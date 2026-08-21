_class("BounceMissionComponent", ICampaignComponent)
BounceMissionComponent = BounceMissionComponent

function BounceMissionComponent:Constructor()
  self.m_component_info = ClientBounceMissionComponentInfo:New()
end

function BounceMissionComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = ClientBounceMissionComponentInfo:New()
  end
  return self.m_component_info
end

function BounceMissionComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function BounceMissionComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_BOUNCE_MISSION
end

function BounceMissionComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function BounceMissionComponent:HandleBounceMissionSettle(TT, asyncRes, missionId, killNum, killBossNum, cost_time)
  local request = BounceMissionSettleReq:New()
  local response = BounceMissionSettleRes:New()
  request.mission_id = missionId
  request.kill_num = killNum
  request.kill_boss_num = killBossNum
  request.game_cost_time = cost_time
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  local res = AsyncRequestRes:New()
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][BounceMissionComponent] HandleBounceMissionSettle ret:", asyncRes.m_result)
    res:SetSucc(false)
    return res
  end
  res:SetSucc(true)
  self.m_component_info.m_cur_mission = missionId
  self.m_component_info.m_pass_mission_info[missionId] = response.info
  return res
end

function BounceMissionComponent:HandleBounceMissionGetReward(TT, asyncRes, missionId, entieId)
  local request = BounceMissionGetRewardReq:New()
  local response = BounceMissionGetRewardRes:New()
  request.mission_id = missionId
  request.entie_id = entieId
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  local res = AsyncRequestRes:New()
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][BounceMissionComponent] HandleBounceMissionGetReward ret:", asyncRes.m_result)
    res:SetResult(asyncRes.m_result)
    return res
  end
  res:SetSucc(true)
  self.m_component_info.m_pass_mission_info[missionId] = response.info
  return res, response
end

function BounceMissionComponent:MissionCanRecvReward()
  local passMission = self.m_component_info.m_pass_mission_info
  if passMission == nil then
    return false
  end
  for k, v in pairs(passMission) do
    for sk, sv in pairs(v.enties_list) do
      if sv == BounceMission_Status.E_BounceMission_Status_CAN_RECV then
        return true
      end
    end
  end
  return false
end
