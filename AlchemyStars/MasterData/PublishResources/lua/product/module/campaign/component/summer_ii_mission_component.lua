_class("SummerIIMissionComponent", ICampaignComponent)
SummerIIMissionComponent = SummerIIMissionComponent

function SummerIIMissionComponent:Constructor()
  self.m_component_info = SummerIIMissionComponentInfo:New()
  self.m_component_other_data = {}
end

function SummerIIMissionComponent:GetOtherData()
  local l_component_info = self:ComponentInfo()
  local nCfgId = self:GetComponetCfgId(l_component_info.m_campaign_id, l_component_info.m_component_id)
  if self.m_component_other_data[nCfgId] == nil then
    self.m_component_other_data[nCfgId] = {}
  end
  return self.m_component_other_data[nCfgId]
end

function SummerIIMissionComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = SummerIIMissionComponentInfo:New()
  end
  return self.m_component_info
end

function SummerIIMissionComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function SummerIIMissionComponent:IsPassCamMissionID(camMissionId)
  if self.m_component_info.m_pass_mission_info[camMissionId] then
    return true
  else
    return false
  end
end

function SummerIIMissionComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_SUM_II_MISSION
end

function SummerIIMissionComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function SummerIIMissionComponent:GetCampaignMissionComponentId()
  return ECampaignMissionComponentId.ECampaignMissionComponentId_SummerII
end

