local BackTrackAwardPreviewUtils = {}

function BackTrackAwardPreviewUtils.BackTrackAwakerLv(awakerData)
  local itemList = {}
  local awakerId = awakerData.tid
  local expTotal = AwakerDataUtils.GetExpUpgradeEx(awakerId, 1, awakerData.level) + awakerData.exp
  local expItemId1Cnt = math.ceil(expTotal / 10000)
  local expItemId2Cnt = math.ceil((expTotal - 10000 * expItemId1Cnt) / 2000)
  local expItemId3Cnt = math.ceil((expTotal - 10000 * expItemId1Cnt - 2000 * expItemId2Cnt) / 500)
  local expCntMap = {
    [1] = expItemId1Cnt,
    [3] = expItemId2Cnt,
    [5] = expItemId3Cnt
  }
  local oriList = DT.GetOriginalConstant("AwakerExpItem")
  local listCnt = #oriList
  for i = 1, listCnt, 2 do
    local itemData = {
      itemId = oriList[i],
      itemCount = expCntMap[i]
    }
    table.insert(itemList, itemData)
  end
  local rate = DT.GetConstant("AwakerExpCoinRatio")
  local coinCnt = expTotal * rate
  local coinData = {
    itemTid = CommonDefine.CurrencyType.JuniorMoney,
    itemCount = coinCnt
  }
  table.insert(itemList, coinData)
  local requireItemList = AwakerDataUtils.GetAwakerLimitIncreaseRequireItem(awakerId)
  for i = 1, #requireItemList, 2 do
    local itemId = requireItemList[i]
    local cnt = requireItemList[i + 1]
    local changeData = BackTrackAwardPreviewUtils.GetItemDataByTransform(itemId, cnt)
    table.insert(itemList, changeData)
  end
  return itemList
end

function BackTrackAwardPreviewUtils.BackTrackAwakerBreakthrough(awakerData)
  local itemList = {}
  local awakerId = awakerData.tid
  local cfg = DT.AwakerBreakThrough[awakerId]
  local star = awakerData.currBreakthroughStar
  for i = 1, star do
    local currStarCfg = cfg.data_list[i]
    local mtrlCostToNextStar, _ = AwakerDataUtils._GetBreakthroughCost(currStarCfg)
    local changeData = BackTrackAwardPreviewUtils.GetItemDataByTransform(mtrlCostToNextStar.id, mtrlCostToNextStar.count)
    table.insert(itemList, changeData)
  end
  return itemList
end

function BackTrackAwardPreviewUtils.BackTrackAwakerPotency(_awakerData)
end

function BackTrackAwardPreviewUtils.GetItemDataByTransform(itemId, cnt)
  local ratio = 1
  local changeItemId = itemId
  local cfg = ItemDataUtils.GetItemConfig(itemId)
  if cfg.BackTrackItemTransform then
    changeItemId = cfg.BackTrackItemTransform[1]
    ratio = cfg.BackTrackItemTransform[2]
  end
  local changeData = {
    itemId = changeItemId,
    itemCount = ratio * cnt
  }
  return changeData
end

return BackTrackAwardPreviewUtils
