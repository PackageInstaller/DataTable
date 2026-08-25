local WeaponEnhanceMaterial, Super = System.NewComponent("WeaponEnhanceMaterial")

function WeaponEnhanceMaterial:ctor(go, mtrl)
  Super.ctor(self)
  self.ui = UI_Common_Item_WuPin_Type1Resource(go)
  self.mtrl = mtrl
end

function WeaponEnhanceMaterial:OnBind(binder)
  self.binder = binder
  binder:BindToImage(self.ui.Icon_Article, function()
    if not self.mtrl.tid then
      return ""
    end
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, self.mtrl.tid
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    if not self.mtrl.tid then
      return ""
    end
    local config = DT.Item[self.mtrl.tid]
    do return ItemDataUtils.GetCommonItemBottomQualityFrame, config end
    return ItemDataUtils.GetCommonItemBottomQualityFrame, config, self.ui.Image_Bg_Black
  end)
  binder:BindToText(self.ui.Text_Article_Number, function()
    if self.mtrl.isWeapon then
      do return string.format, "Lv.%s" end
      return string.format, "Lv.%s", self.mtrl.enhanceLevel
    else
      return self.mtrl.count
    end
  end)
  binder:BindLongPressButton(self.ui.Btn_Click, function()
  end, System.fn(self, self.OnTodoFunc), tonumber(DT.GetConstant("Role_Press_Time")))
end

function WeaponEnhanceMaterial:OnTodoFunc()
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, self.mtrl.tid)
end

return WeaponEnhanceMaterial
