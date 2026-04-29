require("component_base")
_class("AvgMinigameComponent", ICampaignComponent)
AvgMinigameComponent = AvgMinigameComponent

function AvgMinigameComponent:Constructor()
  self.m_component_info = AVGStoryComponentClientInfo:New()
end

function AvgMinigameComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = AVGStoryComponentClientInfo:New()
  end
  return self.m_component_info
end

function AvgMinigameComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function AvgMinigameComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_AVG_STORY
end

function AvgMinigameComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function AvgMinigameComponent:HandleSetCurrentLocation(TT, asyncRes, nodeID)
  local request = AvgSetCurrentLocationReq:New()
  local response = AvgSetCurrentLocationRsp:New()
  request.Node_id = nodeID
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][AvgComponent] HandleSetCurrentLocation ret:", asyncRes.m_result)
    return -1
  end
  self.m_component_info.cur_node_id = nodeID
  return response.ret
end

function AvgMinigameComponent:HandleUpdateNodeData(TT, asyncRes, data, complate_node_id)
  local request = AvgUpdateNodeDataReq:New()
  local response = AvgUpdateNodeDataRsp:New()
  request.data = data
  request.complate_mission_id = complate_node_id
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][DemoComponent] HandleDemo ret:", asyncRes.m_result)
    return -1
  end
  local timeMd = GameGlobal.GetModule(SvrTimeModule)
  self.m_component_info.mission_datas[data.mission_id] = data
  table.insert(self.m_component_info.conplated_node_ids, complate_node_id)
  table.unique(self.m_component_info.conplated_node_ids)
  self.m_component_info.mission_datas[data.mission_id].update_time = math.floor(timeMd:GetServerTime() / 1000)
  return response.ret
end

function AvgMinigameComponent:HandleManualChoose(TT, asyncRes, manual_id)
  local request = AvgManualChooseReq:New()
  local response = AvgManualChooseRsp:New()
  request.manual_id = manual_id
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][DemoComponent] HandleDemo ret:", asyncRes.m_result)
    return -1
  end
  table.insert(self.m_component_info.choosed_manual_ids, manual_id)
  table.unique(self.m_component_info.choosed_manual_ids)
  return response.ret
end

function AvgMinigameComponent:HandleComplateEnding(TT, asyncRes, ending_id)
  local request = AvgComplateEndingReq:New()
  local response = AvgComplateEndingRsp:New()
  request.ending_id = ending_id
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][DemoComponent] HandleDemo ret:", asyncRes.m_result)
    return -1
  end
  table.insert(self.m_component_info.conplated_ending_ids, ending_id)
  table.unique(self.m_component_info.conplated_ending_ids)
  return response.ret
end

function AvgMinigameComponent:HandleShowEvidence(TT, asyncRes, evidence_manual_id, evidence_id)
  local request = AvgShowEvidenceReq:New()
  local response = AvgShowEvidenceRsp:New()
  request.evidence_manual_id = evidence_manual_id
  request.evidence_id = evidence_id
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][DemoComponent] HandleDemo ret:", asyncRes.m_result)
    return -1
  end
  if self.m_component_info.showed_evidence[evidence_manual_id] == nil then
    self.m_component_info.showed_evidence[evidence_manual_id] = {}
  end
  table.insert(self.m_component_info.showed_evidence[evidence_manual_id], evidence_id)
  return response.ret
end

function AvgMinigameComponent:HandleGainEvidence(TT, asyncRes, evidence_id)
  local request = AvgGainEvidenceReq:New()
  local response = AvgGainEvidenceRsp:New()
  request.evidence_id = evidence_id
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][DemoComponent] HandleDemo ret:", asyncRes.m_result)
    return -1
  end
  table.insert(self.m_component_info.gained_evidence, evidence_id)
  return response.ret
end

function AvgMinigameComponent:HandleAcceptCgReward(TT, CgItemTemplateid)
  local itemModule = GameGlobal.GetModule(ItemModule)
  return itemModule:RequestUseItemByTemplateID(TT, CgItemTemplateid, 1)
end

function AvgMinigameComponent:HandleGetBadgeReward(TT, asyncRes, badge_reward_id)
  local request = AvgAcceptBadgeRewardReq:New()
  local response = AvgAcceptBadgeRewardRsp:New()
  request.badge_reward_id = badge_reward_id
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][DemoComponent] HandleDemo ret:", asyncRes.m_result)
    return -1
  end
  table.insert(self.m_component_info.accepted_badge_rewards, badge_reward_id)
  table.unique(self.m_component_info.accepted_badge_rewards)
  return response.ret
end
