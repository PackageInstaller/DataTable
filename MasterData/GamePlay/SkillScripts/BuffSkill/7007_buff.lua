local bs_7007 = class("bs_7007", LuaSkillBase)
local base = LuaSkillBase
bs_7007.config = {
  effectId = 10701,
  hurt_config = {basehurt_formula = 10034}
}

function bs_7007:ctor()
end

function bs_7007:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_7007_4", 1, self.OnAfterHurt)
end

function bs_7007:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.isCommonAttack and sender == self.caster and not isMiss and 0 < hurt then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 55, 10, target)
    if 0 < targetList.Count then
      local role = targetList[0].targetRole
      LuaSkillCtrl:CallEffect(role, self.config.effectId, self, nil, target)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      print(self.arglist[1])
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
      skillResult:EndResult()
    end
  end
end

function bs_7007:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_7007
