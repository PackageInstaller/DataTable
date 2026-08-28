local DataModel = {
  activityId = nil,
  activityCA = nil,
  reward = {},
  rewardState = {
    lock = 1,
    canGet = 2,
    got = 3
  },
  progressNum = 0,
  progress = 0,
  lastUnlock = 0,
  firstUnlock = 0,
  remainTime = 1,
  lastDay = 0
}

function DataModel:Init(parms)
  DataModel.activityId = parms.activityId
  DataModel.activityCA = PlayerData:GetFactoryData(DataModel.activityId)
  DataModel.reward = parms.reward
  DataModel.progressNum = parms.progressNum
  DataModel.firstUnlock = 0
end

function DataModel:GetRewardStateByIndex(index)
  local data = DataModel.activityCA.globalWeeklyRewardsList[index]
  if DataModel.reward and DataModel.reward[tostring(index - 1)] then
    return DataModel.rewardState.got
  elseif DataModel.progressNum >= data.score then
    return DataModel.rewardState.canGet
  end
  return DataModel.rewardState.lock
end

function DataModel:GetRewardLastUnlock()
  local lastUnlock = 0
  for i, v in ipairs(DataModel.activityCA.globalWeeklyRewardsList) do
    local data = DataModel.activityCA.globalWeeklyRewardsList[i]
    if DataModel.reward and DataModel.reward[tostring(i - 1)] then
      lastUnlock = i
    elseif DataModel.progressNum >= data.score then
      lastUnlock = i
    end
  end
  return lastUnlock
end

return DataModel
