local ActivityHallowmasEnum = {}
ActivityHallowmasEnum.reddotType = {
  DailyTask = 1,
  Exp = 2,
  Achievement = 3,
  SectorAvg = 4,
  Tech = 5,
  EnvTask = 6,
  TechItemLimit = 7
}
ActivityHallowmasEnum.reddotIsRedType = {
  ActivityHallowmasEnum.reddotType.DailyTask,
  ActivityHallowmasEnum.reddotType.Exp,
  ActivityHallowmasEnum.reddotType.Achievement,
  ActivityHallowmasEnum.reddotType.EnvTask
}
return ActivityHallowmasEnum
