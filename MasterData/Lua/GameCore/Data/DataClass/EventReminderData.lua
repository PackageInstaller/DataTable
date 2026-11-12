local EventReminderData = class("EventReminderData")

function EventReminderData:ctor()
end

function EventReminderData:Init()
  self.nAddStarTowerTicket = 0
  self:InitData()
  self:AddListeners()
end

function EventReminderData:InitData()
  self.tbEventReminderData = {}
  
  local function foreachTable(data)
    self.tbEventReminderData[data.ModuleType] = {
      nId = data.Id,
      nType = data.ModuleType,
      bFinish = false,
      bUnlock = false,
      tbProgressData = nil,
      tbCusParam = nil
    }
  end
  
  ForEachTableLine(DataTable.EventReminder, foreachTable)
end

function EventReminderData:UpdateAllData()
  self:UpdateWeeklyCopies()
  self:UpdateVampire()
  self:UpdateScoreBoss()
  self:UpdateStarTower()
  self:UpdateTraceHunt()
  self:RefreshRedDot()
end

function EventReminderData:CacheAddStarTowerTicket(nTowerTicket)
  self.nAddStarTowerTicket = nTowerTicket
end

function EventReminderData:AddListeners()
  EventManager.Add(EventId.IsNewDay, self, self.OnEvent_NewDay)
  EventManager.Add(EventId.EventReminder_Update, self, self.OnEvent_EventReminder_Update)
  EventManager.Add(EventId.CoinResChange, self, self.OnEvent_CoinResChange)
  EventManager.Add(EventId.OpenPanel, self, self.OnEvent_OpenPanel)
  EventManager.Add(EventId.UpdateWorldClass, self, self.OnEvent_UpdateWorldClass)
end

function EventReminderData:RemoveListeners()
end

function EventReminderData:GetMinRemainTime()
  return self.nMinRemainTime
end

function EventReminderData:GetEventReminderDataList()
  local tbTempEventReminderDataList = {}
  local tbEventReminderDataList = {}
  local tbFinishList = {}
  for _, v in pairs(self.tbEventReminderData) do
    if v.bFinish then
      table.insert(tbFinishList, v)
    else
      local nSort = 1
      local nEndTime = PlayerData.EventReminder:GetEndTime(v.nType)
      local nRemainTime = nEndTime - CS.ClientManager.Instance.serverTimeStamp
      if 0 < nRemainTime then
        local cfg = ConfigTable.GetData("EventReminder", v.nId)
        if cfg ~= nil then
          if nRemainTime >= cfg.LimitDay2 * 86400 then
            nSort = 1
          elseif nRemainTime >= cfg.LimitDay * 86400 then
            nSort = 2
          else
            nSort = 3
          end
        end
      end
      table.insert(tbTempEventReminderDataList, {data = v, nSort = nSort})
    end
  end
  table.sort(tbTempEventReminderDataList, function(a, b)
    if a.nSort == b.nSort then
      return a.data.nId < b.data.nId
    end
    return a.nSort > b.nSort
  end)
  for _, v in ipairs(tbTempEventReminderDataList) do
    table.insert(tbEventReminderDataList, v.data)
  end
  table.sort(tbFinishList, function(a, b)
    return a.nId < b.nId
  end)
  return tbEventReminderDataList, tbFinishList
end

function EventReminderData:GetEventReminderLockTips(nType)
  local openFuncCfg
  if nType == GameEnum.EventReminderType.WeeklyCopies then
    openFuncCfg = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.WeeklyCopies)
  elseif nType == GameEnum.EventReminderType.Vampire then
    openFuncCfg = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.VampireSurvivor)
  elseif nType == GameEnum.EventReminderType.ScoreBoss then
    openFuncCfg = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.ScoreBoss)
  elseif nType == GameEnum.EventReminderType.StarTower then
    openFuncCfg = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.StarTower)
  elseif nType == GameEnum.EventReminderType.TraceHunt then
    openFuncCfg = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.TraceHunt)
  end
  if openFuncCfg == nil then
    return ""
  end
  return orderedFormat(openFuncCfg.Tips, "", openFuncCfg.NeedWorldClass)
end

