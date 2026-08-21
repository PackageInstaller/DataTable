_class("Group", Object)
Group = Group

function Group:Constructor(matcher)
  self.Ev_OnEntityAdded = DelegateEvent:New()
  self.Ev_OnEntityRemoved = DelegateEvent:New()
  self.Ev_OnEntityUpdated = DelegateEvent:New()
  self._matcher = matcher
  self._entities = SortedArray:New(Algorithm.COMPARE_CUSTOM, Group._ComparerByID)
end

function Group:Dispose()
  self.Ev_OnEntityAdded = nil
  self.Ev_OnEntityRemoved = nil
  self.Ev_OnEntityUpdated = nil
  self._matcher = nil
  self._entities = nil
end

function Group:UpdateEntity(entity, index, previousComponent, newComponent)
  local findRes = self._entities:Find(entity)
  if findRes ~= -1 then
    self.Ev_OnEntityRemoved(self, entity, index, previousComponent)
    self.Ev_OnEntityAdded(self, entity, index, newComponent)
    self.Ev_OnEntityUpdated(self, entity, index, previousComponent, newComponent)
  end
end

function Group:RemoveAllEventHandlers()
  self.Ev_OnEntityAdded:Clear()
  self.Ev_OnEntityRemoved:Clear()
  self.Ev_OnEntityUpdated:Clear()
end

function Group:HandleEntity(entity, isGetEvent)
  local findRes = self._entities:Find(entity)
  local ev
  if self._matcher:Matches(entity) then
    if findRes == -1 then
      self._entities:Insert(entity)
      entity:Retain(self)
      ev = self.Ev_OnEntityAdded
    end
  elseif findRes ~= -1 then
    self._entities:Remove(entity)
    entity:Release(self)
    ev = self.Ev_OnEntityRemoved
  end
  if isGetEvent then
    return ev
  end
end

function Group:GetEntities()
  local t = {}
  table.appendArray(t, self._entities.elements)
  return t
end

function Group:GetSingleEntity()
  local array = self:GetEntities()
  local cnt = #array
  if cnt == 1 then
    return array[1]
  elseif 1 < cnt then
    Log.fatal("Group:GetSingleEntity cnt > 1")
    return array[1]
  else
    return nil
  end
end

function Group:HandleForeach(handler, handlerFunc, ...)
  local entities = self:GetEntities()
  for i, entity in ipairs(entities) do
    handlerFunc(handler, entity, ...)
  end
end

function Group._ComparerByID(leftEntity, rightEntity)
  local leftEntityID = leftEntity:GetID()
  local rightEntityID = rightEntity:GetID()
  if leftEntityID > rightEntityID then
    return -1
  elseif leftEntityID < rightEntityID then
    return 1
  else
    return 0
  end
end
