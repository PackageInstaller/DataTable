_class("PetDeadMarkComponent", Object)

function PetDeadMarkComponent:Constructor()
  self._hasUnLoad = false
end

function PetDeadMarkComponent:IsUnLoad()
  return self._hasUnLoad
end

function PetDeadMarkComponent:SetUnLoadState(state)
  self._hasUnLoad = state
end

function Entity:PetDeadMark()
  return self:GetComponent(self.WEComponentsEnum.PetDeadMark)
end

function Entity:HasPetDeadMark()
  return self:HasComponent(self.WEComponentsEnum.PetDeadMark)
end

function Entity:AddPetDeadMark()
  if self._world:BattleStat():GetFirstDeadPetEntity() == nil then
    self._world:BattleStat():SetFirstDeadPetEntity(self)
  end
  local index = self.WEComponentsEnum.PetDeadMark
  local component = PetDeadMarkComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePetDeadMark()
  local index = self.WEComponentsEnum.PetDeadMark
  local component = PetDeadMarkComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemovePetDeadMark()
  if self:HasPetDeadMark() then
    self:RemoveComponent(self.WEComponentsEnum.PetDeadMark)
  end
end
