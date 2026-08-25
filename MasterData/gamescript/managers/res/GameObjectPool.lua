local GameObjectPool, Super = System.NewClass("GameObjectPool")
local GameObjectInsQueue = CS.GameObjectInsQueue
local UseInstancedQueueTag = -10001

function GameObjectPool:ctor(assetPath)
  Super.ctor(self)
  self.assetPath = assetPath
  self.mainAsset = nil
  self.isLoading = nil
  self.callabcks = {}
  self.gameObjectsPool = nil
  self.trackGameObjects = nil
  self.useInstancedQueue = false
  UseInstancedQueueTag = UseInstancedQueueTag - 1
  self.instancedQueueTag = UseInstancedQueueTag
end

function GameObjectPool:LoadResource(callBack)
  table.insert(self.callabcks, callBack)
  if self.mainAsset then
    self:OnResourceLoadDone()
    return
  end
  if self.isLoading then
    return
  end
  self.isLoading = true
  ResLoadMgr.LoadAssetAsync(self.assetPath, self, function(asset)
    self.mainAsset = asset
    self:OnResourceLoadDone()
  end)
end

function GameObjectPool:UnloadResource()
  if self.useInstancedQueue then
    GameObjectInsQueue.Instance:StopTaskByTag(self.instancedQueueTag)
  end
  self.isLoading = nil
  if self.mainAsset then
    self.mainAsset = nil
  end
  self.callabcks = {}
  if self.trackGameObjects then
    for k, v in pairs(self.trackGameObjects) do
      if not IsNil(k) then
        Destroy(k)
        Logger.Error("GameObjectPool.UnloadResource还有实例化对象没有回收，assetPath=" .. self.assetPath)
      end
    end
    self.trackGameObjects = nil
  end
  if self.gameObjectsPool then
    for i = 1, #self.gameObjectsPool do
      Destroy(self.gameObjectsPool[i])
    end
    self.gameObjectsPool = nil
  end
  ResLoadMgr.UnloadAssetByTarget(self)
end

function GameObjectPool:IsResourceLoaded()
  return self.mainAsset ~= nil
end

function GameObjectPool:GetMainAsset()
  return self.mainAsset
end

function GameObjectPool:OnResourceLoadDone()
  local cbs = self.callabcks
  self.callabcks = {}
  self.isLoading = nil
  if self.useInstancedQueue then
    local index = 0
    for i = 1, #cbs do
      if self.gameObjectsPool and #self.gameObjectsPool then
        index = i
        cbs[i]()
      else
        break
      end
    end
    local task = GameObjectInsQueue.Instance:PushTask(self.mainAsset, #cbs - index, function(go)
      self.gameObjectsPool = self.gameObjectsPool or {}
      table.insert(self.gameObjectsPool, go)
      index = index + 1
      cbs[index]()
    end)
    task.tag = self.instancedQueueTag
  else
    for i = 1, #cbs do
      cbs[i]()
    end
  end
end

function GameObjectPool:FetchGameObject()
  if not self.mainAsset then
    Logger.Error("资源还没加载完，路径=" .. self.assetPath)
    return
  end
  local go
  if self.gameObjectsPool and #self.gameObjectsPool then
    go = table.remove(self.gameObjectsPool, 1)
  end
  if IsNil(go) then
    go = CS.UnityEngine.GameObject.Instantiate(self.mainAsset)
  end
  self.trackGameObjects = self.trackGameObjects or {}
  self.trackGameObjects[go] = true
  return go
end

function GameObjectPool:ReturnGameObject(go)
  if IsNil(go) then
    return
  end
  if not self.trackGameObjects or not self.trackGameObjects[go] then
    Logger.Error("资回收的对象不是从这个资源中实例化出去的，名字=" .. go.name)
    return
  end
  self.gameObjectsPool = self.gameObjectsPool or {}
  table.insert(self.gameObjectsPool, go)
  self.trackGameObjects[go] = nil
end

function GameObjectPool:RefCount()
  local refCount = 0
  if self.trackGameObjects then
    for _, _ in pairs(self.trackGameObjects) do
      refCount = refCount + 1
    end
  end
  return refCount
end

return GameObjectPool
