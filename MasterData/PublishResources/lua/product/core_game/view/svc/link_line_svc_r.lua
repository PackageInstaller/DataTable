local GridRadiusType = {
  Default = 1,
  NearBy = 2,
  Diagonal = 3
}
_enum("GridRadiusType", GridRadiusType)
_class("LinkLineService", Object)
LinkLineService = LinkLineService

function LinkLineService:Constructor(world)
  self._world = world
end

function LinkLineService:IsTouchInPlayerTouchArea(touchPos, offset)
  local utilData = self._world:GetService("UtilData")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local pickUpType = self:GetCurPickUpType()
  if pickUpType == SkillPickUpType.Moye then
    return self:_MoyeCheckFirstPosition(touchPos)
  elseif pickUpType == SkillPickUpType.LinkLineSP then
    if not utilData:IsValidPiecePos(touchPos) or utilData:IsPosBlockLinkLineForChain(touchPos) then
      return false
    end
  elseif not utilData:IsValidPiecePos(touchPos) or utilData:IsPosBlockLinkLineForChain(touchPos) or table.count(self:_FindTrapByPos(touchPos)) > 0 and not utilScopeSvc:IsPosHaveMonsterOrPet(touchPos) then
    return false
  end
  local playerPosition = self:GetPlayerPos(pickUpType)
  local diff = touchPos - playerPosition
  if math.abs(diff.x) > 1 or 1 < math.abs(diff.y) then
    return false
  end
  if touchPos == playerPosition then
    return true
  end
  local guideService = self._world:GetService("Guide")
  if guideService:IsGuidePathInvokeType() then
    local inGuidePath = guideService:_CheckGuidePathHasPos(touchPos)
    if inGuidePath ~= true then
      return false
    end
    if touchPos ~= playerPosition then
      return false
    end
  end
  local touchRealPos = touchPos + offset
  local distance = Vector2.Distance(touchRealPos, playerPosition)
  if touchPos.x == playerPosition.x or touchPos.y == playerPosition.y then
    return distance < 1
  else
    return distance < Mathf.Sqrt(2)
  end
end

function LinkLineService:StartLinkLine(touchPos, offset)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeBossHPBuffButtonRayCast, false)
  local previewEntity = self._world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  local chainPath = previewChainPathCmpt:GetPreviewChainPath()
  if chainPath == nil then
    return false
  end
  local canMoveArrowService = self._world:GetService("CanMoveArrow")
  if canMoveArrowService then
    canMoveArrowService:ShowCanMoveArrow(false)
  end
  local guideService = self._world:GetService("Guide")
  guideService:HandleBeginDragTrigger(touchPos)
  local linkageRenderService = self._world:GetService("LinkageRender")
  linkageRenderService:DestroyAllLinkedNum()
  linkageRenderService:DestroyAllLinkLine()
  linkageRenderService:DestroyLinkedGridEffect()
  self:_DoDrag(touchPos, offset)
  self:_StartCameraMove()
  self:SetMonsterShadowPosListDown(false)
  self:ShowBoardPieceMap()
  self:StartBulletTime()
end

function LinkLineService:ShowBoardPieceMap()
  local utilData = self._world:GetService("UtilData")
  local mapByPosition = utilData:GetMapByPosition()
  if not mapByPosition or table.count(mapByPosition) == 0 then
    return
  end
  local boardServiceR = self._world:GetService("BoardRender")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  for posIndex, piece in pairs(mapByPosition) do
    local pos = Vector2.Index2Pos(posIndex)
    env:SetPieceType(pos, piece)
    boardServiceR:ReCreateGridEntity(piece, pos, false, true)
  end
end

function LinkLineService:CancelBoardPieceMap(chainPath)
  self:StopMapPieceFirstChainPathEffect()
  local utilData = self._world:GetService("UtilData")
  local mapByPosition = utilData:GetMapByPosition()
  if not mapByPosition or table.count(mapByPosition) == 0 then
    return
  end
  local boardServiceR = self._world:GetService("BoardRender")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  for posIndex, piece in pairs(mapByPosition) do
    local pos = Vector2.Index2Pos(posIndex)
    if not table.intable(chainPath, pos) then
      local pieceType = utilData:GetPieceType(pos)
      env:SetPieceType(pos, pieceType)
      boardServiceR:ReCreateGridEntity(pieceType, pos, false, true)
    end
  end
end

function LinkLineService:SetMonsterShadowPosListDown(animDown)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderChainPathComponent = renderBoardEntity:RenderChainPath()
  local pieceSvc = self._world:GetService("Piece")
  local chainAcrossMonster = renderChainPathComponent:GetChainAcrossMonster()
  if chainAcrossMonster then
    local monsterShadowPosList = renderChainPathComponent:GetChainMonsterShadowPosList()
    if not monsterShadowPosList or table.count(monsterShadowPosList) == 0 then
      monsterShadowPosList = pieceSvc:GetMonsterShadowPosList()
    end
    renderChainPathComponent:SetChainMonsterShadowPosList(monsterShadowPosList)
    for i, pos in ipairs(monsterShadowPosList) do
      if animDown then
        pieceSvc:SetPieceAnimDown(pos)
      else
        pieceSvc:SetPieceAnimNormal(pos)
      end
    end
  end
  local chainAcrossMonsterIDList = renderChainPathComponent:GetChainAcrossMonsterIDList()
  if chainAcrossMonsterIDList and table.count(chainAcrossMonsterIDList) > 0 then
    local selectMonsterShadowPosList = renderChainPathComponent:GetChainSelectMonsterShadowPosList()
    if not selectMonsterShadowPosList or table.count(selectMonsterShadowPosList) == 0 then
      selectMonsterShadowPosList = pieceSvc:GetSelectMonsterShadowPosList(chainAcrossMonsterIDList)
    end
    renderChainPathComponent:SetChainSelectMonsterShadowPosList(selectMonsterShadowPosList)
    for i, pos in ipairs(selectMonsterShadowPosList) do
      if animDown then
        pieceSvc:SetPieceAnimDown(pos)
      else
        pieceSvc:SetPieceAnimNormal(pos)
      end
    end
  end
  if animDown then
    renderChainPathComponent:SetConnectAreaRenderCantRefresh(true)
  end
