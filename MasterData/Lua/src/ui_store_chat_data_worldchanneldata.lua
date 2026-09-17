local this = class("worldChannelData", require(L_R.store .. "chat.data.chatChannelBaseData"))

function this:ctor(channelDataList)
  local channelType = L_Const.chatType.world
  self.init(self, channelType, channelDataList)
end

function this:getRefreshEventId()
  return L_ChatStore.event.refreshCurrentWorldChannelId
end

function this:getInitChannelChatCD()
  return L_GameTpl:getGameConstTpl():getWorldChatCD()
end

return this
