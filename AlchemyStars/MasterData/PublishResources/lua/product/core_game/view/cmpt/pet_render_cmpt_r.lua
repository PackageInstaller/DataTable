_class("PetRenderComponent", Object)
PetRenderComponent = PetRenderComponent

function PetRenderComponent:Constructor()
  self._pet1601751HPAboveLimitAutoCastActiveCount = 0
end

function PetRenderComponent:RecordPetMinosGhostUsedPos(pos)
  if not self._petMinosGhostUsedPosList then
    self._petMinosGhostUsedPosList = {}
  end
  table.insert(self._petMinosGhostUsedPosList, pos)
end

function PetRenderComponent:ClearPetMinosGhostUsedPos(pos)
  if self._petMinosGhostUsedPosList then
    table.removev(self._petMinosGhostUsedPosList, pos)
  end
end

function PetRenderComponent:GetPetMinosGhostUsedPosList()
  if not self._petMinosGhostUsedPosList then
    self._petMinosGhostUsedPosList = {}
  end
  return self._petMinosGhostUsedPosList
end

function PetRenderComponent:ClearPetMinosGhostUsedPosList()
  self._petMinosGhostUsedPosList = {}
end

function PetRenderComponent:WEC_PostInitialize(owner)
end

function PetRenderComponent:WEC_PostRemoved()
end

function PetRenderComponent:GetPet1601751HPAboveLimitAutoCastActiveCount()
  return self._pet1601751HPAboveLimitAutoCastActiveCount
end

function PetRenderComponent:TickPet1601751HPAboveLimitAutoCastActiveCount()
  self._pet1601751HPAboveLimitAutoCastActiveCount = self._pet1601751HPAboveLimitAutoCastActiveCount + 1
end

function PetRenderComponent:ClearPet1601751HPAboveLimitAutoCastActiveCount()
  self._pet1601751HPAboveLimitAutoCastActiveCount = 0
end

function Entity:PetRender()
  return self:GetComponent(self.WEComponentsEnum.PetRender)
end

function Entity:HasPetRender()
  return self:HasComponent(self.WEComponentsEnum.PetRender)
end

function Entity:AddPetRender()
  local index = self.WEComponentsEnum.PetRender
  local component = PetRenderComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePetRender()
  local index = self.WEComponentsEnum.PetRender
  local component = PetRenderComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemovePetRender()
  if self:HasPetRender() then
    self:RemoveComponent(self.WEComponentsEnum.PetRender)
  end
end
