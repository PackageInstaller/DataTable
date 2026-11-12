local ConfigData = require("GameCore.Data.ConfigData")
local AchievementChecker = require("Game.Adventure.AchievementCheck.AchievementChecker")
local PlayerAchievementData = class("PlayerAchievementData")
local Status = {
  Unreceived = 1,
  Uncompleted = 2,
  Received = 3
}

function PlayerAchievementData:Init()
  self._tbAchievementList = {}
  self._tbTypeCount = {}
  self._tbBattleAchievement = {}
  self._bNeedUpdate = true
  self._tbUnreceivedCountList = {}
  self:InitAchievementData()
end

function PlayerAchievementData:InitAchievementData()
  local function func_ForEach(mapCfg)
    if not self._tbAchievementList[mapCfg.Type] then
      self._tbAchievementList[mapCfg.Type] = {}
    end
    local bTime = true
    if bTime then
      self._tbAchievementList[mapCfg.Type][mapCfg.Id] = {
        sTime = "",
        nId = mapCfg.Id,
        nCur = 0,
        nMax = mapCfg.AimNumShow,
        nStatus = Status.Uncompleted,
        bHide = mapCfg.Hide
      }
      if not self._tbTypeCount[mapCfg.Type] then
        self._tbTypeCount[mapCfg.Type] = {
          nCompleted = 0,
          nTotal = 0,
          tbRarity = {
            [GameEnum.itemRarity.SSR] = 0,
            [GameEnum.itemRarity.SR] = 0,
            [GameEnum.itemRarity.R] = 0
          }
        }
      end
      if not mapCfg.Hide then
        self._tbTypeCount[mapCfg.Type].nTotal = self._tbTypeCount[mapCfg.Type].nTotal + 1
      end
    end
  end
  
  ForEachTableLine(DataTable.Achievement, func_ForEach)
end

function PlayerAchievementData:CacheBattleAchievementData(sByte)
  self.tbSpecialBattle = nil
  local tbList = {}
  local tbSpecialBattle = {}
  local tbData = UTILS.ParseByteString(sByte)
  
  local function func_ForEach(mapLineData)
    if mapLineData.CompleteCondClient > 999 then
      local bCompleted = UTILS.IsBitSet(tbData, mapLineData.Id)
      if not bCompleted then
        table.insert(tbSpecialBattle, mapLineData.Id)
      end
    end
    if #mapLineData.LevelType > 1 and table.indexof(mapLineData.LevelType, GameEnum.levelType.All) > 0 then
      printError("禁止全部类型和其它关卡类型同时配置！该成就不生效！ID:" .. mapLineData.Id)
    elseif mapLineData.CompleteCond == GameEnum.achievementCond.ClientReport and #mapLineData.LevelType > 0 then
      local bCompleted = UTILS.IsBitSet(tbData, mapLineData.Id)
      if not bCompleted then
        table.insert(tbList, mapLineData.Id)
      end
    end
  end
  
  ForEachTableLine(DataTable.Achievement, func_ForEach)
  for _, nId in pairs(tbList) do
    local mapCfg = ConfigTable.GetData("Achievement", nId)
    for _, nLevelType in ipairs(mapCfg.LevelType) do
      if not self._tbBattleAchievement[nLevelType] then
        self._tbBattleAchievement[nLevelType] = {}
      end
      table.insert(self._tbBattleAchievement[nLevelType], nId)
    end
  end
  self.tbSpecialBattle = tbSpecialBattle
end

function PlayerAchievementData:SetSpecialBattleAchievement(nLevelType)
  local tbCond = {}
  if self.tbSpecialBattle == nil then
    return
  end
  for _, nId in ipairs(self.tbSpecialBattle) do
    local mapCfg = ConfigTable.GetData("Achievement", nId)
    if mapCfg ~= nil and (table.indexof(mapCfg.LevelType, GameEnum.levelType.All) > 0 or table.indexof(mapCfg.LevelType, nLevelType) > 0) and table.indexof(tbCond, mapCfg.CompleteCondClient) < 1 then
      table.insert(tbCond, mapCfg.CompleteCondClient)
    end
  end
  safe_call_cs_func(CS.AdventureModuleHelper.SetUnFinishedAchievementInfo, tbCond)
