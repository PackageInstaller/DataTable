_class("QuestChatModule", GameModule)
QuestChatModule = QuestChatModule

function QuestChatModule:Constructor()
  self.m_mapChatData = {}
  self.weChatProxy = WeChatProxy:New(self)
end

function QuestChatModule:Dispose()
  if self.weChatProxy then
    self.weChatProxy:Dispose()
    self.weChatProxy = nil
  end
  self.caller:UnRegisterPushHandler(CEventQuestChat_PushSpeakerData)
  QuestChatModule.super.Dispose(self)
end

function QuestChatModule:Init()
  self.caller:RegisterPushHandler(CEventQuestChat_PushSpeakerData, self.OnRecvMsg_QuestChat, self)
end

function QuestChatModule:Update(deltaTimeMS)
end

function QuestChatModule:GetPetChatState(nSpeakerID, nChatID)
  local chat_data = self:_FindChatData(nSpeakerID, nChatID)
  if chat_data == nil then
    return QuestChatStatus.E_ChatState_NotFind
  end
  return chat_data.m_nStatus
end

function QuestChatModule:FindUnReadCount(nSpeakerID, nChatID)
  local pFindChatData = self:_FindChatData(nSpeakerID, nChatID)
  if nil == pFindChatData then
    return 0
  end
  return self:_StatUnReadCount(pFindChatData)
end

function QuestChatModule:FindActiveChatID(nSpeakerID)
  local pFindSpeaker = self:_FindSpeakerData(nSpeakerID)
  if nil == pFindSpeaker then
    return 0, 0
  end
  local nChatCount = table.count(pFindSpeaker.m_vecChatData)
  for i = 1, nChatCount do
    local chatData = pFindSpeaker.m_vecChatData[i]
    if self:_IsChatWorking(chatData) then
      return chatData.m_nChatID, self:_StatUnReadCount(chatData)
    end
  end
  return 0, 0
end

function QuestChatModule:_StatUnReadCount(chatData)
  local nTalkCount = table.count(chatData.m_vecTalkData)
  local nReturn = 0
  for i = 1, nTalkCount do
    local talkData = chatData.m_vecTalkData[i]
    if false == talkData.m_bReaded then
      nReturn = nReturn + 1
    end
  end
  return nReturn
end

function QuestChatModule:_IsChatWorking(chatData)
  if chatData.m_nStatus > QuestChatStatus.E_ChatState_Ready and chatData.m_nStatus < QuestChatStatus.E_ChatState_Completed then
    return true
  end
  return false
end

function QuestChatModule:_FindSpeakerData(nSpeakerID)
  return self.m_mapChatData[nSpeakerID]
end

function QuestChatModule:_FindChatData(nSpeakerID, nChatID)
  local pSpeakerData = self:_FindSpeakerData(nSpeakerID)
  if nil == pSpeakerData then
    return nil
  end
  return self:_FindChatDataBySpeakerData(pSpeakerData, nChatID)
end

function QuestChatModule:_FindTalkData(nSpeakerID, nChatID, nTalkID)
  local pChatData = self:_FindChatData(nSpeakerID, nChatID)
  if nil == pChatData then
    return nil
  end
  local nTalkCount = table.count(pChatData.m_vecTalkData)
  for i = 1, nTalkCount do
    local talkData = pChatData.m_vecTalkData[i]
    if nTalkID == talkData.m_nTalkID then
      return talkData
    end
  end
  return nil
end

function QuestChatModule:_FindChatDataBySpeakerData(pSpeakerData, nChatID)
  local nChatCount = table.count(pSpeakerData.m_vecChatData)
  for i = 1, nChatCount do
    local chatData = pSpeakerData.m_vecChatData[i]
    if chatData.m_nChatID == nChatID then
      return chatData
    end
  end
  return nil
end

