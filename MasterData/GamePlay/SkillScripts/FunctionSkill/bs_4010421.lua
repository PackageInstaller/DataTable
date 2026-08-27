local bs_4010421 = class("bs_4010421", LuaSkillBase)
local base = LuaSkillBase
bs_4010421.config = {
  hurtConfig = 3,
  buffId = 1227,
  duration = 90
}

function bs_4010421:ctor()
end

function bs_4010421:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4010421_3", 1, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
end

function bs_4010421:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and isMiss and not isTriggerSet then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, sender)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
      self.arglist[1]
    }, true)
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId, self.arglist[2], self.config.duration, true)
  end
end

function bs_4010421:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010421
