local bs_81003 = class("bs_81003", LuaSkillBase)
local base = LuaSkillBase
bs_81003.config = {}

function bs_81003:ctor()
end

function bs_81003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_81003_4", 1, self.OnAfterBattleStart)
end

function bs_81003:OnAfterBattleStart()
end

function bs_81003:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_81003
