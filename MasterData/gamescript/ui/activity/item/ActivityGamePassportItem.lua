local ActivityGamePassportItem, Super = System.NewClass("ActivityGamePassportItem", ActivityBaseComp)

function ActivityGamePassportItem:ctor(res, activityTid, taskInfo, isBoughtPlus, reqTaskRewards, tipsOwnerBinder)
  Super.ctor(self)
  self.ui = UI_Events_Item_GamePassportResource(res)
  self.activityTid = activityTid
  self.normalTask = taskInfo[1]
  self.paidTask = taskInfo[2]
  self.isBoughtPlus = isBoughtPlus
  self.reqTaskRewards = reqTaskRewards
  self.tipsOwnerBinder = tipsOwnerBinder
end

function ActivityGamePassportItem:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Title, TaskDataUtils.GetTaskProgressDesc(self.normalTask, "%s<color=#6E6C6C>(%s/%s)</color>"))
  TaskDataUtils.ReportToApus(self.normalTask)
  self:CreateTaskItems(self.normalTask, {
    self.ui.reward_1,
    self.ui.reward_2
  }, false)
  self:CreateTaskItems(self.paidTask, {
    self.ui.reward_3,
    self.ui.reward_4,
    self.ui.reward_5,
    self.ui.reward_6
  }, true)
end

function ActivityGamePassportItem:CreateTaskItems(taskId, gameObjList, isPlus)
  local normalTaskCfg = TaskDataUtils.GetTaskConfigByTid(taskId) or {}
  local reward = normalTaskCfg.CompleteAward or {}
  if isPlus then
    reward = normalTaskCfg.ExtraAward or {}
  end
  for index, gameObj in ipairs(gameObjList) do
    local itemId, itemCount = reward[index * 2 - 1], reward[index * 2]
    self.binder:SetActive(gameObj, nil ~= itemId)
    if itemId then
      local itemData = {
        itemTid = itemId,
        itemCount = itemCount,
        clickFunc = System.bind(self.ClickItem, self, taskId, itemId, itemCount, isPlus),
        lockFunc = function()
          if isPlus and not self.isBoughtPlus then
            return true
          end
          return not TaskDataUtils.IsTaskDoneByTaskId(taskId)
        end,
        isGotFunc = function()
          do return TaskDataUtils.TaskFinshAndGetedAward end
          return TaskDataUtils.TaskFinshAndGetedAward, taskId
        end,
        isShowRing = function()
          do return self.IsTaskRewardCanGet, self, taskId end
          return self.IsTaskRewardCanGet, self, taskId, isPlus
        end,
        redFunc = function()
          do return self.IsTaskRewardCanGet, self, taskId end
          return self.IsTaskRewardCanGet, self, taskId, isPlus
        end,
        isolateStreamerMaterialForRectMask = true
      }
      self.binder:BindComponent(CommonIconItemType2(gameObj, itemData))
    end
  end
end

function ActivityGamePassportItem:IsTaskRewardCanGet(taskId, isPlus)
  if isPlus and not self.isBoughtPlus then
    return
  end
  do return TaskDataUtils.IsTaskCanReward end
  return TaskDataUtils.IsTaskCanReward, taskId
end

function ActivityGamePassportItem:_ReqReqOnGainAllPrize()
  if self.reqTaskRewards then
    self.reqTaskRewards()
  else
    ActivityDataUtils.ReqOnGainAllPrize(self.activityTid)
  end
end

function ActivityGamePassportItem:_CheckEnergyIsOverMax()
  do return ActivityDataUtils.CheckPassportPassportTaskListEnergyIsOverMax, self.activityTid end
  return ActivityDataUtils.CheckPassportPassportTaskListEnergyIsOverMax, self.activityTid, self.isBoughtPlus
end

function ActivityGamePassportItem:ClickItem(taskId, itemId, itemCount, isPlus)
  local isCanReward = TaskDataUtils.IsTaskCanReward(taskId)
  if isCanReward then
    if self:_CheckEnergyIsOverMax() then
      GetEnergyCheckUtils.TipsShow(function()
        self:_ReqReqOnGainAllPrize()
      end)
      return
    end
    if isPlus and not self.isBoughtPlus then
      EventMgr.Instance.OnTryBuyPassport:Dispatch(self.activityTid)
      return
    end
    self:_ReqReqOnGainAllPrize()
  else
    ItemDataUtils.ShowItemDetailTips(self.tipsOwnerBinder or self.binder, self.ui.uiNode, nil, itemId)
  end
end

return ActivityGamePassportItem
