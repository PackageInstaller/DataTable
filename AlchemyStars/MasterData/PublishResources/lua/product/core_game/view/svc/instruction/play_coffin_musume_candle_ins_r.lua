_class("PlayCoffinMusumeCandleInstruction", BaseInstruction)
PlayCoffinMusumeCandleInstruction = PlayCoffinMusumeCandleInstruction

function PlayCoffinMusumeCandleInstruction:Constructor(paramList)
  self._candleEffectID = tonumber(paramList.candleEffectID)
end

function PlayCoffinMusumeCandleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local result = routineComponent:GetEffectResultByArray(SkillEffectType.CoffinMusumeCandle)
  if not result then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local selectedLights = result:GetSelectedLights()
  for _, eid in ipairs(selectedLights) do
    local e = world:GetEntityByID(eid)
    if e then
      local fxsvc = world:GetService("Effect")
      fxsvc:CreateEffect(self._candleEffectID, e)
    end
  end
  world:GetService("PlayBuff"):PlayBuffView(TT, NTCoffinMusumeSkillChangeLight:New(selectedLights))
  self:_TryPlayAddHP(result, casterEntity)
  self:_TryPlayDamage(TT, result, casterEntity, phaseContext)
end

function PlayCoffinMusumeCandleInstruction:_TryPlayAddHP(result, casterEntity)
  local world = casterEntity:GetOwnerWorld()
  local addHPResult = result:GetAddHPResult()
  if not addHPResult then
    return
  end
  local damageInfo = addHPResult:GetDamageInfo()
  local playDamageService = world:GetService("PlayDamage")
  playDamageService:AsyncUpdateHPAndDisplayDamage(casterEntity, damageInfo)
end

function PlayCoffinMusumeCandleInstruction:_TryPlayDamage(TT, result, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local damageResult = result:GetDamageResult()
  if not damageResult then
    return
  end
  local targetEntityID = damageResult:GetTargetID()
  local targetEntity = world:GetEntityByID(targetEntityID)
  local damageInfo = damageResult:GetDamageInfo(1)
  local damageGridPos = damageResult:GetGridPos()
  local playSkillService = world:GetService("PlaySkill")
  local playFinalAttack = playSkillService:GetFinalAttack(world, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName("Hit"):SetHandleBeHitParam_HitEffectID(0):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(1):SetHandleBeHitParam_DeathClear(0):SetHandleBeHitParam_IsFinalHit(playFinalAttack):SetHandleBeHitParam_SkillID(skillID):SetHandleBeHitParam_DamageIndex(1)
  playSkillService:HandleBeHit(TT, beHitParam)
end
