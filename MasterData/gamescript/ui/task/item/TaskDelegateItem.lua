local RedType = RedTypeDefine.RedType
local TaskState = CommonDefine.TaskState
local TaskDelegateItem, Super = System.NewComponent("TaskDelegateItem")

function TaskDelegateItem:ctor(uiNode, data, clickCb)
  Super.ctor(self)
  self.ui = UI_Research_Panel_Dispatch_ItemResource(uiNode)
  data = data or {}
  self.taskData = Vue.reactive(data or {})
  self.taskCfg = DT.Task[data.tid] or {}
  self.taskType = self.taskCfg.TaskType
  self.clickCb = clickCb
end

function TaskDelegateItem:OnBind(binder)
  self.binder = binder
  self:BindDoingState(binder)
  self:BindUnDoneState(binder)
  self:BindReceiveState(binder)
  self:BindLockState(binder)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.BtnItemClick))
  binder:BindToText(self.ui.Text_Title, function()
    if not self.taskCfg.Name then
      Logger.Warn(string.format("任务id:%s 没有配置Name", self.taskData.tid))
    end
    do return LT.Text end
    return LT.Text, self.taskCfg.Name, string.format("任务id:%s 没有配置Name", self.taskData.tid)
  end)
  binder:BindToTextColor(self.ui.Text_Title, function()
    return self.taskData.lock and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    return self.taskData.lock and TaskDataUtils.GetDispatchTaskTypeGreyIcon(self.taskData.tid) or TaskDataUtils.GetDispatchTaskTypeNormalIcon(self.taskData.tid)
  end)
  binder:BindToRaw(function(childBinder, newState)
    self:UpdateShowByState(childBinder, newState)
  end, function()
    return self.taskData.state
  end)
end

function TaskDelegateItem:BindUnDoneState(binder)
end

function TaskDelegateItem:BindReceiveState(binder)
  binder:BindToVisible(self.ui.Image_Time_Bar_Bg_Over, function()
    return self.taskData.state == TaskState.Receive
  end)
end

function TaskDelegateItem:BindLockState(binder)
  binder:BindToVisible(self.ui.Image_Time_Bar_Bg_Unclickable, function()
    return self.taskData.lock
  end)
  binder:BindToVisible(self.ui.Image_Disable, function()
    return self.taskData.lock
  end)
  binder:BindToVisible(self.ui.Bg, function()
    return not self.taskData.lock
  end)
end

function TaskDelegateItem:BindDoingState(binder)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, nil, nil, function()
    local ret = RedPointDataUtils.GetRedPointState(RedType.AppointTaskNew, {
      self.taskData.uid
    })
    if ret then
      return ret
    end
    if self.taskData.lock then
      return false
    end
    if 0 ~= TaskDataUtils.GetIsSpecialAppoint() and self.taskData.state == TaskState.UnDone then
      if TaskDataUtils.HasCanDispatchTaskRed() then
        return RedPointDataUtils.RedAttrType.Red
      end
      return false
    end
    if self.taskData.state == TaskState.UnDone then
      if TaskDataUtils.GetCurDispatchNum() >= TaskDataUtils.GetMaxDispatchNum() then
        return false
      end
      local cfg = TaskDataUtils.GetConfig(self.taskData.tid)
      if cfg and cfg.CompleteCond == CommonDefine.TaskCond.AppointTotalLevel and cfg.CompleteCondPara and cfg.CompleteCondPara[1] then
        local needLevel = cfg.CompleteCondPara[1]
        local top6Sum = TaskDataUtils.GetTop4LevelSumOfUnDispatchedAwakers()
        if needLevel <= top6Sum then
          return RedPointDataUtils.RedAttrType.Red
        end
      end
    end
    if self.taskData.state == TaskState.Receive then
      return RedPointDataUtils.RedAttrType.Red
    end
    return false
  end))
  binder:BindToVisible(self.ui.Image_Time_Bar_Bg_Begin, function()
    return self.taskData.state == TaskState.Doing
  end)
end

function TaskDelegateItem:BtnItemClick()
  self:SetIsSelected(true)
  if self.clickCb then
    self.clickCb(self)
  end
end

function TaskDelegateItem:UpdateShowByState(binder, curState)
  self:ClearDoingTimer(binder)
  if curState == TaskState.Done then
    return
  elseif curState == TaskState.UnDone then
    return
  elseif curState == TaskState.Doing then
    self:SetDoingTimer(binder)
  end
end

function TaskDelegateItem:ClearDoingTimer(binder)
  if self.doingTimer then
    ;(binder or self.binder):StopTimer(self.doingTimer)
    self.doingTimer = nil
  end
end

function TaskDelegateItem:SetDoingTimer(binder)
  if self.doingTimer then
    return
  end
  self:UpdateDoingTime()
  self.doingTimer = (binder or self.binder):BindTimer(1, -1, System.fn(self, self.UpdateDoingTime))
end

function TaskDelegateItem:UpdateDoingTime()
  local needTime = (self.taskCfg.NeedTime or 0) * 60
  local curTime = TimeUtils.GetServerTime()
  local startTime = self.taskData.ts
  if 0 == needTime or not startTime then
    return
  end
  local passedTime = curTime - startTime
  local countDown = math.max(0, needTime - passedTime)
  if 0 == countDown then
    self:ClearDoingTimer()
  end
  local timeStr = self.ConvertCountDownShow(countDown)
  self.binder:SetText(self.ui.Text_Time_Begin, timeStr)
end

function TaskDelegateItem:SetIsSelected(isSelect)
  self.ui.Image_Select:SetActive(isSelect)
end

function TaskDelegateItem:GetCountDown()
  local needTime = (self.taskCfg.NeedTime or 0) * 60
  local curTime = TimeUtils.GetServerTime()
  local startTime = self.taskData.ts
  if 0 == needTime or not startTime then
    return
  end
  local passedTime = curTime - startTime
  local countDown = math.max(0, needTime - passedTime)
  return countDown
end

function TaskDelegateItem.ConvertCountDownShow(countDown)
  local timeStr
  local h, m, s = math.floor(countDown / 3600), math.floor(countDown % 3600 / 60), math.floor(countDown % 60)
  if countDown < 60 then
    timeStr = LT.Textf("Task_Dispatch_Second", s)
  elseif countDown >= 3600 then
    timeStr = LT.Textf("Task_Dispatch_Hour", h, m)
  else
    timeStr = LT.Textf("Task_Dispatch_Minute", m)
  end
  return timeStr
end

return TaskDelegateItem
