RogueShopItemGroup1 = {}; 

RogueShopItemGroup1.__index = RogueShopItemGroup1;

function RogueShopItemGroup1.New()
    local self = {};
    setmetatable(self, RogueShopItemGroup1);
    return self;
end

function RogueShopItemGroup1:Init()
    self.itemList = {};
end

function RogueShopItemGroup1:SetData(data)
    data = data.data;
    self:ClearItems();
    local item;
    local list = data.list;
    local len = #list;
    for i = 1, len do
        item = self.itemList[i];
        if (item == nil) then
            item = RogueShopItem.New(data.item, self.transform);
            self.itemList[i] = item;
        end
        item:SetData(list[i]);
    end
end

function RogueShopItemGroup1:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList;
        for i = 1, len do
            self.itemList[i]:Clear();
        end
    end
end

function RogueShopItemGroup1:Clear()
    self:ClearItems();
end

function RogueShopItemGroup1:Destroy()
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