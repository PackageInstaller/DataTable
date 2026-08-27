local FriendNetworkCtrl = class("FriendNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local cs_MessageCommon = CS.MessageCommon

function FriendNetworkCtrl:ctor()
  self.applyFriendMsg = {}
  self.uidMsg = {}
  self.uidAndAliasMsg = {}
  self.reportMsg = {}
  self.recommendMsg = {}
end

function FriendNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FRIEND_Push, self, proto_csmsg.SC_FRIEND_Push, self.SC_FRIEND_Push)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FRIEND_ApplyFriend, self, proto_csmsg.SC_FRIEND_ApplyFriend, self.SC_FRIEND_ApplyFriend)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FRIEND_IgnoreApply, self, proto_csmsg.SC_FRIEND_IgnoreApply, self.SC_FRIEND_IgnoreApply)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FRIEND_AgreeApply, self, proto_csmsg.SC_FRIEND_AgreeApply, self.SC_FRIEND_AgreeApply)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FRIEND_DissolveFriend, self, proto_csmsg.SC_FRIEND_DissolveFriend, self.SC_FRIEND_DissolveFriend)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FRIEND_NotifyNewApply, self, proto_csmsg.SC_FRIEND_NotifyNewApply, self.SC_FRIEND_NotifyNewApply)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FRIEND_RefreshFriend, self, proto_csmsg.SC_FRIEND_RefreshFriend, self.SC_FRIEND_RefreshFriend)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FRIEND_Alias, self, proto_csmsg.SC_FRIEND_Alias, self.SC_FRIEND_Alias)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Black_Add, self, proto_csmsg.SC_Black_Add, self.SC_Black_Add)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Black_Add_NTF, self, proto_csmsg.SC_Black_Add_NTF, self.SC_Black_Add_NTF)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Black_Delete, self, proto_csmsg.SC_Black_Delete, self.SC_Black_Delete)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Report, self, proto_csmsg.SC_Report, self.SC_Report)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FRIEND_Recommend, self, proto_csmsg.SC_FRIEND_Recommend, self.SC_FRIEND_Recommend)
end

function FriendNetworkCtrl:SC_FRIEND_Push(msg)
  PlayerDataCenter.friendDataCenter:OnReceiveFriendInitData(msg)
end

function FriendNetworkCtrl:HandleFriendDiffer(diffMsg)
  if diffMsg.friendUpdate ~= nil then
    PlayerDataCenter.friendDataCenter:UpadteFrendList(diffMsg.friendUpdate)
  end
  if diffMsg.blackUpdate ~= nil then
    PlayerDataCenter.friendDataCenter:UpdateFriendBlackList(diffMsg.blackUpdate)
  end
  if diffMsg.friendDelete ~= nil then
    PlayerDataCenter.friendDataCenter:UpadteFrendList(diffMsg.friendDelete, true)
  end
  if diffMsg.blackDelete ~= nil then
    PlayerDataCenter.friendDataCenter:UpdateFriendBlackList(diffMsg.blackDelete, true)
  end
  if diffMsg.applyFromMeAdd ~= nil then
    PlayerDataCenter.friendDataCenter:UpdateFriendApplyFromMeAdd(diffMsg.applyFromMeAdd)
  end
  if diffMsg.applyFromMeDelete ~= nil then
    PlayerDataCenter.friendDataCenter:UpdateFriendApplyFromMeDelete(diffMsg.applyFromMeDelete)
  end
end

function FriendNetworkCtrl:CS_FRIEND_ApplyFriend(uid, way, callback)
  self.applyFriendMsg.uid = uid
  self.applyFriendMsg.way = way or 0
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FRIEND_ApplyFriend, proto_csmsg.CS_FRIEND_ApplyFriend, self.applyFriendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_ApplyFriend, callback, proto_csmsg_MSG_ID.MSG_SC_FRIEND_ApplyFriend)
end

function FriendNetworkCtrl:SC_FRIEND_ApplyFriend(msg)
  if msg.ret == proto_csmsg_ErrorCode.ERROR_FRIEND_IN_BLACK then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Friend_FriendInBlackList))
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_ApplyFriend)
  elseif msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_FRIEND_ApplyFriend error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_ApplyFriend)
  else
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

function FriendNetworkCtrl:CS_FRIEND_IgnoreApply(uid, callback)
  self.uidMsg.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FRIEND_IgnoreApply, proto_csmsg.CS_FRIEND_IgnoreApply, self.uidMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_IgnoreApply, callback, proto_csmsg_MSG_ID.MSG_SC_FRIEND_IgnoreApply)
end

function FriendNetworkCtrl:SC_FRIEND_IgnoreApply(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_FRIEND_IgnoreApply error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_IgnoreApply)
  else
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

function FriendNetworkCtrl:CS_FRIEND_AgreeApply(uid, callback)
  self.uidMsg.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FRIEND_AgreeApply, proto_csmsg.CS_FRIEND_AgreeApply, self.uidMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_AgreeApply, callback, proto_csmsg_MSG_ID.MSG_SC_FRIEND_AgreeApply)
end

function FriendNetworkCtrl:SC_FRIEND_AgreeApply(msg)
  if msg.ret == proto_csmsg_ErrorCode.ERROR_FRIEND_RECEIVE_FRIEND then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Friend_AddFailure))
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_FRIEND_AgreeApply, false)
  elseif msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_FRIEND_AgreeApply error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_AgreeApply)
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_FRIEND_AgreeApply, true)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  PlayerDataCenter.friendDataCenter:BroadCastFriendListChange()
end

