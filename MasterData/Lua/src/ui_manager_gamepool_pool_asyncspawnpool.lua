local this = class("asyncSpawnPool")

function this:ctor(despawnRoot, threshold)
  self.spawnPool = L_PoolManager:getSpawnPool(despawnRoot, threshold)
  self.keyCountDic = {}
  self.keyResHandelDic = {}
  self.onceTimerCount = 1
  self.onceTimerDesCount = 1
  self.waitSpawnQueue = L_Struct.getQueue()
  self.waitDeSpawnQueue = L_Struct.getQueue()
  self.updateHandler = handler(self, self.update)
  self.handlerDic = {}
  self.handlerGoDic = {}
end

function this:init()
  C_UpdateSource.AddUpdateEventHandler(self.updateHandler, "asyncSpawnPool.update")
end

function this:update()
  local count = self.waitSpawnQueue:getLength()
  if 0 < count then
    count = count < self.onceTimerCount and count or self.onceTimerCount
    for i = 1, count do
      local spawnData = self.waitSpawnQueue:deQueue()
      self:_asyncSpawn(spawnData.resKey, spawnData.path, spawnData.callback)
    end
  end
  local desCount = self.waitDeSpawnQueue:getLength()
  if 0 < desCount then
    desCount = desCount < self.onceTimerDesCount and desCount or self.onceTimerDesCount
    for i = 1, desCount do
      local spawnData = self.waitDeSpawnQueue:deQueue()
      self:_despawnRes(spawnData.resKey)
    end
  end
end

function this:setMaxCount(value)
  self.onceTimerCount = value
end

function this:asyncGameObject(path, callback, isDestroy, isForce)
  isDestroy = true
  local resKey
  if self.keyCountDic[path] == nil then
    self.keyCountDic[path] = 0
  end
  self.keyCountDic[path] = self.keyCountDic[path] + 1
  resKey = string.format("%s_%s", path, self.keyCountDic[path])
  self.keyResHandelDic[resKey] = {isDeSpawn = false, go = nil}
  if isDestroy then
    self:setResDestory(resKey)
  end
  if isForce then
    self:_asyncSpawn(resKey, path, callback)
  elseif 0 >= self.onceTimerCount then
    self:_asyncSpawn(resKey, path, callback)
  else
    self.waitSpawnQueue:enQueue({
      resKey = resKey,
      path = path,
      callback = callback
    })
  end
  return resKey
end

function this:_asyncSpawn(resKey, path, callback)
  local function _callBack(go)
    if self.keyResHandelDic[resKey].isDeSpawn then
      self.spawnPool:despawn(go)
      
      return
    end
    self.keyResHandelDic[resKey].go = go
    if callback then
      callback(go)
    end
  end
  
  local go = self.spawnPool:asyncSpawn(path, _callBack)
  if self.keyCountDic[path] >= math.maxinteger * 0.5 then
    self.keyCountDic[path] = 0
    error("load the asyncSpawnPool is maxUp path:" .. path)
  end
end

function this:setResDestory(resKey)
  if self.keyResHandelDic[resKey] == nil then
    error("self.keyResHandelDic has not key" .. resKey)
    return
  end
  self.keyResHandelDic[resKey].isDestroy = true
end

function this:despawnRes(resKey, isForce)
  if string.isEmpty(resKey) then
    return
  end
  if self.keyResHandelDic[resKey] == nil then
    error("self.keyResHandelDic has not key" .. resKey)
    return
  end
  self.keyResHandelDic[resKey].isDeSpawn = true
  if isForce then
    self:_despawnRes(resKey)
  else
    self.waitDeSpawnQueue:enQueue({resKey = resKey})
  end
end

function this:_despawnRes(resKey)
  if L_CommonUtil.isValid(self.keyResHandelDic[resKey].go) then
    if self.keyResHandelDic[resKey].isDestroy then
      self.spawnPool:destroyGo(self.keyResHandelDic[resKey].go)
    else
      self.spawnPool:despawn(self.keyResHandelDic[resKey].go)
    end
  end
end

function this:dispose()
  self.waitSpawnQueue:clear()
  self.waitDeSpawnQueue:clear()
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandler)
  self.spawnPool:dispose()
  self.keyCountDic = {}
  self.keyResHandelDic = {}
end

return this
