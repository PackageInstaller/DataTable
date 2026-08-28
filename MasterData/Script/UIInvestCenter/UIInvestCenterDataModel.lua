local ActivityMainController = require("UIActivityMain/UIActivityMainController")
local DataModel = {
  initParams = nil,
  StationId = 0,
  StationCA = nil,
  BuildingId = 0,
  NpcId = 0,
  BgPath = "",
  BgColor = "#FFFFFF",
  CacheEventList = {},
  NPCDialogEnum = {
    enterText = "enterText",
    talkText = "talkText",
    investQuestText = "investQuestText",
    investSuccessText = "investSuccessText",
    investFailText = "investFailText",
    investText = "investText",
    ItemText = "ItemText",
    investOneText = "investOneText",
    investTwoText = "investTwoText",
    investThreeText = "investThreeText",
    investFourText = "investFourText",
    investFiveText = "investFiveText",
    investSixText = "investSixText"
  },
  InBuffList = {},
  OutBuffList = {},
  InProgress = {
    finishCount = 0,
    totalCount = 0,
    isMax = false
  },
  OutProgress = {
    finishCount = 0,
    totalCount = 0,
    isMax = false
  },
  InMissionList = {},
  OutMissionList = {},
  SpItemList = {},
  SpItemGoodsInfo = {},
  SpItemQuestTagBuff = {},
  SpItemCurrencyFunds = {},
  SpItemGoodLvs = {}
}

local function GetPositiveId(id)
  id = tonumber(id)
  if id and 0 < id then
    return id
  end
  return nil
end

function DataModel.GetCurrentStationId()
  local stationId = GetPositiveId(DataModel.StationId)
  if stationId then
    return stationId
  end
  local homeInfo = PlayerData:GetHomeInfo()
  local stopInfo = homeInfo and homeInfo.station_info and homeInfo.station_info.stop_info
  if stopInfo then
    stationId = GetPositiveId(stopInfo[1])
    if stationId then
      return stationId
    end
  end
  local ok, tradeDataModel = pcall(require, "UIHome/UIHomeTradeDataModel")
  if ok and tradeDataModel then
    stationId = GetPositiveId(tradeDataModel.CurStayCity)
    if stationId then
      return stationId
    end
  end
  return 0
end

function DataModel.InitStationConfig()
  DataModel.StationId = DataModel.GetCurrentStationId()
  DataModel.StationCA = nil
  if DataModel.StationId and DataModel.StationId > 0 then
    DataModel.StationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  end
  DataModel.RefreshGoodsTradeData()
end

function DataModel.GetQuestId(quest)
  local questId = GetPositiveId(quest)
  if not questId then
    return nil
  end
  local listCA = PlayerData:GetFactoryData(questId, "ListFactory")
  if listCA and listCA.questList and listCA.questList[1] then
    return GetPositiveId(listCA.questList[1].id)
  end
  local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
  if questCA then
    return questId
  end
  return nil
end

function DataModel.GetIsTaskFinish(quest)
  local questId = DataModel.GetQuestId(quest)
  if not questId then
    return true
  end
  local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
  if not questCA then
    return true
  end
  return ActivityMainController:QuestIsFinish(questId)
end

function DataModel.GetQuestInfo(quest)
  local questId = DataModel.GetQuestId(quest)
  if not questId then
    return nil
  end
  return PlayerData:GetFactoryData(questId, "QuestFactory")
end

function DataModel.GetQuestProgress(questCA)
  if not questCA then
    return 0, 0
  end
  local maxCount = questCA.num or 0
  local curCount = 0
  local state, serverCount = PlayerData.GetQuestState(questCA.id)
  if state == EnumDefine.EQuestState.Receive or state == EnumDefine.EQuestState.Finish then
    curCount = maxCount
  else
    curCount = serverCount or 0
  end
  if maxCount < curCount then
    curCount = maxCount
  end
  return curCount, maxCount
end