function SummerIIMissionComponent:GetCampaignMissionParamKeyMap()
  local ComponentInfo = self:ComponentInfo()
  local nCfgId = self:GetComponetCfgId(ComponentInfo.m_campaign_id, ComponentInfo.m_component_id)
  return {
    [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = nCfgId
  }
end

function SummerIIMissionComponent:CampaignComponentPushNotify(notify_data)
  if SummerIIMissionComponentNotifyType.SummerIIMissionComponentNotifyType_InfoChanged == notify_data.m_notify_type then
    local ev = NotifySummerIIMissionComponentInfoChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:OnUpdateBaseInfo(ev)
    else
      Log.error("[CampaignCom][SummerIIMissionComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function SummerIIMissionComponent:OnUpdateBaseInfo(ev)
  self.m_component_info.m_cur_mission = ev.m_cur_mission
  for key, value in pairs(ev.m_update_mission_info) do
    local l_last_status = self.m_component_info.m_pass_mission_info[key] and true or false
    self:SetHistoryMissionPassStatus(key, l_last_status)
    self.m_component_info.m_pass_mission_info[key] = value
  end
  for key, value in pairs(ev.m_update_pass_afix) do
    local l_lastScore = self.m_component_info.m_pass_afix[key] and self.m_component_info.m_pass_afix[key] or {}
    self:SetHistoryHighScoreAffix(key, l_lastScore)
    self.m_component_info.m_pass_afix[key] = value
  end
  for key, value in pairs(ev.m_update_pass_hard) do
    local l_lastHard = self.m_component_info.m_pass_hard[key]
    self:SetHistoryHard(key, l_lastHard)
    self.m_component_info.m_pass_hard[key] = value
  end
end

function SummerIIMissionComponent:GetHistoryHighAffix(nMissionId)
  local l_other_data = self:GetOtherData()
  if l_other_data.mission_high_score == nil then
    l_other_data.mission_high_score = {}
  end
  local l_RetTable = l_other_data.mission_high_score[nMissionId]
  if l_other_data.mission_high_score[nMissionId] == nil then
    l_other_data.mission_high_score[nMissionId] = self.m_component_info.m_pass_afix[nMissionId]
    if l_other_data.mission_high_score[nMissionId] == nil then
      l_RetTable = {}
    else
      l_RetTable = l_other_data.mission_high_score[nMissionId]
    end
  end
  l_other_data.mission_high_score[nMissionId] = nil
  return l_RetTable
end

function SummerIIMissionComponent:GetHistoryHighHard(nMissionId)
  local l_other_data = self:GetOtherData()
  if l_other_data.mission_high_hard == nil then
    l_other_data.mission_high_hard = {}
  end
  local hardId = l_other_data.mission_high_hard[nMissionId]
  if l_other_data.mission_high_hard[nMissionId] == nil then
    l_other_data.mission_high_hard[nMissionId] = self.m_component_info.m_pass_hard[nMissionId]
    if l_other_data.mission_high_hard[nMissionId] == nil then
      hardId = nil
    else
      hardId = l_other_data.mission_high_hard[nMissionId]
    end
  end
  l_other_data.mission_high_hard[nMissionId] = nil
  return hardId
end

function SummerIIMissionComponent:SetHistoryHighScoreAffix(nMissionId, high_affix)
  local l_other_data = self:GetOtherData()
  if l_other_data.mission_high_score == nil then
    l_other_data.mission_high_score = {}
  end
  if l_other_data.mission_high_score[nMissionId] == nil then
    l_other_data.mission_high_score[nMissionId] = {}
  end
  local l_affix_list = l_other_data.mission_high_score[nMissionId]
  for key, value in pairs(high_affix) do
    l_affix_list[key] = value
  end
end

function SummerIIMissionComponent:SetHistoryHard(nMissionId, hardId)
  local l_other_data = self:GetOtherData()
  if l_other_data.mission_high_hard == nil then
    l_other_data.mission_high_hard = {}
  end
  l_other_data.mission_high_hard[nMissionId] = hardId
end

function SummerIIMissionComponent:GetHistoryMissionPassStatus(nMissionId)
  local l_other_data = self:GetOtherData()
  if l_other_data.mission_history_pass == nil then
    l_other_data.mission_history_pass = {}
  end
  if l_other_data.mission_history_pass[nMissionId] == nil then
    l_other_data.mission_history_pass[nMissionId] = self.m_component_info.m_pass_mission_info[nMissionId] and true or false
  end
  local bRetValue = l_other_data.mission_history_pass[nMissionId]
  if not bRetValue then
    l_other_data.mission_history_pass[nMissionId] = nil
  end
  return bRetValue
end

function SummerIIMissionComponent:SetHistoryMissionPassStatus(nMissionId, isPass)
  local l_other_data = self:GetOtherData()
  if l_other_data.mission_history_pass == nil then
    l_other_data.mission_history_pass = {}
  end
  l_other_data.mission_history_pass[nMissionId] = isPass
end

function SummerIIMissionComponent:HandleSelectAffix(TT, asyncRes, nCampaignMissionId, SelectAffixIdArray, nHardId)
  local request = SummerIISelectAffixReq:New()
  local response = SummerIISelectAffixRep:New()
  request.nCampaignMissionId = nCampaignMissionId
  request.SelectAffixIdArray = SelectAffixIdArray
  request.nHardId = nHardId
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][SummerIIMissionComponent] HandleSelectAffix ret:", asyncRes.m_result)
    return
  end
  self.m_component_info.m_select_affix[nCampaignMissionId] = {}
  local l_m_select_affix = self.m_component_info.m_select_affix[nCampaignMissionId]
  for index, value in ipairs(SelectAffixIdArray) do
    l_m_select_affix[index] = value
  end
  self.m_component_info.m_select_hard[nCampaignMissionId] = nHardId
end

function SummerIIMissionComponent:HandleSummerIIChangeFormationReq(TT, asyncRes, nElementType, formation_pet_list)
  local request = SummerIIChangeFormationReq:New()
  local response = SummerIIChangeFormationRep:New()
  request.nElementType = nElementType
  request.formation_pet_list = formation_pet_list
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][SummerIIMissionComponent] HandleSummerIIChangeFormationReq ret:", asyncRes.m_result)
    return -1
  end
  if response.nFormationRet ~= FORMATION_RESUTL_CODE.FORMATION_SUCCEED then
    asyncRes:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE)
  else
    self.m_component_info.m_formation_info[nElementType] = {}
    local l_m_formation_info = self.m_component_info.m_formation_info[nElementType]
    for index, value in ipairs(formation_pet_list) do
      l_m_formation_info[index] = value
    end
  end
  return response.nFormationRet
end

function SummerIIMissionComponent:HandleCompleteStorySummerIIMission(TT, asyncRes, nMissionId)
  local request = CompleteStorySummerIIMissionReq:New()
  local response = CompleteStorySummerIIMissionRep:New()
  request.m_create_info.nCampaignMissionId = nMissionId
  local ComponentInfo = self:ComponentInfo()
  request.m_create_info.nMissionComId = self:GetCampaignMissionComponentId()
  request.m_create_info.CampaignMissionParams = self:GetCampaignMissionParamKeyMap()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][SummerIIMissionComponent] HandleCompleteStorySummerIIMission ret:", asyncRes.m_result)
    return nil
  end
  if response.nErrorCode ~= MatchOpResCode.MATCH_SUCCESS then
    asyncRes:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE)
    return nil
  end
  return response.reward
end

function SummerIIMissionComponent:SetMissionStoryActive(TT, mission_id, activeStoryType)
  local missionModule = GameGlobal.GetModule(MissionModule)
  return missionModule:SetMissionStoryActive(TT, mission_id, activeStoryType)
end

function SummerIIMissionComponent:IsMissionStoryActive(mission_id, activeStoryType)
  local missionModule = GameGlobal.GetModule(MissionModule)
  missionModule:IsMissionStoryActive(mission_id, activeStoryType)
end
