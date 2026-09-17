local this = class("partyChannelData", require(L_R.store .. "chat.data.chatChannelBaseData"))

function this:ctor(channelDataList)
  local channelType = L_Const.chatType.map
  self.init(self, channelType, channelDataList)
end

function this:getRefreshEventId()
  return L_ChatStore.event.refreshCurrentPartyChannelId
end

function this:getInitChannelChatCD()
  return L_GameTpl:getGameConstTpl():getPartyChatCD()
end

function this:getCurrentChannelId()
  return CS.Lens.Gameplay.UI.PopperPartyStore.GetStore():GetLineId()
end

function this:getChannelActive()
  return AzurWorld.popperPartyMgr:IsInPopperPary()
end

return this
