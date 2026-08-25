local SceneLoaderBase = System.NewClass("SceneLoaderBase")

function SceneLoaderBase:ctor()
end

function SceneLoaderBase:StartLoadScene(scenepath, assetsPath, onFinished, isRemoveOnLowMemory)
  self.scenepath = scenepath
  self.assetsPath = assetsPath
  self.assetsLoader = MultiResourcesLoader()
  ResLoadMgr.LoadSceneAsync(scenepath, CommonDefine.LoadSceneModeType.Additive, function()
    self.isSceneLoaded = true
    if self.assetsLoader then
      self.assetsLoader:Load(self.assetsPath, onFinished)
    else
      pcall(ResLoadMgr.UnLoadScene, scenepath)
    end
  end)
end

function SceneLoaderBase:Clear()
  self.scenepath = nil
  self.assetsPath = nil
  if self.assetsLoader then
    self.assetsLoader:Clear()
    self.assetsLoader = nil
  end
end

return SceneLoaderBase
