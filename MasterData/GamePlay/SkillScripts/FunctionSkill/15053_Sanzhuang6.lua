local bs_15053 = class("bs_15053", LuaSkillBase)
local base = LuaSkillBase
bs_15053.config = {buffId = 1244}

function bs_15053:ctor()
end

function bs_15053:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15053_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_15053_3", 1, self.OnAfterHurt, nil, self.caster)
  self:AddAfterHealTrigger("bs_15053_5", 1, self.OnAfterHeal, nil, self.caster)
end

function bs_15053:OnAfterBattleStart()
  if self.caster.hp == self.caster.maxHp then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  else
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_15053:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self.caster.hp == self.caster.maxHp then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  else
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_15053:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if self.caster.hp == self.caster.maxHp then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  else
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_15053:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15053
