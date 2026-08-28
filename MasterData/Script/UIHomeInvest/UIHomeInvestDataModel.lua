local ActivityMainController = require("UIActivityMain/UIActivityMainController")
local DataModel = {
  initParams = nil,
  StationId = 0,
  StationCA = 0,
  NpcId = 0,
  BgPath = "",
  IsBossBattle = false,
  CurRepLv = 0,
  InvestList = {},
  DrinkInfo = {},
  DrinkCurCount = 0,
  DrinkIdx = 0,
  TradePermissionGoods = {},
  NPCDialogEnum = {
    drinkText = "drinkText",
    upperText = "upperText",
    OneText = "OneText",
    enterText = "enterText",
    investText = "investText",
    talkText = "talkText",
    investSuccessText = "investSuccessText",
    ItemText = "ItemText",
    investOneText = "investOneText",
    investTwoText = "investTwoText",
    investThreeText = "investThreeText",
    investFourText = "investFourText",
    investFiveText = "investFiveText",
    investSixText = "investSixText"
  },
  DevDegree = 0,
  TotalTZ = 0,
  serverStationData = {},
  AllNoInvest = true,
  CacheEventList = {},
  WuLinStationId = 83000046,
  WuLinGoodTagsList = {
    [1] = {listId = 80308640, tagId = 12601851},
    [2] = {listId = 80308641, tagId = 12601857},
    [3] = {listId = 80308642, tagId = 12601848},
    [4] = {listId = 80308643, tagId = 12601849},
    [5] = {listId = 80308644, tagId = 12601845}
  },
  WuLinAllGoodTagQuestList = {},
  WuLinShowGoodTagQuestList = {},
  CurTagGoodListId = 0,
  WuLinInvestGoodsList = {},
  WuLinInvestGoodsAllCount = 0,
  AllStationQuests = {}
}

local function AddTradePermissionGoods(stationCA, devDegree, addTable, isChild)
  for k, v in pairs(stationCA.sellList) do
    local listCA = PlayerData:GetFactoryData(v.id, "ListFactory")
    if listCA.needItemNum > 0 or 0 < listCA.needDevelopNum then
      local t = {}
      t.id = v.id
      t.goodsId = listCA.goodsId
      local itemCA = PlayerData:GetFactoryData(t.goodsId, "ItemFactory")
      local goodsCA = PlayerData:GetFactoryData(t.goodsId, "HomeGoodsFactory")
      t.name = itemCA.name
      t.needItemNum = listCA.needItemNum
      t.needItemNumThousands = PlayerData.FormatNumThousands(t.needItemNum)
      t.checkNeedItemNum = DataModel.TotalTZ >= listCA.needItemNum
      t.needDevelopNum = listCA.needDevelopNum
      t.needDevelopNumThousands = PlayerData.FormatNumThousands(t.needDevelopNum)
      t.checkDevelopNum = devDegree >= listCA.needDevelopNum
      t.unLock = t.checkNeedItemNum and t.checkDevelopNum
      t.isSpecial = goodsCA.isShow
      t.stationName = stationCA.name
      t.stationId = stationCA.id
      t.isChild = isChild
      table.insert(addTable, t)
    end
  end
end

function DataModel.InitData()
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  DataModel.InvestList = {}
  DataModel.AllNoInvest = true
  for k, v in pairs(stationCA.investList) do
    local t = {}
    t.name = v.name
    t.repGrade = v.repGrade
    t.limitNum = v.limitNum
    local serverDetail = DataModel.serverStationData.invest[tostring(k - 1)]
    local usedNum = 0
    if serverDetail ~= nil then
      usedNum = serverDetail.cnt
    end
    t.remainNum = t.limitNum - usedNum
    t.developNum = v.developNum
    local isNoInvest = t.limitNum == t.remainNum
    DataModel.AllNoInvest = DataModel.AllNoInvest and isNoInvest
    local listCA = PlayerData:GetFactoryData(v.id, "ListFactory")
    t.costList = listCA.investorCostList
    t.rewardList = listCA.investorRewList
    table.insert(DataModel.InvestList, t)
  end
  DataModel.TradePermissionGoods = {}
  AddTradePermissionGoods(stationCA, DataModel.DevDegree, DataModel.TradePermissionGoods)
  local attachChildren = PlayerData.TempCache.CacheStationAttachChildren[DataModel.StationId]
  if attachChildren then
    for k, v in ipairs(attachChildren) do
      local ca = PlayerData:GetFactoryData(v, "HomeStationFactory")
      local serverDevDegree = PlayerData:GetHomeInfo().dev_degree[tostring(v)]
      local devDegree = 0
      if serverDevDegree then
        devDegree = serverDevDegree.dev_degree or 0
      end
      AddTradePermissionGoods(ca, devDegree, DataModel.TradePermissionGoods, true)
    end
  end
  DataModel.SortTradePermissionGoods()
