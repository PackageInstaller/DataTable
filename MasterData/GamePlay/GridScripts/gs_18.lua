local gs_18 = class("gs_18", LuaGridBase)
gs_18.config = {
  effectId = 10372,
  buffId = 1144,
  buffTier = 10,
  sheildBuffId = 174,
  sheildBuffTier = 1
}

function gs_18:ctor()
end

function gs_18:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_18:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.config.buffTier)
  LuaSkillCtrl:CallBuff(self, role, self.config.sheildBuffId, self.config.sheildBuffTier)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  self:GridLoseEffect()
end

function gs_18:OnGridExitRole(role)
end

function gs_18:OnGridRoleDead(role)
end

return gs_18
