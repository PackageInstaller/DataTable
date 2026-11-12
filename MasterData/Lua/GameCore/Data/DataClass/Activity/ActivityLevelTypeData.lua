local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local ActivityLevelTypeData = class("ActivityLevelTypeData", ActivityDataBase)
local newDayTime = UTILS.GetDayRefreshTimeOffset()
local LocalData = require("GameCore.Data.LocalData")

function ActivityLevelTypeData:Init()
  self.nActId = 0
  self.startTime = 0
  self.startTimeRefreshTime = 0
  self.exploreLevelCount = 0
  self.adventureLevelCount = 0
  self.hardLevelCount = 0
  self.levelTabExplore = {}
  self.levelTabExploreDifficulty = {}
  self.levelTabAdventure = {}
  self.levelTabAdventureDifficulty = {}
  self.levelTabHard = {}
  self.levelTabHardDifficulty = {}
  self.tabCachedBuildId = {}
  EventManager.Add("ActivityLevels_Instance_Gameplay_Time", self, self.OnEvent_Time)
end

function ActivityLevelTypeData:OnEvent_Time(nTime)
  self._TotalTime = nTime
end

function ActivityLevelTypeData:RefreshActivityLevelGameActData(actId, msgData)
  self:Init()
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  local isEnding = false
  if nCurTime > self.nEndTime then
    isEnding = true
  end
  local openTime = self.nOpenTime
  self.startTimeRefreshTime = CS.ClientManager.Instance:GetNextRefreshTime(openTime) - 86400
  self.nActId = actId
  
  local function foreach_Base(baseData)
    if actId == baseData.ActivityId then
      if baseData.Type == GameEnum.ActivityLevelType.Explore then
        self.exploreLevelCount = self.exploreLevelCount + 1
        self.levelTabExplore[baseData.Id] = {}
        self.levelTabExplore[baseData.Id].baseData = baseData
        self.levelTabExplore[baseData.Id].Star = 0
        self.levelTabExplore[baseData.Id].BuildId = 0
        self.levelTabExploreDifficulty[baseData.Difficulty] = baseData.Id
      elseif baseData.Type == GameEnum.ActivityLevelType.Adventure then
        self.adventureLevelCount = self.adventureLevelCount + 1
        self.levelTabAdventure[baseData.Id] = {}
        self.levelTabAdventure[baseData.Id].baseData = baseData
        self.levelTabAdventure[baseData.Id].Star = 0
        self.levelTabAdventure[baseData.Id].BuildId = 0
        self.levelTabAdventureDifficulty[baseData.Difficulty] = baseData.Id
      elseif baseData.Type == GameEnum.ActivityLevelType.HARD then
        self.hardLevelCount = self.hardLevelCount + 1
        self.levelTabHard[baseData.Id] = {}
        self.levelTabHard[baseData.Id].baseData = baseData
        self.levelTabHard[baseData.Id].Star = 0
        self.levelTabHard[baseData.Id].BuildId = 0
        self.levelTabHardDifficulty[baseData.Difficulty] = baseData.Id
      end
      self:CheckRedDot(baseData.Type, baseData.Id, baseData.DayOpen, isEnding)
    end
  end
  
  ForEachTableLine(DataTable.ActivityLevelsLevel, foreach_Base)
  if msgData ~= nil then
    for i, v in ipairs(msgData.levels) do
      local tmpData = ConfigTable.GetData("ActivityLevelsLevel", v.Id)
      if tmpData then
        if tmpData.Type == GameEnum.ActivityLevelType.Explore then
          if self.levelTabExplore[v.Id] then
            self.levelTabExplore[v.Id].Star = v.Star
            self.levelTabExplore[v.Id].BuildId = v.Build.BuildId
          end
        elseif tmpData.Type == GameEnum.ActivityLevelType.Adventure then
          if self.levelTabAdventure[v.Id] then
            self.levelTabAdventure[v.Id].Star = v.Star
            self.levelTabAdventure[v.Id].BuildId = v.Build.BuildId
          end
        elseif tmpData.Type == GameEnum.ActivityLevelType.HARD and self.levelTabHard[v.Id] then
          self.levelTabHard[v.Id].Star = v.Star
          self.levelTabHard[v.Id].BuildId = v.Build.BuildId
        end
      end
    end
  end
