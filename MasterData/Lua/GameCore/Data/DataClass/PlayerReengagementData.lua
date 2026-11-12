local PlayerReengagementData = class("PlayerReengagementData")
local REENGAGEMENT_RETURN_AVG_ID = "STev_02_01"
local LocalData = require("GameCore.Data.LocalData")
local RedDotManager = require("GameCore.RedDot.RedDotManager")
local SDKManager = CS.SDKManager.Instance

function PlayerReengagementData:Init()
  self:InitData()
end

function PlayerReengagementData:InitData()
  self._nActId = 0
  self._nOpenTime = 0
  self._nDoubleCount = 0
  self._nMaxDoubleCount = 0
  self._bDetailInited = false
  self._bReunionReceived = false
  self._mapLoginInfo = {}
  self._bAvgWatched = false
  self._mapQuestStateList = {}
  self._mapQuestPoint = {}
  self._mapMallInfo = {}
  self._tbBoughtBundles = {}
  self._mapWeeklyCard = {}
  self._mapQuestDataList = {}
  self._tbQuestConfig = {}
end

function PlayerReengagementData:CacheReturneeInfo(mapData)
  if mapData == nil then
    return
  end
  if mapData.Id == nil or mapData.Id == 0 then
    self:RefreshRedDot(true)
    self:InitData()
    return
  end
  if self._nActId ~= mapData.Id or self._nOpenTime ~= (mapData.OpenTime or 0) then
    self:RefreshRedDot(true)
    self:InitData()
  end
  self._nActId = mapData.Id or 0
  self._nOpenTime = mapData.OpenTime or 0
  self._bReunionReceived = mapData.ReunionReward == true
  self._bAvgWatched = mapData.Avg == true
  local mapActData = ConfigTable.GetData("ActivityReturnee", self._nActId)
  if mapActData ~= nil then
    self._nMaxDoubleCount = mapActData.DoubleCount or 0
  end
  self._nDoubleCount = math.max(self._nMaxDoubleCount - (mapData.DoubleCount or 0), 0)
  self:TryEnqueueReturnAvg()
  self:RefreshReengagementPopUp()
  
  local function fet(mapDataTb)
    if self._tbQuestConfig[mapDataTb.Id] == nil then
      self._tbQuestConfig[mapDataTb.Id] = mapDataTb
    end
    if self._mapQuestDataList[mapDataTb.GroupId] == nil then
      self._mapQuestDataList[mapDataTb.GroupId] = {}
    end
    self._mapQuestDataList[mapDataTb.GroupId][mapDataTb.Id] = {
      nId = mapDataTb.Id,
      nStatus = 0,
      Progress = {
        Cur = 0,
        Max = self:GetQuestMaxProgress(mapDataTb.Id)
      }
    }
  end
  
  ForEachTableLine(ConfigTable.Get("ActivityReturneeQuest"), fet)
  self:RefreshRedDot()
  if self:GetActIsOpen() then
    self:RequestReengagementInfo()
  end
  self._mapQuestPointConfig = {}
  
  local function ForeachActivity(mapQuestData)
    if mapQuestData.ReturneeId == self._nActId then
      table.insert(self._mapQuestPointConfig, mapQuestData)
    end
  end
  
  ForEachTableLine(ConfigTable.Get("ActivityReturneeQuestPoint"), ForeachActivity)
  table.sort(self._mapQuestPointConfig, function(a, b)
    return a.Point < b.Point
  end)
end

