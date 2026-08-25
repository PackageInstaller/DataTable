local SummonGiftTask, Super = System.NewComponent("SummonGiftTask")
SummonGiftTask.uiResCls = UI_Summon_GiftTaskResource

function SummonGiftTask:ctor(uiNode, taskTid, reqTaskRewardFunc, extraParam)
  Super.ctor(self)
  self.ui = SummonGiftTask.uiResCls(uiNode)
  self.taskTid = taskTid
  self.extraParam = extraParam or {}
  self.isHideTime = self.extraParam.isHideTime
  self.reqTaskRewardFunc = reqTaskRewardFunc
end

function SummonGiftTask:OnBind(binder)
  self.binder = binder
  local taskCfg = TaskDataUtils.GetTaskConfigByTid(self.taskTid)
  if not taskCfg then
    Logger.Error("SummonGiftTask 任务配置错误，taskTid: " .. self.taskTid)
    return
  end
  self:_OnBindRedPoint(binder)
  self.binder:BindButtonClick(self.ui.Btn_Reward, System.fn(self, self.OnReward))
  self.binder:BindButtonClick(self.ui.Btn_Icon, System.fn(self, self.OnClickIcon))
  self.binder:BindEvent(EventMgr.Instance.UpdateBagEvent, System.fn(self, self.OnObtainRewards))
  self.binder:SetActive(self.ui.Text_Time, not self.isHideTime)
  self.binder:SetActive(self.ui.Group_Expired, false)
  if not self.isHideTime then
    self:BindActivityTimer()
  end
  self.binder:BindToRaw(function()
    self:RefreshTaskInfo()
  end, function()
    local taskData = TaskDataUtils.GetTaskData(self.taskTid)
    return {
      taskData.state,
      taskData.count
    }
  end)
end

function SummonGiftTask:_OnBindRedPoint()
end

function SummonGiftTask:RefreshTaskInfo()
  local taskCfg = TaskDataUtils.GetTaskConfigByTid(self.taskTid)
  local taskData = TaskDataUtils.GetTaskData(self.taskTid) or {}
  self.binder:SetText(self.ui.Text_C_GiftTitle, LT.Text(taskCfg.Name))
  self.binder:SetText(self.ui.Text_Task, LT.Textf(taskCfg.Desc, taskData.count or 0))
  local titleTxtComp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_C_GiftTitle, 0, 0, 0, nil, true)
  local taskTxtComp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Task, 0, 0, 0, nil, true)
  if titleTxtComp and self.ui.Btn_Reward then
    titleTxtComp:SetBtn(self.ui.Btn_Reward)
  end
  if titleTxtComp and self.OnDrag and self.OnBeginDrag then
    titleTxtComp:SetDragDelegate(self)
  end
  if taskTxtComp and self.ui.Btn_Reward then
    taskTxtComp:SetBtn(self.ui.Btn_Reward)
  end
  if taskTxtComp and self.OnDrag and self.OnBeginDrag then
    taskTxtComp:SetDragDelegate(self)
  end
  local rewardItemTid = self:GetRewardItemTid()
  local itemIcon = ItemDataUtils.GetItemIcon(rewardItemTid)
  if itemIcon then
    if ItemDataUtils.GetItemConfigByField("Type", rewardItemTid) == cd.ItemType.SkinItem then
      local skinCfg = AwakerSkinUtils.GetSkinByItem(rewardItemTid)
      if skinCfg then
        self.binder:SetImage(self.ui.Image_Awaker, AwakerSkinUtils.GetSkinFullHeadImg(skinCfg))
      end
      self.binder:SetActive(self.ui.Group_Awkar, true)
      self.binder:SetActive(self.ui.Image_Icon_Gift, false)
    else
      self.binder:SetImage(self.ui.Image_Icon_Gift, itemIcon)
      self.binder:SetActive(self.ui.Group_Awkar, false)
      self.binder:SetActive(self.ui.Image_Icon_Gift, true)
    end
  end
  self.binder:SetActive(self.ui.UI_Vx_Summon_Gift_Select_01, taskData.state == cd.TaskState.Receive)
  self.binder:SetActive(self.ui.Group_Received, taskData.state == cd.TaskState.Done)
  if taskData.state == cd.TaskState.Done then
    EventMgr.Instance.UpdateBagEvent:RemoveEvent(System.fn(self, self.OnObtainRewards))
  end
end

function SummonGiftTask:BindActivityTimer()
  self:ClearTimer()
  self:TimerFixedUpdate()
  local now = TimeUtils.GetFixedTimestamp(TimeUtils.GetServerTime())
  if now > self:GetTaskEndTs() then
    self:HideGift()
    return
  end
  self.activityTimer = self.binder:BindTimer(1, -1, System.fn(self, self.TimerFixedUpdate))
end

function SummonGiftTask:TimerFixedUpdate()
  local now = TimeUtils.GetFixedTimestamp(TimeUtils.GetServerTime())
  local finishTimeCountdown = self:GetTaskEndTs() - now
  if finishTimeCountdown < 0 then
    self:ClearTimer()
    self:HideGift()
  end
  local timeText = ""
  if finishTimeCountdown >= 0 then
    timeText = TimeUtils.ActivityCountDownFormat(finishTimeCountdown)
  else
    timeText = LT.Text("ActivityTimeExpired")
    self.binder:BindToTextColorOld(self.ui.Text_Time, function()
      do return ColorUtils.GetColorHexCode, "UXWarning" end
      return ColorUtils.GetColorHexCode, "UXWarning", cd.ColorType.Dark
    end)
    self.binder:SetActive(self.ui.Group_Expired, true)
  end
  self.binder:SetText(self.ui.Text_Time, timeText)
end

function SummonGiftTask:GetTaskEndTs()
  do return DT.GetConstant end
  return DT.GetConstant, "DeepSeaInvasionDefensiveActiviityTaskEnd"
end

function SummonGiftTask:ClearTimer()
  if self.activityTimer then
    TimerManager.Instance:StopTimer(self.activityTimer)
    self.activityTimer = nil
  end
end

function SummonGiftTask:HideGift()
  self.ui.uiNode:SetActive(false)
end

function SummonGiftTask:OnClickIcon()
  local taskData = TaskDataUtils.GetTaskData(self.taskTid) or {}
  if taskData.state == cd.TaskState.Receive then
    self:OnReward()
    return
  end
  local rewardItemTid = self:GetRewardItemTid()
  if not rewardItemTid then
    return
  end
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, rewardItemTid)
end

function SummonGiftTask:GetRewardItemTid()
  local taskCfg = TaskDataUtils.GetTaskConfigByTid(self.taskTid)
  return taskCfg.CompleteAward and taskCfg.CompleteAward[1]
end

function SummonGiftTask:OnReward()
  local taskData = TaskDataUtils.GetTaskData(self.taskTid) or {}
  if taskData.state < cd.TaskState.Receive then
    Logger.Warn("SummonGiftTask 任务未完成，taskTid: " .. self.taskTid)
    Alert.Show(20198)
    return
  end
  if taskData.state == cd.TaskState.Done then
    Alert.Show(20208)
    return
  end
  if self.reqTaskRewardFunc then
    self.reqTaskRewardFunc(self.taskTid)
  end
end

function SummonGiftTask:OnObtainRewards(datas)
  if not datas or not table.next(datas) then
    return
  end
  for _, data in pairs(datas or {}) do
    if data.reason ~= cd.ItemReason.Task then
      return
    end
  end
  ItemDataUtils.ShowRewardPanel(LT.Text("ItemGain_String_MainTitle"), "", datas)
end

return SummonGiftTask
