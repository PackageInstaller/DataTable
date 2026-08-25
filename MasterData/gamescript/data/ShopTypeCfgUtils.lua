local ShopTypeCfgUtils = {}

function ShopTypeCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.ShopType[tid]
end

function ShopTypeCfgUtils.GetCfgField(field, cfgTid)
  local cfg = ShopTypeCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function ShopTypeCfgUtils.CheckShopTypeByTag(shopTypeTid, tagetShopTypeTag)
  local cfgTypeTag = ShopTypeCfgUtils.GetCfgField("TypeTag", shopTypeTid)
  return cfgTypeTag == tagetShopTypeTag
end

return ShopTypeCfgUtils
