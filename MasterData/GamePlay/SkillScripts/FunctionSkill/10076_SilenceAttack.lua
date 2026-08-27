local bs_10076 = class("bs_10076", LuaSkillBase)
local base = LuaSkillBase
bs_10076.config = {buffId = 26, buffTier = 1}

function bs_10076:ctor()
end

function bs_10076:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10076_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
end

function bs_10076:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and skill.isCommonAttack and not isTriggerSet and LuaSkillCtrl:CallRange(1, 100) <= self.arglist[1] then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.config.buffTier, self.arglist[2])
  end
end

function bs_10076:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10076