end

function ActivityLevelTypeData:CheckRedDot(nType, levelId, dayOpen, isEnding)
  local tmpKey = self.nActId .. "_" .. levelId
  if isEnding then
    LocalData.SetPlayerLocalData(tmpKey, "0")
    return
  end
  local sLocalVal = LocalData.GetPlayerLocalData(tmpKey)
  local nState = tonumber(sLocalVal == nil and "0" or sLocalVal)
  if nState == 2 then
    return
  end
  if nState == 1 then
    local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActId)
    if bInActGroup then
      local actGroupData = PlayerData.Activity:GetActivityGroupDataById(nActGroupId)
      local bActGroupUnlock = actGroupData:IsUnlock()
      if nType == GameEnum.ActivityLevelType.Explore then
        RedDotManager.SetValid(RedDotDefine.ActivityLevel_Explore_Level, {nActGroupId, levelId}, bActGroupUnlock)
      elseif nType == GameEnum.ActivityLevelType.Adventure then
        RedDotManager.SetValid(RedDotDefine.ActivityLevel_Adventure_Level, {nActGroupId, levelId}, bActGroupUnlock)
      elseif nType == GameEnum.ActivityLevelType.HARD then
        RedDotManager.SetValid(RedDotDefine.ActivityLevel_Hard_Level, {nActGroupId, levelId}, bActGroupUnlock)
      end
    end
    return
  end
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  local openTime = self.startTimeRefreshTime + dayOpen * 86400
  local openTimeNextDay = self.startTimeRefreshTime + dayOpen * 86400 + 86400
  if nCurTime >= openTime and (nCurTime <= openTimeNextDay or nCurTime > openTimeNextDay and nState == 0) then
    LocalData.SetPlayerLocalData(tmpKey, "1")
    local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActId)
    if bInActGroup then
      local actGroupData = PlayerData.Activity:GetActivityGroupDataById(nActGroupId)
      local bActGroupUnlock = actGroupData:IsUnlock()
      if nType == GameEnum.ActivityLevelType.Explore then
        RedDotManager.SetValid(RedDotDefine.ActivityLevel_Explore_Level, {nActGroupId, levelId}, bActGroupUnlock)
      elseif nType == GameEnum.ActivityLevelType.Adventure then
        RedDotManager.SetValid(RedDotDefine.ActivityLevel_Adventure_Level, {nActGroupId, levelId}, bActGroupUnlock)
      elseif nType == GameEnum.ActivityLevelType.HARD then
        RedDotManager.SetValid(RedDotDefine.ActivityLevel_Hard_Level, {nActGroupId, levelId}, bActGroupUnlock)
      end
    end
  end
end

function ActivityLevelTypeData:ChangeRedDot(nType, levelId)
  local tmpKey = self.nActId .. "_" .. levelId
  local sLocalVal = LocalData.GetPlayerLocalData(tmpKey)
  local nState = tonumber(sLocalVal == nil and "0" or sLocalVal)
  if nState == 1 then
    LocalData.SetPlayerLocalData(tmpKey, "2")
    local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActId)
    if bInActGroup then
      if nType == GameEnum.ActivityLevelType.Explore then
        RedDotManager.SetValid(RedDotDefine.ActivityLevel_Explore_Level, {nActGroupId, levelId}, false)
      elseif nType == GameEnum.ActivityLevelType.Adventure then
        RedDotManager.SetValid(RedDotDefine.ActivityLevel_Adventure_Level, {nActGroupId, levelId}, false)
      elseif nType == GameEnum.ActivityLevelType.HARD then
        RedDotManager.SetValid(RedDotDefine.ActivityLevel_Hard_Level, {nActGroupId, levelId}, false)
      end
    end
  end
end

