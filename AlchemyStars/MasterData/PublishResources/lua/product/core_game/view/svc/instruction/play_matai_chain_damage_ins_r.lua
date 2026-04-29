_class("PlayMataiChainDamageInstruction", BaseInstruction)
PlayMataiChainDamageInstruction = PlayMataiChainDamageInstruction

function PlayMataiChainDamageInstruction:Constructor(paramList)
  self._paramList = paramList
  self._casterEffectID = tonumber(paramList.casterEffectID)
  self._defenderEffectDelayMs = tonumber(paramList.defenderEffectDelayMs)
  self._defenderEffectID = tonumber(paramList.defenderEffectID)
  self._hitDelayMs = tonumber(paramList.hitDelayMs)
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._hitAnimName = paramList.hitAnimName
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._turnToTarget = tonumber(paramList.turnToTarget)
  self._deathClear = tonumber(paramList.deathClear)
  self._trapNotPlayHitEffect = tonumber(paramList.trapNotPlayHitEffect) or 0
  self._waitBeHitFinish = tonumber(paramList.waitBeHitFinish) or 1
end

function PlayMataiChainDamageInstruction:GetCacheResource()
  return {
    self:GetEffectResCacheInfo(self._casterEffectID),
    self:GetEffectResCacheInfo(self._defenderEffectID)
  }
end

function PlayMataiChainDamageInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if self._waitBeHitFinish == 1 then
    local tid = TaskManager:GetInstance():CoreGameStartTask(self._Play, self, casterEntity, phaseContext)
    phaseContext:AddPhaseTask(tid)
  else
    self:_Play(TT, casterEntity, phaseContext)
  end
end

function PlayMataiChainDamageInstruction:_Play(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playSkillService = world:GetService("PlaySkill")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  if targetEntityID == nil or targetEntityID < 0 then
    return
  end
  local targetEntity = world:GetEntityByID(targetEntityID)
  local curDamageIndex = phaseContext:GetCurDamageResultIndex()
  local curDamageInfoIndex = phaseContext:GetCurDamageInfoIndex()
  local curDamageResultStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, curDamageResultStageIndex)
  local damageResultStageCount = skillEffectResultContainer:GetEffectResultsStageCount(SkillEffectType.Damage)
  local damageResult = damageResultArray[curDamageIndex]
  local damageInfo = damageResult:GetDamageInfo(curDamageInfoIndex)
  if not damageInfo then
    Log.fatal("### damageInfo is nil. curDamageIndex, curDamageInfoIndex=", curDamageIndex, curDamageInfoIndex)
    return
  end
  local damageGridPos = damageResult:GetGridPos()
  local playFinalAttack = playSkillService:GetFinalAttack(world, casterEntity, phaseContext)
  local playHitEffectID = self._hitEffectID
  if self._trapNotPlayHitEffect == 1 and targetEntity:TrapID() then
    playHitEffectID = 0
  end
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(playHitEffectID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(self._turnToTarget):SetHandleBeHitParam_DeathClear(self._deathClear):SetHandleBeHitParam_IsFinalHit(playFinalAttack):SetHandleBeHitParam_SkillID(skillID):SetHandleBeHitParam_DamageIndex(curDamageIndex)
  local boardServiceRender = world:GetService("BoardRender")
  local playSkillService = world:GetService("PlaySkill")
  local targetHitObj = playSkillService:GetEntityRenderHitTransform(targetEntity)
  local targetHitGridPos = boardServiceRender:BoardRenderPos2FloatGridPos_New(targetHitObj.position)
  local casterFxGridDir = targetHitGridPos - casterEntity:GetRenderGridPosition()
  local fxSvc = world:GetService("Effect")
  local casterEffect = fxSvc:CreateWorldPositionDirectionEffect(self._casterEffectID, casterEntity:GetRenderGridPosition(), casterFxGridDir)
  YIELD(TT, self._defenderEffectDelayMs)
  local defenderEffect = fxSvc:CreateWorldPositionDirectionEffect(self._defenderEffectID, casterEntity:GetRenderGridPosition(), casterFxGridDir)
  YIELD(TT, self._hitDelayMs)
  playSkillService:HandleBeHit(TT, beHitParam)
end
