local bs_204810 = class("bs_204810", LuaSkillBase)
local base = LuaSkillBase
bs_204810.config = {
  middleMonsterId = {
    25,
    26,
    27,
    28
  },
  buffId = 1033,
  effectId = 10264,
  effectId1 = 10263,
  startAnimID = 1001,
  maxEnemyNum = 8,
  maxSummonNum = 10,
  buffId_196 = 196,
  buffId_1033 = 1033,
  skill_time = 18,
  maxHpPer = 100,
  powPer = 500,
  audioId1 = 300,
  monsterTime = 3,
  timeDuration = 15,
  totalTime = 30
}

function bs_204810:ctor()
end

function bs_204810:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_196, 1, nil, true)
  self.index = 1
  self.totalTime = self.config.totalTime * 15
  self.timeValue = self.totalTime
  if self.caster.roleDataId ~= 113 then
    LuaSkillCtrl:SetGameScoreAcitve(2, true)
    LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
    local arriveCallBack = BindCallback(self, self.OnArriveAction)
    LuaSkillCtrl:StartTimer(nil, self.config.timeDuration, arriveCallBack, self, -1)
    local timeCallBack = BindCallback(self, self.TimeUp)
    LuaSkillCtrl:StartTimer(nil, self.totalTime, timeCallBack)
  end
end

function bs_204810:PlaySkill(data)
  self:CallBack()
end

function bs_204810:CallBack()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList.Count < self.config.maxEnemyNum then
    self:CallCasterWait(self.config.skill_time)
    local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimID, 1, self.config.skill_time, moveAttackTrigger)
  end
  if self.caster.roleDataId == 113 then
    self:CallCasterWait(self.config.skill_time)
    local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimID, 1, self.config.skill_time, moveAttackTrigger)
  end
end

function bs_204810:OnMoveAttackTrigger()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
  if self.caster.roleDataId == 113 then
    if self.index > 4 then
      self.index = 1
    end
    for i = 1, self.config.monsterTime do
      if i == 1 then
        self:CallBack2(1, 1)
      elseif i == 2 then
        self:CallBack2(2, 2)
      elseif i == 3 then
        self:CallBack2(1, 3)
      end
    end
    LuaSkillCtrl:CallBuff(self, self.caster, 2048021, 1, 10, true)
    self.index = self.index + 1
  else
    for i = 1, self.config.monsterTime do
      local gridData = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
      if gridData == nil then
        return
      end
      LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
      self:CallBack1(gridData.x, gridData.y)
    end
  end
end

function bs_204810:CallBack1(x, y)
  local gridData = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  if gridData == nil then
    return
  end
  x = gridData.x
  y = gridData.y
  local target = LuaSkillCtrl:GetTargetWithGrid(gridData.x, gridData.y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  if self.index > 4 then
    self.index = 1
  end
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.middleMonsterId[self.index], x, y)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.maxHpPer // 1000)
  summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.intensity, self.caster.intensity * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
end

function bs_204810:CallBack2(x, y)
  local target = LuaSkillCtrl:GetTargetWithGrid(x, y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.middleMonsterId[self.index], x, y)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.maxHpPer // 2000)
  summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.intensity, self.caster.intensity * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
end

function bs_204810:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

function bs_204810:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = math.max(0, self.timeValue // 15)
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

function bs_204810:TimeUp()
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_204810:LuaDispose()
  base.LuaDispose(self)
  self.index = nil
  self.totalTime = nil
  self.timeValue = nil
end

return bs_204810
