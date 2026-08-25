local WeaponForEnhanceResult, Super = System.NewComponent("WeaponForEnhanceResult")

function WeaponForEnhanceResult:ctor(go, model)
  Super.ctor(self)
  self.ui = UI_Common_Item_WuPin_Type1Resource(go)
  self.model = model
end

function WeaponForEnhanceResult:OnBind(binder)
  self.binder = binder
  binder:BindToImage(self.ui.Icon_Article, function()
    local tid = self.model.weaponConfig.ID
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, tid
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    local tid = self.model.weaponConfig.ID
    local config = DT.Item[tid]
    do return ItemDataUtils.GetCommonItemBottomQualityFrame, config end
    return ItemDataUtils.GetCommonItemBottomQualityFrame, config, self.ui.Image_Bg_Black
  end)
end

return WeaponForEnhanceResult
