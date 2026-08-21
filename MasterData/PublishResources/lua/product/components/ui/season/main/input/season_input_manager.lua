_class("SeasonInputManager", Object)
SeasonInputManager = SeasonInputManager

function SeasonInputManager:Constructor()
end

function SeasonInputManager:OnInit(seasonID)
  if EDITOR or IsPc() then
    self._seasonInput = SeasonInputPc:New(seasonID)
  else
    self._seasonInput = SeasonInputMobile:New(seasonID)
  end
end

function SeasonInputManager:Update(deltaTime)
  self._seasonInput:Update(deltaTime)
end

function SeasonInputManager:Dispose()
  self._seasonInput:Dispose()
  self._seasonInput = nil
end

function SeasonInputManager:GetInput()
  return self._seasonInput
end

function SeasonInputManager:GetClickUnLockZone()
  return self._seasonInput:GetClickUnLockZone()
end

function SeasonInputManager:GetClickZoneID()
  return self._seasonInput:GetClickZoneID()
end

function SeasonInputManager:SetClickZoneID(zoneId)
  return self._seasonInput:SetClickZoneID(zoneId)
end
