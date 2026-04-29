require("component_base")
_class("DispatchComponent", ICampaignComponent)
DispatchComponent = DispatchComponent

function DispatchComponent:Constructor()
  self.m_component_info = DispatchComponentInfo:New()
end

function DispatchComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = DispatchComponentInfo:New()
  end
  return self.m_component_info
end

function DispatchComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function DispatchComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_DISPATCH
end

function DispatchComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function DispatchComponent:HandleDispatch(TT, asyncRes, arch_id)
  local request = DispatchReq:New()
  request.arch_id = arch_id
  local response = DispatchReply:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][DispatchComponent] HandleDispatch ret:", asyncRes.m_result)
    return asyncRes
  end
  if response.ret == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    self.m_component_info.dispatch_infos[response.info.arch_id] = response.info
  end
  return response.ret, response.suc
end

function DispatchComponent:HandleGetDispatchRewards(TT, asyncRes, arch_id)
  local request = GetDispatchRewardsReq:New()
  request.arch_id = arch_id
  local response = GetDispatchRewardsReply:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][DispatchComponent] HandleGetDispatchRewards ret:", asyncRes.m_result)
    return asyncRes
  end
  if response.ret == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    self.m_component_info.dispatch_infos[response.info.arch_id] = response.info
  end
  return response.ret, response.rewards
end
