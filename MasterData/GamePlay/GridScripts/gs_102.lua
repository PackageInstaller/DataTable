local gs_102 = class("gs_102", LuaGridBase)
gs_102.config = {effectGridId = 10826}

function gs_102:ctor()
end

function gs_102:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_102:OnGridEnterRole(role)
  LuaSkillCtrl:CallEffect(role, self.config.effectGridId, self)
  self:GridLoseEffect()
end

function gs_102:OnGridExitRole(role)
end

function gs_102:OnGridRoleDead(role)
end

return gs_102
