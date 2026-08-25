local PvpPasswordController = NewClass("PvpPasswordController", BaseController)

function PvpPasswordController:OnInit()
end

function PvpPasswordController:OnReset()
  self._isServerTimeInited = false
  PvpPasswordModel.Instance:SetRoomData(nil)
end

function PvpPasswordController:SetLoginPasswordInfo(roomData)
  if not self:CheckLoginRoomValid(roomData) then
    return
  end
  self._loginRoomData = roomData
end

function PvpPasswordController:CheckLoginRoomValid(roomData)
  if not roomData then
    return false
  end
  if roomData.errCode then
    return false
  end
  if roomData.status == PvpDefine.RoomStatus.Close or roomData.status == PvpDefine.RoomStatus.Disband then
    return false
  end
  local playerUid = PlayerDataUtils.GetPlayerUid()
  print("---------------获取 playerUid", playerUid or "nil")
  local playerList = roomData.playerList or {}
  local isFindSelf = false
  for _, player in ipairs(playerList) do
    if player.uid == playerUid then
      isFindSelf = true
      break
    end
  end
  if not isFindSelf then
    return false
  end
  return true
end

function PvpPasswordController:CheckRecoverRoomOnTown()
  if self._loginRoomData then
    self:RecoverRoom()
    self._loginRoomData = nil
  end
end

function PvpPasswordController:RecoverRoom()
  self:OnSyncPasswordData(self._loginRoomData)
end

function PvpPasswordController:OnSyncPasswordData(roomData)
  Logger.Proto("OnSyncPasswordData status", PvpPasswordModel.Instance:GetRoomStatusName(roomData.status))
  if roomData.errCode then
    self:DealErrCode(roomData.errCode)
  end
  local preRoomData = PvpPasswordModel.Instance:GetRoomData() or {}
  PvpPasswordModel.Instance:SetRoomData(roomData)
  EventMgr.Instance.PvpRoomSyncData:Dispatch(roomData)
  if PvpPasswordModel.Instance:GetRoomLeftTime() <= 0 then
    self:OnRoomClose()
    self:ReqCancelMatching()
    return
  end
  if self._loginRoomData then
    UIManager.Instance:Reopen(Urls.MainPanelPVP)
  end
  local status = roomData.status
  if status == PvpDefine.RoomStatus.Created then
    self:OnCreateRoom(true)
  elseif status == PvpDefine.RoomStatus.Close then
    self:OnRoomClose()
  elseif status == PvpDefine.RoomStatus.Disband then
    self:OnRoomClose()
  elseif status == PvpDefine.RoomStatus.Matched then
    self:OnRoomMatched()
  end
  self:CheckPlayerReady()
end

function PvpPasswordController:DealErrCode(errCode)
  if DT.TipsType[errCode] then
    Alert.Show(errCode)
    return
  end
  if DT.LanguageConfig[errCode] then
    Alert.ShowStr(LT.Text(errCode))
    return
  end
  ErrorMsg.ShowErrCodeTips({code = errCode})
end

function PvpPasswordController:ReqCreatePVPRoom(pvpType)
  local playerUid = PlayerDataUtils.GetPlayerUid()
  if not playerUid or 0 == playerUid then
    self:OnCreateRoom(false)
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "StartPasswordGame", function(password, errcode)
    local miniPassword = 100000
    if not tonumber(password) or miniPassword > tonumber(password) then
      self:OnCreateRoom(false)
      return
    end
    if errcode and (errcode.code or cd.NumberTrue) ~= cd.NumberTrue then
      self:OnCreateRoom(false)
      return
    end
  end, function()
    self:OnCreateRoom(false)
  end, playerUid, pvpType)
end

function PvpPasswordController:OnCreateRoom(isSuccess)
  EventMgr.Instance.PvpRoomCreate:Dispatch(isSuccess)
  if isSuccess then
    UIManager.Instance:CloseByUrl(Urls.PvpPasswordCreateView)
    UIManager.Instance:Reopen(Urls.PvpPasswordWaitingView)
  end
end

function PvpPasswordController:ReqJoinRoom(password, callback)
  local playerUid = PlayerDataUtils.GetPlayerUid()
  ProtoManager.Instance:ReqServer("GameRequest", "JoinPasswordGame", function(data1, data2)
    if callback then
      callback()
    end
  end, function()
  end, playerUid, password)
end

function PvpPasswordController:ReqCancelMatching()
  if PvpPasswordModel.Instance:IsRoomClosed() then
    Logger.Warn("PvpPasswordController:ReqCancelMatching room is already closed")
    return
  end
  if not PvpPasswordModel.Instance:IsInRoom() then
    Logger.Warn("PvpPasswordController:ReqCancelMatching not in room")
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "CancelPasswordMatching", function(data, errcode)
    Logger.Proto("CancelPasswordMatching", table.tostring(data))
    self:OnRoomClose()
  end, function(data)
    Logger.Proto("CancelPasswordMatching failed", table.tostring(data))
    self:OnRoomClose()
  end)
end

