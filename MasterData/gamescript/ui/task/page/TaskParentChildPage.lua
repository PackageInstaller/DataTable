local TaskServerIndex = CommonDefine.TaskServerIndex
local TaskType = CommonDefine.TaskType
local pairs = _ENV.pairs
local tInsert = table.insert
local fatherTaskTypeMap = {
  [TaskServerIndex.Career] = TaskType.TaskType_Career_Main,
  [TaskServerIndex.School] = TaskType.TaskType_School_Main
}
local childTaskTypeMap = {
  [TaskServerIndex.Career] = TaskType.TaskType_Career_Sub,
  [TaskServerIndex.School] = TaskType.TaskType_School_Sub
}
local TaskParentChildPage, Super = System.NewClass("TaskParentChildPage", TaskBasePage)

function TaskParentChildPage:ctor(uiNode, serverIdx)
  Super.ctor(self, serverIdx)
  self.ui = UI_Task_Popup_CareerResource(uiNode)
  self.taskCareerGroupData = {}
  self.curSelectChapter = Vue.ref(1)
  self.lastShowChapter = Vue.ref(1)
  self.chapterAwardList = Vue.ref({})
  self.childCareerTaskList = Vue.ref({})
  self.btnFatherTaskState = nil
  self.btnPreviousState = Vue.ref(nil)
  self.btnNextState = Vue.ref(nil)
end

function TaskParentChildPage:OnBind(binder)
  self.binder = binder
  self.taskTypeChildListMap = {
    [TaskServerIndex.Career] = self.ui.ScrollView_Career_List,
    [TaskServerIndex.School] = self.ui.ScrollView_School_List
  }
  self.childTaskBindFuncMap = {
    [TaskServerIndex.Career] = System.fn(self, self.BindCareerChildTaskItem),
    [TaskServerIndex.School] = System.fn(self, self.BindSchoolChildTaskItem)
  }
  self:InitAllBtnComp()
  self:BindCurrency()
  self:InitCareerGroupData()
  self:BindFatherTaskGroup()
  self:BindEvent()
  self:UpdatePageShow(self.serverIdx)
  self:InitDefaultJumpChapter()
  self:BindChildTaskGroup()
end

function TaskParentChildPage:InitCareerGroupData()
  self.taskCareerGroupData = {}
  for _, cfg in pairs(DT.Task) do
    if cfg.BelongTaskGroup and (cfg.TaskType == fatherTaskTypeMap[self.serverIdx] or cfg.TaskType == childTaskTypeMap[self.serverIdx]) then
      self:InitGroupDataByConfig(cfg)
    end
  end
end

function TaskParentChildPage:InitGroupDataByConfig(taskConfig)
  local belongTaskGroup = taskConfig.BelongTaskGroup
  if self.taskCareerGroupData[belongTaskGroup] == nil then
    self.taskCareerGroupData[belongTaskGroup] = {
      groupId = belongTaskGroup,
      fatherTask = nil,
      childsTasks = {}
    }
  end
  if taskConfig.TaskType == fatherTaskTypeMap[self.serverIdx] then
    self.taskCareerGroupData[belongTaskGroup].fatherTask = {
      tid = taskConfig.ID,
      state = CommonDefine.TaskState.Doing,
      uid = nil,
      count = 0
    }
  elseif taskConfig.TaskType == childTaskTypeMap[self.serverIdx] then
    tInsert(self.taskCareerGroupData[belongTaskGroup].childsTasks, {
      tid = taskConfig.ID,
      state = CommonDefine.TaskState.Doing,
      uid = nil,
      count = 0
    })
  end
end

function TaskParentChildPage:UpdatePageShow(serverIdx)
  self:LoadTaskGroupData(serverIdx)
  self:UpdateLastShowChapter()
  self:UpdateFatherShow()
  self:UpdateChildListShow()
end

function TaskBasePage:LoadTaskGroupData(serverIdx)
  self.taskList.value = TaskDataUtils.GetTaskDataListBySvrIdx(serverIdx) or {}
  for _, value in pairs(self.taskList.value) do
    local belongGroup = DT.Task[value.tid].BelongTaskGroup
    if self.taskCareerGroupData[belongGroup].fatherTask.tid == value.tid then
      self.taskCareerGroupData[belongGroup].fatherTask = value
    else
      for index, childTask in pairs(self.taskCareerGroupData[belongGroup].childsTasks) do
        if childTask.tid == value.tid then
          self.taskCareerGroupData[belongGroup].childsTasks[index] = value
        end
      end
    end
  end
