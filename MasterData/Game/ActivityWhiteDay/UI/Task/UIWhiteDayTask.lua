local UIWhiteDayTask = class("UIWhiteDayTask", UIBaseWindow)
local base = UIBaseWindow
local ActivityWhiteDayEnum = require("Game.ActivityWhiteDay.ActivityWhiteDayEnum")
local UINWhiteDayTaskItem = require("Game.ActivityWhiteDay.UI.Task.UINWhiteDayTaskItem")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function UIWhiteDayTask:OnInit()
  self.__IsEndLess = true
  self.taskItemPool = UIItemPool.New(UINWhiteDayTaskItem, self.ui.obj_taskItem)
  self.ui.obj_taskItem:SetActive(false)
  self.__onCompleteTask = BindCallback(self, self.__OnCompleteTask)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__OnClickClose)
  UIUtil.AddValueChangedListener(self.ui.tog_EndlessTask, self, self.__OnEndlessTaskTogValueChange)
  UIUtil.AddValueChangedListener(self.ui.tog_Task, self, self.__OnTaskTogValueChange)
end

function UIWhiteDayTask:InitWDTask(AWDCtrl, AWDData)
  self.AWDCtrl = AWDCtrl
  self.AWDData = AWDData
  self.__IsEndLess = true
  self.ui.tog_Task.isOn = true
  self.ui.tog_EndlessTask.isOn = true
  if self.taskTimerId ~= nil then
    TimerManager:StopTimer(self.taskTimerId)
    self.taskTimerId = nil
  end
  self.taskTimerId = TimerManager:StartTimer(1, self.RefreshWDTaskRefreshTime, self, false, nil, true)
  self:__InitWDTaskReddot()
  local cfg = self.AWDData:GetWDCfg()
  self.ui.tex_Name_endlessTask.text = LanguageUtil.GetLocaleText(cfg.endless_task_title)
  self.ui.tex_Name_task.text = LanguageUtil.GetLocaleText(cfg.task_title)
end

function UIWhiteDayTask:RefreshWDTaskList()
  self.ui.obj_time:SetActive(self.__IsEndLess)
  self:RefreshWDTaskRefreshTime()
  local taskList, taskId2IndexDic
  if self.__IsEndLess then
    taskList = {}
    table.insertto(taskList, self.AWDData:GetWDEndlessTaskList())
    table.insertto(taskList, self.AWDData:GetWDEndlessTaskFinishedList())
    taskId2IndexDic = {}
    for index, taskId in ipairs(taskList) do
      taskId2IndexDic[taskId] = index
    end
  else
    taskList = self.AWDData:GetWDTaskList()
  end
  table.sort(taskList, function(taskIdA, taskIdB)
    local stateA, stateB
    local taskDataA = PlayerDataCenter.allTaskData.taskDatas[taskIdA]
    local taskDataB = PlayerDataCenter.allTaskData.taskDatas[taskIdB]
    if taskDataA ~= nil then
      if taskDataA:CheckComplete() then
        stateA = 1
      else
        stateA = 2
      end
    else
      stateA = 3
    end
    if taskDataB ~= nil then
      if taskDataB:CheckComplete() then
        stateB = 1
      else
        stateB = 2
      end
    else
      stateB = 3
    end
    if self.__IsEndLess then
      local isMultA = self.AWDData:GetWDIsEndlessTaskMultReward(taskId2IndexDic[taskIdA])
      if isMultA then
        stateA = stateA - 0.5
      end
      local isMultB = self.AWDData:GetWDIsEndlessTaskMultReward(taskId2IndexDic[taskIdB])
      if isMultB then
        stateB = stateB - 0.5
      end
    end
    if stateA == stateB then
      return taskIdA < taskIdB
    end
    return stateA < stateB
  end)
  self.taskItemPool:HideAll()
  for index, taskId in ipairs(taskList) do
    if taskId ~= 0 then
      local isMult, multText, multRate
      if self.__IsEndLess then
        isMult, multText, multRate = self.AWDData:GetWDIsEndlessTaskMultReward(taskId2IndexDic[taskId])
      end
      local taskItem = self.taskItemPool:GetOne()
      taskItem:InitWDTaskItem(self.AWDCtrl, taskId, isMult, multText, multRate, self.__IsEndLess, self.__onCompleteTask)
    end
  end
end

function UIWhiteDayTask:__OnTaskTogValueChange(bool)
  if bool then
    self.ui.img_Buttom_Task.color = self.ui.color_select
    self.__IsEndLess = false
    self:RefreshWDTaskList()
  else
    self.ui.img_Buttom_Task.color = self.ui.color_notSelect
  end
