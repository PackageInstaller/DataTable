_class("DifficultyMissionModule", GameModule)
DifficultyMissionModule = DifficultyMissionModule

function DifficultyMissionModule:Constructor()
  self.m_difficulty_mission_info = {}
end

function DifficultyMissionModule:Init()
  DifficultyMissionModule.super.Init(self)
  self.caller:RegisterPushHandler(PushOneParentInfoChange, self.HandleParentInfoChange, self)
  self.caller:RegisterPushHandler(PushCurFormationChange, self.HandleFormationChange, self)
end

function DifficultyMissionModule:Dispose()
  self.caller:UnRegisterPushHandler(PushOneParentInfoChange)
  self.caller:UnRegisterPushHandler(PushCurFormationChange)
  DifficultyMissionModule.super.Dispose(self)
end

function DifficultyMissionModule:HandleFormationChange(msg)
  self.m_difficulty_mission_info.pet_list = msg.formation_pet_list
  self:GetUIModule():FlushTeam(msg.formation_pet_list)
end

function DifficultyMissionModule:HandleParentInfoChange(msg)
  self.m_difficulty_mission_info.cur_parent_id = msg.cur_mission_id
  self.m_difficulty_mission_info.infos[msg.info.parent_mission_id] = msg.info
end

function DifficultyMissionModule:Module_ConvertDiffMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_DifficultyMission
  uiMatchResult.m_nID = recvResult.sub_mission_id
  uiMatchResult.m_parent_mission_id = recvResult.parent_mission_id
  uiMatchResult.m_enties = recvResult.entries
  uiMatchResult.m_vecAwardNormal = recvResult.rewards
  local cfg = Cfg.cfg_difficulty_sub_mission[recvResult.sub_mission_id]
  local name = StringTable.Get(cfg.MissionName)
  uiMatchResult.m_stShowName = name
  return uiMatchResult
end

function DifficultyMissionModule:HandleGetDifficultyMissionData(TT)
  if GameSingle then
    self.m_difficulty_mission_info.infos = {}
    self.m_difficulty_mission_info.pet_list = {}
    self.m_difficulty_mission_info.cur_parent_id = 111006
    local cfg_difficulty_parent_missions = Cfg.cfg_difficulty_parent_mission({})
    for k, v in pairs(cfg_difficulty_parent_missions) do
      if v.ID < 100 or v.ID > 110000 then
        local info = ParentMissionInfo:New()
        info.complete_enties = {}
        info.parent_mission_id = v.ID
        info.status = 1
        info.sub_mission_infos = {}
        local subMissions = v.SubMissionList
        for i = 1, #subMissions do
          local subInfo = SubMissionInfo:New()
          subInfo.max_left_turn = 0
          subInfo.pet_list = {}
          subInfo.mission_id = subMissions[i]
          table.insert(info.sub_mission_infos, subInfo)
        end
        self.m_difficulty_mission_info.infos[v.ID] = info
      end
    end
    return
  end
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyDifficultyMissionInfoReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_DIFFICULTYMISSION_ERROR_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == DifficultyMissionErrorType.E_DIFFICULTYMISSION_ERROR_TYPE_SUCCESS then
    self.m_difficulty_mission_info = replyEvent.Data
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function DifficultyMissionModule:HandleChangeFormation(TT, parent_mission_id, sub_id, pet_list)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyChangeFormationReq)
  request.parent_mission_id = parent_mission_id
  request.formation_pet_list = pet_list
  request.sub_mission_id = sub_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_DIFFICULTYMISSION_ERROR_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nFormationRet == DifficultyMissionErrorType.E_DIFFICULTYMISSION_ERROR_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nFormationRet)
  end
  return AsyncRes
end

function DifficultyMissionModule:HandleResetSubMissionRecord(TT, parent_mission_id, sub_mission_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventResetSubMissionRecordReq)
  request.parent_mission_id = parent_mission_id
  request.sub_mission_id = sub_mission_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_DIFFICULTYMISSION_ERROR_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == DifficultyMissionErrorType.E_DIFFICULTYMISSION_ERROR_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function DifficultyMissionModule:ReqParentMissionPassData(TT, nId)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyParentMissionPassDataReq)
  request.nMissionId = nId
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(-1)
    return AsyncRes, nil
  end
  local replyEvent = reply.msg
  AsyncRes:SetSucc(true)
  return AsyncRes, replyEvent.info
end
