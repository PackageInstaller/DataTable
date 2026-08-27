local UIChatSystemMain = class("UIChatSystemMain", UIBaseWindow)
local base = UIBaseWindow
local UINChatSystemChatBoardNode = require("Game.ChatSystem.UI.UINChatSystemChatBoardNode")
local CSLayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local ChatSystemEnum = require("Game.ChatSystem.ChatSystemEnum")
local UINChatGroupItemFriendChat = require("Game.ChatSystem.UI.ChatGroupItem.UINChatGroupItemFriendChat")
local UINChatGroupItemRecentChat = require("Game.ChatSystem.UI.ChatGroupItem.UINChatGroupItemRecentChat")
local UINChatScrollItem = require("Game.ChatSystem.UI.UINChatScrollItem")
local UINUserInfoNode = require("Game.User.UINUserInfoNode")
local eFriendEnum = require("Game.Friend.eFriendEnum")
local eFriendUIState = eFriendEnum.eFriendUIState
local UINChatBoardEntryFriend = require("Game.ChatSystem.UI.ChatBoardEntry.UINChatBoardEntryFriend")

function UIChatSystemMain:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):PushTopStatusDataToBackStack()
  local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWindow ~= nil then
    homeWindow:OpenOtherCoverWin()
    self:SetFromWhichUI(eBaseWinFromWhere.homeCorver)
  end
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_BackGround, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_UserInfoBackground, self, self.OnClickUserInfoBackGround)
  self.resloader = CS.ResLoader.Create()
  self.chatBoardNode = UINChatSystemChatBoardNode.New()
  self.chatBoardNode:Init(self.ui.obj_ChatBoard)
  self.userInfoNode = UINUserInfoNode.New()
  self.userInfoNode:Init(self.ui.obj_uINUserInfoNode)
  self.ChatEntryFriendPool = UIItemPool.New(UINChatBoardEntryFriend, self.ui.obj_FriendItem, false)
  self.__onCloseAllGroupItemCallback = BindCallback(self, self.OnCloseAllGroupItem)
  self.__onOpenGroupItemCallback = BindCallback(self, self.OnOpenGroupItem)
  self.__onClickChatEntryCallback = BindCallback(self, self.OnClickChatEntry)
  self.__onRecycleGroupItemCallback = BindCallback(self, self.OnRecycleGroupItem)
  self.__onGetChatEntryItemCallback = BindCallback(self, self.GetNewChatEntryItem)
  self.__onRecycleChatEntryItemCallback = BindCallback(self, self.RecycleNewChatEntryItem)
  self.__onClickChatEntryImageCallback = BindCallback(self, self.OnClickChatEntryImage)
  self.__onChatSystemBanChangeCallback = BindCallback(self, self.OnChatSystemBanChange)
  self.chatGroupItemRecentPool = UIItemPool.New(UINChatGroupItemRecentChat, self.ui.obj_ChatGroupItem, false)
  self.chatGroupItemFriendPool = UIItemPool.New(UINChatGroupItemFriendChat, self.ui.obj_ChatGroupItem, false)
  self.scrollItemDic = {}
  self.ui.loop_scroll.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.loop_scroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.loop_scroll.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.__OnGetNewChatMsg = BindCallback(self, self.OnGetNewChatMsg)
  MsgCenter:AddListener(eMsgEventId.OnNewChatMsgCome, self.__OnGetNewChatMsg)
  self.__OnRefreshFriendState = BindCallback(self, self.RefreshFriendState)
  self.__OnGroupItemsUpdate = BindCallback(self, self.OnGroupItemsUpdate)
  MsgCenter:AddListener(eMsgEventId.OnChatBoardNewMsgNumChange, self.__OnGroupItemsUpdate)
  self.__UpdateChatSystemUI = BindCallback(self, self.UpdateChatSystemUI)
  MsgCenter:AddListener(eMsgEventId.OnUserFriendListChange, self.__UpdateChatSystemUI)
  MsgCenter:AddListener(eMsgEventId.OnChatSystemBanChange, self.__onChatSystemBanChangeCallback)
end

function UIChatSystemMain:InitChatSystem(startOpenPageId, chatBoard)
  self:RefreshFriendState()
  TimerManager:StopTimer(self._friendStateTimer)
  self._friendStateTimer = TimerManager:StartTimer(15, self.__OnRefreshFriendState, self)
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  self.chatBoardNode:Hide()
  self.groupItemDic = {}
  self.chatGroupItemRecentPool:HideAll()
  self.chatGroupItemFriendPool:HideAll()
  local pageIds = userChatData:GetAllChatPage()
  local pageDic = userChatData:GetChatPageDic()
  self.ui.loop_scroll.totalCount = #pageIds
  self.ui.loop_scroll:RefillCells()
  if startOpenPageId == nil then
    if #userChatData:GetChatRecents() > 0 then
      startOpenPageId = ChatSystemEnum.EChatChannel.Recent
    elseif 0 < PlayerDataCenter.friendDataCenter:GetFreindNum() then
      startOpenPageId = ChatSystemEnum.EChatChannel.Friend
    end
  end
  if startOpenPageId ~= nil then
    self:OnOpenGroupItem(startOpenPageId)
  end
  if chatBoard ~= nil then
    self:OnClickChatEntry(chatBoard)
  end
