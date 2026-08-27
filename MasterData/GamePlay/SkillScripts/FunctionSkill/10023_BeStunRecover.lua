local bs_10023 = class("bs_10023", LuaSkillBase)
local base = LuaSkillBase
bs_10023.config = {
  effectId = 1008,
  baseheal_formula = 10006,
  correct_formula = 9990,
  heal_number = 0
}

function bs_10023:ctor()
end

function bs_10023:InitSkill(isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_10023_7", 1, self.OnAfterAddBuff, nil, self.caster)
  self.heal_config = {}
end

function bs_10023:OnAfterAddBuff(buff, target)
  if target == self.caster and buff:ContainFeature(eBuffFeatureType.Stun) then
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, self.SkillBack)
  end
end

function bs_10023:SkillBack(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    self.heal_config.baseheal_formula = self.config.baseheal_formula
    self.heal_config.correct_formula = self.config.correct_formula
    self.heal_config.heal_number = self.config.heal_number
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.heal_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10023:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10023
