local TrinketUpgradeUsingMaterialsComp, Super = System.NewClass("TrinketUpgradeUsingMaterialsComp")

function TrinketUpgradeUsingMaterialsComp:ctor(ui, strengthenModel)
  Super.ctor(self)
  self.ui = ui
  self.strengthenModel = strengthenModel
end

function TrinketUpgradeUsingMaterialsComp:OnBind(binder)
  self.binder = binder
  self:BindSelectedMaterials(binder)
end

function TrinketUpgradeUsingMaterialsComp:BindSelectedMaterials(binder)
  local commonIconItemModel = binder:createModel(CommonIconItemModel)
  binder:BindComponent(TrinketUpgradeUsingMatSlotComp(self.ui.Weapon_01, self.strengthenModel, commonIconItemModel))
end

return TrinketUpgradeUsingMaterialsComp
