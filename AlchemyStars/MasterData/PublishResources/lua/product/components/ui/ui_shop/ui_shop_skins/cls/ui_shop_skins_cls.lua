_class("SkinsShopData", Object)
SkinsShopData = SkinsShopData
local SkinsShopTabEnum = {ALL = 1}
_enum("SkinsShopTabEnum", SkinsShopTabEnum)

function SkinsShopData:Constructor()
  self._goods = {}
  self._goodPriceList = {}
  self._mPay = GameGlobal.GetModule(PayModule)
end

function SkinsShopData:UpdateByServerData(marketInfo, cfgs, newList)
  if not marketInfo then
    Log.fatal("### marketInfo nil.")
    return
  end
  local mShop = GameGlobal.GetModule(ShopModule)
  local notShowLeftTime = mShop:GetClientShop():GetNotShowLeftTime()
  local goodPriceList = self._mPay:GetGoodPriceList()
  self._goods = {}
  local serGoods = marketInfo
  local productList = {}
  for i, good in HelperProxy:GetInstance():pairsByKeys(serGoods) do
    local id = good.goodid
    local cfgv = cfgs[id]
    local cfgClient = Cfg.cfg_shop_common_goods[id]
    if cfgv and cfgClient then
      local item = SkinsShopItem:New(id)
      local midasId = cfgv[ConfigKey.ConfigKey_MidasItemId]
      if cfgClient.Type == CommonShopType.CommonShopType_Skin and cfgClient.DirectAssetList and cfgClient.DirectAssetList[1] then
        local assetID = cfgClient.DirectAssetList[1][1]
        if assetID then
          local skinCfg = Cfg.cfg_pet_skin[assetID]
          if skinCfg then
            item:SetName(StringTable.Get(skinCfg.SkinName))
          end
        end
      end
      item:SetMidasId(midasId)
      item:SetEndTime(good.endtime)
      if notShowLeftTime < good.endtime then
        item:SetIsShowLeftTime(false)
      else
        item:SetIsShowLeftTime(true)
      end
      local saleType = good.saletype
      if saleType == SpecialNum.NeedPayMoney then
        item:SetType(SkinsPayType.Currency)
        item:SetPriceIcon(nil)
        item:SetPriceItemId(nil)
        local goodPrice = goodPriceList[midasId]
        if goodPrice then
          item._price = goodPrice.microprice / 1000000
          item:SetPriceWithCurrencySymbol(goodPrice.price)
        else
          table.insert(productList, midasId)
        end
      else
        local priceRawNotCash = tonumber(cfgv[ConfigKey.ConfigKey_RawPrice])
        local priceNotCash = tonumber(cfgv[ConfigKey.ConfigKey_NowPrice])
        if saleType == SpecialNum.FreeGiftSaleType then
          item:SetType(SkinsPayType.Free)
          item:SetPriceIcon(nil)
          item:SetPriceItemId(nil)
        else
          if saleType == RoleAssetID.RoleAssetDiamond then
            item:SetType(SkinsPayType.Yaojing)
          elseif saleType == RoleAssetID.RoleAssetGlow then
            item:SetType(SkinsPayType.Guangpo)
          else
            item:SetType(SkinsPayType.Item)
          end
          item:SetPriceIcon("toptoon_" .. saleType)
          item:SetPriceItemId(saleType)
        end
        item._priceRaw = priceRawNotCash
        item._price = priceNotCash
      end
      local isSeniorSkin = cfgClient.Type == CommonShopType.CommonShopType_SeniorSkin
      item:SetSeniorSkinStatus(isSeniorSkin)
      if isSeniorSkin then
        item:SetSeniorSkinReviewStatus(cfgClient.Subtype == 1)
      end
      item._discount = tonumber(cfgv[ConfigKey.ConfigKey_Discount])
      item:SetSkinId(good.skin_id)
      table.insert(self._goods, item)
    else
      Log.fatal("### no goods in cfgs. id = ", id)
    end
  end
  if productList and table.count(productList) > 0 then
    GameGlobal.GetModule(ShopModule):GetLocalPrice()
  end
  if newList and table.count(newList) > 0 then
    for _, newItem in ipairs(newList) do
      for _, good in ipairs(self._goods) do
        if newItem == good:GetId() then
          good:SetNew(true)
        end
      end
    end
  end
