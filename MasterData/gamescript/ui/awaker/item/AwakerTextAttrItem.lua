local AwakerTextAttrItem, Super = System.NewComponent("AwakerTextAttrItem")

function AwakerTextAttrItem:ctor(res, data)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Attribute_DetailResource(res)
  self.data = data
end

function AwakerTextAttrItem:OnBind(binder)
  self.binder = binder
  binder:BindToText(self.ui.Text_Describe, System.fn(self, self._ShowAttrName))
  binder:BindToText(self.ui.Text_Numerical, System.fn(self, self._ShowAttrValue))
end

function AwakerTextAttrItem:_ShowAttrName()
  if not self.data then
    return
  end
  if self.data.nameTextFunc then
    do return end
    return self.data.nameTextFunc
  end
  return self.data.nameText
end

function AwakerTextAttrItem:_ShowAttrValue()
  if not self.data then
    return
  end
  if self.data.attrValueTextFunc then
    do return end
    return self.data.attrValueTextFunc
  end
  return self.data.attrValueText
end

return AwakerTextAttrItem
