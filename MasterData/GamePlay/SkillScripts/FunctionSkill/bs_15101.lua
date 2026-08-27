local bs_15101 = class("bs_15101", LuaSkillBase)
local base = LuaSkillBase
bs_15101.config = {}

function bs_15101:ctor()
end

function bs_15101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15101_1", 1, self.OnAfterBattleStart)
end

function bs_15101:OnAfterBattleStart()
  LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost * self.arglist[1] // 1000)
end

function bs_15101:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15101
