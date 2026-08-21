_class("MovementComponent", Object)

function MovementComponent:Constructor(movement)
  self.movementImp = movement or nil
end

function MovementComponent:WEC_PostInitialize(owner)
end

function MovementComponent:GetNextPosition()
  return self.movementImp.NextPosition
end

function MovementComponent:GetNextDirection()
  return self.movementImp.NextDirection
end

function MovementComponent:Update(locationCmpt, delta_time)
  return self.movementImp:Update(self.WEC_OwnerEntity, locationCmpt.Position, locationCmpt.Direction, delta_time)
end

function MovementComponent:IsFinish()
  return self.movementImp == nil or self.movementImp:IsFinish()
end

function Entity:Movement()
  return self:GetComponent(self.WEComponentsEnum.Movement)
end

function Entity:HasMovement()
  return self:HasComponent(self.WEComponentsEnum.Movement)
end

function Entity:ReplaceMovement(movement)
  local index = self.WEComponentsEnum.Movement
  local component = MovementComponent:New(movement)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveMovement()
  if self:HasMovement() then
    self:RemoveComponent(self.WEComponentsEnum.Movement)
  end
end
