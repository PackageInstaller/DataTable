local bs_7002 = class("bs_7002", LuaSkillBase)
local base = LuaSkillBase
bs_7002.config = {
  effectId = 10818,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10007,
    crit_formula = 0
  }
}

function bs_7002:ctor()
end

function bs_7002:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_7002_3", 1, self.OnAfterHurt, self.caster)
end

function bs_7002:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.isCommonAttack and sender == self.caster and not isMiss and 0 < hurt and not isTriggerSet then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 55, 10, target)
    if 0 < targetList.Count then
      local role = targetList[0].targetRole
      LuaSkillCtrl:CallEffect(role, self.config.effectId, self, nil, target)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
      skillResult:EndResult()
    end
  end
end

function bs_7002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_7002
