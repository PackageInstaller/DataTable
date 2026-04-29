require("component_base")
_class("SurveyComponent", ICampaignComponent)
SurveyComponent = SurveyComponent

function SurveyComponent:Constructor()
  self.m_component_info = SurveyComponentInfo:New()
end

function SurveyComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = SurveyComponentInfo:New()
  end
  return self.m_component_info
end

function SurveyComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function SurveyComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_SURVEY
end

function SurveyComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function SurveyComponent:HandleSurveyClientDataReq(TT, asyncRes, optype)
  local request = SurveyClientDataReq:New()
  request.op_type = optype
  local response = SurveyClientDataReply:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][SurveyComponent] HandleSurveyClientDataReq ret:", asyncRes.m_result)
    return nil
  end
  self.m_component_info.info = response.info
  asyncRes:SetSucc(true)
  return response.ret, response.reward
end
