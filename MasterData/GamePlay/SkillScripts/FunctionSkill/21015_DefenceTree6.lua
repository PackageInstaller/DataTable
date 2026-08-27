local bs_21015 = class("bs_21015", LuaSkillBase)
local base = LuaSkillBase
bs_21015.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3012,
    crit_formula = 0
  }
}

function bs_21015:ctor()
end

function bs_21015:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_21015_1", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_21015:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isMiss then
    LuaSkillCtrl:CallBuff(self, self.caster, 1130, 1, nil)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_21015:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21015
