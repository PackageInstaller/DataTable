local DormFightNetworkCtrl = class("DormFightNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local CS_pvpFightManager_ins = CS.PvpFightManager.Instance
local cs_P3_PvpFight = CS.P3.PvpFight
local cs_MessageCommon = CS.MessageCommon
local cs_array = CS.System.Array
local cs_byte = CS.System.Byte

function DormFightNetworkCtrl:ctor()
end

function DormFightNetworkCtrl:GetDormFightCtrl()
  if self._dormFightCtrl == nil then
    self._dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight, true)
  end
  return self._dormFightCtrl
end

function DormFightNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FIGHT_DuelInvitation, self, proto_csmsg.SC_FIGHT_DuelInvitation, self.SC_FIGHT_DuelInvitation)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FIGHT_DuelInviationNtf, self, proto_csmsg.SC_FIGHT_DuelInviationNtf, self.SC_FIGHT_DuelInviationNtf)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FIGHT_DuelAccept, self, proto_csmsg.SC_FIGHT_DuelAccept, self.SC_FIGHT_DuelAccept)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FIGHT_DuelAcceptNtf, self, proto_csmsg.SC_FIGHT_DuelAcceptNtf, self.SC_FIGHT_DuelAcceptNtf)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FIGHT_DuelCancel, self, proto_csmsg.SC_FIGHT_DuelCancel, self.SC_FIGHT_DuelCancel)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FIGHT_DuelCancelNtf, self, proto_csmsg.SC_FIGHT_DuelCancelNtf, self.SC_FIGHT_DuelCancelNtf)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FIGHT_DuelDecline, self, proto_csmsg.SC_FIGHT_DuelDecline, self.SC_FIGHT_DuelDecline)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FIGHT_DuelDeclineNtf, self, proto_csmsg.SC_FIGHT_DuelDeclineNtf, self.SC_FIGHT_DuelDeclineNtf)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FIGHT_EnterPickStateNtf, self, proto_csmsg.SC_FIGHT_EnterPickStateNtf, self.SC_FIGHT_EnterPickStateNtf)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FIGHT_PickHero, self, proto_csmsg.SC_FIGHT_PickHero, self.SC_FIGHT_PickHero)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FIGHT_PickHeroNtf, self, proto_csmsg.SC_FIGHT_PickHeroNtf, self.SC_FIGHT_PickHeroNtf)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FIGHT_SyncDiff, self, proto_csmsg.SC_FIGHT_SyncDiff, self.SC_FIGHT_SyncDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FIGHT_OverNtf, self, proto_csmsg.SC_FIGHT_OverNtf, self.SC_FIGHT_OverNtf)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_UserOfflineNtf, self, proto_csmsg.SC_UserOfflineNtf, self.SC_UserOfflineNtf)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FIGHT_CreateRoomNtf, self, proto_csmsg.SC_FIGHT_CreateRoomNtf, self.SC_FIGHT_CreateRoomNtf)
end

function DormFightNetworkCtrl:CS_FIGHT_DuelInvitation(defenderUserId, roomType, callback)
  if self.duelInvitationMsg == nil then
    self.duelInvitationMsg = {}
  end
  self.duelInvitationMsg.defender = defenderUserId
  self.duelInvitationMsg.roomType = roomType
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FIGHT_DuelInvitation, proto_csmsg.CS_FIGHT_DuelInvitation, self.duelInvitationMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FIGHT_DuelInvitation, callback, proto_csmsg_MSG_ID.MSG_SC_FIGHT_DuelInvitation)
end

