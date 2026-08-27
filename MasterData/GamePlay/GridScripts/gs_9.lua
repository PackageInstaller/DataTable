local gs_9 = class("gs_9", LuaGridBase)
gs_9.config = {
  effectId = 10473,
  buffId = 1207,
  buffTier = 1
}

function gs_9:ctor()
end

function gs_9:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_9:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.config.buffTier)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  self:GridLoseEffect()
end

function gs_9:OnGridExitRole(role)
end

function gs_9:OnGridRoleDead(role)
end

return gs_9
