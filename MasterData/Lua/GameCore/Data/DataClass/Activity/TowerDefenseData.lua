local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local TowerDefenseData = class("TowerDefenseData", ActivityDataBase)
local LocalData = require("GameCore.Data.LocalData")
local RapidJson = require("rapidjson")
local RedDotManager = require("GameCore.RedDot.RedDotManager")
local ClientManager = CS.ClientManager.Instance
local TowerDefenseLevelData = require("GameCore.Data.DataClass.Activity.TowerDefenseLevelData")

function TowerDefenseData:Init()
  self:InitData()
  self:AddListeners()
end

function TowerDefenseData:InitData()
  self.allLevelData = {}
  self.teamData = {}
  self.allQuestData = {}
  self.allStoryData = {}
  self.guideData = {}
  self.cacheEnterLevelList = {}
  self.TowerDefenseLevelData = TowerDefenseLevelData.new()
  self.TempLevelTeamData = {}
  self.tempData = nil
end

function TowerDefenseData:UpdateStatus()
  for _, levelData in pairs(self.allLevelData) do
    local levelConfig = ConfigTable.GetData("TowerDefenseLevel", levelData.nLevelId)
    if levelConfig ~= nil and self:IsLevelUnlock(levelData.nLevelId) and self:IsPreLevelPass(levelData.nLevelId) then
      RedDotManager.SetValid(RedDotDefine.Activity_TowerDefense_Level, {
        levelConfig.LevelPage,
        levelData.nLevelId
      }, self:GetlevelIsNew(levelData.nLevelId))
    end
  end
  for _, storyData in pairs(self.allStoryData) do
    RedDotManager.SetValid(RedDotDefine.Activity_TowerDefense_Story, {
      storyData.nId
    }, self:GetStoryIsNew(storyData.nId))
  end
  self:RefreshRedDot()
end

function TowerDefenseData:AddListeners()
  EventManager.Add(EventId.IsNewDay, self, self.OnEvent_NewDay)
end

function TowerDefenseData:GetActConfig()
  self.actCfgData = ConfigTable.GetData("TowerDefenseControl", self.nActId)
  return self.actCfgData
end

function TowerDefenseData:RefreshTowerDefenseActData(actId, msgData)
  self:InitData()
  self.nActId = actId
  local sJson = LocalData.GetPlayerLocalData("TowerDefenseLevel")
  local tb = decodeJson(sJson)
  if type(tb) == "table" then
    self.cacheEnterLevelList = tb
  end
  for _, level in pairs(msgData.Levels) do
    self:UpdateLevelData(level)
  end
  local curActLevelIds = {}
  
  local function foreachTable(data)
    if data.activityId == self.nActId then
      table.insert(curActLevelIds, data.Id)
    end
  end
  
  ForEachTableLine(DataTable.TowerDefenseLevel, foreachTable)
  for _, levelId in pairs(curActLevelIds) do
    if self.allLevelData[levelId] == nil then
      self:UpdateLevelData({Id = levelId, Star = 0})
    end
  end
  local allStoryConfigList = {}
  
  local function foreach_storyTable(data)
    if data.ActivityIdId == self.nActId then
      table.insert(allStoryConfigList, data.Id)
    end
  end
  
  ForEachTableLine(DataTable.TowerDefenseStory, foreach_storyTable)
  local tempStoryData = {}
  for _, value in pairs(allStoryConfigList) do
    tempStoryData[value] = {nId = value, bIsRead = false}
  end
  for _, value in pairs(msgData.Stories) do
    tempStoryData[value] = {nId = value, bIsRead = true}
  end
  for _, value in pairs(tempStoryData) do
    self:UpdateStoryData(value)
  end
  
  local function foreach_questGroupTable(data)
    if data.ActivityId == self.nActId then
      self.allQuestData[data.Id] = {}
    end
  end
  
  ForEachTableLine(DataTable.TowerDefenseQuestGroup, foreach_questGroupTable)
  
  local function foreach_questTable(data)
    if self.allQuestData[data.QuestGroupId] ~= nil then
      local nMax = 1
      if data.QuestType == GameEnum.towerDefenseCond.TowerDefenseClear then
        nMax = 1
      elseif data.QuestType == GameEnum.towerDefenseCond.TowerDefenseClearSpecificStar then
        nMax = 1
      end
      local progressData = {}
      table.insert(progressData, {Cur = 0, Max = nMax})
      self:UpdateQuest({
        nId = data.Id,
        nState = AllEnum.ActQuestStatus.UnComplete,
        progress = progressData
      })
    end
  end
  
  ForEachTableLine(DataTable.TowerDefenseQuest, foreach_questTable)
  for _, quest in pairs(msgData.Quests) do
    self:UpdateQuest({
      nId = quest.Id,
      nState = self:QuestStateServer2Client(quest.Status),
      progress = quest.Progress
    })
  end
  self:RefreshRedDot()
