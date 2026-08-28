local HomeCommon = require("Common/HomeCommon")
local DataModel = {
  StationInvestMaxNumList = {},
  NowStationId = 0,
  StationList = {},
  CurSelectGoodIndex = 0,
  CurSelectStationIndex = 0,
  CurStationCa = nil,
  CurStationSellList = {},
  CurGoodCa = nil,
  CurGoodQuotCa = nil,
  UpLv = 1,
  GoodMaxLv = 0,
  TradeUpdateCa = nil,
  CostMoney = 0,
  CurCanInvestMoney = 0,
  GoodAddPercentList = {},
  SidGoodLvList = {},
  SidUsedFundsList = {},
  SidTotalInvestMoney = {},
  CurStaSellPriceList = nil
}

function DataModel.Init()
  DataModel.NowStationId = 0
  local station_info = PlayerData:GetHomeInfo().station_info
  if station_info ~= nil then
    local stop_info = station_info.stop_info
    if stop_info ~= nil and stop_info[2] == -1 then
      DataModel.NowStationId = tonumber(stop_info[1])
    end
  end
  DataModel.StationList = {}
  local firStationCA = PlayerData:GetFactoryData(DataModel.NowStationId)
  local ca = PlayerData:GetFactoryData(99900014, "HomeStationFactory")
  local tempStationList = {}
  if ca and ca.stationList then
    for i = 1, #ca.stationList do
      local stationCA = PlayerData:GetFactoryData(ca.stationList[i].id)
      if stationCA and stationCA.isOpen and ca.stationList[i].id ~= DataModel.NowStationId and stationCA.currency == firStationCA.currency then
        table.insert(tempStationList, stationCA)
      end
    end
  end
  table.sort(tempStationList, function(a, b)
    return a.order < b.order
  end)
  if firStationCA then
    table.insert(DataModel.StationList, firStationCA)
  end
  for i = 1, #tempStationList do
    table.insert(DataModel.StationList, tempStationList[i])
  end
  local tradeUpgradeCa = PlayerData:GetFactoryData(99900216, "HomeStationFactory")
  if tradeUpgradeCa then
    DataModel.StationInvestMaxNumList = tradeUpgradeCa.AvailableFunds or {}
  end
  local tradeUpCa = PlayerData:GetFactoryData(99900219, "ConfigFactory")
  DataModel.TradeUpdateCa = tradeUpCa
  if tradeUpCa then
    DataModel.GoodMaxLv = tradeUpCa.levelLock or 0
  end
  DataModel.CurStaSellPriceList = nil
end

function DataModel.UpdatePlayerSidGoodProtoInfo(sidGoodLv, sidUsedFunds)
  DataModel.SidGoodLvList = sidGoodLv
  DataModel.SidUsedFundsList = sidUsedFunds
  if PlayerData.ServerData and PlayerData.ServerData.user_home_info then
    PlayerData.ServerData.user_home_info.sid_good_lv = sidGoodLv
    PlayerData.ServerData.user_home_info.sid_used_funds = sidUsedFunds
  end
end

function DataModel.GetActionValue()
  return PlayerData:GetUserInfo().move_energy or 0
end

function DataModel.GetGoodLv(stationId, goodId)
  stationId = tostring(stationId)
  goodId = tostring(goodId)
  if not DataModel.SidGoodLvList then
    return 0
  end
  if not DataModel.SidGoodLvList[stationId] then
    return 0
  end
  return DataModel.SidGoodLvList[stationId][goodId] or 0
end

function DataModel.SetGoodLv(stationId, goodId, lv)
  stationId = tostring(stationId)
  goodId = tostring(goodId)
  DataModel.SidGoodLvList = DataModel.SidGoodLvList or {}
  DataModel.SidGoodLvList[stationId] = DataModel.SidGoodLvList[stationId] or {}
  DataModel.SidGoodLvList[stationId][goodId] = lv or 0
end

function DataModel.SaveGoodAddPercent(stationId, goodId, percent, extNum, extraStock, tagBuff)
  DataModel.GoodAddPercentList = DataModel.GoodAddPercentList or {}
  DataModel.GoodAddPercentList[stationId] = DataModel.GoodAddPercentList[stationId] or {}
  DataModel.GoodAddPercentList[stationId][goodId] = {}
  DataModel.GoodAddPercentList[stationId][goodId].percent = percent
  DataModel.GoodAddPercentList[stationId][goodId].extNum = extNum
  DataModel.GoodAddPercentList[stationId][goodId].extraStock = extraStock
  DataModel.GoodAddPercentList[stationId][goodId].tagBuff = tagBuff
end