end

function LinkLineService:StartBulletTime()
  local prvwEntity = self._world:GetPreviewEntity()
  prvwEntity:ReplaceBulletTime(true)
end

function LinkLineService:FinishBulletTime()
  local prvwEntity = self._world:GetPreviewEntity()
  prvwEntity:ReplaceBulletTime(false)
end

function LinkLineService:_DoDrag(touchPos, offset)
  local previewEntity = self._world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  local chainPath = previewChainPathCmpt:GetPreviewChainPath()
  local playerPosition = self._world:Player():GetLocalTeamEntity():GetGridPosition()
  Log.notice("begin touch in touchPlayer")
  local pieceService = self._world:GetService("Piece")
  local boardServiceRender = self._world:GetService("BoardRender")
  local utilDataSvc = self._world:GetService("UtilData")
  if not boardServiceRender:IsPosCanLinkLine(touchPos, chainPath) or utilDataSvc:IsPosBlockLinkLineForChain(touchPos) then
    return
  end
  local pieceSvc = self._world:GetService("Piece")
  local pieceEntity = pieceSvc:FindPieceEntity(touchPos)
  if not pieceEntity then
    Log.fatal("[touch] 连线坐标：" .. tostring(touchPos) .. " 位置的格子无法获取到！")
    return
  elseif touchPos ~= playerPosition then
    pieceService:SetPieceAnimLinkIn(touchPos)
  end
  if #chainPath == 0 then
    self:_InitChainPath(chainPath, playerPosition)
    self:CalcPathPoint(touchPos, offset)
    local linkageRenderService = self._world:GetService("LinkageRender")
    linkageRenderService:ShowLinkageInfo(chainPath)
    local reBoard = self._world:GetRenderBoardEntity()
    local previewChainSkillRangeCmpt = reBoard:PreviewChainSkillRange()
    previewChainSkillRangeCmpt:EnablePreviewChainSkillRange(true)
  end
end

function LinkLineService:_StartCameraMove(TT)
  local gridTouchComponent = self._world:GridTouch()
  local touchState = gridTouchComponent:GetGridTouchStateID()
  if touchState == GridTouchStateID.EndDrag or touchState == GridTouchStateID.DoubleClick then
    Log.notice("current is end drag state,stop insert chain path")
    return
  end
  local cameraCmpt = self._world:MainCamera()
  cameraCmpt:DoMoveCamera(true)
  self:AllMonsterAndTrapTrans(true)
end

function LinkLineService:_InitChainPath(chainPath, touchPosition)
  table.insert(chainPath, touchPosition)
  Log.debug("[touch] Init chain path insert ", table.tostring(chainPath))
  local elementType = PieceType.None
  local previewEntity = self._world:GetPreviewEntity()
  previewEntity:ReplacePreviewChainPath(chainPath, elementType, PieceType.None)
  local isLocal = self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FlushPetChainSkillItem, isLocal, #chainPath, elementType)
end

