local ActivityPreOrderPanel, Super = System.NewClass("ActivityPreOrderPanel", ActivityBaseComp)
ActivityPreOrderPanel.uiResCls = UI_Events_Panel_PreOrderGiftResource

function ActivityPreOrderPanel:ctor(_, activityTid)
  Super.ctor(self)
  self.activityTid = activityTid
  self.activityData = ActivityManager.Instance.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.taskList = {}
  self.isBought = Vue.ref(self.activityData and self.activityData.isUnlockExtraTask or false)
end

function ActivityPreOrderPanel:Show()
  Super.Show(self)
  UIBasePanel.PlayTableViewFadeInAnim(self, self.ui.ScrollView)
end

function ActivityPreOrderPanel:OnBind(binder)
  self.binder = binder
  self:_SetActivityIllustrate()
  self.binder:SetText(self.ui.Text_Diary, self.activityConfig.ActivityName)
  self.binder:SetImageSync(self.ui.Image_Map, ActivityDataUtils.GetBgImage(self.activityTid))
  self:CreateTaskTableView()
  self:RefreshTaskList()
  self:BindBuyInfo()
  self:_BindActivityTimer()
  self.binder:BindZ1Button(self.ui.Btn_Buy, System.fn(self, self.OnBtnBuy))
  self.binder:BindToRaw(function(_, isBought)
    self.isBought.value = isBought
  end, function()
    return self.activityData.isUnlockExtraTask
  end)
end

function ActivityPreOrderPanel:_SetActivityIllustrate()
  self.binder:SetActive(self.ui.Image_Description, false)
end

function ActivityPreOrderPanel:BindBuyInfo()
  self.binder:SetText(self.ui.Text_BuyTip, LT.Text("PreOrderBeforePurchaseTips"))
  self.binder:SetText(self.ui.Text_BoughtTip, LT.Text("PreOrderPurchasedTips"))
  self.binder:BindToVisible(self.ui.Group_Buy, function()
    local deadline = self:_GetPreOrderPurchaseDeadlineTs()
    local leftTime = deadline - TimeUtils.GetServerTime()
    return leftTime > 0 and not self:IsBought()
  end)
  self.binder:BindToVisible(self.ui.BuyTimeView, function()
    if not self:IsPermanentActivity() or self:IsBought() then
      return false
    end
    local leftTime = (self.activityData.finishTime or 0) - TimeUtils.GetServerTime()
    return leftTime > 0
  end)
  self.binder:BindToVisible(self.ui.Image_Purchased, function()
    do return self.IsBought end
    return self.IsBought, self
  end)
  local shopItemId = self.activityConfig.ActivityPara4 and self.activityConfig.ActivityPara4[2]
  local shopItemCfg = shopItemId and DT.Shop[shopItemId]
  if shopItemCfg then
    local costItemId, costNum = table.unpack(shopItemCfg.Price)
    self.binder:SetImage(self.ui.Image_Item, ItemDataUtils.GetIcon(costItemId))
    self.binder:SetText(self.ui.Text_Cost, costNum)
  end
  
  local function SetBuyTimeFunc()
    if not self:IsPermanentActivity() or self:IsBought() then
      return
    end
    local leftTime = (self.activityData.finishTime or 0) - TimeUtils.GetServerTime()
    if leftTime > 0 then
      local timeStr = TimeUtils.format2Hour(leftTime)
      self.binder:SetText(self.ui.Text_BuyTime, LT.Textf("PreOrderPurchaseCountdownTips", timeStr))
    end
  end
  
  self.binder:BindTimer(1, -1, SetBuyTimeFunc)
  SetBuyTimeFunc()
end

function ActivityPreOrderPanel:OnBtnBuy()
  if self:IsBuyPassport() then
    return
  end
  local shopItem, shopCfg = self:GetShopTidAndConfig()
  assert(shopItem and shopCfg, string.format("活动：%s 购买的通行证数据有误 ActivityPara4", self.activityConfig.ActivityName))
  local buyItem = shopCfg.Item[1]
  local buyItemCfg = ItemDataUtils.GetItemConfig(buyItem) or {}
  local buyInfo = {
    buyItem = shopItem,
    buyCallback = function()
      MainShopDataUtils.ReqOnShopBuyGoods(shopItem, shopCfg.ShopType, 1, function(data)
        if self.activityData then
          ActivityManager.Instance.model:SetActUnlockPassport(self.activityData, true)
        end
        UIManager.Instance:CloseByUrl(Urls.GamePassportBuyPanel)
      end)
    end,
    rewards = self:GetAllRewards(),
    desc = buyItemCfg.Desc,
    actPromotional = self.activityConfig.ActivityPromotionalText1,
    costItem = shopCfg.Price[1],
    costNum = shopCfg.Price[2]
  }
  UIManager.Instance:Reopen(Urls.GamePassportBuyPanel, buyInfo)
end

