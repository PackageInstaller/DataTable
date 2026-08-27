local bs_21032 = class("bs_21032", LuaSkillBase)
local base = LuaSkillBase
bs_21032.config = {
  heal_config = {baseheal_formula = 501}
}

function bs_21032:ctor()
end

function bs_21032:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_21032_1", 1, self.OnAfterHurt, self.caster)
end

function bs_21032:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and 0 < hurt and not isTriggerSet then
    local value = hurt * self.arglist[1] // 1000
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 14, 10)
    if 0 < targetList.Count then
      local targetRole = targetList[0].targetRole
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
      LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {value}, true)
      skillResult:EndResult()
    end
  end
end

function bs_21032:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21032
