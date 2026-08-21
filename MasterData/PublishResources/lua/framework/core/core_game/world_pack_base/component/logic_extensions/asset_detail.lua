_class("IAssetDetail", Object)
IAssetDetail = IAssetDetail

function IAssetDetail:Constructor(resPath)
  self.AssetType = "undefinition"
  self.AsyncLoad = false
  self._ResPath = resPath
end

function IAssetDetail:GenerateView(resource_service, finish_callback, ...)
end

function IAssetDetail:GetResPath()
  return self._ResPath
end
