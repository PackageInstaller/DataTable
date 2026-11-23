UIListData = {};

UIListData.__index = UIListData;

local pools = {};

UIListData.GetData = function(prefab, class, data)
    local item;
    local len = #pools;
    if (len > 0) then
        item = pools[len];
        pools[len] = nil;
    else
        item = UIListData.New();
    end
    item:SetData(prefab, class, data);
    return item;
end

UIListData.AddData = function(data)
    data:Clear();
    pools[#pools + 1] = data;
end

UIListData.New = function()
    local self = {};
    setmetatable(self, UIListData);
    self.id = 0;
    self.prefab = nil;
    self.class = "";
    self.data = nil;
    return self;
end

function UIListData:SetData(prefab, class, data)
    self.prefab = prefab;
    self.class = class;
    self.data = data;
end

function UIListData:Clear()
    self.prefab = nil;
    self.data = nil;
end