function ActivityLevelTypeData:ChangeAllRedHot()
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  local isEnding = false
  if nCurTime >= self.nEndTime then
    isEnding = true
  end
  if isEnding then
    for i, v in pairs(self.levelTabExploreDifficulty) do
      self:ChangeRedDot(GameEnum.ActivityLevelType.Explore, v)
    end
    for i, v in pairs(self.levelTabAdventureDifficulty) do
      self:ChangeRedDot(GameEnum.ActivityLevelType.Adventure, v)
    end
    for i, v in pairs(self.levelTabHardDifficulty) do
      self:ChangeRedDot(GameEnum.ActivityLevelType.HARD, v)
    end
  else
    for i, v in pairs(self.levelTabExplore) do
      self:CheckRedDot(v.baseData.Type, v.baseData.Id, v.baseData.DayOpen, isEnding)
    end
    for i, v in pairs(self.levelTabAdventure) do
      self:CheckRedDot(v.baseData.Type, v.baseData.Id, v.baseData.DayOpen, isEnding)
    end
    for i, v in pairs(self.levelTabHard) do
      self:CheckRedDot(v.baseData.Type, v.baseData.Id, v.baseData.DayOpen, isEnding)
    end
  end
end

function ActivityLevelTypeData:GetLevelStarMsg(nType)
  if nType == GameEnum.ActivityLevelType.Explore then
    local star = 0
    for i, v in pairs(self.levelTabExplore) do
      star = star + v.Star
    end
    return self.exploreLevelCount * 3, star
  elseif nType == GameEnum.ActivityLevelType.Adventure then
    local star = 0
    for i, v in pairs(self.levelTabAdventure) do
      star = star + v.Star
    end
    return self.adventureLevelCount * 3, star
  elseif nType == GameEnum.ActivityLevelType.HARD then
    local star = 0
    for i, v in pairs(self.levelTabHard) do
      star = star + v.Star
    end
    return self.hardLevelCount * 3, star
  end
end

function ActivityLevelTypeData:GetLevelDayOpen(nType, id)
  if nType == GameEnum.ActivityLevelType.Explore then
    if self.levelTabExplore[id] ~= nil then
      local dayOpen = self.levelTabExplore[id].baseData.DayOpen
      local openTime = self.startTimeRefreshTime + dayOpen * 86400
      local nCurTime = CS.ClientManager.Instance.serverTimeStamp
      if openTime <= nCurTime then
        return true
      end
    end
  elseif nType == GameEnum.ActivityLevelType.Adventure then
    if self.levelTabAdventure[id] ~= nil then
      local dayOpen = self.levelTabAdventure[id].baseData.DayOpen
      local openTime = self.startTimeRefreshTime + dayOpen * 86400
      local nCurTime = CS.ClientManager.Instance.serverTimeStamp
      if openTime <= nCurTime then
        return true
      end
    end
  elseif nType == GameEnum.ActivityLevelType.HARD and self.levelTabHard[id] ~= nil then
    local dayOpen = self.levelTabHard[id].baseData.DayOpen
    local openTime = self.startTimeRefreshTime + dayOpen * 86400
    local nCurTime = CS.ClientManager.Instance.serverTimeStamp
    if openTime <= nCurTime then
      return true
    end
  end
  return false
end

function ActivityLevelTypeData:GetUnLockDay(nType, id)
  local dayOpen = -1
  if nType == GameEnum.ActivityLevelType.Explore then
    dayOpen = self.levelTabExplore[id].baseData.DayOpen
  elseif nType == GameEnum.ActivityLevelType.Adventure then
    dayOpen = self.levelTabAdventure[id].baseData.DayOpen
  elseif nType == GameEnum.ActivityLevelType.HARD then
    dayOpen = self.levelTabHard[id].baseData.DayOpen
  end
  if dayOpen ~= -1 then
    local nCurTime = CS.ClientManager.Instance.serverTimeStamp
    local nDay = math.floor((self.startTimeRefreshTime + dayOpen * 86400 - nCurTime) / 86400)
    return nDay
  end
  return 1
