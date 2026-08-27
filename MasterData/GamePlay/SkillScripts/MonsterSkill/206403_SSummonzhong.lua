local bs_206403 = class("bs_206403", LuaSkillBase)
local base = LuaSkillBase
bs_206403.config = {
  smallMonsterId = {
    20,
    22,
    23
  },
  middleMonsterId = {
    20,
    22,
    23
  },
  bigMonsterId = {
    20,
    22,
    23
  },
  maxHpPer = 250,
  powPer = 800,
  buffID_1158 = 1158,
  buffId = 1033,
  effectId = 10264,
  effectId1 = 10263,
  startAnimID = 1002,
  maxEnemyNum = 8,
  maxSummonNum = 10,
  buffId_196 = 196,
  buffId_1033 = 1033,
  skill_time = 18,
  audioId1 = 300,
  buffId = 32,
  totalTime = 30,
  timeDuration = 15
}

function bs_206403:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_206403_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_206403_2", 99, self.OnSetHurt, nil, self.caster)
  self.flag = true
  self.totalTime = self.config.totalTime * 15
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack3 = BindCallback(self, self.OnArriveAction3)
  LuaSkillCtrl:StartTimer(nil, self.config.timeDuration, arriveCallBack3, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.totalTime, timeCallBack)
end

function bs_206403:OnArriveAction3()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = math.max(0, self.timeValue // 15)
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

function bs_206403:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, -1, self.arglist[1])
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1033, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_196, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  self.caster.recordTable["206403_SummonTime"] = 0
  self.index = 1
end

function bs_206403:CallBack()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList.Count < self.config.maxEnemyNum then
    local gridData = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
    if gridData == nil then
      return
    end
    self:CallCasterWait(self.config.skill_time)
    local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger, gridData)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimID, 1, self.config.skill_time, moveAttackTrigger)
  end
end

function bs_206403:OnMoveAttackTrigger(gridData)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  local cback = BindCallback(self, self.CallBack1, gridData.x, gridData.y)
  self.damTimer2 = LuaSkillCtrl:StartTimer(nil, 2, cback, nil, 0, 0)
end

function bs_206403:CallBack1(x, y)
  if self.damTimer2 ~= nil and self.damTimer2:IsOver() then
    self.damTimer2 = nil
  end
  local gridData = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  if gridData == nil then
    return
  end
  x = gridData.x
  y = gridData.y
  local target = LuaSkillCtrl:GetTargetWithGrid(gridData.x, gridData.y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  if self.caster.recordTable["206403_SummonTime"] < self.config.maxSummonNum then
    if self.index > 3 then
      self.index = 1
    end
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.middleMonsterId[self.index], x, y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.maxHpPer // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.powPer // 1000)
    summoner:SetAttr(eHeroAttr.intensity, self.caster.intensity * self.config.powPer // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
    summoner:SetAsRealEntity(1)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    self.index = self.index + 1
  else
    if self.index > 3 then
      self.index = 1
    end
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.middleMonsterId[self.index], x, y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.maxHpPer // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.powPer // 1000)
    summoner:SetAttr(eHeroAttr.intensity, self.caster.intensity * self.config.powPer // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
    summoner:SetAsRealEntity(1)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    self.index = self.index + 1
  end
  local damage = self.caster.maxHp * self.arglist[2] // 1000
  if 1 < self.caster.hp then
    LuaSkillCtrl:RemoveLife(damage, self, self.caster)
    self.caster.recordTable["206403_SummonTime"] = self.caster.recordTable["206403_SummonTime"] + 1
  end
end

function bs_206403:TimeUp()
  if self.flag then
    if self.damTimer then
      self.damTimer:Stop()
      self.damTimer = nil
    end
    if self.damTimer2 then
      self.damTimer2:Stop()
      self.damTimer2 = nil
    end
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffID_1158, 1)
    self.flag = false
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    self:CallCasterWait(200)
    LuaSkillCtrl:CallRoleAction(self.caster, 1020)
    local arriveCallBack = BindCallback(self, self.OnArriveAction)
    LuaSkillCtrl:StartTimer(nil, 70, arriveCallBack)
    local arriveCallBack1 = BindCallback(self, self.OnArriveAction1)
    LuaSkillCtrl:StartTimer(nil, 50, arriveCallBack1)
  end
end

function bs_206403:OnSetHurt(context)
  if context.target == self.caster and context.hurt > self.caster.hp then
    context.hurt = 0
  end
end

function bs_206403:OnArriveAction1()
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(target, 10924, self)
end

function bs_206403:OnArriveAction()
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  LuaSkillCtrl:RemoveLife(self.caster.hp + 1, self, self.caster, true, nil, true, true)
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_206403:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  if self.damTimer2 then
    self.damTimer2:Stop()
    self.damTimer2 = nil
  end
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_206403:LuaDispose()
  base.LuaDispose(self)
  self.flag = nil
  self.damTimer2 = nil
  self.damTimer = nil
end

return bs_206403