end

function DataModel.SortTradePermissionGoods()
  table.sort(DataModel.TradePermissionGoods, function(a, b)
    if not a.unLock and b.unLock then
      return true
    elseif a.unLock and not b.unLock then
      return false
    end
    if a.needItemNum < b.needItemNum then
      return true
    elseif a.needItemNum > b.needItemNum then
      return false
    end
    if not a.isChild and b.isChild then
      return true
    elseif a.isChild and not b.isChild then
      return false
    end
    if a.stationId < b.stationId then
      return true
    elseif a.stationId > b.stationId then
      return false
    end
    return a.needDevelopNum < b.needDevelopNum
  end)
end

function DataModel.GetTotalTZ()
  local serverInvest = DataModel.serverStationData.invest
  local num = 0
  if serverInvest ~= nil then
    for k, v in pairs(serverInvest) do
      num = num + v.cost
    end
  end
  return num
end

function DataModel.GetCurrentStayCityConfig()
  return PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
end

function DataModel.GetCurrentCityIsWuLin()
  return tonumber(DataModel.StationId) == DataModel.WuLinStationId
end

function DataModel.GetIsTaskFinish(taskId)
  local questCA = PlayerData:GetFactoryData(taskId, "QuestFactory")
  if not questCA then
    return true
  end
  return ActivityMainController:QuestIsFinish(taskId)
end

function DataModel.GetCurrentDoingTaskInfo()
  local index = 0
  local questId
  local curTax = 0
  local nextTax = 0
  local stationCa = DataModel.GetCurrentStayCityConfig()
  if not stationCa then
    return index, questId, curTax, nextTax
  end
  local revenueList = stationCa.revenueList
  if not revenueList then
    return index, questId, curTax, nextTax
  end
  for i = 1, #revenueList do
    local listCa = PlayerData:GetFactoryData(revenueList[i].quest, "ListFactory")
    if listCa then
      local questList = listCa.questList or {}
      local firstQuest = questList[1] or {}
      questId = firstQuest.id
      local isQuestFinish = DataModel.GetIsTaskFinish(questId)
      if isQuestFinish then
        index = index + 1
        curTax = curTax + revenueList[i].revenue
      else
        nextTax = curTax + revenueList[i].revenue
        return index, questId, curTax, nextTax
      end
    end
  end
  return index, questId, curTax, curTax
end

function DataModel.GetWuLinTaskMaxCount()
  local stationCa = DataModel.GetCurrentStayCityConfig()
  if not stationCa then
    return 1, nil
  end
  local revenueList = stationCa.revenueList or {}
  return #revenueList
end

function DataModel.GetWuLinTaskIsAllFinished()
  local currentDoingIndex = DataModel.GetCurrentDoingTaskInfo()
  local maxIndex = DataModel.GetWuLinTaskMaxCount()
  return currentDoingIndex >= maxIndex
end

function DataModel.GetQuestFinishCount(questId)
  DataModel.AllStationQuests = DataModel.AllStationQuests or {}
  local info = DataModel.AllStationQuests[tostring(questId)] or {}
  return info.pcnt or 0
end

function DataModel.InitGoodsTagConfig()
  DataModel.WuLinAllGoodTagQuestList = {}
  local stationCa = DataModel.GetCurrentStayCityConfig()
  if not stationCa then
    return
  end
  local goodList = stationCa.goodList
  if not goodList then
    return
  end
  for i = 1, #goodList do
    DataModel.WuLinAllGoodTagQuestList[goodList[i].tag] = DataModel.WuLinAllGoodTagQuestList[goodList[i].tag] or {}
    table.insert(DataModel.WuLinAllGoodTagQuestList[goodList[i].tag], goodList[i])
  end
  DataModel.InitTagShowQuestIndexList()
end

