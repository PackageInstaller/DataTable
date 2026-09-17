local this = {}

function this:req_CSProtoMultiCampaignCreate(dungeonId, callBack)
  local data = {dungeon_id = dungeonId}
  L_Net:sendMessage(MsgGenCode.CSProtoMultiCampaignCreate, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callBack then
      callBack(rspData)
    end
  end)
end

function this:req_CSProtoMultiCampaignQuit(callBack)
  L_Net:sendMessage(MsgGenCode.CSProtoMultiCampaignQuit, nil, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callBack then
      callBack(rspData)
    end
  end)
end

function this:req_CSProtoCreateMatchTeam(dungeonId, callBack)
  local data = {dungeon_id = dungeonId}
  L_Net:sendMessage(MsgGenCode.CSProtoCreateMatchTeam, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callBack then
      callBack(rspData)
    end
  end)
end

function this:req_CSProtoLeaveMatchTeam(callBack)
  L_Net:sendMessage(MsgGenCode.CSProtoLeaveMatchTeam, nil, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self.data.matchTeamData = {}
      self:call(self.event.syncMatchTeamData)
      if callBack then
        callBack(rspData)
      end
    end
  end)
end

function this:req_CSProtoKickOutMatchTeam(pid, callBack)
  local data = {pid = pid}
  L_Net:sendMessage(MsgGenCode.CSProtoKickOutMatchTeam, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callBack then
      callBack(rspData)
    end
  end)
end

function this:req_CSProtoInviteJoinMatchTeam(pid, pos, isQuit, callBack)
  local data = {
    pid = pid,
    position = pos,
    is_quit = isQuit
  }
  L_Net:sendMessage(MsgGenCode.CSProtoInviteJoinMatchTeam, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if isQuit then
        self.data.inviteWaitDic[pos] = nil
      else
        self.data.inviteWaitDic[pos] = {
          pid = pid,
          position = pos,
          start_time = L_TimeUtil.getServerTime()
        }
      end
      self:call(self.event.syncMatchTeamInviteData)
    end
    if callBack then
      callBack(rspData, errorCode)
    end
  end)
end

function this:req_CSProtoReplyInviteJoinMatchTeam(isAccept, callBack)
  local data = {is_accept = isAccept}
  L_Net:sendMessage(MsgGenCode.CSProtoReplyInviteJoinMatchTeam, data, function(rspData, errorCode)
    if callBack then
      callBack(rspData, errorCode)
    end
  end)
end

function this:req_CSProtoStartMatch(callBack)
  L_Net:sendMessage(MsgGenCode.CSProtoStartMatch, nil, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callBack then
      callBack(rspData)
    end
  end)
end

function this:req_CSProtoStopMatch(callBack)
  L_Net:sendMessage(MsgGenCode.CSProtoStopMatch, nil, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callBack then
      callBack(rspData)
    end
  end)
end

function this:req_CSProtoMatchedReady(isReady, callBack)
  local data = {is_ready = isReady}
  L_Net:sendMessage(MsgGenCode.CSProtoMatchedReady, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callBack then
      callBack(rspData)
    end
  end)
end

function this:req_CSProtoStaminaBoxGiveUp(staminaChestId)
  local data = {box_id = staminaChestId}
  L_Net:sendMessage(MsgGenCode.CSProtoStaminaBoxGiveUp, data)
end

function this:rsp_syncMultiDungeonInfo(data)
  for i, v in pairs(data.camp or {}) do
    local info = v
    self.data.multiDungeonInfoDic[info.dungeon_id] = info
  end
  self:call(self.event.syncMultiDungeonInfo)
end

function this:rsp_syncCurMultiDungeonInfo(data)
  print("dungeon_id: " .. tostring(data.dungeon_id))
  print("status: " .. tostring(data.status))
  print("start_time: " .. tostring(data.start_time))
  print("end_time: " .. tostring(data.end_time))
  print("star: " .. tostring(data.star))
  print("score: " .. tostring(data.score))
  self.data.curMultiDungeonInfo = data
  if data == nil then
    return
  end
  if self.data.multiDungeonInfoDic[data.dungeon_id] and self.data.multiDungeonInfoDic[data.dungeon_id].score ~= nil and data.score ~= nil and self.data.multiDungeonInfoDic[data.dungeon_id].score < data.score or not self.data.multiDungeonInfoDic[data.dungeon_id] then
    self.data.multiDungeonInfoDic[data.dungeon_id] = data
  end
  self:call(self.event.syncCurMultiDungeonInfo)
end

function this:rsp_syncMatchTeamData(data)
  self.data.matchTeamSyncReason = data.reason
  self.data.matchTeamData = data.team or {}
  if table.isEmpty(self.data.matchTeamData) then
    self.data.inviteWaitDic = {}
  end
  self:call(self.event.syncMatchTeamData)
end

function this:rsp_syncMatchTeamInviteData(data)
  self.data.matchTeamInviteData = data.invite
  self:call(self.event.syncMatchTeamInviteData)
end

function this:rsp_syncMatchedReadyData(data)
  self.data.matchedReadyData = data
  self:call(self.event.syncMatchedReadyData)
end

function this:rsp_syncRejectInviteJoinMatchTeamData(data)
  data = data or {}
  for i, v in pairs(self.data.inviteWaitDic) do
    if v.pid == data.pid then
      self.data.inviteWaitDic[i] = nil
      break
    end
  end
  self:call(self.event.rejectInviteJoinMatchTeam, data.pid)
end

return this
