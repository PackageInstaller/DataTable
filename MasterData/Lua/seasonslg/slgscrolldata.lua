SLGScrollData = {};

SLGScrollData.__index = SLGScrollData;

local pools = {};

SLGScrollData.GetData = function(prefab, class, width, height,pos, data)
    local item;
    local len = #pools;
    if (len > 0) then
        item = pools[len];
        pools[len] = nil;
    else
        item = SLGScrollData.New();
    end
    item:SetData(prefab, class, width, height, pos,data);
    return item;
end

SLGScrollData.AddData = function(data)
    data:Clear();
    pools[#pools + 1] = data;
end

SLGScrollData.New = function()
    local self = {};
    setmetatable(self, SLGScrollData);
    self.id = 0;
    self.prefab = nil;
    self.class = "";
    self.width = 0;
    self.height = 0;
    self.data = nil;
    self.position = 0;
    return self;
end

function SLGScrollData:SetData(prefab, class, width, height,pos, data)
    self.prefab = prefab;
    self.class = class;
    self.width = width;
    self.height = height;
    self.position=pos;
    self.data = data;
end

function SLGScrollData:Clear()
    self.prefab = nil;
    self.data = nil;
end