local ActHGV3Enum = {}
ActHGV3Enum.reddotType = {
  DailyTaskNew = 1,
  DailyTaskCom = 2,
  BPRewardCom = 4,
  NormalNew = 5,
  ChallengeNew = 6,
  ChallengeReward = 7,
  RepeatHaveTicket = 8
}
ActHGV3Enum.reddotIsRedType = {
  ActHGV3Enum.reddotType.DailyTaskCom,
  ActHGV3Enum.reddotType.BPRewardCom,
  ActHGV3Enum.reddotType.ChallengeReward
}
return ActHGV3Enum
