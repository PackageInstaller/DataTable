local bs_70001 = class("bs_70001", LuaSkillBase)
local base = LuaSkillBase
bs_70001.config = {timeDuration = 15}

function bs_70001:ctor()
end

function bs_70001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.totalTime = self.arglist[1]
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, self.config.timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.totalTime, timeCallBack)
  self:AddAfterHealTrigger("bs_70001_5", 2, self.OnAfterHeal, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_70001_1", 1, self.OnAfterBattleStart)
  LuaSkillCtrl:RecordLimitTime(self.totalTime)
end

function bs_70001:OnAfterBattleStart()
  local damage = self.caster.maxHp - self.caster.maxHp // 5
  self.caster:SubHp(damage)
end

function bs_70001:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if target == self.caster and self.caster.hp == self.caster.maxHp then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetlist.Count < 1 then
      return
    end
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      LuaSkillCtrl:RemoveLife(99999, self, targetRole, true, nil, true, false, eHurtType.RealDmg)
      LuaSkillCtrl:SetFinalScoreValue(2, 1000)
      LuaSkillCtrl:ForceEndBattle(true)
    end
  end
end

function bs_70001:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

function bs_70001:TimeUp()
  LuaSkillCtrl:SetFinalScoreValue(2, 1000)
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_70001:OnCasterDie()
  base.OnCasterDie(self)
  local score = (self.totalTime - self.timeValue) * 1000 // self.totalTime
  LuaSkillCtrl:SetFinalScoreValue(2, score)
  LuaSkillCtrl:ForceEndBattle(true)
end

return bs_70001
