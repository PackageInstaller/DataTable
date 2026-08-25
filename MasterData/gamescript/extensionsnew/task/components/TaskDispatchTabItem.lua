local TaskState = CommonDefine.TaskState
local RedType = RedTypeDefine.RedType
local TaskDispatchTabItem, Super = NewViewComponent("TaskDispatchTabItem")

function TaskDispatchTabItem:ctor(uiNode, view)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Research_Panel_Dispatch_ItemResource(uiNode)
  self.taskData = {}
  self.taskCfg = {}
end

function TaskDispatchTabItem:OnEnterComponent()
  self.view:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClick))
  self:AddViewComponentOnce(self.ui.Com_RedDot, UICompRedDot, nil, nil, System.fn(self, self._RedPointFunc))
end

function TaskDispatchTabItem:Refresh(taskData, isSelected, clickCb)
  self.taskData = taskData or {}
  self.taskCfg = DT.Task[self.taskData.tid] or {}
  self._clickCb = clickCb
  self:_RefreshAll(isSelected)
end

function TaskDispatchTabItem:_RefreshAll(isSelected)
  local taskData = self.taskData
  local taskCfg = self.taskCfg
  if taskCfg.Name then
    self:SetText(self.ui.Text_Title, LT.Text(taskCfg.Name))
  else
    Logger.Warn(string.format("任务id:%s 没有配置Name", taskData.tid))
  end
  self:SetTextColorType(self.ui.Text_Title, taskData.lock and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light)
  self:SetImage(self.ui.Image_Icon, taskData.lock and TaskDataUtils.GetDispatchTaskTypeGreyIcon(taskData.tid) or TaskDataUtils.GetDispatchTaskTypeNormalIcon(taskData.tid))
  local state = taskData.state
  self:SetActive(self.ui.Image_Time_Bar_Bg_Over, state == TaskState.Receive)
  self:SetActive(self.ui.Image_Time_Bar_Bg_Begin, state == TaskState.Doing)
  self:SetActive(self.ui.Image_Time_Bar_Bg_Unclickable, taskData.lock)
  self:SetActive(self.ui.Image_Disable, taskData.lock)
  self:SetActive(self.ui.Bg, not taskData.lock)
  self:SetIsSelected(isSelected)
  self:_ClearDoingTimer()
  if state == TaskState.Doing then
    self:_StartDoingTimer()
  end
end

function TaskDispatchTabItem:SetIsSelected(isSelected)
  self:SetActive(self.ui.Image_Select, isSelected)
end

function TaskDispatchTabItem:_OnClick()
  self:SetIsSelected(true)
  if self._clickCb then
    self._clickCb(self.taskData, self)
  end
end

function TaskDispatchTabItem:_RedPointFunc()
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
end

function TaskDispatchTabItem:_StartDoingTimer()
  if self._doingTimer then
    return
  end
  self:_UpdateDoingTime()
  self._doingTimer = self:BindTimer(1, -1, System.fn(self, self._UpdateDoingTime))
end

function TaskDispatchTabItem:_ClearDoingTimer()
  if self._doingTimer then
    self:StopTimer(self._doingTimer)
    self._doingTimer = nil
  end
end

function TaskDispatchTabItem:_UpdateDoingTime()
  local taskCfg = self.taskCfg
  local taskData = self.taskData
  local needTime = (taskCfg.NeedTime or 0) * 60
  local curTime = TimeUtils.GetServerTime()
  local startTime = taskData.ts
  if 0 == needTime or not startTime then
    return
  end
  local passedTime = curTime - startTime
  local countDown = math.max(0, needTime - passedTime)
  if 0 == countDown then
    self:_ClearDoingTimer()
  end
  local timeStr = self._ConvertCountDownShow(countDown)
  self:SetText(self.ui.Text_Time_Begin, timeStr)
end

function TaskDispatchTabItem._ConvertCountDownShow(countDown)
  if not countDown or countDown <= 0 then
    return ""
  end
  local h = math.floor(countDown / 3600)
  local m = math.floor(countDown % 3600 / 60)
  local s = math.floor(countDown % 60)
  if countDown < 60 then
    do return LT.Textf, "Task_Dispatch_Second" end
    return LT.Textf, "Task_Dispatch_Second", s, nil
  elseif countDown >= 3600 then
    do return LT.Textf, "Task_Dispatch_Hour", h end
    return LT.Textf, "Task_Dispatch_Hour", h, m
  else
    do return LT.Textf, "Task_Dispatch_Minute" end
    return LT.Textf, "Task_Dispatch_Minute", m, m
  end
end

function TaskDispatchTabItem:OnExitComponent()
  self:_ClearDoingTimer()
  Super.OnExitComponent(self)
end

return TaskDispatchTabItem
