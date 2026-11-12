local ActivityStoryDataBase = class("ActivityStoryDataBase")
local File = CS.System.IO.File
local TimerManager = require("GameCore.Timer.TimerManager")
local LocalData = require("GameCore.Data.LocalData")
local RapidJson = require("rapidjson")

function ActivityStoryDataBase:Init()
  self:_InitConfigCache()
  self:_InitRuntimeData()
  self:CacheEvData()
end

function ActivityStoryDataBase:_InitConfigCache()
  self.CFG_ChapterStoryNumIds = {}
  self.CFG_Story = {}
  self.CFG_StoryEvidence = {}
  self.CFG_ConditionStoryNumIds = {}
  
  local function forEachLine_Story(mapLineData)
    self.CFG_Story[mapLineData.StoryId] = mapLineData.Id
    if self.CFG_ChapterStoryNumIds[mapLineData.ChapterId] == nil then
      self.CFG_ChapterStoryNumIds[mapLineData.ChapterId] = {}
    end
    if mapLineData.ConditionId ~= "" then
      if self.CFG_ConditionStoryNumIds[mapLineData.ConditionId] == nil then
        self.CFG_ConditionStoryNumIds[mapLineData.ConditionId] = {}
      end
      table.insert(self.CFG_ConditionStoryNumIds[mapLineData.ConditionId], mapLineData.Id)
    end
    table.insert(self.CFG_ChapterStoryNumIds[mapLineData.ChapterId], mapLineData.Id)
    if mapLineData.MemoryType == GameEnum.MainlineMemoryNodeType.LastEndType then
      self.tbLastEndStoryIds = self.tbLastEndStoryIds or {}
      table.insert(self.tbLastEndStoryIds, mapLineData.Id)
    end
  end
  
  local function forEachLine_StoryEvidence(mapLineData)
    if self.CFG_StoryEvidence[mapLineData.EvId] == nil then
      self.CFG_StoryEvidence[mapLineData.EvId] = {}
    end
    table.insert(self.CFG_StoryEvidence[mapLineData.EvId], mapLineData.Id)
  end
  
  ForEachTableLine(DataTable.ActivityStory, forEachLine_Story)
  ForEachTableLine(DataTable.ActivityStoryEvidence, forEachLine_StoryEvidence)
end

function ActivityStoryDataBase:_InitRuntimeData()
  self.tbStoryIds = {}
  self.tbTempStoryIds = {}
  self.tbEvIds = {}
  self.tbTempEvIds = {}
  self.mapChosen = {}
  self.mapTempCL = {}
  self.mapLatest = {}
  self.mapTempLatestCnt = {}
  self.mapPersonality = {}
  self.mapPersonalityFactor = {}
  self.mapTempPersonality = {}
  self.mapTempPersonalityFactor = {}
  self.mapTempPersonalityCnt = {}
  self.selBuildIdMap = {}
  self.selBuildId = nil
  self.mapRecentStoryId = decodeJson(LocalData.GetPlayerLocalData("ActivityRecentStoryId")) or {}
  local y, n = true, false
  self.__data = {
    [0] = {
      n,
      n,
      n
    },
    [1] = {
      y,
      n,
      n
    },
    [2] = {
      n,
      y,
      n
    },
    [3] = {
      y,
      y,
      n
    },
    [4] = {
      n,
      n,
      y
    },
    [5] = {
      y,
      n,
      y
    },
    [6] = {
      n,
      y,
      y
    },
    [7] = {
      y,
      y,
      y
    }
  }
  self.CURRENT_STORY_ID = 0
  self.CURRENT_ACTIVITY_ID = nil
end

function ActivityStoryDataBase:CacheEvData()
  self.tbEvData = {}
  
  local function forEachLine_Story(storConfig)
    local nConditionId = storConfig.ConditionId
    local mapConditionData = ConfigTable.GetData("ActivityStoryCondition", nConditionId)
    local tbEvIds = {}
    if #mapConditionData.EvIds_a > 0 then
      for _, v in ipairs(mapConditionData.EvIds_a) do
        table.insert(tbEvIds, v)
      end
    end
    if 0 < #mapConditionData.EvIds_b then
      for _, v in ipairs(mapConditionData.EvIds_b) do
        table.insert(tbEvIds, v)
      end
    end
    if #tbEvIds == 0 then
      return
    end
    for _, v in ipairs(tbEvIds) do
      if self.tbEvData[v] == nil then
        self.tbEvData[v] = {}
      end
      table.insert(self.tbEvData[v], storConfig.StoryId)
    end
  end
  
  ForEachTableLine(DataTable.ActivityStory, forEachLine_Story)
end

function ActivityStoryDataBase:ClearTempData()
  self.tbTempStoryIds = {}
  self.tbTempEvIds = {}
  self.mapTempCL = {}
  self.mapTempLatestCnt = {}
  self.mapTempPersonality = {}
  self.mapTempPersonalityFactor = {}
  self.mapTempPersonalityCnt = {}
  self.CURRENT_STORY_ID = 0
end

