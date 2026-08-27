local bs_15209 = class("bs_15209", LuaSkillBase)
local base = LuaSkillBase
bs_15209.config = {buffId = 195, hurtConfig = 3}

function bs_15209:ctor()
end

function bs_15209:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_15209_2", 1, self.OnAfterPlaySkill)
  self:AddAfterHurtTrigger("bs_15209_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
  self.flag = false
end

function bs_15209:OnAfterPlaySkill(skill, role)
  if role == self.caster and not skill.isCommonAttack and not self.flag then
    self.flag = true
  end
end

function bs_15209:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and not isTriggerSet and skill.isCommonAttack and self.flag then
    self.flag = false
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.arglist[1], 75)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
      self.arglist[2]
    }, true)
    skillResult:EndResult()
  end
end

function bs_15209:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15209
