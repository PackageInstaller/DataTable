_class("UINxIntrItemBase", UICustomWidget)
UINxIntrItemBase = UINxIntrItemBase

function UINxIntrItemBase:OnShow()
  self.SubTitle = self:GetUIComponent("UILocalizationText", "SubTitle")
  self.Des = self:GetUIComponent("UILocalizationText", "Des")
end

function UINxIntrItemBase:OnHide()
end

function UINxIntrItemBase:Flush(head, body)
  self.SubTitle:SetText(head)
  self.Des:SetText(body)
end
