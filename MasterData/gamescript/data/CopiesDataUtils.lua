local tableInsert = table.insert
local tableSort = table.sort
local CopiesDataUtils = {}

function CopiesDataUtils.ResetAll()
  DataCenter.copiesData.BarrierId = 0
  DataCenter.copiesData.GiveUpGold = false
  DataCenter.copiesData.alreadyCostEnergy = 0
  DataCenter.copiesData.ClearFog = 0
  DataCenter.copiesData.BornKeyId = 0
end

function CopiesDataUtils.GetGiveUpGold()
  return DataCenter.copiesData.GiveUpGold
end

function CopiesDataUtils.SetGiveUpGold(bool)
  DataCenter.copiesData.GiveUpGold = bool
end

function CopiesDataUtils.GetPrizeShowQueue()
  return DataCenter.copiesData.prizeShowQueue
end

function CopiesDataUtils.AddToShowQueue(configId, desc)
  tableInsert(DataCenter.copiesData.prizeShowQueue, {configId = configId, desc = desc})
end

function CopiesDataUtils.ClearPrizeShowQueue()
  DataCenter.copiesData.prizeShowQueue = {}
end

function CopiesDataUtils.AddAlreadyCostEnergy(num, isOverride)
  if isOverride then
    DataCenter.copiesData.alreadyCostEnergy = num
    return
  end
  DataCenter.copiesData.alreadyCostEnergy = DataCenter.copiesData.alreadyCostEnergy + num
end

function CopiesDataUtils.GetFailCostEnergy()
  local plotCfg = DT.PlotConfig[DataCenter.copiesData.storyLineTid]
  if not plotCfg then
    return 0
  end
  local costEnergy = plotCfg.EnergyCost
  local failEnergyRecover = plotCfg.FailEnergyRecover
  costEnergy = costEnergy - failEnergyRecover
  return costEnergy
end

function CopiesDataUtils.OnRespawn(data)
  DataCenter.copiesData.respawnedNum = data.respawnedNum
  DataCenter.copiesData.lives = data.lives
  if data.isRespawn then
    local barrierExlorePanel = UIManager.Instance:GetWindow(Urls.BarrierExplorePanel)
    if barrierExlorePanel then
      barrierExlorePanel:OnRespawn(data.isRespawn)
    end
  end
end

