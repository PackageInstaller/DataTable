local key = {
  ID = 1,
  Title = 2,
  BGS = 3,
  ScrollIndex = 4,
  InfoBg = 5,
  LayoutIcon = 6,
  BattleBtn = 7
}
local common = {
  {
    "str_week_tower_title_1101",
    "str_week_tower_title_1101",
    "str_week_tower_title_1101"
  },
  {
    {
      "week_tower_level_ban01"
    },
    {
      "week_tower_level_ban02"
    },
    {
      "week_tower_level_ban03"
    }
  },
  {
    {
      "week_tower_level_chart01"
    },
    {
      "week_tower_level_chart02"
    },
    {
      "week_tower_level_chart03"
    }
  },
  {
    {
      "week_tower_level_di01"
    },
    {
      "week_tower_level_di02"
    },
    {
      "week_tower_level_di03"
    }
  },
  {
    {
      "lose_level_btn2"
    },
    {
      "lose_level_btn3"
    },
    {
      "lose_level_btn4"
    }
  },
  {
    {0},
    {0},
    {0}
  }
}
local config = {
  [1101] = {
    1101,
    common[1],
    {
      {
        "week_tower_level_chart01",
        "week_tower_level_chart02",
        "week_tower_level_chart03"
      },
      {
        "week_tower_level_chart01",
        "week_tower_level_chart02",
        "week_tower_level_chart03"
      },
      {
        "week_tower_level_chart01",
        "week_tower_level_chart02",
        "week_tower_level_chart03"
      }
    },
    {
      {6, 12},
      {6, 12},
      {6, 12}
    },
    {
      {
        "week_tower_level_di01",
        "week_tower_level_di02",
        "week_tower_level_di03"
      },
      {
        "week_tower_level_di01",
        "week_tower_level_di02",
        "week_tower_level_di03"
      },
      {
        "week_tower_level_di01",
        "week_tower_level_di02",
        "week_tower_level_di03"
      }
    },
    common[2],
    {
      {
        "lose_level_btn2",
        "lose_level_btn3",
        "lose_level_btn4"
      },
      {
        "lose_level_btn2",
        "lose_level_btn3",
        "lose_level_btn4"
      },
      {
        "lose_level_btn2",
        "lose_level_btn3",
        "lose_level_btn4"
      }
    }
  },
  [1024] = {
    1024,
    common[1],
    common[3],
    common[6],
    common[4],
    common[2],
    common[5]
  },
  [1028] = {
    1028,
    common[1],
    common[3],
    common[6],
    common[4],
    common[2],
    common[5]
  },
  [1065] = {
    1065,
    common[1],
    common[3],
    common[6],
    common[4],
    common[2],
    common[5]
  },
  [1071] = {
    1071,
    common[1],
    common[3],
    common[6],
    common[4],
    common[2],
    common[5]
  },
  [1150] = {
    1150,
    common[1],
    common[3],
    common[6],
    common[4],
    common[2],
    common[5]
  },
  [1152] = {
    1152,
    common[1],
    common[3],
    common[6],
    common[4],
    common[2],
    common[5]
  },
  [5063] = {
    5063,
    common[1],
    common[3],
    common[6],
    common[4],
    common[2],
    common[5]
  }
}
return config, "ID", key
