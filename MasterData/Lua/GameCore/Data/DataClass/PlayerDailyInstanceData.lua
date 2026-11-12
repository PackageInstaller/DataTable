local PlayerDailyInstanceData = class("PlayerDailyInstanceData")
local LocalData = require("GameCore.Data.LocalData")
local newDayTime = UTILS.GetDayRefreshTimeOffset()
local SDKManager = CS.SDKManager.Instance

function PlayerDailyInstanceData:Init()
  self.curLevel = nil
  self.mapAllLevel = {}
  self.bInSettlement = false
  self.tbLastMaxHard = {}
  self.mapLevelCfg = {}
  self:InitConfigData()
  EventManager.Add("Daily_Instance_Gameplay_Time", self, self.OnEvent_Time)
end

function PlayerDailyInstanceData:OnEvent_Time(nTime)
  self._TotalTime = nTime
end

function PlayerDailyInstanceData:InitConfigData()
  local function funcForeachLine(line)
    if nil == self.mapLevelCfg[line.DailyType] then
      self.mapLevelCfg[line.DailyType] = {}
    end
    self.mapLevelCfg[line.DailyType][line.Id] = line
  end
  
  ForEachTableLine(DataTable.DailyInstance, funcForeachLine)
end

function PlayerDailyInstanceData:EnterDailyInstanceEditor(nFloor, tbChar, tbDisc, tbNote)
  if self.curLevel ~= nil then
    printError("当前关卡level不为空1")
    return
  end
  local luaClass = require("Game.Editor.DailyInstance.DailyInstanceEditor")
  if luaClass == nil then
    return
  end
  self.curLevel = luaClass
  if type(self.curLevel.BindEvent) == "function" then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    self.curLevel:Init(self, nFloor, tbChar, tbDisc, tbNote)
  end
end

function PlayerDailyInstanceData:EnterDailyInstance(nLevelId, nBuildId)
  if self.curLevel ~= nil then
    printError("当前关卡level不为空1")
    return
  end
  local luaClass = require("Game.Adventure.DailyInstance.DailyInstanceLevel")
  if luaClass == nil then
    return
  end
  self.curLevel = luaClass
  if type(self.curLevel.BindEvent) == "function" then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    self.curLevel:Init(self, nLevelId, nBuildId)
  end
end

function PlayerDailyInstanceData:SetSelBuildId(nBuildId)
  self.selBuildId = nBuildId
end

function PlayerDailyInstanceData:GetCachedBuildId(nLevelId)
  if PlayerData.Guide:GetGuideState() then
    if self.selBuildId ~= 0 and self.selBuildId ~= nil then
      local ret = self.selBuildId
      return ret
    end
    return 0
  end
  if self.selBuildId ~= 0 and self.selBuildId ~= nil then
    local ret = self.selBuildId
    return ret
  end
  if nLevelId == 0 then
    return 0
  end
  if self.mapAllLevel[nLevelId] == nil then
    local mapLevelCfgData = ConfigTable.GetData("DailyInstance", nLevelId)
    if mapLevelCfgData == nil then
      return 0
    end
    if mapLevelCfgData.PreLevelId ~= 0 then
      if self.mapAllLevel[mapLevelCfgData.PreLevelId] ~= nil then
        return self.mapAllLevel[mapLevelCfgData.PreLevelId].nBuildId
      else
        return 0
      end
    else
      return 0
    end
  end
  return self.mapAllLevel[nLevelId].nBuildId
end

function PlayerDailyInstanceData:CacheDailyInstanceLevel(tbData)
  if tbData == nil then
    return
  end
  for _, mapData in ipairs(tbData) do
    local b1 = 1
    local b2 = 2
    local b3 = 4
    local t1 = mapData.Star & b1 > 0
    local t2 = mapData.Star & b2 > 0
    local t3 = mapData.Star & b3 > 0
    local nStar = self.CalStar(mapData.Star)
    local nBuildId = 0
    if mapData.Build ~= nil then
      nBuildId = mapData.Build.BuildId or 0
    end
    self.mapAllLevel[mapData.Id] = {
      nStar = nStar,
      nBuildId = nBuildId,
      tbTarget = {
        t1,
        t2,
        t3
      }
    }
  end
