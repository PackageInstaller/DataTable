local bs_92004 = class("bs_92004", LuaSkillBase)
local base = LuaSkillBase
bs_92004.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10031,
    crit_formula = 0
  },
  effectId = 10254
}

function bs_92004:ctor()
end

function bs_92004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_92004_3", 1, self.OnAfterHurt, self.caster)
end

function bs_92004:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.isCommonAttack and not isTriggerSet then
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self, self.SkillEventFunc)
  end
end

function bs_92004:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_92004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92004
