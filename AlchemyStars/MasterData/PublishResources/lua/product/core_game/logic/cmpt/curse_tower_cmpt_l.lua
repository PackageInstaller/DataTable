local CurseTowerState = {
  Idle = -1,
  Deactive = 0,
  Active = 1
}
_enum("CurseTowerState", CurseTowerState)
_class("CurseTowerComponent", Object)
CurseTowerComponent = CurseTowerComponent

function CurseTowerComponent:Constructor()
  self._towerIndex = 0
  self._towerState = CurseTowerState.Idle
end

function CurseTowerComponent:SetTowerIndex(index)
  self._towerIndex = index
end

function CurseTowerComponent:GetTowerIndex()
  return self._towerIndex
end

function CurseTowerComponent:SetTowerState(state)
  self._towerState = state
end

function CurseTowerComponent:GetTowerState()
  return self._towerState
end

function CurseTowerComponent:WEC_PostInitialize(owner)
end

function CurseTowerComponent:WEC_PostRemoved()
end

function Entity:CurseTower()
  return self:GetComponent(self.WEComponentsEnum.CurseTower)
end

function Entity:HasCurseTower()
  return self:HasComponent(self.WEComponentsEnum.CurseTower)
end

function Entity:AddCurseTower()
  local index = self.WEComponentsEnum.CurseTower
  local component = CurseTowerComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceCurseTower()
  local index = self.WEComponentsEnum.CurseTower
  local component = CurseTowerComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveCurseTower()
  if self:HasCurseTower() then
    self:RemoveComponent(self.WEComponentsEnum.CurseTower)
  end
end
