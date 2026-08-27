local bs_10027 = class("bs_10027", LuaSkillBase)
local base = LuaSkillBase
bs_10027.config = {
  effectId = 1004,
  heal_config = {baseheal_formula = 501}
}

function bs_10027:ctor()
end

function bs_10027:InitSkill(isMidwaySkill)
  self:AddAfterHealTrigger("bs_10027_5", 1, self.OnAfterHeal, self.caster)
end

function bs_10027:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if sender == self.caster and target ~= self.caster and not isTriggerSet then
    local realHeal = heal * self.arglist[1] // 1000
    if 0 < realHeal then
      self:PlayChipEffect()
      LuaSkillCtrl:CallEffectWithArg(self.caster, self.config.effectId, self, true, false, self.SkillBack, realHeal)
    end
  end
end

function bs_10027:SkillBack(realHeal, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.aoe_config)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {realHeal}, true, true)
  end
end

function bs_10027:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10027
