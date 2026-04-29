require("component_base")
_class("CampaignMiniGameComponent", ICampaignComponent)
CampaignMiniGameComponent = CampaignMiniGameComponent

function CampaignMiniGameComponent:Constructor()
  self.m_component_info = MiniGameComponentInfo:New()
end

function CampaignMiniGameComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = MiniGameComponentInfo:New()
  end
  return self.m_component_info
end

function CampaignMiniGameComponent:GetMiniGameMissionInfo()
  return self.m_component_info.mission_info_list
end

function CampaignMiniGameComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function CampaignMiniGameComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_MINI_GAME
end

function CampaignMiniGameComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function CampaignMiniGameComponent:HandleStoryMsg(TT, asyncRes, mission_id, story_type)
  local request = MiniGameComponentMissionStoryReq:New()
  request.mission_id = mission_id
  request.story_type = story_type
  local response = MiniGameComponentMissionStoryRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CampaignMiniGameComponent] HandleStoryMsg ret:", asyncRes.m_result)
    return asyncRes
  end
  self.m_component_info.mission_info_list[response.mission_id] = response.info
  return asyncRes
end

function CampaignMiniGameComponent:HandleScoreMsg(TT, asyncRes, mission_id, score)
  local request = MiniGameComponentScoreReq:New()
  request.mission_id = mission_id
  request.score = score
  local response = MiniGameComponentScoreRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CampaignMiniGameComponent] HandleScoreMsg ret:", asyncRes.m_result)
    return asyncRes
  end
  self.m_component_info.mission_info_list[response.mission_id] = response.info
  return asyncRes
end

function CampaignMiniGameComponent:HandleRecvRewardMsg(TT, asyncRes, mission_id, grade)
  local request = MiniGameComponentRecvRewardReq:New()
  request.mission_id = mission_id
  request.grade = grade
  local response = MiniGameComponentRecvRewardRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CampaignMiniGameComponent] HandleRecvRewardMsg ret:", asyncRes.m_result)
    return nil
  end
  self.m_component_info.mission_info_list[response.mission_id] = response.info
  return asyncRes, response.rewards
end
