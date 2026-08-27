local gs_5 = class("gs_5", LuaGridBase)
gs_5.config = {
  effectId = 10566,
  buffId = 1052,
  buffTier = 1
}

function gs_5:ctor()
end

function gs_5:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_5:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.config.buffTier)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  self:GridLoseEffect()
end

function gs_5:OnGridExitRole(role)
end

function gs_5:OnGridRoleDead(role)
end

return gs_5
