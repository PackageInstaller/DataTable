local bs_15212 = class("bs_15212", LuaSkillBase)
local base = LuaSkillBase
bs_15212.config = {buffId = 110110}

function bs_15212:ctor()
end

function bs_15212:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15212_3", 1, self.OnAfterHurt, self.caster)
end

function bs_15212:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and not isTriggerSet and isCrit and self.caster:GetBuffTier(self.config.buffId) < self.arglist[2] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_15212:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15212
