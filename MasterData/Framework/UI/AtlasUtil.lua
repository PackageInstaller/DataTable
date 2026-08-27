local cs_ResLoader = CS.ResLoader
AtlasUtil = {}

function AtlasUtil.GetSpriteFromAtlas(atlasName, sName, resloader)
  local atlas = resloader:LoadABAsset(PathConsts:GetAtlasAssetPath(atlasName))
  if IsNull(atlas) then
    return nil
  end
  local sprite = AtlasUtil.GetResldSprite(atlas, sName)
  if IsNull(sprite) then
    return nil
  end
  return sprite
end

function AtlasUtil.GetSpirteAtlas(atlasName, resloader)
  local atlas = resloader:LoadABAsset(PathConsts:GetAtlasAssetPath(atlasName))
  return atlas
end

function AtlasUtil.GetResldSprite(atlas, spriteName)
  return cs_ResLoader.GetAtlasSprite(atlas, spriteName)
end
