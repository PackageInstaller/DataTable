local this = class("modulePrivateChat", G_UIModuleBase)
local _chatChannelListTpl = L_GameTpl:getChatChannelListTpl()
local _playerTitleTpl = L_GameTpl:getPlayerTitleTpl()
local _chatBackgroundTpl = L_GameTpl:getChatBackgroundTpl()
local COLOR_GREY = C_LuaUtility.ParseHtmlStringColor("#8b8c8f")
local COLOR_BLUE = C_LuaUtility.ParseHtmlStringColor("#4ccbff")
local b, CLOLOR_EMO = C_ColorUtility.TryParseHtmlString("#303030")
local b, CLOLOR_EMOs = C_ColorUtility.TryParseHtmlString("#303030BD")
local b, CLOLOR_EMOd = C_ColorUtility.TryParseHtmlString("#3030307C")
local _, CLOLOR_INPUTs = C_ColorUtility.TryParseHtmlString("#FFFFFF")
local _, CLOLOR_INPUTd = C_ColorUtility.TryParseHtmlString("#FFFFFF7C")
local _, CLOLOR_BGNormal = C_ColorUtility.TryParseHtmlString("#FFFFFFEE")
local _, CLOLOR_BGPage = C_ColorUtility.TryParseHtmlString("#FFFFFFEE")
local _, COLOR_NAME_NORMAL = C_ColorUtility.TryParseHtmlString("#303030CC")
local _, COLOR_NAME_MARK = C_ColorUtility.TryParseHtmlString("#04a5ffcc")
local BackgroundDefault = "UI/Texture/ChatBg/tex_chat_bg_background_l_000.png"

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    unreadMsgNum = 0,
    currentBaseInfo = nil,
    conversation = nil,
    tabId = -1
  }
end

function this.bind()
  return {
    offsetMax_bg = C_Vector2(0, 0),
    txt_chatInputContent = nil,
    go_newMsgBtn = false,
    txt_newMsgBtn = "",
    scrollList_message = {},
    focusItemIndex_messageList = 0,
    go_chatMask = false,
    go_moduleCommonWords = false,
    go_moduleEmoticon = false,
    module_commonWords = {
      moduleName = "pages/Chat/moduleChatCommonWords"
    },
    module_emotion = {
      moduleName = "pages/Chat/moduleChatEmotion"
    },
    go_bg = true,
    txt_deleteChat = L_WordsTpl:getValue("ui_chat_delete_chathistory"),
    txt_playerName = "",
    color_playerName = C_Color.white,
    go_notFriendTips = false,
    txt_notFriendTips = L_WordsTpl:getValue("ui_chat_alreadynotfriend"),
    txt_placeHolder = L_DeviceTpl:getIsPc() and L_WordsTpl:getValue("ui_chat_entertext_pc") or L_WordsTpl:getValue("ui_chat_entertext"),
    color_input_emo = CLOLOR_EMOd,
    color_input_img = CLOLOR_EMOd,
    color_input_bg = CLOLOR_INPUTd,
    color_Bg = CLOLOR_BGNormal,
    go_noChat = false,
    go_chatMain = false,
    go_blockChatBtn = false,
    go_sendBtnOn = false,
    go_btnMaskL = false,
    go_btnMaskR = false,
    go_sendBtnHighlight = false,
    img_background = ""
  }
end

