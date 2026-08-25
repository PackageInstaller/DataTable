local System = require("System.System")
local readonly = System.readonly
local SeasonRankReward = readonly({
  [132569] = {
    ID = 132569,
    CnID = "赛季排名奖励@幻梦深潜通用",
    BaseSortID = 1,
    data_list = readonly({
      readonly({
        BaseSortID = 1,
        Type = "幻梦深潜",
        Name = "SeasonRankReward_132569_Name_1|失眠病患",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Blue.png",
        NewRankReward = readonly({
          [10108] = 350000
        }),
        RankLowerInterval = 75,
        RankUpperInterval = 100
      }),
      readonly({
        Name = "SeasonRankReward_132569_Name_2|潜游新手",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Blue.png",
        NewRankReward = readonly({
          [10108] = 500000,
          [74093] = 10,
          [74143] = 5
        }),
        RankLowerInterval = 35,
        RankUpperInterval = 75
      }),
      readonly({
        Name = "SeasonRankReward_132569_Name_3|梦境学徒",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Purple.png",
        NewRankReward = readonly({
          [10108] = 650000,
          [74093] = 20,
          [74143] = 10
        }),
        RankLowerInterval = 15,
        RankUpperInterval = 35
      }),
      readonly({
        Name = "SeasonRankReward_132569_Name_4|深潜学者",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Purple.png",
        NewRankReward = readonly({
          [10108] = 800000,
          [67377] = 5,
          [74093] = 40,
          [74143] = 20
        }),
        RankLowerInterval = 5,
        RankUpperInterval = 15
      }),
      readonly({
        Name = "SeasonRankReward_132569_Name_5|深潜大师",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Yellow.png",
        NewRankReward = readonly({
          [10108] = 1000000,
          [67377] = 10,
          [74093] = 60,
          [74143] = 30
        }),
        RankLowerInterval = 1,
        RankUpperInterval = 5
      }),
      readonly({
        Name = "SeasonRankReward_132569_Name_6|幻梦主宰",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Yellow.png",
        NewRankReward = readonly({
          [10108] = 1200000,
          [67377] = 20,
          [74093] = 80,
          [74143] = 40
        }),
        RankLowerInterval = 0.2,
        RankUpperInterval = 1
      }),
      readonly({
        Name = "SeasonRankReward_132569_Name_7|幻梦传奇",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Yellow.png",
        NewRankReward = readonly({
          [10108] = 1500000,
          [67377] = 30,
          [74093] = 100,
          [74143] = 50
        }),
        RankLowerInterval = 0,
        RankUpperInterval = 0.2
      })
    })
  },
  [132568] = {
    ID = 132568,
    CnID = "赛季排名奖励@相位对弈预组通用",
    BaseSortID = 2,
    data_list = readonly({
      readonly({
        BaseSortID = 2,
        Type = "预组模式",
        Name = "SeasonRankReward_132568_Name_1|相位新手",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Blue.png",
        NewRankReward = readonly({
          [10108] = 500000,
          [74093] = 10,
          [74143] = 5
        }),
        RankLowerInterval = 75,
        RankUpperInterval = 100
      }),
      readonly({
        Name = "SeasonRankReward_132568_Name_2|对弈学徒",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Purple.png",
        NewRankReward = readonly({
          [10108] = 650000,
          [74093] = 20,
          [74143] = 10
        }),
        RankLowerInterval = 50,
        RankUpperInterval = 75
      }),
      readonly({
        Name = "SeasonRankReward_132568_Name_3|相位精英",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Purple.png",
        NewRankReward = readonly({
          [10108] = 800000,
          [67377] = 5,
          [74093] = 40,
          [74143] = 20
        }),
        RankLowerInterval = 25,
        RankUpperInterval = 50
      }),
      readonly({
        Name = "SeasonRankReward_132568_Name_4|对弈大师",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Yellow.png",
        NewRankReward = readonly({
          [10108] = 1000000,
          [67377] = 10,
          [74093] = 60,
          [74143] = 30
        }),
        RankLowerInterval = 10,
        RankUpperInterval = 25
      }),
      readonly({
        Name = "SeasonRankReward_132568_Name_5|相位支配者",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Yellow.png",
        NewRankReward = readonly({
          [10108] = 1200000,
          [67377] = 20,
          [74093] = 80,
          [74143] = 40
        }),
        RankLowerInterval = 2,
        RankUpperInterval = 10
      }),
      readonly({
        Name = "SeasonRankReward_132568_Name_6|相位传奇",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Yellow.png",
        NewRankReward = readonly({
          [10108] = 1500000,
          [67377] = 30,
          [74093] = 100,
          [74143] = 50
        }),
        RankLowerInterval = 0,
        RankUpperInterval = 2
      })
    })
  },
  [132566] = {
    ID = 132566,
    CnID = "赛季排名奖励@欢愉专列通用",
    BaseSortID = 3,
    data_list = readonly({
      readonly({
        BaseSortID = 3,
        Type = "欢愉列车",
        Name = "SeasonRankReward_132566_Name_1|列车新客",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Blue.png",
        NewRankReward = readonly({
          [10108] = 500000,
          [74093] = 10,
          [74143] = 5
        }),
        RankLowerInterval = 75,
        RankUpperInterval = 100
      }),
      readonly({
        Name = "SeasonRankReward_132566_Name_2|卧铺贵族",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Blue.png",
        NewRankReward = readonly({
          [10108] = 650000,
          [74093] = 20,
          [74143] = 10
        }),
        RankLowerInterval = 50,
        RankUpperInterval = 75
      }),
      readonly({
        Name = "SeasonRankReward_132566_Name_3|乘务员克星",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Purple.png",
        NewRankReward = readonly({
          [10108] = 800000,
          [67377] = 5,
          [74093] = 40,
          [74143] = 20
        }),
        RankLowerInterval = 25,
        RankUpperInterval = 50
      }),
      readonly({
        Name = "SeasonRankReward_132566_Name_4|餐车杀手",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Purple.png",
        NewRankReward = readonly({
          [10108] = 1000000,
          [67377] = 10,
          [74093] = 60,
          [74143] = 30
        }),
        RankLowerInterval = 10,
        RankUpperInterval = 25
      }),
      readonly({
        Name = "SeasonRankReward_132566_Name_5|安保大元帅",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Yellow.png",
        NewRankReward = readonly({
          [10108] = 1200000,
          [67377] = 20,
          [74093] = 80,
          [74143] = 40
        }),
        RankLowerInterval = 2,
        RankUpperInterval = 10
      }),
      readonly({
        Name = "SeasonRankReward_132566_Name_6|传奇老车长",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Yellow.png",
        NewRankReward = readonly({
          [10108] = 1500000,
          [67377] = 30,
          [74093] = 100,
          [74143] = 50
        }),
        RankLowerInterval = 0,
        RankUpperInterval = 2
      })
    })
  },
  [132567] = {
    ID = 132567,
    CnID = "赛季排名奖励@相位对弈轮选通用",
    BaseSortID = 4,
    data_list = readonly({
      readonly({
        BaseSortID = 4,
        Type = "轮选模式",
        Name = "SeasonRankReward_132567_Name_1|相位新手",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Blue.png",
        NewRankReward = readonly({
          [10108] = 500000,
          [74093] = 10,
          [74143] = 5
        }),
        RankLowerInterval = 75,
        RankUpperInterval = 100
      }),
      readonly({
        Name = "SeasonRankReward_132567_Name_2|对弈学徒",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Purple.png",
        NewRankReward = readonly({
          [10108] = 650000,
          [74093] = 20,
          [74143] = 10
        }),
        RankLowerInterval = 50,
        RankUpperInterval = 75
      }),
      readonly({
        Name = "SeasonRankReward_132567_Name_3|相位精英",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Purple.png",
        NewRankReward = readonly({
          [10108] = 800000,
          [67377] = 5,
          [74093] = 40,
          [74143] = 20
        }),
        RankLowerInterval = 25,
        RankUpperInterval = 50
      }),
      readonly({
        Name = "SeasonRankReward_132567_Name_4|对弈大师",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Yellow.png",
        NewRankReward = readonly({
          [10108] = 1000000,
          [67377] = 10,
          [74093] = 60,
          [74143] = 30
        }),
        RankLowerInterval = 10,
        RankUpperInterval = 25
      }),
      readonly({
        Name = "SeasonRankReward_132567_Name_5|相位支配者",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Yellow.png",
        NewRankReward = readonly({
          [10108] = 1200000,
          [67377] = 20,
          [74093] = 80,
          [74143] = 40
        }),
        RankLowerInterval = 2,
        RankUpperInterval = 10
      }),
      readonly({
        Name = "SeasonRankReward_132567_Name_6|相位传奇",
        RankIcon = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Item_WuPin_Quality/WuPin_Quality_Tab/WuPin_Quality_Tab_Yellow.png",
        NewRankReward = readonly({
          [10108] = 1500000,
          [67377] = 30,
          [74093] = 100,
          [74143] = 50
        }),
        RankLowerInterval = 0,
        RankUpperInterval = 2
      })
    })
  }
})
return SeasonRankReward
