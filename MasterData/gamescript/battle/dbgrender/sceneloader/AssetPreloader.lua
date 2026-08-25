local AssetPreloader = System.NewClass("AssetPreloader")
local hasPreloadShaders

function AssetPreloader.PreloadShaders()
  if hasPreloadShaders then
    return
  end
  hasPreloadShaders = true
  local shaderType = typeof(CS.UnityEngine.Shader)
  for i = 1, #CommonRes.PreloadShaders do
    local shader = ResLoadMgr.LoadAsset(CommonRes.PreloadShaders[i], AssetPreloader, shaderType)
    if shader then
      CS.ShaderCache.AddShader(shader.name, shader)
    end
  end
  ShadersWarmUpMgr.Instance:StartWarmup()
end

function AssetPreloader:ctor()
end

function AssetPreloader:StartPreLoadAssets()
  if self._hasPreloaded then
    return
  end
  self._hasPreloaded = true
  self:StopPreLoadAssets()
  self.persistentLoader = MultiResourcesLoader()
  self.persistentLoader:Load({
    CommonRes.ShaderVariants
  }, function()
    self._shaderVariants = self.persistentLoader:GetResource(CommonRes.ShaderVariants)
  end)
  self.assetsLoader = MultiResourcesLoader()
  self.battleAssetsLoader = MultiResourcesLoader()
  local resList = {}
  for i = 1, #CommonRes.BasicAssetList do
    table.insert(resList, CommonRes.BasicAssetList[i])
  end
  for i = 1, #CommonRes.BattleAssetList do
    table.insert(resList, CommonRes.BattleAssetList[i])
  end
  for k, v in pairs(CommonRes.AddtionalAssetList) do
    table.insert(resList, v)
  end
  local resTableList = {}
  for _, v in pairs(CommonRes.BattleMaterial) do
    table.insert(resTableList, v)
  end
  self.assetsLoader:Load(resList)
  self.battleAssetsLoader:LoadByTable(resTableList)
  for k, v in pairs(CommonRes.TimelinePrepared) do
    CS.AMTimeline.AMResourcesCache.PrepareDirector(v)
  end
  self:_KeepAwakerSvcAlive()
end

function AssetPreloader:_KeepAwakerSvcAlive()
  if ShadersWarmUpMgr.IsSupportWarmUp() then
    return
  end
  local actorGoldenBodyAliveAsset = ResLoadMgr.LoadAsset("GameBasePrefab/ActorGoldenBodyAlive.prefab", self)
  if not actorGoldenBodyAliveAsset then
    return
  end
  local go = CS.UnityEngine.GameObject.Instantiate(actorGoldenBodyAliveAsset)
  if not go then
    return
  end
  local shadowGo = go.transform:Find("Camera/QuadShadow")
  if not shadowGo then
    return
  end
  local renderer = shadowGo.gameObject:GetComponent(typeof(CS.UnityEngine.Renderer))
  if not renderer or not renderer.sharedMaterial then
    return
  end
  renderer.sharedMaterial:EnableKeyword("_SHADOWS_SOFT")
end

function AssetPreloader:StopPreLoadAssets()
  self:Clear()
end

function AssetPreloader:Dispose()
  ShadersWarmUpMgr.Instance:StopWarmup()
  if self._shaderVariants and not ApplicationUtils.is_editor_mode() then
    DestroyImmediate(self._shaderVariants, true)
    self._shaderVariants = nil
  end
  if self.persistentLoader then
    self.persistentLoader:Clear()
    self.persistentLoader = nil
  end
  self:Clear()
end

function AssetPreloader:Clear()
  ResLoadMgr.UnloadAssetByTarget(AssetPreloader)
  if self.assetsLoader then
    self.assetsLoader:Clear()
    self.assetsLoader = nil
  end
  if self.battleAssetsLoader then
    self.battleAssetsLoader:Clear()
    self.battleAssetsLoader = nil
  end
  CS.AMTimeline.AMResourcesCache.Clear()
end

AssetPreloader.Instance = AssetPreloader()
return AssetPreloader
