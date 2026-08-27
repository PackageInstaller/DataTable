local bs_70007 = class("bs_70007", LuaSkillBase)
local base = LuaSkillBase
bs_70007.config = {timeDuration = 15}

function bs_70007:ctor()
end

function bs_70007:InitSkill(isMidwaySkill)
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

function bs_70007:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

function bs_70007:TimeUp()
  LuaSkillCtrl:ForceEndBattle(false)
end

function bs_70007:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70007
