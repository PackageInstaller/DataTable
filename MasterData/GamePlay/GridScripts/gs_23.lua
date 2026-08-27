local gs_23 = class("gs_23", LuaGridBase)
local base = LuaGridBase
gs_23.config = {duration = 30}

function gs_23:ctor()
end

function gs_23:OnGridBattleStart(role)
end

function gs_23:OnGridEnterRole(role)
  local callBack = BindCallback(self, self.CallBack, role)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.config.duration, callBack, nil, -1)
end

function gs_23:CallBack(role)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local hurt = role.maxHp * 150 // 1000
  LuaSkillCtrl:RemoveLife(hurt, self, role, true, nil, true, true, eHurtType.RealDmg)
end

function gs_23:OnGridExitRole(role)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function gs_23:OnGridRoleDead(role)
end

function gs_23:OnGridUncorver(role)
  if role ~= nil then
    self:OnGridEnterRole(role)
  end
end

function gs_23:OnGridBeCorvered(role, coverGrid)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function gs_23:LuaDispose()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  base.LuaDispose(self)
end

return gs_23
