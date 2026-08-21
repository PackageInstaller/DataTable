_class("UIChatRecentFriendListPanel", UICustomWidget)
UIChatRecentFriendListPanel = UIChatRecentFriendListPanel

function UIChatRecentFriendListPanel:OnShow(uiParams)
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "FriendList")
  self._chatScrollRect = self:GetUIComponent("ScrollRect", "ChatList")
  self._chatListScrollView = self:GetUIComponent("UIDynamicScrollView", "ChatList")
  self._chatPanel = self:GetGameObject("RightFullAnchor")
  self._friendPanel = self:GetGameObject("LeftStretchAnchor")
  self._noFriendPanel = self:GetGameObject("CenterAnchor")
  self._messageInput = self:GetUIComponent("EmojiFilteredInputField", "MessageInput")
  self._tipsLabel = self:GetUIComponent("UILocalizationText", "TipsCH")
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._emojiPanelGo = self:GetGameObject("EmojiPanel")
  self._emojiListScrollView = self:GetUIComponent("UIDynamicScrollView", "EmojiList")
  self._sendImageOffGo = self:GetGameObject("SendImageOff")
  self._sendImageOnGo = self:GetGameObject("SendImageOn")
  self._newMessageBtn = self:GetGameObject("NewMessageBtn")
  self.__mojiPanelAnim = self:GetUIComponent("Animation", "EmojiPanelAnim")
  self._emojiPanelGo:SetActive(false)
  self._newMessageBtn:SetActive(false)
  self._quickMsgPanel = self:GetGameObject("QuickMsgPanel")
  self._quickMsgPanel:SetActive(false)
  self._quickMsgScrollView = self:GetUIComponent("UIDynamicScrollView", "QuickMsgList")
  self._isInited = false
  self._isSendImageOpen = false
  self._sendImageOffGo:SetActive(not self._isSendImageOpen)
  self._sendImageOnGo:SetActive(self._isSendImageOpen)
  self:AttachEvent(GameEventType.SelectRecentFriend, self._OnFriendSelected)
  self:AttachEvent(GameEventType.ReceiveChatMessage, self._ReceiveChatMessage)
  self:AttachEvent(GameEventType.DeleteFriendUI, self._Refresh)
  self:AttachEvent(GameEventType.UpdateFriendInfo, self._Refresh)
  self:AttachEvent(GameEventType.InModuleFriendNotifyNewMsg, self._Refresh)
  self:AttachEvent(GameEventType.TargetFriendNewMsg, self._ReceiveMessage)
  self:AttachEvent(GameEventType.ChatFriendNotYourFriend, self._ChatFriendNotYourFriend)
  self._inputMessageCache = {}
  self:_HidePanel()
  self._sendMsgMaxLength = 100
  self:AddUIEvent(UIEvent.InputFieldChanged, self._messageInput)
  
  function self._chatListScrollView.mOnDragingAction()
    if self._chatListScrollView:CheckAtLast() then
      self._newMessageBtn:SetActive(false)
    end
  end
  
  self._etl = UICustomUIEventListener.Get(self._messageInput.gameObject)
  self:AddUICustomEventListener(self._etl, UIEvent.Press, function()
    if self._messageInput.touchScreenKeyboard then
      pcall(self.ActiveKeyboard, self, false)
    end
  end)
end

function UIChatRecentFriendListPanel:ActiveKeyboard(active)
  self._messageInput.touchScreenKeyboard.active = active
end

function UIChatRecentFriendListPanel:MessageInputOnValueChanged()
  local s = self._messageInput.text
  if string.isnullorempty(s) then
    if self._currentSelectFiendId then
      self._inputMessageCache[self._currentSelectFiendId] = ""
    end
    return
  end
  local len = #s
  local curIdx = 1
  local asciiCount = 0
  while len >= curIdx do
    local c = string.byte(s, curIdx, curIdx)
    local charSize = self:GetCharSize(c)
    if charSize == 1 then
      if asciiCount + 1 > self._sendMsgMaxLength then
        break
      end
      asciiCount = asciiCount + 1
    elseif 1 < charSize then
      if asciiCount + 2 > self._sendMsgMaxLength then
        break
      end
      asciiCount = asciiCount + 2
    end
    curIdx = curIdx + charSize
  end
  self._messageInput.text = string.sub(s, 1, curIdx - 1)
  if self._currentSelectFiendId then
    self._inputMessageCache[self._currentSelectFiendId] = self._messageInput.text
  end