end

function TowerDefenseData:GetLevelStartTime(levelId)
  local levelConfig = ConfigTable.GetData("TowerDefenseLevel", levelId)
  if levelConfig == nil then
    return 0
  end
  local openActDayNextTime = ClientManager:GetNextRefreshTime(self.nOpenTime)
  local nTempDay = 0
  if openActDayNextTime > self.nOpenTime then
    nTempDay = 1
  end
  local nDay = (ClientManager.serverTimeStamp - openActDayNextTime) // 86400 + nTempDay
  if nDay >= levelConfig.ActiveTime then
    return 0
  end
  local openDayNextTime = ClientManager:GetNextRefreshTime(ClientManager.serverTimeStamp)
  return openDayNextTime + (levelConfig.ActiveTime - nDay - 1) * 86400
end

function TowerDefenseData:UpdateLevelData(levelData)
  self.allLevelData[levelData.Id] = {
    nLevelId = levelData.Id,
    nStar = levelData.Star
  }
  local levelConfig = ConfigTable.GetData("TowerDefenseLevel", levelData.Id)
  if levelConfig == nil then
    return
  end
  if self:GetPlayState() and self:IsLevelUnlock(levelData.Id) and self:IsPreLevelPass(levelData.Id) then
    RedDotManager.SetValid(RedDotDefine.Activity_TowerDefense_Level, {
      levelConfig.LevelPage,
      levelData.Id
    }, self:GetlevelIsNew(levelData.Id))
  end
  local nextLevelId = self:GetNextLevelId(levelData.Id)
  if nextLevelId ~= 0 then
    local nextLevelConfig = ConfigTable.GetData("TowerDefenseLevel", nextLevelId)
    if nextLevelConfig == nil then
      return
    end
    if self:GetPlayState() and self:IsLevelUnlock(nextLevelId) and self:IsPreLevelPass(nextLevelId) then
      RedDotManager.SetValid(RedDotDefine.Activity_TowerDefense_Level, {
        nextLevelConfig.LevelPage,
        nextLevelId
      }, self:GetlevelIsNew(nextLevelId))
    end
  end
  EventManager.Hit("TowerDefenseLevelUpdate")
end

function TowerDefenseData:GetAllLevelData()
  return self.allLevelData
end

function TowerDefenseData:GetLevelsByTab(nTabIndex)
  local levelsData = {}
  for _, level in pairs(self.allLevelData) do
    local config = ConfigTable.GetData("TowerDefenseLevel", level.nLevelId)
    if config.LevelPage == nTabIndex then
      table.insert(levelsData, level)
    end
  end
  return levelsData
end

function TowerDefenseData:GetLevelData(levelId)
  return self.allLevelData[levelId]
end

function TowerDefenseData:IsLevelPass(levelId)
  local bResult = false
  local levelData = self:GetLevelData(levelId)
  if levelData ~= nil and levelData.nStar > 0 then
    bResult = true
  end
  return bResult
end

function TowerDefenseData:IsLevelUnlock(levelId)
  if levelId == 0 then
    return true
  end
  local bResult = false
  local levelData = self:GetLevelData(levelId)
  local time = CS.ClientManager.Instance.serverTimeStamp
  if levelData ~= nil and time >= self:GetLevelStartTime(levelData.nLevelId) then
    bResult = true
  end
  return bResult
end

