local this = class("moduleChatCommonWords", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {chatType = -1, relateId = -1}
end

function this.bind()
  return {
    scrollList_commonWords = {
      moduleName = "pages/chat/cellCommonWords"
    }
  }
end

function this.methods()
  return {
    scrollList_commonWords = {
      onClick = function(self, bind)
        self:sendMessage(bind)
      end
    }
  }
end

function this:open(options)
  this.super.open(self, options)
end

function this:close(options)
  this.super.close(self, options)
end

function this:initModule(chatType, relateId)
  self:initCommonWordsList()
  self.data.chatType = chatType
  self.data.relateId = relateId
end

function this:initCommonWordsList()
  local chatQuickTpl = L_GameTpl:getChatQuickTpl()
  local data = chatQuickTpl.data
  local tmp = {}
  for i, v in pairs(data) do
    table.insert(tmp, {
      id = chatQuickTpl:getId(v),
      txt_name = chatQuickTpl:getWords(v)
    })
  end
  self.bind.scrollList_commonWords:clear()
  self.bind.scrollList_commonWords:insert_array(tmp)
end

function this:sendMessage(bind)
  if self.data.chatType == -1 then
    return
  end
  
  local function callback()
    self.parent.bind.go_moduleCommonWords = false
    self.parent.bind.go_chatMask = false
    self.parent.bind.go_btnMaskR = false
    self:emit("onClick_Send", self.bind)
  end
  
  if self.data.chatType == L_Const.chatType.personal then
    if self.data.relateId ~= -1 then
      local friend = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), self.data.relateId)
      L_ChatStore:req_sendChatInfo(self.data.relateId, L_Const.chatType.personal, L_Const.ChatInfoType.CHAT_COMMON, tostring(bind.id), friend:getIsTarShield(), callback)
    end
  else
    local chatType = self.data.chatType
    local chatData = L_ChatStore:getChannelData(chatType)
    if chatData:getChannelChatCD() > 0 then
      L_FlyMsgManager:showNormalMsgByKey("tips_chat_cd", {
        [0] = chatData:getChannelChatCD()
      })
      return
    end
    L_ChatStore:req_sendChatInfo(chatData:getCurrentChannelId(), chatType, L_Const.ChatInfoType.CHAT_COMMON, tostring(bind.id), false, callback)
  end
end

return this
