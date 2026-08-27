local TaskEnum = {}
TaskEnum.eTaskType = {
  MainTask = 1,
  SideTask = 2,
  DailyTask = 4,
  WeeklyTask = 5,
  SectorTask = 300,
  Achievement = 600,
  AvgTask = 7,
  SpecialTask = 8,
  heroTrainTask = 10,
  WeeklyChallengeTask = 12,
  TimeLimitTask = 700,
  LargeActivityTask = 701,
  HeroActivityTask = 702,
  WDRecycleTask = 703,
  WDOnceTask = 704,
  ComebackTask = 705,
  CarnivalTask = 706,
  HTGTinyGameTask = 707,
  SectorIIITask = 708,
  HallowmasTask = 711,
  dubinTask = 712,
  wendiTask = 714,
  ChristmasTask = 715,
  ShortTheatreTask = 777,
  ActivityTask = 800,
  MilestoneTask = 1300,
  BrotatoTask = 1800,
  BrotatoTaskMax = 1850,
  PerformanceSoundPlay = 1950
}
TaskEnum.eActivityTaskNeedShowReward = {
  [TaskEnum.eTaskType.LargeActivityTask] = true,
  [TaskEnum.eTaskType.HeroActivityTask] = true,
  [TaskEnum.eTaskType.HTGTinyGameTask] = true,
  [TaskEnum.eTaskType.ShortTheatreTask] = true
}

function TaskEnum.IsActivityTask(taskType)
  return TaskEnum.eActivityTaskNeedShowReward[taskType]
end

TaskEnum.eTaskPeriodType = {
  DailyTask = 1,
  WeeklyTask = 2,
  WeeklyChallengeTask = 3
}
TaskEnum.eTaskState = {
  InProgress = 1,
  Completed = 2,
  Picked = 3
}
TaskEnum.eSpecialType = {
  FirstBattleGuide1 = 1,
  FirstBattleGuide2 = 2,
  QuckEnterExploration = 3
}
TaskEnum.HomeTaskRewardOthers = {
  TaskEnum.eTaskType.SideTask,
  TaskEnum.eTaskType.WeeklyTask,
  TaskEnum.eTaskType.DailyTask,
  TaskEnum.eTaskType.LargeActivityTask,
  TaskEnum.eTaskType.HeroActivityTask
}
TaskEnum.eFinishConditon = {
  MsBandHeroNum = 150,
  MsBandHeroLevel = 151,
  MsBandHeroStar = 152
}
TaskEnum.MsFinishConditionDic = {
  [TaskEnum.eFinishConditon.MsBandHeroNum] = true,
  [TaskEnum.eFinishConditon.MsBandHeroLevel] = true,
  [TaskEnum.eFinishConditon.MsBandHeroStar] = true
}
return TaskEnum