function QuestChatModule:_SaveChatData(pSpeakerData, recvChatData, nDataSource)
  local pChatData_Chat = self:_FindChatDataBySpeakerData(pSpeakerData, recvChatData.m_nChatID)
  if nil == pChatData_Chat then
    table.insert(pSpeakerData.m_vecChatData, recvChatData)
    self.weChatProxy:AddChat(pSpeakerData.m_nSpeakerID, recvChatData, nDataSource)
    Log.debug("[QuestChat] AddChat ChatData, nSpeakerID = ", pSpeakerData.m_nSpeakerID, ", nChatID = ", recvChatData.m_nChatID)
    return
  end
  pChatData_Chat = recvChatData
  self.weChatProxy:UpdateChat(pSpeakerData.m_nSpeakerID, recvChatData, nDataSource)
  Log.debug("[QuestChat] UpdateChat ChatData, nSpeakerID = ", pSpeakerData.m_nSpeakerID, ", nChatID = ", recvChatData.m_nChatID)
end

function QuestChatModule:_SaveSpeakerData(recvSpeakerData, nDataSource)
  if self.weChatProxy == nil then
    return
  end
  local nSpeakerID = recvSpeakerData.m_nSpeakerID
  local pSpeakerData = self:_FindSpeakerData(nSpeakerID)
  if nil == pSpeakerData then
    local inner = false
    for key, value in pairs(recvSpeakerData.m_vecChatData) do
      local chatid = value.m_nChatID
      if Cfg.cfg_quest_chat[chatid] then
        inner = true
        break
      end
    end
    if inner then
      pSpeakerData = table.cloneconf(recvSpeakerData)
      self.m_mapChatData[nSpeakerID] = pSpeakerData
      if self:_IsChatWorking(recvSpeakerData.m_randomChat) then
        self:_SaveChatData(pSpeakerData, recvSpeakerData.m_randomChat, nDataSource)
      end
      pSpeakerData.m_randomChat = nil
      if nDataSource == 1 then
        for i = #recvSpeakerData.m_vecChatData, 1, -1 do
          if recvSpeakerData.m_vecChatData[i].m_nStatus < 2 then
            table.remove(recvSpeakerData.m_vecChatData, i)
          end
        end
      end
      self.weChatProxy:UpdateRole(nSpeakerID, recvSpeakerData)
    end
    return
  end
  if nDataSource == 1 then
    for i = #recvSpeakerData.m_vecChatData, 1, -1 do
      if recvSpeakerData.m_vecChatData[i].m_nStatus < 2 then
        table.remove(recvSpeakerData.m_vecChatData, i)
      end
    end
  end
  local nChatCount = table.count(recvSpeakerData.m_vecChatData)
  for i = 1, nChatCount do
    local chatData = recvSpeakerData.m_vecChatData[i]
    self:_SaveChatData(pSpeakerData, chatData, nDataSource)
  end
end

function QuestChatModule:_Request_Packet(TT, packetRequest)
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, packetRequest)
  if reply.res ~= CallResultType.Normal then
    if reply.msg then
      res:SetResult(reply.msg.m_nResult)
    else
      res:SetResult(EnumErrorCode_QuestChat.E_Error_QuestChat_Fail)
    end
    return res, nil
  end
  res:SetSucc(true)
  return res, reply.msg
end

function QuestChatModule:Request_GetActiveChat(TT)
  return self:Request_GetActiveChatBySpeakerID(TT, 0)
end

function QuestChatModule:Request_GetActiveChatBySpeakerID(TT, nSpeakerID)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventQuestChat_GetActiveReq)
  request.m_nSpeakerID = nSpeakerID
  local res, replyMsg = self:_Request_Packet(TT, request)
  if replyMsg then
    local recvPacket = replyMsg
    for key, value in pairs(recvPacket.m_mapQuestChatData) do
      self:_SaveSpeakerData(value, 0)
    end
  end
  return res
end

function QuestChatModule:Request_SpeakerHistory(TT, nSpeakerID)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventQuestChat_SpeakerHistoryReq)
  request.m_nSpeakerID = nSpeakerID
  request.m_nChatID = 0
  local res, replyMsg = self:_Request_Packet(TT, request)
  if replyMsg then
    local recvPacket = replyMsg
    self:_SaveSpeakerData(recvPacket.m_speakerChatData, 1)
  end
  return res
