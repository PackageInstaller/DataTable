local gs_21 = class("gs_21", LuaGridBase)
gs_21.config = {effectId = 10815}

function gs_21:ctor()
end

function gs_21:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_21:OnGridEnterRole(role)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  LuaSkillCtrl:CallBuff(self, role, 1150, 2)
  self:GridLoseEffect()
end

function gs_21:OnGridExitRole(role)
end

function gs_21:OnGridRoleDead(role)
end

return gs_21