function LinkLineService:_OnPieceInsertIntoChain(chainPath)
  local boardsvc = self._world:GetService("BoardRender")
  local piecesvc = self._world:GetService("Piece")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  if 1 < #chainPath then
    local prismPos = chainPath[#chainPath]
    local prePos = chainPath[#chainPath - 1]
    if env:IsPrismPiece(prismPos) then
      boardsvc:ApplyPrism(prePos, prismPos)
    end
  end
end

function LinkLineService:_OnPieceRemoveFromChain(pos)
  local boardsvc = self._world:GetService("BoardRender")
  local piecesvc = self._world:GetService("Piece")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  if env:IsPrismPiece(pos) then
    boardsvc:UnapplyPrism(pos)
  end
end

function LinkLineService:CancelChainPath()
  if not self._world then
    return
  end
  local syncMoveServiceRender = self._world:GetService("SyncMoveRender")
  if syncMoveServiceRender then
    syncMoveServiceRender:ClearPreview()
  end
  local ePreview = self._world:GetPreviewEntity()
  if not ePreview then
    return
  end
  local cPreviewChainPath = ePreview:PreviewChainPath()
  if not cPreviewChainPath then
    return
  end
  local chainPath = cPreviewChainPath:GetPreviewChainPath()
  if chainPath then
    local sBoardRender = self._world:GetService("BoardRender")
    local cPreviewEnv = ePreview:PreviewEnv()
    local count = #chainPath
    for i = count, 1, -1 do
      local pos = chainPath[i]
      if cPreviewEnv and cPreviewEnv:IsPrismPiece(pos) then
        sBoardRender:UnapplyPrism(pos)
      end
    end
  end
  self:CancelBoardPieceMap(chainPath)
  self:AllMonsterAndTrapTrans(false)
end

function LinkLineService:QuickResponse(chainpath, touchpos, pieceType)
  local boardServiceRender = self._world:GetService("BoardRender")
  if not chainpath then
    return nil
  end
  if not boardServiceRender:IsSameCrossPos(chainpath[#chainpath], touchpos) then
    return nil
  end
  local lastPos = chainpath[#chainpath]
  local utilData = self._world:GetService("UtilData")
  if lastPos.x == touchpos.x then
    local step = lastPos.y > touchpos.y and -1 or 1
    for y = lastPos.y + step, touchpos.y, step do
      local pos = Vector2(lastPos.x, y)
      if not (not table.icontains(chainpath, pos) and utilData:IsValidPiecePos(pos) and boardServiceRender:IsPosCanLinkLine(pos, chainpath) and not utilData:IsPosBlockLinkLineForChain(pos) and utilData:IsEnoughStepToLinkMore(chainpath)) then
        break
      end
      local newPieceType = self:InsertPieceToChainPath(chainpath, pos, pieceType)
      if not newPieceType then
        break
      end
      if newPieceType and pieceType ~= newPieceType then
        Log.info("QuickResponse ChangeChainPath PieceType  OldTYpe:", pieceType, "NewType:", newPieceType)
        pieceType = newPieceType
      end
    end
  elseif lastPos.y == touchpos.y then
    local step = lastPos.x > touchpos.x and -1 or 1
    for x = lastPos.x + step, touchpos.x, step do
      local pos = Vector2(x, lastPos.y)
      if not (not table.icontains(chainpath, pos) and utilData:IsValidPiecePos(pos) and boardServiceRender:IsPosCanLinkLine(pos, chainpath) and not utilData:IsPosBlockLinkLineForChain(pos) and utilData:IsEnoughStepToLinkMore(chainpath)) then
        break
      end
      local newPieceType = self:InsertPieceToChainPath(chainpath, pos, pieceType)
      if not newPieceType then
        break
      end
      if newPieceType and pieceType ~= newPieceType then
        Log.info("QuickResponse ChangeChainPath PieceType  OldTYpe:", pieceType, "NewType:", newPieceType)
        pieceType = newPieceType
      end
    end
  end
end

function LinkLineService:GetPlayerPos(pickUpType)
  local playerPosition = self._world:Player():GetLocalTeamEntity():GetGridPosition()
  pickUpType = pickUpType or self:GetCurPickUpType()
  if pickUpType == SkillPickUpType.LinkLineSP then
    playerPosition = self:_ActiveSkillLineLineCheckFirstPosition()
  end
  return playerPosition
end

function LinkLineService:CalcPathPoint(touchPos, offset)
  local playerPosition = self:GetPlayerPos()
  local previewEntity = self._world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  local chainPath = previewChainPathCmpt:GetPreviewChainPath()
  local pieceType = previewChainPathCmpt:GetPreviewPieceType()
  previewChainPathCmpt:SetMoveBack(false)
  if chainPath == nil or #chainPath == 0 then
    return
  end
  local chainPathCount = #chainPath
  local utilDataSvc = self._world:GetService("UtilData")
  local boardServiceRender = self._world:GetService("BoardRender")
  if not boardServiceRender:IsPosCanLinkLine(touchPos, chainPath) or utilDataSvc:IsPosBlockLinkLineForChain(touchPos) then
    return
  end
  local radiusType = previewChainPathCmpt:GetGridRadius(touchPos)
  local radius = self:GetRadius(radiusType)
  local offsetLen = Vector2.Magnitude(offset)
  local lastLinkPosition = chainPath[chainPathCount]
  local lastButOneLinkPosition = chainPath[chainPathCount - 1]
  local isLocal = self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn
  if 1 < chainPathCount and touchPos == lastButOneLinkPosition then
    previewChainPathCmpt:SetMoveBack(true)
    if radius > offsetLen then
      local lastElementType
      lastElementType, pieceType = self:_UndoLink(chainPath, pieceType)
      self:UpdateLastPathAroundRadius(chainPath, pieceType, lastElementType)
      local firstElementType, firstElementIndex = previewChainPathCmpt:GetFirstElementData()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FlushPetChainSkillItem, isLocal, chainPathCount, pieceType, firstElementType)
      local linkageRenderService = self._world:GetService("LinkageRender")
      linkageRenderService:ShowLinkageInfo(chainPath, pieceType)
      linkageRenderService:HideBenumbTips()
      linkageRenderService:HideTrapWallBlock()
    end
    return
  end
  local goBackCount = self:QuickGoBack(chainPath, touchPos)
  if goBackCount and goBackCount ~= 0 then
    previewChainPathCmpt:SetMoveBack(true)
    local lastElementType
    for i = 1, goBackCount do
      lastElementType, pieceType = self:_UndoLink(chainPath, pieceType)
    end
    self:UpdateLastPathAroundRadius(chainPath, pieceType, lastElementType)
    local firstElementType, firstElementIndex = previewChainPathCmpt:GetFirstElementData()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FlushPetChainSkillItem, isLocal, chainPathCount, pieceType, firstElementType)
    local linkageRenderService = self._world:GetService("LinkageRender")
    linkageRenderService:ShowLinkageInfo(chainPath, pieceType)
    linkageRenderService:HideBenumbTips()
    linkageRenderService:HideTrapWallBlock()
    return
  end
  if touchPos == lastLinkPosition then
    return
  else
    if not utilDataSvc:IsEnoughStepToLinkMore(chainPath) then
      return
    end
    if utilDataSvc:IsAdjacentPos(lastLinkPosition, touchPos) then
      if radius <= offsetLen then
        return
      end
      local autoLinkPos
      if 0 < chainPathCount then
        autoLinkPos = self:_NeedAutoLink(touchPos, chainPath[chainPathCount], pieceType, offset)
        if autoLinkPos ~= nil then
          if playerPosition == autoLinkPos then
            return
          end
          touchPos = autoLinkPos
        elseif radius < offsetLen then
          return
        end
      end
      self:InsertPieceToChainPath(chainPath, touchPos, pieceType)
    else
      self:QuickResponse(chainPath, touchPos, pieceType)
    end
  end
end

function LinkLineService:IsNeedShowLinkageNumForCostStep()
  local utilDataSvc = self._world:GetService("UtilData")
  return utilDataSvc:IsNeedShowLinkageNumForCostStep()
end

function LinkLineService:_IsElementMatchForLink(touchPosition, pieceType)
  if self:IsNeedShowLinkageNumForCostStep() then
    return true
  else
    return self:_IsElementMatch(touchPosition, pieceType)
  end
end

function LinkLineService:_IsElementMatch(touchPosition, pieceType)
  local utilDataSvc = self._world:GetService("UtilData")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local elementType = env:GetPieceType(touchPosition)
  if utilDataSvc:IgnoreElementMatchOnPos(touchPosition) then
    return true
  end
  if pieceType == PieceType.None then
    return false
  end
  if pieceType == PieceType.Any or elementType == PieceType.Any then
    return true
  end
  if utilDataSvc:IsPosCanMapOtherPiece(touchPosition, pieceType, elementType) then
    return true
  end
  if elementType ~= pieceType then
    return false
  end
  return true
end

function LinkLineService:_UndoLink(chainPath, pieceType)
  local utilData = self._world:GetService("UtilData")
  local superChainCount = utilData:GetCurrentTeamSuperChainCount()
  local boardServiceR = self._world:GetService("BoardRender")
  local utilDataSvc = self._world:GetService("UtilData")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local lastPieceType = pieceType
  local linkLineIndex = #chainPath - 2
  if superChainCount < linkLineIndex then
    linkLineIndex = superChainCount
  end
  if 1 <= linkLineIndex then
    AudioHelperController.PlayInnerGameSfx(linkLineIndex + CriAudioIDConst.SoundCoreGameLinkLineStart - 1)
  end
  local pos = chainPath[#chainPath]
  local pieceSvc = self._world:GetService("Piece")
  local pieceEntity = pieceSvc:FindPieceEntity(pos)
  if pieceEntity then
    self:_OnPieceRemoveFromChain(pos)
  end
  table.remove(chainPath, #chainPath)
  local featureRender = self._world:GetService("FeatureRender")
  if featureRender then
    featureRender:OnLinkLineChainPathChange(chainPath)
  end
  local lastpos = chainPath[#chainPath]
  local lastElementType = env:GetPieceType(lastpos)
  local isFirstStepUseMapPiece = false
  if #chainPath == 2 then
    local firstLinkMapPiece = utilDataSvc:GetMapForFirstChainPath()
    if firstLinkMapPiece then
      lastElementType = firstLinkMapPiece
      isFirstStepUseMapPiece = true
    end
  end
  local canMapOtherPiece = false
  if not isFirstStepUseMapPiece then
    canMapOtherPiece = utilDataSvc:IsPosCanMapOtherPiece(lastpos, pieceType, lastElementType)
  end
  if #chainPath == 1 then
    pieceType = PieceType.None
    self:StopMapPieceFirstChainPathEffect()
  elseif lastElementType == PieceType.Any or canMapOtherPiece then
    local pos = Vector2(0, 0)
    local elementType = PieceType.None
    local needreplace = true
    for index = 2, #chainPath do
      pos = chainPath[index]
      elementType = env:GetPieceType(pos)
      if index == 2 then
        local firstLinkMapPiece = utilDataSvc:GetMapForFirstChainPath()
        if firstLinkMapPiece then
          elementType = firstLinkMapPiece
        end
      end
      if elementType ~= PieceType.Any then
        needreplace = false
        break
      end
    end
    if needreplace then
      pieceType = PieceType.Any
    end
  end
  local isTwoColorChain = self:IsTwoColorChain()
  if isTwoColorChain and lastElementType ~= pieceType and #chainPath == 2 then
    pieceType = lastElementType
  end
  return lastPieceType, pieceType
end

function LinkLineService:_NeedAutoLink(touchPosition, lastPosition, pieceType, offset)
  local autoLinkPos
  local utilDataSvc = self._world:GetService("UtilData")
  local boardServiceRender = self._world:GetService("BoardRender")
  local utilDataSvc = self._world:GetService("UtilData")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local isElementMatch = self:_IsElementMatchForLink(touchPosition, pieceType)
  if isElementMatch == true then
    return autoLinkPos
  end
  local deltaPos = lastPosition - touchPosition
  if (math.abs(deltaPos.x) ~= 0 or math.abs(deltaPos.y) ~= 1) and (math.abs(deltaPos.x) ~= 1 or math.abs(deltaPos.y) ~= 0) then
    return autoLinkPos
  end
  if math.abs(deltaPos.y) == 1 then
    local leftPos = Vector2(touchPosition.x - 1, touchPosition.y)
    local rightPos = Vector2(touchPosition.x + 1, touchPosition.y)
    local leftPieceType = env:GetPieceType(leftPos)
    local rightPieceType = env:GetPieceType(rightPos)
    if leftPieceType == pieceType then
      if offset.x < 0 then
        autoLinkPos = leftPos
      end
    elseif rightPieceType == pieceType and offset.x > 0 then
      autoLinkPos = rightPos
    end
  elseif math.abs(deltaPos.x) == 1 then
    local topPos = Vector2(touchPosition.x, touchPosition.y + 1)
    local downPos = Vector2(touchPosition.x, touchPosition.y - 1)
    local topPieceType = env:GetPieceType(topPos)
    local downPieceType = env:GetPieceType(downPos)
    if topPieceType == pieceType then
      if 0 < offset.y then
        autoLinkPos = topPos
      end
    elseif downPieceType == pieceType and 0 > offset.y then
      autoLinkPos = downPos
    end
  end
  if autoLinkPos then
    local previewEntity = self._world:GetPreviewEntity()
    local previewChainPathCmpt = previewEntity:PreviewChainPath()
    local chainPath = previewChainPathCmpt:GetPreviewChainPath()
    if not (utilDataSvc:IsValidPiecePos(autoLinkPos) and boardServiceRender:IsPosCanLinkLine(autoLinkPos, chainPath)) or utilDataSvc:IsPosBlockLinkLineForChain(autoLinkPos) then
      return nil
    end
  end
  return autoLinkPos
end

function LinkLineService:_CalcNextGrid(offset, touchPosition)
  local up = Vector3(0, 0, 1)
  local newOffset = Vector3(offset.x, 0, offset.y)
  local angle = Vector3.Angle(up, newOffset)
  local crossVal = Vector3.Cross(up, newOffset)
  if 0 > crossVal.y then
    return self:_SelectLeftGrid(angle, touchPosition)
  else
    return self:_SelectRightGrid(angle, touchPosition)
  end
end

function LinkLineService:_CreateSensingArea(direction)
  local str_angle = Cfg.cfg_link_line_sensing_area[1].angle
  local angles = string.split(str_angle, "|")
  local line_angles = {}
  local count_angles = 0
  count_angles = tonumber(angles[1]) / 2
  table.insert(line_angles, count_angles)
  if direction == "Right" then
    count_angles = count_angles + tonumber(angles[2])
    table.insert(line_angles, count_angles)
    count_angles = count_angles + tonumber(angles[3])
    table.insert(line_angles, count_angles)
    count_angles = count_angles + tonumber(angles[4])
    table.insert(line_angles, count_angles)
    count_angles = count_angles + tonumber(angles[5]) / 2
    table.insert(line_angles, count_angles)
  elseif direction == "Left" then
    count_angles = count_angles + tonumber(angles[8])
    table.insert(line_angles, count_angles)
    count_angles = count_angles + tonumber(angles[7])
    table.insert(line_angles, count_angles)
    count_angles = count_angles + tonumber(angles[6])
    table.insert(line_angles, count_angles)
    count_angles = count_angles + tonumber(angles[5]) / 2
    table.insert(line_angles, count_angles)
  end
  return line_angles
end

function LinkLineService:_SelectRightGrid(angle, touchPosition)
  local angles = self:_CreateSensingArea("Right")
  local nextTouchPosition
  if 0 <= angle and angle < angles[1] then
    nextTouchPosition = Vector2(touchPosition.x, touchPosition.y + 1)
  elseif angle >= angles[1] and angle < angles[2] then
    nextTouchPosition = Vector2(touchPosition.x + 1, touchPosition.y + 1)
  elseif angle >= angles[2] and angle < angles[3] then
    nextTouchPosition = Vector2(touchPosition.x + 1, touchPosition.y)
  elseif angle >= angles[3] and angle < angles[4] then
    nextTouchPosition = Vector2(touchPosition.x + 1, touchPosition.y - 1)
  else
    if angle >= angles[4] and angle <= angles[5] then
      nextTouchPosition = Vector2(touchPosition.x, touchPosition.y - 1)
    else
    end
  end
  return nextTouchPosition
end

function LinkLineService:_SelectLeftGrid(angle, touchPosition)
  local angles = self:_CreateSensingArea("Left")
  local nextTouchPosition
  if 0 <= angle and angle < angles[1] then
    nextTouchPosition = Vector2(touchPosition.x, touchPosition.y + 1)
  elseif angle >= angles[1] and angle < angles[2] then
    nextTouchPosition = Vector2(touchPosition.x - 1, touchPosition.y + 1)
  elseif angle >= angles[2] and angle < angles[3] then
    nextTouchPosition = Vector2(touchPosition.x - 1, touchPosition.y)
  elseif angle >= angles[3] and angle < angles[4] then
    nextTouchPosition = Vector2(touchPosition.x - 1, touchPosition.y - 1)
  else
    if angle >= angles[4] and angle <= angles[5] then
      nextTouchPosition = Vector2(touchPosition.x, touchPosition.y - 1)
    else
    end
  end
  return nextTouchPosition
end

function LinkLineService:InsertPieceToChainPath(chainPath, piecePos, pieceType)
  local utilData = self._world:GetService("UtilData")
  local superChainCount = utilData:GetCurrentTeamSuperChainCount()
  local boardServiceRender = self._world:GetService("BoardRender")
  local utilDataSvc = self._world:GetService("UtilData")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  if not utilDataSvc:IsAdjacentPos(chainPath[#chainPath], piecePos) then
    return
  end
  if not boardServiceRender:IsInPlayerArea(piecePos) then
    return
  end
  if utilDataSvc:IsPosBlockLinkLineForChain(piecePos) then
    return
  end
  local lastPieceType = pieceType
  local elementType = env:GetPieceType(piecePos)
  if elementType == PieceType.None then
    return
  end
  if #chainPath == 1 then
    local firstLinkMapPiece = utilDataSvc:GetMapForFirstChainPath()
    if firstLinkMapPiece then
      elementType = firstLinkMapPiece
      local guideService = self._world:GetService("Guide")
      local isMatchGuidePath = guideService:HandleDragTrigger(piecePos)
      if isMatchGuidePath == true then
        self:PlayMapPieceFirstChainPathEffect(piecePos)
      end
    end
    pieceType = elementType
  elseif 1 < #chainPath then
    if 2 <= #chainPath and pieceType == PieceType.Any then
      pieceType = env:GetPieceType(piecePos)
    end
    local isTwoColorChain = self:IsTwoColorChain()
    if isTwoColorChain then
      local isElementMatch, resetPieceType = self:_IsElementMatchForTwoColorChain(piecePos, pieceType, chainPath)
      if not isElementMatch then
        return
      end
      if resetPieceType then
        pieceType = elementType
      end
    else
      local isElementMatch = self:_IsElementMatchForLink(piecePos, pieceType)
      if not isElementMatch then
        return
      end
    end
  end
  if table.icontains(chainPath, piecePos) then
    return
  end
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  if 1 < #chainPath and teamEntity:BuffView():HasBuffEffect(BuffEffectType.Benumb) then
    Log.debug("player is benumb!!")
    return
  end
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderTrapWallComponent = renderBoardEntity:RenderTrapWall()
  if renderTrapWallComponent then
    local blockEffectEntityIDList = renderTrapWallComponent:GetBlockEffectEntityIDList()
    local posTarget = piecePos
    local posCur = teamEntity:GetGridPosition()
    if 1 <= #chainPath then
      posCur = chainPath[#chainPath]
    end
    if utilDataSvc:IsPosBlockMoveForTrapWall(posCur, posTarget) then
      return
    end
  end
  local guideService = self._world:GetService("Guide")
  local isMatchGuidePath = guideService:HandleDragTrigger(piecePos)
  if isMatchGuidePath ~= true then
    return
  end
  table.insert(chainPath, piecePos)
  local featureRender = self._world:GetService("FeatureRender")
  if featureRender then
    featureRender:OnLinkLineChainPathChange(chainPath)
  end
  local linkLineIndex = #chainPath - 1
  if superChainCount < linkLineIndex then
    linkLineIndex = superChainCount
  end
  if 1 <= linkLineIndex then
    AudioHelperController.PlayInnerGameSfx(linkLineIndex + CriAudioIDConst.SoundCoreGameLinkLineStart - 1)
  end
  local pieceSvc = self._world:GetService("Piece")
  local pieceEntity = pieceSvc:FindPieceEntity(piecePos)
  if pieceEntity then
    self:_OnPieceInsertIntoChain(chainPath)
  else
    local viewDataEntity = self._world:GetRenderBoardEntity()
    local waveDataCmpt = viewDataEntity:WaveData()
    local isExitWave = waveDataCmpt:IsExitWave()
    local exitPos = waveDataCmpt:GetExitWavePos()
    if isExitWave and exitPos == piecePos then
      local effectService = self._world:GetService("Effect")
      effectService:CreateWorldPositionEffect(GameResourceConst.EffLinkLine2Exit, piecePos)
    else
      Log.fatal("连线坐标：" .. tostring(piecePos) .. " 位置的格子无法获取到！", Log.traceback())
      return
    end
  end
  lastPieceType = env:GetPieceType(chainPath[#chainPath])
  self:UpdateLastPathAroundRadius(chainPath, pieceType, lastPieceType)
  local isLocal = self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn
  local previewEntity = self._world:GetPreviewEntity()
  local prvwCmpt = previewEntity:PreviewChainPath()
  local firstElementType, firstElementIndex = prvwCmpt:GetFirstElementData()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FlushPetChainSkillItem, isLocal, #chainPath, pieceType, firstElementType)
  local linkageRenderService = self._world:GetService("LinkageRender")
  linkageRenderService:ShowLinkageInfo(chainPath, pieceType)
  return pieceType
end

function LinkLineService:_FindTrapByPos(posTouch)
  local listFindTrapID = {}
  local teTrap = self._world:GetGroupEntities(self._world.BW_WEMatchers.Trap)
  for _, eTrap in ipairs(teTrap) do
    if eTrap:TrapRender():IsHasShow() and eTrap:IsViewVisible() then
      local cBodyArea = eTrap:BodyArea()
      local tv2Relative = cBodyArea and cBodyArea:GetArea() or {
        Vector2.zero
      }
      local v2GridPos = eTrap:GetGridPosition()
      for __, v2Relative in ipairs(tv2Relative) do
        if posTouch == v2GridPos + v2Relative then
          table.insert(listFindTrapID, eTrap:GetID())
        end
      end
    end
  end
  return listFindTrapID
end

function LinkLineService:_QuickStayGoBack(chainpath, touchpos)
  if not table.icontains(chainpath, touchpos) then
    return nil
  end
  if touchpos == chainpath[#chainpath] then
    return nil
  end
  local timeService = self._world:GetService("Time")
  local gridTouchComponent = self._world:GridTouch()
  if gridTouchComponent:GetStayTouchDuration(timeService:GetCurrentTimeMs()) < BattleConst.GoBackStayTime then
    return nil
  end
  local goBackCount = 0
  for i = #chainpath, 1, -1 do
    local pos = chainpath[i]
    if pos ~= touchpos then
      goBackCount = goBackCount + 1
    else
      break
    end
  end
  goBackCount = goBackCount - 1
  return goBackCount
end

function LinkLineService:QuickGoBack(chainpath, touchpos)
  local boardServiceRender = self._world:GetService("BoardRender")
  if not chainpath then
    return nil
  end
  if table.icontains(chainpath, touchpos) then
    return self:_QuickStayGoBack(chainpath, touchpos)
  end
  if not boardServiceRender:IsSameCrossPos(chainpath[#chainpath], touchpos) then
    return nil
  end
  if #chainpath == 1 then
    return nil
  end
  local lastPos = chainpath[#chainpath]
  if touchpos == lastPos then
    return nil
  end
  local goBackCount = 0
  local goBackPosList = {}
  local tmpPosList = {}
  if lastPos.x == touchpos.x then
    local step = lastPos.y > touchpos.y and -1 or 1
    for y = lastPos.y, touchpos.y, step do
      local pos = Vector2(lastPos.x, y)
      table.insert(tmpPosList, pos)
    end
  elseif lastPos.y == touchpos.y then
    local step = lastPos.x > touchpos.x and -1 or 1
    for x = lastPos.x, touchpos.x, step do
      local pos = Vector2(x, lastPos.y)
      table.insert(tmpPosList, pos)
    end
  end
  if 0 < #tmpPosList then
    for i = #chainpath, 1, -1 do
      local pos = chainpath[i]
      if table.icontains(tmpPosList, pos) then
        if #goBackPosList == 0 or math.abs(i - goBackPosList[#goBackPosList][2]) == 1 then
          table.insert(goBackPosList, {pos, i})
          goBackCount = goBackCount + 1
        else
          break
        end
      end
    end
    table.removev(goBackPosList, goBackPosList[#goBackPosList])
    goBackCount = goBackCount - 1
  end
  return goBackCount
end

function LinkLineService:UpdateLastPathAroundRadius(chainPath, chainPieceType, chainLastElementType)
  local utilDataSvc = self._world:GetService("UtilData")
  local previewEntity = self._world:GetPreviewEntity()
  previewEntity:ReplacePreviewChainPath(chainPath, chainPieceType, chainLastElementType)
  local isTwoColorTeam = self:IsTwoColorChain()
  if isTwoColorTeam then
    local env = self._world:GetPreviewEntity():PreviewEnv()
    local prvwCmpt = previewEntity:PreviewChainPath()
    local firstElementType = PieceType.None
    local firstElementIndex = -1
    if 2 <= #chainPath then
      for index = 2, #chainPath do
        local curPos = chainPath[index]
        local curPieceType = env:GetPieceType(curPos)
        if index == 2 then
          local firstLinkMapPiece = utilDataSvc:GetMapForFirstChainPath()
          if firstLinkMapPiece then
            curPieceType = firstLinkMapPiece
          end
        end
        if curPieceType ~= PieceType.Any then
          firstElementType = curPieceType
          firstElementIndex = index
          break
        end
      end
      prvwCmpt:SetFirstElementData(firstElementType, firstElementIndex)
    else
      prvwCmpt:SetFirstElementData(firstElementType, firstElementIndex)
    end
  end
  local endGridPos = chainPath[#chainPath]
  local endNearbyGridPosList = utilDataSvc:GetRoundGrid(endGridPos, function(gridPos)
    if self:_IsElementMatchForLink(gridPos, chainPieceType) then
      return true
    end
    return false
  end)
  local nearbyGridRadius = {}
  for _, v in pairs(endNearbyGridPosList) do
    local gridPos = Vector2(v.x, v.y)
    local gridRoundPosList = utilDataSvc:GetRoundGrid(gridPos, function(pos)
      if table.icontains(endNearbyGridPosList, pos) and self:_IsElementMatchForLink(pos, chainPieceType) then
        return true
      end
      return false
    end)
    if gridPos.x == endGridPos.x or gridPos.y == endGridPos.y then
      if #gridRoundPosList ~= 0 then
        nearbyGridRadius[gridPos] = GridRadiusType.NearBy
      else
        nearbyGridRadius[gridPos] = GridRadiusType.Default
      end
    elseif #gridRoundPosList ~= 0 then
      nearbyGridRadius[gridPos] = GridRadiusType.Diagonal
    else
      nearbyGridRadius[gridPos] = GridRadiusType.Default
    end
  end
  for pos, radiusType in pairs(nearbyGridRadius) do
  end
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  previewChainPathCmpt:SetGridRadius(nearbyGridRadius)
end

function LinkLineService:GetRadius(radiusType)
  local config = Cfg.cfg_link_line_sensing_area[1]
  if radiusType == GridRadiusType.Default then
    return config.DefaultRadius
  elseif radiusType == GridRadiusType.Diagonal then
    return config.DiagonalRadius
  elseif radiusType == GridRadiusType.NearBy then
    return config.NearbyRadius
  end
  return config.DefaultRadius
end

function LinkLineService:AllMonsterAndTrapTrans(show)
  local flashEnemyEntities = self._world:GetGroup(self._world.BW_WEMatchers.MaterialAnimation):GetEntities()
  for _, v in pairs(flashEnemyEntities) do
    if (v:HasMonsterID() or v:HasTrapID()) and (not v:BuffView() or not v:BuffView():HasBuffEffect(BuffEffectType.NotPlayMaterialAnimation)) then
      if show then
        v:NewEnableGhost()
      else
        v:StopGhostAnim()
      end
    end
  end
end

function LinkLineService:ShowChainPathCancelArea(isShow)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  renderBoardCmpt:SetChainPathCancelAreaActive(isShow)
  if isShow then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowChainPathCancelArea)
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HideChainPathCancelArea)
  end
end

function LinkLineService:IsTwoColorChain()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local utilDataSvc = self._world:GetService("UtilData")
  local useTwoColorTeam = utilDataSvc:GetEntityBuffValue(teamEntity, "TwoColorChain")
  return useTwoColorTeam
end

function LinkLineService:_IsElementMatchForTwoColorChain(touchPosition, pieceType, chainPath)
  local utilDataSvc = self._world:GetService("UtilData")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local elementType = env:GetPieceType(touchPosition)
  if self:IsNeedShowLinkageNumForCostStep() then
    return true
  end
  if utilDataSvc:IgnoreElementMatchOnPos(touchPosition) then
    return true
  end
  if pieceType == PieceType.None then
    return false
  end
  if pieceType == PieceType.Any or elementType == PieceType.Any then
    return true
  end
  if utilDataSvc:IsPosCanMapOtherPiece(touchPosition, pieceType, elementType) then
    local noPieceTypeAnyCount = 0
    for checkIndex = 1, #chainPath do
      local checkPos = chainPath[checkIndex]
      local curPieceType = env:GetPieceType(checkPos)
      if checkIndex == 2 then
        local firstLinkMapPiece = utilDataSvc:GetMapForFirstChainPath()
        if firstLinkMapPiece then
          curPieceType = firstLinkMapPiece
        end
      end
      if curPieceType ~= PieceType.Any then
        noPieceTypeAnyCount = noPieceTypeAnyCount + 1
      end
    end
    if noPieceTypeAnyCount == 2 and elementType ~= PieceType.Any then
      return true, true
    end
    return true
  end
  local previewEntity = self._world:GetPreviewEntity()
  local prvwCmpt = previewEntity:PreviewChainPath()
  local firstElementType, firstElementIndex = prvwCmpt:GetFirstElementData()
  local isSecondColor = self:IsSecondColorForTwoColorChain(chainPath)
  if isSecondColor then
    return true, true
  else
    if elementType ~= pieceType then
      return false
    end
    return true
  end
end

function LinkLineService:IsSecondColorForTwoColorChain(chainPath)
  local utilDataSvc = self._world:GetService("UtilData")
  local previewEntity = self._world:GetPreviewEntity()
  local prvwCmpt = previewEntity:PreviewChainPath()
  local firstElementType, firstElementIndex = prvwCmpt:GetFirstElementData()
  if firstElementIndex == #chainPath then
    return true
  end
  if firstElementIndex < 0 then
    return false
  end
  local isAllAny = true
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local startIndex = firstElementIndex + 1
  if startIndex <= #chainPath then
    for checkIndex = startIndex, #chainPath do
      local checkPos = chainPath[checkIndex]
      local curPieceType = env:GetPieceType(checkPos)
      if checkIndex == 2 then
        local firstLinkMapPiece = utilDataSvc:GetMapForFirstChainPath()
        if firstLinkMapPiece then
          curPieceType = firstLinkMapPiece
        end
      end
      if curPieceType ~= PieceType.Any then
        isAllAny = false
        break
      end
    end
  else
    return false
  end
  if isAllAny then
    return true
  end
  return false
end

function LinkLineService:PlayMapPieceFirstChainPathEffect(piecePos)
  local effectService = self._world:GetService("Effect")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local eid = renderBoardCmpt:GetMapPieceFirstChainPathEffectID()
  if eid and 0 < eid then
    local effEntity = effectService:CreateWorldPositionEffect(eid, piecePos)
    if effEntity then
      local renderBoardEntity = self._world:GetRenderBoardEntity()
      local renderBoardCmpt = renderBoardEntity:RenderBoard()
      renderBoardCmpt:SetMapPieceFirstChainPathEffectEntityID(effEntity:GetID())
    end
  end
end

function LinkLineService:StopMapPieceFirstChainPathEffect()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local effEntityID = renderBoardCmpt:GetMapPieceFirstChainPathEffectEntityID()
  if effEntityID then
    local effEntity = self._world:GetEntityByID(effEntityID)
    if effEntity then
      local outAnim = renderBoardCmpt:GetMapPieceFirstChainPathEffectOutAnim()
      if outAnim then
        local ego = effEntity:View():GetGameObject()
        if ego then
          local anim = ego.gameObject:GetComponent("Animation")
          anim:Play(outAnim)
        end
      else
        self._world:DestroyEntity(effEntity)
      end
    end
  end
  renderBoardCmpt:SetMapPieceFirstChainPathEffectEntityID(nil)
end

function LinkLineService:GetCurPickUpType()
  local pickUpCmpt = self._world:PickUp()
  local skillID = pickUpCmpt:GetCurActiveSkillID()
  local pstID = pickUpCmpt:GetCurActiveSkillPetPstID()
  local utilData = self._world:GetService("UtilData")
  local petEntity = utilData:GetEntityByPstID(pstID)
  if not petEntity then
    local entityID = pickUpCmpt:GetEntityID()
    petEntity = self._world:GetEntityByID(entityID)
  end
  if not petEntity then
    return
  end
  local cfgSvc = self._world:GetService("Config")
  local cfgData = cfgSvc:GetSkillConfigData(skillID, petEntity)
  if not cfgData then
    return
  end
  return cfgData:GetSkillPickType()
end

function LinkLineService:_ActiveSkillLineLineCheckFirstPosition()
  local pickUpCmpt = self._world:PickUp()
  local pstID = pickUpCmpt:GetCurActiveSkillPetPstID()
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(pstID)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  return utilDataSvc:GetPet1702361LinkLineBeginPos(petEntityId, activeSkillID)
end

function LinkLineService:_MoyeCheckFirstPosition(touchPos)
  local pickUpCmpt = self._world:PickUp()
  local pstID = pickUpCmpt:GetCurActiveSkillPetPstID()
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(pstID)
  local petEntity = self._world:GetEntityByID(petEntityId)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillConfigData = self:_GetSkillConfigData()
  local firstPickupPos = touchPos
  local firstPickUpValidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.firstPickValidScopeList or {})
  local validGridList = utilScopeSvc:BuildScopeGridList(firstPickUpValidScopeList, petEntity) or {}
  if 0 < #validGridList then
    return table.Vector2Include(validGridList, firstPickupPos)
  else
    return true
  end
end

function LinkLineService:_GetSkillConfigData()
  local pickUpCmpt = self._world:PickUp()
  local skillID = pickUpCmpt:GetCurActiveSkillID()
  local pstID = pickUpCmpt:GetCurActiveSkillPetPstID()
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(pstID)
  local petEntity = self._world:GetEntityByID(petEntityId)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, petEntity)
  return skillConfigData
end

function LinkLineService:_ParseScopeList(list)
  local parser = SkillScopeParamParser:New()
  local t = {}
  for _, v in ipairs(list) do
    local param = SkillPreviewScopeParam:New(v)
    local data = parser:ParseScopeParam(v.ScopeType, v.ScopeParam)
    param:SetScopeParamData(data)
    table.insert(t, param)
  end
  return t
end
