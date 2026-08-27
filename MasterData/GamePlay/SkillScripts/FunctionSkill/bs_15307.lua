local bs_15307 = class("bs_15307", LuaSkillBase)
local base = LuaSkillBase
bs_15307.config = {buffId = 110126, buffId1 = 110127}

function bs_15307:ctor()
end

function bs_15307:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15304_2", 1, self.OnAfterHurt, self.caster)
  self:AddAfterAddBuffTrigger("bs_15304_3", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, self.config.buffId)
  self.hurt = 0
end

function bs_15307:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and 0 < hurt then
    self.hurt = self.hurt + hurt
  end
  local buffTier = self.hurt // self.arglist[1]
  local nowBuffTier = self.caster:GetBuffTier(self.config.buffId)
  if buffTier > nowBuffTier then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier - nowBuffTier, nil)
  end
end

function bs_15307:OnAfterAddBuff(buff, target)
  local buffTier = self.caster:GetBuffTier(self.config.buffId)
  local BigBuffTier = buffTier // self.arglist[3]
  if BigBuffTier > self.caster:GetBuffTier(self.config.buffId1) then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId1, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, BigBuffTier, nil)
  end
end

function bs_15307:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15307
