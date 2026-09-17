local this = class("gameActivityManager")
local _GameEventRewardTpl = L_GameTpl:getGameEventsRewardTpl()
local _GameActivityPlayTpl = L_GameTpl:getGameActivityPlayTpl()

function this:OpenGameActivityHelpPage(activityIds)
  L_UI:open("pageTutorialActivity", {activities = activityIds})
end

function this:IsAllActivitiesRewardGet(mainGameplayActivityId)
  local mainGameEventData = L_GameEventStore:getGameEventData(mainGameplayActivityId)
  if mainGameEventData then
    local rewardStateList = mainGameEventData:getRewardStateList()
    if rewardStateList then
      for _, reward in pairs(rewardStateList) do
        if reward.reward_state ~= L_Const.ActivityRewardState.ARS_REWARDED then
          return false
        end
      end
    end
  else
    return false
  end
  local subActivities = self:GetSubActivitiesByMainActivityId(mainGameplayActivityId)
  if subActivities then
    for _, subActivityId in ipairs(subActivities) do
      local subGameEventData = L_GameEventStore:getGameEventData(subActivityId)
      if subGameEventData then
        local subRewardStateList = subGameEventData:getRewardStateList()
        if subRewardStateList then
          for _, reward in pairs(subRewardStateList) do
            if reward.reward_state ~= L_Const.ActivityRewardState.ARS_REWARDED then
              return false
            end
          end
        end
      else
        return false
      end
    end
  end
  return true
end

function this:GetMainReward(mainGameplayActivityId)
  local allRewardData = _GameEventRewardTpl:getData()
  local mainRewards = {}
  for i, reward in pairs(allRewardData) do
    if _GameEventRewardTpl:getGroupId(reward) == mainGameplayActivityId then
      local rewardData = _GameEventRewardTpl:getReward(reward)
      if rewardData then
        table.insert(mainRewards, rewardData)
      end
    end
  end
  return mainRewards
end

function this:GetSubActivitiesByMainActivityId(mainGameplayActivityId)
  if mainGameplayActivityId == L_LimitedTimeActivityStore.MainGameplayActivity.Xiaoyu then
    return {
      L_LimitedTimeActivityStore.LimitedActivityType.Xiaoyu,
      L_LimitedTimeActivityStore.LimitedActivityType.XiaoyuAvatarBattle
    }
  elseif mainGameplayActivityId == L_LimitedTimeActivityStore.MainGameplayActivity.Qiandai then
    return {
      L_LimitedTimeActivityStore.LimitedActivityType.Qiandai,
      L_LimitedTimeActivityStore.LimitedActivityType.QiandaiAvatarBattle
    }
  end
end

function this:getAvailableQiandaiLevelIds()
  local qiandaiActivityId = L_LimitedTimeActivityStore.LimitedActivityType.Qiandai
  local allData = _GameActivityPlayTpl:getAllData()
  local availableLevels = {}
  for id, tpl in pairs(allData) do
    if _GameActivityPlayTpl:getActivityId(tpl) == qiandaiActivityId then
      local taskUnlockConditions = _GameActivityPlayTpl:getTaskUnlock(tpl)
      local conditionsMet = true
      if taskUnlockConditions and 0 < #taskUnlockConditions then
        for _, condition in ipairs(taskUnlockConditions) do
          if not L_ConditionManager:singleIsComplete(condition) then
            conditionsMet = false
            break
          end
        end
      end
      if conditionsMet then
        table.insert(availableLevels, _GameActivityPlayTpl:getId(tpl))
      end
    end
  end
  return availableLevels
end

function this:randomQiandaiLevelId()
  local availableLevels = self:getAvailableQiandaiLevelIds()
  if #availableLevels == 0 then
    return nil
  end
  local randomIndex = math.random(1, #availableLevels)
  return availableLevels[randomIndex]
end

return this
