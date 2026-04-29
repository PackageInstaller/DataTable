_class("TimeLoginComponent", ICampaignComponent)
TimeLoginComponent = TimeLoginComponent

function TimeLoginComponent:Constructor()
  self._componentInfo = TimeLoginComponentInfo:New()
end

function TimeLoginComponent:ComponentInfo()
  if not self._componentInfo then
    self._componentInfo = TimeLoginComponentInfo:New()
  end
  return self._componentInfo
end

function TimeLoginComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function TimeLoginComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_TIME_LOGIN
end

function TimeLoginComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self._componentInfo)
  return ret
end

function TimeLoginComponent:HandleReceiveTimeLoginReward(TT, asyncRes, cfgID)
  local request = TimeLoginComponentReceiveRewardReq:New()
  request.m_cfg_id = cfgID
  local response = TimeLoginComponentReceiveRewardRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if response ~= nil and table.count(response.m_info) > 0 then
    self._componentInfo.m_info = response.m_info
  end
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][TimeLoginComponent] HandleReceiveTimeLoginReward ret:", asyncRes.m_result)
    return nil
  end
  return response.m_rewards
end

function TimeLoginComponent:CampaignComponentPushNotify(notify_data)
  if TimeLoginComponentNotifyType.TimeLoginComponentNotify_Changed == notify_data.m_notify_type then
    local ev = NotifyPointTimeLoginComponentChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self._componentInfo.m_count = ev.m_count
      self._componentInfo.m_info = ev.m_info
    else
      Log.error("[CampaignCom][TimeLoginComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function TimeLoginComponent:Start_HandleReceiveTimeLoginReward(cfgID, callback)
  local lockName = "Start_HandleReceiveTimeLoginReward"
  GameGlobal.UIStateManager():Lock(lockName)
  TaskManager:GetInstance():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local rewards = self:HandleReceiveTimeLoginReward(TT, res, cfgID)
    GameGlobal.UIStateManager():UnLock(lockName)
    callback(res, rewards)
  end)
end

function TimeLoginComponent:GetCellState(cfgID)
  local info = self:GetComponentInfo()
  return info.m_info[cfgID]
end

function TimeLoginComponent:GetCellPointCount()
  local info = self:GetComponentInfo()
  return info.m_count
end
