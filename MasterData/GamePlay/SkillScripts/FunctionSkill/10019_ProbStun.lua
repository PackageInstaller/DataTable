local bs_10019 = class("bs_10019", LuaSkillBase)
local base = LuaSkillBase
bs_10019.config = {buffId = 66, buffTier = 1}

function bs_10019:ctor()
end

function bs_10019:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10019_3", 1, self.OnAfterHurt, self.caster)
end

function bs_10019:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] and not isTriggerSet then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.config.buffTier, self.arglist[2])
  end
end

function bs_10019:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10019
