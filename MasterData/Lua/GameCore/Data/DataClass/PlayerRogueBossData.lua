local ClientManager = CS.ClientManager
local newDayTime = UTILS.GetDayRefreshTimeOffset()
local PlayerRogueBossData = class("PlayerRogueBossData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")

function PlayerRogueBossData:Init()
  EventManager.Add(EventId.DelBuildItemId, self, self.OnEvent_DelBuildItemId)
  EventManager.Add("region_boss_ticket_notify", self, self.OnEvent_RefreshRes)
  self.passStar = 1
  self.nBeforeStar = 0
  self.selRegionBossId = 0
  self.selBuildId = 0
  self.selLvId = 0
  self.isWeeklyCopies = false
  self.weekBossThroughTime = nil
  self.curLevel = nil
  self._regionBossLevel = {}
  self._regionBossAffix = {}
  self:HandleDifficultyMsg()
  self:HandleAffixMsg()
  self.CacheBossLevelMsg = {}
  self.CacheWeeklyCopiesMsg = {}
  self.CacheWeeklyReceivedIds = {}
  self.isUnLock = false
  self.tbLastMaxHard = {}
  self.isPauseCount = 0
  self.nRegionBossChallengeTicket = 0
  self.isSelectHardCore = false
  self.upDataBuildId = 0
end

function PlayerRogueBossData:GetUnlockRogueBoss(nId, nIndex)
  local data = ConfigTable.GetData("RegionBoss", nId)
  local _prev = decodeJson(data.UnlockCondition)
  for __, nMainlineId in ipairs(_prev) do
    local nStar = PlayerData.Mainline:GetMainlineStar(nMainlineId)
    if type(nStar) ~= "number" then
      return false
    end
  end
  local worldClass = PlayerData.Base:GetWorldClass()
  local tempData = self._regionBossLevel[nId][nIndex]
  if worldClass < tempData.NeedWorldClass then
    return false, tempData.NeedWorldClass
  end
  if tempData.PreLevelId ~= 0 then
    local cachePreData = self:GetCacheBossLevelMsg(tempData.PreLevelId)
    if cachePreData == nil or cachePreData.Star == nil or cachePreData.Star < tempData.PreLevelStar then
      return false
    end
  end
  return true
end

function PlayerRogueBossData:GetRogueBossUnLockMsg(nId, nIndex)
  local worldClass = PlayerData.Base:GetWorldClass()
  local tempData = self._regionBossLevel[nId][nIndex]
  local isWorldClass = true
  if worldClass < tempData.NeedWorldClass then
    isWorldClass = false
  end
  local isPreLevelStar = true
  if tempData.PreLevelId ~= 0 then
    local cachePreData = self:GetCacheBossLevelMsg(tempData.PreLevelId)
    if cachePreData == nil or cachePreData.Star == nil or cachePreData.Star < tempData.PreLevelStar then
      isPreLevelStar = false
    end
  end
  if isWorldClass == false or isPreLevelStar == false then
    return false, isWorldClass, isPreLevelStar
  end
  return true
end

function PlayerRogueBossData:GetBossMaxLv(bossId)
  local maxLv = 1
  local worldClass = PlayerData.Base:GetWorldClass()
  local lvGroupCount = self._regionBossLevel[bossId].groupCount
  for i = 1, lvGroupCount do
    local tempData = self._regionBossLevel[bossId][i]
    if worldClass >= tempData.NeedWorldClass then
      if tempData.PreLevelId ~= 0 then
        local cachePreData = PlayerData.RogueBoss:GetCacheBossLevelMsg(tempData.Id)
        if cachePreData and 0 < cachePreData.Star then
          maxLv = i
        end
      else
        maxLv = i
      end
    end
  end
  return maxLv
end

function PlayerRogueBossData:GetBossMaxGroupCount(bossId)
  if nil ~= self._regionBossLevel[bossId] then
    return self._regionBossLevel[bossId].groupCount
  end
  return 0
