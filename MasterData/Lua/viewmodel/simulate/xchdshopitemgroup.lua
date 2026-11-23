XCHDShopItemGroup = {}; 

XCHDShopItemGroup.__index = XCHDShopItemGroup;

function XCHDShopItemGroup.New()
    local self = {};
    setmetatable(self, XCHDShopItemGroup);
    return self;
end

function XCHDShopItemGroup:Init()
    self.itemList = {};
end

function XCHDShopItemGroup:SetData(data)
    data = data.data;
    self:ClearItems();
    local item;
    local list = data.list;
    local len = #list;
    for i = 1, len do
        item = self.itemList[i];
        if (item == nil) then
            item = XCHDShopItem.New(data.item, self.transform);
            self.itemList[i] = item;
        end
        item:SetData(list[i]);
    end
end

function XCHDShopItemGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList;
        for i = 1, len do
            self.itemList[i]:Clear();
        end
    end
end

function XCHDShopItemGroup:Clear()
    self:ClearItems();
end

function XCHDShopItemGroup:Destroy()
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