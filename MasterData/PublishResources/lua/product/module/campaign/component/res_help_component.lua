_class("ResHelpComponent", ICampaignComponent)
ResHelpComponent = ResHelpComponent

function ResHelpComponent:Constructor()
  self.m_component_info = CResHelpComponentInfo:New()
  self.m_local_next_refresh_time = -1
end

function ResHelpComponent:_GetLocalNextRefreshTime()
  if self.m_local_next_refresh_time < 0 then
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstid = roleModule:GetPstId()
    local l_key = pstid .. "ResHelpNextRefreshTime"
    local strNextRefreshTime = LocalDB.GetString(l_key, "0")
    local lNextRefreshTime = tonumber(strNextRefreshTime)
    self.m_local_next_refresh_time = lNextRefreshTime
  end
  return self.m_local_next_refresh_time
end

function ResHelpComponent:_SetLocalNextRefrehTime(_next_refreshTime_)
  self.m_local_next_refresh_time = _next_refreshTime_
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstid = roleModule:GetPstId()
  local l_key = pstid .. "ResHelpNextRefreshTime"
  LocalDB.SetString(l_key, tostring(_next_refreshTime_))
end

function ResHelpComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = CResHelpComponentInfo:New()
  end
  return self.m_component_info
end

function ResHelpComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function ResHelpComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_RES_HELP
end

function ResHelpComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function ResHelpComponent:HaveRedPoint()
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  if not time_mod then
    return false
  end
  local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
  local l_component_info = self:GetComponentInfo()
  if tmNowTime >= l_component_info.tmNextRefreshTimesTime then
    self.m_component_info.tmNextRefreshTimesTime = self.m_component_info.tmNextRefreshTimesTime + 86400
  end
  local l_local_refresh_time = self:_GetLocalNextRefreshTime()
  if l_local_refresh_time == l_component_info.tmNextRefreshTimesTime then
    return false
  end
  if l_component_info.nTodayHelpTimes < l_component_info.nHelpDayLimitTimes then
    return true
  end
  return false
end

function ResHelpComponent:CloseTodayRedPoint()
  local l_component_info = self:GetComponentInfo()
  self:_SetLocalNextRefrehTime(l_component_info.tmNextRefreshTimesTime)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignComponentStepChange, l_component_info.m_campaign_id, nil, nil)
end

function ResHelpComponent:CampaignComponentPushNotify(notify_data)
  if CResHelpComponentNotifyType.CResHelpComponentNotifyType_ResHelpInfoChange == notify_data.m_notify_type then
    local ev = NotifyResHelpComponentInfoChange:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:OnUpdateBaseInfo(ev)
    else
      Log.error("[CampaignCom][ResHelpComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function ResHelpComponent:OnUpdateBaseInfo(ev)
  self:GetComponentInfo()
  self.m_component_info.nTodayHelpTimes = ev.nTodayHelpTimes
  self.m_component_info.tmNextRefreshTimesTime = ev.tmNextRefreshTimesTime
  self.m_component_info.nHelpDayLimitTimes = ev.nHelpDayLimitTimes
end

function ResHelpComponent:GetBoostTimes()
  local cInfo = self:GetComponentInfo()
  return cInfo.nTodayHelpTimes, cInfo.nHelpDayLimitTimes
end

function ResHelpComponent:GetNextTimestamp()
  local cInfo = self:GetComponentInfo()
  return cInfo.tmNextRefreshTimesTime
end
