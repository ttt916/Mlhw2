close all;
clear all;
clc;

accur=0;
traning=zeros(192,168,1330);
testing=zeros(192,168,1000);
person=zeros(38);
label=zeros(1,1330);
    
a=fopen('te.txt');
C = textscan(a, '%s %s');
path0 = 'CroppedYale\';
flag=1;
ssss=1;
for j =1:length(C{1})
    path = strcat(path0,C{1,1}{j},'\');
    addpath(path);
    image_name = dir([path '*.pgm']);
    
    if ssss==14
        ssss=ssss+1;
    end
    for i=1:35
        traning(:,:,flag) = imread(image_name(i).name); 
        label(1,flag)=ssss;
        flag=flag+1;        
    end
    ssss=ssss+1;
 end

% reshape¦¨192*168*1*1330
traningdata=reshape(traning,192,168,1,1330);
traningdata=permute(traningdata,[2 1 3 4]);



flag=1;
labels=zeros(1,1084);
ssss=1;
for j =1:length(C{1})
    path = strcat(path0,C{1,1}{j},'\');
    addpath(path);
    image_name = dir([path '*.pgm']);
     [x,y]=size(image_name);
     if ssss==14
        ssss=ssss+1;
    end
    for i=36:x-1
        testing(:,:,flag) = imread(image_name(i).name); 
        labels(1,flag)=ssss;
        flag=flag+1;        
    end
    ssss=ssss+1;
 end
testingdata=reshape(testing,192,168,1,1084);
testingdata=permute(testingdata,[2 1 3 4]);
fclose('all');


h5create('train.h5','/data',size(traningdata),'Datatype','double');
h5create('train.h5','/label',size(label),'Datatype','double');
h5write('train.h5','/data',traningdata);
h5write('train.h5','/label',label);

h5create('test.h5','/data',size(testingdata),'Datatype','double');
h5create('test.h5','/label',size(labels),'Datatype','double');
h5write('test.h5','/data',testingdata);
h5write('test.h5','/label',labels);




