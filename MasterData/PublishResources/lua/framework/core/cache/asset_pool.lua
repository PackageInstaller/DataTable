require("base_pool")
_class("AssetPool", BasePool)
AssetPool = AssetPool

function AssetPool:Constructor(poolType, limit)
  self.nameToCache = {}
end

function AssetPool:Dispose()
  self:Clear()
end

function AssetPool:Clear()
  AssetPool.super.Clear(self)
  table.clear(self.nameToCache)
end

function AssetPool:GetCount(name)
  local resRequest = self.nameToCache[name]
  if resRequest then
    return 1
  end
  return 0
end

function AssetPool:Use(name)
  self.curUseCount = self.curUseCount + 1
  if self.curUseCount > self.maxUsedCount then
    self.maxUsedCount = self.curUseCount
  end
  local t = self.nameToMaxUsedCount[name]
  if not t then
    t = {curUseCount = 0, maxUsedCount = 0}
    self.nameToMaxUsedCount[name] = t
    t.curUseCount = t.curUseCount + 1
    if t.curUseCount > t.maxUsedCount then
      t.maxUsedCount = t.curUseCount
    end
  end
end

function AssetPool:UnUse(name)
  self.curUseCount = self.curUseCount - 1
  local t = self.nameToMaxUsedCount[name]
  if t then
    local cnt = t.curUseCount - 1
    t.curUseCount = cnt < 0 and 0 or cnt
  else
    Log.fatal("[Pool] UnUse, cannot find name=", name, " in self.nameToMaxUsedCount")
  end
end

function AssetPool:Move(name, moveCount)
  local cacheObj = self.nameToCache[name]
  if not cacheObj then
    Log.fatal("[Pool] AssetPool:Move Error, cannot find name,", name)
    return
  end
  if moveCount ~= 1 then
    Log.fatal("[Pool] AssetPool:Move Error, moveCount ,", moveCount)
    return
  end
  local index = table.ikey(self.queue, cacheObj)
  if index < #self.queue then
    table.remove(self.queue, index)
    table.insert(self.queue, cacheObj)
  end
end

function AssetPool:Pop(name)
  self.total = self.total + 1
  local cacheObj = self.nameToCache[name]
  if not cacheObj then
    return nil
  end
  self.hit = self.hit + 1
  self.nameToCache[name] = nil
  local index = table.ikey(self.queue, cacheObj)
  table.remove(self.queue, index)
  return cacheObj
end

function AssetPool:Push(name, resRequest)
  local cacheObj = self.nameToCache[name]
  if cacheObj then
    Log.warn("[Pool] AssetPool:Push, had same asset in cache,", name)
    resRequest:Dispose()
    resRequest = nil
    return
  end
  self.nameToCache[name] = resRequest
  table.insert(self.queue, resRequest)
  if self.limitn > -1 and #self.queue > self.limitn then
    local oldestCache = table.remove(self.queue, 1)
    self:RemoveFromCacheTable(oldestCache.m_Name)
  end
end

function AssetPool:RemoveFromCacheTable(name)
  local cacheObj = self.nameToCache[name]
  assert(cacheObj)
  self.nameToCache[name] = nil
  cacheObj:Dispose()
  cacheObj = nil
end