end

function UIChatRecentFriendListPanel:GetCharSize(char)
  if not char then
    return 0
  elseif 240 < char then
    return 4
  elseif 225 < char then
    return 3
  elseif 192 < char then
    return 2
  else
    return 1
  end
end

function UIChatRecentFriendListPanel:OnHide()
  self:DetachEvent(GameEventType.SelectRecentFriend, self._OnFriendSelected)
  self:DetachEvent(GameEventType.ReceiveChatMessage, self._ReceiveChatMessage)
  self:DetachEvent(GameEventType.DeleteFriendUI, self._Refresh)
  self:DetachEvent(GameEventType.UpdateFriendInfo, self._Refresh)
  self:DetachEvent(GameEventType.InModuleFriendNotifyNewMsg, self._Refresh)
  self:DetachEvent(GameEventType.TargetFriendNewMsg, self._ReceiveMessage)
  self:DetachEvent(GameEventType.ChatFriendNotYourFriend, self._ChatFriendNotYourFriend)
end

function UIChatRecentFriendListPanel:Init(uiChatController)
  if self._isInited == false then
    self._uiChatController = uiChatController
    self._chatFriendManager = self._uiChatController:GetChatFriendManager()
    self._panelType = self._uiChatController:GetCurrentPanelType()
    self._inputMessageCache = self._uiChatController.chatInputCache
    self:_InitEmojiScrollView()
    self:_InitQuickMsgScrollView()
  end
  self:_HidePanel()
  self:_RefreshDatas(function()
    self:_RefreshPanelStatus()
    if self._isInited == false then
      self:_InitScrollView()
      self:_InitChatListScrollView()
    else
      self._scrollView:SetListItemCount(self._friendCount, false)
      self._chatListScrollView:SetListItemCount(self._currentChatDataCount, false)
      self._scrollView:RefreshAllShownItem()
      self._chatListScrollView:RefreshAllShownItem()
      self._chatListScrollView:MovePanelToItemIndex(self._currentChatDataCount, 0)
      self._scrollView:MovePanelToItemIndex(self:GetFriendIndex(self._currentSelectFiendId), 0)
    end
    self:_RefreshChatPanelStatus()
    self._isInited = true
    self:_RefreshInputField(nil, self._currentSelectFiendId)
  end)
  self._canSendMsg = true
  self._newMessageBtn:SetActive(false)
end

function UIChatRecentFriendListPanel:GetFriendIndex(friendId)
  for i = 1, #self._friendList do
    local firendData = self._friendList[i]
    if firendData:GetFriendId() == friendId then
      return i - 1
    end
  end
  return 0
end

function UIChatRecentFriendListPanel:Exist()
  if not self:_IsPanelActive() then
    return
  end
  if self._currentSelectFiendId then
    self._inputMessageCache[self._currentSelectFiendId] = self._messageInput.text
  end
  GameGlobal.TaskManager():StartTask(self._ExistCoro, self)
  if self._resetSendBtnEventHandler then
    GameGlobal.Timer():CancelEvent(self._resetSendBtnEventHandler)
  end
  self._resetSendBtnEventHandler = nil
end

function UIChatRecentFriendListPanel:_ExistCoro(TT)
  self:Lock("_ExistCoro")
  local socialModule = GameGlobal.GetModule(SocialModule)
  socialModule:SelectChatFriend(TT, 0)
  self:UnLock("_ExistCoro")
end

function UIChatRecentFriendListPanel:_HidePanel()
  self._friendPanel:SetActive(false)
  self._noFriendPanel:SetActive(false)
  self._chatPanel:SetActive(false)
end

