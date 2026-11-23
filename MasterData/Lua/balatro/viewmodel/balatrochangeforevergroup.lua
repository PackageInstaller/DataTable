







require("Balatro/ViewModel/BalatroChangeForeverItem")
BalatroChangeForeverGroup = {}
BalatroChangeForeverGroup.__index = BalatroChangeForeverGroup

function BalatroChangeForeverGroup.New()
    local self = {}
    setmetatable(self, BalatroChangeForeverGroup)
    return self
end

function BalatroChangeForeverGroup:Init()
    self.itemList = {}
end

function BalatroChangeForeverGroup:SetData(data)
    self:Clear()
    self.data = data.data
    local list = self.data.list
    local len = #list
    local parentScroll = self.data.parentScroll
    local longTapCallback = self.data.longTapCallback
    for i = 1, len do
        local item = self.itemList[i]
        if item == nil then
            item = BalatroChangeForeverItem.New(self.data.item, self.transform, (self.data.index - 1) * 5 + i, parentScroll, longTapCallback)
            self.itemList[i] = item
        end
        if item ~= nil then
            item:SetData(list[i])
        end
    end
end

function BalatroChangeForeverGroup:Clear()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Clear()
        end
    end
end

function BalatroChangeForeverGroup:Destroy()
    if self.itemList ~= nil then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Destroy()
        end
        self.itemList = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end