local TaskServerIndex = CommonDefine.TaskServerIndex
local TaskState = CommonDefine.TaskState
local BtnType = CommonDefine.BtnType
local RedType = RedTypeDefine.RedType
local RECEIVE_DELTA_TIME = 0.5
local isOkTxtColor = CommonDefine.TaskConditionTextColor.IsAchieveColor
local notOkTxtColor = CommonDefine.TaskConditionTextColor.NotAchieveColor
local lockedWeight = 1
local unlockWeight = 0
local sortWeight = {
  [TaskState.Receive] = 1,
  [TaskState.Doing] = 2,
  [TaskState.Done] = 3,
  [TaskState.UnDone] = 4
}
local dispatchBtnStateMap = {
  [TaskState.Doing] = BtnType.Unclickable,
  [TaskState.UnDone] = BtnType.High,
  [TaskState.Receive] = BtnType.High
}
local dispatchBtnTextMap = {
  [TaskState.Doing] = "",
  [TaskState.UnDone] = LT.Text("Task_Dispatch_Select"),
  [TaskState.Receive] = LT.Text("TaskModule_btn_reward")
}
local TaskDispatchAppointComp, Super = NewViewComponent("TaskDispatchAppointComp")

function TaskDispatchAppointComp:ctor(uiNode, view)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Research_Panel_Dispatch_ContentResource(uiNode)
end

function TaskDispatchAppointComp:OnEnterComponent()
  self._serverIdx = TaskServerIndex.Appoint
  self._taskList = {}
  self._tabItems = {}
  self._selectedUid = nil
  self._vueTaskData = {}
  self._awardList = {}
  self._extraAwardList = {}
  self._haveGet = false
  self._getTimer = nil
  self:_CreateTaskListTableview()
  self:_CreateAwardListTableview()
  self:_BindButtons()
  self:BindEvent(EventMgr.Instance.TaskViewUpdate, System.fn(self, self._OnTaskViewUpdate))
  self:_OnTaskViewUpdate(self._serverIdx)
end

function TaskDispatchAppointComp:_CreateTaskListTableview()
  local cellRT = self.ui.UI_Research_Panel_Dispatch_Item.transform
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self._taskTableView = self.view:CreateTableview(self.ui.ScrollView_Task, function()
    return #self._taskList
  end, function(view, index)
    local taskData = self._taskList[index]
    if not taskData then
      return nil
    end
    local cell = self.view:DequeueCell(view, self.ui.UI_Research_Panel_Dispatch_Item)
    local isSelected = self._selectedUid == taskData.uid
    local comp = self.view:AddViewComponentOnce(cell.gameObject, TaskDispatchTabItem)
    comp:Refresh(taskData, isSelected, System.fn(self, self._OnSelectTask))
    self._tabItems[taskData.uid] = comp
    return cell
  end, function()
    return width, height
  end)
end

function TaskDispatchAppointComp:_CreateAwardListTableview()
  local cellRT = self.ui.UI_Common_Item_WuPin_Type2.transform
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self._awardTableView = self.view:CreateTableview(self.ui.ScrollView_Award, function()
    return #(self._awardList or {})
  end, function(view, index)
    local data = self._awardList[index]
    if not data then
      return nil
    end
    local cell = self.view:DequeueCell(view, self.ui.UI_Common_Item_WuPin_Type2)
    local itemData = self:_BuildAwardItemData(data)
    self.view:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, itemData)
    return cell
  end, function()
    return width, height
  end)
end

function TaskDispatchAppointComp:_BindButtons()
  self.view:AddButtonClickListener(self.ui.UI_Common_Btn_Dispatch, System.fn(self, self._OnClickBtnDispatch))
  self.view:AddButtonClickListener(self.ui.Btn_Recall, System.fn(self, self._OnClickBtnRecall))
  self.view:AddButtonClickListener(self.ui.Btn_1, System.fn(self, self._OnClickReceiveAll))
  self.view:AddButtonClickListener(self.ui.UI_Common_Btn_Question, System.fn(self, self._OnClickRole))
  self:SetActive(self.ui.UI_Awaker_Button_Addition, false)
