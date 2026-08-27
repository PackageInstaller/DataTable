local ActivitySeasonEnum = {}
ActivitySeasonEnum.reddotType = {
  DailyTask = 1,
  OnceTask = 2,
  Tech = 3,
  mainStory = 4,
  Bonus = 5
}
ActivitySeasonEnum.reddotIsRedType = {
  ActivitySeasonEnum.reddotType.DailyTask,
  ActivitySeasonEnum.reddotType.OnceTask
}
return ActivitySeasonEnum
