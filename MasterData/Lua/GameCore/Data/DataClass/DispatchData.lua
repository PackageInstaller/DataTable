local dailycheckinctrl = require("Game.UI.CheckIn.DailyCheckInCtrl")
local NotificationManager = require("GameCore.Module.NotificationManager")
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local DispatchData = class("DispatchData")
local tbAllDispatchData = {}
local tbWeeklyDispatchDataIds = {}
local tbCompletedDailyDispatchIds = {}
local tbCompletedWeeklyDispatchIds = {}
local bReqApplyAgent = false

local function OnEvent_NewDay()
  tbCompletedDailyDispatchIds = {}
  EventManager.Hit("UpdateDispatchData")
end

local function OnEvent_SettingsNotificationClose()
  if tbAllDispatchData == nil then
    return
  end
  for k, v in pairs(tbAllDispatchData) do
    if v.State == AllEnum.DispatchState.Accepting then
      NotificationManager.UnregisterNotification(20000000, v.Data.Id)
    end
    if LocalSettingData.GetLocalSettingData("Dispatch") then
      NotificationManager.RegisterNotification(20000000, v.Data.Id, v.Data.StartTime + v.Data.ProcessTime * 60)
    end
  end
end

local function Init()
  EventManager.Add(EventId.IsNewDay, DispatchData, OnEvent_NewDay)
end

local function UnInit()
  EventManager.Remove(EventId.IsNewDay, DispatchData, OnEvent_NewDay)
end

local function CacheDispatchData(data)
  if data == nil or data.Infos == nil then
    return
  end
  for k, v in pairs(data.Infos) do
    NotificationManager.UnregisterNotification(20000000, v.Id)
    local state = AllEnum.DispatchState.Accepting
    if v.ProcessTime * 60 + v.StartTime <= CS.ClientManager.Instance.serverTimeStamp then
      state = AllEnum.DispatchState.Complete
    elseif LocalSettingData.GetLocalSettingData("Dispatch") then
      NotificationManager.RegisterNotification(20000000, v.Id, v.StartTime + v.ProcessTime * 60)
    end
    tbAllDispatchData[v.Id] = {Data = v, State = state}
  end
  tbCompletedDailyDispatchIds = data.DailyIds
  tbCompletedWeeklyDispatchIds = data.WeeklyIds
  tbWeeklyDispatchDataIds = data.NewAgentIds
  for i = #tbWeeklyDispatchDataIds, 1, -1 do
    if table.indexof(tbCompletedWeeklyDispatchIds, tbWeeklyDispatchDataIds[i]) > 0 then
      table.remove(tbWeeklyDispatchDataIds, i)
    end
  end
end

local function GetAllDispatchingData()
  return tbAllDispatchData
end

local function GetAccpectingDispatchCount()
  local count = 0
  for k, v in pairs(tbAllDispatchData) do
    local agentData = ConfigTable.GetData("Agent", v.Data.Id)
    if agentData.Tab ~= GameEnum.AgentType.Emergency and (v.State == AllEnum.DispatchState.Accepting or v.State == AllEnum.DispatchState.Complete) then
      count = count + 1
    end
  end
  return count
end

local function GetDispatchState(dispatchId)
  if tbAllDispatchData[dispatchId] ~= nil then
    if tbAllDispatchData[dispatchId].Data.ProcessTime * 60 + tbAllDispatchData[dispatchId].Data.StartTime <= CS.ClientManager.Instance.serverTimeStamp then
      tbAllDispatchData[dispatchId].State = AllEnum.DispatchState.Complete
    end
    return tbAllDispatchData[dispatchId].State
  end
  if table.indexof(tbCompletedDailyDispatchIds, dispatchId) > 0 then
    return AllEnum.DispatchState.Done
  end
  if table.indexof(tbCompletedWeeklyDispatchIds, dispatchId) > 0 then
    return AllEnum.DispatchState.Done
  end
  return AllEnum.DispatchState.CanAccept
end

local function GetAllTabData()
  local tabDispatchData = {}
  local allTab = ConfigTable.Get("AgentTab")
  
  local function foreachAgentTab(mapData)
    table.insert(tabDispatchData, mapData.Id)
  end
  
  ForEachTableLine(allTab, foreachAgentTab)
  return tabDispatchData
end

