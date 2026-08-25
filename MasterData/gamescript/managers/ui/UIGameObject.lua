local UIGameObject, Super = System.NewClass("UIGameObject")

function UIGameObject:ctor(assetPath)
  Super.ctor(self)
  self.assetPath = assetPath
  self.mainAsset = nil
  self.isLoading = nil
  self.callabcks = {}
  self.gameObjectsPool = nil
  self.trackGameObjects = nil
end

function UIGameObject:LoadResource(callBack, sync)
  table.insert(self.callabcks, callBack)
  if self.mainAsset then
    self:OnResourceLoadDone()
    return
  end
  if self.isLoading then
    return
  end
  self.isLoading = true
  if sync then
    self.mainAsset = ResLoadMgr.LoadAsset(self.assetPath, self)
    self:OnResourceLoadDone()
    return
  end
  ResLoadMgr.LoadAssetAsync(self.assetPath, self, function(asset)
    self.mainAsset = asset
    self:OnResourceLoadDone()
  end)
end

function UIGameObject:UnloadResource()
  self.isLoading = nil
  if self.mainAsset then
    self.mainAsset = nil
  end
  self.callabcks = {}
  if self.trackGameObjects then
    for k, v in pairs(self.trackGameObjects) do
      Destroy(k)
      Logger.Error("UIGameObject.UnloadResource还有实例化对象没有回收，assetPath=" .. self.assetPath)
    end
  end
  if self.gameObjectsPool then
    for i = 1, #self.gameObjectsPool do
      Destroy(self.gameObjectsPool[i])
    end
  end
  self.gameObjectsPool = nil
  ResLoadMgr.UnloadAssetByTarget(self)
end

function UIGameObject:IsResourceLoaded()
  return self.mainAsset ~= nil
end

function UIGameObject:GetMainAsset()
  return self.mainAsset
end

function UIGameObject:ClearCallback()
  self.callabcks = {}
end

function UIGameObject:OnResourceLoadDone()
  local cbs = self.callabcks
  self.callabcks = {}
  self.isLoading = nil
  if cbs then
    for i = 1, #cbs do
      cbs[i]()
    end
  end
end

function UIGameObject:FetchGameObject()
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

function UIGameObject:ReturnGameObject(go)
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

function UIGameObject:RefCount()
  local refCount = 0
  for _, _ in pairs(self.trackGameObjects) do
    refCount = refCount + 1
  end
  return refCount
end

return UIGameObject
