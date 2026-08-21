_class("UIActivityPayData", Object)
UIActivityPayData = UIActivityPayData

function UIActivityPayData:Constructor()
  self._goods = {}
  self._goodPriceList = {}
  self._mPay = GameGlobal.GetModule(PayModule)
end

function UIActivityPayData:UpdateGoodsPrice()
  local goodPriceList = self._mPay:GetGoodPriceList()
  if goodPriceList and table.count(goodPriceList) > 0 then
    for i, item in ipairs(self._goods) do
      local midasId = item:GetMidasId()
      if not string.isnullorempty(midasId) and goodPriceList[midasId] then
        local goodPrice = goodPriceList[midasId]
        item:SetPrice(goodPrice.microprice / 1000000)
        item:SetPriceWithCurrencySymbol(goodPrice.price)
      end
    end
  else
    Log.fatal("### UIActivityPayData:UpdateGoodsPrice() no data in goodPriceList.")
  end
end

function UIActivityPayData:GetGoods()
  return self._goods
end

function UIActivityPayData:GetGoodById(id)
  for index, good in ipairs(self._goods) do
    if good:GetId() == id then
      return good
    end
  end
end

function UIActivityPayData:IsEmpty()
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

_class("UIActivityPayItem", Object)
UIActivityPayItem = UIActivityPayItem

function UIActivityPayItem:Constructor(id)
  self._currencyGoodsType = MidasCurrencyGoodsType.MIDAS_CURRENCY_GOODS_TYPE_CAMPAIGN
  self._goodsId = id
  self._skinId = 0
  self._type = SkinsPayType.Currency
  self._midasId = ""
  self._name = ""
  self._endTime = 0
  self._priceIcon = ""
  self._priceItemId = 0
  self._price = 0
  self._priceWithCurrencySymbol = ""
  self._icon = ""
  self._iconDetail = ""
  self._buyCount = 0
  self._maxBuyCount = 0
  self._isShowLeftTime = true
  self._petModule = GameGlobal.GetModule(PetModule)
end

function UIActivityPayItem:GetCurrencyGoodsType()
  return self._currencyGoodsType
end

function UIActivityPayItem:GetId()
  return self._goodsId
end

function UIActivityPayItem:GetMidasId()
  return self._midasId
end

function UIActivityPayItem:SetMidasId(midasId)
  self._midasId = midasId
  Log.debug("midasId : ", self._midasId)
end

function UIActivityPayItem:GetBuyCount()
  return 1
end

function UIActivityPayItem:GetSkinId()
  return self._skinId
end

function UIActivityPayItem:SetSkinId(skinId)
  self._skinId = skinId
end

function UIActivityPayItem:GetType()
  return self._type
end

function UIActivityPayItem:SetType(ptype)
  self._type = ptype
end

function UIActivityPayItem:GetIsShowLeftTime()
  return self._isShowLeftTime
end

function UIActivityPayItem:SetIsShowLeftTime(isShowLeftTime)
  self._isShowLeftTime = isShowLeftTime
end

function UIActivityPayItem:GetEndTime()
  return self._endTime
end

function UIActivityPayItem:SetEndTime(endTime)
  self._endTime = endTime
end

function UIActivityPayItem:GetLeftSeconds()
  local mSvrTime = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = mSvrTime:GetServerTime() / 1000
  local endTime = self:GetEndTime()
  local leftSeconds = endTime - nowTime
  return leftSeconds
end

function UIActivityPayItem:GetRemainTimeStr()
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

function UIActivityPayItem:GetPriceIcon()
  return self._priceIcon
end

function UIActivityPayItem:SetPriceIcon(priceIcon)
  self._priceIcon = priceIcon
end

function UIActivityPayItem:GetPriceItemId()
  return self._priceItemId
end

function UIActivityPayItem:SetPriceItemId(priceItemId)
  self._priceItemId = priceItemId
end

function UIActivityPayItem:GetPrice()
  return self._price
end

function UIActivityPayItem:SetPrice(price)
  self._price = price
end

function UIActivityPayItem:GetPriceWithCurrencySymbol()
  return self._priceWithCurrencySymbol
end

function UIActivityPayItem:SetPriceWithCurrencySymbol(priceWithCurrencySymbol)
  priceWithCurrencySymbol = RechargeShopItem.RemoveDot00(priceWithCurrencySymbol)
  self._priceWithCurrencySymbol = priceWithCurrencySymbol
end

function UIActivityPayItem:SetName(name)
  self._name = name
end

function UIActivityPayItem:HasSoldOut()
  return self._petModule:HaveSkin(self._skinId)
end
