_class("UIN22EntrustRewardsController", UIController)
UIN22EntrustRewardsController = UIN22EntrustRewardsController

function UIN22EntrustRewardsController:OnShow(uiParams)
  local title = uiParams[1] or ""
  local rewards = uiParams[2]
  self._confirm = uiParams[3]
  UIWidgetHelper.SetLocalizationText(self, "_mainTitle", title)
  self:_SetRewards(rewards)
  local txtConfirm = StringTable.Get("str_common_confirm")
  UIWidgetHelper.SetLocalizationText(self, "_txtConfirmBtn", txtConfirm)
end

function UIN22EntrustRewardsController:_SetRewards(rewards)
  local count = #rewards
  local objs = UIWidgetHelper.SpawnObjects(self, "_rewardPool", "UIN22EntrustRewardItem", count)
  for i = 1, count do
    objs[i]:SetData(rewards[i], false, function(matid, pos)
      UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
    end)
  end
end

function UIN22EntrustRewardsController:ConfirmBtnOnClick(go)
  self:CloseDialog()
  if self._confirm then
    self._confirm()
  end
end