function UIChatRecentFriendListPanel:_ReceiveMessage(msgList, friendId)
  if not self:_IsPanelActive() then
    return
  end
  if msgList then
    for i = #msgList, 1, -1 do
      local chatMessageinfo = msgList[i]
      local chatData = ChatData:New(chatMessageinfo.msg_id, chatMessageinfo.friend_msg_type, chatMessageinfo.chat_message, chatMessageinfo.emoji_id, false, chatMessageinfo.chat_time)
      self._chatFriendManager:AddChatData(friendId, chatData)
    end
  end
  self:_ReceiveChatMessage(friendId, false)
end

function UIChatRecentFriendListPanel:_Refresh()
  if not self:_IsPanelActive() then
    return
  end
  self:_RefreshDatas(function()
    self._scrollView:SetListItemCount(self._friendCount, false)
    self._chatListScrollView:SetListItemCount(self._currentChatDataCount, false)
    self:_RefreshPanelStatus()
    self:_RefreshChatPanelStatus()
    self._scrollView:RefreshAllShownItem()
    self._chatListScrollView:RefreshAllShownItem()
  end)
end

function UIChatRecentFriendListPanel:_OnFriendSelected(newFriendId, preFriendId)
  if not self:_IsPanelActive() then
    return
  end
  self._newMessageBtn:SetActive(false)
  self:_RefreshDatas(function()
    self:_RefreshChatPanelStatus()
    self._scrollView:RefreshAllShownItem()
    self._chatListScrollView:SetListItemCount(self._currentChatDataCount, false)
    self._chatListScrollView:MovePanelToItemIndex(self._currentChatDataCount, 0)
    self:_RefreshInputField(preFriendId, newFriendId)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ModuleFriendNotifyNewMsg)
  end)
end

function UIChatRecentFriendListPanel:_RefreshInputField(preFriendId, newFriendId)
  if preFriendId then
    self._inputMessageCache[preFriendId] = self._messageInput.text
  end
  if newFriendId then
    if self._inputMessageCache[newFriendId] then
      self._messageInput.text = self._inputMessageCache[newFriendId]
    else
      self._messageInput.text = ""
    end
  else
    self._messageInput.text = ""
  end
end

function UIChatRecentFriendListPanel:_ReceiveChatMessage(friendId, isSelf)
  if not self:_IsPanelActive() then
    return
  end
  if not self._currentSelectFiendId then
    return
  end
  if self._currentSelectFiendId ~= friendId then
    return
  end
  self:_RefreshDatas(function()
    if isSelf then
      self._chatListScrollView:SetListItemCount(self._currentChatDataCount, false)
      self._chatListScrollView:RefreshAllShownItem()
      self._scrollView:RefreshAllShownItem()
      self._chatListScrollView:MovePanelToItemIndex(self._currentChatDataCount, 0)
      self._newMessageBtn:SetActive(false)
    elseif self._chatListScrollView:CheckAtLast() or self._currentChatDataCount <= 1 then
      self._chatListScrollView:SetListItemCount(self._currentChatDataCount, false)
      self._chatListScrollView:RefreshAllShownItem()
      self._scrollView:RefreshAllShownItem()
      self._chatListScrollView:MovePanelToItemIndex(self._currentChatDataCount, 0)
      self._newMessageBtn:SetActive(false)
    else
      self._chatListScrollView:SetListItemCount(self._currentChatDataCount, false)
      self._chatListScrollView:RefreshAllShownItem()
      self._scrollView:RefreshAllShownItem()
      self._newMessageBtn:SetActive(true)
    end
  end)
end

function UIChatRecentFriendListPanel:_RefreshChatPanelStatus()
  if self._currentSelectFiendId == nil then
    self._chatPanel:SetActive(false)
  else
    self._chatPanel:SetActive(true)
    local chatFriendData = self._chatFriendManager:GetRecentChatFriendDataById(self._currentSelectFiendId)
    self._nameLabel.text = chatFriendData:GetName()
  end
end

