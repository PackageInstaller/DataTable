local PvpPasswordModel = NewClass("PvpPasswordModel", BaseModel)

function PvpPasswordModel:OnInit()
  self._pvpRoomData = nil
  self._rejectMap = {}
end

function PvpPasswordModel:OnReset()
  self:OnInit()
end

function PvpPasswordModel:IsPvpPasswordRoom()
  return not self:IsRoomClosed()
end

function PvpPasswordModel:SetRoomData(roomData)
  self._pvpRoomData = roomData
  if roomData and roomData.pvpType then
    self:SetPvpType(roomData.pvpType)
  end
end

function PvpPasswordModel:GetRoomData()
  return self._pvpRoomData
end

function PvpPasswordModel:SetRejectMap(rejectMap)
  Logger.Proto("SetRejectMap", table.tostring(rejectMap))
  self._rejectMap = rejectMap or {}
end

function PvpPasswordModel:UpdateRejectMap(updateMap)
  if not self._rejectMap then
    self._rejectMap = updateMap
    return
  end
  for uid, contsInfo in pairs(updateMap) do
    self._rejectMap[uid] = contsInfo
  end
end

function PvpPasswordModel:GetRejectCount(uid)
  if self._rejectMap and self._rejectMap[uid] then
    return self._rejectMap[uid].count
  end
  return 0
end

function PvpPasswordModel:SetPvpType(pvpType)
  if pvpType == PvpDefine.PvpType.Draft then
    SocialStateUtils.SetPlayerState(SocialDefine.OnlineState.PVPPwdDraft)
  elseif pvpType == PvpDefine.PvpType.PreBuilt then
    SocialStateUtils.SetPlayerState(SocialDefine.OnlineState.PVPPwdPrebuilt)
  end
end

function PvpPasswordModel:GetPvpType()
  return self._pvpRoomData and self._pvpRoomData.pvpType
end

function PvpPasswordModel:GetRoomLeftTime()
  if not self._pvpRoomData or not self._pvpRoomData.endTime then
    return 0
  end
  local endTime = self._pvpRoomData.endTime
  do return math.max, 0 end
  return math.max, 0, endTime - TimeUtils.GetServerTime()
end

function PvpPasswordModel:IsRoomClosed()
  if not self._pvpRoomData then
    return true
  end
  local status = self._pvpRoomData.status
  if status == PvpDefine.RoomStatus.Close or status == PvpDefine.RoomStatus.Disband then
    return true
  end
end

function PvpPasswordModel:IsOwner()
  if self._pvpRoomData then
    return self._pvpRoomData.creator == PlayerDataUtils.GetPlayerUid()
  end
end

function PvpPasswordModel:GetSelfPlayerData()
  if self:IsRoomClosed() then
    return
  end
  local playerList = self._pvpRoomData.playerList or {}
  local selfUid = PlayerDataUtils.GetPlayerUid()
  for i, playerData in ipairs(playerList) do
    if playerData.uid == selfUid then
      return playerData
    end
  end
end

function PvpPasswordModel:GetSelfStatus()
  local selfPlayerData = self:GetSelfPlayerData()
  return selfPlayerData and selfPlayerData.status
end

function PvpPasswordModel:GetSitDownPlayer()
  if self._pvpRoomData then
    local playerList = self._pvpRoomData.playerList or {}
    local SitDownIndex = 2
    return playerList[SitDownIndex]
  end
end

function PvpPasswordModel:IsSelfReady()
  if self._pvpRoomData then
    local playerList = self._pvpRoomData.playerList or {}
    local selfUid = PlayerDataUtils.GetPlayerUid()
    for i, v in ipairs(playerList) do
      if v.uid == selfUid then
        return v.status == PvpDefine.RoomPlayerStatus.Ready
      end
    end
  end
end

function PvpPasswordModel:IsSelfInQueue()
  if self._pvpRoomData then
    local playerList = self._pvpRoomData.playerList or {}
    local selfUid = PlayerDataUtils.GetPlayerUid()
    for i, v in ipairs(playerList) do
      if v.uid == selfUid then
        return v.status == PvpDefine.RoomStatus.Waiting
      end
    end
  end
end

function PvpPasswordModel:IsInRoom()
  if self._pvpRoomData then
    local playerList = self._pvpRoomData.playerList or {}
    local selfUid = PlayerDataUtils.GetPlayerUid()
    for i, v in ipairs(playerList) do
      if v.uid == selfUid then
        return true
      end
    end
  end
end

function PvpPasswordModel:GetRoomStatusName(status)
  if status == PvpDefine.RoomStatus.Close then
    return "Close"
  elseif status == PvpDefine.RoomStatus.Matched then
    return "Matched"
  elseif status == PvpDefine.RoomStatus.Disband then
    return "Disband"
  elseif status == PvpDefine.RoomStatus.Created then
    return "Created"
  elseif status == PvpDefine.RoomStatus.Waiting then
    return "Waiting"
  end
  return "None"
end

return PvpPasswordModel
