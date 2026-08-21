_class("UIActivityEveSinsaIntrItem", UICustomWidget)
UIActivityEveSinsaIntrItem = UIActivityEveSinsaIntrItem

function UIActivityEveSinsaIntrItem:OnShow()
  self.txtHead = self:GetUIComponent("UILocalizationText", "txtHead")
  self.txtBody = self:GetUIComponent("UILocalizationText", "txtBody")
end

function UIActivityEveSinsaIntrItem:Flush(head, body)
  self.txtHead:SetText(head)
  self.txtBody:SetText(body)
end