function this.methods()
  return {
    module_emotion = {
      onClick_Send = function(self, bind)
        self.bindComponents.input_text.text = ""
        self:closePagePlayerDetailInfo()
      end
    },
    module_commonWords = {
      onClick_Send = function(self, bind)
        self.bindComponents.input_text.text = ""
        self:closePagePlayerDetailInfo()
      end
    },
    onClick_openOtherOperation = function(self)
      self.bind.go_bg = true
      self:closePagePlayerDetailInfo()
    end,
    onClick_closeOtherOperation = function(self)
      self.bind.go_bg = false
      self:closePagePlayerDetailInfo()
    end,
    onClick_clearChatRecord = function(self)
      local baseInfo = self.data.currentBaseInfo
      local data = {
        txtContent = L_WordsTpl:getValue("notice_delete_friend_chatrecord", {
          [0] = L_FriendStore:getPlayerName(baseInfo)
        }),
        confirmCallback = function()
          local function callback()
            self:initPlayerList()
            
            self:initMessageList()
          end
          
          L_ChatStore:clearPlayerChatRecord(self.data.tabId, callback)
        end
      }
      L_GameUtil.showCommonTip(data)
      self:closePagePlayerDetailInfo()
    end,
    onClick_commonWords = function(self)
      if L_ChatStore:checkChatIsBan() then
        return
      end
      self:closePagePlayerDetailInfo()
      if not L_FriendStore:getIsFriend(self.data.tabId) then
        local baseInfo = self.data.currentBaseInfo
        L_FlyMsgManager:showNormalMsgByKey("tips_friend_nofriendship", {
          [0] = L_FriendStore:getPlayerName(baseInfo)
        })
        self.bind.go_notFriendTips = true
        return
      end
      self:setEmotionModule(false)
      self:setCommonWords(not self.bind.go_moduleCommonWords)
      self.bind.color_btnEmotion = self.bind.go_moduleEmoticon and COLOR_BLUE or COLOR_GREY
      self.modules.module_commonWords:initModule(L_Const.chatType.personal, self.data.tabId)
    end,
    onClick_emotion = function(self)
      if L_ChatStore:checkChatIsBan() then
        return
      end
      self:closePagePlayerDetailInfo()
      if not L_FriendStore:getIsFriend(self.data.tabId) then
        local baseInfo = self.data.currentBaseInfo
        L_FlyMsgManager:showNormalMsgByKey("tips_friend_nofriendship", {
          [0] = L_FriendStore:getPlayerName(baseInfo)
        })
        self.bind.go_notFriendTips = true
        return
      end
      self:setCommonWords(false)
      self:setEmotionModule(not self.bind.go_moduleEmoticon)
      self.bind.color_btnEmotion = self.bind.go_moduleEmoticon and COLOR_BLUE or COLOR_GREY
      self.modules.module_emotion:initModule(L_Const.chatType.personal, self.data.tabId)
    end,
    onSend_click = function(self)
      if L_ChatStore:checkChatIsBan() then
        return
      end
      self:closePagePlayerDetailInfo()
      if self.bindComponents.input_text.text ~= "" then
        if not L_FriendStore:getIsFriend(self.data.tabId) then
          local baseInfo = self.data.currentBaseInfo
          L_FlyMsgManager:showNormalMsgByKey("tips_friend_nofriendship", {
            [0] = L_FriendStore:getPlayerName(baseInfo)
          })
          self.bind.go_notFriendTips = true
          return
        end
        local friend = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), self.data.tabId)
        
        local function callback()
          self.bindComponents.input_text.text = ""
          L_AudioUtil.playSound("Play_SFX_System_FB_Chat_Message_Send")
        end
        
        L_ChatStore:req_sendChatInfo(self.data.tabId, L_Const.chatType.personal, L_Const.ChatInfoType.CHAT_NORMAL, self.bindComponents.input_text.text, friend:getIsTarShield(), callback)
      else
        L_FlyMsgManager:showNormalMsgByKey("tips_chat_cannotsendempty")
      end
    end,
    onClick_newMsg = function(self)
      self.bind.go_newMsgBtn = false
      self.data.unreadMsgNum = 0
      local num = #self.bind.scrollList_message
      self.bindComponents.tableView_chat:FocusItemIndex(num - 1, true)
      if self.data.conversation and self.data.conversation.readedOrder ~= self.data.conversation.currentOrder and self.data.conversation.currentOrder > self.data.conversation.sendOrder then
        if not L_FriendStore:getIsFriend(self.data.tabId) then
          self.data.conversation.readedOrder = self.data.conversation.currentOrder
          L_ReddotManager._dirtyList[L_ReddotManager.DotDef.FriendPrivateChat_Player] = true
          return
        end
        local data = {
          id = self.data.tabId,
          order = self.data.conversation.currentOrder
        }
        self.data.conversation.sendOrder = self.data.conversation.currentOrder
        L_Net:sendMessage(MsgGenCode.CSProtoReadFriendChat, data, function(rspData, errorCode)
          self.data.conversation.sendOrder = -1
          if errorCode == L_Const.errorCode.ErrCodeSucc then
            self.data.conversation.readedOrder = self.data.conversation.currentOrder
            L_ReddotManager._dirtyList[L_ReddotManager.DotDef.FriendPrivateChat_Player] = true
          else
            self.data.conversation.readedOrder = self.data.conversation.currentOrder
            L_ReddotManager._dirtyList[L_ReddotManager.DotDef.FriendPrivateChat_Player] = true
          end
        end)
      end
    end,
    onValueChanged_sendInput = function(self, value)
      self:closePagePlayerDetailInfo()
      if not self.limit or self.limit <= 0 then
        return
      end
      local valueS = string.gsub(value, "\n", "")
      valueS = string.gsub(valueS, "\r", "")
      if value and valueS ~= value then
        self.bindComponents.input_text.text = valueS
        return
      end
      local filterValue = CS.Lens.Framework.UI.LTextMeshProUtilty.UnicodeWhiteFilter(value)
      if filterValue ~= value then
        self.bindComponents.input_text.text = filterValue
        value = filterValue
      end
      local curLen = this:getStringLen(value)
      if curLen > self.limit then
        self.bindComponents.input_text.text = self:getCutString(value, self.limit)
        L_FlyMsgManager:showNormalMsgByKey("tips_chat_maxnum", {
          [0] = math.floor(self.limit / 2)
        })
      end
      if 0 < C_LuaUtility.StringLength(value) then
        self.bind.color_input_bg = CLOLOR_INPUTs
      else
        self.bind.color_input_bg = CLOLOR_INPUTd
      end
    end,
    onValueChange_ScrollList = function(self, value)
      if value.y < 0.01 then
        self.bind.go_newMsgBtn = false
        if self.data.conversation.readedOrder ~= self.data.conversation.currentOrder and self.data.conversation.currentOrder > self.data.conversation.sendOrder then
          self.methods.onClick_newMsg(self)
        end
      end
    end,
    onCloseClick = function(self)
      self:closePagePlayerDetailInfo()
      L_UI:close("pageChat")
    end,
    onMaskLClick = function(self)
      self:closePagePlayerDetailInfo()
      self:checkMaskClick()
    end,
    onMaskRClick = function(self)
      self:closePagePlayerDetailInfo()
      self:checkMaskClick()
    end,
    OnClickViewport = function(self)
      self:closePagePlayerDetailInfo()
    end,
    OnClickPlayerList = function(self)
      self:closePagePlayerDetailInfo()
    end,
    scrollList_message = {
      onClick_head = function(self, uid, callback)
        self:emit("onClick_head", uid, callback)
      end
    }
  }
