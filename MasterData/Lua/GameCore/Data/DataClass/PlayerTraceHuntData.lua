local PlayerTraceHuntData = class("PlayerTraceHuntData")
local ClientManager = CS.ClientManager.Instance
local TimerManager = require("GameCore.Timer.TimerManager")

function PlayerTraceHuntData:Init()
  self.timerControl = nil
  self.timerHelp = nil
  self.timerHunt = nil
  self.bRefreshHelpCD = false
  self.tbRecommend = {}
  self.bNewControl = false
  self.bHuntWarning = true
  self.nMaxStar = 0
  self.nControlId = 0
  self.nBossId = 0
  self.nTraceProgress = 0
  self.nHuntProgress = 0
  self.nBossCreateTime = 0
  self.nSelfBossHuntCount = 0
  self.tbTraceLog = {}
  self.tbHuntLog = {}
  self.tbBossCollection = {}
  self.nLevel = 0
  self.nExp = 0
  self.mapHuntPermit = {
    nEnergyOverflow = 0,
    nConvertedCount = 0,
    nGrantedCount = 0,
    nDailyCount = 0
  }
  self.mapTraceRequest = {
    nEnergyOverflow = 0,
    nConvertedCount = 0,
    nGrantedCount = 0,
    nDailyCount = 0
  }
  self.nBuildId = 0
  self.nSelfBossHard = 1
  self.nHelpBossHard = 1
  EventManager.Add(EventId.IsNewDay, self, self.OnEvent_NewDay)
  self:ProcessTableData()
end

function PlayerTraceHuntData:ProcessTableData()
  self.tbTraceHuntStar = {}
  
  local function func_ForEach_Star(mapData)
    if not self.tbTraceHuntStar[mapData.Star] then
      self.tbTraceHuntStar[mapData.Star] = {}
    end
    self.tbTraceHuntStar[mapData.Star][mapData.Difficulty] = mapData.ScoreNeed
  end
  
  ForEachTableLine(DataTable.TraceHuntStar, func_ForEach_Star)
  self.tbHuntExtraCost = {}
  
  local function func_ForEach_ExtraCost(mapData)
    self.tbHuntExtraCost[mapData.Times] = {
      Tid = mapData.ExtraCost1Tid,
      Qty = mapData.ExtraCost1Qty
    }
  end
  
  ForEachTableLine(DataTable.TraceHuntSelfHuntExtraCost, func_ForEach_ExtraCost)
  self:ProcessTableData_Level()
  self:ProcessTableData_Config()
  self:ProcessTableData_Log()
  self:ProcessTableData_Floor()
end

function PlayerTraceHuntData:ProcessTableData_Config()
  self.nHuntPermitTid = ConfigTable.GetConfigNumber("TraceHuntPermitItemTid")
  self.nTraceRequestTid = ConfigTable.GetConfigNumber("TraceHuntRequestItemTid")
  self.tbPieceNeedTraceProgress = ConfigTable.GetConfigNumberArray("TraceHuntPieceNeedTraceProgress")
  self.nBossHuntLimitTime = ConfigTable.GetConfigNumber("TraceHuntBossHuntLimitTime")
  self.nRefreshHelpCD = ConfigTable.GetConfigNumber("TraceHuntRefreshHelpCD")
  self.nMaxTraceProgress = ConfigTable.GetConfigNumber("TraceHuntMaxTraceProgress")
  self.nMaxHuntProgress = ConfigTable.GetConfigNumber("TraceHuntMaxHuntProgress")
end

function PlayerTraceHuntData:ProcessTableData_Log()
  self.mapLogTemplate = {}
  
  local function func_ForEach_Log(mapData)
    if mapData.Type == GameEnum.TraceHuntLogType.TraceStart then
      self.mapLogTemplate[GameEnum.TraceHuntLogType.TraceStart] = mapData.Id
    elseif mapData.Type == GameEnum.TraceHuntLogType.TraceEnd then
      self.mapLogTemplate[GameEnum.TraceHuntLogType.TraceEnd] = mapData.Id
    elseif mapData.Type == GameEnum.TraceHuntLogType.TraceRestart then
      self.mapLogTemplate[GameEnum.TraceHuntLogType.TraceRestart] = mapData.Id
    elseif mapData.Type == GameEnum.TraceHuntLogType.HuntBeforeStart then
      self.mapLogTemplate[GameEnum.TraceHuntLogType.HuntBeforeStart] = mapData.Id
    elseif mapData.Type == GameEnum.TraceHuntLogType.HuntStart then
      self.mapLogTemplate[GameEnum.TraceHuntLogType.HuntStart] = mapData.Id
    elseif mapData.Type == GameEnum.TraceHuntLogType.HuntInterrupt then
      self.mapLogTemplate[GameEnum.TraceHuntLogType.HuntInterrupt] = mapData.Id
    elseif mapData.Type == GameEnum.TraceHuntLogType.HuntEnd then
      self.mapLogTemplate[GameEnum.TraceHuntLogType.HuntEnd] = mapData.Id
    elseif mapData.Type == GameEnum.TraceHuntLogType.Settlement then
      self.mapLogTemplate[GameEnum.TraceHuntLogType.Settlement] = mapData.Id
    end
  end
  
  ForEachTableLine(DataTable.TraceHuntLogEntryTemplate, func_ForEach_Log)
end

