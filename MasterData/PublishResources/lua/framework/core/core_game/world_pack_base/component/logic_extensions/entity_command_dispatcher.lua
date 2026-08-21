_class("EntityCommandSimpleDispatcher", IEntityCommandDispatcher)
EntityCommandSimpleDispatcher = EntityCommandSimpleDispatcher

function EntityCommandSimpleDispatcher:Constructor()
  self.OnHandleCommand = DelegateEvent:New()
  self.owner = nil
end

function EntityCommandSimpleDispatcher:HandleCommand(cmd)
  self.OnHandleCommand(cmd)
end

function EntityCommandSimpleDispatcher:BindOwner(owner)
  self.owner = owner
  for i = 1, owner._components:Size() do
    local cmpt = owner._components:GetAt(i)
    if cmpt.HandleCommand then
      self.OnHandleCommand:AddEvent(cmpt, cmpt.HandleCommand)
    end
  end
  owner.Ev_OnComponentAdded:AddEvent(self, self._onComponentAdded)
  owner.Ev_OnComponentRemoved:AddEvent(self, self._onComponentRemoved)
  owner.Ev_OnComponentReplaced:AddEvent(self, self._onComponentReplaced)
end

function EntityCommandSimpleDispatcher:UnBindOwner()
  local owner = self.owner
  owner.Ev_OnComponentAdded:RemoveEvent(self, self._onComponentAdded)
  owner.Ev_OnComponentRemoved:RemoveEvent(self, self._onComponentRemoved)
  owner.Ev_OnComponentReplaced:RemoveEvent(self, self._onComponentReplaced)
  self.owner = nil
  self.OnHandleCommand:Clear()
end

function EntityCommandSimpleDispatcher:_onComponentAdded(entity, index, component)
  if component.HandleCommand then
    self.OnHandleCommand:AddEvent(component, component.HandleCommand)
  end
end

function EntityCommandSimpleDispatcher:_onComponentRemoved(entity, index, component)
  if component.HandleCommand then
    self.OnHandleCommand:RemoveEvent(component, component.HandleCommand)
  end
end

function EntityCommandSimpleDispatcher:_onComponentReplaced(entity, index, previousComponent, newComponent)
  if previousComponent ~= newComponent then
    if previousComponent.HandleCommand then
      self.OnHandleCommand:RemoveEvent(previousComponent, previousComponent.HandleCommand)
    end
    if newComponent.HandleCommand then
      self.OnHandleCommand:AddEvent(newComponent, newComponent.HandleCommand)
    end
  end
end