end

function this:open(options)
  this.super.open(self, options)
  L_ChatStore:listenCallFunc(L_ChatStore.event.refreshMessage, self.onEvent_refreshMessage, self)
  L_ChatStore:listenCallFunc(L_ChatStore.event.refreshChatMessageBubbleOrBg, self.onRefreshMessageBubbleOrBg, self)
  L_FriendStore:listenCallFunc(L_FriendStore.event.refreshIdListByLocalPlayer, self.onEvent_refreshIdList, self)
  L_FriendStore:listenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList, self)
  L_ShortCutManager:registerShortCut("pageChat", C_InputManager_KeyType.EPageChatReturn, function()
    if self.bindComponents.input_text.isFocused then
      self.methods.onSend_click(self)
    else
      self.bindComponents.input_text:ActivateInputField()
    end
  end)
  
  function self._inputFieldChange(newText)
    self:checkInputField(newText)
  end
  
  self:checkInputField()
  self.bindComponents.input_text.onValueChanged:AddListener(self._inputFieldChange)
  self:initBgShow()
  self:setBackground()
end

function this:close(options)
  self.bindComponents.input_text.onValueChanged:RemoveAllListeners()
  this.super.close(self, options)
  L_ChatStore:unListenCallFunc(L_ChatStore.event.refreshMessage, self.onEvent_refreshMessage)
  L_ChatStore:unListenCallFunc(L_ChatStore.event.refreshChatMessageBubbleOrBg, self.onRefreshMessageBubbleOrBg)
  L_FriendStore:unListenCallFunc(L_FriendStore.event.refreshIdListByLocalPlayer, self.onEvent_refreshIdList)
  L_FriendStore:unListenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList)
  L_ShortCutManager:removeShortCut("pageChat")
  L_TimerManager:clearTimer(self)
end

function this:initModule(tabId)
  self.limit = L_GameTpl:getGameConstTpl():getMaxChat()
  L_ReddotManager._dirtyList[L_ReddotManager.DotDef.FriendPrivateChat_Player] = true
  self:initPlayerList(tabId)
  self:initMessageList()
end