function DataModel.GetQuotationGoodsList(contentId)
  local result = {}
  local id = GetPositiveId(contentId)
  if not id then
    return result
  end
  local listCA = PlayerData:GetFactoryData(id, "ListFactory")
  local quotationList = listCA and listCA.quotation or {}
  for i = 1, #quotationList do
    local quotationInfo = quotationList[i]
    local quotationId = quotationInfo and (quotationInfo.id or quotationInfo)
    quotationId = GetPositiveId(quotationId)
    if quotationId then
      local quotationCA = PlayerData:GetFactoryData(quotationId, "HomeGoodsQuotationFactory")
      local goodsCA = quotationCA and PlayerData:GetFactoryData(quotationCA.goodsId, "HomeGoodsFactory")
      if goodsCA then
        table.insert(result, {
          goodsId = goodsCA.id,
          imagePath = goodsCA.imagePath or ""
        })
      end
    end
  end
  return result
end

local function BuildBuffList(sourceList)
  sourceList = sourceList or {}
  local finishCount = 0
  local typeOrder = {}
  local typeRecord = {}
  local totalMoney = 0
  local moneyTypeOrder = {}
  local moneyTypeRecord = {}
  for i = 1, #sourceList do
    local info = sourceList[i]
    if info then
      local buffType = tostring(info.buffType or 0)
      if moneyTypeRecord[buffType] == nil then
        table.insert(moneyTypeOrder, buffType)
        moneyTypeRecord[buffType] = {}
      end
      moneyTypeRecord[buffType].lastInfo = info
      if moneyTypeRecord[buffType].currentInfo == nil and not DataModel.GetIsTaskFinish(info.quest) then
        moneyTypeRecord[buffType].currentInfo = info
      end
    end
    if info and DataModel.GetIsTaskFinish(info.quest) then
      finishCount = finishCount + 1
      local buffType = tostring(info.buffType or 0)
      if typeRecord[buffType] == nil then
        table.insert(typeOrder, buffType)
      end
      typeRecord[buffType] = info
    end
  end
  local showList = {}
  for i = 1, #typeOrder do
    table.insert(showList, typeRecord[typeOrder[i]])
  end
  for i = 1, #moneyTypeOrder do
    local moneyInfo = moneyTypeRecord[moneyTypeOrder[i]]
    local questInfo = moneyInfo.currentInfo or moneyInfo.lastInfo
    local questCA = questInfo and DataModel.GetQuestInfo(questInfo.quest)
    local curCount, maxCount = DataModel.GetQuestProgress(questCA)
    totalMoney = totalMoney + (moneyInfo.currentInfo and curCount or maxCount)
  end
  return showList, {
    finishCount = finishCount,
    totalCount = #sourceList,
    isMax = 0 < #sourceList and finishCount >= #sourceList,
    totalMoney = totalMoney
  }
end

local function BuildMissionList(sourceList, nType)
  sourceList = sourceList or {}
  local missionList = {}
  for i = 1, #sourceList do
    local info = sourceList[i]
    if info then
      local questCA = DataModel.GetQuestInfo(info.quest)
      local curCount, maxCount = DataModel.GetQuestProgress(questCA)
      table.insert(missionList, {
        index = i,
        info = info,
        questCA = questCA,
        curCount = curCount,
        maxCount = maxCount,
        isFinish = DataModel.GetIsTaskFinish(info.quest),
        goodsList = DataModel.GetQuotationGoodsList(nType == 1 and info.contentMission or info.content)
      })
    end
  end
  table.sort(missionList, function(a, b)
    if a.isFinish ~= b.isFinish then
      return not a.isFinish
    end
    return a.index < b.index
  end)
  return missionList
end

function DataModel.RefreshGoodsTradeData()
  local stationCA = DataModel.StationCA
  if not stationCA then
    DataModel.InBuffList = {}
    DataModel.OutBuffList = {}
    DataModel.InMissionList = {}
    DataModel.OutMissionList = {}
    DataModel.InProgress = {
      finishCount = 0,
      totalCount = 0,
      isMax = false
    }
    DataModel.OutProgress = {
      finishCount = 0,
      totalCount = 0,
      isMax = false
    }
    return
  end
  DataModel.InBuffList, DataModel.InProgress = BuildBuffList(stationCA.goodList)
  DataModel.OutBuffList, DataModel.OutProgress = BuildBuffList(stationCA.revenueList)
  DataModel.InMissionList = BuildMissionList(stationCA.goodList, 1)
  DataModel.OutMissionList = BuildMissionList(stationCA.revenueList, 2)
