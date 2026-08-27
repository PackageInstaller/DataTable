local EpSavingDataCenter = class("EpSavingDataCache")

function EpSavingDataCenter:ctor()
  self.epSavingDataMsgDic = {}
end

function EpSavingDataCenter:TryGetEpSavingDataCache(envExplorationId)
  return self.epSavingDataMsgDic[envExplorationId]
end

function EpSavingDataCenter:SetEpSavingDataCacheDirty(envExplorationId)
  self.epSavingDataMsgDic[envExplorationId] = nil
end

function EpSavingDataCenter:SetEpSavingDataCache(envExplorationId, cacheMsg)
  self.epSavingDataMsgDic[envExplorationId] = cacheMsg
end

return EpSavingDataCenter
