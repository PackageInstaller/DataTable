_class("UIBattlePassCN1RewardCellFixed", UICustomWidget)
UIBattlePassCN1RewardCellFixed = UIBattlePassCN1RewardCellFixed

function UIBattlePassCN1RewardCellFixed:SetData(campaign, component)
  self._campaign = campaign
  self._component = component
  self._info = component:ComponentInfo()
  local isAdvLock = not self._info.m_unlock_advanced_reward
  self:GetGameObject("_advLock"):SetActive(isAdvLock)
  UIBattlePassStyleHelper.FitStyle_Widget(self._campaign, self)
end
