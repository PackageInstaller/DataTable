local eDungeonEnum = {}
require("Framework.Network.NetworkProto")
eDungeonEnum.eMatDungeonGroup = {DailyDungeon = 1}
eDungeonEnum.eDungeonType = {
  none = 0,
  fragDungeon = 1,
  matDungeon = 2,
  ATHDungeon = 3,
  DailyDungeon = 4
}
eDungeonEnum.systemFunctionID4DungeonType = {
  [eDungeonEnum.eDungeonType.fragDungeon] = proto_csmsg_SystemFunctionID.SystemFunctionID_friendship_sector_Ui,
  [eDungeonEnum.eDungeonType.matDungeon] = proto_csmsg_SystemFunctionID.SystemFunctionID_MaterialDungeon,
  [eDungeonEnum.eDungeonType.ATHDungeon] = proto_csmsg_SystemFunctionID.SystemFunctionID_ATHDungeon,
  [eDungeonEnum.eDungeonType.DailyDungeon] = proto_csmsg_SystemFunctionID.SystemFunctionID_DailyDungeon
}
eDungeonEnum.activityDailyChallengeDungeonScoreType = {
  Daily = 1,
  Spring = 2,
  BlackHole = 3,
  CommonHard = 4
}
return eDungeonEnum
