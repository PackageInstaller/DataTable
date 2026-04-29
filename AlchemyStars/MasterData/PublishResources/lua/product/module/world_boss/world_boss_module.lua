_class("WorldBossModule", GameModule)
WorldBossModule = WorldBossModule

function WorldBossModule:Constructor()
  self.m_world_boss_data = nil
  self.m_dan_info = nil
  self.m_cur_team_index = 1
  self.m_rank_damage_list = nil
  self.rank_max_show = 200
  self.m_cur_rank_topN = nil
  self.m_last_rank_topN = nil
  self.m_rank_stamp = {boss_mission_id = 0, time_stamp = 0}
  self._uiRecordDan = {}
  self._uiRecordDan.oldDan = -1
  self._uiRecordDan.oldRank = -1
  self._uiRecordDan.oldMissionId = -1
  self._bossLevelDifficultyIndex = 1
end

function WorldBossModule:SetBossLevelDifficultyIndex(index)
  self._bossLevelDifficultyIndex = index
end

function WorldBossModule:GetBossLevelDifficultyIndex()
  return self._bossLevelDifficultyIndex
end

function WorldBossModule:Init()
  self.caller:RegisterPushHandler(CEventMobilePushWorldBossRefresh, self.HandleWorldBossRefresh, self)
end

function WorldBossModule:SetCurSelectTeamIndex(index)
  self.m_cur_team_index = index
end

function WorldBossModule:GetCurSelectTeamIndex()
  return self.m_cur_team_index
end

function WorldBossModule:GetRecordByTeamIndex(index)
  if not self.m_world_boss_data then
    return nil
  end
  if #self.m_world_boss_data.formation_info.formation_list > 0 then
    for key, value in pairs(self.m_world_boss_data.formation_info.formation_list) do
      if index == value.id then
        return value
      end
    end
  end
  return nil
end

function WorldBossModule:ReqWorldBossData(TT)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyWorldBossInfoReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(WorldBossErrorType.E_WORLDBOSS_ERROR_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == WorldBossErrorType.E_WORLDBOSS_ERROR_TYPE_SUCCESS then
    self.m_world_boss_data = replyEvent.Data
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.Data
end

function WorldBossModule:SetPlayerWorldBossFormationInfo(pet_list)
  self.m_world_boss_data.formation_info.pet_list = pet_list
end

function WorldBossModule:ReqWorldBossChangeFormationInfo(TT, formation_pet_list)
  local AsyncRes = AsyncRequestRes:New()
  if formation_pet_list == nil then
    AsyncRes:SetResult(WorldBossErrorType.E_WORLDBOSS_FORMATION_DATA_INVALID)
    return AsyncRes
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyChangeWorldBossFormationReq)
  request.nId = self.m_cur_team_index
  request.formation_pet_list = formation_pet_list
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(WorldBossErrorType.E_WORLDBOSS_FORMATION_DATA_INVALID)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nFormationRet == WorldBossErrorType.E_WORLDBOSS_ERROR_TYPE_SUCCESS then
    self:SetPlayerWorldBossFormationInfo(formation_pet_list)
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nFormationRet)
  end
  return AsyncRes
end

