local ShopCfgUtils = {}

function ShopCfgUtils.GetCfg(shopTid)
  if not shopTid then
    return nil
  end
  return DT.Shop[shopTid]
end

function ShopCfgUtils.GetCfgField(field, cfgTid)
  local cfg = ShopCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function ShopCfgUtils.GetShopSellingItemTid(shopTid)
  local cfgItem = ShopCfgUtils.GetCfgField("Item", shopTid)
  if not cfgItem then
    return nil
  end
  return 2 == #(cfgItem or {}) and cfgItem[1]
end

function ShopCfgUtils.IsClothShopType(shopTid)
  local cfgShopType = ShopCfgUtils.GetCfgField("ShopType", shopTid)
  if not cfgShopType then
    return false
  end
  do return ShopTypeCfgUtils.CheckShopTypeByTag, cfgShopType end
  return ShopTypeCfgUtils.CheckShopTypeByTag, cfgShopType, CommonDefine.MainShopTypeTag.ClothersShop
end

function ShopCfgUtils.IsLimitByMaxPotency(viewData)
  local isAwakerChip = ItemDataUtils.IsAwakerChip(viewData.shopItemData.itemList[1])
  local qualitySR = ItemDataUtils.GetItemConfig(viewData.shopItemData.itemList[1]).Quality == CommonDefine.CommonQuality.Purple
  local isMaxPotency = MainShopDataUtils.IsMaxPotencyByShopId(viewData.shopItemData.tid)
  return (isAwakerChip or not qualitySR) and isMaxPotency
end

function ShopCfgUtils.GetAllCfg()
  local rst = {}
  for tid, cfg in pairs(DT.Shop) do
    rst[tid] = cfg
  end
  return rst
end

local itemTid2ExhcangeShopCfgDict = {}

function ShopCfgUtils.GetExchangeShopCfg(targetItemTid)
  if not table.next(itemTid2ExhcangeShopCfgDict) then
    local shopTypeID = MainShopDataUtils.GetShopTypeIDByTag(CommonDefine.MainShopTypeTag.HiddenShop)
    for _, cfg in pairs(ShopCfgUtils.GetAllCfg()) do
      if cfg.ShopType ~= shopTypeID then
      else
        local itemTid = cfg.Item and cfg.Item[1]
        if not itemTid then
        else
          itemTid2ExhcangeShopCfgDict[itemTid] = cfg
        end
      end
    end
  end
  return itemTid2ExhcangeShopCfgDict[targetItemTid]
end

return ShopCfgUtils
