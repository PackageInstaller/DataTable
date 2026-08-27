local bs_10061 = class("bs_10061", LuaSkillBase)
local base = LuaSkillBase
bs_10061.config = {
  realDamageConfig = {basehurt_formula = 10034},
  effectId = 10163
}

function bs_10061:ctor()
end

function bs_10061:InitSkill(isMidwaySkill)
  self:AddSetHurtTrigger("bs_10061_1", 1, self.OnSetHurt, self.caster)
end

function bs_10061:OnSetHurt(context)
  if context.sender == self.caster and not context.isMiss and not context.isTriggerSet then
    LuaSkillCtrl:CallEffect(context.target, self.config.effectId, self, self.SkillEventFunc)
  end
end

function bs_10061:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallRealDamage(self, target, nil, self.config.realDamageConfig, nil, true)
  end
end

function bs_10061:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10061
