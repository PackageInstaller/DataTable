local bs_4012 = class("bs_4012", LuaSkillBase)
local base = LuaSkillBase
bs_4012.config = {
  buffId = 84,
  buffDuration = 60,
  buffTier = 10
}

function bs_4012:ctor()
end

function bs_4012:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4012_3", 1, self.OnAfterHurt, self.caster)
end

function bs_4012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and isCrit then
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId, self.config.buffTier, self.config.buffDuration, true)
  end
end

function bs_4012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4012
