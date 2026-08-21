require("play_skill_phase_base_r")
_class("PlaySkillPetANaTuoLiTractionPhase", PlaySkillPhaseBase)
PlaySkillPetANaTuoLiTractionPhase = PlaySkillPetANaTuoLiTractionPhase

function PlaySkillPetANaTuoLiTractionPhase:PlayFlight(TT, casterEntity, phaseParam, phaseIndex, phaseAdapter)
  local world = self._world
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local tractionResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.MultiTraction)
  local taskIDs = {}
  local boardServiceRender = world:GetService("BoardRender")
  local effectService = world:GetService("Effect")
  local entityRenderService = world:GetService("RenderEntity")
  local pieceService = world:GetService("Piece")
  local casterAction = phaseParam:GetCasterAction()
  local casterEffectID = phaseParam:GetCasterEffectID()
  if casterAction then
    casterEntity:SetAnimatorControllerTriggers({casterAction})
  end
  if casterEffectID then
    effectService:CreateEffect(casterEffectID, casterEntity)
  end
  local casterPos = casterEntity:GetRenderGridPosition()
  local scopeCenterPos, tractionCenterPos
  if tractionResult then
    local tractionScopeResult = tractionResult:GetSkillEffectScopeResult()
    tractionCenterPos = tractionResult:GetTractionCenterPos()
    scopeCenterPos = tractionScopeResult:GetCenterPos()
    local replaceScopeCenterPos = tractionResult:GetReplaceScopeCenterPos()
    if replaceScopeCenterPos then
      scopeCenterPos = replaceScopeCenterPos
    end
    local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._PlayTraction, self, casterEntity, tractionResult, phaseParam)
    table.insert(taskIDs, taskID)
  else
    local targetPos = Vector2(5, 6)
    scopeCenterPos = {casterPos, targetPos}
    tractionCenterPos = Vector2(5, 5)
  end
  casterEntity:SetDirection(tractionCenterPos - casterPos)
  local tractionCenterEffectDelayMs = phaseParam:GetTractionCenterEffectDelayMs()
  YIELD(TT, tractionCenterEffectDelayMs)
  local tractionCenterEffectID = phaseParam:GetTractionCenterEffectID()
  effectService:CreateWorldPositionEffect(tractionCenterEffectID, tractionCenterPos)
  local tractionChaseEffectID = phaseParam:GetTractionChaseEffectID()
  local tractionChaseEffectTimeMs = phaseParam:GetTractionChaseEffectTimeMs()
  local chaseEffectTaskIDs = {}
  for index, targetPos in ipairs(scopeCenterPos) do
    local effectEntity = effectService:CreatePositionEffect(tractionChaseEffectID, tractionCenterPos)
    local effectDir = targetPos - tractionCenterPos
    if targetPos == tractionCenterPos then
      local otherPosIndex = 3 - index
      local otherPos = scopeCenterPos[otherPosIndex]
      local otherDir = otherPos - tractionCenterPos
      effectDir = Vector2(-otherDir.x, -otherDir.y)
    end
    if effectEntity then
      effectEntity:SetDirection(effectDir)
    end
    local targetRenderPos = boardServiceRender:GridPos2RenderPos(targetPos)
    local trajectoryInfo = {
      startHeight = 0,
      endHeight = 0,
      totalTime = tractionChaseEffectTimeMs * 0.001,
      totalTimeMs = tractionChaseEffectTimeMs,
      targetRenderPos = targetRenderPos,
      trajectoryEntity = effectEntity
    }
    table.insert(chaseEffectTaskIDs, GameGlobal.TaskManager():CoreGameStartTask(self._DoFly, self, trajectoryInfo))
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(chaseEffectTaskIDs) do
    YIELD(TT)
  end
  local tractionPushEffectID = phaseParam:GetTractionPushEffectID()
  local tractionPushEffectMoveTimeMs = phaseParam:GetTractionPushEffectMoveTimeMs()
  local pushTrajectoryArray = {}
  for index, targetPos in ipairs(scopeCenterPos) do
    local effectEntity = effectService:CreatePositionEffect(tractionPushEffectID, targetPos)
    local effectDir = tractionCenterPos - targetPos
    if targetPos == tractionCenterPos then
      local otherPosIndex = 3 - index
      local otherPos = scopeCenterPos[otherPosIndex]
      local otherDir = tractionCenterPos - otherPos
      effectDir = Vector2(-otherDir.x, -otherDir.y)
    end
    if effectEntity then
      effectEntity:SetDirection(effectDir)
    end
    local targetRenderPos = boardServiceRender:GridPos2RenderPos(tractionCenterPos)
    local trajectoryInfo = {
      startHeight = 0,
      endHeight = 0,
      totalTime = tractionPushEffectMoveTimeMs * 0.001,
      totalTimeMs = tractionPushEffectMoveTimeMs,
      targetRenderPos = targetRenderPos,
      trajectoryEntity = effectEntity
    }
    table.insert(pushTrajectoryArray, trajectoryInfo)
  end
  local tractionPushEffectHoldTimeMs = phaseParam:GetTractionPushEffectHoldTimeMs()
  YIELD(TT, tractionPushEffectHoldTimeMs)
  local pushTrajectoryTaskIDs = {}
  for index, trajectoryInfo in ipairs(pushTrajectoryArray) do
    table.insert(pushTrajectoryTaskIDs, GameGlobal.TaskManager():CoreGameStartTask(self._DoFly, self, trajectoryInfo))
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(chaseEffectTaskIDs) do
    YIELD(TT)
  end
  local tractionBoomEffectID = phaseParam:GetTractionBoomEffectID()
  effectService:CreatePositionEffect(tractionBoomEffectID, tractionCenterPos)
  local damageIndex = 1
  local isFinalHit = false
  local skillID = skillEffectResultContainer:GetSkillID()
  self:_PlayDamageResult(TT, skillEffectResultContainer, damageIndex, casterEntity, phaseParam, isFinalHit, skillID)
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDs) do
    YIELD(TT)
  end
  local finalWaitTimeMs = phaseParam:GetFinalWaitTimeMs()
  YIELD(TT, finalWaitTimeMs)
  return
