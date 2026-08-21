_class("UIMainLobbyTopIcon", UICustomWidget)
UIMainLobbyTopIcon = UIMainLobbyTopIcon

function UIMainLobbyTopIcon:OnShow()
  self._roleModule = GameGlobal.GetModule(RoleModule)
  self._phyTime = self:GetGameObject("phyTime")
  self._diamondText = self:GetUIComponent("UILocalizationText", "DiamondText")
  self._phyPowerText = self:GetUIComponent("UILocalizationText", "PhyPowerText")
  self._phyTimeCanvasGroup = self:GetUIComponent("CanvasGroup", "phyTime")
  self._nextTime = self:GetUIComponent("UILocalizationText", "nextTime")
  self._allTime = self:GetUIComponent("UILocalizationText", "allTime")
  self._goldText = self:GetUIComponent("UILocalizationText", "GoldText")
  self._yaojingText = self:GetUIComponent("UILocalizationText", "YaojingText")
  self:AttachEvent(GameEventType.ItemCountChanged, self.OnItemCountChange)
  self:AttachEvent(GameEventType.RolePropertyChanged, self.OnItemCountChange)
  self._goldPanel = self:GetGameObject("GoldPanel")
  self._phyPowerPanel = self:GetGameObject("PhyPowerPanel")
  self._diamondPanel = self:GetGameObject("DiamondPanel")
  self._yaojingPanel = self:GetGameObject("YaojingPanel")
end

function UIMainLobbyTopIcon:OnItemCountChange()
  self:ShowPhyPoint()
  self._diamondText:SetText(self._roleModule:GetGlow())
  self._yaojingText:SetText(self._roleModule:GetDiamond())
  local count = self._roleModule:GetGold()
  self._goldText:SetText(HelperProxy:GetInstance():FormatGold(count))
end

function UIMainLobbyTopIcon:OnHide()
  if self._startPhyTimerEvent then
    GameGlobal.RealTimer():CancelEvent(self._startPhyTimerEvent)
    self._startPhyTimerEvent = nil
  end
  if self._startPhyTimerLoopEvent then
    GameGlobal.RealTimer():CancelEvent(self._startPhyTimerLoopEvent)
    self._startPhyTimerLoopEvent = nil
  end
  if self._showTimeEvent then
    GameGlobal.RealTimer():CancelEvent(self._showTimeEvent)
    self._showTimeEvent = nil
  end
  self:ClosePhyTimer()
end

function UIMainLobbyTopIcon:SetData(toptipsInfo)
  self._toptipsInfo = toptipsInfo
  self:GetCurrentPhyTimer()
  self:OnItemCountChange()
end

function UIMainLobbyTopIcon:SetPanelShow(goldShow, powerShow, diamondShow)
  self._goldPanel:SetActive(goldShow)
  self._phyPowerPanel:SetActive(powerShow)
  self._diamondPanel:SetActive(diamondShow)
  self._yaojingPanel:SetActive(false)
end

function UIMainLobbyTopIcon:GetCurrentPhyTimer()
  self:Lock("UIMainLobbyTopIcon:GetCurrentPhyTimer")
  GameGlobal.TaskManager():StartTask(self.OnGetCurrentPhyTimer, self)
end

function UIMainLobbyTopIcon:OnGetCurrentPhyTimer(TT)
  local res, startTime, intervalRecoverTime, leftRecoverTime, allRecoverTime = self._roleModule:GetRecoverData(TT, 0)
  self:UnLock("UIMainLobbyTopIcon:GetCurrentPhyTimer")
  if not res:GetSucc() then
    Log.fatal("###OnGetCurrentPhyTimer false !")
    return
  end
  local gapTimeNum = intervalRecoverTime * 1000
  local nextTimeNum = leftRecoverTime * 1000
  if self._startPhyTimerEvent then
    GameGlobal.RealTimer():CancelEvent(self._startPhyTimerEvent)
    self._startPhyTimerEvent = nil
  end
  if self._roleModule:GetHealthPoint() >= self._roleModule:GetHpLevelMax() then
    return
  end
  self._startPhyTimerEvent = GameGlobal.RealTimer():AddEvent(nextTimeNum, function(gapTimeNum)
    self:StartPhyTimer(gapTimeNum)
  end, gapTimeNum)