function ActivityStoryDataBase:SafeCheck()
  if type(self.tbTempStoryIds) ~= "table" then
    return false
  end
  if #self.tbTempStoryIds <= 0 then
    return false
  end
  local _sStoryId = self.tbTempStoryIds[1]
  if type(_sStoryId) ~= "string" then
    return false
  end
  local _nStoryId = self.CFG_Story[_sStoryId]
  if type(_nStoryId) ~= "number" then
    return false
  end
  if type(self.CURRENT_STORY_ID) ~= "number" then
    return false
  end
  if _nStoryId ~= self.CURRENT_STORY_ID then
    return false
  end
  local cfgdata = ConfigTable.GetData("ActivityStory", _nStoryId)
  if cfgdata == nil then
    return false
  end
  return true
end

function ActivityStoryDataBase:ResetCachedAvgData()
  self.tbStoryIds = {}
  self.tbEvIds = {}
  self.mapChosen = {}
  self.mapLatest = {}
  self.mapPersonality = {}
  self.mapPersonalityFactor = {}
  self.selBuildIdMap = {}
  self.selBuildId = nil
  self.mapRecentStoryId = decodeJson(LocalData.GetPlayerLocalData("ActivityRecentStoryId")) or {}
end

function ActivityStoryDataBase:CacheAvgData(StoryInfo, nActivityId)
  if StoryInfo == nil then
    return
  end
  local nBuildId = StoryInfo.Build and StoryInfo.Build.BuildId or 0
  self:SetSelBuildId(nBuildId, nActivityId)
  for _, nEvId in ipairs(StoryInfo.Evidences) do
    local cfgData_Evidence = ConfigTable.GetData("ActivityStoryEvidence", nEvId)
    if cfgData_Evidence ~= nil then
      local sEvid = cfgData_Evidence.EvId
      if 0 >= table.indexof(self.tbEvIds, sEvid) then
        table.insert(self.tbEvIds, sEvid)
      end
    end
  end
  
  local function func_Parse(uint32Value, nType)
    if nType == 1 then
      return uint32Value & 15
    elseif nType == 2 then
      return (uint32Value & 240) >> 4
    elseif nType == 3 then
      return (uint32Value & 3840) >> 8
    else
      return 0
    end
  end
  
  for _, Story in pairs(StoryInfo.Stories) do
    local mapCfgDataStory = ConfigTable.GetData("ActivityStory", Story.Id)
    if mapCfgDataStory == nil then
      printError("Stroy Cfg Missing:" .. Story.Id)
    else
      if table.indexof(self.tbStoryIds, mapCfgDataStory.StoryId) <= 0 then
        table.insert(self.tbStoryIds, mapCfgDataStory.StoryId)
      end
      local sAvgId = mapCfgDataStory.AvgLuaName
      for _, StoryChoice in pairs(Story.Major) do
        if self.mapChosen[sAvgId] == nil then
          self.mapChosen[sAvgId] = {}
        end
        if self.mapLatest[sAvgId] == nil then
          self.mapLatest[sAvgId] = {}
        end
        self.mapChosen[sAvgId][StoryChoice.Group] = func_Parse(StoryChoice.Value, 1)
        self.mapLatest[sAvgId][StoryChoice.Group] = func_Parse(StoryChoice.Value, 2)
      end
      for _, StoryChoice in pairs(Story.Personality) do
        if self.mapPersonality[sAvgId] == nil then
          self.mapPersonality[sAvgId] = {}
        end
        if self.mapPersonalityFactor[sAvgId] == nil then
          self.mapPersonalityFactor[sAvgId] = {}
        end
        self.mapPersonality[sAvgId][StoryChoice.Group] = func_Parse(StoryChoice.Value, 2)
        self.mapPersonalityFactor[sAvgId][StoryChoice.Group] = func_Parse(StoryChoice.Value, 3)
      end
    end
  end
end

function ActivityStoryDataBase:GetChapterIdByActivityId(activityId)
  return ConfigTable.GetData("ActivityStoryChapter", activityId)
end

function ActivityStoryDataBase:GetChapterStoryNumIds(nChapterId)
  return self.CFG_ChapterStoryNumIds[nChapterId]
end

function ActivityStoryDataBase:GetStoryCfgData(storyId)
  local nId = self.CFG_Story[storyId]
  return ConfigTable.GetData("ActivityStory", nId)
end

function ActivityStoryDataBase:AvgLuaNameToStoryId(sAvgId)
  local nId, storyId
  for _, v in pairs(self.CFG_Story) do
    local data = ConfigTable.GetData("ActivityStory", v)
    if data.AvgLuaName == sAvgId then
      nId = data.Id
      storyId = data.StoryId
      break
    end
  end
  return nId, storyId
end

function ActivityStoryDataBase:CheckIfTrue(bIsMajor, sAvgId, nGroupId, nIndex, nCheckount)
  local _, sCheckTarget = self:AvgLuaNameToStoryId(sAvgId)
  if table.indexof(self.tbTempStoryIds, sCheckTarget) > 0 then
    return self:CheckIfTrue_Client(bIsMajor, sAvgId, nGroupId, nIndex, nCheckount)
  else
    return self:CheckIfTrue_Srv(bIsMajor, sAvgId, nGroupId, nIndex)
  end
end

function ActivityStoryDataBase:CheckIfTrue_Srv(bIsMajor, sAvgId, nGroupId, nIndex)
  local mapData = bIsMajor == true and self.mapLatest or self.mapPersonality
  local mapA = mapData[sAvgId]
  if mapA == nil then
    return false
  end
  local nLatestChosenIndex = mapA[nGroupId]
  if nLatestChosenIndex == nil then
    return false
  end
  return nIndex == nLatestChosenIndex