end

function SkinsShopData:UpdateGoodsPrice()
  local goodPriceList = self._mPay:GetGoodPriceList()
  if goodPriceList and table.count(goodPriceList) > 0 then
    for i, item in ipairs(self._goods) do
      local midasId = item:GetMidasId()
      if not string.isnullorempty(midasId) and goodPriceList[midasId] then
        local goodPrice = goodPriceList[midasId]
        item:SetPriceWithCurrencySymbol(goodPrice.price)
      end
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateSkinsItemPrice)
  else
    Log.fatal("### [Pay][Skins]no data in goodPriceList.")
  end
end

function SkinsShopData:GetGoods()
  return self._goods
end

function SkinsShopData:GetGoodById(id)
  for index, good in ipairs(self._goods) do
    if good:GetId() == id then
      return good
    end
  end
end

function SkinsShopData:IsEmpty()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  for index, good in ipairs(self._goods) do
    local endTime = good:GetEndTime()
    if 0 < endTime and curTime > endTime then
    else
      return false
    end
  end
  return true
end

function SkinsShopData:GetNew()
  for index, good in ipairs(self._goods) do
    if good:GetNew() then
      return true
    end
  end
  return false
end

_class("SkinsShopItem", ShopPriceItem)
SkinsShopItem = SkinsShopItem

function SkinsShopItem:Constructor(id)
  SkinsShopItem.super.Constructor(self, id)
  self._currencyGoodsType = MidasCurrencyGoodsType.MIDAS_CURRENCY_GOODS_TYPE_SKIN
  self._goodsId = id
  self._skinId = 0
  self._type = SkinsPayType.Currency
  self._midasId = ""
  self._name = ""
  self._endTime = 0
  self._costPriceItemId = 0
  self._costPrice = 0
  self._convertType = 0
  self._icon = ""
  self._iconDetail = ""
  self._buyCount = 0
  self._maxBuyCount = 0
  self._isShowLeftTime = true
  self._petModule = GameGlobal.GetModule(PetModule)
  self._new = false
  self._binderSkinItemByRMB = nil
  self._isSeniorSkin = false
end

function SkinsShopItem:SetName(name)
  self._name = name
end

function SkinsShopItem:SetBinderSkin(item)
  self._binderSkinItemByRMB = item
end

function SkinsShopItem:GetBinderSkin()
  return self._binderSkinItemByRMB
end

function SkinsShopItem:GetCurrencyGoodsType()
  return self._currencyGoodsType
end

function SkinsShopItem:GetId()
  return self._goodsId
end

function SkinsShopItem:GetSkinId()
  return self._skinId
end

function SkinsShopItem:SetSkinId(skinId)
  self._skinId = skinId
end

function SkinsShopItem:GetType()
  return self._type
end

function SkinsShopItem:SetType(ptype)
  self._type = ptype
end

function SkinsShopItem:GetMidasId()
  return self._midasId
end

function SkinsShopItem:SetMidasId(midasId)
  self._midasId = midasId
  Log.debug("midasId : ", self._midasId)
end

function SkinsShopItem:GetBuyCount()
  return 1
end

function SkinsShopItem:GetIsShowLeftTime()
  return self._isShowLeftTime
end

function SkinsShopItem:SetIsShowLeftTime(isShowLeftTime)
  self._isShowLeftTime = isShowLeftTime
end

function SkinsShopItem:GetEndTime()
  return self._endTime
end

function SkinsShopItem:SetEndTime(endTime)
  self._endTime = endTime
end

function SkinsShopItem:GetLeftSeconds()
  local mSvrTime = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = mSvrTime:GetServerTime() / 1000
  local endTime = self:GetEndTime()
  local leftSeconds = endTime - nowTime
  return leftSeconds
end

