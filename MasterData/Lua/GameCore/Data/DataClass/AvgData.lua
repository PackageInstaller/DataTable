local AvgData = class("AvgData")
local RapidJson = require("rapidjson")
local LocalData = require("GameCore.Data.LocalData")
local TimerManager = require("GameCore.Timer.TimerManager")
local File = CS.System.IO.File

function AvgData:Init()
  self.CFG_ChapterStoryNumIds = {}
  self.CFG_Story = {}
  self.CFG_StoryCondition = {}
  self.CFG_StoryEvidence = {}
  self.CFG_ConditionStoryNumIds = {}
  self.tbLastEndStoryIds = {}
  
  local function forEachLine_Story(mapLineData)
    self.CFG_Story[mapLineData.StoryId] = mapLineData.Id
    if self.CFG_ChapterStoryNumIds[mapLineData.Chapter] == nil then
      self.CFG_ChapterStoryNumIds[mapLineData.Chapter] = {}
    end
    if mapLineData.ConditionId ~= "" then
      if self.CFG_ConditionStoryNumIds[mapLineData.ConditionId] == nil then
        self.CFG_ConditionStoryNumIds[mapLineData.ConditionId] = {}
      end
      table.insert(self.CFG_ConditionStoryNumIds[mapLineData.ConditionId], mapLineData.Id)
    end
    table.insert(self.CFG_ChapterStoryNumIds[mapLineData.Chapter], mapLineData.Id)
    if mapLineData.MemoryType == GameEnum.MainlineMemoryNodeType.LastEndType then
      table.insert(self.tbLastEndStoryIds, mapLineData.Id)
    end
  end
  
  local function forEachLine_StoryCondition(mapLineData)
    self.CFG_StoryCondition[mapLineData.ConditionId] = mapLineData.Id
  end
  
  local function forEachLine_StoryEvidence(mapLineData)
    self.CFG_StoryEvidence[mapLineData.EvId] = mapLineData.Id
  end
  
  ForEachTableLine(DataTable.StoryCondition, forEachLine_StoryCondition)
  ForEachTableLine(DataTable.StoryEvidence, forEachLine_StoryEvidence)
  ForEachTableLine(DataTable.Story, forEachLine_Story)
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
  local y, n = true, false
  self.__data = {
    [0] = {
      n,
      n,
      n,
      n
    },
    [1] = {
      y,
      n,
      n,
      n
    },
    [2] = {
      n,
      y,
      n,
      n
    },
    [3] = {
      y,
      y,
      n,
      n
    },
    [4] = {
      n,
      n,
      y,
      n
    },
    [5] = {
      y,
      n,
      y,
      n
    },
    [6] = {
      n,
      y,
      y,
      n
    },
    [7] = {
      y,
      y,
      y,
      n
    },
    [8] = {
      n,
      n,
      n,
      y
    },
    [9] = {
      y,
      n,
      n,
      y
    },
    [10] = {
      n,
      y,
      n,
      y
    },
    [11] = {
      y,
      y,
      n,
      y
    },
    [12] = {
      n,
      n,
      y,
      y
    },
    [13] = {
      y,
      n,
      y,
      y
    },
    [14] = {
      n,
      y,
      y,
      y
    },
    [15] = {
      y,
      y,
      y,
      y
    }
  }
  self.CURRENT_STORY_ID = 0
  self:CacheEvData()
  EventManager.Add(EventId.UpdateWorldClass, self, self.CheckNewStoryRedDot)
  if AVG_EDITOR == true then
    EventManager.Add("StoryDialog_DialogEnd", self, self.OnEvent_AvgSTEnd)
  end
  self.bSkip = false
  self.nJustReadStoryId = 0
end

function AvgData:UnInit()
  EventManager.Remove(EventId.UpdateWorldClass, self, self.CheckNewStoryRedDot)
  if AVG_EDITOR == true then
    EventManager.Remove("StoryDialog_DialogEnd", self, self.OnEvent_AvgSTEnd)
  end
  self.nJustReadStoryId = 0
end

function AvgData:ClearTempData()
  self.tbTempStoryIds = {}
  self.tbTempEvIds = {}
  self.mapTempCL = {}
  self.mapTempLatestCnt = {}
  self.mapTempPersonality = {}
  self.mapTempPersonalityFactor = {}
  self.mapTempPersonalityCnt = {}
  self.CURRENT_STORY_ID = 0
end

function AvgData:SafeCheck()
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
  local cfgdata = ConfigTable.GetData_Story(_nStoryId)
  if cfgdata == nil then
    return false
  end
  return true
end

function AvgData:CacheAvgData(StoryInfo)
  self.tbStoryIds = {}
  self.tbTempStoryIds = {}
  self.tbEvIds = {}
  self.tbTempEvIds = {}
  self.mapChosen = {}
  self.mapTempCL = {}
  self.mapLatest = {}
  self.mapTempLatestCnt = {}
  self.mapPersonality = {}
  self.mapTempPersonality = {}
  self.mapPersonalityFactor = {}
  self.mapTempPersonalityFactor = {}
  self.mapTempPersonalityCnt = {}
  if StoryInfo == nil then
    return
  end
  if StoryInfo.Build then
    self:SetSelBuildId(StoryInfo.Build.BuildId or 0)
  end
  for i, nEvId in ipairs(StoryInfo.Evidences) do
    local cfgData_Evidence = ConfigTable.GetData("StoryEvidence", nEvId)
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
    local mapCfgDataStory = ConfigTable.GetData_Story(Story.Idx)
    if mapCfgDataStory == nil then
      printError("Stroy Cfg Missing:" .. Story.Idx)
    else
      table.insert(self.tbStoryIds, mapCfgDataStory.StoryId)
      local sAvgId = mapCfgDataStory.AvgLuaName
      for __, StoryChoice in pairs(Story.Major) do
        if self.mapChosen[sAvgId] == nil then
          self.mapChosen[sAvgId] = {}
        end
        if self.mapLatest[sAvgId] == nil then
          self.mapLatest[sAvgId] = {}
        end
        self.mapChosen[sAvgId][StoryChoice.Group] = func_Parse(StoryChoice.Value, 1)
        self.mapLatest[sAvgId][StoryChoice.Group] = func_Parse(StoryChoice.Value, 2)
      end
      for __, StoryChoice in pairs(Story.Personality) do
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
  self.mapRecentStoryId = decodeJson(LocalData.GetPlayerLocalData("RecentStoryId")) or {}
  self:CheckNewStoryRedDot()
  for k, v in ipairs(self.tbLastEndStoryIds) do
    self:SetLastEndState(v)
  end
