local this = class("moduleChatEmotion", G_UIModuleBase)
local emojiGroupTpl = L_GameTpl:getChatEmojiGroupTpl()
local emojiTpl = L_GameTpl:getChatEmojiTpl()
local EMOTION_COLLECTIED_GROUP_ID = 1
local COLOR_GREY = C_LuaUtility.ParseHtmlStringColor("#8b8c8f")

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    selectType = nil,
    chatType = -1,
    relateId = -1,
    showEmojiList = nil
  }
end

function this.bind()
  return {
    txt_title = "",
    scrollList_emotionType = {
      moduleName = "pages/chat/cellEmotionType"
    },
    scrollList_emotion = {
      moduleName = "pages/chat/cellEmotion"
    },
    emotionFocusItemIndex = 0
  }
end

function this.methods()
  return {
    scrollList_emotionType = {
      onClick_select = function(self, bind)
        L_ChatStore:call(L_ChatStore.event.refreshEmojiRedDot)
        self:redMarkNew(bind.type)
        if not bind.go_active then
          self.data.selectType = bind.type
          self.bind.txt_title = emojiGroupTpl:getNameById(self.data.selectType)
          self:initEmotionList()
          self:setEmotionTypeListActive()
        end
      end
    },
    scrollList_emotion = {
      onClick_select = function(self, bind)
        self:sendMessage(bind)
      end
    },
    onClose = function(self)
    end
  }
end

function this:open(options)
  L_ChatStore:listenCallFunc(L_ChatStore.event.refreshEmojiInfo, self.onEvent_refreshEmojiInfo, self)
  this.super.open(self, options)
end

function this:close(options)
  L_ChatStore:unListenCallFunc(L_ChatStore.event.refreshEmojiInfo, self.onEvent_refreshEmojiInfo, self)
  this.super.close(self, options)
end

function this:initModule(chatType, relateId, options)
  self:initEmotionTypeList(options)
  self.data.selectType = self.data.selectType or self.bind.scrollList_emotionType:getValue(1, "type")
  self:initEmotionList(options)
  self:setEmotionTypeListActive()
  self.data.chatType = chatType
  self.data.relateId = relateId
  L_ReddotManager:setDirty(L_ReddotManager.DotDef.NewEmojiType, true)
  L_ReddotManager:setDirty(L_ReddotManager.DotDef.NewEmoji, true)
  self:redMarkNew(self.data.selectType)
end

function this:initEmotionTypeList(options)
  local tmp = {}
  table.insert(tmp, {
    type = EMOTION_COLLECTIED_GROUP_ID,
    img_heart_icon = emojiGroupTpl:getIcon(emojiGroupTpl:getTplById(EMOTION_COLLECTIED_GROUP_ID)),
    txt_name_normal = emojiGroupTpl:getNameById(EMOTION_COLLECTIED_GROUP_ID)
  })
  for groupId, _ in pairs(L_ChatStore.data.emojiOwnedDic) do
    local tpl = emojiGroupTpl:getTplById(groupId)
    table.insert(tmp, {
      type = groupId,
      img_icon = emojiGroupTpl:getIcon(tpl),
      txt_name_normal = emojiGroupTpl:getName(tpl)
    })
  end
  table.sort(tmp, function(a, b)
    return a.type < b.type
  end)
  self.bind.scrollList_emotionType:clear()
  self.bind.scrollList_emotionType:insert_array(tmp)
  self.bind.scrollList_emotionType:getItemCls(1):setFirst(true)
  if options then
    local typeIndex = -1
    if table.count(tmp) > 0 then
      for index, group in pairs(tmp) do
        if options ~= nil and group.type == options.groupId then
          typeIndex = index
        end
      end
      if typeIndex ~= -1 then
        self.bind.txt_title = tmp[typeIndex].txt_name_normal
      else
        self.bind.txt_title = tmp[1].txt_name_normal
      end
    end
    if typeIndex ~= -1 then
      self.data.selectType = options.groupId
    end
  elseif not self.data.selectType then
    self.bind.txt_title = tmp[1].txt_name_normal
  end
end

function this:initEmotionList(options)
  if self.data.selectType == EMOTION_COLLECTIED_GROUP_ID then
    self:initEmotionCollectedList()
  else
    self:initEmotionGroupList(options)
  end
end

