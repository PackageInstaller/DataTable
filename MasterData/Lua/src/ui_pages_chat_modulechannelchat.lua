local this = class("moduleChannelChat", G_UIModuleBase)
local _chatChannelListTpl = L_GameTpl:getChatChannelListTpl()
local _chatBackgroundTpl = L_GameTpl:getChatBackgroundTpl()
local worldAreaTpl = L_GameTpl:getWorldAreaTpl()
local COLOR_GREY = C_LuaUtility.ParseHtmlStringColor("#8b8c8f")
local COLOR_BLUE = C_LuaUtility.ParseHtmlStringColor("#4ccbff")
local b, CLOLOR_EMO = C_ColorUtility.TryParseHtmlString("#303030")
local b, CLOLOR_EMOs = C_ColorUtility.TryParseHtmlString("#303030BD")
local b, CLOLOR_EMOd = C_ColorUtility.TryParseHtmlString("#3030307C")
local _, CLOLOR_INPUTs = C_ColorUtility.TryParseHtmlString("#FFFFFF")
local _, CLOLOR_INPUTd = C_ColorUtility.TryParseHtmlString("#FFFFFF7C")
local INPUT_ACTIVE = C_LuaUtility.ParseHtmlStringColor("#303030")
local _, CLOLOR_BGNormal = C_ColorUtility.TryParseHtmlString("#FFFFFFEE")
local _, CLOLOR_BGPage = C_ColorUtility.TryParseHtmlString("#FFFFFFEE")
local BackgroundDefault = "UI/Texture/ChatBg/tex_chat_bg_background_l_000.png"
local MenuType = {
  worldChat = 1,
  cityChat = 2,
  teamChat = 3,
  partyChat = 4
}
local MenuTypeConvertToChatType = {
  [L_Const.chatType.team] = MenuType.teamChat,
  [L_Const.chatType.world] = MenuType.worldChat,
  [L_Const.chatType.city] = MenuType.cityChat,
  [L_Const.chatType.map] = MenuType.partyChat
}
local ChatTypeToMenuType = {
  [MenuType.teamChat] = L_Const.chatType.team,
  [MenuType.worldChat] = L_Const.chatType.world,
  [MenuType.cityChat] = L_Const.chatType.city,
  [MenuType.partyChat] = L_Const.chatType.map
}

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    unreadMsgNum = 0,
    chatCD = 0,
    menuType = -1,
    tabId = -1
  }
end

function this.bind()
  return {
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
    txt_switchChannel = L_WordsTpl:getValue("ui_chat_changechannels"),
    txt_ChannelName = "",
    txt_ChannelName2 = "",
    txt_noTeamDesc = L_WordsTpl:getValue("residual_code_modulechannelchat_01"),
    go_ChannelBtn = true,
    go_ChannelName = false,
    go_emptyMessage = true,
    txt_ChatCD = "",
    go_blockChatBtn = false,
    go_sendBtnOn = false,
    txt_placeHolder = L_DeviceTpl:getIsPc() and L_WordsTpl:getValue("ui_chat_entertext_pc") or L_WordsTpl:getValue("ui_chat_entertext"),
    go_teamEmpty = false,
    go_chat = true,
    go_bottom = true,
    go_top = true,
    color_input_emo = CLOLOR_EMO,
    color_input_img = CLOLOR_EMO,
    color_input_bg = CLOLOR_INPUTd,
    color_Bg = CLOLOR_BGNormal,
    go_btnMaskL = false,
    go_btnMaskR = false,
    go_sendBtnHighlight = false,
    img_background = BackgroundDefault
  }
end

