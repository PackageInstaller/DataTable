local ActivityDrawPrizeController = NewClass("ActivityDrawPrizeController", BaseController)

function ActivityDrawPrizeController:OnInit()
end

function ActivityDrawPrizeController:OnReset()
end

function ActivityDrawPrizeController:OpenActivityDrawPrizePoolView(lotteryTidList)
  ActivityDrawPrizeModel.Instance:SetShowLotteryList(lotteryTidList)
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenLottery", function(data)
    Logger.Info("========== 打开活动奖池成功 ==========\n", table.tostring(data or {}))
    ActivityDrawPrizeModel.Instance:UpdateAllPrizePoolDataBySvrData(data)
    UIManager.Instance:Reopen(Urls.ActivityDrawPrizeMainView)
  end, function(data)
    Logger.Info("========== 打开活动奖池失败 ==========\n", table.tostring(data or {}))
  end)
end

function ActivityDrawPrizeController:OpenActivityDrawPrizeResultView(data)
  UIManager.Instance:Reopen(Urls.ActivityDrawPrizeResultView, data)
end

function ActivityDrawPrizeController:ReqReset(tid, callback)
  local coreResetRemain = ActivityDrawPrizeModel.Instance:GetCoreResetRemainTime(tid)
  local coreResetTime = ActivityDrawPrizeModel.Instance:GetLotteryCfgByField("ResetTimes", tid)
  local coreRewardRemain = ActivityDrawPrizeModel.Instance:GetPrizePoolRemainLimit(tid, CommonDefine.LotteryRewardType.Core)
  local tipTid
  if coreRewardRemain > 0 and coreResetRemain > 0 then
    tipTid = 20154
  else
    tipTid = 20153
  end
  local desc = LT.Textf(DT.TipsType[tipTid].Desc, coreResetTime + 1)
  
  local function alertCb()
    ProtoManager.Instance:ReqServer("GameRequest", "OnResetLottery", function(data)
      Logger.Info("========== 重置奖池成功 ==========\n", table.tostring(data or {}))
      ActivityDrawPrizeModel.Instance:UpdateAllPrizePoolDataBySvrData({
        [tid] = data
      })
      Alert.Show(10829)
      if callback then
        callback()
      end
    end, function(data)
      Logger.Info("========== 重置奖池失败 ==========\n", table.tostring(data or {}))
    end, tid)
  end
  
  Alert.Show(tipTid, nil, alertCb, nil, desc)
end

function ActivityDrawPrizeController:ReqLottery(tid, drawTime, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnLottery", function(data)
    Logger.Info("========== 抽取奖池成功 ==========\n", table.tostring(data or {}))
    local poolData = data.pool or {}
    ActivityDrawPrizeModel.Instance:UpdateAllPrizePoolDataBySvrData({
      [tid] = poolData
    })
    local svrData = {
      hasCoreAward = data.hasCoreAward,
      items = data.items
    }
    if callback then
      callback(svrData)
    end
    EventMgr.Instance.OnActivityDrawPrizeLottery:Dispatch()
  end, function(data)
    Logger.Info("========== 抽取奖池失败 ==========\n", table.tostring(data or {}))
  end, tid, drawTime)
end

function ActivityDrawPrizeController:OnGetAllLotteryMultipleDrawTimes(lotteryId)
  ProtoManager.Instance:ReqServer("GameRequest", "OnGetAllLotteryMultipleDrawTimes", function(data)
    Logger.Info("========== 获取全部交换的抽奖次数成功 ==========\n", table.tostring(data or {}))
    ActivityDrawPrizeModel.Instance:UpdateAllLotteryMultipleDrawTimes(data)
  end, function(data)
    Logger.Info("========== 获取全部交换的抽奖次数失败 ==========\n", table.tostring(data or {}))
  end, lotteryId)
end

function ActivityDrawPrizeController:ReqAllLottery(lotteryId, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnAllLottery", function(data)
    Logger.Info("========== 全部交换抽奖成功 ==========\n", table.tostring(data or {}))
    local poolData = data.pool or {}
    ActivityDrawPrizeModel.Instance:UpdateAllPrizePoolDataBySvrData({
      [lotteryId] = poolData
    })
    local svrData = {
      hasCoreAward = data.hasCoreAward,
      items = data.items
    }
    if callback then
      callback(svrData)
    end
    EventMgr.Instance.OnActivityDrawPrizeLottery:Dispatch()
  end, function(data)
    Logger.Info("========== 全部交换抽奖失败 ==========\n", table.tostring(data or {}))
  end, lotteryId)
end

return ActivityDrawPrizeController
