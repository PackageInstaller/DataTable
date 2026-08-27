local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_2108000 = class("bs_2108000", bs_1)
local base = bs_1
bs_2108000.config = {
  effectId_trail = 210801,
  action1 = 1001,
  action2 = 1001,
  effectId_action_1 = 210802,
  effectId_action_2 = 210802,
  timeDuration = 15
}
bs_2108000.config = setmetatable(bs_2108000.config, {
  __index = base.config
})

function bs_2108000:ctor()
end

function bs_2108000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_2108000_1", 1, self.OnAfterBattleStart)
  self.totalTime = 1800
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  LuaSkillCtrl:RecordLimitTime(self.totalTime)
end

function bs_2108000:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(nil, 15, BindCallback(self, self.CountDown), nil, 119, 15)
end

function bs_2108000:CountDown()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
  if self.timeValue <= 0 then
    LuaSkillCtrl:ForceEndBattle(false)
  end
end

function bs_2108000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_2108000
