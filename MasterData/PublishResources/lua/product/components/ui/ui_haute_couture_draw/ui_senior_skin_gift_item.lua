_class("UISeniorSkinGiftItem", UICustomWidget)
UISeniorSkinGiftItem = UISeniorSkinGiftItem

function UISeniorSkinGiftItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeniorSkinGiftItem:InitWidget()
  self.giftName = self:GetUIComponent("UILocalizationText", "giftName")
  self.price = self:GetUIComponent("UILocalizationText", "price")
  self._count = self:GetUIComponent("UILocalizationText", "count")
  self._time = self:GetUIComponent("UILocalizationText", "time")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
end

function UISeniorSkinGiftItem:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
    self._closed = true
  end
end

function UISeniorSkinGiftItem:SetData(id, onClick, closeTime)
  self._id = id
  self._onClick = onClick
  self._closeTime = closeTime
  local cfg = Cfg.cfg_component_buy_gift({GiftID = id})
  if not cfg or next(cfg) == nil then
    Log.exception("cfg_component_buy_gift中找不到礼包:", id)
  end
  cfg = cfg[1]
  self.giftName:SetText(StringTable.Get(cfg.Name[1]))
  self._icon:LoadImage(cfg.Icon)
  self._count:SetText(StringTable.Get("str_senior_skin_draw_gift_count", cfg.ExtraAward[1][2]))
  local now = math.floor(self:GetModule(SvrTimeModule):GetServerTime() / 1000)
  local time = self._closeTime - now
  if time <= 0 then
    self._time:SetText(StringTable.Get("str_senior_skin_draw_gift_remain_time", HelperProxy:GetInstance():FormatTime_3(0)))
    self._closed = true
  else
    self._timeStr = HelperProxy:GetInstance():FormatTime_3(time)
    self._time:SetText(StringTable.Get("str_senior_skin_draw_gift_remain_time", self._timeStr))
    self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:setTime()
    end)
    self._closed = false
  end
end

function UISeniorSkinGiftItem:GetID()
  return self._id
end

function UISeniorSkinGiftItem:SetPrice(price)
  self.price:SetText(price)
end

function UISeniorSkinGiftItem:itemOnClick(go)
  if not self._closed then
    self._onClick(self._id)
  end
end

function UISeniorSkinGiftItem:setTime()
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
      self._time:SetText(StringTable.Get("str_senior_skin_draw_gift_remain_time", str))
      self._timeStr = str
    end
  end
end
