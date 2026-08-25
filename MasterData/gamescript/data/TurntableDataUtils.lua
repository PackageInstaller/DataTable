local TurntableDataUtils = {}
local TurntableData = Vue.reactive({})

function TurntableDataUtils.Reset()
  TurntableData.data = {}
end

function TurntableDataUtils.GetTurntableData(tid)
  return TurntableData.data[tid]
end

function TurntableDataUtils.SetTurntableData(tid, data)
  TurntableData.data[tid] = data
end

function TurntableDataUtils.GetTurntableCfg(tid)
  return DT.Turntable[tid]
end

function TurntableDataUtils.ReqServerData(turntableTid, callback)
  if not TurntableDataUtils.GetTurntableData(turntableTid) then
    TurntableDataUtils.SetTurntableData(turntableTid, {})
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenTurntable", function(data, ret)
    print("OnOpenTurntable", table.tostring(data), table.tostring(ret))
    TurntableDataUtils.SetTurntableData(turntableTid, data)
    if callback then
      callback()
    end
  end, function(data, ret)
    Logger.Error("OnOpenTurntable", table.tostring(data), table.tostring(ret))
  end, turntableTid)
end

function TurntableDataUtils.RefreshServerData(turntableTid)
  TurntableDataUtils.ReqServerData(turntableTid)
end

function TurntableDataUtils.ReqDrawReward(turntableTid)
  ProtoManager.Instance:ReqServer("GameRequest", "OnTurntable", function(data, ret)
    print("OnTurntable", table.tostring(data), table.tostring(ret))
    local turntableRewardLevel = TurntableDataUtils.GetTurntableRewardLevel(turntableTid, data)
    EventMgr.Instance.TurntableRewardLevel:Dispatch(turntableRewardLevel)
    TurntableDataUtils.RefreshServerData(turntableTid)
  end, function(data, ret)
    Logger.Error("OnTurntable", table.tostring(data), table.tostring(ret))
  end, turntableTid)
end

function TurntableDataUtils.GetCurTurntableTid()
  local actModel = ActivityManager.Instance.model
  local activityType = ActivityDefine.ActivityType.TurntableActivity
  local activityList = actModel:GetActivityListByTypeAndSysType(activityType, nil)
  if 0 == #activityList then
    Logger.Error("当前未开启转盘活动")
    return nil
  end
  local activityData = activityList[1]
  local activityTid = activityData.activityTid
  local activityConfg = ActivityDataUtils.GetConfig(activityTid)
  local turntableTid = activityConfg and activityConfg.ActivityPara1 and activityConfg.ActivityPara1[1]
  return turntableTid
end

function TurntableDataUtils.GetCurTurntableCfg()
  local turntableTid = TurntableDataUtils.GetCurTurntableTid()
  do return TurntableDataUtils.GetTurntableCfg end
  return TurntableDataUtils.GetTurntableCfg, turntableTid
end

function TurntableDataUtils.ShowSkinTicketBuyPanel()
  local curActivityTurntableTid = TurntableDataUtils.GetCurTurntableTid()
  local turntableData = TurntableDataUtils.GetTurntableData(curActivityTurntableTid)
  if not turntableData then
    TurntableDataUtils.ReqServerData(curActivityTurntableTid, TurntableDataUtils.ShowSkinTicketBuyPanel)
    return
  end
  local turntableCfg = TurntableDataUtils.GetTurntableCfg(curActivityTurntableTid)
  local buyTid = turntableCfg.Cost[1]
  local TurntableCostItemExchange = turntableCfg.CostChange
  local costId, costNum = table.unpack(TurntableCostItemExchange)
  local maxBuyCount = TurntableDataUtils.GetMaxSkinTicketBuyCount(curActivityTurntableTid)
  local buyData = {
    buyTid = buyTid,
    costTid = costId,
    costNum = costNum,
    maxBuyCount = maxBuyCount,
    buyFunc = function(buyCount)
      if buyCount <= 0 then
        Alert.ShowStr(LT.Text("StoreSoldOut"))
        return
      end
      ProtoManager.Instance:ReqServer("GameRequest", "OnExchangeTurntableCost", function(data, ret)
        print("OnExchangeTurntableCost", table.tostring(data))
        TurntableDataUtils.RefreshServerData(curActivityTurntableTid)
        UIManager.Instance:CloseByUrl(Urls.ItemBuyPanel)
      end, function(data, ret)
        print("OnExchangeTurntableCost failed", table.tostring(data))
      end, curActivityTurntableTid, buyCount)
    end
  }
  UIManager.Instance:Reopen(Urls.ItemBuyPanel, buyData)
end

