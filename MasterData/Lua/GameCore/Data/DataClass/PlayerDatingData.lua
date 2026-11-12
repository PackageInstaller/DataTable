local PlayerDatingData = class("PlayerDatingData")
local FREE_DATING_COUNT = 99

function PlayerDatingData:Init()
  self.tbDatingCharIds = 0
  self.nAllDatingCount = 0
  self.bFreeDating = false
  self.tbLandmarkCfg = {}
  self.mapCharLimitedEvent = {}
  self.mapCharStartEvent = {}
  self.mapCharEndEvent = {}
  self.mapCharLandmark = {}
  self.nCurSelectLandmark = 0
  self.mapDelay = nil
  EventManager.Add(EventId.IsNewDay, self, self.OnEvent_NewDay)
  self:InitConfig()
end

function PlayerDatingData:UnInit()
  EventManager.Remove(EventId.IsNewDay, self, self.OnEvent_NewDay)
end

function PlayerDatingData:InitConfig()
  self.nAllDatingCount = ConfigTable.GetConfigNumber("Dating_Max_Daily_Count")
  
  local function funcForeachLandmark(mapData)
    table.insert(self.tbLandmarkCfg, mapData)
  end
  
  ForEachTableLine(DataTable.DatingLandmark, funcForeachLandmark)
  
  local function funcForeachCharEvent(mapData)
    if mapData.DatingEventType == GameEnum.DatingEventType.LimitedLandmark then
      local param = decodeJson(mapData.DatingEventParams)
      if mapData.DatingEventParams ~= nil and #mapData.DatingEventParams == 2 then
        local nCharId = tonumber(mapData.DatingEventParams[1])
        local nLandmark = tonumber(mapData.DatingEventParams[2])
        if self.mapCharLimitedEvent[nCharId] == nil then
          self.mapCharLimitedEvent[nCharId] = {}
        end
        local data = {
          Id = mapData.Id,
          LandMark = nLandmark,
          Status = AllEnum.DatingEventStatus.Lock
        }
        self.mapCharLimitedEvent[nCharId][mapData.Id] = data
        RedDotManager.SetValid(RedDotDefine.Phone_Dating_Reward, {
          nCharId,
          mapData.Id
        }, false)
        if self.mapCharLandmark[nCharId] == nil then
          self.mapCharLandmark[nCharId] = {}
        end
        if self.mapCharLandmark[nCharId][nLandmark] == nil then
          self.mapCharLandmark[nCharId][nLandmark] = {}
        end
        table.insert(self.mapCharLandmark[nCharId][nLandmark], mapData.Id)
      end
    end
  end
  
  ForEachTableLine(ConfigTable.Get("DatingCharacterEvent"), funcForeachCharEvent)
  
  local function funcForeachStartEndEvent(mapData)
    if mapData.DatingEventType == GameEnum.DatingEventType.Start then
      local nCharId = tonumber(mapData.DatingEventParams[1])
      if self.mapCharStartEvent[nCharId] == nil then
        self.mapCharStartEvent[nCharId] = {}
      end
      table.insert(self.mapCharStartEvent[nCharId], mapData.Id)
    elseif mapData.DatingEventType == GameEnum.DatingEventType.End then
      local nCharId = tonumber(mapData.DatingEventParams[1])
      if self.mapCharEndEvent[nCharId] == nil then
        self.mapCharEndEvent[nCharId] = {}
      end
      table.insert(self.mapCharEndEvent[nCharId], mapData.Id)
    end
  end
  
  ForEachTableLine(ConfigTable.Get("DatingStartEndEvent"), funcForeachStartEndEvent)
  
  local function foreachResponse(line)
    if nil == CacheTable.GetData("_DatingCharResponse", line.CharId) then
      CacheTable.SetData("_DatingCharResponse", line.CharId, {})
    end
    CacheTable.GetData("_DatingCharResponse", line.CharId)[line.Type] = line
  end
  
  ForEachTableLine(DataTable.DatingCharResponse, foreachResponse)
end

function PlayerDatingData:RefreshDatingCharIds(tbChar)
  self.tbDatingCharIds = tbChar
end

function PlayerDatingData:AddDatingCharId(nCharId)
  if self:IsFreeDating() then
    return
  end
  for _, v in ipairs(self.tbDatingCharIds) do
    if v == nCharId then
      printError("重复邀约！！！")
      return
    end
  end
  table.insert(self.tbDatingCharIds, nCharId)
