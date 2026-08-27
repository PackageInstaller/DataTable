local UINChatGroupItemBase = require("Game.ChatSystem.UI.ChatGroupItem.UINChatGroupItemBase")
local UINChatGroupItemFriendChat = class("UINChatGroupItemFriendChat", UINChatGroupItemBase)
local base = UINChatGroupItemBase
local ChatSystemEnum = require("Game.ChatSystem.ChatSystemEnum")

function UINChatGroupItemFriendChat:OnInit()
  base.OnInit(self)
  self.__onRecycleEntryItemCallback = BindCallback(self, self.OnRecycleEntryItem)
end

function UINChatGroupItemFriendChat:InitChatGroupItem(pageId, pageMsg, resloader, startState, onClickPageCallback, onOpenGroupItemCallback, onClickChatEntryCallback, onClickChatEntryImageCallback)
  base.InitChatGroupItem(self, pageId, pageMsg, resloader, startState, onClickPageCallback, onOpenGroupItemCallback, onClickChatEntryCallback, onClickChatEntryImageCallback)
  local friendDataList = PlayerDataCenter.friendDataCenter:GetFreindList()
  local onlineNum = 0
  for _, friendData in ipairs(friendDataList) do
    if friendData:GetOnlineState() == 0 then
      onlineNum = onlineNum + 1
    end
  end
  self.ui.tex_MemberNum:SetIndex(0, tostring(onlineNum), tostring(#friendDataList))
end

function UINChatGroupItemFriendChat:GetNewChatEntryItem(index)
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  local friendData = PlayerDataCenter.friendDataCenter:GetFreindList()[index]
  local chatBoard = userChatData:GetChatBoard(ChatSystemEnum.EChatChannel.Friend, friendData:GetUserUID())
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
    friendEntryItem:InitChatBoardEntryFriend(chatBoard, userInfoData, self.resloader, self.onClickChatEntryCallback, false, isSelecting, self.onClickChatEntryImageCallback)
  end)
  return friendEntryItem
end

function UINChatGroupItemFriendChat:RefreshGroupItemRedDot()
  self.ui.blueDot_Page:SetActive(false)
end

function UINChatGroupItemFriendChat:GetChatEntryCount()
  return #PlayerDataCenter.friendDataCenter:GetFreindList()
end

function UINChatGroupItemFriendChat:OnRecycleEntryItem(entryItem)
  if self.recycleChatEntryItemCallback == nil then
    DestroyUnityObject(entryItem.gameObject)
    return
  end
  self.recycleChatEntryItemCallback(self.pageId, entryItem)
end

return UINChatGroupItemFriendChat
