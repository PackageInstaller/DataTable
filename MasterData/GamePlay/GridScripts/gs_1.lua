local gs_1 = class("gs_1", LuaGridBase)
gs_1.config = {
  effectId = 10173,
  effectId2 = 10174,
  buffId = 1209,
  buffTier = 1
}

function gs_1:ctor()
end

function gs_1:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_1:OnGridEnterRole(role)
  self.curCd = role:GetMainSkillCurCd()
  role.recordTable.gs_1_CDGrid = self.curCd
  LuaSkillCtrl:CallReFillMainSkillCdForRole(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.config.buffTier, 15, true)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  self:GridLoseEffect()
end

function gs_1:OnGridExitRole(role)
end

function gs_1:OnGridRoleDead(role)
end

return gs_1