function PlayerTraceHuntData:ProcessTableData_Level()
  self.tbTraceHuntLevel = {}
  self.nMaxTraceHuntLevel = 0
  self.nHardOpenLevel = 100
  self.nNoneRewardHelpOpenLevel = 100
  
  local function func_ForEach_Level(mapData)
    self.tbTraceHuntLevel[mapData.Level] = {
      Exp = mapData.Exp,
      WorldClass = mapData.WorldClass,
      MaxStar = mapData.MaxStar,
      Level = mapData.Level,
      DisplayMaxStar = mapData.DisplayMaxStar,
      DisplayTokenRate = mapData.DisplayTokenRate,
      DisplayLuckyRate = mapData.DisplayLuckyRate,
      DisplayAddRate = mapData.DisplayAddRate,
      DisplayFreeRate = mapData.DisplayFreeRate,
      DisplayWorldClass = 0
    }
    if mapData.Level > self.nMaxTraceHuntLevel then
      self.nMaxTraceHuntLevel = mapData.Level
    end
    if #mapData.DifficultyList > 1 and mapData.Level < self.nHardOpenLevel then
      self.nHardOpenLevel = mapData.Level
    end
    if mapData.Voluntary == true and mapData.Level < self.nNoneRewardHelpOpenLevel then
      self.nNoneRewardHelpOpenLevel = mapData.Level
    end
  end
  
  ForEachTableLine(DataTable.TraceHuntLevel, func_ForEach_Level)
  for i = 1, self.nMaxTraceHuntLevel do
    local mapCurLevel = self.tbTraceHuntLevel[i]
    local mapNextLevel = self.tbTraceHuntLevel[i + 1]
    if mapNextLevel and mapNextLevel.WorldClass > mapCurLevel.WorldClass and self.tbTraceHuntLevel[i + 2] then
      self.tbTraceHuntLevel[i + 2].DisplayWorldClass = mapNextLevel.WorldClass
    end
  end
end

function PlayerTraceHuntData:ProcessTableData_Floor()
  self.tbTraceHuntFloor = {}
  
  local function func_ForEach_Floor(mapData)
    if not self.tbTraceHuntFloor[mapData.GroupId] then
      self.tbTraceHuntFloor[mapData.GroupId] = {}
    end
    self.tbTraceHuntFloor[mapData.GroupId][mapData.Difficult] = mapData
  end
  
  ForEachTableLine(DataTable.TraceHuntFloorGroup, func_ForEach_Floor)
end

function PlayerTraceHuntData:UnInit()
  EventManager.Remove(EventId.IsNewDay, self, self.OnEvent_NewDay)
end

function PlayerTraceHuntData:OnEvent_NewDay()
  self.mapHuntPermit.nDailyCount = 0
  self.mapTraceRequest.nDailyCount = 0
end

function PlayerTraceHuntData:CacheItemInfo(mapHuntPermit, mapTraceRequest)
  self.mapHuntPermit = {
    nEnergyOverflow = mapHuntPermit.EnergyOverflow,
    nConvertedCount = mapHuntPermit.ConvertedCount,
    nGrantedCount = mapHuntPermit.GrantedCount,
    nDailyCount = mapHuntPermit.DailyCount
  }
  self.mapTraceRequest = {
    nEnergyOverflow = mapTraceRequest.EnergyOverflow,
    nConvertedCount = mapTraceRequest.ConvertedCount,
    nGrantedCount = mapTraceRequest.GrantedCount,
    nDailyCount = mapTraceRequest.DailyCount
  }
  self:UpdateItemRedDot()
end

function PlayerTraceHuntData:ChangeItem(tbTraceHuntItem)
  if tbTraceHuntItem == nil then
    return
  end
  for _, mapTraceHuntItem in ipairs(tbTraceHuntItem) do
    self:ChangeTraceHuntItem(mapTraceHuntItem)
  end
  self:UpdateItemRedDot()
  EventManager.Hit("TraceHuntItemChange")
end

function PlayerTraceHuntData:ChangeItemNotify(mapTraceHuntItem)
  if mapTraceHuntItem == nil then
    return
  end
  self:ChangeTraceHuntItem(mapTraceHuntItem)
  if mapTraceHuntItem.ConvertQty > 0 then
    PlayerData.SideBanner:AddItem(mapTraceHuntItem.Tid, mapTraceHuntItem.ConvertQty)
  end
  self:UpdateItemRedDot()
  EventManager.Hit("TraceHuntItemChange")
end

function PlayerTraceHuntData:ChangeTraceHuntItem(mapTraceHuntItem)
  if mapTraceHuntItem.Tid == self.nHuntPermitTid then
    self.mapHuntPermit.nEnergyOverflow = self.mapHuntPermit.nEnergyOverflow + mapTraceHuntItem.PointQty
    self.mapHuntPermit.nConvertedCount = self.mapHuntPermit.nConvertedCount + mapTraceHuntItem.ConvertQty
    self.mapHuntPermit.nGrantedCount = self.mapHuntPermit.nGrantedCount + mapTraceHuntItem.GrantQty
    self.mapHuntPermit.nDailyCount = self.mapHuntPermit.nDailyCount + mapTraceHuntItem.DailyCount
  elseif mapTraceHuntItem.Tid == self.nTraceRequestTid then
    self.mapTraceRequest.nEnergyOverflow = self.mapTraceRequest.nEnergyOverflow + mapTraceHuntItem.PointQty
    self.mapTraceRequest.nConvertedCount = self.mapTraceRequest.nConvertedCount + mapTraceHuntItem.ConvertQty
    self.mapTraceRequest.nGrantedCount = self.mapTraceRequest.nGrantedCount + mapTraceHuntItem.GrantQty
    self.mapTraceRequest.nDailyCount = self.mapTraceRequest.nDailyCount + mapTraceHuntItem.DailyCount
  end
end

