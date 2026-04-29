local normal
UIAssetConfig = {}

function UIAssetConfig.GetComponentPrefab(type)
  if not normal then
    normal = {
      UIAssetComponentNew = "UIAssetComponentNew.prefab"
    }
  end
  local prefab = normal[type]
  if prefab then
    return prefab
  else
    return type._className .. ".prefab"
  end
end
