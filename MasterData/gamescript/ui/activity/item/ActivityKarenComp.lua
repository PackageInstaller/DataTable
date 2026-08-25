local ActivityKarenComp, Super = System.NewClass("ActivityKarenComp", ActivityMagicStoryComp)
local UIAnimationController = CS.Z1Client.UIAnimationController

function ActivityKarenComp:ctor(res, activityTid, model, params)
  Super.ctor(self, res, activityTid, model, params)
  local activityType = self.activityConfig.ActivityType
  self.activtyDefine = ActivityDefine.ActivityCompClsInfo[activityType]
  self.audioPlay = true
  if params then
    self.audioPlay = params.audioPlay
  end
end

function ActivityKarenComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  binder:SetActive(self.ui.Image_Currency_02, false)
  binder:SetActive(self.ui.Text_Currency_02, false)
  binder:SetActive(self.ui.Image_Currency_03, false)
  binder:SetActive(self.ui.Text_Currency_03, false)
  self:_BindActivityTimer()
  self:_SetActivityPlot()
  self:_BindTaskEntry()
  self:_BindSignEntry()
  self:_BindRewardEntry()
  if self.ui.Btn_PlayPV then
    self.binder:BindButtonClick(self.ui.Btn_PlayPV, System.fn(self, self._OnClickPlayPV))
  end
end

function ActivityKarenComp:_BindRewardEntry()
  local coinTid = self.activityConfig.ActivityPara3[1]
  self.binder:BindToImage(self.ui.Image_Currency_01, function()
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, coinTid
  end)
  self.binder:BindToText(self.ui.Text_Currency_01, function()
    do return ItemDataUtils.GetItemNum end
    return ItemDataUtils.GetItemNum, coinTid
  end)
  self.binder:BindButtonClick(self.ui.Btn_Reward, System.fn(self, self._OnClickBtnReward))
  self.binder:BindToVisible(self.ui.Red_Shop, function()
    do return end
    return RedPointDataUtils.GetActivityKarenRewardEntryRed, nil
  end)
end

function ActivityKarenComp:_BindTaskEntry()
  self.binder:BindToText(self.ui.Text_TaskProgress, function()
    local taskDataList = ActivityKarenUtils.GetDailyTaskDataList(self.activityData)
    local receivedNum = 0
    for _, taskData in ipairs(taskDataList) do
      if taskData.state == CommonDefine.TaskState.Done then
        receivedNum = receivedNum + 1
      end
    end
    local percent = receivedNum / #taskDataList
    local showVal = math.floor(percent * 100) .. "%"
    return showVal
  end)
  self.binder:BindButtonClick(self.ui.Btn_Task, System.fn(self, self._OnClickBtnTask))
  self.binder:BindToVisible(self.ui.Red_Task, function()
    do return end
    return RedPointDataUtils.GetActivityKarenTaskEntryRed, nil
  end)
end

function ActivityKarenComp:_BindSignEntry()
  self.binder:BindToText(self.ui.Text_SignProgress, function()
    local taskDataList = ActivityKarenUtils.GetSignTaskDataList(self.activityData)
    local receivedNum = 0
    for _, taskData in ipairs(taskDataList) do
      if taskData.state == CommonDefine.TaskState.Done then
        receivedNum = receivedNum + 1
      end
    end
    return receivedNum
  end)
  self.binder:BindToText(self.ui.Text_TotalProgress, function()
    local taskDataList = ActivityKarenUtils.GetSignTaskDataList(self.activityData)
    return #taskDataList
  end)
  self.binder:BindButtonClick(self.ui.Btn_Sign, System.fn(self, self._OnClickBtnSign))
  self.binder:BindToVisible(self.ui.Red_Sign, function()
    do return end
    return RedPointDataUtils.GetActivityKarenSignEntryRed, nil
  end)
end

function ActivityKarenComp:_OnClickBtnReward()
  local coinTid = self.activityConfig.ActivityPara3[1]
  local taskList = self:_GetRewardTaskList()
  local extraData = {
    title = LT.Text("KarenActivityRewardTitle"),
    bottomText = LT.Textf("KarenActivityRewardBottomText", ItemDataUtils.GetItemNum(coinTid))
  }
  UIManager.Instance:Reopen(Urls.ActivityTaskListPanel, self.activityTid, taskList, extraData)
end

function ActivityKarenComp:_OnClickBtnTask()
  UIManager.Instance:Reopen(Urls.ActivityKarenTaskView, self.activityData)
end

function ActivityKarenComp:_OnClickBtnSign()
  UIManager.Instance:Reopen(Urls.ActivityKarenSevenDaySignPanel, self.activityData)