function ActivityPreOrderPanel:IsBuyPassport()
  do return self.IsBought end
  return self.IsBought, self
end

function ActivityPreOrderPanel:GetShopTidAndConfig()
  local _, shopItemTid = table.unpack(self.activityConfig.ActivityPara4)
  if shopItemTid then
    local shopItemCfg = DT.Shop[shopItemTid]
    if not shopItemCfg then
      return
    end
    return shopItemTid, shopItemCfg
  end
end

function ActivityPreOrderPanel:IsBought()
  return self.isBought.value
end

function ActivityPreOrderPanel:IsPermanentActivity()
  return self.activityConfig and self.activityConfig.ActivityTimeType == ActivityDefine.ActivityTimeType.Permanent
end

function ActivityPreOrderPanel:IsFixedTimeActivity()
  return self.activityConfig and self.activityConfig.ActivityTimeType == ActivityDefine.ActivityTimeType.FixedTime
end

function ActivityPreOrderPanel:_GetPreOrderPurchaseDeadlineTs()
  if self:IsFixedTimeActivity() then
    local stageEnd = self.activityConfig.ActivityStageEndTime
    if stageEnd and stageEnd > 0 then
      return stageEnd
    end
  end
  return self.activityData.finishTime or 0
end

function ActivityPreOrderPanel:_GetCornerCountdownEndWhenBought()
  if self:IsFixedTimeActivity() then
    local cfgEnd = self.activityConfig.ActivityEndTime
    if cfgEnd and cfgEnd > 0 then
      return cfgEnd
    end
  end
  if self.activityData.endTime and self.activityData.endTime > 0 then
    return self.activityData.endTime
  end
  return self.activityData.finishTime or 0
end

function ActivityPreOrderPanel:GetAllRewards()
  local rewardMap = {}
  local targetTaskInfoList = table.clone(self.taskList)
  local bookExpiredTask = self:_GetBookExpiredTask()
  if bookExpiredTask then
    table.insert(targetTaskInfoList, bookExpiredTask)
  end
  for _, taskInfo in ipairs(targetTaskInfoList) do
    local taskId = taskInfo.taskTid
    local taskCfg = TaskDataUtils.GetTaskConfigByTid(taskId)
    local CompleteAward = taskCfg.CompleteAward or {}
    if TaskDataUtils.IsTaskDoneByTaskId(taskId) or taskInfo.bookExpiredTime and self:IsOutOfBookingTime() then
    else
      for rewardId, num in table.iteraDouble(CompleteAward) do
        rewardMap[rewardId] = (rewardMap[rewardId] or 0) + num
      end
    end
  end
  local rewards = {}
  for itemTid, num in pairs(rewardMap) do
    table.insert(rewards, {
      tid = itemTid,
      num = num,
      itemCfg = ItemDataUtils.GetItemConfig(itemTid)
    })
  end
  table.sort(rewards, function(a, b)
    local cfg1 = a.itemCfg
    local cfg2 = b.itemCfg
    if not ItemDataUtils.IsSameQuality(cfg1, cfg2) then
      do return ItemDataUtils.IsSeniorQuality, cfg1 end
      return ItemDataUtils.IsSeniorQuality, cfg1, cfg2
    end
    return cfg1.BaseSortID < cfg2.BaseSortID
  end)
  return rewards
end

function ActivityPreOrderPanel:RefreshTaskList()
  local bookExpiredTask = self:_GetBookExpiredTask()
  self.binder:SetActive(self.ui.UI_Events_Item_PreOrderGift_BookExpired, bookExpiredTask)
  if bookExpiredTask then
    CS.Framework.TransformUtil.SetLocalPos(self.ui.ScrollView.transform, 0, 180.12, 0)
    CS.Framework.TransformUtil.SetHeight(self.ui.ScrollView.transform, 475.58)
    self.binder:BindComponent(ActivityPreOrderItem(self.ui.UI_Events_Item_PreOrderGift_BookExpired, self.activityTid, bookExpiredTask, self.isBought))
  else
    CS.Framework.TransformUtil.SetLocalPos(self.ui.ScrollView.transform, 0, 326, 0)
    CS.Framework.TransformUtil.SetHeight(self.ui.ScrollView.transform, 652)
  end
  self.taskList = self:GetTaskList()
  self.taskTableView:ReloadData()
  UIBasePanel.PlayTableViewFadeInAnim(self, self.ui.ScrollView)
end

function ActivityPreOrderPanel:GetTaskList()
  local taskList = {}
  local actCfg = ActivityDataUtils.GetConfig(self.activityTid)
  local taskLimitTime = self:GetTaskLimitTimeList()
  for i, tid in ipairs(actCfg.ActivityPara1 or {}) do
    table.insert(taskList, {
      taskTid = tid,
      taskLimitTime = tonumber(taskLimitTime[i])
    })
  end
  return taskList
end