function EventReminderData:JumpToOpenFunc(nType)
  if nType == GameEnum.EventReminderType.WeeklyCopies then
  elseif nType == GameEnum.EventReminderType.Vampire then
  elseif nType == GameEnum.EventReminderType.ScoreBoss then
  elseif nType == GameEnum.EventReminderType.StarTower then
  elseif nType == GameEnum.EventReminderType.TraceHunt then
  end
end

function EventReminderData:UpdateWeeklyCopies()
  local bPlayCond = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.WeeklyCopies, false)
  self.tbEventReminderData[GameEnum.EventReminderType.WeeklyCopies].bUnlock = bPlayCond
  if not bPlayCond then
    return
  end
  local nRemainTicket = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.RogueHardCoreTick)
  local nMaxTicket = ConfigTable.GetConfigNumber("RegionBossChallengeTicker")
  self.tbEventReminderData[GameEnum.EventReminderType.WeeklyCopies].bFinish = nRemainTicket <= 0
  local tbProgressData = {nCur = nRemainTicket, nMax = nMaxTicket}
  self.tbEventReminderData[GameEnum.EventReminderType.WeeklyCopies].tbProgressData = tbProgressData
end

function EventReminderData:UpdateVampire()
  local bPlayCond = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.VampireSurvivor, false)
  self.tbEventReminderData[GameEnum.EventReminderType.Vampire].bUnlock = bPlayCond
  if not bPlayCond then
    return
  end
  local nCurSeasonId, nLevelId = PlayerData.VampireSurvivor:GetCurSeason()
  local bSeasonUnlocked = nCurSeasonId ~= 0
  self.tbEventReminderData[GameEnum.EventReminderType.Vampire].tbCusParam = {}
  local tbCusParam = self.tbEventReminderData[GameEnum.EventReminderType.Vampire].tbCusParam
  tbCusParam.bSeasonUnlock = bSeasonUnlocked
  tbCusParam.nSeason = nCurSeasonId
  if not bSeasonUnlocked then
    self.tbEventReminderData[GameEnum.EventReminderType.Vampire].bFinish = true
    return
  end
  local tbHardUnlock = PlayerData.VampireSurvivor:GetHardUnlock()
  tbCusParam.bHardUnlock = tbHardUnlock[3]
  if tbHardUnlock[3] == false then
    return
  end
  local cur, total = PlayerData.VampireSurvivor:GetSeasonQuestCount(GameEnum.vampireSurvivorType.Turn)
  self.tbEventReminderData[GameEnum.EventReminderType.Vampire].bFinish = total <= cur
  local tbProgressData = {nCur = cur, nMax = total}
  self.tbEventReminderData[GameEnum.EventReminderType.Vampire].tbProgressData = tbProgressData
  tbCusParam.bHardUnlock = tbHardUnlock[3]
  tbCusParam.nSeason = nCurSeasonId
end

function EventReminderData:UpdateScoreBoss()
  local bPlayCond = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.ScoreBoss, false)
  self.tbEventReminderData[GameEnum.EventReminderType.ScoreBoss].bUnlock = bPlayCond
  if not bPlayCond then
    return
  end
  
  local function openScoreBossCallback()
    local tbCusParam = {}
    self.tbEventReminderData[GameEnum.EventReminderType.ScoreBoss].tbCusParam = tbCusParam
    if PlayerData.ScoreBoss.EndTime ~= 0 and PlayerData.ScoreBoss.EndTime > CS.ClientManager.Instance.serverTimeStamp and PlayerData.ScoreBoss.isGetScInfo then
      tbCusParam.bSettlement = false
    else
      tbCusParam.bSettlement = true
      self.tbEventReminderData[GameEnum.EventReminderType.ScoreBoss].bFinish = true
      return
    end
    local nSeasonId = PlayerData.ScoreBoss.ControlId
    if nSeasonId ~= 0 then
      local tbProgressData = {
        nCur = PlayerData.ScoreBoss.Star,
        nMax = PlayerData.ScoreBoss.maxStarNeed
      }
      self.tbEventReminderData[GameEnum.EventReminderType.ScoreBoss].bFinish = PlayerData.ScoreBoss.Star >= PlayerData.ScoreBoss.maxStarNeed
      self.tbEventReminderData[GameEnum.EventReminderType.ScoreBoss].tbProgressData = tbProgressData
      tbCusParam.nSeason = nSeasonId
    end
  end
  
  if not PlayerData.ScoreBoss:GetInitInfoState() then
    PlayerData.ScoreBoss:GetScoreBossInstanceData(openScoreBossCallback)
  else
    openScoreBossCallback()
  end
