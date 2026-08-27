local bs_203201 = class("bs_203201", LuaSkillBase)
local base = LuaSkillBase
bs_203201.config = {
  effectlineId = 10587,
  effecthealId = 10588,
  heal_config = 6
}

function bs_203201:ctor()
end

function bs_203201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_203201_3", 1, self.OnAfterHurt, nil, nil, self.caster.belongNum)
end

function bs_203201:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender.camp == self.caster.camp and sender.belongNum == self.caster.belongNum and 0 < hurt and not skill.isCommonAttack then
    local heal = hurt * self.arglist[1] // 1000
    if heal <= 1 then
      heal = 1
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, sender)
    LuaSkillCtrl:HealResultWithConfig(self, skillResult, self.config.heal_config, {heal}, true, true)
    skillResult:EndResult()
    if sender ~= self.caster then
      LuaSkillCtrl:CallEffect(sender, self.config.effectlineId, self)
    end
    LuaSkillCtrl:CallEffect(sender, self.config.effecthealId, self)
  end
end

function bs_203201:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_203201