function CopiesDataUtils.SetSettleDataByProto(data)
  local settleData = DataCenter.copiesData.copiesSettleData
  if not settleData then
    settleData = {}
    DataCenter.copiesData.copiesSettleData = settleData
  end
  if not data.worldTid then
    return
  end
  settleData.basePrize = CopiesDataUtils.ConvertPrizeArr(data.basePrize)
  settleData.finishLayer = data.finishLayer
  settleData.isFinish = data.isFinish
  settleData.lastLevel = data.level
  settleData.lastExp = data.exp
  settleData.upLevel = DataCenter.playerData.DRole.level > data.level and 1 or 0
  settleData.retEnergy = data.retEnergy
  settleData.finishCourse = {}
  settleData.star = data.star
  settleData.worldType = data.worldType
  settleData.worldTid = data.worldTid
  settleData.isFirstPass = data.isFirstPass
  settleData.expPrize = data.expPrize or 0
  settleData.awakerExpPrize = data.awakerExpPrize
  settleData.awakerFavorFixPer = data.awakerFavorFixPer
  settleData.myAwakers = data.myAwakers
  settleData.achivement = data.achivement
  settleData.finishAchivement = data.finishAchivement
  settleData.teamIdx = data.teamIdx
  settleData.teamType = data.teamType
  settleData.favorScore = data.favorScore
  if data.plot then
    DataCenter.copiesData.storyLineTid = data.plot
    local config = DT.PlotConfig[data.plot]
    DataCenter.copiesData.CopiesId = config.CopyID
  end
  if data.star and data.worldType == CommonDefine.SvrserWorldType.Copies then
    DBGMainCopyDataUtils.UpdateDBGStoryLineData({
      tid = DataCenter.copiesData.storyLineTid,
      star = data.star
    })
  end
  settleData.battleDamageStatsSum = data.battleDamageStatsSum
  settleData.addLike = data.addLike
  settleData.defaultCardLevelUp = data.defaultCardLevelUp
  if data.unlockPlot and data.unlockPlot > 0 then
    local config = DT.PlotConfig[data.unlockPlot]
    DBGMainCopyDataUtils.UpdateDBGStoryLineData({
      tid = data.unlockPlot,
      unlock = true
    })
    local copyCfg = DT.CopiesConfig[config.CopyID]
    if data.unlockCopies and data.unlockCopies > 0 then
      local _, copyUnlock = PlayerDataUtils.IsFeatureUnlock("HardCopy", data.unlockCopies)
      if copyUnlock then
        local tips = LT.Text(copyCfg.SortName) .. LT.Text(copyCfg.Name)
        UIPopTipsDataUtils.AddToTipsShowQueue(30003, {
          desc = LT.Textf(DT.TipsType[30003].Desc, tips)
        }, nil, nil, UIPopTipsDataUtils.SideMsgType.GainTips)
      end
    end
    local tipTid = 30003
    if copyCfg.ChapterDifficulty == TownDefine.DBGCopyLevelHardType.Hard then
      tipTid = 30005
    end
    local _, unlock = PlayerDataUtils.IsFeatureUnlock("HardCopy", copyCfg.ID, false)
    if unlock then
      UIPopTipsDataUtils.AddToTipsShowQueue(tipTid, {
        desc = LT.Textf(DT.TipsType[tipTid].Desc, config.Name)
      }, nil, nil, UIPopTipsDataUtils.SideMsgType.GainTips)
    end
  end
  if 0 == DataCenter.copiesData.BarrierId then
    settleData.allPass = 0 == data.retEnergy
  else
    settleData.allPass = DataCenter.copiesData.BarrierId == data.finishLayer and 0 == data.retEnergy
  end
  settleData.failure = 0 == data.finishLayer
  settleData.showAwakerTid = data.showAwaker
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if stageData then
    settleData.stageId = stageData.stageId
  end
  settleData.endExp = DataCenter.playerData.DRole.exp
  settleData.startLevel = DataCenter.playerData.DRole.oldLevel
  settleData.endLevel = DataCenter.playerData.DRole.level
  settleData.dailyChallengeScoreBase = 1
  local stageCfg = DT.Stage[data.worldTid]
  local stageGroupCfg = DT.StageGroup[stageCfg.BelongGroup]
  if stageGroupCfg.Type == CommonDefine.StageGroupType.DailyChallenge then
    settleData.dailyChallengeScoreBase = DailyChallengeModel.Instance:GetStageScoreBase(data.worldTid)
  end
  settleData.dailyChallengeScores = {}
  if settleData.isFinish then
    table.insert(settleData.dailyChallengeScores, {
      desc = LT.Text("DailyChallengexSettlementBasicScoreTitle") .. "<size=20><color=#747474>" .. LT.Text("DailyChallengexSettlementBasicScoreTips") .. "</color></size>",
      score = settleData.dailyChallengeScoreBase,
      sortID = 0
    })
  end
  if data.dailyChallengeScore then
    for taskID, score in pairs(data.dailyChallengeScore) do
      local taskCfg = DT.Task[taskID]
      table.insert(settleData.dailyChallengeScores, {
        desc = LT.Text(taskCfg.Name),
        score = score,
        sortID = taskCfg.BaseSortID
      })
    end
    table.sort(settleData.dailyChallengeScores, function(a, b)
      return a.score > b.score
    end)
  end
  settleData.dailyChallengeTotalScore = settleData.star
  settleData.newHighScore = data.newHighScore or false
  settleData.score = data.score
  settleData.railWayData = data.railWayData
  return settleData
end

function CopiesDataUtils.ClearCopiesSettleData()
  DataCenter.copiesData.copiesSettleData = nil
end

function CopiesDataUtils.ConvertPrizeArr(prizeArr)
  local tmpTable = {}
  for _, prize in ipairs(prizeArr) do
    if not prize then
    else
      if not tmpTable[prize.awardType] then
        tmpTable[prize.awardType] = {}
      end
      if not tmpTable[prize.awardType][prize.tid] then
        tmpTable[prize.awardType][prize.tid] = {}
      end
      local tmpData = {
        num = prize.num,
        effectNum = prize.effectNum or 0,
        awardType = prize.awardType,
        configId = prize.tid,
        uid = prize.uid,
        extraOrigin = prize.extraOrigin
      }
      if ItemDataUtils.GetItemType(tmpData.configId) ~= CommonDefine.ItemType.Trinket or tmpData.uid then
        tableInsert(tmpTable[prize.awardType][prize.tid], tmpData)
      else
        DataCenter.copiesData.copiesSettleData.isTrinketOver = true
      end
    end
  end
  local result = {}
  for awardType, tblLevel1 in pairs(tmpTable) do
    for tid, prizeDataGroup in pairs(tblLevel1) do
      for _, prizeData in pairs(prizeDataGroup) do
        if prizeData.num > 0 then
          tableInsert(result, prizeData)
        end
      end
    end
  end
  tableSort(result, function(a, b)
    if a.awardType == b.awardType then
      return a.configId < b.configId
    end
    return a.awardType < b.awardType
  end)
  return result
end

