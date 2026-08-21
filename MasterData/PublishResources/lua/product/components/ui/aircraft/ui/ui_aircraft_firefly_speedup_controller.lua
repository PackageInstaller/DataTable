_class("UIAircraftFireflySpeedupController", UIController)
UIAircraftFireflySpeedupController = UIAircraftFireflySpeedupController

function UIAircraftFireflySpeedupController:OnShow(uiParams)
  self.spaceID = uiParams[1]
  self.operation = uiParams[2]
  local sop = self:GetUIComponent("UISelectObjectPath", "currencymenu")
  self.currencyMenu = sop:SpawnObject("UICurrencyMenu")
  self.currencyMenu:SetData({
    RoleAssetID.RoleAssetFirefly
  })
  self.fireFlyItem = self.currencyMenu:GetItemByTypeId(RoleAssetID.RoleAssetFirefly)
  self:InitWidget()
  self.airData = GameGlobal.GameLogic():GetModule(AircraftModule)
  self.fireFlyItem:SetText(math.floor(self.airData:GetFirefly()) .. "/" .. math.floor(self.airData:GetMaxFirefly()))
  self.exchangeRate = Cfg.cfg_aircraft_values[5].IntValue
  self.speedUpTimeS = 0
  local curFireCeiling = math.floor(self.airData:GetFirefly())
  local max = self:CalculateMaxFire()
  if max == 0 then
    self.curFire = 0
    self.fireFloor = 0
  elseif curFireCeiling < 1 then
    self.curFire = 0
    self.fireFloor = 0
  else
    self.curFire = 1
    self.fireFloor = 1
  end
  self:RefreshFirflyWindowInfo()
  self.timerEvent = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:CountDown()
  end)
end

function UIAircraftFireflySpeedupController:OnHide()
  if self.timerEvent then
    GameGlobal.Timer():CancelEvent(self.timerEvent)
    self.timerEvent = nil
  end
end

function UIAircraftFireflySpeedupController:InitWidget()
  self.textExchangeValue = self:GetUIComponent("UILocalizationText", "TextExchangeValue")
  self.textExchangeTip = self:GetUIComponent("UILocalizationText", "TextExchangeTip")
  self.needTime = self:GetUIComponent("UILocalizationText", "needTime")
  self.speedupTime = self:GetUIComponent("UILocalizationText", "speedupTime")
  self.confirmBtnText = self:GetUIComponent("UILocalizationText", "confirmBtn")
  self.decreaseBtn = self:GetGameObject("ButtonExchangeDecrease")
  self.increaseBtn = self:GetGameObject("ButtonExchangeIncrease")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self.decreaseBtn), UIEvent.Hovered, function(go)
    self:StartTimer(false)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self.decreaseBtn), UIEvent.Unhovered, function(go)
    self:StopTimer()
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self.decreaseBtn), UIEvent.Release, function(go)
    self:StopTimer()
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self.increaseBtn), UIEvent.Hovered, function(go)
    self:StartTimer(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self.increaseBtn), UIEvent.Unhovered, function(go)
    self:StopTimer()
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self.increaseBtn), UIEvent.Release, function(go)
    self:StopTimer()
  end)
end

function UIAircraftFireflySpeedupController:StartTimer(isIncrease)
  if self.timeEvent then
    GameGlobal.Timer():CancelEvent(self.timeEvent)
    self.timeEvent = nil
  end
  self.timeEvent = GameGlobal.Timer():AddEvent(500, function()
    self:StepCount(isIncrease)
  end)
end

function UIAircraftFireflySpeedupController:StopTimer(isIncrease)
  if self.timeEvent then
    GameGlobal.Timer():CancelEvent(self.timeEvent)
    self.timeEvent = nil
  end
end

function UIAircraftFireflySpeedupController:StepCount(isIncrease)
  self.timeEvent = GameGlobal.Timer():AddEvent(300, function()
    if isIncrease then
      self:ButtonExchangeIncreaseOnClick()
    else
      self:ButtonExchangeDecreaseOnClick()
    end
    self:StepCount(isIncrease)
  end)
end

function UIAircraftFireflySpeedupController:RefreshFirflyWindowInfo()
  local time = self.curFire * self.exchangeRate
  local remainTime = self:GetRemainTime()
  self.textExchangeValue.text = self.curFire
  self.needTime.text = HelperProxy:GetInstance():FormatTime(remainTime)
  self.speedupTime.text = HelperProxy:GetInstance():FormatTime(time)
  local minute = math.floor(time / 60)
  self.textExchangeTip.text = string.format(StringTable.Get("str_aircraft_tip_speedup_confirm"), self.curFire, minute)
  if remainTime <= self.exchangeRate then
    self.confirmBtnText.text = StringTable.Get("str_aircraft_tip_speedup_free")
  end