function PlayerTraceHuntData:CacheTraceHuntInfo(mapTraceHuntInfo)
  local nLastControlId = self.nControlId
  self.nControlId = mapTraceHuntInfo.ControlID
  if nLastControlId ~= self.nControlId then
    self:ResetStateInNewControl()
  end
  self.nBossId = mapTraceHuntInfo.BossID
  self.nTraceProgress = mapTraceHuntInfo.TraceProgress
  self.nHuntProgress = mapTraceHuntInfo.HuntProgress
  self.nBossCreateTime = mapTraceHuntInfo.BossCreateTime
  if self.nBossCreateTime ~= 0 then
    self:SetHuntTimer()
  end
  self.nSelfBossHuntCount = mapTraceHuntInfo.SelfHuntTimes
  self.tbTraceLog = {}
  self:AddTraceLog(mapTraceHuntInfo.TraceLog)
  self.tbHuntLog = {}
  self:AddHuntLog(mapTraceHuntInfo.HuntLog)
  self.tbBossCollection = {}
  for _, v in ipairs(mapTraceHuntInfo.BossCollections) do
    self:UpdateBossCollection(v.Id, v.HuntCount, v.AssistHuntCount)
    if NovaAPI.IsEditorPlatform() then
      printLog("TraceHunt 图鉴 Boss id/讨伐次数/协助次数：" .. "  " .. v.Id .. "/" .. v.HuntCount .. "/" .. v.AssistHuntCount)
    end
  end
  self:UpdateControlData()
  self:UpdateLevel(mapTraceHuntInfo.Level, mapTraceHuntInfo.Exp)
  self:SetSelBuildId(mapTraceHuntInfo.Build and mapTraceHuntInfo.Build.BuildId or 0)
  local bComplete = self:CheckHuntComplete()
  local bInterrupt = self:CheckHuntInterrupt()
  self:UpdateBossRewardRedDot(bComplete or bInterrupt)
  if NovaAPI.IsEditorPlatform() then
    printLog("TraceHunt 赛季id：" .. "  " .. mapTraceHuntInfo.ControlID)
    printLog("TraceHunt Boss id：" .. "  " .. mapTraceHuntInfo.BossID)
    printLog("TraceHunt 追踪进度：" .. "  " .. mapTraceHuntInfo.TraceProgress)
    printLog("TraceHunt 讨伐进度：" .. "  " .. mapTraceHuntInfo.HuntProgress)
    printLog("TraceHunt boss 创建时间：" .. "  " .. mapTraceHuntInfo.BossCreateTime)
    printLog("TraceHunt boss 自己讨伐的次数：" .. "  " .. mapTraceHuntInfo.SelfHuntTimes)
  end
end

function PlayerTraceHuntData:UpdateControlData()
  if self.nControlId == 0 then
    return
  end
  local mapCfg = ConfigTable.GetData("TraceHuntControl", self.nControlId)
  if not mapCfg then
    return
  end
  self.nEndTime = ClientManager:ISO8601StrToTimeStamp(mapCfg.EndTime)
  self.nStartTime = ClientManager:ISO8601StrToTimeStamp(mapCfg.StartTime)
  self.tbBossList = mapCfg.BossList
  self.tbStarDropCount = mapCfg.StarDropCount
  self:SetControlTimer()
end

function PlayerTraceHuntData:UpdateBossCollection(nId, nCompleteHuntCount, nAssistHuntCount)
  if not self.tbBossCollection[nId] then
    self.tbBossCollection[nId] = {
      nId = nId,
      nCompleteHuntCount = 0,
      nAssistHuntCount = 0
    }
  end
  self.tbBossCollection[nId].nCompleteHuntCount = self.tbBossCollection[nId].nCompleteHuntCount + nCompleteHuntCount
  self.tbBossCollection[nId].nAssistHuntCount = self.tbBossCollection[nId].nAssistHuntCount + nAssistHuntCount
end

function PlayerTraceHuntData:UpdateLevel(nLevel, nExp)
  self.nLevel = nLevel
  self.nExp = nExp
  local mapCfg = self.tbTraceHuntLevel[nLevel]
  self.nMaxStar = mapCfg.MaxStar
end

function PlayerTraceHuntData:SetNewControl(bNew)
  self.bNewControl = bNew
  if bNew then
    self:ResetStateInNewControl()
  end
end

function PlayerTraceHuntData:ResetStateInNewControl()
  self.nSelfBossHard = 1
  self.nHelpBossHard = 1
  self.bRefreshHelpCD = false
end

function PlayerTraceHuntData:GetNewControl()
  return self.bNewControl
end

function PlayerTraceHuntData:GetAddExp(nLevel1, nExp1, nLevel2, nExp2)
  if nLevel1 == nLevel2 then
    return nExp2 - nExp1
  elseif nLevel1 < nLevel2 then
    local nAll = 0
    for i = nLevel1, nLevel2 - 1 do
      nAll = nAll + self.tbTraceHuntLevel[i].Exp
    end
    nAll = nAll + nExp2 - nExp1
    return nAll
  else
    return 0
  end
end

function PlayerTraceHuntData:GetCurControlId()
  return self.nControlId
end

function PlayerTraceHuntData:GetControlBlockState()
  return self.nControlId < ConfigTable.GetConfigNumber("TraceHuntHardOpenControlId")
end

function PlayerTraceHuntData:GetSelfBossHard()
  if self:GetControlBlockState() then
    self.nSelfBossHard = 1
  end
  return self.nSelfBossHard
end

function PlayerTraceHuntData:SetSelfBossHard(nHard)
  self.nSelfBossHard = nHard
end

function PlayerTraceHuntData:GetHelpBossHard()
  if self:GetControlBlockState() then
    self.nHelpBossHard = 1
  end
  local nCost = self:GetHuntCostCount()
  local nHasCoin = self:GetHuntTokenCount()
  if nCost > nHasCoin then
    self.nHelpBossHard = 1
  end
  return self.nHelpBossHard
end

function PlayerTraceHuntData:SetHelpBossHard(nHard)
  self.nHelpBossHard = nHard
end

function PlayerTraceHuntData:CheckNoneRewardHelpOpen()
  if self:GetControlBlockState() then
    return false
  end
  return self.nLevel >= self.nNoneRewardHelpOpenLevel
end

function PlayerTraceHuntData:GetDifficultyBySource(bSelf)
  if bSelf then
    return self:GetSelfBossHard()
  else
    return self:GetHelpBossHard()
  end
