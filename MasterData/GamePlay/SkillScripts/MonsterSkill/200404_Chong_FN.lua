local bs_200404 = class("bs_200404", LuaSkillBase)
local base = LuaSkillBase
bs_200404.config = {buffId_1005 = 1005, timeDuration = 15}

function bs_200404:ctor()
end

function bs_200404:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_200404_10", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_200404_1", 1, self.OnAfterBattleStart)
end

function bs_200404:OnRoleDie(killer, role)
  if killer == self.caster and role.belongNum == 1 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1005, self.arglist[1], nil, true)
  end
end

function bs_200404:OnAfterBattleStart()
  self.timeValue = 450
  self.totalTime = 450
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, self.config.timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.totalTime, timeCallBack)
end

function bs_200404:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

function bs_200404:TimeUp()
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_200404:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:ForceEndBattle(true)
end

return bs_200404
