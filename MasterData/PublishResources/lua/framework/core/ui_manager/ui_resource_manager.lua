_class("UIResourceManager", Singleton)
local TABLE_CLEAR = table.clear

function UIResourceManager.GetViewAsync(TT, uiName, uiPrefab)
  local resRequest = GameGlobal.DonotDestroyRes():GetUIRes(uiPrefab)
  resRequest = resRequest or ResourceManager:GetInstance():AsyncLoadAsset(TT, uiPrefab, LoadType.GameObject)
  local uiGo = resRequest.Obj
  if not uiGo then
    Log.fatal("[UI] UIResourceManager.GetViewAsync, Load View error: ", uiPrefab)
    return nil
  end
  Log.debug("[UI] UIResourceManager.GetViewAsync, end Load View, ", uiPrefab)
  uiGo.name = uiName
  return uiGo:GetComponent("UIView"), resRequest
end

function UIResourceManager.GetView(uiName, uiPrefab)
  Log.debug("[UI] UIResourceManager.GetView, begin Load View, ", uiPrefab)
  local resRequest = ResourceManager:GetInstance():SyncLoadAsset(uiPrefab, LoadType.GameObject)
  local uiGo = resRequest.Obj
  if not uiGo then
    Log.fatal("[UI] UIResourceManager.GetView, Load View error: ", uiPrefab)
    return nil
  end
  Log.debug("[UI] UIResourceManager.GetView, end Load View, ", uiPrefab)
  uiGo.name = uiName
  return uiGo:GetComponent("UIView"), resRequest
end

function UIResourceManager.DisposeView(resRequest)
  resRequest:Dispose()
end

function UIResourceManager.GetAsset(name, loadType, name2Assets)
  local asset = name2Assets[name]
  if asset then
    return asset.Obj
  end
  local resRequest = ResourceManager:GetInstance():SyncLoadAsset(name, loadType)
  name2Assets[name] = resRequest
  return resRequest.Obj
end

function UIResourceManager.AsyncGetAsset(TT, name, loadType, name2Assets)
  local asset = name2Assets[name]
  if asset then
    return asset.Obj
  end
  local resRequest = ResourceManager:GetInstance():AsyncLoadAsset(TT, name, loadType)
  name2Assets[name] = resRequest
  return resRequest.Obj
end

function UIResourceManager.DisposeAsset(name, uiName, name2Assets)
  local asset = name2Assets[name]
  if asset then
    asset:Dispose()
  else
    Log.fatal("[UI] UIResourceManager.DisposeAsset Error, no asset name ", name, " in ui ", uiName)
  end
  name2Assets[name] = nil
end

function UIResourceManager.DisposeAllAssets(name2Assets)
  for k, v in pairs(name2Assets) do
    v:Dispose()
  end
  TABLE_CLEAR(name2Assets)
end

function UIResourceManager.SyncGetGameObject(name, go2ResRequest)
  local resRequest = ResourceManager:GetInstance():SyncLoadAsset(name, LoadType.GameObject)
  local go = resRequest.Obj
  UIHelper.SetActive(go, true)
  go2ResRequest[go] = resRequest
  return go
end

function UIResourceManager.AsyncGetGameObject(TT, name, go2ResRequest)
  local resRequest = ResourceManager:GetInstance():AsyncLoadAsset(TT, name, LoadType.GameObject)
  local go = resRequest.Obj
  if not go then
    Log.fatal("[UI] UIResourceManager.AsyncGetGameObject error: ", name)
    return nil
  end
  UIHelper.SetActive(go, true)
  go2ResRequest[go] = resRequest
  return go
end

function UIResourceManager.DisposeGameObject(go, go2ResRequest)
  local resRequest = go2ResRequest[go]
  if resRequest then
    go2ResRequest[go] = nil
    resRequest:Dispose()
  end
end

function UIResourceManager.DisposeAllGameObjects(go2ResRequest)
  for k, v in pairs(go2ResRequest) do
    v:Dispose()
  end
  TABLE_CLEAR(go2ResRequest)
end
