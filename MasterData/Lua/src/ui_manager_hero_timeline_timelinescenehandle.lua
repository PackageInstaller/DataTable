local this = class("timelineSceneHandle")

function this:ctor(_timelinePrefabHandle)
  self._timelinePrefabHandle = _timelinePrefabHandle
  self._scenePrefabMap = {}
  self._sceneInsIDMap = {}
  self._sceneName = nil
end

function this:dispose()
  if self._scenePrefabMap then
    for i, v in pairs(self._scenePrefabMap) do
      C_PrefabManager:RecycleByLoader(v)
      self._scenePrefabMap[i] = nil
    end
  end
  if self._sceneInsIDMap then
    for i, v in pairs(self._sceneInsIDMap) do
      C_PrefabManager:RecycleByLoader(v)
      self._sceneInsIDMap[i] = nil
    end
  end
  self._scenePrefabMap = nil
  self._sceneInsIDMap = nil
  self._sceneName = nil
end

function this:clearMap()
  if self._scenePrefabMap then
    for i, v in pairs(self._scenePrefabMap) do
      C_PrefabManager:RecycleByLoader(v)
      self._scenePrefabMap[i] = nil
    end
  end
  if self._sceneInsIDMap then
    for i, v in pairs(self._sceneInsIDMap) do
      C_PrefabManager:RecycleByLoader(v)
      self._sceneInsIDMap[i] = nil
    end
  end
end

function this:disposeSceneAsset(lastName, curName)
  local isLowMemoryDevice = true
  if self._scenePrefabMap then
    for i, v in pairs(self._scenePrefabMap) do
      local isNeedClear = false
      if isLowMemoryDevice then
        isNeedClear = i ~= curName
      else
        isNeedClear = i ~= lastName and i ~= curName
      end
      if isNeedClear then
        C_PrefabManager:RecycleByLoader(v)
        self._scenePrefabMap[i] = nil
      end
    end
  end
  if self._sceneInsIDMap then
    for i, v in pairs(self._sceneInsIDMap) do
      local isNeedClear = false
      if isLowMemoryDevice then
        isNeedClear = i ~= curName
      else
        isNeedClear = i ~= lastName and i ~= curName
      end
      if isNeedClear then
        C_PrefabManager:RecycleByLoader(v)
        self._sceneInsIDMap[i] = nil
      end
    end
  end
end

function this:loadScenePrefab(sceneName)
  if self._sceneName == sceneName then
    return
  end
  if self._scenePrefabMap[self._sceneName] then
    self._scenePrefabMap[self._sceneName]:ActiveTrans(false)
  end
  self:disposeSceneAsset(self._sceneName, sceneName)
  if not string.isEmpty(sceneName) then
    self._sceneName = nil
    return
  end
  local prefab
  self._sceneName = sceneName
  if self._scenePrefabMap[sceneName] then
    prefab = self._scenePrefabMap[sceneName]
  else
    prefab = C_UIMgr.uiLoader:Spawn(sceneName, self._timelinePrefabHandle:getRoot().transform, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
    L_Vector3.setLocalPos(prefab.transform, L_Vector3.getTemp())
    L_Vector3.setRot(prefab.transform, L_Vector3.getTemp())
    self._scenePrefabMap[sceneName] = prefab
  end
  prefab:ActiveTrans(true)
end

function this:asyncscenePrefab(sceneName, loadedCallBack)
  C_MJLog.LogDebug("多人测试，真正记载资源 loadedCallBack", C_ELogModule.Home)
  if self._sceneName == sceneName or self._scenePrefabMap[sceneName] ~= nil then
    loadedCallBack(self._scenePrefabMap[sceneName])
    C_MJLog.LogDebug("多人测试，执行缓存里的回调 loadedCallBack", C_ELogModule.Home)
    return
  end
  if self:changeScene(sceneName) == false then
    local insID = C_UIMgr.uiLoader:SpawnAsync(sceneName, function(instanceId, obj)
      obj:ActiveTrans(false)
      self._scenePrefabMap[sceneName] = obj
      C_MJLog.LogDebug("多人测试，异步记载完成加载完成 loadedCallBack", C_ELogModule.Home)
      loadedCallBack(obj)
    end, self._timelinePrefabHandle:getRoot().transform, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
    self._sceneInsIDMap[sceneName] = insID
  end
end

function this:changeScene(sceneName)
  if not self._sceneInsIDMap then
    return
  end
  local sceneID = self._sceneInsIDMap[sceneName]
  if sceneID then
    C_UISceneManager.SetSceneVisible()
    self._scenePrefabMap[sceneName]:ActiveTrans(true)
    if self._sceneName ~= sceneName and self._sceneInsIDMap[self._sceneName] then
      self:disposeSceneAsset(self._sceneName, sceneName)
    end
    self._sceneName = sceneName
    return true
  end
  return false
end

return this
