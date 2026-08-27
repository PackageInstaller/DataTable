local bs_30046 = class("bs_30046", LuaSkillBase)
local base = LuaSkillBase
bs_30046.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10176,
    crit_formula = 0
  },
  effectId = 10929
}

function bs_30046:ctor()
end

function bs_30046:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_30046_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, nil, false)
end

function bs_30046:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isCrit and self:IsReadyToTake() and not isTriggerSet then
    self:OnSkillTake()
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self, self.SkillEventFunc)
  end
end

function bs_30046:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
    skillResult:EndResult()
  end
end

function bs_30046:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30046
