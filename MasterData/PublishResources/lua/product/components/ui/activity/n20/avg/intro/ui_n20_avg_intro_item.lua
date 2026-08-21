_class("UIN20AVGIntroItem", UICustomWidget)
UIN20AVGIntroItem = UIN20AVGIntroItem

function UIN20AVGIntroItem:OnShow()
  self.txtHead = self:GetUIComponent("UILocalizationText", "txtHead")
  self.txtBody = self:GetUIComponent("UILocalizationText", "txtBody")
end

function UIN20AVGIntroItem:Flush(head, body)
  self.txtHead:SetText(head)
  self.txtBody:SetText(body)
end
