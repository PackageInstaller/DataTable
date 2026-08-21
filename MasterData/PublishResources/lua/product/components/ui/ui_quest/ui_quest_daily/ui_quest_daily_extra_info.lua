_class("UIQuestDailyExtraInfoController", UIController)
UIQuestDailyExtraInfoController = UIQuestDailyExtraInfoController

function UIQuestDailyExtraInfoController:OnShow(uiParams)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._size = 68
  local type = Localization.GetCurLanguage()
  if LanguageType.zh == type then
  elseif LanguageType.tw == type then
  elseif LanguageType.us == type then
    self._size = 50
  elseif LanguageType.kr == type then
  elseif LanguageType.jp == type then
    self._size = 60
  elseif LanguageType.pt == type then
    self._size = 36
  elseif LanguageType.es == type then
    self._size = 32
  elseif LanguageType.idn == type then
    self._size = 50
  elseif LanguageType.th == type then
  end
  self:GetComponents()
  self:OnValue()
end

function UIQuestDailyExtraInfoController:GetComponents()
  self._cg = self:GetUIComponent("RawImageLoader", "cg")
  self._cgRect = self:GetUIComponent("RectTransform", "cg")
  self._title = self:GetUIComponent("UILocalizedTMP", "title")
  self._content = self:GetUIComponent("UILocalizationText", "content")
  self._timer = self:GetUIComponent("UILocalizationText", "time")
end

function UIQuestDailyExtraInfoController:OnValue()
  local cfg = Cfg.cfg_quest_daily_extra_activity[1]
  if not cfg then
    Log.fatal("###[UIQuestDailyExtraInfoController] cfg is nil ! id --> ", 1)
  else
    local title = cfg.InfoTitle
    local cg = cfg.InfoCg
    local content = cfg.InfoContent
    local offset = cfg.CgOffset
    self._cg:LoadImage(cg)
    self._title.fontSize = self._size
    self._title:SetText(StringTable.Get(title))
    self._content:SetText(StringTable.Get(content))
    if offset then
      self._cgRect.anchoredPosition = Vector2(offset[1], offset[2])
    end
    local loginModule = GameGlobal.GetModule(LoginModule)
    self._endTime = loginModule:GetTimeStampByTimeStr(cfg.EndTime, Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone)
    self:ShowLessTime()
    if self._event then
      GameGlobal.Timer():CancelEvent(self._event)
      self._event = nil
    end
    self._event = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:ShowLessTime()
    end)
  end
end

function UIQuestDailyExtraInfoController:ShowLessTime()
  local nowTime = math.ceil(self._svrTimeModule:GetServerTime() * 0.001)
  local sec = self._endTime - nowTime
  local timeStr
  if sec < 0 then
    sec = 0
  end
  timeStr = HelperProxy:GetInstance():Time2Tex(sec)
  self._timer:SetText(StringTable.Get("str_n11_rose_less_time", timeStr))
end

function UIQuestDailyExtraInfoController:bgOnClick(go)
  self:CloseDialog()
end

function UIQuestDailyExtraInfoController:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
end
