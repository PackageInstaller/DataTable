local TaskParentChildView, Super = NewClass("TaskParentChildView", BaseView)
TaskParentChildView.uiResCls = UI_Task_Popup_CareerResource
local TaskServerIndex = CommonDefine.TaskServerIndex

function TaskParentChildView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnTaskParentChildServerIndexChanged, self._OnTaskParentChildServerIndexChanged, self)
  self:RegisterLocalNotify(NotifyId.OnTaskParentChildChapterChanged, self._OnTaskParentChildChapterChanged, self)
end

function TaskParentChildView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Get, System.fn(self, self._OnFatherTaskClickCb))
  self:AddButtonClickListener(self.ui.Btn_Click_UP, System.fn(self, self._OnPreviousClickCb))
  self:AddButtonClickListener(self.ui.Btn_Click_Down, System.fn(self, self._OnNextClickCb))
  self:AddButtonClickListener(self.ui.Btn_OneKey, System.fn(self, self._OnOneKeyReward))
  self:_BindChildrenTaskView()
  self:BindEvent(EventMgr.Instance.CommonRewardPanelClose, function()
    local curChapter = TaskParentChildModel.Instance:GetCurTaskSelectChapter()
    local taskCareerGroupData = TaskParentChildModel.Instance:GetTaskGroupsData()
    if self:_IsCurFatherTaskCanRceive() and curChapter < #taskCareerGroupData then
      EventMgr.Instance.TaskShowAnim:Dispatch("UI_Task_Popup_Career_New_Receive", function()
        TaskParentChildModel.Instance:SetTaskServerIndex(TaskParentChildModel.Instance:GetCurTaskServerIndex())
        TaskParentChildModel.Instance:SetCurTaskSelectChapter(curChapter + 1)
      end)
    end
  end)
  self:BindEvent(EventMgr.Instance.TaskViewUpdate, function(serverIdx)
    if serverIdx == TaskParentChildModel.Instance:GetCurTaskServerIndex() then
      self:_RefreshParentTask()
    end
  end)
end

function TaskParentChildView:_IsCurFatherTaskCanRceive()
  local curGroupData = TaskParentChildModel.Instance:GetCurGroupData()
  if not curGroupData then
    return false
  end
  local fatherTask = curGroupData.fatherTask
  return fatherTask.state == CommonDefine.TaskState.Done
end

function TaskParentChildView:_BindChildrenTaskView()
  self.childrenTaskView = self:CreateTableview(self.ui.ScrollView, function()
    if not self.childsTasks then
      return 0
    end
    return #self.childsTasks
  end, function(view, index)
    do return self._ChildTaskCellAtIndex, self, view end
    return self._ChildTaskCellAtIndex, self, view, index
  end, function()
    return 926, 150
  end)
end

function TaskParentChildView:_ChildTaskCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Task_Item_Detail_List_New)
  local taskData = self.childsTasks[index]
  self:AddViewComponentOnce(cell.gameObject, ParentChildTaskStateItem, taskData)
  return cell
end

function TaskParentChildView:OnEnterView()
  Super.OnEnterView(self)
  self:SetText(self.ui.Text_Normal_Get, LT.Text("TaskAward_Btn_Completed"))
  self:SetText(self.ui.Text_Disable_Get, LT.Text("TaskAward_Btn_Completed"))
  self:_RefreshParentTask()
end

function TaskParentChildView:RefreshOnRendered()
  self:_RefreshParentTask()
end

function TaskParentChildView:PlayOpenAnimation()
  if self.childrenTaskView.isReady then
    self:PlayTableViewFadeInAnim(self.ui.ScrollView)
  else
    function self.childrenTaskView.reloadFinishCallback()
      self.childrenTaskView.reloadFinishCallback = nil
      
      self:PlayTableViewFadeInAnim(self.ui.ScrollView)
    end
  end
end

function TaskParentChildView:_RefreshRedDotComponent()
  self.binder:BindComponent(RedDotComponent(self.ui.Com_RedDotUP, CommonDefine.RedDotType.Dot, nil, System.fn(self, self._OnRedPointFuncPreviousBtn)))
  self.binder:BindComponent(RedDotComponent(self.ui.Com_RedDotDown, CommonDefine.RedDotType.Dot, nil, System.fn(self, self._OnRedPointFuncNextBtn)))
end

