local ActivityPreOrderItem, Super = System.NewClass("ActivityPreOrderItem", ActivityBaseComp)

function ActivityPreOrderItem:ctor(res, activityTid, taskInfo, isBought)
  Super.ctor(self)
  self.ui = UI_Events_Item_PreOrderGiftResource(res)
  self.activityTid = activityTid
  self.taskId = taskInfo.taskTid
  self.taskTime = taskInfo.taskLimitTime or 0
  self.bookExpiredTime = taskInfo.bookExpiredTime
  self.isBought = Vue.ref(isBought)
  self.curTime = Vue.ref(TimeUtils.GetServerTime())
end

function ActivityPreOrderItem:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Title, TaskDataUtils.GetTaskDesc(self.taskId))
  self:CreateTaskItems(self.taskId, {
    self.ui.reward_1,
    self.ui.reward_2,
    self.ui.reward_3,
    self.ui.reward_4
  })
  self.binder:BindToText(self.ui.Text_Time, System.fn(self, self.GetTaskTimeText))
  self.binder:BindToText(self.ui.Text_C_Lock, System.fn(self, self.GetTaskTimeText))
  self.binder:BindToText(self.ui.Text_RecieveState, System.fn(self, self.GetTaskTimeText))
  binder:BindToVisible(self.ui.Group_RecieveState, function()
    return self:IsTaskCanGet() or self:IsTaskGot()
  end)
  binder:BindToVisible(self.ui.Group_Lock, function()
    if self:GetBookingLeftTimeStr() then
      return false
    end
    return self:IsTaskNotDone() and self:IsTaskTimeOk()
  end)
  binder:BindToVisible(self.ui.Group_Time, function()
    if self:IsTaskNotDone() and self:GetBookingLeftTimeStr() then
      return true
    end
    return self:IsTaskNotDone() and not self:IsTaskTimeOk()
  end)
  binder:BindToVisible(self.ui.Image_SpecialBg, function()
    return self.bookExpiredTime ~= nil
  end)
  binder:BindToVisible(self.ui.Group_Effect, function()
    local taskInfo = TaskDataUtils.GetTaskData(self.taskId)
    return taskInfo and taskInfo.state <= cd.TaskState.Receive
  end)
  self.binder:BindTimer(1, -1, nil, function()
    self.curTime.value = TimeUtils.GetServerTime()
  end)
end

function ActivityPreOrderItem:IsTaskNotDone()
  return not self:IsTaskCanGet() and not self:IsTaskGot()
end

function ActivityPreOrderItem:IsTaskCanGet()
  local isCanGet = TaskDataUtils.IsTaskCanReward(self.taskId)
  local now = self.curTime.value
  local isTimeOk = now >= self.taskTime
  return isCanGet and isTimeOk
end

function ActivityPreOrderItem:IsTaskGot()
  do return TaskDataUtils.TaskFinshAndGetedAward end
  return TaskDataUtils.TaskFinshAndGetedAward, self.taskId
end

function ActivityPreOrderItem:IsTaskBought()
  return self.isBought.value
end

function ActivityPreOrderItem:IsTaskTimeOk()
  local now = self.curTime.value
  return now >= self.taskTime
end

function ActivityPreOrderItem:GetTaskTimeText()
  if TaskDataUtils.TaskFinshAndGetedAward(self.taskId) then
    return "TextAlreadyReceived"
  end
  local isCanGet = TaskDataUtils.IsTaskCanReward(self.taskId)
  local isBought = self.isBought.value
  local now = self.curTime.value
  local isTimeOk = now >= self.taskTime
  local timeStr = TimeUtils.format2Hour(self.taskTime - now)
  local bookingTimeStr = self:GetBookingLeftTimeStr()
  if isCanGet and isTimeOk then
    return "PreOrderTobeClaimed"
  elseif isBought then
    do return LT.Textf, "PreOrderNeedWaitTobeClaimed" end
    return LT.Textf, "PreOrderNeedWaitTobeClaimed", timeStr
  else
    if bookingTimeStr then
      do return LT.Textf, "NewPreOrderPurchaseTobeClaimed" end
      return LT.Textf, "NewPreOrderPurchaseTobeClaimed", bookingTimeStr
    end
    if isTimeOk then
      return "PreOrderNotPurchasedTobeClaimed"
    else
      do return LT.Textf, "PreOrderNotPurchasedNeedWait" end
      return LT.Textf, "PreOrderNotPurchasedNeedWait", timeStr
    end
  end
end

function ActivityPreOrderItem:GetBookingLeftTimeStr()
  if not self.bookExpiredTime or 0 == self.bookExpiredTime then
    return
  end
  local leftBookingTime = self.bookExpiredTime - self.curTime.value
  if leftBookingTime > 0 then
    do return TimeUtils.format2 end
    return TimeUtils.format2, leftBookingTime
  end
end

function ActivityPreOrderItem:CreateTaskItems(taskId, gameObjList)
  local normalTaskCfg = TaskDataUtils.GetTaskConfigByTid(taskId) or {}
  local reward = normalTaskCfg.CompleteAward or {}
  for index, gameObj in ipairs(gameObjList) do
    local itemId, itemCount = reward[index * 2 - 1], reward[index * 2]
    self.binder:SetActive(gameObj, nil ~= itemId)
    if itemId then
      local itemData = {
        itemTid = itemId,
        itemCount = itemCount,
        clickFunc = System.bind(self.ClickItem, self, taskId, itemId),
        lockFunc = function()
          return not self:IsTaskCanGet() and not self:IsTaskGot()
        end,
        isGotFunc = function()
          do return TaskDataUtils.TaskFinshAndGetedAward end
          return TaskDataUtils.TaskFinshAndGetedAward, taskId
        end,
        isShowRing = function()
          do return self.IsTaskCanGet end
          return self.IsTaskCanGet, self
        end,
        redFunc = function()
          do return self.IsTaskCanGet end
          return self.IsTaskCanGet, self
        end
      }
      self.binder:BindComponent(CommonIconItemType2(gameObj, itemData))
    end
  end
end

function ActivityPreOrderItem:IsTaskRewardCanGet(taskId)
  do return TaskDataUtils.IsTaskCanReward end
  return TaskDataUtils.IsTaskCanReward, taskId
end

function ActivityPreOrderItem:ClickItem(taskId, itemId)
  if self:IsTaskCanGet() then
    self:ReqAllCanGetTask()
  else
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, itemId)
  end
end

function ActivityPreOrderItem:ReqAllCanGetTask()
  local taskList = ActivityDataUtils.GetPreOrderCanGetTaskList(self.activityTid)
  for _, taskTid in ipairs(taskList) do
    ActivityDataUtils.ReqGainAward(self.activityTid, taskTid, nil, function(result)
    end)
  end
end

return ActivityPreOrderItem
