local MAX_RELIC_NUM = DT.GetConstant("RelicMaximumNumber")
local ShopDataUtils = {}

function ShopDataUtils.ResetAll()
  DataCenter.shopData = Vue.reactive({})
end

function ShopDataUtils.ResetShop(shopUid)
  local shopData = DataCenter.shopData[shopUid]
  if shopData then
    shopData.ShopArray = {}
    shopData.SaleCardCount = 0
    shopData.RelieveCardCount = 0
    shopData.SaleCardPrice = 0
    shopData.RelieveCardPrice = 0
    shopData.refreshCount = 0
    shopData.refreshPrice = 50
  end
end

function ShopDataUtils.OnShopData(data)
  local shopUid = data.gearUid
  ShopDataUtils.ResetShop(shopUid)
  local shopData = {
    data.Relic,
    data.SaleCard,
    data.RelieveAbCard,
    data.Enchant,
    data.Item
  }
  local copyShopData = DataCenter.shopData[shopUid] or {}
  DataCenter.shopData[shopUid] = copyShopData
  copyShopData.SaleCardCount = data.SaleCard and data.SaleCard.count or 0
  copyShopData.RelieveCardCount = data.RelieveAbCard and data.RelieveAbCard.count or 0
  copyShopData.SaleCardPrice = data.SaleCard and data.SaleCard.price or 0
  copyShopData.RelieveCardPrice = data.RelieveAbCard and data.RelieveAbCard.price or 0
  copyShopData.refreshCount = data.refreshNum
  copyShopData.maxRefreshCount = data.maxRefreshNum
  copyShopData.refreshPrice = data.refreshCost
  copyShopData.customCmdUseTimes = data.customCmdUseTimes
  copyShopData.enhanceRelicExtraCost = data.enhanceRelicExtraCost or 0
  copyShopData.customCmdArgs = data.customCmdArgs
  copyShopData.ShopArray = {}
  for _, goodData in pairs(shopData) do
    for _, value in ipairs(goodData.goods) do
      ShopDataUtils.AddShopItem(shopUid, value.uid, value.tid, goodData.type, value.price, value.use, value.count, value.notSale, value.basePrice)
    end
  end
end

function ShopDataUtils.GetShopData(shopUid)
  return DataCenter.shopData[shopUid]
end

function ShopDataUtils.AddShopItem(shopUid, uid, tid, type, price, use, count, notSale, basePrice)
  local info = {}
  info.uid = uid
  info.tid = tid
  info.type = type
  info.price = price
  info.use = use
  info.count = count
  info.notSale = notSale
  info.basePrice = basePrice
  local shopData = DataCenter.shopData[shopUid]
  if shopData and shopData.ShopArray then
    table.insert(shopData.ShopArray, info)
  end
  for _, tmpShopData in pairs(DataCenter.shopData) do
    for k, value in ipairs(tmpShopData and tmpShopData.ShopArray or {}) do
      if value.uid == uid then
        tmpShopData.ShopArray[k] = info
        break
      end
    end
  end
end

function ShopDataUtils.SetSellOut(uid, sell)
  for _, shopData in pairs(DataCenter.shopData) do
    for _, value in ipairs(shopData and shopData.ShopArray or {}) do
      if value.uid == uid then
        value.sell = sell
        break
      end
    end
  end
end

function ShopDataUtils.GetShopItem(uid, shopUid)
  for _, shopData in pairs(DataCenter.shopData) do
    for _, value in ipairs(shopData and shopData.ShopArray or {}) do
      if value.uid == uid then
        return value
      end
    end
  end
end

function ShopDataUtils.GetShopItemCfg(shopItemTid)
  return DT.Shop[shopItemTid]
end

function ShopDataUtils.GetShopItemPrice(shopItemTid)
  local shopItemCfg = DT.Shop[shopItemTid or 0]
  if not shopItemCfg or not shopItemCfg.Price then
    return
  end
  local priceItem, price = table.unpack(shopItemCfg.Price)
  return price, priceItem
end

function ShopDataUtils.SetRefreshCount(count)
  DataCenter.shopData.refreshCount = count
end

function ShopDataUtils.GetRefreshCount()
  return DataCenter.shopData.refreshCount
end

function ShopDataUtils.SetRefreshCost(cost)
  DataCenter.shopData.refreshPirce = cost
end

function ShopDataUtils.GetRefreshCost()
  return DataCenter.shopData.refreshPirce
end

function ShopDataUtils.BuyShopItem(uid, callback, shopType)
  local item = ShopDataUtils.GetShopItem(uid)
  if item.type ~= CommonDefine.WorldStageShopItemType.Relic or #RelicDataUtils.GetAllRelicDatas() < MAX_RELIC_NUM then
    item.use = item.use + 1
  end
  EventMgr.Instance.OpenReqMask:Dispatch()
  local param = {
    [1] = {itemType = shopType, itemUid = uid}
  }
  ProtoManager.Instance:ReqServer("WorldRequest", "OnGearHandle", function(data)
    if data then
      ShopDataUtils.OnShopData(data)
    end
    if callback then
      callback(data)
    end
    EventMgr.Instance.OnWorldStageShopPurchased:Dispatch()
  end, nil, uid, param)
end

