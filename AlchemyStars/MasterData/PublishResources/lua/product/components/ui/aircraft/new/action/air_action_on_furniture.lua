_class("AirActionOnFurniture", AirActionBase)
AirActionOnFurniture = AirActionOnFurniture

function AirActionOnFurniture:Constructor(pet, furniture, point, cond, duration, isInit)
  if pet == nil then
    return
  end
  if point == nil then
    Log.fatal("[AircraftFurniture] 家具点为空", debug.traceback())
  end
  self._pet = pet
  self._furniture = furniture
  self._point = point
  self._duration = duration
  self._isInit = isInit
  self._cond = cond
  self._triggerSocial = false
end

function AirActionOnFurniture:Start()
  local pos, rot = self._point:InteractionPoint()
  self._pet:SetPosition(pos)
  self._pet:SetRotation(rot)
  self._curTime = 0
  self._running = true
  self._furniture:OnPetArrive(self._pet)
  self._pet:SetFurnitureType(self._furniture:Type())
  self._pet:SetNaviEnable(false)
  local cfg = self._furniture:GetPetActionCfg(self._pet:SkinID())
  self._behaviour = AirActionBehaviour:New(self._furniture, self._pet, cfg, self._duration, self._isInit)
  self._behaviour:Start()
  self._excuted = true
end

function AirActionOnFurniture:Update(deltaTimeMS)
  if self._running then
    self._curTime = self._curTime + deltaTimeMS
    if self._curTime > self._duration then
      self._running = false
      self:Stop()
    else
      self._behaviour:Update(deltaTimeMS)
    end
  end
end

function AirActionOnFurniture:IsOver()
  return not self._running
end

function AirActionOnFurniture:StartSocial()
  self._triggerSocial = true
  return self._point, self._cond
end

function AirActionOnFurniture:Stop()
  if self._running then
    self._running = false
  end
  self._cond:ReleasePointOnStop()
  self._pet:SetFurnitureType(0)
  self._pet:SetPosition(self._point:MovePoint())
  self._behaviour:Stop()
  self._behaviour:Dispose()
  self._furniture:OnPetLeave(self._pet)
  self._pet:Anim_Stand()
  self._point = nil
end

function AirActionOnFurniture:GetPets()
  return {
    self._pet
  }
end

function AirActionOnFurniture:GetEncodeInfo()
  return self._furniture:GetPstKey(), self._point:Index()
end
