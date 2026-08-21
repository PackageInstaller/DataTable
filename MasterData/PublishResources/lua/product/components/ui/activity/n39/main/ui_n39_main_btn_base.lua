_class("UIN39MainBtnBase", UICustomWidget)
UIN39MainBtnBase = UIN39MainBtnBase

function UIN39MainBtnBase:OnShow()
  self:AttachEvent(GameEventType.ItemCountChanged, self.OnItemCountChanged)
end

function UIN39MainBtnBase:OnItemCountChanged()
end

function UIN39MainBtnBase:GetUIComponents()
  self.svrTimeModule = self:GetModule(SvrTimeModule)
  self._timerTex = self:GetUIComponent("UISelectObjectPath", "timerTex")
  self._timerTexGo = self:GetGameObject("timerTex")
  self._newGo = self:GetGameObject("new")
  self._redGo = self:GetGameObject("red")
  self._maskGo = self:GetGameObject("mask")
  self._close = self:GetGameObject("close")
  self._lock = self:GetGameObject("lock")
  self:GetExtraUI()
end

function UIN39MainBtnBase:GetExtraUI()
end

function UIN39MainBtnBase:SetData(tagName, component, campaign)
  self.tagName = tagName
  self.component = component
  self.campaign = campaign
  self:GetUIComponents()
  self:OnValue()
end

function UIN39MainBtnBase:SetRefreshCallback(refreshCallback)
  self.refreshCallback = refreshCallback
end

function UIN39MainBtnBase:SetHideActive(val)
  self.hideTimer = val
end

function UIN39MainBtnBase:SetLockStateCallback(timeLockCb, lockCb, campaignEndCb, enterClickCb, newCb, redCb)
  self.timeLockCb = timeLockCb
  self.lockCb = lockCb
  self.campaignEndCb = campaignEndCb
  self.enterClickCb = enterClickCb
  self.newCb = newCb
  self.redCb = redCb
end

function UIN39MainBtnBase:OnValue()
  self.state = self:CheckState()
  self._timerTexGo:SetActive(false)
  self._newGo:SetActive(false)
  self._redGo:SetActive(false)
  self._maskGo:SetActive(false)
  self._close:SetActive(false)
  self._lock:SetActive(false)
  if self.state == EActivityComponentLockBtnState.Closed then
    self._maskGo:SetActive(true)
    self._close:SetActive(true)
  elseif self.state == EActivityComponentLockBtnState.LockWithTime then
    if not self.hideTimer then
      self._timerTexGo:SetActive(true)
      self:SetUnLockTimer()
    end
    self._maskGo:SetActive(true)
    self._lock:SetActive(true)
  elseif self.state == EActivityComponentLockBtnState.Lock then
    self._maskGo:SetActive(true)
    self._lock:SetActive(true)
  else
    if not self.hideTimer then
      self._timerTexGo:SetActive(true)
      self:SetOverTimer()
    end
    self:SetNewAndRed()
  end
  self:SetExtraValue()
end

function UIN39MainBtnBase:SetNewAndRed()
  local red = self.redCb(self.tagName)
  local new = self.newCb(self.tagName)
  self._newGo:SetActive(new)
  self._redGo:SetActive(red and not new)
end

function UIN39MainBtnBase:SetOverTimer()
  local closeTime = self.component:GetComponentInfo().m_close_time
  if not self._timerTexItem then
    self._timerTexItem = self._timerTex:SpawnObject("UIN39TimeBase")
    self._timerTexItem:Set_Time_Tex("str_n39_main_btn_less_time")
  end
  self._timerTexItem:SetData(closeTime, self.refreshCallback)
end

function UIN39MainBtnBase:SetUnLockTimer()
  local unlockTime = self.component:ComponentUnLockTime()
  if not self._timerTexItem then
    self._timerTexItem = self._timerTex:SpawnObject("UIN39TimeBase")
    self._timerTexItem:Set_Time_Tex("str_n39_main_btn_unlock_time")
  end
  self._timerTexItem:SetData(unlockTime, self.refreshCallback)
end

function UIN39MainBtnBase:SetExtraValue()
end

function UIN39MainBtnBase:CheckState()
  local curTime = math.floor(self.svrTimeModule:GetServerTime() * 0.001)
  local unlockTime = self.component:ComponentUnLockTime()
  local stamp = unlockTime - curTime
  if self.component:ComponentIsClose() then
    return EActivityComponentLockBtnState.Closed
  elseif 0 < stamp then
    return EActivityComponentLockBtnState.LockWithTime
  elseif not self.component:ComponentIsUnLock() then
    return EActivityComponentLockBtnState.Lock
  else
    return EActivityComponentLockBtnState.Unlock
  end
end

function UIN39MainBtnBase:BtnOnClick(go)
  if self.state == EActivityComponentLockBtnState.Closed then
    if self.campaignEndCb then
      self.campaignEndCb()
    end
  elseif self.state == EActivityComponentLockBtnState.LockWithTime then
    if self.timeLockCb then
      local curTime = math.floor(self.svrTimeModule:GetServerTime() * 0.001)
      local unlockTime = self.component:ComponentUnLockTime()
      local stamp = unlockTime - curTime
      local timeStr = HelperProxy:GetInstance():Time2Tex(stamp)
      self.timeLockCb(timeStr)
    end
  elseif self.state == EActivityComponentLockBtnState.Lock then
    if self.lockCb then
      local missionid = self.component:GetComponentInfo().m_need_mission_id
      local cfg_mission = Cfg.cfg_campaign_mission[missionid]
      local missionName = ""
      if cfg_mission then
        missionName = StringTable.Get(cfg_mission.Name)
      else
        Log.error("###[UIN39MainBtnBase] cfg_mission is nil ! id : ", missionid)
      end
      self.lockCb(missionName)
    end
  elseif self.enterClickCb then
    self.enterClickCb()
  end
end

_class("UIN39MainBtnExchange", UIN39MainBtnBase)
UIN39MainBtnExchange = UIN39MainBtnExchange

function UIN39MainBtnExchange:GetExtraUI()
  self._moneyGo = self:GetGameObject("Money")
  self._txtNum = self:GetUIComponent("UILocalizationText", "txtNum")
end

function UIN39MainBtnExchange:SetExtraValue()
  local itemId = self.component:GetCostItemId()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local count = itemModule:GetItemCount(itemId)
  count = math.min(count, 999999)
  local preZero = UIActivityHelper.GetZeroStrFrontNum(6, count)
  local str = UIActivityHelper.GetColorText("#9e826d", preZero, "#ffffff", tostring(count))
  self._txtNum:SetText(str)
end

function UIN39MainBtnExchange:OnItemCountChanged()
  self:SetExtraValue()
  self:SetNewAndRed()
end
