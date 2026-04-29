require("collector")
_class("ReactiveSystem", Object)
ReactiveSystem = ReactiveSystem

function ReactiveSystem:Constructor(world)
  self._collector = self:GetTrigger(world)
  self._buffer = {}
  self.IsReactiveSystem = true
end

function ReactiveSystem:GetTrigger(world)
  Log.debug("call super ReactiveSystem:GetTrigger Error")
  return nil
end

function ReactiveSystem:Filter(entity)
  return true
end

function ReactiveSystem:ExecuteEntities(entities)
  error("call super ReactiveSystem:ExecuteEntities Error")
end

function ReactiveSystem:Activate()
  self._collector:Activate()
end

function ReactiveSystem:Deactivate()
  self._collector:Deactivate()
end

function ReactiveSystem:Clear()
  self._collector:ClearCollectedEntities()
end

function ReactiveSystem:Execute()
  local collectedEntities = self._collector.collectedEntities
  if collectedEntities == nil then
    return
  end
  if collectedEntities:Size() <= 0 then
    return
  end
  for i = 1, collectedEntities:Size() do
    local e = collectedEntities:GetAt(i)
    if self:Filter(e) then
      self._buffer[#self._buffer + 1] = e
      if e.Retain then
        e:Retain(self)
      end
    end
  end
  self._collector:ClearCollectedEntities()
  if 0 < #self._buffer then
    self:ExecuteEntities(self._buffer)
    for i = 1, #self._buffer do
      if self._buffer[i].Release then
        self._buffer[i]:Release(self)
      end
    end
    self._buffer = {}
  end
end
