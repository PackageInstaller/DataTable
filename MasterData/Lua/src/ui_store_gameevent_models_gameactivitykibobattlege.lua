local this = class("gameActivityKiboBattleGE", L_GameEventStore.baseGameEventCls)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()

function this:ctor(eventId, type, data)
  this.super.ctor(self, eventId, type, data)
end

function this:initData()
  self.data = {
    state = L_Const.ActivityTaskState.KDT_NONE,
    level_pass = {}
  }
end

function this:getLevelPass(kiboDuelId)
  if self.data.level_pass[kiboDuelId] == nil or self.data.level_pass[kiboDuelId] == false then
    return false
  else
    return true
  end
end

function this:populate(protoData)
  if protoData.act_kibo_duel ~= nil then
    self.data.state = L_Const.ActivityTaskState[protoData.act_kibo_duel.task_state]
    if protoData.act_kibo_duel.duel_uids ~= nil then
      for i = 1, #protoData.act_kibo_duel.duel_uids do
        self.data.level_pass[protoData.act_kibo_duel.duel_uids[i]] = true
      end
    end
  end
end

function this:dispose()
end

function this:isActivityCompleted()
  local reward_state_list = L_GameEventStore:getGameEventData(self.id):getRewardStateList()
  local res = true
  if reward_state_list then
    for _, reward in pairs(reward_state_list) do
      if reward.reward_state ~= L_Const.ActivityRewardState.ARS_REWARDED then
        res = false
        break
      end
    end
  end
  local str = string.empty
  if res then
    str = "活动完成"
  else
    str = "活动未完成"
  end
  return res
end

function this:getRedState()
  local state_before = false
  local state_after = false
  local gameEventData = L_GameEventStore:getGameEventData(self.id)
  if #L_GameEventStore.kiboBattleRedConfig >= 1 then
    state_before = gameEventData:IsConditionComplete() and not L_ReddotManager:haveNew(L_ReddotManager.DotDef.GameAct_Events_Kibo_Battle, L_GameEventStore.kiboBattleRedConfig[1])
  end
  if #L_GameEventStore.kiboBattleRedConfig >= 2 then
    local tpl = _GameEventTpl:getTplById(self.id)
    local taskId = _GameEventTpl:getGuideTaskId(tpl)
    local taskFinish = false
    if taskId ~= nil and taskId ~= 0 then
      taskFinish = AzurWorld.TaskMgr:IsFinishTask(taskId)
    end
    state_after = taskFinish and not L_ReddotManager:haveNew(L_ReddotManager.DotDef.GameAct_Events_Kibo_Battle, L_GameEventStore.kiboBattleRedConfig[2])
  end
  return self:hasRewardNewData(self.id) or state_before or state_after
end

function this:isBattleUnlock(duelId)
  local gameEventKiboDuleTpl = L_GameTpl:getGameEventsKiboDuelTpl()
  local tpl = gameEventKiboDuleTpl:getTplById(duelId)
  local event_id = gameEventKiboDuleTpl:getGroupId(tpl)
  local ex_id = gameEventKiboDuleTpl:getExId(tpl)
  local ex_level_pass = false
  if ex_id == nil or ex_id == 0 then
    ex_level_pass = true
  else
    ex_level_pass = L_GameEventStore:getGameEventData(event_id):getGameEvent():getLevelPass(ex_id)
  end
  local event_tpl = _GameEventTpl:getTplById(event_id)
  local start_time = C_CommonTimerMgr.GetStartTime(_GameEventTpl:getTimeLimit(event_tpl))
  local end_time = C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(event_tpl))
  local unlock_day = gameEventKiboDuleTpl:getUnlockTime(tpl)
  local level_start_time = start_time
  if 0 <= unlock_day - 1 then
    level_start_time = start_time + (unlock_day - 1) * 86400
  end
  local isLock = level_start_time < L_TimeUtil:getServerTime() and end_time > L_TimeUtil:getServerTime()
  return not isLock or not ex_level_pass
end

function this:hasRewardNewData(id)
  local red_point = L_GameEventStore:getGameEventData(id):getRedPointData()
  local is_new = false
  for i, v in pairs(red_point) do
    if v == true then
      is_new = true
      break
    end
  end
  return is_new
end

return this
