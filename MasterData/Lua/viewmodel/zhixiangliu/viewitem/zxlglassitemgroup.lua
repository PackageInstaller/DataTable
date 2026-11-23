require("ViewModel/ZhiXiangLiu/ViewItem/ZXLGlassItem")
ZXLGlassItemGroup = {}
ZXLGlassItemGroup.__index = ZXLGlassItemGroup

function ZXLGlassItemGroup.New()
    local self = {}
    setmetatable(self, ZXLGlassItemGroup)
    return self
end

function ZXLGlassItemGroup:Init()
    self.itemList = {}
end

function ZXLGlassItemGroup:SetData(data)
    data = data.data
    self:ClearItems()
    local item
    local list = data.list
    local len = #list
    for i = 1, len do
        item = self.itemList[i]
        if (item == nil) then
            item = ZXLGlassItem.New(data.item, self.transform)
            self.itemList[i] = item
        end
        item:SetData(list[i])
    end
end

function ZXLGlassItemGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Clear()
        end
    end
end

function ZXLGlassItemGroup:Clear()
    self:ClearItems()
end

function ZXLGlassItemGroup:Destroy()
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