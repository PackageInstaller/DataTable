local bs_10067 = class("bs_10067", LuaSkillBase)
local base = LuaSkillBase
bs_10067.config = {
  healDelay = 30,
  startTime = 30,
  healEffectId = 10092,
  healFormula = 10006
}

function bs_10067:ctor()
end

function bs_10067:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10067_1", 1, self.OnAfterBattleStart)
end

function bs_10067:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(self, self.config.healDelay, self.CallBack, self, -1, self.config.healDelay)
end

function bs_10067:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  local healNum = math.max(LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.healFormula, self.caster, self.caster, self), 1)
  LuaSkillCtrl:CallHeal(healNum, self, self.caster, nil, true)
  LuaSkillCtrl:CallEffect(self.caster, self.config.healEffectId, self)
end

function bs_10067:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_10067