end

function PlayerRogueBossData:SetLastMaxHard(nGroupId, nHard)
  self.tbLastMaxHard[nGroupId] = nHard
end

function PlayerRogueBossData:GetLastMaxHard(nGroupId)
  return self.tbLastMaxHard[nGroupId] or 0
end

function PlayerRogueBossData:GetMaxHard(nGroupId)
  local nHard = PlayerData.RogueBoss:GetBossMaxLv(nGroupId)
  local maxCount = PlayerData.RogueBoss:GetBossMaxGroupCount(nGroupId)
  if maxCount < nHard + 1 then
    nHard = maxCount
  else
    local bUnlock = PlayerData.RogueBoss:GetUnlockRogueBoss(nGroupId, nHard + 1)
    if bUnlock then
      nHard = nHard + 1
    end
  end
  return nHard
end

function PlayerRogueBossData:GetLevelOpenState(nGroupId)
  local mapData = ConfigTable.GetData("RegionBoss", nGroupId)
  if nil ~= mapData then
    local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
    local fixedTimeStamp = curTimeStamp - newDayTime * 3600
    local nWeek = tonumber(os.date("!%w", fixedTimeStamp))
    local bOpenTime = table.indexof(mapData.OpenDay, nWeek) > 0
    local nLockMainline = 0
    local bMainLine = true
    local _prev = decodeJson(mapData.UnlockCondition)
    if 0 < #_prev then
      for _, nMainlineId in ipairs(_prev) do
        local nStar = PlayerData.Mainline:GetMainlineStar(nMainlineId)
        if type(nStar) ~= "number" then
          nLockMainline = nMainlineId
        end
      end
      bMainLine = 0 < nLockMainline
    end
    local bRogueLike = true
    local bUnlock = bMainLine and bRogueLike
    if not bOpenTime then
      return AllEnum.RogueBossLevelState.Not_OpenDay, bUnlock
    end
    if not bMainLine then
      return AllEnum.RogueBossLevelState.Not_MainLine, bUnlock
    end
    if not bRogueLike then
      return AllEnum.RogueBossLevelState.Not_RogueLike, bUnlock
    end
    return AllEnum.RogueBossLevelState.Open, bUnlock
  end
  return AllEnum.RogueBossLevelState.None
end

function PlayerRogueBossData:GetUnOpenTipText(nLevelState, nGroupId)
  local sTipStr = ""
  if nLevelState == AllEnum.RogueBossLevelState.Not_OpenDay then
    sTipStr = ConfigTable.GetUIText("Not_Open_Time")
  elseif nLevelState == AllEnum.RogueBossLevelState.Not_MainLine then
    local mapData = ConfigTable.GetData("RegionBoss", nGroupId)
    local nLockMainline = 0
    local _prev = decodeJson(mapData.UnlockCondition)
    for _, nMainlineId in ipairs(_prev) do
      local nStar = PlayerData.Mainline:GetMainlineStar(nMainlineId)
      if type(nStar) ~= "number" then
        nLockMainline = nMainlineId
      end
    end
    local mapLevelData = ConfigTable.GetData_Mainline(nLockMainline)
    if mapLevelData ~= nil then
      sTipStr = orderedFormat(ConfigTable.GetUIText("MainLine_Lock"), mapLevelData.Num, mapLevelData.Name)
    else
      sTipStr = orderedFormat(ConfigTable.GetUIText("MainLine_Lock"), tostring(nLockMainline), "")
    end
  elseif nLevelState == AllEnum.RogueBossLevelState.Not_HardUnlock then
    sTipStr = ConfigTable.GetUIText("Level_Lock")
  end
  return sTipStr
end

