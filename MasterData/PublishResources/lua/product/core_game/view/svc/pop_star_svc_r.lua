_class("PopStarServiceRender", BaseService)
PopStarServiceRender = PopStarServiceRender

function PopStarServiceRender:CalculatePopStarConnectPieces(gridPos)
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local pieceType = env:GetPieceType(gridPos)
  local pieces = env:GetAllPieceType()
  local connMap = {}
  for x, _ in pairs(pieces) do
    connMap[x] = {}
  end
  local connectPieces = {}
  table.insert(connectPieces, gridPos)
  connMap[gridPos.x][gridPos.y] = true
  local utilDataSvc = self._world:GetService("UtilData")
  
  local function searchConnectPiece(center, next)
    for _, offset in ipairs(Offset4) do
      local pos = Vector2(center.x + offset[1], center.y + offset[2])
      if utilDataSvc:IsValidPiecePos(pos) then
        local connectPieceType = env:GetPieceType(pos)
        local pieceMatch = PopStarCanMatchPieceType(pieceType, connectPieceType)
        if not connMap[pos.x][pos.y] and pieceMatch then
          table.insert(connectPieces, pos)
          connMap[pos.x][pos.y] = true
          next(pos, next)
        end
      end
    end
  end
  
  searchConnectPiece(gridPos, searchConnectPiece)
  return connectPieces
end

function PopStarServiceRender:PreviewPopArea(connectPieces)
  local pieceService = self._world:GetService("Piece")
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, pieceEntity in ipairs(pieceGroup:GetEntities()) do
    local gridLocationCmpt = pieceEntity:GridLocation()
    local gridPos = gridLocationCmpt.Position
    if not table.icontains(connectPieces, gridPos) then
      pieceService:SetPieceAnimDark(gridPos)
    end
  end
end

function PopStarServiceRender:ShowPopGridNum(connectPieces)
  local utilDataSvc = self._world:GetService("UtilData")
  local superGridNum = 0
  for _, pos in ipairs(connectPieces) do
    local trapList = utilDataSvc:FindTrapByTypeAndPos(TrapType.PopStar_Super, pos)
    if trapList and 0 < #trapList then
      superGridNum = superGridNum + 1
    end
  end
  local gridNum = #connectPieces
  AudioHelperController.PlayInnerGameSfx(PopStarConst.PopStarSelectAudioID)
  self._world:EventDispatcher():Dispatch(GameEventType.PopStarShowPopNum, true, gridNum, superGridNum)
end

function PopStarServiceRender:ShowPreviewTrap(trapEntityID, gridPos, offset)
  local previewSvc = self._world:GetService("PreviewMonsterTrap")
  previewSvc:ShowPreviewTrap(trapEntityID, gridPos, offset)
end

function PopStarServiceRender:ClearPreviewPop(connectPieces)
  local mainCameraCmpt = self._world:MainCamera()
  mainCameraCmpt:EnableDarkCamera(false)
  local pieceService = self._world:GetService("Piece")
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, pieceEntity in ipairs(pieceGroup:GetEntities()) do
    local gridLocationCmpt = pieceEntity:GridLocation()
    local gridPos = gridLocationCmpt.Position
    if not table.icontains(connectPieces, gridPos) then
      pieceService:SetPieceAnimNormal(gridPos)
    end
  end
  self:_HidePopGridNum()
  self:ClearPreviewTrap()
end

function PopStarServiceRender:_HidePopGridNum()
  self._world:EventDispatcher():Dispatch(GameEventType.PopStarShowPopNum, false)
end

function PopStarServiceRender:ClearPreviewTrap()
  local previewSvc = self._world:GetService("PreviewMonsterTrap")
  previewSvc:ClearPreviewTrap()
end

function PopStarServiceRender:IsPosHasLockTrap(gridPos, delTrapList)
  for _, trapEntity in ipairs(delTrapList) do
    if trapEntity then
      local trapRCmpt = trapEntity:TrapRender()
      if trapRCmpt:GetTrapType() == TrapType.PopStar_Lock and gridPos == trapEntity:GetGridPosition() then
        return true
      end
    end
  end
  return false
