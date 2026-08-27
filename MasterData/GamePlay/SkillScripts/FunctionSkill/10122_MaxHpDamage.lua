local bs_10122 = class("bs_10122", LuaSkillBase)
local base = LuaSkillBase
bs_10122.config = {
  hurt_config = {basehurt_formula = 10006},
  effectId = 1002
}

function bs_10122:ctor()
end

function bs_10122:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10122_1", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_10122:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss then
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(sender, self.config.effectId, self, self.SkillEventFunc)
  end
end

function bs_10122:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10122:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10122
