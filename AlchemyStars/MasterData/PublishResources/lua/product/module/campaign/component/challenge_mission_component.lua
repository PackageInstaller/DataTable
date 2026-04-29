_class("ChallengeMissionComponent", ICampaignComponent)
ChallengeMissionComponent = ChallengeMissionComponent

function ChallengeMissionComponent:Constructor()
  self.m_component_info = ChallengeMissionComponentInfo:New()
  self.m_score = {}
end

function ChallengeMissionComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = ChallengeMissionComponentInfo:New()
  end
  return self.m_component_info
end

function ChallengeMissionComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function ChallengeMissionComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_CHALL_MISSION
end

function ChallengeMissionComponent:InitComponentInfo(a_load_info)
  self.login_mod = GameGlobal.GameLogic():GetModule(LoginModule)
  self.role_mod = GameGlobal.GameLogic():GetModule(RoleModule)
  self.cam_mod = GameGlobal.GameLogic():GetModule(CampaignModule)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function ChallengeMissionComponent:SetScore(LeveIndex, value)
  self.m_score[LeveIndex] = value
end

function ChallengeMissionComponent:GetScore(LeveIndex)
  return self.m_score[LeveIndex]
end

function ChallengeMissionComponent:IsPassMission(misssId)
  return self.m_component_info.m_pass_mission_info[misssId]
end

function ChallengeMissionComponent:GetCampaignMissionComponentId()
  return ECampaignMissionComponentId.ECampaignMissionComponentId_ChallengeMission
end

function ChallengeMissionComponent:GetCampaignMissionParamKeyMap()
  local ComponentInfo = self:ComponentInfo()
  local nCfgId = self:GetComponetCfgId(ComponentInfo.m_campaign_id, ComponentInfo.m_component_id)
  return {
    [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = nCfgId
  }
end

function ChallengeMissionComponent:HaveRedPoint()
  return true
end

function ChallengeMissionComponent:CloseTodayRedPoint()
end

function ChallengeMissionComponent:GetCfgMap()
  local ComponentInfo = self:ComponentInfo()
  if ComponentInfo == nil then
    return nil
  end
  local componentId = self:GetComponentCfgId()
  local cfgMap = Cfg.cfg_component_challenge_mission({ComponentID = componentId})
  return cfgMap
end

function ChallengeMissionComponent:CloseLoginRed(capName, funcName)
  local lrt = self.role_mod:GetLoginTme()
  self.cam_mod:SetDB(lrt, capName, funcName)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignComponentStepChange, l_component_info.m_campaign_id, nil, nil)
end

function ChallengeMissionComponent:SetMissionId(id, capName, funcName)
  self.cam_mod:SetDB(id, capName, funcName)
end

function ChallengeMissionComponent:HaveRed(capName, funcName)
  local lrt = self.role_mod:GetLoginTme()
  if self.cam_mod:GetDB(lrt, capName, funcName) == 1 then
    return 0
  end
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  if not time_mod then
    return 0
  end
  local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
  local num = 0
  for key, value in pairs(self.m_component_info.m_challenge_unlock_time) do
    if value <= tmNowTime and self.cam_mod:GetDB(key, capName, funcName) == 0 then
      num = num + 1
    end
  end
  return num
end

function ChallengeMissionComponent:HaveNewIds()
  local cfgMap = self:GetCfgMap()
  if cfgMap == nil then
    return nil
  end
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  if not time_mod then
    return nil
  end
  local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
  local loginModule = GameGlobal.GameLogic():GetModule(LoginModule)
  
  local function cb(cfgChallenge)
    if cfgChallenge.NewTip == 0 then
      return false
    end
    if cfgChallenge.UnlockNeedTime ~= "" then
      local timer = loginModule:GetTimeStampByTimeStr(cfgChallenge.UnlockNeedTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
      if timer > tmNowTime then
        return false
      end
    end
    for k, v in pairs(self.m_component_info.new_look_ids) do
      if v == cfgChallenge.CampaignMissionId then
        return false
      end
    end
    if 0 < cfgChallenge.UnlockMissionId and self.m_component_info.m_pass_mission_info[cfgChallenge.UnlockMissionId] == nil then
      return false
    end
    if 0 < cfgChallenge.UnlockScore and cfgChallenge.UnlockScore > self.m_component_info.m_max_score[cfgChallenge.LeveIndex] then
      return false
    end
    if self.m_component_info.m_pass_mission_info[cfgChallenge.CampaignMissionId] ~= nil then
      return false
    end
    return true
  end
  
  local ids = {}
  for key, value in pairs(cfgMap) do
    if cb(value) == true then
      ids[value.ID] = true
    end
  end
  return ids
end

function ChallengeMissionComponent:HandleClearAffix(TT, asyncRes, nChallengeMissionId)
  local request = ChallengeClearAffixReq:New()
  request.nChallengeMissionId = nChallengeMissionId
  local response = ChallengeClearAffixRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][ChallengeMissionComponent] HandleClearAffix ret:", asyncRes.m_result)
  else
    self.m_component_info.m_select_affix[nChallengeMissionId] = {}
  end
  return asyncRes, response
end

function ChallengeMissionComponent:HandleSelectAffix(TT, asyncRes, nChallengeMissionId, nAffixList)
  local request = ChallengeSelectAffixReq:New()
  request.nCampaignMissionId = nChallengeMissionId
  request.selectAffixIdArray = nAffixList
  local response = ChallengeSelectAffixRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][ChallengeMissionComponent] HandleSelectAffix ret:", asyncRes.m_result)
  else
    if self.m_component_info.m_select_affix[nChallengeMissionId] == nil then
      self.m_component_info.m_select_affix[nChallengeMissionId] = {}
    end
    self.m_component_info.m_select_affix[nChallengeMissionId] = nAffixList
  end
  return asyncRes, response
end

function ChallengeMissionComponent:CampaignComponentPushNotify(notify_data)
  local ev = NotifyChallengeMissionScoreChanged:New()
  if ChallengeComponentNotifyType.ChallengeComponentNotifyType_ScoreChange == notify_data.m_notify_type then
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      if ev.m_total_score > ev.m_last_score then
        self.m_component_info.m_max_score[ev.m_group_id] = ev.m_total_score
      end
      self:SetScore(ev.m_group_id, ev.m_total_score)
      for key, value in pairs(ev.m_missions) do
        self.m_component_info.m_pass_mission_info[value.mission_id] = value
      end
    else
      Log.error("[CampaignCom][ChallengeMissionComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function ChallengeMissionComponent:HandleChallengeChangeFormationReq(TT, asyncRes, teamInfo)
  local request = ChallengeChangeFormationReq:New()
  request.info = teamInfo
  local response = ChallengeChangeFormationReply:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][ChallengeMissionComponent] HandleChallengeChangeFormationReq ret:", asyncRes.m_result)
  else
    local fid = teamInfo.id
    ComponentInfo.formation_list[fid].id = teamInfo.id
    ComponentInfo.formation_list[fid].name = teamInfo.name
    ComponentInfo.formation_list[fid].pet_list = teamInfo.pet_list
  end
  return asyncRes, response
end

function ChallengeMissionComponent:HandleChallengeClearNewReq(TT, asyncRes, levelIds)
  local request = ChallengeClearNewReq:New()
  local response = ChallengeClearNewRep:New()
  request.look_ids = levelIds
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][ChallengeMissionComponent] HandleChallengeClearNewReq ret:", asyncRes.m_result)
  end
  ComponentInfo.new_look_ids = response.new_look_ids
  return asyncRes, response
end
