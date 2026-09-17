local this = class("alive")
local m_guid = 0

local function _generateGuid(alive)
  m_guid = m_guid + 1
  alive.guid = m_guid
end

function this:ctor(entityType)
  _generateGuid(self)
  self.entityType = entityType
  self.componentDic = {}
end

function this:getGuid()
  return self.guid
end

function this:bindGameObject(go)
  self.gameObject = go
  self:callAllComponent(L_EcsConst.triggerName.onBindGameObject, go)
end

function this:getGameObject()
  return self.gameObject
end

function this:getTransform()
  return self:getGameObject().transform
end

function this:getRotation()
  return L_Vector3.getRot(self:getTransform())
end

function this:isValid()
  local go = self:getGameObject()
  return go and not go:IsNull()
end

function this:onUpdate(scale)
  if not self:isValid() then
    return
  end
  if self.gameObject.activeInHierarchy then
    self:callAllComponent(L_EcsConst.triggerName.onUpdate, scale)
  end
end

function this:onDestroy()
  self:callAllComponent(L_EcsConst.triggerName.onDestroy)
  self.componentDic = {}
  self.go = nil
end

function this:addComponent(componentType)
  local component = self.componentDic[componentType]
  if component == nil then
    component = require(componentType).new(self)
    if self.gameObject then
      component:onBindGameObject(self:getGameObject())
    end
    self.componentDic[componentType] = component
  end
  return component
end

function this:getComponent(componentType, isCreate)
  local component = self.componentDic[componentType]
  if component == nil and isCreate then
    component = self:addComponent(componentType)
  end
  return component
end

function this:callAllComponent(methodName, ...)
  for _, v in pairs(self.componentDic) do
    if v[methodName] then
      v[methodName](v, ...)
    end
  end
end

return this
