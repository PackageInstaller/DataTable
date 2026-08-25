local ShopTypeDataUtils = {}

function ShopTypeDataUtils.GetCfg(shopTypeId)
  if not shopTypeId then
    return nil
  end
  return DT.ShopType[shopTypeId]
end

function ShopTypeDataUtils.GetCfgByField(field, shopTypeId)
  if not field or not shopTypeId then
    return nil
  end
  local cfg = ShopTypeDataUtils.GetCfg(shopTypeId)
  if not cfg then
    return nil
  end
  return cfg[field]
end

return ShopTypeDataUtils
