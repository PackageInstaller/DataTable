HexUtils = {}

local this = {
    gridSize = 0,
    gridWidth = 0,
    gridHeight = 0,
    gridOdd = 0,
    gridEven = 0,
    gridRadius = 0,
    bit16 = 65536,
};


HexUtils.even1 = { 0, 0, 0, -1, 1, -1, 1, 0, 0, 1, -1, 0, -1, -1 };
HexUtils.even2 = { 0, 0, 0, -1, 1, -1, 1, 0, 0, 1, -1, 0, -1, -1, 0, -2, 1, -2, 2, -1, 2, 0, 2, 1, 1, 1, 0, 2, -1, 1, -2, 1, -2, 0, -2, -1, -1, -2 };
HexUtils.even3 = { 0, 0, 0, -1, 1, -1, 1, 0, 0, 1, -1, 0, -1, -1, 0, -2, 1, -2, 2, -1, 2, 0, 2, 1, 1, 1, 0, 2, -1, 1, -2, 1, -2, 0, -2, -1, -1, -2, 0, -3, 1, -3, 2, -2, 3, -2, 3, -1, 3, 0, 3, 1, 2, 2, 1, 2, 0, 3, -1, 2, -2, 2, -3, 1, -3, 0, -3, -1, -3, -2, -2, -2, -1, -3, 2, -3, 3, -3, 3, 2, 2, 3, -2, 3, -3, 2, -3, -3, -2, -3};

HexUtils.radix1 = { 0, 0, 0, -1, 1, 0, 1, 1, 0, 1, -1, 1, -1, 0 };
HexUtils.radix2 = { 0, 0, 0, -1, 1, 0, 1, 1, 0, 1, -1, 1, -1, 0, 0, -2, 1, -1, 2, -1, 2, 0, 2, 1, 1, 2, 0, 2, -1, 2, -2, 1, -2, 0, -2, -1, -1, -1 };
HexUtils.radix3 = { 0, 0, 0, -1, 1, 0, 1, 1, 0, 1, -1, 1, -1, 0, 0, -2, 1, -1, 2, -1, 2, 0, 2, 1, 1, 2, 0, 2, -1, 2, -2, 1, -2, 0, -2, -1, -1, -1, 0, -3, 1, -2, 2, -2, 3, -1, 3, 0, 3, 1, 3, 2, 2, 2, 1, 3, 0, 3, -1, 3, -2, 2, -3, 2, -3, 1, -3, 0, -3, -1, -2, -2, -1, -2, 2, -3, 3, -2, 3, 3, 2, 3, -2, 3, -3, 3, -3, -2, -2, -3 };


HexUtils.SetSize = function(size)
    this.gridSize = size;
    this.gridWidth = this.gridSize * 1.5;
    this.gridHeight = this.gridSize * math.sqrt(3) * 0.37;
    this.gridOdd = (this.gridWidth * this.gridWidth - this.gridHeight * this.gridHeight) * 0.5;
    this.gridEven = (this.gridWidth * this.gridWidth + this.gridHeight * this.gridHeight) * 0.5;
    this.gridRadius = this.gridHeight * 0.8;
end


HexUtils.GridToWorld = function(x, y)
    local px = x * this.gridWidth;
    local py = y * this.gridHeight * 2 + this.gridHeight * (x & 1);
    py = -py;
    return px, py;
end


HexUtils.WorldToGrid = function(x, y)
    y = -y;
    local gx = math.floor(x / this.gridWidth);
    local tx = x - gx * this.gridWidth;
    local gy = math.floor(y / this.gridHeight);
    local ty = y - gy * this.gridHeight;
    if (((gx + gy) & 1) == 1) then
        if (tx * this.gridWidth - ty * this.gridHeight > this.gridOdd) then
            gx = gx + 1;
        end
    else
        if (tx * this.gridWidth + ty * this.gridHeight > this.gridEven) then
            gx = gx + 1;
        end
    end
    gy = math.floor((gy + (1 - (gx & 1))) / 2);
    return gx, gy;
end


HexUtils.P2V = function(x, y)
    return x * this.bit16 + y;
end


HexUtils.V2P = function(v)
    local x = math.floor(v / this.bit16);
    local y = v % this.bit16;
    return x, y;
end