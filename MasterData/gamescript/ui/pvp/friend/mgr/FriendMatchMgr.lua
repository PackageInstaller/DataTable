local FriendMatchData = DataCenter.friendMatchData
local FriendMatchMgr, Super = System.NewClass("FriendMatchMgr", Manager, IUpdater)

function FriendMatchMgr:ResetAll()
  FriendMatchData.myInviteData = nil
  FriendMatchData.inviteList = {}
  self.friendDataMap = {}
  self.reqCanceledFriendUid = nil
end

function FriendMatchMgr:Awake()
  Super.Awake(self)
end

function FriendMatchMgr:Update()
  self:DeleteTimeoutInvite()
end

function FriendMatchMgr:DeleteTimeoutInvite()
  local curTime = TimeUtils.GetServerTime()
  local inviteList = self:GetInviteList()
  local timeout = DT.GetConstant("FriendlyMatchInvitationCountdown", 60)
  local total = #inviteList
  for i = total, 1, -1 do
    local inviteData = inviteList[i]
    if curTime > inviteData.ts + timeout then
      table.remove(inviteList, i)
      self:CancelFriendGame(inviteData.friendRelateUid)
    end
  end
  if FriendMatchData.myInviteData and curTime > FriendMatchData.myInviteData.ts + timeout then
    FriendMatchData.myInviteData = nil
  end
end

function FriendMatchMgr:IsCanFriendGame(facade)
  if facade.relation ~= SocialDefine.SocialRelationType.Cor then
    return false, 100007
  end
  local _, isUnlock = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.PVP, 0)
  if not isUnlock then
    return false, 100005
  end
  if not self:IsFriendPVPOpened(facade) then
    return false
  end
  return true
end

function FriendMatchMgr:IsFriendPVPOpened(facade)
  if not facade or not facade.achieve then
    return
  end
  local achievement = facade.achieve.achievement or {}
  return 1 == achievement.PVPFuncOpen
end

function FriendMatchMgr:LaunchFriendGame(facade)
  local isOk, tips = self:IsCanFriendGame(facade)
  if not isOk and tips then
    Alert.Show(tips)
    return
  end
  PvpController.Instance:OpenPvpFriendSelectGameModeView(facade.uid)
end

function FriendMatchMgr:CancelMyInvite()
  if not FriendMatchData.myInviteData then
    return
  end
  self:CancelFriendGame(FriendMatchData.myInviteData.friendRelateUid)
  FriendMatchData.myInviteData = nil
end

function FriendMatchMgr:CancelFriendGame(uid, callback)
  self.reqCanceledFriendUid = uid
  ProtoManager.Instance:ReqServer("PvpRequest", "CancelInviteFriendGame", function(data, err)
    self.reqCanceledFriendUid = nil
    if callback then
      callback(data, err)
    end
  end, function()
  end, uid)
end

function FriendMatchMgr:AcceptInvite(friendUid, callback)
  ProtoManager.Instance:ReqServer("PvpRequest", "HandleInviteFriendGame", function(data, err)
    if callback then
      callback(data, err)
    end
  end, function()
  end, friendUid, true)
end

function FriendMatchMgr:RefuseInvite(friendUid, callback)
  self.reqCanceledFriendUid = friendUid
  ProtoManager.Instance:ReqServer("PvpRequest", "HandleInviteFriendGame", function(data, err)
    self.reqCanceledFriendUid = nil
    if callback then
      callback(data, err)
    end
  end, function()
  end, friendUid, false)
end

function FriendMatchMgr:IsSelfLaunched(data)
  return data.invitePlayer == PlayerDataUtils.GetPlayerUid()
end

function FriendMatchMgr:SyncFriendGameData(data)
  if data.friendGameStatus == cd.FriendMatchStatus.Inviting then
    self:OnNewInvite(data)
  elseif data.friendGameStatus == cd.FriendMatchStatus.Close then
    self:OnCancelInvite(data)
  elseif data.friendGameStatus == cd.FriendMatchStatus.ChooseTeam then
    self:OnFomationInvite(data)
  elseif data.friendGameStatus == cd.FriendMatchStatus.Finish then
    self:OnFinishInvite(data)
  end
end

function FriendMatchMgr:GetInviteList()
  return FriendMatchData.inviteList
end

function FriendMatchMgr:GetAvailInviteCount()
  local inviteList = self:GetInviteList()
  local count = 0
  for _, data in ipairs(inviteList) do
    if data.friendGameStatus == cd.FriendMatchStatus.Inviting then
      count = count + 1
    end
  end
  return count
end

function FriendMatchMgr:GetFriendData(uid, callback)
  local friendData = self.friendDataMap[uid]
  if friendData then
    return friendData
  end
  self:QueryFriendData(uid, callback)
end

function FriendMatchMgr:RemoveInValidInvite()
  local inviteList = self:GetInviteList()
  local total = #inviteList
  for i = total, 1, -1 do
    local data = inviteList[i]
    if data.friendGameStatus ~= cd.FriendMatchStatus.Inviting then
      table.remove(inviteList, i)
    end
  end
