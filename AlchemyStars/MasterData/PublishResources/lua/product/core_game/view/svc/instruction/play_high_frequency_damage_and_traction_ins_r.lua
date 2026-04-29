require("base_ins_r")
_class("PlayHighFrequencyDamageAndTractionInstruction", BaseInstruction)
PlayHighFrequencyDamageAndTractionInstruction = PlayHighFrequencyDamageAndTractionInstruction

function PlayHighFrequencyDamageAndTractionInstruction:Constructor(paramList)
  self._damageFxID = tonumber(paramList.damageFxID)
  self._tractionCenterFxID = tonumber(paramList.tractionCenterFxID)
  self._hitAnimName = paramList.hitAnimName
  self._startupFxTime = tonumber(paramList.startupFxTime) or 0
  self._eachDamageTime = tonumber(paramList.eachDamageTime) or 0
  self._beforeTractionTime = tonumber(paramList.beforeTractionTime) or 0
  self._paramList = paramList
end

function PlayHighFrequencyDamageAndTractionInstruction:GetCacheResource()
  local t = {}
  local damageFxPath = self:GetEffectResCacheInfo(self._damageFxID, 8)
  if damageFxPath then
    table.insert(t, damageFxPath)
  end
  local tractionCenterFxPath = self:GetEffectResCacheInfo(self._tractionCenterFxID)
  if tractionCenterFxPath then
    table.insert(t, tractionCenterFxPath)
  end
  return t
end

function PlayHighFrequencyDamageAndTractionInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local resContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = resContainer:GetEffectResultByArrayAll(SkillEffectType.HighFrequencyDamage)
  local skillID = resContainer:GetSkillID()
  local lastDamageResult = self:_DoHighFrequencyDamage(TT, casterEntity, phaseContext, results[1], skillID)
  if not lastDamageResult then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local fxsvc = world:GetService("Effect")
  local firstTargetID = lastDamageResult:GetTargetID()
  local eFirstTarget = world:GetEntityByID(firstTargetID)
  local v2RenderGridPosition = eFirstTarget:GetRenderGridPosition()
  fxsvc:CreateWorldPositionEffect(self._tractionCenterFxID, v2RenderGridPosition)
  local tractionResultArray = resContainer:GetEffectResultByArrayAll(SkillEffectType.MultiTraction)
  if tractionResultArray and 0 < #tractionResultArray then
    if 0 < self._beforeTractionTime then
      YIELD(TT, self._beforeTractionTime)
    end
    local tractionInst = PlayMultiTractionInstruction:New(self._paramList)
    tractionInst:DoInstruction(TT, casterEntity, phaseContext)
  end
end

function PlayHighFrequencyDamageAndTractionInstruction:_DoHighFrequencyDamage(TT, casterEntity, phaseContext, result, skillID)
  local damageResults = result:GetDamageResultArray()
  if #damageResults == 0 then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local fxsvc = world:GetService("Effect")
  if 0 < self._startupFxTime then
    YIELD(TT, self._startupFxTime)
  end
  local finalAttackIndex = result:GetFinalAttackIndex()
  local curDamageInfoIndex = phaseContext:GetCurDamageInfoIndex()
  local playSkillService = world:GetService("PlaySkill")
  local playBuffSvc = world:GetService("PlayBuff")
  for index, damageResult in ipairs(damageResults) do
    local nt = NTBeforeHighFrequencyDamageHit:New(casterEntity, index)
    playBuffSvc:PlayBuffView(TT, nt)
    local targetID = damageResult:GetTargetID()
    local targetEntity = world:GetEntityByID(targetID)
    local damageInfo = damageResult:GetDamageInfo(curDamageInfoIndex)
    local damageGridPos = damageResult:GetGridPos()
    local playFinalAttack = playSkillService:GetFinalAttack(world, casterEntity, phaseContext)
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(self._damageFxID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(true):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(index == finalAttackIndex):SetHandleBeHitParam_SkillID(skillID)
    playSkillService:HandleBeHit(TT, beHitParam)
    local ntAfter = NTAfterHighFrequencyDamageHit:New(casterEntity, index)
    playBuffSvc:PlayBuffView(TT, ntAfter)
    if 0 < self._eachDamageTime then
      YIELD(TT, self._eachDamageTime)
    end
  end
  return damageResults[#damageResults]
end
