require("play_skill_phase_base_r")
_class("PlaySkillPhaseScopeGroup", PlaySkillPhaseBase)
PlaySkillPhaseScopeGroup = PlaySkillPhaseScopeGroup

function PlaySkillPhaseScopeGroup:PlayFlight(TT, casterEntity, phaseParam)
  local gridEffectID = phaseParam:GetGridEffectID()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local effService = self._world:GetService("Effect")
  self._damageResultsByPos = {}
  local resultsArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  self:_ParseResultsArray(resultsArray)
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local gridDataArray = scopeResult:GetAttackRange()
  local groupDelay = phaseParam:GetGroupAtkDelay()
  local hitAnimationName = phaseParam:GetHitAnimation()
  local hitEffectID = phaseParam:GetHitEffectID()
  local boardServiceRender = self._world:GetService("BoardRender")
  for _, posList in ipairs(gridDataArray) do
    local centerPos = boardServiceRender:GetPosListCenter(posList)
    effService:CreateWorldPositionEffect(gridEffectID, centerPos, true)
    for _, pos in ipairs(posList) do
      local damageResult = self:_GetDamageResult(pos)
      if damageResult then
        self:_ShowDamage(damageResult, skillEffectResultContainer, hitAnimationName, hitEffectID, casterEntity, pos, phaseParam:HitTurnToTarget(), skillID)
      end
    end
    if 0 < groupDelay then
      YIELD(TT, groupDelay)
    end
  end
  local finishDelayTime = phaseParam:GetFinishDelayTime()
  if 0 < finishDelayTime then
    YIELD(TT, phaseParam:GetFinishDelayTime())
  end
end

function PlaySkillPhaseScopeGroup:_ShowDamage(damageResult, skillEffectResultContainer, hitAnimName, hitEffectID, casterEntity, gridPos, hitTurnToTarget, skillID)
  local targetEntityID = damageResult:GetTargetID()
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  if targetEntity ~= nil then
    local skillService = self:SkillService()
    local targetDamage = damageResult:GetDamageInfo(1)
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(gridPos):SetHandleBeHitParam_HitTurnTarget(hitTurnToTarget):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(skillEffectResultContainer:IsFinalAttack()):SetHandleBeHitParam_SkillID(skillID)
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      skillService:HandleBeHit(TT, beHitParam)
    end)
  end
end

function PlaySkillPhaseScopeGroup:_GetDamageResult(pos)
  for p, v in pairs(self._damageResultsByPos) do
    if p == pos and v.Index <= #v.DamageResults then
      local damageResult = v.DamageResults[v.Index]
      v.Index = v.Index + 1
      return damageResult
    end
  end
  return nil
end

function PlaySkillPhaseScopeGroup:_ParseResultsArray(resultsArray)
  if not resultsArray then
    Log.fatal("11111111")
    return
  end
  for _, result in ipairs(resultsArray) do
    local pos = result:GetGridPos()
    if pos then
      if not self._damageResultsByPos[pos] then
        self._damageResultsByPos[pos] = {
          Index = 1,
          DamageResults = {}
        }
      end
      table.insert(self._damageResultsByPos[pos].DamageResults, result)
    end
  end
end
