require("ViewModel/SongShiYouXin/ViewItem/SSYXShopItem")
SSYXShopItemGroup = {}
SSYXShopItemGroup.__index = SSYXShopItemGroup

function SSYXShopItemGroup.New()
    local self = {}
    setmetatable(self, SSYXShopItemGroup)
    return self
end

function SSYXShopItemGroup:Init()
    self.itemList = {}
end

function SSYXShopItemGroup:SetData(data)
    data = data.data
    self:ClearItems()
    local item
    local list = data.list
    local len = #list
    for i = 1, len do
        item = self.itemList[i]
        if (item == nil) then
            item = SSYXShopItem.New(data.item, self.transform)
            self.itemList[i] = item
        end
        item:SetData(list[i])
    end
end

function SSYXShopItemGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Clear()
        end
    end
end

function SSYXShopItemGroup:Clear()
    self:ClearItems()
end

function SSYXShopItemGroup:Destroy()
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