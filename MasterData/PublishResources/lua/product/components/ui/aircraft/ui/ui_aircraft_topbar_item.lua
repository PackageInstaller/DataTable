_class("UIAircraftTopBarItem", UICustomWidget)
UIAircraftTopBarItem = UIAircraftTopBarItem

function UIAircraftTopBarItem:OnShow(uiParams)
  self.active = true
  self:InitWidget()
  self:SetRecoverActive(false)
  self.aircraftModule = GameGlobal.GameLogic():GetModule(AircraftModule)
  self:OnSetAmbientActive(true)
  self:OnAmbientChanged()
  self.AmbientText_.color = Color(0, 0.8627450980392157, 1.0, 1)
  self:AttachEvent(GameEventType.AircraftOnFireFlyChanged, self.OnFireFlyChanged)
  self:AttachEvent(GameEventType.AircraftOnAmbientChanged, self.OnAmbientChanged)
  self:AttachEvent(GameEventType.AircraftAmbientSetActive, self.OnSetAmbientActive)
  self:AttachEvent(GameEventType.AircraftSettledPetChanged, self.OnAmbientChanged)
end

function UIAircraftTopBarItem:OnHide()
  self.active = false
  if self.timerEvent then
    GameGlobal.Timer():CancelEvent(self.timerEvent)
    self.timerEvent = nil
  end
end

function UIAircraftTopBarItem:InitWidget()
  self.imageSlider = self:GetUIComponent("Image", "ImageSlider")
  self.textRecoverTimer = self:GetUIComponent("UILocalizationText", "TextRecoverTimer")
  self.textRecoverSpeedUp = self:GetUIComponent("RollingText", "TextRecoverSpeedUp")
  self.recoverSpeed = self:GetUIComponent("UILocalizationText", "recoverSpeed")
  self.fireflyGo = self:GetGameObject("Firefly")
  self.Ambient_ = self:GetGameObject("Ambient")
  self.AmbientText_ = self:GetUIComponent("UILocalizationText", "ValueText")
  self.pos = self:GetUIComponent("RectTransform", "pos")
end

function UIAircraftTopBarItem:SetData(_showButtons, _backCallback, _helpCallback, showAmbient, showGold)
  self.Ambient_:SetActive(showAmbient == true)
  local sop = self:GetUIComponent("UISelectObjectPath", "Top")
  self.currencyMenu = sop:SpawnObject("UICurrencyMenu")
  if showGold then
    self.currencyMenu:SetData({
      RoleAssetID.RoleAssetFirefly,
      CurrenyTypeId.StarPoint,
      RoleAssetID.RoleAssetGold
    })
    self.goldItem = self.currencyMenu:GetItemByTypeId(RoleAssetID.RoleAssetGold)
  else
    self.currencyMenu:SetData({
      RoleAssetID.RoleAssetFirefly,
      CurrenyTypeId.StarPoint
    })
  end
  self.fireFlyItem = self.currencyMenu:GetItemByTypeId(RoleAssetID.RoleAssetFirefly)
  self.fireFlyItem:SetAddCallBack(function(id, go)
    local pos = go.transform.position
    self:SetRecoverActive(true, pos)
    self:RefreshFirflyPopupInfo()
  end)
  self.energyItem = self.currencyMenu:GetItemByTypeId(CurrenyTypeId.StarPoint)
  self:RefreshGoldInfo()
  if _showButtons ~= nil and _showButtons == false then
    return
  end
  local topButton = self:GetUIComponent("UISelectObjectPath", "TopButtons")
  self.topButtonWidget = topButton:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(_backCallback, _helpCallback, function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftLeaveAircraft)
    GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Aircraft_Exit, "UI")
  end)
end

function UIAircraftTopBarItem:OnFireFlyChanged()
  self:RefreshFirefly()
end

function UIAircraftTopBarItem:OnAmbientChanged()
  local ambientValue = self.aircraftModule:GetValidAmbient()
  self.AmbientText_:SetText(ambientValue)
end

function UIAircraftTopBarItem:OnSetAmbientActive(boolValue)
  self.Ambient_:SetActive(boolValue)
end

function UIAircraftTopBarItem:RefreshGoldInfo()
  self:RefreshFirefly()
  local powerAvai = self.aircraftModule:GetPower()
  local powerMax = self.aircraftModule:GetMaxPower()
  self.energyItem:SetText(powerAvai .. "/" .. powerMax)
  local gold = GameGlobal.GameLogic():GetModule(RoleModule):GetGold()
  if self.goldItem then
    self.goldItem:SetText(HelperProxy:GetInstance():FormatGold(gold))
  end
