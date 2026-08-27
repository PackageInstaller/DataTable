local ChatSystemBoard = class("ChatSystemBoard")

function ChatSystemBoard:ctor()
  self.chatMsgIds = {}
end

function ChatSystemBoard.CreateChatBoard(chatTpe, chatId)
  local chatBoard = ChatSystemBoard.New()
  chatBoard.chatTpe = chatTpe
  chatBoard.chatId = chatId
  chatBoard.newChatMsgNum = 0
  return chatBoard
end

function ChatSystemBoard.CreateChatBoardByMsg(chatBoardData)
  local chatBoard = ChatSystemBoard.New()
  for k, v in pairs(chatBoardData) do
    chatBoard[k] = v
  end
  return chatBoard
end

function ChatSystemBoard:GetChatBoardType()
  return self.chatTpe
end

function ChatSystemBoard:GetChatBoardId()
  return self.chatId
end

function ChatSystemBoard:GetChatMsgAtIndex(index)
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  if index <= 0 or index > #self.chatMsgIds then
    return nil
  end
  return userChatData:GetChatMsg(self.chatMsgIds[index])
end

function ChatSystemBoard:GetCurMsgCount()
  return #self.chatMsgIds
end

function ChatSystemBoard:GetLatestChatMsg()
  local indexInChatBoard = self:GetCurMsgCount()
  return self:GetChatMsgAtIndex(indexInChatBoard)
end

function ChatSystemBoard:GetNewChatNum()
  return self.newChatMsgNum
end

function ChatSystemBoard:AddChatMsgId(chatMsgId)
  local targetIndex = #self.chatMsgIds + 1
  for iMsgId = #self.chatMsgIds, 0, -1 do
    local tempIndex = self.chatMsgIds[iMsgId]
    if tempIndex == nil or chatMsgId > tempIndex then
      targetIndex = iMsgId + 1
      break
    end
  end
  table.insert(self.chatMsgIds, targetIndex, chatMsgId)
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  local chatMsg = userChatData:GetChatMsg(chatMsgId)
  if not userChatData:IsChatMsgSendBySelf(chatMsg) then
    self:ChangeNewChaMsgNum(1)
  end
end

function ChatSystemBoard:ChangeChatMsgId(chatMsgId, newId)
  for iMsgId = #self.chatMsgIds, 1, -1 do
    local tempIndex = self.chatMsgIds[iMsgId]
    if chatMsgId > tempIndex then
      return false
    end
    if tempIndex == chatMsgId then
      self.chatMsgIds[iMsgId] = newId or chatMsgId + 1
      return true
    end
  end
  return false
end

function ChatSystemBoard:RemoveChatMsgId(chatMsgId)
  if self.chatMsgIds[1] == chatMsgId then
    table.remove(self.chatMsgIds, 1)
    if self.newChatMsgNum > #self.chatMsgIds then
      self:ChangeNewChaMsgNum(#self.chatMsgIds - self.newChatMsgNum)
    end
    return true
  end
  return false
end

function ChatSystemBoard:ChangeNewChaMsgNum(offset)
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  self.newChatMsgNum = self.newChatMsgNum + offset
  MsgCenter:Broadcast(eMsgEventId.OnChatBoardNewMsgNumChange, self)
  userChatData:SetUserChatDataDirty()
end

function ChatSystemBoard:CleanNewChatNum()
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  self.newChatMsgNum = 0
  MsgCenter:Broadcast(eMsgEventId.OnChatBoardNewMsgNumChange, self)
  userChatData:SetUserChatDataDirty()
end

return ChatSystemBoard
