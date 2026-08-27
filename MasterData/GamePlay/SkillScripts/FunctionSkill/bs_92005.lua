local bs_92005 = class("bs_92005", LuaSkillBase)
local base = LuaSkillBase
bs_92005.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10076,
    crit_formula = 0
  },
  effectId = 10953
}

function bs_92005:ctor()
end

function bs_92005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_92005_3", 1, self.OnAfterHurt, self.caster)
end

function bs_92005:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.isCommonAttack and not isTriggerSet then
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self, self.SkillEventFunc)
  end
end

function bs_92005:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster.recordTable.lastAttackRole)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_92005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92005
