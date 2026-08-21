_class("HomelandPetComponentBase", Object)
HomelandPetComponentBase = HomelandPetComponentBase

function HomelandPetComponentBase:Constructor(componentType, pet, behavior)
  self._componentType = componentType
  self._pet = pet
  self.state = HomelandPetComponentState.Resting
  self._behavior = behavior
end

function HomelandPetComponentBase:ReLoadPetComponent()
end

function HomelandPetComponentBase:Init()
end

function HomelandPetComponentBase:OnExcute()
end

function HomelandPetComponentBase:Update(deltaTime)
end

function HomelandPetComponentBase:Exit()
  self.state = HomelandPetComponentState.Resting
end

function HomelandPetComponentBase:Dispose()
end

function HomelandPetComponentBase:Finish()
  return self.state == HomelandPetComponentState.Success
end

function HomelandPetComponentBase:Failure()
  return self.state == HomelandPetComponentState.Failure
end

function HomelandPetComponentBase:Resting()
  self.state = HomelandPetComponentState.Resting
end

function HomelandPetComponentBase:_OnUpdatePerFrameCallback()
  self:OnUpdatePerFrame()
end

function HomelandPetComponentBase:OnUpdatePerFrame()
end