end

function AvgData:GetChapterStoryNumIds(nChapterId)
  return self.CFG_ChapterStoryNumIds[nChapterId]
end

function AvgData:GetStoryCfgData(storyId)
  local nId = self.CFG_Story[storyId]
  return ConfigTable.GetData_Story(nId)
end

function AvgData:AvgLuaNameToStoryId(sAvgId)
  local nId, storyId
  for k, v in pairs(self.CFG_Story) do
    local data = ConfigTable.GetData_Story(v)
    if data.AvgLuaName == sAvgId then
      nId = data.Id
      storyId = data.StoryId
      break
    end
  end
  return nId, storyId
end

function AvgData:CheckIfTrue(bIsMajor, sAvgId, nGroupId, nIndex, nCheckount)
  if self.storySource ~= nil then
    return self.storySource:CheckIfTrue(bIsMajor, sAvgId, nGroupId, nIndex, nCheckount)
  end
  local n, sCheckTarget = self:AvgLuaNameToStoryId(sAvgId)
  if table.indexof(self.tbTempStoryIds, sCheckTarget) > 0 then
    return self:CheckIfTrue_Client(bIsMajor, sAvgId, nGroupId, nIndex, nCheckount)
  else
    return self:CheckIfTrue_Srv(bIsMajor, sAvgId, nGroupId, nIndex)
  end
end

function AvgData:CheckIfTrue_Srv(bIsMajor, sAvgId, nGroupId, nIndex)
  if AVG_EDITOR == true then
    if self.mapAvgEditorTempData_IsTrueData == nil then
      self.mapAvgEditorTempData_IsTrueData = {}
    end
    local mapA = self.mapAvgEditorTempData_IsTrueData[sAvgId]
    if mapA == nil then
      return false
    end
    local sKey = bIsMajor == true and "L" or "X"
    mapA = mapA[sKey]
    if mapA == nil then
      return false
    end
    local _nIndex = mapA[nGroupId]
    if _nIndex == nil then
      return false
    end
    return nIndex == _nIndex
  end
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

function AvgData:CheckIfTrue_Client(bIsMajor, sAvgId, nGroupId, nIndex, nCheckount)
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

function AvgData:IsUnlock(sConditionId, avgId)
  if self.storySource ~= nil then
    return self.storySource:IsUnlock(sConditionId)
  end
  if type(sConditionId) == "string" and sConditionId == "" then
    return true
  end
  if AVG_EDITOR == true then
    if self.tbAvgEditorTempData_Unlocked_sConditionIds == nil then
      self.tbAvgEditorTempData_Unlocked_sConditionIds = {}
    end
    return table.indexof(self.tbAvgEditorTempData_Unlocked_sConditionIds, sConditionId) > 0
  end
  local nConditionIntId = self.CFG_StoryCondition[sConditionId]
  if nConditionIntId == nil then
    printError("Avg数据判断是否解锁时，传了一个excel表里没有的 string id:" .. tostring(sConditionId))
    return false
  end
  local cfgData = ConfigTable.GetData("StoryCondition", nConditionIntId)
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
    for i, v in ipairs(tbRequire) do
      local _b = 0 < table.indexof(tbPlayerData, v)
      if bMust == true then
        bCheckResult = bCheckResult == true and _b == true
      else
        bCheckResult = bCheckResult == true or _b == true
      end
      tbCheckResultInfo[v] = _b
    end
    if bCheckResult == false then
      for i, v in ipairs(tbRequire) do
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
  
  local bMustEvIds, mapMustEvIds = func_Check(cfgData.EvIds_a, self.tbEvIds, self.tbTempEvIds, true)
  local bOneOfEvIds, mapOneOfEvIds = func_Check(cfgData.EvIds_b, self.tbEvIds, self.tbTempEvIds, false)
  local bMustStoryIds, mapMustStoryIds = func_Check(cfgData.StoryId_a, self.tbStoryIds, self.tbTempStoryIds, true)
  local bOneOfStoryIds, mapOneOfStoryIds = func_Check(cfgData.StoryId_b, self.tbStoryIds, self.tbTempStoryIds, false)
  local nNeedWorldLevel = cfgData.PlayerWorldLevel or 0
  local bNeedLv = nNeedWorldLevel <= PlayerData.Base:GetWorldClass()
  local bMustAchievementIds, mapAchieveInfo = PlayerData.Achievement:CheckAchieveIds(cfgData.AchieveIds)
  local tbResult = {
    {bMustStoryIds, mapMustStoryIds},
    {bOneOfStoryIds, mapOneOfStoryIds},
    {bMustEvIds, mapMustEvIds},
    {bOneOfEvIds, mapOneOfEvIds},
    {bNeedLv, nNeedWorldLevel},
    {bMustAchievementIds, mapAchieveInfo}
  }
  local bResult = bMustEvIds == true and bOneOfEvIds == true and bMustStoryIds == true and bOneOfStoryIds == true and bNeedLv == true and bMustAchievementIds == true
  return bResult, tbResult
