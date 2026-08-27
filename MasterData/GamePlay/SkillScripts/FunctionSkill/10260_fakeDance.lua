local bs_10260 = class("bs_10260", LuaSkillBase)
local base = LuaSkillBase
bs_10260.config = {
  effectId1 = 10704,
  effectId2 = 10702,
  hurt_config = {basehurt_formula = 10034}
}

function bs_10260:ctor()
end

function bs_10260:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10260_1", 1, self.OnAfterHurt, self.caster)
end

function bs_10260:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if skill.isCommonAttack and sender == self.caster and not isMiss and 0 < hurt then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 55, 10, target)
    if 0 < targetList.Count then
      local role = targetList[0].targetRole
      LuaSkillCtrl:CallEffect(role, self.config.effectId1, self, nil, target)
      LuaSkillCtrl:CallEffect(role, self.config.effectId2, self, nil, target)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
      skillResult:EndResult()
    end
  end
end

function bs_10260:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10260
