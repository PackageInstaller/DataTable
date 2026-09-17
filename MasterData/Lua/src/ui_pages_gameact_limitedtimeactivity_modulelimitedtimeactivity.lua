local this = class("moduleLimitedTimeActivity", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local _TaskTpl = L_GameTpl:getTaskTpl()
local ActivityState = {
  PreShow = 1,
  Unlocking = 2,
  Unlocked = 3
}

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    actId = 0,
    activityState = ActivityState.PreShow,
    gameEventData = nil,
    tpl = nil,
    unlockTaskId = nil
  }
end

function this.bind()
  return {
    txt_activityName = "",
    txt_remainTime = "",
    txt_activityDesc = "",
    reward_list = {
      moduleName = "modulePages/cellIconCircle"
    },
    condition_list = {
      moduleName = "pages/gameAct/cellLockCondition"
    },
    go_rewardList = false,
    go_statusRoot = false,
    go_acceptTaskBtn = false,
    go_gotoTaskBtn = false,
    go_conditionList = false,
    go_unlockedState = false,
    go_allRewardsGet = false
  }
end

function this.methods()
  return {
    onClick_help = function(self)
      if not math.isEmpty(self.helpGroupId) then
        L_UI:open("pageCommonIntroduction", {
          groupId = self.helpGroupId
        })
      end
    end,
    onClick_acceptTask = function(self)
      if self.data.unlockTaskId then
        L_UI:open("pageGetTask", {
          taskId = self.data.unlockTaskId
        })
      end
    end,
    onClick_gotoTask = function(self)
      if self.data.unlockTaskId then
        L_UI:open("pageTask", {
          taskId = self.data.unlockTaskId
        })
      end
    end,
    onClick_gotoGameplay = function(self)
      L_UI:open("pageLimitedTimePlayEntrance", {
        actId = self.data.actId
      })
    end,
    onClick_rewardPreview = function(self)
      L_UI:open("pageGamePlayActivityReward", {
        mainGameplayActivityId = self.data.actId
      })
    end,
    reward_list = {
      onClick = function(self, data)
        if data.itemType and data.itemId then
          L_ItemTplManager:showInfoTip(data.itemType, data.itemId)
        end
      end
    }
  }
end

function this:setActId(id)
  self.data.actId = id
  self:initPage()
end

function this:open()
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventSync, self.initPage, self)
end

function this:close()
  L_UI:close("pageGetTask")
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventSync, self.initPage)
end

function this:initPage()
  if not self.data.actId or self.data.actId == 0 then
    return
  end
  self.data.gameEventData = L_GameEventStore:getGameEventData(self.data.actId)
  if not self.data.gameEventData then
    return
  end
  self.data.tpl = _GameEventTpl:getTplById(self.data.actId)
  if not self.data.tpl then
    return
  end
  self.helpGroupId = _GameEventTpl:getHelp(self.data.tpl)
  self:checkActivityState()
  self:refreshCommonUI()
  self:refreshStateUI()
end

function this:checkActivityState()
  local preConditions = _GameEventTpl:getCondition(self.data.tpl)
  local allPreConditionsMet = true
  for i, condition in ipairs(preConditions or {}) do
    if not L_ConditionManager:singleIsComplete(condition) then
      allPreConditionsMet = false
      self.lockConditionIndex = i
      break
    end
  end
  if not allPreConditionsMet then
    self.data.activityState = ActivityState.PreShow
    return
  end
  self.data.unlockTaskId = _GameEventTpl:getGuideTaskId(self.data.tpl)
  if self.data.unlockTaskId and self.data.unlockTaskId ~= 0 then
    local taskFinished = AzurWorld.TaskMgr:IsFinishTask(self.data.unlockTaskId)
    if taskFinished then
      self.data.activityState = ActivityState.Unlocked
    else
      self.data.activityState = ActivityState.Unlocking
    end
  else
    self.data.activityState = ActivityState.Unlocked
  end
end

function this:refreshCommonUI()
  local tpl = self.data.tpl
  self.bind.txt_activityName = L_Lang:get(_GameEventTpl:getName(tpl))
  self.bind.txt_activityDesc = L_Lang:get(_GameEventTpl:getDesc(tpl))
  local showBegin, showEnd = C_CommonTimerMgr.GetStartTime(_GameEventTpl:getTimeLimit(tpl)), C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(tpl))
  local nowTime = L_TimeUtil.getServerTime()
  if showBegin < nowTime and showEnd > nowTime then
    self.bind.txt_remainTime = L_TimeUtil.secondToLangString(showEnd - nowTime)
  end
  self:refreshRewardList()
end

function this:refreshRewardList()
  local rewards = _GameEventTpl:getRewardShow(self.data.tpl)
  local rewardsData = L_DataUtil.parseRewardConfig(rewards)
  local rewardList = {}
  for i, reward in ipairs(rewardsData) do
    table.insert(rewardList, {
      itemType = reward.itemType,
      itemId = reward.itemId,
      showNum = false
    })
  end
  self.bind.reward_list:clear()
  self.bind.reward_list:insert_array(rewardList)
end

function this:refreshStateUI()
  if self.data.activityState == ActivityState.PreShow then
    self:refreshPreShowState()
  elseif self.data.activityState == ActivityState.Unlocking then
    self:refreshUnlockingState()
  elseif self.data.activityState == ActivityState.Unlocked then
    self:refreshUnlockedState()
  end
end

function this:refreshPreShowState()
  self.bind.go_rewardList = true
  self.bind.go_statusRoot = true
  self.bind.go_acceptTaskBtn = false
  self.bind.go_conditionList = true
  local conditions = _GameEventTpl:getCondition(self.data.tpl)
  local lockJumps = _GameEventTpl:getLockJump(self.data.tpl)
  self.bind.condition_list:clear()
  if self.lockConditionIndex and conditions[self.lockConditionIndex] then
    local condition = conditions[self.lockConditionIndex]
    local lockParam = {}
    local desc = L_ConditionManager:getSingleDesc(condition)
    lockParam = lockJumps[self.lockConditionIndex] and {
      lockJumps[self.lockConditionIndex]
    } or {}
    self.lockJumpLink = lockParam[1]
    self.bind.condition_list:insert({
      txt_lockDesc = desc,
      lockParam = lockParam,
      show_goto = 0 < #lockParam
    })
  end
end

function this:refreshUnlockingState()
  self.bind.go_rewardList = true
  self.bind.go_statusRoot = true
  self.bind.go_acceptTaskBtn = true
  self.bind.go_conditionList = false
  if self.data.unlockTaskId then
    local taskTpl = _TaskTpl:getTplById(self.data.unlockTaskId)
    if taskTpl then
      local inAccept = AzurWorld.TaskMgr:HasExecuteTaskById(self.data.unlockTaskId)
      self.bind.go_acceptTaskBtn = not inAccept
      self.bind.go_gotoTaskBtn = inAccept
    end
  end
end

function this:refreshUnlockedState()
  self.bind.go_rewardList = false
  self.bind.go_statusRoot = false
  self.bind.go_unlockedState = true
  self.bind.go_allRewardsGet = L_GameActivityManager:IsAllActivitiesRewardGet(self.data.actId)
end

return this
