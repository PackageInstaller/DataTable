GuoBaoShopItemGroup = {};

GuoBaoShopItemGroup.__index = GuoBaoShopItemGroup;

function GuoBaoShopItemGroup.New()
    local self = {};
    setmetatable(self, GuoBaoShopItemGroup);
    return self;
end

function GuoBaoShopItemGroup:Init()
    self.itemList = {};
end

function GuoBaoShopItemGroup:SetData(data)
    data = data.data;
    self:ClearItems();
    local item;
    local list = data.list;
    local len = #list;
    for i = 1, len do
        item = self.itemList[i];
        if (item == nil) then
            item = GuoBaoShopItem.New(data.item, self.transform);
            self.itemList[i] = item;
        end
        item:SetData(list[i]);
    end
end

function GuoBaoShopItemGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList;
        for i = 1, len do
            self.itemList[i]:Clear();
        end
    end
end

function GuoBaoShopItemGroup:Clear()
    self:ClearItems();
end

function GuoBaoShopItemGroup:Destroy()
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