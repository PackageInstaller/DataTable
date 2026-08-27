local bs_10338 = class("bs_10338", LuaSkillBase)
local base = LuaSkillBase
bs_10338.config = {buffId = 1242, buffTier = 1}

function bs_10338:ctor()
end

function bs_10338:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHealTrigger("bs_10338_2", 1, self.OnAfterHeal, nil, self.caster)
end

function bs_10338:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if target == self.caster and not isTriggerSet then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  end
end

function bs_10338:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10338