function PlayerReengagementData:RefreshRedDot(bClear)
  if self._nActId == 0 then
    return
  end
  local bActIsOpen = not bClear and self:GetActIsOpen()
  local nCurDay = 0
  if bActIsOpen then
    local nOpenDayStartTime = CS.ClientManager.Instance:GetNextRefreshTime(self._nOpenTime) - 86400
    nCurDay = math.floor((CS.ClientManager.Instance.serverTimeStamp - nOpenDayStartTime) / 86400)
  end
  for nGroupId, mapQuestList in pairs(self._mapQuestDataList) do
    local bCanReceive = false
    local mapGroupConfig = ConfigTable.GetData("ActivityReturneeQuestGroup", nGroupId)
    if bActIsOpen and mapGroupConfig ~= nil and mapGroupConfig.ReturneeId == self._nActId and nCurDay >= mapGroupConfig.DayOpen then
      for _, mapQuest in pairs(mapQuestList) do
        if mapQuest.nStatus == 1 then
          bCanReceive = true
          break
        end
      end
    end
    RedDotManager.SetValid(RedDotDefine.Activity_Reengagement_Task_Group, {
      self._nActId,
      nGroupId
    }, bCanReceive)
  end
  local bQuestPointReward = false
  if bActIsOpen then
    local nPoint = tonumber(self._mapQuestPoint.Point) or 0
    
    local function CheckQuestPointReward(mapConfig)
      if mapConfig.ReturneeId == self._nActId and nPoint >= mapConfig.Point and not self:CheckPointRewardReceived(mapConfig.Index) then
        bQuestPointReward = true
      end
    end
    
    ForEachTableLine(ConfigTable.Get("ActivityReturneeQuestPoint"), CheckQuestPointReward)
  end
  RedDotManager.SetValid(RedDotDefine.Activity_Reengagement_QuestPoint, self._nActId, bQuestPointReward)
  local mapLoginInfo = self._mapLoginInfo or {}
  local bLoginReward = bActIsOpen and (tonumber(mapLoginInfo.Receive) or 0) > (tonumber(mapLoginInfo.Actual) or 0)
  RedDotManager.SetValid(RedDotDefine.Activity_Reengagement_LoginReward, self._nActId, bLoginReward)
  local mapWeeklyCard = self._mapWeeklyCard or {}
  local bWeeklyCard = bActIsOpen and mapWeeklyCard.Id ~= nil and mapWeeklyCard.Id ~= "" and 0 < (tonumber(mapWeeklyCard.Remaining) or 0) and not mapWeeklyCard.Received
  RedDotManager.SetValid(RedDotDefine.Activity_Reengagement_WeeklyCard, self._nActId, bWeeklyCard)
end

function PlayerReengagementData:OnStateNotify()
  if self:GetActIsOpen() then
    self:RequestReengagementInfo()
  else
    self:RefreshRedDot()
  end
end

function PlayerReengagementData:RefreshReengagementPopUp()
  if not self:GetActIsOpen() then
    return
  end
  if not self:CheckCanReceive() then
    return
  end
  if ConfigTable.GetData("ActivityReturneeLoginRewardControl", self._nActId) == nil then
    return
  end
  PopUpManager.PopUpEnQueue(GameEnum.PopUpSeqType.Reengagement, {
    nActId = self._nActId
  })
end

