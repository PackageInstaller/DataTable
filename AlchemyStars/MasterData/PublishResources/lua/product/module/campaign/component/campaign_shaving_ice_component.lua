require("component_base")
_class("CampaignShavingIceComponent", ICampaignComponent)
CampaignShavingIceComponent = CampaignShavingIceComponent

function CampaignShavingIceComponent:Constructor()
  self.m_component_info = ShavingIceComponentInfo:New()
end

function CampaignShavingIceComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = ShavingIceComponentInfo:New()
  end
  return self.m_component_info
end

function CampaignShavingIceComponent:GetShavingIceMissionInfo()
  return self.m_component_info.mission_info_list
end

function CampaignShavingIceComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function CampaignShavingIceComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_SHAVING_ICE
end

function CampaignShavingIceComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function CampaignShavingIceComponent:HandleStoryMsg(TT, asyncRes, mission_id, story_type)
  local request = ShavingIceComponentMissionStoryReq:New()
  request.mission_id = mission_id
  request.story_type = story_type
  local response = ShavingIceComponentMissionStoryRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CampaignShavingIceComponent] HandleStoryMsg ret:", asyncRes.m_result)
    return asyncRes
  end
  self.m_component_info.mission_info_list[response.mission_id] = response.info
  return asyncRes
end

function CampaignShavingIceComponent:HandleScoreMsg(TT, asyncRes, mission_id, score)
  local request = ShavingIceComponentScoreReq:New()
  request.mission_id = mission_id
  request.score = score
  local response = ShavingIceComponentScoreRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CampaignShavingIceComponent] HandleScoreMsg ret:", asyncRes.m_result)
    return asyncRes
  end
  self.m_component_info.mission_info_list[response.mission_id] = response.info
  return asyncRes
end

function CampaignShavingIceComponent:HandleRecvRewardMsg(TT, asyncRes, mission_id, grade)
  local request = ShavingIceComponentRecvRewardReq:New()
  request.mission_id = mission_id
  request.grade = grade
  local response = ShavingIceComponentRecvRewardRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CampaignShavingIceComponent] HandleRecvRewardMsg ret:", asyncRes.m_result)
    return nil
  end
  self.m_component_info.mission_info_list[response.mission_id] = response.info
  return asyncRes, response.rewards
end
