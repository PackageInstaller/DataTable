require("component_base")
_class("NewYearDinnerMiniGameComponent", ICampaignComponent)
NewYearDinnerMiniGameComponent = NewYearDinnerMiniGameComponent

function NewYearDinnerMiniGameComponent:Constructor()
  self.m_component_info = NewYearDinnerComponentInfo:New()
end

function NewYearDinnerMiniGameComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = NewYearDinnerComponentInfo:New()
  end
  return self.m_component_info
end

function NewYearDinnerMiniGameComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function NewYearDinnerMiniGameComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_NEWYEAR_DINNER
end

function NewYearDinnerMiniGameComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function NewYearDinnerMiniGameComponent:HandleNewYearDinnerMakeFood(TT, asyncRes, foodId)
  local request = NewYearDinnerMakeFoodReq:New()
  local response = NewYearDinnerMakeFoodRep:New()
  request.food_id = foodId
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][IdolComponent] HandleNewYearDinnerMakeFood ret:", asyncRes.m_result)
    return -1
  end
  self.m_component_info.data_info = response.data_info
  return response.ret
end

function NewYearDinnerMiniGameComponent:HandleNewYearDinnerReward(TT, asyncRes, rewardType, reqId)
  local request = NewYearDinnerRewardReq:New()
  local response = NewYearDinnerRewardRep:New()
  request.reward_type = rewardType
  request.req_id = reqId
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][IdolComponent] HandleNewYearDinnerReward ret:", asyncRes.m_result)
    return -1
  end
  self.m_component_info.data_info = response.component_info.data_info
  self.m_component_info.task_list = response.component_info.task_list
  return response.ret, response.rewards
end
