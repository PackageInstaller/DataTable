local gs_40 = class("gs_40", LuaGridBase)

function gs_40:ctor()
end

function gs_40:OnGridBattleStart(role)
end

function gs_40:OnGridEnterRole(role)
  local targetGrid = LuaSkillCtrl:CallFindFurthestGridInDirRangeWithoutRole(role.x, role.y, role.x + 1, role.y)
  if targetGrid ~= nil and targetGrid.x > role.x + 1 then
    LuaSkillCtrl:CallPhaseMove(self, role, targetGrid.x, targetGrid.y, 1, 206806, 1)
    LuaSkillCtrl:CallEffect(role, 10264, self)
    LuaSkillCtrl:CallEffect(role, 11011, self)
    LuaSkillCtrl:CallBuff(self, role, 60504, 1, 15, true)
    LuaSkillCtrl:StartTimer(nil, 1, function()
      role:ResetRoleState()
    end)
  end
end

function gs_40:OnGridExitRole(role)
end

function gs_40:OnGridRoleDead(role)
end

return gs_40