function TurntableDataUtils.ShowRatePanel(turntableTid)
  local curRateList = TurntableDataUtils.GetCurRateList(turntableTid)
  local initRateList = TurntableDataUtils.GetInitRateList(turntableTid)
  UIManager.Instance:Reopen(Urls.TurntableRatePanel, curRateList, initRateList)
end

function TurntableDataUtils.GetCurRateList(turntableTid)
  local turntableData = TurntableDataUtils.GetTurntableData(turntableTid)
  local dropMap = TurntableDataUtils.GetDropMap(turntableTid)
  local currItems = turntableData.items
  local totalWeight = 0
  for _, item in pairs(currItems) do
    totalWeight = totalWeight + item.WeightOrRate
  end
  local rateMap = {}
  for _, item in pairs(currItems) do
    local rate = item.WeightOrRate / totalWeight
    rateMap[item.dropItemId] = rate
  end
  local rateList = {}
  table.insert(rateList, {
    groupName = LT.Text("TitleReward")
  })
  table.insert(rateList, {
    content = LT.Text("TitleRewardItems")
  })
  table.insert(rateList, {
    content = LT.Text("TitleRate")
  })
  local turntableCfg = TurntableDataUtils.GetTurntableCfg(turntableTid)
  for rewardLevel = 1, 10 do
    local itemRare = turntableCfg["ItemRare" .. rewardLevel]
    if not itemRare then
      break
    end
    table.insert(rateList, {
      groupName = LT.Text("PrizeNum" .. rewardLevel)
    })
    for _, dropItemId in pairs(itemRare) do
      local item = dropMap[dropItemId]
      table.insert(rateList, {
        content = ItemNumUtils.GetStr(item.itemTid, item.itemCount)
      })
      if item.StartDropAfter and item.StartDropAfter - 1 > (turntableData.turnNum or 0) then
        table.insert(rateList, {
          content = LT.Textf("GetConditionStr", item.StartDropAfter)
        })
      else
        table.insert(rateList, {
          content = rateMap[dropItemId] and string.format("%.4f%%", rateMap[dropItemId] * 100) or LT.Text("AlreadyGot")
        })
      end
    end
  end
  return rateList
end

function TurntableDataUtils.GetDropItemCurRate(turntableTid, dropItemId)
  local turntableData = TurntableDataUtils.GetTurntableData(turntableTid)
  local currItems = turntableData.items
  local totalWeight = 0
  for _, item in pairs(currItems) do
    totalWeight = totalWeight + item.WeightOrRate
  end
  for _, item in pairs(currItems) do
    if item.dropItemId == dropItemId then
      return item.WeightOrRate / totalWeight
    end
  end
  return 0
end

function TurntableDataUtils.GetInitRateList(turntableTid)
  local dropMap = TurntableDataUtils.GetDropMap(turntableTid)
  local totalWeight = 0
  for _, item in pairs(dropMap) do
    totalWeight = totalWeight + item.WeightOrRate * (item.DropNumLimit or 1)
  end
  local rateMap = {}
  for _, item in pairs(dropMap) do
    local rate = item.WeightOrRate * (item.DropNumLimit or 1) / totalWeight
    rateMap[item.dropItemId] = rate
  end
  local rateList = {}
  table.insert(rateList, {
    groupName = LT.Text("TitleReward")
  })
  table.insert(rateList, {
    content = LT.Text("TitleRewardItems")
  })
  table.insert(rateList, {
    content = LT.Text("TitleRate")
  })
  local turntableCfg = TurntableDataUtils.GetTurntableCfg(turntableTid)
  for rewardLevel = 1, 10 do
    local itemRare = turntableCfg["ItemRare" .. rewardLevel]
    if not itemRare then
      break
    end
    table.insert(rateList, {
      groupName = LT.Text("PrizeNum" .. rewardLevel)
    })
    for _, dropItemId in pairs(itemRare) do
      local item = dropMap[dropItemId]
      table.insert(rateList, {
        content = ItemNumUtils.GetStr(item.itemTid, item.itemCount)
      })
      table.insert(rateList, {
        content = rateMap[dropItemId] and string.format("%.4f%%", rateMap[dropItemId] * 100) or ""
      })
    end
  end
  return rateList
end

function TurntableDataUtils.GetDropMap()
  local turntableCfg = TurntableDataUtils.GetCurTurntableCfg()
  local dropId = turntableCfg.DropIds[1]
  local dropCfg = DT.Drop[dropId]
  local dropMap = {}
  for _, info in ipairs(dropCfg.data_list) do
    local data = table.clone(info)
    data.itemTid = info.DropItem
    data.itemCount = info.DropNum
    data.dropNumLimit = info.DropNumLimit or 1
    data.dropItemId = info.DropItemId
    dropMap[data.dropItemId] = data
  end
  return dropMap