end

function TaskParentChildPage:FatherTaskClickCb()
  if self.btnFatherTaskState == CommonDefine.BtnType.Unclickable then
    Alert.ShowStr(LT.Text("Task_Career_Parent_Pickup_Tips"))
  elseif self.btnFatherTaskState == CommonDefine.BtnType.Normal then
    local fatherTask = self.curCareerGroupData.fatherTask
    TaskDataUtils.TaskComplete(fatherTask.uid)
  end
end

function TaskParentChildPage:PreviousClickCb()
  if self.btnPreviousState.value == CommonDefine.BtnType.Unclickable then
    Alert.ShowStr(LT.Text("Task_Career_LastChapter_Tips"))
  else
    self.curSelectChapter.value = self.curSelectChapter.value - 1
  end
end

function TaskParentChildPage:NextClickCb()
  if self.btnNextState.value == CommonDefine.BtnType.Unclickable then
    Alert.ShowStr(LT.Text("Task_Career_NextChapter_Tips"))
  else
    self.curSelectChapter.value = self.curSelectChapter.value + 1
  end
end

function TaskParentChildPage:UpdateShowByCurSelectChapter(selectChapter)
  self:LoadTaskGroupData(self.serverIdx)
  self:UpdateLastShowChapter()
  local firstChapter = 1
  local lastChapter = self.lastShowChapter.value
  if selectChapter < firstChapter or selectChapter > lastChapter then
    return
  end
  self:EnablePreviousBtn(selectChapter > firstChapter)
  self:EnableNextBtn(selectChapter < lastChapter)
  self.curCareerGroupData = self.taskCareerGroupData[selectChapter]
  self:UpdateFatherShow()
  self:UpdateChildListShow()
end

