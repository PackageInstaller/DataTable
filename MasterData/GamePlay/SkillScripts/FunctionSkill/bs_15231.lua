local bs_15231 = class("bs_15231", LuaSkillBase)
local base = LuaSkillBase
bs_15231.config = {buffId = 110121, buffId1 = 110122}

function bs_15231:ctor()
end

function bs_15231:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15231_1", 1, self.OnAfterBattleStart)
  self:AddSetHealTrigger("bs_15231_2", 1, self.OnSetHeal, self.caster)
end

function bs_15231:OnSetHeal(context)
  if context.sender == self.caster and (LuaSkillCtrl:GetShield(self.caster, eShieldType.Normal) > 0 or 0 < LuaSkillCtrl:GetShield(self.caster, eShieldType.LongRange) or 0 < LuaSkillCtrl:GetShield(self.caster, eShieldType.NoRange)) then
    local shield = LuaSkillCtrl:GetShield(self.caster, eShieldType.Normal)
    if 0 < shield then
      local shieldTime = shield * 1000 // self.caster.maxHp // self.arglist[2]
      context.heal = context.heal + context.heal * self.arglist[3] * shieldTime // 1000
    end
  end
end

function bs_15231:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil)
end

function bs_15231:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15231
