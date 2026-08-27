local gs_1123 = class("gs_1123", LuaGridBase)
gs_1123.config = {
  buffId = 110043,
  effectId = 12032,
  buffEffectId = 12033
}

function gs_1123:ctor()
end

function gs_1123:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_1123:OnGridEnterRole(role)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1)
  LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1.3, 1.3, 1.3), 0.2)
  self:GridLoseEffect()
end

function gs_1123:OnGridExitRole(role)
end

function gs_1123:OnGridRoleDead(role)
end

return gs_1123