end

function ActivityLevelTypeData:GetUnLockHour(nType, id)
  local dayOpen = -1
  if nType == GameEnum.ActivityLevelType.Explore then
    dayOpen = self.levelTabExplore[id].baseData.DayOpen
  elseif nType == GameEnum.ActivityLevelType.Adventure then
    dayOpen = self.levelTabAdventure[id].baseData.DayOpen
  elseif nType == GameEnum.ActivityLevelType.HARD then
    dayOpen = self.levelTabHard[id].baseData.DayOpen
  end
  if dayOpen ~= -1 then
    local nCurTime = CS.ClientManager.Instance.serverTimeStamp
    local openTime = self.startTimeRefreshTime + dayOpen * 86400
    local nRemainTime = openTime - nCurTime
    local hour = math.floor(nRemainTime / 3600)
    local min = math.floor((nRemainTime - hour * 3600) / 60)
    local sec = nRemainTime - hour * 3600 - min * 60
    return hour, min, sec
  end
  return 1, 0, 0
end

function ActivityLevelTypeData:GetUnLockDayHour(nType, id)
  local dayOpen = -1
  if nType == GameEnum.ActivityLevelType.Explore then
    dayOpen = self.levelTabExplore[id].baseData.DayOpen
  elseif nType == GameEnum.ActivityLevelType.Adventure then
    dayOpen = self.levelTabAdventure[id].baseData.DayOpen
  elseif nType == GameEnum.ActivityLevelType.HARD then
    dayOpen = self.levelTabHard[id].baseData.DayOpen
  end
  if dayOpen ~= -1 then
    local nCurTime = CS.ClientManager.Instance.serverTimeStamp
    local openTime = self.startTimeRefreshTime + dayOpen * 86400
    local nRemainTime = openTime - nCurTime
    local nDay = math.floor(nRemainTime / 86400)
    local hour = math.floor((nRemainTime - nDay * 86400) / 3600)
    return nDay, hour
  end
  return 1, 0
end

function ActivityLevelTypeData:GetLevelUnLock(nType, id)
  local tmpLevel = ConfigTable.GetData("ActivityLevelsLevel", id)
  local preActivityStory = tmpLevel.PreActivityStory
  if preActivityStory ~= nil and preActivityStory[1] ~= nil then
    local isRead = PlayerData.ActivityAvg:IsStoryReaded(preActivityStory[2])
    if not isRead then
      return false
    end
  end
  local preLevelId = -1
  local preLevelData
  local preLevelStar = 0
  if nType == GameEnum.ActivityLevelType.Explore then
    if self.levelTabExplore[id] ~= nil then
      preLevelId = self.levelTabExplore[id].baseData.PreLevelId
      if preLevelId == 0 then
        return true
      else
        preLevelData = self.levelTabExplore[preLevelId]
        preLevelStar = self.levelTabExplore[id].baseData.PreLevelStar
      end
    end
  elseif nType == GameEnum.ActivityLevelType.Adventure then
    if self.levelTabAdventure[id] ~= nil then
      preLevelId = self.levelTabAdventure[id].baseData.PreLevelId
      if preLevelId == 0 then
        return true
      else
        preLevelData = self.levelTabAdventure[preLevelId]
        if preLevelData == nil then
          preLevelData = self.levelTabExplore[preLevelId]
        end
        preLevelStar = self.levelTabAdventure[id].baseData.PreLevelStar
      end
    end
  elseif nType == GameEnum.ActivityLevelType.HARD and self.levelTabHard[id] ~= nil then
    preLevelId = self.levelTabHard[id].baseData.PreLevelId
    if preLevelId == 0 then
      return true
    else
      preLevelData = self.levelTabHard[preLevelId]
      if preLevelData == nil then
        preLevelData = self.levelTabAdventure[preLevelId]
      end
      if preLevelData == nil then
        preLevelData = self.levelTabExplore[preLevelId]
      end
      preLevelStar = self.levelTabHard[id].baseData.PreLevelStar
    end
  end
  if preLevelData and preLevelStar <= preLevelData.Star then
    return true
  end
  return false
