_class("SocialModule", GameModule)
SocialModule = SocialModule
local c_refresh_client_friend_info_interval = 60000

function SocialModule:Constructor()
  self.m_friend_list = nil
  self.have_new_msg = false
  self.have_new_invitation = false
  self.last_refresh_friend_time = 0
end

function SocialModule:Init()
  self.caller:RegisterPushHandler(CEventPushUpdateFriendList, self.HandlePushUpdateFriendList, self)
  self.caller:RegisterPushHandler(CEventPushUpdateFriendInvitation, self.HandlePushUpdateFriendInvitation, self)
  self.caller:RegisterPushHandler(CEventOutSidePushNewMsg, self.HandleOutSidePushNewMsg, self)
  self.caller:RegisterPushHandler(CEventPushHaveNewMsg, self.HandlePushHaveNewMsg, self)
  self.caller:RegisterPushHandler(CEventPushFriendMsg, self.HandlePushFriendMsg, self)
end

function SocialModule:Dispose()
  self.caller:UnRegisterPushHandler(CEventPushUpdateFriendList)
  self.caller:UnRegisterPushHandler(CEventPushUpdateFriendInvitation)
  self.caller:UnRegisterPushHandler(CEventOutSidePushNewMsg)
  self.caller:UnRegisterPushHandler(CEventPushHaveNewMsg)
  self.caller:UnRegisterPushHandler(CEventPushFriendMsg)
  SocialModule.super.Dispose(self)
end

function SocialModule:GetFriendList(TT)
  if self.immedRefresh then
    local request = NetMessageFactory:GetInstance():CreateMessage(CEventGetFriendList)
    local reply = self:Call(TT, request)
    if reply.res ~= CallResultType.Normal then
      return nil
    end
    local nRet = reply.msg.ret
    if nRet ~= SocialErrorCode.SOCIAL_SUCC then
      return nil
    end
    self.m_friend_list = reply.msg.friend_list
    self.immedRefresh = false
  end
  if self.m_friend_list == nil then
    local request = NetMessageFactory:GetInstance():CreateMessage(CEventGetFriendList)
    local reply = self:Call(TT, request)
    if reply.res ~= CallResultType.Normal then
      return nil
    end
    local nRet = reply.msg.ret
    if nRet ~= SocialErrorCode.SOCIAL_SUCC then
      return nil
    end
    self.m_friend_list = reply.msg.friend_list
  else
    self:_RefreshFriendList(TT)
  end
  return self.m_friend_list
end

function SocialModule:_RefreshFriendList(TT)
  local l_cur_time = GameGlobal:GetInstance():GetCurrentTime()
  if l_cur_time - self.last_refresh_friend_time < c_refresh_client_friend_info_interval then
    return
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRefreshFriendOnlineState)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return
  end
  local repMsg = reply.msg
  if repMsg.update_friend_list == nil or #repMsg.update_friend_list < 0 then
    return
  end
  for _, value in ipairs(repMsg.update_friend_list) do
    local l_simple_info = value.simple_info
    local l_pstid = l_simple_info.pstid
    self.m_friend_list[l_pstid] = value
  end
  self.last_refresh_friend_time = GameGlobal:GetInstance():GetCurrentTime()
end

function SocialModule:EnterChatFriendModule(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventEnterChatFriendModule)
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SocialErrorCode.SOCIAL_ERROR_SYSTEM)
    return AsyncRes
  end
  local nRet = reply.msg.ret
  AsyncRes:SetResult(nRet)
  if nRet ~= SocialErrorCode.SOCIAL_SUCC then
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  self.m_friend_list = reply.msg.friend_list
  if reply.msg.bIsGotInvitationList then
    self.have_new_invitation = false
  else
    self.have_new_invitation = reply.msg.bHaveInvitation
  end
  return AsyncRes
end

function SocialModule:LeaveChatFriendModule(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventLeaveChatFriendModule)
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SocialErrorCode.SOCIAL_ERROR_SYSTEM)
    return AsyncRes
  end
  local nRet = reply.msg.ret
  AsyncRes:SetResult(nRet)
  if nRet ~= SocialErrorCode.SOCIAL_SUCC then
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  self:_CalHaveUnReadMsg()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ModuleFriendNotifyNewMsg)
  return AsyncRes
