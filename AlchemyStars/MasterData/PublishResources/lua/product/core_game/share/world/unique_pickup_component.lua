_class("PickUpComponent", Object)
PickUpComponent = PickUpComponent

function PickUpComponent:Constructor(world)
  self._world = world
  self._clickPos = Vector3(0, 0, 0)
  self._lastPickUpGridPos = Vector2(0, 0)
  self._curPickUpGridPos = Vector2(0, 0)
  self._activeSkillID = -1
  self._petPstID = -1
  self._entityID = -1
end

function PickUpComponent:Initialize()
  Log.notice("PickUpComponent Initialize")
end

function PickUpComponent:SetClickPos(clickPos)
  self._clickPos = clickPos
end

function PickUpComponent:GetClickPos()
  return self._clickPos
end

function PickUpComponent:SetCurActiveSkillInfo(activeSkillID, petPstID)
  self._activeSkillID = activeSkillID
  self._petPstID = petPstID
end

function PickUpComponent:GetCurActiveSkillID()
  return self._activeSkillID
end

function PickUpComponent:GetCurActiveSkillPetPstID()
  return self._petPstID
end

function PickUpComponent:GetEntityID()
  return self._entityID
end

function PickUpComponent:SetEntityID(entityID)
  self._entityID = entityID
end

function PickUpComponent:ResetPickUpData()
  self._clickPos = Vector3(0, 0, 0)
  self._lastPickUpGridPos = Vector2(0, 0)
  self._curPickUpGridPos = Vector2(0, 0)
  self._activeSkillID = -1
  self._petPstID = -1
  self._entityID = -1
end

function MainWorld:PickUp()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.PickUp)
end

function MainWorld:HasPickUp()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.PickUp) ~= nil
end

function MainWorld:AddPickUp(world)
  local index = self.BW_UniqueComponentsEnum.PickUp
  local component = PickUpComponent:New(self)
  component:Initialize()
  self:SetUniqueComponent(index, component)
end

function MainWorld:RemovePickUp()
  if self:HasPickUp() then
    self:SetUniqueComponent(self.BW_UniqueComponentsEnum.PickUp, nil)
  end
end
