_class("BasePool", Object)
BasePool = BasePool
local STRING_FORMAT = string.format
local TABLE_INSERT = table.insert
local TABLE_CONCAT = table.concat

function BasePool:Constructor(poolType, limit)
  self.poolType = poolType
  self.limitn = limit
  self.queue = {}
  self.maxUsedCount = 0
  self.curUseCount = 0
  self.hit = 0
  self.total = 0
  self.nameToMaxUsedCount = {}
end

function BasePool:Dispose()
end

function BasePool:Clear()
  for i = 1, #self.queue do
    local cacheObj = self.queue[i]
    if cacheObj then
      cacheObj:Dispose()
      cacheObj = nil
    end
  end
  table.clear(self.queue)
  self.maxUsedCount = 0
  self.curUseCount = 0
  self.hit = 0
  self.total = 0
  table.clear(self.nameToMaxUsedCount)
end

function BasePool:Spawn(name, loadType, onSpawned)
  local r = self:Pop(name)
  r = r or ResourceManager:GetInstance():SyncLoadAsset(name, loadType)
  if r then
    self:Use(name)
    if onSpawned then
      onSpawned(r)
    end
  end
  return r
end

function BasePool:AsyncSpawn(TT, name, loadType, onSpawned)
  local r = self:Pop(name)
  r = r or ResourceManager:GetInstance():AsyncLoadAsset(TT, name, loadType)
  if r then
    self:Use(name)
    if onSpawned then
      onSpawned(r)
    end
  end
  return r
end

function BasePool:DeSpawn(resRequest, onDeSpawned)
  if not resRequest then
    Log.fatal("[Pool] DeSpawn Error,resRequest is nil")
    return
  end
  local name = resRequest.m_Name
  if onDeSpawned then
    onDeSpawned(resRequest)
  end
  self:UnUse(name)
  if NoCache then
    resRequest:Dispose()
    resRequest = nil
  else
    self:Push(name, resRequest)
  end
end

function BasePool:SetLimit(limitn)
  Log.debug("[Pool] poolType=", self.poolType, ",SetLimit, old=", self.limitn, ", new=", limitn)
  self.limitn = limitn
end

function BasePool:PreLoad(name, loadType, preloadAmount)
  if NoCache then
    return
  end
  local hadCount = self:GetCount(name)
  local loadCount = preloadAmount - hadCount
  local moveCount = preloadAmount >= hadCount and hadCount or preloadAmount
  if 0 < moveCount then
    Log.debug("[Pool] PreLoad,", name, ", moveCount=", moveCount)
    self:Move(name, moveCount)
  end
  Log.debug("[Pool] PreLoad,", name, ", loadCount=", loadCount)
  for i = 1, loadCount do
    local resRequest = ResourceManager:GetInstance():SyncLoadAsset(name, loadType)
    self:Push(name, resRequest)
    if loadType == LoadType.GameObject and resRequest and resRequest.Obj then
      resRequest.Obj.transform.parent = self:Root()
    end
  end
end

function BasePool:AsyncPreLoad(TT, name, loadType, preloadAmount)
  if NoCache then
    return
  end
  local hadCount = self:GetCount(name)
  local loadCount = preloadAmount - hadCount
  local moveCount = preloadAmount >= hadCount and hadCount or preloadAmount
  if 0 < moveCount then
    Log.debug("[Pool] PreLoad,", name, ", moveCount=", moveCount)
    self:Move(name, moveCount)
  end
  Log.debug("[Pool] PreLoad,", name, ", loadCount=", loadCount)
  for i = 1, loadCount do
    local resRequest = ResourceManager:GetInstance():AsyncLoadAsset(TT, name, loadType)
    self:Push(name, resRequest)
    if loadType == LoadType.GameObject and resRequest and resRequest.Obj then
      resRequest.Obj.transform.parent = self:Root()
    end
  end
end