end

function PlayerTraceHuntData:GetHuntWarning()
  return self.bHuntWarning
end

function PlayerTraceHuntData:SetHuntWarning(bAble)
  self.bHuntWarning = bAble
end

function PlayerTraceHuntData:GetEndTime()
  return self.nEndTime or 0
end

function PlayerTraceHuntData:GetStartTime()
  return self.nStartTime or 0
end

function PlayerTraceHuntData:GetControlLeftTime()
  if not self.nEndTime then
    return 0
  end
  local nLeft = self.nEndTime - ClientManager.serverTimeStamp
  if nLeft < 0 then
    nLeft = 0
  end
  return nLeft
end

function PlayerTraceHuntData:GetHuntLeftTime()
  if self.nBossCreateTime == 0 then
    return 0
  end
  if self.nHuntProgress >= self.nMaxHuntProgress then
    return 0
  end
  local nLeft = self.nBossCreateTime + self.nBossHuntLimitTime - ClientManager.serverTimeStamp
  if nLeft < 0 then
    nLeft = 0
  end
  return nLeft
end

function PlayerTraceHuntData:GetBossCreateTime()
  return self.nBossCreateTime
end

function PlayerTraceHuntData:ClearCurBoss()
  self.nBossId = 0
  self.nTraceProgress = 0
  self.nHuntProgress = 0
  self.nBossCreateTime = 0
  self.nSelfBossHuntCount = 0
  self.tbTraceLog = {}
  self.tbHuntLog = {}
end

function PlayerTraceHuntData:GetTraceHuntLevel()
  return self.nLevel, self.nExp
end

function PlayerTraceHuntData:GetTraceHuntLevelData(nLevel)
  return self.tbTraceHuntLevel[nLevel]
end

function PlayerTraceHuntData:GetTraceHuntMaxLevel()
  return self.nMaxTraceHuntLevel
end

function PlayerTraceHuntData:GetHardOpenLevel()
  return self.nHardOpenLevel
end

function PlayerTraceHuntData:GetLevelDisplayEffects(nLevel)
  local tbEffect = {}
  local mapLevel = self:GetTraceHuntLevelData(nLevel)
  if mapLevel == nil then
    return tbEffect
  end
  if mapLevel.DisplayMaxStar > 0 then
    table.insert(tbEffect, {
      sText = orderedFormat(ConfigTable.GetUIText("TraceHunt_LevelEffect_MaxStar"), mapLevel.DisplayMaxStar),
      bIcon1 = false
    })
  end
  if 0 < mapLevel.DisplayTokenRate then
    local sTitle = ConfigTable.GetData_Item(AllEnum.CoinItemId.TraceHunt).Title
    table.insert(tbEffect, {
      sText = orderedFormat(ConfigTable.GetUIText("TraceHunt_LevelEffect_TokenRate"), sTitle, mapLevel.DisplayTokenRate),
      bIcon1 = false
    })
  end
  if 0 < mapLevel.DisplayFreeRate then
    local sTitle = ConfigTable.GetData_Item(self.nTraceRequestTid).Title
    table.insert(tbEffect, {
      sText = orderedFormat(ConfigTable.GetUIText("TraceHunt_LevelEffect_FreeRate"), sTitle, mapLevel.DisplayFreeRate),
      bIcon1 = false
    })
  end
  if 0 < mapLevel.DisplayAddRate then
    table.insert(tbEffect, {
      sText = orderedFormat(ConfigTable.GetUIText("TraceHunt_LevelEffect_AddRate"), mapLevel.DisplayAddRate),
      bIcon1 = true
    })
  end
  if 0 < mapLevel.DisplayLuckyRate then
    table.insert(tbEffect, {
      sText = orderedFormat(ConfigTable.GetUIText("TraceHunt_LevelEffect_LuckyRate"), mapLevel.DisplayLuckyRate),
      bIcon1 = true
    })
  end
  if self.nHardOpenLevel == nLevel and not self:GetControlBlockState() then
    table.insert(tbEffect, {
      sText = ConfigTable.GetUIText("TraceHunt_LevelEffect_Hard"),
      bIcon1 = true
    })
  end
  if self.nNoneRewardHelpOpenLevel == nLevel and not self:GetControlBlockState() then
    table.insert(tbEffect, {
      sText = ConfigTable.GetUIText("TraceHunt_LevelEffect_NoneRewardHelp"),
      bIcon1 = true
    })
  end
  return tbEffect
end

function PlayerTraceHuntData:GetBossId()
  return self.nBossId
end

function PlayerTraceHuntData:CheckMaxTrace()
  return self.nTraceProgress >= self.nMaxTraceProgress
end

function PlayerTraceHuntData:GetMaxStar()
  return self.nMaxStar
end

function PlayerTraceHuntData:GetTraceProgress()
  return self.nTraceProgress / self.nMaxTraceProgress * 100
end

function PlayerTraceHuntData:GetHuntProgress()
  return self.nHuntProgress / self.nMaxHuntProgress * 100
end

function PlayerTraceHuntData:GetHuntRecommend()
  return self.tbRecommend
end

function PlayerTraceHuntData:GetSelfHuntCount()
  return self.nSelfBossHuntCount
end

function PlayerTraceHuntData:GetStarScore(nStar)
  local mapData = self.tbTraceHuntStar[nStar]
  if not mapData then
    return 0
  end
  local nHard = self:GetDifficultyBySource(self.bSelfBoss)
  return mapData[nHard]
end

function PlayerTraceHuntData:GetBossTimeLimit()
  local nDifficulty = self:GetDifficultyBySource(self.bSelfBoss)
  if 1 < nDifficulty then
    return ConfigTable.GetConfigNumber("TraceHuntHardBossTimeLimit")
  else
    return ConfigTable.GetConfigNumber("TraceHuntBossTimeLimit")
  end
end