function FriendNetworkCtrl:CS_FRIEND_DissolveFriend(uid, callback)
  self.uidMsg.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FRIEND_DissolveFriend, proto_csmsg.CS_FRIEND_DissolveFriend, self.uidMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_DissolveFriend, callback, proto_csmsg_MSG_ID.MSG_SC_FRIEND_DissolveFriend)
end

function FriendNetworkCtrl:SC_FRIEND_DissolveFriend(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_FRIEND_DissolveFriend error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_AgreeApply)
  else
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    PlayerDataCenter.friendDataCenter:BroadCastFriendListChange()
  end
end

function FriendNetworkCtrl:SC_FRIEND_NotifyNewApply(msg)
  PlayerDataCenter.friendDataCenter:OnGetNewApplyNotice(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FriendNetworkCtrl:CS_FRIEND_RefreshFriend(callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FRIEND_RefreshFriend, proto_csmsg.CS_FRIEND_RefreshFriend, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_RefreshFriend, callback, proto_csmsg_MSG_ID.MSG_SC_FRIEND_RefreshFriend)
end

function FriendNetworkCtrl:SC_FRIEND_RefreshFriend(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_FRIEND_RefreshFriend error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_RefreshFriend)
  else
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    PlayerDataCenter.friendDataCenter:UpdateHeroListData(msg.friend)
  end
end

function FriendNetworkCtrl:CS_FRIEND_Alias(uid, alias, callback)
  self.uidAndAliasMsg.uid = uid
  self.uidAndAliasMsg.alias = alias
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FRIEND_Alias, proto_csmsg.CS_FRIEND_Alias, self.uidAndAliasMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_Alias, callback, proto_csmsg_MSG_ID.MSG_SC_FRIEND_Alias)
end

function FriendNetworkCtrl:SC_FRIEND_Alias(msg)
  if msg.ret == proto_csmsg_ErrorCode.INVALID_CHARACTER_INPUT then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.name_Illegal))
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_Alias)
  elseif msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_FRIEND_Alias error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_Alias)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FriendNetworkCtrl:CS_Black_Add(uid, callback)
  self.uidMsg.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Black_Add, proto_csmsg.CS_Black_Add, self.uidMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Black_Add, callback, proto_csmsg_MSG_ID.MSG_CS_Black_Add)
end

function FriendNetworkCtrl:SC_Black_Add(msg)
  if msg.ret == proto_csmsg_ErrorCode.ERROR_FRIEND_BLACK_LIMIT then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Friend_BlacklistLimit))
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Black_Add)
  else
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Black_Add)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  PlayerDataCenter.friendDataCenter:BroadCastFriendListChange()
end

function FriendNetworkCtrl:SC_Black_Add_NTF(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FriendNetworkCtrl:CS_Black_Delete(uid, callback)
  self.uidMsg.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Black_Delete, proto_csmsg.CS_Black_Delete, self.uidMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Black_Delete, callback, proto_csmsg_MSG_ID.MSG_CS_Black_Add)
end

function FriendNetworkCtrl:SC_Black_Delete(msg)
  if msg.ret == proto_csmsg_ErrorCode.ERROR_FRIEND_NOT_BLACK then
    local err = "SC_Black_Delete error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Black_Delete)
  else
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Black_Delete)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  PlayerDataCenter.friendDataCenter:BroadCastFriendListChange()
end

function FriendNetworkCtrl:CS_Report(uid, reasonId, text, callback)
  self.reportMsg.uid = uid
  self.reportMsg.reasonId = reasonId
  self.reportMsg.text = text
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Report, proto_csmsg.CS_Report, self.reportMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Report, callback, proto_csmsg_MSG_ID.MSG_CS_Report)
end

function FriendNetworkCtrl:SC_Report(msg)
  local reportWin = UIManager:GetWindow(UIWindowTypeID.Report)
  if msg.ret == proto_csmsg_ErrorCode.INVALID_CHARACTER_INPUT then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Report_ReasonHasShieldWord))
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Report)
    if reportWin ~= nil then
      reportWin:OnReportInvalidInput()
    end
  elseif msg.ret == proto_csmsg_ErrorCode.ERROR_FRIEND_REPORT_ID_ERR then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Report)
  elseif msg.ret == proto_csmsg_ErrorCode.ERROR_FRIEND_REPORT_TIME_MAX then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Report_LimitTimes))
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Report)
  else
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Report_Success))
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Report)
    if reportWin ~= nil then
      UIManager:DeleteWindow(UIWindowTypeID.Report)
    end
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FriendNetworkCtrl:CS_FRIEND_Recommend(uids, callback)
  self.recommendMsg.lastUids = uids
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FRIEND_Recommend, proto_csmsg.CS_FRIEND_Recommend, self.recommendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_Recommend, callback, proto_csmsg_MSG_ID.MSG_SC_FRIEND_Recommend)
end

function FriendNetworkCtrl:SC_FRIEND_Recommend(msg)
  if msg.ret == proto_csmsg_ErrorCode.ERROR_FRIEND_SIZE_LIMIT then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(6024))
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_Recommend)
  elseif msg.ret == proto_csmsg_ErrorCode.FRIEND_RECOMMEND_REFRESH_CD then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(9714))
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_Recommend)
  elseif msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_FRIEND_Recommend error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_Recommend)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  PlayerDataCenter.friendDataCenter:OnReceiveRecommendFriendData(msg)
end

function FriendNetworkCtrl:Reset()
end

return FriendNetworkCtrl
