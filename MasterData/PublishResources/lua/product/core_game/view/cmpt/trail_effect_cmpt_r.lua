_class("TrailEffectExComponent", Object)
TrailEffectExComponent = TrailEffectExComponent

function TrailEffectExComponent:Constructor()
  self._trailEffectContainer = nil
end

function TrailEffectExComponent:SetTrailEffectExController(csTrailEffectEx)
  self._trailEffectEx = csTrailEffectEx
end

function TrailEffectExComponent:LoadContainer(container)
  self._trailEffectContainer = container
  self._trailEffectEx:SetProfile(self._trailEffectContainer.Obj)
end

function Entity:TrailEffectEx()
  return self:GetComponent(self.WEComponentsEnum.TrailEffectEx)
end

function Entity:HasTrailEffectEx()
  return self:HasComponent(self.WEComponentsEnum.TrailEffectEx)
end

function Entity:AddTrailEffectEx(container, csTrailEffectEx)
  assert(container)
  local index = self.WEComponentsEnum.TrailEffectEx
  local component = TrailEffectExComponent:New(self)
  csTrailEffectEx.meshPoolSize = 1
  component:SetTrailEffectExController(csTrailEffectEx)
  component:LoadContainer(container)
  self:AddComponent(index, component)
end

function Entity:ReplaceTrailEffectEx()
  local index = self.WEComponentsEnum.TrailEffectEx
  local component = TrailEffectExComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveTrailEffectEx()
  if self:HasTrailEffectEx() then
    self:RemoveComponent(self.WEComponentsEnum.TrailEffectEx)
  end
end
