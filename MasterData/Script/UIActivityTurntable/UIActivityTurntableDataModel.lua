local DataModel = {
  activityId = 0,
  rewardList = {},
  singleCostCfg = nil,
  multiCostCfg = nil,
  multiTimes = 0,
  isSkip = false,
  getRewardList = {},
  beforeCircleCount = 2,
  lastShowCount = 6,
  itemTipsStayTime = 2,
  circleInterval = 0.1,
  activityCfg = nil,
  turntableProtoInfo = nil,
  nextRefreshTime = 0,
  boxPathList = {},
  turnSoundId = 0,
  selectSoundId = 0,
  tempDailyCnt = 0,
  moneyId = 0,
  onceCostMoneyNum = 0,
  IsEnough = false,
  Price = 0,
  MoneyNum = 0,
  ShopId = 0,
  CommodityId = 0,
  NeedNum = 0,
  IsSingle = false,
  TempRewardCountList = {},
  probabilityRewardList = {},
  allWeight = 0
}

function DataModel.ParseProtoInfo(turntable)
  if not turntable then
    return
  end
  DataModel.turntableProtoInfo = nil
  for actId, v in pairs(turntable) do
    if DataModel.activityId == tonumber(actId) then
      DataModel.turntableProtoInfo = v
      break
    end
  end
  DataModel.Init()
end

function DataModel.Init()
  if not DataModel.turntableProtoInfo then
    return
  end
  local Ca = PlayerData:GetFactoryData(99900021)
  if Ca then
    DataModel.boxPathList = Ca.turntableBoxPath
  end
  DataModel.isSkip = PlayerData:GetPlayerPrefs("int", "Activity_Turntable_Skip_State") == 1
  local actCa = PlayerData:GetFactoryData(DataModel.activityId, "ActivityFactory")
  DataModel.activityCfg = actCa
  if not actCa then
    return
  end
  DataModel.circleInterval = actCa.turntableAnimTime
  DataModel.beforeCircleCount = actCa.turntableAnimRound
  DataModel.multiTimes = actCa.turntableTimesMulit or 0
  DataModel.rewardList = actCa.turntableRewardList
  if actCa.turntableSingleCostList then
    DataModel.singleCostCfg = actCa.turntableSingleCostList[1]
  end
  if actCa.turntableMulitCostList then
    DataModel.multiCostCfg = actCa.turntableMulitCostList[1]
  end
  DataModel.turnSoundId = actCa.turntableAnimSound
  DataModel.selectSoundId = actCa.turntableFinishSound
  DataModel.ShopId = actCa.turntableShopId
  local shopCa = PlayerData:GetFactoryData(DataModel.ShopId, "StoreFactory")
  if shopCa then
    local shopList = shopCa.shopList or {}
    DataModel.CommodityId = shopList[1].id or 0
  end
  local comCa = PlayerData:GetFactoryData(DataModel.CommodityId, "CommodityFactory")
  if comCa then
    local moneyList = comCa.moneyList or {}
    if moneyList[1] then
      DataModel.moneyId = moneyList[1].moneyID or 0
      DataModel.onceCostMoneyNum = moneyList[1].moneyNum or 0
    end
  end
  DataModel.probabilityRewardList = Clone(actCa.turntableRewardList)
  if DataModel.probabilityRewardList then
    table.sort(DataModel.probabilityRewardList, function(a, b)
      return a.weight < b.weight
    end)
    DataModel.allWeight = 0
    for i = 1, #DataModel.probabilityRewardList do
      local weight = DataModel.probabilityRewardList[i].weight or 0
      DataModel.allWeight = DataModel.allWeight + weight
    end
  end
end

function DataModel.GetRemainCountByIndex(index)
  if not index then
    return 0
  end
  if not DataModel.rewardList then
    return 0
  end
  local rewardInfo = DataModel.rewardList[index]
  if not rewardInfo then
    return 0
  end
  if rewardInfo.max == 0 then
    return -1
  end
  local canGetNum = rewardInfo.max or 0
  local hasGetNum = 0
  if DataModel.turntableProtoInfo and DataModel.turntableProtoInfo.reward then
    hasGetNum = DataModel.turntableProtoInfo.reward[tostring(index - 1)] or 0
  end
  local remainNum = canGetNum - hasGetNum
  remainNum = remainNum < 0 and 0 or remainNum
  return remainNum
end

function DataModel.GetMustBestNeedCount()
  if not DataModel.activityCfg then
    return 0
  end
  local mustMaxCount = DataModel.activityCfg.turntableTimesBest or 0
  local hasCount = 0
  if DataModel.turntableProtoInfo then
    hasCount = DataModel.turntableProtoInfo.best_cnt or 0
  end
  local remainNum = mustMaxCount - hasCount
  remainNum = remainNum < 0 and 0 or remainNum
  return remainNum
end

