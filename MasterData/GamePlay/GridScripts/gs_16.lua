local gs_16 = class("gs_16", LuaGridBase)
gs_16.config = {
  buffId = 1137,
  buffTier = 1,
  effectId = 10855
}

function gs_16:ctor()
end

function gs_16:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_16:OnGridEnterRole(role)
  if role ~= nil then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.config.buffTier, nil, true)
    LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
    self:GridLoseEffect()
  end
end

function gs_16:OnGridExitRole(role)
end

function gs_16:OnGridRoleDead(role)
end

return gs_16