function TaskParentChildView:_OnOneKeyReward()
  local rewardTaskList = self:GetCanRewardTaskTidList()
  if #rewardTaskList > 0 then
    local page = TaskModel.Instance:GetCurTaskPage()
    local serverIdx = TaskModel.Instance:GetPageServerIndex(page)
    print("-------------------_OnOneKeyReward", page, serverIdx)
    if self:IsParentAndChildTask() then
      TaskController.Instance:ReqOnBatchGainPrize(serverIdx, rewardTaskList)
    else
      TaskController.Instance:ReqOnTaskGainAllPrize(serverIdx, function(data)
      end)
    end
  end
end

function TaskParentChildView:IsHaveReward()
  return #self:GetCanRewardTaskTidList() > 0
end

function TaskParentChildView:GetCanRewardTaskTidList()
  local taskTidList = {}
  local page = TaskModel.Instance:GetCurTaskPage()
  local serverIdx = TaskModel.Instance:GetPageServerIndex(page)
  if self:IsParentAndChildTask() then
    local curGroupData = TaskParentChildModel.Instance:GetCurGroupData()
    if not curGroupData then
      return taskTidList
    end
    local childsTasks = curGroupData.childsTasks
    local isAllDone = table.next(childsTasks)
    for _, task in pairs(childsTasks) do
      if task.state == cd.TaskState.Receive then
        table.insert(taskTidList, task.tid)
      end
      if task.state ~= cd.TaskState.Done then
        isAllDone = false
      end
    end
    if isAllDone and curGroupData.fatherTask.state == cd.TaskState.Receive then
      table.insert(taskTidList, curGroupData.fatherTask.tid)
    end
    return taskTidList
  else
    local allTaskList = TaskDataUtils.GetTaskDataListBySvrIdx(serverIdx)
    for _, taskData in pairs(allTaskList) do
      if taskData.state == cd.TaskState.Receive then
        table.insert(taskTidList, taskData.tid)
      end
    end
    return taskTidList
  end
end

function TaskParentChildView:IsParentAndChildTask()
  local page = TaskModel.Instance:GetCurTaskPage()
  local serverIdx = TaskModel.Instance:GetPageServerIndex(page)
  print("========== serverIdx ==========", serverIdx, page, debug.traceback())
  return serverIdx == cd.TaskServerIndex.Career or serverIdx == cd.TaskServerIndex.School
end

function TaskParentChildView:OnExitView()
  Super.OnExitView(self)
end

function TaskParentChildView:_OnTaskParentChildServerIndexChanged()
  self:_RefreshParentTask()
end

function TaskParentChildView:_OnTaskParentChildChapterChanged()
  self:_RefreshParentTask()
  self:PlayTableViewFadeInAnim(self.ui.ScrollView)
end