function DataModel.RemoveGoodAddPercent(stationId, goodId)
  DataModel.GoodAddPercentList = DataModel.GoodAddPercentList or {}
  DataModel.GoodAddPercentList[stationId] = DataModel.GoodAddPercentList[stationId] or {}
  DataModel.GoodAddPercentList[stationId][goodId] = nil
end

function DataModel.GetGoodAddPercent(stationId, goodId)
  if not DataModel.GoodAddPercentList then
    return nil
  end
  if not DataModel.GoodAddPercentList[stationId] then
    return nil
  end
  if not DataModel.GoodAddPercentList[stationId][goodId] then
    return nil
  end
  local percent = DataModel.GoodAddPercentList[stationId][goodId].percent or 0
  local extNum = DataModel.GoodAddPercentList[stationId][goodId].extNum or 0
  local extraStock = DataModel.GoodAddPercentList[stationId][goodId].extraStock or 0
  local tagBuff = DataModel.GoodAddPercentList[stationId][goodId].tagBuff or 0
  local extra_Percent = DataModel.GoodAddPercentList[stationId][goodId].extra_percent or 0
  return percent, extNum, extraStock, tagBuff, extra_Percent
end

function DataModel.GetGoodLvIsMax(stationId, goodId)
  local goodLv = DataModel.GetGoodLv(stationId, goodId) or 0
  return goodLv >= DataModel.GoodMaxLv
end

function DataModel.GetGoodCanUpMaxLv()
  if not DataModel.CurStationCa then
    return 0
  end
  if not DataModel.CurGoodCa then
    return 0
  end
  local canInvestMaxNum = DataModel.GetMaxInvestNumByStationId(DataModel.CurStationCa.id) or 0
  local hasInvestNum = DataModel.GetStationHasInvestNum(DataModel.CurStationCa.id) or 0
  local canInvestNum = canInvestMaxNum - hasInvestNum
  local goldNum = PlayerData:GetUserInfo().gold or 0
  canInvestNum = canInvestNum <= goldNum and canInvestNum or goldNum
  local nowLv = DataModel.GetGoodLv(DataModel.CurStationCa.id, DataModel.CurGoodCa.id) or 0
  local tempLv = nowLv
  local offsetLv = 0
  for i = nowLv, DataModel.GoodMaxLv do
    offsetLv = offsetLv + 1
    local cost = DataModel.GetUpgradeCostMoney(offsetLv)
    if canInvestNum >= cost then
      tempLv = nowLv + offsetLv
    else
      break
    end
  end
  return tempLv
end

function DataModel.GetStationRepNum(stationId)
  local curTotalRep, totalRep = HomeCommon.GetReputationValue(stationId)
  curTotalRep = curTotalRep or 0
  return curTotalRep
end

function DataModel.RefreshStationRepNum(stationId, repNum, repLv)
  local user_home_info = PlayerData:GetHomeInfo()
  if not user_home_info or not user_home_info.stations then
    return
  end
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if stationCA.attachedToCity > 0 then
    stationId = stationCA.attachedToCity
  end
  if user_home_info.stations[tostring(stationId)] then
    PlayerData:GetHomeInfo().stations[tostring(stationId)].rep_num = repNum
    PlayerData:GetHomeInfo().stations[tostring(stationId)].rep_lv = repLv
  end
end

function DataModel.GetMaxInvestNumByStationId(stationId)
  if not DataModel.StationInvestMaxNumList then
    return 0
  end
  local curTotalRep = DataModel.GetStationRepNum(stationId) or 0
  local num = 0
  for i = 1, #DataModel.StationInvestMaxNumList do
    local repNum = DataModel.StationInvestMaxNumList[i].repNum
    if curTotalRep >= repNum then
      num = DataModel.StationInvestMaxNumList[i].num
    else
      break
    end
  end
  local rate = DataModel.GetTradeGoldRate() or 1
  return math.floor(num * rate)
end

function DataModel.GetStationHasInvestNum(stationId)
  stationId = tostring(stationId)
  if not DataModel.SidUsedFundsList then
    return 0
  end
  return DataModel.SidUsedFundsList[stationId] or 0
end

function DataModel.SetStationHasInvestNum(stationId, num)
  stationId = tostring(stationId)
  DataModel.SidUsedFundsList = DataModel.SidUsedFundsList or {}
  DataModel.SidUsedFundsList[stationId] = num or 0
end

