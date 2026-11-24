require("ViewModel/JinZhongQiWu/ViewItem/JZQWShopItem")
JZQWShopItemGroup = {}
JZQWShopItemGroup.__index = JZQWShopItemGroup

function JZQWShopItemGroup.New()
    local self = {}
    setmetatable(self, JZQWShopItemGroup)
    return self
end

function JZQWShopItemGroup:Init()
    self.itemList = {}
end

function JZQWShopItemGroup:SetData(data)
    data = data.data
    self:ClearItems()
    local item
    local list = data.list
    local len = #list
    for i = 1, len do
        item = self.itemList[i]
        if (item == nil) then
            item = JZQWShopItem.New(data.item, self.transform)
            self.itemList[i] = item
        end
        item:SetData(list[i])
    end
end

function JZQWShopItemGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Clear()
        end
    end
end

function JZQWShopItemGroup:Clear()
    self:ClearItems()
end

function JZQWShopItemGroup:Destroy()
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