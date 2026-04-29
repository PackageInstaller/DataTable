require("play_skill_phase_base_r")
_class("PlaySkillScopeForwardTransformPhase", PlaySkillPhaseBase)
PlaySkillScopeForwardTransformPhase = PlaySkillScopeForwardTransformPhase

function PlaySkillScopeForwardTransformPhase:PlayFlight(TT, casterEntity, phaseParam)
  local scopeForwardParam = phaseParam
  local gridEffectIDs = scopeForwardParam:GetGridEffectIDs()
  local bestEffectTime = scopeForwardParam:GetBestEffectTime()
  local gridIntervalTime = scopeForwardParam:GetGridIntervalTime()
  local hasDamage = scopeForwardParam:HasDamage()
  local hasConvert = scopeForwardParam:HasConvert()
  local hitAnimationName = scopeForwardParam:GetHitAnimationName()
  local hitEffectID = scopeForwardParam:GetHitEffectID()
  local effectDirection = scopeForwardParam:GetEffectDirection()
  local effectIgnore = scopeForwardParam:GetEffectIgnore()
  local castPos = casterEntity:GridLocation().Position
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local gridDataArray = scopeResult:GetAttackRange()
  local targetGridType, convertGridArray
  if hasConvert then
    local convertResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ConvertGridElement)
    targetGridType = convertResult:GetTargetElementType()
    convertGridArray = convertResult:GetTargetGridArray()
  end
  local targetGirdList, _, maxGridCount = InnerGameSortGridHelperRender:SortGrid(gridDataArray, castPos)
  local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
  if isFinalAttack then
    local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
    local targetEntityID = self:_SortDistanceForFinalAttack(castPos, damageResultArray)
    skillEffectResultContainer:SetFinalAttackEntityID(targetEntityID)
  end
  local bottom = 0
  local top = 0
  local castPos = casterEntity:GridLocation().Position
  for _, _gridPos in ipairs(gridDataArray) do
    local deltaY = _gridPos.y - castPos.y
    if 0 < deltaY and top < deltaY then
      top = deltaY
    elseif deltaY < 0 and bottom > deltaY then
      bottom = deltaY
    end
  end
  local pieceService = self._world:GetService("Piece")
  local tConvertInfo = {}
  local tidHitTask = {}
  for i = 1, maxGridCount do
    for dir = 1, 8 do
      local t = targetGirdList[dir]
      if i <= #t.gridList then
        local gridPos = t.gridList[i]
        if effectIgnore < i then
          local effID, dir, scale = self:_CalculateEffect(castPos, gridPos, scopeForwardParam, top, bottom)
          if hasConvert then
            local needConvert = convertGridArray and table.icontains(convertGridArray, gridPos)
            if not scopeForwardParam:IsNeedRotateEff() then
              dir = nil
            end
            GameGlobal.TaskManager():CoreGameStartTask(self._SingleGridEffectTranform, self, effID, gridPos, bestEffectTime, targetGridType, dir, scale, needConvert)
            local nOldGridType = PieceType.None
            local gridEntity = pieceService:FindPieceEntity(gridPos)
            local pieceCmpt = gridEntity:Piece()
            nOldGridType = pieceCmpt:GetPieceType()
            local convertInfo = NTGridConvert_ConvertInfo:New(gridPos, nOldGridType, targetGridType)
            table.insert(tConvertInfo, convertInfo)
          elseif scopeForwardParam:IsNeedRotateEff() then
            self._world:GetService("Effect"):CreateWorldPositionDirectionEffect(effID, gridPos, t.direction + self:_GetDirection(effectDirection))
          else
            self._world:GetService("Effect"):CreateWorldPositionEffect(effID, gridPos)
          end
        end
        if hasDamage then
          local damageResult = skillEffectResultContainer:GetEffectResultByPos(SkillEffectType.Damage, gridPos)
          if damageResult then
            local tid = self:_ShowDamage(damageResult, skillEffectResultContainer, hitAnimationName, hitEffectID, casterEntity, gridPos, scopeForwardParam:HitTurnToTarget(), skillID)
            if tid then
              table.insert(tidHitTask, tid)
            end
          end
        end
      end
    end
    if i ~= maxGridCount then
      YIELD(TT, gridIntervalTime)
    end
  end
  local finishDelayTime = scopeForwardParam:GetFinishDelayTime()
  YIELD(TT, finishDelayTime)
  while not TaskHelper:GetInstance():IsAllTaskFinished(tidHitTask) do
    YIELD(TT)
  end
  if 0 < #tConvertInfo then
    local svcPlayBuff = self._world:GetService("PlayBuff")
    local notify = NTGridConvert:New(casterEntity, tConvertInfo)
    notify:SetConvertEffectType(SkillEffectType.ConvertGridElement)
    notify.__attackPosMatchRequired = true
    svcPlayBuff:PlayBuffView(TT, notify)
  end
