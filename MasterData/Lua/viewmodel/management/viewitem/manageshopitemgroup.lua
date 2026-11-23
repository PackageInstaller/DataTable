ManageShopItemGroup = {}

ManageShopItemGroup.__index = ManageShopItemGroup

function ManageShopItemGroup.New()
    local self = {}
    setmetatable(self, ManageShopItemGroup)
    return self
end

function ManageShopItemGroup:Init()
    self.itemList = {}
end

function ManageShopItemGroup:SetData(data)
    data = data.data
    self:ClearItems()
    local item
    local list = data.list
    local len = #list
    for i = 1, len do
        item = self.itemList[i]
        if (item == nil) then
            item = ManageShopItem.New(data.item, self.transform)
            self.itemList[i] = item
        end
        item:SetData(list[i])
    end
end

function ManageShopItemGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Clear()
        end
    end
end

function ManageShopItemGroup:Clear()
    self:ClearItems()
end

function ManageShopItemGroup:Destroy()
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