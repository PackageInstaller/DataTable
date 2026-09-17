local this = class("moduleActivityCommit", G_UIModuleBase)
local attendanceTpl = L_GameTpl:getDailyAttendanceTpl()
local attendanceTeamTpl = L_GameTpl:getDailyAttendanceTeamTpl()
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local _gameeventssubitemTpl = L_GameTpl:getGameeventssubitemTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this.bind()
  return {
    moduleActivityBg = {
      moduleName = "pages/GameAct/moduleActivityBg"
    },
    textDate = "",
    textLeftTime = "",
    textTitle = "",
    textDesc = "",
    textProgress = "",
    textMissionName = "",
    showCheck = true,
    showProgress = false,
    showProgressLock = false,
    showRedPoint = false,
    showComplete = false,
    lock = true,
    condition_list = {
      moduleName = "pages/gameAct/cellLockCondition"
    },
    listReward = {
      moduleName = "modulePages/cellIconBag"
    },
    active_Fx = false
  }
end

function this.methods()
  return {
    OnClick_Go = function(self)
      if not self.isUnlock or self.taskId == nil then
        return
      end
      L_UI:open("pageTask", {
        taskId = self.taskId
      })
    end,
    onClick_help = function(self)
      if math.isEmpty(self.helpGroupId) then
        return
      end
      L_UI:open("pageCommonIntroduction", {
        groupId = self.helpGroupId
      })
    end,
    OnClick_Progress = function(self)
      L_UI:open("pageActivitySubmitItem", {
        ActId = self.actId
      })
    end,
    onClick_Finish = function(self)
      L_UI:open("pageActivitySubmitItem", {
        ActId = self.actId
      })
    end
  }
end

function this:setActId(id)
  self.actId = id
  self:init()
end

function this:closeFx()
  self.bind.active_Fx = false
end

function this:init()
  self.tpl = _GameEventTpl:getTplById(self.actId)
  self:initBg()
  self._data = L_GameEventStore:getGameEventData(self.actId)
  self.bind.textDesc = L_Lang:get(_GameEventTpl:getDesc(self.tpl))
  self:initTskList()
  self:setProgress()
  self.bind.textTitle = L_Lang:get(_GameEventTpl:getName(self.tpl))
  local rewards = _GameEventTpl:getRewardShow(self.tpl)
  self.helpGroupId = _GameEventTpl:getHelp(self.tpl)
  local rewards = _GameEventTpl:getRewardShow(self.tpl)
  local rewardsData = L_DataUtil.parseRewardConfig(rewards)
  self.bind.listReward:clear()
  self.bind.listReward:insert_array(rewardsData)
  local conditions = _GameEventTpl:getCondition(self.tpl)
  self.isUnlock = true
  self.bind.showCheck = false
  self.bind.showProgress = false
  self.bind.active_Fx = true
  self.bind.condition_list:clear()
  for i, v in ipairs(conditions) do
    if not L_ConditionManager:singleIsComplete(v) then
      self.isUnlock = false
      local data = {}
      table.insert(data, {
        lockParam = {
          _GameEventTpl:getLockJump(self.tpl)[i]
        },
        txt_lockDesc = L_Lang:get(_GameEventTpl:getLockText(self.tpl)[i])
      })
      self.bind.condition_list:insert_array(data)
      self.bind.showProgress = false
    end
  end
  if self.isUnlock and self.bind.showComplete == false then
    if self:getPreMissionIsComplete() then
      self.bind.showProgress = true
    else
      self.bind.showCheck = true
    end
  end
  self:setMissionText()
  local startTime = L_TimeUtil.getDisplayTimeCustom(C_CommonTimerMgr.GetStartTime(_GameEventTpl:getTimeLimit(self.tpl)), "!%m.%d")
  local endTime = L_TimeUtil.getDisplayTimeCustom(C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(self.tpl)), "!%m.%d")
  local startMonth = startTime:sub(1, 2)
  local endMonth = endTime:sub(1, 2)
  local startDate = startTime:sub(4, 5)
  local endDate = endTime:sub(4, 5)
  local cleanStartMonth = startMonth:gsub("^0", "")
  local cleanEndMonth = endMonth:gsub("^0", "")
  self.endTime = C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(self.tpl))
  self.bind.textDate = L_TimeUtil.getLeftTimeFormatString(self.endTime)
  self.timer = L_GameTimer.repeated(1, self.repeatShowTime, self)
  local EndTime = self.endTime - L_TimeUtil.getServerTime()
  if EndTime <= 0 then
    self.bind.textLeftTime = L_WordsTpl:getValue("ui_game_events_day_attendance_end")
    self.bind.finish = true
    self.bind.lock = false
    self.bind.inProcess = false
    return
  else
    self:startDateTimer(self.endTime)
  end
