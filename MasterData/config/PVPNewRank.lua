local System = require("System.System")
local readonly = System.readonly
local PVPNewRank = readonly({
  [46160] = {
    ID = 46160,
    CnID = "段位@初级探员",
    BaseSortID = 1,
    Name = "PVPNewRank_46160_Name|相位新手",
    RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Blue.png",
    GoldReward = readonly({
      [10108] = 500000
    }),
    RankLowerInterval = 75,
    RankUpperInterval = 100,
    RotationModeRankLowerInterval = 75,
    RotationModeRankUpperInterval = 100,
    OldCoinReward = readonly({
      [9542] = 500
    }),
    OldGoldReward = readonly({
      [10108] = 65000,
      [74093] = 3
    }),
    OldPVPRankLowerInterval = 75,
    OldPVPRankUpperInterval = 100
  },
  [46161] = {
    ID = 46161,
    CnID = "段位@资深探员",
    BaseSortID = 2,
    Name = "PVPNewRank_46161_Name|对弈学徒",
    RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Purple.png",
    GoldReward = readonly({
      [10108] = 650000
    }),
    RankLowerInterval = 50,
    RankUpperInterval = 75,
    RotationModeRankLowerInterval = 50,
    RotationModeRankUpperInterval = 75,
    OldCoinReward = readonly({
      [9542] = 600
    }),
    OldGoldReward = readonly({
      [10108] = 80000,
      [74093] = 4
    }),
    OldPVPRankLowerInterval = 50,
    OldPVPRankUpperInterval = 75
  },
  [46157] = {
    ID = 46157,
    CnID = "段位@精英探员",
    BaseSortID = 3,
    Name = "PVPNewRank_46157_Name|相位精英",
    RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Purple.png",
    GoldReward = readonly({
      [10108] = 800000,
      [67377] = 5
    }),
    RankLowerInterval = 25,
    RankUpperInterval = 50,
    RotationModeRankLowerInterval = 25,
    RotationModeRankUpperInterval = 50,
    OldCoinReward = readonly({
      [9542] = 700
    }),
    OldGoldReward = readonly({
      [10108] = 100000,
      [74093] = 5,
      [74143] = 1
    }),
    OldPVPRankLowerInterval = 25,
    OldPVPRankUpperInterval = 50
  },
  [46158] = {
    ID = 46158,
    CnID = "段位@调查大师",
    BaseSortID = 4,
    Name = "PVPNewRank_46158_Name|对弈大师",
    RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Yellow.png",
    GoldReward = readonly({
      [10108] = 1000000,
      [67377] = 10
    }),
    RankLowerInterval = 10,
    RankUpperInterval = 25,
    RotationModeRankLowerInterval = 10,
    RotationModeRankUpperInterval = 25,
    OldCoinReward = readonly({
      [9542] = 800
    }),
    OldGoldReward = readonly({
      [10108] = 120000,
      [67377] = 1,
      [74093] = 6,
      [74143] = 2
    }),
    OldPVPRankLowerInterval = 10,
    OldPVPRankUpperInterval = 25
  },
  [46159] = {
    ID = 46159,
    CnID = "段位@觉醒者",
    BaseSortID = 5,
    Name = "PVPNewRank_46159_Name|相位支配者",
    RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Yellow.png",
    GoldReward = readonly({
      [10108] = 1200000,
      [67377] = 20
    }),
    RankLowerInterval = 2,
    RankUpperInterval = 10,
    RotationModeRankLowerInterval = 2,
    RotationModeRankUpperInterval = 10,
    OldCoinReward = readonly({
      [9542] = 900
    }),
    OldGoldReward = readonly({
      [10108] = 150000,
      [67377] = 2,
      [74093] = 7,
      [74143] = 3
    }),
    OldPVPRankLowerInterval = 0,
    OldPVPRankUpperInterval = 10
  },
  [121221] = {
    ID = 121221,
    CnID = "段位@相位传奇",
    BaseSortID = 6,
    Name = "PVPNewRank_121221_Name|相位传奇",
    RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Yellow.png",
    GoldReward = readonly({
      [10108] = 1500000,
      [67377] = 30
    }),
    RankLowerInterval = 0,
    RankUpperInterval = 2,
    RotationModeRankLowerInterval = 0,
    RotationModeRankUpperInterval = 2
  }
})
return PVPNewRank
