







require("ViewModel/KingDeer/KingDeerShopItem")



KingDeerShopGroup = {}
KingDeerShopGroup.__index = KingDeerShopGroup

function KingDeerShopGroup.New()
    local self = {}
    setmetatable(self, KingDeerShopGroup)
    return self
end

function KingDeerShopGroup:Init()
    self.itemList = {}
end

function KingDeerShopGroup:SetData(data)
    self.data = data.data
    self:ClearItems()
    local list = self.data.list
    local len = #list
    self.showIndex = 1
    self.dataLen = len
    for i = 1, len do
        local item = self.itemList[i]
        if (item == nil) then
            item = KingDeerShopItem.New(self.data.item, self.transform)
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
    self.timerID = TimerConst.KingDeerShopGroupDelay * 10 + data.id
    LuaMgr.AddTimer(self.timerID, self.onshowItem, 0.05, -1, false)
end

function KingDeerShopGroup:OnShowItem()
    if (self.showIndex > #self.itemList) then
        LuaMgr.RemoveTimer(self.timerID)
        return
    end
    local item = self.itemList[self.showIndex]
    SetActive(item.gameObject, self.showIndex <= self.dataLen)
    self.showIndex = self.showIndex + 1
end

function KingDeerShopGroup:ClearItems()
    if (self.itemList ~= nil) then
        local len = #self.itemList
        for i = 1, len do
            self.itemList[i]:Clear()
        end
    end
end

function KingDeerShopGroup:Clear()
    self:ClearItems()
    LuaMgr.RemoveTimer(self.timerID)
end

function KingDeerShopGroup:Destroy()
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