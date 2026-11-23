require("ViewModel/ZhiXiangLiu/ViewItem/ZXLChooseItem")
ZXLChooseItemGroup = {}
ZXLChooseItemGroup.__index = ZXLChooseItemGroup

function ZXLChooseItemGroup.New()
    local self = {}
    setmetatable(self, ZXLChooseItemGroup)
    return self
end

function ZXLChooseItemGroup:Init()
    self.itemList = {}
end

function ZXLChooseItemGroup:SetData(data)
    data = data.data
    self:ClearItems()
    local item
    local list = data.list
    local len = #list
    for i = 1, len do
        item = self.itemList[i]
        if (item == nil) then
            item = ZXLChooseItem.New(data.item, self.transform)
            self.itemList[i] = item
        end
        item:SetData(list[i])
    end
end

function ZXLChooseItemGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Clear()
        end
    end
end

function ZXLChooseItemGroup:Clear()
    self:ClearItems()
end

function ZXLChooseItemGroup:Destroy()
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