end

function SocialModule:InvitationFriend(TT, receiver_pstid)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAddFriend)
  request.send_invt.receiver_pstid = receiver_pstid
  request.send_invt.invitation_type = InvitationType.INVAITATION_TYPE_FRIEND
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SocialErrorCode.SOCIAL_ERROR_SYSTEM)
    return AsyncRes
  end
  local reply_msg = reply.msg
  local nRet = reply_msg.ret
  AsyncRes:SetResult(nRet)
  if nRet ~= SocialErrorCode.SOCIAL_SUCC then
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  return AsyncRes
end

function SocialModule:DelFriend(TT, peer_pstid)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventDelFriend)
  request.peer_pstid = peer_pstid
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SocialErrorCode.SOCIAL_ERROR_SYSTEM)
    return AsyncRes
  end
  local reply_msg = reply.msg
  local nRet = reply_msg.ret
  AsyncRes:SetResult(nRet)
  if nRet ~= SocialErrorCode.SOCIAL_SUCC then
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  return AsyncRes
end

function SocialModule:GetFriendInvitationList(TT)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventGetFriendInvitationList)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SocialErrorCode.SOCIAL_ERROR_SYSTEM)
    return AsyncRes, nil
  end
  local reply_msg = reply.msg
  local nRet = reply_msg.ret
  AsyncRes:SetResult(nRet)
  if nRet ~= SocialErrorCode.SOCIAL_SUCC then
    return AsyncRes, nil
  end
  AsyncRes:SetSucc(true)
  self.have_new_invitation = false
  return AsyncRes, reply_msg.invitation_list
end

function SocialModule:ProcessAddFriend(TT, sender_pstid, is_pass)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventProcessAddFriend)
  request.proc_invt.sender_pstid = sender_pstid
  request.proc_invt.is_pass = is_pass
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SocialErrorCode.SOCIAL_ERROR_SYSTEM)
    return AsyncRes
  end
  local reply_msg = reply.msg
  local nRet = reply_msg.ret
  AsyncRes:SetResult(nRet)
  if nRet ~= SocialErrorCode.SOCIAL_SUCC then
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  return AsyncRes
end

function SocialModule:SendFriendMsg(TT, select_friend, send_type, send_message, send_emoji_id)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSendFriendMsg)
  request.select_friend = select_friend
  if send_type == FRIEND_CHAT_MSG_TYPE.FRIEND_CHAT_MSG_TYPE_STR then
    request.send_message = send_message
  elseif send_type == FRIEND_CHAT_MSG_TYPE.FRIEND_CHAT_MSG_TYPE_EMOJI then
    request.emoji_id = send_emoji_id
  end
  request.friend_msg_type = send_type
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SocialErrorCode.SOCIAL_ERROR_SYSTEM)
    return AsyncRes, nil
  end
  local reply_msg = reply.msg
  local nRet = reply_msg.ret
  AsyncRes:SetResult(nRet)
  if nRet ~= SocialErrorCode.SOCIAL_SUCC then
    return AsyncRes, nil
  end
  AsyncRes:SetSucc(true)
  return AsyncRes, reply_msg.send_msg
end

function SocialModule:SelectChatFriend(TT, select_friend_pstid)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSelectChatFriend)
  request.select_friend = select_friend_pstid
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SocialErrorCode.SOCIAL_ERROR_SYSTEM)
    return AsyncRes
  end
  local reply_msg = reply.msg
  local nRet = reply_msg.ret
  AsyncRes:SetResult(nRet)
  if nRet ~= SocialErrorCode.SOCIAL_SUCC then
    return AsyncRes
  end
  if reply_msg.sender_pstid ~= select_friend_pstid then
    Log.error("SocialModule:SelectChatFriend error sender_pstid:", reply_msg.sender_pstid, " select_friend_pstid:", select_friend_pstid)
    AsyncRes:SetResult(SocialErrorCode.SOCIAL_ERROR_SYSTEM)
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  if select_friend_pstid ~= 0 then
    self.m_friend_list[select_friend_pstid].un_read_msg_num = 0
  end
  return AsyncRes, reply_msg.msg_list