end

function UIWhiteDayTask:__OnEndlessTaskTogValueChange(bool)
  if bool then
    self.ui.img_Buttom_EndlessTask.color = self.ui.color_select
    self.__IsEndLess = true
    self:RefreshWDTaskList()
  else
    self.ui.img_Buttom_EndlessTask.color = self.ui.color_notSelect
  end
end

function UIWhiteDayTask:RefreshWDTaskRefreshTime()
  if not self.__IsEndLess then
    return
  end
  local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterModuleValentineEndlessQuestRefreshTime, self.AWDData:GetActId())
  if counterElem ~= nil and counterElem.nextExpiredTm > PlayerDataCenter.timestamp then
    self.ui.tex_Time.text = TimeUtil:TimestampToTime(counterElem.nextExpiredTm - PlayerDataCenter.timestamp)
    return
  end
end

function UIWhiteDayTask:__OnCompleteTask(taskItem)
  local isMult = taskItem.isMult
  local multRate = taskItem.multRate
  local rewardNums = taskItem.taskCfg.rewardNums
  local rewardIds = taskItem.taskCfg.rewardIds
  
  local function showReward()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local nums
      if isMult then
        nums = {}
        for index, value in ipairs(rewardNums) do
          nums[index] = math.floor(value * (multRate / 100 + 1))
        end
      else
        nums = rewardNums
      end
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, nums)
      window:AddAndTryShowReward(CRData)
    end)
    self:RefreshWDTaskList()
  end
  
  if not taskItem.isEndless then
    if taskItem.taskData ~= nil then
      self.AWDCtrl:WDTaskCommit(self.AWDData, taskItem.taskData, showReward)
    end
  else
    self.AWDCtrl:WDEndlessTaskCommit(self.AWDData, taskItem.taskId, showReward)
  end
end

function UIWhiteDayTask:__InitWDTaskReddot()
  local actFrameId = self.AWDData:GetActFrameId()
  local isOk, commonNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, actFrameId, ActivityWhiteDayEnum.redDotType.task, ActivityWhiteDayEnum.redDotType.commonTask)
  if isOk then
    if self.__refresnTaskReddot == nil then
      function self.__refresnTaskReddot(node)
        self.ui.obj_RedDot_Task:SetActive(node:GetRedDotCount() > 0)
      end
    end
    RedDotController:AddListener(commonNode.nodePath, self.__refresnTaskReddot)
    self.__refresnTaskReddot(commonNode)
  end
  local isOk, endlessNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, actFrameId, ActivityWhiteDayEnum.redDotType.task, ActivityWhiteDayEnum.redDotType.endlesstask)
  if isOk then
    if self.__refresnEndlessTaskReddot == nil then
      function self.__refresnEndlessTaskReddot(node)
        self.ui.obj_RedDot_EndlessTask:SetActive(node:GetRedDotCount() > 0)
      end
    end
    RedDotController:AddListener(endlessNode.nodePath, self.__refresnEndlessTaskReddot)
    self.__refresnEndlessTaskReddot(endlessNode)
  end
end

function UIWhiteDayTask:__RemoveWDTaskReddot()
  local actFrameId = self.AWDData:GetActFrameId()
  local isOk, commonnode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, actFrameId, ActivityWhiteDayEnum.redDotType.task, ActivityWhiteDayEnum.redDotType.commonTask)
  if isOk then
    RedDotController:RemoveListener(commonnode.nodePath, self.__refresnTaskReddot)
  end
  local isOk, endlessNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, actFrameId, ActivityWhiteDayEnum.redDotType.task, ActivityWhiteDayEnum.redDotType.endlesstask)
  if isOk then
    RedDotController:RemoveListener(endlessNode.nodePath, self.__refresnEndlessTaskReddot)
  end
  self.__refresnTaskReddot = nil
  self.__refresnEndlessTaskReddot = nil
end

function UIWhiteDayTask:BackAction()
  self:__RemoveWDTaskReddot()
  self:Delete()
end

function UIWhiteDayTask:__OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIWhiteDayTask:OnShow()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack()
  base.OnShow(self)
end

function UIWhiteDayTask:OnDelete()
  if self.taskTimerId ~= nil then
    TimerManager:StopTimer(self.taskTimerId)
    self.taskTimerId = nil
  end
  base.OnDelete(self)
end

return UIWhiteDayTask
