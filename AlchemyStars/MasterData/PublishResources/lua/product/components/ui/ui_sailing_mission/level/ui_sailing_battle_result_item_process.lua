_class("UISailingBattleResultItemProcess", UICustomWidget)
UISailingBattleResultItemProcess = UISailingBattleResultItemProcess

function UISailingBattleResultItemProcess:OnShow(uiParams)
  self._name1Label = self:GetUIComponent("UILocalizationText", "Name1")
  self._name2Label = self:GetUIComponent("UILocalizationText", "Name2")
  self._complete = self:GetGameObject("Complete")
  self._uncomplete = self:GetGameObject("UnComplete")
end

function UISailingBattleResultItemProcess:Refresh(name, complete)
  self._name1Label:SetText(name)
  self._name2Label:SetText(name)
  self._complete:SetActive(complete)
  self._uncomplete:SetActive(not complete)
end
