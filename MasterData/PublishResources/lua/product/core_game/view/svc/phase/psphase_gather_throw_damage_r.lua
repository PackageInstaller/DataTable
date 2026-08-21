require("play_skill_phase_base_r")
_class("PlaySkillGatherThrowDamagePhase", PlaySkillPhaseBase)
PlaySkillGatherThrowDamagePhase = PlaySkillGatherThrowDamagePhase

function PlaySkillGatherThrowDamagePhase:PlayFlight(TT, casterEntity, phaseParam)
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local result = routineComponent:GetEffectResultByArray(SkillEffectType.GatherThrowDamage)
  if not result then
    return
  end
  local monsterTrajectoryInfoArray = {}
  local removeMonsterEntityArray = {}
  local monsterFlyTime = phaseParam:GetMonsterFlyTotalTime()
  local monsterIDArray = result:GetMonsterIDArray()
  local targetPetId = result:GetTargetID()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamLeaderEntityID = teamEntity:Team():GetTeamLeaderEntityID()
  local boardServiceRender = self._world:GetService("BoardRender")
  local casterPos = casterEntity:GetGridPosition()
  local monsterFlyToPos = phaseParam:GetMonsterFlyToPos()
  if monsterFlyToPos then
    casterPos = monsterFlyToPos
  end
  local monsterTargetPos = Vector2.New(casterPos.x, casterPos.y)
  monsterTargetPos = boardServiceRender:GridPos2RenderPos(monsterTargetPos)
  monsterTargetPos.y = monsterTargetPos.y + phaseParam:GetMonsterEndHeight()
  local effectService = self._world:GetService("Effect")
  casterEntity:SetAnimatorControllerTriggers({
    phaseParam:GetCasterAnimName()
  })
  effectService:CreateEffect(phaseParam:GetCastEffectID(), casterEntity)
  local playSkillService = self._world:GetService("PlaySkill")
  playSkillService:ShowPlayerEntity(teamEntity)
  for _, monsterEntityID in ipairs(monsterIDArray) do
    local trajectoryInfo = self:_GenEntityFlyInfo(monsterEntityID, phaseParam, monsterTargetPos)
    table.insert(monsterTrajectoryInfoArray, trajectoryInfo)
  end
  local trajectoryInfo = self:_GenEntityFlyInfo(teamLeaderEntityID, phaseParam, monsterTargetPos)
  table.insert(monsterTrajectoryInfoArray, trajectoryInfo)
  YIELD(TT)
  local monsterTaskIDs = {}
  for _, trajectoryInfo in ipairs(monsterTrajectoryInfoArray) do
    table.insert(monsterTaskIDs, GameGlobal.TaskManager():CoreGameStartTask(self._DoFly, self, trajectoryInfo))
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(monsterTaskIDs) do
    YIELD(TT)
  end
  for _, monsterEntityID in ipairs(monsterIDArray) do
    table.insert(removeMonsterEntityArray, self._world:GetEntityByID(monsterEntityID))
  end
  local msrSvc = self._world:GetService("MonsterShowRender")
  for _, eMonster in ipairs(removeMonsterEntityArray) do
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      msrSvc:_DoOneMonsterDead(TT, eMonster)
    end)
  end
  YIELD(TT, phaseParam:GetBowlderStartDelay())
  local playerPos = teamEntity:GetGridPosition()
  local bowlderTargetPos = boardServiceRender:GridPos2RenderPos(Vector2.New(playerPos.x, playerPos.y))
  bowlderTargetPos.y = bowlderTargetPos.y + phaseParam:GetBowlderEndHeight()
  local bowlderTime = phaseParam:GetBowlderFlyTotalTime()
  local bowlderID = phaseParam:GetBowlderTrajectoryID()
  local bowlderBeginRenderPos = phaseParam:GetBowlderStartPos()
  local bowlderJumpHeight = phaseParam:GetBowlderJumpHeight()
  local bowlderEffectEntity = effectService:CreatePositionEffect(bowlderID, bowlderBeginRenderPos)
  YIELD(TT)
  local bowlderTrajectoryInfo = {
    totalTime = bowlderTime * 0.001,
    totalTimeMs = bowlderTime,
    targetRenderPos = bowlderTargetPos,
    currentTime = 0,
    trajectoryID = bowlderID,
    trajectoryEntity = bowlderEffectEntity,
    jumpHeight = bowlderJumpHeight
  }
  GameGlobal.TaskManager():CoreGameStartTask(self._DoJump, self, bowlderTrajectoryInfo)
  do
    local teleResults = result:GetTeleportResultArray()
    for index, skillResult in ipairs(teleResults) do
      local targetID = skillResult:GetTargetID()
      local targetEntity = self._world:GetEntityByID(targetID)
      self:_ResetScale(targetEntity)
      local playSkillInstructionService = self._world:GetService("PlaySkillInstruction")
      playSkillInstructionService:Teleport(TT, targetEntity, RoleShowType.TeleportHide, false, skillResult)
      playSkillInstructionService:Teleport(TT, targetEntity, RoleShowType.TeleportMove, false, skillResult)
      YIELD(TT, phaseParam.stealthDuration)
      playSkillInstructionService:Teleport(TT, targetEntity, RoleShowType.TeleportShow, false, skillResult)
      playSkillInstructionService:Teleport(TT, targetEntity, RoleShowType.BuffNotify, false, skillResult)
      if phaseParam.appearAnimation then
        targetEntity:SetAnimatorControllerTriggers({
          phaseParam.appearAnimation
        })
      end
      if phaseParam.appearEffectID and phaseParam.appearEffectID ~= 0 then
        effectService:CreateEffect(phaseParam.appearEffectID, targetEntity)
      end
      YIELD(TT, phaseParam.appearDuration)
      local pieceService = self._world:GetService("Piece")
      pieceService:RemovePrismAt(skillResult:GetPosNew())
    end
  end
  local teleportKillMonster = result:GetTeleportKillMonster()
  if 0 < #teleportKillMonster then
    local teleportKillMonsterEntitys = {}
    for _, monsterEntityID in ipairs(teleportKillMonster) do
      table.insert(teleportKillMonsterEntitys, self._world:GetEntityByID(monsterEntityID))
    end
    for _, eMonster in ipairs(teleportKillMonsterEntitys) do
      GameGlobal.TaskManager():CoreGameStartTask(function(TT)
        msrSvc:_DoOneMonsterDead(TT, eMonster)
      end)
    end
  end
  local playSkillService = self._world:GetService("PlaySkill")
  playSkillService:ShowPlayerEntity(teamEntity)
  local hitAnimName = phaseParam:GetHitAnimationName()
  local hitFxID = phaseParam:GetHitEffectId()
  local skillService = self:SkillService()
  local isFinalHit = routineComponent:IsFinalAttack()
  local skillID = routineComponent:GetSkillID()
  local damageResultArray = result:GetDamageResultArray()
  for _, damageResult in ipairs(damageResultArray) do
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    local damageInfoArray = damageResult:GetDamageInfoArray()
    local posCast = self:_GetEntityBasePos(casterEntity)
    local posTarget = self:_GetEntityBasePos(targetEntity)
    for __, damageInfo in ipairs(damageInfoArray) do
      local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitFxID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(posTarget):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(isFinalHit):SetHandleBeHitParam_SkillID(skillID)
      skillService:HandleBeHit(TT, beHitParam)
    end
  end