function TowerDefenseData:IsPreLevelPass(levelId)
  if levelId == 0 then
    return true
  end
  local bResult = false
  local levelConfig = ConfigTable.GetData("TowerDefenseLevel", levelId)
  if levelConfig == nil then
    return bResult
  end
  local preLevelId = levelConfig.PreLevel
  if preLevelId == 0 then
    bResult = true
  else
    local levelData = self:GetLevelData(preLevelId)
    if levelData ~= nil and 0 < levelData.nStar then
      bResult = true
    end
  end
  return bResult
end

function TowerDefenseData:GetNextLevelId(levelId)
  local nextLevelId = 0
  
  local function foreachTable(data)
    if data.PreLevel == levelId then
      nextLevelId = data.Id
    end
  end
  
  ForEachTableLine(DataTable.TowerDefenseLevel, foreachTable)
  return nextLevelId
end

function TowerDefenseData:GetlevelIsNew(levelId)
  local bResult = false
  local levelData = self:GetLevelData(levelId)
  if levelData ~= nil and levelData.nStar == 0 and table.indexof(self.cacheEnterLevelList, levelId) == 0 then
    bResult = true
  end
  return bResult
end

function TowerDefenseData:EnterLevelSelect(levelId)
  local levelConfig = ConfigTable.GetData("TowerDefenseLevel", levelId)
  if levelConfig == nil then
    return
  end
  if table.indexof(self.cacheEnterLevelList, levelId) == 0 then
    table.insert(self.cacheEnterLevelList, levelId)
    RedDotManager.SetValid(RedDotDefine.Activity_TowerDefense_Level, {
      levelConfig.LevelPage,
      levelId
    }, false)
    LocalData.SetPlayerLocalData("TowerDefenseLevel", RapidJson.encode(self.cacheEnterLevelList))
    self:RefreshRedDot()
  end
end

function TowerDefenseData:RefreshRedDotbyTab(nTabIndex)
  for levelId, _ in pairs(self.allLevelData) do
    local levelConfig = ConfigTable.GetData("TowerDefenseLevel", levelId)
    if levelConfig ~= nil and self:IsLevelUnlock(levelId) and levelConfig.LevelPage == nTabIndex and table.indexof(self.cacheEnterLevelList, levelId) == 0 then
      table.insert(self.cacheEnterLevelList, levelId)
      RedDotManager.SetValid(RedDotDefine.Activity_TowerDefense_Level, {
        levelConfig.LevelPage,
        levelId
      }, false)
    end
  end
  LocalData.SetPlayerLocalData("TowerDefenseLevel", RapidJson.encode(self.cacheEnterLevelList))
  self:RefreshRedDot()
end

function TowerDefenseData:GetNextLevelUnlockTime()
  local nextlevelStartTime = 9999999999
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  for _, level in pairs(self.allLevelData) do
    local startTime = self:GetLevelStartTime(level.nLevelId)
    if curTime < startTime then
      nextlevelStartTime = math.min(nextlevelStartTime, startTime)
    end
  end
  nextlevelStartTime = 0
  return nextlevelStartTime
end

function TowerDefenseData:GetLevelTempTeamData(levelId)
  return self.TempLevelTeamData[levelId]
end

function TowerDefenseData:SetLevelTeamData(levelId, tbCharGuideId, itemGuideId)
  self.TempLevelTeamData[levelId] = {tbCharGuideId = tbCharGuideId, itemGuideId = itemGuideId}
end

function TowerDefenseData:UpdateStoryData(storyData)
  self.allStoryData[storyData.nId] = {
    nId = storyData.Id,
    bIsRead = storyData.bIsRead
  }
  if self:GetPlayState() then
    RedDotManager.SetValid(RedDotDefine.Activity_TowerDefense_Story, {
      storyData.Id
    }, self:GetStoryIsNew(storyData.nId))
  end
  EventManager.Hit("TowerDefenseStoryUpdate")
end

function TowerDefenseData:GetAllStoryData()
  return self.allStoryData
end

function TowerDefenseData:GetStoryData(storyId)
  return self.allStoryData[storyId]
end