end

function EventReminderData:UpdateStarTower()
  local bPlayCond = true
  self.tbEventReminderData[GameEnum.EventReminderType.StarTower].bUnlock = bPlayCond
  if not bPlayCond then
    return
  end
  if not PlayerData.StarTower.nFirstGrowthGroup then
    local nWorldClass = PlayerData.Base:GetWorldClass()
    local worldClassCfg = ConfigTable.GetData("WorldClass", nWorldClass, true)
    if not worldClassCfg then
      return
    end
    local nLimit = worldClassCfg.RewardLimit + self.nAddStarTowerTicket
    local nCur = PlayerData.StarTower:GetStarTowerTicket()
    local tbProgressData = {nCur = nCur, nMax = nLimit}
    self.tbEventReminderData[GameEnum.EventReminderType.StarTower].bFinish = nLimit <= nCur
    self.tbEventReminderData[GameEnum.EventReminderType.StarTower].tbProgressData = tbProgressData
  else
    local nLimit = PlayerData.StarTower:GetStarTowerRewardLimit()
    local nCur = PlayerData.StarTower:GetStarTowerTicket()
    local tbProgressData = {nCur = nCur, nMax = nLimit}
    self.tbEventReminderData[GameEnum.EventReminderType.StarTower].bFinish = nLimit <= nCur
    self.tbEventReminderData[GameEnum.EventReminderType.StarTower].tbProgressData = tbProgressData
  end
end

function EventReminderData:UpdateTraceHunt()
  local bPlayCond = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.TraceHunt, false)
  self.tbEventReminderData[GameEnum.EventReminderType.TraceHunt].bUnlock = bPlayCond
  if not bPlayCond then
    return
  end
  local tbMax = ConfigTable.GetConfigArray("TraceHuntRequestItem")
  local nHasCoin = PlayerData.TraceHunt:GetTraceTokenCount()
  local tbProgressData = {
    nCur = nHasCoin,
    nMax = tbMax[3]
  }
  local bFinish = nHasCoin <= 10
  local nEndTime = self:GetTraceHuntEndTime()
  local nRemainTime = nEndTime - CS.ClientManager.Instance.serverTimeStamp
  if 0 < nRemainTime then
    local cfg = ConfigTable.GetData("EventReminder", self.tbEventReminderData[GameEnum.EventReminderType.TraceHunt].nId)
    if cfg ~= nil and nRemainTime <= cfg.LimitDay * 86400 and 0 < nHasCoin then
      bFinish = false
    end
  end
  self.tbEventReminderData[GameEnum.EventReminderType.TraceHunt].bFinish = bFinish
  self.tbEventReminderData[GameEnum.EventReminderType.TraceHunt].tbProgressData = tbProgressData
end

function EventReminderData:GetEndTime(nType)
  if nType == GameEnum.EventReminderType.WeeklyCopies then
    return self:GetWeeklyCopiesEndTime()
  end
  if nType == GameEnum.EventReminderType.Vampire then
    return self:GetVampireEndTime()
  end
  if nType == GameEnum.EventReminderType.ScoreBoss then
    return self:GetScoreBossEndTime()
  end
  if nType == GameEnum.EventReminderType.StarTower then
    return self:GetStarTowerEndTime()
  end
  if nType == GameEnum.EventReminderType.TraceHunt then
    return self:GetTraceHuntEndTime()
  end
  return 0
end

function EventReminderData:GetWeeklyCopiesEndTime()
  local bPlayCond = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.WeeklyCopies, false)
  if not bPlayCond then
    return 0
  end
  return GetNextWeekRefreshTime()
end

function EventReminderData:GetVampireEndTime()
  local bPlayCond = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.VampireSurvivor, false)
  if not bPlayCond then
    return 0
  end
  local nCurSeasonId, nLevelId = PlayerData.VampireSurvivor:GetCurSeason()
  local bSeasonUnlocked = nCurSeasonId ~= 0
  if not bSeasonUnlocked then
    return 0
  end
  local tbHardUnlock = PlayerData.VampireSurvivor:GetHardUnlock()
  if tbHardUnlock[3] == false then
    return 0
  end
  local nSeasonId = PlayerData.VampireSurvivor:GetCurSeason()
  if nSeasonId ~= 0 then
    local mapSeasonCfgData = ConfigTable.GetData("VampireRankSeason", nSeasonId)
    if mapSeasonCfgData ~= nil then
      local nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapSeasonCfgData.EndTime)
      if nEndTime > CS.ClientManager.Instance.serverTimeStamp then
        return nEndTime
      end
    end
  end
  return 0
