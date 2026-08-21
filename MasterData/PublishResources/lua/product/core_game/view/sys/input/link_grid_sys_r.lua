_class("LinkGridSystem_Render", UniqueReactiveSystem)
LinkGridSystem_Render = LinkGridSystem_Render

function LinkGridSystem_Render:IsInterested(index, previousComponent, component)
  if component == nil then
    return false
  end
  if not InputComponent:IsInstanceOfType(component) then
    return false
  end
  if not component:IsPreviewActiveSkill() then
    return false
  end
  if component:IsPreviewActiveSkillPlaying() then
    return false
  end
  return true
end

function LinkGridSystem_Render:ExecuteWorld(world)
  local gridTouchComponent = world:GridTouch()
  local inputComponent = world:Input()
  local gridTouchState = GridTouchStateID.Invalid
  local boardServiceRender = world:GetService("BoardRender")
  if inputComponent:IsTouchMoving() then
    gridTouchState = self:_CalcMultiDragPos(inputComponent, boardServiceRender, gridTouchComponent)
    inputComponent:SetTouchEnd(false)
    gridTouchComponent:SetGridTouchStateID(gridTouchState)
    world:SetUniqueComponent(world.BW_UniqueComponentsEnum.GridTouch, gridTouchComponent)
  elseif inputComponent:TouchHasBegin() then
    gridTouchState = self:_CalcDragBeginPos(inputComponent, boardServiceRender, gridTouchComponent)
    local lastGridTouchID = gridTouchComponent:GetGridTouchStateID()
    if lastGridTouchID ~= GridTouchStateID.PLLBeginDrag then
      inputComponent:SetTouchEnd(false)
      gridTouchComponent:SetGridTouchStateID(gridTouchState)
      world:SetUniqueComponent(world.BW_UniqueComponentsEnum.GridTouch, gridTouchComponent)
    end
  elseif inputComponent:TouchEnd() then
    gridTouchState = self:_CalcDragEndPos(inputComponent, boardServiceRender, gridTouchComponent)
    inputComponent:SetTouchEnd(false)
    gridTouchComponent:SetGridTouchStateID(gridTouchState)
    world:SetUniqueComponent(world.BW_UniqueComponentsEnum.GridTouch, gridTouchComponent)
  end
end

function LinkGridSystem_Render:Filter(world)
  return true
end

function LinkGridSystem_Render:_CalcMultiDragPos(inputComponent, boardServiceRender, gridTouchComponent)
  local lastTouchGridPosBefore = gridTouchComponent:GetLastTouchGridPos()
  gridTouchComponent:ClearGridMove()
  local timeService = self._world:GetService("Time")
  local touchMovePosArray = inputComponent:GetTouchMovePositionArray()
  for _, curTouchPos in ipairs(touchMovePosArray) do
    local gridPos = boardServiceRender:BoardRenderPos2FloatGridPos(curTouchPos)
    local offset = boardServiceRender:BoardGridPosOffset(curTouchPos)
    gridTouchComponent:AddGridMovePosition(gridPos)
    gridTouchComponent:AddGridMoveOffset(offset)
    gridTouchComponent:SetLastTouchTime(timeService:GetCurrentTimeMs())
  end
  local lastTouchGridPosBeAfter = gridTouchComponent:GetLastTouchGridPos()
  if not lastTouchGridPosBefore or lastTouchGridPosBeAfter ~= lastTouchGridPosBefore then
    gridTouchComponent:SetStayTouchGridPos(lastTouchGridPosBeAfter, timeService:GetCurrentTimeMs())
  end
  return GridTouchStateID.PLLDrag
end

function LinkGridSystem_Render:_CalcDragBeginPos(inputComponent, boardServiceRender, gridTouchComponent)
  local beginPos = inputComponent:GetTouchBeginPosition()
  local gridPos = boardServiceRender:BoardRenderPos2FloatGridPos(beginPos)
  gridTouchComponent:SetGridTouchBeginPosition(gridPos)
  local offset = boardServiceRender:BoardGridPosOffset(beginPos)
  gridTouchComponent:SetGridTouchOffset(offset)
  return GridTouchStateID.PLLBeginDrag
end

function LinkGridSystem_Render:_CalcDragEndPos()
  return GridTouchStateID.PLLEndDrag
end
