local RedType = RedTypeDefine.RedType
local TaskState = CommonDefine.TaskState
local BtnType = CommonDefine.BtnType
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
local TaskAppointPage, Super = System.NewClass("TaskAppointPage", TaskBasePage)

function TaskAppointPage:ctor(uiNode, serverIdx)
  Super.ctor(self, serverIdx)
  self.ui = UI_Research_Panel_Dispatch_ContentResource(uiNode)
  self.haveGet = false
  self.awakerList = Vue.ref({})
  self.monsterList = Vue.ref({})
  self.awardList = Vue.ref({})
  self.extraAwardList = Vue.ref({})
  self.vueTaskData = Vue.ref({})
  self.taskType = Vue.ref(CommonDefine.TaskType.TaskType_Appoint_Battle)
end

function TaskAppointPage:OnBind(binder)
  self.binder = binder
  binder:BindEvent(EventMgr.Instance.TaskViewUpdate, function(viewIndex)
    if viewIndex == CommonDefine.TaskServerIndex.Appoint then
      self:UpdatePageShow(viewIndex)
    end
  end)
  self:SetSubView(self.taskList.value[1])
  self:UpdatePageShow(CommonDefine.TaskServerIndex.Appoint)
  self:BindTaskDelegateItem(self.ui.ScrollView_Task, function()
    return self.taskList.value
  end)
  self:BindReceiveAllBtn()
  self.binder:BindToRaw(function(childBinder, nVal, oVal)
    if 0 == oVal and nVal > 0 then
      childBinder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_Task)
    end
  end, function()
    return #self.taskList.value
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Dispatch, System.fn(self, self.OnClickBtnDispatch), function()
    if not self.vueTaskData.value.state then
      return
    end
    return dispatchBtnStateMap[self.vueTaskData.value.state]
  end, nil, function()
    if not self.vueTaskData.value.state then
      return false
    end
    if self.vueTaskData.value.state == TaskState.Receive then
      return RedPointDataUtils.RedAttrType.Red
    end
    return false
  end)
  binder:BindToText(self.ui.Text_High, function()
    if not self.vueTaskData.value.state then
      return
    end
    return dispatchBtnTextMap[self.vueTaskData.value.state]
  end)
  binder:BindToVisible(self.ui.Group_Task, function()
    return #self.taskList.value > 0
  end)
  binder:BindToVisible(self.ui.Group_Empty, function()
    return 0 == #self.taskList.value
  end)
  binder:BindZ1Button(self.ui.Btn_Recall, System.fn(self, self.OnClickBtnRecall), function()
    return BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Task_Dispatch_Callback_Title"
  end)
  binder:BindToVisible(self.ui.Btn_Recall, function()
    if not self.vueTaskData.value.state then
      return false
    end
    return self.vueTaskData.value.state == TaskState.Doing
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Question, System.fn(self, self.OnClickRole))
  binder:BindToCircularListView(self.ui.ScrollView_Award, function()
    return self.awardList.value
  end, function(itemBinder, item, index)
    local data = self.awardList.value[index]
    local itemCount
    local itemCfg = DT.Item[data.itemTid]
    if itemCfg.Type == "DropItem" then
      itemCount = ""
    else
      itemCount = data.count
    end
    local _darkShowFunc = System.fn(self, self._NormalAwardDarkShow)
    if data.isExtra then
      _darkShowFunc = System.fn(self, self._ExtraAwardDarkShow)
    end
    local _extraDescFunc
    if data.isExtra then
      _extraDescFunc = TaskDataUtils.GetExtraAwardTagText
    end
    local itemData = {
      itemTid = data.itemTid,
      itemCount = itemCount,
      isGot = false,
      extraDescBgType = CommonDefine.CommonIconExtraDescBgType.Blue,
      darkShowFunc = _darkShowFunc,
      extraDescFunc = _extraDescFunc
    }
    itemBinder:BindComponent(CommonIconItemType2(item, itemData))
  end)
  binder:BindToText(self.ui.Text_Refresh, function()
    if self:CheckIsSpecialAppoint() then
      do return LT.Text end
      return LT.Text, "Task_Appoint_Newer_Tips", nil, nil, nil, nil
    end
    local curNum = TaskDataUtils.GetCurDispatchNum()
    local maxNum = TaskDataUtils.GetMaxDispatchNum()
    do return LT.Textf, "Task_Appoint_TimesLeft", curNum end
    return LT.Textf, "Task_Appoint_TimesLeft", curNum, maxNum
  end)
  binder:BindToVisible(self.ui.Image_Icon_Time, function()
    do return self.CheckIsSpecialAppoint end
    return self.CheckIsSpecialAppoint, self
  end)
  binder:BindComponent(AwakerSpecialSkillAdditionItem(self.ui.UI_Awaker_Button_Addition, CommonDefine.AwakerSpecialSkillType.AppointTaskRewardAdd))
  binder:BindToVisible(self.ui.Image_Extra, System.fn(self, self._IsShowExtraAwardTips))
  binder:BindToText(self.ui.Text_Take, System.fn(self, self._GetTimeTakeText))
  self:_BindConditionChanged(binder)