end

function ActivityLevelTypeData:GetPreLevelStar(nType, id)
  local preLevelId = -1
  local preLevelData
  local preLevelStar = 0
  if nType == GameEnum.ActivityLevelType.Explore then
    if self.levelTabExplore[id] ~= nil then
      preLevelId = self.levelTabExplore[id].baseData.PreLevelId
      if preLevelId == 0 then
        return 3
      else
        preLevelData = self.levelTabExplore[preLevelId]
        preLevelStar = self.levelTabExplore[id].baseData.PreLevelStar
      end
    end
  elseif nType == GameEnum.ActivityLevelType.Adventure then
    if self.levelTabAdventure[id] ~= nil then
      preLevelId = self.levelTabAdventure[id].baseData.PreLevelId
      if preLevelId == 0 then
        return 3
      else
        preLevelData = self.levelTabAdventure[preLevelId]
        if preLevelData == nil then
          preLevelData = self.levelTabExplore[preLevelId]
        end
        preLevelStar = self.levelTabAdventure[id].baseData.PreLevelStar
      end
    end
  elseif nType == GameEnum.ActivityLevelType.HARD and self.levelTabHard[id] ~= nil then
    preLevelId = self.levelTabHard[id].baseData.PreLevelId
    if preLevelId == 0 then
      return 3
    else
      preLevelData = self.levelTabHard[preLevelId]
      if preLevelData == nil then
        preLevelData = self.levelTabAdventure[preLevelId]
      end
      if preLevelData == nil then
        preLevelData = self.levelTabExplore[preLevelId]
      end
      preLevelStar = self.levelTabHard[id].baseData.PreLevelStar
    end
  end
  if preLevelData and preLevelStar <= preLevelData.Star then
    return preLevelStar
  end
  return 0
end

function ActivityLevelTypeData:GetDefaultSelectionType()
  for i, v in pairs(self.levelTabAdventureDifficulty) do
    local isOpen = self:GetLevelDayOpen(GameEnum.ActivityLevelType.Adventure, v)
    local isLevelUnLock = self:GetLevelUnLock(GameEnum.ActivityLevelType.Adventure, v)
    local star = self.levelTabAdventure[v].Star
    if isOpen and isLevelUnLock and star == 0 then
      return GameEnum.ActivityLevelType.Adventure
    end
  end
  for i, v in pairs(self.levelTabHardDifficulty) do
    local isOpen = self:GetLevelDayOpen(GameEnum.ActivityLevelType.HARD, v)
    local isLevelUnLock = self:GetLevelUnLock(GameEnum.ActivityLevelType.HARD, v)
    local star = self.levelTabHard[v].Star
    if isOpen and isLevelUnLock and star == 0 then
      return GameEnum.ActivityLevelType.HARD
    end
  end
  return GameEnum.ActivityLevelType.Explore
end

function ActivityLevelTypeData:GetDefaultSelectionDifficulty(nType)
  local index = 1
  local tmpTab
  if nType == GameEnum.ActivityLevelType.Explore then
    tmpTab = self.levelTabExploreDifficulty
  elseif nType == GameEnum.ActivityLevelType.Adventure then
    tmpTab = self.levelTabAdventureDifficulty
  elseif nType == GameEnum.ActivityLevelType.HARD then
    tmpTab = self.levelTabHardDifficulty
  end
  for i, v in pairs(tmpTab) do
    local isOpen = self:GetLevelDayOpen(nType, v)
    local isLevelUnLock = self:GetLevelUnLock(nType, v)
    if isOpen and isLevelUnLock then
      index = i
    end
  end
  return index
end