function this:initEmotionCollectedList()
  local emojiIdList = L_ChatStore:getEmojiCollectedList()
  local tmp = {}
  table.insert(tmp, {
    isEditButton = true,
    txt_name = L_WordsTpl:getValue("residual_code_modulechatemotion_01"),
    img_emotion = "",
    first = true
  })
  for _, emojiId in pairs(emojiIdList) do
    table.insert(tmp, {
      isEditButton = false,
      id = emojiId,
      groupId = EMOTION_COLLECTIED_GROUP_ID
    })
  end
  self:insertEmptyCell(tmp, EMOTION_COLLECTIED_GROUP_ID)
  self.bind.scrollList_emotion:clear()
  self.bind.scrollList_emotion:insert_array(tmp)
  self.data.showEmojiList = tmp
end

function this:initEmotionGroupList(options)
  local emojiDict = L_ChatStore:getEmojiOwnedDic()
  local data = emojiDict[self.data.selectType]
  local tmp = {}
  local emojiIndex = -1
  for i, v in pairs(data) do
    local emojiId = v
    table.insert(tmp, {
      isEditButton = false,
      id = emojiId,
      groupId = self.data.selectType
    })
    if options ~= nil and emojiId == options.emojiId then
      emojiIndex = table.count(tmp)
    end
  end
  self:insertEmptyCell(tmp, self.data.selectType)
  self.bind.scrollList_emotion:clear()
  self.bind.scrollList_emotion:insert_array(tmp)
  self.data.showEmojiList = tmp
  if emojiIndex ~= -1 then
    self.bind.emotionFocusItemIndex = emojiIndex
  end
end

function this:insertEmptyCell(tmp, groupId)
  local colCount = 4
  if 0 < #tmp and #tmp < colCount * 2 then
    for i = #tmp + 1, colCount * 2 do
      table.insert(tmp, {
        isEditButton = false,
        id = 0,
        groupId = groupId
      })
    end
  end
end

function this:setEmotionTypeListActive()
  for i = 1, #self.bind.scrollList_emotionType do
    local active = false
    if self.bind.scrollList_emotionType:getValue(i, "type") == self.data.selectType then
      active = true
    end
    self.bind.scrollList_emotionType:change(i, {go_select = active})
  end
end

function this:onEvent_refreshEmojiInfo()
  self:initEmotionTypeList()
  self:initEmotionList()
  self:setEmotionTypeListActive()
end

function this:sendMessage(bind)
  if self.data.chatType == -1 then
    return
  end
  if bind.isEditButton == true then
    L_UI:open("pageEmotionCollectEdit")
    return
  end
  if bind.id == 0 then
    return
  end
  
  local function callback()
    self.parent.bind.go_moduleEmoticon = false
    self.parent.bind.go_btnMaskR = false
    self.parent.bind.go_chatMask = false
    self.parent.bind.color_btnEmotion = COLOR_GREY
    self:emit("onClick_Send", self.bind)
  end
  
  if self.data.chatType == L_Const.chatType.personal then
    if self.data.relateId ~= -1 then
      local friend = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), self.data.relateId)
      L_ChatStore:req_sendChatInfo(self.data.relateId, L_Const.chatType.personal, L_Const.ChatInfoType.CHAT_EMOJI, tostring(bind.id), friend:getIsTarShield(), callback)
    end
  else
    local chatType = self.data.chatType
    local chatData = L_ChatStore:getChannelData(chatType)
    if 0 < chatData:getChannelChatCD() then
      L_FlyMsgManager:showNormalMsgByKey("tips_chat_cd", {
        [0] = chatData:getChannelChatCD()
      })
      return
    end
    L_ChatStore:req_sendChatInfo(chatData:getCurrentChannelId(), chatType, L_Const.ChatInfoType.CHAT_EMOJI, tostring(bind.id), false, callback)
  end
end

function this:redMarkNew(groupId)
  if groupId == EMOTION_COLLECTIED_GROUP_ID then
    return
  end
  L_TimerManager:newOrResetTimer(self, "redMarkNew", function()
    if self.data.showEmojiList then
      for i, v in pairs(self.data.showEmojiList) do
        L_ReddotManager:markNew(L_ReddotManager.DotDef.NewEmoji, v.id, true)
      end
    end
  end, 0.1)
end

return this
