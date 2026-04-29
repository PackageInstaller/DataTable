require("component_base")
_class("CampaignMissionDropComponent", ICampaignComponent)
CampaignMissionDropComponent = CampaignMissionDropComponent

function CampaignMissionDropComponent:Constructor()
  self.m_component_info = MissionDropComponentInfo:New()
end

function CampaignMissionDropComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = MissionDropComponentInfo:New()
  end
  return self.m_component_info
end

function CampaignMissionDropComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function CampaignMissionDropComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function CampaignMissionDropComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_MISSION_DROP
end

function CampaignMissionDropComponent:GetCampaignCount()
  return self.m_component_info.m_total_count
end

function CampaignMissionDropComponent:CampaignComponentPushNotify(notify_data)
  if StoryComponentNotifyType.StoryComponentNotifyType_PointChange == notify_data.m_notify_type then
    local ev = NotifyStoryComponentPointChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self.m_component_info.m_total_count = ev.m_total_count
    else
      Log.error("[CampaignCom][CampaignMissionDropComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end