end

function TaskAppointPage:_NormalAwardDarkShow()
  if not self.vueTaskData.value.tid then
    return
  end
  local tid = self.vueTaskData.value.tid
  local taskCfg = TaskDataUtils.GetConfig(tid)
  local condInfo = TaskDataUtils.GetConditionInfo(taskCfg.CompleteCond, taskCfg.CompleteCondPara, self.vueTaskData.value.awakerList)
  return not condInfo.isOk
end

function TaskAppointPage:_ExtraAwardDarkShow()
  if not self.vueTaskData.value.tid then
    return
  end
  local tid = self.vueTaskData.value.tid
  local awakerList = self.vueTaskData.value.awakerList
  local _extraAwardInfo = TaskDataUtils.GetDispatchExtraAward(tid, awakerList)
  return not _extraAwardInfo or not _extraAwardInfo.reach
end

function TaskAppointPage:OnSelectItem(taskData, index, delegateItem)
  Super.OnSelectItem(self, taskData, index, delegateItem)
  if taskData and taskData.lock then
    return
  end
  if RedPointDataUtils.GetRedPointState(RedType.AppointTaskNew, {
    taskData.uid
  }) == RedPointDataUtils.RedAttrType.IsNew then
    RedPointDataUtils.ReqRemoveData(RedType.AppointTaskNew, RedPointDataUtils.RedAttrType.IsNew, taskData.uid)
  end
  self:SetSubView(taskData)
end

