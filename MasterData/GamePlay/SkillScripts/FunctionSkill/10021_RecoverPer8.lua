local bs_10021 = class("bs_10021", LuaSkillBase)
local base = LuaSkillBase
bs_10021.config = {
  baseheal_formula = 10006,
  correct_formula = 9990,
  heal_number = 0,
  effectId = 1008
}

function bs_10021:ctor()
end

function bs_10021:InitSkill(isMidwaySkill)
  self.heal_config = {}
end

function bs_10021:PlaySkill()
  self:PlayChipEffect()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, self.SkillBack)
end

function bs_10021:SkillBack(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    self.heal_config.baseheal_formula = self.config.baseheal_formula
    self.heal_config.correct_formula = self.config.correct_formula
    self.heal_config.heal_number = self.config.heal_number
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.heal_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10021:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10021
