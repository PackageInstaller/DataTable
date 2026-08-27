local card_20018 = class("card_20018", LuaSkillBase)
local base = LuaSkillBase
card_20018.config = {timeDuration = 15}

function card_20018:ctor()
end

function card_20018:InitSkill(isMidwaySkill)
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

function card_20018:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = math.max(0, self.timeValue // 15)
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

function card_20018:TimeUp()
  LuaSkillCtrl:ForceEndBattle(false)
end

function card_20018:PlaySkill(data)
end

function card_20018:OnCasterDie()
  base.OnCasterDie(self)
end

return card_20018