function PlayerRogueBossData:GetUnOpenUITipText(nLevelState, nGroupId)
  local sTipStr = ""
  if nLevelState == AllEnum.RogueBossLevelState.Not_OpenDay then
    sTipStr = ConfigTable.GetUIText("Not_Open_Time")
  elseif nLevelState == AllEnum.RogueBossLevelState.Not_MainLine then
    local mapData = ConfigTable.GetData("RegionBoss", nGroupId)
    local nLockMainline = 0
    local _prev = decodeJson(mapData.UnlockCondition)
    for _, nMainlineId in ipairs(_prev) do
      local nStar = PlayerData.Mainline:GetMainlineStar(nMainlineId)
      if type(nStar) ~= "number" then
        nLockMainline = nMainlineId
      end
    end
    local mapLevelData = ConfigTable.GetData_Mainline(nLockMainline)
    if mapLevelData ~= nil then
      sTipStr = orderedFormat(ConfigTable.GetUIText("MainLine_Lock"), mapLevelData.Num, mapLevelData.Name)
    else
      sTipStr = orderedFormat(ConfigTable.GetUIText("MainLine_Lock"), tostring(nLockMainline), "")
    end
  elseif nLevelState == AllEnum.RogueBossLevelState.Not_HardUnlock then
    sTipStr = ConfigTable.GetUIText("Level_Lock")
  end
  return sTipStr
end

function PlayerRogueBossData:CheckLevelOpen(nGroupId, nHard, bShowTips)
  if nGroupId == 0 then
    return AllEnum.RogueBossLevelState.Open
  end
  local nLevelState, bUnlock = self:GetLevelOpenState(nGroupId)
  if nil ~= nHard and nLevelState == AllEnum.RogueBossLevelState.Open then
    local nMaxLevel = self:GetMaxHard(nGroupId)
    if nHard > nMaxLevel then
      nLevelState = AllEnum.RogueBossLevelState.Not_HardUnlock
    end
  end
  if true == bShowTips then
    local sTipStr = self:GetUnOpenTipText(nLevelState, nGroupId)
    if nil ~= sTipStr and "" ~= sTipStr then
      EventManager.Hit(EventId.OpenMessageBox, sTipStr)
    end
  end
  return nLevelState == AllEnum.RogueBossLevelState.Open, bUnlock
end

function PlayerRogueBossData:HandleDifficultyMsg()
  local function foreach_Diff(diffData)
    if self._regionBossLevel[diffData.RegionBossId] == nil then
      self._regionBossLevel[diffData.RegionBossId] = {}
      
      self._regionBossLevel[diffData.RegionBossId].groupCount = 0
    end
    self._regionBossLevel[diffData.RegionBossId][diffData.Difficulty] = diffData
    self._regionBossLevel[diffData.RegionBossId].groupCount = self._regionBossLevel[diffData.RegionBossId].groupCount + 1
  end
  
  if self._regionBossLevel == nil then
    self._regionBossLevel = {}
  end
  ForEachTableLine(DataTable.RegionBossLevel, foreach_Diff)
end

function PlayerRogueBossData:GetDiffAffixUnlockLv(regionBossId, entryGroupLevel)
  local gCount = self._regionBossLevel[regionBossId].groupCount
  for i = 1, gCount do
    if self._regionBossLevel[regionBossId][i][entryGroupLevel] ~= 0 then
      return self._regionBossLevel[regionBossId][i].Difficulty
    end
  end
  return 1
end

function PlayerRogueBossData:HandleAffixMsg()
  local function foreach_Affix(affixData)
    if self._regionBossAffix[affixData.GroupId] == nil then
      self._regionBossAffix[affixData.GroupId] = {}
      
      self._regionBossAffix[affixData.GroupId].groupCount = 0
    end
    self._regionBossAffix[affixData.GroupId][affixData.Level] = affixData
    self._regionBossAffix[affixData.GroupId].groupCount = self._regionBossAffix[affixData.GroupId].groupCount + 1
  end
  
  ForEachTableLine(DataTable.RegionBossAffix, foreach_Affix)
end

function PlayerRogueBossData:SetRegionBossId(_regionBossId)
  self.selRegionBossId = _regionBossId
end

