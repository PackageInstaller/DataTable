local gs_1101 = class("gs_1101", LuaGridBase)
local base = LuaGridBase
gs_1101.config = {duration = 30, effectId = 12018}

function gs_1101:ctor()
end

function gs_1101:OnGridBattleStart(role)
end

function gs_1101:OnGridEnterRole(role)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  local callBack = BindCallback(self, self.CallBack, role)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.config.duration, callBack, nil, -1)
end

function gs_1101:CallBack(role)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local hurt = role.maxHp * 50 // 1000
  LuaSkillCtrl:RemoveLife(hurt, self, role, true, nil, true, true, eHurtType.RealDmg)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
end

function gs_1101:OnGridBeCorvered(role)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function gs_1101:OnGridUncorver(role)
  if role ~= nil then
    self:OnGridEnterRole(role)
  end
end

function gs_1101:OnGridExitRole(role)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function gs_1101:OnGridRoleDead(role)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function gs_1101:LuaDispose()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  base.LuaDispose(self)
end

return gs_1101