end

function PlayerDatingData:CacheDatingCharIds(tbChar)
  self.tbDatingCharIds = tbChar
end

function PlayerDatingData:SetFreeDating(bFree)
  self.bFreeDating = bFree == true
end

function PlayerDatingData:IsFreeDating()
  return self.bFreeDating == true
end

function PlayerDatingData:GetRandomLandmark(nCharId)
  local mapCharData = ConfigTable.GetData("DatingCharTag", nCharId)
  local nCharSetTag = 0
  if mapCharData ~= nil and mapCharData.CharSetTag ~= nil then
    nCharSetTag = mapCharData.CharSetTag
  end
  local tbLandMark = {}
  for _, v in ipairs(self.tbLandmarkCfg) do
    if v.CharAvailableSetTag ~= nil and 0 < #v.CharAvailableSetTag then
      if 0 < table.indexof(v.CharAvailableSetTag, nCharSetTag) then
        table.insert(tbLandMark, v)
      end
    else
      table.insert(tbLandMark, v)
    end
  end
  if #tbLandMark <= 3 then
    return tbLandMark
  end
  local tbResult = {}
  local tbRandom = {}
  for i = 1, #tbLandMark do
    tbRandom[i] = i
  end
  math.randomseed(os.time())
  math.random()
  math.random()
  math.random()
  for i = 1, 3 do
    local randomIndex = math.random(#tbRandom)
    local nSelectIndex = tbRandom[randomIndex]
    table.insert(tbResult, tbLandMark[nSelectIndex])
    table.remove(tbRandom, randomIndex)
  end
  return tbResult
end

function PlayerDatingData:CheckHasNewEvent(nCharId, nLandmark)
  local charData = PlayerData.Char:GetCharDatingEvent(nCharId)
  if charData ~= nil and self.mapCharLimitedEvent[nCharId] ~= nil then
    for nEId, v in pairs(self.mapCharLimitedEvent[nCharId]) do
      if v.LandMark == nLandmark and v.Status == AllEnum.DatingEventStatus.Lock then
        return true
      end
    end
  end
  return false
end

function PlayerDatingData:RefreshLimitedEventList(nCharId, tbDatingEventIds, tbDatingEventRewardIds)
  if self.mapCharLimitedEvent[nCharId] ~= nil then
    for nEId, v in pairs(self.mapCharLimitedEvent[nCharId]) do
      for _, nId in ipairs(tbDatingEventIds) do
        if nId == nEId and self.mapCharLimitedEvent[nCharId][nEId].Status == AllEnum.DatingEventStatus.Lock then
          self.mapCharLimitedEvent[nCharId][nEId].Status = AllEnum.DatingEventStatus.Unlock
          RedDotManager.SetValid(RedDotDefine.Phone_Dating_Reward, {nCharId, nEId}, true)
          break
        end
      end
      if tbDatingEventRewardIds ~= nil then
        for _, nId in ipairs(tbDatingEventRewardIds) do
          if nId == nEId then
            self.mapCharLimitedEvent[nCharId][nEId].Status = AllEnum.DatingEventStatus.Received
            RedDotManager.SetValid(RedDotDefine.Phone_Dating_Reward, {nCharId, nEId}, false)
            break
          end
        end
      end
    end
  end
  if PlayerData.Phone ~= nil then
    PlayerData.Phone:RefreshRedDot()
  end
end

function PlayerDatingData:GetLimitedEventList(nCharId)
  local mapData = {}
  if self.mapCharLimitedEvent[nCharId] ~= nil then
    for nEId, v in pairs(self.mapCharLimitedEvent[nCharId]) do
      table.insert(mapData, v)
    end
  end
  table.sort(mapData, function(a, b)
    return a.Id < b.Id
  end)
  return mapData
end

function PlayerDatingData:GetDatingCount()
  if self:IsFreeDating() then
    return FREE_DATING_COUNT, FREE_DATING_COUNT
  end
  return #self.tbDatingCharIds, self.nAllDatingCount
end

function PlayerDatingData:CheckDating(nCharId)
  if self:IsFreeDating() then
    return false
  end
  local bDating = false
  for _, v in ipairs(self.tbDatingCharIds) do
    if v == nCharId then
      bDating = true
      break
    end
  end
  return bDating
end

function PlayerDatingData:SetCurLandmarkId(nLandmarkId)
  self.nCurSelectLandmark = nLandmarkId
end

function PlayerDatingData:GetCurLandmarkId()
  return self.nCurSelectLandmark
end

function PlayerDatingData:SetCharFavourLevelUpDelay(mapData)
  self.mapDelay = mapData
end

function PlayerDatingData:GetCharFavourLevelUpDelay()
  return self.mapDelay
end

function PlayerDatingData:GetCharStartEventId(nCharId)
  if self.mapCharStartEvent[nCharId] ~= nil then
    local nRandom = math.random(1, #self.mapCharStartEvent[nCharId])
    return self.mapCharStartEvent[nCharId][nRandom]
  end
end

function PlayerDatingData:GetCharBranchEventId(nCharId, bFirstBranch)
  local nEventId = 0
  local nBranchType = bFirstBranch and GameEnum.DatingEventType.BranchA or GameEnum.DatingEventType.BranchB
  
  local function funcForeachEvent(mapData)
    if #mapData.DatingEventParams > 0 and mapData.DatingEventParams[1] == self.nCurSelectLandmark then
      for k, v in pairs(mapData.DatingEventExclude) do
        if v == nCharId then
          return
        end
      end
      if mapData.DatingEventType == nBranchType then
        nEventId = mapData.Id
      end
    end
  end
  
  ForEachTableLine(ConfigTable.Get("DatingBranch"), funcForeachEvent)
  return nEventId
end

function PlayerDatingData:GetCharEndEventId(nCharId)
  if self.mapCharEndEvent[nCharId] ~= nil then
    local nRandom = math.random(1, #self.mapCharEndEvent[nCharId])
    return self.mapCharEndEvent[nCharId][nRandom]
  end
end

function PlayerDatingData:CheckSpecialOption(nOptId, nCharId, nLandmarkId)
  if self.mapCharLandmark[nCharId] ~= nil and self.mapCharLandmark[nCharId][nLandmarkId] ~= nil then
    local tbEvent = self.mapCharLandmark[nCharId][nLandmarkId]
    for _, nId in ipairs(tbEvent) do
      local mapCfg = ConfigTable.GetData("DatingCharacterEvent", nId)
      if mapCfg ~= nil and mapCfg.DatingEventType == GameEnum.DatingEventType.LimitedLandmark and mapCfg.BranchTag == nOptId then
        return true
      end
    end
  end
  return false
end

function PlayerDatingData:SendDatingLandmarkSelectMsg(nCharId, nLandmarkId, callback)
  local function successCallback(_, msgData)
    self:SetCurLandmarkId(nLandmarkId)
    
    self:AddDatingCharId(nCharId)
    if callback ~= nil then
      callback(msgData)
    end
  end
  
  local sendData = {CharId = nCharId, LandmarkId = nLandmarkId}
  HttpNetHandler.SendMsg(NetMsgId.Id.char_dating_landmark_select_req, sendData, nil, successCallback)
end

function PlayerDatingData:SendReceiveDatingEventRewardMsg(nCharId, nEventId, callback)
  local function successCallback(_, msgData)
    self.mapCharLimitedEvent[nCharId][nEventId].Status = AllEnum.DatingEventStatus.Received
    
    RedDotManager.SetValid(RedDotDefine.Phone_Dating_Reward, {nCharId, nEventId}, false)
    PlayerData.Phone:RefreshRedDot()
    UTILS.OpenReceiveByChangeInfo(msgData, callback)
  end
  
  local sendData = {CharId = nCharId, EventId = nEventId}
  HttpNetHandler.SendMsg(NetMsgId.Id.char_dating_event_reward_receive_req, sendData, nil, successCallback)
end

function PlayerDatingData:SendDatingSendGiftMsg(nCharId, tbItems, callback)
  local function successCallback(_, msgData)
    if callback ~= nil then
      callback(msgData)
    end
  end
  
  local sendData = {CharId = nCharId, Items = tbItems}
  HttpNetHandler.SendMsg(NetMsgId.Id.char_dating_gift_send_req, sendData, nil, successCallback)
end

function PlayerDatingData:OnEvent_NewDay()
  self.tbDatingCharIds = {}
end

return PlayerDatingData
