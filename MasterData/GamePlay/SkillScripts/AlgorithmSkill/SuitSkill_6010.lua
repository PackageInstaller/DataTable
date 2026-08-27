local bs_6010 = class("bs_6010", LuaSkillBase)
local base = LuaSkillBase
bs_6010.config = {
  heal_config = {
    baseheal_formula = 10026,
    heal_number = 0,
    correct_formula = 9990
  }
}

function bs_6010:ctor()
end

function bs_6010:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_6010_3", 1, self.OnAfterHurt, self.caster)
end

function bs_6010:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and target ~= self.caster and 0 < hurt then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {hurt}, true, true)
    skillResult:EndResult()
  end
end

function bs_6010:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6010
