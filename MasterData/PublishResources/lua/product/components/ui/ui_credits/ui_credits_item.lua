_class("UICreditsItem", UICustomWidget)
UICreditsItem = UICreditsItem

function UICreditsItem:OnShow()
  self.txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self.glg = self:GetUIComponent("GridLayoutGroup", "names")
  self.pool = self:GetUIComponent("UISelectObjectPath", "names")
end

function UICreditsItem:OnHide()
end
