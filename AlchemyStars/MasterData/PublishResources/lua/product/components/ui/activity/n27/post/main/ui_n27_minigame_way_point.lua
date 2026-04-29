_class("UIN27MiniGameWayPoint", UICustomWidget)
UIN27MiniGameWayPoint = UIN27MiniGameWayPoint

function UIN27MiniGameWayPoint:OnShow(uiParams)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self:_GetComponents()
end

function UIN27MiniGameWayPoint:_GetComponents()
  self._di = self:GetGameObject("di")
  self._diImg = self:GetUIComponent("Image", "di")
  self._diImg2 = self:GetUIComponent("Image", "di2")
  self._nameBg = self:GetUIComponent("Image", "NameBg")
  self._headBg = self:GetUIComponent("RawImageLoader", "Head")
  self._lock = self:GetGameObject("lock")
  self._lock2 = self:GetGameObject("lock2")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._description = self:GetUIComponent("UILocalizationText", "Description")
  self._redPoint = self:GetGameObject("RedPoint")
  self._newPoint = self:GetGameObject("NewPoint")
  self._btn = self:GetGameObject("btn")
  self._atlas = self:GetAsset("UIN27PostStation.spriteatlas", LoadType.SpriteAtlas)
  self._animation = self:GetUIComponent("Animation", "ani")
  self._time = self:GetUIComponent("UILocalizationText", "Time")
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._maskObj = self:GetGameObject("Mask")
end

function UIN27MiniGameWayPoint:PlayAni()
  local aniIn = "uieff_UIN27MiniGameWayPoint_up"
  aniIn = self._index % 2 == 1 and "uieff_UIN27MiniGameWayPoint_up" or "uieff_UIN27MiniGameWayPoint_down"
  self._animation:Play(aniIn)
end

function UIN27MiniGameWayPoint:SetData(stagecontroller, index, cfg, miss_info, servertime, callback, showNew, isCurrent, missionLock)
  self._rectTransform.sizeDelta = Vector2.zero
  self._rectTransform.anchoredPosition = Vector2(cfg.MapPosX, cfg.MapPosY)
  self._stageController = stagecontroller
  self._index = index
  self._cfg = cfg
  self._miss_info = miss_info
  self._serverTime = servertime
  self._callBack = callback
  self._showNew = showNew
  self._isCurrent = isCurrent
  self._missionLock = missionLock
  local loginModule = GameGlobal.GetModule(LoginModule)
  self._unlockTime = loginModule:GetTimeStampByTimeStr(cfg.UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  self._scrollRect = self._stageController:GetUIComponent("ScrollRect", "ScrollView")
  if self._btn then
    self.etl = UICustomUIEventListener.Get(self._btn)
    self:AddUICustomEventListener(self.etl, UIEvent.BeginDrag, function(eventData)
      self._draging = true
      self._scrollRect:OnBeginDrag(eventData)
    end)
    self:AddUICustomEventListener(self.etl, UIEvent.Drag, function(eventData)
      self._scrollRect:OnDrag(eventData)
    end)
    self:AddUICustomEventListener(self.etl, UIEvent.EndDrag, function(eventData)
      self._draging = false
      self._scrollRect:OnEndDrag(eventData)
    end)
  end
  self:_SetUIInfo()
end

function UIN27MiniGameWayPoint:_SetUIInfo()
  self:RefreshRedpointState(self._miss_info)
  self:RefreshUnLockState(self._serverTime, self._missionLock)
end

function UIN27MiniGameWayPoint:RefreshRedNew()
  self:RefreshRedpointState(self._miss_info)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UISideEnterItemRefreshRedNew)
end

function UIN27MiniGameWayPoint:RefreshUnLockState(servertime, missionLock)
  self._serverTime = servertime
  self._missionLock = missionLock
  self._name:SetText(StringTable.Get(self._cfg.Title))
  self._lock:SetActive(self._unlockTime > self._serverTime)
  self._lock2:SetActive(self._missionLock and self._unlockTime <= self._serverTime)
  if self._unlockTime > self._serverTime or self._missionLock then
    self._headBg:LoadImage(self._cfg.BgLock)
    self._maskObj:SetActive(true)
  else
    self._maskObj:SetActive(false)
    if self._missionLock then
      self._name:SetText(StringTable.Get("str_n27_poststation_lock_title"))
    else
      self._name:SetText(StringTable.Get(self._cfg.Title))
    end
    self._headBg:LoadImage(self._cfg.Bg)
  end
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  if self._unlockTime > self._serverTime then
    self:RefreshWayPointStatus()
    self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:RefreshWayPointStatus()
    end)
  end