function DataModel.GetGoodComeNumByOffsetLv(offsetLv, buyPercent, extNum, goodQuoCa, goodCa, tagBuff, extra_Percent)
  local curGoodQuoCa = goodQuoCa or DataModel.CurGoodQuotCa
  local curGoodCa = goodCa or DataModel.CurGoodCa
  if not curGoodQuoCa then
    return 0
  end
  if not DataModel.TradeUpdateCa then
    local tradeUpCa = PlayerData:GetFactoryData(99900219, "ConfigFactory")
    DataModel.TradeUpdateCa = tradeUpCa
  end
  if not DataModel.TradeUpdateCa then
    return 0
  end
  if not curGoodCa then
    return 0
  end
  offsetLv = offsetLv or 0
  local quoNum = curGoodQuoCa.num or 0
  local mag = DataModel.TradeUpdateCa.purchaseMag or 0
  local addPercent = buyPercent or 0
  extNum = extNum or 0
  tagBuff = tagBuff or 0
  local rate = DataModel.GetMoneyBuffRate() or 0
  extra_Percent = extra_Percent or 0
  local num = (1 + addPercent + offsetLv * mag + tagBuff + rate / 100 + extra_Percent) * (quoNum + extNum)
  return num
end

function DataModel.GetUpgradeCostMoney(offsetLv)
  if not DataModel.CurGoodCa then
    return 0
  end
  if not DataModel.CurGoodQuotCa then
    return 0
  end
  if not DataModel.TradeUpdateCa then
    return 0
  end
  if offsetLv <= 0 then
    return 0
  end
  local lv = DataModel.GetGoodLv(DataModel.CurStationCa.id, DataModel.CurGoodCa.id) or 0
  local cost = 0
  local price = DataModel.CurGoodCa.price or 0
  local num = DataModel.CurGoodQuotCa.num or 0
  local distance = DataModel.CurGoodCa.distanceFactor or 0
  local distanceMag = DataModel.TradeUpdateCa.distanceMag or 0
  local quality = DataModel.TradeUpdateCa.quality or {}
  local qualityRat = 1
  for i = 1, #quality do
    if price >= quality[i].left then
      qualityRat = quality[i].num
    end
  end
  local speciality = DataModel.TradeUpdateCa.speciality or 0
  if not DataModel.CurGoodCa.isSpeciality then
    speciality = DataModel.TradeUpdateCa.specialityNo or 0
  end
  local levelMag = DataModel.TradeUpdateCa.levelMag or 0
  local cityMag = DataModel.TradeUpdateCa.cityMag or 0
  local stationCA = PlayerData:GetFactoryData(DataModel.CurStationCa.id, "HomeStationFactory")
  if stationCA and 0 < stationCA.force then
    cityMag = DataModel.TradeUpdateCa.cityMagNo or 0
  end
  for i = 1, offsetLv do
    local tempNum = price * num * (distance * distanceMag + 1) * (qualityRat + speciality) * DataModel.RoundToThreeDecimals(levelMag ^ (lv + (i - 1))) * cityMag
    tempNum = DataModel.GetRoundUpToHundred(tempNum)
    cost = cost + tempNum
  end
  local rate = DataModel.GetTradeGoldRate() or 1
  return math.ceil(cost * rate)
end

function DataModel.GetRoundNum(num)
  if 0 <= num then
    return math.floor(num + 0.5)
  else
    return math.ceil(num - 0.5)
  end
end

function DataModel.RoundToThreeDecimals(num)
  local rounded = DataModel.GetRoundNum(num * 1000) / 1000
  return rounded
end

function DataModel.GetRoundUpToHundred(num)
  if num == 0 then
    return 0
  end
  local absNum = math.abs(num)
  local hundredPart = math.floor(absNum / 100)
  local remainder = absNum % 100
  if 0 < remainder then
    hundredPart = hundredPart + 1
  end
  local result = hundredPart * 100
  return num < 0 and -result or result
end

function DataModel.GetIsLastGoodUnlockByIndex(index)
  local lastGoodName = ""
  if not DataModel.CurStationSellList or #DataModel.CurStationSellList == 0 then
    return false, lastGoodName
  end
  if not DataModel.CurStationCa then
    return false, lastGoodName
  end
  if index == 1 then
    return true
  end
  local nextGoodInfo = DataModel.CurStationSellList[index - 1]
  if not nextGoodInfo then
    return true
  end
  local goodQuotationCa = PlayerData:GetFactoryData(nextGoodInfo.id, "HomeGoodsQuotationFactory")
  if goodQuotationCa then
    local goodCa = PlayerData:GetFactoryData(goodQuotationCa.goodsId, "HomeGoodsFactory")
    if goodCa then
      lastGoodName = goodCa.name
      local nextNowLv = DataModel.GetGoodLv(DataModel.CurStationCa.id, goodCa.id) or 0
      if nextNowLv >= DataModel.TradeUpdateCa.NextLock then
        return true
      end
    end
  end
  return false, lastGoodName
end

