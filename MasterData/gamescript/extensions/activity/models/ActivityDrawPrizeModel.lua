local LotteryPage = CommonDefine.LotteryPage
local ActivityDrawPrizeModel = NewClass("ActivityDrawPrizeModel", BaseModel)

function ActivityDrawPrizeModel:OnInit()
  self.allPrizePoolData = {}
  self.rewardGroupViewsData = {}
  self.tabGroupViewsData = {}
  self.resetLimit = 0
  self.drawRewards = {}
  self.allLotteryMultipleDrawTimes = 0
  self:InitAllPrizePoolDataByCfg()
  self:Init_tabGroupViewsData()
  self:InitViewData()
  self:UpdateViewData()
end

function ActivityDrawPrizeModel:SetShowLotteryList(lotteryList)
  self:Init_tabGroupViewsData()
  if lotteryList then
    for i = #self.tabGroupViewsData, 1, -1 do
      local lotteryTid = self.tabGroupViewsData[i]
      if not table.contains(lotteryList, lotteryTid) then
        table.remove(self.tabGroupViewsData, i)
      end
    end
  end
  self:InitViewData()
end

function ActivityDrawPrizeModel:InitViewData()
  local defaultTab = self.tabGroupViewsData[1] or 0
  for _, lotteryTid in ipairs(self.tabGroupViewsData) do
    local remain, resetTime = self:GetPrizePoolRemainResetTime(lotteryTid, CommonDefine.LotteryRewardType.Core)
    local isEmpty = remain <= 0 and resetTime <= 0
    local openCountDown = self:GetPrizePoolOpenCountDown(lotteryTid)
    local isOpened = openCountDown <= 0
    if not isEmpty and isOpened then
      defaultTab = lotteryTid
      break
    end
  end
  self.curSelectTab = defaultTab
  self.curPage = LotteryPage.Pool
end

function ActivityDrawPrizeModel:Get_allPrizePoolData()
  return self.allPrizePoolData or {}
end

function ActivityDrawPrizeModel:GetPrizePoolData(tid)
  local allPoolData = self:Get_allPrizePoolData()
  return allPoolData[tid] or {}
end

function ActivityDrawPrizeModel:GetPrizePoolDataByField(field, tid)
  local prizePoolData = self:GetPrizePoolData(tid)
  return prizePoolData[field]
end

function ActivityDrawPrizeModel:Set_allPrizePoolData(tbl)
  self.allPrizePoolData = tbl
end

function ActivityDrawPrizeModel:SetPrizePoolData(tid, tbl)
  if not self.allPrizePoolData then
    return
  end
  self.allPrizePoolData[tid] = tbl
end

function ActivityDrawPrizeModel:SetPrizePoolDataByField(field, tid, val)
  if not (self.allPrizePoolData and self.allPrizePoolData[tid]) or not self.allPrizePoolData[tid][field] then
    return
  end
  self.allPrizePoolData[tid][field] = val
end

function ActivityDrawPrizeModel:UpdatePrizePoolData(tid, tbl)
  for key, newVal in pairs(tbl) do
    local oriVal = self:GetPrizePoolDataByField(key, tid)
    if not oriVal or type(oriVal) ~= type(newVal) then
      self:SetPrizePoolDataByField(key, tid, newVal)
    end
  end
end

function ActivityDrawPrizeModel:Print_allPrizePoolData()
  for key, val in pairs(self:Get_allPrizePoolData()) do
    print("ActivityDrawPrizeModel self.allPrizePoolData." .. key .. ": " .. table.tostring(val))
  end
end

function ActivityDrawPrizeModel:Set_curSelectTab(nVal)
  self.curSelectTab = nVal
  self:UpdateViewData()
  self:LocalNotify(NotifyId.OnActivityDrawPrizePoolTabChanged, self.curSelectTab)
end

function ActivityDrawPrizeModel:Init_tabGroupViewsData()
  self.tabGroupViewsData = {}
  local cfgGroup = {}
  for _, cfg in pairs(DT.Lottery) do
    table.insert(cfgGroup, cfg)
  end
  table.sort(cfgGroup, function(a, b)
    return a.BaseSortID < b.BaseSortID
  end)
  for _, cfg in ipairs(cfgGroup) do
    table.insert(self.tabGroupViewsData, cfg.ID)
  end