function WorldBossModule:ReqResetRecord(TT, nId)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventResetRecordReq)
  request.nId = nId
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(WorldBossErrorType.E_WORLDBOSS_FORMATION_DATA_INVALID)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == WorldBossErrorType.E_WORLDBOSS_ERROR_TYPE_SUCCESS then
    self:SetPlayerWorldBossFormationInfo(nil)
    for i = 1, #self.m_world_boss_data.formation_info.formation_list do
      local formation_list = self.m_world_boss_data.formation_info.formation_list
      if formation_list[i] and formation_list[i].id == nId then
        table.remove(formation_list, i)
        break
      end
    end
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function WorldBossModule:ReqGetDanInfo(TT)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventGetDanInfoReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(WorldBossErrorType.E_WORLDBOSS_DAN_INVALID)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == WorldBossErrorType.E_WORLDBOSS_ERROR_TYPE_SUCCESS then
    self.m_dan_info = replyEvent.dan_info
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function WorldBossModule:ReqChoseRecord(TT, bSelectNew, nId, damage)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventChoseRecordReq)
  request.select_new = bSelectNew
  request.nId = nId
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(WorldBossErrorType.E_WORLDBOSS_FORMATION_DATA_INVALID)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == WorldBossErrorType.E_WORLDBOSS_ERROR_TYPE_SUCCESS then
    if bSelectNew then
      for key, value in pairs(self.m_world_boss_data.formation_info.formation_list) do
        if nId == value.id then
          self.m_world_boss_data.formation_info.formation_list[key].pet_list = self.m_world_boss_data.formation_info.pet_list
        end
      end
    end
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function WorldBossModule:Module_ConvertMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_WorldBoss
  uiMatchResult.m_nID = recvResult.mission_id
  uiMatchResult.m_damage = recvResult.total_damage
  local cfg = Cfg.cfg_world_boss_mission[recvResult.mission_id]
  if cfg then
    uiMatchResult.m_stShowName = StringTable.Get(cfg.MissionName)
  end
  return uiMatchResult
end

function WorldBossModule:TeamMemberChange()
  local missionModule = self:GetModule(MissionModule)
  local teamsContext = missionModule:TeamCtx()
  local newTeam = teamsContext:Teams():Get(teamsContext:GetCurrTeamId())
  local record = self:GetRecordByTeamIndex(self:GetCurSelectTeamIndex())
  local pets = {}
  if record then
    for i = 1, 5 do
      if newTeam.pets[i] and newTeam.pets[i] > 0 then
        if not pets[newTeam.pets[i]] then
          pets[newTeam.pets[i]] = 1
        else
          pets[newTeam.pets[i]] = 2
        end
      end
      if record.pet_list[i] and 0 < record.pet_list[i] then
        if not pets[record.pet_list[i]] then
          pets[record.pet_list[i]] = 1
        else
          pets[record.pet_list[i]] = 2
        end
      end
    end
    for key, value in pairs(pets) do
      if value < 2 then
        return true
      end
    end
  end
  return false
end

function WorldBossModule:HandleWorldBossRefresh(msg)
  self.m_cur_rank_topN = nil
  self.m_last_rank_topN = nil
  GameGlobal.EventDispatcher():Dispatch(GameEventType.WorldBossDanResult)
end

function WorldBossModule:CheckPetInRecordTeam(pstid)
  local inRecord = false
  if pstid <= 0 then
    return inRecord
  end
  if 0 < #self.m_world_boss_data.formation_info.formation_list then
    for key, value in pairs(self.m_world_boss_data.formation_info.formation_list) do
      if self.m_cur_team_index ~= value.id and table.icontains(value.pet_list, pstid) then
        inRecord = true
        break
      end
    end
  end
  return inRecord
end

function WorldBossModule:CurSeasonEnd()
  if self.m_world_boss_data then
    local svrTimeModule = self:GetModule(SvrTimeModule)
    return self.m_world_boss_data.end_time - svrTimeModule:GetServerTime() * 0.001 <= 0
  end
  return true
end

function WorldBossModule:GetWorldBossRedPoint()
  if not self._worldBossRedPoint then
    self._worldBossRedPoint = UIWorldBossRedPoint:New()
  end
  return self._worldBossRedPoint
end

function WorldBossModule:GetWorldBossRankDamageList(TT)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventGetRankDamageListReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(WorldBossErrorType.E_WORLDBOSS_ERROR_TYPE_FAILURE)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == WorldBossErrorType.E_WORLDBOSS_ERROR_TYPE_SUCCESS then
    self.m_rank_damage_list = replyEvent.damage_list
    self.rank_max_show = replyEvent.rank_max_num
    AsyncRes:SetSucc(true)
  else
    self.rank_max_show = 200
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function WorldBossModule:CheckGetWorldBossRankDamageList(TT)
  local sendDeltaTimeMs = 60000
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = svrTimeModule:GetServerTime()
  local bSendMsg = false
  if not self._getRankDamageListTime then
    bSendMsg = true
  elseif sendDeltaTimeMs < math.abs(curTime - self._getRankDamageListTime) then
    bSendMsg = true
  end
  if bSendMsg then
    local getListRes = self:GetWorldBossRankDamageList(TT)
    if getListRes:GetSucc() then
      self._getRankDamageListTime = curTime
    end
    return getListRes
  else
    local AsyncRes = AsyncRequestRes:New()
    AsyncRes:SetSucc(true)
    return AsyncRes
  end
