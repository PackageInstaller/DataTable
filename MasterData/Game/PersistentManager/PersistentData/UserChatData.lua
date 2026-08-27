local PersistentDataBase = require("Game.PersistentManager.PersistentData.PersistentDataBase")
local UserChatData = class("UserChatData", PersistentDataBase)
local base = PersistentDataBase
local FormationUtil = require("Game.Formation.FormationUtil")
local ChatSystemBoard = require("Game.ChatSystem.Data.ChatSystemBoard")
local ChatSystemEnum = require("Game.ChatSystem.ChatSystemEnum")

function UserChatData:GetSaveDataFilePath()
  return PathConsts:GetPersistentUserChatDataPath(PlayerDataCenter.strPlayerId)
end

function UserChatData:InitBySaveData(table)
  self.chatMsgsOffsetIndex = table.chatMsgsOffsetIndex or 0
  self.chatMsgs = table.chatMsgs or {}
  self.tempChatMsgs = table.tempChatMsgs or {}
  self:__InitChatPageDicByMsg(table.chatPageDic)
  self.recentEmojis = table.recentEmojis or {}
  self.addedToRecentEmojiDic = {}
  for _, emojiId in ipairs(self.recentEmojis) do
    self.addedToRecentEmojiDic[emojiId] = true
  end
  self.chatRecents = table.chatRecents or {}
  self.recentChatBoardDic = {}
  for _, chatRecentMsg in pairs(self.chatRecents) do
    if not self.recentChatBoardDic[chatRecentMsg.chatTpe] then
      self.recentChatBoardDic[chatRecentMsg.chatTpe] = {}
    end
    self.recentChatBoardDic[chatRecentMsg.chatTpe][chatRecentMsg.chatId] = true
  end
end

function UserChatData:InitByDefaultData()
  self.chatMsgsOffsetIndex = 0
  self.chatMsgs = {}
  self.tempChatMsgs = {}
  self:__InitChatPageDicByMsg()
  self.recentEmojis = {}
  self.addedToRecentEmojiDic = {}
  self.chatRecents = {}
  self.recentChatBoardDic = {}
end

function UserChatData:__InitChatPageDicByMsg(msgChatPageDic)
  msgChatPageDic = msgChatPageDic or table.emptytable
  self.chatPageDic = {}
  self.chatPageIds = {}
  for pageId, pageCfg in pairs(ConfigData.new_chat_type) do
    table.insert(self.chatPageIds, pageId)
    self.chatPageDic[pageId] = {
      chatBoardDic = {}
    }
    local pageMsg = msgChatPageDic[pageId]
    if pageMsg ~= nil and pageId ~= ChatSystemEnum.EChatChannel.Recent then
      for chatBoardId, chatBoardMsg in pairs(pageMsg.chatBoardDic) do
        self.chatPageDic[pageId].chatBoardDic[chatBoardId] = ChatSystemBoard.CreateChatBoardByMsg(chatBoardMsg)
      end
    end
  end
  table.sort(self.chatPageIds)
end

function UserChatData:GetChatRecents()
  if self.toRemoveIdInRecentDicList == nil then
    self.toRemoveIdInRecentDicList = {}
  else
    table.removeall(self.toRemoveIdInRecentDicList)
  end
  for index = #self.chatRecents, 1, -1 do
    local chatRecentMsg = self.chatRecents[index]
    if chatRecentMsg.chatTpe == ChatSystemEnum.EChatChannel.Friend and PlayerDataCenter.friendDataCenter:TryGetFriendData(chatRecentMsg.chatId) == nil then
      table.remove(self.chatRecents, index)
      table.insert(self.toRemoveIdInRecentDicList, chatRecentMsg.chatId)
    end
  end
  for _, chatBoardId in ipairs(self.toRemoveIdInRecentDicList) do
    self.recentChatBoardDic[ChatSystemEnum.EChatChannel.Friend][chatBoardId] = nil
  end
  return self.chatRecents
end

function UserChatData:GetAllChatPage()
  return self.chatPageIds
end

function UserChatData:GetChatPageDic()
  return self.chatPageDic
end

function UserChatData:GetChatBoard(chatTpe, chatId)
  if chatTpe == nil or chatId == nil then
    error("get chat board fail, chatTarget is nil !")
    return
  end
  local chatBoard = self.chatPageDic[chatTpe].chatBoardDic[chatId]
  if chatBoard == nil then
    chatBoard = ChatSystemBoard.CreateChatBoard(chatTpe, chatId)
    self.chatPageDic[chatTpe].chatBoardDic[chatId] = chatBoard
  end
  return chatBoard
end

function UserChatData:GetChatMsg(index)
  local msg = self.chatMsgs[index - self.chatMsgsOffsetIndex]
  return msg
end

function UserChatData:IsChatMsgSendBySelf(chatMsg)
  if PlayerDataCenter.inforData == nil then
    error("Get GetMsgTypeId fail, PlayerDataCenter.inforData == nil!")
    return
  end
  if chatMsg == nil then
    error("get ChatMsg Send By Self Fail, chatMsg == nil!")
    return
  end
  local selfUid = PlayerDataCenter.inforData:GetUserUID()
  return chatMsg.sender.uid == selfUid
