local bs_10042 = class("bs_10042", LuaSkillBase)
local base = LuaSkillBase
bs_10042.config = {buffId = 26, buffTier = 1}

function bs_10042:ctor()
end

function bs_10042:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10042_3", 1, self.OnAfterHurt, self.caster)
end

function bs_10042:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and skill.isCommonAttack and not isTriggerSet and LuaSkillCtrl:CallRange(1, 100) < self.arglist[1] then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.config.buffTier, self.arglist[2])
  end
end

function bs_10042:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10042
