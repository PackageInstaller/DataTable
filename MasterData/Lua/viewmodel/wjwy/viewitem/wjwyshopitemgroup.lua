require("ViewModel/WJWY/ViewItem/WJWYShopItem")
WJWYShopItemGroup = {}
WJWYShopItemGroup.__index = WJWYShopItemGroup

function WJWYShopItemGroup.New()
    local self = {}
    setmetatable(self, WJWYShopItemGroup)
    return self
end

function WJWYShopItemGroup:Init()
    self.itemList = {}
end

function WJWYShopItemGroup:SetData(data)
    data = data.data
    self:ClearItems()
    local item
    local list = data.list
    local len = #list
    for i = 1, len do
        item = self.itemList[i]
        if (item == nil) then
            item = WJWYShopItem.New(data.item, self.transform)
            self.itemList[i] = item
        end
        item:SetData(list[i])
    end
end

function WJWYShopItemGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Clear()
        end
    end
end

function WJWYShopItemGroup:Clear()
    self:ClearItems()
end

function WJWYShopItemGroup:Destroy()
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