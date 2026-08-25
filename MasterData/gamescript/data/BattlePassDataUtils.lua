local BattlePassData = DataCenter.battlePassData
local BpPrivilegeLevel = CommonDefine.BpPrivilegeLevel
local BpChestSubTypeList = {
  CommonDefine.ItemSubType.Chest,
  CommonDefine.ItemSubType.AwakerChest,
  CommonDefine.ItemSubType.WeaponChest
}
local BattlePassDataUtils = {}

local function BuildBpRwardData(tid, num, pvlgLevel, level, haveReceive)
  local rstData = {
    tid = tid,
    num = num or 0,
    bpRewardType = pvlgLevel or BpPrivilegeLevel.Ordinary,
    unlockLevel = level or 1,
    haveReceive = haveReceive or false
  }
  return rstData
end

function BattlePassDataUtils.OpenBattlePassPanel()
  UIManager.Instance:Reopen(Urls.BattlePassMainPanel)
end

function BattlePassDataUtils.OnBuyLevelClick(model)
  UIManager.Instance:Reopen(Urls.BattlePassExchangePanel, model)
end

function BattlePassDataUtils.CheckOpenBpUnlockTips(closeCb)
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.BattlePass, PlayerDataUtils.GetFeatureMainTypeKey())
  if not BattlePassDataUtils.GetIsNew() or not unlocked then
    return
  end
  local bpId = BattlePassDataUtils.GetTid()
  if BattlePassData.isNew and 0 ~= bpId then
    BattlePassDataUtils.SetIsNew(false)
    local cfg = DT.BattlePass[bpId]
    local showData = {
      title = LT.Text("BPNewOpenTitle"),
      desc = LT.Textf("BPNewOpenContent", LT.Text(cfg.Name))
    }
    UIManager.Instance:CloseByUrl(Urls.BattlePassMainPanel)
    UIManager.Instance:Reopen(Urls.MainPanel)
    UIManager.Instance:Reopen(Urls.FeatureUnlockPanel, showData, closeCb)
    return true
  end
end

function BattlePassDataUtils.InitBPData(svrData)
  BattlePassDataUtils.LoadConfigData()
  BattlePassDataUtils.LoadServerData(svrData)
end

function BattlePassDataUtils.LoadConfigData()
  for _, config in pairs(DT.BPAward) do
    local level = config.Level
    for tid, num in pairs(config.FreeAward) do
      BattlePassDataUtils.Set_rewardMap(tid, BpPrivilegeLevel.Ordinary, level, BuildBpRwardData(tid, num, BpPrivilegeLevel.Ordinary, level))
    end
    for tid, num in pairs(config.PayAward) do
      BattlePassDataUtils.Set_rewardMap(tid, BpPrivilegeLevel.Advanced, level, BuildBpRwardData(tid, num, BpPrivilegeLevel.Advanced, level))
    end
  end
end

function BattlePassDataUtils.ResetData()
  BattlePassData.rewardMap = {}
  BattlePassData.rewardList = {}
  BattlePassData.level = 0
  BattlePassData.exp = 0
  BattlePassData.weeklyExp = 0
  BattlePassData.privilegeLevel = BpPrivilegeLevel.Ordinary
  BattlePassData.isChargeDLC = false
  BattlePassData.startTs = 0
  BattlePassData.endTs = 0
  BattlePassData.isNew = false
  BattlePassDataUtils.LoadConfigData()
end

function BattlePassDataUtils.LoadServerData(svrData)
  if svrData.bpID and svrData.bpID ~= BattleData.tid then
    BattlePassDataUtils.ResetData()
    BattlePassDataUtils.SetTid(svrData.bpID)
  end
  if svrData.extraLvAwardNum then
    BattlePassDataUtils.SetExtraLvAwardNum(svrData.extraLvAwardNum)
  end
  if svrData.level then
    BattlePassDataUtils.SetLevel(svrData.level)
  end
  if svrData.exp then
    BattlePassDataUtils.SetExp(svrData.exp)
  end
  if svrData.weeklyExp then
    BattlePassDataUtils.SetWeeklyExp(svrData.weeklyExp)
  end
  if svrData.privilegeLevel then
    BattlePassDataUtils.SetPrivilegeLevel(svrData.privilegeLevel)
  end
  if svrData.rewardMap then
    BattlePassDataUtils.SetRewardMap(svrData.rewardMap)
  end
  if svrData.startTs then
    BattlePassDataUtils.SetStartTs(svrData.startTs)
  end
  if svrData.endTs then
    BattlePassDataUtils.SetEndTs(svrData.endTs)
  end
  if svrData.isNew then
    BattlePassDataUtils.SetIsNew(svrData.isNew)
  end
  if svrData.dailyNotGainExtraReward then
    BattlePassDataUtils.SetDailyNotGainExtraReward(svrData.dailyNotGainExtraReward)
  end
  BattlePassDataUtils.UpdateRewardList()
  GlobalDispatcher:Dispatch(NotifyId.OnBattlePassDataChanged)
