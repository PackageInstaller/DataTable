local UINChatGroupItemBase = require("Game.ChatSystem.UI.ChatGroupItem.UINChatGroupItemBase")
local UINChatGroupItemRecentChat = class("UINChatGroupItemRecentChat", UINChatGroupItemBase)
local base = UINChatGroupItemBase

function UINChatGroupItemRecentChat:OnInit()
  base.OnInit(self)
  self.__onRecycleEntryItemCallback = BindCallback(self, self.OnRecycleEntryItem)
end

function UINChatGroupItemRecentChat:InitChatGroupItem(pageId, pageMsg, resloader, startState, onClickPageCallback, onOpenGroupItemCallback, onClickChatEntryCallback, onClickChatEntryImageCallback)
  base.InitChatGroupItem(self, pageId, pageMsg, resloader, startState, onClickPageCallback, onOpenGroupItemCallback, onClickChatEntryCallback, onClickChatEntryImageCallback)
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  local chatRecentMsgs = userChatData:GetChatRecents()
  local onlineNum = 0
  for _, chatRecentMsg in ipairs(chatRecentMsgs) do
    local friendData = PlayerDataCenter.friendDataCenter:TryGetFriendData(chatRecentMsg.chatId)
    if friendData ~= nil and friendData:GetOnlineState() == 0 then
      onlineNum = onlineNum + 1
    end
  end
  self.ui.tex_MemberNum:SetIndex(0, tostring(onlineNum), tostring(#chatRecentMsgs))
end

function UINChatGroupItemRecentChat:GetNewChatEntryItem(index)
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  local chatRecentMsg = userChatData:GetChatRecents()[index]
  local chatBoard = userChatData:GetChatBoard(chatRecentMsg.chatTpe, chatRecentMsg.chatId)
  if self.getChatEntryItemCallback == nil then
    return
  end
  local friendEntryItem = self.getChatEntryItemCallback(self.pageId)
  if friendEntryItem == nil then
    return
  end
  friendEntryItem:SetRecycleCallback(self.__onRecycleEntryItemCallback)
  friendEntryItem:Hide()
  PlayerDataCenter:GetUserInfoByUID(chatBoard:GetChatBoardId(), function(userInfoData)
    if IsNull(self.transform) then
      return
    end
    friendEntryItem:Show()
    local chatWin = UIManager:GetWindow(UIWindowTypeID.ChatSystem)
    local isSelecting = chatWin ~= nil and chatWin:GetChatSystemPrefChatBoard() == chatBoard
    friendEntryItem:InitChatBoardEntryFriend(chatBoard, userInfoData, self.resloader, self.onClickChatEntryCallback, true, isSelecting, self.onClickChatEntryImageCallback)
  end)
  return friendEntryItem
end

function UINChatGroupItemRecentChat:RefreshGroupItemRedDot()
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  self.ui.blueDot_Page:SetActive(false)
  for _, chatRecentMsg in ipairs(userChatData:GetChatRecents()) do
    local chatBoard = userChatData:GetChatBoard(chatRecentMsg.chatTpe, chatRecentMsg.chatId)
    if chatBoard:GetNewChatNum() > 0 then
      self.ui.blueDot_Page:SetActive(true)
      break
    end
  end
end

function UINChatGroupItemRecentChat:GetChatEntryCount()
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  return #userChatData:GetChatRecents()
end

function UINChatGroupItemRecentChat:OnRecycleEntryItem(entryItem)
  if self.recycleChatEntryItemCallback == nil then
    DestroyUnityObject(entryItem.gameObject)
    return
  end
  self.recycleChatEntryItemCallback(self.pageId, entryItem)
end

return UINChatGroupItemRecentChat