end

function PlayerAchievementData:CacheAchievementData(mapMsgData)
  self._tbUnreceivedCountList = {}
  for _, mapAchievement in pairs(mapMsgData.List) do
    local mapCfg = ConfigTable.GetData("Achievement", mapAchievement.Id)
    local nStatus = self:SetStatus(mapAchievement.Status)
    local nBeforeStatus = self._tbAchievementList[mapCfg.Type][mapAchievement.Id].nStatus
    self._tbAchievementList[mapCfg.Type][mapAchievement.Id] = {
      sTime = os.date("%Y/%m/%d", mapAchievement.Completed),
      nId = mapAchievement.Id,
      nCur = #mapAchievement.Progress > 0 and mapAchievement.Progress[1].Cur or mapCfg.AimNumShow,
      nMax = #mapAchievement.Progress > 0 and mapAchievement.Progress[1].Max or mapCfg.AimNumShow,
      nStatus = nStatus,
      bHide = mapCfg.Hide
    }
    local mapCur = self._tbAchievementList[mapCfg.Type][mapAchievement.Id]
    if nBeforeStatus ~= nStatus then
      if mapCur.nStatus == Status.Received then
        self._tbTypeCount[mapCfg.Type].nCompleted = self._tbTypeCount[mapCfg.Type].nCompleted + 1
        self._tbTypeCount[mapCfg.Type].tbRarity[mapCfg.Rarity] = self._tbTypeCount[mapCfg.Type].tbRarity[mapCfg.Rarity] + 1
      end
      if mapCur.bHide and mapCur.nStatus ~= Status.Uncompleted then
        self._tbTypeCount[mapCfg.Type].nTotal = self._tbTypeCount[mapCfg.Type].nTotal + 1
      end
      if mapCur.nStatus == Status.Unreceived then
        local nCount = self._tbUnreceivedCountList[mapCfg.Type] or 0
        nCount = nCount + 1
        self._tbUnreceivedCountList[mapCfg.Type] = nCount
      end
    end
  end
end

function PlayerAchievementData:GetBattleAchievement(nLevelType, bBattleSuccess)
  local tbRet = {}
  if self._tbBattleAchievement[nLevelType] and #self._tbBattleAchievement[nLevelType] > 0 then
    AchievementChecker:CheckBattleAchievement(self._tbBattleAchievement[nLevelType], tbRet, bBattleSuccess)
  end
  if self._tbBattleAchievement[GameEnum.levelType.All] and 0 < #self._tbBattleAchievement[GameEnum.levelType.All] then
    AchievementChecker:CheckBattleAchievement(self._tbBattleAchievement[GameEnum.levelType.All], tbRet, bBattleSuccess)
  end
  return tbRet
end

function PlayerAchievementData:GetAchievementTypeCount(nType)
  return self._tbTypeCount[nType]
end

function PlayerAchievementData:GetAchievementAllTypeCount()
  local ret = {
    nTotal = 0,
    nCompleted = 0,
    nSSR = 0,
    nSR = 0,
    nR = 0
  }
  for _, mapCount in pairs(self._tbTypeCount) do
    ret.nTotal = ret.nTotal + mapCount.nTotal
    ret.nCompleted = ret.nCompleted + mapCount.nCompleted
    ret.nSSR = ret.nSSR + mapCount.tbRarity[GameEnum.itemRarity.SSR]
    ret.nSR = ret.nSR + mapCount.tbRarity[GameEnum.itemRarity.SR]
    ret.nR = ret.nR + mapCount.tbRarity[GameEnum.itemRarity.R]
  end
  return ret