end

function SocialModule:_CalHaveUnReadMsg()
  local l_isAllRead = true
  for key, value in pairs(self.m_friend_list) do
    if value.un_read_msg_num > 0 then
      l_isAllRead = false
      break
    end
  end
  if l_isAllRead then
    self.have_new_msg = false
  else
    self.have_new_msg = true
  end
end

function SocialModule:HandleSearchPlayer(TT, search_pstid_list)
  local AsyncRes = AsyncRequestRes:New()
  if search_pstid_list == nil or #search_pstid_list <= 0 then
    AsyncRes:SetResult(SocialErrorCode.SOCIAL_ERROR_PARAM)
    return AsyncRes
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSearchFriend)
  request.search_pstid_list = search_pstid_list
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SocialErrorCode.SOCIAL_ERROR_SYSTEM)
    return AsyncRes
  end
  local reply_msg = reply.msg
  local nRet = reply_msg.ret
  AsyncRes:SetResult(nRet)
  if nRet ~= SocialErrorCode.SOCIAL_SUCC then
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  return AsyncRes, reply_msg.player_info_list
end

function SocialModule:HandleBlackOperate(TT, black_pstid, is_del)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventUpdateSocialBlackList)
  request.black_pstid = black_pstid
  request.is_del = is_del
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SocialErrorCode.SOCIAL_ERROR_SYSTEM)
    return AsyncRes
  end
  local reply_msg = reply.msg
  local nRet = reply_msg.ret
  AsyncRes:SetResult(nRet)
  if nRet ~= SocialErrorCode.SOCIAL_SUCC then
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  return AsyncRes, reply_msg.player_info
end

function SocialModule:HandleGetSocialBlackList(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventGetSocialBlackList)
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SocialErrorCode.SOCIAL_ERROR_SYSTEM)
    return AsyncRes
  end
  local reply_msg = reply.msg
  local nRet = reply_msg.ret
  AsyncRes:SetResult(nRet)
  if nRet ~= SocialErrorCode.SOCIAL_SUCC then
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  return AsyncRes, reply_msg.black_list
end

function SocialModule:HandleRefreshRecommendPlayer(TT, refresh_list)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRefreshRecommendPlayer)
  request.bRefresh = refresh_list
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SocialErrorCode.SOCIAL_ERROR_SYSTEM)
    return AsyncRes
  end
  local reply_msg = reply.msg
  AsyncRes:SetResult(SocialErrorCode.SOCIAL_SUC)
  AsyncRes:SetSucc(true)
  return AsyncRes, reply_msg.rec_vec
end

function SocialModule:HandlePushUpdateFriendList(msg)
  if not msg then
    return
  end
  local l_update_type = msg.update_type
  local l_update_pstid = msg.update_info.simple_info.pstid
  if l_update_pstid <= 0 then
    return
  end
  if self.m_friend_list == nil then
    return
  end
  if l_update_type == UpdateFriendInfoType.UpdateFriendInfoType_Del then
    self.m_friend_list[l_update_pstid] = nil
  else
    self.m_friend_list[l_update_pstid] = msg.update_info
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateFriendInfo, l_update_type, l_update_pstid)
end

function SocialModule:_CheckAndSetModifyPlayerInfo(check_social_player_info)
  local l_update_pstid = check_social_player_info.pstid
  if l_update_pstid == nil or l_update_pstid <= 0 then
    return
  end
  local l_UpdateNotify = false
  if self.m_friend_list[l_update_pstid] == nil then
    return
  end
  local cur_player_info = self.m_friend_list[l_update_pstid].simple_info
  local l_is_change = self:_SocialPlayerInfoIsChange(check_social_player_info, cur_player_info)
  if l_is_change then
    self.m_friend_list[l_update_pstid].simple_info = check_social_player_info
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateFriendInfo, UpdateFriendInfoType.UpdateFriendInfoType_Update, l_update_pstid)
  end
end

