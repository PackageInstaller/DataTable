_class("UIVigorousRewardController", UISideEnterCenterContentBase)
UIVigorousRewardController = UIVigorousRewardController

function UIVigorousRewardController:DoShow(uiParams)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self:CancelNew()
  self:GetComponents()
  self:OnValue()
end

function UIVigorousRewardController:DoInit(params)
end

function UIVigorousRewardController:DoHide()
end

function UIVigorousRewardController:DoDestroy()
end

function UIVigorousRewardController:GetComponents()
  self._cg = self:GetUIComponent("RawImageLoader", "cg")
  self._cgRect = self:GetUIComponent("RectTransform", "cg")
  self._title = self:GetUIComponent("UILocalizedTMP", "title")
  self._content = self:GetUIComponent("UILocalizationText", "content")
  self._timer = self:GetUIComponent("UILocalizationText", "time")
end

function UIVigorousRewardController:OnValue()
  local cfg = Cfg.cfg_quest_daily_extra_activity[1]
  if not cfg then
    Log.fatal("###[UIQuestDailyExtraInfoController] cfg is nil ! id --> ", 1)
  else
    local title = cfg.InfoTitle
    local cg = cfg.InfoCg
    local content = cfg.InfoContent
    local offset = cfg.CgOffset
    local timeTransform = cfg.TimeTransform
    self._cg:LoadImage(cg)
    self._title:SetText(StringTable.Get(title))
    self._content:SetText(StringTable.Get(content))
    if offset then
      self._cgRect.anchoredPosition = Vector2(offset[1], offset[2])
    end
    local loginModule = GameGlobal.GetModule(LoginModule)
    if timeTransform == 0 then
      self._endTime = loginModule:GetTimeStampByTimeStr(cfg.EndTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    elseif timeTransform == 1 then
      self._endTime = loginModule:GetTimeStampByTimeStr(cfg.EndTime, Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone)
    end
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

function UIVigorousRewardController:ShowLessTime()
  local nowTime = math.ceil(self._svrTimeModule:GetServerTime() * 0.001)
  local sec = self._endTime - nowTime
  local timeStr
  if sec < 0 then
    sec = 0
  end
  timeStr = HelperProxy:GetInstance():Time2Tex(sec)
  if 0 < sec then
    self._timer:SetText(StringTable.Get("str_activity_powercost_time_main", timeStr))
  else
    self._timer:SetText(StringTable.Get("str_activity_error_109"))
  end
end

function UIVigorousRewardController:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
end

function UIVigorousRewardController:CancelNew()
  local pstID = GameGlobal.GetModule(RoleModule):GetPstId()
  LocalDB.SetInt("UIVigorousRewardEnter_New" .. pstID, 1)
end
