_class("MirageInputSystem_Render", UniqueReactiveSystem)
MirageInputSystem_Render = MirageInputSystem_Render

function MirageInputSystem_Render:IsInterested(index, previousComponent, component)
  if component == nil then
    return false
  end
  if not MiragePickUpComponent:IsInstanceOfType(component) then
    return false
  end
  return true
end

function MirageInputSystem_Render:Filter(world)
  return true
end

function MirageInputSystem_Render:ExecuteWorld(world)
  self._world = world
  local miragePickUpCmpt = world:MiragePickUp()
  local clickRenderPos = miragePickUpCmpt:GetClickPos()
  local boardServiceRender = world:GetService("BoardRender")
  local gridPos = boardServiceRender:BoardRenderPos2GridPos(clickRenderPos)
  local utilDataSvc = self._world:GetService("UtilData")
  local stateId = utilDataSvc:GetCurMainStateID()
  if stateId == GameStateID.MirageWaitInput then
    self:SetPickUpGrid(miragePickUpCmpt, gridPos, stateId)
  else
    Log.fatal("### Mirage invalid state. stateId=", stateId)
  end
end

function MirageInputSystem_Render:SetPickUpGrid(miragePickUpCmpt, gridPos, stateId)
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
  local isValid = self:CheckPickUpValidGrid(gridPos)
  if isValid then
    miragePickUpCmpt:SetCurPickUpGridPos(gridPos)
    self:_HandlePickGrid(gridPos)
  else
    miragePickUpCmpt:SetCurPickUpGridPos(Vector2.zero)
    self:_HandleClearPick()
  end
end

function MirageInputSystem_Render:CheckPickUpValidGrid(touchPosition)
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    if not e:HasGhost() and not e:HasGuideGhost() and e:IsOnGridPosition(touchPosition) then
      return false
    end
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if teamEntity:IsOnGridPosition(touchPosition) then
    return false
  end
  local utilData = self._world:GetService("UtilData")
  local validGrids = utilData:GetRoundGrid(teamEntity:GetGridPosition())
  local roundGridPosList = {}
  for _, grid in ipairs(validGrids) do
    local pos = Vector2(grid.x, grid.y)
    table.insert(roundGridPosList, pos)
  end
  if not table.icontains(roundGridPosList, touchPosition) then
    return false
  end
  if utilData:IsValidPiecePos(touchPosition) and not utilData:IsPosBlock(touchPosition, BlockFlag.LinkLine) then
    return true
  end
  return false
end

function MirageInputSystem_Render:_HandlePickGrid(gridPos)
  local piece_service = self._world:GetService("Piece")
  piece_service:SetAllPieceDark()
  piece_service:SetPieceAnimNormal(gridPos)
  self._world:EventDispatcher():Dispatch(GameEventType.RefreshMiragePickUpGrid, true)
end

function MirageInputSystem_Render:_HandleClearPick()
  local mirageSvcRender = self._world:GetService("MirageRender")
  mirageSvcRender:ClearMiragePick()
end
