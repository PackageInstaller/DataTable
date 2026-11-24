require("ViewModel/JiYeChangSheng/ViewItem/JYCSShopItem")
JYCSShopItemGroup = {}
JYCSShopItemGroup.__index = JYCSShopItemGroup

function JYCSShopItemGroup.New()
    local self = {}
    setmetatable(self, JYCSShopItemGroup)
    return self
end

function JYCSShopItemGroup:Init()
    self.itemList = {}
end

function JYCSShopItemGroup:SetData(data)
    data = data.data
    self:ClearItems()
    local item
    local list = data.list
    local len = #list
    for i = 1, len do
        item = self.itemList[i]
        if (item == nil) then
            item = JYCSShopItem.New(data.item, self.transform)
            self.itemList[i] = item
        end
        item:SetData(list[i])
    end
end

function JYCSShopItemGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Clear()
        end
    end
end

function JYCSShopItemGroup:Clear()
    self:ClearItems()
end

function JYCSShopItemGroup:Destroy()
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