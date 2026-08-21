_class("UITacticTapeProduceFree", UIController)
UITacticTapeProduceFree = UITacticTapeProduceFree

function UITacticTapeProduceFree:OnShow(uiParams)
  self:InitWidget()
  self._airModule = self:GetModule(AircraftModule)
  self._tacticRoom = self._airModule:GetRoomByRoomType(AirRoomType.TacticRoom)
  self._timeModule = self:GetModule(SvrTimeModule)
  self.times:SetText(StringTable.Get("str_aircraft_tactic_free_make_count", self._tacticRoom:GetWeeklyFreeMakeCount(), self._tacticRoom:GetWeeklyFreeMakeLimit()))
  self._timerHolder = UITimerHolder:New()
  self._timerHolder:StartTimerInfinite("Countdown", 1000, function()
    self:tick()
  end)
  self:tick()
end

function UITacticTapeProduceFree:OnHide()
  self._timerHolder:Dispose()
end

function UITacticTapeProduceFree:tick()
  local now = math.floor(self._timeModule:GetServerTime() / 1000)
  local timeStr = HelperProxy:GetInstance():FormatTime_3(self._tacticRoom:GetNextResetTime() - now)
  if self._timeStr ~= timeStr then
    self._timeStr = timeStr
    self.countdown:SetText(StringTable.Get("str_aircraft_tactic_free_make_time", timeStr))
  end
end

function UITacticTapeProduceFree:InitWidget()
  self.times = self:GetUIComponent("UILocalizationText", "times")
  self.countdown = self:GetUIComponent("UILocalizationText", "countdown")
end

function UITacticTapeProduceFree:cancelBtnOnClick(go)
  self:CloseDialog()
end

function UITacticTapeProduceFree:okBtnOnClick(go)
  local count = #self._tacticRoom:GetCartridgeList() + self._tacticRoom:GetCartridgeGiftCount()
  if count == self._tacticRoom:GetCartridgeLimit() - 1 then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_aircraft_tactic_free_make_tip2"), function(param)
      self:StartTask(self.makeFree, self)
    end, nil, function(param)
    end, nil)
  else
    self:StartTask(self.makeFree, self)
  end
end

function UITacticTapeProduceFree:makeFree(TT)
  self:Lock(self:GetName())
  local res = self._airModule:RequestMakeCartridgeFree(TT)
  self:UnLock(self:GetName())
  if res:GetSucc() then
    ToastManager.ShowToast(StringTable.Get("str_aircraft_tactic_free_make_success"))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftTacticRefreshTapeList)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshRoomUI, self._tacticRoom:SpaceId())
    self:CloseDialog()
  else
    self._airModule:GetErrorMsg(res:GetResult())
  end
end

function UITacticTapeProduceFree:blankOnClick(go)
  self:CloseDialog()
end