end

function UIMainLobbyTopIcon:StartPhyTimer(gapTime)
  if self._startPhyTimerLoopEvent then
    GameGlobal.RealTimer():CancelEvent(self._startPhyTimerLoopEvent)
    self._startPhyTimerLoopEvent = nil
  end
  self:StartPhyTimerLoop()
  self._startPhyTimerLoopEvent = GameGlobal.RealTimer():AddEventTimes(gapTime, TimerTriggerCount.Infinite, function()
    self:StartPhyTimerLoop()
  end)
end

function UIMainLobbyTopIcon:StartPhyTimerLoop()
  self:Lock("UIMainLobbyTopIcon:StartPhyTimerLoop")
  GameGlobal.TaskManager():StartTask(self.OnStartPhyTimerLoop, self)
end

function UIMainLobbyTopIcon:OnStartPhyTimerLoop(TT)
  local res = self._roleModule:GetRecoverData(TT, 0)
  self:UnLock("UIMainLobbyTopIcon:StartPhyTimerLoop")
  if res:GetSucc() then
    self:ShowPhyPoint()
  else
    Log.fatal("###GetRecoverData false --> result --> ", res:GetResult())
  end
end

function UIMainLobbyTopIcon:PhyPowerTexBtnOnClick()
  do return end
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "Click_PhyPoint"
  }, true)
  if not self._phyPanelIsOpen then
    self:ShowPhyPoint()
    self:OpenPhyTimer()
  end
end

function UIMainLobbyTopIcon:ShowPhyPoint()
  local currentPhyPower = self._roleModule:GetHealthPoint()
  if currentPhyPower == nil then
    currentPhyPower = 0
  end
  local currentPhysicalPowerUpper = self._roleModule:GetHpLevelMax()
  if currentPhysicalPowerUpper == nil then
    currentPhysicalPowerUpper = 0
  end
  local moreThan = false
  if currentPhyPower > currentPhysicalPowerUpper then
    moreThan = true
  end
  if 999 < currentPhyPower then
    currentPhyPower = "999+"
  end
  if moreThan then
    currentPhyPower = "<color=#00ffea>" .. currentPhyPower .. "</color>"
  end
  if self.view then
    self._phyPowerText:SetText(currentPhyPower .. "/" .. currentPhysicalPowerUpper)
  end
end

function UIMainLobbyTopIcon:OpenPhyTimer()
  self:Lock("GetRecoverData")
  self:StartTask(self.OnOpenPhyTimer, self)
end

function UIMainLobbyTopIcon:OnOpenPhyTimer(TT)
  local res, startTime, intervalRecoverTime, leftRecoverTime, allRecoverTime = self._roleModule:GetRecoverData(TT, 0)
  self:UnLock("GetRecoverData")
  if not res:GetSucc() then
    Log.fatal("### request fail -- self._roleModule:GetRecoverData !")
    return
  end
  self._gapTimeNum = intervalRecoverTime
  self._nextTimeNum = leftRecoverTime
  self._allTimeNum = allRecoverTime
  self._phyPanelIsOpen = true
  if self._phyEvent then
    GameGlobal.RealTimer():CancelEvent(self._phyEvent)
    self._phyEvent = nil
  end
  self._phyEvent = GameGlobal.RealTimer():AddEvent(2000, function()
    self:ClosePhyTimer()
  end)
  self._phyTime:SetActive(true)
  self._nextTime:SetText(self:Time2Str(self._nextTimeNum))
  self._allTime:SetText(self:Time2Str(self._allTimeNum))
  if self._showTimeEvent then
    GameGlobal.RealTimer():CancelEvent(self._showTimeEvent)
    self._showTimeEvent = nil
  end
  self._showTimeEvent = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, self.ShowTime, self)
