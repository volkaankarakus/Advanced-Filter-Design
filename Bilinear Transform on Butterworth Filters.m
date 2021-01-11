clc
clear all
close all
Ap = 0.92; %PassBand Attenuation
As = 0.1; %StopBand Attenuation
PCF = 0.6283; % PassBand Corner Frequency
SCF = 1.2566; % StopBand Corner Frequency
Td = 1; % Sampling Time
fs = 1/Td; % Sampling Frequency
alpha_p = 20*log10(Ap); % Converting into Db
alpha_s = 20*log10(As);
PCF_A = (2/Td)*tan(PCF/2); % Using formula for Bilinear Transformation [(2/Td)*tan(Omega/2)]
SCF_A = (2/Td)*tan(SCF/2);
[n,Wn] = buttord(PCF_A,SCF_A,alpha_p,alpha_s,'s'); % Determine the Order and Cut-off Frequency
[Bn,An] = butter(n,Wn,'s'); % Determine the coefficients
Hsn = tf(Bn,An); % H(s) 
[b,a] = butter(n,Wn,'s');
Hs = tf(b,a); % Normalized
[num,den] = bilinear(b,a,fs);
Hz = tf(num, den, Td); % Filter Function
% Magnitude Response
w = 0 : pi/16 : pi; 
Hw = freqz(num,den,w); 
Hw_mag = abs(Hw);
figure(1)
plot(w/pi,Hw_mag, 'k') 
grid on
title('Magnitude Response', 'fontweight', 'b');
% Impulse Response
figure(2)
impulse(b,a);
grid on
% Zero-Pole Plot
figure(3)
zplane(b,a);
title('Pole-Zero Plot of Filter');
grid on