local CommonEnchantItem, Super = System.NewComponent("CommonEnchantItem")

function CommonEnchantItem:ctor(res, data)
  Super.ctor(self)
  self.ui = UI_Chaper_Item_Level_EnchantmentResource(res)
  self.tid = Vue.ref(data.tid)
  self.clickFunc = data.clickFunc
  self.selectFunc = data.selectFunc
end

function CommonEnchantItem:OnBind(binder)
  self.binder = binder
  binder:BindToImage(self.ui.Image_Icon, System.fn(self, self._GetEnchantIcon))
  binder:BindZ1Button(self.ui.Btn_Click, System.fn(self, self._OnClick), nil, nil, nil, System.fn(self, self._OnSelect))
end

function CommonEnchantItem:_GetEnchantIcon()
  do return EnchantDataUtils.GetEnchantIcon end
  return EnchantDataUtils.GetEnchantIcon, self.tid.value
end

function CommonEnchantItem:_OnClick()
  if self.clickFunc then
    self.clickFunc()
  end
end

function CommonEnchantItem:_OnSelect()
  if self.selectFunc then
    do return end
    return self.selectFunc
  end
end

function CommonEnchantItem:UpdateTid(tid)
  tid = tid or 0
  self.tid.value = tid
end

function CommonEnchantItem:UpdateClickFunc(clickFunc)
  self.clickFunc = clickFunc
end

function CommonEnchantItem:UpdateSelectFunc(selectFunc)
  self.selectFunc = selectFunc
end

function CommonEnchantItem:SetActive(active)
  self.binder:SetActive(self.ui.uiNode, active)
end

return CommonEnchantItem