end

function BattlePassDataUtils.OnSyncBPData(svrData)
  if svrData.bpID and svrData.bpID ~= BattleData.tid then
    BattlePassDataUtils.ResetData()
    BattlePassDataUtils.SetTid(svrData.bpID)
  end
  if svrData.extraLvAwardNum then
    BattlePassDataUtils.SetExtraLvAwardNum(svrData.extraLvAwardNum)
  end
  if svrData.level then
    BattlePassDataUtils.SetLevel(svrData.level)
  end
  if svrData.exp then
    BattlePassDataUtils.SetExp(svrData.exp)
  end
  if svrData.weeklyExp then
    BattlePassDataUtils.SetWeeklyExp(svrData.weeklyExp)
  end
  if svrData.privilegeLevel then
    BattlePassDataUtils.SetPrivilegeLevel(svrData.privilegeLevel)
  end
  if svrData.rewardMap then
    BattlePassDataUtils.SetRewardMap(svrData.rewardMap)
  end
  if svrData.startTs then
    BattlePassDataUtils.SetStartTs(svrData.startTs)
  end
  if svrData.endTs then
    BattlePassDataUtils.SetEndTs(svrData.endTs)
  end
  if svrData.isNew then
    BattlePassDataUtils.SetIsNew(svrData.isNew)
  end
  if svrData.dailyNotGainExtraReward then
    BattlePassDataUtils.SetDailyNotGainExtraReward(svrData.dailyNotGainExtraReward)
  end
  BattlePassDataUtils.UpdateRewardList()
  GlobalDispatcher:Dispatch(NotifyId.OnBattlePassDataChanged)
end

function BattlePassDataUtils.OpenLevelUpTips(numLevel)
  UIManager.Instance:Reopen(Urls.BattlePassLevelUpTips, numLevel)
end

function BattlePassDataUtils.UpdateRewardMap(newData, level)
  local tid = newData.itemId
  local privilegeLevel = newData.privType
  local num = BattlePassDataUtils.GetRewardNum(level, privilegeLevel, tid)
  local haveReceive = true
  if not BattlePassData.rewardMap[level] then
    return
  end
  if not BattlePassDataUtils.GetRewardByTwoLevel(level, privilegeLevel, tid) then
    BattlePassData.rewardMap[level][privilegeLevel][tid] = BuildBpRwardData(tid, num, privilegeLevel, level, haveReceive)
    return
  end
  for key, val in pairs(newData) do
    BattlePassData.rewardMap[level][privilegeLevel][tid][key] = val
  end
  BattlePassData.rewardMap[level][privilegeLevel][tid].haveReceive = true
end

function BattlePassDataUtils.BuyBpLevel(numLevel, callBack)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnBuyBpLevel", function(data)
    Logger.Debug("========== 购买等级成功 ==========\n", table.tostring(data or {}))
    if callBack then
      callBack()
    end
  end, function(data)
    Logger.Debug("========== 购买等级失败 ==========\n", table.tostring(data or {}))
  end, numLevel)
end

function BattlePassDataUtils.ReceiveRewardAll(rewardList)
  local multiRewardList = {}
  for _, data in pairs(rewardList) do
    local itemCfg = DT.Item[data.tid]
    if table.contains(BpChestSubTypeList, itemCfg.SubType) then
      table.insert(multiRewardList, data)
    end
  end
  
  local function protoFunc(selectedList)
    BattlePassDataUtils.ReqRewardAll(selectedList)
  end
  
  if 0 == #multiRewardList then
    protoFunc(rewardList)
    return
  end
  UIManager.Instance:Reopen(Urls.BattlePassSelectRewardTips, multiRewardList, protoFunc)
