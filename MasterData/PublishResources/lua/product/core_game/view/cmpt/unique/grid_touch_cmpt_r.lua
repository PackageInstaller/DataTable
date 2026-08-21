_class("GridTouchComponent", Object)
GridTouchComponent = GridTouchComponent

function GridTouchComponent:Constructor(world)
  self.gridTouchBeginPosition = nil
  self.gridTouchCurrentPosition = nil
  self.gridTouchEndPosition = UnityEngine.Vector2:New(-1, -1)
  self.gridTouchStateID = GridTouchStateID.Invalid
  self.lastTouchTime = -1
  self.gridTouchOffset = nil
  self.doubleClickPos = nil
  self._gridTouchPosArray = {}
  self._gridTouchOffsetArray = {}
  self._isTouchPlayer = false
  self._stayTouchGridPos = nil
  self._stayTouchBeginTime = 0
end

function GridTouchComponent:Destructor()
  self.gridTouchBeginPosition = nil
  self.gridTouchCurrentPosition = nil
  self.gridTouchEndPosition = nil
  self.gridTouchOffset = nil
  self.doubleClickPos = nil
  self._gridTouchPosArray = nil
  self._gridTouchOffsetArray = nil
end

function GridTouchComponent:Initialize()
end

function GridTouchComponent:SetGridTouchBeginPosition(position)
  self.gridTouchBeginPosition = position
end

function GridTouchComponent:GetGridTouchBeginPosition()
  return self.gridTouchBeginPosition
end

function GridTouchComponent:SetGridTouchCurrentPosition(position)
  self.gridTouchCurrentPosition = position
end

function GridTouchComponent:GetGridTouchCurrentPosition()
  return self.gridTouchCurrentPosition
end

function GridTouchComponent:GetGridMovePositionArray()
  return self._gridTouchPosArray
end

function GridTouchComponent:GetGridMoveOffsetArray()
  return self._gridTouchOffsetArray
end

function GridTouchComponent:AddGridMovePosition(position)
  self._gridTouchPosArray[#self._gridTouchPosArray + 1] = position
end

function GridTouchComponent:AddGridMoveOffset(offset)
  self._gridTouchOffsetArray[#self._gridTouchOffsetArray + 1] = offset
end

function GridTouchComponent:ClearGridMove()
  self._gridTouchPosArray = {}
  self._gridTouchOffsetArray = {}
end

function GridTouchComponent:SetGridTouchEndPosition(position)
  self.gridTouchCurrentPosition = position
end

function GridTouchComponent:GetGridTouchEndPosition()
  return self.gridTouchCurrentPosition
end

function GridTouchComponent:GetGridTouchStateID()
  return self.gridTouchStateID
end

function GridTouchComponent:SetGridTouchStateID(stateID)
  self.gridTouchStateID = stateID
end

function GridTouchComponent:SetGridTouchOffset(offset)
  self.gridTouchOffset = offset
end

function GridTouchComponent:GetGridTouchOffset()
  return self.gridTouchOffset
end

function GridTouchComponent:SetDoubleClickPos(dbClickPos)
  self.doubleClickPos = dbClickPos
end

function GridTouchComponent:GetDoubleClickPos()
  return self.doubleClickPos
end

function GridTouchComponent:IsTouchPlayer()
  return self._isTouchPlayer
end

function GridTouchComponent:SetTouchPlayer(isTouchPlayer)
  self._isTouchPlayer = isTouchPlayer
end

function GridTouchComponent:SetLastTouchTime(time)
  self.lastTouchTime = time
end

function GridTouchComponent:GetLastTouchGridPos()
  return self._gridTouchPosArray[#self._gridTouchPosArray]
end

function GridTouchComponent:SetStayTouchGridPos(gridPos, timeNow)
  self._stayTouchBeginTime = timeNow
  self._stayTouchGridPos = Vector2(gridPos.x, gridPos.y)
end

function GridTouchComponent:GetStayTouchPos()
  return self._stayTouchGridPos
end

function GridTouchComponent:GetStayTouchDuration(timeNow)
  return timeNow - self._stayTouchBeginTime
end

function MainWorld:GridTouch()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.GridTouch)
end

function MainWorld:HasGridTouch()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.GridTouch) ~= nil
end

function MainWorld:AddGridTouch()
  local index = self.BW_UniqueComponentsEnum.GridTouch
  local component = GridTouchComponent:New(self)
  component:Initialize()
  self:SetUniqueComponent(index, component)
end

function MainWorld:RemoveGridTouch()
  if self:HasGridTouch() then
    self:SetUniqueComponent(self.BW_UniqueComponentsEnum.GridTouch, nil)
  end
end