end

function ActivityStoryDataBase:CheckIfTrue_Client(bIsMajor, sAvgId, nGroupId, nIndex, nCheckount)
  local mapData = bIsMajor == true and self.mapTempLatestCnt or self.mapTempPersonalityCnt
  local mapA = mapData[sAvgId]
  if mapA == nil then
    return false
  end
  mapA = mapA[nGroupId]
  if mapA == nil then
    return false
  end
  local nCount = mapA[nIndex] or 0
  return nCheckount <= nCount
end

function ActivityStoryDataBase:IsUnlock(nConditionIntId)
  if type(nConditionIntId) == "string" and nConditionIntId == "" then
    return true
  end
  local cfgData = ConfigTable.GetData("ActivityStoryCondition", nConditionIntId)
  if cfgData == nil then
    printError("Avg数据判断是否解锁时，传了一个excel表里没有的 number id:" .. tostring(nConditionIntId))
    return false
  end
  
  local function func_Check(tbRequire, tbPlayerData, tbPlayerTempData, bMust)
    if tbRequire == nil then
      return true
    end
    if #tbRequire <= 0 then
      return true
    end
    local bCheckResult, bCheckTempResult, tbCheckResultInfo = bMust, bMust, {}
    for _, v in ipairs(tbRequire) do
      local _b = 0 < table.indexof(tbPlayerData, v)
      if bMust == true then
        bCheckResult = bCheckResult == true and _b == true
      else
        bCheckResult = bCheckResult == true or _b == true
      end
      tbCheckResultInfo[v] = _b
    end
    if bCheckResult == false then
      for _, v in ipairs(tbRequire) do
        if tbCheckResultInfo[v] ~= true then
          local _b = 0 < table.indexof(tbPlayerTempData, v)
          if bMust == true then
            bCheckTempResult = bCheckTempResult == true and _b == true
          else
            bCheckTempResult = bCheckTempResult == true or _b == true
          end
          tbCheckResultInfo[v] = _b
        end
      end
      return bCheckTempResult, tbCheckResultInfo
    else
      return bCheckResult, tbCheckResultInfo
    end
  end
  
  local tbRequire = {}
  local tbPlayerTempData = {}
  for _, v in ipairs(self.tbEvIds) do
    for _, nId in ipairs(self.CFG_StoryEvidence[v] or {}) do
      table.insert(tbRequire, nId)
    end
  end
  for _, v in ipairs(self.tbTempEvIds) do
    for _, nId in ipairs(self.CFG_StoryEvidence[v] or {}) do
      table.insert(tbPlayerTempData, nId)
    end
  end
  local bMustEvIds, mapMustEvIds = func_Check(cfgData.EvIds_a, tbRequire, tbPlayerTempData, true)
  local bOneOfEvIds, mapOneOfEvIds = func_Check(cfgData.EvIds_b, tbRequire, tbPlayerTempData, false)
  tbRequire = {}
  tbPlayerTempData = {}
  for _, v in ipairs(self.tbStoryIds) do
    table.insert(tbRequire, self.CFG_Story[v])
  end
  for _, v in ipairs(self.tbTempStoryIds) do
    table.insert(tbPlayerTempData, self.CFG_Story[v])
  end
  local bMustStoryIds, mapMustStoryIds = func_Check(cfgData.ActivityStoryId_a, tbRequire, tbPlayerTempData, true)
  local bOneOfStoryIds, mapOneOfStoryIds = func_Check(cfgData.ActivityStoryId_b, tbRequire, tbPlayerTempData, false)
  local nNeedWorldLevel = cfgData.PlayerWorldLevel or 0
  local bNeedLv = nNeedWorldLevel <= PlayerData.Base:GetWorldClass()
  local bMustAchievementIds, mapAchieveInfo = PlayerData.Achievement:CheckAchieveIds(cfgData.AchieveIds)
  local activityId = cfgData.ActivityLevel[1] or 0
  local mustLevelId = cfgData.ActivityLevel[2] or 0
  local levelData = PlayerData.Activity:GetActivityDataById(activityId)
  local bMustActivityLevel = true
  if levelData ~= nil then
    bMustActivityLevel = levelData:GetLevelFirstPassNoneType(mustLevelId)
  end
  local tbResult = {
    {bMustStoryIds, mapMustStoryIds},
    {bOneOfStoryIds, mapOneOfStoryIds},
    {bMustEvIds, mapMustEvIds},
    {bOneOfEvIds, mapOneOfEvIds},
    {bNeedLv, nNeedWorldLevel},
    {bMustAchievementIds, mapAchieveInfo},
    {bMustActivityLevel, mustLevelId}
  }
  local bResult = bMustEvIds == true and bOneOfEvIds == true and bMustStoryIds == true and bOneOfStoryIds == true and bNeedLv == true and bMustAchievementIds == true and bMustActivityLevel == true
  return bResult, tbResult
end

function ActivityStoryDataBase:MarkStoryId(sAvgId)
  if AVG_EDITOR == true then
  elseif type(self.CURRENT_STORY_ID) == "number" then
    local cfgdata = ConfigTable.GetData("ActivityStory", self.CURRENT_STORY_ID)
    if cfgdata == nil then
      return
    end
  else
    return
  end
  local _, storyId = self:AvgLuaNameToStoryId(sAvgId)
  if storyId == nil then
    return
  end
  if table.indexof(self.tbTempStoryIds, storyId) <= 0 then
    table.insert(self.tbTempStoryIds, storyId)
  end