function DormFightNetworkCtrl:SC_FIGHT_DuelInvitation(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FIGHT_DuelInvitation)
    if msg.ret == proto_csmsg_ErrorCode.FIGHT_INVITATION_DUP then
      local err = ConfigData:GetTipContent(9301)
      cs_MessageCommon.ShowMessageTips(err)
      return
    end
    if msg.ret == proto_csmsg_ErrorCode.FIGHT_FRIEND_TRUN_OFF_INVITATION then
      local err = ConfigData:GetTipContent(9302)
      cs_MessageCommon.ShowMessageTips(err)
      return
    end
    if msg.ret == proto_csmsg_ErrorCode.FIGHT_ATTACKER_IN_PROGRESS then
      local err = ConfigData:GetTipContent(10731)
      cs_MessageCommon.ShowMessageTips(err)
      return
    end
    if msg.ret == proto_csmsg_ErrorCode.FIGHT_DEFENDER_IN_PROGRESS then
      local err = ConfigData:GetTipContent(10732)
      cs_MessageCommon.ShowMessageTips(err)
      return
    end
    if msg.ret == proto_csmsg_ErrorCode.FIGHT_DEFENDER_IN_PROGRESS then
      local err = ConfigData:GetTipContent(7804)
      cs_MessageCommon.ShowMessageTips(err)
      return
    end
    local err = "DormFightNetworkCtrl:SC_FIGHT_DuelInvitation error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  if isGameDev then
    print("邀请成功")
  end
  local dormFightCtrl = self:GetDormFightCtrl()
  if dormFightCtrl ~= nil then
    dormFightCtrl:OnInviteCallback(msg.duelId, msg.expireTm)
  end
end

function DormFightNetworkCtrl:SC_FIGHT_DuelInviationNtf(msg)
  local dormFightCtrl = self:GetDormFightCtrl()
  if dormFightCtrl ~= nil then
    dormFightCtrl:InvitedDormFight(msg)
  end
end

function DormFightNetworkCtrl:CS_FIGHT_DuelAccept(duelId, attacker, roomType, successCallback, failCallback)
  if self.duelAcceptMsg == nil then
    self.duelAcceptMsg = {}
  end
  self.duelAcceptMsg.duelId = duelId
  self.duelAcceptMsg.attacker = attacker
  self.duelAcceptMsg.roomType = roomType
  self.duelAcceptSuccessCallback = successCallback
  self.duelAcceptFailCallback = failCallback
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FIGHT_DuelAccept, proto_csmsg.CS_FIGHT_DuelAccept, self.duelAcceptMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FIGHT_DuelAccept, nil, proto_csmsg_MSG_ID.MSG_SC_FIGHT_DuelAccept)
end

function DormFightNetworkCtrl:SC_FIGHT_DuelAccept(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FIGHT_DuelAccept)
    if msg.ret == proto_csmsg_ErrorCode.FIGHT_DUAL_ACCEPT_NON_FRIEND then
      local err = ConfigData:GetTipContent(9355)
      cs_MessageCommon.ShowMessageTips(err)
    elseif msg.ret == proto_csmsg_ErrorCode.FIGHT_FRIEND_TRUN_OFF_INVITATION then
      local err = ConfigData:GetTipContent(9302)
      cs_MessageCommon.ShowMessageTips(err)
    elseif msg.ret == proto_csmsg_ErrorCode.FIGHT_INVITATION_ACCEPT_TIMEOUT then
      local err = ConfigData:GetTipContent(10725)
      cs_MessageCommon.ShowMessageTips(err)
    else
      local err = "DormFightNetworkCtrl:SC_FIGHT_DuelAccept error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
    end
    if self.duelAcceptFailCallback ~= nil then
      self.duelAcceptFailCallback()
      self.duelAcceptFailCallback = nil
    end
    return nil
  end
  if isGameDev then
    print("同意邀请成功")
  end
  if self.duelAcceptSuccessCallback ~= nil then
    self.duelAcceptSuccessCallback()
    self.duelAcceptSuccessCallback = nil
  end
end

function DormFightNetworkCtrl:SC_FIGHT_DuelAcceptNtf(msg)
  local dormFightCtrl = self:GetDormFightCtrl()
  if dormFightCtrl ~= nil then
    dormFightCtrl:OtherAcceptInvited(msg)
  end
end

function DormFightNetworkCtrl:CS_FIGHT_DuelCancel(duelId, callback)
  if self.duelCancelMsg == nil then
    self.duelCancelMsg = {}
  end
  self.duelCancelMsg.duelId = duelId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FIGHT_DuelCancel, proto_csmsg.CS_FIGHT_DuelCancel, self.duelCancelMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FIGHT_DuelCancel, callback, proto_csmsg_MSG_ID.MSG_SC_FIGHT_DuelCancel)
end

function DormFightNetworkCtrl:SC_FIGHT_DuelCancel(msg)
end

