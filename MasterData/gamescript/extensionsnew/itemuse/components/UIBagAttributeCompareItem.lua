local UIBagAttributeCompareItem, Super = NewViewComponent("UIBagAttributeCompareItem")

function UIBagAttributeCompareItem:ctor(uiNode, view, iconPath, attrName, preValue, newValue, hasImproved)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Bag_Item_Btn_AttributeResource(uiNode)
  self.iconPath = iconPath
  self.attrName = attrName
  self.preValue = preValue
  self.newValue = newValue
  self.hasImproved = hasImproved
end

function UIBagAttributeCompareItem:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:_RefreshText()
  self:_RefreshImage()
  self:_RefreshVisible()
end

function UIBagAttributeCompareItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function UIBagAttributeCompareItem:_RefreshText()
  local attrName = LT.Text(self.attrName)
  self:SetText(self.ui.Text_Name, attrName)
  self:SetText(self.ui.Text_Originally, self.preValue)
  self:SetText(self.ui.Text_Hoist, self.newValue)
end

function UIBagAttributeCompareItem:_RefreshImage()
  if self.iconPath then
    self:SetImage(self.ui.Image_Icon, self.iconPath)
  end
end

function UIBagAttributeCompareItem:_RefreshVisible()
  self:SetActive(self.ui.Image_Arrow2, self.hasImproved)
end

return UIBagAttributeCompareItem
