_class("DailyMissionComponent", ICampaignComponent)
DailyMissionComponent = DailyMissionComponent

function DailyMissionComponent:Constructor()
  self.m_component_info = DailyMissionComponentInfo:New()
end

function DailyMissionComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = DailyMissionComponentInfo:New()
  end
  return self.m_component_info
end

function DailyMissionComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function DailyMissionComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_DAILY_MISSION
end

function DailyMissionComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function DailyMissionComponent:GetCampaignMissionComponentId()
  return ECampaignMissionComponentId.ECampaignMissionComponentId_DailyMission
end

function DailyMissionComponent:GetCampaignMissionParamKeyMap()
  local ComponentInfo = self:ComponentInfo()
  local nCfgId = self:GetComponetCfgId(ComponentInfo.m_campaign_id, ComponentInfo.m_component_id)
  return {
    [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = nCfgId
  }
end

function DailyMissionComponent:HaveRedPoint()
  return self.m_component_info.m_today_score == 0
end
