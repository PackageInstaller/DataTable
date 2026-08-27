local UIActSum22Task = class("UIActSum22Task", UIBaseWindow)
local base = UIBaseWindow
local UINActSum22TaskItem = require("Game.ActivitySummer.Year22.Task.UINActSum22TaskItem")
local cs_MessageCommon = CS.MessageCommon

function UIActSum22Task:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickTaskClose)
  UIUtil.AddButtonListener(self.ui.btn_Tip, self, self.OnClickTip)
  self._taskPool = UIItemPool.New(UINActSum22TaskItem, self.ui.taskItem)
  self.ui.taskItem:SetActive(false)
  self.__SendCommitTaskCallback = BindCallback(self, self.__SendCommitTask)
  self.__SendRefreshTaskCallback = BindCallback(self, self.__SendRefreshTask)
  self.__RefreshTaskCallback = BindCallback(self, self.__RefreshTask)
  MsgCenter:AddListener(eMsgEventId.ActivitySectorIIIDayTimeout, self.__RefreshTaskCallback)
end

function UIActSum22Task:InitSum22Task(sum22Data, callback)
  self._sum22Data = sum22Data
  self._callback = callback
  local mainCfg = self._sum22Data:GetSectorIIIMainCfg()
  self._taskLimitCount = mainCfg.task_limit
  self._taskPool:HideAll()
  for i = 1, self._taskLimitCount do
    local item = self._taskPool:GetOne()
    item:InitSum22TaskItem(i, self._sum22Data, self.__SendCommitTaskCallback, self.__SendRefreshTaskCallback)
  end
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(ConfigData:GetTipContent(7127))
  if self._timerId == nil then
    self._timerId = TimerManager:StartTimer(1, self.__TimerCountdown, self)
    self:__TimerCountdown()
  end
  self:__RefreshTask()
end

function UIActSum22Task:__RefreshTask()
  local taskIdList = self._sum22Data:GetSectorIIITaskIds()
  for i, item in ipairs(self._taskPool.listItem) do
    local taskData
    if taskIdList[i] ~= nil then
      taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskIdList[i])
    end
    item:Refresh22TaskItem(taskData)
  end
  local taskCurCount = #taskIdList
  self.ui.tex_Number.text = tostring(taskCurCount) .. "/" .. tostring(self._taskLimitCount)
  local isFull = taskCurCount == self._taskLimitCount
  self.ui.time:SetActive(not isFull)
  self.ui.limit:SetActive(isFull)
  local times, maxTimes = self._sum22Data:GetSectorIIITaskRefTimes()
  self.ui.tex_RefreshTimes:SetIndex(0, tostring(maxTimes - times), tostring(maxTimes))
end

function UIActSum22Task:__SendCommitTask(taskData)
  if not taskData:CheckComplete() then
    return
  end
  self._sum22Data:ReqCommitSectorIIITask(taskData, function()
    if IsNull(self.transform) then
      return
    end
    self:__RefreshTask()
  end)
end

function UIActSum22Task:__SendRefreshTask(taskData)
  if taskData:CheckComplete() then
    return
  end
  local times, maxTimes = self._sum22Data:GetSectorIIITaskRefTimes()
  local tip = ConfigData:GetTipContent(7129)
  tip = string.format(tip, tostring(maxTimes - times), tostring(maxTimes))
  cs_MessageCommon.ShowMessageBox(tip, function()
    self._sum22Data:ReqChangeSectorIIITask(taskData.id, function()
      if IsNull(self.transform) then
        return
      end
      self:__RefreshTask()
    end)
  end, nil)
end

function UIActSum22Task:__TimerCountdown()
  local expireTime = self._sum22Data:GetActSectorIIIExpireTime()
  local diff = expireTime - PlayerDataCenter.timestamp
  diff = math.max(diff, 0)
  local d, h, m, s = TimeUtil:TimestampToTimeInter(math.floor(diff), false, true)
  self.ui.tex_Time.text = string.format("%02d:%02d:%02d", h, m, s)
end

function UIActSum22Task:OnClickTip()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(win)
    if win == nil then
      return
    end
    local mainCfg = self._sum22Data:GetSectorIIIMainCfg()
    win:InitCommonInfoByRule(mainCfg.task_rule_id, true)
  end)
end

function UIActSum22Task:OnClickTaskClose()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UIActSum22Task:OnDelete()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.ActivitySectorIIIDayTimeout, self.__RefreshTaskCallback)
  base.OnDelete(self)
end

return UIActSum22Task
