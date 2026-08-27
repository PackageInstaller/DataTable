local bs_15061 = class("bs_15061", LuaSkillBase)
local base = LuaSkillBase
bs_15061.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10187,
    crit_formula = 0
  }
}

function bs_15061:ctor()
end

function bs_15061:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15061_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_15061:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isMiss and not isTriggerSet then
    local sheidValue = LuaSkillCtrl:GetRoleAllShield(self.caster) * self.arglist[1] // 1000
    if 0 < sheidValue then
      self:PlayChipEffect()
      self:OnSkillTake()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {sheidValue}, true)
      skillResult:EndResult()
    end
  end
end

function bs_15061:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15061