function DataModel.GetIsAllBestGot()
  if not DataModel.rewardList then
    return true
  end
  if not DataModel.turntableProtoInfo then
    return true
  end
  for i = 1, #DataModel.rewardList do
    local rewardInfo = DataModel.rewardList[i]
    if rewardInfo.isBest then
      local canGetNum = rewardInfo.max
      local rewardProtoList = DataModel.turntableProtoInfo.reward or {}
      local hasGetCount = rewardProtoList[tostring(i - 1)] or 0
      if canGetNum > hasGetCount then
        return false
      end
    end
  end
  return true
end

function DataModel.GetRemainTurnTime()
  if not DataModel.activityCfg then
    return 0
  end
  local dailyMaxCnt = DataModel.activityCfg.turntableTimesMax or 0
  local hasTurnCnt = 0
  if DataModel.turntableProtoInfo then
    hasTurnCnt = DataModel.tempDailyCnt or 0
  end
  local remainNum = dailyMaxCnt - hasTurnCnt
  remainNum = remainNum < 0 and 0 or remainNum
  return remainNum
end

function DataModel.InitTempDailyCnt()
  if DataModel.turntableProtoInfo then
    DataModel.tempDailyCnt = DataModel.turntableProtoInfo.daily_cnt or 0
  else
    DataModel.tempDailyCnt = 0
  end
end

function DataModel.AddDailyTurnTime(isSingle)
  if not DataModel.tempDailyCnt then
    return
  end
  DataModel.tempDailyCnt = DataModel.tempDailyCnt or 0
  DataModel.tempDailyCnt = DataModel.tempDailyCnt + (isSingle and 1 or DataModel.multiTimes)
end

function DataModel.GetLastAnimationIndexListByIndex(index)
  if not DataModel.rewardList then
    return {}
  end
  local list = {}
  local frontCount = DataModel.lastShowCount - 1
  if index <= frontCount then
    for i = 1, frontCount do
      table.insert(list, #DataModel.rewardList + index - (frontCount - i))
    end
    table.insert(list, index)
  else
    for i = 1, frontCount do
      table.insert(list, index - (frontCount - i))
    end
    table.insert(list, index)
  end
  return list
end

function DataModel.GetIsCanTurn(isSingle)
  if not DataModel.activityCfg then
    return false
  end
  if not DataModel.turntableProtoInfo then
    return false
  end
  local isAllItemGot = DataModel.GetIsAllTurntableItemGot()
  if isAllItemGot then
    return false
  end
  local dayRemainTime = DataModel.GetRemainTurnTime() or 0
  if dayRemainTime < (isSingle and 1 or DataModel.multiTimes) then
    CommonTips.OpenTips(80611825)
    return false
  end
  local turntableCostList = isSingle and DataModel.activityCfg.turntableSingleCostList or DataModel.activityCfg.turntableMulitCostList
  if not turntableCostList then
    return false
  end
  local isCan = true
  for i = 1, #turntableCostList do
    local hasNum = PlayerData:GetGoodsById(turntableCostList[i].id).num or 0
    local needNum = turntableCostList[i].num
    if hasNum < needNum then
      isCan = false
      if turntableCostList[i].id == 11400005 then
        local function callback()
          CommonTips.OpenStoreBuy()
        end
        
        CommonTips.OnPrompt(80600147, GetText(80600068), GetText(80600067), callback)
        return false
      end
    end
  end
  if isCan == false then
    CommonTips.OpenTips(80600488)
    return false
  end
  return true
end

function DataModel.InitDayRefreshTime()
  local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
  local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
  local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
  local targetTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s)
  DataModel.nextRefreshTime = targetTime
end

function DataModel.GetMustNotGetBestCount()
  if not DataModel.activityCfg then
    return 0
  end
  local mustMaxCount = DataModel.activityCfg.turntableTimesPre or 0
  local hasCount = 0
  if DataModel.turntableProtoInfo then
    hasCount = DataModel.turntableProtoInfo.tt_cnt or 0
  end
  local remainNum = mustMaxCount - hasCount
  remainNum = remainNum < 0 and 0 or remainNum
  return remainNum
end

function DataModel.GetTurntableAcyRedDotState(id)
  local actCa = PlayerData:GetFactoryData(id, "ActivityFactory")
  if actCa and actCa.turntableCoinId then
    local num = PlayerData:GetGoodsById(actCa.turntableCoinId).num or 0
    return 0 < num
  end
  return false
end

function DataModel.GetIsAllTurntableItemGot()
  if not DataModel.rewardList then
    return false
  end
  if not DataModel.turntableProtoInfo then
    return false
  end
  for i = 1, #DataModel.rewardList do
    local remainCount = DataModel.GetRemainCountByIndex(i)
    if 0 < remainCount then
      return false
    elseif remainCount == -1 then
      return false
    end
  end
  return true
end

function DataModel.GetIsItemRemainLessTen()
  if not DataModel.rewardList then
    return true
  end
  if not DataModel.turntableProtoInfo then
    return true
  end
  local count = 0
  for i = 1, #DataModel.rewardList do
    local remainCount = DataModel.GetRemainCountByIndex(i)
    if remainCount == -1 then
      return false
    end
    count = count + remainCount
  end
  if count < DataModel.multiTimes then
    return true
  else
    return false
  end
end

return DataModel
