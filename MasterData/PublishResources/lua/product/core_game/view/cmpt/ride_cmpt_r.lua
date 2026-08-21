_class("RideRenderComponent", Object)
RideRenderComponent = RideRenderComponent

function RideRenderComponent:Constructor(riderID, mountID)
  self._riderID = riderID
  self._mountID = mountID
end

function RideRenderComponent:GetRiderID()
  return self._riderID
end

function RideRenderComponent:GetMountID()
  return self._mountID
end

function Entity:RideRender()
  return self:GetComponent(self.WEComponentsEnum.RideRender)
end

function Entity:HasRideRender()
  return self:HasComponent(self.WEComponentsEnum.RideRender)
end

function Entity:AddRideRender(riderID, mountID)
  local index = self.WEComponentsEnum.RideRender
  local component = RideComponent:New(riderID, mountID)
  self:AddComponent(index, component)
end

function Entity:ReplaceRideRender(riderID, mountID)
  local index = self.WEComponentsEnum.RideRender
  local component = RideRenderComponent:New(riderID, mountID)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveRideRender()
  if self:HasRideRender() then
    self:RemoveComponent(self.WEComponentsEnum.RideRender)
  end
end