function ActivityPreOrderPanel:_GetBookExpiredTask()
  local actCfg = ActivityDataUtils.GetConfig(self.activityTid)
  local cfgActivityPara5 = table.clone(actCfg.ActivityPara5 or {})
  local bookExpiredTime = cfgActivityPara5[1]
  local targetTaskTid = cfgActivityPara5[2]
  if not bookExpiredTime or not targetTaskTid then
    return
  end
  local now = TimeUtils.GetServerTime()
  if bookExpiredTime > now or TaskDataUtils.IsTaskDoneByTaskId(targetTaskTid) then
    return {bookExpiredTime = bookExpiredTime, taskTid = targetTaskTid}
  end
  return nil
end

function ActivityPreOrderPanel:GetTaskLimitTimeList()
  local actCfg = ActivityDataUtils.GetConfig(self.activityTid)
  do return string.split, actCfg.ActivityPara2 or "" end
  return string.split, actCfg.ActivityPara2 or "", ","
end

function ActivityPreOrderPanel:CreateTaskTableView()
  local baseGameObj = self.ui.UI_Events_Item_PreOrderGift
  self.binder:SetActive(baseGameObj, false)
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.taskTableView = UIBasePanel.CreateTableview(self, self.ui.ScrollView, function()
    return #self.taskList
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local taskInfo = self.taskList[idx]
    itemComps[gameObj] = self.binder:BindComponent(ActivityPreOrderItem(gameObj, self.activityTid, taskInfo, self.isBought))
    return cell
  end, function(view, index)
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
  if self.taskTableView.isReady then
    self:_JumpToRewardIdx()
  else
    function self.taskTableView.reloadFinishCallback()
      self.taskTableView.reloadFinishCallback = nil
      
      self:_JumpToRewardIdx()
    end
  end
end

function ActivityPreOrderPanel:_IsTaskCanGet(taskInfo)
  local isCanGet = TaskDataUtils.IsTaskCanReward(taskInfo.taskTid)
  local now = TimeUtils.GetServerTime()
  local isTimeOk = now >= taskInfo.taskLimitTime or 0
  return isCanGet and isTimeOk
end

function ActivityPreOrderPanel:_JumpToRewardIdx()
  local targetIdx = 1
  for idx, taskInfo in ipairs(self.taskList) do
    if self:_IsTaskCanGet(taskInfo) then
      targetIdx = idx
      break
    end
  end
  local offset = self.taskTableView:GetOffsetByIndex(targetIdx - 1)
  self.taskTableView:SetOffset(offset, false)
end

function ActivityPreOrderPanel:_BindActivityTimer()
  if not (self.activityData and self.binder and self.ui) or not self.ui.Text_Time then
    Logger.Warn("_BindActivityTimer wrong activityData:%s binder:%s Text_Time:%s", self.activityData, self.binder, self.ui and self.ui.Text_Time)
    return
  end
  if not self._activityTimer then
    self._activityTimer = self.binder:BindTimer(1, -1, System.fn(self, self._BindActivityTimer))
  end
  if self:IsBought() and self:IsPermanentActivity() then
    self.binder:SetText(self.ui.Text_BuyTip, LT.Text("PreOrderBeforePurchaseTips"))
    self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimePermanent"))
    self:_ClearTimer()
    return
  end
  if self:IsBought() then
    local endTs = self:_GetCornerCountdownEndWhenBought()
    local leftTime = endTs - TimeUtils.GetServerTime()
    if leftTime <= 0 then
      self:_ClearTimer()
      self.binder:SetText(self.ui.Text_Time, "")
      return
    end
    self.binder:SetText(self.ui.Text_Time, TimeUtils.ActivityCountDownFormat(leftTime))
  else
    local deadlineTs = self:_GetPreOrderPurchaseDeadlineTs()
    local leftTime = deadlineTs - TimeUtils.GetServerTime()
    if leftTime > 0 then
      local timeStr = TimeUtils.format2Hour(leftTime)
      self.binder:SetText(self.ui.Text_Time, LT.Textf("PreOrderPurchaseCountdownTips", timeStr))
    else
      self.binder:SetText(self.ui.Text_Time, "")
    end
  end
end

function ActivityPreOrderPanel:IsOutOfBookingTime()
  local para5 = self.activityConfig.ActivityPara5
  local bookingTime = para5 and para5[1]
  local now = TimeUtils.GetServerTime()
  if bookingTime and bookingTime < now then
    return true
  end
end

function ActivityPreOrderPanel:GetBookingTimeStr()
  local para5 = self.activityConfig.ActivityPara5
  local bookingTime = para5 and para5[1]
  local now = TimeUtils.GetServerTime()
  if bookingTime and bookingTime > now then
    local leftBookingTime = bookingTime - now
    do return TimeUtils.format2Hour end
    return TimeUtils.format2Hour, leftBookingTime
  end
end

return ActivityPreOrderPanel