end

function PlaySkillPetANaTuoLiTractionPhase:_PlayTraction(TT, casterEntity, tractionResult, phaseParam)
  if tractionResult then
    local taskIDs = {}
    local world = self._world
    local boardServiceRender = world:GetService("BoardRender")
    local effectService = world:GetService("Effect")
    local entityRenderService = world:GetService("RenderEntity")
    local pieceService = world:GetService("Piece")
    local playTractionDelayMs = phaseParam:GetPlayTractionDelayMs()
    YIELD(TT, playTractionDelayMs)
    local tractionTargetEffectID = phaseParam:GetTractionTargetEffectID()
    local tractionMoveTimeMs = phaseParam:GetTractionMoveTimeMs()
    local tractionMoveAction = phaseParam:GetTractionMoveAction()
    local singleTractionArray = tractionResult:GetResultArray()
    local teamTractionData, teamEntity
    for _, info in ipairs(singleTractionArray) do
      local entity = world:GetEntityByID(info.entityID)
      if entity then
        local currentPos = boardServiceRender:GetRealEntityGridPos(entity)
        if tractionTargetEffectID and 0 < tractionTargetEffectID and info.beginPos ~= info.finalPos then
          effectService:CreateEffect(tractionTargetEffectID, entity)
        end
        if info.beginPos ~= info.finalPos then
          local playSkillSvc = world:GetService("PlaySkill")
          playSkillSvc:SetTargetDirection(entity, info.finalPos - currentPos)
          if tractionMoveAction then
            entity:SetAnimatorControllerBools({
              [tractionMoveAction] = true
            })
          end
        end
        local moveDis = Vector2.Distance(info.finalPos, info.beginPos)
        local tractionMoveSpeed = moveDis / (tractionMoveTimeMs * 0.001)
        local gridPos = boardServiceRender:GetRealEntityGridPos(entity)
        entity:AddGridMove(tractionMoveSpeed, info.finalPos, gridPos)
        entityRenderService:DestroyMonsterAreaOutLineEntity(entity)
        pieceService:RefreshMonsterPiece(entity, true)
        local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._CheckMoveFinish, self, entity, tractionMoveAction)
        table.insert(taskIDs, taskID)
        if entity:HasTeam() then
          teamTractionData = info
          teamEntity = entity
          local supply = tractionResult:GetSupplyPlayerPiece()
          if supply then
            boardServiceRender:ReCreateGridEntity(supply.color, info.beginPos)
            local playSkillSvc = world:GetService("PlaySkill")
            local svcPlayBuff = world:GetService("PlayBuff")
            svcPlayBuff:_SendNTGridConvertRender(TT, info.beginPos, supply.color, SkillEffectType.MultiTraction)
            local colorNew = tractionResult:GetColorNew()
            boardServiceRender:ReCreateGridEntity(colorNew, info.finalPos)
          end
        end
        local svcPlayBuff = self._world:GetService("PlayBuff")
        svcPlayBuff:PlayBuffView(TT, NTTractionEnd:New(casterEntity, entity, info.beginPos, info.finalPos))
      end
    end
    while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDs) do
      YIELD(TT)
    end
    if teamTractionData then
      local posOld = teamTractionData.beginPos
      local posNew = teamTractionData.finalPos
      local pets = teamEntity:Team():GetTeamPetEntities()
      for i, petEntity in ipairs(pets) do
        petEntity:SetLocation(posNew)
      end
      teamEntity:SetLocation(posNew)
      local utilDataSvc = self._world:GetService("UtilData")
      if utilDataSvc:CanChangePieceToGray() then
        boardServiceRender:ReCreateGridEntity(PieceType.None, posNew)
      end
    end
    if 0 < tractionTargetEffectID then
      effectService:DestroyEffectByID(tractionTargetEffectID)
    end
    local trapServiceRender = world:GetService("TrapRender")
    for _, info in ipairs(singleTractionArray) do
      local entity = world:GetEntityByID(info.entityID)
      if entity and info.beginPos ~= info.finalPos then
        local listTrapTrigger = info:GetTriggerTraps()
        trapServiceRender:PlayTrapTriggerSkillTasks(TT, listTrapTrigger, false, entity)
      end
    end
  end
