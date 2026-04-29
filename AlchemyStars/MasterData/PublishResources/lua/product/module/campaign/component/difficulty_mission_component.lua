_class("DifficultyMissionComponent", ICampaignComponent)
DifficultyMissionComponent = DifficultyMissionComponent

function DifficultyMissionComponent:Constructor()
  self.m_component_info = ClientCampaignDifficultyMissionInfo:New()
end

function DifficultyMissionComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = ClientCampaignDifficultyMissionInfo:New()
  end
  return self.m_component_info
end

function DifficultyMissionComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function DifficultyMissionComponent:IsPassCamMissionID(camMissionId)
  if self.m_component_info.m_pass_mission_info[camMissionId] then
    return true
  else
    return false
  end
end

function DifficultyMissionComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_DIFFICULTY_MISSION
end

function DifficultyMissionComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function DifficultyMissionComponent:GetCampaignMissionComponentId()
  return EDifficultyMissionComponentId.EDifficultyMissionComponentId_Campaign
end

function DifficultyMissionComponent:GetCampaignMissionParamKeyMap()
  local ComponentInfo = self:ComponentInfo()
  local nCfgId = self:GetComponetCfgId(ComponentInfo.m_campaign_id, ComponentInfo.m_component_id)
  return {
    [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = nCfgId
  }
end

function DifficultyMissionComponent:HandleDifficultyChangeFormation(TT, asyncRes, parent_mission_id, sub_id, pet_list)
  local request = CCampaignEventApplyChangeFormationReq:New()
  local response = CCampaignEventApplyChangeFormationRes:New()
  request.parent_mission_id = parent_mission_id
  request.formation_pet_list = pet_list
  request.sub_mission_id = sub_id
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  local res = AsyncRequestRes:New()
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][IdolComponent] HandleDifficultyChangeFormation ret:", asyncRes.m_result)
    res:SetSucc(false)
    return res
  end
  res:SetSucc(true)
  return res
end

function DifficultyMissionComponent:HandleDifficultyResetSubMissionRecord(TT, asyncRes, parent_mission_id, sub_mission_id)
  local request = CCampaignEventResetSubMissionRecordReq:New()
  local response = CCampaignEventResetSubMissionRecordRes:New()
  request.parent_mission_id = parent_mission_id
  request.sub_mission_id = sub_mission_id
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  local res = AsyncRequestRes:New()
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][IdolComponent] HandleDifficultyChangeFormation ret:", asyncRes.m_result)
    res:SetResult(asyncRes.m_result)
    return res
  end
  res:SetSucc(true)
  return res
end

function DifficultyMissionComponent:CampaignComponentPushNotify(notify_data)
  if DifficultyMissionComponentNotifyType.DifficultyMissionComponentNotifyType_Parent == notify_data.m_notify_type then
    local ev = NotifyDifficultyMissionComponentParentInfoChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self.m_component_info.infos[ev.info.parent_mission_id] = ev.info
      self.m_component_info.cur_parent_id = ev.cur_mission_id
    else
      Log.error("[CampaignCom][DifficultyMissionComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
  if DifficultyMissionComponentNotifyType.DifficultyMissionComponentNotifyType_CurFormation == notify_data.m_notify_type then
    local ev = NotifyDifficultyMissionComponentCurFormationChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self.m_component_info.pet_list = ev.formation_pet_list
    else
      Log.error("[CampaignCom][DifficultyMissionComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end
