_class("PopStarProInputSystem_Render", UniqueReactiveSystem)
PopStarProInputSystem_Render = PopStarProInputSystem_Render

function PopStarProInputSystem_Render:IsInterested(index, previousComponent, component)
  if component == nil then
    return false
  end
  if not PopStarPickUpComponent:IsInstanceOfType(component) then
    return false
  end
  return true
end

function PopStarProInputSystem_Render:Filter(world)
  if world:MatchType(GetMatchTypeType.NoLinkLine) ~= MatchType.MT_PopStarPro then
    return false
  end
  return true
end

function PopStarProInputSystem_Render:ExecuteWorld(world)
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
  local popStarRSvc = self._world:GetService("PopStarProRender")
  if popStarRSvc:IsPosBlockPopStar(gridPos) then
    self:_HandleClickBlockPos(gridPos, offset, pickUpResCmpt)
    return
  else
    local prvwSvc = self._world:GetService("PreviewMonsterTrap")
    prvwSvc:ClearMonsterTrapPreview()
  end
  local curPickUpGirdPos = pickUpResCmpt:GetPopStarPickUpPos()
  if curPickUpGirdPos == Vector2(0, 0) then
    self:_HandleFirstClick(gridPos, offset, pickUpResCmpt)
  else
    local validPosList = pickUpResCmpt:GetPopStarConnectPieces()
    if curPickUpGirdPos == gridPos then
      self:_HandlePop(pickUpResCmpt)
    elseif table.icontains(validPosList, gridPos) then
      self:_HandleClickOtherValidPos(gridPos, offset, pickUpResCmpt)
    else
      self:_HandleCancel(pickUpResCmpt)
    end
  end
end

function PopStarProInputSystem_Render:_HandleClickBlockPos(gridPos, offset, pickUpResCmpt)
  local curPickUpGirdPos = pickUpResCmpt:GetPopStarPickUpPos()
  if curPickUpGirdPos ~= Vector2(0, 0) then
    self:_HandleCancel(pickUpResCmpt)
  end
  local previewSvc = self._world:GetService("PreviewMonsterTrap")
  previewSvc:CheckPreviewMonsterAction(gridPos, offset)
  local monsterShowRSvc = self._world:GetService("MonsterShowRender")
  monsterShowRSvc:MonsterGridAnimDown()
end

function PopStarProInputSystem_Render:_HandleFirstClick(gridPos, offset, pickUpResCmpt)
  local utilDataSvc = self._world:GetService("UtilData")
  if not utilDataSvc:IsValidPiecePos(gridPos) then
    return
  end
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local pieceType = env:GetPieceType(gridPos)
  if pieceType == PieceType.None then
    return
  end
  pickUpResCmpt:SetPopStarPickUpPos(gridPos)
  local popStarRSvc = self._world:GetService("PopStarProRender")
  local previewSvc = self._world:GetService("PreviewMonsterTrap")
  previewSvc:CheckPreviewTrapAction(gridPos, offset)
  local connectPieces = popStarRSvc:CalculatePopStarConnectPieces(gridPos)
  pickUpResCmpt:SetPopStarConnectPieces(connectPieces)
  popStarRSvc:PreviewPopInfo(gridPos, connectPieces)
end

function PopStarProInputSystem_Render:_HandleClickOtherValidPos(gridPos, offset, pickUpResCmpt)
  local entityRSvc = self._world:GetService("RenderEntity")
  entityRSvc:DestroyGhost()
  pickUpResCmpt:ResetPopStarPickUp()
  self:_HandleFirstClick(gridPos, offset, pickUpResCmpt)
end

function PopStarProInputSystem_Render:_HandlePop(pickUpResCmpt)
  local entityRSvc = self._world:GetService("RenderEntity")
  entityRSvc:DestroyGhost()
  local pickUpPos = pickUpResCmpt:GetPopStarPickUpPos()
  local connectPieces = pickUpResCmpt:GetPopStarConnectPieces()
  local popStarRSvc = self._world:GetService("PopStarProRender")
  popStarRSvc:ClearPreviewPop(connectPieces)
  self._world:EventDispatcher():Dispatch(GameEventType.PopStarPickUp, pickUpPos, connectPieces)
  pickUpResCmpt:ResetPopStarPickUp()
end

function PopStarProInputSystem_Render:_HandleCancel(pickUpResCmpt)
  local entityRSvc = self._world:GetService("RenderEntity")
  entityRSvc:DestroyGhost()
  local connectPieces = pickUpResCmpt:GetPopStarConnectPieces()
  local popStarRSvc = self._world:GetService("PopStarProRender")
  popStarRSvc:ClearPreviewPop(connectPieces)
  popStarRSvc:PetHeadInQueue()
  pickUpResCmpt:ResetPopStarPickUp()
end