end

function UIChatSystemMain:RefreshFriendState()
  if PlayerDataCenter.friendDataCenter:IsExpireFriendData() then
    local friendNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
    friendNetCtrl:CS_FRIEND_RefreshFriend()
  end
end

function UIChatSystemMain:OnGroupItemsUpdate()
  self.ui.loop_scroll:RefreshCells()
end

function UIChatSystemMain:UpdateChatSystemUI()
  self:OnGroupItemsUpdate()
  local currentChatBoard, isActive = self.chatBoardNode:GetCurrentChatBoard()
  if isActive and currentChatBoard:GetChatBoardType() == ChatSystemEnum.EChatChannel.Friend then
    if PlayerDataCenter.friendDataCenter:TryGetFriendData(currentChatBoard:GetChatBoardId()) == nil then
      self.chatBoardNode:OnClickClose()
    else
      self.chatBoardNode:RefreshLoopScroll()
    end
  end
  local currentUserInfoData = self.userInfoNode.userInfoData
  if currentUserInfoData ~= nil and PlayerDataCenter.friendDataCenter:TryGetFriendData(currentUserInfoData:GetUserUID()) == nil then
    self:OnClickUserInfoBackGround()
  else
    self.userInfoNode:UpdateInfoNode()
  end
end

function UIChatSystemMain:OnGetNewChatMsg(chatRecvMsg, removeNum, isSendBySelf)
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  local msgChatBoard = userChatData:GetChatBoard(userChatData:GetMsgTypeId(chatRecvMsg))
  local currentChatBoard, isActive = self.chatBoardNode:GetCurrentChatBoard()
  if not isActive or currentChatBoard ~= msgChatBoard then
    return
  end
  self.chatBoardNode:OnNewChatMsgComes(removeNum, isSendBySelf)
end

function UIChatSystemMain:OnCloseAllGroupItem()
  self.prefPageId = nil
  self.prefChatBoard = nil
  UIUtil.ReturnUntil2Marker(UIWindowTypeID.ChatSystem, false)
  for _, groupItem in pairs(self.groupItemDic) do
    groupItem:ChangeChatGroupPageState(false)
  end
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  local pageIds = userChatData:GetAllChatPage()
  self.ui.loop_scroll.totalCount = #pageIds
  self.ui.loop_scroll:RefillCells()
end

function UIChatSystemMain:OnOpenGroupItem(groupItemPageId)
  self.prefPageId = groupItemPageId
  local groupItem = self.groupItemDic[groupItemPageId]
  groupItem:ChangeChatGroupPageState(true)
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  local pageIds = userChatData:GetAllChatPage()
  self.ui.loop_scroll.totalCount = #pageIds + groupItem:GetChatEntryCount()
  self.ui.loop_scroll:RefillCells()
end

function UIChatSystemMain:OnClickChatEntry(chatBoard)
  self.prefChatBoard = chatBoard
  local currentChatBoard, isActive = self.chatBoardNode:GetCurrentChatBoard()
  if isActive and currentChatBoard == chatBoard then
    return
  end
  self.chatBoardNode:InitChatBoardNode(chatBoard, self.__onClickChatEntryImageCallback)
end

function UIChatSystemMain:OnClickChatEntryImage(uid)
  PlayerDataCenter:GetUserInfoByUID(uid, function(userInfoData)
    self.userInfoNode:Show()
    self.userInfoNode:RefershInfoNode(userInfoData, nil, self.resloader, false, eFriendUIState.chat)
    self.ui.btn_UserInfoBackground.gameObject:SetActive(true)
  end)
end

function UIChatSystemMain:OnClickUserInfoBackGround()
  self.userInfoNode:Hide()
  self.ui.btn_UserInfoBackground.gameObject:SetActive(false)
end

function UIChatSystemMain:OnRecycleGroupItem(groupItem)
  if groupItem.pageId == ChatSystemEnum.EChatChannel.Recent then
    self.chatGroupItemRecentPool:HideOne(groupItem)
    groupItem.transform:SetParent(self.ui.obj_ChatGroupItemHolder.transform, false)
  elseif groupItem.pageId == ChatSystemEnum.EChatChannel.Friend then
    self.chatGroupItemFriendPool:HideOne(groupItem)
    groupItem.transform:SetParent(self.ui.obj_ChatGroupItemHolder.transform, false)
  end
end

