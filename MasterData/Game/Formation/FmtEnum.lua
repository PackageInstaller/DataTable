local FmtEnum = {}
FmtEnum.FmtCtrlSate = {
  none = 0,
  parpare = 1,
  normal = 2,
  editing = 3
}
FmtEnum.eFmtFromModule = {
  MianFmt = -1,
  None = 0,
  SectorLevel = 1,
  FriendshipDungeon = 2,
  MaterialDungeon = 3,
  Infinity = 4,
  ATHDungeon = 5,
  PeriodicChallenge = 6,
  WeeklyChallenge = 7,
  DailyDungeon = 8,
  DailyDungeonLevel = 9,
  DungeonTower = 10,
  SectorIIDun = 11,
  SctIIDunChallenge = 12,
  ARDDun = 13,
  DungeonTwinTower = 14,
  CarnivalEp = 15,
  CarnivalDungeon = 16,
  ADCDungeon = 17,
  ActSectorIIIDun = 18,
  WarChess = 20,
  HeroGrow = 21,
  Season = 22,
  Spring = 23,
  SpringEp = 24,
  ActSeasonDun = 25,
  Brotato = 26,
  CardSet = 27,
  ActBlackHole = 28,
  Repeat = 29,
  FmtModeCommonHard = 30,
  HGV3Repeat = 31,
  HGV3Normal = 32,
  HGV3NormalFree = 33,
  BondDun = 34,
  SixHeroTower = 35,
  Infinity4Act24 = 36,
  ContinueAct24 = 37
}
FmtEnum.eFmtGamePlayType = {
  None = 0,
  Exploration = 1,
  Dungeon = 2,
  WarChess = 3
}
local fmtModule2PlayType = {
  [FmtEnum.eFmtFromModule.MianFmt] = FmtEnum.eFmtGamePlayType.None,
  [FmtEnum.eFmtFromModule.SectorLevel] = FmtEnum.eFmtGamePlayType.Exploration,
  [FmtEnum.eFmtFromModule.FriendshipDungeon] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.MaterialDungeon] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.Infinity] = FmtEnum.eFmtGamePlayType.Exploration,
  [FmtEnum.eFmtFromModule.ATHDungeon] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.PeriodicChallenge] = FmtEnum.eFmtGamePlayType.Exploration,
  [FmtEnum.eFmtFromModule.WeeklyChallenge] = FmtEnum.eFmtGamePlayType.Exploration,
  [FmtEnum.eFmtFromModule.DungeonTower] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.SectorIIDun] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.SctIIDunChallenge] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.ARDDun] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.DungeonTwinTower] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.CarnivalEp] = FmtEnum.eFmtGamePlayType.Exploration,
  [FmtEnum.eFmtFromModule.CarnivalDungeon] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.ActSectorIIIDun] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.HeroGrow] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.Season] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.Spring] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.SpringEp] = FmtEnum.eFmtGamePlayType.Exploration,
  [FmtEnum.eFmtFromModule.Brotato] = FmtEnum.eFmtGamePlayType.Exploration,
  [FmtEnum.eFmtFromModule.ActSeasonDun] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.CardSet] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.Repeat] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.ActBlackHole] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.FmtModeCommonHard] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.HGV3Repeat] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.BondDun] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.SixHeroTower] = FmtEnum.eFmtGamePlayType.Dungeon,
  [FmtEnum.eFmtFromModule.Infinity4Act24] = FmtEnum.eFmtGamePlayType.Exploration,
  [FmtEnum.eFmtFromModule.ContinueAct24] = FmtEnum.eFmtGamePlayType.Exploration
}
FmtEnum.eFmtEvaluationAdvant = {
  advContain = 1,
  advantage = 2,
  inferior = 3
}
FmtEnum.eFmtHeroDetailState = {
  Lock = 1,
  Empty = 2,
  HasHero = 3
}
FmtEnum.eFmtSpecialSector = {Copley = 6}
FmtEnum.eFmtSpecialSectorTip = {
  [FmtEnum.eFmtSpecialSector.Copley] = {9001}
}

function FmtEnum.GetFmtGameTypeByModuleId(modId)
  local gameType = fmtModule2PlayType[modId]
  return gameType or FmtEnum.eFmtGamePlayType.None
end

return FmtEnum