function ActivityLevelTypeData:GetLevelFirstPass(nType, id)
  if nType == GameEnum.ActivityLevelType.Explore then
    if self.levelTabExplore[id] ~= nil and self.levelTabExplore[id].Star >= 1 then
      return true
    end
  elseif nType == GameEnum.ActivityLevelType.Adventure then
    if self.levelTabAdventure[id] ~= nil and 1 <= self.levelTabAdventure[id].Star then
      return true
    end
  elseif nType == GameEnum.ActivityLevelType.HARD and self.levelTabHard[id] ~= nil and 1 <= self.levelTabHard[id].Star then
    return true
  end
  return false
end

function ActivityLevelTypeData:GetLevelFirstPassNoneType(id)
  if self.levelTabExplore[id] ~= nil and self.levelTabExplore[id].Star >= 1 then
    return true
  end
  if self.levelTabAdventure[id] ~= nil and 1 <= self.levelTabAdventure[id].Star then
    return true
  end
  if self.levelTabHard[id] ~= nil and 1 <= self.levelTabHard[id].Star then
    return true
  end
  return false
end

function ActivityLevelTypeData:SendEnterActivityLevelsApplyReq(nActivityId, nLevelId, nBuildId)
  if nActivityId ~= self.nActId then
    return
  end
  self.entryLevelId = nLevelId
  self.entryBuildId = nBuildId
  local mapBuildData = PlayerData.Build:GetBuildData(nBuildId)
  local bTrial = mapBuildData.nBuildSource == AllEnum.BuildSource.Trial or mapBuildData.nBuildSource == AllEnum.BuildSource.LimitedTrial
  local nBuildType = bTrial and 2 or 1
  local msg = {}
  msg.ActivityId = nActivityId
  msg.LevelId = nLevelId
  msg.Build = {Type = nBuildType, BuildId = nBuildId}
  self._EntryTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  
  local function msgCallback(_, msgData)
    self:SetCachedSelBuildId(nBuildId, nLevelId)
    self:EnterActivityLevelInstance(nActivityId, nLevelId, nBuildId)
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(msgData)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_levels_apply_req, msg, nil, msgCallback)
end

function ActivityLevelTypeData:EnterActivityLevelInstance(nActivityId, nLevelId, nBuildId)
  if self.curLevel ~= nil then
    printError("当前关卡level不为空1")
    return
  end
  self._EntryTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  local luaClass = require("Game.Adventure.ActivityLevels.ActivityLevelsInstanceLevel")
  if luaClass == nil then
    return
  end
  self.curLevel = luaClass
  if type(self.curLevel.BindEvent) == "function" then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    self.curLevel:Init(self, nActivityId, nLevelId, nBuildId)
  end
end

function ActivityLevelTypeData:SendActivityLevelSettleReq(nActivityId, nStar, callback)
  if 0 < nStar then
    self:EventUpload(1)
  else
    self:EventUpload(2)
  end
  local msg = {}
  msg.ActivityId = nActivityId
  msg.Star = nStar
  msg.Events = {
    List = PlayerData.Achievement:GetBattleAchievement(GameEnum.levelType.ActivityLevels, 0 < nStar)
  }
  
  local function msgCallback(_, msgData)
    if callback ~= nil then
      if self.levelTabExplore[self.entryLevelId] then
        self.levelTabExplore[self.entryLevelId].Star = nStar > self.levelTabExplore[self.entryLevelId].Star and nStar or self.levelTabExplore[self.entryLevelId].Star
        self.levelTabExplore[self.entryLevelId].BuildId = self.entryBuildId
      end
      if self.levelTabAdventure[self.entryLevelId] then
        self.levelTabAdventure[self.entryLevelId].Star = nStar > self.levelTabAdventure[self.entryLevelId].Star and nStar or self.levelTabAdventure[self.entryLevelId].Star
        self.levelTabAdventure[self.entryLevelId].BuildId = self.entryBuildId
      end
      if self.levelTabHard[self.entryLevelId] then
        self.levelTabHard[self.entryLevelId].Star = nStar > self.levelTabHard[self.entryLevelId].Star and nStar or self.levelTabHard[self.entryLevelId].Star
        self.levelTabHard[self.entryLevelId].BuildId = self.entryBuildId
      end
      if callback ~= nil then
        local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(msgData.ChangeInfo)
        HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
        callback(msgData.Fixed, msgData.First, msgData.Exp, msgData.ChangeInfo)
      end
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_levels_settle_req, msg, nil, msgCallback)
end

