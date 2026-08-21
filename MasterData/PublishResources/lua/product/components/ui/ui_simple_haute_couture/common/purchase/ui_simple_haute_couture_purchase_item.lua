_class("UISimpleHauteCouturePurchaseItem", UICustomWidget)
UISimpleHauteCouturePurchaseItem = UISimpleHauteCouturePurchaseItem

function UISimpleHauteCouturePurchaseItem:Constructor()
end

function UISimpleHauteCouturePurchaseItem:OnShow(uiParams)
  self:_GetComponents()
end

function UISimpleHauteCouturePurchaseItem:_GetComponents()
  self._atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self.price = self:GetUIComponent("UILocalizationText", "price")
  self.giftName = self:GetUIComponent("UILocalizationText", "giftName")
  self.count = self:GetUIComponent("UILocalizationText", "count")
  self.time = self:GetUIComponent("UILocalizationText", "time")
  self.rootbg = self:GetUIComponent("RawImageLoader", "rootbg")
  self._imgPrice = self:GetUIComponent("Image", "imgPrice")
  self:GetComponents()
end

function UISimpleHauteCouturePurchaseItem:GetComponents()
end

function UISimpleHauteCouturePurchaseItem:InitComponents()
end

function UISimpleHauteCouturePurchaseItem:ClearTimer()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
    self._closed = true
  end
end

function UISimpleHauteCouturePurchaseItem:SetData(id, component, onClick, closeTime)
  self._id = id
  self._component = component
  self._onClick = onClick
  self._closeTime = closeTime
  local cfg = Cfg.cfg_component_buy_gift({GiftID = id})
  if not cfg or next(cfg) == nil then
    Log.exception("cfg_component_buy_gift中找不到礼包:", id)
  end
  cfg = cfg[1]
  self.giftName:SetText(StringTable.Get(cfg.Name[1]))
  self.rootbg:LoadImage(cfg.Icon)
  self.count:SetText(StringTable.Get(cfg.Name[2], cfg.ExtraAward[1][2]))
  local now = math.floor(self:GetModule(SvrTimeModule):GetServerTime() / 1000)
  local time = self._closeTime - now
  if time <= 0 then
    self.time:SetText(StringTable.Get("str_senior_skin_draw_gift_remain_time", HelperProxy:GetInstance():FormatTime_3(0)))
    self._closed = true
  else
    self._timeStr = HelperProxy:GetInstance():FormatTime_3(time)
    self.time:SetText(StringTable.Get("str_senior_skin_draw_gift_remain_time", self._timeStr))
    self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:SetTime()
    end)
    self._closed = false
  end
  self:InitComponents()
end

function UISimpleHauteCouturePurchaseItem:SetTime()
  if tolua.isnull(self.time) then
    return
  end
  local now = math.floor(self:GetModule(SvrTimeModule):GetServerTime() / 1000)
  local time = self._closeTime - now
  if time <= 0 then
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
      self._timer = nil
      self._closed = true
    end
  else
    local str = HelperProxy:GetInstance():FormatTime_3(time)
    if self._timeStr ~= str then
      self.time:SetText(StringTable.Get("str_senior_skin_draw_gift_remain_time", str))
      self._timeStr = str
    end
  end
end

function UISimpleHauteCouturePurchaseItem:GetID()
  return self._id
end

function UISimpleHauteCouturePurchaseItem:GetPriceIcon(id)
  local good = self._component:GetGoodCfgById(id)
  local saleType = good.SaleType
  return "toptoon_" .. saleType
end

function UISimpleHauteCouturePurchaseItem:RefreshPrice()
  local cfg = Cfg.cfg_shop_common_goods[self._id]
  local gift1ID = cfg.CurrencySkinID
  self._imgPrice.sprite = self._atlas:GetSprite(self:GetPriceIcon(gift1ID))
  local price1 = Cfg.cfg_shop_common_goods[gift1ID].NewPrice
  local price2 = self._component:GetGiftPriceForShowById(self._id)
  self.price:SetText(price1 .. "/" .. price2)
end

function UISimpleHauteCouturePurchaseItem:RootBgOnClick(go)
  if not self._closed and self._onClick then
    self._onClick(self._id)
  end
end
