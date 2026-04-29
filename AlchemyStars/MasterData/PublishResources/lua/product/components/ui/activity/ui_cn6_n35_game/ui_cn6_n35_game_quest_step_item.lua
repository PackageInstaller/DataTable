_class("UI_CN6_N35_GameQuestStepItem", UICustomWidget)
UI_CN6_N35_GameQuestStepItem = UI_CN6_N35_GameQuestStepItem

function UI_CN6_N35_GameQuestStepItem:OnShow()
  self._imgRect = self:GetUIComponent("RectTransform", "rect")
  self._img = self:GetUIComponent("Image", "img")
  self._tex = self:GetUIComponent("UILocalizedTMP", "tex")
end

function UI_CN6_N35_GameQuestStepItem:SetData(tex, posx, sp)
  self._imgRect.anchoredPosition = Vector2(posx, 0)
  self._img.sprite = sp
  self._tex:SetText(tex)
end
