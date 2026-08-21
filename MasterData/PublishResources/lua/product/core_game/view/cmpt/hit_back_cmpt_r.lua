_class("HitbackComponent", Object)

function HitbackComponent:Constructor(startPos, speed, targetPos, hitDir, gridOffset)
  self._isStartMove = nil
  self._speed = speed
  self._targetPos = targetPos
  self._startPos = startPos
  self._gridOffset = gridOffset
  self._materialAnim = nil
  self._deltaTime = 0
  self._hitbackEnd = false
end

function HitbackComponent:GetDeltaTime()
  return self._deltaTime
end

function HitbackComponent:AppendDeltaTime(dt)
  self._deltaTime = self._deltaTime + dt
end

function HitbackComponent:ResetDeltaTime()
  self._deltaTime = 0
end

function HitbackComponent:GetHitbackSpeed()
  return self._speed
end

function HitbackComponent:GetHitbackStartPos()
  return self._startPos
end

function HitbackComponent:SetStartMoving(_isMoving)
  self._isStartMove = _isMoving
end

function HitbackComponent:IsStartMoving()
  return self._isStartMove
end

function HitbackComponent:GetHitbackTargetPos()
  return self._targetPos
end

function HitbackComponent:SetMaterialAnim(materialAnim)
  self._materialAnim = materialAnim
end

function HitbackComponent:GetMaterialAnim()
  return self._materialAnim
end

function HitbackComponent:IsHitbackEnd()
  return self._hitbackEnd
end

function HitbackComponent:SetHitbackEnd()
  self._hitbackEnd = true
end

function HitbackComponent:GetGridOffset()
  return self._gridOffset
end

function Entity:Hitback()
  return self:GetComponent(self.WEComponentsEnum.Hitback)
end

function Entity:HasHitback()
  return self:HasComponent(self.WEComponentsEnum.Hitback)
end

function Entity:AddHitback(startPos, speed, targetPos, hitDir)
  local index = self.WEComponentsEnum.Hitback
  local gridOffset = self:GetGridOffset()
  if gridOffset then
    targetPos = targetPos + gridOffset
  end
  local component = HitbackComponent:New(startPos, speed, targetPos, hitDir, gridOffset)
  self:AddComponent(index, component)
end

function Entity:ReplaceHitback(startPos, speed, targetPos, hitDir)
  local gridOffset = self:GetGridOffset()
  if gridOffset then
    targetPos = targetPos + gridOffset
  end
  local index = self.WEComponentsEnum.Hitback
  local component = HitbackComponent:New(startPos, speed, targetPos, hitDir, gridOffset)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveHitback()
  if self:HasHitback() then
    self:RemoveComponent(self.WEComponentsEnum.Hitback)
  end
end
