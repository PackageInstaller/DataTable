_class("UIN21IntrItem", UICustomWidget)
UIN21IntrItem = UIN21IntrItem

function UIN21IntrItem:OnShow()
  self.SubTitle = self:GetUIComponent("UILocalizationText", "SubTitle")
  self.Des = self:GetUIComponent("UILocalizationText", "Des")
end

function UIN21IntrItem:OnHide()
end

function UIN21IntrItem:Flush(head, body)
  self.SubTitle:SetText(head)
  self.Des:SetText(body)
end