function TowerDefenseData:IsStoryUnlock(storyId)
  local bResult = false
  local storyConfig = ConfigTable.GetData("TowerDefenseStory", storyId)
  if storyConfig == nil then
    return bResult
  end
  if storyConfig.LevelId == 0 then
    return true
  end
  local blevelConditionPass = self:IsLevelUnlock(storyConfig.LevelId) and self:IsPreLevelPass(storyConfig.LevelId)
  bResult = blevelConditionPass
  return bResult
end

function TowerDefenseData:GetStoryIsNew(storyId)
  local bResult = false
  local storyData = self:GetStoryData(storyId)
  if storyData ~= nil and not storyData.bIsRead and self:IsStoryUnlock(storyId) and self:IsPreStoryRead(storyId) then
    bResult = true
  end
  return bResult
end

function TowerDefenseData:IsPreStoryRead(storyId)
  local bResult = false
  local storyConfig = ConfigTable.GetData("TowerDefenseStory", storyId)
  if storyConfig == nil then
    return bResult
  end
  local preStoryId = storyConfig.PreStoryId
  if preStoryId == 0 then
    bResult = true
  else
    local preStoryData = self:GetStoryData(preStoryId)
    if preStoryData ~= nil and preStoryData.bIsRead then
      bResult = true
    end
  end
  return bResult
end

function TowerDefenseData:PlayAvg(storyId, avgId)
  local function avgEndCallback()
    EventManager.Remove("StoryDialog_DialogEnd", self, avgEndCallback)
    
    if self.allStoryData[storyId].bIsRead == false then
      self:RequestReadAVG(storyId)
    end
  end
  
  EventManager.Add("StoryDialog_DialogEnd", self, avgEndCallback)
  EventManager.Hit("StoryDialog_DialogStart", avgId)
end

function TowerDefenseData:UpdateQuest(questData)
  local questConfig = ConfigTable.GetData("TowerDefenseQuest", questData.nId)
  if questConfig == nil then
    return
  end
  if self.allQuestData[questConfig.QuestGroupId] == nil then
    self.allQuestData[questConfig.QuestGroupId] = {}
  end
  local progress = {}
  local progressData = {}
  if questData.nState == AllEnum.ActQuestStatus.Complete or questData.nState == AllEnum.ActQuestStatus.Received then
    if questConfig.QuestType == GameEnum.towerDefenseCond.TowerDefenseClear then
      progressData.Cur = 1
      progressData.Max = 1
    elseif questConfig.QuestType == GameEnum.towerDefenseCond.TowerDefenseClearSpecificStar then
      progressData.Cur = 1
      progressData.Max = 1
    else
      progressData.Cur = questConfig.QuestParam[2]
      progressData.Max = questConfig.QuestParam[2]
    end
    table.insert(progress, progressData)
    self.allQuestData[questConfig.QuestGroupId][questData.nId] = {
      nId = questData.nId,
      nState = questData.nState,
      progress = progress
    }
  else
    self.allQuestData[questConfig.QuestGroupId][questData.nId] = {
      nId = questData.nId,
      nState = questData.nState,
      progress = questData.progress
    }
  end
  RedDotManager.SetValid(RedDotDefine.Activity_TowerDefense_Quest, {
    questConfig.QuestGroupId,
    questData.nId
  }, questData.nState == AllEnum.ActQuestStatus.Complete)
  EventManager.Hit("TowerDefenseQuestUpdate")
end

function TowerDefenseData:GetQuestbyGroupId(nGroupId)
  return self.allQuestData[nGroupId]
end

function TowerDefenseData:GetGroupQuestReceiveCount(nGroupId)
  local nResult = 0
  if self.allQuestData[nGroupId] == nil then
    return nResult
  end
  for _, quest in pairs(self.allQuestData[nGroupId]) do
    if quest.nState == AllEnum.ActQuestStatus.Received then
      nResult = nResult + 1
    end
  end
  return nResult
end

function TowerDefenseData:GetAllQuestCount()
  local nResult = 0
  for _, groupQuestList in pairs(self.allQuestData) do
    for key, value in pairs(groupQuestList) do
      nResult = nResult + 1
    end
  end
  return nResult
end

function TowerDefenseData:GetAllReceivedCount()
  local nResult = 0
  for _, groupQuestList in pairs(self.allQuestData) do
    for _, quest in pairs(groupQuestList) do
      if quest.nState == AllEnum.ActQuestStatus.Received then
        nResult = nResult + 1
      end
    end
  end
  return nResult