function DataModel.GetGoodsTagQuestFinishCount()
  local count = 0
  local stationCa = DataModel.GetCurrentStayCityConfig()
  if not stationCa then
    return count
  end
  local goodList = stationCa.goodList
  if not goodList then
    return count
  end
  for i = 1, #goodList do
    local listCa = PlayerData:GetFactoryData(goodList[i].quest, "ListFactory")
    if listCa then
      local questList = listCa.questList or {}
      local firstQuest = questList[1] or {}
      local isQuestFinish = DataModel.GetIsTaskFinish(firstQuest.id)
      if isQuestFinish then
        count = count + 1
      end
    end
  end
  return count
end

function DataModel.GetGoodsTagQuestMaxFinishCount()
  local stationCa = DataModel.GetCurrentStayCityConfig()
  if not stationCa then
    return 0
  end
  local goodList = stationCa.goodList or {}
  return #goodList
end

function DataModel.GetIsGoodsTagAllQuestFinished()
  local finishCount = DataModel.GetGoodsTagQuestFinishCount() or 0
  local maxCount = DataModel.GetGoodsTagQuestMaxFinishCount() or 0
  return finishCount >= maxCount
end

function DataModel.GetTagQuestFinishedProgressByTagId(tagId)
  local stationCa = DataModel.GetCurrentStayCityConfig()
  if not stationCa then
    return 0
  end
  local goodList = DataModel.WuLinAllGoodTagQuestList[tagId]
  if not goodList then
    return 0
  end
  local finishCount = 0
  local allCount = 0
  for i = 1, #goodList do
    if tostring(tagId) == tostring(goodList[i].tag) then
      allCount = allCount + 1
      local listCa = PlayerData:GetFactoryData(goodList[i].quest, "ListFactory")
      if listCa then
        local questList = listCa.questList or {}
        local firstQuest = questList[1] or {}
        local isQuestFinish = DataModel.GetIsTaskFinish(firstQuest.id)
        if isQuestFinish then
          finishCount = finishCount + goodList[i].num
        end
      end
    end
  end
  return finishCount
end

function DataModel.InitTagShowQuestIndexList()
  DataModel.WuLinShowGoodTagQuestList = {}
  for i = 1, #DataModel.WuLinGoodTagsList do
    local goodQuestList = DataModel.WuLinAllGoodTagQuestList[DataModel.WuLinGoodTagsList[i].tagId] or {}
    local index = 1
    local nextIndex = 0
    local questId = 0
    for j = 1, #goodQuestList do
      local listCa = PlayerData:GetFactoryData(goodQuestList[j].quest, "ListFactory")
      if listCa then
        local questList = listCa.questList or {}
        local firstQuest = questList[1] or {}
        local isQuestFinish = DataModel.GetIsTaskFinish(firstQuest.id)
        questId = firstQuest.id
        index = j
        nextIndex = index + 1
        if not isQuestFinish then
          break
        end
      end
    end
    local questCa = PlayerData:GetFactoryData(questId, "QuestFactory")
    if questCa then
      local info = {}
      info.index = index
      if goodQuestList[nextIndex] then
        local nextListCa = PlayerData:GetFactoryData(goodQuestList[nextIndex].quest)
        if nextListCa then
          local questList = nextListCa.questList or {}
          local firstQuest = questList[1] or {}
          info.nextQuestCa = PlayerData:GetFactoryData(firstQuest.id, "QuestFactory")
        end
      else
        info.nextQuestCa = nil
      end
      info.questCa = questCa
      info.goodListId = DataModel.WuLinGoodTagsList[i].listId
      info.tagCa = PlayerData:GetFactoryData(DataModel.WuLinGoodTagsList[i].tagId, "TagFactory")
      table.insert(DataModel.WuLinShowGoodTagQuestList, info)
    end
  end
end

function DataModel.InitWuLinGoodsInvestConfig()
  DataModel.WuLinInvestGoodsList = {}
  local stationCa = DataModel.GetCurrentStayCityConfig()
  if not stationCa then
    return
  end
  local exInvestList = stationCa.exInvestList or {}
  for i = 1, #exInvestList do
    local goodQuaCa = PlayerData:GetFactoryData(exInvestList[i].id, "HomeGoodsQuotationFactory")
    local goodCa = PlayerData:GetFactoryData(goodQuaCa.goodsId, "HomeGoodsFactory")
    local info = {}
    info.goodQuaCa = goodQuaCa
    info.goodCa = goodCa
    info.isUnlock = DataModel.GetIsTaskFinish(goodQuaCa.unlockedQuest)
    if goodQuaCa and goodCa then
      table.insert(DataModel.WuLinInvestGoodsList, info)
    end
  end
