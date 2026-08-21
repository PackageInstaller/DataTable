_class("LostAreaModule", GameModule)
LostAreaModule = LostAreaModule

function LostAreaModule:Constructor()
  self._difficulty_status = {}
  self._nextRefreshTime = 0
  self._choosed_design_id = 0
  self._difficult_mission_info = {}
  self._areaDesignCfg = {}
  self._areaLevelGroupCfg = {}
end

function LostAreaModule:Init()
end

function LostAreaModule:LoadInitializeData(designConfig, levelGroupConfig)
  self._areaDesignCfg = designConfig
  self._areaLevelGroupCfg = levelGroupConfig
end

function LostAreaModule:RequestLostAreaRedDot(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventLostAreaRedDotReq)
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  return reply.msg.show
end

function LostAreaModule:RequestLostAreadifficultyStatus(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventLostAreadifficultyStatusReq)
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == LOST_AREA_RESULT_CODE.LOST_AREA_SUCCEED then
    self._nextRefreshTime = replyEvent.next_refresh_time
    self._difficulty_status = replyEvent.status
    self._areaDesignCfg = replyEvent.area_design_cfg
    self._areaLevelGroupCfg = replyEvent.area_level_group_cfg
  end
  return res
end

function LostAreaModule:GetDifficultyStatusData()
  return self._nextRefreshTime, self._difficulty_status
end

function LostAreaModule:GetLostAreaDesignConfig()
  return self._areaDesignCfg
end

function LostAreaModule:GetLostAreaLevelGroupConfig()
  return self._areaLevelGroupCfg
end

function LostAreaModule:RequestLostAreaUnlockOnedifficulty(TT, designID)
  local request = NetMessageFactory:GetInstance():CreateMessage(CeventLostAreaUnlockOnedifficultyReq)
  local res = AsyncRequestRes:New()
  request.id = designID
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res
end

function LostAreaModule:RequestLostAreadifficultyMission(TT, designID)
  local request = NetMessageFactory:GetInstance():CreateMessage(CeventLostAreaGetdifficultyMissionReq)
  request.ID = designID
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == LOST_AREA_RESULT_CODE.LOST_AREA_SUCCEED then
    self._difficult_mission_info = replyEvent.difficult_mission_info
  end
  return res
end

function LostAreaModule:GetLostAreadifficultyMission()
  return self._difficult_mission_info
end

function LostAreaModule:RequestLostAreaChooseWeekDifficulty(TT, designID)
  local request = NetMessageFactory:GetInstance():CreateMessage(CeventLostAreaChooseWeekDifficultyReq)
  request.design_id = designID
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == LOST_AREA_RESULT_CODE.LOST_AREA_SUCCEED then
    self._difficult_mission_info = replyEvent.difficult_mission_info
  end
  return res
end

function LostAreaModule:Module_ConvertMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_LostArea
  uiMatchResult.m_nID = recvResult.mission_id
  uiMatchResult.m_vecFirstPassAward = recvResult.first_pass_rewards
  uiMatchResult.m_recommend_pet_rewards = recvResult.recommend_pet_rewards
  return uiMatchResult
end