end

function DataModel.GetGoodsImagePath(contentId)
  local id = GetPositiveId(contentId)
  if not id then
    return ""
  end
  local listCA = PlayerData:GetFactoryData(id, "ListFactory")
  local quotationList = listCA and listCA.quotation or {}
  local firstQuotation = quotationList[1]
  local quotationId = firstQuotation and (firstQuotation.id or firstQuotation)
  quotationId = GetPositiveId(quotationId)
  if not quotationId then
    return ""
  end
  local quotationCA = PlayerData:GetFactoryData(quotationId, "HomeGoodsQuotationFactory")
  if not quotationCA then
    return ""
  end
  local goodsCA = PlayerData:GetFactoryData(quotationCA.goodsId, "HomeGoodsFactory")
  if not goodsCA then
    return ""
  end
  return goodsCA.imagePath or ""
end

function DataModel.GetStationCurrencyIcon()
  if not DataModel.StationCA then
    return ""
  end
  local id = DataModel.StationCA.currency or 11400001
  local itemCa = PlayerData:GetFactoryData(id, "ItemFactory")
  return itemCa.buyPath or ""
end

function DataModel.GetRoundNum(num)
  num = tonumber(num) or 0
  if 0 <= num then
    return math.floor(num + 0.5)
  end
  return math.ceil(num - 0.5)
end

function DataModel.GetStationCurrency(stationId)
  local id = 11400001
  local ca = DataModel.StationCA
  if not ca or stationId and tonumber(ca.id) ~= tonumber(stationId) then
    ca = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  end
  if not ca then
    return id
  end
  if ca.isExCity == false then
    return id
  end
  return ca.currency or id
end

function DataModel.GetTradeGoldRate()
  local stationCA = DataModel.StationCA
  local exRate = stationCA and stationCA.exRate or 80309353
  local listCA = PlayerData:GetFactoryData(exRate, "ListFactory")
  if not listCA then
    return 1
  end
  return listCA.rateNum or 1
end

function DataModel.GetMoneyBuffRate(moneyInvest)
  local tradeUpCA = PlayerData:GetFactoryData(99900219, "ConfigFactory")
  if not tradeUpCA then
    return 0
  end
  local buffRate = tradeUpCA.BuffRate or 0
  buffRate = buffRate == 0 and 1 or buffRate
  local goldRate = DataModel.GetTradeGoldRate() or 1
  local rate = math.floor((moneyInvest or 0) / (buffRate * goldRate))
  local buffFloor = math.floor((tradeUpCA.BuffFloor or 0) * 100)
  return rate <= buffFloor and rate or buffFloor
end

function DataModel.GetGoodComeNumByOffsetLv(offsetLv, buyPercent, extNum, goodQuoCA, goodCA, tagBuff, moneyRate, extra_Percent)
  if not goodQuoCA or not goodCA then
    return 0
  end
  local tradeUpdateCA = PlayerData:GetFactoryData(99900219, "ConfigFactory")
  if not tradeUpdateCA then
    return 0
  end
  offsetLv = offsetLv or 0
  buyPercent = buyPercent or 0
  extNum = extNum or 0
  tagBuff = tagBuff or 0
  moneyRate = moneyRate or 0
  local quoNum = goodQuoCA.num or 0
  local mag = tradeUpdateCA.purchaseMag or 0
  extra_Percent = extra_Percent or 0
  return (1 + buyPercent + offsetLv * mag + tagBuff + moneyRate / 100 + extra_Percent) * (quoNum + extNum)
end

function DataModel.GetQuestCostInfo(quest)
  local questCA = DataModel.GetQuestInfo(quest)
  local requireItem = questCA and questCA.requireItemList and questCA.requireItemList[1] or nil
  local itemId = requireItem and GetPositiveId(requireItem.id) or nil
  local itemCA = itemId and PlayerData:GetFactoryData(itemId, "ItemFactory") or nil
  return {
    id = itemId,
    num = requireItem and requireItem.num or 0,
    icon = itemCA and itemCA.buyPath or ""
  }
