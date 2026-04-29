_class("AirActionEffect", AirActionBase)
AirActionEffect = AirActionEffect

function AirActionEffect:Constructor(pet, effName, slotType, offset, duration)
  self._pet = pet
  self._effName = effName
  local req = ResourceManager:GetInstance():SyncLoadAsset(effName, LoadType.GameObject)
  self._req = req
  self._effect = req.Obj
  self._transform = req.Obj.transform
  self._duration = duration
  if duration then
    self._timer = 0
  end
  self._slotType = slotType
  self._offset = offset
  if not self._offset then
    self._offset = Vector3.zero
  end
  if self._slotType == AircraftPetSlotType.None then
    self._transform.position = self._offset
  end
end

function AirActionEffect:Start()
  self._running = true
  self._effect:SetActive(true)
  local collider = self._effect:GetComponentInChildren(typeof(UnityEngine.BoxCollider))
  if collider then
    AirLog("特效包含碰撞器，设置给星灵:", self._effName, self._pet:PetName())
    self._pet:SetEffectCollider(collider)
    self._hasCollider = true
  end
end

function AirActionEffect:Stop()
  if self._running then
    self._running = false
  end
  self:Dispose()
end

function AirActionEffect:Dispose()
  self._req:Dispose()
  self._req = nil
  self._effect = nil
  self._transform = nil
  if self._hasCollider then
    self._pet:SetEffectCollider(nil)
  end
end

function AirActionEffect:Update(dt)
  if self._running then
    if self._slotType == AircraftPetSlotType.Root then
      self._transform.position = self._pet:WorldPosition() + self._offset
    elseif self._slotType == AircraftPetSlotType.Head then
      self._transform.position = self._pet:HeadPos() + self._offset
    end
    if self._duration then
      self._timer = self._timer + dt
      if self._timer > self._duration then
        self._running = false
        self:Stop()
      end
    end
  end
end

function AirActionEffect:IsOver()
  return not self._running
end

function AirActionEffect:GetGameObject()
  return self._effect
end
