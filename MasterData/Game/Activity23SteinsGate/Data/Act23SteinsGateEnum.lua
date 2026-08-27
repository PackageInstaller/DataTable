local Act23SteinsGateEnum = {}
Act23SteinsGateEnum.reddotType = {
  DailyTask = 1,
  OnceTask = 2,
  Shop = 3,
  CardSetTask = 4,
  H5MiniGame = 5,
  Brotato = 6
}
Act23SteinsGateEnum.reddotIsRedType = {
  Act23SteinsGateEnum.reddotType.DailyTask,
  Act23SteinsGateEnum.reddotType.OnceTask,
  Act23SteinsGateEnum.reddotType.CardSetTask
}
Act23SteinsGateEnum.performType = {
  OpenStoryLine = 1,
  OpenAndExtendStoryLine = 2,
  ReturnStoryLine = 11,
  ChangeLobby = 12,
  WorldLineSwitchAndChangeLobby = 13,
  ChangeHeroState = 14
}
Act23SteinsGateEnum.nodeType = {
  isLocked = 1,
  isUnlocked = 2,
  isCompleted = 3
}
Act23SteinsGateEnum.eStoryDiff = {Normal = 1, Hard = 2}
return Act23SteinsGateEnum