function PlayerReengagementData:RequestReengagementInfo(callback)
  local nActId = self._nActId
  local nOpenTime = self._nOpenTime
  
  local function processCb(_, mapDataCb)
    if self._nActId ~= nActId or self._nOpenTime ~= nOpenTime then
      return
    end
    self._bReunionReceived = mapDataCb.Reunion.ReunionReward == true
    self._bAvgWatched = mapDataCb.Avg.Avg == true
    self._mapLoginInfo = mapDataCb.Login
    self._mapQuestPoint = {}
    local tbReceived = UTILS.ParseByteString(mapDataCb.QuestPoint.Received)
    self._mapQuestPoint.Received = tbReceived or {}
    self._mapQuestPoint.Point = tonumber(mapDataCb.QuestPoint.Point) or 0
    self._mapQuestStateList = {}
    for _, mapQuestList in pairs(self._mapQuestDataList) do
      for _, mapQuest in pairs(mapQuestList) do
        mapQuest.nStatus = 0
        mapQuest.Progress = {
          Cur = 0,
          Max = self:GetQuestMaxProgress(mapQuest.nId)
        }
      end
    end
    if mapDataCb.Quests ~= nil and mapDataCb.Quests.List ~= nil then
      for k, mapQuestData in pairs(mapDataCb.Quests.List) do
        local questConfig = ConfigTable.GetData("ActivityReturneeQuest", mapQuestData.Id)
        if questConfig ~= nil then
          local mapProgress = mapQuestData.Progress and mapQuestData.Progress[1]
          if mapProgress == nil then
            mapProgress = {
              Cur = 0,
              Max = self:GetQuestMaxProgress(mapQuestData.Id)
            }
          end
          local dataToInsert = {
            nId = mapQuestData.Id,
            nStatus = mapQuestData.Status,
            Progress = mapProgress
          }
          self._mapQuestStateList[mapQuestData.Id] = dataToInsert
          self._mapQuestDataList[questConfig.GroupId] = self._mapQuestDataList[questConfig.GroupId] or {}
          self._mapQuestDataList[questConfig.GroupId][mapQuestData.Id] = dataToInsert
        end
      end
    else
      self._mapQuestStateList = {}
    end
    self._mapWeeklyCard = {}
    self._mapMallInfo = mapDataCb.MallInfo
    if self._mapMallInfo ~= nil then
      self._tbBoughtBundles = self._mapMallInfo.Ids
      self._mapWeeklyCard = self._mapMallInfo.Card
    end
    self._bDetailInited = true
    self:RefreshRedDot()
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_returnee_info_req, {}, nil, processCb)
end

function PlayerReengagementData:GetAvgWatched()
  return self._bAvgWatched
end

function PlayerReengagementData:SetAvgWatched()
  local function cb()
    self._bAvgWatched = true
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_returnee_avg_req, {}, nil, cb)
end

function PlayerReengagementData:TryEnqueueReturnAvg()
  if self:GetAvgWatched() or not self:GetActIsOpen() then
    return
  end
  PopUpManager.PopUpEnQueue(GameEnum.PopUpSeqType.ReengagementAvg, true)
end

function PlayerReengagementData:PlayReturnAvg(callback)
  if self:GetAvgWatched() or not self:GetActIsOpen() then
    if callback ~= nil then
      callback()
    end
    return
  end
  local mapActData = ConfigTable.GetData("ActivityReturnee", self:GetActId())
  local sAvgId
  if mapActData ~= nil and mapActData.AVG ~= nil then
    sAvgId = mapActData.AVG
  else
    sAvgId = REENGAGEMENT_RETURN_AVG_ID
  end
  if type(sAvgId) ~= "string" or sAvgId == "" or sAvgId == "0" then
    if callback ~= nil then
      callback()
    end
    return
  end
  local bCallbackDone = false
  local func_Cancel
  
  local function func_Continue()
    EventManager.Remove("ForceCloseAllBeforeBackLogin", self, func_Cancel)
    PlayerData.Voice:ResumeBoardFreeTimer()
    if callback ~= nil then
      callback()
    end
  end
  
  local function func_LoadingClosed()
    EventManager.Remove(EventId.TransAnimOutClear, self, func_LoadingClosed)
    func_Continue()
  end
  
  local function func_AvgEnd()
    if bCallbackDone then
      return
    end
    bCallbackDone = true
    self:SetAvgWatched()
    EventManager.Remove("AvgSTEnd", self, func_AvgEnd)
    local sAvgIdHead = string.sub(sAvgId, 1, 2)
    if sAvgIdHead == "ST" or sAvgIdHead == "CG" then
      EventManager.Add(EventId.TransAnimOutClear, self, func_LoadingClosed)
    else
      func_Continue()
    end
  end
  
  function func_Cancel()
    bCallbackDone = true
    EventManager.Remove("AvgSTEnd", self, func_AvgEnd)
    EventManager.Remove(EventId.TransAnimOutClear, self, func_LoadingClosed)
    EventManager.Remove("ForceCloseAllBeforeBackLogin", self, func_Cancel)
    PlayerData.Voice:ClearTimer()
    PlayerData.Voice:ResumeBoardFreeTimer()
  end
  
  PlayerData.Voice:PauseBoardFreeTimer()
  EventManager.Add("ForceCloseAllBeforeBackLogin", self, func_Cancel)
  EventManager.Add("AvgSTEnd", self, func_AvgEnd)
  EventManager.Hit("StoryDialog_DialogStart", sAvgId, Settings.sCurrentTxtLanguage, Settings.sCurrentVoLanguage)
