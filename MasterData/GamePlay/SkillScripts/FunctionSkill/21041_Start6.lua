local bs_21041 = class("bs_21041", LuaSkillBase)
local base = LuaSkillBase
bs_21041.config = {
  heal_config = {
    baseheal_formula = 10037,
    heal_number = 0,
    correct_formula = 9990
  },
  effectId = 10092
}

function bs_21041:ctor()
end

function bs_21041:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_21041_3", 1, self.OnAfterHurt, self.caster)
end

function bs_21041:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and isCrit then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {hurt}, true)
    skillResult:EndResult()
  end
end

function bs_21041:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21041
