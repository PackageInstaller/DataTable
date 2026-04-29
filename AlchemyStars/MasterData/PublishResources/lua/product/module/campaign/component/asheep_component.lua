require("component_base")
_class("ASheepComponent", ICampaignComponent)
ASheepComponent = ASheepComponent

function ASheepComponent:Constructor()
  self.m_component_info = ASheepComponentInfo:New()
end

function ASheepComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = ASheepComponentInfo:New()
  end
  return self.m_component_info
end

function ASheepComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function ASheepComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_A_SHEEP
end

function ASheepComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function ASheepComponent:HandleCompleteASheepMission(TT, asyncRes, mission_id, score)
  local request = CompleteASheepMissionReq:New()
  request.mission_id = mission_id
  request.score = score
  local response = CompleteASheepMissionRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][ASheepComponent] HandleCompleteASheepMission ret:", asyncRes.m_result)
    return nil
  end
  self.m_component_info.m_info = response.m_info
  return response.ret, response.reward
end
