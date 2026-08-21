_class("UIDispatchMapController", UIController)
UIDispatchMapController = UIDispatchMapController

function UIDispatchMapController:LoadDataOnEnter(TT, res, uiParams)
  self._aircraftModule = GameGlobal.GetModule(AircraftModule)
  self._aircraftModule:HandleCEventDispatchSite(TT)
  self._aircraftModule:HandleCEventDispatchLook(TT)
  self._roomData = self._aircraftModule:GetRoomByRoomType(AirRoomType.DispatchRoom)
  self._maxPointCount = self._roomData:GetSiteMaxNum()
end

function UIDispatchMapController:OnShow(uiParams)
  self.enterFromEasy = uiParams[1]
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundAircraftDispatchSceneChange)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIDispatchMap)
  self:AttachEvent(GameEventType.UpdateDispatchTaskSiteInfo, self.RefreshUI)
  self._topBarLoader = self:GetUIComponent("UISelectObjectPath", "TopBarLoader")
  self.topButtonWidget = self._topBarLoader:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    self:OnBack()
  end, function()
    self:OnHelp()
  end, function()
    self:OnHome()
  end)
  self._dispatchCountLabel = self:GetUIComponent("UILocalizationText", "DispatchCount")
  self._dispatchRevocerTimeLabel = self:GetUIComponent("UILocalizationText", "DispatchRecoverTime")
  self._dispatchTeamCountLabel = self:GetUIComponent("UILocalizationText", "DispatchTeamCount")
  self._timeRemaindLabel = self:GetUIComponent("UILocalizationText", "TimeRemaind")
  self._tipsGo = self:GetGameObject("Tips")
  self._closeTipsBtn = self:GetGameObject("CloseTipsBtn")
  self._tipsBtn = self:GetGameObject("TipsBtn")
  self._mask = self:GetGameObject("Mask")
  self._dispatchTaskItemList = {}
  for i = 1, self._maxPointCount do
    local taskPointLoader = self:GetUIComponent("UISelectObjectPath", tostring(i))
    local taskIcon = taskPointLoader:SpawnObject("UIDispatchTaskIcon")
    self._dispatchTaskItemList[#self._dispatchTaskItemList + 1] = taskIcon
  end
  self._isShowTips = false
  self:RefreshUI()
  self:RefreshTipsPanel()
end

function UIDispatchMapController:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
  self:DetachEvent(GameEventType.UpdateDispatchTaskSiteInfo, self.RefreshUI)
end

function UIDispatchMapController:RefreshUI()
  local dispatchCount = self._roomData:GetDispatchCount()
  self._currentDispatchCount = dispatchCount
  local roomCfg = self._roomData:GetRoomConfig()
  local dispatchTeamCount = self._roomData:GetDispatchTeamCount()
  self._dispatchCountLabel.text = dispatchCount .. "/" .. roomCfg.DispatchMax
  self._dispatchTeamCountLabel.text = dispatchTeamCount .. "/" .. roomCfg.TeamMax
  local time = self._roomData:GetSurplusSecond()
  if time == -1 then
    self._dispatchRevocerTimeLabel.text = StringTable.Get("str_dispatch_room_dispatch_stop_recover")
  elseif 0 <= time then
    if time == 0 then
      self._dispatchRevocerTimeLabel.text = "00:00:00"
    else
      self._dispatchRevocerTimeLabel.text = HelperProxy:GetInstance():FormatTime(math.floor(time))
    end
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
      self._timer = nil
    end
    self._timer = GameGlobal.Timer():AddEventTimes(100, TimerTriggerCount.Infinite, function()
      local _text
      local time = self._roomData:GetSurplusSecond()
      if time == -1 then
        _text = StringTable.Get("str_dispatch_room_dispatch_stop_recover")
      elseif time == 0 or self._currentDispatchCount ~= self._roomData:GetDispatchCount() then
        if self._timer then
          GameGlobal.Timer():CancelEvent(self._timer)
          self._timer = nil
        end
        _text = "00:00:00"
        self:ReqDataAndRefreshRoomMsg()
      else
        _text = HelperProxy:GetInstance():FormatTime(math.floor(time))
      end
      self._dispatchRevocerTimeLabel.text = _text
    end)
  end
  self:RefreshTask()
end

function UIDispatchMapController:ReqDataAndRefreshRoomMsg()
  GameGlobal.TaskManager():StartTask(self._ReqData, self)
end

function UIDispatchMapController:RefreshTipsPanel()
  self._tipsGo:SetActive(self._isShowTips)
  self._mask:SetActive(self._isShowTips)
  self._closeTipsBtn:SetActive(self._isShowTips)
  self._tipsBtn:SetActive(not self._isShowTips)
  if self._remaindTimeTimer then
    GameGlobal.Timer():CancelEvent(self._remaindTimeTimer)
    self._remaindTimeTimer = nil
  end
  if self._isShowTips then
    self._timeRemaindLabel.text = self:GetRemaindTimeStr(self._roomData:GetDispatchRecoverTotalTime())
    self._remaindTimeTimer = GameGlobal.Timer():AddEventTimes(100, TimerTriggerCount.Infinite, function()
      self._timeRemaindLabel.text = self:GetRemaindTimeStr(self._roomData:GetDispatchRecoverTotalTime())
    end)
  end
end

function UIDispatchMapController:GetRemaindTimeStr(seconds)
  if seconds <= 0 then
    seconds = 0
    return StringTable.Get("str_dispatch_room_has_recover_complete")
  end
  local day = math.floor(seconds / 86400)
  seconds = seconds - day * 86400
  local hour = math.floor(seconds / 3600)
  seconds = seconds - hour * 3600
  local hourStr = hour
  if hour < 10 then
    hourStr = "0" .. hour
  end
  local min = math.floor(seconds / 60)
  seconds = seconds - min * 60
  local minStr = min
  if min < 10 then
    minStr = "0" .. min
  end
  local secondStr = seconds
  if hour == 0 and min == 0 and seconds <= 0 then
    seconds = 1
  end
  if seconds < 10 then
    secondStr = "0" .. seconds
  end
  local timeStr = hourStr .. ":" .. minStr .. ":" .. secondStr
  if 0 < day then
    timeStr = StringTable.Get("str_dispatch_room_day", day) .. timeStr
  end
  return StringTable.Get("str_dispatch_room_task_remaind_time_tips", timeStr)
end

function UIDispatchMapController:_ReqData(TT)
  self:Lock("UIDispatchMapController_ReqData")
  local ack = self._aircraftModule:AircraftUpdate(TT)
  if ack:GetSucc() then
    self:RefreshUI()
  else
    ToastManager.ShowToast(self._aircraftModule:GetErrorMsg(ack:GetResult()))
  end
  self:UnLock("UIDispatchMapController_ReqData")
end

function UIDispatchMapController:RefreshTask()
  for i = 1, self._maxPointCount do
    self._dispatchTaskItemList[i]:GetGameObject():SetActive(false)
  end
  for i = 1, self._maxPointCount do
    local dispatchTaskIconItem = self._dispatchTaskItemList[i]
    dispatchTaskIconItem:Refresh(i - 1, self)
  end
end

function UIDispatchMapController:GetAllRewards()
  local task
  local index = 1
  
  function task(TT)
    if index > self._maxPointCount then
      return
    end
    local dispatchTaskIconItem = self._dispatchTaskItemList[index]
    if dispatchTaskIconItem._siteInfo.state == DispatchTaskStateType.DTST_Complete then
      dispatchTaskIconItem:_GetReward(TT, function()
        index = index + 1
        task(TT)
      end)
    else
      index = index + 1
      task(TT)
    end
  end
  
  GameGlobal.TaskManager():StartTask(task)
end

function UIDispatchMapController:OnBack()
  self:CloseDialog()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshMainUI)
  if not self.enterFromEasy then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftShowRoomUI, self._roomData:SpaceId())
  end
