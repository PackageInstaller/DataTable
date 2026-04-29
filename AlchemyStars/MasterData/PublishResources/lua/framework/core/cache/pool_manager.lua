_class("PoolManager", Object)
PoolManager = PoolManager
local TABLE_INSERT = table.insert
local TABLE_CONCAT = table.concat
local CACHE_DIR_NAME = "CachePoolStatistics"
local CACHE_FILE_NAME = "CachePool"

function PoolManager:Constructor()
  self.Pools = {}
  self.root = CacheHelper.GetRoot()
end

function PoolManager:Dispose()
  self:DestroyAllPools()
  UIHelper.DestroyGameObject(self.root)
end

function PoolManager:Init()
  PoolRegister:RegisterPools(self)
end

function PoolManager:CreatePool(poolType, loadType, limitn, enableShowInHierarchy, name, preloadAmount)
  self:CreatePoolInternal(poolType, loadType, limitn, enableShowInHierarchy)
  if name and loadType then
    preloadAmount = preloadAmount or 1
    self:PreLoad(poolType, name, loadType, preloadAmount)
  end
end

function PoolManager:AsyncCreatePool(TT, poolType, loadType, limitn, enableShowInHierarchy, name, preloadAmount)
  self:CreatePoolInternal(poolType, loadType, limitn, enableShowInHierarchy)
  if name and loadType then
    preloadAmount = preloadAmount or 1
    self:AsyncPreLoad(TT, poolType, name, loadType, preloadAmount)
  end
end

function PoolManager:ConcCreatePool(poolType, loadType, limitn, enableShowInHierarchy, name, preloadAmount)
  self:CreatePoolInternal(poolType, loadType, limitn, enableShowInHierarchy)
  if name and loadType then
    preloadAmount = preloadAmount or 1
    self:ConcPreLoad(poolType, name, loadType, preloadAmount)
  end
end

function PoolManager:Spawn(poolType, name, loadType, onSpawned)
  local pool = self.Pools[poolType]
  if not pool then
    Log.fatal("[Pool] PoolManager:Spawn Error, not find pool,", poolType, ", need CreatePool first")
    return
  end
  local r = pool:Spawn(name, loadType, onSpawned)
  if loadType == LoadType.GameObject and r and r.Obj then
    UIHelper.SetActive(r.Obj, true)
  end
  return r
end

function PoolManager:AsyncSpawn(TT, poolType, name, loadType, onSpawned)
  local pool = self.Pools[poolType]
  if not pool then
    Log.fatal("[Pool] PoolManager:AsyncSpawn Error, not find pool,", poolType, ", need CreatePool first")
    return
  end
  local r = pool:AsyncSpawn(TT, name, loadType, onSpawned)
  if loadType == LoadType.GameObject and r and r.Obj then
    UIHelper.SetActive(r.Obj, true)
  end
  return r
end

function PoolManager:DeSpawn(poolType, resRequest, onDeSpawned)
  local pool = self.Pools[poolType]
  if not pool then
    Log.fatal("[Pool] PoolManager:DeSpawn Error, not find pool,", poolType, ", you should create pool when spawn")
    return
  end
  if resRequest.m_LoadType == LoadType.GameObject then
    if not resRequest or not resRequest.Obj then
      Log.fatal("[Pool] PoolManager:DeSpawn Error, gameobject is nil")
      return
    end
    resRequest.Obj.transform.parent = pool:Root()
    UIHelper.SetActive(resRequest.Obj, false)
  end
  pool:DeSpawn(resRequest, onDeSpawned)
end

function PoolManager:SetLimit(poolType, limitn)
  local pool = self.Pools[poolType]
  if pool then
    pool:SetLimit(limitn)
  else
    Log.fatal("[Pool] PoolManager:SetLimit Error, not find pool,", poolType, ", need CreatePool first")
  end
end

function PoolManager:PreLoad(poolType, name, loadType, preloadAmount)
  local pool = self.Pools[poolType]
  if not pool then
    Log.fatal("[Pool] PoolManager:PreLoad Error, not find pool,", poolType, ", need CreatePool first")
    return
  end
  pool:PreLoad(name, loadType, preloadAmount)
end

function PoolManager:AsyncPreLoad(TT, poolType, name, loadType, preloadAmount)
  local pool = self.Pools[poolType]
  if not pool then
    Log.fatal("[Pool] PoolManager:AsyncPreLoad Error, not find pool,", poolType, ", need CreatePool first")
    return
  end
  pool:AsyncPreLoad(TT, name, loadType, preloadAmount)
end

