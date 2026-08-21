require("base_ins_r")
_class("PlayAlphaThrowTrapInstruction", BaseInstruction)
PlayAlphaThrowTrapInstruction = PlayAlphaThrowTrapInstruction

function PlayAlphaThrowTrapInstruction:Constructor(paramList)
  self._hitAnimName = paramList.hitAnim
  self._hitDelayTime = tonumber(paramList.hitDelayTime) or 0
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._eachDamageTime = tonumber(paramList.eachDamageTime) or 0
  self._delTrapDelay = tonumber(paramList.delTrapDelay) or 0
  self._trapStartDelay = tonumber(paramList.trapStartDelay) or 0
  self._trapTrajectoryID = tonumber(paramList.trapTrajectoryID)
  self._trapStartHeight = tonumber(paramList.trapStartHeight)
  self._trapEndHeight = tonumber(paramList.trapEndHeight)
  self._trapFlyTotalTime = tonumber(paramList.trapFlyTotalTime) or 0
  self._rideTrapStartHeight = tonumber(paramList.rideTrapStartHeight)
  self._rideTrapTrajectoryID = tonumber(paramList.rideTrapTrajectoryID)
  self._resetHeightDelay = tonumber(paramList.resetHeightDelay) or 0
end

function PlayAlphaThrowTrapInstruction:GetCacheResource()
  local t = {}
  if self._hitEffectID and self._hitEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  if self._trapTrajectoryID and 0 < self._trapTrajectoryID then
    table.insert(t, {
      Cfg.cfg_effect[self._trapTrajectoryID].ResPath,
      1
    })
  end
  if self._rideTrapTrajectoryID and 0 < self._rideTrapTrajectoryID then
    table.insert(t, {
      Cfg.cfg_effect[self._trapTrajectoryID].ResPath,
      1
    })
  end
  return t
end

function PlayAlphaThrowTrapInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local resultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local result = resultContainer:GetEffectResultByArray(SkillEffectType.AlphaThrowTrap)
  if not result then
    return
  end
  local trapTrajectoryInfoArray = {}
  local removeTrapEntityArray = {}
  local effectService = world:GetService("Effect")
  local trapRenderSvc = world:GetService("TrapRender")
  local trapMountID = result:GetTrapMountID()
  local trapMountPos
  if trapMountID then
    local trapEntity = world:GetEntityByID(trapMountID)
    trapMountPos = trapEntity:GetGridPosition()
    trapRenderSvc:PlayTrapDieSkill(TT, {trapEntity})
  end
  local rideRenderSvc = world:GetService("RideRender")
  local monsterMountID = result:GetMonsterMountID()
  if monsterMountID then
    rideRenderSvc:RemoveRideRender(casterEntity:GetID(), monsterMountID)
  end
  YIELD(TT, self._delTrapDelay)
  local trapIDArray = result:GetTrapEntityIDs()
  for _, trapEntityID in ipairs(trapIDArray) do
    local trapEntity = world:GetEntityByID(trapEntityID)
    if trapEntityID ~= trapMountID then
      table.insert(removeTrapEntityArray, trapEntity)
    end
  end
  trapRenderSvc:PlayTrapDieSkill(TT, removeTrapEntityArray)
  local damageResult = result:GetDamageResult()
  local damagePos = damageResult:GetGridPos()
  local trapTargetPos = Vector2.New(damagePos.x, damagePos.y)
  local boardServiceRender = world:GetService("BoardRender")
  trapTargetPos = boardServiceRender:GridPos2RenderPos(Vector2.New(trapTargetPos.x + 0.5, trapTargetPos.y + 0.5))
  trapTargetPos.y = trapTargetPos.y + self._trapEndHeight
  YIELD(TT, self._trapStartDelay)
  for _, trapEntityID in ipairs(trapIDArray) do
    local trapEntity = world:GetEntityByID(trapEntityID)
    local trapEntityPos = trapEntity:GetGridPosition()
    local trapStartHeight = self._rideTrapStartHeight
    local trapTrajectoryID = self._rideTrapTrajectoryID
    local effectDir = damagePos - trapEntityPos
    if trapEntityID ~= trapMountID then
      trapStartHeight = self._trapStartHeight
      trapTrajectoryID = self._trapTrajectoryID
    end
    local trapBeginPos = boardServiceRender:GridPos2RenderPos(trapEntityPos)
    trapBeginPos.y = trapBeginPos.y + trapStartHeight
    local effectEntity = effectService:CreatePositionEffect(trapTrajectoryID, trapBeginPos)
    if effectEntity then
      effectEntity:SetDirection(effectDir)
    end
    local trajectoryInfo = {
      startHeight = trapStartHeight,
      endHeight = self._trapEndHeight,
      totalTime = self._trapFlyTotalTime * 0.001,
      totalTimeMs = self._trapFlyTotalTime,
      targetRenderPos = trapTargetPos,
      currentTime = 0,
      trajectoryID = trapTrajectoryID,
      trajectoryEntity = effectEntity
    }
    table.insert(trapTrajectoryInfoArray, trajectoryInfo)
  end
  YIELD(TT)
  local trapTaskIDs = {}
  for _, trajectoryInfo in ipairs(trapTrajectoryInfoArray) do
    table.insert(trapTaskIDs, GameGlobal.TaskManager():CoreGameStartTask(self._DoFly, self, trajectoryInfo))
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(trapTaskIDs) do
    YIELD(TT)
  end
  YIELD(TT, self._hitDelayTime)
  local hitAnimName = self._hitAnimName
  local hitFxID = self._hitEffectID
  local playSkillSvc = world:GetService("PlaySkill")
  local skillID = resultContainer:GetSkillID()
  local targetEntityID = damageResult:GetTargetID()
  local targetEntity = world:GetEntityByID(targetEntityID)
  local damageInfoArray = damageResult:GetDamageInfoArray()
  for __, damageInfo in ipairs(damageInfoArray) do
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitFxID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damagePos):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(false):SetHandleBeHitParam_SkillID(skillID):SetHandleBeHitParam_PlayHitBack(false)
    playSkillSvc:HandleBeHit(TT, beHitParam)
    if 0 < self._eachDamageTime then
      YIELD(TT, self._eachDamageTime)
    end
  end
  if trapMountID then
    rideRenderSvc:RemoveRideRender(casterEntity:GetID(), trapMountID)
    local curPos = casterEntity:Location():GetPosition()
    local tarPos = Vector3(curPos.x, 0, curPos.z)
    local effectViewCmpt = casterEntity:View()
    local effectObject = effectViewCmpt:GetGameObject()
    local transWork = effectObject.transform
    local easeWork = transWork:DOMove(tarPos, self._resetHeightDelay * 0.001, false):SetEase(DG.Tweening.Ease.InOutSine)
  end
  YIELD(TT, self._resetHeightDelay)
  if trapMountID then
    casterEntity:SetLocationHeight(0)
  end
end

function PlayAlphaThrowTrapInstruction:_DoFly(TT, trajectoryInfo)
  local entity = trajectoryInfo.trajectoryEntity
  local effectViewCmpt = entity:View()
  local effectObject = effectViewCmpt:GetGameObject()
  local posEffect = effectObject.transform.position
  local transWork = effectObject.transform
  local easeWork = transWork:DOMove(trajectoryInfo.targetRenderPos, trajectoryInfo.totalTime, false):SetEase(DG.Tweening.Ease.InOutSine)
  YIELD(TT, trajectoryInfo.totalTimeMs)
  local world = entity:GetOwnerWorld()
  world:DestroyEntity(entity)
end
