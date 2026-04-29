_class("UIActivityReturnSystemTabBoost", UICustomWidget)
UIActivityReturnSystemTabBoost = UIActivityReturnSystemTabBoost

function UIActivityReturnSystemTabBoost:OnShow(uiParams)
  self.txtDropTimes = self:GetUIComponent("UILocalizationText", "txtDropTimes")
  self.btnFight = self:GetGameObject("btnFight")
  self.txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self.bg = self:GetUIComponent("RawImageLoader", "bg")
  self.tripleDurationGo = self:GetGameObject("tripleDurationGo")
end

function UIActivityReturnSystemTabBoost:OnHide()
  self:CancelTimerEventDropTimes()
end

function UIActivityReturnSystemTabBoost:SetData(campaign, remainingTimeCallback, tipsCallback, isBoostIntro)
  self._campaign = campaign
  self._component = UIActivityReturnSystemHelper.GetComponentByTabName(self._campaign, "boost", 1)
  self.remainingTimeCallback = remainingTimeCallback
  self:Flush()
  if isBoostIntro then
    self.btnFight:SetActive(false)
  else
    self._component:CloseTodayRedPoint()
  end
  self:_RefreshTripleReward()
end

function UIActivityReturnSystemTabBoost:Flush()
  local curTimes, maxTimex = self._component:GetBoostTimes()
  local leftTimes = maxTimex - curTimes
  local str = StringTable.Get("str_return_system_extra_drop_times", leftTimes, maxTimex)
  self.txtDropTimes:SetText(str)
  
  local function RegisterTimeEvent(seconds)
    self:CancelTimerEventDropTimes()
    self.te = GameGlobal.Timer():AddEvent(seconds * 1000, function()
      self:Flush()
    end)
  end
  
  local resetTime = self._component:GetNextTimestamp()
  local leftSeconds = UICommonHelper.CalcLeftSeconds(resetTime)
  RegisterTimeEvent(leftSeconds)
  if self.remainingTimeCallback then
    self.remainingTimeCallback(resetTime)
  end
end

function UIActivityReturnSystemTabBoost:CancelTimerEventDropTimes()
  if self.te then
    GameGlobal.Timer():CancelEvent(self.te)
  end
end

function UIActivityReturnSystemTabBoost:btnFightOnClick(go)
  local curTimes, maxTimex = self._component:GetBoostTimes()
  if maxTimex <= curTimes then
    ToastManager.ShowToast(StringTable.Get("str_return_system_extra_drop_times_not_enough"))
    return
  end
  local uiJumpModule = GameGlobal.GetUIModule(QuestModule)
  local jumpID = UIJumpType.UI_JumpResDungeon
  local jumpParam
  uiJumpModule:SetJumpUIData(jumpID, jumpParam)
  uiJumpModule:Jump()
end

function UIActivityReturnSystemTabBoost:_RefreshTripleReward()
  local bTriple = false
  local strBegin = Cfg.cfg_global.ActiveBackFlowStartTime.StrValue
  local strEnd = Cfg.cfg_global.ActiveBackFlowEndTime.StrValue
  if strBegin and strEnd then
    local loginModule = GameGlobal.GetModule(LoginModule)
    local srvTime = GameGlobal.GetModule(SvrTimeModule)
    local curTime = math.floor(srvTime:GetServerTime() * 0.001)
    local beginTime = loginModule:GetTimeStampByTimeStr(strBegin, Enum_DateTimeZoneType.E_ZoneType_GMT)
    local endTime = loginModule:GetTimeStampByTimeStr(strEnd, Enum_DateTimeZoneType.E_ZoneType_GMT)
    if curTime >= beginTime and curTime < endTime then
      bTriple = true
    end
  end
  self.tripleDurationGo:SetActive(bTriple)
  if bTriple then
    self.bg:LoadImage("huiliu_zhuli_bg1_1")
    self.txtDesc:SetText(StringTable.Get("str_return_system_desc_1"))
  else
    self.bg:LoadImage("huiliu_zhuli_bg1")
    self.txtDesc:SetText(StringTable.Get("str_return_system_desc"))
  end
end
