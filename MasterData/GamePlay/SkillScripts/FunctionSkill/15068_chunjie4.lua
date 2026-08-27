local bs_15068 = class("bs_15068", LuaSkillBase)
local base = LuaSkillBase
bs_15068.config = {
  buffId = 1270,
  buffId2 = 1273,
  heal_config = {
    baseheal_formula = 501,
    heal_number = 0,
    correct_formula = 9990
  }
}

function bs_15068:ctor()
end

function bs_15068:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15068_1", 1, self.OnAfterBattleStart)
end

function bs_15068:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(nil, 150, self.CallBack, self, -1)
  local value = self.arglist[1] // 10
  local healNum = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, value, nil, true)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {healNum}, true, true)
  skillResult:EndResult()
end

function bs_15068:CallBack()
  local value2 = self.arglist[2] * self.caster.hp // 1000
  LuaSkillCtrl:RemoveLife(value2, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
end

function bs_15068:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15068