function TaskAppointPage:UpdatePageShow(serverIdx)
  if not self.vueTaskData.value.uid then
    return
  end
  local curUid = self.vueTaskData.value.uid
  if curUid then
    local tmpData = TaskDataUtils.GetTaskData(curUid)
    if not tmpData or tmpData.state == CommonDefine.TaskState.Done then
      self.selectedUid = nil
    end
  end
  local tempList = self:SortAppointTaskList(table.clone(TaskDataUtils.GetTaskDataListBySvrIdx(serverIdx) or {}))
  local receiveNum = 0
  if tempList then
    for _, taskData in pairs(tempList) do
      if taskData.state == TaskState.Receive or taskData.state == TaskState.Doing then
        receiveNum = receiveNum + 1
      end
    end
  end
  EventMgr.Instance.TaskPageEmptyShow:Dispatch(0 == #tempList)
  self.taskList.value = tempList
  self:SetSubView(TaskDataUtils.GetTaskData(self.selectedUid))
end

function TaskAppointPage:SetTaskTextInfo(taskTid)
  if not taskTid then
    return
  end
  local taskCfg = DT.Task[taskTid]
  self.binder:SetText(self.ui.Text_Task_Name, taskCfg.Name)
  self.binder:SetText(self.ui.Text_Task_Desc, taskCfg.Desc)
end

function TaskAppointPage:SetCondition(taskTid)
  if not taskTid then
    return
  end
  local taskCfg = DT.Task[taskTid]
  local conditionDesc = LT.Textf(taskCfg.CompleteCondDesc, table.unpack(taskCfg.CompleteCondPara))
  self.binder:SetText(self.ui.Text_Special1, conditionDesc)
  local condInfo = TaskDataUtils.GetConditionInfo(taskCfg.CompleteCond, taskCfg.CompleteCondPara, self.vueTaskData.value.awakerList)
  self.binder:SetTextColorByHtml(self.ui.Text_Special1, condInfo.isOk and isOkTxtColor or notOkTxtColor)
  self.binder:SetActive(self.ui.Text_Special2, false)
end

function TaskAppointPage:_BindConditionChanged(binder)
  binder:BindToText(self.ui.Text_Special1, function()
    if not self.vueTaskData.value.tid then
      return
    end
    local taskCfg = DT.Task[self.vueTaskData.value.tid]
    local conditionDesc = LT.Textf(taskCfg.CompleteCondDesc, table.unpack(taskCfg.CompleteCondPara))
    return conditionDesc
  end)
  binder:BindToTextColor(self.ui.Text_C_Special2, function()
    local reach = self:_IsReachExtraAwardCond()
    if reach then
      return CommonDefine.ColorType.Light
    end
    return CommonDefine.ColorType.Normal
  end)
  binder:BindToTextColor(self.ui.Text_Special1, function()
    if not self.vueTaskData.value.tid then
      return
    end
    local taskCfg = DT.Task[self.vueTaskData.value.tid]
    local condInfo = TaskDataUtils.GetConditionInfo(taskCfg.CompleteCond, taskCfg.CompleteCondPara, self.vueTaskData.value.awakerList)
    if condInfo.isOk then
      return CommonDefine.ColorType.Light
    end
    return CommonDefine.ColorType.Normal
  end)
  binder:BindToVisible(self.ui.Image_Icon_Cond_1, function()
    if not self.vueTaskData.value.tid then
      return false
    end
    local taskCfg = DT.Task[self.vueTaskData.value.tid]
    local condInfo = TaskDataUtils.GetConditionInfo(taskCfg.CompleteCond, taskCfg.CompleteCondPara, self.vueTaskData.value.awakerList)
    return not condInfo.isOk
  end)
  binder:BindToVisible(self.ui.Image_Icon_Hook_1, function()
    local tid = self.vueTaskData.value.tid
    local taskCfg = TaskDataUtils.GetConfig(tid)
    local condInfo = TaskDataUtils.GetConditionInfo(taskCfg.CompleteCond, taskCfg.CompleteCondPara, self.vueTaskData.value.awakerList)
    return condInfo and condInfo.isOk
  end)
  binder:BindToVisible(self.ui.Image_Icon_Cond_2, function()
    local tid = self.vueTaskData.value.tid
    if not tid then
      return
    end
    local hasExtraAward = TaskDataUtils.HasExtraAward(tid)
    return hasExtraAward and self:_ExtraAwardDarkShow()
  end)
  binder:BindToVisible(self.ui.Image_Icon_Hook_2, function()
    local reach = self:_IsReachExtraAwardCond()
    return reach
  end)
end

function TaskAppointPage:SetSubView(taskData)
  if not taskData or not taskData.tid then
    return
  end
  self.vueTaskData.value = taskData
  local taskCfg = DT.Task[taskData.tid]
  self.taskType.value = taskCfg.TaskType
  self:SetTaskTextInfo(taskData.tid)
  local sendAwakerList = table.clone(self.vueTaskData.value.awakerList)
  local awardList = self:GetAwardList(taskCfg, sendAwakerList)
  self.awardList.value = awardList
  local extraAwardList = {}
  for itemTid, count in pairs(taskCfg.ExtraAward or {}) do
    table.insert(extraAwardList, {itemTid = itemTid, count = count})
  end
  self.extraAwardList.value = extraAwardList
  if taskCfg.TaskType == CommonDefine.TaskType.TaskType_Appoint_Battle then
    self.awakerList.value = {}
  elseif taskData.awakerList then
    for _ = #taskData.awakerList + 1, taskCfg.MaxAwakerNum do
      table.insert(taskData.awakerList, 0)
    end
    self.awakerList.value = taskData.awakerList or {}
  end
end

function TaskAppointPage:GetAwardList(taskCfg, awakerList)
  do return TaskDataUtils.GetDispatchAwardList, taskCfg end
  return TaskDataUtils.GetDispatchAwardList, taskCfg, awakerList
end

function TaskAppointPage:_GetTimeTakeText()
  if not self.vueTaskData.value.tid then
    return
  end
  local tid = self.vueTaskData.value.tid
  local state = self.vueTaskData.value.state
  if state ~= TaskState.UnDone then
    return ""
  end
  local config = TaskDataUtils.GetConfig(tid)
  if not config or not config.NeedTime then
    return ""
  end
  local timeStr = self.ConvertNeedTimeShow(config.NeedTime * 60)
  return timeStr
end

function TaskAppointPage:_IsReachExtraAwardCond()
  if not self.vueTaskData.value.tid then
    return
  end
  local reach = TaskDataUtils.IsReachDispatchExtraAwardCond(self.vueTaskData.value.tid, self.vueTaskData.value.awakerList)
  return reach
end

function TaskAppointPage:_IsShowExtraAwardTips()
  if not self.vueTaskData.value.tid then
    return
  end
  do return TaskDataUtils.HasExtraAward end
  return TaskDataUtils.HasExtraAward, self.vueTaskData.value.tid
end

function TaskAppointPage:IsBattle()
  return self.taskType.value == CommonDefine.TaskType.TaskType_Appoint_Battle
end

function TaskAppointPage:IsDelegate()
  return self.taskType.value == CommonDefine.TaskType.TaskType_Appoint_Dispatch
end

function TaskAppointPage:OnBtnGet()
  if self.haveGet == false then
    self.haveGet = true
    Logger.Info("TaskAppointPage:OnBtnGet()")
    local sendAwakerList = table.clone(self.vueTaskData.value.awakerList)
    local taskTid = self.vueTaskData.value.tid
    local reDispatchData = {
      awakerList = sendAwakerList,
      awardList = self:_GetSendAwardList(taskTid, sendAwakerList),
      taskData = self.vueTaskData.value,
      taskTid = taskTid
    }
    local viewData = {
      [taskTid] = reDispatchData
    }
    TaskModel.Instance:SetPopTipRewards(viewData)
    TaskModel.Instance:SetNeedCalcReward(true)
    TaskDataUtils.TaskComplete(self.vueTaskData.value.uid, function(serverData)
      TaskModel.Instance:SetNeedCalcReward(false)
      self.timer = self.binder:BindTimer(RECEIVE_DELTA_TIME, 0, nil, function()
        self.haveGet = false
        EventMgr.Instance.TaskViewUpdate:Dispatch(CommonDefine.TaskServerIndex.Appoint)
      end)
    end, false)
  end
end

function TaskAppointPage:OnBtnGo()
  if not TaskDataUtils.EnableDispatch() then
    Alert.Show(10649)
    return
  end
  local list = {}
  local taskCfg = DT.Task[self.vueTaskData.value.tid]
  if taskCfg.MaxAwakerNum then
    for i = 1, taskCfg.MaxAwakerNum do
      list[i] = 0
    end
  end
  local panelData = {
    awakerDataMap = AwakerDataUtils.GetOwnedAwakerMap(),
    teamAwakerTids = list,
    recommandSchoolTids = {},
    challengeFunc = System.fn(self, self.OnBuildTeamBack),
    opponent = nil,
    taskData = table.deepclone(self.vueTaskData.value) or nil
  }
  TaskDataUtils.OpenAppointBuildTips(panelData)
end

function TaskAppointPage:OnBuildTeamBack(awakerList, taskData)
  if not taskData or not TaskDataUtils.GetTaskData(taskData.uid) then
    UIManager.Instance:CloseByUrl(Urls.TaskAppointBuildTips)
    Alert.ShowStr(LT.Text("Task_Appoint_NonExistent"))
    return
  end
  TaskController.Instance:ReqOnTaskAwakerDelegate(self.vueTaskData.value, self.vueTaskData.value.uid, awakerList)
end

function TaskAppointPage:OnRecall()
  TaskDataUtils.OpenRecallTips(function()
    if self.vueTaskData.value.state ~= TaskState.Receive then
      TaskController.Instance:ReqOnTaskRecallAwaker(self.vueTaskData.value, self.vueTaskData.value.uid)
    else
      Alert.ShowStr(LT.Text("Task_Dispatch_FinishedTips"))
    end
  end, self.vueTaskData.value.awakerList)
end

function TaskAppointPage:ReleaseBattle()
  if self.battleResult then
    BattleManager.Instance:ExitBattle()
    self.battleResult = nil
  end
end

function TaskAppointPage:OnClickBtnRecall()
  local taskData = self.vueTaskData.value
  if taskData.state == TaskState.Doing then
    self:OnRecall()
  end
end

function TaskAppointPage:OnClickBtnDispatch()
  local taskData = self.vueTaskData.value
  if taskData.state == TaskState.UnDone then
    self:OnBtnGo()
  elseif taskData.state == TaskState.Receive then
    self:OnBtnGet()
  end
end

function TaskAppointPage:OnUnbind()
  Super.OnUnbind(self)
  self:ReleaseBattle()
end

function TaskAppointPage:SortAppointTaskList(taskItemList)
  if not taskItemList or 0 == #taskItemList then
    return taskItemList
  end
  for i = #taskItemList, 1, -1 do
    if taskItemList[i].state == CommonDefine.TaskState.Done then
      table.remove(taskItemList, i)
    end
  end
  table.sort(taskItemList, function(a, b)
    if a.lock == b.lock then
      if a.state == b.state then
        local aSortVal = DT.Task[a.tid].BaseSortID
        local bSortVal = DT.Task[b.tid].BaseSortID
        local aSearchTime = (DT.Task[a.tid].NeedTime or 0) * 60
        local bSearchTime = (DT.Task[b.tid].NeedTime or 0) * 60
        local aNeedTime = a.state == TaskState.UnDone and aSearchTime or math.max(0, aSearchTime - (TimeUtils.GetServerTime() - (a.ts or TimeUtils.GetServerTime())))
        local bNeedTime = b.state == TaskState.UnDone and bSearchTime or math.max(0, bSearchTime - (TimeUtils.GetServerTime() - (b.ts or TimeUtils.GetServerTime())))
        if aNeedTime == bNeedTime then
          return aSortVal < bSortVal
        end
        return aNeedTime < bNeedTime
      end
      return sortWeight[a.state] < sortWeight[b.state]
    end
    local lockWeightA = a.lock and lockedWeight or unlockWeight
    local lockWeightB = b.lock and lockedWeight or unlockWeight
    return lockWeightA < lockWeightB
  end)
  if self.selectedUid == nil and self.tabItems then
    local firstTaskData = taskItemList[1]
    if not firstTaskData then
      return taskItemList
    end
    for key, tabItem in pairs(self.tabItems) do
      if key == firstTaskData.uid then
        self.selectedUid = firstTaskData.uid
        if tabItem and tabItem.SetIsSelected and tabItem.ui then
          tabItem:SetIsSelected(true)
        end
        break
      end
    end
  end
  return taskItemList
end

function TaskAppointPage:BindReceiveAllBtn()
  self.binder:BindToVisible(self.ui.Btn_1, function()
    return not self:CheckIsSpecialAppoint()
  end)
  self.binder:BindZ1Button(self.ui.Btn_1, function()
    if not self:CheckHaveCompleteTask() then
      Alert.ShowStr(LT.Text("DispatchNoReceiveTask"))
      return
    end
    local completeTaskTids = self:GetCompleteTaskTids()
    local completeTaskData = {}
    for _, taskTid in pairs(completeTaskTids) do
      completeTaskData[taskTid] = table.clone(TaskDataUtils.GetTaskData(taskTid))
    end
    local viewData = {}
    for _, tid in pairs(completeTaskTids) do
      local taskData = completeTaskData[tid]
      local sendAwakerList = taskData.awakerList
      local sendAwardList = self:_GetSendAwardList(tid, sendAwakerList)
      local rstData = {
        awakerList = sendAwakerList,
        awardList = sendAwardList,
        taskData = taskData,
        taskTid = tid
      }
      viewData[tid] = rstData
    end
    TaskModel.Instance:SetPopTipRewards(viewData)
    TaskModel.Instance:SetNeedCalcReward(true)
    TaskController.Instance:ReqOnTaskGainAllPrize(CommonDefine.TaskServerIndex.Appoint, function()
      TaskModel.Instance:SetNeedCalcReward(false)
    end)
  end, function()
    if not self:CheckHaveCompleteTask() then
      return BtnType.Unclickable
    end
    return BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "DispatchReceiveAll"
  end, function()
    return self:CheckHaveCompleteTask() and RedPointDataUtils.RedAttrType.Red or false
  end)
end

function TaskAppointPage:_GetSendAwardList(taskTid, sendAwakerList)
  local taskCfg = DT.Task[taskTid]
  local awardList = self:GetAwardList(taskCfg, sendAwakerList)
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

function TaskAppointPage:CheckHaveCompleteTask()
  do return table.next, self:GetCompleteTaskTids() end
  return table.next, self:GetCompleteTaskTids()
end

function TaskAppointPage:GetCompleteTaskTids()
  local rst = {}
  for _, taskData in pairs(self.taskList.value) do
    if taskData.state == TaskState.Receive then
      table.insert(rst, taskData.tid)
    end
  end
  return rst
end

function TaskAppointPage:CheckIsSpecialAppoint()
  return 0 ~= TaskDataUtils.GetIsSpecialAppoint()
end

function TaskAppointPage.ConvertNeedTimeShow(countDown)
  if not countDown or countDown <= 0 then
    return
  end
  local timeStr
  local h, m, _ = math.floor(countDown / 3600), math.floor(countDown % 3600 / 60), math.floor(countDown % 60)
  if countDown >= 3600 then
    timeStr = LT.Textf("Task_Dispatch_NeedTime", h)
  elseif countDown >= 60 then
    timeStr = LT.Textf("Task_Dispatch_NeedTime_Min", m)
  end
  return timeStr
end

function TaskAppointPage:OnOpen()
  self.binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_Task)
end

function TaskAppointPage:OnClickRole()
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("RuleTipsTitle"), LT.Text("Task_Appoint_Rules"))
end

return TaskAppointPage
