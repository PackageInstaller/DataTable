require("world")
_class("BaseWorld", World)
BaseWorld = BaseWorld

function BaseWorld:Constructor(worldInfo)
  self.BW_WorldInfo = worldInfo
  self.BW_WEComponentsEnum = worldInfo.BWCC_EComponentsEnum
  self.BW_WEMatchers = worldInfo.BWCC_EMatchers
  self.BW_UniqueComponentsEnum = worldInfo.BWCC_WUniqueComponentsEnum
  self.BW_Systems = nil
  self.BW_Services = nil
  self.BW_UniqueComponents = SortedDictionary:New()
  self.BW_Ev_OnUniqueComponentReplaced = DelegateEvent:New()
  if _G.EnalbeProfLog == true then
    self._checkCrossSide = false
  else
    self._checkCrossSide = true
  end
end

function BaseWorld:Dispose()
  BaseWorld.super.Dispose(self)
  self:DestroyAllEntity()
  self:DestroyAllGroup()
  self:DestroyServices()
  local uniqueCmptCount = self.BW_UniqueComponents:Size()
  for cmptIndex = 1, uniqueCmptCount do
    local uniqueCmpt = self.BW_UniqueComponents:GetAt(cmptIndex)
    if uniqueCmpt.Dispose ~= nil then
      uniqueCmpt:Dispose()
    end
  end
  self.BW_UniqueComponents:Clear()
  self.BW_Ev_OnUniqueComponentReplaced:Clear()
end

function BaseWorld:DestroyAllEntity()
  local i = 1
  while true do
    local entity = self._entities:GetAt(1)
    if entity ~= nil then
      self:DestroyEntity(entity)
      i = i + 1
    else
      break
    end
  end
  self._entities:Clear()
end

function BaseWorld:DestroyAllGroup()
  for _, group in ipairs(self._groups) do
    if group then
      group:Dispose()
    end
  end
end

function BaseWorld:DestroyServices()
  if self.BW_Services.Dispose then
    self.BW_Services:Dispose()
  end
  self.BW_Services = nil
end

function BaseWorld:DestroySystems()
  self.BW_Systems = nil
end

function BaseWorld:CreateEntity()
  local e = BaseWorld.super.CreateEntity(self)
  e.WEComponentsEnum = self.BW_WEComponentsEnum
  e.Ev_OnComponentAdded:AddEvent(self, self.Internal_onComponentAdded)
  e.Ev_OnComponentRemoved:AddEvent(self, self.Internal_onComponentRemoved)
  e.Ev_OnComponentReplaced:AddEvent(self, self.Internal_onComponentReplaced)
  return e
end

function BaseWorld:DestroyEntity(entity)
  return BaseWorld.super.DestroyEntity(self, entity)
end

function BaseWorld:Internal_onComponentAdded(entity, index, component)
  component.WEC_OwnerEntity = entity
  if component.WEC_PostInitialize then
    component:WEC_PostInitialize(entity)
  end
end

function BaseWorld:Internal_onComponentRemoved(entity, index, component)
  if component.WEC_PostRemoved then
    component:WEC_PostRemoved()
  end
end

function BaseWorld:Internal_onComponentReplaced(entity, index, previousComponent, newComponent)
  if previousComponent ~= newComponent then
    if previousComponent.WEC_PostRemoved then
      previousComponent:WEC_PostRemoved()
    end
    if newComponent ~= nil then
      newComponent.WEC_OwnerEntity = entity
      if newComponent.WEC_PostInitialize then
        newComponent:WEC_PostInitialize(entity)
      end
    end
  end
end

function BaseWorld:EnterWorld()
  self:Internal_CreateServices()
  self:Internal_CreateComponents()
  self:Internal_CreateSystems()
  local systems = self.BW_Systems
  systems:ActivateReactiveSystems()
  systems:Initialize()
end

function BaseWorld:UpdateWorld(deltaTimeMS)
  local systems = self.BW_Systems
  if not systems then
    return
  end
  systems:Execute()
  systems:Cleanup()
end

function BaseWorld:ExitWorld()
  local systems = self.BW_Systems
  if systems ~= nil then
    systems:TearDown()
    systems:DeactivateReactiveSystems()
  end
  self:DestroySystems()
end

function BaseWorld:GetUniqueComponent(index)
  if EDITOR and self._checkCrossSide then
    local available = self:_CheckUniqueCmptAvailableInRenderSide(index)
    if not available then
      local cmptName = self:_GetUniqueComponentNameByIndex(index)
      local fullCmptName = cmptName .. "Component"
      Log.exception(fullCmptName, " not available in render side.", " ", Log.traceback())
    end
  end
  return self.BW_UniqueComponents:Find(index)
end

function BaseWorld:_GetUniqueComponentNameByIndex(index)
  local cmptName = self.BW_WorldInfo.BWCC_WUniqueComponentsEnum.EL_RawStrArray[index]
  return cmptName
end

function BaseWorld:_CheckUniqueCmptAvailableInRenderSide(index)
  local debugInfo = debug.getinfo(3, "S")
  if debugInfo == nil then
    return true
  end
  local filePath = debugInfo.short_src
  local isRenderFile = string.find(filePath, "_r.lua")
  local available = self.BW_WorldInfo:UniqueCmptAvailableInRender(index)
  if isRenderFile then
    return available
  end
  return true
end

function BaseWorld:HasUniqueComponent(index)
  return self.BW_UniqueComponents:Find(index) ~= nil
end

function BaseWorld:HasUniqueComponents(indices)
  for _, v in pairs(indices) do
    if self.BW_UniqueComponents:Find(v) == nil then
      return false
    end
  end
  return true
end

function BaseWorld:HasAnyUniqueComponent(indices)
  for _, v in pairs(indices) do
    if self.BW_UniqueComponents:Find(v) ~= nil then
      return true
    end
  end
  return false
end

function BaseWorld:SetUniqueComponent(index, cmpt)
  if not self:HasUniqueComponent(index) then
    self.BW_UniqueComponents:Insert(index, cmpt)
    self.BW_Ev_OnUniqueComponentReplaced(self, index, nil, cmpt)
    return
  end
  local previousCmpt = self.BW_UniqueComponents:Find(index)
  if previousCmpt ~= cmpt then
    if cmpt == nil then
      self.BW_UniqueComponents:Remove(index)
    else
      self.BW_UniqueComponents:Modify(index, cmpt)
    end
    self.BW_Ev_OnUniqueComponentReplaced(self, index, previousCmpt, cmpt)
    if previousCmpt.Dispose then
      previousCmpt:Dispose()
    end
  else
    self.BW_Ev_OnUniqueComponentReplaced(self, index, previousCmpt, cmpt)
  end
end

function BaseWorld:GetEntityByID(entityID)
end

function BaseWorld:WorldHandleCommands(command_list)
end

function BaseWorld:Internal_CreateSystems()
end

function BaseWorld:Internal_CreateComponents()
end

function BaseWorld:Internal_CreateServices()
end