end

function PopStarServiceRender:PopConnectPieces(TT, connectPieces, score, delTrapList)
  local utilDataSvc = self._world:GetService("UtilData")
  local pieceSvc = self._world:GetService("Piece")
  local index = 0
  if score < PopStarConst.PopStarPopCountList[1] then
    index = 1
  elseif score < PopStarConst.PopStarPopCountList[2] then
    index = 2
  elseif score < PopStarConst.PopStarPopCountList[3] then
    index = 3
  elseif score >= PopStarConst.PopStarPopCountList[3] then
    index = 4
  end
  if 0 < index then
    AudioHelperController.PlayInnerGameSfx(PopStarConst.PopStarPopAudioIDList[index])
  end
  local posList = {}
  local effectSvc = self._world:GetService("Effect")
  for _, gridPos in ipairs(connectPieces) do
    effectSvc:CreateWorldPositionEffect(PopStarConst.PopStarPopEffID, gridPos)
    local pieceEntity = pieceSvc:FindPieceEntity(gridPos)
    local worldPos = pieceEntity:View():GetGameObject().transform.position
    local uiWorldPos = self:CalcUIWorldPos(worldPos + Vector3(0, 0.5, 0))
    posList[#posList + 1] = uiWorldPos
  end
  if 0 < PopStarConst.PopStarPlayRankEffDelayTime then
    YIELD(TT, PopStarConst.PopStarPlayRankEffDelayTime)
  end
  self._world:EventDispatcher():Dispatch(GameEventType.PopStarPlayRankUIEff, score)
  if 0 < PopStarConst.PopStarPopEffInterval then
    YIELD(TT, PopStarConst.PopStarPopEffInterval)
  end
  local pieceService = self._world:GetService("Piece")
  for _, gridPos in ipairs(connectPieces) do
    local hasLockTrap = self:IsPosHasLockTrap(gridPos, delTrapList)
    if not hasLockTrap then
      pieceService:SetPieceAnimMoveDone(gridPos)
    end
  end
  if 0 < PopStarConst.PopStarGridDownInterval then
    YIELD(TT, PopStarConst.PopStarGridDownInterval)
  end
  self._world:EventDispatcher():Dispatch(GameEventType.PopStarPlayPopUIEff, posList)
  if 0 < PopStarConst.PopStarFlyInterval then
    YIELD(TT, PopStarConst.PopStarFlyInterval)
  end
end

function PopStarServiceRender:PlayPopStarResult(TT, result, isActive)
  if not result then
    return
  end
  local score = result:GetPopNum()
  if isActive then
    score = 0
  end
  self:PopConnectPieces(TT, result:GetPopConnectPieces(), score, result:GetDelTrapList())
  local isIndexChange = result:IsIndexChange()
  if isIndexChange then
    self._world:EventDispatcher():Dispatch(GameEventType.PopStarRefreshStageInfo)
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, NTPopStarScoreChange:New())
  if not isIndexChange then
    self._world:EventDispatcher():Dispatch(GameEventType.PopStarRefreshProgressInfo, result:GetPopNum())
  end
  YIELD(TT, PopStarConst.PopStarPopWaitTime)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local boardServiceR = self._world:GetService("BoardRender")
  local pool = {}
  for i, v in ipairs(result:GetDelSet()) do
    local pieceEntity = renderBoardCmpt:GetGridRenderEntity(v.pos)
    pieceEntity:SetViewVisible(false)
    renderBoardCmpt:RemoveGridRenderEntityData(v.pos)
    pool[i] = pieceEntity
  end
  local trapSvc = self._world:GetService("TrapRender")
  trapSvc:PlayTrapDieSkill(TT, result:GetDelTrapList())
  local moveGridDic, effGridList = self:_SortAllMoveGrid(result:GetMoveSet(), result:GetNewSet())
  local effectSvc = self._world:GetService("Effect")
  for _, gridPos in ipairs(effGridList) do
    effectSvc:CreateWorldPositionEffect(PopStarConst.PopStarGridFallEffID, gridPos)
  end
  YIELD(TT, PopStarConst.PopStarFallStartDelayTime)
  local moveEntities = {}
  local poolIndex = 1
  for _, posList in ipairs(moveGridDic) do
    for _, data in ipairs(posList) do
      poolIndex = self:PlayGridFall(TT, data.to, result, poolIndex, pool, moveEntities)
    end
    YIELD(TT, PopStarConst.PopStarMoveInterval)
  end
  while self:IsMoving(moveEntities) do
    YIELD(TT)
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, NTPopStarEnd:New(result:GetPopNum()))
end

