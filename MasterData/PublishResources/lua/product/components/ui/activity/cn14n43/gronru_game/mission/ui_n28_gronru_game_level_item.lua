local UIN28GronruGameLevelItemState = {
  Normal = 1,
  Lock = 2,
  Pass = 3
}
_enum("UIN28GronruGameLevelItemState", UIN28GronruGameLevelItemState)
_class("UIN28GronruGameLevelItem", Object)
UIN28GronruGameLevelItem = UIN28GronruGameLevelItem

function UIN28GronruGameLevelItem:Constructor(uiview)
  self._view = uiview
  self._normal = self._view:GetUIComponent("Image", "normal")
  self._pass = self._view:GetUIComponent("Image", "pass")
  self._way = self._view:GetGameObject("way")
  self._close = self._view:GetUIComponent("Image", "close")
  self._redPoint = self._view:GetGameObject("redPoint")
  self._animation = self._view:GetUIComponent("Animation", "anim")
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
end

function UIN28GronruGameLevelItem:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIN28GronruGameLevelItem:Flush(index, cfg, passInfo, cur, atlas, manager)
  self._cfg = cfg
  local levelCfg = UIN28GronruGameLevel.LevelCfg[index]
  self._normal.sprite = atlas:GetSprite(levelCfg.normal)
  self._pass.sprite = atlas:GetSprite(levelCfg.pass)
  self._close.sprite = atlas:GetSprite(levelCfg.close)
  self._passInfo = passInfo
  self._manager = manager
  self._index = index
  self._curlevel = cur
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self._serverTime = self._svrTimeModule:GetServerTime() * 0.001
  local loginModule = GameGlobal.GetModule(LoginModule)
  self._unlockTime = loginModule:GetTimeStampByTimeStr(self._cfg.UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  if self._unlockTime > self._serverTime then
    self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:CheckUnLock()
    end)
  end
  local state = 0
  if passInfo then
    state = passInfo.status
  end
  if state == 1 then
    if not passInfo then
      Log.exception("没有通关信息：", index)
    end
    self:SetUiState(self._unlockTime > self._serverTime and UIN28GronruGameLevelItemState.Lock or UIN28GronruGameLevelItemState.Pass)
  elseif state == 0 then
    if index == cur then
      local state = self._unlockTime > self._serverTime and UIN28GronruGameLevelItemState.Lock or UIN28GronruGameLevelItemState.Normal
      self:SetUiState(state)
    else
      self:SetUiState(UIN28GronruGameLevelItemState.Lock)
    end
  end
end

function UIN28GronruGameLevelItem:SetUiState(uiState)
  self._pass.gameObject:SetActive(false)
  self._close.gameObject:SetActive(false)
  if UIN28GronruGameLevelItemState.Normal == uiState then
    self._normal.gameObject:SetActive(true)
  elseif UIN28GronruGameLevelItemState.Lock == uiState then
    self._close.gameObject:SetActive(true)
  elseif UIN28GronruGameLevelItemState.Pass == uiState then
    local count = 0
    if self._passInfo then
      for index, value in pairs(self._passInfo.enties_list) do
        count = count + 1
      end
    end
    self._pass.gameObject:SetActive(count == 3)
  end
end

function UIN28GronruGameLevelItem:CheckUnLock()
  self._serverTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local time = self._unlockTime - self._serverTime
  if time < 0 then
    if self._timerHandler then
      GameGlobal.Timer():CancelEvent(self._timerHandler)
      self._timerHandler = nil
    end
    self:SetUiState(self._index == self._curlevel and UIN28GronruGameLevelItemState.Normal or UIN28GronruGameLevelItemState.Lock)
  end
end

function UIN28GronruGameLevelItem:GetUnLockState()
  local serverTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  if serverTime < self._unlockTime then
    return false
  end
  return true
end

function UIN28GronruGameLevelItem:GetUnLockTime()
  local serverTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  return self._unlockTime - serverTime
end

function UIN28GronruGameLevelItem:FlushData(data)
  self._passInfo = data
end

function UIN28GronruGameLevelItem:SetRedPoint()
  self._redPoint:SetActive(false)
  if self._passInfo then
    for index, value in pairs(self._passInfo.enties_list) do
      if value == 1 then
        self._redPoint:SetActive(true)
        break
      end
    end
  else
    self._redPoint:SetActive(false)
  end
end
