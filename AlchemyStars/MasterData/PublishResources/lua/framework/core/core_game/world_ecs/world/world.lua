require("world_creation_context")
require("entity")
require("matcher")
require("group")
_class("World", Object)
World = World

function World:Constructor(contextInfo)
  self._contextInfo = contextInfo
  self._totalComponents = contextInfo:WCC_EntityTotalComponents()
  self._entityCreationIndex = contextInfo.WCC_StartCreationIndex
  self._entityCreationProto = contextInfo.WCC_EntityCreationProto
  self._entityIdThreshold = contextInfo.WCC_EntityIdThreshold
  self._startEntityIdLogic = contextInfo.WCC_StartEntityIdLogic
  self._startEntityIdRender = contextInfo.WCC_StartEntityIdRender
  self._entities = SortedDictionary:New()
  self._groups = {}
  self._groupsForIndex = {}
  for i = 1, self._totalComponents do
    self._groupsForIndex[i] = false
  end
  self.Ev_OnEntityCreated = DelegateEvent:New()
  self.Ev_OnEntityWillBeDestroyed = DelegateEvent:New()
  self.Ev_OnEntityDestroyed = DelegateEvent:New()
  self.Ev_OnGroupCreated = DelegateEvent:New()
  self.Ev_OnGroupCleared = DelegateEvent:New()
end

function World:Dispose()
  self.Ev_OnEntityCreated = nil
  self.Ev_OnEntityWillBeDestroyed = nil
  self.Ev_OnEntityDestroyed = nil
  self.Ev_OnGroupCreated = nil
  self.Ev_OnGroupCleared = nil
end

function World:CreateEntity()
  local entity = self._entityCreationProto:New()
  local creationIndex = self._entityCreationIndex
  self._entityCreationIndex = creationIndex + 1
  entity:Initialize(creationIndex, self._contextInfo)
  entity:Retain(self)
  entity.Ev_OnComponentAdded:AddEvent(self, self.updateGroupsComponentAddedOrRemoved)
  entity.Ev_OnComponentRemoved:AddEvent(self, self.updateGroupsComponentAddedOrRemoved)
  entity.Ev_OnComponentReplaced:AddEvent(self, self.updateGroupsComponentReplaced)
  entity.Ev_OnEntityReleased:AddEvent(self, self.onEntityReleased)
  if self.Ev_OnEntityCreated then
    self.Ev_OnEntityCreated(self, entity)
  end
  entity:SetOwnerWorld(self)
  return entity
end

function World:DestroyEntity(entity)
  self._entities:Remove(entity:GetID())
  if self.Ev_OnEntityWillBeDestroyed ~= nil then
    self.Ev_OnEntityWillBeDestroyed(self, entity)
  end
  entity:Destroy()
  if self.Ev_OnEntityDestroyed ~= nil then
    self.Ev_OnEntityDestroyed(self, entity)
  end
  if entity._retainCount == 1 then
    entity.Ev_OnEntityReleased:RemoveEvent(self, self.onEntityReleased)
    entity:Release(self)
    entity:RemoveAllOnEntityReleasedHandlers()
  else
    entity:Release(self)
  end
end

function World:GetGroupEntities(matcher)
  local group = self:GetGroup(matcher)
  if group then
    return group:GetEntities()
  end
end

function World:GetGroup(matcher)
  if matcher == nil then
    Log.fatal("World:GetGroup matcher == nil")
    return nil
  end
  local group = self._groups[matcher]
  if not group then
    group = Group:New(matcher)
    for i = 1, self._entities:Size() do
      local e = self._entities:GetAt(i)
      group:HandleEntity(e)
    end
    self._groups[matcher] = group
    local indices = matcher.indices
    for index, _ in pairs(indices) do
      if not self._groupsForIndex[index] then
        local list = ArrayList:New()
        self._groupsForIndex[index] = list
      end
      self._groupsForIndex[index]:PushBack(group)
    end
    if self.Ev_OnGroupCreated then
      self.Ev_OnGroupCreated(self, group)
    end
  end
  return group
end

function World:updateGroupsComponentAddedOrRemoved(entity, index, component)
  local groups = self._groupsForIndex[index]
  if groups then
    local events = {}
    for i = 1, groups:Size() do
      local g = groups:GetAt(i)
      events[#events + 1] = g:HandleEntity(entity, true)
    end
    for i = 1, #events do
      local groupChangedEvent = events[i]
      if groupChangedEvent then
        groupChangedEvent(groups:GetAt(i), entity, index, component)
      end
    end
  end
end

function World:updateGroupsComponentReplaced(entity, index, previousComponent, newComponent)
  local groups = self._groupsForIndex[index]
  if groups then
    for i = 1, groups:Size() do
      local g = groups:GetAt(i)
      g:UpdateEntity(entity, index, previousComponent, newComponent)
    end
  end
end

function World:onEntityReleased(entity)
  entity.RemoveAllOnEntityReleasedHandlers()
end

function World:SetEntityIdByEntityConfigId(entity, entityConfigId)
  local id = 0
  if entityConfigId > EntityConfigIDConstLength then
    id = self._startEntityIdRender + self._entityIdThreshold
    self._startEntityIdRender = self._startEntityIdRender + 1
  else
    id = self._startEntityIdLogic
    self._startEntityIdLogic = self._startEntityIdLogic + 1
  end
  entity:SetID(id)
  self._entities:Insert(id, entity)
end