end

function DataModel.GetExInvestUnlockState(goodQuoCA)
  if not goodQuoCA then
    return false
  end
  if not GetPositiveId(goodQuoCA.unlockedQuest) then
    return true
  end
  return DataModel.GetIsTaskFinish(goodQuoCA.unlockedQuest)
end

function DataModel.GetQuestListFinishCount(questList)
  questList = questList or {}
  local finishCount = 0
  for i = 1, #questList do
    local questInfo = questList[i]
    local quest = type(questInfo) == "table" and questInfo.quest or questInfo
    if DataModel.GetIsTaskFinish(quest) then
      finishCount = finishCount + 1
    end
  end
  return finishCount, #questList
end

function DataModel.GetCurrentSpQuestId(goodQuoCA, isUnlock)
  if not goodQuoCA then
    return nil, 0
  end
  if not isUnlock then
    return DataModel.GetQuestId(goodQuoCA.unlockedQuest), 0
  end
  local questList = goodQuoCA.questList or {}
  for i = 1, #questList do
    local questInfo = questList[i]
    local quest = type(questInfo) == "table" and questInfo.quest or questInfo
    if not DataModel.GetIsTaskFinish(quest) then
      return DataModel.GetQuestId(quest), i
    end
  end
  return nil, 0
end

function DataModel.GetSpItemQuotationIdStr()
  local stationCA = DataModel.StationCA
  local exInvestList = stationCA and stationCA.exInvestList or {}
  local ids = {}
  for i = 1, #exInvestList do
    local exInfo = exInvestList[i]
    local id = GetPositiveId(type(exInfo) == "table" and exInfo.id or exInfo)
    if id then
      table.insert(ids, tostring(id))
    end
  end
  return table.concat(ids, ",")
end

function DataModel.ApplySpItemGoodsQuery(json)
  DataModel.SpItemGoodsInfo = json and json.goods_bf or {}
  DataModel.SpItemQuestTagBuff = json and json.quest_tag_bf or {}
  DataModel.SpItemCurrencyFunds = json and json.currency_funds or {}
  DataModel.SpItemGoodLvs = json and json.sid_good_lv or {}
end

function DataModel.GetSpItemBuyNum(goodQuoCA, goodCA)
  if not goodQuoCA or not goodCA then
    return 0
  end
  local goodProtoInfo = (DataModel.SpItemGoodsInfo or {})[tostring(goodQuoCA.id)] or {}
  local buyPercent = goodProtoInfo.buy_percent or 0
  local extNum = goodProtoInfo.ext_num or 0
  local tagBuff = (DataModel.SpItemQuestTagBuff or {})[tostring(goodCA.goodsType)] or 0
  local moneyId = DataModel.GetStationCurrency(DataModel.StationId)
  local moneyInvest = (DataModel.SpItemCurrencyFunds or {})[tostring(moneyId)] or 0
  local moneyRate = DataModel.GetMoneyBuffRate(moneyInvest) or 0
  local extra_Percent = goodProtoInfo.extra_percent or 0
  return DataModel.GetGoodComeNumByOffsetLv(0, buyPercent, extNum, goodQuoCA, goodCA, tagBuff, moneyRate, extra_Percent)
end

function DataModel.GetSpItemInventoryText(goodQuoCA, finishCount)
  if not goodQuoCA then
    return ""
  end
  local tradeUpdateCA = PlayerData:GetFactoryData(99900219, "ConfigFactory")
  local inventoryBaseNum = goodQuoCA.num or 0
  local inventoryPercent = tradeUpdateCA and tradeUpdateCA.inventory or 0
  local minInventory = goodQuoCA.stockMultipleMin or 0
  local goodProtoInfo = (DataModel.SpItemGoodsInfo or {})[tostring(goodQuoCA.id)] or {}
  local extraStock = goodProtoInfo.extra_stock or 0
  local stGoodLv = (DataModel.SpItemGoodLvs or {})[tostring(DataModel.StationId)] or {}
  local goodLv = stGoodLv[tostring(goodQuoCA.goodsId)] or 0
  local baseForDivide = inventoryBaseNum ~= 0 and inventoryBaseNum or 1
  local inventoryNum = minInventory + goodLv * inventoryPercent + extraStock / baseForDivide
  return tostring(DataModel.GetRoundNum(inventoryBaseNum)) .. "x" .. tostring(DataModel.GetRoundNum(inventoryNum))
