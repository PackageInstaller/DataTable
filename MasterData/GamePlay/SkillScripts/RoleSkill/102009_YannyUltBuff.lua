local bs_102009 = class("bs_102009", LuaSkillBase)
local base = LuaSkillBase
bs_102009.config = {buffId = 102003}

function bs_102009:ctor()
end

function bs_102009:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_102009_3", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_102009:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and self.caster:GetBuffTier(self.config.buffId) > 0 and not isMiss and 0 < hurt and LuaSkillCtrl:CallRange(1, 1000) <= self.caster.recordTable["102009_UltBuff"] then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_102009:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102009
