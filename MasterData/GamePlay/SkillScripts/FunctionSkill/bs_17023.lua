local bs_17023 = class("bs_17023", LuaSkillBase)
local base = LuaSkillBase
bs_17023.config = {buffId = 2099, buffTier = 1}

function bs_17023:ctor()
end

function bs_17023:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17023_2", 10, self.OnAfterBattleStart)
end

function bs_17023:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, self, -1)
end

function bs_17023:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local piece = 0
  while piece < self.arglist[2] do
    piece = piece + 1
    local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    local x = grid.x + LuaSkillCtrl:CallRange(-2, 2)
    local y = grid.y + LuaSkillCtrl:CallRange(-2, 2)
    local tempGrid = LuaSkillCtrl:GetGridWithPos(x, y)
    if tempGrid == nil then
      x = grid.x
      y = grid.y
    end
    LuaSkillCtrl:CallHurtPool(self, 3, x, y)
  end
  piece = 0
end

function bs_17023:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_17023