end

function ActivityStoryDataBase:MarkEvId(sId)
  if table.indexof(self.tbTempEvIds, sId) <= 0 and 0 >= table.indexof(self.tbEvIds, sId) then
    table.insert(self.tbTempEvIds, sId)
  end
end

function ActivityStoryDataBase:IsChosen(sAvgId, nGroupId, nIndex)
  if self.mapChosen[sAvgId] == nil then
    return false
  end
  if self.mapChosen[sAvgId][nGroupId] == nil then
    return false
  end
  local nCurrent = self.mapChosen[sAvgId][nGroupId]
  local bIsChosen = self.__data[nCurrent][nIndex]
  if self.mapTempCL[sAvgId] == nil then
    self.mapTempCL[sAvgId] = {}
  end
  if self.mapTempCL[sAvgId][nGroupId] == nil then
    self.mapTempCL[sAvgId][nGroupId] = {}
  end
  local bIsChosen_Temp = table.indexof(self.mapTempCL[sAvgId][nGroupId], nIndex) > 0
  return bIsChosen, bIsChosen_Temp
end

function ActivityStoryDataBase:MarkChosen(sAvgId, nGroupId, nIndex)
  if self.mapTempCL[sAvgId] == nil then
    self.mapTempCL[sAvgId] = {}
  end
  if self.mapTempCL[sAvgId][nGroupId] == nil then
    self.mapTempCL[sAvgId][nGroupId] = {}
  end
  local nTableIndex = table.indexof(self.mapTempCL[sAvgId][nGroupId], nIndex)
  if 0 < nTableIndex then
    table.remove(self.mapTempCL[sAvgId][nGroupId], nTableIndex)
  end
  table.insert(self.mapTempCL[sAvgId][nGroupId], nIndex)
  if self.mapTempLatestCnt[sAvgId] == nil then
    self.mapTempLatestCnt[sAvgId] = {}
  end
  if self.mapTempLatestCnt[sAvgId][nGroupId] == nil then
    self.mapTempLatestCnt[sAvgId][nGroupId] = {}
  end
  local nCurCnt = self.mapTempLatestCnt[sAvgId][nGroupId][nIndex] or 0
  nCurCnt = nCurCnt + 1
  self.mapTempLatestCnt[sAvgId][nGroupId][nIndex] = nCurCnt
end

function ActivityStoryDataBase:IsEvidenceUnlock(evidenceId)
  for _, v in ipairs(self.tbEvIds) do
    if v == evidenceId then
      return true
    end
  end
  return false
end

function ActivityStoryDataBase:IsStoryReaded(nStoryId)
  local cfgData = ConfigTable.GetData("ActivityStory", nStoryId)
  if cfgData == nil then
    return false
  end
  if table.indexof(self.tbStoryIds, cfgData.StoryId) > 0 or 0 < table.indexof(self.tbTempStoryIds, cfgData.StoryId) then
    return true
  end
  return false
end

function ActivityStoryDataBase:GetHistoryChoosedPersonality(sAvgId, nGroupId)
  if self.mapPersonality[sAvgId] == nil then
    return nil
  end
  if self.mapPersonality[sAvgId][nGroupId] == nil then
    return nil
  end
  local nValue = self.mapPersonality[sAvgId][nGroupId]
  local tbData = self.__data[nValue]
  for i, v in ipairs(tbData) do
    if v == true then
      return i
    end
  end
  return 0
end

function ActivityStoryDataBase:MarkChoosedPersonality(sAvgId, nGroupId, nIndex, nFactor)
  if self.mapTempPersonality[sAvgId] == nil then
    self.mapTempPersonality[sAvgId] = {}
  end
  if self.mapTempPersonalityFactor[sAvgId] == nil then
    self.mapTempPersonalityFactor[sAvgId] = {}
  end
  local n = 0
  if nIndex == 1 then
    n = 1
  elseif nIndex == 2 then
    n = 2
  elseif nIndex == 3 then
    n = 4
  end
  self.mapTempPersonality[sAvgId][nGroupId] = n
  self.mapTempPersonalityFactor[sAvgId][nGroupId] = nFactor
  if self.mapTempPersonalityCnt[sAvgId] == nil then
    self.mapTempPersonalityCnt[sAvgId] = {}
  end
  if self.mapTempPersonalityCnt[sAvgId][nGroupId] == nil then
    self.mapTempPersonalityCnt[sAvgId][nGroupId] = {}
  end
  local nCurCnt = self.mapTempPersonalityCnt[sAvgId][nGroupId][nIndex] or 0
  nCurCnt = nCurCnt + 1
  self.mapTempPersonalityCnt[sAvgId][nGroupId][nIndex] = nCurCnt
end

function ActivityStoryDataBase:CalcPersonality(nId)
  return PlayerData.Avg:CalcPersonality(nId)
end

function ActivityStoryDataBase:_ResolveBuildIdKey(nActivityId)
  return nActivityId or self.CURRENT_ACTIVITY_ID
end

