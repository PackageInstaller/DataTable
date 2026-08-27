local gs_1102 = class("gs_1102", LuaGridBase)
local base = LuaGridBase
gs_1102.config = {duration = 30, effectId = 12019}

function gs_1102:ctor()
end

function gs_1102:OnGridBattleStart(role)
end

function gs_1102:OnGridEnterRole(role)
  if role.belongNum == eBattleRoleBelong.neutral then
    return
  end
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  local callBack = BindCallback(self, self.CallBack, role)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.config.duration, callBack, nil, -1)
end

function gs_1102:CallBack(role)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local heal = role.maxHp * 50 // 1000
  LuaSkillCtrl:CallHeal(heal, self, role, true)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
end

function gs_1102:OnGridBeCorvered(role)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function gs_1102:OnGridUncorver(role)
  if role ~= nil then
    self:OnGridEnterRole(role)
  end
end

function gs_1102:LuaDispose()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  base.LuaDispose(self)
end

function gs_1102:OnGridExitRole(role)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function gs_1102:OnGridRoleDead(role)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return gs_1102
