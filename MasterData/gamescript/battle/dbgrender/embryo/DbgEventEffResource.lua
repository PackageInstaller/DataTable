local DbgEventEffResource, Super = System.NewClass("DbgEventEffResource")

function DbgEventEffResource:ctor(assetPath)
  Super.ctor(self)
  self.assetPath = assetPath
  self.mainAsset = nil
  self.isLoading = nil
  self.callabck = nil
  self.gameObjectsPool = nil
  self.trackGameObjects = nil
end

function DbgEventEffResource:LoadResource(callabck)
  self.callabck = callabck
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

function DbgEventEffResource:UnloadResource()
  self.isLoading = nil
  if self.mainAsset then
    self.mainAsset = nil
  end
  self.callabck = nil
  if self.gameObjectsPool then
    for _, go in pairs(self.gameObjectsPool) do
      CS.UnityEngine.GameObject.Destroy(go)
      if self.trackGameObjects[go] then
        self.trackGameObjects[go] = nil
      end
    end
  end
  ResLoadMgr.UnloadAssetByTarget(self)
end

function DbgEventEffResource:IsResourceLoaded()
  return self.mainAsset ~= nil
end

function DbgEventEffResource:GetMainAsset()
  return self.mainAsset
end

function DbgEventEffResource:OnResourceLoadDone()
  local cb = self.callabck
  self.callabck = nil
  self.isLoading = nil
  if cb then
    cb()
  end
end

function DbgEventEffResource:FetchGameObject()
  if not self.mainAsset then
    Logger.Error("资源还没加载完，路径=" .. self.assetPath)
    return
  end
  local go
  if self.gameObjectsPool and #self.gameObjectsPool then
    go = table.remove(self.gameObjectsPool, 1)
  end
  go = go or CS.UnityEngine.GameObject.Instantiate(self.mainAsset)
  self.trackGameObjects = self.trackGameObjects or {}
  self.trackGameObjects[go] = true
  return go
end

function DbgEventEffResource:ReturnGameObject(go)
  if IsNil(go) then
    return
  end
  if not self.trackGameObjects or not self.trackGameObjects[go] then
    Logger.Error("资回收的对象不是从这个资源中实例化出去的，名字=" .. go.name)
    return
  end
  if not self:IsInPool(go) then
    self.gameObjectsPool = self.gameObjectsPool or {}
    table.insert(self.gameObjectsPool, go)
  end
end

function DbgEventEffResource:IsInPool(go)
  for _, v in ipairs(self.gameObjectsPool or {}) do
    if v == go then
      return true
    end
  end
end

return DbgEventEffResource
