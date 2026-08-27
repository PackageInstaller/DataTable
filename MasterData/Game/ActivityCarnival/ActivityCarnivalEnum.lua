local ActivityCarnivalEnum = {}
ActivityCarnivalEnum.eActivityCarnivalReddot = {
  Task = "Task",
  Reward = "Reward",
  UnlockEnv = "UnlockEnv",
  TaskPeriod = "TaskPeriod",
  UnlockStage = "UnlockStage",
  Tech = "Tech",
  AutoTech = "AutoTech",
  UnlockHardDun = "UnlockHardDun"
}
ActivityCarnivalEnum.eReddotShowRedTypes = {
  ActivityCarnivalEnum.eActivityCarnivalReddot.Task,
  ActivityCarnivalEnum.eActivityCarnivalReddot.Reward,
  ActivityCarnivalEnum.eActivityCarnivalReddot.UnlockEnv,
  ActivityCarnivalEnum.eActivityCarnivalReddot.UnlockHardDun,
  ActivityCarnivalEnum.eActivityCarnivalReddot.AutoTech
}
ActivityCarnivalEnum.eActivityCarnivalQuestQuality = {
  S = 1,
  A = 2,
  B = 3
}
ActivityCarnivalEnum.eActivityCarnivalUnlockNew = {
  Env = 1,
  AVG = 2,
  Stage = 3
}
return ActivityCarnivalEnum
