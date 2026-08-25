local PvPTeamBuildWeaponItem, Super = System.NewComponent("PvPTeamBuildWeaponItem", PvPTeamBuildBaseItem)

function PvPTeamBuildWeaponItem:ctor(uiNode, data)
  Super.ctor(self, uiNode, data)
end

function PvPTeamBuildWeaponItem:OnBindExpandPart()
  local binder = self.binder
  binder:BindToVisible(self.ui.Image_Weapon, function()
    return true
  end)
  binder:BindToImage(self.ui.Image_Weapon, self.mainIconFunc)
end

return PvPTeamBuildWeaponItem