function DormFightNetworkCtrl:SC_FIGHT_DuelCancelNtf(msg)
  local dormFightCtrl = self:GetDormFightCtrl()
  if dormFightCtrl ~= nil then
    dormFightCtrl:OnOtherCancelInvite(msg.duelId)
  end
end

function DormFightNetworkCtrl:CS_FIGHT_DuelDecline(duelId, callback)
  if self.duelDeclineMsg == nil then
    self.duelDeclineMsg = {}
  end
  self.duelDeclineMsg.duelId = duelId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FIGHT_DuelDecline, proto_csmsg.CS_FIGHT_DuelDecline, self.duelDeclineMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FIGHT_DuelDecline, callback, proto_csmsg_MSG_ID.MSG_SC_FIGHT_DuelDecline)
end

function DormFightNetworkCtrl:SC_FIGHT_DuelDecline(msg)
end

function DormFightNetworkCtrl:SC_FIGHT_DuelDeclineNtf(msg)
  local dormFightCtrl = self:GetDormFightCtrl()
  if dormFightCtrl ~= nil then
    dormFightCtrl:UpdateInviteFail(msg.duelId)
  end
end

function DormFightNetworkCtrl:SC_FIGHT_EnterPickStateNtf(msg)
  local dormFightCtrl = self:GetDormFightCtrl()
  if dormFightCtrl ~= nil then
    dormFightCtrl:EnterSelectHeroState(msg)
    if isGameDev then
      print("服务器通知可以选人 SC_FIGHT_EnterPickStateNtf " .. "msg.endTm = " .. tostring(msg.endTm) .. " playerTime = " .. tostring(PlayerDataCenter.timestamp))
    end
  end
end

function DormFightNetworkCtrl:CS_FIGHT_PickHero(heroIds, duelId, roomType, callback)
  if self.pickHeroMsg == nil then
    self.pickHeroMsg = {}
  end
  self.pickHeroMsg.heroIds = heroIds
  self.pickHeroMsg.duelId = duelId
  self.pickHeroMsg.roomType = roomType
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FIGHT_PickHero, proto_csmsg.CS_FIGHT_PickHero, self.pickHeroMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FIGHT_PickHero, callback, proto_csmsg_MSG_ID.MSG_SC_FIGHT_PickHero)
end

function DormFightNetworkCtrl:SC_FIGHT_PickHero(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "DormFightNetworkCtrl:SC_FIGHT_PickHero error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FIGHT_PickHero)
  end
end

function DormFightNetworkCtrl:SC_FIGHT_PickHeroNtf(msg)
  local dormFightCtrl = self:GetDormFightCtrl()
  if dormFightCtrl ~= nil then
    dormFightCtrl:OnOtherSelectEnd(msg)
  end
end

function DormFightNetworkCtrl:CS_FIGHT_FriendInvitationToggle(value, callback)
  if self.friendInvitationToggleMsg == nil then
    self.friendInvitationToggleMsg = {}
  end
  self.friendInvitationToggleMsg.state = value
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FIGHT_FriendInvitationToggle, proto_csmsg.CS_FIGHT_FriendInvitationToggle, self.friendInvitationToggleMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FIGHT_FriendInvitationToggle, callback, proto_csmsg_MSG_ID.MSG_SC_FIGHT_FriendInvitationToggle)
end

function DormFightNetworkCtrl:SC_FIGHT_FriendInvitationToggle(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "DormFightNetworkCtrl:SC_FIGHT_FriendInvitationToggle error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FIGHT_FriendInvitationToggle)
  end
end

function DormFightNetworkCtrl:SC_FIGHT_SyncDiff(msg)
  self:UpdateDormFightRecord(msg.data[1])
end

function DormFightNetworkCtrl:UpdateDormFightRecord(msg)
  PlayerDataCenter.inforData:UpdateDormFight1v1RecordData(msg)
end

function DormFightNetworkCtrl:UpdateWinnerDormFightRecord(userId, data, callback)
  PlayerDataCenter:GetUserInfoByUID(userId, function(userInfoData)
    if userInfoData ~= nil then
      userInfoData:UpdateDormFight1v1RecordData(data)
      if callback ~= nil then
        callback()
      end
    end
  end)
end

function DormFightNetworkCtrl:CS_PVP_Test_CreateRoom(mode)
  if self.createRoomMsg == nil then
    self.createRoomMsg = {}
  end
  self.createRoomMsg.op = mode
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_PVP_Test_CreateRoom, proto_csmsg.CS_PVP_Test_CreateRoom, self.createRoomMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_PVP_Test_CreateRoom, proto_csmsg_MSG_ID.MSG_SC_FIGHT_CreateRoomNtf)
end