end

function this:repeatShowTime()
  local isChange, str = L_TimeUtil.tryGetLeftTimeFormatString(self.endTime, 1)
  if isChange then
    self.bind.textDate = str
  end
end

function this:initBg()
  self.modules.moduleActivityBg:setPath(self.actId)
end

function this:initTskList()
  self.taskList = {}
  self.taskCount = 0
  local allData = _gameeventssubitemTpl:getAllData()
  for i, task in pairs(allData) do
    if task.groupId == self.actId then
      self.taskList[task.id] = {
        UnlockTime = math.max(task.unlockTime - 1, 0) * 86400,
        id = task.id
      }
      self.taskCount = self.taskCount + 1
    end
  end
end

function this:setMissionText()
  if not self.isUnlock then
    return
  end
  if self:getPreMissionIsComplete() then
    local task
    if self._data.finish or self._data.order <= self.taskCount then
    end
    local count = 0
    for k, taskData in pairs(self.taskList) do
      if not self._data._gameEvent:checkIsCompletById(taskData.id) then
        if not task then
          task = taskData
        elseif task.id > taskData.id then
          task = taskData
        end
        count = count + 1
      end
    end
    self.bind.showProgressLock = false
    if task == nil then
      self.bind.textMissionName = L_WordsTpl:getValue("ui_game_events_subitem_allfinish")
      self.bind.showComplete = true
      self.bind.showCheck = false
      self.bind.showProgress = false
      self.taskId = nil
    else
      self.isWaitingTask = false
      self.taskId = task.id
      self.bind.textMissionName = L_WordsTpl:getValue("ui_gameevents_gotosee")
    end
  else
    self.bind.textMissionName = L_WordsTpl:getValue("ui_gameevents_gotosee")
    self.taskId = _GameEventTpl:getGuideTaskId(self.tpl)
  end
  self:initRedPoint()
end

function this:initRedPoint()
  local go = L_ReddotManager:haveNew(L_ReddotManager.DotDef.GameAct_Events_Submit)
  self.bind.showRedPoint = go
  L_ReddotManager:registerReddot(self.bindComponents.reddotNormal, L_ReddotManager.DotDef.GameAct_Events_SubmitNew)
  L_ReddotManager:setDirty(L_ReddotManager.DotDef.GameAct_Events_SubmitNew, true)
end

function this:setProgress()
  local num1 = 0
  local num2 = 0
  local task = self.taskList[self._data.order]
  for k, task in pairs(self.taskList) do
    num2 = num2 + 1
    if self._data._gameEvent:checkIsCompletById(task.id) then
      num1 = num1 + 1
    end
  end
  self.bind.textProgress = L_Lang:get(L_WordsTpl:getValue("ui_game_events_subitem_progress"), {
    [1] = num1,
    [2] = num2
  })
end

function this:getPreMissionIsComplete()
  local taskId = _GameEventTpl:getGuideTaskId(self.tpl)
  if taskId == 0 then
    return true
  end
  return AzurWorld.TaskMgr:IsFinishTask(taskId)
end

function this:sortRewardList(rewardsData)
  local result = {}
  if 1 < #rewardsData then
    for i, v in pairs(rewardsData) do
      local item = L_ItemTplManager:getItemConfig(v.itemType, v.itemId)
      table.insert(result, {
        itemType = v.itemType,
        itemId = v.itemId,
        itemNumTxt = tostring(v.itemNum),
        quality = item.quality or 0
      })
    end
    table.sort(result, function(a, b)
      if a.quality == b.quality then
        if a.itemType == b.itemType then
          return a.itemId < b.itemId
        else
          return a.itemType < b.itemType
        end
      else
        return a.quality > b.quality
      end
    end)
    return result
  else
    return rewardsData
  end
end

function this:preOpen(options)
  self.taskList = {}
  self.taskCount = 0
  self.taskId = nil
  self.isWaitingTask = true
  self._data = {}
  self.timer = nil
  self.helpGroupId = 1
  self.isUnlock = false
end

function this:open()
end

function this:show()
  if self.actId ~= nil then
    self.bindComponents.rewardList.horizontalNormalizedPosition = 0
  end
end

function this:close()
  self:disposeTimer()
end

function this:startDateTimer(endTime)
  self:disposeTimer()
  local nowTime = L_TimeUtil:getServerTime()
  local gapTime = endTime - nowTime
end

function this:disposeTimer()
  if self.timer ~= nil then
    self.timer:stop()
    Timer.remove(self.timer)
    self.timer = nil
  end
end

return this
