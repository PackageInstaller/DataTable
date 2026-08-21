_class("UIHomeLandDiaryEnterItem", UICustomWidget)
UIHomeLandDiaryEnterItem = UIHomeLandDiaryEnterItem

function UIHomeLandDiaryEnterItem:LoadDataOnEnter(TT, res, uiParams)
end

function UIHomeLandDiaryEnterItem:_InitWidget()
  self._titleText = self:GetUIComponent("UILocalizationText", "titleText")
  self._contentText = self:GetUIComponent("UILocalizationText", "contentText")
  self._tipText = self:GetUIComponent("UILocalizationText", "tipText")
  self._newGo = self:GetGameObject("new")
  self._numGo = self:GetGameObject("num")
  self._numText = self:GetUIComponent("UILocalizationText", "numText")
  self._luckImg = self:GetGameObject("luckImg")
  self._bgRawImg = self:GetUIComponent("RawImageLoader", "bgImage")
  self._titleRawImg = self:GetUIComponent("RawImageLoader", "titleImg")
  self._bgRaw = self:GetUIComponent("RawImage", "bgImage")
  self._titleRaw = self:GetUIComponent("RawImage", "titleImg")
end

function UIHomeLandDiaryEnterItem:Flush(type, data, helper, callback)
  self._type = type
  self._callBack = callback
  self._localData = helper
  self:Refresh()
end

function UIHomeLandDiaryEnterItem:OnShow(uiParams)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self:_InitWidget()
  self:SetCustomTimeStr_Common()
end

function UIHomeLandDiaryEnterItem:Refresh()
  local unlock = self._homelandModule:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_STORY_TASK)
  self._luckImg:SetActive(false)
  self._newGo:SetActive(false)
  self._numGo:SetActive(false)
  if self._type == DiaryOpenType.Diary then
    self._titleText:SetText(StringTable.Get("str_homeland_diaryenter"))
    self._contentText:SetText(StringTable.Get("str_homeland_diaryenter"))
    self._bgRawImg:LoadImage("n19csj_rukou_di02")
    self._titleRawImg:LoadImage("n19csj_rukou_di04")
  elseif self._type == DiaryOpenType.Story then
    self:TimeEvent()
    self._luckImg:SetActive(not self._timeUnlock or not unlock)
    self._titleText:SetText(StringTable.Get("str_homeland_storytaskenter"))
    self._contentText:SetText(StringTable.Get("str_homeland_storytaskenter"))
    self._bgRawImg:LoadImage("n19csj_rukou_di03")
    self._titleRawImg:LoadImage("n19csj_rukou_di05")
    local colorlock = Color(0.2823529411764706, 0.2823529411764706, 0.2823529411764706)
    local colorunlock = Color(1, 1, 1)
    self._bgRaw.color = unlock and self._timeUnlock and colorunlock or colorlock
    self._titleRaw.color = unlock and self._timeUnlock and colorunlock or colorlock
  end
  self:SetNewAndNum()
end

function UIHomeLandDiaryEnterItem:SetNewAndNum()
  if self._type == DiaryOpenType.Diary then
    local count = self._localData:GetDairyEventCount()
    self._numText:SetText(count)
    self._numGo:SetActive(0 < count)
  elseif self._type == DiaryOpenType.Story then
    self._newGo:SetActive(self._localData:CheckNew())
  end
end

function UIHomeLandDiaryEnterItem:OnHide()
  if self.teActivity then
    self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
    self.teActivity = nil
  end
end

function UIHomeLandDiaryEnterItem:_AttachEvents()
end

function UIHomeLandDiaryEnterItem:_DetachEvents()
end

function UIHomeLandDiaryEnterItem:BtnOnClick()
  if self._type == DiaryOpenType.Story then
    if not self._localData.HasUnLockPrefs() then
      self._localData.SetUnLockPrefs()
    end
    local unlock = self._homelandModule:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_STORY_TASK)
    if not unlock then
      ToastManager.ShowHomeToast(StringTable.Get("str_homeland_storytask_btnclick_close"))
      return
    end
    if not self._timeUnlock then
      local svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
      local servertime = math.floor(svrTimeModule:GetServerTime() * 0.001)
      local beginTime = HelperProxy:GetInstance():FormatDateTime(self._globalCfgTime)
      local set = Cfg.cfg_homeland_global.StoryTaskMenuTime.IntValue
      local type = set == 0 and Enum_DateTimeZoneType.E_ZoneType_GMT or Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
      local loginModule = GameGlobal.GetModule(LoginModule)
      local time = loginModule:GetTimeStampByTimeStr(self._globalCfgTime, type)
      local timeStr = UIActivityHelper.GetFormatTimerStr(time - servertime, self._customStr)
      ToastManager.ShowHomeToast(string.format(StringTable.Get("str_homeland_storytask_time_unlock", timeStr)))
      return
    end
  end
  if self._callBack then
    self._callBack(self, self._type)
  end
end

function UIHomeLandDiaryEnterItem:TimeEvent()
  self._timeUnlock = false
  self._globalCfgTime = Cfg.cfg_homeland_global.StoryTaskMenuTime.StrValue
  if self:CheckOpen(self._globalCfgTime) then
    self._timeUnlock = true
  end
  if not self._timeUnlock then
    if self.teActivity then
      self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
      self.teActivity = nil
    end
    self.teActivity = UIActivityHelper.StartTimerEvent(self.teActivity, function()
      self:FlushTaskCD()
    end, 1000)
    return
  end
end

function UIHomeLandDiaryEnterItem:CheckOpen(beginTime, timetype)
  local svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local loginModule = GameGlobal.GetModule(LoginModule)
  timetype = timetype or 0
  local type = timetype == 0 and Enum_DateTimeZoneType.E_ZoneType_GMT or Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
  local beginTime = loginModule:GetTimeStampByTimeStr(beginTime, type)
  if curTime >= beginTime then
    return true
  end
  return false
end

function UIHomeLandDiaryEnterItem:FlushTaskCD()
  if not self:CheckOpen(self._globalCfgTime) then
    local nowTimestamp = UICommonHelper.GetNowTimestamp()
    local beginTime = HelperProxy:GetInstance():FormatDateTime(self._globalCfgTime)
    beginTime = beginTime - nowTimestamp
    local timeStr = UIActivityHelper.GetFormatTimerStr(beginTime, self._customStr)
    self._tipText:SetText(timeStr)
  else
    self:Refresh()
    self._tipText:SetText("")
    self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
    self.teActivity = nil
  end
end

function UIHomeLandDiaryEnterItem:SetCustomTimeStr_Common()
  self:SetCustomTimeStr({
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_common_less_minute"
  })
end

function UIHomeLandDiaryEnterItem:SetCustomTimeStr(customStr)
  self._customStr = customStr
end