function TaskParentChildView:_RefreshParentTask()
  local curGroupData = TaskParentChildModel.Instance:GetCurGroupData()
  if not curGroupData then
    return
  end
  local childsTasks = curGroupData.childsTasks
  local fatherTask = curGroupData.fatherTask
  local fatherTaskCfg = DT.Task[fatherTask.tid]
  self:SetText(self.ui.Text_Chapter_Number, fatherTaskCfg.Name)
  self:SetText(self.ui.Text_Chapter_Tips, fatherTaskCfg.Desc)
  self:SetText(self.ui.Text_Total_Progress, LT.Textf("UniversalProgressDisplay", fatherTask.count, #childsTasks))
  self:SetImageFillAmount(self.ui.Image_Bar, fatherTask.count / #childsTasks)
  if fatherTask.state == CommonDefine.TaskState.Done then
    self:SetReceiveState(CommonDefine.BtnType.High)
  else
    local canReceiveFatherTask = fatherTask.state == CommonDefine.TaskState.Receive and fatherTask.count == #childsTasks
    self:EnableFatherTaskBtn(canReceiveFatherTask)
  end
  self:_RefreshFatherTaskAwards(fatherTask)
  self:_RefreshSelectChapter()
  self:_RefreshChildrenTaskview()
  self:_RefreshRedDotComponent()
  self:SetButtonState(self.ui.Btn_OneKey, self:IsHaveReward() and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
end

function TaskParentChildView:SetReceiveState(state)
  self.ui.Text_C_Get:SetActive(state == CommonDefine.BtnType.High)
  self.ui.Image_Normal_Get:SetActive(state == CommonDefine.BtnType.Normal)
  self.ui.Image_Disable_Get:SetActive(state == CommonDefine.BtnType.Unclickable)
end

function TaskParentChildView:EnableFatherTaskBtn(enabled)
  if enabled then
    self:SetReceiveState(CommonDefine.BtnType.Normal)
  else
    self:SetReceiveState(CommonDefine.BtnType.Unclickable)
  end
end

function TaskParentChildView:SetPreviousBtnState(state)
  self.ui.Icon_Normal_UP:SetActive(state == CommonDefine.BtnType.Normal)
  self.ui.Icon_Disable_UP:SetActive(state == CommonDefine.BtnType.Unclickable)
end

function TaskParentChildView:SetNextBtnState(state)
  self.ui.Icon_Normal_Down:SetActive(state == CommonDefine.BtnType.Normal)
  self.ui.Icon_Disable_Down:SetActive(state == CommonDefine.BtnType.Unclickable)
end

function TaskParentChildView:EnablePreviousBtn(enabled)
  if enabled then
    self:SetPreviousBtnState(CommonDefine.BtnType.Normal)
  else
    self:SetPreviousBtnState(CommonDefine.BtnType.Unclickable)
  end
end

function TaskParentChildView:EnableNextBtn(enabled)
  if enabled then
    self:SetNextBtnState(CommonDefine.BtnType.Normal)
  else
    self:SetNextBtnState(CommonDefine.BtnType.Unclickable)
  end
end

function TaskParentChildView:_RefreshFatherTaskAwards(fatherTask)
  local fatherTaskCfg = DT.Task[fatherTask.tid]
  local tempList = {}
  local tempAwardList = {}
  local itemCountMap = {}
  for key, count in table.iteraDouble(fatherTaskCfg.CompleteAward or {}) do
    table.insert(tempList, key)
    itemCountMap[key] = count
  end
  for _, itemId in pairs(tempList) do
    table.insert(tempAwardList, {
      tid = itemId,
      num = itemCountMap[itemId]
    })
  end
  local awardNum = #tempAwardList
  for i = 1, 4 do
    local item = self.ui["Awaed_" .. i]
    if i <= awardNum then
      item:SetActive(true)
      local itemRes = UI_Common_Item_WuPin_Type1Resource(item)
      self.binder:CheckUpdatePanelResource(item, DataCenter.gameData.CurrTextLanguage)
      local data = tempAwardList[i]
      local itemCfg = DT.Item[data.tid]
      if itemCfg.Type == "DropItem" then
        self:SetText(itemRes.Text_Article_Number, "")
      else
        self:SetText(itemRes.Text_Article_Number, StrUtils.NumberConvert(data.num))
      end
      self:SetImage(itemRes.Icon_Article, ItemDataUtils.GetItemIcon(data.tid))
      self:SetImage(itemRes.Image_Quality, ItemDataUtils.GetCommonItemBottomQualityFrame(itemCfg, itemRes.Image_Bg_Black))
      self:SetLongPressButtonIntervalTime(itemRes.Btn_Click, tonumber(DT.GetConstant("Role_Press_Time")))
      self:AddShortPressButtonListener(itemRes.Btn_Click, function()
        ItemDataUtils.ShowItemDetailTips(self.binder, item, nil, data.tid, true)
      end)
      itemRes.Image_Dis:SetActive(fatherTask.state == CommonDefine.TaskState.Done)
    else
      item:SetActive(false)
    end
  end
end

function TaskParentChildView:_RefreshChildrenTaskview()
  local curGroupData = TaskParentChildModel.Instance:GetCurGroupData()
  if not curGroupData then
    return
  end
  self.childsTasks = TaskModel.Instance:SortTaskList(curGroupData.childsTasks)
  self.childrenTaskView:ReloadData()
end

function TaskParentChildView:_RefreshSelectChapter()
  local curChapter = TaskParentChildModel.Instance:GetCurTaskSelectChapter()
  local firstChapter, lastChapter = self:_CalculateChaptersRange()
  self:EnablePreviousBtn(curChapter > firstChapter)
  self:EnableNextBtn(curChapter < lastChapter)
  local taskCareerGroupData = TaskParentChildModel.Instance:GetTaskGroupsData()
  self.ui.Group_UP:SetActive(1 ~= curChapter)
  self.ui.Group_Down:SetActive(curChapter ~= #taskCareerGroupData)
end

function TaskParentChildView:_CalculateChaptersRange()
  local groupDatas = TaskParentChildModel.Instance:GetTaskGroupsData()
  if not groupDatas then
    return 0, 0
  end
  local curChapter = TaskParentChildModel.Instance:GetCurTaskSelectChapter()
  local serverIdx = TaskParentChildModel.Instance:GetCurTaskServerIndex()
  local chapterNum = #groupDatas
  local lastChapter
  if serverIdx == TaskServerIndex.Career then
    curChapter = TaskParentChildModel.Instance:GetFirstUnCompleteFatherChapter()
    lastChapter = chapterNum < curChapter and chapterNum or curChapter
  else
    lastChapter = chapterNum
  end
  local firstChapter = 1
  if curChapter < firstChapter or curChapter > lastChapter then
    return 0, 0
  end
  return firstChapter, lastChapter
end

function TaskParentChildView:_OnFatherTaskClickCb()
  local curGroupData = TaskParentChildModel.Instance:GetCurGroupData()
  if not curGroupData then
    return
  end
  local fatherTask = curGroupData.fatherTask
  local childsTasks = curGroupData.childsTasks
  if fatherTask.state ~= CommonDefine.TaskState.Done then
    local canReceiveFatherTask = fatherTask.state == CommonDefine.TaskState.Receive and fatherTask.count == #childsTasks
    if not canReceiveFatherTask then
      Alert.ShowStr(LT.Text("Task_Career_Parent_Pickup_Tips"))
      return
    end
    TaskDataUtils.TaskComplete(fatherTask.uid)
  end
end

function TaskParentChildView:_OnPreviousClickCb()
  if not self:_IsPrePreviousBtnEnable() then
    Alert.ShowStr(LT.Text("Task_Career_LastChapter_Tips"))
  else
    local curChapter = TaskParentChildModel.Instance:GetCurTaskSelectChapter()
    TaskParentChildModel.Instance:SetCurTaskSelectChapter(curChapter - 1)
  end
end

function TaskParentChildView:_OnNextClickCb()
  if not self:_IsNextBtnEnable() then
    Alert.ShowStr(LT.Text("Task_Career_NextChapter_Tips"))
  else
    local curChapter = TaskParentChildModel.Instance:GetCurTaskSelectChapter()
    TaskParentChildModel.Instance:SetCurTaskSelectChapter(curChapter + 1)
  end
end

function TaskParentChildView:_IsPrePreviousBtnEnable()
  local curChapter = TaskParentChildModel.Instance:GetCurTaskSelectChapter()
  local firstChapter = self:_CalculateChaptersRange()
  if curChapter <= firstChapter then
    return false
  end
  return true
end

function TaskParentChildView:_IsNextBtnEnable()
  local curChapter = TaskParentChildModel.Instance:GetCurTaskSelectChapter()
  local _, lastChapter = self:_CalculateChaptersRange()
  if curChapter >= lastChapter then
    return false
  end
  return true
end

function TaskParentChildView:_OnRedPointFuncPreviousBtn()
  if not self:_IsPrePreviousBtnEnable() then
    return false
  end
  local firstChap = 1
  local curChapter = TaskParentChildModel.Instance:GetCurTaskSelectChapter()
  local finalChap = curChapter - 1
  if firstChap > finalChap then
    return false
  end
  if self:CheckTaskGroupHaveComplete(firstChap, finalChap) then
    return RedPointDataUtils.RedAttrType.Red
  end
  return false
end

function TaskParentChildView:_OnRedPointFuncNextBtn()
  if not self:_IsNextBtnEnable() then
    return false
  end
  local curChapter = TaskParentChildModel.Instance:GetCurTaskSelectChapter()
  local _, lastChapter = self:_CalculateChaptersRange()
  local firstChap = curChapter + 1
  local finalChap = lastChapter
  if firstChap > finalChap then
    return false
  end
  if self:CheckTaskGroupHaveComplete(firstChap, finalChap) then
    return RedPointDataUtils.RedAttrType.Red
  end
  return false
end

function TaskParentChildView:CheckTaskGroupHaveComplete(firstChap, finalChap)
  local taskCareerGroupData = TaskParentChildModel.Instance:GetTaskGroupsData()
  for i = firstChap, finalChap do
    local dataGroup = taskCareerGroupData[i]
    if dataGroup.fatherTask.state == CommonDefine.TaskState.Receive then
      return true
    end
    for _, childTask in pairs(dataGroup.childsTasks) do
      if childTask.state == CommonDefine.TaskState.Receive then
        return true
      end
    end
  end
  return false
end

return TaskParentChildView
