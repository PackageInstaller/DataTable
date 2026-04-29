require("play_skill_phase_base_r")
_class("PlaySkillScopeForwardTransformNoAttackPhase", PlaySkillPhaseBase)
PlaySkillScopeForwardTransformNoAttackPhase = PlaySkillScopeForwardTransformNoAttackPhase

function PlaySkillScopeForwardTransformNoAttackPhase:PlayFlight(TT, casterEntity, phaseParam)
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
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local convertResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ConvertGridElement)
  local targetGridType = convertResult:GetTargetElementType()
  local gridDataArray = convertResult:GetTargetGridArray()
  local renderPickUpComponent = casterEntity:RenderPickUpComponent()
  local pickUpGridArray = renderPickUpComponent:GetAllValidPickUpGridPos()
  local pickUpGridPos = pickUpGridArray[1]
  local targetGirdList, f, maxGridCount = InnerGameSortGridHelperRender:SortGridWithCenterPos(gridDataArray, pickUpGridPos)
  local bottom = 0
  local top = 0
  local castPos = pickUpGridPos
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
    for dir = 1, 9 do
      local t = targetGirdList[dir]
      if i <= #t.gridList then
        local gridPos = t.gridList[i]
        if effectIgnore < i then
          local effID, dir, scale = self:_CalculateEffect(castPos, gridPos, scopeForwardParam, top, bottom)
          local needConvert = gridDataArray and table.icontains(gridDataArray, gridPos)
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
        end
      end
    end
    if i ~= maxGridCount then
      YIELD(TT, gridIntervalTime)
    end
  end
  local finishDelayTime = scopeForwardParam:GetFinishDelayTime()
  YIELD(TT, finishDelayTime)
  if 0 < #tConvertInfo then
    local svcPlayBuff = self._world:GetService("PlayBuff")
    local notify = NTGridConvert:New(casterEntity, tConvertInfo)
    notify:SetConvertEffectType(SkillEffectType.ConvertGridElement)
    notify.__attackPosMatchRequired = true
    svcPlayBuff:PlayBuffView(TT, notify)
  end
end

function PlaySkillScopeForwardTransformNoAttackPhase:_CalculateEffect(castPos, gridPos, phaseParam, topEdge, bottomEdge)
  local effID, dir, scale
  local deltaPos = gridPos - castPos
  dir = Vector2.Normalize(deltaPos)
  local layer = math.max(math.abs(deltaPos.x), math.abs(deltaPos.y))
  local scaleStart = phaseParam:GetEffectStart()
  local scaleDefault = phaseParam:GetDefaultScale()
  local layerScale = phaseParam:GetLayerScale()
  local scaleN = 0
  if layer >= scaleStart then
    scaleN = scaleDefault + (layer - scaleStart) * layerScale
  else
    scaleN = scaleDefault
  end
  scale = Vector3(scaleN, scaleN, scaleN)
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

function PlaySkillScopeForwardTransformNoAttackPhase:_SingleGridEffectTranform(TT, gridEffectID, gridPos, bestEffectTime, targetGridType, dir, scale, needConvert)
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
