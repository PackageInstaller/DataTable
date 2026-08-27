local bs_30040 = class("bs_30040", LuaSkillBase)
local base = LuaSkillBase
bs_30040.config = {
  heal_config = {baseheal_formula = 10140},
  effectId_start = 10802,
  effectId_line = 10804,
  effectId_end = 10803
}

function bs_30040:ctor()
end

function bs_30040:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_30040_3", 1, self.OnAfterHurt, self.caster)
end

function bs_30040:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and 0 < hurt then
    self:PlayChipEffect()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 14, 20)
    self.hurt = hurt
    if 0 < targetList.Count and targetList[0].targetRole ~= nil then
      LuaSkillCtrl:CallEffect(targetList[0].targetRole, self.config.effectId_line, self, self.SkillEventFunc, target)
    end
  end
end

function bs_30040:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
      self.hurt
    }, false, true)
    skillResult:EndResult()
  end
end

function bs_30040:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30040
