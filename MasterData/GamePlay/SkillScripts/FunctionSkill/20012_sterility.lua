local bs_20012 = class("bs_20012", LuaSkillBase)
local base = LuaSkillBase
bs_20012.config = {}

function bs_20012:ctor()
end

function bs_20012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20012_1", 1, self.OnAfterBattleStart)
end

function bs_20012:OnAfterBattleStart()
  LuaSkillCtrl:CallLoseAllGridEffect()
end

function bs_20012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20012