end

function EventReminderData:GetScoreBossEndTime()
  local bPlayCond = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.ScoreBoss, false)
  if not bPlayCond then
    return 0
  end
  if PlayerData.ScoreBoss.EndTime ~= 0 and PlayerData.ScoreBoss.EndTime > CS.ClientManager.Instance.serverTimeStamp and PlayerData.ScoreBoss.isGetScInfo then
    return PlayerData.ScoreBoss.EndTime
  end
  return 0
end

function EventReminderData:GetStarTowerEndTime()
  return GetNextWeekRefreshTime()
end

function EventReminderData:GetTraceHuntEndTime()
  local bPlayCond = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.TraceHunt, false)
  if not bPlayCond then
    return 0
  end
  local nSeasonId = PlayerData.TraceHunt:GetCurControlId()
  if nSeasonId == 0 then
    local nCurTime = CS.ClientManager.Instance.serverTimeStamp
    local nTempEndTime = 0
    
    local function foreachTable(data)
      local nStartTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(data.StartTime)
      local nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(data.EndTime)
      if nStartTime <= nCurTime and nEndTime >= nCurTime then
        nTempEndTime = nEndTime
        return
      end
    end
    
    ForEachTableLine(DataTable.TraceHuntControl, foreachTable)
    return nTempEndTime
  end
  return PlayerData.TraceHunt:GetControlLeftTime() + CS.ClientManager.Instance.serverTimeStamp
end

function EventReminderData:RefreshRedDot()
  self.nMinRemainTime = nil
  for _, v in pairs(self.tbEventReminderData) do
    if v.bUnlock and not v.bFinish then
      local cfgData = ConfigTable.GetData("EventReminder", v.nId)
      if cfgData ~= nil then
        local nEndTime = self:GetEndTime(v.nType)
        local nCurTime = CS.ClientManager.Instance.serverTimeStamp
        local nRemainTime = nEndTime - nCurTime
        if 0 < nRemainTime and nRemainTime <= cfgData.LimitDay * 86400 then
          if self.nMinRemainTime == nil then
            self.nMinRemainTime = nRemainTime
          else
            self.nMinRemainTime = math.min(self.nMinRemainTime, nRemainTime)
          end
        end
      end
    end
  end
  if self.nMinRemainTime ~= nil then
    RedDotManager.SetValid(RedDotDefine.EventReminder, {}, true)
  else
    RedDotManager.SetValid(RedDotDefine.EventReminder, {}, false)
  end
end

function EventReminderData:OnEvent_NewDay()
  self:InitData()
  self:UpdateAllData()
end

function EventReminderData:OnEvent_EventReminder_Update(nType)
  if nType == GameEnum.EventReminderType.WeeklyCopies then
    self:UpdateWeeklyCopies()
  elseif nType == GameEnum.EventReminderType.Vampire then
    self:UpdateVampire()
  elseif nType == GameEnum.EventReminderType.ScoreBoss then
    self:UpdateScoreBoss()
  elseif nType == GameEnum.EventReminderType.StarTower then
    self:UpdateStarTower()
  elseif nType == GameEnum.EventReminderType.TraceHunt then
    self:UpdateTraceHunt()
  else
    return
  end
  self:RefreshRedDot()
end

function EventReminderData:OnEvent_CoinResChange(nTid, nQty)
  if nTid == AllEnum.CoinItemId.RogueHardCoreTick then
    self:UpdateWeeklyCopies()
  end
  if nTid == AllEnum.CoinItemId.FRRewardCurrency then
    self:UpdateStarTower()
  end
end

function EventReminderData:OnEvent_OpenPanel(nPanelId)
  if nPanelId == PanelId.MainView then
    self:UpdateAllData()
  end
end

function EventReminderData:OnEvent_UpdateWorldClass()
  self:UpdateAllData()
end

return EventReminderData
