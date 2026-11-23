WaterlilyShopItemGroup = {}; 

WaterlilyShopItemGroup.__index = WaterlilyShopItemGroup;

function WaterlilyShopItemGroup.New()
    local self = {};
    setmetatable(self, WaterlilyShopItemGroup);
    return self;
end

function WaterlilyShopItemGroup:Init()
    self.itemList = {};
end

function WaterlilyShopItemGroup:SetData(data)
    data = data.data;
    self:ClearItems();
    local item;
    local list = data.list;
    local len = #list;
    for i = 1, len do
        item = self.itemList[i];
        if (item == nil) then
            item = WaterlilyShopItem.New(data.item, self.transform);
            self.itemList[i] = item;
        end
        item:SetData(list[i]);
    end
end

function WaterlilyShopItemGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList;
        for i = 1, len do
            self.itemList[i]:Clear();
        end
    end
end

function WaterlilyShopItemGroup:Clear()
    self:ClearItems();
end

function WaterlilyShopItemGroup:Destroy()
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