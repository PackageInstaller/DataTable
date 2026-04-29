_class("UIN27IntrItem", UICustomWidget)
UIN27IntrItem = UIN27IntrItem

function UIN27IntrItem:OnShow()
  self.SubTitle = self:GetUIComponent("UILocalizationText", "SubTitle")
  self.Des = self:GetUIComponent("UILocalizationText", "Des")
end

function UIN27IntrItem:OnHide()
end

function UIN27IntrItem:Flush(head, body)
  self.SubTitle:SetText(head)
  self.Des:SetText(body)
end
