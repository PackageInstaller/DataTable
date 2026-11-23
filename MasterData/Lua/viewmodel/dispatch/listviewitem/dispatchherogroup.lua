







require("ViewModel/Dispatch/ListViewItem/DispatchHeroItem")


DispatchHeroGroup = {}
DispatchHeroGroup.__index = DispatchHeroGroup

function DispatchHeroGroup.New()
    local self = {}
    setmetatable(self, DispatchHeroGroup)
    return self
end

function DispatchHeroGroup:Init()
    self.itemList = {}
end

function DispatchHeroGroup:SetData(data)
    self.data = data.data
    self:ClearItems()
    local list = self.data.list
    local callback = self.data.callback
    local len = #list
    self.dataLen = len
    self.showIndex = 1
    for i = 1, len do
        local item = self.itemList[i]
        if item == nil then
            item = DispatchHeroItem.New(self.data.prefab, self.transform, self.data.scale, callback)
            self.itemList[i] = item
        end
        item:SetData(list[i])
    end

    self.onshowItem = function()
        self:OnShowItem()
    end
    for key, value in pairs(self.itemList) do
        SetActive(value.gameObject, false)
    end
    self.timerID = TimerConst.DispatchEnd * 10 + data.id
    LuaMgr.AddTimer(self.timerID, self.onshowItem, 0.05, -1, false)
end

function DispatchHeroGroup:OnShowItem()
    if (self.showIndex > #self.itemList) then
        LuaMgr.RemoveTimer(self.timerID)
        return
    end
    local item = self.itemList[self.showIndex]
    SetActive(item.gameObject, self.showIndex <= self.dataLen)
    self.showIndex = self.showIndex + 1
end

function DispatchHeroGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Clear()
        end
    end
end

function DispatchHeroGroup:Clear()
    LuaMgr.RemoveTimer(self.timerID)
    self:ClearItems()
end

function DispatchHeroGroup:Destroy()
    LuaMgr.RemoveTimer(self.timerID)
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