end

function TowerDefenseData:QuestStateServer2Client(nStatus)
  if nStatus == 0 then
    return AllEnum.ActQuestStatus.UnComplete
  elseif nStatus == 1 then
    return AllEnum.ActQuestStatus.Complete
  else
    return AllEnum.ActQuestStatus.Received
  end
end

function TowerDefenseData:RefreshQuestData(questData)
  self:UpdateQuest({
    nId = questData.Id,
    nState = self:QuestStateServer2Client(questData.Status),
    progress = questData.Progress
  })
  self:RefreshRedDot()
end

function TowerDefenseData:InitTeam(levelId)
  self.teamData = {
    characterList = {},
    itemId = 0
  }
  if self:IsLockTeam(levelId) then
    self.teamData.characterList, self.teamData.itemId = self:GetLockCharacterAndItem(levelId)
  end
end

function TowerDefenseData:IsLockTeam(levelId)
  local bResult = false
  local levelConfig = ConfigTable.GetData("TowerDefenseLevel", levelId)
  if levelConfig == nil then
    return bResult
  end
  local floorConfig = ConfigTable.GetData("TowerDefenseFloor", levelConfig.FloorId)
  if floorConfig == nil then
    return bResult
  end
  bResult = floorConfig.TeamGroup ~= nil and #floorConfig.TeamGroup > 0
  return bResult
end

function TowerDefenseData:GetLockCharacterAndItem(levelId)
  local characterList = {}
  local itemId = 0
  local levelConfig = ConfigTable.GetData("TowerDefenseLevel", levelId)
  if levelConfig == nil then
    return characterList, itemId
  end
  local floorConfig = ConfigTable.GetData("TowerDefenseFloor", levelConfig.FloorId)
  if floorConfig == nil then
    return characterList, itemId
  end
  characterList = floorConfig.TeamGroup or {}
  itemId = floorConfig.ItemID
  return characterList, itemId
end

function TowerDefenseData:RefreshRedDot()
  if not self:GetPlayState() then
    return
  end
  local bReddot = false
  for _, levelData in pairs(self.allLevelData) do
    if self:IsLevelUnlock(levelData.nLevelId) and self:IsPreLevelPass(levelData.nLevelId) then
      bReddot = bReddot or self:GetlevelIsNew(levelData.nLevelId)
      if bReddot then
        RedDotManager.SetValid(RedDotDefine.Activity_Tab, self.nActId, bReddot)
        return
      end
    end
  end
  for _, questGroupData in pairs(self.allQuestData) do
    for _, questData in pairs(questGroupData) do
      bReddot = bReddot or questData.nState == AllEnum.ActQuestStatus.Complete
      if bReddot then
        RedDotManager.SetValid(RedDotDefine.Activity_Tab, self.nActId, bReddot)
        return
      end
    end
  end
  for _, storyData in pairs(self.allStoryData) do
    bReddot = bReddot or self:GetStoryIsNew(storyData.nId)
    if bReddot then
      RedDotManager.SetValid(RedDotDefine.Activity_Tab, self.nActId, bReddot)
      return
    end
  end
  RedDotManager.SetValid(RedDotDefine.Activity_Tab, self.nActId, bReddot)
end

function TowerDefenseData:RequestEnterLevel(levelId, characterList, itemId, callback)
  local mapMsg = {
    Level = levelId,
    Characters = characterList,
    ItemId = itemId
  }
  
  local function cb()
    if callback ~= nil then
      callback()
    end
    local result = {
      action = 1,
      nActId = self.nActId,
      nlevelId = levelId,
      nStar = 0,
      nHp = 0,
      bIsFirstPass = false
    }
    self:EventUpload(result)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_tower_defense_level_apply_req, mapMsg, nil, cb)
  self.TempLevelTeamData[levelId] = {
    charList = clone(characterList),
    itemId = itemId
  }
end

