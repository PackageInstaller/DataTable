local gs_17 = class("gs_17", LuaGridBase)
gs_17.config = {
  effectId = 10370,
  buffId = 1143,
  buffTier = 10,
  sheildBuffId = 174,
  sheildBuffTier = 1
}

function gs_17:ctor()
end

function gs_17:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_17:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.config.buffTier)
  LuaSkillCtrl:CallBuff(self, role, self.config.sheildBuffId, self.config.sheildBuffTier)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  self:GridLoseEffect()
end

function gs_17:OnGridExitRole(role)
end

function gs_17:OnGridRoleDead(role)
end

return gs_17
