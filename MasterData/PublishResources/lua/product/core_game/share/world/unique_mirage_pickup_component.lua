_class("MiragePickUpComponent", Object)
MiragePickUpComponent = MiragePickUpComponent

function MiragePickUpComponent:Constructor(world)
  self._world = world
  self._clickPos = Vector3(0, 0, 0)
  self._lastPickUpGridPos = Vector2(0, 0)
  self._curPickUpGridPos = Vector2(0, 0)
end

function MiragePickUpComponent:Initialize()
  Log.notice("MiragePickUpComponent Initialize")
end

function MiragePickUpComponent:SetClickPos(clickPos)
  self._clickPos = clickPos
end

function MiragePickUpComponent:GetClickPos()
  return self._clickPos
end

function MiragePickUpComponent:GetCurPickUpGridPos()
  return self._curPickUpGridPos
end

function MiragePickUpComponent:SetCurPickUpGridPos(gridPos)
  self._curPickUpGridPos = gridPos
end

function MainWorld:MiragePickUp()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.MiragePickUp)
end

function MainWorld:HasMiragePickUp()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.MiragePickUp) ~= nil
end

function MainWorld:AddMiragePickUp(world)
  local index = self.BW_UniqueComponentsEnum.MiragePickUp
  local component = MiragePickUpComponent:New(self)
  component:Initialize()
  self:SetUniqueComponent(index, component)
end

function MainWorld:RemoveMiragePickUp()
  if self:HasMiragePickUp() then
    self:SetUniqueComponent(self.BW_UniqueComponentsEnum.MiragePickUp, nil)
  end
end