end

function TaskDispatchAppointComp:_OnTaskViewUpdate(viewIndex)
  if viewIndex ~= self._serverIdx then
    return
  end
  local curUid = self._vueTaskData.uid
  if curUid then
    local tmpData = TaskDataUtils.GetTaskData(curUid)
    if not tmpData or tmpData.state == TaskState.Done then
      self._selectedUid = nil
    end
  end
  local tempList = self:_SortAppointTaskList(table.clone(TaskDataUtils.GetTaskDataListBySvrIdx(self._serverIdx) or {}))
  EventMgr.Instance.TaskPageEmptyShow:Dispatch(0 == #tempList)
  self._taskList = tempList
  self._tabItems = {}
  if self._taskTableView then
    self._taskTableView:ReloadData()
  end
  self:_RefreshReceiveAllBtn()
  self:_RefreshRefreshText()
  local subTaskData = TaskDataUtils.GetTaskData(self._selectedUid)
  if not subTaskData and #tempList > 0 then
    subTaskData = tempList[1]
  end
  self:_SetSubView(subTaskData)
end

function TaskDispatchAppointComp:_OnSelectTask(taskData, tabItem)
  if not taskData then
    return
  end
  if taskData.lock then
    tabItem:SetIsSelected(false)
    local tips = TaskDataUtils.GetLockedTips(taskData.uid)
    if not tips then
      return
    end
    Alert.ShowStr(tips)
    return
  end
  if RedPointDataUtils.GetRedPointState(RedType.AppointTaskNew, {
    taskData.uid
  }) == RedPointDataUtils.RedAttrType.IsNew then
    RedPointDataUtils.ReqRemoveData(RedType.AppointTaskNew, RedPointDataUtils.RedAttrType.IsNew, taskData.uid)
  end
  if self._selectedUid then
    local lastItem = self._tabItems[self._selectedUid]
    if lastItem and lastItem.SetIsSelected then
      lastItem:SetIsSelected(false)
    end
  end
  self._selectedUid = taskData.uid
  tabItem:SetIsSelected(true)
  self:_SetSubView(taskData)
end

function TaskDispatchAppointComp:_SetSubView(taskData)
  if not taskData or not taskData.tid then
    self._vueTaskData = {}
    self:SetActive(self.ui.Group_Task, false)
    self:SetActive(self.ui.Group_Empty, 0 == #self._taskList)
    return
  end
  self._vueTaskData = taskData
  local taskCfg = DT.Task[taskData.tid]
  self:_SetTaskTextInfo(taskData.tid)
  self:_RefreshCondition()
  local sendAwakerList = table.clone(taskData.awakerList or {})
  self._awardList = TaskDataUtils.GetDispatchAwardList(taskCfg, sendAwakerList)
  self._extraAwardList = {}
  for itemTid, count in pairs(taskCfg.ExtraAward or {}) do
    table.insert(self._extraAwardList, {itemTid = itemTid, count = count})
  end
  if self._awardTableView then
    self._awardTableView:ReloadData()
  end
  self:SetActive(self.ui.Group_Task, true)
  self:SetActive(self.ui.Group_Empty, false)
  self:_RefreshDispatchBtn()
  self:_RefreshRecallBtn()
  self:_RefreshTakeTime()
  self:_RefreshExtraAwardTips()
end

function TaskDispatchAppointComp:_SetTaskTextInfo(taskTid)
  if not taskTid then
    return
  end
  local taskCfg = DT.Task[taskTid]
  self:SetText(self.ui.Text_Task_Name, taskCfg.Name)
  self:SetText(self.ui.Text_Task_Desc, taskCfg.Desc)
end

function TaskDispatchAppointComp:_RefreshCondition()
  local taskData = self._vueTaskData
  if not taskData or not taskData.tid then
    return
  end
  local taskCfg = DT.Task[taskData.tid]
  local condInfo = TaskDataUtils.GetConditionInfo(taskCfg.CompleteCond, taskCfg.CompleteCondPara, taskData.awakerList)
  local conditionDesc = LT.Textf(taskCfg.CompleteCondDesc, table.unpack(taskCfg.CompleteCondPara))
  self:SetText(self.ui.Text_Special1, conditionDesc)
  self:SetTextColorByHtml(self.ui.Text_Special1, condInfo.isOk and isOkTxtColor or notOkTxtColor)
  self:SetTextColorType(self.ui.Text_C_Special2, self:_IsReachExtraAwardCond() and CommonDefine.ColorType.Light or CommonDefine.ColorType.Normal)
  self:SetActive(self.ui.Image_Icon_Cond_1, not condInfo.isOk)
  self:SetActive(self.ui.Image_Icon_Hook_1, condInfo.isOk)
  local hasExtraAward = TaskDataUtils.HasExtraAward(taskData.tid)
  self:SetActive(self.ui.Image_Icon_Cond_2, hasExtraAward and self:_ExtraAwardDarkShow())
  self:SetActive(self.ui.Image_Icon_Hook_2, self:_IsReachExtraAwardCond())
end

function TaskDispatchAppointComp:_NormalAwardDarkShow()
  local taskData = self._vueTaskData
  if not taskData or not taskData.tid then
    return false
  end
  local taskCfg = TaskDataUtils.GetConfig(taskData.tid)
  local condInfo = TaskDataUtils.GetConditionInfo(taskCfg.CompleteCond, taskCfg.CompleteCondPara, taskData.awakerList)
  return not condInfo.isOk
end

function TaskDispatchAppointComp:_ExtraAwardDarkShow()
  local taskData = self._vueTaskData
  if not taskData or not taskData.tid then
    return false
  end
  local awakerList = taskData.awakerList
  local extraAwardInfo = TaskDataUtils.GetDispatchExtraAward(taskData.tid, awakerList)
  return not extraAwardInfo or not extraAwardInfo.reach
end

function TaskDispatchAppointComp:_IsReachExtraAwardCond()
  local taskData = self._vueTaskData
  if not taskData or not taskData.tid then
    return false
  end
  do return TaskDataUtils.IsReachDispatchExtraAwardCond, taskData.tid end
  return TaskDataUtils.IsReachDispatchExtraAwardCond, taskData.tid, taskData.awakerList
end

function TaskDispatchAppointComp:_IsShowExtraAwardTips()
  local taskData = self._vueTaskData
  if not taskData or not taskData.tid then
    return false
  end
  do return TaskDataUtils.HasExtraAward end
  return TaskDataUtils.HasExtraAward, taskData.tid
end

function TaskDispatchAppointComp:_RefreshExtraAwardTips()
  self:SetActive(self.ui.Image_Extra, self:_IsShowExtraAwardTips())
end

function TaskDispatchAppointComp:_RefreshTakeTime()
  self:SetText(self.ui.Text_Take, self:_GetTimeTakeText())
end

function TaskDispatchAppointComp:_GetTimeTakeText()
  local taskData = self._vueTaskData
  if not taskData or not taskData.tid then
    return ""
  end
  local state = taskData.state
  if state ~= TaskState.UnDone then
    return ""
  end
  local config = TaskDataUtils.GetConfig(taskData.tid)
  if not config or not config.NeedTime then
    return ""
  end
  do return self._ConvertNeedTimeShow end
  return self._ConvertNeedTimeShow, config.NeedTime * 60
end

function TaskDispatchAppointComp._ConvertNeedTimeShow(countDown)
  if not countDown or countDown <= 0 then
    return ""
  end
  local h = math.floor(countDown / 3600)
  local m = math.floor(countDown % 3600 / 60)
  if countDown >= 3600 then
    do return LT.Textf, "Task_Dispatch_NeedTime" end
    return LT.Textf, "Task_Dispatch_NeedTime", h
  elseif countDown >= 60 then
    do return LT.Textf, "Task_Dispatch_NeedTime_Min" end
    return LT.Textf, "Task_Dispatch_NeedTime_Min", m
  end
  return ""
end

function TaskDispatchAppointComp:_RefreshDispatchBtn()
  local taskData = self._vueTaskData
  local state = taskData.state
  local btnState = dispatchBtnStateMap[state] or BtnType.Unclickable
  self:SetButtonState(self.ui.UI_Common_Btn_Dispatch, btnState)
  local btnText = dispatchBtnTextMap[state] or ""
  self:SetText(self.ui.Text_High, btnText)
  local showRed = state == TaskState.Receive and RedPointDataUtils.RedAttrType.Red or false
  self.view:SetButtonRedPoint(self.ui.UI_Common_Btn_Dispatch, function()
    return showRed
  end)
end

function TaskDispatchAppointComp:_RefreshRecallBtn()
  local taskData = self._vueTaskData
  local show = taskData.state == TaskState.Doing
  self:SetActive(self.ui.Btn_Recall, show)
  if show then
    self:SetButtonState(self.ui.Btn_Recall, BtnType.High)
    self.view:SetButtonText(self.ui.Btn_Recall, LT.Text("Task_Dispatch_Callback_Title"))
  end
end

function TaskDispatchAppointComp:_RefreshReceiveAllBtn()
  local isSpecial = self:_CheckIsSpecialAppoint()
  self:SetActive(self.ui.Btn_1, not isSpecial)
  if isSpecial then
    return
  end
  local hasComplete = self:_CheckHaveCompleteTask()
  local btnState = hasComplete and BtnType.High or BtnType.Unclickable
  self:SetButtonState(self.ui.Btn_1, btnState)
  self.view:SetButtonText(self.ui.Btn_1, LT.Text("DispatchReceiveAll"))
  local showRed = hasComplete and RedPointDataUtils.RedAttrType.Red or false
  self.view:SetButtonRedPoint(self.ui.Btn_1, function()
    return showRed
  end)
end

function TaskDispatchAppointComp:_RefreshRefreshText()
  if self:_CheckIsSpecialAppoint() then
    self:SetText(self.ui.Text_Refresh, LT.Text("Task_Appoint_Newer_Tips"))
    self:SetActive(self.ui.Image_Icon_Time, true)
  else
    local curNum = TaskDataUtils.GetCurDispatchNum()
    local maxNum = TaskDataUtils.GetMaxDispatchNum()
    self:SetText(self.ui.Text_Refresh, LT.Textf("Task_Appoint_TimesLeft", curNum, maxNum))
    self:SetActive(self.ui.Image_Icon_Time, false)
  end
end

function TaskDispatchAppointComp:_OnClickBtnDispatch()
  local taskData = self._vueTaskData
  if taskData.state == TaskState.UnDone then
    self:_OnBtnGo()
  elseif taskData.state == TaskState.Receive then
    self:_OnBtnGet()
  end
end

function TaskDispatchAppointComp:_OnBtnGet()
  if self._haveGet then
    return
  end
  self._haveGet = true
  local sendAwakerList = table.clone(self._vueTaskData.awakerList or {})
  local taskTid = self._vueTaskData.tid
  local reDispatchData = {
    awakerList = sendAwakerList,
    awardList = self:_GetSendAwardList(taskTid, sendAwakerList),
    taskData = self._vueTaskData,
    taskTid = taskTid
  }
  local viewData = {
    [taskTid] = reDispatchData
  }
  TaskModel.Instance:SetPopTipRewards(viewData)
  TaskModel.Instance:SetNeedCalcReward(true)
  TaskDataUtils.TaskComplete(self._vueTaskData.uid, function(serverData)
    TaskModel.Instance:SetNeedCalcReward(false)
    self._getTimer = self.view:BindTimer(RECEIVE_DELTA_TIME, 0, nil, function()
      self._haveGet = false
      EventMgr.Instance.TaskViewUpdate:Dispatch(self._serverIdx)
    end)
  end, false)
end

function TaskDispatchAppointComp:_OnBtnGo()
  if not TaskDataUtils.EnableDispatch() then
    Alert.Show(10649)
    return
  end
  local list = {}
  local taskCfg = DT.Task[self._vueTaskData.tid]
  if taskCfg.MaxAwakerNum then
    for i = 1, taskCfg.MaxAwakerNum do
      list[i] = 0
    end
  end
  local panelData = {
    awakerDataMap = AwakerDataUtils.GetOwnedAwakerMap(),
    teamAwakerTids = list,
    recommandSchoolTids = {},
    challengeFunc = System.fn(self, self._OnBuildTeamBack),
    opponent = nil,
    taskData = table.deepclone(self._vueTaskData) or nil
  }
  TaskDataUtils.OpenAppointBuildTips(panelData)
end

function TaskDispatchAppointComp:_OnBuildTeamBack(awakerList, taskData)
  if not taskData or not TaskDataUtils.GetTaskData(taskData.uid) then
    UIManager.Instance:CloseByUrl(Urls.TaskAppointBuildTips)
    Alert.ShowStr(LT.Text("Task_Appoint_NonExistent"))
    return
  end
  TaskController.Instance:ReqOnTaskAwakerDelegate(self._vueTaskData, self._vueTaskData.uid, awakerList)
end

function TaskDispatchAppointComp:_OnClickBtnRecall()
  local taskData = self._vueTaskData
  if taskData.state ~= TaskState.Doing then
    return
  end
  TaskDataUtils.OpenRecallTips(function()
    if self._vueTaskData.state ~= TaskState.Receive then
      TaskController.Instance:ReqOnTaskRecallAwaker(self._vueTaskData, self._vueTaskData.uid)
    else
      Alert.ShowStr(LT.Text("Task_Dispatch_FinishedTips"))
    end
  end, self._vueTaskData.awakerList)
end

function TaskDispatchAppointComp:_OnClickReceiveAll()
  if not self:_CheckHaveCompleteTask() then
    Alert.ShowStr(LT.Text("DispatchNoReceiveTask"))
    return
  end
  local completeTaskTids = self:_GetCompleteTaskTids()
  local completeTaskData = {}
  for _, taskTid in pairs(completeTaskTids) do
    completeTaskData[taskTid] = table.clone(TaskDataUtils.GetTaskData(taskTid))
  end
  local viewData = {}
  for _, tid in pairs(completeTaskTids) do
    local taskData = completeTaskData[tid]
    local sendAwakerList = taskData.awakerList
    local sendAwardList = self:_GetSendAwardList(tid, sendAwakerList)
    viewData[tid] = {
      awakerList = sendAwakerList,
      awardList = sendAwardList,
      taskData = taskData,
      taskTid = tid
    }
  end
  TaskModel.Instance:SetPopTipRewards(viewData)
  TaskModel.Instance:SetNeedCalcReward(true)
  TaskController.Instance:ReqOnTaskGainAllPrize(self._serverIdx, function()
    TaskModel.Instance:SetNeedCalcReward(false)
  end)
end

function TaskDispatchAppointComp:_OnClickRole()
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("RuleTipsTitle"), LT.Text("Task_Appoint_Rules"))
end

function TaskDispatchAppointComp:_GetSendAwardList(taskTid, sendAwakerList)
  local taskCfg = DT.Task[taskTid]
  local awardList = TaskDataUtils.GetDispatchAwardList(taskCfg, sendAwakerList)
  local rst = {}
  for _, awardData in pairs(awardList) do
    if not awardData.isExtra or awardData.reach then
      local sendAward = {
        tid = awardData.itemTid,
        changedNum = awardData.count,
        uid = 0,
        extraDescFunc = awardData.reach and TaskDataUtils.GetExtraAwardTagText or nil
      }
      setmetatable(sendAward, ReactiveFlags.SKIP)
      table.insert(rst, sendAward)
    end
  end
  rst = ItemDataUtils.HandleExpBonusReward(rst)
  return rst
end

function TaskDispatchAppointComp:_BuildAwardItemData(data)
  local itemCount
  local itemCfg = DT.Item[data.itemTid]
  if itemCfg.Type == "DropItem" then
    itemCount = ""
  else
    itemCount = data.count
  end
  local isShowDark = false
  if data.isExtra then
    isShowDark = self:_ExtraAwardDarkShow()
  else
    isShowDark = self:_NormalAwardDarkShow()
  end
  local extraDesc
  if data.isExtra then
    extraDesc = TaskDataUtils.GetExtraAwardTagText()
  end
  return {
    itemTid = data.itemTid,
    itemCount = itemCount,
    isGot = false,
    extraDescBgType = CommonDefine.CommonIconExtraDescBgType.Blue,
    isShowDarkMask = isShowDark,
    extraDesc = extraDesc
  }
end

function TaskDispatchAppointComp:_CheckHaveCompleteTask()
  return table.next(self:_GetCompleteTaskTids()) ~= nil
end

function TaskDispatchAppointComp:_GetCompleteTaskTids()
  local rst = {}
  for _, taskData in pairs(self._taskList) do
    if taskData.state == TaskState.Receive then
      table.insert(rst, taskData.tid)
    end
  end
  return rst
end

function TaskDispatchAppointComp:_CheckIsSpecialAppoint()
  return 0 ~= TaskDataUtils.GetIsSpecialAppoint()
end

function TaskDispatchAppointComp:_SortAppointTaskList(taskItemList)
  if not taskItemList or 0 == #taskItemList then
    return taskItemList
  end
  for i = #taskItemList, 1, -1 do
    if taskItemList[i].state == TaskState.Done then
      table.remove(taskItemList, i)
    end
  end
  table.sort(taskItemList, function(a, b)
    if a.lock == b.lock then
      if a.state == b.state then
        local aCfg = DT.Task[a.tid]
        local bCfg = DT.Task[b.tid]
        local aSearchTime = (aCfg.NeedTime or 0) * 60
        local bSearchTime = (bCfg.NeedTime or 0) * 60
        local aNeedTime = a.state == TaskState.UnDone and aSearchTime or math.max(0, aSearchTime - (TimeUtils.GetServerTime() - (a.ts or TimeUtils.GetServerTime())))
        local bNeedTime = b.state == TaskState.UnDone and bSearchTime or math.max(0, bSearchTime - (TimeUtils.GetServerTime() - (b.ts or TimeUtils.GetServerTime())))
        if aNeedTime == bNeedTime then
          return aCfg.BaseSortID < bCfg.BaseSortID
        end
        return aNeedTime < bNeedTime
      end
      return sortWeight[a.state] < sortWeight[b.state]
    end
    local lockWeightA = a.lock and lockedWeight or unlockWeight
    local lockWeightB = b.lock and lockedWeight or unlockWeight
    return lockWeightA < lockWeightB
  end)
  if self._selectedUid == nil then
    local firstTaskData = taskItemList[1]
    if firstTaskData then
      self._selectedUid = firstTaskData.uid
    end
  end
  return taskItemList
end

function TaskDispatchAppointComp:OnOpen()
  if self._taskTableView then
    self.view:PlayTableViewFadeInAnim(self.ui.ScrollView_Task)
  end
end

function TaskDispatchAppointComp:OnExitComponent()
  if self._getTimer then
    self.view:StopTimer(self._getTimer)
    self._getTimer = nil
  end
  Super.OnExitComponent(self)
end

return TaskDispatchAppointComp