end

function WorldBossModule:SetUiOldDan(dan, rank, missionId)
  self._uiRecordDan.oldDan = dan
  self._uiRecordDan.oldRank = rank
  self._uiRecordDan.oldMissionId = missionId
end

function WorldBossModule:GetUiOldDan(curMissionId)
  if curMissionId == self._uiRecordDan.oldMissionId then
    return self._uiRecordDan.oldDan, self._uiRecordDan.oldRank
  else
    return -1, -1
  end
end

function WorldBossModule:AwardMultiOpen()
  return self:GetAwardMultiple() > 1 and not self:CurSeasonEnd()
end

function WorldBossModule:GetAwardMultiple()
  if not self.m_world_boss_data or self.m_world_boss_data.boss_mission_id <= 0 then
    return 0
  end
  local cfg = Cfg.cfg_world_boss_mission[self.m_world_boss_data.boss_mission_id]
  if cfg then
    return cfg.AwardMulti
  end
  return 0
end

function WorldBossModule:GetWorldBossRankTopN(TT, is_cur_rank)
  local timeMod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmNowTime = timeMod:GetServerTime()
  self.m_rank_stamp.boss_mission_id = self.m_world_boss_data.boss_mission_id
  self.m_rank_stamp.time_stamp = tmNowTime
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventGetRankTopNReq)
  request.is_cur_rank = is_cur_rank
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(WorldBossErrorType.E_WORLDBOSS_ERROR_TYPE_FAILURE)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == WorldBossErrorType.E_WORLDBOSS_ERROR_TYPE_SUCCESS then
    if is_cur_rank then
      self.m_cur_rank_topN = replyEvent.show_list
    else
      self.m_last_rank_topN = replyEvent.show_list
    end
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function WorldBossModule:GetRankOneDetail(TT, pstid)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRankOneDetailReq)
  request.pstid = pstid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(WorldBossErrorType.E_WORLDBOSS_ERROR_TYPE_FAILURE)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == WorldBossErrorType.E_WORLDBOSS_ERROR_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.detail_info
end

function WorldBossModule:NeedRequestRank()
  if self.m_world_boss_data == nil then
    return true, true
  end
  if self.m_world_boss_data.boss_mission_id ~= self.m_rank_stamp.boss_mission_id then
    return true, true
  end
  local timeMod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmNowTime = timeMod:GetServerTime()
  if tmNowTime - self.m_rank_stamp.time_stamp >= 59000 then
    return true, self.m_last_rank_topN == nil
  end
  return self.m_cur_rank_topN == nil, self.m_last_rank_topN == nil
end

function WorldBossModule:QuestHaveRedPoint()
  local haveRedPoint = false
  local idMission = self.m_world_boss_data.boss_mission_id
  local cfg_mission = Cfg.cfg_world_boss_mission[idMission]
  local QuestList
  if cfg_mission ~= nil and cfg_mission.QuestList ~= nil then
    QuestList = cfg_mission.QuestList
  else
    QuestList = {}
  end
  local questModule = self:GetModule(QuestModule)
  for k, v in pairs(QuestList) do
    local quest = questModule:GetQuest(v)
    local qinfo
    if quest ~= nil then
      qinfo = quest:QuestInfo()
    end
    if qinfo ~= nil and qinfo.status == QuestStatus.QUEST_Completed then
      haveRedPoint = true
      break
    end
  end
  return haveRedPoint
end
