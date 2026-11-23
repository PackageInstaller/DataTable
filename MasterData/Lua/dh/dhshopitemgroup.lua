DHShopItemGroup = {};

DHShopItemGroup.__index = DHShopItemGroup;

function DHShopItemGroup.New()
    local self = {};
    setmetatable(self, DHShopItemGroup);
    return self;
end

function DHShopItemGroup:Init()
    self.itemList = {};
end

function DHShopItemGroup:SetData(data)
    data = data.data;
    self:ClearItems();
    local item;
    local list = data.list;
    local len = #list;
    for i = 1, len do
        item = self.itemList[i];
        if (item == nil) then
            item = DHShopItem.New(data.item, self.transform);
            self.itemList[i] = item;
        end
        item:SetData(list[i]);
    end
end

function DHShopItemGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList;
        for i = 1, len do
            self.itemList[i]:Clear();
        end
    end
end

function DHShopItemGroup:Clear()
    self:ClearItems();
end

function DHShopItemGroup:Destroy()
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