local bs_17016 = class("bs_17016", LuaSkillBase)
local base = LuaSkillBase
bs_17016.config = {}

function bs_17016:ctor()
end

function bs_17016:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.typenum = 2
  self.caster.recordTable["17016_arg"] = self.arglist[1]
  self:AddTrigger(eSkillTriggerType.OnSelfStartMove, "bs_17016_1", 1, self.OnStartMove)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_17016_2", 2, self.OnAfterMove)
end

function bs_17016:OnStartMove()
  if self.damTimer == nil then
    self.damTimer = LuaSkillCtrl:StartTimer(nil, 5, self.CallBack, self, -1, 5)
  else
    self.damTimer:Start()
  end
end

function bs_17016:OnAfterMove()
  if self.damTimer ~= nil then
    self.damTimer:Pause()
    self.damTimer.left = 0
  end
end

function bs_17016:CallBack()
  local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  LuaSkillCtrl:CallHurtPool(self, self.typenum, grid.x, grid.y)
end

function bs_17016:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_17016
