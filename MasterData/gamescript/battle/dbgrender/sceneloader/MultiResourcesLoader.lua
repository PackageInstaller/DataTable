local MultiResourcesLoader = System.NewClass("MultiResourcesLoader")

function MultiResourcesLoader:ctor()
  self.loadedResDict = {}
  self.resPaths = {}
  self.isAllPreload = false
  self.finishCallback = nil
  self.loadedCount = 0
  self.totalCount = 0
end

function MultiResourcesLoader:IsAllSuccess()
  return self.totalCount == self.loadedCount
end

function MultiResourcesLoader:Load(resPaths, finishCallback, sync)
  self.resPaths = self:UniqueAssetsPath(resPaths)
  if self.resPaths == nil or 0 == #self.resPaths then
    if finishCallback then
      finishCallback()
    end
    return
  end
  self.finishCallback = finishCallback
  self.totalCount = #self.resPaths
  for i = 1, self.totalCount do
    local resPath = self.resPaths[i]
    if not sync then
      ResLoadMgr.LoadAssetAsync(resPath, self, function(asset)
        self:OnResLoaded(resPath, asset)
      end)
    else
      local asset = ResLoadMgr.LoadAsset(resPath, self)
      self:OnResLoaded(resPath, asset)
    end
  end
end

function MultiResourcesLoader:LoadByTable(resPaths, finishCallback)
  self.resPaths = self:UniqueAssetsTablePath(resPaths)
  if self.resPaths == nil or 0 == #self.resPaths then
    if finishCallback then
      finishCallback()
    end
    return
  end
  self.finishCallback = finishCallback
  self.totalCount = #self.resPaths
  for i = 1, self.totalCount do
    local data = self.resPaths[i]
    local resPath = data[1]
    local assetType = data[2]
    ResLoadMgr.LoadAssetAsync(resPath, self, function(asset)
      self:OnResLoaded(resPath, asset)
    end, assetType)
  end
end

function MultiResourcesLoader:UniqueAssetsTablePath(assetsTablePath)
  if not assetsTablePath then
    return
  end
  local resMap = {}
  for _, v in pairs(assetsTablePath) do
    if not resMap[v[1]] then
      resMap[v[1]] = v
    end
  end
  local resPaths = {}
  for k, v in pairs(resMap) do
    table.insert(resPaths, {
      v[1],
      v[2]
    })
  end
  return resPaths
end

function MultiResourcesLoader:UniqueAssetsPath(assetsPath)
  if not assetsPath or 0 == #assetsPath then
    return
  end
  local resMap = {}
  for i = 1, #assetsPath do
    if not resMap[assetsPath[i]] then
      resMap[assetsPath[i]] = true
    end
  end
  local resPaths = {}
  for k, v in pairs(resMap) do
    table.insert(resPaths, k)
  end
  return resPaths
end

function MultiResourcesLoader:OnResLoaded(resPath, asset)
  if 0 == self.totalCount then
    return
  end
  self.loadedCount = self.loadedCount + 1
  self.loadedResDict[resPath] = asset
  if self.loadedCount >= self.totalCount and self.finishCallback then
    self.finishCallback()
  end
end

function MultiResourcesLoader:GetResources()
  return self.loadedResDict
end

function MultiResourcesLoader:GetResource(resPath)
  return self.loadedResDict[resPath]
end

function MultiResourcesLoader:Clear()
  if 0 == self.totalCount then
    return
  end
  ResLoadMgr.UnloadAssetByTarget(self)
  self.loadedResDict = {}
  self.resPaths = {}
  self.finishCallback = nil
  self.loadedCount = 0
  self.totalCount = 0
end

return MultiResourcesLoader
