require("component_base")
_class("ClientCommonBaseComponentInfo", ICampaignComponentInfo)
ClientCommonBaseComponentInfo = ClientCommonBaseComponentInfo

function ClientCommonBaseComponentInfo:Constructor()
end

_class("CommonBaseComponent", ICampaignComponent)
CommonBaseComponent = CommonBaseComponent

function CommonBaseComponent:Constructor()
  self.m_component_info = ClientCommonBaseComponentInfo:New()
end

function CommonBaseComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = ClientCommonBaseComponentInfo:New()
  end
  return self.m_component_info
end

function CommonBaseComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function CommonBaseComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_COMMON_BASE
end

function CommonBaseComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end
