local card_10007 = class("card_10007", LuaSkillBase)
local base = LuaSkillBase
card_10007.config = {}

function card_10007:ctor()
end

function card_10007:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "card_10007_1", 1, self.OnAfterBattleStart)
end

function card_10007:OnAfterBattleStart()
  LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost * self.arglist[1] // 1000)
  local arriveCallBack = BindCallback(self, self.doFun)
  LuaSkillCtrl:StartTimer(nil, self.arglist[2], arriveCallBack, nil, -1)
end

function card_10007:doFun()
  LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost * self.arglist[3] // 1000)
end

function card_10007:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10007