function UIChatRecentFriendListPanel:_RefreshPanelStatus()
  if self._friendCount <= 0 then
    self._friendPanel:SetActive(false)
    self._chatPanel:SetActive(false)
    self._noFriendPanel:SetActive(true)
    self._tipsLabel.text = StringTable.Get("str_chat_no_recent_friend_tips_ch")
  else
    self._noFriendPanel:SetActive(false)
    self._friendPanel:SetActive(true)
    self._chatPanel:SetActive(true)
  end
end

function UIChatRecentFriendListPanel:_RefreshDatas(callback)
  GameGlobal.TaskManager():StartTask(self._RequestDatas, self, callback)
end

function UIChatRecentFriendListPanel:_RequestDatas(TT, callback)
  self:Lock("_RequestDatas")
  self._chatFriendManager:RequestFriendList(TT)
  self._friendList = self._chatFriendManager:GetRecentChatList()
  self._chatFriendManager:UpdateSelectFriend()
  self._friendCount = table.count(self._friendList)
  self._currentSelectFiendId = self._chatFriendManager:GetSelectRecentFriend()
  if self._currentSelectFiendId == nil then
    self._currentChatDatas = {}
    self._currentChatDataCount = 0
    local socialModule = GameGlobal.GetModule(SocialModule)
    socialModule:SelectChatFriend(TT, 0)
  else
    self._currentChatDatas = self._chatFriendManager:RequestChatData(TT, self._currentSelectFiendId)
    self._currentChatDataCount = 0
    if self._currentChatDatas then
      self._currentChatDataCount = table.count(self._currentChatDatas)
    end
  end
  if callback then
    callback()
  end
  self:UnLock("_RequestDatas")
end

function UIChatRecentFriendListPanel:_IsPanelActive()
  if not self._isInited then
    return false
  end
  if not self._uiChatController then
    return false
  end
  if self._panelType ~= self._uiChatController:GetCurrentPanelType() then
    return false
  end
  return true
end

function UIChatRecentFriendListPanel:_InitChatListScrollView()
  self._chatListScrollView:InitListView(self._currentChatDataCount, function(scrollview, index)
    return self:_OnGetChatMessageItem(scrollview, index)
  end)
end

function UIChatRecentFriendListPanel:_OnGetChatMessageItem(scrollView, index)
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIChatMessageItem", 1)
  end
  local itemRectTran = item:GetComponent("RectTransform")
  local rowList = rowPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    if itemIndex > self._currentChatDataCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      UIHelper.RefreshLayout(itemRectTran)
      itemWidget:GetGameObject():SetActive(true)
      self:_RefreshChatMessageItemInfo(itemWidget, itemIndex, itemRectTran)
    end
  end
  UIHelper.RefreshLayout(itemRectTran)
  return item
end

function UIChatRecentFriendListPanel:_RefreshChatMessageItemInfo(itemWidget, index, itemRectTran)
  local chatFriendData = self._chatFriendManager:GetRecentChatFriendDataById(self._currentSelectFiendId)
  itemWidget:Refresh(self._currentChatDatas[index], chatFriendData, self._chatFriendManager, itemRectTran)
end

function UIChatRecentFriendListPanel:_InitScrollView()
  self._scrollView:InitListView(self._friendCount, function(scrollview, index)
    return self:_OnGetFriendItem(scrollview, index)
  end)
end

function UIChatRecentFriendListPanel:_OnGetFriendItem(scrollView, index)
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIChatRecentFriendItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    if itemIndex > self._friendCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      itemWidget:GetGameObject():SetActive(true)
      self:_RefreshFriendItemInfo(itemWidget, itemIndex)
    end
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UIChatRecentFriendListPanel:_RefreshFriendItemInfo(itemWidget, index)
  itemWidget:Refresh(self._friendList[index], self._panelType, self._chatFriendManager)
end

