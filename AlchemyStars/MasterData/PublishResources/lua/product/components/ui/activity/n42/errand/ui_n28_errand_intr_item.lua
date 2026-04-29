_class("UIN28ErrandIntrItem", UICustomWidget)
UIN28ErrandIntrItem = UIN28ErrandIntrItem

function UIN28ErrandIntrItem:OnShow()
  self.SubTitle = self:GetUIComponent("UILocalizationText", "SubTitle")
  self.Des = self:GetUIComponent("UILocalizationText", "Des")
end

function UIN28ErrandIntrItem:OnHide()
end

function UIN28ErrandIntrItem:Flush(head, body)
  self.SubTitle:SetText(head)
  self.Des:SetText(body)
end
