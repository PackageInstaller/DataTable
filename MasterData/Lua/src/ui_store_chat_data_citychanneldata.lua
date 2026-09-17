local this = class("cityChannelData", require(L_R.store .. "chat.data.chatChannelBaseData"))

function this:ctor(channelDataList)
  local channelType = L_Const.chatType.city
  self.init(self, channelType, channelDataList)
end

function this:getRefreshEventId()
  return L_ChatStore.event.refreshCurrentCityChannelId
end

function this:getInitChannelChatCD()
  return L_GameTpl:getGameConstTpl():getCityChatCD()
end

function this:getCurrentChannelId()
  local areaId = AzurWorld.MultiPlayerCityMgr:GetAreaId()
  local lineId = AzurWorld.MultiPlayerCityMgr:GetLineId()
  return areaId * 4.294967296E9 + lineId
end

function this:getChannelActive()
  return AzurWorld.MultiPlayerCityMgr:IsInMultiPlayerCity()
end

function this:isNeedCheckFreq()
  return true
end

return this
