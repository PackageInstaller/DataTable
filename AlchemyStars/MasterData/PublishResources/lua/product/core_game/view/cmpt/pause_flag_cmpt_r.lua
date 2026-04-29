_class("PauseFlagComponent", Object)
PauseFlagComponent = PauseFlagComponent

function PauseFlagComponent:Constructor()
  self._pauseDuration = 0
end

function PauseFlagComponent:SetPauseDuration(pauseDuration)
  self._pauseDuration = pauseDuration
end

function PauseFlagComponent:GetPauseDuration()
  return self._pauseDuration
end

function Entity:PauseFlag()
  return self:GetComponent(self.WEComponentsEnum.PauseFlag)
end

function Entity:HasPauseFlag()
  return self:HasComponent(self.WEComponentsEnum.PauseFlag)
end

function Entity:AddPauseFlag(pauseDuration)
  local index = self.WEComponentsEnum.PauseFlag
  local component = PauseFlagComponent:New()
  component:SetPauseDuration(pauseDuration)
  self:AddComponent(index, component)
end

function Entity:RemovePauseFlag()
  if self:HasPauseFlag() then
    self:RemoveComponent(self.WEComponentsEnum.PauseFlag)
  end
end
