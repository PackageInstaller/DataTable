local this = class("moduleGameActivityTask", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local _GameEventNoviceTpl = L_GameTpl:getGameEventsNoviceTpl()
local _WordsTpl = L_GameTpl:getWordsTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this.bind()
  return {
    condition_list = {
      moduleName = "pages/gameAct/cellLockCondition"
    },
    txt_openTime = "",
    txt_desc = "",
    finish = false,
    lock = false,
    inProcess = false,
    reward_list = {
      moduleName = "modulePages/cellIconCircle"
    },
    txt_tips = ""
  }
end

function this.methods()
  return {
    onClick_gotoTask = function(self)
      if math.isEmpty(self.taskId) then
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
    end
  }
end

function this:setActId(id)
  self.actId = id
  self:initPage()
end

function this:open()
  L_GameStore:listenCallFunc(L_GameStore.event.refreshDayChange, self.initPage, self)
end

function this:close()
  L_GameStore:unListenCallFunc(L_GameStore.event.refreshDayChange, self.initPage)
  self:disposeTimer()
end

function this:initPage()
  local gameEventData = L_GameEventStore:getGameEventData(self.actId)
  if not gameEventData then
    return
  end
  local gameEvent = gameEventData:getGameEvent()
  if not gameEvent then
    return
  end
  local tpl = _GameEventTpl:getTplById(self.actId)
  local rewards = _GameEventTpl:getRewardShow(tpl)
  local systemId = _GameEventTpl:getSystemId(tpl)
  self.helpGroupId = _GameEventTpl:getHelp(tpl)
  local taskGroupData = _GameEventNoviceTpl:getTplBySystemId(systemId)
  if 1 < #taskGroupData then
    table.sort(taskGroupData, function(a, b)
      return _GameEventNoviceTpl:getTaskOrder(a) < _GameEventNoviceTpl:getTaskOrder(b)
    end)
  end
  local curTaskTpl
  self.bind.txt_desc = _GameEventTpl:getDesc(tpl)
  local task_order = gameEvent:getData().cur_order
  local endTimeType = _GameEventTpl:getEndShowType(tpl)
  if endTimeType == L_Const.gameActEndType.permanent then
    self:disposeTimer()
    self.bind.txt_openTime = L_WordsTpl:getValue("ui_game_events_end_time")
  elseif endTimeType == L_Const.gameActEndType.specifyTime then
    local showBegin, showEnd = C_CommonTimerMgr.GetStartTime(_GameEventTpl:getTimeLimit(tpl)), C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(tpl))
    local tempEndTime = showEnd - L_TimeUtil.getServerTime()
    if tempEndTime <= 0 then
      self.bind.txt_openTime = L_WordsTpl:getValue("notice_finished")
      self.bind.finish = true
      self.bind.lock = false
      self.bind.inProcess = false
      return
    end
    self.bind.txt_openTime = L_TimeUtil.getLeftTimeString(tempEndTime)
    self:startDateTimer(showEnd)
  end
  self.bind.condition_list:clear()
  if math.isEmpty(task_order) then
    if not gameEvent:isAllTaskFinish(systemId) then
      self.bind.lock = true
      local data = {}
      table.insert(data, {
        txt_lockDesc = _GameEventNoviceTpl:getLockDesc(taskGroupData[1], 1),
        lockParam = _GameEventNoviceTpl:getLockParam(taskGroupData[1])
      })
      self.bind.condition_list:insert_array(data)
    end
  else
    curTaskTpl = taskGroupData[task_order]
    local taskId = _GameEventNoviceTpl:getTaskId(curTaskTpl)
    self.taskId = taskId
    local taskFinish = AzurWorld.TaskMgr:IsFinishTask(taskId)
    local conditions = _GameEventNoviceTpl:getUnlockCondition(curTaskTpl)
    local complete = true
    for i, v in ipairs(conditions) do
      if not L_ConditionManager:singleIsComplete(v) then
        complete = false
        break
      end
    end
    if taskFinish and not gameEvent:isAllTaskFinish(systemId) then
      local lenCondition = false
      if task_order + 1 > #taskGroupData then
        print("活动" .. "task_order + 1所用的索引超出范围")
      else
        lenCondition = true
      end
      local nextTaskTpl = taskGroupData[task_order + 1]
      local nilCondition = false
      if nextTaskTpl == nil then
        print("活动" .. "nextTaskTpl为空")
      else
        nilCondition = true
      end
      if lenCondition and nilCondition then
        local data = {}
        if not table.isEmpty(_GameEventNoviceTpl:getUnlockCondition(nextTaskTpl)) then
          local nextConditions = _GameEventNoviceTpl:getUnlockCondition(nextTaskTpl)
          local nextComplete = true
          for i, n in ipairs(nextConditions) do
            if not L_ConditionManager:singleIsComplete(n) then
              nextComplete = false
              break
            end
          end
          if not nextComplete then
            table.insert(data, {
              txt_lockDesc = _GameEventNoviceTpl:getLockDesc(nextTaskTpl, 1),
              lockParam = _GameEventNoviceTpl:getLockParam(nextTaskTpl)
            })
          end
        end
        local gapTime = _GameEventNoviceTpl:getUnlockTime(nextTaskTpl) - 1
        if 0 < gapTime then
          local showBegin = C_CommonTimerMgr:GetStartTime(_GameEventTpl:getTimeLimit(tpl))
          local canShowTime = showBegin + gapTime * 24 * 3600
          if canShowTime > L_TimeUtil.getServerTime() then
            table.insert(data, {})
          end
        end
        self.bind.condition_list:insert_array(data)
        self.bind.lock = not table.isEmpty(data)
      end
    elseif not taskFinish then
      if not complete then
        local data = {}
        table.insert(data, {
          txt_lockDesc = _GameEventNoviceTpl:getLockDesc(curTaskTpl, 1),
          lockParam = _GameEventNoviceTpl:getLockParam(curTaskTpl)
        })
        self.bind.condition_list:insert_array(data)
        self.bind.lock = true
      else
        self.bind.lock = false
      end
    else
      self.bind.lock = false
    end
  end
  self.bind.inProcess = not gameEvent:isAllTaskFinish(systemId) and not self.bind.lock
  self.bind.finish = gameEvent:isAllTaskFinish(systemId)
  self.bind.reward_list:clear()
  local rewardsData = L_DataUtil.parseRewardConfig(rewards)
  self.bind.reward_list:insert_array(rewardsData)
  self.bind.txt_tips = L_WordsTpl:getValue("ui_game_events_novice_reward_show")
end

function this:sortRewardList(rewardsData)
  local result = {}
  if 1 < #rewardsData then
    for i, v in pairs(rewardsData) do
      local item = L_ItemTplManager:getItemConfig(v.itemType, v.itemId)
      table.insert(result, {
        itemType = v.itemType,
        itemId = v.itemId,
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

function this:startDateTimer(endTime)
  self:disposeTimer()
  local nowTime = L_TimeUtil:getServerTime()
  local nextDayTime = endTime
  local gapTime = nextDayTime - nowTime
  self.bind.txt_openTime = L_WordsTpl:getValue("ui_systemMessage_19") .. L_TimeUtil.secondToLangString(gapTime)
  self.timer = Timer.repeated(1, function()
    if 0 < gapTime then
      gapTime = gapTime - 1
      self.bind.txt_openTime = L_WordsTpl:getValue("ui_systemMessage_19") .. L_TimeUtil.secondToLangString(gapTime)
    else
      self.bind.txt_openTime = ""
      self:disposeTimer()
    end
  end, self, self.gameObject)
end

function this:disposeTimer()
  if self.timer ~= nil then
    self.timer:stop()
    Timer.remove(self.timer)
    self.timer = nil
  end
end

return this
