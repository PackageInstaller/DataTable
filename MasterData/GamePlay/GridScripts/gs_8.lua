local gs_8 = class("gs_8", LuaGridBase)
gs_8.config = {
  effectId = 10472,
  buffId = 1049,
  buffTier = 1
}

function gs_8:ctor()
end

function gs_8:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_8:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.config.buffTier)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  self:GridLoseEffect()
end

function gs_8:OnGridExitRole(role)
end

function gs_8:OnGridRoleDead(role)
end

return gs_8
