local DungeonLevelEnum = {}
DungeonLevelEnum.DunLevelType = {
  None = 0,
  Tower = 1,
  SectorII = 2,
  SectorIIChallenge = 3,
  AprilFool = 4,
  Carnival = 5,
  ADC = 6,
  SectorIII = 7,
  HeroGrow = 8,
  Season = 9,
  Spring = 10,
  SeasonI = 11,
  CardSet = 12,
  ActBlackHole = 13,
  Repeat = 14,
  CommonHard = 15,
  HeroGrowV3Repeat = 16,
  HeroGrowChallenge = 17,
  Bond = 18,
  SixHeroTower = 19
}
DungeonLevelEnum.InterfaceType = {
  Default = 0,
  DailyDungeon = 1,
  DungeonTower = 2,
  SectorIIDungeon = 3,
  WinterChallenge = 4,
  RefreshDun = 5,
  Carnival = 6,
  ADC = 7,
  SectorIIIDungeon = 8,
  HeroGrow = 9,
  Season = 10,
  Spring = 11,
  CardSet = 12,
  ActBlackHole = 13,
  Repeat = 14,
  CommonHard = 15,
  HeroGrowV3Repeat = 16,
  HeroGrowChallenge = 17,
  HeroGrowV3Normal = 18,
  Bond = 19,
  SixHeroTower = 19
}
DungeonLevelEnum.DunModuleMsgProto = {
  [proto_csmsg_SystemFunctionID.SystemFunctionID_DungeonTower] = proto_csmsg_MSG_ID.MSG_CS_DUNGEONTOWER_Enter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_SixHeroTower] = proto_csmsg_MSG_ID.MSG_CS_DUNGEONTOWER_Enter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_ActivityWinter] = proto_csmsg_MSG_ID.MSG_CS_DUNGEONWINTER_Enter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_ActivityWinterChallenge] = proto_csmsg_MSG_ID.MSG_CS_DUNGEONWinterVerify_Enter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_RefreshDungeon] = proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_REFRESHDUNGEON_EnterDungeon,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_ActivityCarnival] = proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DUNGEON_GeneralEnter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_ActivityDailyChallenge] = proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DUNGEON_GeneralEnter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_ActivitySummer22] = proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DUNGEON_GeneralEnter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_HeroActivity] = proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DUNGEON_GeneralEnter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_WarChessSeason] = proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DUNGEON_GeneralEnter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_ActivitySpring] = proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DUNGEON_GeneralEnter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_activity_card_set] = proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Enter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_activity_blackhole] = proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DUNGEON_GeneralEnter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_activity_steinsgate] = proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DUNGEON_GeneralEnter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_activity_anniv] = proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DUNGEON_GeneralEnter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_herolite_rebrush] = proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DUNGEON_GeneralEnter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_herolite_challenge] = proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DUNGEON_GeneralEnter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_herolite_normal] = proto_csmsg_MSG_ID.MSG_CS_Activity_DungeonGroup_Enter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_herolite_normal_free] = proto_csmsg_MSG_ID.MSG_CS_Activity_DungeonGroup_Enter,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_activity_bond] = proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DUNGEON_GeneralEnter
}
DungeonLevelEnum.eDunLevelInfoNodeType = {LevelNormalInfo = 0, LevelChips = 1}
DungeonLevelEnum.DunCustomTicket = {
  [DungeonLevelEnum.DunLevelType.SectorII] = true,
  [DungeonLevelEnum.DunLevelType.SectorIIChallenge] = true,
  [DungeonLevelEnum.DunLevelType.SectorIII] = true,
  [DungeonLevelEnum.DunLevelType.HeroGrowV3Repeat] = true
}
DungeonLevelEnum.nodeTyps = {
  [DungeonLevelEnum.DunLevelType.None] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo
  },
  [DungeonLevelEnum.DunLevelType.Tower] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo,
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelChips
  },
  [DungeonLevelEnum.DunLevelType.SixHeroTower] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo,
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelChips
  },
  [DungeonLevelEnum.DunLevelType.SectorII] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo,
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelChips
  },
  [DungeonLevelEnum.DunLevelType.SectorIIChallenge] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo,
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelChips
  },
  [DungeonLevelEnum.DunLevelType.Carnival] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo,
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelChips
  },
  [DungeonLevelEnum.DunLevelType.ADC] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo,
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelChips
  },
  [DungeonLevelEnum.DunLevelType.SectorIII] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo
  },
  [DungeonLevelEnum.DunLevelType.HeroGrow] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo
  },
  [DungeonLevelEnum.DunLevelType.Season] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo
  },
  [DungeonLevelEnum.DunLevelType.Spring] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo,
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelChips
  },
  [DungeonLevelEnum.DunLevelType.SeasonI] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo
  },
  [DungeonLevelEnum.DunLevelType.Repeat] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo
  },
  [DungeonLevelEnum.DunLevelType.ActBlackHole] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo,
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelChips
  },
  [DungeonLevelEnum.DunLevelType.CommonHard] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo,
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelChips
  },
  [DungeonLevelEnum.DunLevelType.HeroGrowV3Repeat] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo
  },
  [DungeonLevelEnum.DunLevelType.HeroGrowChallenge] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo
  },
  [DungeonLevelEnum.DunLevelType.Bond] = {
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo,
    DungeonLevelEnum.eDunLevelInfoNodeType.LevelChips
  }
}
DungeonLevelEnum.TowerLevelItemType = {
  NormalItem = 0,
  BigItem = 1,
  TopEmpty = 2,
  DownEmpty = 3
}
DungeonLevelEnum.DunTowerCategory = {Normal = 0, TwinTower = 1}
return DungeonLevelEnum
