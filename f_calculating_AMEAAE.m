% ============================================================
% File: f_calculating_AMEAAE.m
% Author: XuXiaoping
% Email: 22320220156432@stu.xmu.edu.cn
% Date: 2024-12-09
%   This script computes the Average Magnitude Error (AME) and 
%   Average Angle Error (AAE) between simulated (model) and 
%   measured (observational) velocity fields.
%
% Usage:
%   1. Load simulated and measured velocity data using other loadData function.
%   2. Calculate the AME and AAE using this processData function.
%
% Dependencies:
%   - MATLAB (no external toolboxes required)
%
% Inputs (One-dimensional matrix):
%   - Simulated velocity components (u and v) for model data. 
%   - Measured velocity components (u and v) for observational data
%
% Outputs:
%   - AME (Average Magnitude Error): Average magnitude error of the velocities fields.
%   - AAE (Average Angle Error): Average angular error between simulated and measured velocity vectors.
% ============================================================

function [AME,AAE] = f_calculating_AMEAAE(Simulated_v,Simulated_u,Measured_v,Measured_u)
if size(Simulated_v) ~= size(Measured_v) || size(Simulated_u) ~= size(Measured_u)
    error('Simulated and measured data must have the same dimensions.');
end
sizen = size(Simulated_v,1);
Simulated_v = reshape(Simulated_v,[sizen,1]);
Simulated_u = reshape(Simulated_u,[sizen,1]);
Measured_v = reshape(Measured_v,[sizen,1]);
Measured_u = reshape(Measured_u,[sizen,1]);
for i = 1:sizen
    % Calculate AME for each velocity component (u and v)
    ameup = sqrt((Simulated_v(i)-Measured_v(i))^2+(Simulated_u(i)-Measured_u(i))^2);
    amedown = sqrt(Measured_v(i)^2+(Measured_u(i))^2);
    ame(i,1) = ameup/amedown;
    % Calculate AAE for each velocity vector (angle difference)
    aaeup = (Simulated_v(i)*Measured_v(i))+(Simulated_u(i)*Measured_u(i));
    aaedown = (sqrt((Simulated_v(i))^2+(Simulated_u(i))^2))*(sqrt((Measured_v(i))^2+(Measured_u(i))^2));
    aae(i,1) = acosd(aaeup/aaedown);
end
% Calculate the average AME and AAE
AME = sum(ame)/sizen;
AAE = sum(aae)/sizen;
end