end

function PlayerAchievementData:GetAchievementTypeList(nType)
  return self._tbAchievementList[nType]
end

function PlayerAchievementData:GetReceiveList(nType)
  local tbId = {}
  for _, mapData in pairs(self._tbAchievementList[nType]) do
    if mapData.nStatus == Status.Unreceived then
      table.insert(tbId, mapData.nId)
    end
  end
  return tbId
end

function PlayerAchievementData:JudgeHide(nType, mapData)
  local bUncompleted = mapData.nStatus == Status.Uncompleted
  if not bUncompleted then
    return false
  end
  local mapCfg = ConfigTable.GetData("Achievement", mapData.nId)
  local bHide = mapData.bHide
  local bPreReceived = true
  if mapCfg ~= nil and #mapCfg.Prerequisites > 0 then
    for _, nId in ipairs(mapCfg.Prerequisites) do
      if self._tbAchievementList[nType] == nil or self._tbAchievementList[nType][nId] == nil then
        printError("AchievementCfg Missing:" .. nId .. "," .. nType)
        break
      end
      if self._tbAchievementList[nType][nId].nStatus ~= Status.Received then
        bPreReceived = false
        break
      end
    end
  end
  return bHide or not bPreReceived
end

function PlayerAchievementData:ChangeAchievementData(mapAchievement)
  self:ChangeBattleAchievementData(mapAchievement.Id, mapAchievement.Status)
  local nStatus = self:SetStatus(mapAchievement.Status)
  if nStatus ~= Status.Uncompleted then
    PlayerData.SideBanner:AddAchievement(mapAchievement.Id)
  end
  if #mapAchievement.Progress == 0 then
    self._bNeedUpdate = true
    return
  end
  if self._bNeedUpdate then
    return
  end
  local mapCfg = ConfigTable.GetData("Achievement", mapAchievement.Id)
  if mapCfg == nil then
    return
  end
  if not self._tbAchievementList[mapCfg.Type] then
    self._tbAchievementList[mapCfg.Type] = {}
  end
  self._tbAchievementList[mapCfg.Type][mapAchievement.Id] = {
    sTime = os.date("%Y/%m/%d", mapAchievement.Completed),
    nId = mapAchievement.Id,
    nCur = mapAchievement.Progress[1].Cur,
    nMax = mapAchievement.Progress[1].Max,
    nStatus = nStatus,
    bHide = mapCfg.Hide
  }
  local mapCur = self._tbAchievementList[mapCfg.Type][mapAchievement.Id]
  if not self._tbTypeCount[mapCfg.Type] then
    self._tbTypeCount[mapCfg.Type] = {
      nCompleted = 0,
      nTotal = 0,
      tbRarity = {
        [GameEnum.itemRarity.SSR] = 0,
        [GameEnum.itemRarity.SR] = 0,
        [GameEnum.itemRarity.R] = 0
      }
    }
  end
  if mapCur.bHide then
    self._tbTypeCount[mapCfg.Type].nTotal = self._tbTypeCount[mapCfg.Type].nTotal + 1
  end
  if nStatus == Status.Unreceived then
    local nCount = self._tbUnreceivedCountList[mapCfg.Type] or 0
    nCount = nCount + 1
    self._tbUnreceivedCountList[mapCfg.Type] = nCount
  end
end

function PlayerAchievementData:ChangeBattleAchievementData(nId, nStatus)
  if nStatus ~= Status.Unreceived then
    return
  end
  local mapCfg = ConfigTable.GetData("Achievement", nId)
  if mapCfg == nil then
    return
  end
  if mapCfg.CompleteCond ~= GameEnum.achievementCond.ClientReport or #mapCfg.LevelType == 0 then
    return
  end
  if mapCfg.CompleteCondClient > 999 then
    local nIdx = table.indexof(self.tbSpecialBattle, nId)
    if 0 < nIdx then
      table.remove(self.tbSpecialBattle, nIdx)
    end
  end
  for _, nType in ipairs(mapCfg.LevelType) do
    if self._tbBattleAchievement[nType] then
      for key, value in pairs(self._tbBattleAchievement[nType]) do
        if value == nId then
          table.remove(self._tbBattleAchievement[nType], key)
          break
        end
      end
    end
  end
