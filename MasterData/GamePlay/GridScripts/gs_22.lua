local gs_22 = class("gs_22", LuaGridBase)
local base = LuaGridBase
gs_22.config = {duration = 30}

function gs_22:ctor()
end

function gs_22:OnGridBattleStart(role)
end

function gs_22:OnGridEnterRole(role)
  local callBack = BindCallback(self, self.CallBack, role)
  if self.timer == nil then
    self.timer = LuaSkillCtrl:StartTimer(nil, self.config.duration, callBack, nil, -1)
  end
end

function gs_22:CallBack(role)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local hurt = role.maxHp * 100 // 1000
  LuaSkillCtrl:RemoveLife(hurt, self, role, true, nil, true, true, eHurtType.RealDmg)
end

function gs_22:OnGridExitRole(role)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function gs_22:OnGridUncorver(role)
  if role ~= nil then
    self:OnGridEnterRole(role)
  end
end

function gs_22:OnGridBeCorvered(role, coverGrid)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function gs_22:OnGridRoleDead(role)
end

function gs_22:LuaDispose()
  base.LuaDispose(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return gs_22