end

function PlayerDailyInstanceData:GetDailyInstanceLevelUnlock(nLevelId)
  local mapLevelCfgData = ConfigTable.GetData("DailyInstance", nLevelId)
  if mapLevelCfgData == nil then
    return false
  end
  if mapLevelCfgData.PreLevelId == 0 then
    return true
  end
  if PlayerData.Base:GetWorldClass() < mapLevelCfgData.NeedWorldClass then
    return false, mapLevelCfgData.NeedWorldClass
  end
  if self.mapAllLevel[mapLevelCfgData.PreLevelId] == nil then
    return false
  end
  if self.mapAllLevel[mapLevelCfgData.PreLevelId].nStar >= mapLevelCfgData.PreLevelStar then
    return true
  end
  return false
end

function PlayerDailyInstanceData:GetDailyInstanceUnlockMsg(nLevelId)
  local mapLevelCfgData = ConfigTable.GetData("DailyInstance", nLevelId)
  if mapLevelCfgData.PreLevelId == 0 then
    return true
  end
  local isWorldClass = true
  if PlayerData.Base:GetWorldClass() < mapLevelCfgData.NeedWorldClass then
    isWorldClass = false
  end
  local isPreLevelStar = true
  if self.mapAllLevel[mapLevelCfgData.PreLevelId] == nil or self.mapAllLevel[mapLevelCfgData.PreLevelId].nStar < mapLevelCfgData.PreLevelStar then
    isPreLevelStar = false
  end
  if isWorldClass == false or isPreLevelStar == false then
    return false, isWorldClass, isPreLevelStar
  end
  return true
end

function PlayerDailyInstanceData:GetDailyInstanceStar(nLevelId)
  if nLevelId == nil then
    return 0, {
      false,
      false,
      false
    }
  end
  if self.mapAllLevel[nLevelId] == nil then
    return 0, {
      false,
      false,
      false
    }
  end
  return self.mapAllLevel[nLevelId].nStar, self.mapAllLevel[nLevelId].tbTarget == nil and {
    false,
    false,
    false
  } or self.mapAllLevel[nLevelId].tbTarget
end

function PlayerDailyInstanceData:MsgEnterDailyInstance(nLevelId, nBuildId, callback)
  local mapBuildData = PlayerData.Build:GetBuildData(nBuildId)
  local bTrial = mapBuildData.nBuildSource == AllEnum.BuildSource.Trial or mapBuildData.nBuildSource == AllEnum.BuildSource.LimitedTrial
  local nBuildType = bTrial and 2 or 1
  local msg = {}
  msg.Id = nLevelId
  msg.Build = {Type = nBuildType, BuildId = nBuildId}
  msg.RewardType = self.lastRewardType
  self._EntryTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  
  local function msgCallback()
    self:EnterDailyInstance(nLevelId, nBuildId)
    if self.mapAllLevel[nLevelId] == nil then
      self.mapAllLevel[nLevelId] = {nStar = 0, nBuildId = 0}
    end
    self.mapAllLevel[nLevelId].nBuildId = nBuildId
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.daily_instance_apply_req, msg, nil, msgCallback)
end

