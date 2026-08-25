local LimitTimeGiftUtils = {}

function LimitTimeGiftUtils.GetShopDatas()
  LimitTimeGiftUtils.actIndexMap = {}
  local giftList = ActivityManager.Instance.model:GetTimeLimitGiftActivities()
  local ret = {}
  for index, actData in ipairs(giftList) do
    LimitTimeGiftUtils.actIndexMap[actData.tid] = index
    if actData.endTime > TimeUtils.GetServerTime() then
      local exampleData = {
        lock = false,
        maxBuyCount = -1,
        refreshTime = 0,
        uid = 0,
        tid = 0,
        price = 0,
        isSell = false,
        discount = 0,
        actTid = actData.tid
      }
      table.insert(ret, exampleData)
    end
  end
  return ret
end

function LimitTimeGiftUtils.GetItemAndPrice(actTid)
  local taskTid = LimitTimeGiftUtils.GetFirstTaskTid(actTid)
  local price, priceItemTid = TaskDataUtils.GetTaskPrice(taskTid)
  return priceItemTid or 0, price or 0
end

function LimitTimeGiftUtils.GetFirstTaskTid(actTid)
  local activityCfg = DT.Activity[actTid]
  for _, taskTid in ipairs(activityCfg.ActivityPara1) do
    if not TaskDataUtils.TaskFinshAndGetedAward(taskTid) then
      return taskTid
    end
  end
end

function LimitTimeGiftUtils.OpenPanel(actTid)
  if not actTid then
    return
  end
  local giftList = ActivityManager.Instance.model:GetTimeLimitGiftActivities()
  if #giftList > 0 then
    UIManager.Instance:Reopen(Urls.LimitTimeGiftPanel, giftList, LimitTimeGiftUtils.actIndexMap[actTid])
  end
end

function LimitTimeGiftUtils.GetEndTimeByActTid(actTid)
  if not actTid then
    return 0
  end
  local giftList = ActivityManager.Instance.model:GetTimeLimitGiftActivities()
  for _, actData in ipairs(giftList) do
    if actData.tid == actTid then
      return actData.endTime
    end
  end
  return nil
end

function LimitTimeGiftUtils.GetShortestEndTime()
  local giftList = ActivityManager.Instance.model:GetTimeLimitGiftActivities()
  local shortestEndTime
  for _, actData in ipairs(giftList) do
    if actData.endTime and actData.endTime > TimeUtils.GetServerTime() and (nil == shortestEndTime or shortestEndTime > actData.endTime) then
      shortestEndTime = actData.endTime
    end
  end
  return shortestEndTime
end

function LimitTimeGiftUtils.CollectShopItemTidSet(activityCfg, result)
  if not activityCfg or not activityCfg.ActivityPara1 then
    return
  end
  if activityCfg.ActivityType == ActivityDefine.ActivityType.FirstTimeLimitedSale then
    for _, shopItemTid in ipairs(activityCfg.ActivityPara1) do
      result[shopItemTid] = true
    end
  else
    for _, taskTid in ipairs(activityCfg.ActivityPara1) do
      local shopItemTid = TaskDataUtils.GetNeededShopItem(taskTid)
      if shopItemTid then
        result[shopItemTid] = true
      end
    end
  end
end

function LimitTimeGiftUtils.GetAllLimitGiftShopItemTidSet()
  if LimitTimeGiftUtils._allLimitGiftShopItemTidSet then
    return LimitTimeGiftUtils._allLimitGiftShopItemTidSet
  end
  local result = {}
  local activityTypeList = {
    ActivityDefine.ActivityType.TaskList,
    ActivityDefine.ActivityType.FirstTimeLimitedSale
  }
  local sysTypeList = {
    TriggerOnceEvent = true,
    PeriodTrigger = true,
    LimitedTimeSale = true
  }
  for _, cfg in pairs(DT.Activity or {}) do
    if table.contains(activityTypeList, cfg.ActivityType) and sysTypeList[cfg.ActivitySystemType] then
      LimitTimeGiftUtils.CollectShopItemTidSet(cfg, result)
    end
  end
  LimitTimeGiftUtils._allLimitGiftShopItemTidSet = result
  return result
end

function LimitTimeGiftUtils.GetValidLimitGiftShopItemTidSet()
  local giftList = ActivityManager.Instance.model:GetTimeLimitGiftActivities()
  local result = {}
  for _, actData in ipairs(giftList) do
    local activityCfg = DT.Activity[actData.activityTid]
    LimitTimeGiftUtils.CollectShopItemTidSet(activityCfg, result)
  end
  return result
end

function LimitTimeGiftUtils.IsExpiredLimitGiftShopItem(shopItemTid)
  if not shopItemTid then
    return false
  end
  local allSet = LimitTimeGiftUtils.GetAllLimitGiftShopItemTidSet()
  if not allSet[shopItemTid] then
    return false
  end
  local validSet = LimitTimeGiftUtils.GetValidLimitGiftShopItemTidSet()
  return not validSet[shopItemTid]
end

return LimitTimeGiftUtils
