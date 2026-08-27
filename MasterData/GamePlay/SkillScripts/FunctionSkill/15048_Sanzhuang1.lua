local bs_15048 = class("bs_15048", LuaSkillBase)
local base = LuaSkillBase
bs_15048.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10187,
    crit_formula = 0
  }
}

function bs_15048:ctor()
end

function bs_15048:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15048_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_15048:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isMiss and not isTriggerSet then
    local damageValue = self.caster.maxHp * self.arglist[1] // 1000
    if 0 < damageValue then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {damageValue}, true)
      skillResult:EndResult()
    end
    self:PlayChipEffect()
    self:OnSkillTake()
  end
end

function bs_15048:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15048
