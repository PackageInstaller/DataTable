local bs_10154 = class("bs_10154", LuaSkillBase)
local base = LuaSkillBase
bs_10154.config = {buffId = 1069}

function bs_10154:ctor()
end

function bs_10154:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHealTrigger("bs_10152_5", 1, self.OnAfterHeal, self.caster)
end

function bs_10154:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if sender == self.caster and not isTriggerSet then
    local time = self.arglist[4]
    local pre_tier = target:GetBuffTier(self.config.buffId)
    local self_tier = self.caster:GetBuffTier(self.config.buffId)
    local tier = 1
    if pre_tier < self.arglist[3] then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, tier, time, true)
    elseif pre_tier > self.arglist[3] then
      LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0)
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.arglist[3], time, true)
    end
    if self_tier < self.arglist[3] then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, tier, time, true)
    elseif self_tier > self.arglist[3] then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[3], time, true)
    end
  end
end

function bs_10154:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10154