function TaskParentChildPage:UpdateFatherShow()
  local fatherTask = self.curCareerGroupData.fatherTask
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
  self.chapterAwardList.value = tempAwardList
  self.binder:SetText(self.ui.Text_Chapter_Number, fatherTaskCfg.Name)
  self.binder:SetText(self.ui.Text_Chapter_Tips, fatherTaskCfg.Desc)
  self.binder:SetText(self.ui.Text_Total_Progress, LT.Textf("UniversalProgressDisplay", fatherTask.count, #self.curCareerGroupData.childsTasks))
  self.binder:SetImageFillAmount(self.ui.Image_Bar, fatherTask.count / #self.curCareerGroupData.childsTasks)
  local canReceiveFatherTask = fatherTask.state == CommonDefine.TaskState.Receive and fatherTask.count == #self.curCareerGroupData.childsTasks
  if fatherTask.state == CommonDefine.TaskState.Done then
    self:SetReceiveState(CommonDefine.BtnType.High)
  else
    self:EnableFatherTaskBtn(canReceiveFatherTask)
  end
end

function TaskParentChildPage:UpdateChildListShow()
  local tempChildList = Super.SortTaskList(self, self.curCareerGroupData.childsTasks)
  self.childCareerTaskList.value = tempChildList
end

function TaskParentChildPage:InitAllBtnComp()
  self.binder:BindButtonClick(self.ui.Btn_Get, System.fn(self, self.FatherTaskClickCb))
  self.binder:BindToText(self.ui.Text_Normal_Get, function()
    do return LT.Text end
    return LT.Text, "TaskAward_Btn_Completed"
  end)
  self.binder:BindToText(self.ui.Text_Disable_Get, function()
    do return LT.Text end
    return LT.Text, "TaskAward_Btn_Completed"
  end)
  self:SetReceiveState(CommonDefine.BtnType.Normal)
  self.binder:BindButtonClick(self.ui.Btn_Click_UP, System.fn(self, self.PreviousClickCb))
  self:SetPreviousBtnState(CommonDefine.BtnType.Normal)
  self.binder:BindButtonClick(self.ui.Btn_Click_Down, System.fn(self, self.NextClickCb))
  self:SetNextBtnState(CommonDefine.BtnType.Normal)
  self.binder:BindComponent(RedDotComponent(self.ui.Com_RedDotUP, CommonDefine.RedDotType.Dot, nil, System.fn(self, self.RedPointFuncPreviousBtn)))
  self.binder:BindComponent(RedDotComponent(self.ui.Com_RedDotDown, CommonDefine.RedDotType.Dot, nil, System.fn(self, self.RedPointFuncNextBtn)))
  self.binder:BindToVisible(self.ui.Group_UP, function()
    return 1 ~= self.curSelectChapter.value
  end)
  self.binder:BindToVisible(self.ui.Group_Down, function()
    return self.curSelectChapter.value ~= #self.taskCareerGroupData
  end)
end

function TaskParentChildPage:BindCurrency()
  local coinList = {}
  self.binder:BindComponent(CommonCurrencyGroupItem(self.ui.UI_Common_Item_Coin_Group, coinList))
end

function TaskParentChildPage:UpdateLastShowChapter()
  local curChapter = self:GetFirstUnCompleteFatherChapter()
  local chapterNum = #self.taskCareerGroupData
  if self.serverIdx == TaskServerIndex.Career then
    self.lastShowChapter.value = curChapter > chapterNum and chapterNum or curChapter
  else
    self.lastShowChapter.value = chapterNum
  end
end

function TaskParentChildPage:EnableFatherTaskBtn(enabled)
  if enabled then
    self:SetReceiveState(CommonDefine.BtnType.Normal)
  else
    self:SetReceiveState(CommonDefine.BtnType.Unclickable)
  end
end

function TaskParentChildPage:EnablePreviousBtn(enabled)
  if enabled then
    self:SetPreviousBtnState(CommonDefine.BtnType.Normal)
  else
    self:SetPreviousBtnState(CommonDefine.BtnType.Unclickable)
  end
end

function TaskParentChildPage:EnableNextBtn(enabled)
  if enabled then
    self:SetNextBtnState(CommonDefine.BtnType.Normal)
  else
    self:SetNextBtnState(CommonDefine.BtnType.Unclickable)
  end
end

function TaskParentChildPage:SetReceiveState(state)
  self.btnFatherTaskState = state
  self.ui.Text_C_Get:SetActive(state == CommonDefine.BtnType.High)
  self.ui.Image_Normal_Get:SetActive(state == CommonDefine.BtnType.Normal)
  self.ui.Image_Disable_Get:SetActive(state == CommonDefine.BtnType.Unclickable)
end

function TaskParentChildPage:SetPreviousBtnState(state)
  self.btnPreviousState.value = state
  self.ui.Icon_Normal_UP:SetActive(state == CommonDefine.BtnType.Normal)
  self.ui.Icon_Disable_UP:SetActive(state == CommonDefine.BtnType.Unclickable)
end

function TaskParentChildPage:SetNextBtnState(state)
  self.btnNextState.value = state
  self.ui.Icon_Normal_Down:SetActive(state == CommonDefine.BtnType.Normal)
  self.ui.Icon_Disable_Down:SetActive(state == CommonDefine.BtnType.Unclickable)
end

function TaskParentChildPage:CurFatherTaskCanRceive()
  return self.taskCareerGroupData[self.curSelectChapter.value].fatherTask.state == CommonDefine.TaskState.Done
end

function TaskParentChildPage:BindSchoolChildTaskItem(binder, item, taskData)
  local itemData = {
    taskTid = taskData.tid,
    taskUid = taskData.uid,
    taskState = taskData.state
  }
  binder:BindComponent(TaskSchoolItem(item, itemData))
end

function TaskParentChildPage:BindCareerChildTaskItem(binder, item, taskData)
  binder:BindComponent(TaskStateItem(item, taskData))
end

function TaskParentChildPage:BindFatherTaskGroup()
  self.binder:BindRawTable(function()
    return self.chapterAwardList.value
  end, function(valueBinder, _, _, _)
    if not valueBinder then
      return
    end
    self:BindFatherAwardGroup(valueBinder)
  end)
  self.binder:BindToRaw(function(_, new)
    self:UpdateShowByCurSelectChapter(new)
  end, function()
    return self.curSelectChapter.value
  end)
end

function TaskParentChildPage:BindEvent()
  self.binder:BindEvent(EventMgr.Instance.CommonRewardPanelClose, function()
    if self:CurFatherTaskCanRceive() and self.curSelectChapter.value < #self.taskCareerGroupData then
      EventMgr.Instance.TaskShowAnim:Dispatch("UI_Task_Popup_Career_New_Receive", function()
        self.curSelectChapter.value = self.curSelectChapter.value + 1
      end)
    end
  end)
  self.binder:BindEvent(EventMgr.Instance.TaskViewUpdate, function(serverIdx)
    if serverIdx == self.serverIdx then
      self:UpdatePageShow(self.serverIdx)
    end
  end)
end

function TaskParentChildPage:BindChildTaskGroup()
  self.binder:BindToCircularListView(self.taskTypeChildListMap[self.serverIdx], function()
    return self.childCareerTaskList.value
  end, function(itemBinder, item, index)
    local taskData = self.childCareerTaskList.value[index]
    self.childTaskBindFuncMap[self.serverIdx](itemBinder, item, taskData)
  end)
  self.binder:BindToRaw(function(childBinder, _, oVal)
    if oVal then
      childBinder:PlayCircularScrollViewFadeInAnim(self.taskTypeChildListMap[self.serverIdx])
    end
  end, function()
    return self.curSelectChapter.value
  end)
  for idx, circularList in pairs(self.taskTypeChildListMap) do
    self.binder:BindToVisible(circularList, function()
      return self.serverIdx == idx
    end)
  end
end

function TaskParentChildPage:BindFatherAwardGroup(binder)
  local awardNum = #self.chapterAwardList.value
  for i = 1, 4 do
    local item = self.ui["Awaed_" .. i]
    if i <= awardNum then
      binder:SetActive(item, true)
      local itemRes = UI_Common_Item_WuPin_Type1Resource(item)
      binder:CheckUpdatePanelResource(item, DataCenter.gameData.CurrTextLanguage)
      local data = self.chapterAwardList.value[i]
      binder:BindToText(itemRes.Text_Article_Number, function()
        local itemCfg = DT.Item[data.tid]
        if itemCfg.Type == "DropItem" then
          return ""
        end
        do return StrUtils.NumberConvert end
        return StrUtils.NumberConvert, data.num
      end)
      binder:BindToImage(itemRes.Icon_Article, function()
        do return ItemDataUtils.GetItemIcon end
        return ItemDataUtils.GetItemIcon, data.tid
      end)
      binder:BindToImage(itemRes.Image_Quality, function()
        local config = DT.Item[data.tid]
        do return ItemDataUtils.GetCommonItemBottomQualityFrame, config end
        return ItemDataUtils.GetCommonItemBottomQualityFrame, config, itemRes.Image_Bg_Black
      end)
      binder:BindLongPressButton(itemRes.Btn_Click, function()
      end, function()
        ItemDataUtils.ShowItemDetailTips(binder, item, nil, data.tid, true)
      end, tonumber(DT.GetConstant("Role_Press_Time")))
      binder:BindToVisible(itemRes.Image_Dis, function()
        return self.curCareerGroupData.fatherTask.state == CommonDefine.TaskState.Done
      end)
    else
      binder:SetActive(item, false)
    end
  end
end

function TaskParentChildPage:InitDefaultJumpChapter()
  self.curSelectChapter.value = self:GetFirstUnCompleteFatherChapter()
end

function TaskParentChildPage:GetFirstUnCompleteFatherChapter()
  local rst = 1
  for _, value in pairs(self.taskCareerGroupData) do
    if value.fatherTask.state ~= CommonDefine.TaskState.Done then
      break
    end
    rst = rst + 1
  end
  do return math.min, rst end
  return math.min, rst, #self.taskCareerGroupData, pairs(self.taskCareerGroupData)
end

function TaskParentChildPage:OnOpen()
  self.binder:PlayCircularScrollViewFadeInAnim(self.taskTypeChildListMap[self.serverIdx])
end

function TaskParentChildPage:RedPointFuncPreviousBtn()
  if self.btnPreviousState.value == CommonDefine.BtnType.Unclickable then
    return false
  end
  local firstChap = 1
  local finalChap = self.curSelectChapter.value - 1
  if firstChap > finalChap then
    return false
  end
  if self:CheckTaskGroupHaveComplete(firstChap, finalChap) then
    return RedPointDataUtils.RedAttrType.Red
  end
  return false
end

function TaskParentChildPage:RedPointFuncNextBtn()
  if self.btnNextState.value == CommonDefine.BtnType.Unclickable then
    return false
  end
  local firstChap = self.curSelectChapter.value + 1
  local finalChap = self.lastShowChapter.value
  if firstChap > finalChap then
    return false
  end
  if self:CheckTaskGroupHaveComplete(firstChap, finalChap) then
    return RedPointDataUtils.RedAttrType.Red
  end
  return false
end

function TaskParentChildPage:CheckTaskGroupHaveComplete(firstChap, finalChap)
  for i = firstChap, finalChap do
    local dataGroup = self.taskCareerGroupData[i]
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

return TaskParentChildPage
