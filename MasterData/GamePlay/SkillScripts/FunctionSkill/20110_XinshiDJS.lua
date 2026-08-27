local bs_20110 = class("bs_20110", LuaSkillBase)
local base = LuaSkillBase
bs_20110.config = {timeDuration = 15, totalTime = 45}

function bs_20110:ctor()
end

function bs_20110:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.totalTime = self.config.totalTime * 15
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, self.config.timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.totalTime, timeCallBack)
end

function bs_20110:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = math.max(0, self.timeValue // 15)
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

function bs_20110:TimeUp()
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_20110:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20110
