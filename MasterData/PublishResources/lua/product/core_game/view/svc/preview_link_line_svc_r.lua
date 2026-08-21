_class("PreviewLinkLineService", LinkLineService)
PreviewLinkLineService = PreviewLinkLineService

function PreviewLinkLineService:StartLinkLine(touchPos, offset)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeBossHPBuffButtonRayCast, false)
  local previewEntity = self._world:GetPreviewEntity()
  local previewLinkLineCmpt = previewEntity:PreviewLinkLine()
  local chainPath = previewLinkLineCmpt:GetPreviewChainPath()
  if chainPath == nil then
    return false
  end
  local guideService = self._world:GetService("Guide")
  guideService:HandlePLLBeginDragTrigger(touchPos)
  local linkageRenderService = self._world:GetService("LinkageRender")
  linkageRenderService:HideAllLinkDot()
  linkageRenderService:DestroyAllLinkLine()
  linkageRenderService:DestroyLinkedGridEffect()
  if 0 < #chainPath then
    self:CancelAllLinkPosPieceType(chainPath)
  end
  self:_DoDrag(touchPos, offset)
  self:_StartCameraMove()
  self:SetMonsterShadowPosListDown(false)
  self:StartBulletTime()
end

function PreviewLinkLineService:GetLinkLineCount()
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
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  if pickUpTargetCmpt:GetPickUpTargetType() == SkillPickUpType.LinkLineSP then
    local utilDataSvc = self._world:GetService("UtilData")
    return utilDataSvc:GetPet1702361LinkLineStep(petEntity, skillID)
  else
    return cfgData:GetSkillPickParam()[1] or 0
  end
end

function PreviewLinkLineService:GetCurPickUpParam()
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
  return cfgData:GetSkillPickParam()
end

function PreviewLinkLineService:SetMonsterShadowPosListDown(animDown)
  local pickUpParam = self:GetCurPickUpParam()
  local isLinkMonster = pickUpParam[3] or 0
  if isLinkMonster ~= 1 then
    return
  end
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
  if chainAcrossMonsterIDList and 0 < table.count(chainAcrossMonsterIDList) then
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

function PreviewLinkLineService:_DoDrag(touchPos, offset)
  local previewEntity = self._world:GetPreviewEntity()
  local previewLinkLineCmpt = previewEntity:PreviewLinkLine()
  local chainPath = previewLinkLineCmpt:GetPreviewChainPath()
  local playerPosition = self:GetPlayerPos()
  if not self:IsPosCanLink(touchPos, chainPath) then
    return
  end
  local pieceSvc = self._world:GetService("Piece")
  local pieceEntity = pieceSvc:FindPieceEntity(touchPos)
  if not pieceEntity then
    Log.fatal("[touch] 连线坐标：" .. tostring(touchPos) .. " 位置的格子无法获取到！")
    return
  end
  if #chainPath == 0 then
    local pickUpType = self:GetCurPickUpType()
    if pickUpType == SkillPickUpType.Moye then
      if self:_MoyeCheckFirstPosition(touchPos) then
        self:_InitChainPath(chainPath, touchPos)
      end
    else
      self:_InitChainPath(chainPath, playerPosition)
    end
    self:CalcPathPoint(touchPos, offset)
    if self:IsNeedShowLinkageNumForCostStep() then
      self:_ShowLinkageInfo(chainPath)
      local reBoard = self._world:GetRenderBoardEntity()
      local previewChainSkillRangeCmpt = reBoard:PreviewChainSkillRange()
      previewChainSkillRangeCmpt:EnablePreviewChainSkillRange(true)
    end
  end
end

function PreviewLinkLineService:_StartCameraMove(TT)
  local gridTouchComponent = self._world:GridTouch()
  local touchState = gridTouchComponent:GetGridTouchStateID()
  if touchState == GridTouchStateID.PLLEndDrag then
    Log.notice("current is end drag state,stop insert chain path")
    return
  end
  local cameraCmpt = self._world:MainCamera()
  cameraCmpt:DoMoveCamera(true)
  self:AllMonsterAndTrapTrans(true)
end

