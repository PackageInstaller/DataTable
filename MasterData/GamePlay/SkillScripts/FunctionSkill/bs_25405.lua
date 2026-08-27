local bs_25405 = class("bs_25405", LuaSkillBase)
local base = LuaSkillBase
bs_25405.config = {buffId1 = 2159, buffId2 = 2158}

function bs_25405:ctor()
end

function bs_25405:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25405_1", 1, self.OnAfterBattleStart)
end

function bs_25405:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
  local heal_Num = self.caster.maxHp * self.arglist[1] // 1000
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {heal_Num}, true, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
end

function bs_25405:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25405
