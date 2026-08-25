local PVPBattleRoleGraveUI, Super = System.NewComponent("PVPBattleRoleGraveUI")

function PVPBattleRoleGraveUI:ctor(uiNode, battleRole)
  Super.ctor(self)
  self.ui = UI_Pvp_GraveResource(uiNode)
  self.battleRole = battleRole
  self.roleUid = battleRole.uid
  self.roleData = bg.battleDataCenter:GetRoleDataModel(self.roleUid)
end

function PVPBattleRoleGraveUI:OnBind(binder)
  self.binder = binder
end

function PVPBattleRoleGraveUI:SetActive(isActive)
  self.ui.uiNode:SetActive(isActive)
end

return PVPBattleRoleGraveUI
