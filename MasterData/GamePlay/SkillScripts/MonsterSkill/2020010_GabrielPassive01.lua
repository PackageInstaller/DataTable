local bs_2000010 = require("GamePlay.SkillScripts.MonsterSkill.200001_Boss_mianyi")
local bs_2020010 = class("bs_2020010", bs_2000010)
local base = bs_2000010
bs_2020010.config = {timeDuration = 15}
bs_2020010.config = setmetatable(bs_2020010.config, {
  __index = base.config
})

function bs_2020010:ctor()
end

function bs_2020010:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["520_arg1"] = self.arglist[1]
  self.caster.recordTable["520_arg2"] = self.arglist[2]
  self.totalTime = 1800
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, self.config.timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.totalTime, timeCallBack)
  LuaSkillCtrl:RecordLimitTime(self.totalTime)
end

function bs_2020010:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

function bs_2020010:TimeUp()
  LuaSkillCtrl:ForceEndBattle(false)
end

function bs_2020010:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_2020010
