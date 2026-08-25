local AlchemyDataUtils = {}
AlchemyDataUtils.alchemyPanelMap = {
  Compose = Urls.AlchemyCompositePanel,
  Decompose = Urls.AlchemyDecomposePanel
}

function AlchemyDataUtils.ResetAll()
  DataCenter.alchemyData.compositeList = {}
  DataCenter.alchemyData.decomposeList = {}
  DataCenter.alchemyData.recastList = {}
  DataCenter.alchemyData.decomposeCfgPreParseGroup = {}
  ItemAlchemyUtils.ParseAlchemyFormat()
end

function AlchemyDataUtils.OpenAlchemyPanel(type, model)
  if not type then
    UIManager.Instance:Reopen(Urls.AlchemyMainPanel)
    return
  end
  UIManager.Instance:Reopen(AlchemyDataUtils.alchemyPanelMap[type], model)
end

function AlchemyDataUtils.ComposeItem(tid, composeNum)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnItemCompose", function(data)
    Logger.Debug("GameRequest OnItemCompose Successful", table.tostring(data))
    local items = {}
    for awardTid, awardInfo in pairs(data) do
      table.insert(items, {
        tid = awardTid,
        changedNum = awardInfo.amount,
        uid = 0,
        extraOrigin = awardInfo.extraOrigin
      })
    end
    ItemDataUtils.ShowRewardPanel(LT.Text("ItemGain_String_MainTitle"), "", items)
    AlchemyCompositeExtModel.Instance:DelRemainCompositeTime(tid, composeNum)
  end, function(data)
    Logger.Debug("GameRequest OnItemCompose Failed", table.tostring(data))
  end, tid, composeNum)
end

function AlchemyDataUtils.ReqMultiCompose(compositeItems)
  local composeList = {}
  for _, data in pairs(compositeItems) do
    composeList[data.id] = data.count
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnAutoComposeList", function()
    print("一键合成同步成功！")
    local items = {}
    for awardTid, awardNum in pairs(composeList) do
      table.insert(items, {
        tid = awardTid,
        changedNum = awardNum,
        uid = 0
      })
    end
    ItemDataUtils.ShowRewardPanel(LT.Text("ItemGain_String_MainTitle"), "", items)
  end, function(_, code)
    Logger.Error("一键合成同步失败！错误码: %s", code.code)
  end, composeList)
end

function AlchemyDataUtils.ExchangeItem(tid, exchangeGroup, callback, notShow)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnMaterialExchange", function(data)
    Logger.Debug("GameRequest OnMaterialExchange Successful", table.tostring(data))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Debug("GameRequest OnMaterialExchange Failed", table.tostring(data))
  end, tid, exchangeGroup, notShow)
end

function AlchemyDataUtils.ReqOnConversionRemainCountGet()
  ProtoManager.Instance:ReqServer("GameRequest", "OnConversionRemainCountGet", function(data)
    Logger.Debug("GameRequest OnConversionRemainCountGet", table.tostring(data))
    AlchemyCompositeExtModel.Instance:UpdateCompositeRemainCountInfo(data)
    AlchemyCompositeExtModel.Instance:UpdateData()
  end, function(data)
    Logger.Debug("GameRequest OnConversionRemainCountGet Failed", table.tostring(data))
  end)
end

function AlchemyDataUtils.ReqGetExchangePlan()
  ProtoManager.Instance:ReqServer("GameRequest", "OnExchangePlanGet", function(data)
    Logger.Debug("GameRequest OnExchangePlanGet Successful", table.tostring(data))
    local ret = {}
    for _, itemTid in ipairs(data[1]) do
      ret[itemTid] = true
    end
    AlchemyExchangeExtModel.Instance:UpdateExchangePlan(ret)
  end, function(data)
    Logger.Debug("GameRequest OnExchangePlanGet Failed", table.tostring(data))
  end)
end

function AlchemyDataUtils.ReqSaveExchangePlan(callback)
  local ret = {}
  local exchangePlan = AlchemyExchangeExtModel.Instance:GetExchangePlan()
  for itemTid, _ in pairs(exchangePlan) do
    table.insert(ret, itemTid)
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnExchangePlanSet", function(data)
    Logger.Debug("GameRequest OnExchangePlanSet Successful", table.tostring(data))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Debug("GameRequest OnExchangePlanSet Failed", table.tostring(data))
  end, ret)