end

function UIAircraftTopBarItem:RefreshFirefly()
  local hadf = math.floor(self.aircraftModule:GetFirefly())
  local maxf = math.floor(self.aircraftModule:GetMaxFirefly())
  self.fireFlyItem:SetText(hadf .. "/" .. maxf)
end

function UIAircraftTopBarItem:RefreshFirflyPopupInfo()
  local hadf = math.floor(self.aircraftModule:GetFirefly())
  local maxf = math.floor(self.aircraftModule:GetMaxFirefly())
  local fireflyAmount = 0
  if maxf == 0 then
    fireflyAmount = 1
  else
    fireflyAmount = hadf / maxf
  end
  self.imageSlider.fillAmount = fireflyAmount
  local speed = self.aircraftModule:GetFireflyRecoverSpeed() * 3600
  local title = StringTable.Get("str_aircraft_func_firefly_recover_speed_sum")
  self.textRecoverSpeedUp:RefreshText(title)
  self.recoverSpeed:SetText(string.format("%.2f", speed))
  local countDownTime = math.ceil(self.aircraftModule:GetFireFlyRemainderTime())
  if 0 < countDownTime then
    self.textRecoverTimer.text = HelperProxy:GetInstance():FormatTime_2(countDownTime)
    self:StartCountDown()
  else
    self.textRecoverTimer.text = "--:--:--"
  end
end

function UIAircraftTopBarItem:StartCountDown()
  self.timerEvent = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    local hadf = math.floor(self.aircraftModule:GetFirefly())
    local maxf = math.floor(self.aircraftModule:GetMaxFirefly())
    local fireflyAmount = 0
    if maxf == 0 then
      fireflyAmount = 1
    else
      fireflyAmount = hadf / maxf
    end
    self.fireFlyItem:SetText(hadf .. "/" .. maxf)
    self.imageSlider.fillAmount = fireflyAmount
    local countDownTime = math.ceil(self.aircraftModule:GetFireFlyRemainderTime())
    if countDownTime <= 0 then
      self.textRecoverTimer.text = "--:--:--"
      self:CountdownEnd()
    else
      self.textRecoverTimer.text = HelperProxy:GetInstance():FormatTime_2(countDownTime)
    end
  end)
end

function UIAircraftTopBarItem:CountdownEnd()
  self.countDownTime = 0
  GameGlobal.Timer():CancelEvent(self.timerEvent)
  self.timerEvent = nil
  GameGlobal.TaskManager():StartTask(self.ReqData, self)
end

function UIAircraftTopBarItem:ReqData(TT)
  self:Lock(self:GetName())
  local ack = self.aircraftModule:AircraftUpdate(TT)
  self:UnLock(self:GetName())
  if ack:GetSucc() then
    if self.active then
      self:RefreshAllMsg()
    end
  else
    ToastManager.ShowToast(self.aircraftModule:GetErrorMsg(ack:GetResult()))
  end
end

function UIAircraftTopBarItem:RefreshAllMsg()
  self:RefreshGoldInfo()
  if self.fireflyGo.activeSelf then
    if self.timerEvent then
      GameGlobal.Timer():CancelEvent(self.timerEvent)
      self.timerEvent = nil
    end
    self:RefreshFirflyPopupInfo()
  end
end

function UIAircraftTopBarItem:SetRecoverActive(active, position)
  self.fireflyGo:SetActive(active)
  if active and position then
    self.pos.position = position
  end
end

function UIAircraftTopBarItem:ButtonFireflyPopupOnClick(go)
  self:SetRecoverActive(true)
  self:RefreshFirflyPopupInfo()
end

function UIAircraftTopBarItem:ButtonSpeedUpOnClick(go)
  ToastManager.ShowLockTip()
end

function UIAircraftTopBarItem:FireflyRecoverPopupOnClick(go)
  if self.timerEvent then
    GameGlobal.Timer():CancelEvent(self.timerEvent)
    self.timerEvent = nil
  end
  self:SetRecoverActive(false)
end

function UIAircraftTopBarItem:AmbientPanelOnClick(go)
  GameGlobal.UIStateManager():ShowDialog("UIAmbientPanel")
end

function UIAircraftTopBarItem:AmbientButton1OnClick(go)
end
