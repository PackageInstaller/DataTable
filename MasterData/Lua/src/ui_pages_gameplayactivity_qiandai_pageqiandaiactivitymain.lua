local this = class("pageQiandaiActivityMain", G_UIPageBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local _GameEventRewardGroupTpl = L_GameTpl:getGameEventsRewardGroupTpl()
local _GameActivityIntegralTpl = L_GameTpl:getGameActivityIntegralTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.currencyId = 0
  self.data = {
    activityId = L_LimitedTimeActivityStore.LimitedActivityType.Qiandai,
    reward_state_map = {},
    hasShowType = false,
    showType_groups = {},
    simpleRewards = {},
    currentShowType = 0
  }
end

function this.bind()
  return {
    selectId = 0,
    go_tab = true,
    tab_list = {
      moduleName = "pages/gameplayActivity/cellGameplayActivityRewardTab"
    },
    reward_item_list = {
      moduleName = "pages/gameplayActivity/cellGameplayActivityRewardItem"
    },
    txt_curScore = "",
    txt_scoreLimitUnlock = "",
    go_scoreLimitUnlock = true
  }
end

function this.methods()
  return {
    onClickChallenge = function(self)
      L_UI:open("pageQiandaiLevelSelect")
    end,
    onClickTutorial = function(self)
      self:openActivityHelpPanel()
    end
  }
end

function this:close(options)
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventReward, self.refreshByData)
end

function this:open(options)
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventReward, self.refreshByData, self)
  local tpl = _GameEventTpl:getTplById(self.data.activityId)
  self.currencyId = _GameEventTpl:getCurrencyId(tpl)
end

function this:show()
  self:refreshByData()
end

function this:initRewardData()
  local gameEventData = L_GameEventStore:getGameEventData(self.data.activityId)
  if not gameEventData then
    return
  end
  local reward_state_list = gameEventData:getRewardStateList()
  local hasShowType = true
  if reward_state_list ~= nil then
    for _, v in pairs(reward_state_list) do
      if not v.reward_show_type or v.reward_show_type == 0 then
        hasShowType = false
        break
      end
    end
  end
  self.data.hasShowType = hasShowType
  self.data.showType_groups = {}
  self.data.simpleRewards = {}
  if reward_state_list ~= nil then
    if hasShowType then
      for k, v in pairs(reward_state_list) do
        local showType = v.reward_show_type or 0
        if not self.data.showType_groups[showType] then
          self.data.showType_groups[showType] = {
            showType = showType,
            rewards = {}
          }
        end
        local group = self.data.showType_groups[showType]
        table.insert(group.rewards, v)
      end
      for _, group in pairs(self.data.showType_groups) do
        self:sortRewardItemList(group.rewards)
      end
    else
      self.data.simpleRewards = reward_state_list
      self:sortRewardItemList(self.data.simpleRewards)
    end
  end
end

function this:refreshByData()
  self:initRewardData()
  if self.data.hasShowType then
    self.bind.go_tab = true
    self:refreshTabList()
    if self.data.currentShowType > 0 then
      self:selectShowType(self.data.currentShowType)
    else
      local firstShowType
      for showType, _ in pairs(self.data.showType_groups) do
        if firstShowType == nil or showType < firstShowType then
          firstShowType = showType
        end
      end
      if firstShowType then
        self:selectShowType(firstShowType)
      end
    end
  else
    self.bind.go_tab = false
    self:refreshAllRewards()
  end
  self:refreshScoreShow()
end

function this:refreshTabList()
  local tab_tmp_list = {}
  local groups = {}
  for _, group in pairs(self.data.showType_groups) do
    table.insert(groups, group)
  end
  table.sort(groups, function(a, b)
    return a.showType < b.showType
  end)
  for _, group in ipairs(groups) do
    local name = ""
    if group.showType > 0 then
      local groupTpl = _GameEventRewardGroupTpl:getTplById(group.showType)
      if groupTpl then
        name = L_Lang:get(_GameEventRewardGroupTpl:getName(groupTpl))
      end
    end
    local tab_item = {
      id = group.showType,
      activityId = self.data.activityId,
      txt_activityName = name,
      action = function(id)
        self:selectShowType(id)
      end
    }
    table.insert(tab_tmp_list, tab_item)
  end
  self.bind.tab_list:clear()
  self.bind.tab_list:insert_array(tab_tmp_list)
end

function this:selectShowType(showType)
  self.data.currentShowType = showType
  self.bind.selectId = showType
  local group = self.data.showType_groups[showType]
  if group then
    self:refreshRewardListByGroup(group)
  end
end

function this:refreshRewardListByGroup(group)
  local reward_items = {}
  for idx, reward in ipairs(group.rewards) do
    local item_data = {
      reward_id = reward.reward_id,
      reward_state = reward.reward_state,
      reward_show_type = reward.reward_show_type,
      reward_group_id = self.data.activityId,
      showLevelInfo = false
    }
    table.insert(reward_items, item_data)
  end
  self.bind.reward_item_list:clear()
  self.bind.reward_item_list:insert_array(reward_items)
end

function this:refreshAllRewards()
  local reward_items = {}
  for _, reward in ipairs(self.data.simpleRewards) do
    local item_data = {
      reward_id = reward.reward_id,
      reward_state = reward.reward_state,
      reward_show_type = reward.reward_show_type,
      reward_group_id = self.data.activityId,
      showLevelInfo = false
    }
    table.insert(reward_items, item_data)
  end
  self.bind.reward_item_list:clear()
  self.bind.reward_item_list:insert_array(reward_items)
end

function this:sortRewardItemList(item_list)
  local priority = {
    [1] = 1,
    [0] = 2,
    [2] = 3
  }
  table.sort(item_list, function(a, b)
    if priority[a.reward_state] ~= priority[b.reward_state] then
      return priority[a.reward_state] < priority[b.reward_state]
    end
    return a.reward_id < b.reward_id
  end)
  return item_list
end

function this:openActivityHelpPanel()
  L_GameActivityManager:OpenGameActivityHelpPage({
    self.data.activityId
  })
end

function this:refreshScoreShow()
  local curScore = self:getCurScore()
  local curPassDay = self:getPassDay()
  local maxDayNum = _GameActivityIntegralTpl:getMaxDayNum(self.currencyId)
  if curPassDay > maxDayNum then
    curPassDay = maxDayNum
  end
  local curMaxScore = _GameActivityIntegralTpl:getMaxByCurrencyIdAndDay(self.currencyId, curPassDay)
  local nextMaxScore = _GameActivityIntegralTpl:getMaxByCurrencyIdAndDay(self.currencyId, curPassDay + 1)
  local haveNextDay = nextMaxScore ~= nil
  self.bind.txt_curScore = string.format("%d/%d", curScore, curMaxScore)
  self.bind.go_scoreLimitUnlock = haveNextDay
  if haveNextDay then
    local nextDayMaxScore = nextMaxScore
    self.bind.txt_scoreLimitUnlock = L_WordsTpl:getValue("nextday_unlock_max", {
      [0] = nextDayMaxScore
    })
  end
end

function this:getPassDay()
  local tpl = _GameEventTpl:getTplById(self.data.activityId)
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

function this:getCurScore()
  return L_LimitedTimeActivityStore:getActivityScore(self.data.activityId)
end

return this
