local bs_10009 = class("bs_10009", LuaSkillBase)
local base = LuaSkillBase
bs_10009.config = {
  hurt_config = {basehurt_formula = 10007},
  effectIdAttack = 1006
}

function bs_10009:ctor()
end

function bs_10009:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10009_3", 1, self.OnAfterHurt, self.caster)
end

function bs_10009:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and target:ContainFeature(eBuffFeatureType.Stun) and not isTriggerSet then
    self:PlayChipEffect()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    self:CallCasterLookAt(targetList)
    LuaSkillCtrl:CallEffect(targetList, self.config.effectIdAttack, self, self.SkillEventFunc)
  end
end

function bs_10009:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10009:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10009