local function GetAllDispatchItemList()
  local allDispatch = ConfigTable.Get("Agent")
  local tbDispatchList = {}
  
  local function foreachAgent(mapData)
    if mapData.Tab ~= GameEnum.AgentType.Emergency then
      if tbDispatchList[mapData.Tab] == nil then
        tbDispatchList[mapData.Tab] = {}
      end
      if mapData.RefreshType ~= GameEnum.AgentRefreshType.Daily or table.indexof(tbCompletedDailyDispatchIds, mapData.Id) <= 0 then
        table.insert(tbDispatchList[mapData.Tab], mapData.Id)
      end
    end
  end
  
  ForEachTableLine(allDispatch, foreachAgent)
  tbDispatchList[GameEnum.AgentType.Emergency] = tbWeeklyDispatchDataIds
  for k, v in pairs(tbAllDispatchData) do
    local data = ConfigTable.GetData("Agent", k)
    if data ~= nil and data.Tab == GameEnum.AgentType.Emergency and table.indexof(tbDispatchList[GameEnum.AgentType.Emergency], k) < 1 then
      table.insert(tbDispatchList[GameEnum.AgentType.Emergency], data.Id)
    end
  end
  return tbDispatchList
end

local function CheckTabUnlock(tabIndex, dispatchListData)
  local txtLockCondition = ""
  local bDispatchUnlock = false
  if dispatchListData == nil then
    dispatchListData = {}
    
    local function foreachAgent(mapData)
      if mapData.Tab == tabIndex then
        table.insert(dispatchListData, mapData.Id)
      end
    end
    
    ForEachTableLine(ConfigTable.Get("Agent"), foreachAgent)
  end
  for k, v in pairs(dispatchListData) do
    bDispatchUnlock, txtLockCondition = PlayerData.Dispatch.CheckDispatchItemUnlock(v)
    if bDispatchUnlock then
      return true
    end
  end
  return bDispatchUnlock, txtLockCondition
end

local function GetDispatchCharList(dispatchId)
  if tbAllDispatchData[dispatchId] then
    return tbAllDispatchData[dispatchId].Data.CharIds
  end
  return {}
end

local function GetDispatchBuildData(dispatchId, callback)
  local _mapAllBuild = {}
  local buildId = -1
  if tbAllDispatchData[dispatchId] ~= nil then
    buildId = tbAllDispatchData[dispatchId].Data.BuildId
  end
  
  local function GetDataCallback(tbBuildData, mapAllBuild)
    _mapAllBuild = mapAllBuild
    if callback ~= nil then
      callback(_mapAllBuild[buildId])
    end
  end
  
  PlayerData.Build:GetAllBuildBriefData(GetDataCallback)
end

local function CheckDispatchItemUnlock(dispatchId)
  local agentData = ConfigTable.GetData("Agent", dispatchId)
  local tbCond = decodeJson(agentData.UnlockConditions)
  if tbCond == nil then
    return true
  else
    for _, tbCondInfo in ipairs(tbCond) do
      if tbCondInfo[1] == 1 then
        local nCondLevelId = tbCondInfo[2]
        if 1 > table.indexof(PlayerData.StarTower.tbPassedId, nCondLevelId) then
          return false, nCondLevelId, tbCondInfo[2]
        end
      elseif tbCondInfo[1] == 2 then
        local nWorldCalss = PlayerData.Base:GetWorldClass()
        local nCondClass = tbCondInfo[2]
        if nWorldCalss < nCondClass then
          return false, orderedFormat(ConfigTable.GetUIText("Agent_Cond_WorldClass"), nCondClass), tbCondInfo[2]
        end
      elseif tbCondInfo[1] == 3 then
        local nCondLevelId = tbCondInfo[2]
        if not PlayerData.Avg:IsStoryReaded(nCondLevelId) then
          local config = ConfigTable.GetData("Story", nCondLevelId)
          return false, orderedFormat(ConfigTable.GetUIText("Plot_Limit_MainLine") or "", config.Index), tbCondInfo[2]
        end
      end
    end
  end
  return true
end

local function GetCharOrBuildState(id)
  if tbAllDispatchData ~= nil then
    for k, v in pairs(tbAllDispatchData) do
      if v.Data.CharIds ~= nil then
        for _, charid in ipairs(v.Data.CharIds) do
          if charid == id then
            return AllEnum.DispatchState.Accepting
          end
        end
      end
      if v.Data.BuildId == id then
        return AllEnum.DispatchState.Accepting
      end
    end
  end
  return AllEnum.DispatchState.CanAccept
