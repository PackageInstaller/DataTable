require("component_base")
_class("TacitTestComponent", ICampaignComponent)
TacitTestComponent = TacitTestComponent

function TacitTestComponent:Constructor()
  self.m_component_info = TacitTestComponentInfo:New()
end

function TacitTestComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = TacitTestComponentInfo:New()
  end
  return self.m_component_info
end

function TacitTestComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function TacitTestComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_TACIT_TEST
end

function TacitTestComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function TacitTestComponent:HandleCompleteTacitTestMission(TT, asyncRes, missionId, star)
  local request = CompleteTacitTestMissionReq:New()
  request.mission_id = missionId
  request.star = star
  local response = CompleteTacitTestMissionRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][TacitTestComponent] HandleCompleteTacitTestMission ret:", asyncRes.m_result)
    return nil
  end
  self.m_component_info.m_pass_mission_info[missionId] = response.info
  return response.ret, response.reward
end

function TacitTestComponent:HandleUpdateTacitTestAnswer(TT, asyncRes, missionId, answerRecord)
  local request = UpdateTacitTestAnswerReq:New()
  request.mission_id = missionId
  request.answer_record = answerRecord
  local response = UpdateTacitTestAnswerRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][TacitTestComponent] HandleUpdateTacitTestAnswer ret:", asyncRes.m_result)
    return nil
  end
  self.m_component_info.m_pass_mission_info[missionId].answer_record = answerRecord
  return response.ret
end
