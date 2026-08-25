local UnityTime = CS.UnityEngine.Time
local ResCache = NewClass("ResCache")
local _handleIdCounter = 0

function ResCache:ctor(createFunc, releaseFunc)
  self.cacheObjsParent = CS.UnityEngine.GameObject("ResCache").transform
  self.cacheObjsParent.gameObject:SetActive(false)
  self.permanentRes = nil
  self.delayRecycleTime = 10
  self.delayRemoveObjects = nil
  self.cacheObjects = nil
  self.freeResGameObjects = nil
  self.loadedResObjects = nil
  self.createFunc = createFunc
  self.releaseFunc = releaseFunc
end

function ResCache:SetDelayRecycleTime(delayRecycleTime)
  self.delayRecycleTime = delayRecycleTime
end

function ResCache:NewObject(assetPath, loadedHandler)
  local resObject = self:_GetResObject()
  local handleIdCounter = _handleIdCounter + 1
  _handleIdCounter = handleIdCounter
  resObject.handleId = handleIdCounter
  resObject.loadedHandler = loadedHandler
  if self.delayRemoveRes then
    self.delayRemoveRes[assetPath] = nil
  end
  self.cacheObjects = self.cacheObjects or {}
  self.cacheObjects[resObject.handleId] = resObject
  resObject.assetPath = assetPath
  self.gameObjectsCache = self.gameObjectsCache or {}
  local goPool = self.gameObjectsCache[assetPath]
  if not goPool then
    goPool = GameObjectPool(assetPath)
    self.gameObjectsCache[assetPath] = goPool
  end
  goPool:LoadResource(function()
    if not self.cacheObjects[handleIdCounter] then
      return
    end
    self.loadedResObjects = self.loadedResObjects or {}
    self.loadedResObjects[handleIdCounter] = resObject
  end)
  return resObject
end

function ResCache:RecycleObject(handler)
  if self.cacheObjects then
    local handleId = handler.handleId
    local resObject = self.cacheObjects[handleId]
    if resObject then
      local assetPath = handler.assetPath
      local goPool = self.gameObjectsCache and self.gameObjectsCache[assetPath] or nil
      if goPool and not IsNil(resObject.gameObject) then
        goPool:ReturnGameObject(resObject.gameObject)
        if self.cacheObjsParent then
          resObject.gameObject.transform:SetParent(self.cacheObjsParent)
        end
      end
      self.cacheObjects[handleId] = nil
      self:_RecycleResObject(resObject)
      if goPool and 0 == goPool:RefCount() then
        self.delayRemoveRes = self.delayRemoveRes or {}
        self.delayRemoveRes[assetPath] = 0.0
      end
      resObject:OnDisable()
    end
    if self.loadedResObjects then
      self.loadedResObjects[handleId] = nil
    end
  end
end

function ResCache:SetPermanent(assetPath, permanent)
  if permanent then
    self.permanentRes = self.permanentRes or {}
    self.permanentRes[assetPath] = true
  elseif self.permanentRes then
    self.permanentRes[assetPath] = nil
  end
end

function ResCache:IsPermanent(assetPath)
  if self.permanentRes then
    return self.permanentRes[assetPath]
  end
end

function ResCache:Update(deltaTime)
  if self.cacheObjects then
    self.tempCacheObjects = self.tempCacheObjects or {}
    table.clear(self.tempCacheObjects)
    table.mergeWithoutGc(self.tempCacheObjects, self.cacheObjects)
    for k, v in pairs(self.tempCacheObjects) do
      v:Update(deltaTime)
    end
  end
end

function ResCache:Dispose()
  if self.cacheObjects then
    local temp = {}
    table.mergeWithoutGc(temp, self.cacheObjects)
    for k, v in pairs(temp) do
      self:RecycleObject(v)
    end
    temp = nil
  end
  self:ReleaseUnuseResources()
  self.cacheObjects = nil
  self.freeResGameObjects = nil
  self.loadedResObjects = nil
  self.clearGoKeys = nil
  self.delayRemoveRes = nil
  self.clearResKeys = nil
end

function ResCache:ReleaseUnuseResources()
  if self.gameObjectsCache then
    local destroyKeys = {}
    table.mergeWithoutGc(destroyKeys, self.gameObjectsCache)
    for k, v in pairs(destroyKeys) do
      self:ReleaseUnuseResourceByPath(v)
    end
  end
end

function ResCache:ReleaseUnuseResourceByPath(assetPath)
  local goPool = self.gameObjectsCache and self.gameObjectsCache[assetPath] or nil
  if goPool and 0 == goPool:RefCount() then
    goPool:UnloadResource()
    self.gameObjectsCache[assetPath] = nil
  end
end

function ResCache:LateUpdate()
  if self.loadedResObjects then
    self.clearGoKeys = self.clearGoKeys or {}
    for k, v in pairs(self.loadedResObjects) do
      self.clearGoKeys[k] = v
    end
    table.clear(self.loadedResObjects)
    for k, v in pairs(self.clearGoKeys) do
      if k and v then
        self:_OnObjectResLoadedFinish(v)
      end
    end
    table.clear(self.clearGoKeys)
  end
  if self.delayRemoveRes then
    self.clearResKeys = self.clearResKeys or {}
    for k, v in pairs(self.delayRemoveRes) do
      self.delayRemoveRes[k] = self.delayRemoveRes[k] + UnityTime.deltaTime
      if self.delayRemoveRes[k] >= self.delayRecycleTime then
        self.clearResKeys[k] = v
      end
    end
    for k, v in pairs(self.clearResKeys) do
      self.delayRemoveRes[k] = nil
      self:ReleaseUnuseResourceByPath(k)
    end
    table.clear(self.clearResKeys)
  end
end

function ResCache:_GetResObject()
  if self.createFunc then
    do return end
    return self.createFunc, nil, nil, nil
  end
  local resObject
  if self.freeResGameObjects then
    resObject = self.freeResGameObjects[1]
    if resObject then
      table.remove(self.freeResGameObjects, 1)
    end
  end
  resObject = resObject or ResGameObject()
  return resObject
end

function ResCache:_RecycleResObject(resObject)
  if self.releaseFunc then
    self.releaseFunc(resObject)
    return
  end
  self.freeResGameObjects = self.freeResGameObjects or {}
  table.insert(self.freeResGameObjects, resObject)
end

function ResCache:_OnObjectResLoadedFinish(resObject)
  local resHandler
  if self.cacheObjects then
    resHandler = self.cacheObjects[resObject.handleId]
  end
  if not resHandler then
    return
  end
  local assetPath = resObject.assetPath
  local goPool = self.gameObjectsCache and self.gameObjectsCache[assetPath] or nil
  if not goPool then
    return
  end
  local go = goPool:FetchGameObject()
  if IsNil(go) then
    return
  end
  local parent = resHandler.parent
  resHandler.parent = nil
  resObject.gameObject = go
  go.transform:SetParent(parent, false)
  resObject:OnEnable()
  if resObject.loadedHandler then
    resObject.loadedHandler(resObject)
  end
end

return ResCache