function DataModel.GetIsGoodRepUnlock(index)
  local lockRep = 0
  if not DataModel.CurStationSellList or #DataModel.CurStationSellList == 0 then
    return false, lockRep
  end
  local goodInfo = DataModel.CurStationSellList[index]
  if not goodInfo then
    return false, lockRep
  end
  if not DataModel.CurStationCa then
    return false, lockRep
  end
  local curTotalRep = DataModel.GetStationRepNum(DataModel.CurStationCa.id) or 0
  local goodQuotationCa = PlayerData:GetFactoryData(goodInfo.id, "HomeGoodsQuotationFactory")
  if goodQuotationCa then
    local goodCa = PlayerData:GetFactoryData(goodQuotationCa.goodsId, "HomeGoodsFactory")
    if goodCa then
      local price = goodCa.price or 0
      local quality = DataModel.TradeUpdateCa.quality or {}
      for i = 1, #quality do
        if price >= quality[i].left then
          lockRep = quality[i].lock
        end
      end
      if curTotalRep >= lockRep then
        return true
      end
    end
  end
  return false, lockRep
end

function DataModel.GetIsGoodLvUnlockByIndex(index)
  local isLastUnlock = DataModel.GetIsLastGoodUnlockByIndex(index)
  local isRepUnlock = DataModel.GetIsGoodRepUnlock(index)
  if isLastUnlock and isRepUnlock then
    return true
  end
  return false
end

function DataModel.AddSidTotalInvestMoney(moneyId, num)
  DataModel.SidTotalInvestMoney = DataModel.SidTotalInvestMoney or {}
  num = num or 0
  moneyId = tostring(moneyId)
  DataModel.SidTotalInvestMoney[moneyId] = DataModel.SidTotalInvestMoney[moneyId] or 0
  DataModel.SidTotalInvestMoney[moneyId] = DataModel.SidTotalInvestMoney[moneyId] + num
end

function DataModel.GetSidTotalInvestMoney(moneyId)
  moneyId = moneyId or DataModel.GetStationCurrency(DataModel.CurStationCa.id)
  DataModel.SidTotalInvestMoney = DataModel.SidTotalInvestMoney or {}
  return DataModel.SidTotalInvestMoney[tostring(moneyId)] or 0
end

function DataModel.GetMoneyBuffRate()
  if not DataModel.TradeUpdateCa then
    return 0
  end
  local buffRate = DataModel.TradeUpdateCa.BuffRate or 0
  local goldRate = DataModel.GetTradeGoldRate() or 1
  local allInvest = DataModel.GetSidTotalInvestMoney() or 0
  buffRate = buffRate == 0 and 1 or buffRate
  local rate = math.floor(allInvest / math.ceil(buffRate * goldRate))
  local buffFloor = DataModel.GetMoneyBuffFloor() or 0
  buffFloor = math.floor(buffFloor * 100)
  return rate <= buffFloor and rate or buffFloor
end

function DataModel.GetIsTotalInvestBuffRateMax()
  if not DataModel.TradeUpdateCa then
    return false
  end
  local rate = DataModel.GetMoneyBuffRate() or 0
  local maxRate = DataModel.GetMoneyBuffFloor() or 0
  maxRate = maxRate * 100
  return rate >= maxRate
end

function DataModel.GetMoneyBuffFloor()
  if not DataModel.CurStationCa then
    return 0
  end
  if not DataModel.TradeUpdateCa then
    return 0
  end
  local buffFloor = 0
  local buffList = DataModel.TradeUpdateCa.BuffFloorNew or {}
  for i = 1, #buffList do
    if tostring(buffList[i].coin) == tostring(DataModel.GetStationCurrency(DataModel.CurStationCa.id)) then
      buffFloor = buffList[i].num or 0
      break
    end
  end
  return buffFloor
end

function DataModel.GetNextNeedInvestMoney()
  if not DataModel.TradeUpdateCa then
    return 0
  end
  local buffRate = DataModel.TradeUpdateCa.BuffRate or 0
  local goldRate = DataModel.GetTradeGoldRate() or 1
  buffRate = math.ceil(buffRate * goldRate)
  local allInvest = DataModel.GetSidTotalInvestMoney() or 0
  local yu = allInvest % buffRate
  return math.floor(buffRate - yu)
end

function DataModel.GetTradeGoldRate()
  if not DataModel.CurStationCa then
    return 1
  end
  local exRate = DataModel.CurStationCa.exRate or 80309353
  local listCa = PlayerData:GetFactoryData(exRate, "ListFactory")
  if not listCa then
    return 1
  end
  return listCa.rateNum or 1
end

function DataModel.GetStationCurrency(stationId)
  local id = 11400001
  if not stationId then
    return id
  end
  local ca = PlayerData:GetFactoryData(stationId, "HomeStationFactor")
  if not ca then
    return id
  end
  if ca.isExCity == false then
    return id
  end
  return ca.currency or id
end

return DataModel
