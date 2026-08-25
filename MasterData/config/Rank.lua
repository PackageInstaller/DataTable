local System = require("System.System")
local readonly = System.readonly
local Rank = readonly({
  [18703] = {
    ID = 18703,
    CnID = "段位@新手",
    BaseSortID = 1,
    Name = "Rank_18703_Name|失眠病患",
    RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Blue.png",
    RankReward = readonly({
      [9542] = 50,
      [10108] = 10000
    }),
    NewRankReward = readonly({
      [10108] = 350000
    }),
    RankLowerInterval = 75,
    RankUpperInterval = 100,
    OldNewRankReward = readonly({
      [10108] = 50000,
      [74093] = 2
    }),
    OldRankLowerInterval = 75,
    OldRankUpperInterval = 100
  },
  [18706] = {
    ID = 18706,
    CnID = "段位@初级探员",
    BaseSortID = 2,
    Name = "Rank_18706_Name|潜游新手",
    RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Blue.png",
    RankReward = readonly({
      [9542] = 100,
      [10108] = 20000
    }),
    NewRankReward = readonly({
      [10108] = 500000
    }),
    RankLowerInterval = 35,
    RankUpperInterval = 75,
    OldNewRankReward = readonly({
      [10108] = 65000,
      [74093] = 3
    }),
    OldRankLowerInterval = 35,
    OldRankUpperInterval = 75
  },
  [18707] = {
    ID = 18707,
    CnID = "段位@资深探员",
    BaseSortID = 3,
    Name = "Rank_18707_Name|梦境学徒",
    RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Purple.png",
    RankReward = readonly({
      [9542] = 150,
      [10108] = 30000
    }),
    NewRankReward = readonly({
      [10108] = 650000
    }),
    RankLowerInterval = 15,
    RankUpperInterval = 35,
    OldNewRankReward = readonly({
      [10108] = 80000,
      [74093] = 4
    }),
    OldRankLowerInterval = 15,
    OldRankUpperInterval = 35
  },
  [18704] = {
    ID = 18704,
    CnID = "段位@精英探员",
    BaseSortID = 4,
    Name = "Rank_18704_Name|深潜学者",
    RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Purple.png",
    RankReward = readonly({
      [9542] = 200,
      [10108] = 40000
    }),
    NewRankReward = readonly({
      [10108] = 800000,
      [67377] = 5
    }),
    RankLowerInterval = 5,
    RankUpperInterval = 15,
    OldNewRankReward = readonly({
      [10108] = 100000,
      [74093] = 5,
      [74143] = 1
    }),
    OldRankLowerInterval = 5,
    OldRankUpperInterval = 15
  },
  [18702] = {
    ID = 18702,
    CnID = "段位@调查大师",
    BaseSortID = 5,
    Name = "Rank_18702_Name|深潜大师",
    RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Yellow.png",
    RankReward = readonly({
      [9542] = 225,
      [10108] = 50000
    }),
    NewRankReward = readonly({
      [10108] = 1000000,
      [67377] = 10
    }),
    RankLowerInterval = 1,
    RankUpperInterval = 5,
    OldNewRankReward = readonly({
      [10108] = 120000,
      [67377] = 1,
      [74093] = 6,
      [74143] = 2
    }),
    OldRankLowerInterval = 1,
    OldRankUpperInterval = 5
  },
  [18705] = {
    ID = 18705,
    CnID = "段位@觉醒者",
    BaseSortID = 6,
    Name = "Rank_18705_Name|幻梦主宰",
    RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Yellow.png",
    RankReward = readonly({
      [9542] = 250,
      [10108] = 60000
    }),
    NewRankReward = readonly({
      [10108] = 1200000,
      [67377] = 20
    }),
    RankLowerInterval = 0.2,
    RankUpperInterval = 1,
    OldNewRankReward = readonly({
      [10108] = 150000,
      [67377] = 2,
      [74093] = 7,
      [74143] = 3
    }),
    OldRankLowerInterval = 0,
    OldRankUpperInterval = 1
  },
  [117739] = {
    ID = 117739,
    CnID = "段位@传奇",
    BaseSortID = 7,
    Name = "Rank_117739_Name|幻梦传奇",
    RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Yellow.png",
    RankReward = readonly({
      [9542] = 250,
      [10108] = 60000
    }),
    NewRankReward = readonly({
      [10108] = 1500000,
      [67377] = 30
    }),
    RankLowerInterval = 0,
    RankUpperInterval = 0.2
  }
})
return Rank
