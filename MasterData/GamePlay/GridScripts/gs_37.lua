local gs_37 = class("gs_37", LuaGridBase)

function gs_37:ctor()
end

function gs_37:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_37:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, 1280, 1, nil, true)
  LuaSkillCtrl:CallEffect(role, 11008, self)
  self:GridLoseEffect()
end

function gs_37:OnGridExitRole(role)
end

function gs_37:OnGridRoleDead(role)
end

return gs_37