end

local function GetSameTagCount(dispatchId, bBuild, nId, bExtra)
  local data = ConfigTable.GetData("Agent", dispatchId)
  local charTagList = {}
  local count = 0
  if bBuild then
    local _mapAllBuild = {}
    
    local function GetDataCallback(tbBuildData, mapAllBuild)
      _mapAllBuild = mapAllBuild
    end
    
    PlayerData.Build:GetAllBuildBriefData(GetDataCallback)
    local buildData = _mapAllBuild[nId]
    for i = 1, 3 do
      if buildData.tbChar[i] ~= nil then
        local mapCharDescCfg = ConfigTable.GetData("CharacterDes", buildData.tbChar[i].nTid)
        for _, v in ipairs(mapCharDescCfg.Tag) do
          table.insert(charTagList, v)
        end
      end
    end
  else
    local mapCharDescCfg = ConfigTable.GetData("CharacterDes", nId)
    for _, v in ipairs(mapCharDescCfg.Tag) do
      table.insert(charTagList, v)
    end
  end
  local tagList = bExtra and data.ExtraTags or data.Tags
  for k, v in ipairs(tagList) do
    if 0 < table.indexof(charTagList, v) then
      table.removebyvalue(charTagList, v)
      count = count + 1
    end
  end
  return count
end

local function IsSpecialDispatch(dispatchId)
  if table.indexof(tbWeeklyDispatchDataIds, dispatchId) > 0 then
    return true
  end
  if table.indexof(tbCompletedDailyDispatchIds, dispatchId) > 0 then
    return true
  end
  if table.indexof(tbCompletedWeeklyDispatchIds, dispatchId) > 0 then
    return true
  end
  return false
end

local function IsBuildDispatching(buildId)
  for k, v in pairs(tbAllDispatchData) do
    if v.Data.BuildId == buildId then
      return true
    end
  end
  return false
end

local function RandomSpecialPerformance(charIds)
  local tbEligible = {}
  local totalWeight = 0
  
  local function foreachAgentSpecialPerformance(mapData)
    if #mapData.CharId <= #charIds then
      local hasAll = true
      for k, v in ipairs(mapData.CharId) do
        if table.indexof(charIds, v) <= 0 then
          hasAll = false
          break
        end
      end
      if hasAll then
        totalWeight = totalWeight + mapData.Weight
        table.insert(tbEligible, {
          Id = mapData.Id,
          Weight = totalWeight
        })
      end
    end
  end
  
  ForEachTableLine(ConfigTable.Get("AgentSpecialPerformance"), foreachAgentSpecialPerformance)
  local randomWeight = math.random(1, totalWeight)
  for k, v in ipairs(tbEligible) do
    if randomWeight <= v.Weight then
      return v.Id
    end
  end
  if 0 < #tbEligible then
    return tbEligible[1].Id
  end
  return -1
end

local function CheckReddot()
  for k, v in pairs(tbAllDispatchData) do
    local dispatchData = ConfigTable.GetData("Agent", k)
    local bComplete = v.Data.ProcessTime * 60 + v.Data.StartTime <= CS.ClientManager.Instance.serverTimeStamp
    RedDotManager.SetValid(RedDotDefine.Dispatch_Reward, {
      dispatchData.Tab,
      dispatchData.Id
    }, bComplete)
  end
end

local function GetCurrentYearInfo(time_s)
  local day = os.date("%d", time_s)
  local weekIndex = os.date("%W", time_s)
  local month = os.date("%m", time_s)
  local yearNum = os.date("%Y", time_s)
  return {
    year = yearNum,
    month = month,
    weekIdx = weekIndex,
    day = day
  }
end

local function IsSameDay(stampA, stampB, resetHour)
  resetHour = resetHour or 5
  local resetSeconds = resetHour * 3600
  stampA = stampA - resetSeconds
  stampB = stampB - resetSeconds
  local dateA = GetCurrentYearInfo(stampA)
  local dateB = GetCurrentYearInfo(stampB)
  return dateA.day == dateB.day and dateA.month == dateB.month and dateA.year == dateB.year
end

local function IsSameWeek(stampA, stampB, resetHour)
  resetHour = resetHour or 5
  local resetSeconds = resetHour * 3600
  stampA = stampA - resetSeconds
  stampB = stampB - resetSeconds
  local dateA = GetCurrentYearInfo(stampA)
  local dateB = GetCurrentYearInfo(stampB)
  return dateA.weekIdx == dateB.weekIdx and dateA.year == dateB.year
