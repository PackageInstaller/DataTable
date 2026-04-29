_class("RideComponent", Object)
RideComponent = RideComponent

function RideComponent:Constructor(riderID, mountID)
  self._riderID = riderID
  self._mountID = mountID
  self._onlyRiderCanClick = true
end

function RideComponent:GetRiderID()
  return self._riderID
end

function RideComponent:GetMountID()
  return self._mountID
end

function RideComponent:IsOnlyRiderCanClick()
  return self._onlyRiderCanClick
end

function RideComponent:SetOnlyRiderCanClick(canClick)
  self._onlyRiderCanClick = canClick
end

function Entity:Ride()
  return self:GetComponent(self.WEComponentsEnum.Ride)
end

function Entity:HasRide()
  return self:HasComponent(self.WEComponentsEnum.Ride)
end

function Entity:AddRide(riderID, mountID)
  local index = self.WEComponentsEnum.Ride
  local component = RideComponent:New(riderID, mountID)
  self:AddComponent(index, component)
end

function Entity:ReplaceRide(riderID, mountID)
  local index = self.WEComponentsEnum.Ride
  local component = RideComponent:New(riderID, mountID)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveRide()
  if self:HasRide() then
    self:RemoveComponent(self.WEComponentsEnum.Ride)
  end
end