end

function UIDispatchMapController:_RequestRoomData(TT)
end

function UIDispatchMapController:OnHome()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftLeaveAircraft)
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Aircraft_Exit, "UI")
end

function UIDispatchMapController:OnHelp()
  self:ShowDialog("UIHelpController", "UIDispatchMapController")
end

function UIDispatchMapController:GetTaskBtn(taskLevel)
  for i = 1, #self._dispatchTaskItemList do
    local taskUI = self._dispatchTaskItemList[i]
    if taskUI:GetStarCount() == taskLevel then
      return taskUI:GetTaskBtn()
    end
  end
  return nil
end

function UIDispatchMapController:TipsBtnOnClick()
  self._isShowTips = true
  self:RefreshTipsPanel()
end

function UIDispatchMapController:MaskOnClick()
  self._isShowTips = false
  self:RefreshTipsPanel()
end

function UIDispatchMapController:CloseTipsBtnOnClick()
  self._isShowTips = false
  self:RefreshTipsPanel()
end

function UIDispatchMapController:GetRoomInfoGameobject()
  local leftBottomRect = self:GetUIComponent("RectTransform", "Info_Guide")
  local countPanelRect = self:GetUIComponent("RectTransform", "DispatchCountPanel")
  local recoverTimePanelRect = self:GetUIComponent("RectTransform", "DispatchRecoverTimePanel")
  local teamPanelRect = self:GetUIComponent("RectTransform", "DispatchTeamPanel")
  local maxWidth = countPanelRect.sizeDelta.x
  if maxWidth < recoverTimePanelRect.sizeDelta.x then
    maxWidth = recoverTimePanelRect.sizeDelta.x
  end
  if maxWidth < teamPanelRect.sizeDelta.x then
    maxWidth = teamPanelRect.sizeDelta.x
  end
  leftBottomRect.sizeDelta = Vector2(maxWidth, leftBottomRect.sizeDelta.y)
  return leftBottomRect.gameObject
end
