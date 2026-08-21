require("component_base")
_class("PopStarComponent", ICampaignComponent)
PopStarComponent = PopStarComponent

function PopStarComponent:Constructor()
  self.m_component_info = PopStarComponentInfo:New()
end

function PopStarComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = PopStarComponentInfo:New()
  end
  return self.m_component_info
end

function PopStarComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function PopStarComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_POPSTAR_MISSION
end

function PopStarComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function PopStarComponent:GetCampaignMissionComponentId()
  return ECampaignMissionComponentId.ECampaignMissionComponentId_PopStar
end

function PopStarComponent:GetCampaignMissionParamKeyMap()
  local componentInfo = self:ComponentInfo()
  local nCfgId = self:GetComponetCfgId(componentInfo.m_campaign_id, componentInfo.m_component_id)
  return {
    [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = nCfgId
  }
end

function PopStarComponent:HandlePopStarChangeFormation(TT, asyncRes, pet_data_list)
  local request = PopStarChangeFormationReq:New()
  request.formation_pet_list = pet_data_list
  local response = PopStarChangeFormationRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][PopStarComponent] HandlePopStarChangeFormation ret:", asyncRes.m_result)
    return nil
  end
  self.m_component_info.formation_pet_list = pet_data_list
  asyncRes:SetSucc(true)
end

function PopStarComponent:CampaignComponentPushNotify(notify_data)
  if PopStarComponentNotifyType.PopStarMissionComponentNotifyType_InfoChanged == notify_data.m_notify_type then
    local ev = NotifyPopStarComponentInfoChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self.m_component_info.m_pass_mission_info = ev.m_update_mission_info
      self.m_component_info.m_received = ev.m_received
      self.m_component_info.m_max_score = ev.m_max_score
    else
      Log.error("[CampaignCom][PopStarComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end