function ShopDataUtils.OpenRuneCardSelectPanel(runeTid, enchantCb)
  local runeCfg = DT.EnchantConfig[runeTid]
  local showCards = CardDataUtils.GetCanInlayRuneCards()
  if 0 == #showCards then
    showCards = CardDataUtils.GetInlayedRuneCards()
  end
  showCards = CardDataUtils.SortCardsByActorOrder(showCards)
  local cardCount = #(showCards or {})
  if 0 == cardCount then
    return
  end
  local langInfo = {
    title = LT.Textf("RuneGain_Title", runeCfg.Name),
    confirm = LT.Text("RuneGain_Btn"),
    cancel = LT.Text("Common_Button_Cancel"),
    costItemId = runeTid,
    cost = nil,
    forbidClose = true,
    notAutoClose = true,
    closeCallback = function()
    end
  }
  
  local function confirmCallback(uid)
    EventMgr.Instance.OpenReqMask:Dispatch()
    
    local function EnchantReqFunc(newEnchantTid)
      local function IsUpgrade()
        return newEnchantTid and newEnchantTid ~= runeTid
      end
      
      ProtoManager.Instance:ReqServer("WorldRequest", "PutRune", function(data)
        Alert.Show(10396)
        EventMgr.Instance.PutOnRune:Dispatch(true)
        if CopiesDataUtils.HasInitRuneTid() then
          CopiesDataUtils.SetInitRuneTid(0)
        end
        if IsUpgrade() then
          local cardData = CardDataUtils.GetCardInfo(uid)
          cardData.runes[1] = runeTid
          local panelData = {
            cardUid = uid,
            cardTid = cardData.configId
          }
          UIManager.Instance:Reopen(Urls.CardFeatureInfoPanel, panelData)
          FrameWaiter.OnNextFrame(function()
            cardData.runes[1] = newEnchantTid
            local newPanelData = {
              cardUid = uid,
              cardTid = cardData.configId
            }
            local cardFeatureInfoPanel = UIManager.Instance:Reopen(Urls.CardFeatureInfoPanel, newPanelData)
            cardFeatureInfoPanel:ShowEffect()
          end, 1)
        end
      end, function()
        EventMgr.Instance.PutOnRune:Dispatch(false)
        if CopiesDataUtils.HasInitRuneTid() then
          CopiesDataUtils.SetInitRuneTid(0)
        end
      end, uid, newEnchantTid or runeTid)
    end
    
    if enchantCb then
      enchantCb(EnchantReqFunc)
    else
      EnchantReqFunc()
    end
  end
  
  UIManager.Instance:Reopen(Urls.WorldStageShopCardPanel, showCards, langInfo, confirmCallback, runeTid)
end

function ShopDataUtils.UpdateShopDataRed(data)
  DataCenter.shopData.shopUpdateData = data
end

function ShopDataUtils.GetShopUpdateData()
  return DataCenter.shopData.shopUpdateData
end

function ShopDataUtils.CheckGoodsSoldOut(uid)
  local item = ShopDataUtils.GetShopItem(uid)
  if item and item.use and item.use >= 1 then
    return true
  end
  return false
end

function ShopDataUtils.GetChargeConfig()
  return DT.Charge
end

function ShopDataUtils.GetChargeCfgById(chargeId)
  return DT.Charge[chargeId]
end

function ShopDataUtils.GetChargeCfgByChargeGroup(chargeGroup)
  local chargeId = ShopDataUtils.GetChargeIdByChargeGroup(chargeGroup, true)
  return chargeId and ShopDataUtils.GetChargeCfgById(chargeId)
end

function ShopDataUtils.GetChargeIdByChargeGroup(chargeGroup, isAlert)
  local chargeConfig = ShopDataUtils.GetChargeConfig()
  local chargeChannel = SdkMgr.Instance:GetChargeChannel()
  for chargeId, chargeCfg in pairs(chargeConfig) do
    if chargeCfg.Group == chargeGroup and chargeCfg.Channel == chargeChannel then
      return chargeId
    end
  end
  if isAlert then
    Logger.Error(string.format("找不到充值组对应的充值项: chargeGroup:%s, chargeChannel:%s", chargeGroup, chargeChannel))
  else
    Logger.Warn("[ShopDataUtils] 找不到充值组对应的充值项: chargeGroup:%s, chargeChannel:%s", chargeGroup, chargeChannel)
  end
end

function ShopDataUtils.GetChargePriceStr(chargeId)
  local chargeCfg = ShopDataUtils.GetChargeCfgById(chargeId)
  local showCountryCode = SdkMgr.Instance.model.countryCode
  if SdkMgr.Instance:CheckIsGWPackage() or showCountryCode == CommonDefine.CountryCode.CN then
    showCountryCode = CommonDefine.CountryCode.US
  end
  local symbol = chargeCfg.RegionPriceSymbol[showCountryCode] or ""
  local price = tostring(chargeCfg.RegionPrice[showCountryCode]) or ""
  do return string.format, "%s %s", symbol end
  return string.format, "%s %s", symbol, price
end

function ShopDataUtils.indexOf(t, v)
  for i = 1, #(t or {}) do
    if t[i] == v then
      return i
    end
  end
end

ShopDataUtils.initMainAnim = false
return ShopDataUtils
