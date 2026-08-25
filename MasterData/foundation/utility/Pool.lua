local Pool = {}
local DefaultPoolSize = 4

local function createPoolObj(creator, ...)
  return creator and creator(...) or {}
end

Pool.tagPools = {}
Pool.classPools = {}

function Pool.GetWithTag(class, tag, ...)
  local tagPools = Pool.tagPools[class]
  if nil == tagPools then
    tagPools = {}
    Pool.tagPools[class] = tagPools
  end
  local tagPool = tagPools[tag]
  if nil == tagPool then
    tagPool = Pool.CreatePool(1, class, tag, ...)
    tagPools[tag] = tagPool
  end
  do return tagPool.Get, tagPool, tag, ... end
  return tagPool.Get, tagPool, tag, ...
end

function Pool.Get(class, ...)
  local classPool = Pool.classPools[class]
  if nil == classPool then
    classPool = Pool.CreatePool(DefaultPoolSize, class, ...)
    Pool.classPools[class] = classPool
  end
  do return classPool.Get, classPool, ... end
  return classPool.Get, classPool, ...
end

function Pool.FreeWithTag(class, tag, obj)
  local tagPools = Pool.tagPools[class]
  if nil == tagPools then
    return
  end
  local tagPool = tagPools[tag]
  if tagPool then
    tagPool:Free(obj)
  end
end

function Pool.Free(class, obj)
  local classPool = Pool.classPools[class]
  if classPool then
    classPool:Free(obj)
  end
end

function Pool.CreateWithTag(class, tag, size, ...)
  do return Pool.CreateWithTagAndCreator, class, tag, size, class, ... end
  return Pool.CreateWithTagAndCreator, class, tag, size, class, ...
end

function Pool.Create(class, size, ...)
  do return Pool.CreateWithCreator, class, size, class, ... end
  return Pool.CreateWithCreator, class, size, class, ...
end

function Pool.CreateWithTagAndCreator(class, tag, size, creator, ...)
  local tagPools = Pool.tagPools[class]
  if nil == tagPools then
    tagPools = {}
    Pool.tagPools[class] = tagPools
  end
  local tagPool = tagPools[tag]
  if nil == tagPool then
    tagPool = Pool.CreatePool(size, creator, tag, ...)
    tagPools[tag] = tagPool
  end
  return tagPool
end

function Pool.CreateWithCreator(class, size, creator, ...)
  local classPool = Pool.classPools[class]
  if nil == classPool then
    classPool = Pool.CreatePool(size, creator, ...)
    Pool.classPools[class] = classPool
  end
  return classPool
end

function Pool.CreatePool(poolSize, creator, ...)
  poolSize = poolSize or DefaultPoolSize
  local freeObjects = {}
  local usingObjects = {}
  local pool = {
    freeObjects = freeObjects,
    creator = creator,
    usingObjects = usingObjects
  }
  for _ = 1, poolSize do
    local obj = createPoolObj(creator, ...)
    obj.pool = pool
    table.insert(freeObjects, obj)
  end
  
  function pool:Get(...)
    local obj = table.remove(self.freeObjects)
    if nil == obj then
      obj = createPoolObj(self.creator, ...)
    end
    obj.pool = self
    self.usingObjects[obj] = obj
    return obj
  end
  
  function pool:Free(obj)
    assert(obj, "obj to be freeed can't be null")
    assert(obj.pool == self, "obj cannot be free to another pool")
    if table.contains(self.freeObjects, obj) then
      return
    end
    table.insert(self.freeObjects, obj)
    self.usingObjects[obj] = nil
    if obj.OnRecycle then
      obj.OnRecycle(obj)
    end
  end
  
  function pool:Clear()
    for _, v in ipairs(self.freeObjects) do
      if v.Dispose then
        v:Dispose()
      end
    end
    for k, v in pairs(self.usingObjects) do
      if v.Dispose then
        v:Dispose()
      end
    end
    self.freeObjects = {}
    self.usingObjects = {}
  end
  
  return pool
end

function Pool.ClearWithTag(class, tag)
  local tagPools = Pool.tagPools[class]
  local tagPool = tagPools and tagPools[tag]
  if tagPool then
    tagPool:Clear()
    tagPools[tag] = nil
  end
end

function Pool.Clear()
  for _, p in pairs(Pool.classPools) do
    p:Clear()
  end
  for _, tagPools in pairs(Pool.tagPools) do
    for _, pool in pairs(tagPools) do
      pool:Clear()
    end
  end
  Pool.classPools = {}
  Pool.tagPools = {}
end

return Pool