end

function BattlePassDataUtils.ReceiveRewardSingle(tblData)
  local multiRewardList = {}
  local itemCfg = DT.Item[tblData.tid]
  if table.contains(BpChestSubTypeList, itemCfg.SubType) then
    table.insert(multiRewardList, tblData)
  end
  
  local function protoFunc(selectedList)
    BattlePassDataUtils.ReqRewardSingle(selectedList)
  end
  
  if 0 == #multiRewardList then
    protoFunc({tblData})
    return
  end
  UIManager.Instance:Reopen(Urls.BattlePassSelectRewardTips, multiRewardList, protoFunc)
end

function BattlePassDataUtils.GetBpPriceList(bpTid)
  local isDoubleEx = BattlePassDataUtils.IsDoubleExBP(bpTid)
  if isDoubleEx then
    do return DT.GetOriginalConstant end
    return DT.GetOriginalConstant, "DoubleExBPPriceList"
  end
  do return DT.GetOriginalConstant end
  return DT.GetOriginalConstant, "BPPriceList"
end

function BattlePassDataUtils.IsDoubleExBP(bpTid)
  bpTid = bpTid or BattlePassDataUtils.GetTid()
  do return BattlePassCfgUtils.GetCfgField, "IFDoubleEx" end
  return BattlePassCfgUtils.GetCfgField, "IFDoubleEx", bpTid
end

function BattlePassDataUtils.ExecuteBuyBp(key, callback, withPreview, price)
  if withPreview then
    local showRewardList = {}
    local dailyNotGainExtraReward = BattlePassDataUtils.GetDailyNotGainExtraReward()
    for tid, num in pairs(dailyNotGainExtraReward) do
      table.insert(showRewardList, {tid = tid, num = num})
    end
    table.sort(showRewardList, ItemDataUtils.CommonItemSortFunc)
    local viewData = {
      title = LT.Text("Shop_Confirm_Buy_Str_Title"),
      topDesc = LT.Text("BPAdvanceBuyConfirmTipTopDesc"),
      bottomDesc = LT.Textf("BPAdvanceBuyConfirmTipBottomDesc", price),
      rewardInfoList = showRewardList,
      confirmFunc = function()
        BattlePassDataUtils.ReqOnBuyBp(key, callback)
      end
    }
    UIManager.Instance:Reopen(Urls.BuyConfirmPreviewView, viewData)
    return
  end
  Alert.ShowPayMoneyBuyConfirm(price, function()
    BattlePassDataUtils.ReqOnBuyBp(key, callback)
  end)
end

function BattlePassDataUtils.ReqOnBuyBp(key, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnBuyBp", function(data)
    Logger.Debug("========== 购买BP成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Debug("========== 购买BP失败 ==========\n", table.tostring(data or {}))
  end, key)
end

function BattlePassDataUtils.ReqRewardSingle(rewardList)
  EventMgr.Instance.OpenReqMask:Dispatch()
  local rewardData = rewardList[1]
  ProtoManager.Instance:ReqServer("GameRequest", "OnGetReward", function(data)
    Logger.Debug("========== 领取道具成功 ==========\n", table.tostring(data or {}))
  end, function(data)
    Logger.Debug("========== 领取道具失败 ==========\n", table.tostring(data or {}))
  end, rewardData.level, rewardData.privType, rewardData.tid, rewardData.chooseTid or 0)
end

function BattlePassDataUtils.ReqReceiveTaskAll()
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OneKeyGainTaskPrize", function(data)
    Logger.Debug("========== 一键领取任务成功 ==========\n", table.tostring(data or {}))
    if data.taskUids then
      for _, uid in pairs(data.taskUids) do
        local taskData = TaskDataUtils.GetTaskData(uid)
        taskData.state = CommonDefine.TaskState.Done
        TaskDataUtils.UpdateTask(taskData)
      end
    end
  end, function(data)
    Logger.Debug("========== 一键领取任务失败 ==========\n", table.tostring(data or {}))
  end)
end