end

function PlayerAchievementData:CheckReddot()
  if self._bNeedUpdate then
    local bRedddot = PlayerData.State.bNewAchievement or false
    RedDotManager.SetValid(RedDotDefine.Achievement_Tab, {
      GameEnum.achievementType.Overview
    }, bRedddot)
  else
    RedDotManager.SetValid(RedDotDefine.Achievement_Tab, {
      GameEnum.achievementType.Overview
    }, false)
    for k, v in pairs(self._tbUnreceivedCountList) do
      local bRedddot = 0 < v
      RedDotManager.SetValid(RedDotDefine.Achievement_Tab, {k}, bRedddot)
    end
  end
end

function PlayerAchievementData:CheckAchieveId(nId)
  for nAchieveType, mapAchieveInfo in pairs(self._tbAchievementList) do
    for nAchieveId, mapInfo in pairs(mapAchieveInfo) do
      if nAchieveId == nId and mapInfo.nStatus ~= Status.Uncompleted then
        return true
      end
    end
  end
  return false
end

function PlayerAchievementData:CheckAchieveIds(tbIds)
  local bResult = true
  local mapAchieveInfo = {}
  if tbIds == nil then
    return bResult, mapAchieveInfo
  end
  if #tbIds <= 0 then
    return bResult, mapAchieveInfo
  end
  for i, nId in ipairs(tbIds) do
    mapAchieveInfo[nId] = self:CheckAchieveId(nId)
    bResult = bResult == true and mapAchieveInfo[nId] == true
  end
  return bResult, mapAchieveInfo
end

function PlayerAchievementData:GetTimeLimit(sStart, sEnd)
end

function PlayerAchievementData:SetStatus(nStatus)
  if nStatus == 0 then
    nStatus = Status.Uncompleted
  elseif nStatus == 1 then
    nStatus = Status.Unreceived
  elseif nStatus == 2 then
    nStatus = Status.Received
  end
  return nStatus
end

function PlayerAchievementData:UpdateStatus(tbId, nType)
  for _, nId in pairs(tbId) do
    local mapCfg = ConfigTable.GetData("Achievement", nId)
    self._tbAchievementList[nType][nId].nStatus = Status.Received
    self._tbTypeCount[nType].nCompleted = self._tbTypeCount[nType].nCompleted + 1
    self._tbTypeCount[nType].tbRarity[mapCfg.Rarity] = self._tbTypeCount[nType].tbRarity[mapCfg.Rarity] + 1
    local nCount = self._tbUnreceivedCountList[nType]
    nCount = math.max(0, nCount - 1)
    self._tbUnreceivedCountList[nType] = nCount
  end
end

function PlayerAchievementData:SendAchievementInfoReq(callback)
  if self._bNeedUpdate then
    self._bNeedUpdate = false
    
    local function successCallback(_, mapMainData)
      self:CacheAchievementData(mapMainData)
      callback(mapMainData)
    end
    
    HttpNetHandler.SendMsg(NetMsgId.Id.achievement_info_req, {}, nil, successCallback)
  else
    callback()
  end
end

function PlayerAchievementData:SendAchievementRewardReq(tbId, nType, callback)
  local msgData = {Ids = tbId}
  
  local function successCallback(_, mapMainData)
    UTILS.OpenReceiveByChangeInfo(mapMainData)
    self:UpdateStatus(tbId, nType)
    EventManager.Hit("AchievementRefresh")
    if callback then
      callback(mapMainData)
    end
    self:CheckReddot()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.achievement_reward_receive_req, msgData, nil, successCallback)
end

return PlayerAchievementData