function this.methods()
  return {
    module_emotion = {
      onClick_Send = function(self, bind)
        self.bindComponents.input_text.text = ""
        self:InitChatCD()
        self:closePagePlayerDetailInfo()
      end
    },
    module_commonWords = {
      onClick_Send = function(self, bind)
        self.bindComponents.input_text.text = ""
        self:InitChatCD()
        self:closePagePlayerDetailInfo()
      end
    },
    onClick_openOtherOperation = function(self)
      self.bind.go_bg = true
      self:closePagePlayerDetailInfo()
    end,
    onClick_closeOtherOperation = function(self)
      L_TimerManager:newOrResetTimer(self, "closeOtherOperation", function()
      end, 0.5)
      self.bind.go_bg = false
      self:closePagePlayerDetailInfo()
    end,
    onClick_clearChatRecord = function(self)
      local data = {
        txtContent = L_WordsTpl:getValue("notice_delete_chatrecord"),
        confirmCallback = function()
          self.bind.go_emptyMessage = true
          local chatType = self:getCurChatType()
          L_ChatStore:clearChannelConversation(chatType)
          self:initMessageList()
        end
      }
      L_GameUtil.showCommonTip(data)
      self:closePagePlayerDetailInfo()
    end,
    onClick_switchChannel = function(self)
      self:switchChannel()
      self:closePagePlayerDetailInfo()
    end,
    onClick_commonWorlds = function(self)
      if L_ChatStore:checkChatIsBan() then
        return
      end
      self:setEmotionModule(false)
      self.bind.color_btnEmotion = self.bind.go_moduleEmoticon and COLOR_BLUE or COLOR_GREY
      self:setCommonWords(not self.bind.go_moduleCommonWords)
      self.modules.module_commonWords:initModule(ChatTypeToMenuType[self.data.tabId], -1)
      self:closePagePlayerDetailInfo()
    end,
    onClick_emotion = function(self)
      if L_ChatStore:checkChatIsBan() then
        return
      end
      self.bind.color_btnEmotion = self.bind.go_moduleEmoticon and COLOR_BLUE or COLOR_GREY
      self:setCommonWords(false)
      self:setEmotionModule(not self.bind.go_moduleEmoticon)
      self.modules.module_emotion:initModule(ChatTypeToMenuType[self.data.tabId], -1)
      self:closePagePlayerDetailInfo()
    end,
    onSend_click = function(self)
      if L_ChatStore:checkChatIsBan() then
        return
      end
      self:HandleSendMessage()
      self:closePagePlayerDetailInfo()
    end,
    onClick_newMsg = function(self)
      self.bind.go_newMsgBtn = false
      self:updateReddot()
      self.data.unreadMsgNum = 0
      local num = #self.bind.scrollList_message
      self.bindComponents.tableView_chat:FocusItemIndex(num - 1, true)
      self:closePagePlayerDetailInfo()
    end,
    onValueChanged_sendInput = function(self, value)
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
      self:closePagePlayerDetailInfo()
    end,
    onValueChange_ScrollList = function(self, value)
      if value.y < 0.01 then
        self.bind.go_newMsgBtn = false
        self:updateReddot()
      end
    end,
    onCloseClick = function(self)
      L_UI:close("pageChat")
      self:closePagePlayerDetailInfo()
    end,
    onCloseEmotion = function(self)
      self:setEmotionModule(false)
      self:closePagePlayerDetailInfo()
    end,
    onMaskLClick = function(self)
      self:closePagePlayerDetailInfo()
      self:checkMaskClick()
    end,
    onMaskRClick = function(self)
      self:closePagePlayerDetailInfo()
      self:checkMaskClick()
    end,
    scrollList_message = {
      onClick_head = function(self, uid, callback)
        self:emit("onClick_head", uid, callback)
      end,
      onClick_close = function(self)
        self:emit("onClick_close")
      end
    },
    OnClickViewport = function(self)
      self:closePagePlayerDetailInfo()
    end,
    OnClickPlayerList = function(self)
      self:closePagePlayerDetailInfo()
    end
  }
end

