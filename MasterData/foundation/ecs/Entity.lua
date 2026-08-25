local Entity = System.NewClass("Entity", IDestroyable)

function Entity:ctor()
  self._components = SafeList("__componentRemoved")
  self._updaters = SafeList("__updateRemoved")
  self._startComponents = SafeList("__startRemoved")
  self.binder = Vue.newBinder(self)
end

function Entity:CheckDestroied()
  if self.destroyed then
    Logger.Debug(debug.traceback(">>>容器已销毁，无法调用此函数"))
    return true
  end
  return false
end

function Entity:GetComponent(T)
  local exist = self:GetComponent1(T)
  if not exist then
    return nil
  end
  do return System.cast, exist end
  return System.cast, exist, T
end

function Entity.OnGetComponent(v, T)
  do return T.isDerivedFrom, T, v:GetType() end
  return T.isDerivedFrom, T, v:GetType()
end

function Entity:GetComponent1(T)
  if self:CheckDestroied() then
    return nil
  end
  do return self._components.Find, self._components, Entity.OnGetComponent, T end
  return self._components.Find, self._components, Entity.OnGetComponent, T, System.Type
end

function Entity:GetComponents(T)
  if self:CheckDestroied() then
    return nil
  end
  do return self._components.Finds, self._components, Entity.OnGetComponent, T end
  return self._components.Finds, self._components, Entity.OnGetComponent, T, System.Type
end

function Entity:GetOrAddComponent(T, ...)
  if self:CheckDestroied() then
    return nil
  end
  local comp = self:GetComponent1(T)
  if nil == comp then
    comp = self:AddComponent(T, ...)
  end
  return comp
end

function Entity:AddComponent(T, ...)
  if self:CheckDestroied() then
    return nil
  end
  local component = T(...):as(Component)
  component.parent = self
  self._components:Add(component)
  self._startComponents:Add(component)
  if component:is(IUpdater) then
    self._updaters:Add(component)
  end
  local binder = self.binder:createChild(component)
  component.binder = binder
  component:Awake(binder)
  
  function component.__unbind()
    binder:teardown()
  end
  
  return component
end

function Entity:DestroyComponent(component)
  if self._components == nil then
    return
  end
  if component.destroyed then
    Logger.Debug("组件被重复销毁：%s , %s", component, component:GetType():GetTypeFullName())
    return
  end
  if component:is(IUpdater) then
    self._updaters:Remove(component)
  end
  self._components:Remove(component)
  self._startComponents:Remove(component)
  component:OnDestroy()
  if component.__unbind then
    component.__unbind()
    component.__unbind = nil
  end
  component.destroyed = true
end

function Entity.OnStart(v)
  v:Start()
end

function Entity:Start()
  if self._startComponents:getIsEmpty() then
    return
  end
  self.destroyed = false
  self._startComponents:ForEach(Entity.OnStart)
  self._startComponents:Clear()
end

function Entity:Update(dt)
  if self:CheckDestroied() then
    return
  end
  self:Start()
  self._updaters:Update(dt)
end

function Entity.OnDestroy(component)
  component:OnDestroy()
  if component.__unbind then
    component.__unbind()
    component.__unbind = nil
  end
  component.destroyed = true
end

function Entity:Destroy()
  if self.destroyed then
    return
  end
  self.destroyed = true
  self.binder:teardown()
  self.binder = nil
  self._components:Destroy(Entity.OnDestroy)
  self._updaters:Clear()
  self._components:Clear()
  self._startComponents:Clear()
  self._components = nil
  self._startComponents = nil
end

function Entity:isDestroyed()
  return self.destroyed
end

return Entity
