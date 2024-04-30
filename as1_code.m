hp = im2double(rgb2gray(imread('white_room.jpg')));
lp = im2double(rgb2gray(imread('road.jpg')));

hp_size = imresize(hp, [500 500]);
lp_size = imresize(lp, [500 500]);

hpfreq = fft2(hp_size);
hpfreqfinal = fftshift(abs(hpfreq));
hpfreqfinal = hpfreqfinal / 50;
hpfreqfinal = hpfreqfinal / 2;

lpfreq = fft2(lp_size);
lpfreqfinal = fftshift(abs(lpfreq));
lpfreqfinal = lpfreqfinal / 50;
lpfreqfinal = lpfreqfinal / 2;

imwrite(hp_size, 'HP.png');
imwrite(lp_size, 'LP.png');
imwrite(hpfreqfinal, 'HP-freq.png');
imwrite(lpfreqfinal, 'LP-freq.png');

gaus = fspecial('gaussian', 15, 2.5);
sobel = [-1 0 1; -2 0 2; -1 0 1];
dog = conv2(gaus, sobel);

hp_filt = imfilter(hp_size, gaus);
lp_filt = imfilter(lp_size, gaus);

lpfiltfreq = fftshift(abs(fft2(lp_filt)));
lpfiltfreq = lpfiltfreq / 50;

hpfiltfreq = fftshift(abs(fft2(hp_filt)));
hpfiltfreq = hpfiltfreq / 50;

hpfiltfreq = hpfiltfreq * 2;

imwrite(hp_filt, 'HP-filt.png')
imwrite(lp_filt, 'LP-filt.png')
imwrite(lpfiltfreq, 'LP-filt-freq.png')
imwrite(hpfiltfreq, 'HP-filt-freq.png')


dogfiltfreq = fft2(dog,500,500);
lpdogfilt = lpfreq .* dogfiltfreq;
lpdogfiltfinal = fftshift(abs(lpdogfilt));
lpdogspa = ifft2(lpdogfilt);
hpdogfilt = hpfreq .* dogfiltfreq;
hpdogfiltfinal = fftshift(abs(hpdogfilt));
hpdogspa = ifft2(hpdogfilt);

imwrite(hpdogspa, 'HP-dogfilt.png')
imwrite(lpdogspa, 'LP-dogfilt.png')

hpdogfiltfinal = hpdogfiltfinal / 5;
lpdogfiltfinal = lpdogfiltfinal / 5;
lpdogfiltfinal = lpdogfiltfinal / 8;
hpdogfiltfinal = hpdogfiltfinal / 8;

imwrite(hpdogfiltfinal, 'HP-dogfilt-freq.png')
imwrite(lpdogfiltfinal, 'LP-dogfilt-freq.png')
hpsub2 = hp_size(1:2:end, 1:2:end);

lpsub2 = lp_size(1:2:end, 1:2:end);

lpsub2freq = fftshift(abs(fft2(lpsub2)));
lpsub2freq = lpsub2freq / 50;

hpsub2freq = fftshift(abs(fft2(hpsub2)));
hpsub2freq = hpsub2freq / 50;

lpsub2freq = lpsub2freq / 2;
lpsub2freq = lpsub2freq / 2;
hpsub2freq = hpsub2freq / 2;
hpsub2freq = hpsub2freq / 2;


imwrite(lpsub2, 'LP-sub2.png')
imwrite(hpsub2, 'HP-sub2.png')
imwrite(hpsub2freq, 'HP-sub2-freq.png')
imwrite(lpsub2freq, 'LP-sub2-freq.png')
hpsub4 = hp_size(1:4:end, 1:4:end);
lpsub4 = lp_size(1:4:end, 1:4:end);
hpsub4freq = fftshift(abs(fft2(hpsub4)));
lpsub4freq = fftshift(abs(fft2(lpsub4)));

lpsub4freq = lpsub4freq / 200;
hpsub4freq = hpsub4freq / 200;

imwrite(lpsub4, 'LP-sub4.png')
imwrite(hpsub4, 'HP-sub4.png')

imwrite(hpsub4freq, 'HP-sub4-freq.png')
imwrite(lpsub4freq, 'LP-sub4-freq.png')

gaus2 = fspecial('gaussian', 10, 1.5);
antihpsub2 = imfilter(hp_size, gaus2);
antihpsub2 = antihpsub2(1:2:end, 1:2:end);

gaus4 = fspecial('gaussian', 15, 2.5);
antihpsub4 = imfilter(hp_size, gaus4);
antihpsub4 = antihpsub4(1:4:end, 1:4:end);

antihpsub2freq = fftshift(abs(fft2(antihpsub2)));
antihpsub2freq = antihpsub2freq / 200;

antihpsub4freq = fftshift(abs(fft2(antihpsub4)));
antihpsub4freq = antihpsub4freq / 200;

imwrite(antihpsub2, 'HP-sub2-aa.png')
imwrite(antihpsub2freq, 'HP-sub2-aa-freq.png')
imwrite(antihpsub4, 'HP-sub4-aa.png')
imwrite(antihpsub4freq, 'HP-sub4-aa-freq.png')

hp_optimal = edge(hp_size, 'canny', [0.01 0.15]);
hp_highhigh = edge(hp_size, 'canny', [0.01 0.2]);
hp_highlow = edge(hp_size, 'canny', [0.09 0.15]);
hp_lowlow = edge(hp_size, 'canny', [0.0001 0.15]);
hp_lowhigh = edge(hp_size, 'canny', [0.01 0.1]);

imwrite(hp_optimal, 'HP-canny-optimal.png')
imwrite(hp_lowlow, 'HP-canny-lowlow.png')
imwrite(hp_highlow, 'HP-canny-highlow.png')
imwrite(hp_highhigh, 'HP-canny-highhigh.png')
imwrite(hp_lowhigh, 'HP-canny-lowhigh.png')

lp_lowlow = edge(lp_size, 'canny', [0.01 0.2]);
lp_optimal = edge(lp_size, 'canny', [0.07 0.2]);
lp_highhigh = edge(lp_size, 'canny', [0.07 0.5]);
lp_highlow = edge(lp_size, 'canny', [0.15 0.2]);
lp_lowhigh = edge(lp_size, 'canny', [0.07 0.1]);

imwrite(lp_optimal, 'LP-canny-optimal.png')
imwrite(lp_lowlow, 'LP-canny-lowlow.png')
imwrite(lp_highlow, 'LP-canny-highlow.png')
imwrite(lp_highhigh, 'LP-canny-highhigh.png')
imwrite(lp_lowhigh, 'LP-canny-lowhigh.png')