function PlayerDailyInstanceData:MsgSettleDailyInstance(nLevelId, nBuildId, nStar, callback)
  if nStar == 0 then
    if callback ~= nil then
      callback({}, {}, {})
    end
    if PlayerData.Guide:GetGuideState() then
      EventManager.Hit("Guide_DailyInstance_Fail")
    end
    self:EventUpload(2, nLevelId, nBuildId)
    return
  end
  local msg = {}
  msg.Star = nStar
  msg.Events = {
    List = PlayerData.Achievement:GetBattleAchievement(GameEnum.levelType.DailyInstance, 0 < nStar)
  }
  
  local function msgCallback(_, mapMsgData)
    local b1 = 1
    local b2 = 2
    local b3 = 4
    local t1 = 0 < nStar & b1
    local t2 = 0 < nStar & b2
    local t3 = 0 < nStar & b3
    local nStarCount = (t1 and 1 or 0) + (t2 and 1 or 0) + (t3 and 1 or 0)
    if self.mapAllLevel[nLevelId] ~= nil then
      if nStarCount > self.mapAllLevel[nLevelId].nStar then
        self.mapAllLevel[nLevelId].nStar = nStarCount
      end
      if self.mapAllLevel[nLevelId].tbTarget == nil then
        self.mapAllLevel[nLevelId].tbTarget = {
          false,
          false,
          false
        }
      end
      self.mapAllLevel[nLevelId].tbTarget[1] = t1 or self.mapAllLevel[nLevelId].tbTarget[1]
      self.mapAllLevel[nLevelId].tbTarget[2] = t2 or self.mapAllLevel[nLevelId].tbTarget[2]
      self.mapAllLevel[nLevelId].tbTarget[3] = t3 or self.mapAllLevel[nLevelId].tbTarget[3]
    else
      self.mapAllLevel[nLevelId] = {
        nStar = nStar,
        nBuildId = nBuildId,
        tbTarget = {
          t1,
          t2,
          t3
        }
      }
    end
    if callback ~= nil then
      callback(mapMsgData.Select, mapMsgData.First, mapMsgData.DoubleItems, mapMsgData.Exp, mapMsgData.Change)
    end
    self:EventUpload(1, nLevelId, nBuildId)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.daily_instance_settle_req, msg, nil, msgCallback)
  if PlayerData.Guide:GetGuideState() then
    EventManager.Hit("Guide_DailyInstance_Settle")
  end
end

function PlayerDailyInstanceData:EventUpload(result, nLevelId, nBuildId)
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
    tostring(nBuildId)
  })
  table.insert(tabUpLevel, {
    "battle_id",
    tostring(nLevelId)
  })
  table.insert(tabUpLevel, {
    "battle_result",
    tostring(result)
  })
  NovaAPI.UserEventUpload("daily_instance_battle", tabUpLevel)
end

function PlayerDailyInstanceData:LevelEnd()
  if nil ~= self.curLevel and type(self.curLevel.UnBindEvent) == "function" then
    self.curLevel:UnBindEvent()
  end
  self.curLevel = nil
end

function PlayerDailyInstanceData.CalStar(nOrigin)
  nOrigin = (nOrigin & 1431655765) + (nOrigin >> 1 & 1431655765)
  nOrigin = (nOrigin & 858993459) + (nOrigin >> 2 & 858993459)
  nOrigin = (nOrigin & 252645135) + (nOrigin >> 4 & 252645135)
  nOrigin = nOrigin * 16843009 >> 24
  return nOrigin
end

function PlayerDailyInstanceData:GetCurLevel()
  if self.curLevel == nil then
    return 0
  end
  return self.curLevel.nLevelId
end

function PlayerDailyInstanceData:SetLastMaxHard(nGroupId, nMaxHard)
  self.tbLastMaxHard[nGroupId] = nMaxHard
end

function PlayerDailyInstanceData:GetLastMaxHard(nGroupId)
  return self.tbLastMaxHard[nGroupId] or 0
end

function PlayerDailyInstanceData:GetMaxDailyInstanceHard(nType)
  local retHard = 1
  local tbLevelList = self.mapLevelCfg[nType]
  if nil ~= tbLevelList then
    for nLevelId, mapLevel in pairs(tbLevelList) do
      if self:GetDailyInstanceLevelUnlock(nLevelId) then
        retHard = math.max(mapLevel.Difficulty, retHard)
      end
    end
  end
  return retHard
end