function BasePool:ConcPreLoad(name, loadType, preloadAmount)
  if NoCache then
    return
  end
  local hadCount = self:GetCount(name)
  local loadCount = preloadAmount - hadCount
  local moveCount = preloadAmount >= hadCount and hadCount or preloadAmount
  if 0 < moveCount then
    Log.debug("[Pool] PreLoad,", name, ", moveCount=", moveCount)
    self:Move(name, moveCount)
  end
  Log.debug("[Pool] PreLoad,", name, ", loadCount=", loadCount)
  for i = 1, loadCount do
    TaskManager:GetInstance():StartTask(self.AsyncLoad, self, name, loadType)
  end
end

function BasePool:AsyncLoad(TT, name, loadType)
  local resRequest = ResourceManager:GetInstance():AsyncLoadAsset(TT, name, loadType)
  self:Push(name, resRequest)
  if loadType == LoadType.GameObject and resRequest and resRequest.Obj then
    resRequest.Obj.transform.parent = self:Root()
  end
end

function BasePool:Count()
  return #self.queue
end

function BasePool:GetCount(name)
  return 0
end

function BasePool:LogMessages()
  Log.sys(self:Message())
end

function BasePool:Message()
  local messageTable = {}
  local t1, t2 = {}, {}
  local cnt = 0
  for k, v in pairs(self.nameToMaxUsedCount) do
    cnt = cnt + v.maxUsedCount
    TABLE_INSERT(t1, STRING_FORMAT("Res name[%s], maxUsedCount[%d]", k, v.maxUsedCount))
    TABLE_INSERT(t2, STRING_FORMAT("Res name[%s], PreLoadAmount[%d]", k, v.maxUsedCount))
  end
  TABLE_INSERT(messageTable, STRING_FORMAT("--------------------Pool[%s]--------------------", self.poolType))
  TABLE_INSERT(messageTable, STRING_FORMAT("maxUsedCount[%d],limitn[%d],curCount[%d],hit[%d], total[%d], hitRate[%f%%]", self.maxUsedCount, self.limitn, self:Count(), self.hit, self.total, self.total == 0 and 0 or self.hit * 100 / self.total))
  TABLE_INSERT(messageTable, TABLE_CONCAT(t1, "\n"))
  TABLE_INSERT(messageTable, [[

Pool limit suggest: ]])
  TABLE_INSERT(messageTable, STRING_FORMAT("limit[%d]", cnt))
  if 0 < #t2 then
    TABLE_INSERT(messageTable, "Pool PreLoad suggest: ")
    TABLE_INSERT(messageTable, STRING_FORMAT("%s", TABLE_CONCAT(t2, "\n")))
  end
  TABLE_INSERT(messageTable, "\n")
  return TABLE_CONCAT(messageTable, "\n")
end

function BasePool:Root()
  return
end

function BasePool:Use(name)
  self.curUseCount = self.curUseCount + 1
  if self.curUseCount > self.maxUsedCount then
    self.maxUsedCount = self.curUseCount
  end
  local t = self.nameToMaxUsedCount[name]
  if not t then
    t = {curUseCount = 0, maxUsedCount = 0}
    self.nameToMaxUsedCount[name] = t
  end
  t.curUseCount = t.curUseCount + 1
  if t.curUseCount > t.maxUsedCount then
    t.maxUsedCount = t.curUseCount
  end
end

function BasePool:UnUse(name)
  self.curUseCount = self.curUseCount - 1
  local t = self.nameToMaxUsedCount[name]
  if t then
    t.curUseCount = t.curUseCount - 1
  else
    Log.fatal("[Pool] UnUse, cannot find name=", name, " in self.nameToMaxUsedCount")
  end
end

function BasePool:Move(name, moveCount)
end

function BasePool:Pop(name)
  return
end

function BasePool:Push(name, resRequest)
end

function BasePool:RemoveFromCacheTable(name)
end

function BasePool:OnCreated()
end

function BasePool:OnDestroyed()
end
