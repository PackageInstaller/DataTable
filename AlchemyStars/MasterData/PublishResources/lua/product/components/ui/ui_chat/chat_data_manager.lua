_class("ChatDataManager", Object)
ChatDataManager = ChatDataManager

function ChatDataManager:Constructor()
  self._chatDatas = nil
  self._chatDataKey = nil
end

function ChatDataManager:SendMessage(TT, chatFriendManager, friendId, messageType, message, emojiId)
  local socialModule = GameGlobal.GetModule(SocialModule)
  local res, msgInfo = socialModule:SendFriendMsg(TT, friendId, messageType, message, emojiId)
  if res:GetSucc() then
    local chatData = ChatData:New(msgInfo.msg_id, msgInfo.friend_msg_type, msgInfo.chat_message, msgInfo.emoji_id, true, msgInfo.chat_time)
    self:AddChatData(friendId, chatData)
    self:ReceiveMessage(friendId)
  elseif res:GetResult() == SocialErrorCode.SOCIAL_CHAT_PEER_NOT_FRIEND then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ChatFriendNotYourFriend, friendId)
  else
    chatFriendManager:HandleErrorMsgCode(res:GetResult())
  end
end

function ChatDataManager:ReceiveMessage(friendId)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ReceiveChatMessage, friendId, true)
end

function ChatDataManager:AddChatData(friendId, chatData)
  if self._chatDatas[friendId] == nil then
    self._chatDatas[friendId] = {}
  end
  local hasContain = false
  local chatCount = #self._chatDatas[friendId]
  for i = 1, chatCount do
    local tempChatData = self._chatDatas[friendId][i]
    if tempChatData:GetId() == chatData:GetId() then
      hasContain = true
      break
    end
  end
  if not hasContain then
    self._chatDatas[friendId][#self._chatDatas[friendId] + 1] = chatData
    self:_RefreshChatDataTimeStatus()
  end
end

function ChatDataManager:DeleteChatData(friendId)
  if not friendId or not self._chatDatas[friendId] then
    return
  end
  self._chatDatas[friendId] = nil
end

function ChatDataManager:GetChatData(friendId)
  if not self._chatDatas or not friendId then
    return nil
  end
  local success = self:_RemoveChatData(friendId)
  if success then
    self:_RefreshChatDataTimeStatus()
  end
  return self._chatDatas[friendId]
end

function ChatDataManager:RequestChatData(TT, chatFriendManager, friendId)
  local socialModule = GameGlobal.GetModule(SocialModule)
  local res, msgList = socialModule:SelectChatFriend(TT, friendId)
  if res:GetSucc() then
    if msgList then
      for i = #msgList, 1, -1 do
        local chatInfo = msgList[i]
        local chatData = ChatData:New(chatInfo.msg_id, chatInfo.friend_msg_type, chatInfo.chat_message, chatInfo.emoji_id, false, chatInfo.chat_time)
        self:AddChatData(friendId, chatData)
      end
    end
    chatFriendManager:ResetFriendUnReadMessageStatus(friendId)
  else
    chatFriendManager:HandleErrorMsgCode(res:GetResult())
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateUnReadMessageStatus)
  self:SaveAllChatDatas()
  self:PushCurStoreMaxMsgId(friendId)
  return self:GetChatData(friendId)
end

