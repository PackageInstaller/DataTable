require("play_skill_phase_base_r")
_class("PlaySkillRangeAttackAnimationPhase", PlaySkillPhaseBase)
PlaySkillRangeAttackAnimationPhase = PlaySkillRangeAttackAnimationPhase

function PlaySkillRangeAttackAnimationPhase:PlayFlight(TT, casterEntity, phaseParam)
  local param = phaseParam
  local castAnimationName = param:GetCastAnimation()
  local castEffectID = param:GetCastEffectID()
  local hitDelayTime = param:GetHitDelayTime()
  local animatedEntity = casterEntity
  if param:IsPlayOnSuperEntity() and casterEntity:HasSuperEntity() then
    animatedEntity = casterEntity:GetSuperEntity()
  end
  self:_PlayAnimationEffect(TT, animatedEntity, castAnimationName, castEffectID, hitDelayTime)
  Log.debug("[RangeAttackAnimation] play anim effect end")
  GameGlobal.TaskManager():CoreGameStartTask(self._skillService.PlayCastAudio, self._skillService, param:GetAudioID(), param:GetAudioWaitTime())
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local isFinalHit = skillEffectResultContainer:IsFinalAttack()
  local results = skillEffectResultContainer:GetEffectResultByArrayAll(SkillEffectType.Damage)
  local bHaveBit = self:_TrajectoryAction(TT, casterEntity, param, results, isFinalHit, skillID)
  local taskIDs = {}
  if false == bHaveBit then
    if not results then
      return
    end
    local hitAnimationName = param:GetHitAnimation()
    local hitEffectID = param:GetHitEffectID()
    local hpDelayTime = param:GetHpDelay()
    local targetEffectID = param:GetTargetEffectID()
    for _, res in pairs(results) do
      local targetEntity = self._world:GetEntityByID(res:GetTargetID())
      if targetEntity then
        local pos = targetEntity:GridLocation().Position
        local targetDamage = res:GetDamageInfo(1)
        local damagePos = res:GetGridPos()
        local nTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._HandleBeHit, self, casterEntity, targetEntity, hitAnimationName, hitEffectID, targetDamage, targetEffectID, hpDelayTime, isFinalHit, param, damagePos, skillID)
        if 0 < nTaskID then
          taskIDs[#taskIDs + 1] = nTaskID
        end
      end
    end
  end
  local nWaitStart = GameGlobal:GetInstance():GetCurrentTime()
  self:_WaitSonTask(taskIDs)
  local nWaitEnd = GameGlobal:GetInstance():GetCurrentTime()
  local finishDelayTime = math.max(0, param:GetFinishDelayTime() - (nWaitEnd - nWaitStart))
  Log.debug("[RangeAttackAnimation] finishDelayTime:", finishDelayTime)
  YIELD(TT, finishDelayTime)
end

function PlaySkillRangeAttackAnimationPhase:_HandleBeHit(TT, casterEntity, targetEntity, hitAnimationName, hitEffectID, targetDamage, targetEffectID, hpDelayTime, isFinalHit, param, damagePos, skillID)
  if targetEffectID then
    self._world:GetService("Effect"):CreateEffect(targetEffectID, targetEntity)
  end
  YIELD(TT, hpDelayTime)
  local playSkillService = self:SkillService()
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimationName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(damagePos):SetHandleBeHitParam_DeathClear(param:IsClearBodyNow()):SetHandleBeHitParam_IsFinalHit(isFinalHit):SetHandleBeHitParam_SkillID(skillID)
  playSkillService:HandleBeHit(TT, beHitParam)
end

function PlaySkillRangeAttackAnimationPhase:_TrajectoryAction(TT, casterEntity, phaseParam, results, isFinalHit, nSkillID)
  local nTrajectoryType = phaseParam:GetTrajectoryType()
  if nil == nTrajectoryType then
    return false
  end
  if nil == results or table.count(results) <= 0 then
    return false
  end
  local nTrajectoryEffectID = phaseParam:GetTrajectoryEffectID()
  local nTrajectoryTime = phaseParam:GetTrajectoryTime()
  local castPos = casterEntity:GridLocation().Position
  local boardServiceRender = self._world:GetService("BoardRender")
  local effectService = self._world:GetService("Effect")
  local effectEntities = {}
  for _, res in pairs(results) do
    local targetEntity = self._world:GetEntityByID(res:GetTargetID())
    if targetEntity then
      local posDamage = res:GetGridPos()
      local posDirectory = posDamage - castPos
      local nEffectOffset = phaseParam:GetTrajectoryEffectOffset()
      local posCreate = castPos
      if nEffectOffset then
        local nDirectoryLen = math.max(math.abs(posDirectory.x), math.abs(posDirectory.y), 1)
        local effectDirector = Vector2(posDirectory.x / nDirectoryLen, posDirectory.y / nDirectoryLen)
        posCreate = castPos + nEffectOffset * effectDirector
      end
      local effectEntity = effectService:CreateWorldPositionDirectionEffect(nTrajectoryEffectID, posCreate, posDirectory)
      effectEntities[posDamage] = effectEntity
    end
  end
  local nMaxTime = nTrajectoryTime
  local needWaitTaskIds = {}
  for _, res in pairs(results) do
    local targetEntity = self._world:GetEntityByID(res:GetTargetID())
    if targetEntity then
      local posDamage = res:GetGridPos()
      local attachPos = posDamage
      local disx = math.abs(attachPos.x - castPos.x)
      local disy = math.abs(attachPos.y - castPos.y)
      local dis = math.sqrt(disx * disx + disy * disy)
      local entityEffect = effectEntities[posDamage]
      local effView = entityEffect:View()
      if not effView then
        Log.debug("[RangeAttackAnimation] eff no view")
      end
      local nFlayTime = dis * nTrajectoryTime / 1000.0
      local easeWork
      if effView then
        local trajectoryObject = effView:GetGameObject()
        local transWork = trajectoryObject.transform
        local gridWorldpos = boardServiceRender:GridPos2RenderPos(attachPos)
        if SkillPhaseParam_RangeAttack_TrajectoryType.Line == nTrajectoryType then
          easeWork = transWork:DOMove(gridWorldpos, nFlayTime, false):SetEase(DG.Tweening.Ease.InOutSine)
        elseif SkillPhaseParam_RangeAttack_TrajectoryType.Parabola == nTrajectoryType then
          transWork.position = transWork.position + Vector3.up * 1
          local jumpPower = math.sqrt(disx + disy)
          local sequence = transWork:DOJump(gridWorldpos, jumpPower, 1, nFlayTime, false)
          easeWork = sequence:SetEase(DG.Tweening.Ease.InOutSine)
        elseif SkillPhaseParam_RangeAttack_TrajectoryType.Laser == nTrajectoryType then
          local sequence = transWork:DOScaleZ(dis, nFlayTime)
          easeWork = sequence:SetEase(DG.Tweening.Ease.InOutSine)
        end
      end
      if easeWork then
        local taskId = GameGlobal.TaskManager():CoreGameStartTask(self._DoTweenCompleteCall, self, casterEntity, targetEntity, phaseParam, castPos, attachPos, res, isFinalHit, nSkillID, nFlayTime, entityEffect)
        needWaitTaskIds[#needWaitTaskIds + 1] = taskId
      else
        local taskId = GameGlobal.TaskManager():CoreGameStartTask(self._DoTweenCompleteCall, self, casterEntity, targetEntity, phaseParam, castPos, attachPos, res, isFinalHit, nSkillID, nFlayTime, entityEffect)
        needWaitTaskIds[#needWaitTaskIds + 1] = taskId
      end
      if nMaxTime < nFlayTime then
        nMaxTime = nFlayTime
      end
    end
  end
  local endtime = GameGlobal:GetInstance():GetCurrentTime() + nMaxTime
  while endtime > GameGlobal:GetInstance():GetCurrentTime() do
    YIELD(TT)
  end
  YIELD(TT)
  self:_WaitSonTask(needWaitTaskIds)
  Log.debug("[RangeAttackAnimation] TrajectoryAction finish")
  return true
end

function PlaySkillRangeAttackAnimationPhase:_DoTweenCompleteCall(TT, casterEntity, targetEntity, phaseParam, castPos, attachPos, res, isFinalHit, nSkillID, nFlayTime, entityEffect)
  YIELD(TT, nFlayTime * 1000)
  self._world:DestroyEntity(entityEffect)
  self:_PlayTrajectoryOverEffect(TT, phaseParam:GetTargetEffectID(), phaseParam:GetHpDelay(), castPos, attachPos)
  self:_PlayHitEffect(TT, casterEntity, targetEntity, phaseParam, res, isFinalHit, nSkillID)
end

function PlaySkillRangeAttackAnimationPhase:_PlayTrajectoryOverEffect(TT, nEffectID, nShowTime, posCast, posGrid)
  if nil == nEffectID or nEffectID <= 0 then
    return
  end
  local effectService = self._world:GetService("Effect")
  local posDirectory = posGrid - posCast
  local entityEffect = effectService:CreateWorldPositionDirectionEffect(nEffectID, posGrid, posDirectory)
  YIELD(TT, nShowTime)
end

function PlaySkillRangeAttackAnimationPhase:_PlayHitEffect(TT, entityCast, entityTarget, phaseParam, result, isFinalHit, nSkillID)
  local hitAnimationName = phaseParam:GetHitAnimation()
  local hitEffectID = phaseParam:GetHitEffectID()
  local targetDamage = result:GetDamageInfo(1)
  local damagePos = result:GetGridPos()
  local skillService = self:SkillService()
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(entityCast):SetHandleBeHitParam_TargetEntity(entityTarget):SetHandleBeHitParam_HitAnimName(hitAnimationName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(damagePos):SetHandleBeHitParam_DeathClear(phaseParam:IsClearBodyNow()):SetHandleBeHitParam_IsFinalHit(isFinalHit):SetHandleBeHitParam_SkillID(nSkillID)
  skillService:HandleBeHit(TT, beHitParam)
end
