_class("UIDiscoveryDiffChaptersWeight", UICustomWidget)
UIDiscoveryDiffChaptersWeight = UIDiscoveryDiffChaptersWeight
local LockType = {
  NoLock = 1,
  TimeLock = 2,
  ForceLock = 3
}
_enum("LockType", LockType)

function UIDiscoveryDiffChaptersWeight:Constructor()
end

function UIDiscoveryDiffChaptersWeight:OnShow()
  self._isDiff = false
  self._lockType = LockType.NoLock
  self:GetComponent()
end

function UIDiscoveryDiffChaptersWeight:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIDiscoveryDiffChaptersWeight:SetChapterId(chapterId, isDiff)
  self._isOpen = self:CheckOpenDiff()
  self._chapterId = chapterId
  self._isDiff = isDiff
  self._lockTyp = self:GetDiffCfgLockType()
  self:Init()
end

function UIDiscoveryDiffChaptersWeight:SetCallBack(normalClickCallBack, diffClickCallBack)
  self._normalClickCallBack = normalClickCallBack
  self._diffClickCallBack = diffClickCallBack
end

function UIDiscoveryDiffChaptersWeight:GetComponent()
  self._selet = self:GetGameObject("selet")
  self._diffBtn = self:GetGameObject("diffEnter")
  self._normBtn = self:GetGameObject("normEnter")
  self._lockImage = self:GetGameObject("lockImage")
  self._timeTip = self:GetUIComponent("UILocalizationText", "timeTip")
end

function UIDiscoveryDiffChaptersWeight:Init()
  self._isOpen = self:CheckOpenDiff()
  local unlock = true
  if self._lockTyp == LockType.TimeLock then
    unlock = self:CheckDiffTimeUnLock()
  else
    unlock = true
  end
  self._lockImage:SetActive(not unlock or self:IsForceLock())
  self._diffBtn:SetActive(self._isDiff)
  self._normBtn:SetActive(not self._isDiff)
  self._timeTip:SetText("")
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:LockTimer()
end

function UIDiscoveryDiffChaptersWeight:Refresh()
  self:OnSelect()
end

function UIDiscoveryDiffChaptersWeight:OnSelect()
  self._diffBtn:SetActive(self._isDiff)
  self._normBtn:SetActive(not self._isDiff)
  local unlock = true
  if self._lockTyp == LockType.TimeLock then
    unlock = self:CheckDiffTimeUnLock()
  else
    unlock = true
  end
  self._lockImage:SetActive(not unlock or self:IsForceLock())
end

function UIDiscoveryDiffChaptersWeight:CheckOpenDiff()
  local uiDiffMissionModule = GameGlobal.GetUIModule(DifficultyMissionModule)
  local chapter = uiDiffMissionModule:GetDiffChapterFromMission(self._chapterId)
  if not chapter then
    Log.debug("###[UIDiscovery] no diff ! id --> ", self._chapterId)
    return false
  end
  return true
end

function UIDiscoveryDiffChaptersWeight:NormEnterOnClick()
  if self:IsForceLock() then
    ToastManager.ShowToast(StringTable.Get("str_discovery_blackbox_force_locktip"))
    return
  end
  if self._lockTyp == LockType.TimeLock and not self:CheckDiffTimeUnLock() then
    local cfg = self:GetDiffDescCfg(self._chapterId)
    local unlockTime = UITimerHelper.GetTimeFormatByString(cfg.TimeUnLock)
    local lastTime = unlockTime - UITimerHelper.GetCurTime()
    ToastManager.ShowToast(StringTable.Get("str_discovery_blackbox_time_locktip", UITimerHelper.GetTimeString(lastTime)))
    return
  end
  local complete, lock
  if self._normalClickCallBack then
    complete, lock = self:_normalClickCallBack()
  end
  if not complete or lock == DiffMissionChapterStatus.Lock then
    return
  end
  self._isDiff = true
  self:Refresh()
end

function UIDiscoveryDiffChaptersWeight:DiffEnterOnClick()
  self._isDiff = false
  self:Refresh()
  if self._diffClickCallBack then
    self:_diffClickCallBack()
  end
end

function UIDiscoveryDiffChaptersWeight:SelectOnClick()
  if self._isDiff then
    self:DiffEnterOnClick()
  else
    self:NormEnterOnClick()
  end
end

function UIDiscoveryDiffChaptersWeight:LockTimer()
  if self._lockTyp ~= LockType.TimeLock then
    return
  end
  local cfg = self:GetDiffDescCfg(self._chapterId)
  local unlockTime = UITimerHelper.GetTimeFormatByString(cfg.TimeUnLock)
  
  local function timerCallBack()
    local lastTime = unlockTime - UITimerHelper.GetCurTime()
    self._timeTip:SetText(UITimerHelper.GetTimeString(lastTime))
    if self:CheckDiffTimeUnLock() then
      self._lockImage:SetActive(not self:CheckDiffTimeUnLock())
      if self._timerHandler then
        self._timeTip:SetText("")
        GameGlobal.Timer():CancelEvent(self._timerHandler)
        self._timerHandler = nil
      end
    end
  end
  
  if not self:CheckDiffTimeUnLock() then
    local unlockTime = UITimerHelper.GetTimeFormatByString(cfg.TimeUnLock)
    local lastTime = unlockTime - UITimerHelper.GetCurTime()
    self._timeTip:SetText(UITimerHelper.GetTimeString(lastTime))
    self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, timerCallBack)
  end
end

function UIDiscoveryDiffChaptersWeight:GetDiffDescCfg(checkChapterId)
  local cfg = Cfg.cfg_difficulty_mission_chapter_desc({PreMainChapterId = checkChapterId})
  if cfg then
    return cfg[1]
  end
end

function UIDiscoveryDiffChaptersWeight:CheckDiffTimeUnLock()
  if self._lockTyp ~= LockType.TimeLock then
    return
  end
  local cfg = self:GetDiffDescCfg(self._chapterId)
  if not cfg then
    return
  end
  if not cfg.TimeUnLock then
    return
  end
  local unlockTime = UITimerHelper.GetTimeFormatByString(cfg.TimeUnLock)
  local unlock = UITimerHelper.CheckTimeUnLock(unlockTime)
  return unlock
end

function UIDiscoveryDiffChaptersWeight:IsForceLock()
  return self._lockTyp == LockType.ForceLock
end

function UIDiscoveryDiffChaptersWeight:GetDiffCfgLockType()
  local type = LockType.NoLock
  local cfg = self:GetDiffDescCfg(self._chapterId)
  if cfg and cfg.TimeUnLock then
    type = LockType.TimeLock
  end
  if cfg and cfg.ForceLock and cfg.ForceLock == 1 then
    type = LockType.ForceLock
  end
  return type
end

function UIDiscoveryDiffChaptersWeight:CheckChapterDiffTimeUnlock(chapter)
  local cfg = self:GetDiffDescCfg(chapter)
  if not cfg then
    return
  end
  if not cfg.TimeUnLock then
    return
  end
  local unlockTime = UITimerHelper.GetTimeFormatByString(cfg.TimeUnLock)
  local unlock = UITimerHelper.CheckTimeUnLock(unlockTime)
  return unlock
end
