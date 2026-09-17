local this = class("gameEventData")
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local _shopGroupTpl = L_GameTpl:getShopGroupTpl()
local _shopTpl = L_GameTpl:getShopTpl()

function this:ctor(id)
  self.id = id
  self.start_time = 0
  self.end_time = 0
  self.ptShopId = 0
  self.ptCurrencyId = 0
  self.ptShopNoticeTime = 0
  self.hasEventData = false
  self.fakeTime = ""
  self.rewardStateList = {}
  self.isNewList = {}
  local tpl = _GameEventTpl:getTplById(id)
  local eType = tpl and _GameEventTpl:getType(tpl) or "nil"
  self.ptShopId = 0
  self.ptCurrencyId = 0
  if tpl then
    self.fakeTime = _GameEventTpl:getFakeTime(tpl)
    self.ptShopId = _GameEventTpl:getPtShopId(tpl)
    self.ptCurrencyId = _GameEventTpl:getPtCurrencyId(tpl)
  end
  self:initReward()
  local gameEventModelPath = L_GameEventStore.gameEventGEModels[eType]
  if gameEventModelPath then
    local cls = require(L_R.store .. "gameEvent.models." .. gameEventModelPath)
    self._gameEvent = cls.new(id, eType, self)
    self._gameEvent:initData()
    if 0 < self.ptShopId and 0 < self.ptCurrencyId then
      local curShopId = _shopGroupTpl:getShopList(_shopGroupTpl:getTplById(self.ptShopId))[1]
      local tpl = _shopTpl:getTplById(curShopId)
      local endDateTime = _shopTpl:getEndTime(tpl)
      if not string.isEmpty(endDateTime) then
        self.ptShopNoticeTime = L_TimeUtil.getDateTimeStamp(endDateTime)
      end
    end
    self._gameEvent:setPtShopNoticeTime(self.ptShopNoticeTime)
    self._type = eType
  else
    print("活动" .. id .. "类型" .. eType .. "不存在 找策划！")
  end
end

function this:populate(data)
  self.start_time = data.start_time
  self.end_time = data.end_time
end

function this:populateEventData(data)
  if self._gameEvent == nil then
    return
  end
  if table.isEmpty(data.data) then
    self:syncReward(data.rewards)
    return
  end
  self._gameEvent:populate(data.data)
  self.hasEventData = true
  self:syncReward(data.rewards)
end

function this:checkPtShopNoticeReddot()
  self:clearNoticeTimer()
  if self.ptShopId > 0 and 0 < self.ptCurrencyId then
    local curShopId = _shopGroupTpl:getShopList(_shopGroupTpl:getTplById(self.ptShopId))[1]
    local tpl = _shopTpl:getTplById(curShopId)
    local endDateTime = _shopTpl:getEndTime(tpl)
    if not string.isEmpty(endDateTime) then
      self.ptShopNoticeTime = L_TimeUtil.getDateTimeStamp(endDateTime)
      local serverTime = L_TimeUtil.getServerTime()
      if serverTime < self.ptShopNoticeTime then
        local delayTime = 0
        local noticeDay = L_GameTpl:getGameConstTpl():getData("ptshop_trade_notice", L_Const.GameTplType.int)
        local noticeTime = self.ptShopNoticeTime - noticeDay * 24 * 60 * 60
        if serverTime > noticeTime then
          delayTime = self.ptShopNoticeTime - serverTime
        else
          delayTime = noticeTime - serverTime
        end
        if 0 < delayTime then
          self.ptNoticeTimer = Timer.once(delayTime, function()
            L_GameEventStore:call(this.event.gameEventRedDot)
            self:checkPtShopNoticeReddot()
          end, self)
        end
      end
    end
  end
end

function this:clearNoticeTimer()
  if self.ptNoticeTimer then
    self.ptNoticeTimer:destroy()
    Timer.remove(self.ptNoticeTimer)
    self.ptNoticeTimer = nil
  end
end

function this:dispose()
  self:clearNoticeTimer()
  if self._gameEvent and self._gameEvent.dispose then
    self._gameEvent:dispose()
  end
  self.rewardStateList = {}
  self.redPointData = {}
  self.isNewList = {}