end

function PlayerReengagementData:CheckCanReceive()
  return not self._bReunionReceived
end

function PlayerReengagementData:CheckPointRewardReceived(nPointIndex)
  local tbReceived = self._mapQuestPoint.Received or {}
  for _, mapConfig in ipairs(self._mapQuestPointConfig or {}) do
    if nPointIndex <= mapConfig.Index and UTILS.IsBitSet(tbReceived, mapConfig.Index + 1) then
      return true
    end
  end
  return false
end

function PlayerReengagementData:IsQuestGroupAllReceived(nGroupIndex)
  local nGroupId = nGroupIndex + 100
  local nGroupQuestCount = 0
  for k, v in pairs(self._tbQuestConfig) do
    if v.GroupId == nGroupId then
      nGroupQuestCount = nGroupQuestCount + 1
    end
  end
  local nActual = 0
  local tbThisGroupQuestList = self:GetQuestListByGroup(nGroupId)
  if tbThisGroupQuestList == nil then
    return false
  end
  for _, v in pairs(tbThisGroupQuestList) do
    if v.nStatus == 2 then
      nActual = nActual + 1
    else
      return false
    end
  end
  if nGroupQuestCount > nActual then
    return false
  end
  return true
end

function PlayerReengagementData:GetQuestListByGroup(nGroupId)
  if self._mapQuestDataList == nil or next(self._mapQuestDataList) == nil then
    self:RequestReengagementInfo(function()
      return self._mapQuestDataList[nGroupId]
    end)
  else
    return self._mapQuestDataList[nGroupId]
  end
end

function PlayerReengagementData:GetQuestConfigDataByGroup(nGroupId)
  local tbThisGroup = {}
  for k, v in pairs(self._tbQuestConfig) do
    if v.GroupId == nGroupId then
      table.insert(tbThisGroup, v)
    end
  end
  return tbThisGroup
end

function PlayerReengagementData:GetQuestDataById(nQuestId)
  local function func()
    local ret = self._mapQuestStateList[nQuestId]
    
    if ret == nil then
      self._mapQuestStateList[nQuestId] = {
        nId = nQuestId,
        nStatus = 0,
        Progress = {
          Cur = 0,
          Max = self:GetQuestMaxProgress(nQuestId)
        }
      }
    end
    return self._mapQuestStateList[nQuestId]
  end
  
  if not self._bDetailInited then
    self:RequestReengagementInfo(function()
      return func()
    end)
  else
    return func()
  end
end

function PlayerReengagementData:GetQuestConfigDataById(nQuestId)
  return self._tbQuestConfig[nQuestId]
end

function PlayerReengagementData:GetQuestMaxProgress(nQuestId)
  local mapQuestConfig = self:GetQuestConfigDataById(nQuestId)
  if mapQuestConfig == nil then
    return 1
  end
  local tbParams = decodeJson(mapQuestConfig.CompleteParams)
  local nParamIndex = mapQuestConfig.CompleteCond == GameEnum.questCompleteCond.ItemsDeplete and 2 or 1
  return tonumber(tbParams[nParamIndex]) or 1
end

function PlayerReengagementData:GetActCfgData()
  return {}
end

function PlayerReengagementData:GetWeeklyCardData()
  if not self._bDetailInited then
    self:RequestReengagementInfo(function()
      return self._mapWeeklyCard
    end)
  else
    return self._mapWeeklyCard
  end
end

function PlayerReengagementData:GetActLoginRewardList()
  if not self._bDetailInited then
    self:RequestReengagementInfo(function()
      return self._mapLoginInfo
    end)
  else
    return self._mapLoginInfo
  end
