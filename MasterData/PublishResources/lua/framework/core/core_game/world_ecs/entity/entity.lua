_class("Entity", Object)
Entity = Entity

function Entity:Constructor()
  self._isEnabled = false
  self._retainCount = 0
  self._id = 0
  self._components = SortedDictionary:New()
  self.Ev_OnComponentAdded = DelegateEvent:New()
  self.Ev_OnComponentRemoved = DelegateEvent:New()
  self.Ev_OnComponentReplaced = DelegateEvent:New()
  self.Ev_OnEntityReleased = DelegateEvent:New()
  if _G.EnalbeProfLog == true then
    self._checkCrossSide = false
  else
    self._checkCrossSide = true
  end
end

function Entity:isEnabled()
  return self._isEnabled
end

function Entity:Initialize(creationIndex, contextInfo)
  self:Reactivate(creationIndex)
  self.worldContextInfo = contextInfo
end

function Entity:Destroy()
  self:RemoveAllComponents()
  self._isEnabled = false
  self.Ev_OnComponentAdded:Clear()
  self.Ev_OnComponentReplaced:Clear()
  self.Ev_OnComponentRemoved:Clear()
  self.Ev_OnEntityReleased:Clear()
end

function Entity:RemoveAllOnEntityReleasedHandlers()
  self.Ev_OnEntityReleased:Clear()
end

function Entity:Reactivate(creationIndex)
  self._isEnabled = true
  self._creationIndex = creationIndex
end

function Entity:AddComponent(index, component)
  if not self._isEnabled then
    Log.debug("Entity:AddComponent Error! entity._isEnabled = false")
    return
  end
  if self:HasComponent(index) then
    return
  end
  component._entity = self
  self._components:Insert(index, component)
  self.Ev_OnComponentAdded(self, index, component)
end

function Entity:RemoveComponent(index)
  if not self._isEnabled then
    Log.debug("Entity:RemoveComponent Error! entity._isEnabled = false")
    return
  end
  if not self:HasComponent(index) then
    return
  end
  local previousComponent = self._components:Find(index)
  self._components:Remove(index)
  self.Ev_OnComponentRemoved(self, index, previousComponent)
  if previousComponent.Dispose then
    previousComponent:Dispose()
  end
end

function Entity:ReplaceComponent(index, component)
  if not self._isEnabled then
    Log.debug("Entity:ReplaceComponent Error! entity._isEnabled = false")
    return
  end
  if not self:HasComponent(index) then
    self:AddComponent(index, component)
    return
  end
  local previousComponent = self._components:Find(index)
  if previousComponent ~= component then
    component._entity = self
    self._components:Modify(index, component)
    if component ~= nil then
      self.Ev_OnComponentReplaced(self, index, previousComponent, component)
    else
      self.Ev_OnComponentRemoved(self, index, previousComponent)
      if previousComponent.Dispose then
        previousComponent:Dispose()
      end
    end
  else
    self.Ev_OnComponentReplaced(self, index, previousComponent, component)
  end
end

function Entity:GetComponent(index)
  if EDITOR and self._checkCrossSide then
    local available = self:_CheckAvailableInRenderSide(index)
    if not available then
      local cmptName = self:_GetComponentNameByIndex(index)
      local fullCmptName = cmptName .. "Component"
      Log.exception(fullCmptName, " not available in render side.", " ", debug.traceback())
    end
  end
  return self._components:Find(index)
end

function Entity:GetComponents()
  return self._components.dictionary
end

function Entity:GetComponentIndices()
  return self._components.sorted_key
end

function Entity:HasComponent(index)
  if EDITOR and self._checkCrossSide then
    local available = self:_CheckAvailableInRenderSide(index)
    if not available then
      local cmptName = self:_GetComponentNameByIndex(index)
      local fullCmptName = cmptName .. "Component"
      Log.exception(fullCmptName, " not available in render side.", " ", debug.traceback())
    end
  end
  return self._components:Find(index) ~= nil
end

function Entity:HasComponents(indices)
  for _, v in pairs(indices) do
    if self._components:Find(v) == nil then
      return false
    end
  end
  return true
end

function Entity:HasAnyComponent(indices)
  for _, v in pairs(indices) do
    if self._components:Find(v) ~= nil then
      return true
    end
  end
  return false
end

function Entity:RemoveAllComponents()
  while self._components:Size() > 0 do
    local index = self._components:GetKeyAt(1)
    self:RemoveComponent(index)
  end
  self._components:Clear()
end

function Entity:GetCreationIndex()
  return self._creationIndex
end

function Entity:Retain(owner)
  self._retainCount = self._retainCount + 1
end

function Entity:Release(owner)
  self._retainCount = self._retainCount - 1
  if self._retainCount == 0 then
    self.Ev_OnEntityReleased(self)
  end
end

function Entity:GetID()
  return self._id
end

function Entity:SetID(id)
  self._id = id
end

function Entity:SetOwnerWorld(world)
  self._world = world
  if self._world:GetRunningPosition() == WorldRunPostion.Performance then
    self._checkCrossSide = false
  end
end

function Entity:GetOwnerWorld()
  return self._world
end

function Entity:_CheckAvailableInRenderSide(index)
  local debugInfo = debug.getinfo(3, "S")
  if debugInfo == nil then
    return true
  end
  local filePath = debugInfo.short_src
  local isRenderFile = string.find(filePath, "_r.lua")
  local world = self:GetOwnerWorld()
  local available = world.BW_WorldInfo:AvailableInRender(index)
  if isRenderFile then
    return available
  end
  return true
end

function Entity:_GetComponentNameByIndex(index)
  local world = self:GetOwnerWorld()
  local cmptName = world.BW_WorldInfo.BWCC_EComponentsEnum.EL_RawStrArray[index]
  return cmptName
end
