_class("UIN28AVGIntroItem", UICustomWidget)
UIN28AVGIntroItem = UIN28AVGIntroItem

function UIN28AVGIntroItem:OnShow()
  self.txtHead = self:GetUIComponent("UILocalizationText", "txtHead")
  self.txtBody = self:GetUIComponent("UILocalizationText", "txtBody")
end

function UIN28AVGIntroItem:Flush(head, body)
  self.txtHead:SetText(head)
  self.txtBody:SetText(body)
end
