_class("UIBattlePassCN1ItemIconReward", UICustomWidget)
UIBattlePassCN1ItemIconReward = UIBattlePassCN1ItemIconReward

function UIBattlePassCN1ItemIconReward:OnShow(uiParams)
  local iconRect = self:GetUIComponent("RectTransform", "_icon")
  self._defaultSizeDelta = Vector2(iconRect.sizeDelta.x, iconRect.sizeDelta.y)
end

function UIBattlePassCN1ItemIconReward:SetData(index, adv, campaign, component, clickCallback, tipsCallback)
  self._index = index
  self._adv = adv
  self._campaign = campaign
  self._component = component
  self._componentInfo = component:ComponentInfo()
  self._clickCallback = clickCallback
  self._tipsCallback = tipsCallback
  UIBattlePassStyleHelper.FitStyle_Widget(self._campaign, self)
  self._state = self:_CheckState(adv)
  self:_SetState(self._state)
  self:_SetBg(adv)
  local rewards = {}
  if not adv then
    rewards = self._component:GetNormalRewards()
  else
    rewards = self._component:GetAdvancedRewards()
  end
  self._roleAsset = rewards[self._index]
  local goldReward = self._component:IsPreviewLvFromConfig(self._index)
  self:_SetIcon(goldReward, self._roleAsset)
end

function UIBattlePassCN1ItemIconReward:PlayAnimTaken(callback)
  self:_SetState(UIBattlePassCN1ItemIconRewardState.EState_Received)
  local animName, duration = "UIeff_UIBattlePassCN1_ItemIcon_Reward_Taken", 367
  UIWidgetHelper.PlayAnimation(self, "_anim", animName, duration, callback)
end

local UIBattlePassCN1ItemIconRewardState = {
  EState_Lock = 1,
  EState_Claim = 2,
  EState_Received = 3
}
_enum("UIBattlePassCN1ItemIconRewardState", UIBattlePassCN1ItemIconRewardState)

function UIBattlePassCN1ItemIconReward:_CheckState(adv)
  if adv and not self._componentInfo.m_unlock_advanced_reward then
    return UIBattlePassCN1ItemIconRewardState.EState_Lock
  end
  if self._index > self._componentInfo.m_current_level then
    return UIBattlePassCN1ItemIconRewardState.EState_Lock
  end
  local received = adv and self._componentInfo.m_received_advanced_lv or self._componentInfo.m_received_normal_lv
  for _, v in ipairs(received) do
    if v == self._index then
      return UIBattlePassCN1ItemIconRewardState.EState_Received
    end
  end
  return UIBattlePassCN1ItemIconRewardState.EState_Claim
end

function UIBattlePassCN1ItemIconReward:_SetState(state)
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"state_Lock"},
    {
      "state_Completed"
    },
    {
      "state_Taken"
    }
  })
  UIWidgetHelper.SetObjGroupShow(objs, state)
end

function UIBattlePassCN1ItemIconReward:_SetBg(adv)
  local idx = adv and 2 or 1
  local tb_iconBg = UIBattlePassStyleHelper.GetStyleInfo_KeyWidgetName(self._campaign, self, "_iconBg")
  local tb_txtBg = UIBattlePassStyleHelper.GetStyleInfo_KeyWidgetName(self._campaign, self, "_txtBg")
  local tb_txt = UIBattlePassStyleHelper.GetStyleInfo_KeyWidgetName(self._campaign, self, "_txt")
  local convert = {"_standard", "_elite"}
  UIStyleHelper.FitStyle_Widget(tb_iconBg[convert[idx]], self, "_iconBg")
  UIStyleHelper.FitStyle_Widget(tb_txtBg[convert[idx]], self, "_txtBg")
  UIStyleHelper.FitStyle_Widget(tb_txt[convert[idx]], self, "_txt")
end

function UIBattlePassCN1ItemIconReward:_SetIcon(goldReward, roleAsset)
  local itemId, itemText = roleAsset.assetid, roleAsset.count
  UIWidgetHelper.SetItemIcon(self, itemId, "_icon")
  UIWidgetHelper.SetItemIcon_AdjHead(self, itemId, "_icon", self._defaultSizeDelta)
  local atlasName = "UICommon.spriteatlas"
  local spriteName = "spirit_shengji_se"
  UIWidgetHelper.SetItemIconColor(self, itemId, "_quality", atlasName, spriteName)
  UIWidgetHelper.SetLocalizationText(self, "_txt", itemText)
end

function UIBattlePassCN1ItemIconReward:BtnOnClick(go)
  if self._state == UIBattlePassCN1ItemIconRewardState.EState_Claim then
    if self._clickCallback then
      self._clickCallback(self._index, self._adv)
    end
  elseif self._tipsCallback then
    self._tipsCallback(self._roleAsset.assetid, go.transform.position)
  end
end
