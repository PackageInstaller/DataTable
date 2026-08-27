local bs_17068 = class("bs_17068", LuaSkillBase)
local base = LuaSkillBase
bs_17068.config = {
  buffId = {
    2097,
    2098,
    2099
  },
  buffTier = 1
}

function bs_17068:ctor()
end

function bs_17068:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17068_1", 10, self.OnAfterBattleStart)
end

function bs_17068:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], arriveCallBack, self, -1)
end

function bs_17068:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 82, 20)
  if targetList.Count < 1 then
    return
  end
  for i = 0, targetList.Count - 1 do
    local index = LuaSkillCtrl:CallRange(1, 3)
    local buffId = self.config.buffId[index]
    local piece = 0
    while piece < self.arglist[1] do
      piece = piece + 1
      local grid = LuaSkillCtrl:GetGridWithRole(targetList[i].targetRole)
      local x = grid.x + LuaSkillCtrl:CallRange(-2, 2)
      local y = grid.y + LuaSkillCtrl:CallRange(-2, 2)
      local tempGrid = LuaSkillCtrl:GetGridWithPos(x, y)
      if tempGrid == nil then
        x = grid.x
        y = grid.y
      end
      LuaSkillCtrl:CallHurtPool(self, index, x, y)
    end
    piece = 0
  end
end

function bs_17068:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_17068
