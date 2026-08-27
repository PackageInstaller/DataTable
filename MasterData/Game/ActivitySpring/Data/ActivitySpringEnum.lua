local ActivitySpringEnum = class("ActivitySpringEnum")
ActivitySpringEnum.reddotType = {
  OnceTask = 1,
  DailyTask = 2,
  Tech = 3,
  TechItemLimit = 4,
  Talk = 5,
  HardLevel = 6,
  EpEnv = 7,
  TeamPerformance = 8,
  Brotato = 9
}
ActivitySpringEnum.reddotIsRedType = {
  ActivitySpringEnum.reddotType.OnceTask,
  ActivitySpringEnum.reddotType.DailyTask,
  ActivitySpringEnum.reddotType.Talk,
  ActivitySpringEnum.reddotType.TeamPerformance,
  ActivitySpringEnum.reddotType.Brotato
}
ActivitySpringEnum.actDataType = {Spring = 1, Music = 3}
ActivitySpringEnum.actHandbookType = {Spring = 1, Common = 2}
return ActivitySpringEnum
