local bs_25058 = class("bs_25058", LuaSkillBase)
local base = LuaSkillBase
bs_25058.config = {hurtConfig = 3, buffId = 1059}

function bs_25058:ctor()
end

function bs_25058:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_25058_3", 1, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_25058:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and isMiss and not isTriggerSet then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, sender)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
      self.arglist[1]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId, self.arglist[2], self.arglist[3])
  end
end

function bs_25058:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25058