function ActivityStoryDataBase:_FilterPersonalityByChapter(nChapterId)
  local tbPersonality = {}
  local tbPersonalityFactor = {}
  for sAvgId, v in pairs(self.mapPersonality) do
    local cfgData = self:GetStoryCfgData(sAvgId)
    if cfgData ~= nil and cfgData.ChapterId == nChapterId then
      tbPersonality[sAvgId] = v
      if self.mapPersonalityFactor[sAvgId] ~= nil then
        tbPersonalityFactor[sAvgId] = self.mapPersonalityFactor[sAvgId]
      end
    end
  end
  return tbPersonality, tbPersonalityFactor
end

function ActivityStoryDataBase:SetSelBuildId(nBuildId, nActivityId)
  if self.selBuildIdMap == nil then
    self.selBuildIdMap = {}
  end
  local key = self:_ResolveBuildIdKey(nActivityId)
  if key ~= nil then
    self.selBuildIdMap[key] = nBuildId
  end
  self.selBuildId = nBuildId
end

function ActivityStoryDataBase:GetCachedBuildId(nActivityId)
  if self.selBuildIdMap ~= nil then
    local key = self:_ResolveBuildIdKey(nActivityId)
    if key ~= nil and self.selBuildIdMap[key] ~= nil then
      return self.selBuildIdMap[key]
    end
  end
  return self.selBuildId
end

function ActivityStoryDataBase:SortStoryList(chapterId)
  local list = self.CFG_ChapterStoryNumIds[chapterId]
  local sortedList = {}
  if list == nil or #list == 0 then
    return sortedList
  end
  local storyIdToConfig = {}
  local storyIdToNumId = {}
  for _, numId in ipairs(list) do
    local config = ConfigTable.GetData("ActivityStory", numId)
    if config then
      storyIdToConfig[config.StoryId] = config
      storyIdToNumId[config.StoryId] = numId
    end
  end
  local parentToChildren = {}
  local rootChildren = {}
  for storyId, config in pairs(storyIdToConfig) do
    local parentIds = config.ParentStoryId
    local bIsRoot = false
    if type(parentIds) == "table" then
      bIsRoot = #parentIds == 0 or parentIds[1] == ""
    elseif type(parentIds) == "string" then
      bIsRoot = parentIds == ""
    end
    if bIsRoot then
      table.insert(rootChildren, storyId)
    else
      local tbParents = type(parentIds) == "table" and parentIds or {parentIds}
      for _, parentId in ipairs(tbParents) do
        if parentId ~= "" then
          if parentToChildren[parentId] == nil then
            parentToChildren[parentId] = {}
          end
          table.insert(parentToChildren[parentId], storyId)
        end
      end
    end
  end
  
  local function sortByNumId(children)
    table.sort(children, function(a, b)
      return storyIdToNumId[a] < storyIdToNumId[b]
    end)
  end
  
  sortByNumId(rootChildren)
  for _, children in pairs(parentToChildren) do
    sortByNumId(children)
  end
  local visited = {}
  local queue = {}
  for _, storyId in ipairs(rootChildren) do
    if not visited[storyId] then
      visited[storyId] = true
      table.insert(queue, storyId)
    end
  end
  local head = 1
  while head <= #queue do
    local storyId = queue[head]
    head = head + 1
    table.insert(sortedList, storyIdToNumId[storyId])
    local children = parentToChildren[storyId]
    if children ~= nil then
      for _, childId in ipairs(children) do
        if not visited[childId] then
          visited[childId] = true
          table.insert(queue, childId)
        end
      end
    end
  end
  return sortedList
end

function ActivityStoryDataBase:GetStoryIdListByChapterId(chapterId)
  return self:SortStoryList(chapterId)
end

function ActivityStoryDataBase:GetStoryIdListByActivityId(activityId)
  local chapterConfig = ConfigTable.GetData("ActivityStoryChapter", activityId)
  if chapterConfig == nil then
    return {}, 0
  end
  local list = self:SortStoryList(chapterConfig.ChapterId)
  return list, chapterConfig.ChapterId
end

function ActivityStoryDataBase:GetLastestStoryId()
  local nMax = 101
  for _, v in pairs(self.tbStoryIds) do
    local curIdx = self.CFG_Story[v]
    if nMax < curIdx then
      nMax = curIdx
    end
  end
  for _, v in pairs(self.tbTempStoryIds) do
    local curIdx = self.CFG_Story[v]
    if nMax < curIdx then
      nMax = curIdx
    end
  end
  return nMax
end

function ActivityStoryDataBase:GetRecentStoryId(nChapterId)
  local nStoryId = self.mapRecentStoryId[tostring(nChapterId)]
  if nStoryId == nil then
    local tbChapterList = self.CFG_ChapterStoryNumIds[nChapterId]
    if tbChapterList ~= nil then
      table.sort(tbChapterList, function(a, b)
        return a < b
      end)
      return tbChapterList[1]
    end
  end
  return nStoryId
end

function ActivityStoryDataBase:SetRecentStoryId(nStoryId)
  local cfgData = ConfigTable.GetData("ActivityStory", nStoryId)
  if cfgData ~= nil then
    self.mapRecentStoryId[tostring(cfgData.ChapterId)] = nStoryId
    local sJson = RapidJson.encode(self.mapRecentStoryId)
    printLog(sJson)
    LocalData.SetPlayerLocalData("ActivityRecentStoryId", sJson)
  end
end

function ActivityStoryDataBase:IsActivityStory(nStoryId)
  for _, v in pairs(self.CFG_Story) do
    if v == nStoryId then
      return true
    end
  end
  return false
