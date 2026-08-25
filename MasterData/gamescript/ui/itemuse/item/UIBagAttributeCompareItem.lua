local UIBagAttributeCompareItem, Super = System.NewComponent("UIBagAttributeCompareItem")

function UIBagAttributeCompareItem:ctor(uiNode, iconPath, attrName, preValue, newValue, hasImproved)
  Super.ctor(self)
  self.ui = UI_Bag_Item_Btn_AttributeResource(uiNode)
  self.iconPath = iconPath
  self.attrName = attrName
  self.preValue = preValue
  self.newValue = newValue
  self.hasImproved = hasImproved
end

function UIBagAttributeCompareItem:OnBind(binder)
  binder:BindToText(self.ui.Text_Name, function()
    do return LT.Text end
    return LT.Text, self.attrName
  end)
  binder:BindToText(self.ui.Text_Originally, function()
    return self.preValue
  end)
  binder:BindToText(self.ui.Text_Hoist, function()
    return self.newValue
  end)
  if self.iconPath then
    binder:BindToImage(self.ui.Image_Icon, function()
      return self.iconPath
    end)
  end
  binder:BindToVisible(self.ui.Image_Arrow2, function()
    return self.hasImproved
  end)
end

return UIBagAttributeCompareItem
