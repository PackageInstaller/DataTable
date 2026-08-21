_class("SailingMissionModule", GameModule)
SailingMissionModule = SailingMissionModule

function SailingMissionModule:Constructor()
  self.m_sailing_mission_info = {}
end

function SailingMissionModule:Init()
  SailingMissionModule.super.Init(self)
  self.caller:RegisterPushHandler(SailingPushOneLayerInfoChange, self.HandleLayerInfoChange, self)
  self.caller:RegisterPushHandler(SailingPushCurFormationChange, self.HandleFormationChange, self)
end

function SailingMissionModule:Dispose()
  self.caller:UnRegisterPushHandler(SailingPushOneLayerInfoChange)
  self.caller:UnRegisterPushHandler(SailingPushCurFormationChange)
  SailingMissionModule.super.Dispose(self)
end

function SailingMissionModule:HandleFormationChange(msg)
  self.m_sailing_mission_info.team_cache = msg.team_cache
end

function SailingMissionModule:HandleLayerInfoChange(msg)
  self.m_sailing_mission_info.max_layer_id = msg.max_layer_id
  self.m_sailing_mission_info.cur_exploration_progress = msg.cur_exploration_progress
  self.m_sailing_mission_info.history_exploration_progress = msg.history_exploration_progress
  self.m_sailing_mission_info.infos[msg.info.layer_id] = msg.info
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SailingMissionLayerInfoChanged, msg.info.layer_id)
end

function SailingMissionModule:Module_ConvertSailingMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_SailingMission
  uiMatchResult.m_nID = recvResult.mission_id
  uiMatchResult.m_parent_mission_id = recvResult.layer_id
  uiMatchResult.layer_mission_num = recvResult.layer_mission_num
  uiMatchResult.cur_max_layer = recvResult.cur_max_layer
  uiMatchResult.history_exploration_progress = recvResult.history_exploration_progress
  local cfg = Cfg.cfg_sailing_mission[recvResult.mission_id]
  local name = StringTable.Get(cfg.MissionName)
  uiMatchResult.m_stShowName = name
  return uiMatchResult
end

function SailingMissionModule:HandleGetSailingMissionData(TT)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplySailingMissionInfoReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_SAILINGMISSION_ERROR_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == SailingMissionErrorType.E_SAILINGMISSION_ERROR_TYPE_SUCCESS then
    self.m_sailing_mission_info = replyEvent.Data
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function SailingMissionModule:HandleChangeFormation(TT, layer_id, mission_id, pet_list)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplySMChangeFormationReq)
  request.formation_pet_list = pet_list
  request.layer_id = layer_id
  request.mission_id = mission_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_SAILINGMISSION_ERROR_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nFormationRet == SailingMissionErrorType.E_SAILINGMISSION_ERROR_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nFormationRet)
  end
  return AsyncRes
end

function SailingMissionModule:HandleResetMissionRecord(TT, layer_id, mission_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventResetSailingMissionRecordReq)
  request.layer_id = layer_id
  request.mission_id = mission_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_SAILINGMISSION_ERROR_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == SailingMissionErrorType.E_SAILINGMISSION_ERROR_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function SailingMissionModule:HandleReceiveRewards(TT, id_list)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventReceiveRewardReq)
  request.id_list = id_list
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_SAILINGMISSION_ERROR_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.ret == SailingMissionErrorType.E_SAILINGMISSION_ERROR_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
    self.m_sailing_mission_info.received_exploration_reward = replyEvent.received_exploration_reward
  else
    AsyncRes:SetResult(replyEvent.ret)
  end
  return AsyncRes, replyEvent.rewards
end

function SailingMissionModule:GetChallengeLayerID()
  return self.m_sailing_mission_info.max_layer_id
end

function SailingMissionModule:GetCurrentProgress()
  return self.m_sailing_mission_info.cur_exploration_progress
end

function SailingMissionModule:GetHistoryProgress()
  return self.m_sailing_mission_info.history_exploration_progress
end

function SailingMissionModule:GetLayerInfo(layer_id)
  return self.m_sailing_mission_info.infos[layer_id]
end

function SailingMissionModule:GetReceivedReward()
  return self.m_sailing_mission_info.received_exploration_reward
end

function SailingMissionModule:GetMissionTeams(layerId, missionId)
  if not self.m_sailing_mission_info then
    return {}
  end
  local layerInfo = self.m_sailing_mission_info.infos[layerId]
  if not layerInfo then
    return {}
  end
  local missionInfos = layerInfo.mission_infos
  for i = 1, #missionInfos do
    local missionInfo = missionInfos[i]
    if missionInfo.mission_id == missionId then
      return missionInfo.pet_list
    end
  end
  return {}
end

function SailingMissionModule:GetTeamCache()
  if not self.m_sailing_mission_info then
    return nil
  end
  return self.m_sailing_mission_info.team_cache
end

function SailingMissionModule:CacheFilterPetsLayerAndMissionId(layerId, missionId)
  self._cache_layer_id = layerId
  self._cache_mission_id = missionId
end

function SailingMissionModule:GetFilterPets()
  if not self.m_sailing_mission_info then
    return {}
  end
  local infos = self.m_sailing_mission_info.infos
  if not infos then
    return {}
  end
  local filterPets = {}
  for _, layerInfo in pairs(infos) do
    local missionInfos = layerInfo.mission_infos
    if missionInfos then
      for i = 1, #missionInfos do
        local missionInfo = missionInfos[i]
        local missionId = missionInfo.mission_id
        if layerInfo.layer_id == self._cache_layer_id and missionId ~= self._cache_mission_id then
          local petList = missionInfo.pet_list
          if petList then
            for j = 1, #petList do
              filterPets[petList[j]] = true
            end
          end
        end
      end
    end
  end
  return filterPets
end

function SailingMissionModule:CacheHistoryMissionCount()
  self._cache_history_mission_count = self.m_sailing_mission_info.history_exploration_progress
end

function SailingMissionModule:GetCacheHistoryMissionCount()
  return self._cache_history_mission_count
end

function SailingMissionModule:IsMissionComplete(layerId, missionId)
  if not self.m_sailing_mission_info then
    return false
  end
  local infos = self.m_sailing_mission_info.infos
  if not infos then
    return false
  end
  local layerInfo = self.m_sailing_mission_info.infos[layerId]
  if not layerInfo then
    return false
  end
  local missionInfos = layerInfo.mission_infos
  for i = 1, #missionInfos do
    local missionInfo = missionInfos[i]
    if missionInfo.mission_id == missionId then
      return true
    end
  end
  return false
end

function SailingMissionModule:IsShowRewardRedPoint()
  local showRetPoint = false
  local progress = self:GetHistoryProgress()
  local rewardList = self:GetReceivedReward()
  local dicReward = {}
  for _, v in pairs(rewardList) do
    dicReward[v] = v
  end
  local cfgs = Cfg.cfg_sailing_reward({})
  for _, v in pairs(cfgs) do
    if progress >= v.ExplorationProgress and dicReward[v.ID] == nil then
      showRetPoint = true
      break
    end
  end
  return showRetPoint
end
