local ResourceLoader = CS.ResourceLoader
local GameResourceLoader = {}
GameResourceLoader.ResType = CS.GameResourceLoader.ResourceType
GameResourceLoader.RootPath = "Assets/AssetBundles/"
local tbCachedBundleGroup = {}
GameResourceLoader.LoadAssets = CS.GameResourceLoader.LoadAssets
GameResourceLoader.LoadAssetsAsync = CS.GameResourceLoader.LoadAssetsAsync
GameResourceLoader.LoadSubAsset = CS.GameResourceLoader.LoadSubAsset
GameResourceLoader.LoadSubAssetAsync = CS.GameResourceLoader.LoadSubAssetAsync
GameResourceLoader.LoadSubAssets = CS.GameResourceLoader.LoadSubAssets
GameResourceLoader.LoadSubAssetsAsync = CS.GameResourceLoader.LoadSubAssetsAsync
GameResourceLoader.LoadAllSubAssets = CS.GameResourceLoader.LoadAllSubAssets
GameResourceLoader.LoadAllSubAssetsAsync = CS.GameResourceLoader.LoadAllSubAssetsAsync
GameResourceLoader.LoadAssetBundle = CS.GameResourceLoader.LoadAssetBundle
GameResourceLoader.Unload = CS.GameResourceLoader.Unload

function GameResourceLoader.LoadAsset(resourceType, path, type, bundleGroup, panelId)
  local res = CS.GameResourceLoader.LoadAsset(resourceType, path, type, GameResourceLoader.MakeBundleGroup(bundleGroup, panelId))
  if res ~= nil then
    return res
  else
    printError("load resource failed: " .. path)
    return nil
  end
end

function GameResourceLoader.LoadAssetAsync(resourceType, path, type, bundleGroup, panelId, callBack)
  CS.GameResourceLoader.LoadAssetAsync(resourceType, path, type, callBack, GameResourceLoader.MakeBundleGroup(bundleGroup, panelId))
end

function GameResourceLoader.UnloadAsset(nPanelId)
  if tbCachedBundleGroup[nPanelId] ~= nil then
    if PanelManager.CheckPanelOpen(nPanelId) == true then
      return
    end
    local _clonedBundleGroup = tbCachedBundleGroup[nPanelId].clonedBundleGroup
    GameResourceLoader.Unload(_clonedBundleGroup)
    _clonedBundleGroup = nil
    tbCachedBundleGroup[nPanelId] = nil
  end
end

function GameResourceLoader.ExistsAsset(path)
  return CS.GameResourceLoader.ExistsAsset(path)
end

function GameResourceLoader.MakeBundleGroup(sGroupName, nPanelId)
  local _clonedBundleGroup
  if sGroupName ~= nil and nPanelId ~= nil and nPanelId ~= 0 then
    if tbCachedBundleGroup[nPanelId] == nil then
      _clonedBundleGroup = CS.GameResourceLoader.CloneBundleGroup(sGroupName)
      tbCachedBundleGroup[nPanelId] = {clonedBundleGroup = _clonedBundleGroup}
    else
      _clonedBundleGroup = tbCachedBundleGroup[nPanelId].clonedBundleGroup
    end
  end
  return _clonedBundleGroup
end

return GameResourceLoader
