local this = class("component")

function this:ctor(parent)
  self.parent = parent
end

function this:emit(methodName, ...)
  if self.parent[methodName] == nil then
    return
  end
  self.parent[methodName](...)
end

function this:onBindGameObject(go)
end

function this:onReleaseGameObject()
end

function this:getGameObject()
  return self:getParent():getGameObject()
end

function this:getTransform()
  return self:getGameObject().transform
end

function this:isValid()
  local go = self:getGameObject()
  return go and not go:IsNull()
end

function this:getParent()
  return self.parent
end

function this:triggerParent(methodName, ...)
  local trigger = self.parent[methodName]
  if trigger then
    trigger(self.parent, ...)
  end
end

function this:onRemove()
  self:onDestroy()
end

function this:onDestroy()
  if self.parent ~= nil then
    self.parent = nil
  end
end

return this
