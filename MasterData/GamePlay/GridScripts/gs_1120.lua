local gs_1120 = class("gs_1120", LuaGridBase)
gs_1120.config = {
  buffId = 110012,
  effectId = 12034,
  buffEffectId = 12035
}

function gs_1120:ctor()
end

function gs_1120:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_1120:OnGridEnterRole(role)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1)
  LuaSkillCtrl:CallEffect(role, self.config.buffEffectId, self)
  self:GridLoseEffect()
end

function gs_1120:OnGridExitRole(role)
end

function gs_1120:OnGridRoleDead(role)
end

return gs_1120
