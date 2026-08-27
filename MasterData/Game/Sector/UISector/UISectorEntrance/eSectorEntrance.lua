local eSectorEntrance = {}
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
eSectorEntrance.eEntranceType = {
  resDungeon = 101,
  frageDungeon = 102,
  athDungeon = 103,
  daily = 201,
  weekly = 301,
  blackHole = 401,
  sixHeroTower = 511
}
eSectorEntrance.entranceType2DungeonType = {
  [eSectorEntrance.eEntranceType.resDungeon] = eDungeonEnum.eDungeonType.matDungeon,
  [eSectorEntrance.eEntranceType.frageDungeon] = eDungeonEnum.eDungeonType.fragDungeon,
  [eSectorEntrance.eEntranceType.athDungeon] = eDungeonEnum.eDungeonType.ATHDungeon
}
eSectorEntrance.stateInfoType = {
  underSearch = 0,
  leftTime = 1,
  leftTimeWithDay = 2,
  thisWeekBuffTime = 3,
  todayLeftTime = 4,
  process = 5,
  todayFinished = 6
}
eSectorEntrance.secondStateInfoType = {periodicProcess = 0}
eSectorEntrance.stateTagType = {double = 0, buffButNotDouble = 1}
return eSectorEntrance