function PlayerTraceHuntData:GetHuntCostCount(bSelf)
  if self.nControlId == 0 then
    return 0
  end
  local mapCfg = ConfigTable.GetData("TraceHuntControl", self.nControlId)
  if not mapCfg then
    return 0
  end
  if bSelf then
    local nNext = self.nSelfBossHuntCount
    local nMax = #self.tbHuntExtraCost
    if nNext >= nMax then
      nNext = nMax
    end
    if nNext == 0 then
      return mapCfg.SelfHuntCost1Qty
    else
      return mapCfg.SelfHuntCost1Qty + self.tbHuntExtraCost[nNext].Qty
    end
  else
    return mapCfg.OtherHuntCost1Qty
  end
end

function PlayerTraceHuntData:GetTraceCostCount()
  if self.nControlId == 0 then
    return 0
  end
  local mapCfg = ConfigTable.GetData("TraceHuntControl", self.nControlId)
  if not mapCfg then
    return 0
  end
  return mapCfg.TraceCost1Qty
end

function PlayerTraceHuntData:GetHuntRewardRange(bSelf)
  if self.nControlId == 0 then
    return 0, 0
  end
  local mapCfg = ConfigTable.GetData("TraceHuntControl", self.nControlId)
  if not mapCfg then
    return 0, 0
  end
  local nDifficulty = self:GetDifficultyBySource(bSelf)
  local mapDifficulty = ConfigTable.GetData("TraceHuntDifficulty", nDifficulty)
  if not mapDifficulty then
    return 0, 0
  end
  local nLevelRate = self:GetLevelTokenRate()
  local nHardRate = mapDifficulty.TokenRate
  local nAddRate = 100 + nLevelRate + nHardRate
  local tbCount = mapCfg.StarDropCount
  local nMin = tbCount[1]
  local nMax = 0
  for nStar, v in ipairs(tbCount) do
    if nStar <= self.nMaxStar then
      nMax = v
    end
  end
  nMin = math.floor(nMin * nAddRate / 100)
  nMax = math.floor(nMax * nAddRate / 100)
  return nMin, nMax
end

function PlayerTraceHuntData:GetHuntTokenCount()
  return self.mapHuntPermit.nConvertedCount + self.mapHuntPermit.nGrantedCount
end

function PlayerTraceHuntData:GetTraceTokenCount()
  return self.mapTraceRequest.nConvertedCount + self.mapTraceRequest.nGrantedCount
end

function PlayerTraceHuntData:GetHuntTokenDailyCount()
  return self.mapHuntPermit.nDailyCount
end

function PlayerTraceHuntData:GetTraceTokenDailyCount()
  return self.mapTraceRequest.nDailyCount
end

function PlayerTraceHuntData:AddTraceLog(tbLog, bAdd)
  if next(tbLog) == nil then
    return
  end
  if next(self.tbTraceLog) == nil then
    table.insert(self.tbTraceLog, {
      nId = self.mapLogTemplate[GameEnum.TraceHuntLogType.TraceStart],
      tbArgs = {},
      nType = GameEnum.TraceHuntLogType.TraceStart
    })
  end
  for _, v in ipairs(tbLog) do
    local mapCfg = ConfigTable.GetData("TraceHuntLogEntryTemplate", v.Tid)
    if mapCfg then
      table.insert(self.tbTraceLog, {
        nId = v.Tid,
        tbArgs = v.args,
        nType = mapCfg.Type
      })
      if mapCfg.Type == GameEnum.TraceHuntLogType.TraceBeforeEnd then
        table.insert(self.tbTraceLog, {
          nId = self.mapLogTemplate[GameEnum.TraceHuntLogType.TraceEnd],
          tbArgs = {},
          nType = GameEnum.TraceHuntLogType.TraceEnd
        })
      elseif mapCfg.Type == GameEnum.TraceHuntLogType.TraceInterrupt then
        table.insert(self.tbTraceLog, {
          nId = self.mapLogTemplate[GameEnum.TraceHuntLogType.TraceRestart],
          tbArgs = {},
          nType = GameEnum.TraceHuntLogType.TraceRestart
        })
      end
    end
    if bAdd and mapCfg and mapCfg.Type == GameEnum.TraceHuntLogType.Tracing then
      self.nTraceProgress = self.nTraceProgress + tonumber(v.args[1])
      if self.nTraceProgress >= self.nMaxTraceProgress then
        self.nTraceProgress = self.nMaxTraceProgress
      end
    end
  end
end

function PlayerTraceHuntData:GetTraceLog()
  return clone(self.tbTraceLog)
end

function PlayerTraceHuntData:AddHuntLog(tbLog, bAdd)
  if next(tbLog) == nil then
    return
  end
  if next(self.tbHuntLog) == nil then
    table.insert(self.tbHuntLog, {
      nId = self.mapLogTemplate[GameEnum.TraceHuntLogType.HuntBeforeStart],
      tbArgs = {},
      nType = GameEnum.TraceHuntLogType.HuntBeforeStart
    })
    table.insert(self.tbHuntLog, {
      nId = self.mapLogTemplate[GameEnum.TraceHuntLogType.HuntStart],
      tbArgs = {},
      nType = GameEnum.TraceHuntLogType.HuntStart
    })
  end
  for _, v in ipairs(tbLog) do
    local mapCfg = ConfigTable.GetData("TraceHuntLogEntryTemplate", v.Tid)
    if mapCfg then
      table.insert(self.tbHuntLog, {
        nId = v.Tid,
        tbArgs = v.args,
        nType = mapCfg.Type
      })
      if mapCfg.Type == GameEnum.TraceHuntLogType.HuntPlayerFatal or mapCfg.Type == GameEnum.TraceHuntLogType.HuntNPCFatal then
        table.insert(self.tbHuntLog, {
          nId = self.mapLogTemplate[GameEnum.TraceHuntLogType.HuntEnd],
          tbArgs = {},
          nType = GameEnum.TraceHuntLogType.HuntEnd
        })
      end
    end
    if bAdd and mapCfg and (mapCfg.Type == GameEnum.TraceHuntLogType.HuntPlayer or mapCfg.Type == GameEnum.TraceHuntLogType.HuntNPC) then
      local nIndex = 1
      if mapCfg.Type == GameEnum.TraceHuntLogType.HuntPlayer then
        nIndex = 2
      elseif mapCfg.Type == GameEnum.TraceHuntLogType.HuntNPC then
        nIndex = 1
      end
      self.nHuntProgress = self.nHuntProgress + tonumber(v.args[nIndex])
      if self.nHuntProgress >= self.nMaxHuntProgress then
        self.nHuntProgress = self.nMaxHuntProgress
      end
    end
  end
  if self:CheckHuntInterrupt() then
    self:AddHuntLog_HuntInterrupt()
  end
