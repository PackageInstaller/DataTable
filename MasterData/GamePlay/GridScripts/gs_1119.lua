local gs_1119 = class("gs_1119", LuaGridBase)
gs_1119.config = {
  buffId = 110011,
  effectId = 12032,
  buffEffectId = 12033
}

function gs_1119:ctor()
end

function gs_1119:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_1119:OnGridEnterRole(role)
  local roleAtkSkill = role:GetCommonAttack()
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  roleAtkSkill:ResetCDTimeRatio(0)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1)
  LuaSkillCtrl:CallEffect(role, self.config.buffEffectId, self)
  self:GridLoseEffect()
end

function gs_1119:OnGridExitRole(role)
end

function gs_1119:OnGridRoleDead(role)
end

return gs_1119
