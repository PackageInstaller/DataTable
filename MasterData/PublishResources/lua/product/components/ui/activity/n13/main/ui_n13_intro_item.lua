_class("UIN13IntroItem", UICustomWidget)
UIN13IntroItem = UIN13IntroItem

function UIN13IntroItem:OnShow(uiParams)
  self:_GetComponent()
end

function UIN13IntroItem:_GetComponent()
  self._txtHead = self:GetUIComponent("UILocalizationText", "_txtHead")
  self._txtBody = self:GetUIComponent("UILocalizationText", "_txtBody")
end

function UIN13IntroItem:Flush(head, body)
  self._txtHead:SetText(head)
  self._txtBody:SetText(body)
end
