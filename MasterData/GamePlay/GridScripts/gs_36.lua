local gs_36 = class("gs_36", LuaGridBase)
local base = LuaGridBase
gs_36.config = {duration = 15, duration2 = 30}

function gs_36:ctor()
end

function gs_36:OnGridBattleStart(role)
  self.flag = false
end

function gs_36:OnGridEnterRole(role)
  local callBack = BindCallback(self, self.CallBack, role)
  local callBack1 = BindCallback(self, self.CallBack1)
  if self.timer == nil then
    self.timer = LuaSkillCtrl:StartTimer(nil, self.config.duration, callBack, nil, -1)
  end
  if self.flag == true then
    return
  end
  if self.timer2 == nil then
    self.timer2 = LuaSkillCtrl:StartTimer(nil, self.config.duration2, callBack1, nil)
  end
end

function gs_36:CallBack(role)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local hurt = role.maxHp * 50 // 1000
  LuaSkillCtrl:RemoveLife(hurt, self, role, true, nil, true, true, eHurtType.RealDmg)
end

function gs_36:CallBack1()
  self:GridLoseEffect()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.timer2 ~= nil then
    self.timer2:Stop()
    self.timer2 = nil
  end
  self.flag = true
end

function gs_36:OnGridExitRole(role)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function gs_36:OnGridRoleDead(role)
end

function gs_36:LuaDispose()
  base.LuaDispose(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return gs_36
