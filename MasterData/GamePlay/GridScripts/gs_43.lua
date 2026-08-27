local gs_43 = class("gs_43", LuaGridBase)
local base = LuaGridBase
gs_43.config = {duration = 30}

function gs_43:ctor()
end

function gs_43:OnGridBattleStart(role)
end

function gs_43:OnGridEnterRole(role)
  local callBack = BindCallback(self, self.CallBack, role)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.config.duration, callBack, nil, -1)
end

function gs_43:CallBack(role)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  if role.belongNum ~= eBattleRoleBelong.neutral then
    local hurt = role.maxHp * 150 // 1000
    LuaSkillCtrl:RemoveLife(hurt, self, role, true, nil, true, true, eHurtType.RealDmg)
  end
end

function gs_43:OnGridExitRole(role)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function gs_43:OnGridRoleDead(role)
end

function gs_43:OnGridUncorver(role)
  if role ~= nil then
    self:OnGridEnterRole(role)
  end
end

function gs_43:OnGridBeCorvered(role, coverGrid)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function gs_43:LuaDispose()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  base.LuaDispose(self)
end

return gs_43
