local WorldStageShopUtils = {}

function WorldStageShopUtils.OnClickRelicGoods(uid)
  local shopItem = ShopDataUtils.GetShopItem(uid)
  if not shopItem then
    Logger.Error("ui == " .. uid)
    return
  end
  local cost = math.modf(shopItem.price)
  DataCenter.relicData.RelicDetailDarkMode = true
  RelicDataUtils.ShowGainRelicDetailPanel({
    uid = shopItem.uid,
    relicTid = shopItem.tid,
    itemType = shopItem.type
  }, nil, function(callBack)
    local gold = WorldstageDMoneyDataUtils.GetGold()
    if nil == gold or gold < math.abs(cost) then
      Alert.Show(10222)
      return
    end
    ShopDataUtils.BuyShopItem(shopItem.uid, callBack, CommonDefine.WorldStageShopItemType.Relic)
  end)
end

function WorldStageShopUtils.OnClickEnchantGoods(uid)
  local shopItem = ShopDataUtils.GetShopItem(uid)
  if not shopItem then
    Logger.Error("ui == " .. uid)
    return
  end
  local cost = math.modf(ShopDataUtils.GetShopItem(uid).price)
  DataCenter.relicData.RelicDetailDarkMode = true
  RelicDataUtils.ShowGainRelicDetailPanel({
    uid = shopItem.uid,
    relicTid = shopItem.tid,
    itemType = shopItem.type
  }, nil, function()
    local gold = WorldstageDMoneyDataUtils.GetGold()
    if nil == gold or gold < math.abs(cost) then
      Alert.Show(10222)
      return
    end
    DataCenter.copiesData.ShowRuneGainTipPanel = false
    
    local function enchantCb(callBack)
      ShopDataUtils.BuyShopItem(shopItem.uid, function(shopHandleData)
        DataCenter.copiesData.ShowRuneGainTipPanel = true
        if callBack then
          callBack(shopHandleData.newEnchantTid)
        end
      end, CommonDefine.WorldStageShopItemType.Enchant)
    end
    
    ShopDataUtils.OpenRuneCardSelectPanel(shopItem.tid, enchantCb)
  end, nil, function(component)
    local haveMoney = WorldstageDMoneyDataUtils.GetGold() or 0
    local icon = 100 == DataCenter.itemData.Coin and DT.GetOriginalConstant("PhiloStone")[2] or DT.Item[DataCenter.itemData.Coin].SmallIcon
    component:SetPrice(cost, haveMoney, icon)
  end)
end

return WorldStageShopUtils