function this:initPlayerList(tabId)
  local tmp = {}
  local conversationList = L_ChatStore:getConversationList()
  local curUid = L_ChatStore:getCurrentChatFriendId()
  if tabId and 0 < tabId and conversationList[tabId] then
    curUid = tabId
  end
  if curUid == -1 then
    for id, v in pairs(conversationList) do
      table.insert(tmp, {uid = id})
    end
    table.sort(tmp, function(a, b)
      local baseInfoA = L_FriendStore:getPlayerBaseInfo(a.uid)
      local baseInfoB = L_FriendStore:getPlayerBaseInfo(b.uid)
      local onlineA = L_FriendStore:getPlayerIsOnline(baseInfoA) and 0 or 1
      local onlineB = L_FriendStore:getPlayerIsOnline(baseInfoB) and 0 or 1
      if not L_FriendStore:getIsFriend(a.uid) or not L_FriendStore:getIsFriend(b.uid) then
        return L_FriendStore:getIsFriend(a.uid) and not L_FriendStore:getIsFriend(b.uid)
      elseif onlineA == 0 and onlineB == 0 then
        local friendItemA = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), a.uid)
        local friendItemB = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), b.uid)
        local timeA = friendItemA:getInsertTime()
        local timeB = friendItemB:getInsertTime()
        return timeA < timeB
      elseif onlineA == 1 and onlineB == 1 then
        local offlineTimeA = L_FriendStore:getPlayerOffLineTime(baseInfoA)
        local offlineTimeB = L_FriendStore:getPlayerOffLineTime(baseInfoB)
        return offlineTimeA > offlineTimeB
      else
        return onlineA < onlineB
      end
    end)
  end
  if table.count(conversationList) > 0 then
    self.bind.go_noChat = false
    self.bind.go_chatMain = true
    self.bind.offsetMax_bg = C_Vector2(0, 0)
  else
    self.bind.go_noChat = true
    self.bind.go_chatMain = false
    self.bind.offsetMax_bg = C_Vector2(-1600, 0)
  end
  if curUid == -1 and table.count(conversationList) > 0 then
    self.data.tabId = tmp[1].uid
  else
    self.data.tabId = curUid
  end
end

function this:initMessageList()
  local playerId = self.data.tabId
  if playerId == -1 then
    return
  end
  self.bind.go_notFriendTips = false
  
  local function callback()
    local baseInfo = L_FriendStore:getPlayerBaseInfo(playerId)
    self.data.currentBaseInfo = baseInfo
    self.data.conversation = L_ChatStore:getConversation(playerId)
    self:initPrivateChat()
    if L_FriendStore:getIsFriend(playerId) then
      local friend = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), playerId)
      self.bind.txt_playerName = string.isEmpty(friend:getFriendMark()) and L_FriendManager:getFriendShowName(playerId) or friend:getFriendMark()
      local isMark = not string.isEmpty(friend:getFriendMark())
      self.bind.color_playerName = isMark and COLOR_NAME_MARK or COLOR_NAME_NORMAL
    else
      self.bind.txt_playerName = L_FriendStore:getPlayerName(baseInfo)
      self.bind.color_playerName = COLOR_NAME_NORMAL
    end
  end
  
  self:checkPlayerInfo(playerId, callback)
end

function this:initPrivateChat()
  if not self.data.conversation then
    return
  end
  local msgList = L_ChatStore:getMessageList(self.data.conversation)
  local tmp = {}
  local lastMsg
  local friend = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), self.data.currentBaseInfo.id)
  local isShield = L_FriendStore:getIsBlockChatList(self.data.tabId)
  if not isShield then
    for i, v in pairs(msgList) do
      local timeMsg = L_ChatManager:parseTimeMsg(lastMsg, v)
      if timeMsg then
        table.insert(tmp, timeMsg)
      end
      lastMsg = v
      local msg = L_ChatManager:parseMsg(v, self.data.currentBaseInfo)
      if msg.emotionData ~= nil then
        msg.emojiCallBack = handler(self, self.onClickEmotion)
      end
      table.insert(tmp, msg)
    end
  end
  self.bind.scrollList_message:clear()
  self.bind.scrollList_message:insert_array(tmp)
  if 0 < #tmp then
    self:emit("onSetActive", false)
  end
  self.methods.onClick_newMsg(self)
end

