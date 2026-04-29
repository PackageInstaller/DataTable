require("play_skill_phase_base_r")
_class("PlaySkillMultiRandomTrajectoryPhase", PlaySkillPhaseBase)
PlaySkillMultiRandomTrajectoryPhase = PlaySkillMultiRandomTrajectoryPhase

function PlaySkillMultiRandomTrajectoryPhase:PlayFlight(TT, casterEntity, phaseParam)
  local effectParam = phaseParam
  self._startPosEffectID = effectParam:GetStartPosEffectID()
  self._bulletEffectID = effectParam:GetBulletEffectID()
  self._flyDelayTime = effectParam:GetFlyDelayTime()
  self._flyTime = effectParam:GetFlyTime()
  self._intervalTime = effectParam:GetSpawnIntervalTime()
  self._bulletOffSetV3 = effectParam:GetBulletOffSetV3()
  self._startPosList = effectParam:GetStartPosList()
  self._lastHitPointTime = 0
  self._hitPointDelay = 0
  self._destroyBulletDelay = 0
  self._targetHit = effectParam:GetTargetHit()
  self._hitAnimName = effectParam:GetHitAnimName()
  self._hitEffectID = effectParam:GetHitEffectID()
  self._casterEntity = casterEntity
  self._needLookAt = 1
  self._hitSoundID = effectParam:GetHitSoundID()
  local listTask = {}
  local castPos = casterEntity:GetRenderGridPosition()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if damageResultArray == nil then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local playSkillService = world:GetService("PlaySkill")
  local timeService = self._world:GetService("Time")
  local startTime = timeService:GetCurrentTimeMs()
  self._flyTaskIDList = {}
  if not self._startPosList then
    self._startPosList = {
      Vector2(2, 2),
      Vector2(1, 6),
      Vector2(5, 9),
      Vector2(9, 4),
      Vector2(8, 8)
    }
  end
  local posStartIndex = 1
  for i, v in ipairs(damageResultArray) do
    local format = {}
    local damageResult = v
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = world:GetEntityByID(targetEntityID)
    if targetEntity then
      local targetEntityPos = targetEntity:GetGridPosition()
      if i ~= 1 then
        YIELD(TT, self._intervalTime)
      end
      local posStart = self._startPosList[posStartIndex]
      if self:_TooClose(posStart, targetEntityPos) then
        posStartIndex = posStartIndex + 1
        posStart = self._startPosList[posStartIndex]
        posStartIndex = posStartIndex + 1
      else
        posStartIndex = posStartIndex + 1
      end
      posStart = posStart or Vector(7, 7)
      local taskID = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
        self:_PlayOneTrajectory(TT, i, v, posStart)
      end)
      table.insert(self._flyTaskIDList, taskID)
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(self._flyTaskIDList) do
    YIELD(TT)
  end
  YIELD(TT)
end

function PlaySkillMultiRandomTrajectoryPhase:_TooClose(posA, posB)
  local nearest = posA
  local relative = nearest - posB
  local distance = math.max(math.abs(relative.x), math.abs(relative.y))
  if distance <= 1 then
    return true
  end
  return false
end

function PlaySkillMultiRandomTrajectoryPhase:_PlayOneTrajectory(TT, index, damageResult, posStart)
  local targetEntityID = damageResult:GetTargetID()
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  if not targetEntity then
    return
  end
  local targetPos = targetEntity:GetGridPosition()
  local dir = targetPos - posStart
  if targetPos == posStart then
    dir = Vector2(1, 0)
  end
  local effectService = self._world:GetService("Effect")
  local startEffect
  if self._startPosEffectID and 0 < self._startPosEffectID then
    startEffect = effectService:CreateWorldPositionDirectionEffect(self._startPosEffectID, posStart, dir)
  end
  if not startEffect then
    return
  end
  local startEffectEntityID = startEffect:GetID()
  YIELD(TT, self._flyDelayTime)
  local boardServiceRender = self._world:GetService("BoardRender")
  local bulletEffect
  if self._bulletEffectID and 0 < self._bulletEffectID then
    local posBullet
    if self._bulletOffSetV3 then
      local startEffectEntity = self._world:GetEntityByID(startEffectEntityID)
      if startEffectEntity then
        local startEntityTransform = startEffect:View():GetGameObject().transform
        posBullet = startEntityTransform:TransformPoint(self._bulletOffSetV3)
      else
        posBullet = boardServiceRender:GridPos2RenderPos(posStart)
      end
    else
      posBullet = boardServiceRender:GridPos2RenderPos(posStart)
    end
    bulletEffect = effectService:CreatePositionEffect(self._bulletEffectID, posBullet)
    bulletEffect:SetDirection(dir)
  end
  if not bulletEffect then
    return
  end
  local bulletEffectEntityID = bulletEffect:GetID()
  local trajectoryObject = bulletEffect:View():GetGameObject()
  local transWork = trajectoryObject.transform
  local targetRenderPos = boardServiceRender:GridPos2RenderPos(targetPos)
  transWork:DOMove(targetRenderPos, self._flyTime / 1000, false):SetEase(DG.Tweening.Ease.Linear)
  YIELD(TT, self._flyTime)
  self:_OnPlayHit(TT, damageResult, bulletEffectEntityID, targetEntity)
end

function PlaySkillMultiRandomTrajectoryPhase:_OnPlayHit(TT, damageResult, bulletEffectEntityID, targetEntity)
  local effectEntity = self._world:GetEntityByID(bulletEffectEntityID)
  if effectEntity then
    local go = effectEntity:View():GetGameObject()
    local effectPos = go.transform.position
    local targetEntityID = targetEntity:GetID()
    local effectService = self._world:GetService("Effect")
  end
  local skillEffectResultContainer = self._casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageInfo = damageResult:GetDamageInfo(1)
  local damageGridPos = damageResult:GetGridPos()
  local playFinalAttack = false
  local playSkillService = self._world:GetService("PlaySkill")
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(self._casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(self._hitEffectID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(self._turnToTarget):SetHandleBeHitParam_DeathClear(0):SetHandleBeHitParam_IsFinalHit(playFinalAttack):SetHandleBeHitParam_SkillID(skillID)
  playSkillService:HandleBeHit(TT, beHitParam)
  if self._hitSoundID and 0 < self._hitSoundID then
    AudioHelperController.PlayInnerGameSfx(self._hitSoundID)
  end
  if self._destroyBulletDelay and 0 < self._destroyBulletDelay then
    YIELD(TT, self._destroyBulletDelay)
    local effectEntity = self._world:GetEntityByID(bulletEffectEntityID)
    if effectEntity then
      self._world:DestroyEntity(effectEntity)
    end
  else
    local effectEntity = self._world:GetEntityByID(bulletEffectEntityID)
    if effectEntity then
      self._world:DestroyEntity(effectEntity)
    end
  end
end
