local gs_25 = class("gs_25", LuaGridBase)

function gs_25:ctor()
end

function gs_25:OnGridBattleStart(role)
end

function gs_25:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, 1226, 1, nil, true)
end

function gs_25:OnGridExitRole(role)
  LuaSkillCtrl:DispelBuff(self.caster, 1226, 0)
end

function gs_25:OnGridUncorver(role)
  if role ~= nil then
    self:OnGridEnterRole(role)
  end
end

function gs_25:OnGridRoleDead(role)
end

return gs_25
