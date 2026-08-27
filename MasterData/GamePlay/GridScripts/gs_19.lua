local gs_19 = class("gs_19", LuaGridBase)
gs_19.config = {effectId = 10816}

function gs_19:ctor()
end

function gs_19:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_19:OnGridEnterRole(role)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  LuaSkillCtrl:CallBuff(self, role, 1145, 1)
  self:GridLoseEffect()
end

function gs_19:OnGridExitRole(role)
end

function gs_19:OnGridRoleDead(role)
end

return gs_19