function this:open(options)
  this.super.open(self, options)
  self._onEvent_PlayerInOutEventHandle = self._onEvent_PlayerInOutEventHandle or handler(self, self.onPlayerInOut)
  C_MultiEvent.instance:Listen(C_EMultiEvent.MultiTeamInOutTeam, self._onEvent_PlayerInOutEventHandle)
  L_ChatStore:listenCallFunc(L_ChatStore.event.refreshChannelConversationList, self.onEvent_refreshMessage, self)
  L_ChatStore:listenCallFunc(L_ChatStore.event.refreshChatMessageBubbleOrBg, self.onEvent_refreshChannelRecord, self)
  L_ChatStore:listenCallFunc(L_ChatStore.event.refreshWorldChannelCD, self.onEvent_refreshWorldChannelCD, self)
  for i, data in pairs(L_ChatStore.data.channelDataList) do
    local refreshEventId = data:getRefreshEventId()
    if refreshEventId then
      L_ChatStore:listenCallFunc(refreshEventId, self.onEvent_refreshChannelRecord, self)
    end
  end
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
  
  self.bindComponents.input_text.onValueChanged:AddListener(self._inputFieldChange)
  self:initBgShow()
  L_ChatStore:sendTeamMsg()
end

function this:close(options)
  this.super.close(self, options)
  for i, data in pairs(L_ChatStore.data.channelDataList) do
    data:setChannelChatTimeCountCallback(nil)
    data:setChannelChatTimeEndCallback(nil)
  end
  C_MultiEvent.instance:Cancel(C_EMultiEvent.MultiTeamInOutTeam, self._onEvent_PlayerInOutEventHandle)
  L_ChatStore:unListenCallFunc(L_ChatStore.event.refreshChannelConversationList, self.onEvent_refreshMessage)
  L_ChatStore:unListenCallFunc(L_ChatStore.event.refreshChatMessageBubbleOrBg, self.onEvent_refreshChannelRecord, self)
  L_ChatStore:unListenCallFunc(L_ChatStore.event.refreshWorldChannelCD, self.onEvent_refreshWorldChannelCD, self)
  for i, data in pairs(L_ChatStore.data.channelDataList) do
    local refreshEventId = data:getRefreshEventId()
    if refreshEventId then
      L_ChatStore:unListenCallFunc(data.refreshEventId, self.onEvent_refreshChannelRecord, self)
    end
  end
  L_ShortCutManager:removeShortCut("pageChat")
  self.bindComponents.input_text.onValueChanged:RemoveListener(self._inputFieldChange)
  self.bindComponents.input_text.onValueChanged:RemoveAllListeners()
  L_TimerManager:clearTimer(self)
end

function this:show()
  self:initModule(self.data.tabId)
end

function this:initModule(tabId)
  self.limit = L_GameTpl:getGameConstTpl():getMaxChat()
  if self.data.tabId == -1 then
    if tabId == nil or tabId == 0 then
      self.data.tabId = MenuType.worldChat
    else
      self.data.tabId = tabId
    end
  end
  self.data.menuType = self.data.tabId
  self:initMessageList()
end