function BattlePassDataUtils.ReqRewardAll(rewardList)
  local sendData = {}
  for _, data in pairs(rewardList) do
    local level = data.level
    local privType = data.privType
    local tid = data.tid
    local chooseTid = data.chooseTid
    if not sendData[level] then
      sendData[level] = {}
    end
    if not sendData[level][privType] then
      sendData[level][privType] = {}
    end
    sendData[level][privType][tid] = chooseTid or 0
  end
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnGetRewardAll", function(data)
    Logger.Debug("========== 一键领取成功 ==========\n", table.tostring(data or {}))
  end, function(data)
    Logger.Debug("========== 一键领取失败 ==========\n", table.tostring(data or {}))
  end, sendData)
end

function BattlePassDataUtils.ReqOnGetExtraAward()
  ProtoManager.Instance:ReqServer("GameRequest", "OnGetExtraAward", function(data)
    Logger.Debug("========== 领取额外奖励成功 ==========\n", table.tostring(data or {}))
  end, function(data)
    Logger.Debug("========== 领取额外奖励失败 ==========\n", table.tostring(data or {}))
  end)
end

function BattlePassDataUtils.SetRewardMap(tblVal)
  if not tblVal then
    return
  end
  for level, receiveItems in pairs(tblVal) do
    for _, dataList in pairs(receiveItems) do
      for _, data in pairs(dataList) do
        BattlePassDataUtils.UpdateRewardMap(data, level)
      end
    end
  end
end

function BattlePassDataUtils.SetStartTs(numVal)
  if not numVal then
    return
  end
  BattlePassData.startTs = numVal
end

function BattlePassDataUtils.SetTid(numVal)
  if not numVal then
    return
  end
  print("-------------------setTid", numVal)
  BattlePassData.tid = numVal
  if 0 == numVal then
    BattlePassDataUtils.ResetData()
  end
end

function BattlePassDataUtils.SetEndTs(numVal)
  if not numVal then
    return
  end
  BattlePassData.endTs = numVal
end

function BattlePassDataUtils.SetDailyNotGainExtraReward(tblVal)
  if not tblVal then
    return
  end
  BattlePassData.dailyNotGainExtraReward = tblVal
end

function BattlePassDataUtils.GetDailyNotGainExtraReward()
  return BattlePassData.dailyNotGainExtraReward or {}
end

function BattlePassDataUtils.SetLevel(numVal)
  if not numVal then
    return
  end
  EventMgr.Instance.BpLevelChange:Dispatch(numVal)
  BattlePassData.level = numVal
end

function BattlePassDataUtils.SetIsNew(boolVal)
  BattlePassData.isNew = boolVal
end

function BattlePassDataUtils.SetExp(numVal)
  if not numVal then
    return
  end
  BattlePassData.exp = math.min(numVal, BattlePassDataUtils.GetLevelUpExp())
  EventMgr.Instance.BpExpSliderAnim:Dispatch()
end

function BattlePassDataUtils.SetWeeklyExp(numVal)
  if not numVal then
    return
  end
  BattlePassData.weeklyExp = numVal
end

function BattlePassDataUtils.SetPrivilegeLevel(numVal)
  if not numVal then
    return
  end
  BattlePassData.privilegeLevel = numVal
  EventMgr.Instance.BpPrivilegeLevelChange:Dispatch()
end

function BattlePassDataUtils.SetIsChargeDLC(boolVal)
  if nil == boolVal then
    return
  end
  BattlePassData.isChargeDLC = boolVal
end

function BattlePassDataUtils.SetExtraLvAwardNum(numVal)
  if nil == numVal then
    return
  end
  local oldVal = BattlePassData.extraLvAwardNum
  BattlePassData.oldExtraLvAwardNum = oldVal
  BattlePassData.extraLvAwardNum = numVal
end

function BattlePassDataUtils.GetExtraLvAwardNum()
  return BattlePassData.extraLvAwardNum
end

function BattlePassDataUtils.GetOldExtraLvAwardNum()
  return BattlePassData.oldExtraLvAwardNum
end

function BattlePassDataUtils.GetRewardItemState(bpLevel, privilegeLevel, tid)
  local tblData = BattlePassDataUtils.GetRewardByTwoLevel(bpLevel, privilegeLevel, tid)
  if tblData.haveReceive then
    return CommonDefine.BpRewardState.HaveReceive
  end
  if tblData.unlockLevel > BattlePassDataUtils.GetLevel() then
    return CommonDefine.BpRewardState.LockByLevel
  end
  if tblData.bpRewardType > BattlePassDataUtils.GetPrivilegeLevel() then
    return CommonDefine.BpRewardState.LockByMoney
  end
  return CommonDefine.BpRewardState.CanReceive