end

function UIMainLobbyTopIcon:ClosePhyTimer()
  self._phyTime:SetActive(false)
  if self._showTimeEvent then
    GameGlobal.RealTimer():CancelEvent(self._showTimeEvent)
    self._showTimeEvent = nil
  end
  if self._phyEvent then
    GameGlobal.RealTimer():CancelEvent(self._phyEvent)
    self._phyEvent = nil
  end
  self._phyPanelIsOpen = false
end

function UIMainLobbyTopIcon:ShowTime()
  self._nextTimeNum = self._nextTimeNum - 1
  self._allTimeNum = self._allTimeNum - 1
  if self._nextTimeNum < 0 then
    self._nextTimeNum = self._gapTimeNum - 1
    self:OnItemCountChange()
  end
  if self._allTimeNum < 0 then
    self._allTimeNum = 0
    if self._showTimeEvent then
      GameGlobal.RealTimer():CancelEvent(self._showTimeEvent)
      self._showTimeEvent = nil
    end
    return
  end
  self._nextTime:SetText(self:Time2Str(self._nextTimeNum))
  self._allTime:SetText(self:Time2Str(self._allTimeNum))
end

function UIMainLobbyTopIcon:Time2Str(time)
  local str = ""
  local timeTab = self:ChangeSecondToTime(time)
  str = self:ChangeTimeTableToStr(timeTab)
  return str
end

function UIMainLobbyTopIcon:ChangeTimeTableToStr(timeTable)
  local hourStr, minStr, secStr
  if timeTable.hour > 9 then
    hourStr = timeTable.hour
  else
    hourStr = "0" .. timeTable.hour
  end
  if 9 < timeTable.min then
    minStr = timeTable.min
  else
    minStr = "0" .. timeTable.min
  end
  if 9 < timeTable.sec then
    secStr = timeTable.sec
  else
    secStr = "0" .. timeTable.sec
  end
  return hourStr .. ":" .. minStr .. ":" .. secStr
end

function UIMainLobbyTopIcon:ChangeSecondToTime(second)
  local timeTable = {
    hour = 0,
    min = 0,
    sec = 0
  }
  if second == 0 then
    return timeTable
  end
  local sec = math.modf(second % 60)
  local minAll = math.modf((second - sec) / 60)
  local min = math.modf(minAll % 60)
  local hour = math.modf((minAll - min) / 60)
  timeTable.hour = hour
  timeTable.min = min
  timeTable.sec = sec
  return timeTable
end

function UIMainLobbyTopIcon:GoldOnClick()
  local gold = self:GetGameObject("Gold")
  self._toptipsInfo:SetData(RoleAssetID.RoleAssetGold, gold)
end

function UIMainLobbyTopIcon:PhyPowerOnClick()
  local power = self:GetGameObject("PhyPower")
  self._toptipsInfo:SetData(RoleAssetID.RoleAssetPhyPoint, power)
end

function UIMainLobbyTopIcon:DiamondOnClick()
  local count = self._roleModule:GetGlow()
  if count < 0 then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, StringTable.Get("str_shop_resourceerror_title"), StringTable.Get("str_shop_resourceerror_desc"), function(param)
    end)
  else
    local diamond = self:GetGameObject("Diamond")
    self._toptipsInfo:SetData(RoleAssetID.RoleAssetGlow, diamond)
  end
end

function UIMainLobbyTopIcon:DiamondAddOnClick()
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_ADD_DIAMOND)
  GameGlobal.UIStateManager():ShowDialog("UIShopCurrency1To2", 0)
end

function UIMainLobbyTopIcon:PhyPowerAddOnClick(go)
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_ADD_PHY)
  self:ShowDialog("UIGetPhyPointController")
end

function UIMainLobbyTopIcon:GoldAddOnClick()
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_COIN)
  self:ShowDialog("UIItemGetPathController", RoleAssetID.RoleAssetGold)
end