end

function ActivityStoryDataBase:GetActivityChapterConfigByChapterId(chapterId)
  local config
  
  local function forEachLine_StoryChapter(chapterConfig)
    if chapterConfig.ChapterId == chapterId then
      config = chapterConfig
    end
  end
  
  ForEachTableLine(ConfigTable.Get("ActivityStoryChapter"), forEachLine_StoryChapter)
  return config
end

function ActivityStoryDataBase:EnterAvg(avgId, actId)
  self.CURRENT_STORY_ID = avgId
  self.CURRENT_ACTIVITY_ID = actId
  local mapCfgData_Story = ConfigTable.GetData("ActivityAvgLevel", avgId)
  if NovaAPI.IsEditorPlatform() == true then
    local nLanIdx = GetLanguageIndex(Settings.sCurrentTxtLanguage)
    local sRequireRootPath = GetAvgLuaRequireRoot(nLanIdx) .. "Config/"
    local filePath = NovaAPI.ApplicationDataPath .. "/../Lua/" .. sRequireRootPath .. mapCfgData_Story.StoryId .. ".lua"
    if not File.Exists(filePath) then
      EventManager.Hit(EventId.OpenMessageBox, "找不到AVG配置文件,请检查配置表！，Avg名：" .. mapCfgData_Story.StoryId)
      printError("找不到AVG配置文件,请检查配置表！，Avg名：" .. mapCfgData_Story.StoryId)
      return
    end
  end
  printLog("进AVG演出了 " .. mapCfgData_Story.StoryId)
  EventManager.Add("StoryDialog_DialogEnd", self, self.OnEvent_AvgSTEnd)
  EventManager.Hit("StoryDialog_DialogStart", mapCfgData_Story.StoryId)
end

function ActivityStoryDataBase:_GetApplyMsgId(nActivityId)
  return NetMsgId.Id.activity_story_apply_req
end

function ActivityStoryDataBase:_GetSettleMsgId(nActivityId)
  return NetMsgId.Id.activity_story_settle_req, false
end

function ActivityStoryDataBase:IsOpen(sAvgId, nActivityId)
  return true, 0
end

function ActivityStoryDataBase:RefreshAvgRedDot()
end

function ActivityStoryDataBase:_GetLocalReadKey(nActId, nStoryId)
  return "Act_Story_New" .. tostring(nActId) .. tostring(nStoryId)
end

function ActivityStoryDataBase:GetActivityOpenTime(nActivityId)
  local mapActCfg = ConfigTable.GetData("Activity", nActivityId)
  if mapActCfg == nil then
    return 0, 0
  end
  local nStart = 0
  local nEnd = 0
  if mapActCfg.StartTime ~= nil and mapActCfg.StartTime ~= "" then
    nStart = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapActCfg.StartTime)
  end
  if mapActCfg.EndTime ~= nil and mapActCfg.EndTime ~= "" then
    nEnd = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapActCfg.EndTime)
  end
  return nStart, nEnd
end

function ActivityStoryDataBase:SendMsg_STORY_ENTER(nActivityId, nStoryId, nBuildId, bNewestStory)
  if type(nStoryId) == "string" then
    nStoryId = self.CFG_Story[nStoryId]
    if type(nStoryId) ~= "number" then
      return
    end
  end
  if type(nStoryId) == "number" then
    local cfgdata = ConfigTable.GetData("ActivityStory", nStoryId)
    if cfgdata == nil then
      return
    end
  else
    return
  end
  if nBuildId == nil then
    nBuildId = 0
  end
  
  local function func_cb()
    self:ClearTempData()
    if bNewestStory == true then
      self:SetRecentStoryId(nStoryId)
    end
    if nBuildId ~= 0 then
      self:SetSelBuildId(nBuildId, nActivityId)
    end
    self.CURRENT_STORY_ID = nStoryId
    local mapCfgData_Story = ConfigTable.GetData("ActivityStory", nStoryId)
    if mapCfgData_Story.IsBattle == true then
      local luaClass = require("Game.Adventure.Story.StoryLevel")
      if luaClass == nil then
        return
      end
      self.curLevel = luaClass
      if type(self.curLevel.BindEvent) == "function" then
        self.curLevel:BindEvent()
      end
      if type(self.curLevel.Init) == "function" then
        self.curLevel:Init(self, nStoryId, nBuildId, true)
      end
      printLog("进战斗关卡了")
    else
      if NovaAPI.IsEditorPlatform() == true then
        local nLanIdx = GetLanguageIndex(Settings.sCurrentTxtLanguage)
        local sRequireRootPath = GetAvgLuaRequireRoot(nLanIdx) .. "Config/"
        local filePath = NovaAPI.ApplicationDataPath .. "/../Lua/" .. sRequireRootPath .. mapCfgData_Story.AvgLuaName .. ".lua"
        if not File.Exists(filePath) then
          EventManager.Hit(EventId.OpenMessageBox, "找不到AVG配置文件,请检查配置表！，Avg名：" .. mapCfgData_Story.AvgLuaName)
          printError("找不到AVG配置文件,请检查配置表！，Avg名：" .. mapCfgData_Story.AvgLuaName)
          return
        end
      end
      printLog("进AVG演出了 " .. mapCfgData_Story.AvgLuaName)
      EventManager.Add("AvgSTEnd", self, self.OnEvent_AvgSTEnd)
      EventManager.Hit("StoryDialog_DialogStart", mapCfgData_Story.AvgLuaName, nil, nil, nil, nil, mapCfgData_Story.AvgMotion)
    end
    PlayerData.Avg:SetStorySource(self)
  end
  
  self.CURRENT_ACTIVITY_ID = nActivityId
  local nMsgId = self:_GetApplyMsgId(nActivityId)
  local nBuildType = 0
  local buildPackge
  local mapBuildData = PlayerData.Build:GetBuildData(nBuildId)
  if mapBuildData ~= nil then
    local bTrial = mapBuildData.nBuildSource == AllEnum.BuildSource.Trial or mapBuildData.nBuildSource == AllEnum.BuildSource.LimitedTrial
    nBuildType = bTrial and 2 or 1
    buildPackge = {Type = nBuildType, BuildId = nBuildId}
  end
  HttpNetHandler.SendMsg(nMsgId, {
    ActivityId = nActivityId,
    StoryId = nStoryId,
    Build = buildPackge
  }, nil, func_cb)
  local mapCfgData_Story = ConfigTable.GetData("ActivityStory", nStoryId)
  local nChapterId = mapCfgData_Story and mapCfgData_Story.ChapterId
  PlayerData.Story:SetRecentStoryInfo(GameEnum.StoryPreviewType.ActivityStory, nChapterId, nStoryId)
