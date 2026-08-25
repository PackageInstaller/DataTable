local ActorSightComponent, Super = System.NewClass("ActorSightComponent", Component)

function ActorSightComponent:ctor()
  Super.ctor(self)
end

function ActorSightComponent:Awake(binder)
  Super.Awake(self)
  self.sightRadius = nil
end

function ActorSightComponent:Update()
end

function ActorSightComponent:SetSightRadius(radius)
  if tonumber(radius) == nil then
    return
  end
  self.sightRadius = tonumber(radius)
end

function ActorSightComponent:GetSightRadius()
  return self.sightRadius
end

function ActorSightComponent:OnDestroy()
  Super.OnDestroy(self)
end

return ActorSightComponent
