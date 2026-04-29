require("play_skill_phase_base_r")
_class("PlaySkillPhaseScopeForwardByDistance", PlaySkillPhaseBase)
PlaySkillPhaseScopeForwardByDistance = PlaySkillPhaseScopeForwardByDistance

function PlaySkillPhaseScopeForwardByDistance:PlayFlight(TT, casterEntity, phaseParam)
  local scopeForwardParam = phaseParam
  local gridEffectID = scopeForwardParam:GetGridEffectID()
  local hitAnimationName = scopeForwardParam:GetHitAnimationName()
  local hitEffectID = scopeForwardParam:GetHitEffectID()
  local effectDirection = scopeForwardParam:GetGridEffectDirection()
  local castPos = casterEntity:GridLocation().Position
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local gridDataArray = scopeResult:GetAttackRange()
  local targetGirdList, maxLength, _ = InnerGameSortGridHelperRender:SortGrid(gridDataArray, castPos)
  local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
  if isFinalAttack then
    local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
    local targetEntityID = self:_SortDistanceForFinalAttack(castPos, damageResultArray)
    skillEffectResultContainer:SetFinalAttackEntityID(targetEntityID)
  end
  local intervalTime = scopeForwardParam:GetEffectIntervalTime()
  local scopeType = scopeForwardParam:GetScopeType()
  local quadrantDiagonal = scopeForwardParam:GetQuadrantDiagonal()
  local tidHitTask = {}
  for i = 1, maxLength + 1 do
    local completeGirdArray = {}
    for _, gridPos in pairs(gridDataArray) do
      local distance = Vector2.Distance(castPos, gridPos)
      if i >= distance and 0 < distance then
        table.insert(completeGirdArray, gridPos)
        local girdDirection = Vector2.zero
        if quadrantDiagonal then
          girdDirection = self:_GetEffDir(gridPos, castPos)
        else
          girdDirection = self:_GetGridDirection(gridPos, castPos, scopeType) + self:_GetEffectDirection(effectDirection)
        end
        local entity = self._world:GetService("Effect"):CreateWorldPositionDirectionEffect(gridEffectID, gridPos, girdDirection)
        local damageResult = skillEffectResultContainer:GetEffectResultByPos(SkillEffectType.Damage, gridPos)
        if damageResult then
          local tid = self:_ShowDamage(damageResult, skillEffectResultContainer, hitAnimationName, hitEffectID, casterEntity, gridPos, scopeForwardParam:HitTurnToTarget(), skillID)
          if tid then
            table.insert(tidHitTask, tid)
          end
        end
      end
    end
    for _, pos in pairs(completeGirdArray) do
      table.removev(gridDataArray, pos)
    end
    YIELD(TT, intervalTime)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(tidHitTask) do
    YIELD(TT)
  end
end

function PlaySkillPhaseScopeForwardByDistance:_ShowDamage(damageResult, skillEffectResultContainer, hitAnimName, hitEffectID, casterEntity, gridPos, hitTurnToTarget, skillID)
  local targetEntityID = damageResult:GetTargetID()
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  if targetEntity ~= nil then
    local targetDamage = damageResult:GetDamageInfo(1)
    Log.debug("[skill] PlaySkillService:_HandlePlayFlyAttack ", targetEntityID, hitAnimName)
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(gridPos):SetHandleBeHitParam_HitTurnTarget(hitTurnToTarget):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(skillEffectResultContainer:IsFinalAttack()):SetHandleBeHitParam_SkillID(skillID)
    GameGlobal.TaskManager():CoreGameStartTask(self:SkillService().HandleBeHit, self:SkillService(), beHitParam)
  end
end

function PlaySkillPhaseScopeForwardByDistance:_GetGridDirection(girdPos, casterPos, scopeType)
  if girdPos == casterPos + Vector2(0, 1) then
    return Vector2(0, 1)
  elseif girdPos == casterPos + Vector2(0, -1) then
    return Vector2(0, -1)
  elseif girdPos == casterPos + Vector2(1, 0) then
    return Vector2(1, 0)
  elseif girdPos == casterPos + Vector2(-1, 0) then
    return Vector2(-1, 0)
  end
  if scopeType == 1 then
    local sub = girdPos - casterPos
    if 0 > sub.x then
      return Vector2(-1, 0)
    else
      return Vector2(1, 0)
    end
  else
    local sub = girdPos - casterPos
    if 0 > sub.y then
      return Vector2(0, -1)
    else
      return Vector2(0, 1)
    end
  end
end

function PlaySkillPhaseScopeForwardByDistance:_GetEffectDirection(effectDirection)
  if effectDirection == "Bottom" then
    return Vector2(0, -1)
  elseif effectDirection == "Up" then
    return Vector2(0, 1)
  elseif effectDirection == "Left" then
    return Vector2(1, 0)
  elseif effectDirection == "Right" then
    return Vector2(-1, 0)
  else
    return Vector2(0, 0)
  end
end

function PlaySkillPhaseScopeForwardByDistance:_GetEffDir(girdPos, casterPos)
  local sub = girdPos - casterPos
  if sub.x == 0 or sub.y == 0 then
    return sub.normalized
  else
    return Vector2(sub.x / Mathf.Abs(sub.x), sub.y / Mathf.Abs(sub.y))
  end
end

function PlaySkillPhaseScopeForwardByDistance:_SortDistanceForFinalAttack(castPos, damageResultArray)
  local function CmpDistancefunc(skillDamageEffectResult1, skillDamageEffectResult2)
    local dis1 = self:_CalcDistanceToCaster(castPos, skillDamageEffectResult1)
    
    local dis2 = self:_CalcDistanceToCaster(castPos, skillDamageEffectResult2)
    return dis1 > dis2
  end
  
  table.sort(damageResultArray, CmpDistancefunc)
  for _, v in ipairs(damageResultArray) do
    local result = v
    local targetEntityID = result:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    if targetEntity:HasDeadFlag() then
      return targetEntityID
    end
  end
end

function PlaySkillPhaseScopeForwardByDistance:_CalcDistanceToCaster(castPos, skillDamageResult)
  local gridPos = skillDamageResult:GetGridPos()
  return Vector2.Distance(gridPos, castPos)
end