function TowerDefenseData:RequestFinishLevel(levelId, bResult, nHp, cb)
  local levelData = self:GetLevelData(levelId)
  local bIsInActivityTime = self:CheckActivityOpen()
  if not bIsInActivityTime then
    local mapMsg = {LevelId = levelId, Star = 0}
    if cb ~= nil then
      cb(levelData.nStar, levelData.nStar)
    end
    local result = {
      action = 5,
      nActId = self.nActId,
      nlevelId = levelId,
      nStar = 0,
      nHp = 0,
      bIsFirstPass = false
    }
    self:EventUpload(result)
    HttpNetHandler.SendMsg(NetMsgId.Id.activity_tower_defense_level_settle_req, mapMsg, nil, nil)
    return
  end
  if not bResult then
    local mapMsg = {LevelId = levelId, Star = 0}
    HttpNetHandler.SendMsg(NetMsgId.Id.activity_tower_defense_level_settle_req, mapMsg, nil, function()
      if cb ~= nil then
        cb(levelData.nStar, levelData.nStar)
      end
      local result = {
        action = 5,
        nActId = self.nActId,
        nlevelId = levelId,
        nStar = 0,
        nHp = 0,
        bIsFirstPass = false
      }
      self:EventUpload(result)
    end)
    return
  end
  self:CreateTempData(levelId, bResult)
  EventManager.Hit(EventId.ClosePanel, PanelId.TowerDefenseLevelDetailPanel)
  local nStar = 1
  local config = ConfigTable.GetData("TowerDefenseLevel", levelId)
  if nHp > config.Condition2 then
    nStar = nStar + 1
  end
  if nHp > config.Condition3 then
    nStar = nStar + 1
  end
  if nStar == 3 then
    local bPerfect = self:IsPerfectClear(levelId, nHp)
    if bPerfect then
      nStar = nStar + 10
    end
  end
  local mapMsg = {LevelId = levelId, Star = nStar}
  local oldStar = levelData.nStar
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_tower_defense_level_settle_req, mapMsg, nil, function(_, mapMsgData)
    cb(nStar, levelData.nStar, mapMsgData)
    self:UpdateLevelData({
      Id = levelId,
      Star = math.max(nStar, levelData.nStar)
    })
    local result = {
      action = 2,
      nActId = self.nActId,
      nlevelId = levelId,
      nStar = nStar,
      nHp = nHp
    }
    if oldStar == 0 and levelData.nStar > 0 then
      result.bIsFirstPass = true
    else
      result.bIsFirstPass = false
    end
    self:EventUpload(result)
  end)
end

function TowerDefenseData:RequestFinishLevelFailed(levelId, nHp, cb)
  local levelData = self:GetLevelData(levelId)
  local mapMsg = {LevelId = levelId, Star = 0}
  if cb ~= nil then
    cb(levelData.nStar, levelData.nStar)
  end
  local result = {
    action = 5,
    nActId = self.nActId,
    nlevelId = levelId,
    nStar = 0,
    nHp = 0,
    bIsFirstPass = false
  }
  self:EventUpload(result)
end

function TowerDefenseData:SkipLevel(levelId, characterList, itemId, cb)
  local mapMsg = {
    Level = levelId,
    Characters = characterList,
    ItemId = itemId
  }
  
  local function callback()
    self:CreateTempData(levelId, true)
    local mapMsg = {LevelId = levelId, Star = 13}
    HttpNetHandler.SendMsg(NetMsgId.Id.activity_tower_defense_level_settle_req, mapMsg, nil, function(_, mapMsgData)
      self:UpdateLevelData({Id = levelId, Star = 13})
      local mapReward = PlayerData.Item:ProcessRewardChangeInfo(mapMsgData)
      local tbItem = {}
      for _, v in ipairs(mapReward.tbReward) do
        local item = {
          Tid = v.id,
          Qty = v.count,
          rewardType = AllEnum.RewardType.First
        }
        table.insert(tbItem, item)
      end
      UTILS.OpenReceiveByDisplayItem(tbItem, mapMsgData)
      if cb ~= nil then
        cb()
      end
    end)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_tower_defense_level_apply_req, mapMsg, nil, callback)
  self.TempLevelTeamData[levelId] = {
    charList = clone(characterList),
    itemId = itemId
  }
end

