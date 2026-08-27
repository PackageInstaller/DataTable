local bs_92040 = class("bs_92040", LuaSkillBase)
local base = LuaSkillBase
bs_92040.config = {
  heal_config = {baseheal_formula = 3022}
}

function bs_92040:ctor()
end

function bs_92040:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_92040_1", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_92040:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss then
    self:PlayChipEffect()
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
      self.arglist[1]
    }, true)
    skillResult:EndResult()
  end
end

function bs_92040:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92040
