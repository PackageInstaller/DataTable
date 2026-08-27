local gs_7 = class("gs_7", LuaGridBase)
gs_7.config = {
  effectId = 10372,
  buffId = 1048,
  buffTier = 10,
  sheildBuffId = 174,
  sheildBuffTier = 1
}

function gs_7:ctor()
end

function gs_7:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_7:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.config.buffTier)
  LuaSkillCtrl:CallBuff(self, role, self.config.sheildBuffId, self.config.sheildBuffTier)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  self:GridLoseEffect()
end

function gs_7:OnGridExitRole(role)
end

function gs_7:OnGridRoleDead(role)
end

return gs_7
