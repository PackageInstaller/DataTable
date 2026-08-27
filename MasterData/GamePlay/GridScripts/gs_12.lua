local gs_12 = class("gs_12", LuaGridBase)
gs_12.config = {effectId = 10477, effectId1 = 10478}

function gs_12:ctor()
end

function gs_12:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_12:OnGridEnterRole(role)
  local grid = LuaSkillCtrl:GetNearestEmptyEfcGrid(role, 10)
  if grid ~= nil then
    LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
    LuaSkillCtrl:SetRolePos(grid, role)
    LuaSkillCtrl:CallEffect(role, self.config.effectId1, self)
  end
  self:GridLoseEffect()
end

function gs_12:OnGridExitRole(role)
end

function gs_12:OnGridRoleDead(role)
end

return gs_12
