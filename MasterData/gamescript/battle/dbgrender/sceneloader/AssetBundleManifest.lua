local AssetBundleManifest = NewClass("AssetBundleManifest")

function AssetBundleManifest:LoadFromFile()
  self._abDependencies = {}
  self._asset2ABName = {}
  local abJsonPath
  if ApplicationUtils.is_editor_mode() then
    abJsonPath = CS.UnityEngine.Application.streamingAssetsPath .. "/_ab_info.json"
  else
    abJsonPath = CS.ResourceManager.DownloadHelper.GetDownloadPathDefault() .. "/_ab_info.json"
  end
  local fileContent = CS.Framework.AssetLoadUtil.ReadFile(abJsonPath)
  if string.isempty(fileContent) then
    return false
  end
  local JSON = require("ejoysdk_lua.libs.lunajson")
  local abManifest = JSON.decode(fileContent)
  for _, it in pairs(abManifest.items) do
    local assetBundleName = it.assetBundleName
    local assetNames = it.assetNames
    for i = 1, #assetNames do
      self._asset2ABName[assetNames[i]] = assetBundleName
    end
    self._abDependencies[assetBundleName] = it.depAbs
  end
  return true
end

function AssetBundleManifest:Asset2ABName(assetName)
  if not self._asset2ABName then
    return
  end
  return self._asset2ABName[assetName]
end

function AssetBundleManifest:GetDependencies(assetBundleName)
  return self._abDependencies and self._abDependencies[assetBundleName] or nil
end

AssetBundleManifest.Instance = AssetBundleManifest()
return AssetBundleManifest
