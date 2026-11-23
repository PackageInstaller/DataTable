DHShop2ItemGroup = {};

DHShop2ItemGroup.__index = DHShop2ItemGroup;

function DHShop2ItemGroup.New()
    local self = {};
    setmetatable(self, DHShop2ItemGroup);
    return self;
end

function DHShop2ItemGroup:Init()
    self.itemList = {};
end

function DHShop2ItemGroup:SetData(data)
    data = data.data;
    self:ClearItems();
    local item;
    local list = data.list;
    local len = #list;
    for i = 1, len do
        item = self.itemList[i];
        if (item == nil) then
            item = DHShop2Item.New(data.item, self.transform);
            self.itemList[i] = item;
        end
        item:SetData(list[i]);
    end
end

function DHShop2ItemGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList;
        for i = 1, len do
            self.itemList[i]:Clear();
        end
    end
end

function DHShop2ItemGroup:Clear()
    self:ClearItems();
end

function DHShop2ItemGroup:Destroy()
    if (self.itemList ~= nil) then
        local len = #self.itemList;
        for i = 1, len do
            self.itemList[i]:Destroy();
        end
        self.itemList = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end