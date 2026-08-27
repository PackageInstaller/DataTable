local EventWeeklyQAQuestionRewardData = class("EventWeeklyQAQuestionRewardData")
EventWeeklyQAQuestionRewardData.eRewardState = {
  unComplete = 0,
  CompleteNoPicked = 1,
  Picked = 2
}

function EventWeeklyQAQuestionRewardData:ctor(needScore, rewardCfg, currentState)
  self.needScore = needScore
  self.rewardCfg = rewardCfg
  self.currentState = currentState
  return self
end

return EventWeeklyQAQuestionRewardData
