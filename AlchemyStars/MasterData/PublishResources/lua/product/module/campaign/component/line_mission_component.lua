_class("LineMissionComponent", ICampaignComponent)
LineMissionComponent = LineMissionComponent

function LineMissionComponent:Constructor()
  self.m_component_info = LineMissionComponentInfo:New()
end

function LineMissionComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = LineMissionComponentInfo:New()
  end
  return self.m_component_info
end

function LineMissionComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function LineMissionComponent:IsPassCamMissionID(camMissionId)
  if self.m_component_info.m_pass_mission_info[camMissionId] then
    return true
  else
    return false
  end
end

function LineMissionComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_LINE_MISSION
end

function LineMissionComponent:GetLineSubCfg()
  local cfgid = self:GetComponentCfgId()
  local cfg = Cfg.cfg_component_link_sub[cfgid]
  return cfg
end

function LineMissionComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function LineMissionComponent:GetCampaignMissionComponentId()
  return ECampaignMissionComponentId.ECampaignMissionComponentId_Line
end

function LineMissionComponent:GetCampaignMissionParamKeyMap()
  local ComponentInfo = self:ComponentInfo()
  local nCfgId = self:GetComponetCfgId(ComponentInfo.m_campaign_id, ComponentInfo.m_component_id)
  return {
    [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = nCfgId
  }
end

function LineMissionComponent:CampaignComponentPushNotify(notify_data)
  if LineMissionComponentNotifyType.LineMissionComponentNotifyType_InfoChanged == notify_data.m_notify_type then
    local ev = NotifyLineMissionComponentInfoChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:OnUpdateBaseInfo(ev)
    else
      Log.error("[CampaignCom][LineMissionComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function LineMissionComponent:OnUpdateBaseInfo(ev)
  self.m_component_info.m_cur_mission = ev.m_cur_mission
  for key, value in pairs(ev.m_update_mission_info) do
    self.m_component_info.m_pass_mission_info[key] = value
  end
end

function LineMissionComponent:HandleCompleteStoryMission(TT, asyncRes, nMissionId)
  local request = CompleteStoryMissionReq:New()
  local response = CompleteStoryMissionRep:New()
  request.m_create_info.nCampaignMissionId = nMissionId
  local ComponentInfo = self:ComponentInfo()
  request.m_create_info.nMissionComId = self:GetCampaignMissionComponentId()
  request.m_create_info.CampaignMissionParams = self:GetCampaignMissionParamKeyMap()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][LineMissionComponent] HandleCompleteStoryMission ret:", asyncRes.m_result)
    return nil
  end
  if response.nErrorCode ~= MatchOpResCode.MATCH_SUCCESS then
    asyncRes:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE)
    return nil
  end
  return response.reward
end

function LineMissionComponent:HandleLineChangeFormationReq(TT, asyncRes, teamInfo)
  local request = LineChangeFormationReq:New()
  request.info = teamInfo
  local response = LineChangeFormationReply:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[LineMissionComponent:HandleLineChangeFormationReq] ret:", asyncRes.m_result)
  else
    local fid = teamInfo.id
    ComponentInfo.formation_list[fid].id = teamInfo.id
    ComponentInfo.formation_list[fid].name = teamInfo.name
    ComponentInfo.formation_list[fid].pet_list = teamInfo.pet_list
  end
  return asyncRes, response
end

function LineMissionComponent:SetMissionStoryActive(TT, mission_id, activeStoryType)
  local missionModule = GameGlobal.GetModule(MissionModule)
  return missionModule:SetMissionStoryActive(TT, mission_id, activeStoryType)
end

function LineMissionComponent:IsMissionStoryActive(mission_id, activeStoryType)
  local missionModule = GameGlobal.GetModule(MissionModule)
  missionModule:IsMissionStoryActive(mission_id, activeStoryType)
end

function LineMissionComponent:GetClearProgress()
  local cfgId = self:GetComponentCfgId()
  local cfg_component_line_mission = Cfg.cfg_component_line_mission({ComponentID = cfgId})
  local all = table.count(cfg_component_line_mission)
  local componentInfo = self:GetComponentInfo()
  local clear = table.count(componentInfo.m_pass_mission_info)
  return clear, all
end

function LineMissionComponent:Start_HandleCompleteStoryMission(stageId, callback)
  local isActive = self:IsPassCamMissionID(stageId)
  if isActive then
    return
  end
  GameGlobal.TaskManager():StartTask(function(TT)
    self:SetMissionStoryActive(TT, stageId, ActiveStoryType.ActiveStoryType_BeforeBattle)
    local res = AsyncRequestRes:New()
    local award = self:HandleCompleteStoryMission(TT, res, stageId)
    if callback then
      callback(res, award)
    end
  end)
end
