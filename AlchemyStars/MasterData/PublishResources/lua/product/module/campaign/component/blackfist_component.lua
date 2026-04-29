require("component_base")
_class("BlackfistComponent", ICampaignComponent)
BlackfistComponent = BlackfistComponent

function BlackfistComponent:Constructor()
  self.m_component_info = BlackfistComponentInfo:New()
end

function BlackfistComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = BlackfistComponentInfo:New()
  end
  return self.m_component_info
end

function BlackfistComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function BlackfistComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_BLACKFIST
end

function BlackfistComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function BlackfistComponent:GetCampaignMissionComponentId()
  return ECampaignMissionComponentId.ECampaignMissionComponentId_Blackfist
end

function BlackfistComponent:GetCampaignMissionParamKeyMap()
  local ComponentInfo = self:ComponentInfo()
  local nCfgId = self:GetComponetCfgId(ComponentInfo.m_campaign_id, ComponentInfo.m_component_id)
  return {
    [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = nCfgId,
    [ECampaignMissionParamKey.ECampaignMissionParamKey_BlackfistdayId] = ComponentInfo.cur_day_index
  }
end

function BlackfistComponent:CampaignComponentPushNotify(notify_data)
  if BlackfistComponentNotifyType.BlackfistComponentNotify_ScoreChanged == notify_data.m_notify_type then
    local ev = NotifyBlackfistScoreChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:OnScoreChanged(ev)
    else
      Log.error("[CampaignCom][BlackfistComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function BlackfistComponent:OnScoreChanged(notify_data)
  self.m_component_info.score_infos = notify_data.score
end

function BlackfistComponent:OnEnterBlackFist()
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(timeModule:GetServerTime() / 1000)
  LocalDB.SetInt("LAST_ENTER_BLACKFIST_TIME" .. GameGlobal.GameLogic().msdkAuthorityInfo.open_id, curTime)
end

function BlackfistComponent:ShowRedDot()
  if not self:ComponentIsOpen() then
    return false
  end
  local loginModule = GameGlobal.GetModule(LoginModule)
  local nextRefreshTime = loginModule:GetCampaignRefreshTime()
  local lastRefreshTime = nextRefreshTime - 86400
  local enterTime = LocalDB.GetInt("LAST_ENTER_BLACKFIST_TIME" .. GameGlobal.GameLogic().msdkAuthorityInfo.open_id, 0)
  local ret = lastRefreshTime > enterTime
  return ret
end
