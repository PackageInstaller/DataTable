local bs_30004 = class("bs_30004", LuaSkillBase)
local base = LuaSkillBase
bs_30004.config = {
  heal_config = {baseheal_formula = 10139}
}

function bs_30004:ctor()
end

function bs_30004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30004_1", 1, self.OnAfterBattleStart)
end

function bs_30004:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.Callback, self, -1)
end

function bs_30004:Callback()
  local sheild = LuaSkillCtrl:GetShield(self.caster, eShieldType.Normal) + LuaSkillCtrl:GetShield(self.caster, eShieldType.LongRange) + LuaSkillCtrl:GetShield(self.caster, eShieldType.NoRange)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {sheild}, false, true)
  skillResult:EndResult()
end

function bs_30004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30004
