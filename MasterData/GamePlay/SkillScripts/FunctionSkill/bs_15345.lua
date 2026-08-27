local bs_15345 = class("bs_15345", LuaSkillBase)
local base = LuaSkillBase
bs_15345.config = {buffWKId = 1248}

function bs_15345:ctor()
end

function bs_15345:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15345_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
end

function bs_15345:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and skill.isCommonAttack and not isTriggerSet and sender:GetBuffTier(self.config.buffWKId) > 0 then
    local damage = sender:GetBuffTier(self.config.buffWKId) * self.arglist[1]
    local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult1, 3, {damage}, true, true)
    skillResult1:EndResult()
  end
end

function bs_15345:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15345
