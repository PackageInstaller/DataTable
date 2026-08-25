local PvPTeamBuildKeeperSkillItem, Super = System.NewComponent("PvPTeamBuildKeeperSkillItem", PvPTeamBuildBaseItem)

function PvPTeamBuildKeeperSkillItem:ctor(uiNode, data)
  Super.ctor(self, uiNode, data)
end

function PvPTeamBuildKeeperSkillItem:OnBindExpandPart()
  local binder = self.binder
  binder:BindToVisible(self.ui.Image_Resonance, function()
    return true
  end)
  binder:BindToImage(self.ui.Image_Resonance, self.mainIconFunc)
end

return PvPTeamBuildKeeperSkillItem
