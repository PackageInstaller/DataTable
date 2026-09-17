local this = class("conversation")

function this:ctor()
  self.playerUid = nil
  self.chats = {}
  self.lastOrder = -1
  self.readedOrder = -1
  self.currentOrder = -1
  self.sendOrder = -1
  self.upgrade = 0
  self.num = 0
  self.hasReqChat = false
  self.chatTimes = {}
  self.chatMessages = {}
  self.chatSpamLimit = false
  self.chatSpamLimitTime = 0
end

function this:clear()
  self.playerUid = nil
  self.chats = {}
  self.lastOrder = -1
  self.readedOrder = -1
  self.currentOrder = -1
  self.upgrade = 0
  self.num = 0
  self.hasReqChat = false
end

return this
