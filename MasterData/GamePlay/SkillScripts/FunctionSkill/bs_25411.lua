local bs_25411 = class("bs_25411", LuaSkillBase)
local base = LuaSkillBase
bs_25411.config = {buffId1 = 2168, buffId2 = 2158}

function bs_25411:ctor()
end

function bs_25411:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25411_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_25411_3", 1, self.OnAfterHurt, nil, self.caster)
  self:AddAfterHealTrigger("bs_25411_2", 1, self.OnAfterHeal, nil, self.caster)
end

function bs_25411:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
end

function bs_25411:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and self.caster.hp <= self.caster.maxHp * self.arglist[4] // 1000 and self.caster:GetBuffTier(self.config.buffId1) < 1 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1)
  end
end

function bs_25411:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if target == self.caster and self.caster.hp >= self.caster.maxHp * self.arglist[4] // 1000 and self.caster:GetBuffTier(self.config.buffId1) > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId1, 1)
  end
end

function bs_25411:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25411
