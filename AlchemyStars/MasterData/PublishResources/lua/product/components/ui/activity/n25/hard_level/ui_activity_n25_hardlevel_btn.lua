_class("UIN25HardLevelBtn", UICustomWidget)
UIN25HardLevelBtn = UIN25HardLevelBtn

function UIN25HardLevelBtn:OnShow(uiParams)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self:InitWidget()
end

function UIN25HardLevelBtn:InitWidget()
  self.select = self:GetGameObject("select")
  self.unSelect = self:GetGameObject("unSelect")
  self.locker = self:GetGameObject("locker")
  self.logName = self:GetUIComponent("RawImage", "logName")
  self.logNameLoader = self:GetUIComponent("RawImageLoader", "logName")
  self.rootRt = self:GetUIComponent("RectTransform", "rootRt")
  self.levelBtn = self:GetUIComponent("Button", "rootRt")
  self.lockTime = self:GetGameObject("lockTime")
  self.lockTimeTex = self:GetUIComponent("UILocalizationText", "lockTimeTex")
end

function UIN25HardLevelBtn:SetData(logName, clickCallback)
  self.clickCallback = clickCallback
  self:SetLockVisible(false)
  self.logNameLoader:LoadImage(logName)
end

function UIN25HardLevelBtn:SetLockVisible(bVisible, openTime, timerCb)
  local lockTime = false
  if openTime then
    lockTime = true
  end
  local lockMission = false
  if bVisible then
    lockMission = true
  end
  if self.locker then
    self.locker:SetActive(lockMission or lockTime)
  end
  if self.lockTime then
    self.lockTime:SetActive(lockTime)
    if lockTime then
      self._openTime = openTime
      self._timerCb = timerCb
      self:InitTimer()
    end
  end
  self.isLock = lockMission or lockTime
end

function UIN25HardLevelBtn:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UIN25HardLevelBtn:InitTimer()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:ShowTime()
  end)
  self:ShowTime()
end

function UIN25HardLevelBtn:ShowTime()
  local nowTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local sec = self._openTime - nowTime
  if 0 <= sec then
    local secStr = HelperProxy:GetInstance():Time2Tex(sec)
    self.lockTimeTex:SetText(StringTable.Get("str_n25_hard_level_open_time_str", secStr))
  else
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
    end
    if self._timerCb then
      self._timerCb()
    end
  end
end

function UIN25HardLevelBtn:SetSelect(bSelect, localPosition)
  self.select:SetActive(bSelect)
  self.unSelect:SetActive(not bSelect)
  local color = self.logName.color
  if bSelect then
    color.a = 1
  else
    color.a = 0.5
  end
  self.levelBtn.interactable = not bSelect
end

function UIN25HardLevelBtn:LevelBtnOnClick(go)
  if self.clickCallback then
    self.clickCallback()
  end
end