end

function PlayerReengagementData:GetQuestPointInfo()
  if not self._bDetailInited then
    self:RequestReengagementInfo(function()
      return self._mapQuestPoint
    end)
  else
    return self._mapQuestPoint
  end
end

function PlayerReengagementData:GetDoubleDropCount()
  return self._nDoubleCount
end

function PlayerReengagementData:GetMaxDoubleDropCount()
  return self._nMaxDoubleCount
end

function PlayerReengagementData:GetDoubleFuncType()
  return {
    GameEnum.instanceType.DailyInstance,
    GameEnum.instanceType.RegionBoss,
    GameEnum.instanceType.SkillInstance,
    GameEnum.instanceType.CharGemInstance
  }
end

function PlayerReengagementData:GetActId()
  return self._nActId
end

function PlayerReengagementData:GetActIsOpen()
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  if self._nOpenTime == 0 or self._nActId == 0 or nCurTime >= self:GetReengagementCloseTime() then
    return false
  end
  return CS.ClientManager.Instance.serverTimeStamp >= self._nOpenTime
end

function PlayerReengagementData:GetReengagementOpenTime()
  return self._nOpenTime
end

function PlayerReengagementData:SetOpenTime(nOpenTime)
  if nOpenTime == nil then
    return
  end
  self._nOpenTime = nOpenTime
  self:RefreshRedDot()
end

function PlayerReengagementData:GetReengagementRemainTime()
  return self:GetReengagementCloseTime() - CS.ClientManager.Instance.serverTimeStamp
end

function PlayerReengagementData:GetReengagementCloseTime()
  local nTime = self._nOpenTime + (ConfigTable.GetConfigNumber("ActivityReturneeDuration") or 0) * 24 * 60 * 60
  return CS.ClientManager.Instance:GetNextRefreshTime(nTime) - 86400
end

function PlayerReengagementData:GetLimitedTrialBuildList()
  if self:GetActIsOpen() == false then
    return {}
  end
  local nWorldLevel = PlayerData.Base:GetWorldClass()
  local mapTrialBuildData
  
  local function foreachMapData(mapData)
    if nWorldLevel >= mapData.LevelMin and (mapData.LevelMax == -1 or nWorldLevel <= mapData.LevelMax) then
      mapTrialBuildData = mapData
    end
  end
  
  ForEachTableLine(ConfigTable.Get("ActivityReturneeTrialBuildGroup"), foreachMapData)
  if mapTrialBuildData == nil then
    return {}
  end
  local tbTrialBuildIds = {}
  
  local function foreachMapData1(mapData)
    if mapData ~= nil and mapData.Group == mapTrialBuildData.Id then
      table.insert(tbTrialBuildIds, mapData.TrialBuildId)
    end
  end
  
  ForEachTableLine(ConfigTable.Get("ActivityReturneeTrialBuild"), foreachMapData1)
  return tbTrialBuildIds
end

function PlayerReengagementData:GetPurchasedBundles()
  return self._tbBoughtBundles
end

function PlayerReengagementData:UpdateDoubleCount(nDoubleCount)
  self._nDoubleCount = math.max(self._nMaxDoubleCount - nDoubleCount, 0)
end

function PlayerReengagementData:BuyWeeklyCard(sId, sStatistical)
  PlayerData.Mall:BuyWeeklyCard(sId, sStatistical)
end

function PlayerReengagementData:BuyReengagementPack(sId, sStatistical)
  PlayerData.Mall:BuyReengagementPackage(sId, sStatistical)
end

function PlayerReengagementData:RequestReceiveReunionReward(callback)
  local function cb(_, changeInfo)
    self._bReunionReceived = true
    
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(changeInfo)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    UTILS.OpenReceiveByChangeInfo(changeInfo, callback)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_returnee_reunion_reward_req, {}, nil, cb)
end

