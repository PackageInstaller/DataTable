_class("UniqueReactiveSystem", Object)
UniqueReactiveSystem = UniqueReactiveSystem

function UniqueReactiveSystem:Constructor(world)
  self.world = world
  self._world = world
  if self.OnUniqueComponentReplaced then
    world.BW_Ev_OnUniqueComponentReplaced:AddEvent(self, self.OnUniqueComponentReplaced)
  end
  self.CheckExecute = false
end

function UniqueReactiveSystem:Dispose()
  self.world.BW_Ev_OnUniqueComponentReplaced:RemoveEvent(self, self.OnUniqueComponentReplaced)
  self.world = nil
end

function UniqueReactiveSystem:OnUniqueComponentReplaced(index, previousComponent, component)
  if self:IsInterested(index, previousComponent, component) then
    self.CheckExecute = true
  end
end

function UniqueReactiveSystem:Execute()
  local world = self.world
  if self.CheckExecute then
    if self:Filter(world) then
      self:ExecuteWorld(world)
    end
    self.CheckExecute = false
  end
end

function UniqueReactiveSystem:IsInterested(index, previousComponent, component)
  Log.fatal("call super UniqueReactiveSystem:GetMatcher Error")
  return false
end

function UniqueReactiveSystem:ExecuteWorld(world)
  Log.fatal("call super UniqueReactiveSystem:ExecuteEntities Error")
end

function UniqueReactiveSystem:Filter(world)
  return true
end
