_class("UIActivityAnniversaryLoginTabReward", UICustomWidget)
UIActivityAnniversaryLoginTabReward = UIActivityAnniversaryLoginTabReward

function UIActivityAnniversaryLoginTabReward:OnShow(uiParams)
  self._isOpen = true
end

function UIActivityAnniversaryLoginTabReward:OnHide()
  self._isOpen = false
end

function UIActivityAnniversaryLoginTabReward:SetData(campaign, component, refreshCallback, closeCallback, tipsCallback, btnCallback)
  self._campaign = campaign
  self._component = component
  self._refreshCallback = refreshCallback
  self._closeCallback = closeCallback
  self._tipsCallback = tipsCallback
  self._btnCallback = btnCallback
end

function UIActivityAnniversaryLoginTabReward:Refresh()
  local state = self._component:GetTimeRewardState(1)
  local rewards = self._component:GetReviewRewards()
  local objs = UIWidgetHelper.SpawnObjects(self, "_pool", "UIActivityAnniversaryLoginItem", #rewards)
  for i, v in ipairs(objs) do
    v:SetData(rewards[i], state, self._tipsCallback)
  end
  local showBtn = state == ETimeRewardRewardStatus.E_TIME_REWARD_CAN_RECV
  self:GetGameObject("ClaimBtn"):SetActive(showBtn)
end

function UIActivityAnniversaryLoginTabReward:BgBtnOnClick(go)
  self._refreshCallback(UIActivityAnniversaryLoginState.TabPre)
end

function UIActivityAnniversaryLoginTabReward:ClaimBtnOnClick(go)
  local id = self._component:GetTimeRewardId(1)
  self._btnCallback(self._component, id)
end
