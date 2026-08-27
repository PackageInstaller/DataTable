local DungeonDyncEnum = {}
DungeonDyncEnum.DgDyncType = {
  None = 0,
  DailyDungeon = 1,
  WinterChallenge = 2,
  HeroLite = 3,
  HeroLiteFree = 4
}
DungeonDyncEnum.DgDyncType2DungeonTypeDic = {
  [DungeonDyncEnum.DgDyncType.DailyDungeon] = proto_csmsg_DungeonType.DungeonType_Daily,
  [DungeonDyncEnum.DgDyncType.WinterChallenge] = proto_csmsg_DungeonType.DungeonType_WinterHard,
  [DungeonDyncEnum.DgDyncType.HeroLite] = proto_csmsg_DungeonType.DungeonType_HeroLite,
  [DungeonDyncEnum.DgDyncType.HeroLiteFree] = proto_csmsg_DungeonType.DungeonType_HeroLiteFree
}
return DungeonDyncEnum
