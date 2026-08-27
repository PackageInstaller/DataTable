local bs_15050 = class("bs_15050", LuaSkillBase)
local base = LuaSkillBase
bs_15050.config = {buffId = 1242, buffTier = 1}

function bs_15050:ctor()
end

function bs_15050:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHealTrigger("bs_15050_2", 1, self.OnAfterHeal, nil, self.caster)
end

function bs_15050:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if target == self.caster and not isTriggerSet then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  end
end

function bs_15050:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15050
