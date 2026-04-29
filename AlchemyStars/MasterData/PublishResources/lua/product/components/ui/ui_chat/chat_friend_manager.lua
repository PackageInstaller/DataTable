_class("ChatFriendManager", Object)
ChatFriendManager = ChatFriendManager

function ChatFriendManager:Constructor()
  self._friendList = {}
  self._recentChatList = {}
  self._blackList = {}
  self._chatDataManager = ChatDataManager:New()
  self._currentSelectedChatFriendId = nil
  self._friendID2platformName = {}
end

function ChatFriendManager:ResetFriendUnReadMessageStatus(friendId)
  for i = 1, #self._friendList do
    local friendData = self._friendList[i]
    if friendData:GetFriendId() == friendId then
      friendData:ResetUnReadMessageStatus()
      break
    end
  end
  for i = 1, #self._recentChatList do
    local friendData = self._recentChatList[i]
    if friendData:GetFriendId() == friendId then
      friendData:ResetUnReadMessageStatus()
      break
    end
  end
end

function ChatFriendManager:RequestFriendList(TT)
  local socialModule = GameGlobal.GetModule(SocialModule)
  local friendList = socialModule:GetFriendList(TT) or {}
  self._friendList = {}
  for pstId, data in pairs(friendList) do
    local simpleInfo = data.simple_info
    local createTime = simpleInfo.create_time
    local unReadMsgNum = data.un_read_msg_num
    local endMsgTime = data.end_msg_time
    local hasNewMessage = false
    if 0 < unReadMsgNum then
      hasNewMessage = true
    end
    local chatFriendData = ChatFriendData:New(simpleInfo.pstid, simpleInfo.head, simpleInfo.head_bg, simpleInfo.frame_id, simpleInfo.level, simpleInfo.nick, hasNewMessage, simpleInfo.is_online, createTime, endMsgTime, simpleInfo.last_logout_time, simpleInfo.remark_name, simpleInfo.help_pet, simpleInfo.world_boss_info, simpleInfo.homeland_info)
    self._friendList[#self._friendList + 1] = chatFriendData
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateUnReadMessageStatus)
end

function ChatFriendManager:GetFriendList(sort)
  if sort then
    table.sort(self._friendList, function(a, b)
      local aPriority = 0
      local bPriority = 0
      if a:IsOnline() and not b:IsOnline() then
        aPriority = 10
      elseif not a:IsOnline() and b:IsOnline() then
        bPriority = 10
      end
      local aLevel = a:GetLevel()
      local bLevel = b:GetLevel()
      if aLevel ~= bLevel then
        if aLevel > bLevel then
          aPriority = aPriority + 1
        elseif aLevel < bLevel then
          bPriority = bPriority + 1
        end
      end
      if aPriority ~= bPriority then
        return aPriority > bPriority
      end
      return a:GetFriendId() > b:GetFriendId()
    end)
  end
  return self._friendList
end