end

function UIAircraftFireflySpeedupController:CountDown()
  local remainTime = self:GetRemainTime()
  if remainTime <= 0 then
    self.needTime.text = HelperProxy:GetInstance():FormatTime(0)
    self.curFire = 0
    self:RefreshFirflyWindowInfo()
    GameGlobal.Timer():CancelEvent(self.timerEvent)
    self.timerEvent = nil
    return
  end
  local maxFire = self:CalculateMaxFire()
  if maxFire < self.curFire then
    self.curFire = maxFire
    self:RefreshFirflyWindowInfo()
  else
    self.needTime.text = HelperProxy:GetInstance():FormatTime(remainTime)
  end
end

function UIAircraftFireflySpeedupController:CalculateMaxFire()
  local curFireCeiling = math.floor(self.airData:GetFirefly())
  local fireTime = curFireCeiling * self.exchangeRate
  local remainTime = self:GetRemainTime()
  local maxFire = 0
  if remainTime <= self.exchangeRate then
    maxFire = 0
  elseif fireTime > remainTime then
    maxFire = math.ceil(remainTime / self.exchangeRate)
  else
    maxFire = curFireCeiling
  end
  return maxFire
end

function UIAircraftFireflySpeedupController:GetRemainTime()
  if self.operation == AircraftRoomOperation.CleanSpeedUp then
    return self.airData:GetCleanSpaceRemainingTime(self.spaceID)
  end
  return math.floor(self.airData:GetRoom(self.spaceID):BuildRemainTime())
end

function UIAircraftFireflySpeedupController:ButtonExchangeIncreaseOnClick(go)
  local maxFire = self:CalculateMaxFire()
  if maxFire <= self.curFire then
    self.curFire = maxFire
  else
    self.curFire = self.curFire + 1
  end
  self:RefreshFirflyWindowInfo()
end

function UIAircraftFireflySpeedupController:ButtonExchangeDecreaseOnClick(go)
  if self.curFire <= self.fireFloor then
    self.curFire = self.fireFloor
    return
  end
  self.curFire = self.curFire - 1
  self:RefreshFirflyWindowInfo()
end

function UIAircraftFireflySpeedupController:ButtonExchangeMaxOnClick(go)
  self.curFire = self:CalculateMaxFire()
  self:RefreshFirflyWindowInfo()
end

function UIAircraftFireflySpeedupController:ButtonExchangeMinOnClick(go)
  if self.curFire <= self.fireFloor then
    self.curFire = self.fireFloor
    return
  end
  self.curFire = self.fireFloor
  self:RefreshFirflyWindowInfo()
end

function UIAircraftFireflySpeedupController:ButtonExchangeConfirmOnClick(go)
  local remainTime = self:GetRemainTime()
  if remainTime <= 0 then
    self:CloseDialog()
    return
  end
  if self.airData:GetFirefly() < 1 then
    ToastManager.ShowToast(StringTable.Get("str_aircraft_tip_no_firefly"))
    return
  end
  GameGlobal.TaskManager():StartTask(self.SpeedUp, self)
end

function UIAircraftFireflySpeedupController:SpeedUp(TT)
  local result
  self:Lock(self:GetName())
  if self.operation == AircraftRoomOperation.BuildSpeedUp then
    result = self.airData:RequestUseFireflyBuildRoom(TT, self.spaceID, self.curFire)
  elseif self.operation == AircraftRoomOperation.UpgradeSpeedUp then
    result = self.airData:RequestUseFireflyUpgradeRoom(TT, self.spaceID, self.curFire)
  elseif self.operation == AircraftRoomOperation.CleanSpeedUp then
    result = self.airData:RequestUseFireflyCleanSpace(TT, self.spaceID, self.curFire)
  elseif self.operation == AircraftRoomOperation.DegradeSpeedUp then
    result = self.airData:RequestUseFireflyDegradeRoom(TT, self.spaceID, self.curFire)
  end
  if result:GetSucc() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshTopbar)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshRoomUI, self.spaceID)
    self:CloseDialog()
  else
    ToastManager.ShowToast(self.airData:GetErrorMsg(result:GetResult()))
  end
  self:UnLock(self:GetName())
end

function UIAircraftFireflySpeedupController:ButtonExchangeCancelOnClick(go)
  self:CloseDialog()
end
