local ObjectPool = NewClass("ObjectPool")

function ObjectPool:ctor(capacity, createFunc, disposeFunc, resetFunc)
  self.capacity = capacity or 0
  self.objects = {}
  self.createFunc = createFunc
  self.disposeFunc = disposeFunc
  self.resetFunc = resetFunc
  self.createdCount = 0
  self.disposedCount = 0
end

function ObjectPool:SetCapacity(capacity)
  self.capacity = capacity
end

function ObjectPool:GetObjectCount()
  return #self.objects
end

function ObjectPool:GetCreatedCount()
  return self.createdCount
end

function ObjectPool:GetDisposedCount()
  return self.disposedCount
end

function ObjectPool:FetchObject()
  local count = #self.objects
  local obj
  if count < 1 then
    obj = self:_CreateNewObject()
  else
    obj = table.remove(self.objects)
  end
  return obj
end

function ObjectPool:ReturnObject(obj)
  local count = #self.objects
  self:_ResetObject(obj)
  if count >= self.capacity then
    self:_DisposeObject(obj)
  else
    table.insert(self.objects, obj)
  end
end

function ObjectPool:_CreateNewObject()
  local obj
  if self.createFunc ~= nil then
    obj = self.createFunc()
    self.createdCount = self.createdCount + 1
  end
  return obj
end

function ObjectPool:_DisposeObject(obj)
  if self.disposeFunc ~= nil then
    self.disposeFunc(obj)
  end
  self.disposedCount = self.disposedCount + 1
end

function ObjectPool:_ResetObject(obj)
  if self.resetFunc ~= nil then
    self.resetFunc(obj)
  end
end

function ObjectPool:Clear()
  local count = #self.objects
  if count > 0 then
    local obj
    for i = 1, count do
      obj = self.objects[i]
      self:_DisposeObject(obj)
      self.objects[i] = nil
    end
  end
end

return ObjectPool
