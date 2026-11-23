require("ViewModel/ZhiXiangLiu/ViewItem/ZXLShopItem")
ZXLShopItemGroup = {}
ZXLShopItemGroup.__index = ZXLShopItemGroup

function ZXLShopItemGroup.New()
    local self = {}
    setmetatable(self, ZXLShopItemGroup)
    return self
end

function ZXLShopItemGroup:Init()
    self.itemList = {}
end

function ZXLShopItemGroup:SetData(data)
    data = data.data
    self:ClearItems()
    local item
    local list = data.list
    local len = #list
    for i = 1, len do
        item = self.itemList[i]
        if (item == nil) then
            item = ZXLShopItem.New(data.item, self.transform)
            self.itemList[i] = item
        end
        item:SetData(list[i])
    end
end

function ZXLShopItemGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Clear()
        end
    end
end

function ZXLShopItemGroup:Clear()
    self:ClearItems()
end

function ZXLShopItemGroup:Destroy()
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