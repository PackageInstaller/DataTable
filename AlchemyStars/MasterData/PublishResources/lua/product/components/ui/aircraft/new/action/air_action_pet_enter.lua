_class("AirActionPetEnter", AirActionBase)
AirActionPetEnter = AirActionPetEnter

function AirActionPetEnter:Constructor(pet, enterPos, delayTime)
  self._pet = pet
  self._delayTime = delayTime
  self._pet:SetPosition(enterPos)
  self._pet:GameObject():SetActive(false)
end

function AirActionPetEnter:Start()
  if self._delayTime <= 0 then
    self._pet:GameObject():SetActive(true)
    self._running = false
  else
    self._curTime = 0
    self._running = true
    self._pet:SetState(AirPetState.WaitForEnter)
  end
  self:LogStart()
end

function AirActionPetEnter:Update(deltaTimeMS)
  if self._running then
    self._curTime = self._curTime + deltaTimeMS
    if self._curTime > self._delayTime then
      self._pet:GameObject():SetActive(true)
      self._running = false
      self:Stop()
    end
  end
end

function AirActionPetEnter:IsOver()
  return not self._running
end

function AirActionPetEnter:Stop()
  self._running = false
  self:LogStop()
end
