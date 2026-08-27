local bs_6009 = class("bs_6009", LuaSkillBase)
local base = LuaSkillBase
bs_6009.config = {
  effectId = 10054,
  hurt_config = {
    hit_formula = 0,
    def_formula = 9996,
    basehurt_formula = 10028,
    minhurt_formula = 9994,
    crit_formula = 0,
    crithur_ratio = 0,
    correct_formula = 9989,
    hurt_type = -1
  }
}

function bs_6009:ctor()
end

function bs_6009:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_6009_3", 1, self.OnAfterHurt, self.caster)
  self.CritNum = 0
end

function bs_6009:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and isCrit == true and target ~= self.caster and skill.isCommonAttack then
    self.CritNum = self.CritNum + 1
    local num = self.CritNum
    if self.CritNum % self.arglist[1] == 0 then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
      skillResult:EndResult()
    end
  end
end

function bs_6009:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6009
