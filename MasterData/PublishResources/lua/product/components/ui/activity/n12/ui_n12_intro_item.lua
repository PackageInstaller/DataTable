_class("UIN12IntroItem", UICustomWidget)
UIN12IntroItem = UIN12IntroItem

function UIN12IntroItem:OnShow(uiParams)
  self:_GetComponent()
end

function UIN12IntroItem:_GetComponent()
  self.txtHead = self:GetUIComponent("UILocalizationText", "txtHead")
  self.txtBody = self:GetUIComponent("UILocalizationText", "txtBody")
end

function UIN12IntroItem:Flush(head, body)
  self.txtHead:SetText(head)
  self.txtBody:SetText(body)
end
