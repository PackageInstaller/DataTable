local bs_17504 = class("bs_17504", LuaSkillBase)
local base = LuaSkillBase
bs_17504.config = {HurtConfigId = 14}

function bs_17504:ctor()
end

function bs_17504:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17504", 1, self.OnAfterBattleStart)
end

function bs_17504:OnAfterBattleStart()
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.TimerCallBack, self, -1)
end

function bs_17504:TimerCallBack()
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, nil)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {
    self.arglist[2]
  }, false, false)
  skillResult:EndResult()
end

function bs_17504:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_17504:OnDispose()
  base.OnDispose(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_17504
