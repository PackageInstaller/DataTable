local gs_1128 = class("gs_1128", LuaGridBase)
local base = LuaGridBase
gs_1128.config = {duration = 15}

function gs_1128:ctor()
end

function gs_1128:OnGridBattleStart(role)
end

function gs_1128:OnGridEnterRole(role)
  local callBack = BindCallback(self, self.CallBack, role)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.config.duration, callBack, nil, -1)
end

function gs_1128:CallBack(role)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local hurt = role.maxHp * 100 // 1000
  LuaSkillCtrl:RemoveLife(hurt, self, role, true, nil, true, true, eHurtType.RealDmg)
end

function gs_1128:OnGridExitRole(role)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function gs_1128:OnGridRoleDead(role)
end

function gs_1128:LuaDispose()
  base.LuaDispose(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return gs_1128