end

function AlchemyDataUtils.DecomposeItem(uidGroup, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnItemDecompose", function(data)
    Logger.Debug("GameRequest OnItemDecompose Successful", table.tostring(data))
    AwakerTrinketExtModel.Instance:DeleteTrinkets(uidGroup)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Debug("GameRequest OnItemDecompose Failed", table.tostring(data))
  end, uidGroup, 1)
end

function AlchemyDataUtils.DecomposeList(uid2NumDict, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnDecomposeList", function(data)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Debug("GameRequest OnDecomposeList Failed", table.tostring(data))
  end, uid2NumDict)
end

function AlchemyDataUtils.RecastItem(tid, trinketUidList, successfulCb)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnItemRecasting", function(data)
    if successfulCb then
      successfulCb()
    end
    Logger.Debug("GameRequest OnItemRecasting Successful", table.tostring(data))
  end, function(data)
    Logger.Debug("GameRequest OnItemRecasting Failed", table.tostring(data))
  end, tid, trinketUidList)
end

function AlchemyDataUtils.ReqAlchemyData(type)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenItemConversion", function(data)
    Logger.Debug("GameRequest OnOpenItemConversion " .. type, table.tostring(data))
    AlchemyDataUtils.ParseAlchemyData(data, type)
  end, nil, type)
end

function AlchemyDataUtils.CloseAlchemyPanel(type)
  if not type then
    UIManager.Instance:CloseByUrl(Urls.AlchemyMainPanel)
    return
  end
  UIManager.Instance:CloseByUrl(AlchemyDataUtils.alchemyPanelMap[type])
end

function AlchemyDataUtils.ParseAlchemyData(data, type)
  if type == AlchemyDefine.AlchemyType.Compose then
    DataCenter.alchemyData.compositeList = data
  elseif type == AlchemyDefine.AlchemyType.Decompose then
    DataCenter.alchemyData.decomposeList = data
  elseif type == AlchemyDefine.AlchemyType.Recast then
    DataCenter.alchemyData.recastList = data
  end
end

function AlchemyDataUtils.GetRecastList()
  return DataCenter.alchemyData.recastList
end

function AlchemyDataUtils.PreParseDecompositeConversion()
  if table.next(DataCenter.alchemyData.decomposeCfgPreParseGroup) then
    do return table.clone end
    return table.clone, DataCenter.alchemyData.decomposeCfgPreParseGroup, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  local rstMap = {}
  local decompositeCheckCfgGroup = {}
  for _, cfg in pairs(DT.ItemConversion) do
    if cfg.ConversionType == AlchemyDefine.AlchemyType.Decompose then
      table.insert(decompositeCheckCfgGroup, cfg)
    end
  end
  for _, cfg in pairs(decompositeCheckCfgGroup) do
    local consumeItemList = cfg.ConsumeItem
    local consumeItemTids = {}
    local consumeItemNum = {}
    local convertItemList = cfg.ItemsGet
    local convertItemTids = {}
    local convertItemNum = {}
    local idx = 1
    while idx <= #consumeItemList do
      table.insert(consumeItemTids, consumeItemList[idx])
      table.insert(consumeItemNum, consumeItemList[idx + 1])
      idx = idx + 2
    end
    idx = 1
    while idx <= #convertItemList do
      table.insert(convertItemTids, convertItemList[idx])
      table.insert(convertItemNum, convertItemList[idx + 1])
      idx = idx + 2
    end
    local itemTid = consumeItemTids[1]
    local itemNum = consumeItemTids[2]
    local itemCfg = DT.Item[itemTid]
    local itemType = itemCfg.Type
    rstMap[cfg.ID] = {
      itemType = itemType,
      itemTid = itemTid,
      consumeItemTids = consumeItemTids,
      consumeItemNum = consumeItemNum,
      convertItemTids = convertItemTids,
      convertItemNum = convertItemNum,
      itemNum = itemNum,
      ID = cfg.ID
    }
  end
  DataCenter.alchemyData.decomposeCfgPreParseGroup = rstMap
  return rstMap
end

return AlchemyDataUtils
