local key = {ID = 1, Param = 2}
local config = {
  {
    1,
    {
      wordList = {
        2001,
        2003,
        2005,
        2007,
        2009,
        3001,
        3002,
        2000
      },
      viewEffStartVal = 99,
      {
        range = {100, 100},
        descStr = "str_battle_san_desc_0"
      },
      {
        range = {80, 99},
        descStr = "str_battle_san_desc_1"
      },
      {
        range = {50, 79},
        descStr = "str_battle_san_desc_2"
      },
      {
        range = {20, 49},
        descStr = "str_battle_san_desc_3"
      },
      {
        range = {1, 19},
        descStr = "str_battle_san_desc_4"
      },
      {
        range = {0, 0},
        descStr = "str_battle_san_desc_5"
      }
    }
  },
  {
    2,
    {
      wordList = {
        2101,
        2103,
        2105,
        2107,
        2109,
        3001,
        3002,
        2000
      },
      viewEffStartVal = 79,
      {
        range = {80, 100},
        descStr = "str_battle_san_desc_10"
      },
      {
        range = {50, 79},
        descStr = "str_battle_san_desc_11"
      },
      {
        range = {20, 49},
        descStr = "str_battle_san_desc_12"
      },
      {
        range = {1, 19},
        descStr = "str_battle_san_desc_13"
      },
      {
        range = {0, 0},
        descStr = "str_battle_san_desc_14"
      }
    }
  }
}
return config, "ID", key