end

function ActivityDrawPrizeModel:GetCoreResetRemainTime(lotteryTid)
  local resetTime = self:GetPrizePoolDataByField("resetTime", lotteryTid)
  local coreResetTime = self:GetLotteryCfgByField("ResetTimes", lotteryTid)
  do return math.max, 0 end
  return math.max, 0, coreResetTime - resetTime
end

function ActivityDrawPrizeModel:GetPrizePoolRemainResetTime(lotteryTid, rewardType)
  local remain, _ = self:GetPrizePoolRemainLimit(lotteryTid, rewardType)
  local resetTime = self:GetCoreResetRemainTime(lotteryTid)
  return remain, resetTime
end

function ActivityDrawPrizeModel:GetPrizePoolIsDrawOut(lotteryTid)
  local nomarlRemain, _ = ActivityDrawPrizeModel.Instance:GetPrizePoolRemainResetTime(lotteryTid, CommonDefine.LotteryRewardType.Normal)
  local coreRemain, _ = ActivityDrawPrizeModel.Instance:GetPrizePoolRemainResetTime(lotteryTid, CommonDefine.LotteryRewardType.Core)
  return nomarlRemain <= 0 and coreRemain <= 0
end

function ActivityDrawPrizeModel:UpdateViewData()
  local lotteryTid = self.curSelectTab
  local prizePoolData = self:GetPrizePoolData(lotteryTid)
  self.resetLimit = self:GetLotteryCfgByField("ResetTimes", self.curSelectTab) or 0
  self.rewardGroupViewsData = {}
  if not prizePoolData.prizeDataGroup then
    return
  end
  local prizeDataGroup = prizePoolData.prizeDataGroup
  for _, prizeData in pairs(prizeDataGroup) do
    if not self.rewardGroupViewsData[prizeData.type] then
      self.rewardGroupViewsData[prizeData.type] = {}
    end
    table.insert(self.rewardGroupViewsData[prizeData.type], prizeData)
  end
  for idx, rewardGroup in pairs(self.rewardGroupViewsData) do
    table.sort(rewardGroup, function(a, b)
      if 0 == a.remain and 0 ~= b.remain then
        return false
      end
      if 0 == b.remain and 0 ~= a.remain then
        return true
      end
      if 0 == a.limit then
        return false
      end
      if 0 == b.limit then
        return true
      end
      return a.sortIdx < b.sortIdx
    end)
    self.rewardGroupViewsData[idx] = rewardGroup
  end
end

function ActivityDrawPrizeModel:InitAllPrizePoolDataByCfg()
  if table.next(self:Get_allPrizePoolData()) then
    return
  end
  for _, cfg in pairs(DT.Lottery) do
    local prizeDataGroup = {}
    local dropWeight = cfg.DropWeight
    for i = 1, #dropWeight, 2 do
      local dropId = dropWeight[i]
      local dropLimit = dropWeight[i + 1]
      if not dropId or not dropLimit then
      else
        local dropType = CommonDefine.LotteryRewardType.Normal
        if table.contains(cfg.CoreDrop or {}, dropId) then
          dropType = CommonDefine.LotteryRewardType.Core
        end
        local dropCfg = self:GetFirstDropCfg(dropId)
        if not dropCfg then
        else
          local prizeData = self:CreateDrawPrizeData(dropCfg.DropItem, dropLimit, dropLimit, dropType, i, dropId, dropCfg.DropNum)
          table.insert(prizeDataGroup, prizeData)
        end
      end
    end
    self:SetPrizePoolData(cfg.ID, self:CreateDrawPrizePoolData(cfg.ID, cfg.ResetTimes, prizeDataGroup))
  end
end

function ActivityDrawPrizeModel:CreateUnlimitDrawPrizeData(dropId, dropType, prizeDataGroup)
  for idx, dropData in pairs(DT.Drop[dropId].data_list) do
    local tid = dropData.DropItem
    local limit = 0
    local prizeData = self:CreateDrawPrizeData(tid, limit, limit, dropType, idx, dropId, dropData.DropNum)
    table.insert(prizeDataGroup, prizeData)
  end
  return prizeDataGroup