function PlayerDailyInstanceData:GetLevelOpenState(nType)
  nType = GameEnum.dailyType.Common
  local mapData = ConfigTable.GetData("DailyInstanceType", nType)
  if nil ~= mapData then
    local bMainLine = true
    if mapData.MainLineId > 0 then
      local nStar = PlayerData.Mainline:GetMianlineLevelStar(mapData.MainLineId)
      bMainLine = 0 < nStar
    end
    local worldClass = PlayerData.Base:GetWorldClass()
    local bWorldClass = worldClass >= mapData.WorldClassLevel
    local bUnlock = bMainLine and bWorldClass
    if not bMainLine then
      return AllEnum.DailyInstanceState.Not_MainLine, bUnlock
    end
    if not bWorldClass then
      return AllEnum.DailyInstanceState.Not_WorldClass, bUnlock
    end
    return AllEnum.DailyInstanceState.Open, bUnlock
  end
  return AllEnum.DailyInstanceState.None
end

function PlayerDailyInstanceData:GetUnOpenTipText(nLevelState, nType)
  nType = GameEnum.dailyType.Common
  local sTipStr
  if nLevelState == AllEnum.DailyInstanceState.Not_MainLine then
    local mapData = ConfigTable.GetData("DailyInstanceType", nType)
    local mapLevelData = ConfigTable.GetData_Mainline(mapData.MainLineId)
    if mapLevelData ~= nil then
      sTipStr = orderedFormat(ConfigTable.GetUIText("MainLine_Lock") or "", mapLevelData.Num, mapLevelData.Name)
    else
      sTipStr = orderedFormat(ConfigTable.GetUIText("MainLine_Lock") or "", tostring(mapData.MainLineId), "")
    end
  elseif nLevelState == AllEnum.DailyInstanceState.Not_WorldClass then
    local mapData = ConfigTable.GetData("DailyInstanceType", nType)
    sTipStr = orderedFormat(ConfigTable.GetUIText("WorldClass_Lock") or "", mapData.WorldClassLevel)
  elseif nLevelState == AllEnum.DailyInstanceState.Not_HardUnlock then
    sTipStr = ConfigTable.GetUIText("Level_Lock")
  end
  return sTipStr or ""
end

function PlayerDailyInstanceData:CheckLevelOpen(nType, nHard, bShowTips)
  if nType == 0 then
    return AllEnum.DailyInstanceState.Open
  end
  local nLevelState, bUnlock = self:GetLevelOpenState(nType)
  if nil ~= nHard and nLevelState == AllEnum.DailyInstanceState.Open then
    local nMaxUnlockHard = self:GetMaxDailyInstanceHard(nType)
    if nHard > nMaxUnlockHard then
      nLevelState = AllEnum.DailyInstanceState.Not_HardUnlock
    end
  end
  if true == bShowTips then
    local sTipStr = self:GetUnOpenTipText(nLevelState, nType)
    if nil ~= sTipStr and "" ~= sTipStr then
      EventManager.Hit(EventId.OpenMessageBox, sTipStr)
    end
  end
  return nLevelState == AllEnum.DailyInstanceState.Open, bUnlock
end

function PlayerDailyInstanceData:SetSettlementState(bInSettlement)
  self.bInSettlement = bInSettlement
end

function PlayerDailyInstanceData:GetSettlementState()
  return self.bInSettlement
end

function PlayerDailyInstanceData:GetLastRewardType()
  if self.lastRewardType == nil then
    local lastType = LocalData.GetPlayerLocalData("DailyRewardType")
    if lastType == nil then
      self:SetRewardType(GameEnum.DailyRewardType.CharExp)
    else
      self.lastRewardType = lastType
    end
  end
  return tonumber(self.lastRewardType)
end

function PlayerDailyInstanceData:SetRewardType(nType)
  self.lastRewardType = nType
  LocalData.SetPlayerLocalData("DailyRewardType", nType)
end

function PlayerDailyInstanceData:SendDailyInstanceRaidReq(nId, nCount, callback)
  local Events = {}
  local msgData = {
    Id = nId,
    RewardType = self.lastRewardType,
    Times = nCount
  }
  if 0 < #Events then
    msgData.Events = {
      List = {}
    }
    msgData.Events.List = Events
  end
  
  local function successCallback(_, mapMainData)
    callback(mapMainData.Rewards, mapMainData.Change)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.daily_instance_raid_req, msgData, nil, successCallback)
end

return PlayerDailyInstanceData