end

local function ReqApplyAgent(agentList, agentData, callback)
  local count = PlayerData.Dispatch.GetAccpectingDispatchCount()
  local maxCount = tonumber(ConfigTable.GetConfigValue("AgentMaximumQuantity"))
  if count >= maxCount then
    local agentData = agentList[1]
    if agentData ~= nil then
      local configData = ConfigTable.GetData("Agent", agentData.Id)
      if configData.Tab ~= GameEnum.AgentType.Emergency then
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Agent_Max_Accepted"))
        return
      end
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Agent_Max_Accepted"))
      return
    end
  end
  
  local function func_callback(_, msgData)
    for k, v in ipairs(msgData.Infos) do
      if agentData[v.Id] ~= nil then
        local agentInfo = {
          Id = v.Id,
          StartTime = v.BeginTime,
          CharIds = agentData[v.Id].CharIds,
          BuildId = agentData[v.Id].BuildId,
          ProcessTime = agentData[v.Id].ProcessTime
        }
        tbAllDispatchData[v.Id] = {
          Data = agentInfo,
          State = AllEnum.DispatchState.Accepting
        }
      end
      if callback ~= nil then
        callback()
      end
      if LocalSettingData.GetLocalSettingData("Dispatch") then
        NotificationManager.RegisterNotification(20000000, v.Id, v.BeginTime + agentData[v.Id].ProcessTime * 60)
      end
    end
    EventManager.Hit(EventId.DispatchRefreshPanel, AllEnum.DispatchState.Accepting)
    bReqApplyAgent = false
  end
  
  local mapData = {Apply = agentList}
  if bReqApplyAgent ~= true then
    HttpNetHandler.SendMsg(NetMsgId.Id.agent_apply_req, mapData, nil, func_callback)
  end
  bReqApplyAgent = true
end

local function ResetReqLock()
  bReqApplyAgent = false
end

local function ReqGiveUpAgent(dispatchId, callback)
  local mapData = {Id = dispatchId}
  
  local function func_callback(msgData)
    if tbAllDispatchData[dispatchId] ~= nil then
      local dispatchData = tbAllDispatchData[dispatchId]
      local dispathcConfig = ConfigTable.GetData("Agent", dispatchId)
      local nTime = CS.ClientManager.Instance.serverTimeStamp
      if dispathcConfig.RefreshType == GameEnum.AgentRefreshType.NonRefresh and IsSameWeek(dispatchData.Data.StartTime, nTime, 5) == false and table.indexof(tbWeeklyDispatchDataIds, dispatchId) > 0 then
        table.removebyvalue(tbWeeklyDispatchDataIds, dispatchId)
      end
      tbAllDispatchData[dispatchId] = nil
    end
    if callback ~= nil then
      callback()
    end
    EventManager.Hit(EventId.DispatchRefreshPanel)
    NotificationManager.UnregisterNotification(20000000, dispatchId)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.agent_give_up_req, mapData, nil, func_callback)
end

