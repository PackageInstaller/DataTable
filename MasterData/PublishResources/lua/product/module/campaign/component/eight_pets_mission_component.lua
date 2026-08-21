require("component_base")
_class("EightPetsMissionComponent", ICampaignComponent)
EightPetsMissionComponent = EightPetsMissionComponent

function EightPetsMissionComponent:Constructor()
  self.m_component_info = EightPetsComponentInfo:New()
  self.m_prev_pass_info_valid = false
  self.m_prev_pass_info = {}
end

function EightPetsMissionComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = EightPetsComponentInfo:New()
  end
  return self.m_component_info
end

function EightPetsMissionComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function EightPetsMissionComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_EIGHT_PETS_MISSION
end

function EightPetsMissionComponent:InitComponentInfo(a_load_info)
  local m_cur_team_index = self.m_component_info.m_cur_team_index
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  self.m_component_info.m_cur_team_index = m_cur_team_index
  return ret
end

function EightPetsMissionComponent:GetCampaignMissionComponentId()
  return ECampaignMissionComponentId.ECampaignMissionComponentId_EightPets
end

function EightPetsMissionComponent:GetCampaignMissionParamKeyMap()
  local componentInfo = self:ComponentInfo()
  local nCfgId = self:GetComponetCfgId(componentInfo.m_campaign_id, componentInfo.m_component_id)
  return {
    [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = nCfgId
  }
end

function EightPetsMissionComponent:HandleEightPetsChangeFormationReq(TT, asyncRes, formation_index, formation_list)
  local request = EightPetsChangeFormationReq:New()
  request.formation_index = formation_index
  request.formation_list = formation_list
  local response = EightPetsChangeFormationReply:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS == asyncRes.m_result then
    local item = ComponentInfo.m_formation_info[formation_index]
    item.name = formation_list.name
    for k, v in pairs(formation_list.pet_list) do
      item.pet_list[k] = v
    end
  else
    Log.error("[CampaignCom][EightPetsMissionComponent] HandleEightPetsChangeFormationReq ret:", asyncRes.m_result)
  end
  return asyncRes, response
end

function EightPetsMissionComponent:IsPassCamMissionID(camMissionId)
  if self.m_component_info.m_pass_mission_info[camMissionId] then
    return true
  else
    return false
  end
end

function EightPetsMissionComponent:CampaignComponentPushNotify(notify_data)
  if EightPetsMissionComponentNotifyType.EightPetsMissionComponentNotifyType_InfoChanged == notify_data.m_notify_type then
    local ev = NotifyEightPetsMissionComponentInfoChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:OnUpdateBaseInfo(ev)
    else
      Log.error("[CampaignCom][EightPetsMissionComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function EightPetsMissionComponent:OnUpdateBaseInfo(ev)
  for key, value in pairs(ev.m_update_mission_info) do
    self.m_component_info.m_pass_mission_info[key] = value
  end
end

function EightPetsMissionComponent:GetCurrTeamId()
  local componentInfo = self:GetComponentInfo()
  local teamId = componentInfo.m_cur_team_index
  local theMax = 0
  for k, v in pairs(componentInfo.m_formation_info) do
    theMax = math.max(theMax, k)
  end
  teamId = math.max(teamId, 1)
  teamId = math.min(teamId, theMax)
  return teamId
end

function EightPetsMissionComponent:SetCurrTeamId(teamId)
  local componentInfo = self:GetComponentInfo()
  componentInfo.m_cur_team_index = teamId
end

function EightPetsMissionComponent:IsPrevPassInfoValid()
  return self.m_prev_pass_info_valid
end

function EightPetsMissionComponent:GetPrevPassInfo()
  return self.m_prev_pass_info
end

function EightPetsMissionComponent:SavePrevPassInfo()
  self.m_prev_pass_info_valid = true
  self.m_prev_pass_info = {}
  local mapPass = self:GetComponentInfo().m_pass_mission_info
  for k, v in pairs(mapPass) do
    self.m_prev_pass_info[k] = v
  end
end
