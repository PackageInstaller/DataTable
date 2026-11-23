





















DispatchZoneItem = {}
DispatchZoneItem.__index = DispatchZoneItem

local objs = {
    button = {path = "Group/Icon", type = UITool.Button},
    lockObj = {path = "Group/LockObj", type = UITool.GameObject},
    statusDispatching = {path = "Group/StatusDispatching", type = UITool.GameObject},
    statusDispatchEnd = {path = "Group/StatusDispatchEnd", type = UITool.GameObject},
    selectObj = {path = "Group/SelectImage", type = UITool.GameObject},
    titleText = {path = "Group/TitleBG/TitleText", type = UITool.Text},
    addressArrowObj = {path = "Group/TitleBG/AddressArrowObj", type = UITool.Text},
    unlockCondText = {path = "Group/LockObj/UnlockCondText", type = UITool.Text},
    dispatchingText = {path = "Group/StatusDispatching/DispatchingText", type = UITool.Text},
    redIconListener = {path = "Group", type = UITool.RedIconListener}
}

DispatchZoneItem.New = function(obj, index, callback)

    local self = {}
    setmetatable(self, DispatchZoneItem)
    self.gameObject = obj
    self.index = index
    self.callback = callback
    UITool.Parse(self.gameObject, self, objs)
    local clickBtn = function()
        if self.callback ~= nil then
            self.callback(self)
        end
    end
    LuaMgr.AddClick(self.button, clickBtn)
    return self
end

function DispatchZoneItem:SetData(data)
    if data ~= nil then
        self.data = data
    end
    self.redIconListener.RedId = "16821_" .. self.data.id
    local num = 0
    if data.status == DispatchData.StrongholdStatus.DispatchEnd then
        num = 1
    end
    RedMgr.Singleton:UpdateClientRedData(self.redIconListener.RedId, num)
    self:SetItem()
end

function DispatchZoneItem:SetItem()
    local data = self.data
    SetActive(self.statusDispatching, false)
    SetActive(self.statusDispatchEnd, false)
    self:SetDispatchingText(false)
    if data.status == DispatchData.StrongholdStatus.Dispatching then
        SetActive(self.statusDispatching, true)
        self:SetDispatchingText(true)
    elseif data.status == DispatchData.StrongholdStatus.DispatchEnd then
        SetActive(self.statusDispatchEnd, true)
    end

    self.titleText.text = LuaMgr.GetLangText(data.config.NameLan)
    if data.isUnlock == true then
        SetActive(self.lockObj, false)
        SetActive(self.addressArrowObj, true)
    else
        SetActive(self.lockObj, true)
        self.unlockCondText.text = data.unlockText
        SetActive(self.addressArrowObj, false)
    end
end

function DispatchZoneItem:SetDispatchingText(isShow)
    if self.Tweener ~= nil then
        self.Tweener:Kill()
    end
    if isShow == true then
        self.Tweener = self.dispatchingText:DOText("...", 1):SetLoops(-1)
    end
end

function DispatchZoneItem:SetSelected(selected)
    SetActive(self.selectObj, selected)
end

function DispatchZoneItem:Clear()
    if self.Tweener ~= nil then
        self.Tweener:Kill()
        self.Tweener = nil
    end
end