end

function PlayerTraceHuntData:AddHuntLog_HuntInterrupt()
  local bHas = false
  for _, v in ipairs(self.tbHuntLog) do
    if v.nType == GameEnum.TraceHuntLogType.HuntInterrupt then
      bHas = true
      break
    end
  end
  if bHas then
    return
  end
  table.insert(self.tbHuntLog, {
    nId = self.mapLogTemplate[GameEnum.TraceHuntLogType.HuntInterrupt],
    tbArgs = {},
    nType = GameEnum.TraceHuntLogType.HuntInterrupt
  })
  table.insert(self.tbHuntLog, {
    nId = self.mapLogTemplate[GameEnum.TraceHuntLogType.HuntEnd],
    tbArgs = {},
    nType = GameEnum.TraceHuntLogType.HuntEnd
  })
end

function PlayerTraceHuntData:AddHuntLog_Settlement(nExp)
  table.insert(self.tbHuntLog, {
    nId = self.mapLogTemplate[GameEnum.TraceHuntLogType.Settlement],
    tbArgs = {nExp},
    nType = GameEnum.TraceHuntLogType.Settlement
  })
end

function PlayerTraceHuntData:CheckHuntInterrupt()
  return self.nHuntProgress < self.nMaxHuntProgress and self.nBossCreateTime ~= 0 and 0 >= self:GetHuntLeftTime()
end

function PlayerTraceHuntData:CheckHuntComplete()
  return self.nHuntProgress >= self.nMaxHuntProgress
end

function PlayerTraceHuntData:GetHuntLog()
  return clone(self.tbHuntLog)
end

function PlayerTraceHuntData:GetBossCollection()
  return self.tbBossCollection, self.tbBossList or {}
end

function PlayerTraceHuntData:GetLevelTokenRate()
  local nRate = 0
  for i = 1, self.nLevel do
    nRate = nRate + self.tbTraceHuntLevel[i].DisplayTokenRate
  end
  return nRate
end

function PlayerTraceHuntData:GetStarDropCount(nDifficulty)
  local mapDifficulty = ConfigTable.GetData("TraceHuntDifficulty", nDifficulty)
  if not mapDifficulty then
    return {}
  end
  local nLevelRate = self:GetLevelTokenRate()
  local nHardRate = mapDifficulty.TokenRate
  local nAddRate = 100 + nLevelRate + nHardRate
  local tbCount = {}
  for nStar, v in ipairs(self.tbStarDropCount) do
    tbCount[nStar] = math.floor(v * nAddRate / 100)
  end
  return tbCount
end

function PlayerTraceHuntData:SetControlTimer()
  if self.timerControl ~= nil then
    self.timerControl:Cancel(false)
    self.timerControl = nil
  end
  local nLeft = self:GetControlLeftTime()
  if 0 < nLeft then
    self.timerControl = TimerManager.Add(1, nLeft, self, function()
      local function callback()
        EventManager.Hit("TraceHuntNewControl")
      end
      
      self:SendTraceHuntInfoReq(callback)
    end, true, true, false)
  end
end

function PlayerTraceHuntData:SetHuntTimer()
  if self.timerHunt ~= nil then
    self.timerHunt:Cancel(false)
    self.timerHunt = nil
  end
  local nLeft = self:GetHuntLeftTime()
  if 0 < nLeft then
    self.timerHunt = TimerManager.Add(1, nLeft, self, function()
      if self:CheckHuntInterrupt() then
        self:AddHuntLog_HuntInterrupt()
        EventManager.Hit("TraceHuntCurBossExpired")
      end
    end, true, true, false)
  end
end

function PlayerTraceHuntData:SetHelpTimer()
  if self.timerHelp ~= nil then
    self.timerHelp:Cancel(false)
    self.timerHelp = nil
  end
  self.timerHelp = TimerManager.Add(1, self.nRefreshHelpCD, self, function()
    self.bRefreshHelpCD = false
  end, true, true, false)
end

function PlayerTraceHuntData:SendTraceHuntInfoReq(callback)
  local function successCallback(_, mapMainData)
    self:CacheTraceHuntInfo(mapMainData)
    
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.trace_hunt_info_req, {}, nil, successCallback)
end

function PlayerTraceHuntData:SendTraceHuntApplyReq(nOwnerUID, nBossID, nBuildId, nBossCreateTime, mapFriend)
  local bSelfBoss = PlayerData.Base._nPlayerId == nOwnerUID
  local nDifficulty = self:GetDifficultyBySource(bSelfBoss)
  local mapBoss = ConfigTable.GetData("TraceHuntBoss", nBossID)
  local nFloorId = self.tbTraceHuntFloor[mapBoss.FloorGroup][nDifficulty].Id
  local mapBuildData = PlayerData.Build:GetBuildData(nBuildId)
  local bTrial = mapBuildData.nBuildSource == AllEnum.BuildSource.Trial or mapBuildData.nBuildSource == AllEnum.BuildSource.LimitedTrial
  local nBuildType = bTrial and 2 or 1
  local msgData = {
    OwnerUID = nOwnerUID,
    BossID = nBossID,
    Build = {Type = nBuildType, BuildId = nBuildId},
    BossCreateTime = nBossCreateTime,
    Difficulty = nDifficulty
  }
  
  local function successCallback(_, mapMainData)
    self.CurHPLvScore = 0
    self.HPLvScore = 0
    self.CurHPDamage = 0
    self.bSelfBoss = bSelfBoss
    self:EnterTraceHunt(nBossID, nBuildId, nFloorId)
    PlayerData.Friend:CacheFriendAddStranger(mapFriend)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.trace_hunt_apply_req, msgData, nil, successCallback)
