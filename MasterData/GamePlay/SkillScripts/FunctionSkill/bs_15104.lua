local bs_15104 = class("bs_15104", LuaSkillBase)
local base = LuaSkillBase
bs_15104.config = {}

function bs_15104:ctor()
end

function bs_15104:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15104_1", 1, self.OnAfterBattleStart)
end

function bs_15104:OnAfterBattleStart()
  local heal = self.caster.maxHp * self.arglist[1] // 1000
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {heal}, true, true)
  skillResult:EndResult()
end

function bs_15104:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15104
