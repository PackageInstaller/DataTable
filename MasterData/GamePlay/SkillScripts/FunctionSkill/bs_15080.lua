local bs_15080 = class("bs_15080", LuaSkillBase)
local base = LuaSkillBase
bs_15080.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10187,
    crit_formula = 0
  }
}

function bs_15080:ctor()
end

function bs_15080:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15080_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_15080:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isMiss and not isTriggerSet then
    local sheidValue = LuaSkillCtrl:GetRoleAllShield(self.caster) * self.arglist[1] // 1000
    if sheidValue > self.caster.maxHp * self.arglist[2] // 1000 then
      sheidValue = self.caster.maxHp * self.arglist[2] // 1000
    end
    if 0 < sheidValue then
      self:PlayChipEffect()
      self:OnSkillTake()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {sheidValue}, true)
      skillResult:EndResult()
    end
  end
end

function bs_15080:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15080
