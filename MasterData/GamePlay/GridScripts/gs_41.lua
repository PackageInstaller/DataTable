local gs_41 = class("gs_41", LuaGridBase)
local base = LuaGridBase
gs_41.config = {
  middleMonsterId = 5,
  maxEnemyNum = 8,
  maxSummonNum = 10,
  maxHpPer = 700,
  powPer = 1000,
  effectId = 10264,
  summonTime = 90,
  buffId = 2100,
  maxNum = 2
}

function gs_41:ctor()
end

function gs_41:__OnGridSkillInit()
  base.__OnGridSkillInit(self)
  self:AddGridTrigger(eSkillTriggerType.RoleDie, "gs_41_1", 1, self.OnRoleDie)
end

function gs_41:OnGridBattleStart(role)
  self.summonorList = {}
  self.index = 0
end

function gs_41:OnRoleDie(killer, role)
  for i = 0, self.config.maxNum - 1 do
    if self.summonorList[i] ~= nil and self.summonorList[i] == role then
      self.summonorList[i] = nil
      self.index = self.index - 1
    end
  end
end

function gs_41:OnGridEnterRole(role)
  local taget = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
  LuaSkillCtrl:CallEffect(taget, 11012, self)
  local gridData = LuaSkillCtrl:FindEmptyGridWithoutEfcGridAroundRole(role)
  if gridData == nil then
    return
  end
  local arriveCallBack = BindCallback(self, self.OnArriveAction, role)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  self.timer = LuaSkillCtrl:StartTimer(nil, self.config.summonTime, arriveCallBack, self, -1)
  local arriveCallBack2 = BindCallback(self, self.OnArriveAction2, role)
  LuaSkillCtrl:StartTimer(nil, 1, arriveCallBack2, self)
end

function gs_41:OnGridExitRole(role)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function gs_41:OnGridRoleDead(role)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function gs_41:OnArriveAction(role)
  self:CallSummoner(role)
end

function gs_41:OnArriveAction2(role)
  self:CallSummoner(role)
end

function gs_41:CallSummoner(role)
  if self.index >= self.config.maxNum then
    return
  end
  if self.cskill == nil then
    return
  end
  local gridData = LuaSkillCtrl:FindEmptyGridAroundRole(role)
  if gridData == nil then
    return
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(gridData.x, gridData.y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.middleMonsterId, gridData.x, gridData.y, role.belongNum)
  summoner:SetAttr(eHeroAttr.maxHp, role.maxHp * self.config.maxHpPer // 1000)
  summoner:SetAttr(eHeroAttr.pow, role.pow * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.skill_intensity, role.skill_intensity * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.speed, role.speed)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  LuaSkillCtrl:CallBuff(self, summonerEntity, self.config.buffId, 1, nil, true)
  for i = 0, self.config.maxNum - 1 do
    if self.summonorList[i] == nil then
      self.summonorList[i] = summonerEntity
      break
    end
  end
  self.index = self.index + 1
end

function gs_41:OnGridBeCorvered(role)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  self:GridLoseEffect()
end

function gs_41:OnGridUncorver(role)
end

return gs_41