end

local UnlockConditionPriority = {
  [1] = "MustStoryIds",
  [2] = "OneofStoryIds",
  [3] = "MustEvIds",
  [4] = "OneofEvIds",
  [5] = "WorldLevel",
  [6] = "MustAchievementIds"
}

function AvgData:GetLockReasonText(tbResult, bHasAchievementData)
  if tbResult == nil then
    return ""
  end
  local lockTxt = ""
  for i = 1, #tbResult do
    local value = tbResult[i]
    if value[1] == false then
      if UnlockConditionPriority[i] == "MustStoryIds" then
        do
          local tbStoryIds = value[2]
          for k, v in pairs(tbStoryIds) do
            if v == false then
              local storyData = ConfigTable.GetData_Story(self.CFG_Story[k])
              lockTxt = orderedFormat(ConfigTable.GetUIText("Story_UnlockPreId") or "", storyData.Title)
              break
            end
          end
        end
        break
      end
      if UnlockConditionPriority[i] == "OneofStoryIds" then
        do
          local tbStoryIds = value[2]
          for k, v in pairs(tbStoryIds) do
            if v == false then
              local storyData = ConfigTable.GetData_Story(self.CFG_Story[k])
              lockTxt = orderedFormat(ConfigTable.GetUIText("Story_UnlockPreId") or "", storyData.Title)
              break
            end
          end
        end
        break
      end
      if UnlockConditionPriority[i] == "MustEvIds" then
        lockTxt = ConfigTable.GetUIText("Story_UnlockClueCondition")
        break
      end
      if UnlockConditionPriority[i] == "OneofEvIds" then
        lockTxt = ConfigTable.GetUIText("Story_UnlockClueCondition")
        break
      end
      if UnlockConditionPriority[i] == "WorldLevel" then
        do
          local level = value[2]
          lockTxt = orderedFormat(ConfigTable.GetUIText("Story_UnlockWorldLv") or "", level)
        end
        break
      end
      if UnlockConditionPriority[i] == "MustAchievementIds" and bHasAchievementData == true then
        local tbAchievementList = value[2]
        for k, v in pairs(tbAchievementList) do
          if v == false then
            local achievementId = k
            local achievement = ConfigTable.GetData("Achievement", achievementId)
            lockTxt = orderedFormat(ConfigTable.GetUIText("Story_UnlockAchievement") or "", achievement.Title) .. "\n" .. "(" .. achievement.Desc .. ")"
            break
          end
        end
      end
      break
    end
  end
  return lockTxt
end

function AvgData:MarkStoryId(sAvgId)
  if self.storySource ~= nil then
    self.storySource:MarkStoryId(sAvgId)
    return
  end
  if AVG_EDITOR == true then
  elseif type(self.CURRENT_STORY_ID) == "number" then
    local cfgdata = ConfigTable.GetData_Story(self.CURRENT_STORY_ID)
    if cfgdata == nil then
      return
    end
  else
    return
  end
  local nId, storyId = self:AvgLuaNameToStoryId(sAvgId)
  if storyId == nil then
    return
  end
  if table.indexof(self.tbTempStoryIds, storyId) <= 0 then
    table.insert(self.tbTempStoryIds, storyId)
  end
end

function AvgData:MarkEvId(sId)
  if self.storySource ~= nil then
    self.storySource:MarkEvId(sId)
    return
  end
  if table.indexof(self.tbTempEvIds, sId) <= 0 and 0 >= table.indexof(self.tbEvIds, sId) then
    table.insert(self.tbTempEvIds, sId)
  end
end

function AvgData:IsChosen(sAvgId, nGroupId, nIndex)
  if self.storySource ~= nil then
    return self.storySource:IsChosen(sAvgId, nGroupId, nIndex)
  end
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

function AvgData:MarkChosen(sAvgId, nGroupId, nIndex)
  if self.storySource ~= nil then
    self.storySource:MarkChosen(sAvgId, nGroupId, nIndex)
    return
  end
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

function AvgData:IsEvidenceUnlock(evidenceId)
  for k, v in ipairs(self.tbEvIds) do
    if v == evidenceId then
      return true
    end
  end
  return false
end

function AvgData:IsStoryReaded(nStoryId)
  local cfgData = ConfigTable.GetData_Story(nStoryId)
  if cfgData == nil then
    return false
  end
  if table.indexof(self.tbStoryIds, cfgData.StoryId) > 0 or 0 < table.indexof(self.tbTempStoryIds, cfgData.StoryId) then
    return true
  end
  return false
end

function AvgData:IsChapterAllRead(nChapterId)
  local chapterStoryIds = self.CFG_ChapterStoryNumIds[nChapterId]
  if chapterStoryIds == nil or #chapterStoryIds == 0 then
    return false
  end
  for _, nStoryId in ipairs(chapterStoryIds) do
    if not self:IsStoryReaded(nStoryId) then
      return false
    end
  end
  return true
end

