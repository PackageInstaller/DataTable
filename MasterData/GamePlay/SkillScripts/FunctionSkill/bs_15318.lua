local bs_15318 = class("bs_15318", LuaSkillBase)
local base = LuaSkillBase
bs_15318.config = {buffId = 1286}

function bs_15318:ctor()
end

function bs_15318:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_15318_1", 1, self.OnSetHurt, nil, self.caster)
  self:AddAfterHealTrigger("bs_15318_2", 1, self.OnAfterHeal, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15318_2", 1, self.OnAfterBattleStart)
end

function bs_15318:OnAfterBattleStart()
  if self.caster.hp * 1000 // self.caster.maxHp > self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil)
  else
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_15318:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if self.caster.hp * 1000 // self.caster.maxHp > self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil)
  else
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_15318:OnSetHurt(context)
  if self.caster.hp * 1000 // self.caster.maxHp > self.arglist[1] then
    context.isIgnoreShield = true
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil)
  else
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_15318:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15318
