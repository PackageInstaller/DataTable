_class("DemoComponent", ICampaignComponent)
DemoComponent = DemoComponent

function DemoComponent:Constructor()
  self.m_component_info = DemoComponentInfo:New()
end

function DemoComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = DemoComponentInfo:New()
  end
  return self.m_component_info
end

function DemoComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function DemoComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_DEMO
end

function DemoComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function DemoComponent:HandleDemo(TT, asyncRes, a_req)
  local request = DemoComponentReq:New()
  request.m_req = a_req
  local response = DemoComponentRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][DemoComponent] HandleDemo ret:", asyncRes.m_result)
    return -1
  end
  return response.m_rep
end
