_class("TreeMissionComponent", ICampaignComponent)
TreeMissionComponent = TreeMissionComponent

function TreeMissionComponent:Constructor()
  self.m_component_info = TreeMissionComponentInfo:New()
end

function TreeMissionComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = TreeMissionComponentInfo:New()
  end
  return self.m_component_info
end

function TreeMissionComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function TreeMissionComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_TREE_MISSION
end

function TreeMissionComponent:IsPassCamMissionID(camMissionId)
  if self.m_component_info.m_pass_mission_info[camMissionId] then
    return true
  else
    return false
  end
end

function TreeMissionComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function TreeMissionComponent:GetCampaignMissionComponentId()
  return ECampaignMissionComponentId.ECampaignMissionComponentId_Tree
end

function TreeMissionComponent:GetCampaignMissionParamKeyMap()
  local ComponentInfo = self:ComponentInfo()
  local nCfgId = self:GetComponetCfgId(ComponentInfo.m_campaign_id, ComponentInfo.m_component_id)
  return {
    [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = nCfgId
  }
end

function TreeMissionComponent:CampaignComponentPushNotify(notify_data)
  if TreeMissionComponentNotifyType.TreeMissionComponentNotifyType_InfoChanged == notify_data.m_notify_type then
    local ev = NotifyTreeMissionComponentInfoChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:OnUpdateBaseInfo(ev)
    else
      Log.error("[CampaignCom][TreeMissionComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function TreeMissionComponent:OnUpdateBaseInfo(ev)
  for key, value in pairs(ev.m_update_mission_info) do
    self.m_component_info.m_pass_mission_info[key] = value
  end
end

function TreeMissionComponent:HandleCompleteStoryTreeMission(TT, asyncRes, nMissionId)
  local request = CompleteStoryTreeMissionReq:New()
  local response = CompleteStoryTreeMissionRep:New()
  request.m_create_info.nCampaignMissionId = nMissionId
  local ComponentInfo = self:ComponentInfo()
  request.m_create_info.nMissionComId = self:GetCampaignMissionComponentId()
  request.m_create_info.CampaignMissionParams = self:GetCampaignMissionParamKeyMap()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][TreeMissionComponent] HandleCompleteStoryTreeMission ret:", asyncRes.m_result)
    return nil
  end
  if response.nErrorCode ~= MatchOpResCode.MATCH_SUCCESS then
    asyncRes:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE)
    return nil
  end
  return response.reward
end

function TreeMissionComponent:SetMissionStoryActive(TT, mission_id, activeStoryType)
  local missionModule = GameGlobal.GetModule(MissionModule)
  return missionModule:SetMissionStoryActive(TT, mission_id, activeStoryType)
end

function TreeMissionComponent:IsMissionStoryActive(mission_id, activeStoryType)
  local missionModule = GameGlobal.GetModule(MissionModule)
  missionModule:IsMissionStoryActive(mission_id, activeStoryType)
end
