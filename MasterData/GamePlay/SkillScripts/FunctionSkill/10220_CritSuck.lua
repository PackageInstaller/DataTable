local bs_10220 = class("bs_10220", LuaSkillBase)
local base = LuaSkillBase
bs_10220.config = {buffId_shixue = 257, buffTier = 1}

function bs_10220:ctor()
end

function bs_10220:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10220_3", 1, self.OnAfterHurt, nil, self.caster)
  self.triggerNum = 0
end

function bs_10220:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and 0 < hurt then
    self.triggerNum = self.triggerNum + 1
    if self.triggerNum >= self.arglist[1] then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_shixue, 1)
      self:PlayChipEffect()
      self:OnSkillTake()
      self.triggerNum = 0
    end
  end
end

function bs_10220:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10220
