_class("UILuckLandFlyItem", UICustomWidget)
UILuckLandFlyItem = UILuckLandFlyItem

function UILuckLandFlyItem:OnShow(uiParams)
  self:InitWidget()
end

function UILuckLandFlyItem:InitWidget()
  self.resDataText = self:GetUIComponent("UILocalizationText", "ResDataText")
  self.rootRectTf = self:GetUIComponent("RectTransform", "Root")
end

function UILuckLandFlyItem:SetData(value)
  self.resDataText:SetText(value)
end

function UILuckLandFlyItem:FlyPos(pos)
  self.rootRectTf:DOAnchorPos(pos, 0.25, true)
end
