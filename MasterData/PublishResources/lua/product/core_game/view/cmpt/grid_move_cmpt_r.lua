_class("GridMoveComponent", Object)
GridMoveComponent = GridMoveComponent

function GridMoveComponent:Constructor(speed, targetPos, originPos)
  self.speed = speed
  self.targetPos = Vector2(targetPos.x, targetPos.y)
  self.originPos = Vector2(originPos.x, originPos.y)
  self.isRefreshPiece = true
  self.isUpdateBlockInfo = false
  self.movingHeight = nil
end

function GridMoveComponent:GetTargetPos()
  return self.targetPos:Clone()
end

function GridMoveComponent:GetOriginPos()
  return self.originPos:Clone()
end

function GridMoveComponent:SetMovingHeight(height)
  self.movingHeight = height
end

function GridMoveComponent:GetMovingHeight()
  return self.movingHeight
end

function GridMoveComponent:GetSpeed()
  return self.speed
end

function GridMoveComponent:HasUpdateBlockInfo()
  return self.isUpdateBlockInfo
end

function GridMoveComponent:SetUpdateBlockInfoState(state)
  self.isUpdateBlockInfo = state
end

function GridMoveComponent:SetIsRefreshPiece(isRefreshPiece)
  self.isRefreshPiece = isRefreshPiece
end

function GridMoveComponent:IsRefreshPiece()
  return self.isRefreshPiece
end

function Entity:GridMove()
  return self:GetComponent(self.WEComponentsEnum.GridMove)
end

function Entity:HasGridMove()
  return self:HasComponent(self.WEComponentsEnum.GridMove)
end

function Entity:AddGridMove(speed, targetPos, originPos)
  if self:GetGridOffset() then
    targetPos = targetPos + self:GetGridOffset()
  end
  local index = self.WEComponentsEnum.GridMove
  local component = GridMoveComponent:New(speed, targetPos, originPos)
  self:AddComponent(index, component)
  return component
end

function Entity:ReplaceGridMove(speed, targetPos, originPos)
  if self:GetGridOffset() then
    targetPos = targetPos + self:GetGridOffset()
  end
  local index = self.WEComponentsEnum.GridMove
  local component = GridMoveComponent:New(speed, targetPos, originPos)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveGridMove()
  if self:HasGridMove() then
    self:RemoveComponent(self.WEComponentsEnum.GridMove)
  end
end
