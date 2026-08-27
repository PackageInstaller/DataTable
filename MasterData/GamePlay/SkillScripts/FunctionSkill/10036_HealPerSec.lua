local bs_10036 = class("bs_10036", LuaSkillBase)
local base = LuaSkillBase
bs_10036.config = {
  healDelay = 30,
  startTime = 30,
  healEffectId = 10092,
  healFormula = 10006
}

function bs_10036:ctor()
end

function bs_10036:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10036_1", 1, self.OnAfterBattleStart)
end

function bs_10036:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(self, self.config.healDelay, self.CallBack, self, -1, self.config.healDelay)
end

function bs_10036:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  local healNum = math.max(LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.healFormula, self.caster, self.caster, self), 1)
  LuaSkillCtrl:CallHeal(healNum, self, self.caster, nil, true)
  LuaSkillCtrl:CallEffect(self.caster, self.config.healEffectId, self)
end

function bs_10036:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_10036