end

function QuestChatModule:Request_AllHistory(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventQuestChat_AllHistoryReq)
  request.m_nSpeakerID = 0
  local res, replyMsg = self:_Request_Packet(TT, request)
  if replyMsg then
    local recvPacket = replyMsg
    for key, value in pairs(recvPacket.m_mapQuestChatData) do
      self:_SaveSpeakerData(value, 0)
    end
  end
  return res
end

function QuestChatModule:Request_UpdateChatAnswer(TT, nSpeakerID, nChatID, nQuestionID, nAnswerID)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventQuestChat_UpdateChatAnswerReq)
  request.m_nSpeakerID = nSpeakerID
  request.m_nChatID = nChatID
  request.m_nQuestionID = nQuestionID
  request.m_nAnswerID = nAnswerID
  local res, replyMsg = self:_Request_Packet(TT, request)
  if replyMsg then
    local recvPacket = replyMsg
    if recvPacket.m_nResult == EnumErrorCode_QuestChat.E_Error_QuestChat_Succ then
      local pFindChatData = self:_FindChatData(recvPacket.m_nSpeakerID, recvPacket.m_nChatID)
      if pFindChatData then
        local talkAnswer = DQuestChatData_Talk:New()
        talkAnswer.m_nTalkID = nAnswerID
        talkAnswer.m_bReaded = true
        table.insert(pFindChatData.m_vecTalkData, talkAnswer)
        pFindChatData.m_nStatus = recvPacket.m_nStatus
        self.weChatProxy:AddTalk(recvPacket.m_nSpeakerID, recvPacket.m_nChatID, pFindChatData.m_nStatus, pFindChatData.m_nCount, talkAnswer, false)
        local nRecvCount = table.count(recvPacket.m_vecTalkID)
        if nRecvCount == 0 then
          self.weChatProxy:SetInitState(recvPacket.m_nSpeakerID, true)
        end
        for i = 1, nRecvCount do
          local talkData = DQuestChatData_Talk:New()
          talkData.m_nTalkID = recvPacket.m_vecTalkID[i]
          talkData.m_bReaded = false
          table.insert(pFindChatData.m_vecTalkData, talkData)
          self.weChatProxy:AddTalk(recvPacket.m_nSpeakerID, recvPacket.m_nChatID, pFindChatData.m_nStatus, pFindChatData.m_nCount, talkData, true)
        end
      end
    end
  end
  return res
end

function QuestChatModule:Request_UpdateSpeakerName(TT, nSpeakerID, stSpeakerName)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventQuestChat_UpdateSpeakerNameReq)
  request.m_nSpeakerID = nSpeakerID
  request.m_stSpeakerName = stSpeakerName
  local res, replyMsg = self:_Request_Packet(TT, request)
  if replyMsg then
    local pSpeakerData = self:_FindSpeakerData(nSpeakerID)
    if pSpeakerData then
      pSpeakerData.m_stSpeakerName = stSpeakerName
    else
      Log.debug("[QuestChat] 修改SpeakerName时没有找到对应", nSpeakerID, "的交互信息")
    end
    return res, replyMsg.m_nResult
  end
  return res, EnumErrorCode_QuestChat.E_Error_QuestChat_Fail
end

function QuestChatModule:Request_SetTalkReaded(TT, nSpeakerID, nChatID, nTalkID, triggerIndex)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventQuestChat_SetTalkReadedReq)
  request.m_nSpeakerID = nSpeakerID
  request.m_nChatID = nChatID
  request.m_nTalkID = nTalkID
  local res, replyMsg = self:_Request_Packet(TT, request)
  if replyMsg then
    local recvPacket = replyMsg
    if EnumErrorCode_QuestChat.E_Error_QuestChat_Succ == recvPacket.m_nResult then
      local pTalkData = self:_FindTalkData(nSpeakerID, nChatID, nTalkID)
      if pTalkData then
        pTalkData.m_bReaded = true
        self.weChatProxy:SetTalkReaded(nSpeakerID, nChatID, nTalkID, triggerIndex)
      end
      local pChatData = self:_FindChatData(nSpeakerID, nChatID)
      if pChatData then
        pChatData.m_nStatus = recvPacket.m_nStatus
      end
    end
  end
  res:SetSucc(true)
  return res