end

function ActivityDrawPrizeModel:UpdateAllPrizePoolDataBySvrData(svrData)
  for lotteryTid, poolSvrData in pairs(svrData) do
    local poolViewData = self:GetPrizePoolData(lotteryTid)
    if table.isempty(poolViewData) then
    else
      poolViewData.resetTime = poolSvrData.resetTime
      local prizeDataGroup = poolViewData.prizeDataGroup
      local dropId2RemainItemNumMap = poolSvrData.dropResult or {}
      for idx, prizeData in pairs(prizeDataGroup) do
        local dropedNum = dropId2RemainItemNumMap[prizeData.dropId] and dropId2RemainItemNumMap[prizeData.dropId].count or 0
        prizeData.remain = prizeData.limit - dropedNum
        prizeDataGroup[idx] = prizeData
      end
      poolViewData.prizeDataGroup = prizeDataGroup
      self:SetPrizePoolData(lotteryTid, poolViewData)
    end
  end
  self:UpdateViewData()
  self:LocalNotify(NotifyId.OnActivityLotteryDataUpdated)
end

function ActivityDrawPrizeModel:UpdateAllLotteryMultipleDrawTimes(svrData)
  if svrData and svrData.multipleDrawTimes then
    self.allLotteryMultipleDrawTimes = svrData.multipleDrawTimes or 0
    self:LocalNotify(NotifyId.UpdateAllLotteryMultipleDrawTimes)
  end
end

function ActivityDrawPrizeModel:GetAllLotteryMultipleDrawTimes()
  return self.allLotteryMultipleDrawTimes
end

function ActivityDrawPrizeModel:GetFirstDropCfg(dropId)
  return DT.Drop[dropId] and DT.Drop[dropId].data_list and DT.Drop[dropId].data_list[1]
end

function ActivityDrawPrizeModel:GetLotteryMultiDropTime(lotteryTid)
  local nomarlRemain, _ = ActivityDrawPrizeModel.Instance:GetPrizePoolRemainResetTime(lotteryTid, CommonDefine.LotteryRewardType.Normal)
  local coreRemain, _ = ActivityDrawPrizeModel.Instance:GetPrizePoolRemainResetTime(lotteryTid, CommonDefine.LotteryRewardType.Core)
  local allRemain = nomarlRemain + coreRemain
  do return math.min, allRemain end
  return math.min, allRemain, self:GetLotteryCfgByField("MultipleDraw", lotteryTid) or 0, self, "MultipleDraw", lotteryTid
end

function ActivityDrawPrizeModel:GetLotteryCfg(tid)
  return DT.Lottery[tid] or {}
end

function ActivityDrawPrizeModel:GetLotteryCfgByField(field, tid)
  local cfg = self:GetLotteryCfg(tid)
  return cfg[field]
end

function ActivityDrawPrizeModel:GetRewardItemRewardType(lotteryTid, itemTid, num)
  local prizeDataGroup = self:GetPrizePoolDataByField("prizeDataGroup", lotteryTid)
  for _, prizeData in pairs(prizeDataGroup) do
    if prizeData.tid == itemTid and prizeData.dropNum == num then
      return prizeData.type
    end
  end
  return nil
end

function ActivityDrawPrizeModel:GetPrizePoolRemainLimit(tid, rewardType)
  local prizeDataGroup = self:GetPrizePoolDataByField("prizeDataGroup", tid)
  do return self.GetRemainLimitByPrizeDatas, self, prizeDataGroup end
  return self.GetRemainLimitByPrizeDatas, self, prizeDataGroup, rewardType
end

function ActivityDrawPrizeModel:GetPrizePoolCanReset(tid)
  local coreResetRemainTime = ActivityDrawPrizeModel.Instance:GetCoreResetRemainTime(tid)
  if coreResetRemainTime > 0 then
    do return self.GetPrizePoolCanResetWhenHaveCoreReset, self end
    return self.GetPrizePoolCanResetWhenHaveCoreReset, self, tid
  end
  do return self.GetPrizePoolCanResetWhenNoCoreReset, self end
  return self.GetPrizePoolCanResetWhenNoCoreReset, self, tid