end

function BattlePassDataUtils.GetMaxBpLevel()
  local rst = 0
  for _, data in pairs(DT.BPAward) do
    rst = math.max(rst, data.Level)
  end
  return rst
end

function BattlePassDataUtils.GetRewardNum(bpLevel, privilegeLevel, tid)
  for _, config in pairs(DT.BPAward) do
    if config.Level == bpLevel then
      if privilegeLevel == CommonDefine.BpPrivilegeLevel.Ordinary then
        return config.FreeAward[tid] or nil
      elseif privilegeLevel == CommonDefine.BpPrivilegeLevel.Advanced then
        return config.PayAward[tid] or nil
      end
    end
  end
  return nil
end

function BattlePassDataUtils.GetStartCountDown()
  local startTs = BattlePassDataUtils.GetStartTs()
  local curTs = TimeUtils.GetServerTime()
  if startTs > curTs then
    local openCountDown = startTs - curTs
    local d, h = TimeUtils.ConvertTime(openCountDown)
    do return LT.Textf, "BPOpenPreviewTxt", d end
    return LT.Textf, "BPOpenPreviewTxt", d, h
  end
  return nil
end

function BattlePassDataUtils.GetAwardLevelNum()
  local rst = 0
  for _, tbl1 in pairs(BattlePassDataUtils.GetRewardMap()) do
    for _, tbl2 in pairs(tbl1) do
      for _, data in pairs(tbl2) do
        if BattlePassDataUtils.GetRewardItemState(data.unlockLevel, data.bpRewardType, data.tid) == CommonDefine.BpRewardState.CanReceive and 0 ~= data.unlockLevel then
          rst = rst + 1
          goto lbl_37
        end
      end
    end
    ::lbl_37::
  end
  return rst
end

function BattlePassDataUtils.GetEndCountDown()
  local endTs = BattlePassDataUtils.GetEndTs()
  local curTs = TimeUtils.GetServerTime()
  if endTs > curTs then
    local openCountDown = endTs - curTs
    local d, h, m = TimeUtils.ConvertTime(openCountDown)
    if openCountDown >= 86400 then
      do return LT.Textf, "BattlePassLeftTimeMore", d end
      return LT.Textf, "BattlePassLeftTimeMore", d, h
    end
    do return LT.Textf, "BattlePassLeftTimeLess", h end
    return LT.Textf, "BattlePassLeftTimeLess", h, m
  end
end

function BattlePassDataUtils.GetBPConfig()
  local tid = BattlePassDataUtils.GetTid()
  return DT.BattlePass[tid]
end

function BattlePassDataUtils.GetLevelUpExp()
  local bpCfg = BattlePassDataUtils.GetBPConfig()
  return bpCfg and bpCfg.BPExpPerLv or 0
end

function BattlePassDataUtils.GetRewardByTwoLevel(bpLevel, privilegeLevel, tid)
  if not (bpLevel and privilegeLevel) or not tid then
    return nil
  end
  return BattlePassData.rewardMap and BattlePassData.rewardMap[bpLevel] and BattlePassData.rewardMap[bpLevel][privilegeLevel] and BattlePassData.rewardMap[bpLevel][privilegeLevel][tid]
end

function BattlePassDataUtils.Set_rewardMap(tid, bpPrivilegeLevel, level, bpRewardData)
  if not BattlePassData.rewardMap[level] then
    BattlePassData.rewardMap[level] = {}
  end
  if not BattlePassData.rewardMap[level][bpPrivilegeLevel] then
    BattlePassData.rewardMap[level][bpPrivilegeLevel] = {}
  end
  BattlePassData.rewardMap[level][bpPrivilegeLevel][tid] = bpRewardData
end

function BattlePassDataUtils.GetRewardList()
  return BattlePassData.rewardList
end

function BattlePassDataUtils.UpdateRewardList()
  local rst = {}
  for _, tbl1 in pairs(BattlePassDataUtils.GetRewardMap()) do
    for _, tbl2 in pairs(tbl1) do
      for _, data in pairs(tbl2) do
        table.insert(rst, data)
      end
    end
  end
  BattlePassData.rewardList = rst
