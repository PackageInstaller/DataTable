_class("CrazyModeComponent", Object)
CrazyModeComponent = CrazyModeComponent

function CrazyModeComponent:Constructor()
end

function Entity:CrazyMode()
  return self:GetComponent(self.WEComponentsEnum.CrazyMode)
end

function Entity:HasCrazyMode()
  return self:HasComponent(self.WEComponentsEnum.CrazyMode)
end

function Entity:ReplaceCrazyMode()
  local index = self.WEComponentsEnum.CrazyMode
  local component = CrazyModeComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveCrazyMode()
  if self:HasCrazyMode() then
    self:RemoveComponent(self.WEComponentsEnum.CrazyMode)
  end
end
