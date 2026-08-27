local gs_6 = class("gs_6", LuaGridBase)
gs_6.config = {
  effectId = 10370,
  buffId = 1047,
  buffTier = 10,
  sheildBuffId = 174,
  sheildBuffTier = 1
}

function gs_6:ctor()
end

function gs_6:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_6:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.config.buffTier)
  LuaSkillCtrl:CallBuff(self, role, self.config.sheildBuffId, self.config.sheildBuffTier)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  self:GridLoseEffect()
end

function gs_6:OnGridExitRole(role)
end

function gs_6:OnGridRoleDead(role)
end

return gs_6