end

function UserChatData:GetMsgTypeId(msg)
  if PlayerDataCenter.inforData == nil then
    error("Get GetMsgTypeId fail, PlayerDataCenter.inforData == nil!")
    return
  end
  local selfUid = PlayerDataCenter.inforData:GetUserUID()
  if msg.message.tar.id == selfUid then
    return msg.message.tar.tpe, msg.sender.uid
  end
  return msg.message.tar.tpe, msg.message.tar.id
end

function UserChatData:GetRecentEmojis()
  return self.recentEmojis
end

function UserChatData:SetUserChatDataDirty()
  self:SetPstDataDirty()
  self:DelaySavePstData(1)
end

function UserChatData:AddChatMsg(chatRecvMsg)
  local insertIndex = #self.chatMsgs + 1
  for iChatMsgIndex = #self.chatMsgs, 0, -1 do
    local tempMsg = self.chatMsgs[iChatMsgIndex]
    if tempMsg ~= nil and tempMsg.sendTime > chatRecvMsg.sendTime then
      local tempChatBoard = self:GetChatBoard(self:GetMsgTypeId(tempMsg))
      tempChatBoard:ChangeChatMsgId(iChatMsgIndex + self.chatMsgsOffsetIndex)
    else
      insertIndex = iChatMsgIndex + 1
      break
    end
  end
  table.insert(self.chatMsgs, insertIndex, chatRecvMsg)
  local chatBoard = self:GetChatBoard(self:GetMsgTypeId(chatRecvMsg))
  chatBoard:AddChatMsgId(insertIndex + self.chatMsgsOffsetIndex)
  local userChatCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
  local removeMsgNum = 0
  if #self.chatMsgs > userChatCtrl:GetChatSystemMainCfg().message_num then
    removeMsgNum = 1
    self:RemoveChatMsg()
  end
  local chatBoardTpe = chatBoard:GetChatBoardType()
  local chatBoardId = chatBoard:GetChatBoardId()
  if not self.recentChatBoardDic[chatBoardTpe] or not self.recentChatBoardDic[chatBoardTpe][chatBoardId] then
    local chatRecentMsg = {}
    chatRecentMsg.chatTpe = chatBoard.chatTpe
    chatRecentMsg.chatId = chatBoard.chatId
    table.insert(self.chatRecents, 1, chatRecentMsg)
    if not self.recentChatBoardDic[chatBoardTpe] then
      self.recentChatBoardDic[chatBoardTpe] = {}
    end
    self.recentChatBoardDic[chatBoardTpe][chatBoardId] = true
    local userChatCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
    if #self.chatRecents > userChatCtrl:GetChatSystemMainCfg().recent_max then
      local toRemoveChatRecentMsg = table.remove(self.chatRecents)
      self.recentChatBoardDic[toRemoveChatRecentMsg.chatTpe][toRemoveChatRecentMsg.chatId] = nil
    end
  else
    local prefIndex = 0
    for index, chatRecentMsg in ipairs(self.chatRecents) do
      if chatBoardId == chatRecentMsg.chatId and chatBoardTpe == chatRecentMsg.chatTpe then
        prefIndex = index
        break
      end
    end
    if prefIndex ~= 1 then
      local chatRecentMsg = table.remove(self.chatRecents, prefIndex)
      table.insert(self.chatRecents, 1, chatRecentMsg)
    end
  end
  MsgCenter:Broadcast(eMsgEventId.OnNewChatMsgCome, chatRecvMsg, removeMsgNum, self:IsChatMsgSendBySelf(chatRecvMsg))
  self:SetUserChatDataDirty()
end

function UserChatData:RemoveChatMsg()
  local deletedMsg = table.remove(self.chatMsgs, 1)
  if deletedMsg == nil then
    return
  end
  self.chatMsgsOffsetIndex = self.chatMsgsOffsetIndex + 1
  local chatBoard = self:GetChatBoard(self:GetMsgTypeId(deletedMsg))
  chatBoard:RemoveChatMsgId(self.chatMsgsOffsetIndex)
  self:SetUserChatDataDirty()
end

function UserChatData:TryAddEmojiToRecentEmojis(emojiId)
  if self.addedToRecentEmojiDic[emojiId] then
    local prefIndex = 0
    for index, recentEmojiId in ipairs(self.recentEmojis) do
      if recentEmojiId == emojiId then
        prefIndex = index
        break
      end
    end
    if prefIndex ~= 1 then
      local recentEmojiId = table.remove(self.recentEmojis, prefIndex)
      table.insert(self.recentEmojis, 1, recentEmojiId)
    end
    return
  end
  self.addedToRecentEmojiDic[emojiId] = true
  table.insert(self.recentEmojis, 1, emojiId)
  local userChatCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
  if #self.recentEmojis > userChatCtrl:GetChatSystemMainCfg().often_emoticon_num then
    local removedEmojiId = table.remove(self.recentEmojis)
    self.addedToRecentEmojiDic[removedEmojiId] = nil
  end
  self:SetUserChatDataDirty()
end

return UserChatData