end

function PlaySkillScopeForwardTransformPhase:_ShowDamage(damageResult, skillEffectResultContainer, hitAnimName, hitEffectID, casterEntity, gridPos, hitTurnToTarget, skillID)
  local targetEntityID = damageResult:GetTargetID()
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  if targetEntity ~= nil then
    local targetDamage = damageResult:GetDamageInfo(1)
    Log.debug("[skill] PlaySkillService:_HandlePlayFlyAttack ", targetEntityID, hitAnimName)
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(gridPos):SetHandleBeHitParam_HitTurnTarget(hitTurnToTarget):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(skillEffectResultContainer:IsFinalAttack()):SetHandleBeHitParam_SkillID(skillID)
    GameGlobal.TaskManager():CoreGameStartTask(self:SkillService().HandleBeHit, self:SkillService(), beHitParam)
  end
end

function PlaySkillScopeForwardTransformPhase:_GetDirection(effectDirection)
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

function PlaySkillScopeForwardTransformPhase:_SortDistanceForFinalAttack(castPos, damageResultArray)
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

function PlaySkillScopeForwardTransformPhase:_CalcDistanceToCaster(castPos, skillDamageResult)
  local gridPos = skillDamageResult:GetGridPos()
  return Vector2.Distance(gridPos, castPos)
end

function PlaySkillScopeForwardTransformPhase:_CalculateEffect(castPos, gridPos, phaseParam, topEdge, bottomEdge)
  local effID, dir, scale
  local deltaPos = gridPos - castPos
  dir = Vector2.Normalize(deltaPos)
  local layer = math.max(math.abs(deltaPos.x), math.abs(deltaPos.y))
  local scaleStart = phaseParam:GetEffectStart()
  local scaleDefault = phaseParam:GetDefaultScale()
  local layerScale = phaseParam:GetLayerScale()
  local _scale = 0
  if layer >= scaleStart then
    _scale = scaleDefault + (layer - scaleStart) * layerScale
  else
    _scale = scaleDefault
  end
  scale = Vector3(_scale, _scale, _scale)
  if deltaPos.y == topEdge and 0 < topEdge then
    effID = phaseParam:GetGridEdgeEffect()
  elseif deltaPos.y == bottomEdge and bottomEdge < 0 then
    effID = phaseParam:GetGridEdgeEffect()
  else
    local effs = phaseParam:GetGridEffectIDs()
    local gridCount = #effs
    local effIdx = deltaPos.y % gridCount
    if effIdx == 0 then
      effIdx = gridCount
    end
    effID = effs[effIdx]
  end
  return effID, dir, scale
end

function PlaySkillScopeForwardTransformPhase:_SingleGridEffectTranform(TT, gridEffectID, gridPos, bestEffectTime, targetGridType, dir, scale, needConvert)
  local effEntity = self._world:GetService("Effect"):CreateTransformEffect(gridEffectID, gridPos, dir, scale)
  if not needConvert then
    return
  end
  YIELD(TT, bestEffectTime)
  local boardService = self._world:GetService("BoardRender")
  boardService:ReCreateGridEntity(targetGridType, gridPos, false)
  YIELD(TT)
  local piece_service = self._world:GetService("Piece")
  if piece_service then
    piece_service:RefreshPieceAnim()
  end
end
