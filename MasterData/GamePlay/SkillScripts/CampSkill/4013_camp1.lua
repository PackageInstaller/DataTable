local bs_4013 = class("bs_4013", LuaSkillBase)
local base = LuaSkillBase
bs_4013.config = {
  buffId = 84,
  buffDuration = 60,
  buffTier = 20
}

function bs_4013:ctor()
end

function bs_4013:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4013_3", 1, self.OnAfterHurt, self.caster)
end

function bs_4013:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and isCrit then
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId, self.config.buffTier, self.config.buffDuration, true)
  end
end

function bs_4013:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4013