function AvgData:IsChapterLastStoryRead(nChapterId)
  local chapterStoryIds = self.CFG_ChapterStoryNumIds[nChapterId]
  if chapterStoryIds == nil or #chapterStoryIds == 0 then
    return false
  end
  for _, nStoryId in ipairs(chapterStoryIds) do
    local mapStoryCfg = ConfigTable.GetData_Story(nStoryId)
    if mapStoryCfg ~= nil and mapStoryCfg.IsLast == true then
      return self:IsStoryReaded(nStoryId)
    end
  end
  return self:IsStoryReaded(chapterStoryIds[#chapterStoryIds])
end

function AvgData:MarkSkip(_bSkip)
  self.bSkip = _bSkip == true
end

function AvgData:GetHistoryChoosedPersonality(sAvgId, nGroupId)
  if self.storySource ~= nil then
    return self.storySource:GetHistoryChoosedPersonality(sAvgId, nGroupId)
  end
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

function AvgData:MarkChoosedPersonality(sAvgId, nGroupId, nIndex, nFactor)
  if self.storySource ~= nil then
    self.storySource:MarkChoosedPersonality(sAvgId, nGroupId, nIndex, nFactor)
    return
  end
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

function AvgData:GetPersonalityId()
  local _, _, sFace = self:CalcPersonality(1)
  return sFace and tostring(sFace) or ""
end

function AvgData:PersonalityChangedUpload(sOldPersonalityId)
  local sNewPersonalityId = self:GetPersonalityId()
  if sOldPersonalityId == sNewPersonalityId then
    return
  end
  local tabEvt = {}
  table.insert(tabEvt, {
    "before_personality",
    sOldPersonalityId
  })
  table.insert(tabEvt, {
    "after_personality",
    sNewPersonalityId
  })
  table.insert(tabEvt, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  NovaAPI.UserEventUpload("personality_change", tabEvt)
end

function AvgData:CalcPersonality(nId)
  local cfgData_SRP = ConfigTable.GetData("StoryRolePersonality", nId)
  local tbPersonalityBaseNum = cfgData_SRP.BaseValue
  local nTotalCount = tbPersonalityBaseNum[1] + tbPersonalityBaseNum[2] + tbPersonalityBaseNum[3]
  local tbPData = {
    {
      nIndex = 1,
      nCount = tbPersonalityBaseNum[1],
      nPercent = 0
    },
    {
      nIndex = 2,
      nCount = tbPersonalityBaseNum[2],
      nPercent = 0
    },
    {
      nIndex = 3,
      nCount = tbPersonalityBaseNum[3],
      nPercent = 0
    }
  }
  local tbPersonality = self.mapPersonality
  local tbPersonalityFactor = self.mapPersonalityFactor
  local nFactor = 1
  for sAvgId, v in pairs(tbPersonality) do
    for nGroupId, vv in pairs(v) do
      nFactor = 1
      if tbPersonalityFactor[sAvgId] ~= nil then
        nFactor = tbPersonalityFactor[sAvgId][nGroupId] or 1
      end
      nTotalCount = nTotalCount + nFactor
      local _idx = vv
      if _idx == 4 then
        _idx = 3
      end
      tbPData[_idx].nCount = tbPData[_idx].nCount + nFactor
    end
  end
  for k, v in pairs(self.mapActivityPersonality) do
    for i, vv in ipairs(v) do
      tbPData[i].nCount = tbPData[i].nCount + vv
      nTotalCount = nTotalCount + vv
    end
  end
  for i, v in ipairs(tbPData) do
    tbPData[i].nPercent = tbPData[i].nCount / nTotalCount
  end
  local sTitle, sFace, sHead
  table.sort(tbPData, function(a, b)
    return a.nCount > b.nCount
  end)
  if self.TempLocalData ~= nil then
    tbPData = self.TempLocalData
    table.sort(tbPData, function(a, b)
      return a.nPercent > b.nPercent
    end)
  end
  local nMaxIndex = tbPData[1].nIndex
  local nMaxPercent = tbPData[1].nPercent
  local nIdx = nMaxIndex
  if 0.9 <= nMaxPercent then
    local tbTitle = {
      cfgData_SRP.Amax,
      cfgData_SRP.Bmax,
      cfgData_SRP.Cmax
    }
    local tbFace = {
      cfgData_SRP.AmaxFace,
      cfgData_SRP.BmaxFace,
      cfgData_SRP.CmaxFace
    }
    local tbHead = {
      cfgData_SRP.AmaxHead,
      cfgData_SRP.BmaxHead,
      cfgData_SRP.CmaxHead
    }
    sTitle = tbTitle[nMaxIndex]
    sFace = tbFace[nMaxIndex]
    sHead = tbHead[nMaxIndex]
  elseif 0.5 <= nMaxPercent then
    local tbTitle = {
      cfgData_SRP.Aplus,
      cfgData_SRP.Bplus,
      cfgData_SRP.Cplus
    }
    local tbFace = {
      cfgData_SRP.AplusFace,
      cfgData_SRP.BplusFace,
      cfgData_SRP.CplusFace
    }
    local tbHead = {
      cfgData_SRP.AplusHead,
      cfgData_SRP.BplusHead,
      cfgData_SRP.CplusHead
    }
    sTitle = tbTitle[nMaxIndex]
    sFace = tbFace[nMaxIndex]
    sHead = tbHead[nMaxIndex]
    nIdx = nIdx + 3
  elseif math.abs(tbPData[2].nPercent - tbPData[3].nPercent) < 0.1 then
    sTitle = cfgData_SRP.Normal
    sFace = cfgData_SRP.NormalFace
    sHead = cfgData_SRP.NormalHead
    nIdx = 10
  else
    local tbTitleFace = {
      [1] = {
        sTitle = cfgData_SRP.Abc,
        sFace = cfgData_SRP.AbcFace,
        sHead = cfgData_SRP.AbcHead
      },
      [2] = {
        sTitle = cfgData_SRP.Bac,
        sFace = cfgData_SRP.BacFace,
        sHead = cfgData_SRP.BacHead
      },
      [3] = {
        sTitle = cfgData_SRP.Cab,
        sFace = cfgData_SRP.CabFace,
        sHead = cfgData_SRP.CabHead
      }
    }
    local data = tbTitleFace[nMaxIndex]
    sTitle = data.sTitle
    sFace = data.sFace
    sHead = data.sHead
    nIdx = nMaxIndex + 6
  end
  local tbRetPercent = {}
  for i, v in ipairs(tbPData) do
    tbRetPercent[v.nIndex] = v.nPercent
  end
  return tbRetPercent, sTitle, sFace, tbPData, nTotalCount, sHead, nIdx
end

function AvgData:SetSelBuildId(nBuildId)
  self.selBuildId = nBuildId
end

function AvgData:GetCachedBuildId()
  return self.selBuildId
end

function AvgData:GetChapterCount()
  local count = 0
  local data = {}
  
  local function forEachChapter(mapData)
    if self:IsStoryChapterShow(mapData.Id) == true then
      count = count + 1
      table.insert(data, mapData)
    end
  end
  
  ForEachTableLine(DataTable.StoryChapter, forEachChapter)
  return count, data
end

function AvgData:IsStoryChapterUnlock(nChapterId)
  local mapStoryData = ConfigTable.GetData("StoryChapter", nChapterId)
  if mapStoryData == nil then
    return false
  end
  local nWorldClass = mapStoryData.WorldClass
  local nCurWorldClass = PlayerData.Base:GetWorldClass()
  if nWorldClass > nCurWorldClass then
    return false, orderedFormat(ConfigTable.GetUIText("Story_UnlockWorldLv") or "", nWorldClass)
  end
  local tbPrevId
  tbPrevId = mapStoryData.PrevStories
  for __, nPrevId in ipairs(tbPrevId) do
    if not self:IsStoryReaded(self.CFG_Story[nPrevId]) then
      local cfgData = ConfigTable.GetData_Story(self.CFG_Story[nPrevId])
      local chapterConfig = ConfigTable.GetData("StoryChapter", cfgData.Chapter)
      return false, orderedFormat(ConfigTable.GetUIText("Story_UnlockPreId") or "", chapterConfig.Name)
    end
  end
  local nPrevChapterId = nChapterId - 1
  local mapPrevChapterData = 0 < nPrevChapterId and ConfigTable.GetData("StoryChapter", nPrevChapterId) or nil
  if mapPrevChapterData ~= nil then
    if nCurWorldClass < mapPrevChapterData.WorldClass then
      return false, orderedFormat(ConfigTable.GetUIText("Story_UnlockWorldLv") or "", mapPrevChapterData.WorldClass)
    end
    for __, nPrevId in ipairs(mapPrevChapterData.PrevStories) do
      if not self:IsStoryReaded(self.CFG_Story[nPrevId]) then
        return false, orderedFormat(ConfigTable.GetUIText("Story_UnlockPreId") or "", mapPrevChapterData.Name)
      end
    end
  end
  return true
end

function AvgData:IsStoryChapterShow(nChapterId)
  local mapStoryData = ConfigTable.GetData("StoryChapter", nChapterId)
  if mapStoryData == nil then
    return false
  end
  if mapStoryData.OpenTime == "" then
    return true
  end
  local nOpenTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapStoryData.OpenTime)
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  return nOpenTime <= nCurTime
end

function AvgData:SendMsg_STORY_ENTER(nStoryId, nBuildId, bNewestStory)
  if type(nStoryId) == "string" then
    nStoryId = self.CFG_Story[nStoryId]
    if type(nStoryId) ~= "number" then
      return
    end
  end
  if type(nStoryId) == "number" then
    local cfgdata = ConfigTable.GetData_Story(nStoryId)
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
      PlayerData.Story:SetLastMainlineStoryId(nStoryId)
    end
    if nBuildId ~= 0 then
      self.selBuildId = nBuildId
    end
    self.CURRENT_STORY_ID = nStoryId
    local mapCfgData_Story = ConfigTable.GetData_Story(nStoryId)
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
        self.curLevel:Init(self, nStoryId, nBuildId)
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
  end
  
  local nBuildType = 0
  local buildPackge
  local mapBuildData = PlayerData.Build:GetBuildData(nBuildId)
  if mapBuildData ~= nil then
    local bTrial = mapBuildData.nBuildSource == AllEnum.BuildSource.Trial or mapBuildData.nBuildSource == AllEnum.BuildSource.LimitedTrial
    nBuildType = bTrial and 2 or 1
    buildPackge = {Type = nBuildType, BuildId = nBuildId}
  end
  HttpNetHandler.SendMsg(NetMsgId.Id.story_apply_req, {Idx = nStoryId, Build = buildPackge}, nil, func_cb)
end

function AvgData:SendMsg_STORY_DONE(callBack, tbBattleEvents)
  local mapSendMsgData = {
    List = {},
    Evidences = {},
    Events = tbBattleEvents == nil and {
      List = {}
    } or tbBattleEvents
  }
  local mapStoryCfg = ConfigTable.GetData_Story(self.CURRENT_STORY_ID)
  local bBattle = mapStoryCfg.IsBattle
  if bBattle then
    mapSendMsgData.List[1] = {
      Idx = self.CURRENT_STORY_ID
    }
    if table.indexof(self.tbTempStoryIds, mapStoryCfg.StoryId) <= 0 then
      table.insert(self.tbTempStoryIds, mapStoryCfg.StoryId)
    end
  else
    if self:SafeCheck() ~= true then
      self:ClearTempData()
      local sErrorLog = "error:"
      for i, v in ipairs(self.tbTempStoryIds) do
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
          Idx = nStoryId,
          Major = {},
          Personality = {}
        }
        local mapStoryCfg = ConfigTable.GetData_Story(nStoryId)
        if mapStoryCfg ~= nil then
          local sAvgId = mapStoryCfg.AvgLuaName
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
                elseif nChoiceIndex == 4 then
                  n = 8
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
        table.insert(mapSendMsgData.Evidences, self.CFG_StoryEvidence[sEvId])
      end
    end
    self:CheckNewStoryRedDot()
    local tbPassId = {}
    for _, v in ipairs(mapSendMsgData.List) do
      table.insert(tbPassId, v.Idx)
    end
    PlayerData.Char:StoryPass(tbPassId)
  end
  
  local function func_merge(tbSrc, tbTarget)
    for i, v in ipairs(tbSrc) do
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
  
  local function func_succ(_, mapChangeInfo)
    if mapStoryCfg.Chapter == 1 and mapStoryCfg.IsLast and mapChangeInfo and mapChangeInfo.Props and #mapChangeInfo.Props > 0 then
      PlayerData.Base:UserEventUpload_PC("pc_mainstory_1_clear")
    end
    if mapStoryCfg.Chapter == 2 and mapStoryCfg.IsLast and mapChangeInfo and mapChangeInfo.Props and #mapChangeInfo.Props > 0 then
      local tab = {}
      table.insert(tab, {
        "role_id",
        tostring(PlayerData.Base._nPlayerId)
      })
      NovaAPI.UserEventUpload("chapter2_complete", tab)
      PlayerData.Base:UserEventUpload_PC("pc_mainstory_2_clear")
    end
    if 1 < #self.tbTempStoryIds then
      local nRecentStoryId = self.CFG_Story[self.tbTempStoryIds[#self.tbTempStoryIds]]
      self:SetRecentStoryId(nRecentStoryId)
    end
    if self.tbLastEndStoryIds ~= nil then
      for _, nLastEndStoryId in ipairs(self.tbLastEndStoryIds) do
        local mapLastEndStoryCfg = ConfigTable.GetData_Story(nLastEndStoryId)
        if mapLastEndStoryCfg ~= nil and 0 < table.indexof(self.tbTempStoryIds, mapLastEndStoryCfg.StoryId) then
          self:SetLastEndState(nLastEndStoryId)
        end
      end
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
          elseif nChoiceIndex == 4 then
            n = 8
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
    local sOldPid = next(self.mapTempPersonality) ~= nil and self:GetPersonalityId()
    func_overwrite(self.mapTempPersonality, self.mapPersonality)
    self.mapTempPersonality = {}
    self.mapTempPersonalityCnt = {}
    func_overwrite(self.mapTempPersonalityFactor, self.mapPersonalityFactor)
    self.mapTempPersonalityFactor = {}
    if sOldPid then
      self:PersonalityChangedUpload(sOldPid)
    end
    if callBack ~= nil then
      callBack(mapChangeInfo)
    end
    local bHasReward = not bBattle and mapChangeInfo and mapChangeInfo.Props and #mapChangeInfo.Props > 0
    if bHasReward then
      local tbItem = {}
      local tbRewardDisplay = UTILS.DecodeChangeInfo(mapChangeInfo)
      for _, v in pairs(tbRewardDisplay) do
        for k, value in pairs(v) do
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
        tostring(mapStoryCfg.Id)
      })
      local _skip = self.bSkip == true and "1" or "0"
      table.insert(tabEvent, {"is_skip", _skip})
      table.insert(tabEvent, {
        "role_id",
        tostring(PlayerData.Base._nPlayerId)
      })
      NovaAPI.UserEventUpload("main_story", tabEvent)
      
      local function AfterRewardDisplay()
        EventManager.Hit("Story_RewardClosed")
      end
      
      local function delayOpen()
        UTILS.OpenReceiveByDisplayItem(tbItem, mapChangeInfo, AfterRewardDisplay)
      end
      
      local nDelayTime = 1.5
      EventManager.Hit(EventId.TemporaryBlockInput, nDelayTime)
      TimerManager.Add(1, nDelayTime, self, delayOpen, true, true, true)
    end
    EventManager.Hit("Story_Done", bHasReward)
    printLog("通关结算完成")
  end
  
  printLog("发送通关消息")
  self.nJustReadStoryId = self.CURRENT_STORY_ID
  HttpNetHandler.SendMsg(NetMsgId.Id.story_settle_req, mapSendMsgData, nil, func_succ)
  self.CURRENT_STORY_ID = 0
end

function AvgData:OnEvent_AvgSTEnd()
  if AVG_EDITOR == true then
    self.tbTempStoryIds = {}
    self.tbTempEvIds = {}
    self.mapTempCL = {}
    self.mapTempLatestCnt = {}
    self.mapTempPersonality = {}
    self.mapTempPersonalityCnt = {}
    self.mapTempPersonalityFactor = {}
    return
  end
  EventManager.Remove("AvgSTEnd", self, self.OnEvent_AvgSTEnd)
  self:SendMsg_STORY_DONE()
end

function AvgData:LevelEnd()
  PlayerData.Build:DeleteTrialBuild()
  if type(self.curLevel.UnBindEvent) == "function" then
    self.curLevel:UnBindEvent()
  end
  self.curLevel = nil
end

function AvgData:GetLastestStoryId()
  self.nLastestChapter = 0
  
  local function foreachfunc(mapData)
    if mapData ~= nil then
      local nStoryId = mapData.Id
      local sStoryName = table.keyof(self.CFG_Story, nStoryId)
      local nIdx = table.indexof(self.tbStoryIds, sStoryName)
      if nIdx ~= nil and 0 < nIdx and mapData.Chapter > self.nLastestChapter then
        self.nLastestChapter = mapData.Chapter
      end
    end
  end
  
  ForEachTableLine(DataTable.Story, foreachfunc)
  if self.nLastestChapter == 0 then
    return 101
  end
  local tbLastestChapterStoryIds = self.CFG_ChapterStoryNumIds[self.nLastestChapter]
  if tbLastestChapterStoryIds ~= nil then
    local nMaxStoryId = 0
    for k, v in pairs(tbLastestChapterStoryIds) do
      local sStoryName = table.keyof(self.CFG_Story, v)
      local nIdx = table.indexof(self.tbStoryIds, sStoryName)
      if nIdx ~= nil and 0 < nIdx and v > nMaxStoryId then
        nMaxStoryId = v
      end
    end
    return nMaxStoryId
  end
  return 101
end

function AvgData:GetRecentStoryId(nChapterId)
  local nStoryId = self.mapRecentStoryId[tostring(nChapterId)]
  if nStoryId == nil then
    local tbStoryNumId = self.CFG_ChapterStoryNumIds[nChapterId]
    if tbStoryNumId ~= nil then
      table.sort(tbStoryNumId, function(a, b)
        return a < b
      end)
      for i = #tbStoryNumId, 1, -1 do
        local v = tbStoryNumId[i]
        if self.tbStoryIds[v] then
          nStoryId = v
          break
        end
      end
    end
  end
  if nStoryId == nil then
    local chapterConfig = ConfigTable.GetData("StoryChapter", nChapterId)
    nStoryId = chapterConfig.UnlockShowStoryId
  end
  return nStoryId
end

function AvgData:SetRecentStoryId(nStoryId)
  local cfgData = ConfigTable.GetData_Story(nStoryId)
  if cfgData ~= nil then
    self.mapRecentStoryId[tostring(cfgData.Chapter)] = nStoryId
    local sJson = RapidJson.encode(self.mapRecentStoryId)
    LocalData.SetPlayerLocalData("RecentStoryId", sJson)
  end
end

function AvgData:CheckNewStoryRedDot()
  local _, data = self:GetChapterCount()
  for k, v in ipairs(data) do
    local bHasNew = false
    if self:IsStoryChapterUnlock(v.Id) then
      local tbStoryIds = self:CheckNewStory(v.Id)
      for k, v in pairs(tbStoryIds) do
        if v == true then
          bHasNew = true
          break
        end
      end
    end
    local nChapterId = v.Id
    local cfg = ConfigTable.GetData("StoryChapter", nChapterId)
    RedDotManager.SetValid(RedDotDefine.Map_MainLine_Chapter, {
      cfg.StoryLineId,
      nChapterId
    }, bHasNew)
  end
end

function AvgData:CheckNewStory(nChapterId)
  local tbNewUnlockStorys = {}
  local map = self.CFG_ChapterStoryNumIds[nChapterId]
  if type(map) == "table" then
    for k, v in ipairs(map) do
      local config = ConfigTable.GetData("Story", v)
      local bUnlock = self:IsUnlock(config.ConditionId, config.StoryId)
      if bUnlock then
        local bReaded = self:IsStoryReaded(v)
        if not bReaded then
          tbNewUnlockStorys[v] = true
        end
      end
    end
  else
    printError("[AvgData:CheckNewStory] can't find story id in chapter:" .. tostring(nChapterId))
  end
  return tbNewUnlockStorys
end

function AvgData:SetNewLockChapterIndex(chapterIndex)
  self.nNewLockChapterIndex = chapterIndex
end

function AvgData:GetNewLockChapterIndex()
  if self.nNewLockChapterIndex == nil then
    self.nNewLockChapterIndex = -1
  end
  local tempIndex = self.nNewLockChapterIndex
  self.nNewLockChapterIndex = -1
  return tempIndex
end

function AvgData:SetLastEndState(nStoryId)
  local storyConifg = ConfigTable.GetData_Story(nStoryId)
  if storyConifg == nil then
    return
  end
  if self.tbLastEndStateMap == nil then
    self.tbLastEndStateMap = {}
  end
  local isUnlock = self:IsUnlock(storyConifg.ConditionId, storyConifg.StoryId)
  if isUnlock then
    local isReaded = self:IsStoryReaded(nStoryId)
    local nState = AllEnum.MainlineLastEndState.Unlock
    if isReaded then
      nState = AllEnum.MainlineLastEndState.Fobidden
      local nResetChapterId = ConfigTable.GetConfigNumber("StoryLastEnd_UnlockCondition_Chapter" .. tostring(storyConifg.Chapter))
      if nResetChapterId ~= nil and 0 < nResetChapterId and self:IsChapterLastStoryRead(nResetChapterId) then
        nState = AllEnum.MainlineLastEndState.Unlock
      end
    end
    self.tbLastEndStateMap[nStoryId] = nState
    self.LastEndState = nState
    for _, nSt in pairs(self.tbLastEndStateMap) do
      if nSt == AllEnum.MainlineLastEndState.Fobidden then
        self.LastEndState = AllEnum.MainlineLastEndState.Fobidden
        break
      end
    end
  else
    self.tbLastEndStateMap[nStoryId] = nil
    local chapterId = storyConifg.Chapter
    local allReaded = true
    local map = self.CFG_ChapterStoryNumIds[chapterId]
    if type(map) == "table" then
      for k, v in pairs(map) do
        if v ~= storyConifg.StoryId then
          local isReaded = self:IsStoryReaded(v)
          if not isReaded then
            allReaded = false
            break
          end
        end
      end
    end
    self.LastEndState = allReaded and AllEnum.MainlineLastEndState.WaitUnlock or AllEnum.MainlineLastEndState.None
  end
end

function AvgData:GetLastEndState()
  if self.LastEndState == nil then
    return AllEnum.MainlineLastEndState.None
  end
  return self.LastEndState
end

function AvgData:SetStorySource(dataObj)
  self.storySource = dataObj
end

function AvgData:AvgEditorTempData(sConditionIds, bAdd)
  if self.tbAvgEditorTempData_Unlocked_sConditionIds == nil then
    self.tbAvgEditorTempData_Unlocked_sConditionIds = {}
  end
  if sConditionIds == "all" then
    if bAdd == false then
      self.tbAvgEditorTempData_Unlocked_sConditionIds = {}
    end
  else
    local tbIds = string.split(sConditionIds, ",")
    for i, v in ipairs(tbIds) do
      if bAdd == true then
        if table.indexof(self.tbAvgEditorTempData_Unlocked_sConditionIds, v) <= 0 then
          table.insert(self.tbAvgEditorTempData_Unlocked_sConditionIds, v)
        end
      else
        local n = table.indexof(self.tbAvgEditorTempData_Unlocked_sConditionIds, v)
        if 0 < n then
          table.remove(self.tbAvgEditorTempData_Unlocked_sConditionIds, n)
        end
      end
    end
  end
end

function AvgData:AvgEditorTempIfTrueData(sData, bAdd)
  if self.mapAvgEditorTempData_IsTrueData == nil then
    self.mapAvgEditorTempData_IsTrueData = {}
  end
  if sData == "all" then
    if bAdd == false then
      self.mapAvgEditorTempData_IsTrueData = {}
    end
  else
    local tbCell = string.split(sData, ",")
    local tbChoice = {
      "A",
      "B",
      "C"
    }
    for i, v in ipairs(tbCell) do
      if v ~= nil and v ~= "" then
        local tbData = string.split(v, "-")
        if tbData ~= nil and #tbData == 4 then
          local sAvgId = tbData[1]
          local sKey = tbData[2]
          local nGroupId = tonumber(tbData[3])
          local nIndex = table.indexof(tbChoice, tbData[4])
          if self.mapAvgEditorTempData_IsTrueData[sAvgId] == nil then
            self.mapAvgEditorTempData_IsTrueData[sAvgId] = {}
          end
          if self.mapAvgEditorTempData_IsTrueData[sAvgId][sKey] == nil then
            self.mapAvgEditorTempData_IsTrueData[sAvgId][sKey] = {}
          end
          self.mapAvgEditorTempData_IsTrueData[sAvgId][sKey][nGroupId] = nIndex
        end
      end
    end
  end
end

function AvgData:CacheEvData()
  self.tbEvData = {}
  
  local function forEachLine_Story(storConfig)
    local sConditionId = storConfig.ConditionId
    if sConditionId == nil then
      return
    end
    if self.CFG_StoryCondition[sConditionId] == nil then
      return
    end
    local nConditionId = self.CFG_StoryCondition[sConditionId]
    local mapConditionData = ConfigTable.GetData("StoryCondition", nConditionId)
    local tbEvIds = {}
    if #mapConditionData.EvIds_a > 0 then
      for k, v in ipairs(mapConditionData.EvIds_a) do
        table.insert(tbEvIds, v)
      end
    end
    if 0 < #mapConditionData.EvIds_b then
      for k, v in ipairs(mapConditionData.EvIds_b) do
        table.insert(tbEvIds, v)
      end
    end
    if #tbEvIds == 0 then
      return
    end
    for i, v in ipairs(tbEvIds) do
      if self.tbEvData[v] == nil then
        self.tbEvData[v] = {}
      end
      table.insert(self.tbEvData[v], storConfig.StoryId)
    end
  end
  
  ForEachTableLine(DataTable.Story, forEachLine_Story)
end

function AvgData:CachePersonalityData(actPersonalityData)
  self.mapActivityPersonality = {}
  for k, v in pairs(actPersonalityData) do
    self.mapActivityPersonality[v.ChapterId] = {
      v.A,
      v.B,
      v.C
    }
  end
end

function AvgData:RefreshActPersonalityData(nChapterId, personalityData, personalityFactorData)
  local tbPData = {
    0,
    0,
    0
  }
  local nFactor = 1
  for sAvgId, v in pairs(personalityData) do
    for nGroupId, vv in pairs(v) do
      nFactor = 1
      if personalityFactorData[sAvgId] ~= nil then
        nFactor = personalityFactorData[sAvgId][nGroupId] or 1
      end
      local _idx = vv
      if _idx == 4 then
        _idx = 3
      end
      tbPData[_idx] = tbPData[_idx] + nFactor
    end
  end
  for i, v in ipairs(tbPData) do
    if v ~= 0 then
      self.mapActivityPersonality[nChapterId][i] = v
    end
  end
end

function AvgData:CheckBE(nChapterFrom, nChapterTo)
  local nTotal = 0
  local nRead = 0
  
  local function foreach_Story(cfg)
    local nChapterId = cfg.Chapter
    local bIsBranch = cfg.IsBranch == true
    if bIsBranch == true and nChapterId >= nChapterFrom and nChapterId <= nChapterTo then
      nTotal = nTotal + 1
      if self:IsStoryReaded(cfg.Id) == true then
        nRead = nRead + 1
      end
    end
  end
  
  ForEachTableLine(DataTable.Story, foreach_Story)
  local nResult = nRead / nTotal
  return nResult
end

return AvgData