function SkinsShopItem:GetRemainTimeStr()
  local str = ""
  local leftSeconds = self:GetLeftSeconds()
  local cycleType = self:GetCycleType()
  if leftSeconds <= 0 then
    str = StringTable.Get("str_pay_expired")
  elseif leftSeconds <= 60 then
    str = StringTable.Get("str_pay_left_minute", 1)
  elseif leftSeconds <= 3600 then
    local leftMinutes = math.ceil(leftSeconds / 60)
    str = StringTable.Get("str_pay_left_minute", leftMinutes)
  elseif leftSeconds <= 86400 then
    local leftHours = math.ceil(leftSeconds / 3600)
    str = StringTable.Get("str_pay_left_hour", leftHours)
  else
    local leftDays = math.ceil(leftSeconds / 86400)
    str = StringTable.Get("str_pay_left_day", leftDays)
  end
  return str
end

function SkinsShopItem:GetPriceIcon()
  return self._priceIcon
end

function SkinsShopItem:SetPriceIcon(priceIcon)
  self._priceIcon = priceIcon
end

function SkinsShopItem:GetPriceItemId()
  return self._priceItemId
end

function SkinsShopItem:SetPriceItemId(priceItemId)
  self._priceItemId = priceItemId
end

function SkinsShopItem:GetPrice()
  return self._price
end

function SkinsShopItem:SetPrice(price)
  self._price = price
end

function SkinsShopItem:SetCostPrice(price)
  self._costPrice = price
end

function SkinsShopItem:GetCostPriceItemId()
  return self._costPriceItemId
end

function SkinsShopItem:SetCostPriceItemId(priceItemId)
  self._costPriceItemId = priceItemId
end

function SkinsShopItem:GetCostPrice()
  return self._costPrice
end

function SkinsShopItem:GetCostPrice()
  return self._costPrice
end

function SkinsShopItem:GetCostPrice()
  return self._costPrice
end

function SkinsShopItem:GetConvertType()
  return self._convertType
end

function SkinsShopItem:SetConvertType(ptype)
  self._convertType = ptype
end

function SkinsShopItem:GetPriceWithCurrencySymbol()
  return self._priceWithCurrencySymbol
end

function SkinsShopItem:SetPriceWithCurrencySymbol(priceWithCurrencySymbol)
  priceWithCurrencySymbol = RechargeShopItem.RemoveDot00(priceWithCurrencySymbol)
  self._priceWithCurrencySymbol = priceWithCurrencySymbol
end

function SkinsShopItem:HasSoldOut()
  return self._petModule:HaveSkin(self._skinId)
end

function SkinsShopItem:GetNew()
  return self._new
end

function SkinsShopItem:SetNew(new)
  self._new = new
end

SkinsPayType = {
  Currency = 0,
  Yaojing = 1,
  Guangpo = 2,
  Item = 3,
  Free = 4,
  ConvertCost = 5
}
SkinsConvertPayType = {BattlePass = 0}
_enum("SkinsConvertPayType", SkinsConvertPayType)

function SkinsShopItem:SetSeniorSkinStatus(status)
  self._isSeniorSkin = status
end

function SkinsShopItem:IsSeniorSkin()
  return self._isSeniorSkin
end

function SkinsShopItem:IsResident()
  local goodsId = self:GetId()
  local cfgClient = Cfg.cfg_shop_common_goods[goodsId]
  if cfgClient ~= nil and cfgClient.IsResident then
    return true
  else
    return false
  end
end

function SkinsShopItem:SetSeniorSkinReviewStatus(status)
  self._isSeniorSkinReview = status
end

function SkinsShopItem:IsSeniorSkinReview()
  return self._isSeniorSkinReview
end

function SkinsShopItem:IsResident()
  local goodsId = self:GetId()
  local cfgClient = Cfg.cfg_shop_common_goods[goodsId]
  if cfgClient ~= nil and cfgClient.IsResident then
    return true
  else
    return false
  end
end

function SkinsShopItem:GetTabID()
  local goodsId = self:GetId()
  local cfgClient = Cfg.cfg_shop_common_goods[goodsId]
  local tabID = SkinsShopTabEnum.ALL
  if cfgClient ~= nil then
    tabID = cfgClient.TabID
  end
  if tabID == nil then
    tabID = SkinsShopTabEnum.ALL
  end
  return tabID
end

_class("SkinsShopItemContainer", Object)
SkinsShopItemContainer = SkinsShopItemContainer

function SkinsShopItemContainer:Constructor()
  self.itemSkin = nil
  self.itemGift = nil
end
