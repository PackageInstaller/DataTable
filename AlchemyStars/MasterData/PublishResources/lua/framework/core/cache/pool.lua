require("base_pool")
_class("Pool", BasePool)
Pool = Pool

function Pool:Constructor(poolType, limit, _enableShowInHierarchy)
  self.nameToCacheArray = {}
  self.root = nil
  self.enableShowInHierarchy = _enableShowInHierarchy
  self:OnCreated()
end

function Pool:Dispose()
  self:Clear()
  self:OnDestroyed()
end

function Pool:Clear()
  Pool.super.Clear(self)
  table.clear(self.nameToCacheArray)
end

function Pool:GetCount(name)
  local cacheArray = self.nameToCacheArray[name]
  if cacheArray then
    return #cacheArray
  end
  return 0
end

function Pool:Root()
  return self.root
end

function Pool:Move(name, moveCount)
  local cacheArray = self.nameToCacheArray[name]
  if not cacheArray then
    Log.fatal("[Pool] Pool:Move Error, cannot find name,", name)
    return
  end
  if moveCount > #cacheArray then
    Log.fatal("[Pool] Pool:Move Error, moveCount,", moveCount, ", is bigger than,", #cacheArray)
    return
  end
  for i = 1, moveCount do
    local cacheObj = cacheArray[i]
    local index = table.ikey(self.queue, cacheObj)
    if index < #self.queue then
      table.remove(self.queue, index)
      table.insert(self.queue, cacheObj)
    end
  end
end

function Pool:Pop(name)
  self.total = self.total + 1
  local cacheArray = self.nameToCacheArray[name]
  if not cacheArray then
    return nil
  end
  self.hit = self.hit + 1
  local cacheObj = cacheArray[1]
  table.remove(cacheArray, 1)
  if #cacheArray < 1 then
    self.nameToCacheArray[name] = nil
  end
  local index = table.ikey(self.queue, cacheObj)
  table.remove(self.queue, index)
  return cacheObj
end

function Pool:Push(name, resRequest)
  local cacheArray = self.nameToCacheArray[name]
  if not cacheArray then
    cacheArray = {}
    self.nameToCacheArray[name] = cacheArray
  end
  table.insert(cacheArray, resRequest)
  table.insert(self.queue, resRequest)
  if self.limitn > -1 and #self.queue > self.limitn then
    local oldestCache = table.remove(self.queue, 1)
    self:RemoveFromCacheTable(oldestCache.m_Name)
  end
end

function Pool:RemoveFromCacheTable(name)
  local cacheArray = self.nameToCacheArray[name]
  assert(cacheArray)
  local cacheObj = table.remove(cacheArray, 1)
  if #cacheArray < 1 then
    self.nameToCacheArray[name] = nil
  end
  cacheObj:Dispose()
  cacheObj = nil
end

function Pool:OnCreated()
  if self.enableShowInHierarchy then
    self.root = UnityEngine.GameObject:New(self.poolType).transform
    self.root.parent = GameGlobal.PoolManager():Root()
  end
end

function Pool:OnDestroyed()
  if self.enableShowInHierarchy then
    UnityEngine.GameObject.Destroy(self.root.gameObject)
    self.root = nil
  end
end