end

function ActivityKarenComp:BindAchievementProgress()
  local parentTaskList = ActivityDataUtils.GetTaskList(self.activityTid)
  self.binder:BindToVisible(self.ui.Btn_Reward, function()
    local taskList = self.activityData.taskList
    return taskList and table.next(taskList)
  end)
  self.binder:BindZ1Button(self.ui.Btn_Reward, function()
    local taskList = self.activityData.taskList
    UIManager.Instance:Reopen(Urls.ActivityAchievementPanel, self.activityData, parentTaskList, taskList)
  end)
  self.binder:BindToText(self.ui.Text_AchieveProgress, function()
    local taskList = self.activityData.taskList
    local percent = self:GetTaskProgressPercent(taskList, parentTaskList)
    do return string.format, "%s%%" end
    return string.format, "%s%%", percent
  end)
  self.binder:BindComponent(NewRedCom(self.ui.Red_Achieve)):BindActivityTask(self.activityData)
end

function ActivityKarenComp:BindSubPlotRecord()
  Super.BindSubPlotRecord(self)
end

function ActivityKarenComp:BindBtnChallenge()
  if self.hasFinishedActivity then
    self.ui.Btn_Challenge:SetActive(false)
    return
  end
  self.binder:BindZ1Button(self.ui.Btn_Challenge, function()
    ActivityController.Instance:OpenActivityStageGroupPanel(self.activityData, self.resonanceGroupId)
  end)
  local stageGroupTypeId = self.activityConfig.ActivityPara1[1]
  local stageGroupList = CopyDataUtils.GetStageGroupIdList(stageGroupTypeId)
  self:BindNewStageGroupRed(stageGroupList)
end

function ActivityKarenComp:_RedFunc()
  local shopTypeList = ShopExtModel.Instance:GetShopTypeListByActivityTid(self.activityTid)
  do return RedPointDataUtils.GetShopRedByShopTypes end
  return RedPointDataUtils.GetShopRedByShopTypes, shopTypeList
end

function ActivityKarenComp:PlayTimeline(timelinePath)
  self:ClearTimeline()
  local timelinePatn = timelinePath
  self.player = self.ui.uiNode
  self.timelinePlayer = PortraitTimelinePlayer(self.player)
  local timelineConfig = TimelineConfig()
  timelineConfig.assetPath = timelinePath
  self.timelinePlayer:Play(timelineConfig)
end

function ActivityKarenComp:ClearTimeline()
  if self.timelinePlayer then
    self.timelinePlayer:Stop()
    self.timelinePlayer:Dispose()
    self.timelinePlayer = nil
  end
end

function ActivityKarenComp:OnOpenAnim(callback)
  self.ui.UI_Events_Panel_Lily_Audio:SetActive(self.audioPlay)
  if not self.audioPlay then
    self.audioPlay = true
  end
  if self.activtyDefine.openAnim then
    self.uiAnimController:PlayState(self.activtyDefine.openAnim, callback)
  elseif self.activtyDefine.openTimeline then
    self.ui.uiNode:SetActive(true)
    self:PlayTimeline(self.activtyDefine.openTimeline)
  else
    self.ui.uiNode:SetActive(true)
    if callback then
      callback()
    end
  end
end

function ActivityKarenComp:OnCloseAnim(callback)
  self.ui.UI_Events_Panel_Lily_Audio:SetActive(false)
  if self.activtyDefine.closeAnim then
    self.uiAnimController:PlayState(self.activtyDefine.closeAnim, callback)
  elseif self.activtyDefine.endTimeline then
    self:PlayTimeline(self.activtyDefine.endTimeline)
  else
    self.ui.uiNode:SetActive(false)
    if callback then
      callback()
    end
  end
end

function ActivityKarenComp:OnUnbind()
  Super.OnUnbind(self)
  self.ui.UI_Events_Panel_Lily_Audio:SetActive(false)
  self:ClearTimeline()
end

function ActivityKarenComp:_GetRewardTaskList()
  local rst = {}
  for tid, _ in pairs(self.activityData.taskList) do
    if TaskCfgUtils.GetCfgField("CompleteCond", tid) == TaskDefine.CompleteCond.ActivityStatCount then
      local taskData = TaskDataUtils.GetTaskData(tid)
      table.insert(rst, taskData)
    end
  end
  table.sort(rst, function(a, b)
    local aSortId = TaskCfgUtils.GetCfgField("BaseSortID", a.tid)
    local bSortId = TaskCfgUtils.GetCfgField("BaseSortID", b.tid)
    return aSortId < bSortId
  end)
  return rst
end

return ActivityKarenComp
