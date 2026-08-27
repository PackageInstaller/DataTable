local gs_1124 = class("gs_1124", LuaGridBase)
gs_1124.config = {
  buffId = 110044,
  effectId = 12034,
  buffEffectId = 12035
}

function gs_1124:ctor()
end

function gs_1124:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_1124:OnGridEnterRole(role)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1)
  LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1.3, 1.3, 1.3), 0.2)
  self:GridLoseEffect()
end

function gs_1124:OnGridExitRole(role)
end

function gs_1124:OnGridRoleDead(role)
end

return gs_1124
