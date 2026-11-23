UIScrollData = {};

UIScrollData.__index = UIScrollData;

local pools = {};

UIScrollData.GetData = function(prefab, class, width, height, data)
    local item;
    local len = #pools;
    if (len > 0) then
        item = pools[len];
        pools[len] = nil;
    else
        item = UIScrollData.New();
    end
    item:SetData(prefab, class, width, height, data);
    return item;
end

UIScrollData.AddData = function(data)
    data:Clear();
    pools[#pools + 1] = data;
end

UIScrollData.New = function()
    local self = {};
    setmetatable(self, UIScrollData);
    self.id = 0;
    self.prefab = nil;
    self.class = "";
    self.width = 0;
    self.height = 0;
    self.data = nil;
    self.position = 0;
    return self;
end

function UIScrollData:SetData(prefab, class, width, height, data)
    self.prefab = prefab;
    self.class = class;
    self.width = width;
    self.height = height;
    self.data = data;
end

function UIScrollData:Clear()
    self.prefab = nil;
    self.data = nil;
end