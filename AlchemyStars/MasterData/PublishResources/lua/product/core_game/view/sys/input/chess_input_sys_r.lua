_class("ChessInputSystem_Render", UniqueReactiveSystem)
ChessInputSystem_Render = ChessInputSystem_Render

function ChessInputSystem_Render:IsInterested(index, previousComponent, component)
  if component == nil then
    return false
  end
  if not ChessPickUpComponent:IsInstanceOfType(component) then
    return false
  end
  return true
end

function ChessInputSystem_Render:Filter(world)
  return true
end

function ChessInputSystem_Render:ExecuteWorld(world)
  self._world = world
  local chessPickUpCmpt = world:ChessPickUp()
  local clickRenderPos = chessPickUpCmpt:GetChessClickPos()
  local boardServiceRender = world:GetService("BoardRender")
  local gridPos = boardServiceRender:BoardRenderPos2GridPos(clickRenderPos)
  local utilDataSvc = self._world:GetService("UtilData")
  local stateId = utilDataSvc:GetCurMainStateID()
  if stateId == GameStateID.WaitInput or stateId == GameStateID.PreviewChessPet or stateId == GameStateID.PickUpChessPet then
    self:SetChessPickUpGrid(chessPickUpCmpt, gridPos, stateId)
  else
    Log.fatal("### invalid state. stateId=", stateId)
  end
end

function ChessInputSystem_Render:SetChessPickUpGrid(cPickUp, gridPos, stateId)
  local utilData = self._world:GetService("UtilData")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local guideService = self._world:GetService("Guide")
  local isGuide, isValid = guideService:IsGuideAndPieceValid(gridPos.x, gridPos.y)
  if isGuide then
    if isValid then
      self._world:EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Piece)
    else
      return
    end
  end
  local pickUpResCmpt = renderBoardEntity:PickUpChessResult()
  pickUpResCmpt:SetChessPickUpPos(gridPos)
  local lastPickUpTargetType = pickUpResCmpt:GetChessPickUpResultType()
  local pickUpChessPetEntityID = pickUpResCmpt:GetPickUpChessPetEntityID()
  local selectMonster, curPickUpMonsterEntityID = self:CheckPickUpMonster(gridPos)
  local selectHookChess, curPickUpHookChessEntityID = self:CheckChessHookChess(gridPos, pickUpResCmpt)
  if selectMonster then
    self:_HandleChessInputPickMonster(gridPos, curPickUpMonsterEntityID)
  elseif not selectMonster and selectHookChess and pickUpChessPetEntityID then
    self:_HandleChessInputPickMonster(gridPos, curPickUpHookChessEntityID)
  else
    pickUpResCmpt:SetPickUpMonsterEntityID(nil)
    local selectChessPet, curPickUpChessPetEntityID = self:CheckPickUpChessPet(gridPos)
    if selectChessPet then
      self:_HandleChessInputPickChessPet(gridPos, curPickUpChessPetEntityID)
    else
      self:_HandleChessInputPickGrid(gridPos)
    end
  end
end

function ChessInputSystem_Render:CheckPickUpMonster(touchPosition)
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(group:GetEntities()) do
    if not e:HasGhost() and not e:HasGuideGhost() and e:IsOnGridPosition(touchPosition) then
      return true, e:GetID()
    end
  end
  return false, nil
end

function ChessInputSystem_Render:CheckChessHookChess(touchPosition, pickUpResCmpt)
  local attackRange = pickUpResCmpt:GetChessPetAttackRange()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.ChessPet)
  for _, e in ipairs(group:GetEntities()) do
    if e:IsOnGridPosition(touchPosition) and table.intable(attackRange, touchPosition) then
      return true, e:GetID()
    end
  end
  return false, nil
end

function ChessInputSystem_Render:CheckPickUpChessPet(touchPosition)
  local group = self._world:GetGroup(self._world.BW_WEMatchers.ChessPet)
  for _, e in ipairs(group:GetEntities()) do
    if not e:HasDeadMark() and e:IsOnGridPosition(touchPosition) then
      return true, e:GetID()
    end
  end
  return false, nil
end

function ChessInputSystem_Render:_HandleChessInputPickChessPet(gridPos, pickEntityID)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpResCmpt = renderBoardEntity:PickUpChessResult()
  local lastPickUpPetEntityID = pickUpResCmpt:GetPickUpChessPetEntityID()
  if pickEntityID ~= lastPickUpPetEntityID then
    pickUpResCmpt:SetChessPickUpTargetChanged(true)
    local stateID = self:_GetChessInputMainStateID()
    if stateID == GameStateID.PreviewChessPet or stateID == GameStateID.PickUpChessPet then
    else
      pickUpResCmpt:SetChessPickUpTargetChanged(true)
      pickUpResCmpt:SetChessPickUpResultType(ChessPickUpTargetType.ChessPet)
      pickUpResCmpt:SetPickUpChessPetEntityID(pickEntityID)
      renderBoardEntity:ReplacePickUpChessResult()
    end
  else
    pickUpResCmpt:SetChessPickUpTargetChanged(false)
    pickUpResCmpt:SetChessPickUpResultType(ChessPickUpTargetType.ChessPet)
    pickUpResCmpt:SetPickUpChessPetEntityID(pickEntityID)
    renderBoardEntity:ReplacePickUpChessResult()
  end
end

function ChessInputSystem_Render:_HandleChessInputPickMonster(gridPos, pickEntityID)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpResCmpt = renderBoardEntity:PickUpChessResult()
  local lastPickUpMonsterEntityID = pickUpResCmpt:GetPickUpMonsterEntityID()
  if lastPickUpMonsterEntityID == nil then
    pickUpResCmpt:SetChessPickUpTargetChanged(true)
  elseif pickEntityID ~= lastPickUpMonsterEntityID then
    pickUpResCmpt:SetChessPickUpTargetChanged(true)
  else
    pickUpResCmpt:SetChessPickUpTargetChanged(false)
  end
  pickUpResCmpt:SetChessPickUpResultType(ChessPickUpTargetType.Monster)
  pickUpResCmpt:SetPickUpMonsterEntityID(pickEntityID)
  renderBoardEntity:ReplacePickUpChessResult()
end

function ChessInputSystem_Render:_HandleChessInputPickGrid(gridPos)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpResCmpt = renderBoardEntity:PickUpChessResult()
  local lastPickUpTargetType = pickUpResCmpt:GetChessPickUpResultType()
  pickUpResCmpt:SetChessPickUpResultType(ChessPickUpTargetType.Grid)
  renderBoardEntity:ReplacePickUpChessResult()
  Log.notice("ChessPickUp nothing : ", gridPos)
end

function ChessInputSystem_Render:_GetChessInputMainStateID()
  local utilDataSvc = self._world:GetService("UtilData")
  local stateId = utilDataSvc:GetCurMainStateID()
  return stateId
end
