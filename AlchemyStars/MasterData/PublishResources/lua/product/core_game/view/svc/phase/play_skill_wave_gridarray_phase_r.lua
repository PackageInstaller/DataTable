require("play_skill_phase_base_r")
_class("PlaySkillWaveGridArrayPhase", PlaySkillPhaseBase)
PlaySkillWaveGridArrayPhase = PlaySkillWaveGridArrayPhase

function PlaySkillWaveGridArrayPhase:PlayFlight(TT, casterEntity, phaseParam)
  local waveGridArrayParam = phaseParam
  local columnInternalTime = waveGridArrayParam:GetColumnInternalTime()
  local waveGridEffectID = waveGridArrayParam:GetGridEffectID()
  local hitAnimName = waveGridArrayParam:GetHitAnimName()
  local hitEffectID = waveGridArrayParam:GetHitEffectID()
  local gridEffectWaitTime = waveGridArrayParam:GetGridWaitEffectTime()
  local hitWaitTime = waveGridArrayParam:GetHitWaitTime()
  local castPos = casterEntity:GridLocation().Position
  local taskIDList = {}
  local finalDamageColumn = -1
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local isFinalDamage = skillEffectResultContainer:IsFinalAttack()
  if isFinalDamage == true then
    finalDamageColumn = self:_FindLastDamageColumn(casterEntity, castPos)
  end
  self:_HandlePlayColumnEffect(casterEntity, castPos.x, waveGridEffectID, hitAnimName, hitEffectID, hitWaitTime, taskIDList, false, finalDamageColumn, phaseParam)
  if 0 < columnInternalTime then
    YIELD(TT, columnInternalTime)
  end
  local area = casterEntity:AttackArea():GetAttackArea()
  local leftColumn = castPos.x - 1
  local rightColumn = castPos.x + 1
  local boardServiceRender = self._world:GetService("BoardRender")
  local leftColumnValid = boardServiceRender:CheckColumnBoundary(leftColumn, area)
  local rightColumnValid = boardServiceRender:CheckColumnBoundary(rightColumn, area)
  while leftColumnValid or rightColumnValid do
    if leftColumnValid then
      self:_HandlePlayColumnEffect(casterEntity, leftColumn, waveGridEffectID, hitAnimName, hitEffectID, hitWaitTime, taskIDList, true, finalDamageColumn, phaseParam)
    end
    if rightColumnValid then
      self:_HandlePlayColumnEffect(casterEntity, rightColumn, waveGridEffectID, hitAnimName, hitEffectID, hitWaitTime, taskIDList, false, finalDamageColumn, phaseParam)
    end
    leftColumn = leftColumn - 1
    rightColumn = rightColumn + 1
    leftColumnValid = boardServiceRender:CheckColumnBoundary(leftColumn, area)
    rightColumnValid = boardServiceRender:CheckColumnBoundary(rightColumn, area)
    if 0 < columnInternalTime then
      YIELD(TT, columnInternalTime)
    end
  end
  YIELD(TT, gridEffectWaitTime)
  local notFinished = true
  while notFinished do
    notFinished = false
    for i = 1, #taskIDList do
      if not TaskHelper:GetInstance():IsTaskFinished(taskIDList[i]) then
        notFinished = true
        break
      end
    end
    if notFinished then
      YIELD(TT)
    end
  end
end