function PlayerRogueBossData:GetRegionBossId()
  return self.selRegionBossId
end

function PlayerRogueBossData:GetRewardItem(id, isFirstPass, isThreeStar)
  local cfgData = ConfigTable.GetData("RegionBossLevel", id)
  local tbItem = {}
  local _base = decodeJson(cfgData.BaseAwardPreview)
  if not isFirstPass then
    local _first = decodeJson(cfgData.FirstAwardPreview)
    for k, v in ipairs(_first) do
      table.insert(tbItem, {
        Tid = v,
        rewardType = AllEnum.RewardType.First
      })
    end
  end
  if not isThreeStar then
    local _three = decodeJson(cfgData.ThreeStarAwardPreview)
    for k, v in ipairs(_three) do
      table.insert(tbItem, {
        Tid = v,
        rewardType = AllEnum.RewardType.Three
      })
    end
  end
  for k, v in ipairs(_base) do
    table.insert(tbItem, {Tid = v})
  end
  return tbItem
end

function PlayerRogueBossData:SetSelLvId(id)
  self.selLvId = id
end

function PlayerRogueBossData:GetSelLvId()
  return self.selLvId
end

function PlayerRogueBossData:SetIsWeeklyCopies(isWeeklyCopies)
  self.isWeeklyCopies = isWeeklyCopies
end

function PlayerRogueBossData:GetIsWeeklyCopies()
  return self.isWeeklyCopies
end

function PlayerRogueBossData:CacheRogueBossData(tbData)
  if self.CacheBossLevelMsg == nil then
    self.CacheBossLevelMsg = {}
  end
  if tbData then
    for i, v in ipairs(tbData) do
      local tab = {}
      tab.Star = v.Star
      tab.First = v.First
      tab.ThreeStar = v.ThreeStar
      tab.BuildId = 0
      if v.Build ~= nil then
        tab.BuildId = v.Build.BuildId or 0
      end
      tab.maxStar = v.ThreeStar and 3 or v.Star
      self.CacheBossLevelMsg[v.Id] = tab
    end
  end
  self:OnEvent_RefreshRes(AllEnum.CoinItemId.RogueHardCoreTick)
end

function PlayerRogueBossData:CacheWeeklyCopiesData(tbData)
  if self.CacheWeeklyCopiesMsg == nil then
    self.CacheWeeklyCopiesMsg = {}
  end
  if self.CacheWeeklyLastBuildInfo == nil then
    self.CacheWeeklyLastBuildInfo = {}
  end
  if tbData then
    for i, v in pairs(tbData) do
      if self.CacheWeeklyCopiesMsg[v.Id] ~= nil then
        local tab = self.CacheWeeklyCopiesMsg[v.Id]
        if tab.Time > v.Time then
          tab.Time = v.Time
          tab.BuildId = v.BuildId
          tab.First = v.First
          self.CacheWeeklyCopiesMsg[v.Id] = tab
        end
      else
        local tab = {}
        tab.Id = v.Id
        tab.Time = v.Time
        tab.BuildId = v.BuildId
        tab.First = v.First
        self.CacheWeeklyCopiesMsg[v.Id] = tab
      end
      self.CacheWeeklyLastBuildInfo[v.Id] = v.BuildId
    end
  end
end

function PlayerRogueBossData:GetCacheWeeklyBossMsg(id)
  return self.CacheWeeklyCopiesMsg[id] or nil
end

function PlayerRogueBossData:GetCacheWeeklyBuildID(id)
  return self.CacheWeeklyLastBuildInfo[id] or nil
end

function PlayerRogueBossData:CacheWeeklyThroughTime(time)
  self.weekBossThroughTime = time
end

function PlayerRogueBossData:ClearCacheWeeklyRecIds()
  self.CacheWeeklyReceivedIds = {}
  if PanelManager.CheckPanelOpen(PanelId.WeeklyCopiesPanel) then
    EventManager.Hit(EventId.OpenPanel, PanelId.WeeklyCopiesPanel)
  end
