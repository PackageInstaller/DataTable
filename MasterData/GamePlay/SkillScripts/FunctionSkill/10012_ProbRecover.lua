local bs_10012 = class("bs_10012", LuaSkillBase)
local base = LuaSkillBase
bs_10012.config = {
  heal_config = {
    baseheal_formula = 10006,
    correct_formula = 9990,
    heal_number = 0
  },
  effectId = 1008
}

function bs_10012:ctor()
end

function bs_10012:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10012_3", 1, self.OnAfterHurt, self.caster)
  self.heal_config = {}
end

function bs_10012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] and not isTriggerSet then
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, self.SkillBack)
  end
end

function bs_10012:SkillBack(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10012