function DormFightNetworkCtrl:SC_FIGHT_CreateRoomNtf(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "DormFightNetworkCtrl:SC_FIGHT_CreateRoomNtf error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_PVP_Test_CreateRoom)
    return
  end
  local dormFightCtrl = self:GetDormFightCtrl()
  if dormFightCtrl ~= nil then
    dormFightCtrl:RecvPvpCreateRoom(msg)
  end
end

function DormFightNetworkCtrl:CS_FIGHT_Over(isWin, resultCallback)
  local cs_netCtrl = CS_pvpFightManager_ins.PvpFightNetCtrl
  local PvpFightNetworkCtrl = cs_netCtrl:GetNetworkCtrl(cs_P3_PvpFight.PvpNetworkCtrlID.Fight)
  local msgData = cs_P3_PvpFight.PvpNetMsgData.Get()
  local MsgC2SFightOver = 5047
  msgData.CmdID = MsgC2SFightOver
  local dataArray = cs_array.CreateInstance(typeof(cs_byte), 2)
  if isWin then
    dataArray[0] = 8
    dataArray[1] = 2
  else
    dataArray[0] = 8
    dataArray[1] = 1
  end
  msgData:Encode(dataArray)
  cs_netCtrl:SendTcpMsg(msgData)
  self.resultCallback = resultCallback
  if isGameDev then
    print("客户端发送结束消息 CS_FIGHT_Over " .. "isWin = " .. tostring(isWin))
  end
end

function DormFightNetworkCtrl:SC_FIGHT_Over(netData)
end

function DormFightNetworkCtrl:S2C_FIGHT_CloseNtf(msg)
  local winner = msg.Winner
  local winerUserId
  if winner ~= nil and winner.Count > 0 then
    winerUserId = winner[0]
  end
  if isGameDev then
    print("收到服务器通知结束消息 S2C_FIGHT_CloseNtf")
  end
  if self.resultCallback == nil then
    local dormFightCtrl = self:GetDormFightCtrl()
    if dormFightCtrl ~= nil then
      dormFightCtrl:ForceEndGame(winerUserId)
    end
  else
    self.resultCallback(winerUserId)
  end
end

function DormFightNetworkCtrl:SC_FIGHT_OverNtf(msg)
  local winerUserId = msg.winnerUid
  self:UpdateDormFightRecord(msg.data)
  self:UpdateWinnerDormFightRecord(winerUserId, msg.winner, function()
    local dormFightCtrl = self:GetDormFightCtrl()
    if dormFightCtrl ~= nil then
      dormFightCtrl:OnShowResult(winerUserId)
    end
  end)
  if isGameDev then
    print("收到服务器通知战斗结果 SC_FIGHT_OverNtf " .. "winerUserId = " .. tostring(winerUserId))
  end
end

function DormFightNetworkCtrl:SC_UserOfflineNtf(msg)
  local dormFightCtrl = self:GetDormFightCtrl()
  if dormFightCtrl ~= nil then
    dormFightCtrl:OnOtherUserOffline(msg.uid)
  end
end

function DormFightNetworkCtrl:RegisterDormFightNetwork(msgId, caller, msgType, callback)
  local cs_netCtrl = CS_pvpFightManager_ins.PvpFightNetCtrl
  cs_netCtrl:RegisterListener(msgId, function(netData)
    local genericFunc = xlua.get_generic_method(cs_P3_PvpFight.PvpNetMsgData, "Decode")
    local pvpNetMsgDataDecodeFunc = genericFunc(typeof(msgType))
    local msg = pvpNetMsgDataDecodeFunc(netData)
    callback(caller, msg)
  end)
end

return DormFightNetworkCtrl