function PlayerReengagementData:RequestReceiveWeeklyCard(callback)
  local function cb(_, changeInfo)
    self._mapWeeklyCard.Received = true
    
    self:RefreshRedDot()
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(changeInfo)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    UTILS.OpenReceiveByChangeInfo(changeInfo, callback)
    EventManager.Hit("RefreshReengagementWeeklyCard")
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_returnee_card_reward_receive_req, {}, nil, cb)
end

function PlayerReengagementData:RequestReceiveQuestReward(nQuestId)
  local function cb(_, changeInfo)
    local nGroupId = self._tbQuestConfig[nQuestId].GroupId
    
    for _, mapQuest in pairs(self._mapQuestStateList) do
      local nThisGroupId = self._tbQuestConfig[mapQuest.nId].GroupId
      if mapQuest.nStatus == 1 and nThisGroupId == nGroupId then
        mapQuest.nStatus = 2
        mapQuest.Progress.Cur = mapQuest.Progress.Max
        self._mapQuestPoint.Point = self._mapQuestPoint.Point + 1
      end
    end
    if self._mapQuestDataList[nGroupId] ~= nil then
      for k, v in pairs(self._mapQuestDataList[nGroupId]) do
        if v.nStatus == 1 then
          v.nStatus = 2
          v.Progress.Cur = v.Progress.Max
        end
      end
    end
    self:RefreshRedDot()
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(changeInfo)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    UTILS.OpenReceiveByChangeInfo(changeInfo, function()
      EventManager.Hit("RefreshReengagementQuest")
      EventManager.Hit("RefreshReengagementQuestPoint")
    end)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_returnee_quest_reward_receive_req, {Value = nQuestId}, nil, cb)
end

function PlayerReengagementData:RequestReceiveQuestPointReward(nPointIndex)
  local function cb(_, changeInfo)
    self._mapQuestPoint.Received = self._mapQuestPoint.Received or {}
    
    local nPoint = tonumber(self._mapQuestPoint.Point) or 0
    for _, mapConfig in ipairs(self._mapQuestPointConfig or {}) do
      if nPoint >= mapConfig.Point then
        UTILS.SetBit(self._mapQuestPoint.Received, mapConfig.Index + 1)
      end
    end
    self:RefreshRedDot()
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(changeInfo)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    UTILS.OpenReceiveByChangeInfo(changeInfo)
    EventManager.Hit("RefreshReengagementQuestPoint")
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_returnee_quest_point_reward_receive_req, {Value = nPointIndex}, nil, cb)
end

function PlayerReengagementData:RequestReceiveLoginReward(callback)
  local function cb(_, changeInfo)
    self._mapLoginInfo.Actual = self._mapLoginInfo.Receive
    
    self:RefreshRedDot()
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(changeInfo)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    UTILS.OpenReceiveByChangeInfo(changeInfo, callback)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_returnee_login_reward_receive_req, {}, nil, cb)
end

function PlayerReengagementData:OnQuestChangeNotify(mapQuestData)
  if self._nActId == 0 or mapQuestData == nil or mapQuestData.Id == nil then
    return
  end
  local questConfig = ConfigTable.GetData("ActivityReturneeQuest", mapQuestData.Id)
  if questConfig == nil then
    return
  end
  local mapProgress
  if mapQuestData.Progress ~= nil then
    mapProgress = mapQuestData.Progress[1]
  end
  if mapProgress == nil then
    mapProgress = {
      Cur = 0,
      Max = self:GetQuestMaxProgress(mapQuestData.Id)
    }
  end
  local dataToInsert = {
    nId = mapQuestData.Id,
    nStatus = mapQuestData.Status,
    Progress = mapProgress
  }
  self._mapQuestStateList[mapQuestData.Id] = dataToInsert
  if self._mapQuestDataList[questConfig.GroupId] == nil then
    self._mapQuestDataList[questConfig.GroupId] = {}
  end
  self._mapQuestDataList[questConfig.GroupId][mapQuestData.Id] = dataToInsert
  self:RefreshRedDot()
  EventManager.Hit("RefreshReengagementQuest")
end

return PlayerReengagementData
