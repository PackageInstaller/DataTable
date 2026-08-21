require("component_base")
_class("PostStationComponent", ICampaignComponent)
PostStationComponent = PostStationComponent

function PostStationComponent:Constructor()
  self.m_component_info = PostStationComponentInfo:New()
end

function PostStationComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = PostStationComponentInfo:New()
  end
  return self.m_component_info
end

function PostStationComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function PostStationComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_POST_STATION_GAME
end

function PostStationComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function PostStationComponent:HandleSubmitMissionInfo(TT, asyncRes, mission_id, order_list)
  local request = SubmitMissionInfoReq:New()
  request.mission_id = mission_id
  request.order_list = order_list
  local response = SubmitMissionInfoRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][PostStationComponent] HandleSubmitMissionInfo ret:", asyncRes.m_result)
    return asyncRes
  end
  if response.ret == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    self.m_component_info.mission_infos[mission_id] = response.info
  end
  return response.ret, response.suc
end

function PostStationComponent:HandleStory(TT, asyncRes, mission_id, story_type)
  local request = PostStationMissionStoryReq:New()
  request.mission_id = mission_id
  request.story_type = story_type
  local response = PostStationMissionStoryRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][PostStationComponent] HandleStory ret:", asyncRes.m_result)
    return asyncRes
  end
  if response.ret == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    self.m_component_info.mission_infos[mission_id] = response.info
  end
  return response.ret
end

function PostStationComponent:HandleGetTargetReward(TT, asyncRes, mission_id, target_id)
  local request = PostStationGetTargetRewardReq:New()
  request.mission_id = mission_id
  request.target_id = target_id
  local response = PostStationGetTargetRewardRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][PostStationComponent] HandleGetTargetReward ret:", asyncRes.m_result)
    return asyncRes
  end
  if response.ret == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    self.m_component_info.mission_infos[mission_id] = response.info
  end
  return response.ret, response.reward
end
