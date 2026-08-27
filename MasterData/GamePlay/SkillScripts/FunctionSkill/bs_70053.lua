local bs_70053 = class("bs_70053", LuaSkillBase)
local base = LuaSkillBase
bs_70053.config = {
  timeDuration = 15,
  totalTime = 1350,
  bufff_special = 1051012
}

function bs_70053:ctor()
end

function bs_70053:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_70053", 1, self.OnAfterBattleStart)
  local pf = LuaSkillCtrl:GetPlayerRoleEntity()
  if pf.recordTable.bs_70053 ~= nil and pf.recordTable.bs_70053 == true then
    return
  else
    pf.recordTable.bs_70053 = true
  end
  self.timeValue = self.arglist[1]
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, self.config.timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], timeCallBack)
  LuaSkillCtrl:SetGameScoreAcitve(1, true)
  LuaSkillCtrl:SetGameScoreValue(1, 0)
  self.totalDamage = 0
  self.damageCb = BindCallback(self, self.OnDamageValueChangeCb)
  MsgCenter:AddListener(eMsgEventId.OnDamageValueChange, self.damageCb)
  self:AddLuaTrigger(eSkillLuaTrigger.OnBeforeCallSummoner, self.OnBeforeCallSummoner)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_70053_2", 10, self.OnRoleDie)
end

function bs_70053:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, 1283, 1)
end

function bs_70053:OnDamageValueChangeCb(totalDamage)
  self.totalDamage = totalDamage
end

function bs_70053:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = math.max(0, self.timeValue // 15)
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
  LuaSkillCtrl:SetGameScoreValue(1, self.totalDamage)
end

function bs_70053:OnRoleDie(killer, role)
  local rolesList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if rolesList ~= nil and rolesList.Count < 1 then
    LuaSkillCtrl:BattleFailButContionueEP()
  end
end

function bs_70053:TimeUp()
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_70053:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_70053:OnBeforeCallSummoner(summoner)
  if summoner.maxHp <= 0 then
    summoner:SetAttr(eHeroAttr.maxHp, 1)
  end
end

function bs_70053:LuaDispose()
  base.LuaDispose(base)
  MsgCenter:RemoveListener(eMsgEventId.OnDamageValueChange, self.damageCb)
  self.damageCb = nil
end

return bs_70053