function this:initMessageList()
  for i, data in pairs(L_ChatStore.data.channelDataList) do
    data:setChannelChatTimeCountCallback(nil)
    data:setChannelChatTimeEndCallback(nil)
  end
  local chatType = self:getCurChatType()
  local chatData = L_ChatStore:getChannelData(chatType)
  if not chatData then
    return
  end
  local conversation = chatData:getChannelConversation()
  local channelActive = chatData:getChannelActive()
  self.bind.go_teamEmpty = not channelActive
  self.bind.go_bottom = channelActive
  self.bind.go_top = channelActive
  self:initConversation(conversation)
  self:setBackground()
  if chatData.channelChatCD > 0 then
    self.bind.go_blockChatBtn = true
    self.bind.go_sendBtnOn = false
    self.bind.go_sendBtnHighlight = false
    self.bind.txt_ChatCD = chatData.channelChatCD .. "s"
  else
    self:checkInputField()
  end
  chatData:setChannelChatTimeCountCallback(function(countTime)
    self.bind.txt_ChatCD = countTime .. "s"
  end)
  chatData:setChannelChatTimeEndCallback(function()
    self.bind.go_blockChatBtn = false
    self.bind.go_sendBtnOn = true
    self.bind.go_sendBtnHighlight = true
    self:checkInputField()
  end)
  if chatType == L_Const.chatType.world then
    self.bind.go_ChannelBtn = true
    self.bind.go_ChannelName = false
    self.bind.txt_ChannelName = L_WordsTpl:getValue("ui_chat_channels", {
      [0] = chatData:getCurrentChannelId()
    })
  elseif chatType == L_Const.chatType.team then
    self.bind.txt_noTeamDesc = L_WordsTpl:getValue("ui_chat_noteam")
    self.bind.go_ChannelBtn = false
    self.bind.go_ChannelName = true
    self.bind.txt_ChannelName2 = L_WordsTpl:getValue("ui_chat_channel_team")
  elseif chatType == L_Const.chatType.city then
    self.bind.txt_noTeamDesc = L_WordsTpl:getValue("ui_chat_nocity")
    self.bind.go_ChannelBtn = false
    self.bind.go_ChannelName = true
    if channelActive then
      local areaId = AzurWorld.MultiPlayerCityMgr:GetAreaId()
      local lineId = AzurWorld.MultiPlayerCityMgr:GetLineId()
      local tpl = worldAreaTpl:getTplById(areaId)
      local areaName = worldAreaTpl:getName(tpl)
      local name = L_WordsTpl:getValue("ui_chat_multimaincity", {
        [0] = areaName,
        [1] = lineId
      })
      self.bind.txt_ChannelName2 = name
    end
  elseif chatType == L_Const.chatType.map then
    self.bind.txt_noTeamDesc = L_WordsTpl:getValue("ui_chat_noparty")
    self.bind.go_ChannelBtn = false
    self.bind.go_ChannelName = true
    self.bind.txt_ChannelName2 = L_WordsTpl:getValue("ui_chat_channel_party")
  else
    self.bind.go_ChannelBtn = false
    self.bind.go_ChannelName = false
  end
  self:setEmotionModule(false)
  self:setCommonWords(false)
  self:checkInputField()
end

function this:checkInputField(newText)
  local chatType = self:getCurChatType()
  local chatData = L_ChatStore:getChannelData(chatType)
  if chatData and chatData.channelChatCD > 0 then
    return
  end
  if newText and newText ~= "" then
    self.bind.go_blockChatBtn = false
    self.bind.go_sendBtnOn = true
    self.bind.go_sendBtnHighlight = true
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
  self.bind.txt_ChatCD = L_WordsTpl:getValue("residual_code_modulechannelchat_02")
end

function this:initConversation(conversation)
  local msgList = L_ChatStore:getMessageList(conversation)
  local tmp = {}
  local lastMsg
  for i, v in pairs(msgList) do
    local timeMsg = L_ChatManager:parseTimeMsg(lastMsg, v)
    if timeMsg then
      table.insert(tmp, timeMsg)
    end
    lastMsg = v
    local msg = L_ChatManager:parseMsg(v, v.baseInfo)
    if msg.emotionData ~= nil then
      msg.emojiCallBack = handler(self, self.onClickEmotion)
    end
    table.insert(tmp, msg)
  end
  self.bind.scrollList_message:clear()
  self.bind.scrollList_message:insert_array(tmp)
  if 0 < #tmp then
    self.bind.go_emptyMessage = false
  end
  for i, v in pairs(self.modules.scrollList_message) do
    if v.playInitFX then
      v:playInitFX()
    end
  end
  self.methods.onClick_newMsg(self)
end

