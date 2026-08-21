_class("UISummer1IntroItem", UICustomWidget)
UISummer1IntroItem = UISummer1IntroItem

function UISummer1IntroItem:OnShow()
  self.txtHead = self:GetUIComponent("UILocalizationText", "txtHead")
  self.txtBody = self:GetUIComponent("UILocalizationText", "txtBody")
end

function UISummer1IntroItem:Flush(head, body)
  self.txtHead:SetText(head)
  self.txtBody:SetText(body)
end
