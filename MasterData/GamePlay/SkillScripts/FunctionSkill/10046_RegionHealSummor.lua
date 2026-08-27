local bs_10046 = class("bs_10046", LuaSkillBase)
local base = LuaSkillBase
bs_10046.config = {
  monsterEffectId = 103,
  effectId = 104,
  attackdelay = 15,
  buffId = 1007,
  buffTier = 1,
  buffDuration = 75,
  heal_config = {
    baseheal_formula = 10011,
    heal_number = 0,
    correct_formula = 9990
  }
}

function bs_10046:ctor()
end

function bs_10046:InitSkill(isMidwaySkill)
  self.damTimer = LuaSkillCtrl:StartTimer(self, self.config.attackdelay, self.CallBack, self, -1, self.config.attackdelay)
end

function bs_10046:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 0)
  for i = 0, targetlist.Count - 1 do
    LuaSkillCtrl:CallEffect(targetlist[i].targetRole, self.config.effectId, self, self.SkillEventFunc)
  end
end

function bs_10046:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config)
    skillResult:EndResult()
  end
end

function bs_10046:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_10046