end

function ActivityStoryDataBase:SendMsg_STORY_DONE(callBack, tbBattleEvents)
  local mapSendMsgData = {
    ActivityId = self.CURRENT_ACTIVITY_ID,
    List = {},
    Evidences = {},
    Events = tbBattleEvents == nil and {
      List = {}
    } or tbBattleEvents
  }
  local mapStoryCfg = ConfigTable.GetData("ActivityStory", self.CURRENT_STORY_ID)
  local bBattle = mapStoryCfg.IsBattle
  if bBattle then
    mapSendMsgData.List[1] = {
      StoryId = self.CURRENT_STORY_ID
    }
    if table.indexof(self.tbTempStoryIds, mapStoryCfg.StoryId) <= 0 then
      table.insert(self.tbTempStoryIds, mapStoryCfg.StoryId)
    end
  else
    if self:SafeCheck() ~= true then
      self:ClearTempData()
      local sErrorLog = "error:"
      for _, v in ipairs(self.tbTempStoryIds) do
        sErrorLog = sErrorLog .. tostring(v) .. ","
      end
      sErrorLog = sErrorLog .. tostring(self.CURRENT_STORY_ID)
      printError(sErrorLog)
      local msg = {
        nType = AllEnum.MessageBox.Desc,
        sContent = sErrorLog,
        callbackConfirm = nil,
        bBlur = false
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
      return
    end
    if #self.tbTempStoryIds > 0 then
      for i, sStoryId in ipairs(self.tbTempStoryIds) do
        local nStoryId = self.CFG_Story[sStoryId]
        mapSendMsgData.List[i] = {
          StoryId = nStoryId,
          Major = {},
          Personality = {}
        }
        local mapStoryCfg2 = ConfigTable.GetData("ActivityStory", nStoryId)
        if mapStoryCfg2 ~= nil then
          local sAvgId = mapStoryCfg2.AvgLuaName
          local mapGroupData = self.mapTempCL[sAvgId]
          if mapGroupData ~= nil then
            for nGroupId, tbChosen in pairs(mapGroupData) do
              for _, nChoiceIndex in ipairs(tbChosen) do
                local n = 0
                if nChoiceIndex == 1 then
                  n = 1
                elseif nChoiceIndex == 2 then
                  n = 2
                elseif nChoiceIndex == 3 then
                  n = 4
                end
                table.insert(mapSendMsgData.List[i].Major, {
                  Group = nGroupId,
                  Choice = n,
                  Factor = 0
                })
              end
            end
          end
          mapGroupData = self.mapTempPersonality[sAvgId]
          if mapGroupData ~= nil then
            for nGroupId, nLatest in pairs(mapGroupData) do
              local nFactor = 0
              if self.mapTempPersonalityFactor[sAvgId] ~= nil then
                nFactor = self.mapTempPersonalityFactor[sAvgId][nGroupId] or 0
              end
              table.insert(mapSendMsgData.List[i].Personality, {
                Group = nGroupId,
                Choice = nLatest,
                Factor = nFactor
              })
            end
          end
        end
      end
    end
    if 0 < #self.tbTempEvIds then
      for _, sEvId in ipairs(self.tbTempEvIds) do
        for _, nId in ipairs(self.CFG_StoryEvidence[sEvId] or {}) do
          table.insert(mapSendMsgData.Evidences, nId)
        end
      end
    end
    local tbPassId = {}
    for _, v in ipairs(mapSendMsgData.List) do
      table.insert(tbPassId, v.StoryId)
    end
    PlayerData.Char:StoryPass(tbPassId)
  end
  
  local function func_merge(tbSrc, tbTarget)
    for _, v in ipairs(tbSrc) do
      if table.indexof(tbTarget, v) <= 0 then
        table.insert(tbTarget, v)
      end
    end
  end
  
  local function func_overwrite(tbSrc, tbTarget)
    for sAvgId, v in pairs(tbSrc) do
      if tbTarget[sAvgId] == nil then
        tbTarget[sAvgId] = {}
      end
      for nGroupId, vv in pairs(v) do
        tbTarget[sAvgId][nGroupId] = vv
      end
    end
  end
  
  local eventStoryId = self.CURRENT_STORY_ID
  PlayerData.Avg:SetStorySource(nil)
  local nMsgId, bIsStoryReview = self:_GetSettleMsgId(self.CURRENT_ACTIVITY_ID)
  
  local function func_succ(_, mapChangeInfo)
    if #self.tbTempStoryIds > 1 then
      local nRecentChapterId = self.CFG_Story[self.tbTempStoryIds[#self.tbTempStoryIds]]
      self:SetRecentStoryId(nRecentChapterId)
    end
    func_merge(self.tbTempStoryIds, self.tbStoryIds)
    self.tbTempStoryIds = {}
    func_merge(self.tbTempEvIds, self.tbEvIds)
    self.tbTempEvIds = {}
    for sAvgId, mapGroupData in pairs(self.mapTempCL) do
      if self.mapChosen[sAvgId] == nil then
        self.mapChosen[sAvgId] = {}
      end
      for nGroupId, tbChosen in pairs(mapGroupData) do
        if self.mapChosen[sAvgId][nGroupId] == nil then
          self.mapChosen[sAvgId][nGroupId] = 0
        end
        local nLen = #tbChosen
        for _, nChoiceIndex in ipairs(tbChosen) do
          local n = 0
          if nChoiceIndex == 1 then
            n = 1
          elseif nChoiceIndex == 2 then
            n = 2
          elseif nChoiceIndex == 3 then
            n = 4
          end
          local nCur = self.mapChosen[sAvgId][nGroupId]
          self.mapChosen[sAvgId][nGroupId] = nCur | n
          if _ == nLen then
            if self.mapLatest[sAvgId] == nil then
              self.mapLatest[sAvgId] = {}
            end
            self.mapLatest[sAvgId][nGroupId] = n
          end
        end
      end
    end
    self.mapTempCL = {}
    self.mapTempLatestCnt = {}
    local sOldPid = PlayerData.Avg:GetPersonalityId()
    if bIsStoryReview ~= true then
      func_overwrite(self.mapTempPersonality, self.mapPersonality)
    end
    self.mapTempPersonality = {}
    self.mapTempPersonalityCnt = {}
    if bIsStoryReview ~= true then
      func_overwrite(self.mapTempPersonalityFactor, self.mapPersonalityFactor)
    end
    self.mapTempPersonalityFactor = {}
    local actChapterConfig = ConfigTable.GetData("ActivityStoryChapter", self.CURRENT_ACTIVITY_ID)
    local tbActPersonality, tbActPersonalityFactor = self:_FilterPersonalityByChapter(actChapterConfig.ChapterId)
    PlayerData.Avg:RefreshActPersonalityData(actChapterConfig.ChapterId, tbActPersonality, tbActPersonalityFactor)
    PlayerData.Avg:PersonalityChangedUpload(sOldPid)
    if callBack ~= nil then
      callBack(mapChangeInfo)
    end
    local bHasReward = not bBattle and mapChangeInfo and mapChangeInfo.Props and 0 < #mapChangeInfo.Props
    if bHasReward then
      local tbItem = {}
      local tbRewardDisplay = UTILS.DecodeChangeInfo(mapChangeInfo)
      for _, v in pairs(tbRewardDisplay) do
        for _, value in pairs(v) do
          table.insert(tbItem, {
            Tid = value.Tid,
            Qty = value.Qty,
            rewardType = AllEnum.RewardType.First
          })
        end
      end
      local tabEvent = {}
      table.insert(tabEvent, {
        "story_id",
        tostring(eventStoryId)
      })
      local _skip = PlayerData.Avg.bSkip == true and "1" or "0"
      table.insert(tabEvent, {"is_skip", _skip})
      table.insert(tabEvent, {
        "role_id",
        tostring(PlayerData.Base._nPlayerId)
      })
      NovaAPI.UserEventUpload("activity_story", tabEvent)
      
      local function AfterRewardDisplay()
        EventManager.Hit("Story_RewardClosed")
      end
      
      local function delayOpen()
        UTILS.OpenReceiveByDisplayItem(tbItem, mapChangeInfo, AfterRewardDisplay)
      end
      
      local nDelayTime = 1
      EventManager.Hit(EventId.TemporaryBlockInput, nDelayTime)
      TimerManager.Add(1, nDelayTime, self, delayOpen, true, true, true)
    end
    EventManager.Hit("Story_Done", bHasReward)
    self:RefreshAvgRedDot()
    printLog("通关结算完成")
  end
  
  printLog("发送通关消息")
  HttpNetHandler.SendMsg(nMsgId, mapSendMsgData, nil, func_succ)
  self.CURRENT_STORY_ID = 0
end

function ActivityStoryDataBase:OnEvent_AvgSTEnd()
  EventManager.Remove("AvgSTEnd", self, self.OnEvent_AvgSTEnd)
  self:SendMsg_STORY_DONE()
  self:RefreshAvgRedDot()
end

function ActivityStoryDataBase:LevelEnd()
  PlayerData.Build:DeleteTrialBuild()
  if type(self.curLevel.UnBindEvent) == "function" then
    self.curLevel:UnBindEvent()
  end
  self.curLevel = nil
end

return ActivityStoryDataBase