function SocialModule:_SocialPlayerInfoIsChange(check_social_player_info, cur_player_info)
  if cur_player_info.pstid ~= check_social_player_info.pstid or cur_player_info.nick ~= check_social_player_info.nick or cur_player_info.head ~= check_social_player_info.head or cur_player_info.head_bg ~= check_social_player_info.head_bg or cur_player_info.level ~= check_social_player_info.level or cur_player_info.is_online ~= check_social_player_info.is_online or cur_player_info.create_time ~= check_social_player_info.create_time or cur_player_info.last_logout_time ~= check_social_player_info.last_logout_time or cur_player_info.remark_name ~= check_social_player_info.remark_name then
    return true
  end
  for key, value in pairs(cur_player_info.help_pet) do
    for k, var in pairs(value) do
      if check_social_player_info.help_pet[key][k] ~= var then
        return true
      end
    end
  end
  return false
end

function SocialModule:HandlePushUpdateFriendInvitation(msg)
  self.have_new_invitation = msg.bHaveNewInvitation
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateFriendInvitation)
end

function SocialModule:HaveNewMsg()
  return self.have_new_msg
end

function SocialModule:HaveNewInvitation()
  return self.have_new_invitation
end

function SocialModule:HandleOutSidePushNewMsg()
  self.have_new_msg = true
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ModuleFriendNotifyNewMsg)
end

function SocialModule:CheckHaveNewMsg(bHaveNewMsg)
  if bHaveNewMsg then
    self:HandleOutSidePushNewMsg()
  end
end

function SocialModule:PushCurStoreMaxMsgId(sender_pstid, max_msg_id)
  if max_msg_id <= 0 then
    Log.error("SocialModule:PushCurStoreMaxMsgId error max_msg_id:", max_msg_id)
    return
  end
  local msg = NetMessageFactory:GetInstance():CreateMessage(CEventPushClientRecvMaxMsgIdAck)
  msg.sender_pstid = sender_pstid
  msg.recv_msg_max_id = max_msg_id
  self:Push(msg)
end

function SocialModule:HandlePushHaveNewMsg(msg)
  local l_sender_pstid = msg.sender_pstid
  if self.m_friend_list == nil or self.m_friend_list[l_sender_pstid] == nil then
    return
  end
  self.m_friend_list[l_sender_pstid].end_msg_time = msg.send_time
  self.m_friend_list[l_sender_pstid].un_read_msg_num = self.m_friend_list[l_sender_pstid].un_read_msg_num + 1
  GameGlobal.EventDispatcher():Dispatch(GameEventType.InModuleFriendNotifyNewMsg)
end

function SocialModule:HandlePushFriendMsg(msg)
  local msg_list = msg.msg_list
  local sender_pstid = msg.sender_pstid
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TargetFriendNewMsg, msg_list, sender_pstid)
end

function SocialModule:HandleGetPlayerDetailInfo(TT, pstid)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventGetPlayerDetailInfo)
  request.pst_id = pstid
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SocialErrorCode.SOCIAL_ERROR_SYSTEM)
    return AsyncRes
  end
  local reply_msg = reply.msg
  local nRet = reply_msg.ret
  AsyncRes:SetResult(nRet)
  if nRet ~= SocialErrorCode.SOCIAL_SUCC then
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  local l_social_player_info = reply_msg.m_social_info.simple_info
  self:_CheckAndSetModifyPlayerInfo(l_social_player_info)
  return AsyncRes, reply_msg.m_social_info
end

function SocialModule:HandleRemark(TT, pstid, remark)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSetFriendRemarkName)
  request.pst_id = pstid
  request.remark_name = remark
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SocialErrorCode.SOCIAL_ERROR_SYSTEM)
    return AsyncRes
  end
  local reply_msg = reply.msg
  local nRet = reply_msg.ret
  AsyncRes:SetResult(nRet)
  if nRet ~= SocialErrorCode.SOCIAL_SUCC then
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  return AsyncRes
end

function SocialModule:HandleCEventBothwayFriend(TT, pstid)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventBothwayFriendReq)
  request.pst_id = pstid
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SocialErrorCode.SOCIAL_ERROR_SYSTEM)
    return AsyncRes
  end
  local reply_msg = reply.msg
  local nRet = reply_msg.ret
  AsyncRes:SetResult(nRet)
  if nRet ~= SocialErrorCode.SOCIAL_SUCC then
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  return AsyncRes
end