end

function FriendMatchMgr:OnNewInvite(friendData)
  if self:IsSelfLaunched(friendData) then
    FriendMatchData.myInviteData = friendData
    self:QueryFriendData(friendData.friendRelateUid, function(data)
      UIManager.Instance:Reopen(Urls.FriendMatchWaitPanel, friendData, data.name)
    end)
  else
    table.insert(FriendMatchData.inviteList, 1, friendData)
    EventMgr.Instance.FriendMatchNew:Dispatch(friendData)
    self:OpenInvitePopBubble()
  end
end

function FriendMatchMgr:OpenInvitePopBubble()
  if SceneMgr.Instance:IsLoginScene() then
    return
  end
  if UIManager.Instance:GetWindow(Urls.FriendMatchListPanel) then
    return
  end
  if UIManager.Instance:GetWindow(Urls.FriendMatchPopTipPanel) then
    return
  end
  if UIManager.Instance:GetWindow(Urls.PvPFriendGameTeamPanel) then
    return
  end
  if UIManager.Instance:GetWindow(Urls.PvpDraftView) then
    return
  end
  if UIManager.Instance:GetWindow(Urls.PvpDraftAdjustTeamView) then
    return
  end
  if not SceneMgr.Instance:IsInTown() then
    return
  end
  local availCount = FriendMatchMgr.Instance:GetAvailInviteCount()
  if availCount <= 0 then
    return
  end
  UIManager.Instance:Reopen(Urls.FriendMatchPopTipPanel)
end

function FriendMatchMgr:OpenMatchListPanel()
  self:RemoveInValidInvite()
  local inviteList = self:GetInviteList()
  local leftCount = #inviteList
  
  local function callback()
    leftCount = leftCount - 1
    if leftCount <= 0 then
      UIManager.Instance:CloseByUrl(Urls.FriendMatchPopTipPanel)
      UIManager.Instance:Reopen(Urls.FriendMatchListPanel)
    end
  end
  
  for _, info in ipairs(inviteList) do
    self:QueryFriendData(info.friendRelateUid, callback)
  end
end

function FriendMatchMgr:QueryFriendData(uid, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "QueryFacadeDetail", function(data)
    self.friendDataMap[uid] = data
    if callback then
      callback(data)
    end
  end, function()
    if callback then
      callback(nil)
    end
  end, uid)
end

function FriendMatchMgr:OnCancelInvite(data)
  local inviteList = self:GetInviteList()
  for index, friendData in ipairs(inviteList) do
    if data.friendRelateUid == friendData.friendRelateUid then
      if friendData.friendRelateUid == cd.FriendMatchStatus.Timeout then
        return
      end
      friendData.friendGameStatus = data.friendGameStatus
      table.remove(inviteList, 1)
      break
    end
  end
  EventMgr.Instance.FriendMatchCancel:Dispatch(data.friendRelateUid, data.reason)
  if FriendMatchData.myInviteData and FriendMatchData.myInviteData.friendRelateUid == data.friendRelateUid then
    UIManager.Instance:CloseByUrl(Urls.FriendMatchWaitPanel)
    FriendMatchData.myInviteData = nil
  end
end

function FriendMatchMgr:ShowInviteCloseTips(reason)
  if "OnDisconnect" == reason then
    Alert.Show(100013)
  elseif "HandleRoleStatusChange" == reason then
    Alert.Show(100014)
  elseif "reject" == reason then
    Alert.Show(100012)
  elseif "CancelFriendGame" == reason then
    Alert.Show(100016)
  elseif "AcceptOne" == reason then
    Alert.Show(100017)
  else
    Alert.Show(100012)
  end
end

function FriendMatchMgr:OnFomationInvite(data)
  local inviteList = self:GetInviteList()
  for index, friendData in ipairs(inviteList) do
    if data.friendRelateUid == friendData.friendRelateUid then
      friendData.friendGameStatus = data.friendGameStatus
      table.remove(inviteList, 1)
      break
    end
  end
  EventMgr.Instance.FriendMatchFormation:Dispatch(data.friendRelateUid)
  UIManager.Instance:CloseByUrl(Urls.FriendMatchWaitPanel)
  UIManager.Instance:CloseByUrl(Urls.FriendMatchListPanel)
  UIManager.Instance:CloseByUrl(Urls.FriendMatchPopTipPanel)
  PvPTeamBuildDataUtils.ReqOnOpenTeam(function()
    UIManager.Instance:Reopen(Urls.PvPFriendGameTeamPanel, data.friendRelateUid)
  end)
end

function FriendMatchMgr:OnFinishInvite(data)
  local inviteList = self:GetInviteList()
  for index, friendData in ipairs(inviteList) do
    if data.friendRelateUid == friendData.friendRelateUid then
      friendData.friendGameStatus = data.friendGameStatus
      table.remove(inviteList, 1)
      EventMgr.Instance.FriendMatchFinish:Dispatch(data.friendRelateUid)
      break
    end
  end
end

return FriendMatchMgr