end

function PlayerRogueBossData:GetCacheBossLevelMsg(Id)
  return self.CacheBossLevelMsg[Id] or nil
end

function PlayerRogueBossData:GetBeforeStar()
  return self.nBeforeStar
end

function PlayerRogueBossData:OnEvent_RefreshRes(nId)
  if nId == AllEnum.CoinItemId.RogueHardCoreTick then
    self.nRegionBossChallengeTicket = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.RogueHardCoreTick)
    local worldClass = PlayerData.Base:GetWorldClass()
    local openClass = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.RegionBossChallenge).NeedWorldClass
    if worldClass >= openClass and self.nRegionBossChallengeTicket > 0 then
      RedDotManager.SetValid(RedDotDefine.Map_RogueBoss, nil, true)
    else
      RedDotManager.SetValid(RedDotDefine.Map_RogueBoss, nil, false)
    end
  end
end

function PlayerRogueBossData:GetRegionBossChallengeTicket()
  return self.nRegionBossChallengeTicket
end

function PlayerRogueBossData:SetSelectRegionType(isHard)
  self.isSelectHardCore = isHard
end

function PlayerRogueBossData:GetSelectRegionType()
  return self.isSelectHardCore
end

function PlayerRogueBossData:EnterRegionBoss(mapData)
  self._EntryTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  if self.curLevel ~= nil then
    if self.curLevel.UnBindEvent ~= nil then
      self.curLevel:UnBindEvent()
    end
    self.curLevel = nil
  end
  local luaClass = require("Game.Adventure.RegionBossLevel.RegionBossBattleLevel")
  if luaClass == nil then
    return
  end
  self.curLevel = luaClass
  if type(self.curLevel.BindEvent) == "function" then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    self.upDataBuildId = self.selBuildId
    self.curLevel:Init(self, self.selLvId, self.selBuildId, 1)
  end
end

function PlayerRogueBossData:EnterWeekBoss(mapData)
  self._EntryTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  if self.curLevel ~= nil then
    if self.curLevel.UnBindEvent ~= nil then
      self.curLevel:UnBindEvent()
    end
    self.curLevel = nil
  end
  local luaClass = require("Game.Adventure.RegionBossLevel.RegionBossBattleLevel")
  if luaClass == nil then
    return
  end
  self.curLevel = luaClass
  if type(self.curLevel.BindEvent) == "function" then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    self.upDataBuildId = self.selBuildId
    self.curLevel:Init(self, self.selLvId, self.selBuildId, 2)
  end
end

function PlayerRogueBossData:EnterRoguelikeEditor(floorId, tbTeamCharId, tbDisc, tbNote)
  self.selLvId = 0
  self.nFloorId = floorId
  self.tbCharId = tbTeamCharId
  self.selBuildId = 0
  
  local function foreach_level(_Data)
    if _Data.FloorId == floorId then
      self.selLvId = _Data.Id
    end
  end
  
  ForEachTableLine(DataTable.RegionBossLevel, foreach_level)
  if self.curLevel ~= nil then
    if self.curLevel.UnBindEvent ~= nil then
      self.curLevel:UnBindEvent()
    end
    self.curLevel = nil
  end
  local luaClass = require("Game.Editor.RegionBossLevel.RegionBossBattleLevelEditor")
  if luaClass == nil then
    return
  end
  self.curLevel = luaClass
  if type(self.curLevel.BindEvent) == "function" then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    self.curLevel:Init(self, self.selLvId, tbTeamCharId, tbDisc, tbNote)
  end
end

function PlayerRogueBossData:LevelEnd()
  self.curLevel = nil
end

