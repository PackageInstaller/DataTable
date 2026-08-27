local bs_10286 = class("bs_10286", LuaSkillBase)
local base = LuaSkillBase
bs_10286.config = {buffId = 1194, buffTier = 1}

function bs_10286:ctor()
end

function bs_10286:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10286_3", 1, self.OnAfterHurt, nil, self.caster)
  self:AddAfterHealTrigger("bs_10286_5", 1, self.OnAfterHeal, nil, self.caster)
end

function bs_10286:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and self.caster.hp < self.caster.maxHp * self.arglist[1] // 1000 and 1 > self.caster:GetBuffTier(self.config.buffId) then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  end
end

function bs_10286:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if target == self.caster and target.hp > target.maxHp * self.arglist[1] // 1000 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_10286:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10286
