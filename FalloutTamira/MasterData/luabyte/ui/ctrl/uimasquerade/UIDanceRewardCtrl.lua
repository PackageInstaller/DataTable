--baoruichang
local UIDanceRewardCtrl = BaseClass("UIDanceRewardCtrl")
local M = UIDanceRewardCtrl
local EActivityState = EnumConst.EActivityState

function M:__init(view)
    self._view = view
    self:Init()
end

function M:Init()
    self._view.btnReward:onClick(Bind(self, self._OnClickReward))
end

function M:UpdateData(data)
    self.data = data
    self._view.UIDanceItemCtrl:UpdateData(data.itemData)
    self._view.UIDanceItemCtrl:EnablePopItem(false)

    self._view.state:SetState(data.state1)
    self._view.stateReward:SetState(data.state + 1)
    self._view.labNum:SetText(tostring(data.num))
end

function M:SetOnClickCallBack(cilckCallBack)
    self._cilckCallBack = cilckCallBack
end

function M:_OnClickReward()
    if self.data.state ~= EActivityState.Finished then
        return
    end
    if self._cilckCallBack then
        self._cilckCallBack()
    end
end

function M:OnDispose()
    self.data = nil
    self._cilckCallBack = nil
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end

end

return UIDanceRewardCtrl