function this:onEvent_refreshMessage(data)
  if data.oppositePlayerId == self.data.tabId then
    local friend = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), data.oppositePlayerId)
    local isShield = L_FriendStore:getIsBlockChatList(data.oppositePlayerId)
    if self.bindComponents.tableView_chat.verticalNormalizedPosition > 0.001 and not L_ChatStore:getIsMessageSendByMyself(data.chat) then
      if isShield then
        return
      end
      self.data.unreadMsgNum = self.data.unreadMsgNum + 1
      self.bind.txt_newMsgBtn = L_WordsTpl:getValue("ui_chat_received_new_message")
      local isBottom = self.bindComponents.content.rect.height <= self.bindComponents.viewport.rect.height
      self:insertNewMsg(data.chat, isBottom)
      if not isBottom then
        self.bind.go_newMsgBtn = true
      end
    else
      if not L_ChatStore:getIsMessageSendByMyself(data.chat) and isShield then
        return
      end
      self:insertNewMsg(data.chat, true)
      self.methods.onClick_newMsg(self)
    end
  end
end

function this:onRefreshMessageBubbleOrBg()
  self:initPrivateChat()
  self:setBackground()
end

function this:onEvent_refreshIdList(data)
  self:initModule(self.data.tabId)
end

function this:refreshBlock()
  self:initPrivateChat()
  for i = 1, #self.bind.scrollList_friendChat do
    local cell = self.bind.scrollList_friendChat:getItemCls(i)
    if cell then
      cell:refresh()
    else
    end
  end
end

function this:insertNewMsg(message, isBottom)
  local num = #self.bind.scrollList_message
  local lastMsg = num ~= 0 and self.bind.scrollList_message:getValue(num).serverData or nil
  local timeMsg = L_ChatManager:parseTimeMsg(lastMsg, message)
  if timeMsg then
    if isBottom then
      self.bind.scrollList_message:insert(timeMsg)
    else
      self.bind.scrollList_message:insert_withoutRefresh(timeMsg)
    end
  end
  local msg = L_ChatManager:parseMsg(message, self.data.currentBaseInfo)
  if msg.emotionData ~= nil then
    msg.emojiCallBack = handler(self, self.onClickEmotion)
  end
  if isBottom then
    self.bind.scrollList_message:insert(msg)
  else
    self.bind.scrollList_message:insert_withoutRefresh(msg)
  end
  local count = #self.modules.scrollList_message
  for i, v in pairs(self.modules.scrollList_message) do
    if i == count then
      v:playInitFX()
    end
  end
  if 0 < count then
    self:emit("onSetActive", false)
  end
end

function this:checkPlayerInfo(playerId, callback)
  local baseInfo = L_FriendStore:getPlayerBaseInfo(playerId)
  if baseInfo then
    if callback then
      callback()
    end
    return
  end
  local types = {
    L_Const.PlayerBasicQueryType.PBQT_ALL
  }
  local players = {playerId}
  L_FriendManager:requestBaseInfo(types, players, function()
    if callback then
      callback()
    end
  end)
end

function this:checkInputField(newText)
  if newText and newText ~= "" then
    self.bind.go_blockChatBtn = false
    self.bind.go_sendBtnHighlight = true
    self.bind.go_sendBtnOn = true
    return
  end
  local txt = self.bindComponents.input_text.text
  if txt and txt ~= "" then
    self.bind.go_blockChatBtn = false
    self.bind.go_sendBtnOn = true
    self.bind.go_sendBtnHighlight = true
    return
  end
  self.bind.go_blockChatBtn = true
  self.bind.go_sendBtnOn = false
  self.bind.go_sendBtnHighlight = false
end

function this:checkMaskClick()
  if self.bind.go_moduleEmoticon then
    self:setEmotionModule(false)
    return true
  elseif self.bind.go_moduleCommonWords then
    self:setCommonWords(false)
    return true
  end
  return false
end

function this:closePagePlayerDetailInfo()
  self:emit("onClick_close")
end

function this:setEmotionModule(isActive)
  if isActive and not self.bind.go_moduleEmoticon then
    L_AudioUtil.playSound("Play_SFX_System_UI_Chat_Meme_Show")
  end
  self.bind.go_moduleEmoticon = isActive
  self.bind.go_btnMaskL = isActive
  self.bind.go_btnMaskR = isActive
  if isActive then
    self.bind.color_input_emo = CLOLOR_EMOs
    self.bind.color_input_bg = CLOLOR_INPUTs
  else
    self.bind.color_input_emo = CLOLOR_EMOd
    self.bind.color_input_bg = CLOLOR_INPUTd
  end
end