function PlayerRogueBossData:RegionBossLevelSettleReq(isWin, useTime, callback)
  if isWin and not PlayerData.Guide:CheckGuideFinishById(16) then
    PlayerData.Guide:SetPlayerLearnReq(16, -1)
  end
  
  local function func_cbRegionBossLevelSettleAck(_, msgData)
    if callback ~= nil then
      callback(msgData, self.passStar)
    end
    self._EndTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
    local tabUpLevel = {}
    local result = isWin and "1" or "2"
    table.insert(tabUpLevel, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tabUpLevel, {
      "game_cost_time",
      tostring(useTime)
    })
    table.insert(tabUpLevel, {
      "real_cost_time",
      tostring(self._EndTime - self._EntryTime)
    })
    table.insert(tabUpLevel, {
      "build_id",
      tostring(self.upDataBuildId)
    })
    table.insert(tabUpLevel, {
      "battle_id",
      tostring(self.selLvId)
    })
    table.insert(tabUpLevel, {
      "battle_result",
      tostring(result)
    })
    NovaAPI.UserEventUpload("region_boss_battle", tabUpLevel)
  end
  
  self.passStar = 0
  if isWin then
    self.passStar = 1
    local lvMsg = ConfigTable.GetData("RegionBossLevel", self.selLvId)
    if lvMsg.RegionType == GameEnum.RegionType.NormalRegion then
      local star2 = decodeJson(lvMsg.TwoStarCondition)
      local star3 = decodeJson(lvMsg.ThreeStarCondition)
      if star2[1] == 2 and useTime < star2[2] then
        self.passStar = 2
      end
      if star3[1] == 2 and useTime < star3[2] then
        self.passStar = 3
      end
    end
  end
  local Events = PlayerData.Achievement:GetBattleAchievement(GameEnum.levelType.RegionBoss, isWin)
  local mapSendMsg = {}
  mapSendMsg.Star = self.passStar
  if 0 < #Events then
    mapSendMsg.Events = {
      List = {}
    }
    mapSendMsg.Events.List = Events
  end
  HttpNetHandler.SendMsg(NetMsgId.Id.region_boss_level_settle_req, mapSendMsg, nil, func_cbRegionBossLevelSettleAck)
end

function PlayerRogueBossData:WeeklyCopiesLevelSettleReq(isWin, useTime, callback)
  local function func_cbRegionBossLevelSettleAck(_, msgData)
    if callback ~= nil then
      callback(msgData, self.passStar)
    end
    self._EndTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
    local tabUpLevel = {}
    local result = isWin and "1" or "2"
    table.insert(tabUpLevel, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tabUpLevel, {
      "game_cost_time",
      tostring(useTime)
    })
    table.insert(tabUpLevel, {
      "real_cost_time",
      tostring(self._EndTime - self._EntryTime)
    })
    table.insert(tabUpLevel, {
      "build_id",
      tostring(self.upDataBuildId)
    })
    table.insert(tabUpLevel, {
      "battle_id",
      tostring(self.selLvId)
    })
    table.insert(tabUpLevel, {
      "battle_result",
      tostring(result)
    })
    NovaAPI.UserEventUpload("week_boss", tabUpLevel)
  end
  
  local Events = PlayerData.Achievement:GetBattleAchievement(GameEnum.levelType.WeeklyCopies, isWin)
  local mapSendMsg = {}
  mapSendMsg.Result = isWin
  mapSendMsg.Time = useTime
  if isWin then
    PlayerData.RogueBoss:CacheWeeklyThroughTime(useTime)
  else
    PlayerData.RogueBoss:CacheWeeklyThroughTime(nil)
  end
  if 0 < #Events then
    mapSendMsg.Events = {
      List = {}
    }
    mapSendMsg.Events.List = Events
  end
  HttpNetHandler.SendMsg(NetMsgId.Id.week_boss_settle_req, mapSendMsg, nil, func_cbRegionBossLevelSettleAck)
end

function PlayerRogueBossData:WeeklyCopiesLevelSettleReqSuccess(msgData)
  local isFirst = msgData.First
  if self.weekBossThroughTime == nil then
    return
  end
  local levels = {}
  local level = {}
  level.Id = self.selLvId
  level.Time = self.weekBossThroughTime
  level.First = isFirst
  level.BuildId = self.selBuildId
  table.insert(levels, level)
  self:CacheWeeklyCopiesData(levels)
  self.weekBossThroughTime = nil
