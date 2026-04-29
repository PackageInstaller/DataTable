_class("UIN15DrawIntroItem", UICustomWidget)
UIN15DrawIntroItem = UIN15DrawIntroItem

function UIN15DrawIntroItem:OnShow(uiParams)
  self:_GetComponent()
end

function UIN15DrawIntroItem:_GetComponent()
  self._txtHead = self:GetUIComponent("UILocalizationText", "_txtHead")
  self._txtBody = self:GetUIComponent("UILocalizationText", "_txtBody")
end

function UIN15DrawIntroItem:RefView(head, body)
  self._txtHead:SetText(head)
  self._txtBody:SetText(body)
end
