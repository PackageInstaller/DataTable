





require("Balatro/ViewModel/BalatroBag/BrandBagItem")
BrandBagItemGroup = {}
BrandBagItemGroup.__index = BrandBagItemGroup

function BrandBagItemGroup.New()
    local self = {}
    setmetatable(self, BrandBagItemGroup)
    return self
end

function BrandBagItemGroup:Init()
    self.itemList = {}
end

function BrandBagItemGroup:SetData(param)
    self:Clear()
    self.data = param.data
    local list = self.data.list
    local len = #list
    for i = 1, len do
        local item = self.itemList[i]
        if item == nil then
            item = BrandBagItem.New(self.data.item, self.transform)
            self.itemList[i] = item
        end
        if item ~= nil then
            item:SetData(list[i])
        end
    end
end

function BrandBagItemGroup:Clear()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Clear()
        end
    end
end

function BrandBagItemGroup:Destroy()
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