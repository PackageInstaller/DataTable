_class("AirActionSendGift", AirActionBase)
AirActionSendGift = AirActionSendGift

function AirActionSendGift:Constructor(pet, effName, delayTime)
  self._effName = effName
  self._pet = pet
  self._eff = nil
  self._delayTime = delayTime
end

function AirActionSendGift:Start()
  self._eff = ResourceManager:GetInstance():SyncLoadAsset(self._effName, LoadType.GameObject)
  local effect = self._eff.Obj
  local pos = self._pet:WorldPosition()
  effect.transform.position = pos
  effect:SetActive(true)
  self._running = true
end

function AirActionSendGift:IsOver()
  return not self._running
end

function AirActionSendGift:Update(deltaTimeMS)
  if self._running then
    self._curTime = self._curTime + deltaTimeMS
    if self._curTime >= self._delayTime then
      self:Stop()
    end
  end
end

function AirActionSendGift:Stop()
  self._running = false
  self._curTime = 0
  self._delayTime = 0
  if self._eff then
    self._eff:Dispose()
    self._eff = nil
    self._effName = nil
    self._pet = nil
  end
end

function AirActionSendGift:GetPets()
  return {
    self._pets
  }
end

function AirActionSendGift:Dispose()
end
