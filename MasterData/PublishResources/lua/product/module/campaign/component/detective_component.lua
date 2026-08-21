require("component_base")
_class("DetectiveComponent", ICampaignComponent)
DetectiveComponent = DetectiveComponent

function DetectiveComponent:Constructor()
  self.m_component_info = ClientDetectiveComponentInfo:New()
  self.m_endingId = 0
end

function DetectiveComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = ClientDetectiveComponentInfo:New()
  end
  return self.m_component_info
end

function DetectiveComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function DetectiveComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_DETECTIVE
end

function DetectiveComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function DetectiveComponent:HandleSubmitItem(TT, asyncRes, stage_id, clue_list, fragment_list, talk_list)
  local request = DetectiveSubmitItemReq:New()
  request.stage = stage_id
  request.clue_list = clue_list
  request.fragment_list = fragment_list
  request.talk_list = talk_list
  local response = DetectiveSubmitItemRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][DetectiveComponent] HandleSubmitItem ret:", asyncRes.m_result)
    return asyncRes
  end
  if response.ret == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    self.m_component_info.cur_info = response.cur_info
  end
  return response.ret
end

function DetectiveComponent:HandleSubmitEnding(TT, asyncRes, ending_id)
  local request = DetectiveSubmitEndingReq:New()
  request.ending_id = ending_id
  local response = DetectiveSubmitEndingRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  self.m_endingId = ending_id
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][DetectiveComponent] HandleSubmitEnding ret:", asyncRes.m_result)
    return asyncRes
  end
  if response.ret == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    self.m_component_info.cg_list = response.cg_list
  end
  return response.ret
end

function DetectiveComponent:HandleAutoSave(TT, asyncRes)
  local request = DetectiveAutoSaveReq:New()
  local response = DetectiveAutoSaveRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][DetectiveComponent] HandleAutoSave ret:", asyncRes.m_result)
    return asyncRes
  end
  if response.ret == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    self.m_component_info.is_record = response.is_record
    self.m_component_info.auto_save_record_time = response.auto_save_record_time
  end
  return response.ret
end

function DetectiveComponent:HandleStartGame(TT, asyncRes, info)
  local request = DetectiveReadRecordPlayReq:New()
  request.cur_info = info
  local response = DetectiveReadRecordPlayRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][DetectiveComponent] HandleStartGame ret:", asyncRes.m_result)
    return asyncRes
  end
  if response.ret == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    self.m_component_info.cur_info = response.cur_info
  end
  return response.ret
end

function DetectiveComponent:GetCurrentEndingId()
  return self.m_endingId
end