end

function ActivityDrawPrizeModel:GetPrizePoolCanResetWhenHaveCoreReset(tid)
  local resetContition = self:GetLotteryCfgByField("ResetCondition", tid)
  if not resetContition then
    return false
  end
  do return self._CheckResetConditionComplete, self, resetContition end
  return self._CheckResetConditionComplete, self, resetContition, tid
end

function ActivityDrawPrizeModel:GetPrizePoolCanResetWhenNoCoreReset(tid)
  local resetContition = self:GetLotteryCfgByField("ResetConditionNoneCoreDrop", tid)
  if not resetContition then
    return false
  end
  do return self._CheckResetConditionComplete, self, resetContition end
  return self._CheckResetConditionComplete, self, resetContition, tid
end

function ActivityDrawPrizeModel:_CheckResetConditionComplete(resetContition, tid)
  local rst = true
  for i = 1, #resetContition, 2 do
    local condDropId, condNum = resetContition[i], resetContition[i + 1]
    local condDropCfg = self:GetFirstDropCfg(condDropId)
    local condItemTid = condDropCfg and condDropCfg.DropItem
    if not (condDropId and condItemTid) or not condNum then
      return false
    end
    local prizeDataGroup = self:GetPrizePoolDataByField("prizeDataGroup", tid)
    local satisfyCondition = false
    for _, prizeData in pairs(prizeDataGroup) do
      local drawNum = math.max(0, prizeData.limit - prizeData.remain)
      if prizeData.tid == condItemTid and prizeData.dropId == condDropId and condNum <= drawNum then
        satisfyCondition = true
      end
    end
    if not satisfyCondition then
      return false
    end
  end
  return rst
end

function ActivityDrawPrizeModel:GetRemainLimitByPrizeDatas(prizeDataGroup, rewardType)
  local remain, limit = 0, 0
  if not prizeDataGroup then
    return remain, limit
  end
  for _, prizeData in pairs(prizeDataGroup) do
    local newProgress = type(prizeData) == "table" and prizeData.remain or 0
    local newLimit = type(prizeData) == "table" and prizeData.limit or 0
    if not rewardType or rewardType == prizeData.type then
      remain = remain + newProgress
      limit = limit + newLimit
    end
  end
  return remain, limit
end

function ActivityDrawPrizeModel:GetPrizePoolOpenCountDown(tid)
  local rst = 0
  local openTs = self:GetLotteryCfgByField("OpenDate", tid)
  if not openTs then
    return rst
  end
  local curTs = TimeUtils.GetServerTime()
  do return math.max, 0 end
  return math.max, 0, openTs - curTs
end

function ActivityDrawPrizeModel:GetPrizePoolCloseCountDown(tid)
  local rst = 0
  local closeTs = self:GetLotteryCfgByField("CloseDate", tid)
  if not closeTs then
    return rst
  end
  local curTs = TimeUtils.GetServerTime()
  do return math.max, 0 end
  return math.max, 0, closeTs - curTs
end

function ActivityDrawPrizeModel:CreateDrawPrizePoolData(tid, resetTime, prizeDataGroup)
  return {
    tid = tid or 0,
    resetTime = resetTime or 0,
    prizeDataGroup = prizeDataGroup or {}
  }
end

function ActivityDrawPrizeModel:CreateDrawPrizeData(tid, remain, limit, type, sortIdx, dropId, dropNum)
  return {
    tid = tid or 0,
    limit = limit or 0,
    remain = remain or limit,
    type = type or CommonDefine.LotteryRewardType.Normal,
    sortIdx = sortIdx or 0,
    dropId = dropId or 0,
    dropNum = dropNum or 1
  }
end

function ActivityDrawPrizeModel:Set_drawRewards(tblData)
  self.drawRewards = tblData
end

function ActivityDrawPrizeModel:Set_curPage(page)
  self.curPage = page
  self:LocalNotify(NotifyId.OnActivityPageChanged, page)
end

function ActivityDrawPrizeModel:OnReset()
end

return ActivityDrawPrizeModel