function this:onEvent_refreshMessage(data)
  if MenuTypeConvertToChatType[data.type] ~= self.data.tabId then
    return
  end
  if self.bindComponents.tableView_chat.verticalNormalizedPosition > 0.001 and not L_ChatStore:getIsMessageSendByMyself(data.chat) then
    self.data.unreadMsgNum = self.data.unreadMsgNum + 1
    self.bind.txt_newMsgBtn = L_WordsTpl:getValue("ui_chat_received_new_message")
    local isBottom = self.bindComponents.content.rect.height <= self.bindComponents.viewport.rect.height
    self:insertNewMsg(data.chat, isBottom)
    if not isBottom then
      self.bind.go_newMsgBtn = true
    end
  else
    self:insertNewMsg(data.chat, true)
    self.methods.onClick_newMsg(self)
  end
end

function this:onEvent_refreshChannelRecord()
  self:initMessageList()
  self:setBackground()
end

function this:onEvent_refreshWorldChannelCD()
  self.bindComponents.input_text.text = ""
  self:InitChatCD(MenuType.worldChat)
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
  local msg = L_ChatManager:parseMsg(message, message.baseInfo)
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
    self.bind.go_emptyMessage = false
  end
  if count > L_GameTpl:getGameConstTpl():getWorldChannelChatMaxLimit() then
    self.bind.scrollList_message:remove(1)
  end
end

function this:switchChannel()
  local function callbackGetMaxNum(count)
    local data = {
      txtTitle = L_WordsTpl:getValue("ui_chat_changechannels"),
      
      placeHolder = L_WordsTpl:getValue("ui_chat_channels_enter", {
        [0] = count
      }),
      limit = 5,
      textBoxType = L_Const.CommonTextBoxType.PureNumber,
      keepPageOpen = true,
      active_edit_icon = false,
      confirmCallback = function(txt)
        local id = tonumber(txt)
        if not id then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_chat_entertruechannel"))
          return
        end
        if id < 1 or id > count then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_chat_entertruechannel"))
          return
        end
        if id == L_ChatStore:getCurrentWorldChannelId() then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_chat_channel_current", {
            [0] = L_ChatStore:getCurrentWorldChannelId()
          }))
          return
        end
        
        local function callback()
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_chat_channel_switch", {
            [0] = L_ChatStore:getCurrentWorldChannelId()
          }))
          L_UI:close("pageCommonTextBox")
        end
        
        L_ChatStore:req_chatWorldJoin(id, callback)
      end
    }
    L_GameUtil.showNormalTextBox(data)
  end
  
  L_ChatStore:req_chatWorldMaxNum(callbackGetMaxNum)
end

function this:HandleSendMessage()
  local chatType = self:getCurChatType()
  local chatData = L_ChatStore:getChannelData(chatType)
  if chatData.channelChatCD > 0 then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_chat_cd", {
      [0] = chatData.channelChatCD
    }))
    return
  end
  if self.bindComponents.input_text.text ~= "" then
    local function callback()
      self.bindComponents.input_text.text = ""
      
      self:InitChatCD(chatType)
    end
    
    L_ChatStore:req_sendChatInfo(chatData:getCurrentChannelId(), chatType, L_Const.ChatInfoType.CHAT_NORMAL, self.bindComponents.input_text.text, false, callback)
  else
    L_FlyMsgManager:showNormalMsgByKey("tips_chat_cannotsendempty")
  end
end

function this:InitChatCD(chatType)
  local chatType = chatType or self:getCurChatType()
  local chatData = L_ChatStore:getChannelData(chatType)
  self.bind.go_blockChatBtn = true
  self.bind.txt_ChatCD = chatData.channelChatCD .. "s"
  self.bind.go_sendBtnOn = false
  self.bind.go_sendBtnHighlight = false
  chatData:InitChatCD()
end

function this:onPlayerInOut(isPlayerIn)
  if self.data.tabId == MenuType.teamChat then
    self.bind.go_teamEmpty = not C_MultiTeam.IsInMultiTeam()
    self.bind.go_bottom = C_MultiTeam.IsInMultiTeam()
    self.bind.go_top = C_MultiTeam.IsInMultiTeam()
    self:setBackground()
    L_ChatStore:updateTeamChannelGetNewMessage(false)
  end
