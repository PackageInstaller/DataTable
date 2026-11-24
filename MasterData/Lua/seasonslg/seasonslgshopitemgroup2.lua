require("SeasonSLG/SeasonSLGShopItem")
SeasonSLGShopItemGroup2 = {}
SeasonSLGShopItemGroup2.__index = SeasonSLGShopItemGroup2

function SeasonSLGShopItemGroup2.New()
    local self = {}
    setmetatable(self, SeasonSLGShopItemGroup2)
    return self
end

function SeasonSLGShopItemGroup2:Init()
    self.itemList = {}
end

function SeasonSLGShopItemGroup2:SetData(data)
    data = data.data
    self:ClearItems()
    local item
    local list = data.list
    local len = #list
    for i = 1, len do
        item = self.itemList[i]
        if (item == nil) then
            item = SeasonSLGShopItem.New(data.item, self.transform)
            self.itemList[i] = item
        end
        item:SetData(list[i])
    end
end

function SeasonSLGShopItemGroup2:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Clear()
        end
    end
end

function SeasonSLGShopItemGroup2:Clear()
    self:ClearItems()
end

function SeasonSLGShopItemGroup2:Destroy()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Destroy()
        end
        self.itemList = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end