-- baoruichang
local UIDanceAchieveItemCtrl = BaseClass("UIDanceAchieveItemCtrl", UIBaseComponent)
local M = UIDanceAchieveItemCtrl
local EActivityState = EnumConst.EActivityState

function M:__init(view)
    self._view = view
    self:Init()
end

function M:Init()
    self._rewardCtrl1 = nil
    self._rewardCtrl2 = nil
    self._view.rewardBtn:onClick(Bind(self, self._OnClickItem))
end

function M:UpdateItem(data)
    if data == nil then
        return
    end

    self._data = data
    local cfg = data:Config()
    local state = data:State()
    local reward = cfg.reward
    local progress = string.format("%d/%d", data:CurProgress()[1], data:MaxProgress()[1])

    self._view.icon:SetPic(cfg.icon)
    self._view.name:SetText(cfg.name)
    self._view.desc:SetText(cfg.des)
    self._view.num:SetText(progress)

    self:_SetReward(cfg)
    self:_SetState(state)
    self._view.tfRedPoint:SetActive(state == EActivityState.Finished)
end

function M:_SetReward(data)

    if #data.reward > 0 then
        local tempData = {id=data.reward[1], num=data.reward[2]}
        self._view.UIDanceItemCtrl1:UpdateData(tempData)
    end
    self._view.UIDanceItemCtrl1:SetActive(#data.reward > 0)
    if data.integral > 0 then
        local tempData = {id=75, num=data.integral}
        self._view.UIDanceItemCtrl2:UpdateData(tempData)
    end
    self._view.UIDanceItemCtrl2:SetActive(data.integral > 0)
end

function M:_SetState(state)
    for i = 0, 2 do
        local name = string.format("state%d", i)
        local isShow = state == i
        self._view[name]:SetActive(isShow)
    end

    if state == 2 then
        local time = self._data:FinishTime()
        local date = GameHelper.GetDateTime(time)
        local str = date.Year .. "/" .. date.Month .. "/" .. date.Day
        self._view.day:SetText(str)
    end
end

function M:_OnClickItem()
    self._callback(self._data:Id())
end

function M:ClickCallback(callback)
    self._callback = callback
end

return UIDanceAchieveItemCtrl
