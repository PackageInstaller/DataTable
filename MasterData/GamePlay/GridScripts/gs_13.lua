local gs_13 = class("gs_13", LuaGridBase)
gs_13.config = {
  effectId = 10479,
  buffId = 1051,
  buffTier = 1
}

function gs_13:ctor()
end

function gs_13:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_13:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.config.buffTier, 150)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  self:GridLoseEffect()
end

function gs_13:OnGridExitRole(role)
end

function gs_13:OnGridRoleDead(role)
end

return gs_13