function UIChatSystemMain:GetNewChatEntryItem(pageId)
  if pageId == ChatSystemEnum.EChatChannel.Recent or pageId == ChatSystemEnum.EChatChannel.Friend then
    local friendItem = self.ChatEntryFriendPool:GetOne()
    return friendItem
  end
end

function UIChatSystemMain:RecycleNewChatEntryItem(pageId, entryItem)
  if pageId == ChatSystemEnum.EChatChannel.Recent or pageId == ChatSystemEnum.EChatChannel.Friend then
    self.ChatEntryFriendPool:HideOne(entryItem)
    entryItem.transform:SetParent(self.ui.obj_FriendChatEntryItemHolder.transform, false)
  end
end

function UIChatSystemMain:GetChatSystemPrefPageId()
  return self.prefPageId
end

function UIChatSystemMain:GetChatSystemPrefChatBoard()
  return self.prefChatBoard
end

function UIChatSystemMain:__OnNewItem(go)
  local scrollItem = UINChatScrollItem.New()
  scrollItem:Init(go)
  self.scrollItemDic[go] = scrollItem
end

function UIChatSystemMain:__GetGroupItem(index)
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  local pageIds = userChatData:GetAllChatPage()
  local pageId = pageIds[index + 1]
  local pageDic = userChatData:GetChatPageDic()
  local pageMsg = pageDic[pageId]
  local groupItem
  if pageId == ChatSystemEnum.EChatChannel.Recent then
    groupItem = self.chatGroupItemRecentPool:GetOne()
  elseif pageId == ChatSystemEnum.EChatChannel.Friend then
    groupItem = self.chatGroupItemFriendPool:GetOne()
  end
  if groupItem == nil then
    return
  end
  local startIsOpen = self.prefPageId ~= nil and self.prefPageId == pageId
  groupItem:InitChatGroupItem(pageId, pageMsg, self.resloader, startIsOpen, self.__onCloseAllGroupItemCallback, self.__onOpenGroupItemCallback, self.__onClickChatEntryCallback, self.__onClickChatEntryImageCallback)
  groupItem:SetRecycleCallback(self.__onRecycleGroupItemCallback)
  groupItem:SetEntryItemCallback(self.__onGetChatEntryItemCallback, self.__onRecycleChatEntryItemCallback)
  self.groupItemDic[pageId] = groupItem
  return self.groupItemDic[pageId]
end

function UIChatSystemMain:__OnChangeItem(go, index)
  local scrollItem = self.scrollItemDic[go]
  if scrollItem == nil then
    error("Can't find scrollItem by gameObject")
    return
  end
  local prefGroupItem = self.groupItemDic[self.prefPageId]
  if prefGroupItem ~= nil then
    local entryCount = prefGroupItem:GetChatEntryCount()
    local indexInGroup = index + 1 - prefGroupItem.pageId
    local indexInPage = entryCount < indexInGroup and index - entryCount or index
    if indexInGroup < 1 or entryCount < indexInGroup then
      local groupItem = self:__GetGroupItem(indexInPage)
      scrollItem:InitChatScrollItem(groupItem, true, index)
    else
      scrollItem:InitChatScrollItem(prefGroupItem, false, index, prefGroupItem.pageId)
    end
  else
    local groupItem = self:__GetGroupItem(index)
    scrollItem:InitChatScrollItem(groupItem, true, index)
  end
  CSLayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.loop_scroll.transform)
end

function UIChatSystemMain:__OnReturnItem(go)
  local scrollItem = self.scrollItemDic[go]
  if scrollItem == nil then
    error("Can't find scrollItem by gameObject")
    return
  end
  scrollItem:OnRecycleChatScrollItem()
end

function UIChatSystemMain:OnChatSystemBanChange(isBan)
  if isBan then
    self:OnClickClose()
  end
end

function UIChatSystemMain:OnClickClose()
  UIUtil.ReturnUntil2Marker(UIWindowTypeID.ChatSystem, true)
end

function UIChatSystemMain:_BackAction()
  self:OnCloseWin()
  if self.chatBoardNode ~= nil then
    self.chatBoardNode:Delete()
    self.chatBoardNode = nil
  end
  if self.userInfoNode ~= nil then
    self.userInfoNode:Delete()
    self.userInfoNode = nil
  end
  self:Delete()
end

function UIChatSystemMain:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  TimerManager:StopTimer(self._friendStateTimer)
  MsgCenter:RemoveListener(eMsgEventId.OnNewChatMsgCome, self.__OnGetNewChatMsg)
  MsgCenter:RemoveListener(eMsgEventId.OnChatBoardNewMsgNumChange, self.__OnGroupItemsUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnUserFriendListChange, self.__UpdateChatSystemUI)
  MsgCenter:RemoveListener(eMsgEventId.OnChatSystemBanChange, self.__onChatSystemBanChangeCallback)
  base.OnDelete(self)
end

return UIChatSystemMain
