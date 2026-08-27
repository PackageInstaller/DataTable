local bs_104704 = class("bs_104704", LuaSkillBase)
local base = LuaSkillBase
bs_104704.config = {
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    crithur_ratio = 0
  }
}

function bs_104704:ctor()
end

function bs_104704:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("104704_14", 90, self.OnSetHurt)
end

function bs_104704:OnSetHurt(context)
  if context.sender == self.caster and not context.isTriggerSet and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey and context.skill.isCommonAttack then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
    local prob = self.caster.recordTable.buffNum
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {prob}, true)
    skillResult:EndResult()
  end
end

function bs_104704:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104704
