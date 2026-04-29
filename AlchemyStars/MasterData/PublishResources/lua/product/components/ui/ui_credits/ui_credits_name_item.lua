_class("UICreditsNameItem", UICustomWidget)
UICreditsNameItem = UICreditsNameItem

function UICreditsNameItem:OnShow()
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
end

function UICreditsNameItem:OnHide()
end
