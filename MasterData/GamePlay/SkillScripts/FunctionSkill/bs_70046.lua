local bs_70046 = class("bs_70046", LuaSkillBase)
local base = LuaSkillBase
bs_70046.config = {timeDuration = 15}

function bs_70046:ctor()
end

function bs_70046:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.totalTime = self.arglist[1]
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, self.config.timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.totalTime, timeCallBack)
end

function bs_70046:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = math.max(0, self.timeValue // 15)
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

function bs_70046:TimeUp()
  LuaSkillCtrl:BattleFailButContionueEP()
end

function bs_70046:PlaySkill(data)
end

function bs_70046:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70046
