local gs_39 = class("gs_39", LuaGridBase)

function gs_39:ctor()
end

function gs_39:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_39:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, 1282, 1, nil, true)
  LuaSkillCtrl:CallEffect(role, 11010, self)
  self:GridLoseEffect()
end

function gs_39:OnGridExitRole(role)
end

function gs_39:OnGridRoleDead(role)
end

return gs_39
