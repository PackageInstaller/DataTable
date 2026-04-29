require("play_skill_phase_base_r")
_class("PlaySkillAbsorbTrapsAndDamageByPickupTargetPhase", PlaySkillPhaseBase)
PlaySkillAbsorbTrapsAndDamageByPickupTargetPhase = PlaySkillAbsorbTrapsAndDamageByPickupTargetPhase

function PlaySkillAbsorbTrapsAndDamageByPickupTargetPhase:PlayFlight(TT, casterEntity, phaseParam)
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local result = routineComponent:GetEffectResultByArray(SkillEffectType.AbsorbTrapsAndDamageByPickupTarget)
  if not result then
    return
  end
  local trapTrajectoryInfoArray = {}
  local removeTrapEntityArray = {}
  local trapStartHeight = phaseParam:GetTrapStartHeight()
  local trapEndHeight = phaseParam:GetTrapEndHeight()
  local trapFlyTime = phaseParam:GetTrapFlyTotalTime()
  local trapTrajectoryID = phaseParam:GetTrapTrajectoryID()
  local trapIDArray = result:GetTrapEntityIDs()
  local boardServiceRender = self._world:GetService("BoardRender")
  local casterPos = casterEntity:GetGridPosition()
  local trapTargetPos = Vector2.New(casterPos.x, casterPos.y)
  trapTargetPos = boardServiceRender:GridPos2RenderPos(Vector2.New(casterPos.x + 0.5, casterPos.y + 0.5))
  trapTargetPos.y = trapTargetPos.y + phaseParam:GetTrapEndHeight()
  local effectService = self._world:GetService("Effect")
  YIELD(TT, phaseParam:GetTrapStartDelay())
  local trapServiceRender = self._world:GetService("TrapRender")
  local trapCount = #trapIDArray
  for _, trapEntityID in ipairs(trapIDArray) do
    local trapEntity = self._world:GetEntityByID(trapEntityID)
    table.insert(removeTrapEntityArray, trapEntity)
    local trapEntityPos = trapEntity:GetGridPosition()
    effectService:CreateWorldPositionEffect(phaseParam:GetTrapGridEffID(), trapEntityPos)
    local trapBeginPos = boardServiceRender:GridPos2RenderPos(trapEntityPos)
    trapBeginPos.y = trapBeginPos.y + phaseParam:GetTrapStartHeight()
    local effectEntity = effectService:CreatePositionEffect(trapTrajectoryID, trapBeginPos)
    local trajectoryInfo = {
      startHeight = trapStartHeight,
      endHeight = trapEndHeight,
      totalTime = trapFlyTime * 0.001,
      totalTimeMs = trapFlyTime,
      targetRenderPos = trapTargetPos,
      currentTime = 0,
      trajectoryID = trapTrajectoryID,
      trajectoryEntity = effectEntity
    }
    table.insert(trapTrajectoryInfoArray, trajectoryInfo)
  end
  YIELD(TT)
  trapServiceRender:DestroyTrapList(TT, removeTrapEntityArray)
  for _, e in ipairs(removeTrapEntityArray) do
    local trapRenderCmpt = e:TrapRender()
    if trapRenderCmpt then
      trapRenderCmpt:SetHadPlayDead()
    end
  end
  local trapTaskIDs = {}
  for _, trajectoryInfo in ipairs(trapTrajectoryInfoArray) do
    table.insert(trapTaskIDs, GameGlobal.TaskManager():CoreGameStartTask(self._DoFly, self, trajectoryInfo))
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(trapTaskIDs) do
    YIELD(TT)
  end
  YIELD(TT, phaseParam:GetHitDelayTime())
  local hitAnimName = phaseParam:GetHitAnimationName()
  local hitFxID = phaseParam:GetHitEffectId()
  local skillService = self:SkillService()
  local finalAttackIndex = result:GetFinalAttackIndex()
  local skillID = routineComponent:GetSkillID()
  local damageResultArray = result:GetDamageResultArray()
  for index, damageResult in ipairs(damageResultArray) do
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    local damageInfoArray = damageResult:GetDamageInfoArray()
    local damageGridPos = damageResult:GetGridPos()
    for __, damageInfo in ipairs(damageInfoArray) do
      local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitFxID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(index == finalAttackIndex):SetHandleBeHitParam_SkillID(skillID)
      skillService:HandleBeHit(TT, beHitParam)
      if 0 < phaseParam:GetEachDamageTime() then
        YIELD(TT, phaseParam:GetEachDamageTime())
      end
    end
  end
end

function PlaySkillAbsorbTrapsAndDamageByPickupTargetPhase:_DoFly(TT, trajectoryInfo)
  local entity = trajectoryInfo.trajectoryEntity
  local effectViewCmpt = entity:View()
  local effectObject = effectViewCmpt:GetGameObject()
  local posEffect = effectObject.transform.position
  local transWork = effectObject.transform
  local _easeWork = transWork:DOMove(trajectoryInfo.targetRenderPos, trajectoryInfo.totalTime, false):SetEase(DG.Tweening.Ease.InOutSine)
  YIELD(TT, trajectoryInfo.totalTimeMs)
  self._world:DestroyEntity(trajectoryInfo.trajectoryEntity)
end
