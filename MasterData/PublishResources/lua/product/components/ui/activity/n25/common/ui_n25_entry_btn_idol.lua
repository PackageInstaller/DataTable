_class("UIN25EntryBtnIdol", UIN25EntryBtnBase)
UIN25EntryBtnIdol = UIN25EntryBtnIdol

function UIN25EntryBtnIdol:OnShow(uiParams)
  self:InitWidget()
  self.stageCount = 0
  self.secondsPerDay = 86400
end

function UIN25EntryBtnIdol:OnHide()
  self:CancelTimeEvent()
end

function UIN25EntryBtnIdol:RefreshState(activityConst)
  self.activityConst = activityConst
  self:RefreshStageCount()
  self:RefreshStateInternal()
  self:CancelTimeEvent()
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    self:RefreshStateInternal()
  end)
end

function UIN25EntryBtnIdol:RefreshStageCount()
  self.stageCount = 1
  local c, cInfo = self.activityConst:GetIdolComponent()
  if nil == cInfo then
    return
  end
  local cId = cInfo.m_campaign_id * 100000 + cInfo.m_component_type * 100 + cInfo.m_component_id
  local cfgs = Cfg.cfg_component_idol_round({ComponentID = cId})
  for k, v in pairs(cfgs) do
    if v.UnlockTime and v.UnlockTime > self.stageCount then
      self.stageCount = v.UnlockTime
    end
  end
end

function UIN25EntryBtnIdol:RefreshStateInternal()
  local idol_open_state = 0
  local idol_open_state_key = "UIN25IdolOpenStateKey_fk"
  local c, cInfo = self.activityConst:GetIdolComponent()
  if nil == cInfo then
    return
  end
  local new = self.activityConst:CheckGameIdolNew()
  local red = self.activityConst:CheckGameIdolRed()
  self:SetLock(true)
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  local unlockTime = cInfo.m_unlock_time
  local closeTime = cInfo.m_close_time
  local state = self.activityConst:GetStateGameIdol()
  if state == UISummerOneEnterBtnState.NotOpen then
    local unlockTime = cInfo.m_unlock_time
    local seconds = math.floor(unlockTime - nowTimestamp)
    local timeStr = UIActivityN25Const.GetTimeString(seconds)
    local timeTips = StringTable.Get("str_n25_activity_remain_open_time", timeStr)
    self:SetLeftTime(timeTips)
  elseif state == UISummerOneEnterBtnState.Locked then
    self:SetLeftTimeShow(true)
    self:SetLeftTime(StringTable.Get("str_n25_hardlevel_locktip"))
    self:CancelTimeEvent()
  elseif state == UISummerOneEnterBtnState.Normal then
    self:SetLock(false)
    local nowTimestamp = UICommonHelper.GetNowTimestamp()
    local curStage = math.floor((nowTimestamp - unlockTime) / self.secondsPerDay) + 1
    local timeTips
    if curStage <= 1 then
      idol_open_state = 1
    elseif curStage <= 2 then
      idol_open_state = 2
    else
      idol_open_state = 3
    end
    local val = LocalDB.GetInt(idol_open_state_key, 0)
    if red or idol_open_state == 1 then
    elseif idol_open_state == 2 then
      red = idol_open_state ~= val
    else
      red = idol_open_state ~= val
    end
    local timeGo = self:GetGameObject("leftTime")
    local showTime = false
    if idol_open_state == 3 then
    elseif idol_open_state ~= val then
    elseif idol_open_state == 1 then
      showTime = true
    elseif idol_open_state == 2 then
      showTime = true
    end
    timeGo:SetActive(showTime)
    if showTime then
      local seconds = math.floor(unlockTime + curStage * self.secondsPerDay - nowTimestamp)
      local timeStr = UIActivityN25Const.GetTimeString(seconds)
      timeTips = StringTable.Get("str_n25_activity_next_open", timeStr)
    end
    self:SetLeftTime(timeTips)
  elseif state == UISummerOneEnterBtnState.Closed then
    self:SetLeftTime(StringTable.Get("str_n25_activity_end"))
    self:CancelTimeEvent()
  end
  self:SetNewAndRed(new, red)
end

function UIN25EntryBtnIdol:CancelTimeEvent()
  self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
end
