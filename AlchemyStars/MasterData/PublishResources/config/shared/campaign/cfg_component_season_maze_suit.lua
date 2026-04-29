local key = {
  ID = 1,
  ComponentID = 2,
  RelicList = 3,
  Name = 4,
  Words = 5,
  SuitEffect = 6,
  MutalExclusionRelic = 7
}
local common = {
  {
    {0},
    {0}
  }
}
local config = {
  [98101] = {
    98101,
    900308001,
    {
      9011016,
      9011017,
      9011018,
      9011019
    },
    "str_season_maze_relic_suit_98101_name",
    {
      "str_season_maze_relic_suit_desc_9810102",
      "str_season_maze_relic_suit_desc_9810104"
    },
    {
      {2, 9810102},
      {4, 9810104}
    },
    {
      {0},
      {9810102}
    }
  },
  [98102] = {
    98102,
    900308001,
    {
      9011077,
      9011078,
      9011079,
      9011080,
      9011081,
      9011082
    },
    "str_season_maze_relic_suit_98102_name",
    {
      "str_season_maze_relic_suit_desc_9810202",
      "str_season_maze_relic_suit_desc_9810204",
      "str_season_maze_relic_suit_desc_9810206"
    },
    {
      {2, 9810202},
      {4, 9810204},
      {6, 9810206}
    },
    {
      {0},
      {9810202},
      {9810202}
    }
  },
  [98103] = {
    98103,
    900308001,
    {
      9011020,
      9011021,
      9011022,
      9011023
    },
    "str_season_maze_relic_suit_98103_name",
    {
      "str_season_maze_relic_suit_desc_9810302",
      "str_season_maze_relic_suit_desc_9810304"
    },
    {
      {2, 9810302},
      {4, 9810304}
    },
    {
      {0},
      {9810302}
    }
  },
  [98104] = {
    98104,
    900308001,
    {
      9011032,
      9011033,
      9011034,
      9011035
    },
    "str_season_maze_relic_suit_98104_name",
    {
      "str_season_maze_relic_suit_desc_9810401",
      "str_season_maze_relic_suit_desc_9810402",
      "str_season_maze_relic_suit_desc_9810404"
    },
    {
      {1, 9810401},
      {2, 9810402},
      {4, 9810404}
    },
    {
      {0},
      {9810401},
      {9810401, 9810402}
    }
  },
  [98105] = {
    98105,
    900308001,
    {
      9011083,
      9011084,
      9011085,
      9011086,
      9011087,
      9011088
    },
    "str_season_maze_relic_suit_98105_name",
    {
      "str_season_maze_relic_suit_desc_9810502",
      "str_season_maze_relic_suit_desc_9810504",
      "str_season_maze_relic_suit_desc_9810506"
    },
    {
      {2, 9810502},
      {4, 9810504},
      {6, 9810506}
    },
    {
      {0},
      {9810502},
      {9810502}
    }
  },
  [98106] = {
    98106,
    900308001,
    {
      9011040,
      9011041,
      9011042,
      9011043
    },
    "str_season_maze_relic_suit_98106_name",
    {
      "str_season_maze_relic_suit_desc_9010602",
      "str_season_maze_relic_suit_desc_9010604"
    },
    {
      {2, 9010602},
      {4, 9010604}
    },
    common[1]
  },
  [98107] = {
    98107,
    900308001,
    {
      9011048,
      9011049,
      9011050,
      9011051,
      9011052,
      9011053
    },
    "str_season_maze_relic_suit_98107_name",
    {
      "str_season_maze_relic_suit_desc_9810702",
      "str_season_maze_relic_suit_desc_9810704",
      "str_season_maze_relic_suit_desc_9810706"
    },
    {
      {2, 9810702},
      {4, 9810704},
      {6, 9810706}
    },
    {
      {0},
      {0},
      {0}
    }
  },
  [98108] = {
    98108,
    900308001,
    {
      9011009,
      9011010,
      9011011,
      9011012
    },
    "str_season_maze_relic_suit_98108_name",
    {
      "str_season_maze_relic_suit_desc_9010802",
      "str_season_maze_relic_suit_desc_9010804"
    },
    {
      {2, 9010802},
      {4, 9010804}
    },
    common[1]
  }
}
return config, "ID", key
