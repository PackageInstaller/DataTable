_class("ChessPickUpComponent", Object)
ChessPickUpComponent = ChessPickUpComponent

function ChessPickUpComponent:Constructor(world)
  self._world = world
  self._clickPos = Vector3(0, 0, 0)
  self._lastPickUpGridPos = Vector2(0, 0)
  self._curPickUpGridPos = Vector2(0, 0)
  self._targetType = ChessPickUpTargetType.None
end

function ChessPickUpComponent:Initialize()
  Log.notice("ChessPickUpComponent Initialize")
end

function ChessPickUpComponent:SetChessClickPos(clickPos)
  self._clickPos = clickPos
end

function ChessPickUpComponent:GetChessClickPos()
  return self._clickPos
end

function ChessPickUpComponent:GetChessEntityID()
  return self._entityID
end

function ChessPickUpComponent:SetChessEntityID(entityID)
  self._entityID = entityID
end

function ChessPickUpComponent:GetChessPickUpTargetType()
  return self._targetType
end

function ChessPickUpComponent:SetChessPickUpTargetType(type)
  self._targetType = type
end

function MainWorld:ChessPickUp()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.ChessPickUp)
end

function MainWorld:HasChessPickUp()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.ChessPickUp) ~= nil
end

function MainWorld:AddChessPickUp(world)
  local index = self.BW_UniqueComponentsEnum.ChessPickUp
  local component = ChessPickUpComponent:New(self)
  component:Initialize()
  self:SetUniqueComponent(index, component)
end

function MainWorld:RemoveChessPickUp()
  if self:HasChessPickUp() then
    self:SetUniqueComponent(self.BW_UniqueComponentsEnum.ChessPickUp, nil)
  end
end