function PvpPasswordController:OnMathedPlayer()
end

function PvpPasswordController:RejectPasswordGame(uid)
  ProtoManager.Instance:ReqServer("GameRequest", "RejectPasswordGame", function(data, errcode)
    local rejectCount = PvpPasswordModel.Instance:GetRejectCount(uid)
    local isBanned = SocialDataUtils.IsBanned(uid)
    if rejectCount >= 3 and not isBanned then
      Alert.Show("PVP_PasswordBattle_BlockTips", nil, function()
        SocialDataUtils.Ban(uid, function(data)
        end)
      end)
    end
  end, function()
  end, uid)
end

function PvpPasswordController:ReadyPasswordGame()
  local playerUid = PlayerDataUtils.GetPlayerUid()
  ProtoManager.Instance:ReqServer("GameRequest", "ReadyPasswordGame", function(data, errcode)
    Logger.Proto("ReadyPasswordGame", table.tostring(data), table.tostring(errcode))
  end, function()
  end, playerUid)
end

function PvpPasswordController:OnRoomClose()
  UIManager.Instance:CloseByUrl(Urls.PvpPasswordWaitingView)
  UIManager.Instance:CloseByUrl(Urls.PvpPasswordRoleListView)
  EventMgr.Instance.PvpRoomClose:Dispatch()
  PvpPasswordModel.Instance:OnReset()
  if SceneMgr.Instance:IsInTown() and not UIManager.Instance:GetWindow(Urls.MainPanel) then
    UIManager.Instance:Reopen(Urls.MainPanel)
  end
end

function PvpPasswordController:OnRoomMatched()
  local roomData = PvpPasswordModel.Instance:GetRoomData()
  local playerList = roomData.playerList or {}
  if not table.next(playerList) then
    UIManager.Instance:CloseByUrl(Urls.PvpPasswordRoleListView)
    if roomData.creator == PlayerDataUtils.GetPlayerUid() then
      UIManager.Instance:Reopen(Urls.PvpPasswordWaitingView)
    end
  else
    self:ShowRoleListView()
  end
end

function PvpPasswordController:CheckPlayerReady()
  local pvpRoomData = PvpPasswordModel.Instance:GetRoomData()
  if not pvpRoomData then
    return
  end
  local playerList = pvpRoomData.playerList or {}
  local selfUid = PlayerDataUtils.GetPlayerUid()
  local friendUid
  local readyPlayerNum = 0
  for _, player in ipairs(playerList) do
    if player.status == PvpDefine.RoomPlayerStatus.Ready or player.status == PvpDefine.RoomPlayerStatus.SelectedTeam then
      readyPlayerNum = readyPlayerNum + 1
    end
    if player.uid ~= selfUid then
      friendUid = player.uid
    end
  end
  if readyPlayerNum < PvpDefine.RoomFightPlayerCount then
    UIManager.Instance:CloseByUrl(Urls.PvPPasswordTeamPanel)
    return
  end
  UIManager.Instance:CloseByUrl(Urls.PvpPasswordRoleListView)
  local teamDataGroup = DataCenter.pvpTeamBuildData.teamDataGroup
  if not table.next(teamDataGroup) then
    PvPTeamBuildDataUtils.ReqOnOpenTeam(function()
      UIManager.Instance:Reopen(Urls.PvPPasswordTeamPanel, friendUid)
    end)
  else
    UIManager.Instance:Reopen(Urls.PvPPasswordTeamPanel, friendUid)
  end
end

function PvpPasswordController:ShowRoleListView()
  local pvpRoomData = PvpPasswordModel.Instance:GetRoomData()
  local playerList = pvpRoomData.playerList or {}
  local ownerUid = pvpRoomData.creator
  local selfUid = PlayerDataUtils.GetPlayerUid()
  local isOwner = ownerUid == PlayerDataUtils.GetPlayerUid()
  if not PvpPasswordModel.Instance:IsInRoom() then
    UIManager.Instance:CloseByUrl(Urls.PvpPasswordRoleListView)
    return
  end
  local sitDownPlayer = PvpPasswordModel.Instance:GetSitDownPlayer()
  if not sitDownPlayer then
    UIManager.Instance:CloseByUrl(Urls.PvpPasswordRoleListView)
    return
  end
  local otherPlayerUid = isOwner and sitDownPlayer.uid or ownerUid
  SocialDataUtils.ReqQueryAwakerList(otherPlayerUid, function(facadeData)
    UIManager.Instance:CloseByUrl(Urls.PvpPasswordWaitingView)
    if UIManager.Instance:GetWindow(Urls.PvPPasswordTeamPanel) then
      return
    end
    if UIManager.Instance:GetWindow(Urls.PvpPasswordRoleListView) then
      EventMgr.Instance.PvpRoomRoleSync:Dispatch(isOwner, otherPlayerUid, facadeData)
      return
    end
    UIManager.Instance:Reopen(Urls.PvpPasswordRoleListView, isOwner, otherPlayerUid, facadeData)
  end)
end

return PvpPasswordController