end

function this:updateReddot()
  local chatType = self:getCurChatType()
  local chatData = L_ChatStore:getChannelData(chatType)
  chatData:updateChannelGetNewMessage(false)
end

function this:closePagePlayerDetailInfo()
  self:emit("onClick_close")
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

function this:setEmotionModule(isActive)
  if isActive then
    C_AudioManager.Play("Play_SFX_System_UI_General_Frame_Open")
  else
    C_AudioManager.Play("Play_SFX_System_UI_General_Frame_Close")
  end
  self.bind.go_moduleEmoticon = isActive
  self.bind.go_btnMaskR = isActive
  self.bind.go_btnMaskL = isActive
  if isActive then
    self.bind.color_input_emo = CLOLOR_EMOs
  else
    self.bind.color_input_emo = CLOLOR_EMOd
  end
end

function this:setCommonWords(isActive)
  self.bind.go_moduleCommonWords = isActive
  self.bind.go_btnMaskR = isActive
  self.bind.go_btnMaskL = isActive
  if isActive then
    self.bind.color_input_img = CLOLOR_EMOs
  else
    self.bind.color_input_img = CLOLOR_EMOd
  end
end

function this:playOpenAnim()
  if not self.bindComponents.anim_channelChat then
    return
  end
  self.bindComponents.anim_channelChat:Stop()
  self.bindComponents.anim_channelChat:Play("anim_channel_chat_in")
end

function this:playSwitchAnim(isOpen)
  if not self.bindComponents.anim_channelChat then
    return
  end
  self.bindComponents.anim_channelChat:Stop()
  if isOpen then
    self.bindComponents.anim_channelChat:Play("anim_channel_chat_in")
  else
    self.bindComponents.anim_channelChat:Play("anim_channel_chat_close")
  end
end

function this:playCloseAnim()
  if not self.bindComponents.anim_channelChat then
    return
  end
  self.bindComponents.anim_channelChat:Stop()
  self.bindComponents.anim_channelChat:Play("anim_channel_chat_close")
end

function this:playSwitchChatAnim()
  if not self.bindComponents.anim_channelChat then
    return
  end
  self.bindComponents.anim_channelChat:Stop()
  self.bindComponents.anim_channelChat:Play("anim_channel_chat_switch")
  L_AudioUtil.playSound("Play_SFX_System_UI_Chat_WorldTeam_Switch")
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
  self.bind.color_btnEmotion = self.bind.go_moduleEmoticon and COLOR_BLUE or COLOR_GREY
  self:setCommonWords(false)
  self:setEmotionModule(not self.bind.go_moduleEmoticon)
  self.modules.module_emotion:initModule(ChatTypeToMenuType[self.data.tabId], -1, {groupId = groupId, emojiId = emojiId})
  if L_UI:checkPageOpen("pageChatEmotion") then
    L_UI:close("pageChatEmotion")
  end
end

function this:onSetSelectTabId(tabId)
  self.data.tabId = tabId
  self.data.menuType = self.data.tabId
  self.limit = L_GameTpl:getGameConstTpl():getMaxChat()
  if self.isBind then
    self:initMessageList()
  end
end

function this:setBackground()
  local curBackgroundConfigId = AzurWorld.ChatMgr:GetByChatBackgroundId()
  local tpl = _chatBackgroundTpl:getTplById(curBackgroundConfigId)
  local background = BackgroundDefault
  local chatType = self:getCurChatType()
  local chatData = L_ChatStore:getChannelData(chatType)
  if not chatData:getChannelActive() then
    self.bind.img_background = background
  else
    if tpl and _chatBackgroundTpl:getShowType(tpl) ~= 0 then
      background = _chatBackgroundTpl:getBackgroundRes(tpl)
    end
    self.bind.img_background = background
  end
end

function this:getCurChatType()
  return ChatTypeToMenuType[self.data.tabId]
end

return this
