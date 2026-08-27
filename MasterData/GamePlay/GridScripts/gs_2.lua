local gs_2 = class("gs_2", LuaGridBase)
gs_2.config = {effectCFId = 10176, effectId = 10175}

function gs_2:ctor()
end

function gs_2:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_2:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, 1024, 1, 75)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  LuaSkillCtrl:CallEffect(role, self.config.effectCFId, self)
  self:GridLoseEffect()
end

function gs_2:OnGridExitRole(role)
end

function gs_2:OnGridRoleDead(role)
end

return gs_2
