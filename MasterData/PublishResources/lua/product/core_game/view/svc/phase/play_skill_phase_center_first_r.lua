require("play_skill_phase_base_r")
_class("PlaySkillPhaseCenterFirst", PlaySkillPhaseBase)
PlaySkillPhaseCenterFirst = PlaySkillPhaseCenterFirst

function PlaySkillPhaseCenterFirst:PlayFlight(TT, casterEntity, phaseParam)
  self._damageStageIndex = phaseParam:GetdDmageStageIndex()
  local gridCenterEffectID = phaseParam:GetAtkCenterEffectID()
  local shandowCenterEffectID = phaseParam:GetAtkShandowCenterEffectID()
  local gridEffectID = phaseParam:GetAtkEffectID()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  self:InitSkillResult(skillEffectResultContainer)
  local gridDataArray = scopeResult:GetAttackRange()
  local centerPos = scopeResult:GetCenterPos()
  local playerEntity = self._world:Player():GetCurrentTeamEntity()
  local playerPos = playerEntity:GridLocation().Position
  local targetGirdList, maxLength, maxGridCount = InnerGameSortGridHelperRender:SortGrid(gridDataArray, centerPos)
  local effService = self._world:GetService("Effect")
  local centerDelay = phaseParam:GetCenterDelay()
  local hitAnimationName = phaseParam:GetHitAnimation()
  local hitEffectID = phaseParam:GetHitEffectID()
  local timeService = self._world:GetService("Time")
  local atkAnim = phaseParam:GetAtkAnimation()
  casterEntity:SetAnimatorControllerTriggers({atkAnim})
  local distanceDelay = phaseParam:GetDistanceDelay()
  local randomArray = phaseParam:GetRandomEffectIDs()
  local randomRequired = 0 < #randomArray
  local maxRandom = #randomArray
  for i = 1, maxGridCount do
    if i == 1 then
      if (centerPos.x == playerPos.x and centerPos.y == playerPos.y or shandowCenterEffectID == 0) and 0 < gridCenterEffectID then
        effService:CreateWorldPositionEffect(gridCenterEffectID, centerPos)
      elseif 0 < shandowCenterEffectID then
        effService:CreateWorldPositionEffect(shandowCenterEffectID, centerPos)
      end
    else
      for dir = 1, 8 do
        local t = targetGirdList[dir]
        if i <= #t.gridList then
          local gridPos = t.gridList[i]
          local fxid = gridEffectID
          if randomRequired then
            fxid = randomArray[math.random(1, maxRandom)]
          end
          local dx = t.direction.x
          local dy = t.direction.y
          local fxdir = Vector2.New(0 - dy, dx)
          effService:CreateWorldPositionDirectionEffect(fxid, gridPos, fxdir)
        end
      end
    end
    local waitTime = 0
    if i == 1 then
      waitTime = phaseParam:GetCenterHitDelay()
    else
      waitTime = phaseParam:GetOtherGridHitDelay()
    end
    for dir = 1, 8 do
      local t = targetGirdList[dir]
      if i <= #t.gridList then
        local gridPos = t.gridList[i]
        local damageResults = self:GetResultByGridPos(gridPos)
        if damageResults then
          for _, damageRes in ipairs(damageResults) do
            self:_ShowDamage(damageRes, skillEffectResultContainer, hitAnimationName, hitEffectID, casterEntity, gridPos, phaseParam:HitTurnToTarget(), skillID, waitTime)
          end
        end
      end
    end
    if i ~= maxGridCount then
      if i == 1 then
        YIELD(TT, centerDelay)
      elseif 0 < distanceDelay then
        YIELD(TT, distanceDelay)
      end
    end
  end
  local finishDelayTime = phaseParam:GetFinishDelayTime()
  if 0 < finishDelayTime then
    YIELD(TT, phaseParam:GetFinishDelayTime())
  end
end

function PlaySkillPhaseCenterFirst:_ShowDamage(damageResult, skillEffectResultContainer, hitAnimName, hitEffectID, casterEntity, gridPos, hitTurnToTarget, skillID, waitTime)
  local targetEntityID = damageResult:GetTargetID()
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  if targetEntity ~= nil then
    local skillService = self:SkillService()
    local targetDamage = damageResult:GetDamageInfo(1)
    local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
    local damageResultStageCount = skillEffectResultContainer:GetEffectResultsStageCount(SkillEffectType.Damage)
    local playFinalAttack = false
    if isFinalAttack and self._damageStageIndex == damageResultStageCount then
      playFinalAttack = true
    end
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      if 0 < waitTime then
        YIELD(TT, waitTime)
      end
      local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(gridPos):SetHandleBeHitParam_HitTurnTarget(hitTurnToTarget):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(playFinalAttack):SetHandleBeHitParam_SkillID(skillID)
      skillService:HandleBeHit(TT, beHitParam)
    end)
  end
end

function PlaySkillPhaseCenterFirst:InitSkillResult(skillEffectResultContainer)
  self._resultList = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, self._damageStageIndex)
end

function PlaySkillPhaseCenterFirst:GetResultByGridPos(gridPos)
  local resultArray = {}
  for _, result in ipairs(self._resultList) do
    local resultPos = result:GetGridPos()
    if resultPos.x == gridPos.x and resultPos.y == gridPos.y then
      table.insert(resultArray, result)
    end
  end
  return resultArray
end
