local gs_42 = class("gs_42", LuaGridBase)
gs_42.config = {effectId = 10477, effectId1 = 10478}

function gs_42:ctor()
end

function gs_42:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_42:OnGridEnterRole(role)
  local grid = LuaSkillCtrl:GetNearestEmptyEfcGrid(role, 11)
  if grid ~= nil then
    LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
    LuaSkillCtrl:SetRolePos(grid, role)
    LuaSkillCtrl:CallEffect(role, self.config.effectId1, self)
  end
  self:GridLoseEffect()
end

function gs_42:OnGridExitRole(role)
end

function gs_42:OnGridRoleDead(role)
end

return gs_42
