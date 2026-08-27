local bs_10014 = class("bs_10014", LuaSkillBase)
local base = LuaSkillBase
bs_10014.config = {
  heal_config = {
    baseheal_formula = 10037,
    heal_number = 0,
    correct_formula = 9990
  },
  effectId = 10092
}

function bs_10014:ctor()
end

function bs_10014:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10014_3", 1, self.OnAfterHurt, self.caster)
  self.heal_config = {}
end

function bs_10014:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and isCrit then
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {hurt}, true)
    skillResult:EndResult()
  end
end

function bs_10014:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10014