end

function UIN27MiniGameWayPoint:RefreshRedpointState(miss_info)
  local showredpoint = self:_CheckRedpoint(miss_info)
  self._redPoint:SetActive(showredpoint)
  self._newPoint:SetActive(self:_CheckNewpoint(self._index) and not self._missionLock)
end

function UIN27MiniGameWayPoint:_CheckRedpoint(miss_info)
  if not miss_info then
    return false
  end
  if #miss_info.can_get_target_list > 0 then
    return true
  end
  return false
end

function UIN27MiniGameWayPoint:_CheckNewpoint(index)
  if not self._showNew then
    return false
  end
  local key = self:GetNewFlagKey(index)
  local hasNew = LocalDB.GetInt("UIN42MiniGameWayPoint" .. key)
  if 0 < hasNew then
    return false
  end
  return true
end

function UIN27MiniGameWayPoint:GetNewFlagKey(id)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. id
  return key
end

function UIN27MiniGameWayPoint:BtnOnClick(go)
  if self._unlockTime > self._serverTime then
    ToastManager.ShowToast(StringTable.Get("str_n27_poststation_lock"))
    return
  end
  if self._missionLock then
    ToastManager.ShowToast(StringTable.Get("str_n27_poststation_lock_preposition_mission_tip"))
    return
  end
  if self:_CheckNewpoint(self._index) then
    self._newPoint:SetActive(false)
  end
  if self._showNew then
    self._showNew = false
  end
  self._callBack(self._index)
end

function UIN27MiniGameWayPoint:RefreshClickStatus(clickIndex)
  if self._index == clickIndex then
    if self._unlockTime > self._serverTime or self._missionLock then
      self._headBg:LoadImage(self._cfg.BgLock)
    else
      self._headBg:LoadImage(self._cfg.BgSelect)
    end
    self._nameBg.sprite = self._atlas:GetSprite("n27_yz_xxg_btndi02")
  else
    if self._unlockTime > self._serverTime or self._missionLock then
      self._headBg:LoadImage(self._cfg.BgLock)
    else
      self._headBg:LoadImage(self._cfg.Bg)
    end
    self._nameBg.sprite = self._atlas:GetSprite("n27_yz_xxg_btndi01")
  end
  local showFinish = self._miss_info ~= nil and self._miss_info.suc == 1 and #self._miss_info.can_get_target_list == 0 and #self._miss_info.already_get_target_list == 3
  self._diImg.gameObject:SetActive(not showFinish)
  self._diImg2.gameObject:SetActive(showFinish)
end

function UIN27MiniGameWayPoint:LockOnClick(go)
  if self._unlockTime > self._serverTime then
    ToastManager.ShowToast(StringTable.Get("str_n27_poststation_lock"))
    return
  end
  if self._missionLock then
    ToastManager.ShowToast(StringTable.Get("str_n27_poststation_lock_mission_tip"))
  end
end

function UIN27MiniGameWayPoint:RefreshData(data)
  self._miss_info = data
end

function UIN27MiniGameWayPoint:RefreshWayPointStatus()
  local servertime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local time = self._unlockTime - servertime
  if time < 0 then
    if self._timerHandler then
      GameGlobal.Timer():CancelEvent(self._timerHandler)
      self._timerHandler = nil
    end
    self._stageController:_RefreshWayPointWayLineInfo()
    self._newPoint:SetActive(not self._missionLock)
  end
  local str = self:_GetRemainTime(time)
  self._time:SetText(str)
end

function UIN27MiniGameWayPoint:_GetRemainTime(time)
  local day, hour, minute
  day = math.floor(time / 86400)
  hour = math.floor(time / 3600) % 24
  minute = math.floor(time / 60) % 60
  local timestring = ""
  if 0 < day then
    timestring = day .. StringTable.Get("str_activity_common_day") .. hour .. StringTable.Get("str_activity_common_hour")
  elseif 0 < hour then
    timestring = hour .. StringTable.Get("str_activity_common_hour") .. minute .. StringTable.Get("str_activity_common_minute")
  elseif 0 < minute then
    timestring = minute .. StringTable.Get("str_activity_common_minute")
  else
    timestring = StringTable.Get("str_activity_common_less_minute")
  end
  return string.format(StringTable.Get("str_activity_common_over"), timestring)
end

function UIN27MiniGameWayPoint:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIN27MiniGameWayPoint:GetRectTransform()
  return self._rectTransform
end
