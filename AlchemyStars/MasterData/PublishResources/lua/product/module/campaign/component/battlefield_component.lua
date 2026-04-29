require("component_base")
_class("BattlefieldComponent", ICampaignComponent)
BattlefieldComponent = BattlefieldComponent

function BattlefieldComponent:Constructor()
  self.m_component_info = BattlefieldComponentInfo:New()
end

function BattlefieldComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = BattlefieldComponentInfo:New()
  end
  return self.m_component_info
end

function BattlefieldComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function BattlefieldComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_BATTLEFIELD
end

function BattlefieldComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function BattlefieldComponent:HandleBattlefieldDailyReset(TT, asyncRes)
  local request = BattlefieldComponentDailyResetReq:New()
  local response = BattlefieldComponentDailyResetRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][BattlefieldComponent] HandleBattlefieldDailyReset ret:", asyncRes.m_result)
    return nil
  end
  self.m_component_info.m_battlefield_info = response.m_battlefield_info
  asyncRes:SetSucc(true)
end

function BattlefieldComponent:CampaignComponentPushNotify(notify_data)
  if BattlefieldComponentNotifyType.BattlefieldComponentNotify_MilitaryExploitChanged == notify_data.m_notify_type then
    local ev = NotifyBattlefieldComponentMilitaryExploitChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:OnMilitaryExploitChanged(ev)
    else
      Log.error("[CampaignCom][BattlefieldComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function BattlefieldComponent:OnMilitaryExploitChanged(ev)
  self.m_component_info.m_battlefield_info.m_cur_max_military_exploit = ev.m_cur_max_military_exploit
  self.m_component_info.m_battlefield_info.m_accumulated_military_exploit = ev.m_accumulated_military_exploit
  for key, value in pairs(self.m_component_info.m_battlefield_info.m_challenge_mission_info) do
    if key == ev.m_challenge_mission_info.mission_id then
      self.m_component_info.m_battlefield_info.m_challenge_mission_info[key] = ev.m_challenge_mission_info
    end
  end
end
