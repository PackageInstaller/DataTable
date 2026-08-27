local bs_6007 = class("bs_6007", LuaSkillBase)
local base = LuaSkillBase
bs_6007.config = {buffId = 103}

function bs_6007:ctor()
end

function bs_6007:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_6007_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_6007_22", 1, self.OnBreakShield)
end

function bs_6007:OnAfterBattleStart()
  local Value = self.arglist[1] * self.caster.def // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, Value)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
end

function bs_6007:OnBreakShield(shieldType, sender, target)
  if target == self.caster and shieldType == 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
  end
end

function bs_6007:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6007
