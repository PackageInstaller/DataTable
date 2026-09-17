local this = class("moduleActivityMainTaskReward", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local _WordsTpl = L_GameTpl:getWordsTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {hasInit = false}
end

function this.bind()
  return {
    condition_list = {
      moduleName = "pages/gameAct/cellLockCondition"
    },
    txt_openTime = "",
    txt_desc = "",
    reward_list = {
      moduleName = "pages/gameAct/mainTaskReward/cellActivityMainTaskReward"
    },
    go_unlock = false,
    go_isOn = false,
    go_isComplete = false,
    go_desc = false
  }
end

function this.methods()
  return {
    onClick_gotoTask = function(self)
      if self.commonJump == nil then
        return
      end
      L_JumpMgr:jumpTo(self.commonJump)
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

function this:initUIData()
  self.tab_list = {}
  self.tab_to_item_map = {}
  if self.reward_state_list ~= nil then
    for k, v in pairs(self.reward_state_list) do
      if not table.find(self.tab_list, function(m)
        return m == v.reward_show_type
      end) then
        table.insert(self.tab_list, v.reward_show_type)
      end
    end
    table.sort(self.tab_list, function(a, b)
      return a < b
    end)
    for k, v in pairs(self.reward_state_list) do
      if not self.tab_to_item_map[v.reward_show_type] then
        self.tab_to_item_map[v.reward_show_type] = {}
      end
      table.insert(self.tab_to_item_map[v.reward_show_type], v)
    end
  end
  self:setTaskId()
end

function this:refreshRewardItemList(reward_group_id)
  local item_tmp_list = self.tab_to_item_map[reward_group_id]
  if item_tmp_list ~= nil then
    local item_list = self:sortRewardItemList(item_tmp_list)
    self:refreshRewardItem(item_list)
  end
end

function this:refreshRewardItem(item_list)
  if item_list ~= nil then
    if self.data.hasInit then
      for i, v in ipairs(item_list) do
        self.bind.reward_list:change(i, v)
      end
    else
      self.bind.reward_list:clear()
      self.bind.reward_list:insert_array(item_list)
    end
  else
    errorf("活动奖励" .. "奖励列表数据为空", 2)
  end
end

function this:refreshByData()
  self.reward_state_list = L_GameEventStore:getGameEventData(self.actId):getRewardStateList()
  self:initUIData()
  self:refreshRewardItemList(self.selectId)
  self:refreshRedDot()
end

function this:sortRewardItemList(item_list)
  local priority = {
    [1] = 1,
    [0] = 2,
    [2] = 3
  }
  table.sort(item_list, function(a, b)
    return a.reward_id < b.reward_id
  end)
  return item_list
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
  self.reward_state_list = L_GameEventStore:getGameEventData(self.actId):getRewardStateList()
  self:initUIData()
  self:checkComplete()
  self:initView()
  if self.tab_list ~= nil and #self.tab_list > 0 then
    self:refreshRewardItemList(self.tab_list[1])
  end
  local tpl = _GameEventTpl:getTplById(self.actId)
  local rewards = _GameEventTpl:getRewardShow(tpl)
  local systemId = _GameEventTpl:getSystemId(tpl)
  self.helpGroupId = _GameEventTpl:getHelp(tpl)
  self.commonJump = _GameEventTpl:getCommonJump(tpl)
  self.bind.txt_desc = _GameEventTpl:getDesc(tpl)
  local task_order = gameEvent:getData().cur_order
  local endTimeType = _GameEventTpl:getEndShowType(tpl)
  if endTimeType == L_Const.gameActEndType.permanent then
    self:disposeTimer()
    self.bind.txt_openTime = L_WordsTpl:getValue("ui_game_events_end_time")
  elseif endTimeType == L_Const.gameActEndType.specifyTime then
    self.endTime = C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(tpl))
    self:refreshCountdown(L_TimeUtil.getLeftTimeFormatString(self.endTime))
    self.timer = L_GameTimer.repeated(1, self.repeatShowTime, self)
  end
  self.data.hasInit = true
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

function this:setTaskId()
  local validTasks = {}
  for k, v in pairs(self.reward_state_list) do
    if v.reward_id and v.reward_state ~= nil then
      table.insert(validTasks, v)
    end
  end
  table.sort(validTasks, function(a, b)
    return a.reward_id < b.reward_id
  end)
  local targetTaskId
  for _, task in ipairs(validTasks) do
    local isUnfinished = task.reward_state ~= L_Const.ActivityRewardState.ARS_REWARDED and task.reward_state ~= L_Const.ActivityRewardState.ARS_FINISH
    if isUnfinished then
      targetTaskId = task.reward_id
      break
    end
  end
  self.taskId = targetTaskId
end

function this:checkComplete()
  if not self.reward_state_list or #self.reward_state_list == 0 then
    self.isOn = true
    return
  end
  for k, v in pairs(self.reward_state_list) do
    if v.reward_state == L_Const.ActivityRewardState.ARS_FINISH or v.reward_state == L_Const.ActivityRewardState.ARS_NONE then
      self.isOn = true
      return
    end
  end
  self.isOn = false
end

function this:initView()
  local a = self.isOn and not self.isLock
  self.bind.go_isOn = self.isOn and not self.isLock
  self.bind.go_isComplete = not self.isOn and not self.isLock
  self.bind.go_unlock = not self.isLock
  self.bind.go_desc = self.isLock
end

function this:refreshLockCondition(id)
  local gameEventData = L_GameEventStore:getGameEventData(id)
  if gameEventData:IsConditionComplete() == false then
    local tpl = _GameEventTpl:getTplById(self.actId)
    local conditions = _GameEventTpl:getCondition(tpl)
    self.bind.condition_list:clear()
    for i, v in ipairs(conditions) do
      if not L_ConditionManager:singleIsComplete(v) then
        local data = {}
        table.insert(data, {
          lockParam = {
            _GameEventTpl:getLockJump(tpl)[i]
          },
          txt_lockDesc = L_Lang:get(_GameEventTpl:getLockText(tpl)[i])
        })
        self.bind.condition_list:insert_array(data)
        self.isLock = true
      end
    end
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

function this:repeatShowTime()
  local isChange, str = L_TimeUtil.tryGetLeftTimeFormatString(self.endTime, 1)
  if isChange then
    self:refreshCountdown(str)
  end
end

function this:refreshCountdown(content)
  self.bind.txt_openTime = content or ""
end

function this:disposeTimer()
  if self.timer ~= nil then
    self.timer:stop()
    Timer.remove(self.timer)
    self.timer = nil
  end
end

return this
