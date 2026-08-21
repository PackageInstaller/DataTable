_class("UI_CN6_N35_GameQuestItem", UICustomWidget)
UI_CN6_N35_GameQuestItem = UI_CN6_N35_GameQuestItem

function UI_CN6_N35_GameQuestItem:OnShow()
  self._finishGo = self:GetGameObject("finish")
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
end

function UI_CN6_N35_GameQuestItem:SetData(desc, finish)
  self._desc:SetText(desc)
  self._finishGo:SetActive(finish)
end