end

function DataModel.InitWuLinAllGoodsInvestMoneyCount()
  DataModel.WuLinInvestGoodsList = DataModel.WuLinInvestGoodsList or {}
  DataModel.WuLinInvestGoodsAllCount = 0
  for i = 1, #DataModel.WuLinInvestGoodsList do
    if DataModel.WuLinInvestGoodsList[i].goodQuaCa then
      local questList = DataModel.WuLinInvestGoodsList[i].goodQuaCa.questList or {}
      for j = 1, #questList do
        local isFinish = DataModel.GetIsTaskFinish(questList[j].quest)
        if isFinish then
          local addCount = 0
          local questCA = PlayerData:GetFactoryData(questList[j].quest, "QuestFactory")
          if questCA then
            local requireItemList = questCA.requireItemList or {}
            local reInfo = requireItemList[1] or {}
            addCount = reInfo.num or 0
          end
          DataModel.WuLinInvestGoodsAllCount = DataModel.WuLinInvestGoodsAllCount + addCount
        end
      end
    end
  end
end

function DataModel.GetCurGoodInvestQuestByIndex(index)
  if not DataModel.WuLinInvestGoodsList then
    return nil
  end
  if not DataModel.WuLinInvestGoodsList[index] or not DataModel.WuLinInvestGoodsList[index].goodQuaCa then
    return nil
  end
  local questList = DataModel.WuLinInvestGoodsList[index].goodQuaCa.questList or {}
  for i = 1, #questList do
    local questCA = PlayerData:GetFactoryData(questList[i].quest, "QuestFactory")
    if questCA then
      local isFinish = DataModel.GetIsTaskFinish(questList[i].quest)
      if not isFinish then
        return questCA, questList[i].num or 0, i
      end
    end
  end
  return nil
end

function DataModel.GetGoodComeNumByOffsetLv(offsetLv, buyPercent, extNum, goodQuoCa, goodCa, tagBuff, moneyRate, extra_Percent)
  if not goodQuoCa then
    return 0
  end
  local tradeUpdateCa = PlayerData:GetFactoryData(99900219, "ConfigFactory")
  if not tradeUpdateCa then
    return 0
  end
  if not goodCa then
    return 0
  end
  offsetLv = offsetLv or 0
  local quoNum = goodQuoCa.num or 0
  local mag = tradeUpdateCa.purchaseMag or 0
  local addPercent = buyPercent or 0
  extNum = extNum or 0
  tagBuff = tagBuff or 0
  moneyRate = moneyRate or 0
  extra_Percent = extra_Percent or 0
  local num = (1 + addPercent + offsetLv * mag + tagBuff + moneyRate / 100 + extra_Percent) * (quoNum + extNum)
  return num
end

function DataModel.GetStationCurrency(stationId)
  local id = 11400001
  if not stationId then
    return id
  end
  local ca = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if not ca then
    return id
  end
  if ca.isExCity == false then
    return id
  end
  return ca.currency or id
end

function DataModel.GetMoneyBuffRate(moneyInvest)
  local tradeUpCa = PlayerData:GetFactoryData(99900219, "ConfigFactory")
  if not tradeUpCa then
    return 0
  end
  local buffRate = tradeUpCa.BuffRate or 0
  local allInvest = moneyInvest or 0
  buffRate = buffRate == 0 and 1 or buffRate
  local goldRate = DataModel.GetTradeGoldRate() or 1
  local rate = math.floor(allInvest / (buffRate * goldRate))
  local buffFloor = tradeUpCa.BuffFloor or 0
  buffFloor = math.floor(buffFloor * 100)
  return rate <= buffFloor and rate or buffFloor
end

function DataModel.GetTradeGoldRate()
  local stationCa = DataModel.GetCurrentStayCityConfig()
  local exRate = stationCa.exRate or 80309353
  local listCa = PlayerData:GetFactoryData(exRate, "ListFactory")
  if not listCa then
    return 1
  end
  return listCa.rateNum or 1
end

return DataModel
