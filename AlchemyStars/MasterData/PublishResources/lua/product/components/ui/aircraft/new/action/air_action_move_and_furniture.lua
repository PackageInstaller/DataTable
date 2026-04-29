_class("AirActionMoveAndFurniture", AirActionBase)
AirActionMoveAndFurniture = AirActionMoveAndFurniture

function AirActionMoveAndFurniture:Constructor(pet, furniture, point, main, duaration)
  self._pet = pet
  self._furniture = furniture
  self._point = point
  self._main = main
  self._duration = duaration
  self._interated = false
end

function AirActionMoveAndFurniture:Start()
  if self._point == nil then
    Log.fatal("该家具已没有可用点")
    return
  end
  self._moveAction = AirActionMove:New(self._pet, self._point:MovePoint(), self._furniture:Floor(), self._main, "移动-到家具")
  self._furnAction = AirActionOnFurniture:New(self._pet, self._furniture, self._point, self._duration)
  self._moveAction:Start()
  self._pet:SetMovingTargetArea(self._furniture:Area())
  self._pet:SetState(AirPetState.Transiting)
  self._running = true
  self:LogStart()
end

function AirActionMoveAndFurniture:Update(deltaTimeMS)
  if self._running then
    if self._moveAction and self._moveAction:IsOver() then
      if self._furnAction:IsOver() then
        self._running = false
        self._interated = true
        self:Stop()
      else
        self._furnAction:Update(deltaTimeMS)
      end
    else
      self._moveAction:Update(deltaTimeMS)
      if self._moveAction:IsOver() then
        self._pet:SetMovingTargetArea(nil)
        local random = AirHelper.RandomRelationPet(self._main, self._pet)
        if not random then
          self._furnAction:Start()
          self._pet:SetState(AirPetState.OnFurniture)
        end
      end
    end
  end
end

function AirActionMoveAndFurniture:IsOver()
  return not self._running
end

function AirActionMoveAndFurniture:Stop()
  if self._running then
    if not self._moveAction:IsOver() then
      self._moveAction:Stop()
    end
    self._running = false
  else
    self._main:RandomActionForPet(self._pet)
  end
  if not self._interated then
    self._furnAction:Stop()
  end
  self:LogStop()
end

function AirActionMoveAndFurniture:Duration()
  return self._furnAction:Duration()
end

function AirActionMoveAndFurniture:CurrentTime()
  return self._furnAction:CurrentTime()
end

function AirActionMoveAndFurniture:GetEncodeInfo()
  return self._furnAction:GetEncodeInfo()
end

function AirActionMoveAndFurniture:GetPets()
  return {
    self._pet
  }
end
