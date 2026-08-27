local gs_1104 = class("gs_1104", LuaGridBase)
local csRoleState = CS.eBattleRoleState
gs_1104.config = {
  effectId = 10477,
  effectId1 = 10478,
  buffId_1000 = 1000
}

function gs_1104:ctor()
end

function gs_1104:OnGridBattleStart(role)
end

function gs_1104:OnGridEnterRole(role)
  local grid = LuaSkillCtrl:GetNearestEmptyEfcGrid(role, 1105)
  if grid ~= nil then
    LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
    LuaSkillCtrl:CallBreakAllSkill(role)
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId_1000, 1, 30, true)
    role:AddSkillWaitBuff(10)
    LuaSkillCtrl.cluaSkillCtrl:SetPosForce(grid, role)
    LuaSkillCtrl:CallEffect(role, self.config.effectId1, self)
  end
end

function gs_1104:TryResetMoveState(role)
  if role == nil or role.hp <= 0 then
    return
  end
  if role.eState == csRoleState.Moving then
    role:SetRoleState(csRoleState.Normal)
  end
end

function gs_1104:OnGridExitRole(role)
end

function gs_1104:OnGridRoleDead(role)
end

return gs_1104