end

function TurntableDataUtils.GetTurntableRewardLevel(turntableId, data)
  local turntableCfg = TurntableDataUtils.GetTurntableCfg(turntableId)
  local level = 10
  for _, item in ipairs(data.items or {}) do
    local dropItemId = item.dropItemId
    for i = 1, 10 do
      local itemRare = turntableCfg["ItemRare" .. i]
      if itemRare and table.contains(itemRare, dropItemId) then
        level = math.min(level, i)
      end
    end
  end
  return level
end

function TurntableDataUtils.GetCostId(turntableTid)
  local turntableCfg = TurntableDataUtils.GetTurntableCfg(turntableTid)
  local costId = turntableCfg.Cost[1]
  return costId
end

function TurntableDataUtils.GetCostPrice(turntableTid)
  local turntableCfg = TurntableDataUtils.GetTurntableCfg(turntableTid)
  local turntableData = TurntableDataUtils.GetTurntableData(turntableTid)
  local turnNum = turntableData.turnNum or 0
  local costPrice = turntableCfg.Cost[turnNum + 2]
  costPrice = costPrice or turntableCfg.Cost[#turntableCfg.Cost]
  return costPrice
end

function TurntableDataUtils.GetMaxSkinTicketBuyCount(turntableTid)
  local turntableData = TurntableDataUtils.GetTurntableData(turntableTid)
  if not turntableData then
    return 0
  end
  return turntableData.maxNeed or 0
end

function TurntableDataUtils.IsGot(turntableTid, dropItemId)
  local turntableData = TurntableDataUtils.GetTurntableData(turntableTid)
  local dropItemCfg = TurntableDataUtils.GetDropCfgItems(turntableTid, dropItemId)
  if not turntableData or not dropItemCfg then
    return false
  end
  local itemTid = dropItemCfg.DropItem
  local itemCfg = ItemDataUtils.GetItemConfig(itemTid)
  if itemCfg and itemCfg.Type == cd.ItemType.SkinItem and AwakerSkinUtils.IsOwnSkin(itemTid) then
    return true
  end
  if dropItemCfg.StartDropAfter and (turntableData.turnNum or 0) < dropItemCfg.StartDropAfter then
    return false
  end
  local item = TurntableDataUtils.GetItem(turntableTid, dropItemId)
  return not item or item.dropNum > 0
end

function TurntableDataUtils.GetCfgMaxDropNum(turntableTid, dropItemId)
  local dropCfgItem = TurntableDataUtils.GetDropCfgItems(turntableTid, dropItemId)
  return dropCfgItem.dropNumLimit or 1
end

function TurntableDataUtils.GetDropNum(turntableTid, dropItemId)
  local data = TurntableDataUtils.GetTurntableData(turntableTid)
  local dropCfg = TurntableDataUtils.GetDropCfgItems(turntableTid, dropItemId)
  if dropCfg.StartDropAfter and (data.turnNum or 0) < dropCfg.StartDropAfter then
    return 0
  end
  local item = TurntableDataUtils.GetItem(turntableTid, dropItemId)
  if not item then
    do return TurntableDataUtils.GetCfgMaxDropNum, turntableTid end
    return TurntableDataUtils.GetCfgMaxDropNum, turntableTid, dropItemId
  end
  return item.dropNum or 0
end

function TurntableDataUtils.GetDropLeftNum(turntableTid, dropItemId)
  local cfgMaxDropNum = TurntableDataUtils.GetCfgMaxDropNum(turntableTid, dropItemId)
  local dropNum = TurntableDataUtils.GetDropNum(turntableTid, dropItemId)
  return cfgMaxDropNum - dropNum
end

function TurntableDataUtils.GetItem(turntableTid, dropItemId)
  local turntableData = TurntableDataUtils.GetTurntableData(turntableTid)
  if not turntableData then
    return nil
  end
  for _, item in ipairs(turntableData.items or {}) do
    if item.dropItemId == dropItemId then
      return item
    end
  end
  return nil
end

function TurntableDataUtils.GetDropCfgItems(turntableTid, dropItemId)
  local dropMap = TurntableDataUtils.GetDropMap(turntableTid)
  return dropMap[dropItemId]
end

function TurntableDataUtils.IsPoolEmpty(turntableTid)
  local dropMap = TurntableDataUtils.GetDropMap(turntableTid)
  for dropItemId, _ in pairs(dropMap) do
    if TurntableDataUtils.GetDropLeftNum(turntableTid, dropItemId) > 0 then
      return false
    end
  end
  return true
end

return TurntableDataUtils
