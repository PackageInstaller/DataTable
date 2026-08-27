local bs_10001 = class("bs_10001", LuaSkillBase)
local base = LuaSkillBase
bs_10001.config = {buffId = 69, attBuffId = 70}

function bs_10001:ctor()
end

function bs_10001:InitSkill(isMidwaySkill)
end

function bs_10001:PlaySkill()
  self:PlayChipEffect()
  self:AddAfterHurtTrigger("bs_10001_3", 1, self.OnAfterHurt, nil, self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.attBuffId, self.arglist[1])
end

function bs_10001:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and self.caster:GetBuffTier(self.config.buffId) > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.attBuffId, self.arglist[1], nil, true)
  end
end

function bs_10001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10001