end

function BattlePassDataUtils.GetIsFirstEnterBp()
  local ret = RedPointDataUtils.GetRedData(RedPointDataUtils.RedType.BattlePass)
  ret = ret and (ret.isNew and true or false)
  return ret
end

function BattlePassDataUtils.GetStartTs()
  return BattlePassData.startTs
end

function BattlePassDataUtils.GetEndTs()
  return BattlePassData.endTs
end

function BattlePassDataUtils.GetItemEndTs()
  local bpTid = BattlePassDataUtils.GetTid()
  if not bpTid then
    return
  end
  local cfgList = BattlePassDataUtils.GetBpConfigsList()
  local curIndex = -1
  for i = 1, #cfgList do
    if cfgList[i].ID == bpTid then
      curIndex = i
      break
    end
  end
  if -1 == curIndex then
    return
  end
  for i = curIndex, #cfgList do
    local cfg = cfgList[i]
    if cfg and 1 == cfg.IFRecycleBPLimitItem then
      return cfg.CloseDate
    end
  end
end

function BattlePassDataUtils.GetBpConfigsList()
  if BattlePassDataUtils._sortedBpList then
    return BattlePassDataUtils._sortedBpList
  end
  BattlePassDataUtils._sortedBpList = {}
  for _, cfg in pairs(DT.BattlePass) do
    table.insert(BattlePassDataUtils._sortedBpList, cfg)
  end
  table.sort(BattlePassDataUtils._sortedBpList, function(x, y)
    return x.BaseSortID < y.BaseSortID
  end)
  return BattlePassDataUtils._sortedBpList
end

function BattlePassDataUtils.GetRewardMap()
  return BattlePassData.rewardMap
end

function BattlePassDataUtils.GetExp()
  do return math.min, BattlePassData.exp, BattlePassDataUtils.GetLevelUpExp() end
  return math.min, BattlePassData.exp, BattlePassDataUtils.GetLevelUpExp()
end

function BattlePassDataUtils.GetWeeklyExp()
  return BattlePassData.weeklyExp
end

function BattlePassDataUtils.IsDoubleEx()
  local bpCfg = BattlePassDataUtils.GetBPConfig() or {}
  local isDoubleEx = 1 == bpCfg.IFDoubleEx
  return isDoubleEx, bpCfg.OpenDate, bpCfg.CloseDate
end

function BattlePassDataUtils.IsShowDoubleBpTag()
  local _, isUnlock = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.BattlePass, 0)
  if not isUnlock then
    return false
  end
  if not BattlePassDataUtils.IsDoubleEx() then
    return false
  end
  local todayHide = ClientDataUtils.GetClientSubData(cd.ClientSubKey.TodayHideDoubleBpTag, cd.NumberFalse)
  if todayHide == cd.NumberTrue then
    return false
  end
  return true
end

function BattlePassDataUtils.GetTid()
  return BattlePassData.tid
end

function BattlePassDataUtils.IsRoleExp(tid)
  local cfgList = DT.GetOriginalConstant("PVPandDailyChallengeRewardLimit")
  local expId = cfgList[1]
  local result = tid == expId
  return result
end

function BattlePassDataUtils.GetLevel()
  return BattlePassData.level
end

function BattlePassDataUtils.GetPrivilegeLevel()
  return BattlePassData.privilegeLevel
end

function BattlePassDataUtils.IsCore()
  return BattlePassData.privilegeLevel >= CommonDefine.BpPrivilegeLevel.Core
end

function BattlePassDataUtils.GetIsChargeDLC()
  return BattlePassData.isChargeDLC
end

function BattlePassDataUtils.GetIsNew()
  return BattlePassData.isNew
end

function BattlePassDataUtils.CheckIsMaxLevel()
  return BattlePassDataUtils.GetLevel() >= BattlePassDataUtils.GetMaxBpLevel()
end

function BattlePassDataUtils.OpenBuyCore()
  if BattlePassDataUtils.IsCore() then
    return
  end
  local isJumpToBuy = true
  UIManager.Instance:Reopen(Urls.BpMainView, isJumpToBuy)
end

return BattlePassDataUtils
