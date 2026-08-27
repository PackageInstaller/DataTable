local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_2092000 = class("bs_2092000", bs_1)
local base = bs_1
bs_2092000.config = {effectId_trail = 209201, timeDuration = 15}
bs_2092000.config = setmetatable(bs_2092000.config, {
  __index = base.config
})

function bs_2092000:ctor()
end

function bs_2092000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_2092000_1", 1, self.OnAfterBattleStart)
  self.totalTime = 1800
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  LuaSkillCtrl:RecordLimitTime(self.totalTime)
end

function bs_2092000:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(nil, 15, BindCallback(self, self.CountDown), nil, 119, 15)
end

function bs_2092000:CountDown()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
  if self.timeValue <= 0 then
    LuaSkillCtrl:ForceEndBattle(false)
  end
end

function bs_2092000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_2092000