function CopiesDataUtils.ShowSettlement(callback, stageType)
  local saveKey = CommonDefine.LocalSaveKey.CopyRecoverSettleData
  MobileFileDataManager.Instance:SetPlayerFileValue(saveKey, nil, true)
  local cb = callback
  if SummonDataUtils.HasWorldSettleGotAwakerShow() then
    function cb()
      local animData = SummonDataUtils.GetWorldSettleAwakerShowAnimData()
      
      UIManager.Instance:Reopen(Urls.SummonNewItemPanel, nil, nil, nil, animData, callback)
    end
  end
  CopiesDataUtils.ShowCopiesSettlePanel(cb, stageType)
end

function CopiesDataUtils.ShowCopiesSettlePanel(callback, stageType)
  local function openFunction()
    local params = {callback = callback, stageType = stageType}
    
    UIManager.Instance:Reopen(Urls.DBGMainCopyOutPanel, params)
    EventMgr.Instance.CopySettle:Dispatch()
  end
  
  if AwakerDataUtils.IsGainNewAwakerPanelOpen() then
    EventMgr.Instance.SummonGainItemCbSet:Dispatch(openFunction)
  else
    openFunction()
  end
end

function CopiesDataUtils.ShowCurrencyBanner()
end

function CopiesDataUtils.CloseCurrencyBanner()
end

function CopiesDataUtils.ClearFog(data)
  if 1 == data.clearType then
    DataCenter.copiesData.ClearFog = DataCenter.copiesData.BarrierId
  else
    DataCenter.copiesData.ClearFog = -1
  end
end

function CopiesDataUtils.OnSyncAwakerAddLike(data)
  table.insert(DataCenter.copiesData.AwakerShowLikeList, data)
end

function CopiesDataUtils.OnSyncAwakerFavorLvUpGrade(data)
  table.insert(DataCenter.copiesData.AwakerFavorLvUpGradeList, data)
end

function CopiesDataUtils.PopAwakerShow()
  do return table.remove end
  return table.remove, DataCenter.copiesData.AwakerShowLikeList
end

function CopiesDataUtils.PopAwakerFavorLvUpShow()
  do return table.remove end
  return table.remove, DataCenter.copiesData.AwakerFavorLvUpGradeList
end

function CopiesDataUtils.CleanBackpack()
  DataCenter.copiesData.Backpack = {}
end

function CopiesDataUtils.GetCopiesItem(tid)
  return DataCenter.copiesData.Backpack[tid]
end

function CopiesDataUtils.GetCopiesItemNum(tid)
  local item = DataCenter.copiesData.Backpack[tid]
  if item then
    return item.num or 0
  end
  return 0
end

function CopiesDataUtils.CheckBackpackItem(dat, isInit)
  for k, v in ipairs(dat) do
    local oldNum = 0
    local item = CopiesDataUtils.GetCopiesItem(v.tid)
    if item then
      oldNum = item.num
      dat[k].oldNum = oldNum
      item.num = v.num
    elseif v.num > 0 then
      dat[k].oldNum = 0
      local itemConfig = DT.Item[v.tid]
      if itemConfig then
        item = {
          tid = v.tid,
          num = v.num,
          variable = itemConfig.Variable,
          type = itemConfig.Type
        }
        DataCenter.copiesData.Backpack[v.tid] = item
      end
    end
    local itemCfg = DT.Item[v.tid]
    if item then
      Logger.Info(string.format("Copies Backpack CheckItem: tid=%s type=%s variable=%s num=%s->%s", v.tid, item.type, item.variable, oldNum, item.num))
    else
      Logger.Info(string.format("Copies Backpack CheckItem: item=%s", table.tostring(v)))
    end
  end
  EventMgr.Instance.CopyItemUpdate:Dispatch(dat)
end

function CopiesDataUtils.HasInitRuneTid()
  if DataCenter.copiesData.initRuneTid and DataCenter.copiesData.initRuneTid > 0 then
    return true
  end
end

function CopiesDataUtils.SetInitRuneTid(tid)
  DataCenter.copiesData.initRuneTid = tid
end

function CopiesDataUtils.GetCurrency(curType)
  for _, v in pairs(DataCenter.copiesData.Backpack) do
    if v.variable == curType then
      return v.num or 0
    end
  end
  return 0
end

function CopiesDataUtils.GetCopiesMoney()
  do return CopiesDataUtils.GetCurrency end
  return CopiesDataUtils.GetCurrency, CommonDefine.MoneyVariable.CopiesMoney
end

function CopiesDataUtils.GetExclusiveMoney()
  do return CopiesDataUtils.GetCurrency end
  return CopiesDataUtils.GetCurrency, CommonDefine.MoneyVariable.ExclusiveMoney
end

function CopiesDataUtils.GetGiveupSelectMoney()
  local barrierCfg = DT["Barrier.Barrier_" .. DataCenter.copiesData.BarrierId]
  if not barrierCfg then
    return -1
  end
  return barrierCfg.GetMoneyByGivingUp
end

return CopiesDataUtils
