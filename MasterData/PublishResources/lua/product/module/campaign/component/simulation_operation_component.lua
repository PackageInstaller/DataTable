require("component_base")
_class("SimulationOperation", ICampaignComponent)
SimulationOperation = SimulationOperation

function SimulationOperation:Constructor()
  self.m_component_info = SimulationOperationComponentInfo:New()
end

function SimulationOperation:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = SimulationOperationComponentInfo:New()
  end
  return self.m_component_info
end

function SimulationOperation:GetComponentInfo()
  return self:ComponentInfo()
end

function SimulationOperation:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_SIMULATION_OPERATION
end

function SimulationOperation:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function SimulationOperation:HandlePickUpCoin(TT, asyncRes, arch_id)
  local request = PickUpComponentReq:New()
  request.arch_id = arch_id
  local response = PickUpComponentRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][SimulationOperation] HandleSubmitMissionInfo ret:", asyncRes.m_result)
    return asyncRes
  end
  if response.ret == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    self.m_component_info.arch_infos[response.info.arch_id] = response.info
  end
  return response.ret, response.suc
end

function SimulationOperation:HandleSubmitSimulationOperationStory(TT, asyncRes, arch_id, story_id, final_story)
  local request = SubmitStoryComponentReq:New()
  request.arch_id = arch_id
  request.story_id = story_id
  request.final_story = final_story
  local response = SubmitStoryComponentRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][SimulationOperation] HandleStory ret:", asyncRes.m_result)
    return asyncRes
  end
  if response.ret == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    if final_story == true then
      self.m_component_info.final_story = response.final_story
    else
      self.m_component_info.story_list = response.story_list
    end
  end
  return response.ret, response.rewards
end

function SimulationOperation:HandleUpgradeArch(TT, asyncRes, arch_id)
  local request = UpgradeComponentReq:New()
  request.arch_id = arch_id
  local response = UpgradeComponentRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][SimulationOperation] HandleGetTargetReward ret:", asyncRes.m_result)
    return asyncRes
  end
  if response.ret == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    self.m_component_info.arch_infos[response.info.arch_id] = response.info
  end
  return response.ret, response.rewards
end

function SimulationOperation:HandleGetArchInfos(TT, asyncRes)
  local request = GetArchInfosComponentReq:New()
  local response = GetArchInfosComponentRep:New()
  if not self.m_campaign_com_module or not self.m_campaign_com_module:GetCampaignManager() then
    return asyncRes
  end
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][SimulationOperation] HandleGetTargetReward ret:", asyncRes.m_result)
    return asyncRes
  end
  if response.ret == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    self.m_component_info.arch_infos = response.arch_infos
  end
  return response.ret
end