function this:setCommonWords(isActive)
  if isActive and not self.bind.go_moduleCommonWords then
    L_AudioUtil.playSound("Play_SFX_System_UI_Chat_QuickPhrase_Show")
  end
  self.bind.go_moduleCommonWords = isActive
  self.bind.go_btnMaskL = isActive
  self.bind.go_btnMaskR = isActive
  if isActive then
    self.bind.color_input_img = CLOLOR_EMOs
    self.bind.color_input_bg = CLOLOR_INPUTs
  else
    self.bind.color_input_img = CLOLOR_EMOd
    self.bind.color_input_bg = CLOLOR_INPUTd
  end
end

function this:playOpenAnim()
  if not self.bindComponents.anim_chat then
    return
  end
  self.bindComponents.anim_chat:Stop()
  self.bindComponents.anim_chat:Play("anim_privatechat_main_in")
end

function this:playSwitchAnim(isOpen)
  if not self.bindComponents.anim_chat then
    return
  end
  self.bindComponents.anim_chat:Stop()
  if isOpen then
    self.bindComponents.anim_chat:Play("anim_privatechat_main_in")
  else
    self.bindComponents.anim_chat:Play("anim_privatechat_main_close")
  end
end

function this:playCloseAnim()
  if not self.bindComponents.anim_chat then
    return
  end
  self.bindComponents.anim_chat:Stop()
  self.bindComponents.anim_chat:Play("anim_privatechat_main_close")
end

function this:playSwitchChatAnim()
  if not self.bindComponents.anim_chat then
    return
  end
  self.bindComponents.anim_chat:Stop()
  self.bindComponents.anim_chat:Play("anim_privatechat_main_switch")
end

function this:initBgShow()
  local pages = C_UIMgr.GetAllPages(0)
  for k, pretop in pairs(pages) do
    if pretop and pretop.config and (pretop.config.displayMode == CS.Azur.Gameplay.EUIDisplay.Normal or pretop.config.displayMode == CS.Azur.Gameplay.EUIDisplay.SceneUI) then
      self.bindComponents.imgBgMaterial.material = nil
      self.bind.color_Bg = CLOLOR_BGPage
      return
    end
  end
end

function this:getStringLen(str)
  if str == nil or str == "" then
    return 0
  end
  local count = 0
  local i = 1
  local byteLen = #str
  while i <= byteLen do
    local c = string.byte(str, i)
    count = count + 1
    if c < 128 then
      i = i + 1
    elseif c < 224 then
      i = i + 2
    elseif c < 240 then
      i = i + 3
    elseif c < 248 then
      i = i + 4
    else
      i = i + 1
    end
  end
  return count * 2
end

function this:getCutString(str, limit, showEllipsis)
  if str == nil or str == "" then
    return ""
  end
  local currentLen = 0
  local i = 1
  local byteLen = #str
  local lastValidByte = 0
  local checkLimit = limit
  while i <= byteLen do
    local c = string.byte(str, i)
    local step = 1
    if c < 128 then
      step = 1
    elseif c < 224 then
      step = 2
    elseif c < 240 then
      step = 3
    else
      step = 4
    end
    if checkLimit < currentLen + 2 then
      return string.sub(str, 1, lastValidByte)
    end
    currentLen = currentLen + 2
    lastValidByte = i + step - 1
    i = i + step
  end
  return str
end

function this:onClickEmotion(groupId, emojiId)
  if not L_FriendStore:getIsFriend(self.data.tabId) then
    return
  end
  self:setCommonWords(false)
  self:setEmotionModule(not self.bind.go_moduleEmoticon)
  self.bind.color_btnEmotion = self.bind.go_moduleEmoticon and COLOR_BLUE or COLOR_GREY
  self.modules.module_emotion:initModule(L_Const.chatType.personal, self.data.tabId, {groupId = groupId, emojiId = emojiId})
  if L_UI:checkPageOpen("pageChatEmotion") then
    L_UI:close("pageChatEmotion")
  end
end

function this:onSetSelectTabId(tabId)
  self.data.tabId = tabId
  if self.isBind then
    self:initMessageList(tabId)
    self:playSwitchChatAnim()
  end
end

function this:setBackground()
  local curBackgroundConfigId = AzurWorld.ChatMgr:GetByChatBackgroundId()
  local tpl = _chatBackgroundTpl:getTplById(curBackgroundConfigId)
  local background = BackgroundDefault
  if tpl and _chatBackgroundTpl:getShowType(tpl) ~= 0 then
    background = _chatBackgroundTpl:getBackgroundRes(tpl)
  end
  self.bind.img_background = background
end

return this
