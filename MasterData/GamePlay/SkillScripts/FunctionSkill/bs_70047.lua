local bs_70047 = class("bs_70047", LuaSkillBase)
local base = LuaSkillBase
bs_70047.config = {timeDuration = 15, totalTime = 900}

function bs_70047:ctor()
end

function bs_70047:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local pf = LuaSkillCtrl:GetPlayerRoleEntity()
  pf.recordTable.bs_70047 = true
  self.timeValue = self.config.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, self.config.timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.config.totalTime, timeCallBack)
  LuaSkillCtrl:SetGameScoreAcitve(1, true)
  LuaSkillCtrl:SetGameScoreValue(1, 0)
  self.totalDamage = 0
  self.damageCb = BindCallback(self, self.OnDamageValueChangeCb)
  MsgCenter:AddListener(eMsgEventId.OnDamageValueChange, self.damageCb)
end

function bs_70047:OnDamageValueChangeCb(totalDamage)
  self.totalDamage = totalDamage
end

function bs_70047:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = math.max(0, self.timeValue // 15)
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
  LuaSkillCtrl:SetGameScoreValue(1, self.totalDamage)
end

function bs_70047:TimeUp()
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_70047:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_70047:LuaDispose()
  base.LuaDispose(base)
  MsgCenter:RemoveListener(eMsgEventId.OnDamageValueChange, self.damageCb)
  self.damageCb = nil
end

return bs_70047
