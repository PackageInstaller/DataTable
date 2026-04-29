require("base_ins_r")
_class("PlaySplashDamageInstruction", BaseInstruction)
PlaySplashDamageInstruction = PlaySplashDamageInstruction

function PlaySplashDamageInstruction:Constructor(paramList)
  self._hitAnimName = paramList.hitAnimName
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._turnToTarget = tonumber(paramList.turnToTarget)
  self._deathClear = tonumber(paramList.deathClear)
  self._gridEffectID = tonumber(paramList.gridEffectID)
end

function PlaySplashDamageInstruction:GetCacheResource()
  local t = {}
  if self._gridEffectID and self._gridEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._gridEffectID].ResPath,
      1
    })
  end
  return t
end

function PlaySplashDamageInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local resultIdx = phaseContext:GetCurResultIndexByType(SkillEffectType.SplashDamage)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SplashDamage)
  if not results then
    Log.fatal("no results")
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local hasTargetDamageResultArray = {}
  for _, result in ipairs(results) do
    for _, damageResult in ipairs(result:GetDamageResults()) do
      local targetEntityID = damageResult:GetTargetID()
      local targetEntity = world:GetEntityByID(targetEntityID)
      if targetEntity then
        table.insert(hasTargetDamageResultArray, damageResult)
      end
    end
  end
  if table.count(hasTargetDamageResultArray) == 0 then
    return
  end
  local result = results[resultIdx]
  if not result then
    Log.fatal("no result at index: ", resultIdx)
    return
  end
  local fxsvc = world:GetService("Effect")
  local splashScopeResult = result:GetSplashScopeResult()
  local attackRange = splashScopeResult:GetAttackRange()
  for _, gridPos in ipairs(attackRange) do
    fxsvc:CreateWorldPositionEffect(self._gridEffectID, gridPos)
  end
  local playSkillService = world:GetService("PlaySkill")
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageResults = result:GetDamageResults()
  for _, damageResult in ipairs(damageResults) do
    local targetEntity = world:GetEntityByID(damageResult:GetTargetID())
    local damageInfo = damageResult:GetDamageInfo(1)
    local damageGridPos = damageResult:GetGridPos()
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(self._hitEffectID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(self._turnToTarget):SetHandleBeHitParam_DeathClear(self._deathClear):SetHandleBeHitParam_IsFinalHit(skillEffectResultContainer:IsFinalAttack()):SetHandleBeHitParam_SkillID(skillID)
    playSkillService:HandleBeHit(TT, beHitParam)
  end
end