end

function QuestChatModule:Request_CompleteChat(TT, nChatID, nStatus)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventQuestChat_CompleteReq)
  request.m_nStatus = nStatus or QuestChatStatus.E_ChatState_Completed
  request.m_nChatID = nChatID
  local res, replyMsg = self:_Request_Packet(TT, request)
  if replyMsg then
    local recvPacket = replyMsg
  end
  res:SetSucc(true)
  return res
end

function QuestChatModule:OnRecvMsg_QuestChat(msg)
  GameGlobal.TaskManager():StartTask(QuestChatModule.HandleQuestChatPushEvent, self, msg)
end

function QuestChatModule:HandleQuestChatPushEvent(TT, msg)
  if self.weChatProxy == nil then
    return
  end
  if self.allHistoryTaskId and TaskHelper:GetInstance():IsTaskFinished(self.allHistoryTaskId) == false then
    YIELD(TT)
    while TaskHelper:GetInstance():IsTaskFinished(self.allHistoryTaskId) == false do
      YIELD(TT)
    end
    self:InitEachSpeaker(TT, msg)
  else
    self.allHistoryTaskId = self.weChatProxy:InitAllLocalSpeaker(msg.m_persistid)
    if self.allHistoryTaskId and TaskHelper:GetInstance():IsTaskFinished(self.allHistoryTaskId) == false then
      while TaskHelper:GetInstance():IsTaskFinished(self.allHistoryTaskId) == false do
        YIELD(TT)
      end
      self.allHistoryTaskId = nil
    else
      self:InitEachSpeaker(TT, msg)
    end
  end
  local isShow = GameGlobal.UIStateManager():IsShow("UIMainLobbyController")
  if isShow then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateWeChatRed)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateWeChatMainTalk)
  end
end

function QuestChatModule:InitEachSpeaker(TT, msg)
  if not self.weChatProxy then
    return
  end
  local waitHistoryTaskId = {}
  for nSpeakerID, speakerData in pairs(msg.m_mapQuestChatData) do
    local taskId = self.weChatProxy:InitLocalSpeaker(nSpeakerID, msg.m_persistid, speakerData)
    if taskId and 0 < taskId then
      while TaskHelper:GetInstance():IsTaskFinished(taskId) == false do
        YIELD(TT)
      end
      table.insert(waitHistoryTaskId, taskId)
    end
  end
  local count = #waitHistoryTaskId
  if 0 < count then
    while not TaskHelper:GetInstance():IsAllTaskFinished(waitHistoryTaskId) do
      YIELD(TT)
    end
  end
  for nSpeakerID, speakerData in pairs(msg.m_mapQuestChatData) do
    self:_SaveSpeakerData(speakerData, 0)
    self.weChatProxy:UpdateRoleName(speakerData.m_nSpeakerID, speakerData.m_stSpeakerName)
  end
end

function QuestChatModule:UI_GetChatSummaryList()
end

function QuestChatModule:UI_GetSpeakerChat(nSpeakerID, nChatID)
end

function QuestChatModule:UI_GetSpeakerHistory(nSpeakerID)
end