end

function PlayerTraceHuntData:SendTraceHuntSettleReq(nBossId, callback)
  local nStar = self:ScoreToStar()
  local nScore = self:GetTotalScore()
  local msgData = {
    Score = nScore,
    Star = nStar,
    Events = {
      List = PlayerData.Achievement:GetBattleAchievement(GameEnum.levelType.TraceHunt, true)
    }
  }
  CS.AdventureModuleHelper.PauseLogic()
  
  local function successCallback(_, mapMainData)
    local nExp = 0
    local bUpgrade = false
    local nBeforeMaxStar = self:GetMaxStar()
    if 1 <= nStar then
      nExp = self:GetAddExp(self.nLevel, self.nExp, mapMainData.Level, mapMainData.Exp)
      bUpgrade = mapMainData.Level > self.nLevel
      self:UpdateLevel(mapMainData.Level, mapMainData.Exp)
      if self.bSelfBoss then
        self.tbHuntLog = {}
        self.nHuntProgress = 0
        self:AddHuntLog(mapMainData.HuntLog, true)
        self.nSelfBossHuntCount = mapMainData.SelfHuntTimes
        if mapMainData.BossCreateTime ~= 0 then
          self.nBossCreateTime = mapMainData.BossCreateTime
          self:SetHuntTimer()
        end
        local bComplete = self:CheckHuntComplete()
        local bInterrupt = self:CheckHuntInterrupt()
        self:UpdateBossRewardRedDot(bComplete or bInterrupt)
      else
        self:UpdateBossCollection(nBossId, 0, 1)
        self.bRefreshHelpCD = false
      end
    end
    CS.AdventureModuleHelper.ResumeLogic()
    EventManager.Hit("TraceHuntSettleSuccess", self.entryLevelId, nStar, nExp, self.bSelfBoss, mapMainData.ChangeInfo or {}, bUpgrade, nBeforeMaxStar)
    self:LevelEnd()
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.trace_hunt_settle_req, msgData, nil, successCallback)
end

function PlayerTraceHuntData:ReceiveTraceHuntSettleFailed()
  local nStar = 0
  local nExp = 0
  local bUpgrade = false
  local nBeforeMaxStar = self:GetMaxStar()
  CS.AdventureModuleHelper.ResumeLogic()
  EventManager.Hit("TraceHuntSettleSuccess", self.entryLevelId, nStar, nExp, self.bSelfBoss, {}, bUpgrade, nBeforeMaxStar)
  self:LevelEnd()
end

function PlayerTraceHuntData:SendTraceHuntRecommendReq(callback)
  if self.bRefreshHelpCD then
    if callback then
      callback()
    end
    return
  end
  
  local function successCallback(_, mapMainData)
    self.bRefreshHelpCD = true
    self:SetHelpTimer()
    self.tbRecommend = {}
    for _, v in ipairs(mapMainData.Recommendations) do
      local mapData = {
        nUID = v.OwnerUID,
        nBossId = v.BossID,
        nBossCreateTime = v.BossCreateTime,
        bFriend = v.IsFriend,
        bStar = v.IsStar,
        mapFriend = {}
      }
      PlayerData.Friend:ParseFriendData(mapData.mapFriend, v.Info)
      table.insert(self.tbRecommend, mapData)
      table.sort(self.tbRecommend, function(a, b)
        if a.bStar ~= b.bStar then
          return a.bStar and not b.bStar
        elseif a.bFriend ~= b.bFriend then
          return a.bFriend and not b.bFriend
        else
          return a.nBossCreateTime < b.nBossCreateTime
        end
      end)
    end
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.trace_hunt_recommend_req, {}, nil, successCallback)
end

function PlayerTraceHuntData:SendTraceHuntRewardReceiveReq(callback)
  if self.nBossId == 0 then
    return
  end
  local bComplete = PlayerData.TraceHunt:CheckHuntComplete()
  local bInterrupt = PlayerData.TraceHunt:CheckHuntInterrupt()
  if not bComplete and not bInterrupt then
    return
  end
  
  local function successCallback(_, mapMainData)
    local mapBeforeLevel = {
      nLevel = self.nLevel,
      nExp = self.nExp,
      nMaxLevel = self.nMaxTraceHuntLevel,
      nMaxExp = self.tbTraceHuntLevel[self.nLevel].Exp
    }
    local mapAfterLevel = {
      nLevel = mapMainData.Level,
      nExp = mapMainData.Exp,
      nMaxLevel = self.nMaxTraceHuntLevel,
      nMaxExp = self.tbTraceHuntLevel[mapMainData.Level].Exp
    }
    self:UpdateBossRewardRedDot(false)
    self:UpdateBossCollection(self.nBossId, 1, 0)
    local nExp = self:GetAddExp(self.nLevel, self.nExp, mapMainData.Level, mapMainData.Exp)
    self:UpdateLevel(mapMainData.Level, mapMainData.Exp)
    self:AddHuntLog_Settlement(nExp)
    if callback then
      callback(mapBeforeLevel, mapAfterLevel, mapMainData.ChangeInfo)
    end
    self:ClearCurBoss()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.trace_hunt_boss_reward_receive_req, {}, nil, successCallback)
end

