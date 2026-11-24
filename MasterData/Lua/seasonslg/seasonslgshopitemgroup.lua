require("SeasonSLG/SeasonSLGShopItem")
SeasonSLGShopItemGroup = {}
SeasonSLGShopItemGroup.__index = SeasonSLGShopItemGroup

function SeasonSLGShopItemGroup.New()
    local self = {}
    setmetatable(self, SeasonSLGShopItemGroup)
    return self
end

function SeasonSLGShopItemGroup:Init()
    self.itemList = {}
end

function SeasonSLGShopItemGroup:SetData(data)
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

function SeasonSLGShopItemGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Clear()
        end
    end
end

function SeasonSLGShopItemGroup:Clear()
    self:ClearItems()
end

function SeasonSLGShopItemGroup:Destroy()
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