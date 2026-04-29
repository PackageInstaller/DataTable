PetFilterType = {
  None = 0,
  ElementBlue = 1,
  ElementRed = 2,
  ElementGreen = 3,
  ElementYellow = 4,
  ElementNone = 6,
  MainElementBlue = 11,
  MainElementRed = 12,
  MainElementGreen = 13,
  MainElementYellow = 14,
  MainElementNone = 16,
  NotInRoom = 100,
  InCentralRoom = 101,
  InPowerRoom = 102,
  InMazeRoom = 103,
  InPrismRoom = 104,
  InResouceRoom = 105,
  InTowerRoom = 106,
  InEvilRoom = 107,
  BaiYeCheng = 1001,
  BaiYeXiaCheng = 1002,
  QiGuang = 1003,
  BeiJing = 1004,
  HongYouBanShou = 1005,
  TaiYangJiaoTuan = 1006,
  YouMin = 1007,
  RiShi = 1008,
  LongZhou = 1009,
  JobColor = 2001,
  JobBlood = 2002,
  JobAttack = 2003,
  JobFunction = 2004,
  FT_Start = 3001,
  GongTing = 3001,
  JiaoHui = 3002,
  GuiZu = 3003,
  SiTianShi = 3004,
  SiLingBu = 3005,
  JunDui = 3006,
  KeYanWeiYuanHui = 3007,
  GongWuYuan = 3008,
  TanSuoDui = 3009,
  GanBu = 3010,
  ChengYuan = 3011,
  YiSiTaWanBang = 3012,
  LieQueBang = 3013,
  JuMin = 3014,
  GaoJiSheYuan = 3015,
  PuTongSheYuan = 3016,
  XinShiGongHui = 3017,
  YouMinFriend = 3018,
  LingXiu = 3019,
  JingYing = 3020,
  AnGui = 3021,
  RedPoint_Break = 8000,
  Refine = 8001,
  Fav_Collect = 8002,
  DontFilter = 9000,
  FT_End = 9999
}
BookCGType = {
  Main = 1,
  Ext = 2,
  Pet = 3,
  Season = 4,
  Max = 4
}
BookRoleType = {Pet = 1, Monster = 2}
BookMainType = {
  RenShiQingBao = 1,
  CG = 2,
  Music = 3,
  Plot = 4,
  Medal = 5
}
local PetAttributeType = {
  None = 0,
  Attack = 1,
  Defence = 2,
  HP = 3
}
_enum("PetAttributeType", PetAttributeType)
local PetTagType = {
  Camp = 1,
  Function = 2,
  Friend = 3
}
_enum("PetTagType", PetTagType)
local PetIntimacyCondition = {
  Affinity = 1,
  Grade = 2,
  Three = 3,
  Time = 4,
  ServerTime = 5,
  AffinityEqual = 6,
  DateLock = 7,
  Skin = 8,
  SpeSkin = 9
}
_enum("PetIntimacyCondition", PetIntimacyCondition)
