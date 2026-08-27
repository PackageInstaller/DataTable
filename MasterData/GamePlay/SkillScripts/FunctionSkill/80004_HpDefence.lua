local bs_80004 = class("bs_80004", LuaSkillBase)
local base = LuaSkillBase
bs_80004.config = {
  real_Config = {
    hit_formula = 0,
    def_formula = 0,
    basehurt_formula = 502,
    minhurt_formula = 9994,
    crit_formula = 0,
    crithur_ratio = 0,
    correct_formula = 9989,
    lifesteal_formula = 1001,
    spell_lifesteal_formula = 1002,
    returndamage_formula = 1000,
    hurt_type = 2
  }
}

function bs_80004:ctor()
end

function bs_80004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_80004_3", 1, self.OnAfterHurt, self.caster)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_80004_12", 1, self.OnAfterPlaySkill)
  self.flag = false
end

function bs_80004:OnAfterPlaySkill(skill, role)
  if role == self.caster and not skill.isCommonAttack and not self.flag then
    self.flag = true
  end
end

function bs_80004:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and not isTriggerSet and skill.isCommonAttack and self.flag then
    self.flag = false
    local damage = self.caster.def * self.arglist[1] // 1000
    LuaSkillCtrl:CallRealDamage(self, target, nil, self.config.real_Config, {damage}, true)
  end
end

function bs_80004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_80004