function ChatFriendManager:GetRecentChatList()
  local friendList = self:GetFriendList(false)
  self._recentChatList = {}
  for i = 1, #friendList do
    local friendData = friendList[i]
    local chatDatas = self._chatDataManager:GetChatData(friendData:GetFriendId())
    if chatDatas and table.count(chatDatas) > 0 then
      local recentFriendData = ChatFriendData:New()
      recentFriendData:Init(friendData)
      self._recentChatList[#self._recentChatList + 1] = recentFriendData
      if recentFriendData:GetFriendId() == self._currentSelectedChatFriendId then
        recentFriendData:SetSelectedStatus(true)
      end
    elseif friendData:HasNewMessage() then
      local recentFriendData = ChatFriendData:New()
      recentFriendData:Init(friendData)
      self._recentChatList[#self._recentChatList + 1] = recentFriendData
      if recentFriendData:GetFriendId() == self._currentSelectedChatFriendId then
        recentFriendData:SetSelectedStatus(true)
      end
    end
  end
  table.sort(self._recentChatList, function(a, b)
    local aChatData = self._chatDataManager:GetChatData(a:GetFriendId())
    local aTime = 0
    if aChatData and 0 < #aChatData then
      local chatData = aChatData[#aChatData]
      aTime = chatData:GetDate()
    end
    if a:HasNewMessage() then
      aTime = a:GetRecentMsgTime()
    end
    local bChatData = self._chatDataManager:GetChatData(b:GetFriendId())
    local bTime = 0
    if bChatData and 0 < #bChatData then
      local chatData = bChatData[#bChatData]
      bTime = chatData:GetDate()
    end
    if b:HasNewMessage() then
      bTime = b:GetRecentMsgTime()
    end
    local aPriority = 0
    local bPriority = 0
    if a:HasNewMessage() and not b:HasNewMessage() then
      aPriority = 10
    elseif not a:HasNewMessage() and b:HasNewMessage() then
      bPriority = 10
    end
    if aTime ~= bTime then
      if aTime > bTime then
        aPriority = aPriority + 1
      elseif aTime < bTime then
        bPriority = bPriority + 1
      end
    end
    if aPriority ~= bPriority then
      return aPriority > bPriority
    end
    return a:GetFriendId() > b:GetFriendId()
  end)
  if self._needAddRecentFriendId and self:IsMyFriend(self._needAddRecentFriendId) then
    local friendData = self:GetRecentChatFriendDataById(self._needAddRecentFriendId)
    if not friendData then
      friendData = self:GetFriendDataById(self._needAddRecentFriendId)
      local recentFriendData = ChatFriendData:New()
      recentFriendData:Init(friendData)
      table.insert(self._recentChatList, 1, recentFriendData)
      if recentFriendData:GetFriendId() == self._currentSelectedChatFriendId then
        recentFriendData:SetSelectedStatus(true)
      end
    end
  end
  return self._recentChatList
end

function ChatFriendManager:GetFriendDataById(friendId)
  if not friendId then
    return nil
  end
  local friendList = self:GetFriendList(false)
  if not friendList then
    return nil
  end
  for i = 1, #friendList do
    local friendData = friendList[i]
    if friendData:GetFriendId() == friendId then
      return friendData
    end
  end
  return nil
end

function ChatFriendManager:RequestChatData(TT, friendId)
  return self._chatDataManager:RequestChatData(TT, self, friendId)
end

function ChatFriendManager:AddChatData(friendId, chatData)
  self._chatDataManager:AddChatData(friendId, chatData)
end

function ChatFriendManager:SaveAllChatDatas()
  self._chatDataManager:SaveAllChatDatas()
end

function ChatFriendManager:GetAllChatDatas(TT)
  local friendList = self:GetFriendList(false)
  self._chatDataManager:GetAllChatDatas(TT, friendList)
end

function ChatFriendManager:SendMessage(TT, friendId, messageType, message, emojiId)
  self._chatDataManager:SendMessage(TT, self, friendId, messageType, message, emojiId)
end

function ChatFriendManager:DeleteFriend(TT, friendId)
  local socialModule = GameGlobal.GetModule(SocialModule)
  local res = socialModule:DelFriend(TT, friendId)
  if res:GetSucc() then
    self._chatDataManager:DeleteChatData(friendId)
    self:_DeleteFriendFromList(friendId)
  else
    self:HandleErrorMsgCode(res:GetResult())
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateUnReadMessageStatus)
end

function ChatFriendManager:_DeleteFriendFromList(friendId)
  if friendId == self._currentSelectedChatFriendId then
    self._currentSelectedChatFriendId = nil
  end
  for k, friendData in pairs(self._friendList) do
    if friendData:GetFriendId() == friendId then
      table.remove(self._friendList, k)
      break
    end
  end
  for k, friendData in pairs(self._recentChatList) do
    if friendData:GetFriendId() == friendId then
      table.remove(self._recentChatList, k)
      break
    end
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.DeleteFriendUI, friendId)
end

function ChatFriendManager:SelectRecentFriend(friendDataId)
  local friendData = self:GetRecentChatFriendDataById(self._currentSelectedChatFriendId)
  if friendData then
    friendData:SetSelectedStatus(false)
  end
  self._currentSelectedChatFriendId = friendDataId
  friendData = self:GetRecentChatFriendDataById(self._currentSelectedChatFriendId)
  if friendData then
    friendData:SetSelectedStatus(true)
  end
end

function ChatFriendManager:GetRecentChatFriendDataById(friendId)
  if not friendId then
    return
  end
  if not self._recentChatList then
    return
  end
  for i = 1, #self._recentChatList do
    local friendData = self._recentChatList[i]
    if friendData:GetFriendId() == friendId then
      return friendData
    end
  end
  return nil
end

function ChatFriendManager:CancelSelectRecentFriend(TT)
  local friendData = self:GetRecentChatFriendDataById(self._currentSelectedChatFriendId)
  if friendData then
    friendData:SetSelectedStatus(false)
  end
  self._currentSelectedChatFriendId = nil
end

function ChatFriendManager:GetSelectRecentFriend()
  return self._currentSelectedChatFriendId
end

function ChatFriendManager:UpdateSelectFriend()
  if self._recentChatList and self._currentSelectedChatFriendId then
    local friendId = self._currentSelectedChatFriendId
    local find = false
    for k, friendData in pairs(self._recentChatList) do
      if friendData:GetFriendId() == friendId then
        find = true
        break
      end
    end
    if find == false then
      self._currentSelectedChatFriendId = nil
    end
  end
  if self._cacheCurrentSelectRecentFriendId then
    self._currentSelectedChatFriendId = self._cacheCurrentSelectRecentFriendId
    local friendData = self:GetRecentChatFriendDataById(self._currentSelectedChatFriendId)
    if friendData then
      friendData:SetSelectedStatus(true)
    end
  end
  self._cacheCurrentSelectRecentFriendId = nil
end

function ChatFriendManager:CacheCurrentSelectRecentFriend(friendId)
  self._cacheCurrentSelectRecentFriendId = friendId
  self._needAddRecentFriendId = friendId
end

function ChatFriendManager:ClearCacheCurrentSelectRecentFriend()
  self._cacheCurrentSelectRecentFriendId = nil
  self._needAddRecentFriendId = nil
end

function ChatFriendManager:HasUnReadMessage()
  if not self._friendList then
    return false
  end
  for i = 1, #self._friendList do
    if self._friendList[i]:HasNewMessage() then
      return true
    end
  end
  return false
end

function ChatFriendManager:GetMaxFriendCount()
  local friendCfg = Cfg.cfg_friend_global[1]
  if not friendCfg then
    return 50
  end
  if friendCfg.limit_count then
    return friendCfg.limit_count
  end
  return 50
end

function ChatFriendManager:GetMaxAddFriendRequestCount()
  local friendCfg = Cfg.cfg_friend_global[1]
  if not friendCfg then
    return 15
  end
  if friendCfg.invitation_friend_count then
    return friendCfg.invitation_friend_count
  end
  return 15
end

function ChatFriendManager:GetMaxBlackListCount()
  local friendCfg = Cfg.cfg_friend_global[1]
  if not friendCfg then
    return 50
  end
  if friendCfg.black_list_count then
    return friendCfg.black_list_count
  end
  return 50
end

function ChatFriendManager:RequestBlackListData(TT)
  local socialModule = GameGlobal.GetModule(SocialModule)
  local res, tempBlackList = socialModule:HandleGetSocialBlackList(TT)
  if not res:GetSucc() then
    return
  end
  local blackList = tempBlackList
  for k, v in pairs(blackList) do
    self:_AddBlackListData(v)
  end
end

function ChatFriendManager:_AddBlackListData(playerInfo)
  local chatFriendData = ChatFriendData:New(playerInfo.pstid, playerInfo.head, playerInfo.head_bg, playerInfo.frame_id, playerInfo.level, playerInfo.nick, false, playerInfo.is_online, playerInfo.create_time, 0, playerInfo.last_logout_time, playerInfo.remark_name, playerInfo.help_pet, playerInfo.world_boss_info, playerInfo.homeland_info)
  self._blackList[#self._blackList + 1] = chatFriendData
end

function ChatFriendManager:GetBlackListData(TT)
  return self._blackList
end

function ChatFriendManager:HandleBlackOperate(TT, friendId, isDel)
  if not isDel then
    local count = #self._blackList
    if count >= self:GetMaxBlackListCount() then
      ToastManager.ShowToast(StringTable.Get("str_chat_blacklist_count_is_max"))
      return false
    end
  end
  local socialModule = GameGlobal.GetModule(SocialModule)
  local res, playerInfo = socialModule:HandleBlackOperate(TT, friendId, isDel)
  if not res:GetSucc() then
    local retCode = res:GetResult()
    self:HandleErrorMsgCode(retCode)
    return false
  end
  if isDel then
    for i = 1, #self._blackList do
      local friendData = self._blackList[i]
      if friendData:GetFriendId() == friendId then
        table.remove(self._blackList, i)
        break
      end
    end
  else
    self:_AddBlackListData(playerInfo)
  end
  return true
end

function ChatFriendManager:IsMyFriend(friendId)
  if not friendId then
    return false
  end
  local friendList = self:GetFriendList(false)
  if not friendList then
    return false
  end
  for i = 1, #friendList do
    local friendData = friendList[i]
    if friendData:GetFriendId() == friendId then
      return true
    end
  end
  return false
end

function ChatFriendManager:IsInBlackList(friendId)
  if not self._blackList then
    return false
  end
  for i = 1, #self._blackList do
    local friendData = self._blackList[i]
    if friendData:GetFriendId() == friendId then
      return true
    end
  end
  return false
end

function ChatFriendManager:GetSuggestFriendList(TT, isRefresh)
  local socialModule = GameGlobal.GetModule(SocialModule)
  local res, tempSuggestList = socialModule:HandleRefreshRecommendPlayer(TT, isRefresh)
  if not res:GetSucc() then
    self:HandleErrorMsgCode(res:GetResult())
    return {}
  end
  local suggestFriendList = {}
  local dataList = tempSuggestList
  if not dataList then
    return suggestFriendList
  end
  for i = 1, #dataList do
    local suggestFriendData = dataList[i]
    local playerInfo = suggestFriendData.recommend_info
    local chatFriendData = ChatFriendData:New(playerInfo.pstid, playerInfo.head, playerInfo.head_bg, playerInfo.frame_id, playerInfo.level, playerInfo.nick, false, playerInfo.is_online, playerInfo.create_time, 0, playerInfo.last_logout_time, playerInfo.remark_name, playerInfo.help_pet, playerInfo.world_boss_info, playerInfo.homeland_info)
    suggestFriendList[#suggestFriendList + 1] = chatFriendData
    chatFriendData:SetSuggestSource(suggestFriendData.nRecommendType)
  end
  return suggestFriendList
end

function ChatFriendManager:HandleErrorMsgCode(errorCode)
  if errorCode == nil then
    return
  end
  local errorMsg = ""
  if errorCode == SocialErrorCode.SOCIAL_ERROR_SYSTEM then
    errorMsg = StringTable.Get("str_chat_error_code_system_exception")
  elseif errorCode == SocialErrorCode.SOCIAL_ERROR_SYSTEM_RMI then
    errorMsg = StringTable.Get("str_chat_error_code_service_chat_exception")
  elseif errorCode == SocialErrorCode.SOCIAL_ERROR_DB then
    errorMsg = StringTable.Get("str_chat_error_code_db_exception")
  elseif errorCode == SocialErrorCode.SOCIAL_ERROR_PARAM then
    errorMsg = StringTable.Get("str_chat_error_code_param_error")
  elseif errorCode == SocialErrorCode.SOCIAL_ERROR_DUPLICATE then
    errorMsg = StringTable.Get("str_chat_error_code_already_peeer_friend")
  elseif errorCode == SocialErrorCode.SOCIAL_ERROR_NULL_SOC then
    errorMsg = StringTable.Get("str_chat_error_code_null_soc")
  elseif errorCode == SocialErrorCode.SOCIAL_ERROR_SELF_COUNT_MAX then
    errorMsg = StringTable.Get("str_chat_error_code_self_count_max")
  elseif errorCode == SocialErrorCode.SOCIAL_ERROR_PEER_COUNT_MAX then
    errorMsg = StringTable.Get("str_chat_error_code_peer_count_max")
  elseif errorCode == SocialErrorCode.SOCIAL_ERROR_SELF then
    errorMsg = StringTable.Get("str_chat_error_code_self")
  elseif errorCode == SocialErrorCode.SOCIAL_ERROR_INVITATION_COUNT_MAX then
    errorMsg = StringTable.Get("str_chat_error_code_invitation_count_max")
  elseif errorCode == SocialErrorCode.SOCIAL_ERROR_INVITATION_SELF then
    errorMsg = StringTable.Get("str_chat_error_code_invitation_self")
  elseif errorCode == SocialErrorCode.SOCIAL_ERROR_DUPLICATE_BLACK then
    errorMsg = StringTable.Get("str_chat_error_code_player_in_self_black")
  elseif errorCode == SocialErrorCode.SOCIAL_ERROR_SELF_IN_BLACK then
    errorMsg = StringTable.Get("str_chat_error_code_player_in_self_black")
  elseif errorCode == SocialErrorCode.SOCIAL_ERROR_PEER_IN_BLACK then
    errorMsg = StringTable.Get("str_chat_error_code_in_peer_blacklist")
  elseif errorCode == SocialErrorCode.SOCIAL_BLACK_LIST_LIMIT then
    errorMsg = StringTable.Get("str_chat_error_code_black_list_limit")
  elseif errorCode == SocialErrorCode.SOCIAL_ERROR_IN_PEER_INV_LIST then
    errorMsg = StringTable.Get("str_chat_error_code_in_peer_inv_list")
  elseif errorCode == SocialErrorCode.SOCIAL_ERROR_ALREAD_PEER_FRIEND then
    errorMsg = StringTable.Get("str_chat_error_code_already_peeer_friend")
  elseif errorCode == SocialErrorCode.SOCIAL_CHAT_ERROR_PARAM then
    errorMsg = StringTable.Get("str_chat_error_code_chat_error_param")
  elseif errorCode == SocialErrorCode.SOCIAL_CHAT_ERROR_S2SRMI_FAIL then
    errorMsg = StringTable.Get("str_chat_error_code_s2srmi_fail")
  elseif errorCode == SocialErrorCode.SOCIAL_CHAT_ERROR_CHANNEL_NOT_FOUND then
    errorMsg = StringTable.Get("str_chat_error_code_channel_not_found")
  elseif errorCode == SocialErrorCode.SOCIAL_CHAT_ERROR_NOT_IN_CHANNEL then
    errorMsg = StringTable.Get("str_chat_error_code_not_in_channel")
  elseif errorCode == SocialErrorCode.SOCIAL_CHAT_ERROR_NOT_PERMISSION_LOW_LEVEL then
    errorMsg = StringTable.Get("str_chat_error_code_not_permission_low_level")
  elseif errorCode == SocialErrorCode.SOCIAL_CHAT_ERROR_FREQUENCY_LIMIT then
    errorMsg = StringTable.Get("str_chat_error_code_frequency_limit")
  elseif errorCode == SocialErrorCode.SOCIAL_CHAT_ERROR_LENGTH_LIMIT then
    errorMsg = StringTable.Get("str_chat_error_code_length_limit")
  elseif errorCode == SocialErrorCode.SOCIAL_CHAT_ERROR_PLAYER_STATISICS_GET_FAIL then
    errorMsg = StringTable.Get("str_chat_error_code_player_statisics_get_fail")
  elseif errorCode == SocialErrorCode.SOCIAL_CHAT_ERROR_PLAYER_GET_INFO_FAIL then
    errorMsg = StringTable.Get("str_chat_error_code_player_get_info_fail")
  elseif errorCode == SocialErrorCode.SOCIAL_CHAT_ERROR_PLAYER_REFUSE_RECEIVE then
    errorMsg = StringTable.Get("str_chat_error_code_player_refuse_receive")
  elseif errorCode == SocialErrorCode.SOCIAL_CHAT_NOT_FRIEND then
    errorMsg = StringTable.Get("str_chat_error_code_not_friend")
  elseif errorCode == SocialErrorCode.SOCIAL_CHAT_PEER_NOT_FRIEND then
    errorMsg = StringTable.Get("str_chat_error_code_peer_not_friend")
  elseif errorCode == SocialErrorCode.SOCIAL_CHAT_SEND_TARGET_ERROR then
    errorMsg = StringTable.Get("str_chat_error_code_send_target_error")
  elseif errorCode == SocialErrorCode.SOCIAL_CHAT_IS_EMPTY then
    errorMsg = StringTable.Get("str_chat_error_code_is_empty")
  elseif errorCode == SocialErrorCode.SOCIAL_SEARCH_PSTID_INVALID then
    errorMsg = StringTable.Get("str_chat_error_search_pstid_invalid")
  elseif errorCode == SocialErrorCode.SOCIAL_CHAT_ERROR_TIME_OUT then
    errorMsg = StringTable.Get("str_chat_error_time_out")
  elseif errorCode == SocialErrorCode.SOCIAL_CHAT_SEND_TYPE_ERROR then
    errorMsg = StringTable.Get("str_chat_error_code_send_type_error")
  elseif errorCode == SocialErrorCode.SOCIAL_CHAT_EMOJI_NUM_ERROR then
    errorMsg = StringTable.Get("str_chat_error_code_emoji_num_error")
  elseif errorCode == SocialErrorCode.SOCIAL_REMARK_LIMIT then
    errorMsg = StringTable.Get("str_chat_set_name_tolong")
  elseif errorCode == SocialErrorCode.SOCIAL_REMARK_DIRTY then
    errorMsg = StringTable.Get("str_chat_error_code_remark_dirty")
  elseif errorCode == SocialErrorCode.SOCIAL_REMARK_SPE then
    errorMsg = StringTable.Get("str_chat_error_code_remark_spe")
  elseif errorCode == SocialErrorCode.SOCIAL_REMARK_INVALID then
    errorMsg = StringTable.Get("str_chat_error_coed_remark_invalid")
  end
  if errorMsg and errorMsg ~= "" then
    ToastManager.ShowToast(errorMsg)
  end
  Log.error(errorCode)
end

function ChatFriendManager:Request(friendList, blackList, chatDatas, cb)
  GameGlobal.TaskManager():StartTask(function(chatFriendManager, TT)
    local lockName = "ChatFriendManager:Request"
    GameGlobal.UIStateManager():Lock(lockName)
    if friendList then
      chatFriendManager:RequestFriendList(TT)
    end
    if blackList then
      chatFriendManager:RequestBlackListData(TT)
    end
    if chatDatas then
      chatFriendManager:GetAllChatDatas()
    end
    GameGlobal.UIStateManager():UnLock(lockName)
    if cb then
      cb(chatFriendManager)
    end
  end, self)
end

function ChatFriendManager:GetFriendName(friendData)
  local friendid = friendData:GetFriendId()
  local retName
  local showName = friendData:GetName()
  local platformName = self._friendID2platformName[friendid]
  if platformName then
    platformName = string.gsub(platformName, "%%", "%%%%")
    retName = StringTable.Get("str_chat_name_append", showName, platformName)
  else
    retName = showName
  end
  local appendValue = StringTable.Get("str_chat_name_append_dot")
  return retName, appendValue
end
