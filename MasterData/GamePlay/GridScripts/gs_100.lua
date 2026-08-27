local gs_100 = class("gs_100", LuaGridBase)
gs_100.config = {effectGridId = 10824}

function gs_100:ctor()
end

function gs_100:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_100:OnGridEnterRole(role)
  LuaSkillCtrl:CallEffect(role, self.config.effectGridId, self)
end

function gs_100:OnGridExitRole(role)
end

function gs_100:OnGridRoleDead(role)
end

function gs_100:OnGridBattleEnd(role)
  local healNum = role.maxHp * 300 // 1000
  role:AddHp(healNum)
end

return gs_100