function PreviewLinkLineService:_InitChainPath(chainPath, touchPosition)
  table.insert(chainPath, touchPosition)
  Log.info("[touch] Init chain path insert ", table.tostring(chainPath))
  local elementType = PieceType.None
  local previewEntity = self._world:GetPreviewEntity()
  local utilDataSvc = self._world:GetService("UtilData")
  if utilDataSvc:IsPreviewNeedShowLinkageNumForCostStep() then
    previewEntity:ReplacePreviewLinkLine(chainPath, elementType, PieceType.None, true)
    previewEntity:ReplacePreviewChainPath(chainPath, PieceType.Any, PieceType.Any, true)
  else
    previewEntity:ReplacePreviewLinkLine(chainPath, elementType, PieceType.None)
  end
  self:NotifyPickUpTargetChange()
end

function PreviewLinkLineService:CancelChainPath()
  if not self._world then
    return
  end
  local syncMoveServiceRender = self._world:GetService("SyncMoveRender")
  if syncMoveServiceRender then
    syncMoveServiceRender:ClearPreview()
  end
  self:AllMonsterAndTrapTrans(false)
end

function PreviewLinkLineService:QuickResponse(chainPath, touchPos, pieceType)
  if not chainPath then
    return nil
  end
  local boardServiceRender = self._world:GetService("BoardRender")
  if not boardServiceRender:IsSameCrossPos(chainPath[#chainPath], touchPos) then
    return nil
  end
  local lastPos = chainPath[#chainPath]
  if lastPos.x == touchPos.x then
    local step = lastPos.y > touchPos.y and -1 or 1
    for y = lastPos.y + step, touchPos.y, step do
      local pos = Vector2(lastPos.x, y)
      if not (not table.icontains(chainPath, pos) and self:IsPosCanLink(pos, chainPath)) then
        break
      end
      local newPieceType = self:InsertPieceToChainPath(chainPath, pos, pieceType)
      if not newPieceType then
        break
      end
      if newPieceType and pieceType ~= newPieceType then
        pieceType = newPieceType
      end
    end
  elseif lastPos.y == touchPos.y then
    local step = lastPos.x > touchPos.x and -1 or 1
    for x = lastPos.x + step, touchPos.x, step do
      local pos = Vector2(x, lastPos.y)
      if not (not table.icontains(chainPath, pos) and self:IsPosCanLink(pos, chainPath)) then
        break
      end
      local newPieceType = self:InsertPieceToChainPath(chainPath, pos, pieceType)
      if not newPieceType then
        break
      end
      if newPieceType and pieceType ~= newPieceType then
        pieceType = newPieceType
      end
    end
  end
end

function PreviewLinkLineService:CalcPathPoint(touchPos, offset)
  local previewEntity = self._world:GetPreviewEntity()
  local previewLinkLineCmpt = previewEntity:PreviewLinkLine()
  local chainPath = previewLinkLineCmpt:GetPreviewChainPath()
  local pieceType = previewLinkLineCmpt:GetPreviewPieceType()
  previewLinkLineCmpt:SetMoveBack(false)
  if chainPath == nil or #chainPath == 0 then
    return
  end
  local chainPathCount = #chainPath
  local utilDataSvc = self._world:GetService("UtilData")
  if not self:IsPosCanLink(touchPos, chainPath) then
    return
  end
  local radiusType = previewLinkLineCmpt:GetGridRadius(touchPos)
  local radius = self:GetRadius(radiusType)
  local offsetLen = Vector2.Magnitude(offset)
  local lastLinkPosition = chainPath[chainPathCount]
  local lastButOneLinkPosition = chainPath[chainPathCount - 1]
  if 1 < chainPathCount and touchPos == lastButOneLinkPosition then
    previewLinkLineCmpt:SetMoveBack(true)
    if radius > offsetLen then
      pieceType = self:_UndoLink(chainPath)
      self:UpdateLastPathAroundRadius(chainPath, pieceType)
      if self:IsNeedShowLinkageNumForCostStep() then
        self:_ShowLinkageInfo(chainPath)
      end
    end
    return
  end
  local goBackCount = self:_QuickGoBack(chainPath, touchPos)
  if goBackCount and goBackCount ~= 0 then
    previewLinkLineCmpt:SetMoveBack(true)
    for i = 1, goBackCount do
      pieceType = self:_UndoLink(chainPath)
    end
    self:UpdateLastPathAroundRadius(chainPath, pieceType)
    return
  end
  if touchPos == lastLinkPosition then
    return
  elseif utilDataSvc:IsAdjacentPos(lastLinkPosition, touchPos) then
    if radius <= offsetLen then
      return
    end
    self:InsertPieceToChainPath(chainPath, touchPos, pieceType)
  else
    self:QuickResponse(chainPath, touchPos, pieceType)
  end
end

function PreviewLinkLineService:_ShowLinkageInfo(chainPath)
  local linkageRenderService = self._world:GetService("LinkageRender")
  linkageRenderService:ShowLinkageInfo(chainPath)
end

function PreviewLinkLineService:_OnPieceRemoveFromChain(pos)
  local pieceSvc = self._world:GetService("Piece")
  local utilDataSvc = self._world:GetService("UtilData")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  if env:IsPrismPiece(pos) then
    pieceSvc:ResetPieceEffectRender(pos)
  end
end

function PreviewLinkLineService:_OnPieceInsertIntoChain(piecePos)
  local boardsvc = self._world:GetService("BoardRender")
  local pieceSvc = self._world:GetService("Piece")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  if env:IsPrismPiece(piecePos) then
    local pickUpType = self:GetCurPickUpType()
    if pickUpType ~= SkillPickUpType.Moye and pickUpType ~= SkillPickUpType.LinkLine then
      pieceSvc:SetPieceRenderEffect(piecePos, PieceEffectType.Normal)
    end
  end
end

function PreviewLinkLineService:_UndoLink(chainPath)
  local utilData = self._world:GetService("UtilData")
  local superChainCount = utilData:GetCurrentTeamSuperChainCount()
  local env = self._world:GetPreviewEntity():PreviewEnv()
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
  local lastpos = chainPath[#chainPath]
  local lastElementType = env:GetPieceType(lastpos)
  return lastElementType
end

function PreviewLinkLineService:InsertPieceToChainPath(chainPath, piecePos, pieceType)
  if table.icontains(chainPath, piecePos) then
    return
  end
  local boardServiceRender = self._world:GetService("BoardRender")
  local utilDataSvc = self._world:GetService("UtilData")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  if not utilDataSvc:IsAdjacentPos(chainPath[#chainPath], piecePos) then
    return
  end
  if not boardServiceRender:IsInPlayerArea(piecePos) then
    return
  end
  if utilDataSvc:IsPreviewNeedShowLinkageNumForCostStep() then
    pieceType = 0
  else
    pieceType = env:GetPieceType(piecePos)
  end
  if not self:_MoyeCheck(piecePos, pieceType) then
    return
  end
  local guideService = self._world:GetService("Guide")
  local isMatchGuidePath = guideService:HandlePLLDragTrigger(piecePos)
  if isMatchGuidePath ~= true then
    return
  end
  Log.debug("InsertPos X:" .. piecePos.x .. " Y:" .. piecePos.y .. ">>>>>>1")
  table.insert(chainPath, piecePos)
  local utilData = self._world:GetService("UtilData")
  local superChainCount = utilData:GetCurrentTeamSuperChainCount()
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
    self:_OnPieceInsertIntoChain(piecePos)
  end
  self:UpdateLastPathAroundRadius(chainPath, pieceType)
  if self:IsNeedShowLinkageNumForCostStep() then
    self:_ShowLinkageInfo(chainPath)
  end
  return pieceType
end

function PreviewLinkLineService:_QuickStayGoBack(chainPath, touchPos)
  if not table.icontains(chainPath, touchPos) then
    return nil
  end
  if touchPos == chainPath[#chainPath] then
    return nil
  end
  local timeService = self._world:GetService("Time")
  local gridTouchComponent = self._world:GridTouch()
  if gridTouchComponent:GetStayTouchDuration(timeService:GetCurrentTimeMs()) < BattleConst.GoBackStayTime then
    return nil
  end
  local goBackCount = 0
  for i = #chainPath, 1, -1 do
    local pos = chainPath[i]
    if pos ~= touchPos then
      goBackCount = goBackCount + 1
    else
      break
    end
  end
  goBackCount = goBackCount - 1
  return goBackCount
end

function PreviewLinkLineService:_QuickGoBack(chainPath, touchPos)
  if not chainPath then
    return nil
  end
  if table.icontains(chainPath, touchPos) then
    return self:_QuickStayGoBack(chainPath, touchPos)
  end
  local boardServiceRender = self._world:GetService("BoardRender")
  if not boardServiceRender:IsSameCrossPos(chainPath[#chainPath], touchPos) then
    return nil
  end
  if #chainPath == 1 then
    return nil
  end
  local lastPos = chainPath[#chainPath]
  if touchPos == lastPos then
    return nil
  end
  local goBackCount = 0
  local goBackPosList = {}
  local tmpPosList = {}
  if lastPos.x == touchPos.x then
    local step = lastPos.y > touchPos.y and -1 or 1
    for y = lastPos.y, touchPos.y, step do
      local pos = Vector2(lastPos.x, y)
      table.insert(tmpPosList, pos)
    end
  elseif lastPos.y == touchPos.y then
    local step = lastPos.x > touchPos.x and -1 or 1
    for x = lastPos.x, touchPos.x, step do
      local pos = Vector2(x, lastPos.y)
      table.insert(tmpPosList, pos)
    end
  end
  if 0 < #tmpPosList then
    for i = #chainPath, 1, -1 do
      local pos = chainPath[i]
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

function PreviewLinkLineService:UpdateLastPathAroundRadius(chainPath, chainPieceType)
  local utilDataSvc = self._world:GetService("UtilData")
  local previewEntity = self._world:GetPreviewEntity()
  self:NotifyPickUpTargetChange()
  if utilDataSvc:IsPreviewNeedShowLinkageNumForCostStep() then
    previewEntity:ReplacePreviewChainPath(chainPath, PieceType.Any, PieceType.Any, true)
    previewEntity:ReplacePreviewLinkLine(chainPath, chainPieceType, true)
  else
    previewEntity:ReplacePreviewLinkLine(chainPath, chainPieceType)
  end
  local endGridPos = chainPath[#chainPath]
  local endNearbyGridPosList = utilDataSvc:GetRoundGrid(endGridPos)
  local nearbyGridRadius = {}
  for _, v in pairs(endNearbyGridPosList) do
    local gridPos = Vector2(v.x, v.y)
    local gridRoundPosList = utilDataSvc:GetRoundGrid(gridPos, function(pos)
      if table.icontains(endNearbyGridPosList, pos) then
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
  local previewLinkLineCmpt = previewEntity:PreviewLinkLine()
  previewLinkLineCmpt:SetGridRadius(nearbyGridRadius)
end

function PreviewLinkLineService:GetRadius(radiusType)
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

function PreviewLinkLineService:NotifyPickUpTargetChange()
  local pickUpCmpt = self._world:PickUp()
  local skillID = pickUpCmpt:GetCurActiveSkillID()
  local pstID = pickUpCmpt:GetCurActiveSkillPetPstID()
  local entityID = pickUpCmpt:GetEntityID()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local activeSkillPickUpType = skillConfigData:GetSkillPickType()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  pickUpTargetCmpt:SetPickUpTargetType(activeSkillPickUpType)
  pickUpTargetCmpt:SetCurActiveSkillInfo(skillID, pstID)
  pickUpTargetCmpt:SetEntityID(entityID)
  renderBoardEntity:ReplacePickUpTarget()
end

function PreviewLinkLineService:ConvertLinkPosPieceType(pos)
  local utilDataSvc = self._world:GetService("UtilData")
  if not utilDataSvc:IsPreviewNeedShowLinkageNumForCostStep() then
    local pickUpParam = self:GetCurPickUpParam()
    local pieceType = pickUpParam[2] or PieceType.Blue
    local boardServiceR = self._world:GetService("BoardRender")
    local env = self._world:GetPreviewEntity():PreviewEnv()
    local curType = env:GetPieceType(pos)
    local pickUpType = self:GetCurPickUpType()
    if pickUpType and pickUpType == SkillPickUpType.Moye then
      return curType
    end
    if not (not utilDataSvc:GetMonsterAtPos(pos) and utilDataSvc:IsPosCanConvertGridElement(pos)) or pieceType == curType then
      return curType
    end
    env:SetPieceType(pos, pieceType)
    boardServiceR:ReCreateGridEntity(pieceType, pos, false, true)
    return pieceType
  end
end

function PreviewLinkLineService:CancelLinkPosPieceType(pos)
  local boardServiceR = self._world:GetService("BoardRender")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local utilDataSvc = self._world:GetService("UtilData")
  local pieceType = utilDataSvc:GetPieceType(pos)
  local previewPieceType = env:GetPieceType(pos)
  if previewPieceType == pieceType then
    return
  end
  env:SetPieceType(pos, pieceType)
  local pieceSvc = self._world:GetService("Piece")
  pieceSvc:ResetPieceEffectRender(pos)
  boardServiceR:ReCreateGridEntity(pieceType, pos, false, true)
end

function PreviewLinkLineService:CancelAllLinkPosPieceType(chainPath)
  for _, pos in pairs(chainPath) do
    self:CancelLinkPosPieceType(pos)
  end
end

function PreviewLinkLineService:IsPosCanLink(pos, chainPath)
  local utilDataSvc = self._world:GetService("UtilData")
  if not utilDataSvc:IsValidPiecePos(pos) then
    return false
  end
  local pickUpParam = self:GetCurPickUpParam()
  if not pickUpParam then
    return false
  end
  local linkCount = self:GetLinkLineCount()
  local linkMonster = pickUpParam[3] == 1
  if #chainPath <= 1 then
    if utilDataSvc:IsPosBlockForPreviewLinkLine(pos, linkMonster) then
      return false
    end
    return true
  end
  local isMaxLink = linkCount <= #chainPath - 1
  local lastPos = chainPath[#chainPath]
  local isPosMonster = false
  local pickUpType = self:GetCurPickUpType()
  if linkMonster then
    if not pickUpType or pickUpType ~= SkillPickUpType.Moye then
      isPosMonster = utilDataSvc:GetMonsterAtPos(lastPos) ~= nil
    end
    if utilDataSvc:GetMonsterAtPos(pos) then
      isMaxLink = linkCount <= #chainPath - 2
    end
  end
  if pickUpType == SkillPickUpType.LinkLineSP then
    local playerPosition = self._world:Player():GetLocalTeamEntity():GetGridPosition()
    if playerPosition == pos then
      return false
    end
  end
  local isPosExit = utilDataSvc:IsPosExit(lastPos)
  local isPosDimensionDoor = utilDataSvc:IsPosDimensionDoor(lastPos)
  local isBreakLastPos = isMaxLink or isPosMonster or isPosExit or isPosDimensionDoor
  if isBreakLastPos and not table.icontains(chainPath, pos) then
    return false
  end
  if utilDataSvc:IsPosBlockForPreviewLinkLine(pos, linkMonster) then
    return false
  end
  return true
end

function PreviewLinkLineService:CalcReplaceChainPreviewParamsPet1502051(e, chainPath)
  local skillInfoCmpt = e:SkillInfo()
  local chainRule = skillInfoCmpt._chainSkillIDSelector:GetRule()
  local firstChainRule = chainRule[1]
  local chainSkillID = firstChainRule.Skill
  local configSvc = self._world:GetService("Config")
  local firstChainConfig = configSvc:GetSkillConfigData(chainSkillID)
  local previewType = firstChainConfig:GetSkillPreviewType()
  if previewType ~= SkillPreviewType.Pet1502051Chain then
    return
  end
  local previewParam = firstChainConfig:GetSkillPreviewParam()
  local rangeSkillID = previewParam.SkillID
  local rangeIncludeTrap = previewParam.IsTrapIncluded
  local includedTrapType = previewParam.TrapType
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalc = SkillScopeCalculator:New(utilScopeSvc)
  local skillConfigData = configSvc:GetSkillConfigData(rangeSkillID)
  local utilData = self._world:GetService("UtilData")
  local extraCount = 0
  for _, v2 in ipairs(chainPath) do
    if utilData:FindPieceElement(v2) == PieceType.Blue then
      local scopeResult = scopeCalc:ComputeScopeRange(skillConfigData:GetSkillScopeType(), skillConfigData:GetSkillScopeParam(), v2, e:BodyArea():GetArea(), e:GetGridDirection(), SkillTargetType.Monster, e:GetGridPosition(), e)
      local targetSelector = self._world:GetSkillScopeTargetSelector()
      local tEntityID = targetSelector:_SelectMonsterDeadOrAlive(e, scopeResult, rangeSkillID, skillConfigData:GetSkillTargetTypeParam()) or {}
      if #tEntityID == 0 then
        if rangeIncludeTrap and includedTrapType then
          local selected = targetSelector:_SelectTrap(e, scopeResult, rangeSkillID, skillConfigData:GetSkillTargetTypeParam(), false) or {}
          tEntityID = {}
          for id, _ in pairs(selected) do
            table.insert(tEntityID, id)
          end
          for _, id in ipairs(tEntityID) do
            local trapEntity = self._world:GetEntityByID(id)
            local cTrap = trapEntity:TrapRender()
            local trapType = cTrap:GetTrapType()
            if table.icontains(includedTrapType, trapType) then
              extraCount = extraCount + 1
              Log.info("CalcReplaceChainPreviewParamsPet1502051: trap in range", v2)
              break
            end
          end
        end
      else
        extraCount = extraCount + 1
        Log.info("CalcReplaceChainPreviewParamsPet1502051: monster in range", v2)
      end
    end
  end
  Log.info("CalcReplaceChainPreviewParamsPet1502051: extra count: ", extraCount)
  local fix = e:RenderAttributes():GetAttribute("ChainSkillReleaseFix") or 0
  local chainCountMul = e:RenderAttributes():GetAttribute("ChainSkillReleaseMul") or 0
  local utilCalc = self._world:GetService("UtilCalc")
  local utilData = self._world:GetService("UtilData")
  local chainCount, useless = utilCalc:GetChainDamageRateAtIndex(chainPath, #chainPath)
  local fixedChainCount = math.ceil((chainCount + fix) * (1 + chainCountMul)) + extraCount
  local chainExtraFix = utilData:GetEntityBuffValue(e, "ChangeExtraChainSkillReleaseFixForSkill") or {}
  local skillID = utilData:GetChainSkillByChainCount(e, fixedChainCount, chainExtraFix)
  Log.info("CalcReplaceChainPreviewParamsPet1502051: fixed chain count: ", fixedChainCount)
  Log.info("CalcReplaceChainPreviewParamsPet1502051: skillID: ", skillID)
  if skillID == 0 then
    return
  end
  local replacedChainSkillConfig = configSvc:GetSkillConfigData(skillID)
  local scopeResult = utilScopeSvc:CalcSkillScopeForChainSkillPreview(replacedChainSkillConfig, chainPath[#chainPath], e)
  local selector = SkillScopeTargetSelector:New(self._world)
  local skillTargetType = replacedChainSkillConfig:GetSkillTargetType()
  local entityIDArray = selector:DoSelectSkillTarget(e, skillTargetType, scopeResult, chainSkillID)
  local attackRange = scopeResult:GetAttackRange()
  for _, gridPos in ipairs(attackRange) do
    for _, targetEntityID in ipairs(entityIDArray) do
      local targetEntity = self._world:GetEntityByID(targetEntityID)
      local gridLocationCmpt = targetEntity:GridLocation()
      local bodyAreaCmpt = targetEntity:BodyArea()
      local bodyAreaList = bodyAreaCmpt:GetArea()
      for i, bodyArea in ipairs(bodyAreaList) do
        local curBodyPos = Vector2(gridLocationCmpt.Position.x + bodyArea.x, gridLocationCmpt.Position.y + bodyArea.y)
        if curBodyPos == gridPos then
          scopeResult:AddTargetIDAndPos(targetEntityID, gridPos)
        end
      end
    end
  end
  return skillID, scopeResult
end

function PreviewLinkLineService:GetCurPickUpType()
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

function PreviewLinkLineService:_GetSkillConfigData()
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

function PreviewLinkLineService:_MoyeCheck(gridPos, pieceType)
  local utilDataSvc = self._world:GetService("UtilData")
  local skillConfigData = self:_GetSkillConfigData()
  local activeSkillPickUpType = skillConfigData:GetSkillPickType()
  if activeSkillPickUpType == SkillPickUpType.Moye then
    local pickUpParam = skillConfigData:GetSkillPickParam()
    local targetPieceType = pickUpParam[2]
    local trapIds = pickUpParam.trapIdList
    if pieceType ~= targetPieceType and pieceType ~= PieceType.Any then
      local trapSatisfied = self:_CheckTrapSatisfied(trapIds, gridPos, utilDataSvc)
      if not trapSatisfied then
        return false
      end
    end
  end
  return true
end

function PreviewLinkLineService:_CheckTrapSatisfied(trapIds, gridPos, utilDataSvc)
  if trapIds and 0 < #trapIds then
    local traps = utilDataSvc:GetTrapsAtPos(gridPos)
    for _, trap in pairs(traps) do
      local trapId = trap:TrapRender():GetTrapID()
      if table.icontains(trapIds, trapId) then
        return true
      end
    end
  end
  return false
end

function PreviewLinkLineService:_MoyeCheckFirstPosition(gridPosition)
  local pickUpCmpt = self._world:PickUp()
  local pstID = pickUpCmpt:GetCurActiveSkillPetPstID()
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(pstID)
  local petEntity = self._world:GetEntityByID(petEntityId)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillConfigData = self:_GetSkillConfigData()
  local firstPickupPos = gridPosition
  local firstPickUpValidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.firstPickValidScopeList or {})
  local validGridList = utilScopeSvc:BuildScopeGridList(firstPickUpValidScopeList, petEntity) or {}
  if 0 < #validGridList then
    return table.Vector2Include(validGridList, firstPickupPos)
  else
    return true
  end
end

function PreviewLinkLineService:_ParseScopeList(list)
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
