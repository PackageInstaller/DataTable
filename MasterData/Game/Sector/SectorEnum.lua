local SectorEnum = {}
SectorEnum.eSectorAchivState = {
  Normal = 1,
  Completed = 2,
  Picked = 3
}
SectorEnum.eSectorMentionId = {
  None = 0,
  MaterialDungeonId = 11,
  FriendshipDungeonId = 22,
  ATHDungeonId = 13,
  DailyChallenge = 23,
  WeeklyChallenge = 24,
  DungeonTower = 27
}
SectorEnum.NewbeeSectorId = 100
SectorEnum.InfinityGroup = 5
SectorEnum.eSectorLevelItemType = {
  Normal = 0,
  ForkUp = 1,
  ForkDown = 2,
  OnlyNumber = 100
}
SectorEnum.SectorLevelItemDesc = {
  [SectorEnum.eSectorLevelItemType.Normal] = "STAGE %d-%d",
  [SectorEnum.eSectorLevelItemType.ForkUp] = "STAGE UP %d-%d",
  [SectorEnum.eSectorLevelItemType.ForkDown] = "STAGE DOWN %d-%d",
  [SectorEnum.eSectorLevelItemType.OnlyNumber] = "STAGE %d"
}
SectorEnum.SectorAvgItemDesc = {
  [SectorEnum.eSectorLevelItemType.Normal] = "PART.%d",
  [SectorEnum.eSectorLevelItemType.ForkUp] = "PART UP.%d",
  [SectorEnum.eSectorLevelItemType.ForkDown] = "PART DOWN.%d"
}
SectorEnum.SectorRewardShowType = {
  FirstReward = 0,
  FixedReward = 1,
  HideReward = 2
}
SectorEnum.SctRelevancyNormalSector = 1000
SectorEnum.ePageIndex = {
  main = 1,
  act = 2,
  res = 3,
  challenge = 4
}
return SectorEnum
