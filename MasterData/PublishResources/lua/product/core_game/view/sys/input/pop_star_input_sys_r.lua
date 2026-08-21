_class("PopStarInputSystem_Render", UniqueReactiveSystem)
PopStarInputSystem_Render = PopStarInputSystem_Render

function PopStarInputSystem_Render:IsInterested(index, previousComponent, component)
  if component == nil then
    return false
  end
  if not PopStarPickUpComponent:IsInstanceOfType(component) then
    return false
  end
  return true
end

function PopStarInputSystem_Render:Filter(world)
  return true
end

function PopStarInputSystem_Render:ExecuteWorld(world)
  self._world = world
  local popStarPickUpCmpt = world:PopStarPickUp()
  local clickRenderPos = popStarPickUpCmpt:GetPopStarClickPos()
  local boardSvc = world:GetService("BoardRender")
  local gridPos = boardSvc:BoardRenderPos2GridPos(clickRenderPos)
  local offset = boardSvc:BoardGridPosOffset(clickRenderPos)
  local guideService = self._world:GetService("Guide")
  local isGuide, isValid = guideService:IsGuideAndPieceValid(gridPos.x, gridPos.y)
  if isGuide then
    if isValid then
      self._world:EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Piece)
    else
      return
    end
  end
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpResCmpt = renderBoardEntity:PopStarPickUpResult()
  if not pickUpResCmpt then
    return
  end
  local curPickUpGirdPos = pickUpResCmpt:GetPopStarPickUpPos()
  if curPickUpGirdPos == Vector2(0, 0) then
    self:_HandleFirstClick(gridPos, offset, pickUpResCmpt)
  else
    local validPosList = pickUpResCmpt:GetPopStarConnectPieces()
    if table.icontains(validPosList, gridPos) then
      self:_HandlePop(pickUpResCmpt)
    else
      self:_HandleCancel(pickUpResCmpt)
    end
  end
end

function PopStarInputSystem_Render:_HandleFirstClick(gridPos, offset, pickUpResCmpt)
  local utilData = self._world:GetService("UtilData")
  if not utilData:IsValidPiecePos(gridPos) then
    return
  end
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local pieceType = env:GetPieceType(gridPos)
  if pieceType == PieceType.None then
    return
  end
  pickUpResCmpt:SetPopStarPickUpPos(gridPos)
  local popStarRSvc = self._world:GetService("PopStarRender")
  local isPickUpTrap, trapEntityID = self:_CheckPickUpTrap(gridPos)
  if isPickUpTrap then
    popStarRSvc:ShowPreviewTrap(trapEntityID, gridPos, offset)
  end
  local connectPieces = popStarRSvc:CalculatePopStarConnectPieces(gridPos)
  pickUpResCmpt:SetPopStarConnectPieces(connectPieces)
  popStarRSvc:PreviewPopArea(connectPieces)
  popStarRSvc:ShowPopGridNum(connectPieces)
end

function PopStarInputSystem_Render:_CheckPickUpTrap(touchPosition)
  local utilDataSvc = self._world:GetService("UtilData")
  local trapList = utilDataSvc:FindTrapByTypeAndPos(TrapType.PopStar_Prop, touchPosition)
  if 0 < #trapList then
    return true, trapList[1]:GetID()
  end
  return false, nil
end

function PopStarInputSystem_Render:_HandlePop(pickUpResCmpt)
  local pickUpPos = pickUpResCmpt:GetPopStarPickUpPos()
  local connectPieces = pickUpResCmpt:GetPopStarConnectPieces()
  local popStarRSvc = self._world:GetService("PopStarRender")
  popStarRSvc:ClearPreviewPop(connectPieces)
  self._world:EventDispatcher():Dispatch(GameEventType.PopStarPickUp, pickUpPos, connectPieces)
  pickUpResCmpt:ResetPopStarPickUp()
end

function PopStarInputSystem_Render:_HandleCancel(pickUpResCmpt)
  local connectPieces = pickUpResCmpt:GetPopStarConnectPieces()
  local popStarRSvc = self._world:GetService("PopStarRender")
  popStarRSvc:ClearPreviewPop(connectPieces)
  pickUpResCmpt:ResetPopStarPickUp()
end