function ActivityLevelTypeData:EventUpload(result)
  self._EndTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  local tabUpLevel = {}
  table.insert(tabUpLevel, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  table.insert(tabUpLevel, {
    "game_cost_time",
    tostring(self._TotalTime)
  })
  table.insert(tabUpLevel, {
    "real_cost_time",
    tostring(self._EndTime - self._EntryTime)
  })
  table.insert(tabUpLevel, {
    "build_id",
    tostring(self.entryBuildId)
  })
  table.insert(tabUpLevel, {
    "battle_id",
    tostring(self.entryLevelId)
  })
  table.insert(tabUpLevel, {
    "battle_result",
    tostring(result)
  })
  NovaAPI.UserEventUpload("activity_battle", tabUpLevel)
end

function ActivityLevelTypeData:SendActivityLevelsSweepReq(nActivityId, nLevelId, nTimes, callback)
  if nActivityId ~= self.nActId then
    return
  end
  local msg = {}
  msg.ActivityId = self.nActId
  msg.LevelId = nLevelId
  msg.Times = nTimes
  
  local function successCallback(_, mapMainData)
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMainData.ChangeInfo)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    callback(mapMainData.Rewards, mapMainData.ChangeInfo)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_levels_sweep_req, msg, nil, successCallback)
end

function ActivityLevelTypeData:LevelEnd()
  self.curLevel = nil
end

function ActivityLevelTypeData:GetCachedBuildId(nLevelId)
  return self.tabCachedBuildId[nLevelId] or 0
end

function ActivityLevelTypeData:SetCachedSelBuildId(nBuildId, levelId)
  self.tabCachedBuildId[levelId] = nBuildId
end

function ActivityLevelTypeData:GetLevelBuild(nLevelId)
  if self.levelTabExplore[nLevelId] then
    if self.levelTabExplore[nLevelId].BuildId ~= 0 then
      return self.levelTabExplore[nLevelId].BuildId
    else
      local PreLevelId = self.levelTabExplore[nLevelId].baseData.PreLevelId
      if PreLevelId ~= 0 then
        return self.levelTabExplore[PreLevelId].BuildId
      end
    end
  end
  if self.levelTabAdventure[nLevelId] then
    if self.levelTabAdventure[nLevelId].BuildId ~= 0 then
      return self.levelTabAdventure[nLevelId].BuildId
    else
      local PreLevelId = self.levelTabAdventure[nLevelId].baseData.PreLevelId
      if PreLevelId ~= 0 then
        if self.levelTabAdventure[PreLevelId] then
          return self.levelTabAdventure[PreLevelId].BuildId
        else
          return self.levelTabExplore[PreLevelId].BuildId
        end
      end
    end
  end
  if self.levelTabHard[nLevelId] then
    if self.levelTabHard[nLevelId].BuildId ~= 0 then
      return self.levelTabHard[nLevelId].BuildId
    else
      local PreLevelId = self.levelTabHard[nLevelId].baseData.PreLevelId
      if PreLevelId ~= 0 then
        if self.levelTabHard[PreLevelId] then
          return self.levelTabHard[PreLevelId].BuildId
        elseif self.levelTabAdventure[PreLevelId] then
          return self.levelTabAdventure[PreLevelId].BuildId
        else
          return self.levelTabExplore[PreLevelId].BuildId
        end
      end
    end
  end
  return 0
end

function ActivityLevelTypeData:GetLevelStar(nLevelId)
  if self.levelTabExplore[nLevelId] then
    return self.levelTabExplore[nLevelId].Star
  end
  if self.levelTabAdventure[nLevelId] then
    return self.levelTabAdventure[nLevelId].Star
  end
  if self.levelTabHard[nLevelId] then
    return self.levelTabHard[nLevelId].Star
  end
  return 0
end

return ActivityLevelTypeData
