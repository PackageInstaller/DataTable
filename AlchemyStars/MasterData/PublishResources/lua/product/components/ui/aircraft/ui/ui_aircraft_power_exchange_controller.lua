_class("UIPowerExchangeController", UIController)
UIPowerExchangeController = UIPowerExchangeController

function UIPowerExchangeController:OnShow(uiParams)
  local sop = self:GetUIComponent("UISelectObjectPath", "currencymenu")
  self.currencyMenu = sop:SpawnObject("UICurrencyMenu")
  self.currencyMenu:SetData({
    RoleAssetID.RoleAssetFirefly,
    RoleAssetID.RoleAssetPhyPoint
  })
  self.fireFlyItem = self.currencyMenu:GetItemByTypeId(RoleAssetID.RoleAssetFirefly)
  self:InitWidget()
  self.airData = GameGlobal.GameLogic():GetModule(AircraftModule)
  local roleModel = GameGlobal.GameLogic():GetModule(RoleModule)
  self.fireFlyItem:SetText(math.floor(self.airData:GetFirefly()) .. "/" .. math.floor(self.airData:GetMaxFirefly()))
  self.exchangeRate = Cfg.cfg_aircraft_values[4].IntValue
  self.maxPower = self.airData:GetMaxHealthPoint()
  if self.maxPower < 1 then
    self.curPower = 0
    self.maxPower = 0
    self.minPower = 0
  else
    self.curPower = 1
    self.minPower = 1
  end
  self.timeEvent = nil
  self:RefreshFirflyWindowInfo()
end

function UIPowerExchangeController:OnHide()
  if self.timeEvent then
    GameGlobal.Timer():CancelEvent(self.timeEvent)
    self.timeEvent = nil
  end
end

function UIPowerExchangeController:InitWidget()
  self.textExchangePowerValue = self:GetUIComponent("UILocalizationText", "TextExchangePowerValue")
  self.textExchangeFireflyValue = self:GetUIComponent("UILocalizationText", "TextExchangeFireflyValue")
  self.textExchangeTip = self:GetUIComponent("UILocalizationText", "TextExchangeTip")
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

function UIPowerExchangeController:RefreshFirflyWindowInfo()
  local curFirefly = self.curPower * self.exchangeRate
  self.textExchangePowerValue.text = self.curPower
  self.textExchangeFireflyValue.text = "+" .. curFirefly
  self.textExchangeTip.text = string.format(StringTable.Get("str_aircraft_tip_exchange"), self.curPower, curFirefly)
end

function UIPowerExchangeController:StartTimer(isIncrease)
  if self.timeEvent then
    GameGlobal.Timer():CancelEvent(self.timeEvent)
    self.timeEvent = nil
  end
  self.timeEvent = GameGlobal.Timer():AddEvent(500, function()
    self:StepCount(isIncrease)
  end)
end

function UIPowerExchangeController:StopTimer(isIncrease)
  if self.timeEvent then
    GameGlobal.Timer():CancelEvent(self.timeEvent)
    self.timeEvent = nil
  end
end

function UIPowerExchangeController:StepCount(isIncrease)
  self.timeEvent = GameGlobal.Timer():AddEvent(300, function()
    if isIncrease then
      self:ButtonExchangeIncreaseOnClick()
    else
      self:ButtonExchangeDecreaseOnClick()
    end
    self:StepCount(isIncrease)
  end)
end

function UIPowerExchangeController:ButtonExchangeIncreaseOnClick(go)
  if self.curPower >= self.maxPower then
    self.curPower = self.maxPower
    return
  end
  self.curPower = self.curPower + 1
  self:RefreshFirflyWindowInfo()
end

function UIPowerExchangeController:ButtonExchangeDecreaseOnClick(go)
  if self.curPower <= self.minPower then
    self.curPower = self.minPower
    return
  end
  self.curPower = self.curPower - 1
  self:RefreshFirflyWindowInfo()
end

function UIPowerExchangeController:ButtonExchangeMaxOnClick(go)
  if self.curPower >= self.maxPower then
    self.curPower = self.maxPower
    return
  end
  self.curPower = self.maxPower
  self:RefreshFirflyWindowInfo()
end

function UIPowerExchangeController:ButtonExchangeMinOnClick(go)
  if self.curPower <= self.minPower then
    self.curPower = self.minPower
    return
  end
  self.curPower = self.minPower
  self:RefreshFirflyWindowInfo()
end

function UIPowerExchangeController:ButtonExchangeConfirmOnClick(go)
  if self.airData:GetFirefly() >= self.airData:GetMaxFirefly() then
    ToastManager.ShowToast(StringTable.Get("str_aircraft_tip_firefly_full"))
    return
  end
  if self.maxPower <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_aircraft_tip_phys_not_enough"))
    return
  end
  GameGlobal.TaskManager():StartTask(self.Exchange, self)
end

function UIPowerExchangeController:Exchange(TT)
  self:Lock(self:GetName())
  local result = self.airData:RedeemFirefly(TT, self.curPower)
  self:UnLock(self:GetName())
  if result:GetSucc() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshTopbar)
    self:CloseDialog()
  else
    ToastManager.ShowToast(self.airData:GetErrorMsg(result:GetResult()))
  end
end

function UIPowerExchangeController:ButtonExchangeCancelOnClick(go)
  self:CloseDialog()
end
