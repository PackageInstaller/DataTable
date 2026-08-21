require("base_ins_r")
_class("PlayThrowMonsterAndDamageInstruction", BaseInstruction)
PlayThrowMonsterAndDamageInstruction = PlayThrowMonsterAndDamageInstruction

function PlayThrowMonsterAndDamageInstruction:Constructor(paramList)
  self._hitAnimName = paramList.hitAnim
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._dieEffectID = tonumber(paramList.dieEffectID)
  self._trajectoryDelayTime = tonumber(paramList.trajectoryDelayTime) or 0
  self._flyDelay = tonumber(paramList.flyDelay) or 0
  self._trajectoryID = tonumber(paramList.trajectoryID)
  self._startHeight = tonumber(paramList.startHeight)
  self._endHeight = tonumber(paramList.endHeight)
  self._flyTotalTime = tonumber(paramList.flyTotalTime) or 0
  self._eachFlyDelayTime = tonumber(paramList.eachFlyDelayTime) or 0
end

function PlayThrowMonsterAndDamageInstruction:GetCacheResource()
  local t = {}
  if self._hitEffectID and self._hitEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  if self._dieEffectID and 0 < self._dieEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._dieEffectID].ResPath,
      1
    })
  end
  if self._trapTrajectoryID and 0 < self._trapTrajectoryID then
    table.insert(t, {
      Cfg.cfg_effect[self._trapTrajectoryID].ResPath,
      1
    })
  end
  return t
end

function PlayThrowMonsterAndDamageInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local resultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local result = resultContainer:GetEffectResultByArray(SkillEffectType.ThrowMonsterAndDamage)
  if not result then
    return
  end
  local damageResult = result:GetDamageResult()
  if not damageResult then
    return
  end
  local damagePos = damageResult:GetGridPos()
  local targetEntityID = damageResult:GetTargetID()
  local targetEntity = world:GetEntityByID(targetEntityID)
  local targetPos = Vector2.New(damagePos.x, damagePos.y)
  local boardServiceRender = world:GetService("BoardRender")
  targetPos = boardServiceRender:GridPos2RenderPos(Vector2.New(targetPos.x + 0.5, targetPos.y + 0.5))
  targetPos.y = targetPos.y + self._endHeight
  local effectService = world:GetService("Effect")
  local msrSvc = world:GetService("MonsterShowRender")
  local monsterIDArray = result:GetMonsterEntityIDs()
  for _, entityID in ipairs(monsterIDArray) do
    local entity = world:GetEntityByID(entityID)
    local hpComponent = entity:HP()
    if hpComponent then
      local sliderEntityId = hpComponent:GetHPSliderEntityID()
      local sliderEntity = world:GetEntityByID(sliderEntityId)
      if sliderEntity then
        sliderEntity:SetViewVisible(false)
      end
    end
  end
  local trapTaskIDs = {}
  for _, entityID in ipairs(monsterIDArray) do
    local monsterEntity = world:GetEntityByID(entityID)
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      msrSvc:PlayOneMonsterSpDead(TT, monsterEntity)
    end)
    local entityPos = boardServiceRender:GetRealEntityGridPos(monsterEntity)
    local effectDir = damagePos - entityPos
    local beginPos = boardServiceRender:GridPos2RenderPos(entityPos)
    local deadEffectEntity = effectService:CreatePositionEffect(self._dieEffectID, beginPos)
    if deadEffectEntity then
      deadEffectEntity:SetDirection(effectDir)
    end
    monsterEntity:SetViewVisible(false)
    YIELD(TT, self._trajectoryDelayTime)
    beginPos.y = beginPos.y + self._startHeight
    local effectEntity = effectService:CreatePositionEffect(self._trajectoryID, beginPos)
    if effectEntity then
      effectEntity:SetDirection(effectDir)
    end
    local trajectoryInfo = {
      startHeight = self._startHeight,
      endHeight = self._endHeight,
      totalTime = self._flyTotalTime * 0.001,
      totalTimeMs = self._flyTotalTime,
      targetRenderPos = targetPos,
      currentTime = 0,
      trajectoryID = self._trajectoryID,
      trajectoryEntity = effectEntity,
      hitEntity = targetEntity
    }
    table.insert(trapTaskIDs, GameGlobal.TaskManager():CoreGameStartTask(self._DoFly, self, trajectoryInfo))
    YIELD(TT, self._eachFlyDelayTime)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(trapTaskIDs) do
    YIELD(TT)
  end
  YIELD(TT)
  local hitAnimName = self._hitAnimName
  local hitFxID = self._hitEffectID
  local playSkillSvc = world:GetService("PlaySkill")
  local skillID = resultContainer:GetSkillID()
  local damageInfoArray = damageResult:GetDamageInfoArray()
  for __, damageInfo in ipairs(damageInfoArray) do
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitFxID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damagePos):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(false):SetHandleBeHitParam_SkillID(skillID):SetHandleBeHitParam_PlayHitBack(false)
    playSkillSvc:HandleBeHit(TT, beHitParam)
  end
end

function PlayThrowMonsterAndDamageInstruction:_DoFly(TT, trajectoryInfo)
  local entity = trajectoryInfo.trajectoryEntity
  local effectViewCmpt = entity:View()
  local effectObject = effectViewCmpt:GetGameObject()
  local transWork = effectObject.transform
  local easeWork = transWork:DOMove(trajectoryInfo.targetRenderPos, trajectoryInfo.totalTime, false):SetEase(DG.Tweening.Ease.InOutSine)
  YIELD(TT, trajectoryInfo.totalTimeMs)
  local world = entity:GetOwnerWorld()
  world:DestroyEntity(entity)
  trajectoryInfo.hitEntity:SetAnimatorControllerTriggers({
    self._hitAnimName
  })
  local effectService = world:GetService("Effect")
  effectService:CreateEffect(self._hitEffectID, trajectoryInfo.hitEntity)
end