end

function PlaySkillPetANaTuoLiTractionPhase:_CheckMoveFinish(TT, entity, tractionMoveAction)
  while entity:HasGridMove() do
    YIELD(TT)
  end
  local world = entity:GetOwnerWorld()
  local trapServiceRender = world:GetService("TrapRender")
  local boardServiceRender = world:GetService("BoardRender")
  local pieceService = world:GetService("Piece")
  local realPos = boardServiceRender:GetRealEntityGridPos(entity)
  local entityRenderService = world:GetService("RenderEntity")
  pieceService:RefreshMonsterPiece(entity, false)
  entityRenderService:CreateMonsterAreaOutlineEntity(entity)
  trapServiceRender:ShowHideTrapAtPos(realPos, false)
  if tractionMoveAction then
    entity:SetAnimatorControllerBools({
      [tractionMoveAction] = false
    })
  end
end

function PlaySkillPetANaTuoLiTractionPhase:_DoFly(TT, trajectoryInfo)
  local entity = trajectoryInfo.trajectoryEntity
  local effectViewCmpt = entity:View()
  local effectObject = effectViewCmpt:GetGameObject()
  local transWork = effectObject.transform
  local easeWork = transWork:DOMove(trajectoryInfo.targetRenderPos, trajectoryInfo.totalTime, false):SetEase(DG.Tweening.Ease.InOutSine)
  YIELD(TT, trajectoryInfo.totalTimeMs)
end

function PlaySkillPetANaTuoLiTractionPhase:_PlayDamageResult(TT, skillEffectResultContainer, damageStageIndex, casterEntity, phaseParam, isFinalHit, nSkillID)
  local damageResults = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, damageStageIndex)
  if not damageResults then
    return
  end
  for index, damageResult in ipairs(damageResults) do
    local targetEntity = self._world:GetEntityByID(damageResult:GetTargetID())
    self:_PlayHitEffect(TT, casterEntity, targetEntity, phaseParam, damageResult, isFinalHit, nSkillID)
  end
end

function PlaySkillPetANaTuoLiTractionPhase:_PlayHitEffect(TT, entityCast, entityTarget, phaseParam, result, isFinalHit, nSkillID)
  local hitAnimationName = phaseParam:GetBeHitAnimation()
  local hitEffectID = phaseParam:GetBeHitEffectID()
  local targetDamage = result:GetDamageInfo(1)
  local damagePos = result:GetGridPos()
  local skillService = self:SkillService()
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(entityCast):SetHandleBeHitParam_TargetEntity(entityTarget):SetHandleBeHitParam_HitAnimName(hitAnimationName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(damagePos):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(isFinalHit):SetHandleBeHitParam_SkillID(nSkillID)
  local hitTaskID = TaskManager:GetInstance():CoreGameStartTask(skillService.HandleBeHit, skillService, beHitParam)
end