end

function this:getGameEvent()
  return self._gameEvent
end

function this:getRedPointData()
  return self.isNewList
end

function this:getRewardStateList()
  return self.rewardStateList
end

function this:getType()
  return self._type
end

function this:getActivityId()
  return self.id
end

function this:getStartTime()
  return self.start_time
end

function this:getEndTime()
  return self.end_time
end

function this:checkIfHasEventData()
  return self.hasEventData == true
end

function this:getFakeTime()
  return self.fakeTime
end

function this:isUnlock()
  local result = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.gameAct)
  local tpl = _GameEventTpl:getTplById(self.id)
  if tpl == nil then
    return false
  end
  local conditions = _GameEventTpl:getCondition(tpl)
  local canShow = true
  local complete = true
  for i, v in ipairs(conditions) do
    if not L_ConditionManager:singleIsComplete(v) then
      complete = false
      break
    end
  end
  if not complete then
    canShow = _GameEventTpl:getUnlockShow(tpl) == 1 and true or false
  end
  return result and canShow
end

function this:isFinishGuideTask()
  local tpl = _GameEventTpl:getTplById(self.id)
  if tpl == nil then
    return true
  end
  local guideId = _GameEventTpl:getGuideTaskId(tpl)
  if guideId == nil or guideId == 0 then
    return true
  end
  return AzurWorld.TaskMgr:IsFinishTask(guideId)
end

function this:isShow()
  local tpl = _GameEventTpl:getTplById(self.id)
  if tpl == nil then
    return false
  end
  local showBegin, showEnd = C_CommonTimerMgr.GetStartTime(_GameEventTpl:getTimeLimit(tpl)), C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(tpl))
  local currTime = L_TimeUtil.getServerTime()
  return showBegin <= currTime and showEnd >= currTime and self:isUnlock(tpl) and self:checkCanPreShow(tpl)
end

function this:checkCanPreShow(tpl)
  local preShowCondition = _GameEventTpl:getPreShowCondition(tpl)
  if preShowCondition then
    return L_ConditionManager:isComplete(preShowCondition)
  else
    return true
  end
end

function this:IsConditionComplete()
  local tpl = _GameEventTpl:getTplById(self.id)
  if tpl == nil then
    return false
  end
  local conditions = _GameEventTpl:getCondition(tpl)
  local complete = true
  for i, v in ipairs(conditions) do
    if not L_ConditionManager:singleIsComplete(v) then
      complete = false
      break
    end
  end
  return complete
end

function this:isValid()
  return self:isUnlock() and self.start_time <= L_TimeUtil.getServerTime() and self.end_time >= L_TimeUtil.getServerTime()
end

function this:canParticipateIn()
  return self:isValid() and self:checkIfHasEventData()
end

function this:initReward()
  local gameEventRewardTpl = L_GameTpl:getGameEventsRewardTpl()
  local allRewardData = gameEventRewardTpl:getData()
  for i, reward in pairs(allRewardData) do
    if reward.groupId == self.id then
      local rewardData = {
        reward_id = reward.id,
        reward_group_id = reward.groupId,
        reward_val = 0,
        reward_show_type = reward.showType,
        reward_state = L_Const.ActivityRewardState.ARS_NONE
      }
      table.insert(self.rewardStateList, rewardData)
    end
  end
  self:initRedPointData()
end

function this:syncReward(rewardsData)
  if rewardsData == nil then
    return
  end
  for i, v in pairs(rewardsData) do
    for j, reward in pairs(self.rewardStateList) do
      if v.id == reward.reward_id then
        reward.reward_state = L_Const.ActivityRewardState[v.state]
        reward.reward_val = v.val
        break
      end
    end
  end
  self:initRedPointData()
end

function this:initRedPointData()
  for i, v in pairs(self.rewardStateList) do
    self.isNewList[v.reward_show_type] = false
  end
  for i, v in pairs(self.rewardStateList) do
    if v.reward_state == L_Const.ActivityRewardState.ARS_FINISH then
      self.isNewList[v.reward_show_type] = true
    end
  end
end

return this
