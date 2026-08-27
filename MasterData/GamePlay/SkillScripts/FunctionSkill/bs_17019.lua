local bs_17019 = class("bs_17019", LuaSkillBase)
local base = LuaSkillBase
bs_17019.config = {}

function bs_17019:ctor()
end

function bs_17019:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfStartMove, "bs_17019_1", 1, self.OnStartMove)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_17019_2", 2, self.OnAfterMove)
  self.typenum = 3
end

function bs_17019:OnStartMove()
  if self.damTimer == nil then
    self.damTimer = LuaSkillCtrl:StartTimer(nil, 5, self.CallBack, self, -1, 5)
  else
    self.damTimer:Start()
  end
end

function bs_17019:OnAfterMove()
  if self.damTimer ~= nil then
    self.damTimer:Pause()
    self.damTimer.left = 0
  end
end

function bs_17019:CallBack()
  if LuaSkillCtrl:CallRange(1, 1000) < self.arglist[1] then
    local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    LuaSkillCtrl:CallHurtPool(self, self.typenum, grid.x, grid.y)
  end
end

function bs_17019:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_17019