end

function PlayerRogueBossData:RegionBossLevelSettleSuccess(mapMsgData)
  self.nBeforeStar = 0
  if self.CacheBossLevelMsg[self:GetSelLvId()] then
    self.nBeforeStar = self.CacheBossLevelMsg[self:GetSelLvId()].Star
  end
  if 0 < self.passStar then
    local tempCache = self.CacheBossLevelMsg[self:GetSelLvId()]
    local data = {}
    data.Id = self:GetSelLvId()
    if tempCache and tempCache.Star > self.passStar then
      data.Star = tempCache.Star
    else
      data.Star = self.passStar
    end
    if tempCache and tempCache.First then
      data.First = tempCache.First
    else
      data.First = mapMsgData.First
    end
    if tempCache and tempCache.ThreeStar then
      data.ThreeStar = tempCache.ThreeStar
    else
      data.ThreeStar = mapMsgData.ThreeStar
    end
    data.BuildId = self.selBuildId
    if tempCache and tempCache.ThreeStar then
      data.maxStar = 3
    else
      data.maxStar = mapMsgData.ThreeStar and 3 or self.passStar
    end
    self.CacheBossLevelMsg[data.Id] = data
    local tempLvData = ConfigTable.GetData("RegionBossLevel", self:GetSelLvId())
    if tempLvData.Difficulty < self._regionBossLevel[tempLvData.RegionBossId].groupCount then
      local tempDiff = tempLvData.Difficulty + 1
      local _tempLvId = self._regionBossLevel[tempLvData.RegionBossId][tempDiff].Id
      if self.CacheBossLevelMsg[_tempLvId] == nil then
        self:SetIsUnlock(true)
      end
    end
  else
    local tempCache = self.CacheBossLevelMsg[self:GetSelLvId()]
    local data = {}
    data.Id = self:GetSelLvId()
    if tempCache and tempCache.Star > self.passStar then
      data.Star = tempCache.Star
    else
      data.Star = self.passStar
    end
    data.First = tempCache and tempCache.First or mapMsgData.First
    data.ThreeStar = tempCache and tempCache.ThreeStar or mapMsgData.ThreeStar
    data.BuildId = self.selBuildId
    if tempCache and tempCache.maxStar > self.passStar then
      data.maxStar = tempCache.maxStar
    else
      data.maxStar = self.passStar
    end
    self.CacheBossLevelMsg[data.Id] = data
  end
  self:SetSelBuildId(0)
  self:OnEvent_RefreshRes(AllEnum.CoinItemId.RogueHardCoreTick)
end

function PlayerRogueBossData:RegionBossLevelSettleFail()
end

function PlayerRogueBossData:SetSelBuildId(bId)
  self.selBuildId = bId
end

function PlayerRogueBossData:GetSelBuildId()
  return self.selBuildId
end

function PlayerRogueBossData:OnEvent_DelBuildItemId(tab)
  for i, v in pairs(tab) do
    for i1, v1 in pairs(self.CacheBossLevelMsg) do
      if v1.BuildId == v then
        v1.BuildId = 0
      end
    end
  end
end

function PlayerRogueBossData:GetIsUnlock()
  return self.isUnLock
end

function PlayerRogueBossData:SetIsUnlock(isPass)
  self.isUnLock = isPass
end

function PlayerRogueBossData:Sweep(nLevelId, nTimes, callback)
  local msg = {
    Id = nLevelId,
    Times = nTimes,
    Events = {
      List = {}
    }
  }
  
  local function successCallback(_, mapMainData)
    callback(mapMainData.Rewards, mapMainData.Change)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.region_boss_level_sweep_req, msg, nil, successCallback)
end

return PlayerRogueBossData