function TowerDefenseData:IsPerfectClear(levelId, nHp)
  local levelConfig = ConfigTable.GetData("TowerDefenseLevel", levelId)
  if levelConfig == nil then
    return false
  end
  local floorConfig = ConfigTable.GetData("TowerDefenseFloor", levelConfig.FloorId)
  if floorConfig == nil then
    return false
  end
  return nHp == floorConfig.Durability
end

function TowerDefenseData:CreateTempData(nLevelId, bResult)
  self.tempData = {nLevelId = nLevelId, bResult = bResult}
end

function TowerDefenseData:GetTempData()
  return self.tempData
end

function TowerDefenseData:ClearTempData()
  self.tempData = nil
end

function TowerDefenseData:EventUpload(result)
  local tabUpLevel = {}
  table.insert(tabUpLevel, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  table.insert(tabUpLevel, {
    "action",
    tostring(result.action)
  })
  table.insert(tabUpLevel, {
    "activity_id",
    tostring(result.nActId)
  })
  table.insert(tabUpLevel, {
    "battle_id",
    tostring(result.nlevelId)
  })
  table.insert(tabUpLevel, {
    "first_clear",
    tostring(result.bIsFirstPass and 1 or 0)
  })
  table.insert(tabUpLevel, {
    "result_star",
    tostring(result.nStar)
  })
  table.insert(tabUpLevel, {
    "hp_result",
    tostring(result.nHp)
  })
  NovaAPI.UserEventUpload("activity_tower_defense", tabUpLevel)
end

function TowerDefenseData:RequestReadAVG(storyId)
  local mapMsg = {Value = storyId}
  
  local function cb(_, mapMsgData)
    local data = {nId = storyId, bIsRead = true}
    self:UpdateStoryData(data)
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
    UTILS.OpenReceiveByDisplayItem(mapDecodedChangeInfo["proto.Res"], mapMsgData)
    self:RefreshRedDot()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_tower_defense_story_reward_receive_req, mapMsg, nil, cb)
end

function TowerDefenseData:RequestReceiveQuest(nGroupId, nQuestId)
  local mapMsg = {
    ActivityId = self.nActId,
    GroupId = nQuestId == 0 and nGroupId or 0,
    QuestId = nQuestId
  }
  
  local function cb(_, mapMsgData)
    if nQuestId == 0 then
      local quests = self:GetQuestbyGroupId(nGroupId)
      for _, quest in pairs(quests) do
        if quest.nState == AllEnum.ActQuestStatus.Complete then
          local config = ConfigTable.GetData("TowerDefenseQuest", quest.nId)
          local progress = {}
          local progressData = {}
          if config.QuestType == GameEnum.towerDefenseCond.TowerDefenseClear then
            progressData.Cur = 1
            progressData.Max = 1
          elseif config.QuestType == GameEnum.towerDefenseCond.TowerDefenseClearSpecificStar then
            progressData.Cur = 1
            progressData.Max = 1
          else
            progressData.Cur = config.QuestParam[2]
            progressData.Max = config.QuestParam[2]
          end
          table.insert(progress, progressData)
          local data = {
            nId = quest.nId,
            nState = AllEnum.ActQuestStatus.Received,
            progress = progress
          }
          self:UpdateQuest(data)
        end
      end
    else
      local config = ConfigTable.GetData("TowerDefenseQuest", nQuestId)
      local progress = {}
      local progressData = {}
      if config.QuestType == GameEnum.towerDefenseCond.TowerDefenseClear then
        progressData.Cur = 1
        progressData.Max = 1
      elseif config.QuestType == GameEnum.towerDefenseCond.TowerDefenseClearSpecificStar then
        progressData.Cur = 1
        progressData.Max = 1
      else
        progressData.Cur = config.QuestParam[2]
        progressData.Max = config.QuestParam[2]
      end
      table.insert(progress, progressData)
      local data = {
        nId = nQuestId,
        nState = AllEnum.ActQuestStatus.Received,
        progress = progress
      }
      self:UpdateQuest(data)
    end
    self:RefreshRedDot()
    UTILS.OpenReceiveByChangeInfo(mapMsgData)
    EventManager.Hit("TowerDefenseQuestReceived")
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_tower_defense_quest_reward_receive_req, mapMsg, nil, cb)
end

return TowerDefenseData