end

function PlaySkillGatherThrowDamagePhase:_GenEntityFlyInfo(entityID, phaseParam, monsterTargetPos)
  local monsterFlyTime = phaseParam:GetMonsterFlyTotalTime()
  local minScale = phaseParam:GetMonsterMinScale()
  local monsterEntity = self._world:GetEntityByID(entityID)
  local trajectoryInfo = {
    totalTime = monsterFlyTime * 0.001,
    totalTimeMs = monsterFlyTime,
    targetRenderPos = monsterTargetPos,
    currentTime = 0,
    trajectoryID = entityID,
    trajectoryEntity = monsterEntity,
    minScale = minScale
  }
  return trajectoryInfo
end

function PlaySkillGatherThrowDamagePhase:_DoFly(TT, trajectoryInfo)
  local entity = trajectoryInfo.trajectoryEntity
  local effectViewCmpt = entity:View()
  local effectObject = effectViewCmpt:GetGameObject()
  local posEffect = effectObject.transform.position
  local transWork = effectObject.transform
  local hpCmpt = entity:HP()
  if hpCmpt then
    local sliderEntityID = entity:HP():GetHPSliderEntityID()
    local sliderEntity = self._world:GetEntityByID(sliderEntityID)
    if sliderEntity then
      sliderEntity:SetViewVisible(false)
    end
  end
  local _easeWork = transWork:DOMove(trajectoryInfo.targetRenderPos, trajectoryInfo.totalTime, false):SetEase(DG.Tweening.Ease.InOutSine)
  transWork:DOScale(Vector3(trajectoryInfo.minScale, trajectoryInfo.minScale, trajectoryInfo.minScale), trajectoryInfo.totalTime)
  YIELD(TT, trajectoryInfo.totalTimeMs)
end

function PlaySkillGatherThrowDamagePhase:_ResetScale(entity)
  if entity then
    local effectViewCmpt = entity:View()
    local effectObject = effectViewCmpt:GetGameObject()
    local transWork = effectObject.transform
    transWork.localScale = Vector3(1, 1, 1)
  end
end

function PlaySkillGatherThrowDamagePhase:_DoJump(TT, trajectoryInfo)
  local entity = trajectoryInfo.trajectoryEntity
  local effectViewCmpt = entity:View()
  local effectObject = effectViewCmpt:GetGameObject()
  local posEffect = effectObject.transform.position
  local transWork = effectObject.transform
  local _easeWork = transWork:DOJump(trajectoryInfo.targetRenderPos, trajectoryInfo.jumpHeight, 1, trajectoryInfo.totalTime, false):SetEase(DG.Tweening.Ease.Linear)
  YIELD(TT, trajectoryInfo.totalTimeMs)
end
