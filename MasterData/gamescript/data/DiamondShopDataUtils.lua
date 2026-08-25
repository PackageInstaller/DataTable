local DiamondShopDataUtils = {}

function DiamondShopDataUtils.ResetAll()
  DiamondShopData.rechargeData = {}
  DiamondShopDataUtils.awardsData = {}
  DiamondShopData.diamondExchangeRewardStates = {}
  DiamondShopData.isInit = false
end

function DiamondShopDataUtils.OpenRechargePanel()
  if bg.IsInBattle() or SceneMgr.Instance:IsInCopies() then
    Alert.ShowStr("BacktrackCannotSkipTips")
    return
  end
  UIManager.Instance:Reopen(Urls.DiamondShopPanel)
end

function DiamondShopDataUtils.SetDiamondExchangeStates(states)
  DiamondShopData.diamondExchangeRewardStates = {}
  DiamondShopDataUtils.awardsData = {}
  if states and states.exRewardStates then
    for groupId, exchengeList in pairs(states.exRewardStates) do
      DiamondShopData.diamondExchangeRewardStates[groupId] = {}
      for _, index in pairs(exchengeList) do
        DiamondShopData.diamondExchangeRewardStates[groupId][index] = true
      end
    end
  end
  for k, v in pairs(DT.DiamondExgAward) do
    if type(v) == "table" and v.BaseSortID then
      table.insert(DiamondShopDataUtils.awardsData, v)
    end
  end
  table.sort(DiamondShopDataUtils.awardsData, function(x, y)
    return x.BaseSortID < y.BaseSortID
  end)
end

function DiamondShopDataUtils.IsDiamondExchangeGot(group, index)
  local diamondExchangeRewardStates = DiamondShopData.diamondExchangeRewardStates
  if not diamondExchangeRewardStates then
    return false
  end
  if not diamondExchangeRewardStates[group] then
    return false
  end
  return diamondExchangeRewardStates[group][index] or false
end

function DiamondShopDataUtils.ExistDiamondExchangeCanReceived()
  local awardsData = DiamondShopDataUtils.awardsData
  if not awardsData then
    return false
  end
  local exchangeNum = MainShopDataUtils.GetExchangeNum()
  local totalExchange = awardsData[#awardsData].NeedTotalExchange
  local cyclesNum = math.ceil(exchangeNum / totalExchange) + 1
  for i = 1, cyclesNum do
    for j = 1, #awardsData do
      local curExchangeNum = totalExchange * (i - 1) + awardsData[j].NeedTotalExchange
      if exchangeNum >= curExchangeNum and not DiamondShopDataUtils.IsDiamondExchangeGot(i, j) then
        return true
      end
    end
  end
  return false
end

function DiamondShopDataUtils.GetCanReceiveDiamondExchangeIndexes()
  local result = {}
  local awardsData = DiamondShopDataUtils.awardsData
  if not awardsData or 0 == #awardsData then
    return result
  end
  local exchangeNum = MainShopDataUtils.GetExchangeNum()
  local totalExchange = awardsData[#awardsData].NeedTotalExchange
  local cyclesNum = math.ceil(exchangeNum / totalExchange) + 1
  local groupMap = {}
  for i = 1, cyclesNum do
    for j = 1, #awardsData do
      local curExchangeNum = totalExchange * (i - 1) + awardsData[j].NeedTotalExchange
      if exchangeNum >= curExchangeNum and not DiamondShopDataUtils.IsDiamondExchangeGot(i, j) then
        groupMap[i] = groupMap[i] or {}
        table.insert(groupMap[i], j)
      end
    end
  end
  for group, indexList in pairs(groupMap) do
    table.insert(result, {group = group, indexes = indexList})
  end
  return result
end

function DiamondShopDataUtils.RechargeTips(num, confirmCallBack)
  local perPayBuyDiamond = 1
  num = math.ceil(num / perPayBuyDiamond)
  Alert.Show(20069, nil, function()
    if ItemDataUtils.GetPayMoneyTotalNum() < num then
      DiamondShopDataUtils.ChargeNotEnoughTips()
      return
    end
    DiamondShopDataUtils.ReqExchange(num, confirmCallBack)
  end, LT.Text("ExchangeConfirmTitle"), LT.Textf("ExchangeConfirmText", num))
  local costData = {
    tid = CommonDefine.CurrencyType.PayMoney,
    num = num
  }
  Alert.ShowCoin({
    CommonDefine.CurrencyType.PayMoney
  }, true, costData)
end

function DiamondShopDataUtils.ReqExchange(num, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "Exchange", function(svrData)
    Logger.Debug("Exchange Successful", table.tostring(svrData))
    MainShopDataUtils.SetExchangeNum(svrData)
    if callback then
      callback()
    end
  end, function(svrData)
    Logger.Debug("Exchange Fail", table.tostring(svrData))
  end, num)
end

function DiamondShopDataUtils.ExchangeGainReward(group, index, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "ExchangeGainReward", function(svrData)
    Logger.Debug("Exchange Successful", table.tostring(svrData))
    DiamondShopData.diamondExchangeRewardStates[group] = DiamondShopData.diamondExchangeRewardStates[group] or {}
    DiamondShopData.diamondExchangeRewardStates[group][index] = true
    if callback then
      callback()
    end
    GlobalDispatcher:Dispatch(NotifyId.OnGetDiamondExchangeAwards, group, index)
  end, function(svrData)
    Logger.Debug("ExchangeGainReward Fail", table.tostring(svrData))
  end, group, index)
end

function DiamondShopDataUtils.ExchangeGainRewardBatchAll(callback)
  local canReceiveIndexes = DiamondShopDataUtils.GetCanReceiveDiamondExchangeIndexes()
  for _, groupData in ipairs(canReceiveIndexes) do
    DiamondShopDataUtils.ExchangeGainRewardBatch(groupData.group, groupData.indexes, callback)
  end
end

function DiamondShopDataUtils.ExchangeGainRewardBatch(group, indexList, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "ExchangeGainRewardBatch", function(svrData)
    Logger.Debug("ExchangeGainRewardBatch Successful (from ExchangeGainReward_BatchCompatible)", table.tostring(svrData))
    DiamondShopData.diamondExchangeRewardStates[group] = DiamondShopData.diamondExchangeRewardStates[group] or {}
    for _, idx in pairs(indexList) do
      DiamondShopData.diamondExchangeRewardStates[group][idx] = true
    end
    if callback then
      callback()
    end
    GlobalDispatcher:Dispatch(NotifyId.OnGetDiamondExchangeAwardsBatch, group, indexList)
  end, function(svrData)
    Logger.Debug("ExchangeGainRewardBatch Fail (from ExchangeGainReward_BatchCompatible)", table.tostring(svrData))
  end, group, indexList)
end

function DiamondShopDataUtils.ChargeNotEnoughTips(callback)
  Alert.SetMaskClickClose(true)
  Alert.Show(20069, nil, function()
    local function openFunc()
      if callback then
        callback()
      end
      UIManager.Instance:Reopen(Urls.ChargeMainPanel)
    end
    
    FuncJumpManager.JumpToFuncPanel(nil, openFunc)
  end, LT.Text("CurrencyNotEnoughTitle"), LT.Text("CurrencyNotEnoughText"))
end

function DiamondShopDataUtils.GetBuyCount(tid)
  if DiamondShopData.rechargeData[tid] then
    return DiamondShopData.rechargeData[tid].num
  else
    return 0
  end
end

function DiamondShopDataUtils.UpdateData(data)
  local tid = data.tid
  DiamondShopData.rechargeData[tid] = data
end

return DiamondShopDataUtils
