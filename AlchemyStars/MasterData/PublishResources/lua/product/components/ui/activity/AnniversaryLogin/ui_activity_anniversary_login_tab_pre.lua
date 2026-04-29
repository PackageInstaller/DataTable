_class("UIActivityAnniversaryLoginTabPre", UICustomWidget)
UIActivityAnniversaryLoginTabPre = UIActivityAnniversaryLoginTabPre

function UIActivityAnniversaryLoginTabPre:OnShow(uiParams)
  self._isOpen = true
end

function UIActivityAnniversaryLoginTabPre:OnHide()
  self._isOpen = false
end

function UIActivityAnniversaryLoginTabPre:SetData(campaign, component, refreshCallback, closeCallback, tipsCallback, btnCallback)
  self._campaign = campaign
  self._component = component
  self._refreshCallback = refreshCallback
  self._closeCallback = closeCallback
  self._tipsCallback = tipsCallback
  self._btnCallback = btnCallback
end

function UIActivityAnniversaryLoginTabPre:Refresh()
  local state = self._component:GetTimeRewardState(1)
  local index = state == ETimeRewardRewardStatus.E_TIME_REWARD_CAN_RECV and 1 or 2
  self:_SetState(index)
  self:_SetRed()
end

function UIActivityAnniversaryLoginTabPre:_SetState(index)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"_txt_1", "CloseBtn"},
    {"_txt_2", "BackBtn"}
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, index)
end

function UIActivityAnniversaryLoginTabPre:_SetRed()
  local red = UIActivityAnniversaryLoginHelper.CheckComponentRedPoint(self._campaign, ECampaignAnniversaryComponentID.ECAMPAIGN_RESOURCE_BOX)
  UIWidgetHelper.SetNewAndReds(self, 0, red, "", "_red")
end

function UIActivityAnniversaryLoginTabPre:PreviewBtnOnClick(go)
  self._refreshCallback(UIActivityAnniversaryLoginState.TabReward)
end

function UIActivityAnniversaryLoginTabPre:ClaimBtnOnClick(go)
  self._refreshCallback(UIActivityAnniversaryLoginState.TabReward)
end

function UIActivityAnniversaryLoginTabPre:CloseBtnOnClick(go)
  self._closeCallback()
end

function UIActivityAnniversaryLoginTabPre:BackBtnOnClick(go)
  self._refreshCallback(UIActivityAnniversaryLoginState.TabMain)
end