function UIChatRecentFriendListPanel:_InitQuickMsgScrollView()
  local quickMsgCfg = Cfg.cfg_chat_quick_msg({})
  self._quickList = {}
  if quickMsgCfg then
    for k, v in pairs(quickMsgCfg) do
      local t = {}
      t.msg = StringTable.Get(v.MsgInfo)
      self._quickList[#self._quickList + 1] = t
    end
  end
  self._quickMsgCount = #self._quickList
  self._quickMsgScrollView:InitListView(self._quickMsgCount, function(scrollview, index)
    return self:_OnGetQuickMsgItem(scrollview, index)
  end)
end

function UIChatRecentFriendListPanel:_OnGetQuickMsgItem(scrollView, index)
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIChatQuickMsgItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    if itemIndex > self._quickMsgCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      itemWidget:GetGameObject():SetActive(true)
      self:_RefreshQuickMsgItemInfo(itemWidget, itemIndex)
    end
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UIChatRecentFriendListPanel:_RefreshQuickMsgItemInfo(itemWidget, index)
  itemWidget:Refresh(self._quickList[index], self)
end

function UIChatRecentFriendListPanel:_InitEmojiScrollView()
  local chatEmojiCfg = Cfg.cfg_chat_emoji({})
  self._emojiList = {}
  if chatEmojiCfg then
    for k, v in pairs(chatEmojiCfg) do
      local t = {}
      t.id = v.ID
      t.textureName = v.TextureName
      self._emojiList[#self._emojiList + 1] = t
    end
  end
  self._itemCountPerRow = 5
  self._emojiCount = #self._emojiList
  self._listItemTotalRow = self:_CalcTotalRow(self._emojiCount)
  self._emojiListScrollView:InitListView(self._listItemTotalRow, function(scrollview, index)
    return self:_OnGetEmojiItem(scrollview, index)
  end)
end

function UIChatRecentFriendListPanel:_OnGetEmojiItem(scrollView, index)
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIChatEmojiItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local itemWidget = rowList[i]
    if itemWidget then
      local itemIndex = index * self._itemCountPerRow + i
      if itemIndex > self._emojiCount then
        itemWidget:GetGameObject():SetActive(false)
      else
        itemWidget:GetGameObject():SetActive(true)
        self:_RefreshEmojiItemInfo(itemWidget, itemIndex)
      end
    end
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UIChatRecentFriendListPanel:_RefreshEmojiItemInfo(itemWidget, index)
  itemWidget:Refresh(self._emojiList[index], self)
end

function UIChatRecentFriendListPanel:_CalcTotalRow(itemTotalCount)
  local row, mod = math.modf(itemTotalCount / self._itemCountPerRow)
  if mod ~= 0 then
    row = row + 1
  end
  return row
end

function UIChatRecentFriendListPanel:SendBtnOnClick(go)
  if not self._currentSelectFiendId then
    return
  end
  local roleModule = GameGlobal.GetModule(RoleModule)
  if not roleModule:GetCanChat() then
    ToastManager.ShowToast(StringTable.Get("str_chat_unopen_chat_function"))
    return
  end
  local message = self._messageInput.text
  if not message or message == "" then
    ToastManager.ShowToast(StringTable.Get("str_chat_error_code_is_empty"))
    return
  end
  self:Lock("SendMessage")
  GameGlobal.TaskManager():StartTask(self._SendMessage, self, self._currentSelectFiendId, FRIEND_CHAT_MSG_TYPE.FRIEND_CHAT_MSG_TYPE_STR, message, nil, true)
end

function UIChatRecentFriendListPanel:SendQuickMessage(message)
  self:Lock("SendMessage")
  GameGlobal.TaskManager():StartTask(self._SendMessage, self, self._currentSelectFiendId, FRIEND_CHAT_MSG_TYPE.FRIEND_CHAT_MSG_TYPE_STR, message, nil, false)
  self:QuickMsgMaskOnClick()
end

function UIChatRecentFriendListPanel:SendImageMessage(emojiId)
  if not emojiId then
    return
  end
  if emojiId < 0 then
    return
  end
  self:Lock("SendMessage")
  GameGlobal.TaskManager():StartTask(self._SendMessage, self, self._currentSelectFiendId, FRIEND_CHAT_MSG_TYPE.FRIEND_CHAT_MSG_TYPE_EMOJI, nil, emojiId, false)
  self:EmojiMaskOnClick()
end

function UIChatRecentFriendListPanel:_SendMessage(TT, friendId, messageType, message, emojiId, isCustomInput)
  local idipGameModule = GameGlobal.GetModule(IdipgameModule)
  if idipGameModule:ShutupHandle() == true then
    self:UnLock("SendMessage")
    return
  end
  if not self._canSendMsg then
    self:UnLock("SendMessage")
    ToastManager.ShowToast(StringTable.Get("str_chat_error_code_frequency_limit"))
    return
  end
  if HelperProxy:GetInstance():GetCharLength(message) > self._sendMsgMaxLength then
    ToastManager.ShowToast(StringTable.Get("str_chat_error_code_length_limit"))
    self:UnLock("SendMessage")
    return
  end
  self._canSendMsg = false
  self._chatFriendManager:SendMessage(TT, friendId, messageType, message, emojiId)
  if isCustomInput then
    self._messageInput.text = ""
    self._inputMessageCache[friendId] = nil
  end
  self:UnLock("SendMessage")
  local waitTime = 1000
  local friendCfg = Cfg.cfg_friend_global[1]
  if friendCfg and friendCfg.send_msg_interval then
    waitTime = friendCfg.send_msg_interval * 1000
  end
  self._resetSendBtnEventHandler = GameGlobal.Timer():AddEventTimes(waitTime, 1, self._ResetSendBtn, self)
end

function UIChatRecentFriendListPanel:_ResetSendBtn()
  if self._resetSendBtnEventHandler then
    GameGlobal.Timer():CancelEvent(self._resetSendBtnEventHandler)
  end
  self._resetSendBtnEventHandler = nil
  self._canSendMsg = true
end

function UIChatRecentFriendListPanel:_ChatFriendNotYourFriend(friendId)
  local chatFriendData = self._chatFriendManager:GetRecentChatFriendDataById(self._currentSelectFiendId)
  self:ShowDialog("UIChatDontFriendTipsController", chatFriendData, self._chatFriendManager)
end

function UIChatRecentFriendListPanel:EmojiMaskOnClick(go)
  self._isSendImageOpen = false
  self._sendImageOffGo:SetActive(not self._isSendImageOpen)
  self._sendImageOnGo:SetActive(self._isSendImageOpen)
  self:_CloseImojiPanel()
end

function UIChatRecentFriendListPanel:SendImageBtnOnClick(go)
  self._isSendImageOpen = true
  self._sendImageOffGo:SetActive(not self._isSendImageOpen)
  self._sendImageOnGo:SetActive(self._isSendImageOpen)
  self._emojiPanelGo:SetActive(true)
  self._emojiListScrollView:MovePanelToItemIndex(0, 0)
  self.__mojiPanelAnim:Play("uieff_ChatRecentFriendList_Emoji")
end

function UIChatRecentFriendListPanel:QuickMsgBtnOnClick(go)
  self._quickMsgPanel:SetActive(true)
  self._quickMsgScrollView:MovePanelToItemIndex(0, 0)
end

function UIChatRecentFriendListPanel:NewMessageBtnOnClick(go)
  self._newMessageBtn:SetActive(false)
  self._chatListScrollView:MovePanelToItemIndex(self._currentChatDataCount, 0)
end

function UIChatRecentFriendListPanel:_CloseImojiPanel()
  self:Lock("_CloseImojiPanel")
  GameGlobal.TaskManager():StartTask(self._CloseImojiPanelCoro, self)
end

function UIChatRecentFriendListPanel:_CloseImojiPanelCoro(TT)
  YIELD(TT, 200)
  self._emojiPanelGo:SetActive(false)
  self:UnLock("_CloseImojiPanel")
end

function UIChatRecentFriendListPanel:QuickMsgMaskOnClick(go)
  self:_CloseQuickMsgPanel()
end

function UIChatRecentFriendListPanel:_CloseQuickMsgPanel()
  self:Lock("_CloseQuickMsgPanel")
  GameGlobal.TaskManager():StartTask(self._CloseQuickMsgPanelCoro, self)
end

function UIChatRecentFriendListPanel:_CloseQuickMsgPanelCoro(TT)
  YIELD(TT)
  self._quickMsgPanel:SetActive(false)
  self:UnLock("_CloseQuickMsgPanel")
end