local function ReqReceiveReward(dispatchId, callback)
  local mapData = {Id = dispatchId}
  
  local function func_callback(_, msgData)
    local data = {}
    local tbSpecialPerformanceId = {}
    local nTime = CS.ClientManager.Instance.serverTimeStamp
    for k, v in ipairs(msgData.RewardShows) do
      local dispatchData = ConfigTable.GetData("Agent", v.Id)
      local time = tbAllDispatchData[v.Id] ~= nil and tbAllDispatchData[v.Id].Data.ProcessTime or 0
      local Item = {}
      for _, item in ipairs(v.Rewards) do
        if Item[item.Tid] ~= nil then
          Item[item.Tid].nCount = Item[item.Tid].nCount + item.Qty
        else
          Item[item.Tid] = {
            nId = item.Tid,
            nCount = item.Qty,
            bBonus = false
          }
        end
      end
      for _, item in ipairs(v.Bonus) do
        if Item[item.Tid] ~= nil then
          Item[item.Tid].nCount = Item[item.Tid].nCount + item.Qty
        else
          Item[item.Tid] = {
            nId = item.Tid,
            nCount = item.Qty,
            bBonus = true
          }
        end
      end
      local rewardItem = {}
      for k, v in pairs(Item) do
        table.insert(rewardItem, v)
      end
      table.insert(data, {
        Id = v.Id,
        CharIds = tbAllDispatchData[v.Id].Data.CharIds,
        BuildId = tbAllDispatchData[v.Id].Data.BuildId,
        Name = dispatchData.Name,
        Time = time,
        Item = rewardItem
      })
      if 0 < table.indexof(tbWeeklyDispatchDataIds, v.Id) then
        table.removebyvalue(tbWeeklyDispatchDataIds, v.Id)
        table.insert(tbCompletedWeeklyDispatchIds, v.Id)
      end
      RedDotManager.SetValid(RedDotDefine.Dispatch_Reward, {
        dispatchData.Tab,
        dispatchData.Id
      }, false)
      if dispatchData.RefreshType == GameEnum.AgentRefreshType.Daily and IsSameDay(tbAllDispatchData[v.Id].Data.StartTime, nTime, 5) then
        printLog("Dispatch:" .. "每日任务完成")
        table.insert(tbCompletedDailyDispatchIds, v.Id)
        RedDotManager.UnRegisterNode(RedDotDefine.Dispatch_Reward, {
          dispatchData.Tab,
          dispatchData.Id
        })
      end
      if 0 < #v.SpecialRewards then
        for _, item in ipairs(v.SpecialRewards) do
          local performanceId = PlayerData.Dispatch.RandomSpecialPerformance(tbAllDispatchData[v.Id].Data.CharIds)
          if 0 < performanceId then
            table.insert(tbSpecialPerformanceId, {
              itemId = item.Tid,
              nCount = item.Qty,
              performanceId = performanceId
            })
          end
        end
      end
      if tbAllDispatchData[v.Id] ~= nil then
        tbAllDispatchData[v.Id] = nil
      end
    end
    EventManager.Hit(EventId.DispatchReceiveReward, data, tbSpecialPerformanceId)
    if callback ~= nil then
      callback()
    end
    EventManager.Hit(EventId.DispatchRefreshPanel)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.agent_reward_receive_req, mapData, nil, func_callback)
end

local function RefreshWeeklyDispatchs(msgData)
  if msgData ~= nil then
    tbWeeklyDispatchDataIds = msgData
  end
  for i = #tbCompletedWeeklyDispatchIds, 1, -1 do
    if table.indexof(tbWeeklyDispatchDataIds, tbCompletedWeeklyDispatchIds[i]) > 0 then
      table.remove(tbCompletedWeeklyDispatchIds, i)
    end
  end
end

local function RefreshAgentInfos(data)
  for k, v in pairs(data.Infos) do
    local state = AllEnum.DispatchState.Accepting
    if v.ProcessTime * 60 + v.StartTime <= CS.ClientManager.Instance.serverTimeStamp then
      state = AllEnum.DispatchState.Complete
    end
    tbAllDispatchData[v.Id] = {Data = v, State = state}
  end
end

local DispatchData = {
  Init = Init,
  UnInit = UnInit,
  CacheDispatchData = CacheDispatchData,
  GetAccpectingDispatchCount = GetAccpectingDispatchCount,
  GetAllDispatchingData = GetAllDispatchingData,
  GetDispatchState = GetDispatchState,
  GetAllTabData = GetAllTabData,
  CheckTabUnlock = CheckTabUnlock,
  GetAllDispatchItemList = GetAllDispatchItemList,
  GetDispatchCharList = GetDispatchCharList,
  GetDispatchBuildData = GetDispatchBuildData,
  CheckDispatchItemUnlock = CheckDispatchItemUnlock,
  GetCharOrBuildState = GetCharOrBuildState,
  GetSameTagCount = GetSameTagCount,
  IsSpecialDispatch = IsSpecialDispatch,
  ReqApplyAgent = ReqApplyAgent,
  ReqGiveUpAgent = ReqGiveUpAgent,
  ReqReceiveReward = ReqReceiveReward,
  RefreshWeeklyDispatchs = RefreshWeeklyDispatchs,
  RandomSpecialPerformance = RandomSpecialPerformance,
  IsBuildDispatching = IsBuildDispatching,
  CheckReddot = CheckReddot,
  IsSameDay = IsSameDay,
  IsSameWeek = IsSameWeek,
  ResetReqLock = ResetReqLock,
  RefreshAgentInfos = RefreshAgentInfos
}
return DispatchData
