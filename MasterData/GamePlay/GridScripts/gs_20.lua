local gs_20 = class("gs_20", LuaGridBase)
gs_20.config = {effectId = 10819}

function gs_20:ctor()
end

function gs_20:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_20:OnGridEnterRole(role)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  LuaSkillCtrl:CallBuff(self, role, 1149, 1, nil)
  self:GridLoseEffect()
end

function gs_20:OnGridExitRole(role)
end

function gs_20:OnGridRoleDead(role)
end

return gs_20
