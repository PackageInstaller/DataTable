local item = class("cellAvatarBattleTab", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local _GameActivityLevelGroupTpl = L_GameTpl:getGameActivityLevelGroupTpl()

function item:ctor(...)
  item.super.ctor(self, ...)
  self.data = {lock = false}
end

function item.bind()
  return {
    txt_activityName = "",
    tab_id = 0,
    go_lock = false,
    go_completeTag = false,
    go_select = false
  }
end

function item.methods()
  return {
    onClick_tab = function(self)
      if self.bind.action ~= nil then
        self.bind.action(self.bind.id)
      end
    end
  }
end

function item:open(...)
  if self.bind.tabGroup ~= nil then
    self.bindComponents.tabItem.Group = self.bind.tabGroup
  end
  self:refreshTitle(self.bind.txt_activityName)
  self:checkLock()
  self.bind.tab_id = self.bind.id
  self:refreshCompleteTag()
end

function item:checkLock()
  self.data.lock = false
  if self.bind.taskUnlock and #self.bind.taskUnlock > 0 then
    local isUnlock = L_ConditionManager:isComplete(self.bind.taskUnlock)
    if not isUnlock then
      self.data.lock = true
    end
  end
  if not self.data.lock and self.bind.startTimeNum and 0 < self.bind.startTimeNum then
    local currentDay = self:getPassDay()
    if currentDay < self.bind.startTimeNum then
      self.data.lock = true
    end
  end
  self.bind.go_lock = self.data.lock
end

function item:getPassDay()
  local activityId = self.bind.activityId
  if not activityId then
    return 1
  end
  local tpl = _GameEventTpl:getTplById(activityId)
  if not tpl then
    return 1
  end
  local beginTime = C_CommonTimerMgr.GetStartTime(_GameEventTpl:getTimeLimit(tpl))
  local firstRefreshDate = L_TimeUtil.getNextDayTime(tonumber(L_GameConstTpl:getData("DAILY_REFRESH_TIME", L_Const.GameTplType.int)), beginTime)
  local curDate = L_TimeUtil.getServerTime()
  if firstRefreshDate >= curDate then
    return 1
  else
    local deltaTime = curDate - beginTime
    local leftDay = deltaTime // L_TimeUtil.DAY_WHOLE
    return leftDay
  end
end

function item:refreshTitle(title)
  self.bind.txt_activityName = title
end

function item:hide()
end

function item:close()
end

function item:refreshCompleteTag()
  local completeNum = 0
  local groupTpl = _GameActivityLevelGroupTpl:getTplById(self.bind.id)
  local challengeRewardList = _GameActivityLevelGroupTpl:getRewardShow(groupTpl)
  local gameEventData = L_GameEventStore:getGameEventData(self.bind.activityId)
  if not gameEventData then
    return
  end
  local reward_state_list = gameEventData:getRewardStateList()
  self.data.simpleRewards = {}
  if reward_state_list then
    for _, reward in pairs(reward_state_list) do
      for _, challengeRewardId in ipairs(challengeRewardList) do
        if reward.reward_id == challengeRewardId then
          table.insert(self.data.simpleRewards, reward)
          break
        end
      end
    end
  end
  for _, reward in ipairs(self.data.simpleRewards) do
    if reward.reward_state ~= L_Const.ActivityRewardState.ARS_NONE then
      completeNum = completeNum + 1
    end
  end
end

return item
