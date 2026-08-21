require("play_skill_phase_base_r")
_class("PlaySkillLRAttackDifferentAnimationPhase", PlaySkillPhaseBase)
PlaySkillLRAttackDifferentAnimationPhase = PlaySkillLRAttackDifferentAnimationPhase

function PlaySkillLRAttackDifferentAnimationPhase:PlayFlight(TT, casterEntity, phaseParam)
  local audioTaskIDArray = self:_PlayLRAttackAudio(phaseParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageResultAll = skillEffectResultContainer:GetEffectResultByArrayAll(SkillEffectType.Damage)
  if not damageResultAll then
    return
  end
  local beAttackEntityID = damageResultAll[1]:GetTargetID()
  local targetEntity = self._world:GetEntityByID(beAttackEntityID)
  if not targetEntity then
    return
  end
  local resvc = self._world:GetService("RenderEntity")
  resvc:AttackTurn(casterEntity, targetEntity)
  local effectService = self._world:GetService("Effect")
  local attackAnimName
  local boardServiceRender = self._world:GetService("BoardRender")
  local attEffPos
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local frontPos = utilCalcSvc:GetFrontPieces(casterEntity)
  local armBlurEffId = 0
  local blurDelay = 0
  local hitPointDelay = phaseParam:GetHitPointDelay()
  local hitEffectID = phaseParam:GetHitEffectID()
  local overDelay = phaseParam:GetOverDelay()
  if 0 > boardServiceRender:IsLeftOrRight(casterEntity, targetEntity) then
    attackAnimName = phaseParam:GetLAnimationName()
    attEffPos = frontPos[1]
    armBlurEffId = phaseParam:GetLBlurEffectID()
    blurDelay = phaseParam:GetBlurDelay()[1]
    hitPointDelay = phaseParam:GetHitPointDelay()[1]
    hitEffectID = phaseParam:GetHitEffectID()[1]
    overDelay = phaseParam:GetOverDelay()[1]
  else
    attackAnimName = phaseParam:GetRAnimationName()
    attEffPos = frontPos[2]
    armBlurEffId = phaseParam:GetRBlurEffectID()
    blurDelay = phaseParam:GetBlurDelay()[2]
    hitPointDelay = phaseParam:GetHitPointDelay()[2]
    hitEffectID = phaseParam:GetHitEffectID()[2]
    overDelay = phaseParam:GetOverDelay()[2]
  end
  casterEntity:SetAnimatorControllerTriggers({attackAnimName})
  if blurDelay then
    YIELD(TT, blurDelay)
  end
  if armBlurEffId then
    effectService:CreateEffect(armBlurEffId, casterEntity)
  end
  local deltaTimeMS = self._timeService:GetCurrentTimeMs()
  if 0 < hitPointDelay then
    YIELD(TT, hitPointDelay)
  end
  if targetEntity ~= nil then
    local hitAnimName = phaseParam:GetHitAnimation()
    local skillID = skillEffectResultContainer:GetSkillID()
    local skillService = self._world:GetService("PlaySkill")
    local taskIDs = {}
    for i = 1, #damageResultAll do
      local damageResult = damageResultAll[i]
      local castDamage = damageResult:GetDamageInfo(1)
      local damagePos = damageResult:GetGridPos()
      local beAttackEntityID = damageResult:GetTargetID()
      local targetEntity = self._world:GetEntityByID(beAttackEntityID)
      local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(castDamage):SetHandleBeHitParam_DamagePos(damagePos):SetHandleBeHitParam_HitTurnTarget(TurnToTargetType.None):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(false):SetHandleBeHitParam_SkillID(skillID)
      local nTaskID = GameGlobal.TaskManager():CoreGameStartTask(skillService.HandleBeHit, skillService, beHitParam)
      if 0 < nTaskID then
        taskIDs[#taskIDs + 1] = nTaskID
      end
    end
    if 0 < table.count(taskIDs) then
      while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDs) do
        YIELD(TT)
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(audioTaskIDArray) do
    YIELD(TT)
  end
end

function PlaySkillLRAttackDifferentAnimationPhase:_PlayLRAttackAudio(phaseParam)
  local audioTaskArray = {}
  local leftAudioID = phaseParam:GetLeftAudioID()
  local leftAudioDelay = phaseParam:GetLeftAudioDelay()
  local rightAudioID = phaseParam:GetRightAudioID()
  local rightAudioDelay = phaseParam:GetRightAudioDelay()
  if leftAudioID ~= nil and 0 < leftAudioID then
    local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._PlayAttackAudio, self, leftAudioID, leftAudioDelay)
    audioTaskArray[#audioTaskArray + 1] = taskID
  end
  if rightAudioID ~= nil and 0 < rightAudioID then
    local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._PlayAttackAudio, self, rightAudioID, rightAudioDelay)
    audioTaskArray[#audioTaskArray + 1] = taskID
  end
  return audioTaskArray
end

function PlaySkillLRAttackDifferentAnimationPhase:_PlayAttackAudio(TT, audioID, audioDelay)
  YIELD(TT, audioDelay)
  AudioHelperController.PlayInnerGameSfx(audioID)
end
