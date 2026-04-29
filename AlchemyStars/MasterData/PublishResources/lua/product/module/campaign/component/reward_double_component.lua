_class("RewardDoubleComponent", ICampaignComponent)
RewardDoubleComponent = RewardDoubleComponent

function RewardDoubleComponent:Constructor()
  self.m_component_info = RewardDoubleComponentInfo:New()
  self.m_local_next_refresh_time = -1
end

function RewardDoubleComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = RewardDoubleComponentInfo:New()
  end
  return self.m_component_info
end

function RewardDoubleComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function RewardDoubleComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_REWARD_DOUBLE
end

function RewardDoubleComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end
