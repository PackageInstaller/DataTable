local PlayerDictionaryData = class("PlayerDictionaryData")
local Status = {
  Uncompleted = 0,
  Unreceived = 1,
  Received = 2
}

function PlayerDictionaryData:Init()
  self._tbEntryStatus = {}
  self._tbEntryId = {}
  self:ProcessTableData()
end

function PlayerDictionaryData:ProcessTableData()
  local function func_ForEach_DictionaryEntry(mapData)
    if self._tbEntryId[mapData.Tab] == nil then
      self._tbEntryId[mapData.Tab] = {}
    end
    self._tbEntryId[mapData.Tab][mapData.Index] = mapData.Id
    if mapData.FinishType == GameEnum.questCompleteCond.ClientReport then
      self._tbEntryStatus[mapData.Id] = Status.Uncompleted
    end
  end
  
  ForEachTableLine(DataTable.DictionaryEntry, func_ForEach_DictionaryEntry)
end

function PlayerDictionaryData:GetEntryStatus(nId)
  return self._tbEntryStatus[nId] or Status.Uncompleted
end

function PlayerDictionaryData:GetCompletedEntry(bAll)
  local tbList = {}
  for nId, nStatus in pairs(self._tbEntryStatus) do
    if nStatus == Status.Received or nStatus == Status.Unreceived then
      local mapCfg = ConfigTable.GetData("DictionaryEntry", nId)
      local mapTab = ConfigTable.GetData("DictionaryTab", mapCfg.Tab)
      if bAll or not mapTab.HideInBattle then
        local mapData = {
          nId = nId,
          nIndex = mapCfg.Index,
          nSort = mapCfg.Sort,
          sTitle = mapCfg.Title,
          nTab = mapCfg.Tab,
          bUnreceived = nStatus == Status.Unreceived
        }
        table.insert(tbList, mapData)
      end
    end
  end
  return tbList
end

function PlayerDictionaryData:GetUncompletedEntry()
  local tbList = {}
  for nId, nStatus in pairs(self._tbEntryStatus) do
    if nStatus == Status.Uncompleted then
      table.insert(tbList, nId)
    end
  end
  return tbList
end

function PlayerDictionaryData:CacheDictionaryData(tbData)
  if not tbData then
    return
  end
  for _, mapTab in pairs(tbData) do
    for _, mapEntry in pairs(mapTab.Entries) do
      local nId = self._tbEntryId[mapTab.TabId][mapEntry.Index]
      if nId then
        self._tbEntryStatus[nId] = mapEntry.Status
        self:UpdateDictionarySubRedDot(mapTab.TabId, mapEntry.Index, mapEntry.Status)
      else
        printError("DictionaryEntry表变更，TabId" .. mapTab.TabId .. ";Index" .. mapEntry.Index .. "对应的词条未找到")
      end
    end
  end
end

function PlayerDictionaryData:ChangeDictionaryData(mapData)
  local nId = self._tbEntryId[mapData.TabId][mapData.Index]
  if nId == nil then
    return
  end
  if not self._tbEntryStatus[nId] or self._tbEntryStatus[nId] == Status.Uncompleted then
    local mapCfg = ConfigTable.GetData("DictionaryEntry", nId)
    if mapCfg ~= nil and mapCfg.Popup == true then
      PlayerData.SideBanner:AddDictionaryEntry(nId)
    end
  end
  self._tbEntryStatus[nId] = mapData.Status
  self:UpdateDictionarySubRedDot(mapData.TabId, mapData.Index, mapData.Status)
end

function PlayerDictionaryData:SendDictRewardReq(nTabId, nIndex, callback)
  local mapMsg = {TabId = nTabId, Index = nIndex}
  
  local function successCallback(_, mapData)
    local mapReward = PlayerData.Item:ProcessRewardChangeInfo(mapData)
    if nIndex == 0 then
      for nEntryIndex, nId in pairs(self._tbEntryId[nTabId]) do
        self._tbEntryStatus[nId] = Status.Received
        self:UpdateDictionarySubRedDot(nTabId, nEntryIndex, Status.Received)
      end
    else
      local nId = self._tbEntryId[nTabId][nIndex]
      self._tbEntryStatus[nId] = Status.Received
      self:UpdateDictionarySubRedDot(nTabId, nIndex, Status.Received)
    end
    if callback then
      callback(mapReward)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.dictionary_reward_receive_req, mapMsg, nil, successCallback)
end

function PlayerDictionaryData:UpdateDictionarySubRedDot(nTabId, nIndex, nStatus)
  RedDotManager.SetValid(RedDotDefine.Dictionary_Sub, {nTabId, nIndex}, nStatus == Status.Unreceived)
end

return PlayerDictionaryData
