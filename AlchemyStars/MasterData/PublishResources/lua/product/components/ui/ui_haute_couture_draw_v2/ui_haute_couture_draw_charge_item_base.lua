_class("UIHauteCoutureDrawChargeItemBase", UICustomWidget)
UIHauteCoutureDrawChargeItemBase = UIHauteCoutureDrawChargeItemBase

function UIHauteCoutureDrawChargeItemBase:InitWidgetsBase()
  self.price = self:GetUIComponent("UILocalizationText", "price")
  self.giftName = self:GetUIComponent("UILocalizationText", "giftName")
  self.count = self:GetUIComponent("UILocalizationText", "count")
  self.time = self:GetUIComponent("UILocalizationText", "time")
  self.rootbg = self:GetUIComponent("RawImageLoader", "rootbg")
end

function UIHauteCoutureDrawChargeItemBase:ClearTimer()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
    self._closed = true
  end
end

function UIHauteCoutureDrawChargeItemBase:GetCountStrKey()
  return "str_senior_skin_draw_gift_count"
end

function UIHauteCoutureDrawChargeItemBase:SetData(id, onClick, closeTime)
  self._id = id
  self._onClick = onClick
  self._closeTime = closeTime
  local cfg = Cfg.cfg_component_buy_gift({GiftID = id})
  if not cfg or next(cfg) == nil then
    Log.exception("cfg_component_buy_gift中找不到礼包:", id)
  end
  cfg = cfg[1]
  self.giftName:SetText(StringTable.Get(cfg.Name[1]))
  self.rootbg:LoadImage(cfg.Icon)
  local countStrKey = self:GetCountStrKey()
  self.count:SetText(StringTable.Get(countStrKey, cfg.ExtraAward[1][2]))
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
end

function UIHauteCoutureDrawChargeItemBase:SetTime()
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

function UIHauteCoutureDrawChargeItemBase:GetID()
  return self._id
end

function UIHauteCoutureDrawChargeItemBase:SetPrice(price)
  self.price:SetText(price)
end

function UIHauteCoutureDrawChargeItemBase:RootBgOnClick(go)
  if not self._closed and self._onClick then
    self._onClick(self._id)
  end
end
