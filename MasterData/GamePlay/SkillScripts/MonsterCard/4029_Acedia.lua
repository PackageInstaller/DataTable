local bs_4029 = class("bs_4029", LuaSkillBase)
local base = LuaSkillBase
bs_4029.config = {
  buff_treatment = 40291,
  hurtConfig = {
    basehurt_formula = 3000,
    crit_formula = 9992,
    hit_formula = 0
  }
}

function bs_4029:ctor()
end

function bs_4029:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4029_01", 1, self.OnAfterHurt, self.caster, nil, nil, eBattleRoleBelong.enemy, nil, nil, nil, nil, false)
end

function bs_4029:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if skill.skillType == eBattleSkillLogicType.Original and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[4] then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig, {
      self.arglist[1]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_treatment, 1, self.arglist[5])
  end
end

function bs_4029:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4029
