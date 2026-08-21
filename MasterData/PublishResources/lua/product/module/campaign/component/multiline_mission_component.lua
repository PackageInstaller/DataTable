require("component_base")
_class("MultiLineMissionComponent", ICampaignComponent)
MultiLineMissionComponent = MultiLineMissionComponent

function MultiLineMissionComponent:Constructor()
  self.m_component_info = MultiLineComponentInfo:New()
end

function MultiLineMissionComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = MultiLineComponentInfo:New()
  end
  return self.m_component_info
end

function MultiLineMissionComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function MultiLineMissionComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_MULTILINE_MISSION
end

function MultiLineMissionComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function MultiLineMissionComponent:GetCampaignMissionComponentId()
  return ECampaignMissionComponentId.ECampaignMissionComponentId_MultiLine
end

function MultiLineMissionComponent:GetCampaignMissionParamKeyMap()
  local componentInfo = self:ComponentInfo()
  local nCfgId = self:GetComponetCfgId(componentInfo.m_campaign_id, componentInfo.m_component_id)
  return {
    [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = nCfgId
  }
end

function MultiLineMissionComponent:HandleMultiLineMissionSettle(TT, asyncRes, nMissionId)
  local request = CompleteMultiLineReq:New()
  local response = CompleteMultiLineRep:New()
  request.m_create_info.nCampaignMissionId = nMissionId
  local ComponentInfo = self:ComponentInfo()
  request.m_create_info.nMissionComId = self:GetCampaignMissionComponentId()
  request.m_create_info.CampaignMissionParams = self:GetCampaignMissionParamKeyMap()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][MultiLineMissionComponent] HandleMultiLineMissionSettle ret:", asyncRes.m_result)
    return nil
  end
  if response.nErrorCode ~= MatchOpResCode.MATCH_SUCCESS then
    asyncRes:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE)
    return nil
  end
  return response.reward, response.m_files_id
end

function MultiLineMissionComponent:HandleMultiLineMissionGetReward(TT, asyncRes, petid)
  local request = MultiLineGetRewardReq:New()
  local response = MultiLineGetRewardRes:New()
  request.pet_id = petid
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  local res = AsyncRequestRes:New()
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][MultiLineMissionComponent] HandleMultiLineMissionGetReward ret:", asyncRes.m_result)
    res:SetResult(asyncRes.m_result)
    return res
  end
  res:SetSucc(true)
  self.m_component_info.m_files_received = response.m_files_received
  return res, response.reward
end

function MultiLineMissionComponent:ECCH_HandleMultiLineSetMark(TT, asyncRes, mltiline)
  local request = MultiLineSetMarkReq:New()
  local response = MultiLineSetMarkRes:New()
  request.m_mark = self.m_component_info.m_mark | 1 << mltiline
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  local res = AsyncRequestRes:New()
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][MultiLineMissionComponent] ECCH_HandleMultiLineSetMark ret:", asyncRes.m_result)
    res:SetResult(asyncRes.m_result)
    return res
  end
  res:SetSucc(true)
  self.m_component_info.m_mark = request.m_mark
  return res
end

function MultiLineMissionComponent:CampaignComponentPushNotify(notify_data)
  if MultiLineComponentNotifyType.MultiLineComponentNotifyType_InfoChanged == notify_data.m_notify_type then
    local ev = NotifyMultiLineComponentInfoChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self.m_component_info.m_pass_mission_info = ev.m_pass_mission_info
      self.m_component_info.m_pet_files = ev.m_pet_files
    else
      Log.error("[CampaignCom][MultiLineMissionComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function MultiLineMissionComponent:SetMissionStoryActive(TT, mission_id, activeStoryType)
  local missionModule = GameGlobal.GetModule(MissionModule)
  return missionModule:SetMissionStoryActive(TT, mission_id, activeStoryType)
end

function MultiLineMissionComponent:IsMissionStoryActive(mission_id, activeStoryType)
  local missionModule = GameGlobal.GetModule(MissionModule)
  missionModule:IsMissionStoryActive(mission_id, activeStoryType)
end

function MultiLineMissionComponent:IsPassCamMissionID(camMissionId)
  if self.m_component_info.m_pass_mission_info[camMissionId] then
    return true
  else
    return false
  end
end

function MultiLineMissionComponent:GetMark(mltiline)
  return self.m_component_info.m_mark & 1 << mltiline > 0
end
