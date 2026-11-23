ZGCXShopItemGroup = {}; 

ZGCXShopItemGroup.__index = ZGCXShopItemGroup;

function ZGCXShopItemGroup.New()
    local self = {};
    setmetatable(self, ZGCXShopItemGroup);
    return self;
end

function ZGCXShopItemGroup:Init()
    self.itemList = {};
end

function ZGCXShopItemGroup:SetData(data)
    data = data.data;
    self:ClearItems();
    local item;
    local list = data.list;
    local len = #list;
    for i = 1, len do
        item = self.itemList[i];
        if (item == nil) then
            item = ZGCXShopItem.New(data.item, self.transform);
            self.itemList[i] = item;
        end
        item:SetData(list[i]);
    end
end

function ZGCXShopItemGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList;
        for i = 1, len do
            self.itemList[i]:Clear();
        end
    end
end

function ZGCXShopItemGroup:Clear()
    self:ClearItems();
end

function ZGCXShopItemGroup:Destroy()
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