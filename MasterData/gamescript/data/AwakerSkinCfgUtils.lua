local AwakerSkinCfgUtils = {}

function AwakerSkinCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.AwakerSkin[tid]
end

function AwakerSkinCfgUtils.GetCfgField(field, cfgTid)
  local cfg = AwakerSkinCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function AwakerSkinCfgUtils.GetSkinQuality(skinTid)
  local targetSkinQuality = AwakerSkinCfgUtils.GetCfgField("Quality", skinTid)
  targetSkinQuality = targetSkinQuality or AwakerSkinDefine.SkinQuality.Star00
  return targetSkinQuality
end

function AwakerSkinCfgUtils.GetSkinQualityImage(skinTid)
  local quality = AwakerSkinCfgUtils.GetSkinQuality(skinTid)
  do return ItemQualityCfgUtils.GetCfgField, "ItemQualityColor" end
  return ItemQualityCfgUtils.GetCfgField, "ItemQualityColor", quality
end

function AwakerSkinCfgUtils.GetSkinQualityBottomImage(skinTid)
  local quality = AwakerSkinCfgUtils.GetSkinQuality(skinTid)
  do return ItemQualityCfgUtils.GetCfgField, "ItemQualityFrame" end
  return ItemQualityCfgUtils.GetCfgField, "ItemQualityFrame", quality
end

function AwakerSkinCfgUtils.GetSkinShopQualityImage(skinTid)
  local quality = AwakerSkinCfgUtils.GetSkinQuality(skinTid)
  do return ItemQualityCfgUtils.GetCfgField, "GiftBagQualityRes" end
  return ItemQualityCfgUtils.GetCfgField, "GiftBagQualityRes", quality
end

function AwakerSkinCfgUtils.GetSkinShopQualityBottomImage(skinTid)
  local quality = AwakerSkinCfgUtils.GetSkinQuality(skinTid)
  do return ItemQualityCfgUtils.GetCfgField, "ShopItemQualityRes" end
  return ItemQualityCfgUtils.GetCfgField, "ShopItemQualityRes", quality
end

function AwakerSkinCfgUtils.GetSkinItemQualityBottomImage(skinTid)
  local quality = AwakerSkinCfgUtils.GetSkinQuality(skinTid)
  do return ItemQualityCfgUtils.GetCfgField, "PaitingFrame" end
  return ItemQualityCfgUtils.GetCfgField, "PaitingFrame", quality
end

return AwakerSkinCfgUtils