function PlaySkillWaveGridArrayPhase:_HandlePlayColumnEffect(casterEntity, columnVal, gridEffectID, hitAnimName, hitEffectID, hitWaitTime, taskIDList, isLeft, finalDamageColumn, phaseParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scope = skillEffectResultContainer:GetScopeResult()
  local gridData = scope:GetAttackRange()
  local results = skillEffectResultContainer:GetEffectResultsAsPosDic(SkillEffectType.Damage)
  local castPos = casterEntity:GridLocation().Position
  local playSkillService = self._world:GetService("PlaySkill")
  local boardServiceRender = self._world:GetService("BoardRender")
  local finalAttackTargetEntityID = -1
  if columnVal == finalDamageColumn then
    finalAttackTargetEntityID = self:_FindFinalAttackTarget(gridData, columnVal, results)
  end
  for _, pos in ipairs(gridData) do
    if pos.x == columnVal and pos ~= castPos and boardServiceRender:IsInPlayerArea(pos) then
      local effectDir = Vector2(0, 0)
      if isLeft then
        effectDir = Vector2(0, -1)
      end
      self._world:GetService("Effect"):CreateWorldPositionDirectionEffect(gridEffectID, pos, effectDir)
      if results then
        local res = results[Vector2.Pos2Index(pos)]
        if res then
          do
            local targetEntityID = res:GetTargetID()
            taskIDList[#taskIDList + 1] = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
              if hitWaitTime and 0 < hitWaitTime then
                YIELD(TT, hitWaitTime)
              end
              local targetEntity = self._world:GetEntityByID(targetEntityID)
              local targetDamage = res:GetDamageInfo(1)
              local isFinalAttack = false
              if targetEntityID == finalAttackTargetEntityID then
                isFinalAttack = true
              end
              local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(pos):SetHandleBeHitParam_HitTurnTarget(phaseParam:HitTurnToTarget()):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(isFinalAttack):SetHandleBeHitParam_SkillID(skillID)
              self:SkillService():HandleBeHit(TT, beHitParam)
            end)
          end
        end
      end
    end
  end
end

function PlaySkillWaveGridArrayPhase:_FindLastDamageColumn(casterEntity, castPos)
  local lastDamageColumn = -1
  local isDamageColumn = self:_IsDamageColumn(casterEntity, castPos.x)
  if isDamageColumn == true then
    lastDamageColumn = castPos.x
  end
  local area = casterEntity:AttackArea():GetAttackArea()
  local leftColumn = castPos.x - 1
  local rightColumn = castPos.x + 1
  local boardServiceRender = self._world:GetService("BoardRender")
  local leftColumnValid = boardServiceRender:CheckColumnBoundary(leftColumn, area)
  local rightColumnValid = boardServiceRender:CheckColumnBoundary(rightColumn, area)
  while leftColumnValid == true or rightColumnValid == true do
    if leftColumnValid then
      isDamageColumn = self:_IsDamageColumn(casterEntity, leftColumn)
      if isDamageColumn == true then
        lastDamageColumn = leftColumn
      end
    end
    if rightColumnValid then
      isDamageColumn = self:_IsDamageColumn(casterEntity, rightColumn)
      if isDamageColumn == true then
        lastDamageColumn = rightColumn
      end
    end
    leftColumn = leftColumn - 1
    rightColumn = rightColumn + 1
    leftColumnValid = boardServiceRender:CheckColumnBoundary(leftColumn, area)
    rightColumnValid = boardServiceRender:CheckColumnBoundary(rightColumn, area)
  end
  return lastDamageColumn
end

function PlaySkillWaveGridArrayPhase:_IsDamageColumn(casterEntity, column)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = skillEffectResultContainer:GetEffectResultsAsPosDic(SkillEffectType.Damage)
  if nil == results then
    return false
  end
  local scope = skillEffectResultContainer:GetScopeResult()
  local gridData = scope:GetAttackRange()
  for _, pos in ipairs(gridData) do
    if pos.x == column and self:_IsDamagePos(pos, results) then
      return true
    end
  end
  return false
end

function PlaySkillWaveGridArrayPhase:_IsDamagePos(pos, results)
  if nil == results then
    return false
  end
  local res = results[Vector2.Pos2Index(pos)]
  if not res then
    return false
  end
  local targetEntityID = res:GetTargetID()
  local damage = res:GetDamageInfo(1)
  if targetEntityID == nil or damage == nil then
    return false
  end
  if 0 < targetEntityID and 0 < damage:GetDamageValue() then
    return true
  end
end

function PlaySkillWaveGridArrayPhase:_FindFinalAttackTarget(gridData, columnVal, results)
  if results == nil then
    return
  end
  local victimIDArray = {}
  local boardServiceRender = self._world:GetService("BoardRender")
  for _, pos in ipairs(gridData) do
    if pos.x == columnVal and boardServiceRender:IsInPlayerArea(pos) then
      local res = results[Vector2.Pos2Index(pos)]
      if res then
        local targetEntityID = res:GetTargetID()
        victimIDArray[#victimIDArray + 1] = targetEntityID
      end
    end
  end
  local playerEntity = self._world:Player():GetCurrentTeamEntity()
  local playerPos = playerEntity:GridLocation().Position
  
  local function CmpDistancefunc(entityID1, entityID2)
    local entity1 = self._world:GetEntityByID(entityID1)
    local entity2 = self._world:GetEntityByID(entityID2)
    local pos1 = entity1:GridLocation().Position
    local pos2 = entity2:GridLocation().Position
    local castPos = playerPos
    local dis1 = Vector2.Distance(castPos, pos1)
    local dis2 = Vector2.Distance(castPos, pos2)
    return dis1 > dis2
  end
  
  table.sort(victimIDArray, CmpDistancefunc)
  if 0 < #victimIDArray then
    return victimIDArray[1]
  end
end
