local gs_38 = class("gs_38", LuaGridBase)

function gs_38:ctor()
end

function gs_38:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_38:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, 1281, 1, nil, true)
  LuaSkillCtrl:CallEffect(role, 11009, self)
  self:GridLoseEffect()
end

function gs_38:OnGridExitRole(role)
end

function gs_38:OnGridRoleDead(role)
end

return gs_38
