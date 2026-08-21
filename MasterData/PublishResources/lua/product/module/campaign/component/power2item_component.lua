require("component_base")
_class("CampaignPower2itemComponent", ICampaignComponent)
CampaignPower2itemComponent = CampaignPower2itemComponent

function CampaignPower2itemComponent:Constructor()
  self.m_component_info = Power2ItemComponentInfo:New()
end

function CampaignPower2itemComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = Power2ItemComponentInfo:New()
  end
  return self.m_component_info
end

function CampaignPower2itemComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function CampaignPower2itemComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function CampaignPower2itemComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_POWER2ITEM
end

function CampaignPower2itemComponent:GetCampaignCount()
  return self.m_component_info.m_total_count
end

function CampaignPower2itemComponent:CampaignComponentPushNotify(notify_data)
  if StoryComponentNotifyType.StoryComponentNotifyType_PointChange == notify_data.m_notify_type then
    local ev = NotifyStoryComponentPointChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self.m_component_info.m_total_count = ev.m_total_count
    else
      Log.error("[CampaignCom][CampaignPower2itemComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end