end

function DataModel.RefreshSpItemData()
  DataModel.SpItemList = {}
  local stationCA = DataModel.StationCA
  local exInvestList = stationCA and stationCA.exInvestList or {}
  for i = 1, #exInvestList do
    local exInfo = exInvestList[i]
    local quotationId = GetPositiveId(type(exInfo) == "table" and exInfo.id or exInfo)
    local goodQuoCA = quotationId and PlayerData:GetFactoryData(quotationId, "HomeGoodsQuotationFactory") or nil
    local goodCA = goodQuoCA and PlayerData:GetFactoryData(goodQuoCA.goodsId, "HomeGoodsFactory") or nil
    local spInfo = {
      index = i,
      exInfo = exInfo,
      goodQuoCA = goodQuoCA,
      goodCA = goodCA,
      isUnlock = false,
      finishCount = 0,
      totalCount = 0,
      isMax = false,
      currentQuestId = nil,
      costInfo = {num = 0, icon = ""},
      lvText = "0",
      buyNum = 0,
      inventoryText = ""
    }
    if goodQuoCA and goodCA then
      local isUnlock = DataModel.GetExInvestUnlockState(goodQuoCA)
      local finishCount, totalCount = DataModel.GetQuestListFinishCount(goodQuoCA.questList)
      local isMax = isUnlock and totalCount <= finishCount
      local currentQuestId
      local questIndex = 0
      if isMax then
        currentQuestId = nil
        questIndex = 0
      else
        currentQuestId, questIndex = DataModel.GetCurrentSpQuestId(goodQuoCA, isUnlock)
      end
      local costInfo = DataModel.GetQuestCostInfo(currentQuestId)
      spInfo.isUnlock = isUnlock
      spInfo.finishCount = finishCount
      spInfo.totalCount = totalCount
      spInfo.isMax = isMax
      spInfo.currentQuestId = currentQuestId
      spInfo.costInfo = costInfo
      spInfo.lvText = isMax and "MAX" or tostring(finishCount)
      spInfo.buyNum = DataModel.GetSpItemBuyNum(goodQuoCA, goodCA)
      spInfo.inventoryText = DataModel.GetSpItemInventoryText(goodQuoCA, finishCount)
      spInfo.questCa = DataModel.GetQuestInfo(currentQuestId)
      spInfo.questIndex = questIndex or 0
    end
    table.insert(DataModel.SpItemList, spInfo)
  end
end

function DataModel.RefreshQuestServerData(currentQuests)
  if not currentQuests then
    return
  end
  PlayerData.ServerData = PlayerData.ServerData or {}
  PlayerData.ServerData.quests = PlayerData.ServerData.quests or {}
  for k, v in pairs(currentQuests) do
    local questCA = PlayerData:GetFactoryData(k, "QuestFactory")
    if questCA then
      local serverKeys = {}
      if questCA.questType == "Main" then
        table.insert(serverKeys, "mq_quests")
      elseif questCA.questType == "Side" then
        table.insert(serverKeys, "branch_quests")
      elseif questCA.questType == "Activity" then
        table.insert(serverKeys, "activity_quests")
        PlayerData.ServerData.server_quests = PlayerData.ServerData.server_quests or {}
        PlayerData.ServerData.server_quests[k] = v
      elseif questCA.questType == "ActivityAchieve" then
        table.insert(serverKeys, "activity_achieve")
      elseif questCA.questType == "ActivityDay" then
        table.insert(serverKeys, "activity_day_quests")
      end
      for i = 1, #serverKeys do
        local serverKey = serverKeys[i]
        PlayerData.ServerData.quests[serverKey] = PlayerData.ServerData.quests[serverKey] or {}
        PlayerData.ServerData.quests[serverKey][k] = v
      end
    end
  end
end

return DataModel