function PoolManager:ConcPreLoad(poolType, name, loadType, preloadAmount)
  local pool = self.Pools[poolType]
  if not pool then
    Log.fatal("[Pool] PoolManager:AsyncPreLoad Error, not find pool,", poolType, ", need CreatePool first")
    return
  end
  pool:ConcPreLoad(name, loadType, preloadAmount)
end

function PoolManager:Compare(names)
  if type(names) ~= "table" then
    Log.fatal("[Pool] PoolManager:Compare Error, names not valid")
    return {}, names
  end
  local t, missNames = {}, {}
  for i = 1, #names do
    local name = names[i]
    local miss = true
    for k, pool in self.Pools, nil, nil do
      local hitCount = pool:GetCount(name)
      if 0 < hitCount then
        t[#t + 1] = {_hitCount = hitCount, _name = name}
        miss = false
        break
      end
    end
    if miss then
      missNames[#missNames + 1] = name
    end
  end
  table.sort(t, function(e1, e2)
    return e1._hitCount > e2._hitCount
  end)
  local res = {}
  for i = 1, #t do
    res[#res + 1] = t[i]._name
  end
  return res, missNames
end

function PoolManager:CompareInPool(poolType, names)
  if type(names) ~= "table" then
    Log.fatal("[Pool] PoolManager:CompareInPool Error, names not valid")
    return {}, names
  end
  local pool = self.Pools[poolType]
  if not pool then
    Log.debug("[Pool] PoolManager:CompareInPool, no pool,", poolType, ", now")
    return {}, names
  end
  local t, missNames = {}, {}
  for i = 1, #names do
    local name = names[i]
    local hitCount = pool:GetCount(name)
    if 0 < hitCount then
      t[#t + 1] = {_hitCount = hitCount, _name = name}
    else
      missNames[#missNames + 1] = name
    end
  end
  table.sort(t, function(e1, e2)
    return e1._hitCount > e2._hitCount
  end)
  local res = {}
  for i = 1, #t do
    res[#res + 1] = t[i]._name
  end
  return res, missNames
end

function PoolManager:LogMessages()
  for k, v in pairs(self.Pools) do
    v:LogMessages()
  end
end

function PoolManager:Messages()
  local res = {}
  for k, v in pairs(self.Pools) do
    TABLE_INSERT(res, v:Message())
  end
  return TABLE_CONCAT(res, "\n")
end

function PoolManager:WriteMessagesToFile()
  local dir = string.format("%s%s/", App.StoragePath, CACHE_DIR_NAME)
  local file = dir .. string.format("%s%s.txt", CACHE_FILE_NAME, TimeToDate2(_now()))
  Monitor:GetInstance():WriteToFile(dir, file, self:Messages())
end

function PoolManager:DestroyPool(poolType)
  local pool = self.Pools[poolType]
  if pool then
    pool:Dispose()
    self.Pools[poolType] = nil
  else
    Log.fatal("[Pool]PoolManager:DestroyPool Error,", poolType, ", is nil")
  end
end

function PoolManager:ClearPool(poolType)
  local pool = self.Pools[poolType]
  if pool then
    pool:Clear()
  else
    Log.fatal("[Pool]PoolManager:ClearPool Error,", poolType, ", is nil")
  end
end

function PoolManager:Root()
  return self.root
end

function PoolManager:PreLoadInternal(poolType, name, loadType, preloadAmount)
  local pool = self.Pools[poolType]
  if not pool then
    Log.fatal("[Pool] PoolManager:PreLoad Error, not find pool,", poolType, ", need CreatePool first")
    return
  end
  local hadCount = pool:GetCount(name)
  local leftPreloadAmount = preloadAmount - hadCount
  if leftPreloadAmount <= 0 then
    Log.debug("[Pool] PoolManager:PreLoad return, preloadAmount=", preloadAmount, ",pool:", poolType, ",", name, ", is enough,", hadCount)
    return
  end
  Log.debug("[Pool] PoolManager:PreLoad,", leftPreloadAmount, ",", poolType, ",", name)
  return pool, leftPreloadAmount
end

function PoolManager:CreatePoolInternal(poolType, loadType, limitn, enableShowInHierarchy)
  local pool = self.Pools[poolType]
  if pool then
    Log.info("[Pool] PoolManager:CreatePool return,", poolType, ", had created")
    return
  end
  enableShowInHierarchy = enableShowInHierarchy ~= false
  if loadType == LoadType.GameObject then
    pool = Pool:New(poolType, limitn, enableShowInHierarchy)
  else
    pool = AssetPool:New(poolType, limitn)
  end
  self.Pools[poolType] = pool
end

function PoolManager:DestroyAllPools()
  for k, v in pairs(self.Pools) do
    v:Dispose()
  end
  table.clear(self.Pools)
end
