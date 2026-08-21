_class("UITacticTapeProduceSpeedup", UIController)
UITacticTapeProduceSpeedup = UITacticTapeProduceSpeedup

function UITacticTapeProduceSpeedup:OnShow(uiParams)
  self:InitWidget()
  self._airModule = self:GetModule(AircraftModule)
  self._tacticRoom = self._airModule:GetRoomByRoomType(AirRoomType.TacticRoom)
  self._timeModule = self:GetModule(SvrTimeModule)
  self._min, self._max, self._cur = 0, 0, 1
  self._rate = Cfg.cfg_aircraft_values[5].IntValue
  self._topTips = self.currencymenu:SpawnObject("UICurrencyMenu")
  self._topTips:SetData({
    RoleAssetID.RoleAssetFirefly
  })
  local firefly = self._topTips:GetItemByTypeId(RoleAssetID.RoleAssetFirefly)
  firefly:CloseAddBtn()
  self._timerHolder = UITimerHolder:New()
  self._available = true
  self:OnFireflyChanged()
  self._timerHolder:StartTimerInfinite("Countdown", 1000, function()
    self:onValueChanged()
  end)
  self._btnAdd = UITouchButton:New(self.addBtn, function()
    self._cur = self._cur + 1
    self:refreshPanel()
  end)
  self._btnDec = UITouchButton:New(self.decBtn, function()
    self._cur = self._cur - 1
    self:onValueChanged()
  end)
  self:AttachEvent(GameEventType.AircraftTacticOnTapeChanged, self.onTapeChanged)
  self:AttachEvent(GameEventType.AircraftOnFireFlyChanged, self.OnFireflyChanged)
end

function UITacticTapeProduceSpeedup:OnHide()
  self._timerHolder:Dispose()
  self._btnAdd:Dispose()
  self._btnDec:Dispose()
end

function UITacticTapeProduceSpeedup:InitWidget()
  self.value = self:GetUIComponent("UILocalizationText", "value")
  self.before = self:GetUIComponent("UILocalizationText", "before")
  self.after = self:GetUIComponent("UILocalizationText", "after")
  self.exchange = self:GetUIComponent("UILocalizationText", "exchange")
  self.currencymenu = self:GetUIComponent("UISelectObjectPath", "currencymenu")
  self.addBtn = self:GetUIComponent("UIEventTriggerListener", "increase")
  self.decBtn = self:GetUIComponent("UIEventTriggerListener", "decrease")
end

function UITacticTapeProduceSpeedup:onValueChanged()
  if not self._available then
    self._max = 0
    self._min = 0
    self:refreshPanel()
    return
  end
  local firefly = self._airModule:GetFirefly()
  local tapeCount = #self._tacticRoom:GetCartridgeList() + self._tacticRoom:GetCartridgeGiftCount()
  local tapeCeiling = self._tacticRoom:GetCartridgeLimit()
  if tapeCeiling - tapeCount <= 0 or firefly <= 0 then
    self._max = 0
    self._min = 0
    self._timerHolder:StopTimer("Countdown")
    self:refreshPanel()
    return
  end
  local count = tapeCeiling - tapeCount
  local now = math.floor(self._timeModule:GetServerTime() / 1000)
  local delta = self._tacticRoom:GetCartridgeCountDown() - now
  local needMaxFirefly = math.ceil(delta / self._rate)
  self._max = math.min(firefly, needMaxFirefly)
  if self._max <= 0 then
    self._max = 0
    self._min = 0
    self._timerHolder:StopTimer("Countdown")
    self:refreshPanel()
    return
  end
  self._min = 1
  self:refreshPanel()
end

function UITacticTapeProduceSpeedup:onTapeChanged()
  self:DetachEvent(GameEventType.AircraftTacticOnTapeChanged, self.onTapeChanged)
  self._available = false
  self:onValueChanged()
  self._timerHolder:Dispose()
end

function UITacticTapeProduceSpeedup:refreshPanel()
  if self._available then
    self._cur = Mathf.Clamp(self._cur, self._min, self._max)
    local now = math.floor(self._timeModule:GetServerTime() / 1000)
    local delta = self._tacticRoom:GetCartridgeCountDown() - now
    local exchange = self._cur * self._rate
    self.value:SetText(self._cur)
    self.before:SetText(HelperProxy:GetInstance():FormatTime_2(delta))
    self.exchange:SetText(HelperProxy:GetInstance():FormatTime_2(exchange))
    self.after:SetText(HelperProxy:GetInstance():FormatTime_2(delta - exchange))
  else
    self._cur = 0
    self.value:SetText(self._cur)
    self.before:SetText(HelperProxy:GetInstance():FormatTime_2(0))
    self.exchange:SetText(HelperProxy:GetInstance():FormatTime_2(0))
    self.after:SetText(HelperProxy:GetInstance():FormatTime_2(0))
  end
end

function UITacticTapeProduceSpeedup:OnFireflyChanged()
  local firefly = self._topTips:GetItemByTypeId(RoleAssetID.RoleAssetFirefly)
  firefly:SetText(self._airModule:GetFirefly() .. "/" .. math.floor(self._airModule:GetMaxFirefly()))
  self:onValueChanged()
end

function UITacticTapeProduceSpeedup:minOnClick(go)
  self._cur = self._min
  self:refreshPanel()
end

function UITacticTapeProduceSpeedup:maxOnClick(go)
  self._cur = self._max
  self:refreshPanel()
end

function UITacticTapeProduceSpeedup:cancelBtnOnClick(go)
  self:CloseDialog()
end

function UITacticTapeProduceSpeedup:okBtnOnClick(go)
  if not self._available then
    ToastManager.ShowToast(StringTable.Get("str_aircraft_tactic_tape_is_made_success"))
    self:CloseDialog()
    return
  end
  if self._cur <= 0 then
    if 0 >= self._airModule:GetFirefly() then
      ToastManager.ShowToast(StringTable.Get("str_aircraft_firefly_not_enough"))
    else
      ToastManager.ShowToast(StringTable.Get("str_aircraft_tactic_tape_is_full"))
    end
    return
  end
  self:StartTask(self.reqExchange, self)
end

function UITacticTapeProduceSpeedup:reqExchange(TT)
  local curCount = #self._tacticRoom:GetCartridgeList() + self._tacticRoom:GetCartridgeGiftCount()
  self:Lock(self:GetName())
  local ack = self._airModule:RequestExchangeFirefly(TT, self._cur)
  self:UnLock(self:GetName())
  if ack:GetSucc() then
    self._tacticRoom = self._airModule:GetRoomByRoomType(AirRoomType.TacticRoom)
    local count = #self._tacticRoom:GetCartridgeList() + self._tacticRoom:GetCartridgeGiftCount()
    if curCount < count then
      local spaceID = self._tacticRoom:SpaceId()
      ToastManager.ShowToast(StringTable.Get("str_aircraft_tactic_tape_speedup_success1"))
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftTacticRefreshTapeList)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftTryRefreshRoomUI, spaceID, false)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshRoomUI, spaceID)
    else
      ToastManager.ShowToast(StringTable.Get("str_aircraft_tactic_tape_speedup_success2"))
    end
    self:CloseDialog()
  else
    ToastManager.ShowToast(self._airModule:GetErrorMsg(ack:GetResult()))
  end
end