function PopStarServiceRender:IsMoving(es)
  for _, e in ipairs(es) do
    if e:HasGridMove() then
      return true
    end
  end
end

function PopStarServiceRender:_GetNewTrapByPos(pos, result)
  local traps = {}
  for i, v in ipairs(result:GetNewTrapList()) do
    if v.pos == pos then
      traps[#traps + 1] = v.entity
    end
  end
  return traps
end

function PopStarServiceRender:_GetMoveDataByTargetPos(pos, result)
  for _, v in ipairs(result:GetMoveSet()) do
    if v.to == pos then
      return v
    end
  end
end

function PopStarServiceRender:_GetNewDataByTargetPos(pos, result)
  for _, v in ipairs(result:GetNewSet()) do
    if v.pos == pos then
      return v
    end
  end
end

function PopStarServiceRender:_GetMoveTrapDataByTargetPos(pos, result)
  local trapDatas = {}
  for i, v in ipairs(result:GetMoveTrapList()) do
    if v.to == pos then
      trapDatas[#trapDatas + 1] = v
    end
  end
  return trapDatas
end

function PopStarServiceRender:PopStarShowCasterEntity(petPstID)
  if self._world:MatchType() ~= MatchType.MT_PopStar then
    return
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityID = utilDataSvc:GetEntityIDByPstID(petPstID)
  local casterEntity = self._world:GetEntityByID(petEntityID)
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local pets = teamEntity:Team():GetTeamPetEntities()
  for _, e in ipairs(pets) do
    if casterEntity and casterEntity:GetID() == e:GetID() then
      e:SetViewVisible(true)
    else
      e:SetViewVisible(false)
    end
  end
end

function PopStarServiceRender:StopPreviewPopStar()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpResCmpt = renderBoardEntity:PopStarPickUpResult()
  if not pickUpResCmpt then
    return
  end
  local connectPieces = pickUpResCmpt:GetPopStarConnectPieces()
  self:ClearPreviewPop(connectPieces)
  pickUpResCmpt:ResetPopStarPickUp()
end

function PopStarServiceRender:CalcUIWorldPos(worldPos)
  local camera = self._world:MainCamera():Camera()
  local screenPos = camera:WorldToScreenPoint(worldPos)
  local uiCam = GameGlobal.UIStateManager():GetControllerCamera("UIBattle")
  local uiWorldPos = uiCam:ScreenToWorldPoint(screenPos)
  return Vector2(uiWorldPos.x, uiWorldPos.y)
end

function PopStarServiceRender:_SortAllMoveGrid(moveSet, newSet)
  local posDic = {}
  for _, v in ipairs(moveSet) do
    local columnIndex = v.to.x
    if not posDic[columnIndex] then
      posDic[columnIndex] = {}
    end
    table.insert(posDic[columnIndex], v)
  end
  for _, v in ipairs(newSet) do
    local columnIndex = v.pos.x
    if not posDic[columnIndex] then
      posDic[columnIndex] = {}
    end
    local vMove = {
      from = v.from,
      to = v.pos,
      color = v.color
    }
    table.insert(posDic[columnIndex], vMove)
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local effPosList = {}
  local maxCount = 0
  for k, list in pairs(posDic) do
    table.sort(list, function(dataA, dataB)
      return dataA.to.y < dataB.to.y
    end)
    effPosList[#effPosList + 1] = Vector2(k, utilDataSvc:GetMaxYOfColX(k))
    maxCount = math.max(maxCount, table.count(list))
  end
  local movePosDic = {}
  for i = 1, maxCount do
    movePosDic[i] = {}
    for _, list in pairs(posDic) do
      if list[i] then
        table.insert(movePosDic[i], list[i])
      end
    end
  end
  return movePosDic, effPosList
end

function PopStarServiceRender:PlayGridFall(TT, gridTargetPos, result, poolIndex, pool, moveEntities)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local boardServiceR = self._world:GetService("BoardRender")
  local trapSvc = self._world:GetService("TrapRender")
  local pieceService = self._world:GetService("Piece")
  local speed = 1 / (PopStarConst.PopStarMoveOneGridTime / 1000)
  local moveData = self:_GetMoveDataByTargetPos(gridTargetPos, result)
  if moveData then
    local gridEntity = renderBoardCmpt:GetGridRenderEntity(moveData.from)
    gridEntity:AddGridMove(speed, moveData.to, moveData.from)
    moveEntities[#moveEntities + 1] = gridEntity
    gridEntity:SetGridPosition(moveData.to)
    renderBoardCmpt:SetGridRenderEntityData(moveData.to, gridEntity)
  end
  local newData = self:_GetNewDataByTargetPos(gridTargetPos, result)
  if newData then
    local gridEntity = pool[poolIndex]
    poolIndex = poolIndex + 1
    pieceService:SetPieceEntityPieceType(gridEntity, newData.color)
    gridEntity:SetGridPosition(newData.pos)
    gridEntity:SetPosition(newData.from)
    gridEntity:SetViewVisible(true)
    local traps = self:_GetNewTrapByPos(newData.pos, result)
    for _, trap in ipairs(traps) do
      trapSvc:CreateSingleTrapRender(TT, trap, true)
      trap:SetPosition(newData.from)
      trap:SetViewVisible(true)
      renderBoardCmpt:SetGridRenderEntityData(newData.pos, trap)
    end
    if newData.pos ~= newData.from then
      gridEntity:AddGridMove(speed, newData.pos, newData.from)
      moveEntities[#moveEntities + 1] = gridEntity
      for _, trap in ipairs(traps) do
        local isPieceExtraLayerTrap = trapSvc:IsPieceExtraLayerTrap(trap)
        if isPieceExtraLayerTrap == false then
          trap:AddGridMove(speed, newData.pos, newData.from)
          moveEntities[#moveEntities + 1] = trap
        end
      end
    end
    renderBoardCmpt:SetGridRenderEntityData(newData.pos, gridEntity)
  end
  for _, v in ipairs(self:_GetMoveTrapDataByTargetPos(gridTargetPos, result)) do
    local trapEntity = v.entity
    local isPieceExtraLayerTrap = trapSvc:IsPieceExtraLayerTrap(trapEntity)
    if isPieceExtraLayerTrap == false then
      trapEntity:AddGridMove(speed, v.to, v.from)
      moveEntities[#moveEntities + 1] = trapEntity
    end
    if trapEntity:HasTrapRoundInfoRender() then
      local eid = trapEntity:TrapRoundInfoRender():GetRoundInfoEntityID()
      if eid then
        local eff = self._world:GetEntityByID(eid)
        eff:AddGridMove(speed, v.to, v.from)
      end
    end
    local cEffectHolder = trapEntity:EffectHolder()
    if cEffectHolder then
      local effectList = cEffectHolder:GetIdleEffect()
      if table.count(effectList) > 0 then
        for i, eff in ipairs(effectList) do
          local effectEntity = self._world:GetEntityByID(eff)
          if effectEntity and effectEntity:HasView() then
            local curGridPos = boardServiceR:GetRealEntityGridPos(effectEntity)
            local newGridPos = curGridPos + Vector2(v.to.x - v.from.x, v.to.y - v.from.y)
            effectEntity:AddGridMove(speed, newGridPos, curGridPos)
          end
        end
      end
    end
  end
  return poolIndex
end