function PlayerTraceHuntData:SendTraceHuntTraceReq(nCount, callback)
  local msgData = {Value = nCount}
  
  local function successCallback(_, mapMainData)
    self:AddTraceLog(mapMainData.TraceLog, true)
    if mapMainData.BossID ~= 0 then
      self.nBossId = mapMainData.BossID
    end
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.trace_hunt_trace_req, msgData, nil, successCallback)
end

function PlayerTraceHuntData:UpdateBossRewardRedDot(bAble)
  RedDotManager.SetValid(RedDotDefine.TraceHunt_Reward_Boss, nil, bAble)
  self:UpdateItemEntranceRedDot()
end

function PlayerTraceHuntData:UpdateItemRedDot()
  self:UpdateHuntItemRedDot()
  self:UpdateTraceItemRedDot()
  self:UpdateItemEntranceRedDot()
end

function PlayerTraceHuntData:UpdateHuntItemRedDot()
  local tbMax = ConfigTable.GetConfigNumberArray("TraceHuntPermitItem")
  local nHasCoin = self:GetHuntTokenCount()
  local bAble = nHasCoin >= tbMax[3]
  RedDotManager.SetValid(RedDotDefine.TraceHunt_HuntItem, nil, bAble)
end

function PlayerTraceHuntData:UpdateTraceItemRedDot()
  local tbMax = ConfigTable.GetConfigNumberArray("TraceHuntRequestItem")
  local nHasCoin = self:GetTraceTokenCount()
  local bAble = nHasCoin >= tbMax[3]
  RedDotManager.SetValid(RedDotDefine.TraceHunt_TraceItem, nil, bAble)
end

function PlayerTraceHuntData:UpdateItemEntranceRedDot()
  local bTraceMax = RedDotManager.GetValid(RedDotDefine.TraceHunt_TraceItem)
  RedDotManager.SetValid(RedDotDefine.TraceHunt_Item, nil, bTraceMax)
end

function PlayerTraceHuntData:EnterTraceHunt(nLevelId, nBuildId, nFloorId)
  self.entryLevelId = nLevelId
  self.entryBuild = nBuildId
  self.entryFloorId = nFloorId
  if self.curLevel == nil then
    local luaClass = require("Game.Adventure.TraceHunt.TraceHuntLevel")
    if luaClass == nil then
      return
    end
    self.curLevel = luaClass
  end
  if type(self.curLevel.BindEvent) == "function" and not self.isGoAgain then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    self.curLevel:Init(self, nLevelId, nBuildId, nFloorId, self.isGoAgain)
  end
  self.isGoAgain = false
end

function PlayerTraceHuntData:LevelEnd()
  if nil ~= self.curLevel and type(self.curLevel.UnBindEvent) == "function" then
    self.curLevel:UnBindEvent()
  end
  self.curLevel = nil
end

function PlayerTraceHuntData:SetSelBuildId(nBuildId)
  self.nCachedBuildId = nBuildId
end

function PlayerTraceHuntData:GetCachedBuild()
  return self.nCachedBuildId or 0
end

function PlayerTraceHuntData:DamageToScore(damageValue, SwitchRate, battleLv)
  self.CurHPDamage = damageValue
  self.CurHPLvScore = math.floor(damageValue / SwitchRate)
  EventManager.Hit("TraceHunt_Score_Change")
  self:CheckMaxStar()
end

function PlayerTraceHuntData:HPLevelChanged()
  self.HPLvScore = self.HPLvScore + self.CurHPLvScore
  self.CurHPLvScore = 0
  self.CurHPDamage = 0
  EventManager.Hit("TraceHunt_Score_Change")
  self:CheckMaxStar()
end

function PlayerTraceHuntData:CheckMaxStar()
  local nStar = self:ScoreToStar()
  if nStar >= self.nMaxStar then
    NovaAPI.DispatchEventWithData("TraceHunt_MaxStar")
    EventManager.Hit("TraceHunt_MaxStar")
  end
end

function PlayerTraceHuntData:GetTotalScore()
  local totalScore = self.HPLvScore + self.CurHPLvScore
  return totalScore
end

function PlayerTraceHuntData:ScoreToStar()
  local nDifficulty = self:GetDifficultyBySource(self.bSelfBoss)
  local tmpStar = 0
  local totalScore = self.HPLvScore + self.CurHPLvScore
  for i, v in pairs(self.tbTraceHuntStar) do
    if totalScore >= v[nDifficulty] and i > tmpStar then
      tmpStar = i
    end
  end
  if tmpStar >= self.nMaxStar then
    tmpStar = self.nMaxStar
  end
  return tmpStar
end

function PlayerTraceHuntData:QuiteLevel()
  self:LevelEnd()
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    CS.WwiseAudioManager.Instance:PostEvent("ui_loading_combatSFX_mute", nil, false)
  end
  
  cs_coroutine.start(wait)
  CS.AdventureModuleHelper.ResumeLogic()
  
  local function levelEndCallback()
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
    NovaAPI.EnterModule("MainMenuModuleScene", true)
  end
  
  EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
  CS.AdventureModuleHelper.LevelStateChanged(true, 0, true)
end

function PlayerTraceHuntData:SendEnterLvAgain()
  if self.curLevel ~= nil then
    self.curLevel.isCanPause = false
  end
  self.isGoAgain = true
  CS.AdventureModuleHelper.LevelStateChanged(false)
  EventManager.Hit("BattleRestart")
end

function PlayerTraceHuntData:EntryLvAgain()
  if self.isGoAgain then
    CS.AdventureModuleHelper.ClearCharacterDamageRecord(false)
    self.CurHPLvScore = 0
    self.HPLvScore = 0
    self.CurHPDamage = 0
    EventManager.Hit("TraceHunt_Restart_Again")
    self:EnterTraceHunt(self.entryLevelId, self.entryBuild, self.entryFloorId)
  end
end

return PlayerTraceHuntData
