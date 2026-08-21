_class("SeasonMissionComponent", ICampaignComponent)
SeasonMissionComponent = SeasonMissionComponent

function SeasonMissionComponent:Constructor()
  self._componentInfo = SeasonMissionComponentInfo:New()
end

function SeasonMissionComponent:ComponentInfo()
  if not self._componentInfo then
    self._componentInfo = SeasonMissionComponentInfo:New()
  end
  return self._componentInfo
end

function SeasonMissionComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function SeasonMissionComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_SEASON
end

function SeasonMissionComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self._componentInfo)
  return ret
end

function SeasonMissionComponent:IsPassCamMissionID(camMissionId)
  if self._componentInfo.m_pass_mission_info[camMissionId] then
    return true
  else
    return false
  end
end

function SeasonMissionComponent:GetMask(id)
  return self._componentInfo.m_stage_info[id]
end

function SeasonMissionComponent:GetPassStar(missionID)
  local star = 0
  local passInfo = self._componentInfo.m_pass_mission_info[missionID]
  if passInfo then
    for i = 1, 3 do
      if 0 < passInfo.star & 1 << i - 1 then
        star = star + 1
      end
    end
  end
  return star
end

function SeasonMissionComponent:GetCampaignMissionParamKeyMap()
  local ComponentInfo = self:ComponentInfo()
  local nCfgId = self:GetComponetCfgId(ComponentInfo.m_campaign_id, ComponentInfo.m_component_id)
  return {
    [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = nCfgId,
    [ECampaignMissionParamKey.ECampaignMissionParamKey_CSHardId] = ComponentInfo.m_daily_info.m_progress
  }
end

function SeasonMissionComponent:GetCampaignMissionComponentId()
  return ECampaignMissionComponentId.ECampaignMissionComponentId_SeasonMission
end

function SeasonMissionComponent:CampaignComponentPushNotify(notify_data)
  if SeasonMissionComponentNotifyType.SeasonMissionComponentNotifyType_InfoChanged == notify_data.m_notify_type then
    local ev = NotifySeasonMissionComponentInfoChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:OnUpdateBaseInfo(ev)
    else
      Log.error("[CampaignCom][SeasonMissionComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
  if SeasonMissionComponentNotifyType.SeasonMissionComponentNotifyTypeDaily_InfoChanged == notify_data.m_notify_type then
    local ev = NotifySeasonMissionDailyComponentInfoChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self._componentInfo.m_daily_info = ev.m_daily_info
      if ev.m_is_reset then
        self:OnReset()
      end
    else
      Log.error("[CampaignCom][SeasonMissionComponent] CampaignComponentPushNotify2 ParseData error! ret:", ret)
    end
  end
end

function SeasonMissionComponent:OnUpdateBaseInfo(ev)
  self._componentInfo.m_cur_mission = ev.m_cur_mission
  for key, value in pairs(ev.m_update_mission_info) do
    self._componentInfo.m_pass_mission_info[key] = value
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonSceneAwardCollected)
end

function SeasonMissionComponent:HandleCompleteStoryMission(TT, asyncRes, missionId)
  local request = CompleteStorySeasonMissionReq:New()
  local response = CompleteStorySeasonMissionRep:New()
  request.m_create_info.nCampaignMissionId = missionId
  local ComponentInfo = self:ComponentInfo()
  request.m_create_info.nMissionComId = self:GetCampaignMissionComponentId()
  request.m_create_info.CampaignMissionParams = self:GetCampaignMissionParamKeyMap()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE)
    Log.error("[CampaignCom][SeasonMissionComponent] HandleCompleteStoryMission ret:", asyncRes.m_result)
    return nil
  end
  return response
end

function SeasonMissionComponent:HandleSeasonChangeFormation(TT, asyncRes, teamInfo)
  local request = SeasonChangeFormationReq:New()
  local response = SeasonChangeFormationReply:New()
  request.info = teamInfo
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE)
    Log.error("[CampaignCom][SeasonMissionComponent] HandleSeasonChangeFormation ret:", asyncRes.m_result)
    return nil
  end
  ComponentInfo.m_formation_list[teamInfo.id] = teamInfo
  return response
end

function SeasonMissionComponent:HandleSeasonClientDataPoint(TT, asyncRes, x, y, z)
  local request = SeasonClientDataPointReq:New()
  local response = SeasonClientDataPointReply:New()
  request.m_x = x
  request.m_y = y
  request.m_z = z
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE)
    Log.error("[CampaignCom][SeasonMissionComponent] HandleSeasonClientDataPoint ret:", asyncRes.m_result)
    return nil
  end
  ComponentInfo.m_client_info.m_x = x
  ComponentInfo.m_client_info.m_y = y
  ComponentInfo.m_client_info.m_z = z
  return response
end

function SeasonMissionComponent:HandleSeasonClientDataExt(TT, asyncRes, tables)
  local request = SeasonClientDataExtReq:New()
  local response = SeasonClientDataExtReply:New()
  local tz = table.count(tables)
  if 100 <= tz then
    asyncRes:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE)
    Log.error("[CampaignCom][SeasonMissionComponent] HandleSeasonClientDataExt ret:", asyncRes.m_result)
    return nil
  end
  request.ext = tables
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE)
    Log.error("[CampaignCom][SeasonMissionComponent] HandleSeasonClientDataExt ret:", asyncRes.m_result)
    return nil
  end
  for key, value in pairs(tables) do
    ComponentInfo.m_client_info.ext[key] = value
  end
  return response
end

function SeasonMissionComponent:HandleSeasonClientStageData(TT, asyncRes, id, type)
  local request = SeasonClientStageDataReq:New()
  local response = SeasonClientStageDataReply:New()
  request.id = id
  request.type = type
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE)
    Log.error("[CampaignCom][SeasonMissionComponent] HandleSeasonClientStageData ret:", asyncRes.m_result)
    return nil
  end
  ComponentInfo.m_stage_info[id] = type
  return response
end

function SeasonMissionComponent:HandleSeasonPointClientData(TT, asyncRes, point_info)
  local request = SeasonPointClientDataReq:New()
  local response = SeasonPointClientDataReply:New()
  request.m_save_info = point_info
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE)
    Log.error("[CampaignCom][SeasonMissionComponent] HandleSeasonPointClientData ret:", asyncRes.m_result)
    return nil
  end
  ComponentInfo.m_daily_info.m_save_info = point_info
  return response
end

function SeasonMissionComponent:HandleMissionTeamRecord(TT, asyncRes, num, mission)
  local request = SeasonMissionTeamRecordReq:New()
  local response = SeasonMissionTeamRecordRes:New()
  request.num = num
  request.mission = mission
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][SeasonMissionComponent] HandleMissionTeamRecord ret:", asyncRes.m_result)
    return nil
  end
  return response
end

function SeasonMissionComponent:SetMissionStoryActive(TT, mission_id, activeStoryType)
  local missionModule = GameGlobal.GetModule(MissionModule)
  return missionModule:SetMissionStoryActive(TT, mission_id, activeStoryType)
end

function SeasonMissionComponent:IsMissionStoryActive(mission_id, activeStoryType)
  local missionModule = GameGlobal.GetModule(MissionModule)
  missionModule:IsMissionStoryActive(mission_id, activeStoryType)
end

function SeasonMissionComponent:OnReset()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonDailyReset)
  Log.info("[CampaignCom][SeasonMissionComponent] OnRest")
end