function ChatDataManager:PushCurStoreMaxMsgId(senderPstId)
  if not self._chatDatas[senderPstId] then
    return
  end
  if #self._chatDatas[senderPstId] <= 0 then
    return
  end
  local socialModule = GameGlobal.GetModule(SocialModule)
  local chatData = self._chatDatas[senderPstId][#self._chatDatas[senderPstId]]
  socialModule:PushCurStoreMaxMsgId(senderPstId, chatData:GetId())
end

function ChatDataManager:_RemoveChatData(friendId)
  if not self._chatDatas[friendId] then
    return
  end
  local chatCount = #self._chatDatas[friendId]
  local maxCount = Cfg.cfg_friend_global[1].client_save_max_msg_count
  if chatCount <= maxCount then
    return false
  end
  local moreCount = chatCount - maxCount
  for i = moreCount, 1, -1 do
    table.remove(self._chatDatas[friendId], i)
  end
  return true
end

function ChatDataManager:GetAllChatDatas(TT, friendList)
  self._chatDatas = {}
  self:_ReadLocalChatDatas(friendList)
  self:_ReadServerChatDatas(TT)
end

function ChatDataManager:_ReadLocalChatDatas(friendList)
  local chatDataKey = self:_GetChatDataKey()
  local localChatDatasStr = UnityEngine.PlayerPrefs.GetString(chatDataKey)
  if not localChatDatasStr or localChatDatasStr == "" then
    return
  end
  local func = load("return" .. localChatDatasStr)
  if func == nil then
    localChatDatasStr = string.gsub(localChatDatasStr, "\\", "\\\\")
    localChatDatasStr = string.gsub(localChatDatasStr, "\r\n", "")
    func = load("return" .. localChatDatasStr)
  end
  local chatDataTable = {}
  if func ~= nil then
    chatDataTable = func()
  end
  
  local function isContainFriendIdFunc(friendDatas, friendId)
    if not friendDatas then
      return false
    end
    for k, v in pairs(friendDatas) do
      if friendId == v:GetFriendId() then
        return true
      end
    end
    return false
  end
  
  for friendId, chatDatas in pairs(chatDataTable) do
    if isContainFriendIdFunc(friendList, friendId) then
      if self._chatDatas[friendId] == nil then
        self._chatDatas[friendId] = {}
      end
      for i = 1, #chatDatas do
        local data = chatDatas[i]
        local chatData = ChatData:New(data._id, data._messageType, data._message, data._emojiId, data._isSelf, data._date)
        self._chatDatas[friendId][#self._chatDatas[friendId] + 1] = chatData
      end
    end
  end
  self:_RefreshChatDataTimeStatus()
end

function ChatDataManager:_RefreshChatDataTimeStatus()
  for friendId, chatDatas in pairs(self._chatDatas) do
    local firstData
    for i = 1, #chatDatas do
      local chatData = chatDatas[i]
      if i == 1 then
        chatData:SetShowTimeStatus(true)
        firstData = chatData
      else
        local preChatData = chatDatas[i - 1]
        local isSameDay = SameDay(preChatData:GetDate(), chatData:GetDate())
        if isSameDay then
          local preDate = _time(firstData:GetDate())
          local curDate = _time(chatData:GetDate())
          local preMin = preDate.min
          local curMin = curDate.min
          local min = (curDate.hour - preDate.hour) * 60 + curMin - preMin
          if 30 <= min then
            chatData:SetShowTimeStatus(true)
            firstData = chatData
          else
            chatData:SetShowTimeStatus(false)
          end
        else
          chatData:SetShowTimeStatus(true)
          firstData = chatData
        end
      end
    end
  end
end

function ChatDataManager:_ReadServerChatDatas(TT)
end

function ChatDataManager:SaveAllChatDatas()
  local chatDataKey = self:_GetChatDataKey()
  if not self._chatDatas or table.count(self._chatDatas) <= 0 then
    UnityEngine.PlayerPrefs.DeleteKey(chatDataKey)
    return
  end
  for k, v in pairs(self._chatDatas) do
    for i = 1, #v do
      v[i]:EncodeMessage()
    end
  end
  local chatDatasStr = echo_not_escape(self._chatDatas)
  for k, v in pairs(self._chatDatas) do
    for i = 1, #v do
      v[i]:DecodeMessage()
    end
  end
  UnityEngine.PlayerPrefs.SetString(chatDataKey, chatDatasStr)
end

function ChatDataManager:_GetChatDataKey()
  if self._chatDataKey then
    return self._chatDataKey
  end
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local chatDataKey = "CHAT_DATA_KEY_1VERSION" .. pstId
  self._chatDataKey = chatDataKey
  return chatDataKey
end
