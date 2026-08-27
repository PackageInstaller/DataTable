local bs_10006 = class("bs_10006", LuaSkillBase)
local base = LuaSkillBase
bs_10006.config = {
  featureType = eBuffFeatureType.Stun,
  baseheal_formula = 10006,
  correct_formula = 9990,
  heal_number = 0,
  effectId = 1004
}

function bs_10006:ctor()
end

function bs_10006:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10006_1", 1, self.OnAfterHurt, self.caster)
  self.heal_config = {}
end

function bs_10006:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and target:ContainFeature(self.config.featureType) and not isTriggerSet then
    self:PlayChipEffect()
    if self.caster.hp <= 0 then
      return
    end
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self, self.SkillBack)
  end
end

function bs_10006:SkillBack(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    self.heal_config.baseheal_formula = self.config.baseheal_formula
    self.heal_config.correct_formula = self.config.correct_formula
    self.heal_config.heal_number = self.config.heal_number
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config)
    skillResult:EndResult()
  end
end

function bs_10006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10006
