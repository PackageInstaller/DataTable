local TaskBasePage, Super = System.NewComponent("TaskBasePage")

function TaskBasePage:ctor(serverIdx)
  Super.ctor(self)
  self.serverIdx = serverIdx
  self.taskList = Vue.ref(TaskDataUtils.GetTaskDataListBySvrIdx(serverIdx) or {})
  self.tabItems = {}
  self.selectedUid = nil
  self.doingTimerMap = {}
end

function TaskBasePage:UpdatePageShow(serverIdx)
  self.taskList.value = TaskDataUtils.GetTaskDataListBySvrIdx(serverIdx) or {}
end

function TaskBasePage:BindTaskDelegateItem(scrollView, dataListFunc)
  self.binder:BindToCircularListView(scrollView, dataListFunc, function(itemBinder, item, index)
    local data = self.taskList.value[index]
    local clickCb = System.bind(self.OnSelectItem, self, data, index)
    if data then
      item:SetActive(true)
      local tabItem = itemBinder:BindComponent(TaskDelegateItem(item, data, clickCb))
      self.tabItems[data.uid] = tabItem
      if self.selectedUid == nil then
        if 1 == index then
          self:OnSelectItem(data, index, tabItem)
        elseif tabItem and tabItem.SetIsSelected and tabItem.ui then
          tabItem:SetIsSelected(false)
        end
      elseif self.selectedUid == data.uid then
        self:OnSelectItem(data, index, tabItem)
      elseif tabItem and tabItem.SetIsSelected and tabItem.ui then
        tabItem:SetIsSelected(false)
      end
    else
      item:SetActive(false)
    end
  end)
end

function TaskBasePage:OnSelectItem(taskData, _, tabItem)
  if not taskData then
    return
  end
  if taskData.lock then
    if tabItem then
      tabItem:SetIsSelected(false)
    end
    local tips = TaskDataUtils.GetLockedTips(taskData.uid)
    if not tips then
      return
    end
    Alert.ShowStr(tips)
    return
  end
  if self.selectedUid then
    local lastItem = self.tabItems[self.selectedUid]
    if lastItem and lastItem.SetIsSelected and lastItem.ui then
      lastItem:SetIsSelected(false)
    end
  end
  self.selectedUid = taskData.uid
  if tabItem.SetIsSelected and tabItem.ui then
    tabItem:SetIsSelected(true)
  end
end

function TaskBasePage:OnClickReceive()
end

function TaskBasePage:SortTaskList(taskItemList)
  if not taskItemList or 0 == #taskItemList then
    return taskItemList
  end
  local tempChildList = taskItemList
  table.sort(tempChildList, function(a, b)
    local aCfg = DT.Task[a.tid]
    local bCfg = DT.Task[b.tid]
    local sortWeight = {
      [CommonDefine.TaskState.Receive] = 1,
      [CommonDefine.TaskState.Doing] = 2,
      [CommonDefine.TaskState.Done] = 3,
      [CommonDefine.TaskState.UnDone] = 4
    }
    if a.isHide then
      return false
    elseif b.isHide then
      return true
    end
    if a.state == b.state then
      return aCfg.BaseSortID < bCfg.BaseSortID
    else
      return sortWeight[a.state] < sortWeight[b.state]
    end
  end)
  if self.selectedUid == nil and self.tabItems then
    local firstTaskData = tempChildList[1]
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
  return tempChildList
end

function TaskBasePage:EnableRefreshCountdown(textComp, enable, countDownFunc, langKey)
  if nil == textComp then
    return
  end
  self.countDownMap = self.countDownMap or {}
  if false == enable then
    textComp:SetActive(false)
    self.countDownMap[textComp] = nil
  else
    textComp:SetActive(true)
    self.countDownMap[textComp] = {
      countDownFunc = countDownFunc,
      langKey = langKey,
      lastCountDown = nil
    }
  end
  if not self.countDownTimer then
    textComp:SetActive(enable)
    self:OnCountDown()
    self.countDownTime = self.binder:BindTimer(1, -1, System.fn(self, self.OnCountDown))
  end
end

function TaskBasePage:OnCountDown()
  for textComp, info in pairs(self.countDownMap or {}) do
    local countDown = info.countDownFunc()
    if info.lastCountDown ~= countDown then
      info.lastCountDown = countDown
      local timeStr = self:GetTimeStr(countDown)
      local langStr = info.langKey and LT.Textf(info.langKey, timeStr)
      self.binder:SetText(textComp, langStr or timeStr)
    end
  end
end

function TaskBasePage:GetTimeStr(countDown)
  local timeStr = ""
  if countDown and 0 ~= countDown then
    local h, m, s = math.floor(countDown / 3600), math.floor(countDown % 3600 / 60), math.floor(countDown % 60)
    timeStr = h > 0 and string.format("%02d:%02d:%02d", h, m, s) or string.format("%02d:%02d", m, s)
  end
  return timeStr
end

function TaskBasePage:GetDayRefreshCountDown()
  local refreshTime = TimeCfgUtils.Get_Future_DailyRefresh_TimeStamp()
  local curTime = TimeUtils.GetServerTime()
  local countDown = math.max(0, refreshTime - curTime)
  return countDown
end

function TaskBasePage:OnUnbind()
  self.tabItems = nil
end

return TaskBasePage
