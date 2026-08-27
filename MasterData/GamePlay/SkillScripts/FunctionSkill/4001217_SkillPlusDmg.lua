local bs_4001217 = class("bs_4001217", LuaSkillBase)
local base = LuaSkillBase
bs_4001217.config = {
  real_Config = {
    hit_formula = 0,
    basehurt_formula = 502,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0,
    hurt_type = 2
  }
}

function bs_4001217:ctor()
end

function bs_4001217:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4001217_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.normalSkill)
  self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_4001217_1", 1, self.OnBeforePlaySkill)
  self.attackTable = {}
end

function bs_4001217:OnBeforePlaySkill(role, context)
  if role == self.caster and context.skill.skillTag == eSkillTag.normalSkill then
    self.attackTable = {}
  end
end

function bs_4001217:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and self.caster ~= target and not isMiss and skill.skillTag == eSkillTag.normalSkill then
    if self.attackTable[target] ~= nil then
      return
    end
    self.attackTable[target] = true
    local damage = self.caster.maxHp * self.arglist[1] // 1000
    LuaSkillCtrl:CallRealDamage(self, target, nil, self.config.real_Config, {damage}, nil, true)
  end
end

function bs_4001217:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001217
