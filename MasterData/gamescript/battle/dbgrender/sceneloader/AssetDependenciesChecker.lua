local AssetDependenciesChecker = NewClass("AssetDependenciesChecker")

function AssetDependenciesChecker:StartCheckDependencies()
  if not ApplicationUtils.is_editor_mode() or CS.Z1Client.LuaCSharpUtil.GetDependencies == nil then
    return
  end
  local useABManifest = false
  local assetsList = self:_GetAllPreloadAssets()
  local invalidBundles = self:_GetInvalidAssetBundles()
  local invalidFolders = self:_GetInvalidAssetFolders()
  local result = {}
  for i = 1, #assetsList do
    local depth = 20
    local assetFullPath = assetsList[i]
    if not string.startswith(assetsList[i], "Packages/") then
      assetFullPath = "Assets/ArtRes/" .. assetsList[i]
    end
    if useABManifest then
      local abName = AssetBundleManifest.Instance:Asset2ABName(assetFullPath)
      local dependencies = AssetBundleManifest.Instance:GetDependencies(abName)
      self:_CheckInvaldAssetBundleDependencies(assetsList[i], abName, dependencies, invalidBundles, result, depth)
    else
      local dependencies = CS.Z1Client.LuaCSharpUtil.GetDependencies(assetFullPath)
      self:_CheckInvaldAssetDependencies(assetFullPath, assetFullPath, dependencies, invalidFolders, result, depth)
    end
  end
  for k, v in pairs(result) do
    Logger.Error(string.format("资源依赖错误，请联系程序或者美术检查资源规范，原始资源=%s  问题资源=%s  依赖资源=%s", v.assetName, v.abName, v.invalidBundleName))
  end
  if not useABManifest and table.next(result) then
    self:_SaveResult(result)
  end
end

function AssetDependenciesChecker:_SaveResult(result)
  local content = {}
  for k, v in pairs(result) do
    table.insert(content, v.invalidBundleName)
  end
  local fileContent = table.concat(content, ",")
  ApplicationUtils.WriteFile(fileContent, "Assets/AssetDependenciesChecker.txt")
end

function AssetDependenciesChecker:_CheckInvaldAssetBundleDependencies(originAssetName, abName, dependencies, invalidBundles, result, depth)
  if 0 == depth or not dependencies then
    return
  end
  for i, v in pairs(dependencies) do
    if invalidBundles[v] then
      table.insert(result, {
        assetName = originAssetName,
        abName = abName,
        invalidBundleName = v
      })
    end
  end
  local originABName = AssetBundleManifest.Instance:Asset2ABName(originAssetName)
  for i, v in pairs(dependencies) do
    if v ~= originABName then
      local deps = AssetBundleManifest.Instance:GetDependencies(v)
      self:_CheckInvaldAssetBundleDependencies(originAssetName, v, deps, invalidBundles, result, depth - 1)
    end
  end
end

function AssetDependenciesChecker:_CheckInvaldAssetDependencies(originAssetName, assetName, dependencies, invalidFolders, result, depth)
  if 0 == depth or not dependencies then
    return
  end
  for k, v in pairs(invalidFolders) do
    if string.startswith(assetName, k) then
      table.insert(result, {
        assetName = originAssetName,
        abName = assetName,
        invalidBundleName = assetName
      })
    end
  end
  for i = 0, dependencies.Length - 1 do
    for k, v in pairs(invalidFolders) do
      if assetName ~= dependencies[i] and string.startswith(dependencies[i], k) then
        table.insert(result, {
          assetName = originAssetName,
          abName = assetName,
          invalidBundleName = dependencies[i]
        })
      end
    end
  end
  for i = 0, dependencies.Length - 1 do
    if assetName ~= dependencies[i] then
      local deps = CS.Z1Client.LuaCSharpUtil.GetDependencies(dependencies[i])
      self:_CheckInvaldAssetDependencies(originAssetName, dependencies[i], deps, invalidFolders, result, depth - 1)
    end
  end
end

function AssetDependenciesChecker:_GetAllPreloadAssets()
  local assetsList = {}
  for k, v in pairs(CommonRes.PreloadShaders) do
    table.insert(assetsList, v)
  end
  for k, v in pairs(CommonRes.BasicAssetList) do
    table.insert(assetsList, v)
  end
  for k, v in pairs(CommonRes.AddtionalAssetList) do
    table.insert(assetsList, v)
  end
  for k, v in pairs(CommonRes.TimelinePrepared) do
    table.insert(assetsList, v)
  end
  for k, v in pairs(CommonRes.BattleMaterial) do
    table.insert(assetsList, v[1])
  end
  local UIPanelAssetList = CommonRes.UIPanelAssetList
  for url, v in pairs(UIPanelAssetList) do
    local uiCls = require("GameScript." .. url)
    local assetPath = UIManager.GetUIResObj(uiCls.uiResCls).assetPath
    table.insert(assetsList, assetPath)
  end
  return assetsList
end

function AssetDependenciesChecker:_GetInvalidAssetBundles()
  return {
    ["artres/effects/common/textures/gloww.ab"] = true,
    ["artres/effects/common/textures/loopp.ab"] = true,
    ["artres/effects/common/textures/maskk.ab"] = true,
    ["artres/effects/common/textures/noisee.ab"] = true,
    ["artres/effects/common/textures/objectt.ab"] = true,
    ["artres/effects/common/textures/smokee.ab"] = true,
    ["artres/effects/common/textures/traill.ab"] = true,
    ["artres/effects/common/textures/xuliee.ab"] = true,
    ["artres/effects/common/model.ab"] = true
  }
end

function AssetDependenciesChecker:_GetInvalidAssetFolders()
  return {
    ["Assets/ArtRes/Effects/Common/Textures/"] = true,
    ["Assets/ArtRes/Effects/Common/Model/"] = true
  }
end

AssetDependenciesChecker.Instance = AssetDependenciesChecker()
return AssetDependenciesChecker