function QuestChatModule:UI_IsChatEnd(nChatID)
  local cfgChat = Cfg.cfg_quest_chat[nChatID]
  if nil == cfgChat then
    Log.error("[Quest_Chat] UI_IsChatEnd中发现错误的ChatID = ", nChatID)
    return false
  end
  local nSpeakerID = cfgChat.SpeakerID
  local pFindChatData = self:_FindChatData(nSpeakerID, nChatID)
  if nil == pFindChatData then
    if true == self.weChatProxy:IsChatInHistory(nSpeakerID, nChatID) then
      return true
    end
    Log.info("[Quest_Chat] UI_IsChatEnd中发现错误的ChatID = ", nChatID, ", SpeakerID = ", nSpeakerID)
    return false
  end
  if pFindChatData.m_nStatus < QuestChatStatus.E_ChatState_Completed then
    return false
  end
  if pFindChatData.m_nStatus > QuestChatStatus.E_ChatState_Taken then
    return false
  end
  return true
end

function QuestChatModule:UI_TestDebug()
  local nSpeakerID = 2100106
  local nChatID = 30302
  local nFindTalkID = 30302001
  local listTalkID = {}
  while 0 < nFindTalkID do
    table.insert(listTalkID, nFindTalkID)
    local pFindTalk = Cfg.cfg_quest_talk[nFindTalkID]
    if nil == pFindTalk then
      break
    end
    nFindTalkID = pFindTalk.NextWord
    if nil == nFindTalkID then
      break
    end
  end
  for i = 1, #listTalkID do
    local nTalkID = listTalkID[i]
    TaskManager:GetInstance():StartTask(function(TT)
      self:Request_SetTalkReaded(TT, nSpeakerID, nChatID, nTalkID, i)
    end)
  end
end

function QuestChatModule:UI_StatCompleteTalkInChat(chaitd, talkid)
  local cfg = Cfg.cfg_quest_chat[chaitd]
  if not cfg then
    Log.error("###[QuestChatModule] cfg_quest_chat is nil ! id --> ", chaitd)
    return false
  end
  local speakerid = cfg.SpeakerID
  local role = self.weChatProxy:GetRole(speakerid)
  if role then
    local chats = role.chats
    if chats then
      for i = 1, #chats do
        local chat = chats[i]
        if chat then
          local _chatid = chat.chatId
          if _chatid == chaitd then
            local talks = chat.talks
            if talks then
              for j = 1, #talks do
                local talk = talks[j]
                if talk then
                  local _talkid = talk.talkId
                  if _talkid == talkid then
                    if talk.readed then
                      return true
                    end
                    break
                  end
                end
              end
            end
            break
          end
        end
      end
    end
  end
end

function QuestChatModule:UI_StatCompleteCount(nFindSpeakerID)
  local nCount = 0
  local role = self.weChatProxy.roles
  if role == nil then
    return nCount
  end
  for vid, speakerData in pairs(role) do
    if 0 == nFindSpeakerID or nFindSpeakerID == speakerData.speakerId then
      local chats = speakerData:GetChats()
      for key, value in pairs(chats) do
        if value.state >= QuestChatStatus.E_ChatState_Completed and value.state <= QuestChatStatus.E_ChatState_Taken then
          nCount = nCount + 1
        end
      end
      if 0 ~= nFindSpeakerID then
        break
      end
    end
  end
  return nCount
end

function QuestChatModule:GetErrorMsg(nErrorCode)
  local vecErrorMsg = {
    [EnumErrorCode_QuestChat.E_Error_QuestChat_Succ] = StringTable.Get("str_extra_mission_error_success"),
    [EnumErrorCode_QuestChat.E_Error_QuestChat_Unknown] = StringTable.Get("str_extra_mission_error_fail"),
    [EnumErrorCode_QuestChat.E_Error_QuestChat_SpeakerName] = StringTable.Get("str_guide_ROLE_ERROR_CHANGE_NICK_SPE"),
    [EnumErrorCode_QuestChat.E_Error_QuestChat_SpeakerNameWord] = StringTable.Get("str_guide_ROLE_ERROR_DIRTY_NICK")
  }
  local stErrorMsg = vecErrorMsg[nErrorCode]
  if nil == stErrorMsg then
    return "Unknown ErrorCode"
  end
  return stErrorMsg
end

function QuestChatModule:GetWeChatProxy()
  return self.weChatProxy
end
