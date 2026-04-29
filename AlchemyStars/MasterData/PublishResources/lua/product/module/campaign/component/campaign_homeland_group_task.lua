require("component_base")
_class("CampaignHomelandGroupTaskComponent", ICampaignComponent)
CampaignHomelandGroupTaskComponent = CampaignHomelandGroupTaskComponent

function CampaignHomelandGroupTaskComponent:Constructor()
  self.m_component_info = HomelandGroupTaskComponentInfo:New()
end

function CampaignHomelandGroupTaskComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = HomelandGroupTaskComponentInfo:New()
  end
  return self.m_component_info
end

function CampaignHomelandGroupTaskComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function CampaignHomelandGroupTaskComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_HOMELAND_GROUP_TASK
end

function CampaignHomelandGroupTaskComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function CampaignHomelandGroupTaskComponent:CampaignComponentPushNotify(notify_data)
end
