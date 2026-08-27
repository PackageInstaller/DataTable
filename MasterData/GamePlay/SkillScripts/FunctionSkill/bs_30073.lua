local bs_30073 = class("bs_30073", LuaSkillBase)
local base = LuaSkillBase
bs_30073.config = {}

function bs_30073:ctor()
end

function bs_30073:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30073_start", 300, self.OnAfterBattleStart)
end

function bs_30073:OnAfterBattleStart()
  self.caster.recordTable.bs_30073 = true
  self.caster.recordTable.bs_30073_time = self.arglist[1]
end

function bs_30073:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30073
