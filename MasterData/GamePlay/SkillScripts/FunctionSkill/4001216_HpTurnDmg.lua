local bs_4001216 = class("bs_4001216", LuaSkillBase)
local base = LuaSkillBase
bs_4001216.config = {
  real_Config = {
    hit_formula = 0,
    basehurt_formula = 502,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0,
    hurt_type = 2
  }
}

function bs_4001216:ctor()
end

function bs_4001216:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4001216_3", 1, self.OnAfterHurt, self.caster)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_4001216_12", 1, self.OnAfterPlaySkill)
  self.flag = false
end

function bs_4001216:OnAfterPlaySkill(skill, role)
  if role == self.caster and not skill.isCommonAttack and not self.flag then
    self.flag = true
  end
end

function bs_4001216:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and not isTriggerSet and skill.isCommonAttack and self.flag then
    self.flag = false
    local damage = self.caster.maxHp * self.arglist[1] // 1000
    if damage <= 0 then
      damage = 1
    end
    LuaSkillCtrl:CallRealDamage(self, target, nil, self.config.real_Config, {damage}, nil, true)
  end
end

function bs_4001216:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001216
