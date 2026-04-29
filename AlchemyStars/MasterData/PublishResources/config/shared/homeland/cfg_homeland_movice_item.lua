local key = {
  ID = 1,
  Type = 2,
  HangPoint = 3,
  OptionID = 4,
  Name = 5,
  Introduction = 6,
  SelectList = 7,
  Offset = 8
}
local common = {
  {
    {1500331, 2}
  },
  {
    {5273001, 1},
    {5273010, 2},
    {5273019, 1}
  },
  {
    {5273002, 1},
    {5273011, 2},
    {5273020, 1}
  },
  {
    {1, 1},
    {2, 2},
    {3, 0}
  },
  {
    {5273001, 2},
    {5273010, 1},
    {5273019, 1}
  },
  {
    {5273002, 2},
    {5273011, 1},
    {5273020, 1}
  },
  {
    {1, 2},
    {2, 1},
    {3, 0}
  },
  {
    {1500711, 2}
  },
  {
    {5273001, 1},
    {5273010, 1},
    {5273019, 2}
  },
  {
    {5273002, 1},
    {5273011, 1},
    {5273020, 2}
  },
  {
    {1, 2},
    {2, 0},
    {3, 1}
  },
  {
    {1, 2},
    {2, 2},
    {3, 2}
  },
  {
    {1, 2},
    {2, 0},
    {3, 0}
  },
  {
    {1, 0},
    {2, 0},
    {3, 2}
  }
}
local config = {
  [101101] = {
    101101,
    1,
    "MoviePath101/101",
    nil,
    "str_movie_item_name_101101",
    "str_movie_item_intro_101101",
    common[1]
  },
  [101102] = {
    101102,
    1,
    "MoviePath101/102",
    nil,
    "str_movie_item_name_101102",
    "str_movie_item_intro_101102",
    {
      {1400811, 2}
    }
  },
  [101103] = {
    101103,
    1,
    "MoviePath101/103",
    nil,
    "str_movie_item_name_101103",
    "str_movie_item_intro_101103",
    {
      {1601461, 2},
      {1501141, 0}
    }
  },
  [101104] = {
    101104,
    1,
    "MoviePath101/104",
    nil,
    "str_movie_item_name_101104",
    "str_movie_item_intro_101104",
    {
      {1501441, 2},
      {1601671, 0}
    }
  },
  [101105] = {
    101105,
    1,
    "MoviePath101/105",
    nil,
    "str_movie_item_name_101105",
    "str_movie_item_intro_101105",
    {
      {1400451, 2},
      {1500921, 0}
    }
  },
  [101201] = {
    101201,
    2,
    nil,
    nil,
    "str_movie_item_name_101201",
    "str_movie_item_intro_101201",
    common[2]
  },
  [101202] = {
    101202,
    2,
    nil,
    nil,
    "str_movie_item_name_101202",
    "str_movie_item_intro_101202",
    common[3]
  },
  [101203] = {
    101203,
    2,
    "MoviePath101/201",
    nil,
    "str_movie_item_name_101203",
    "str_movie_item_intro_101203",
    {
      {5273012, 2}
    },
    {33}
  },
  [101204] = {
    101204,
    2,
    "MoviePath101/202",
    nil,
    "str_movie_item_name_101204",
    "str_movie_item_intro_101204",
    {
      {5273013, 2},
      {5273014, 0},
      {5273015, 1}
    }
  },
  [101205] = {
    101205,
    2,
    "MoviePath101/203",
    nil,
    "str_movie_item_name_101205",
    "str_movie_item_intro_101205",
    {
      {5273016, 2},
      {5273017, 1},
      {5273018, 0}
    }
  },
  [101301] = {
    101301,
    3,
    nil,
    3010101,
    nil,
    nil,
    common[4]
  },
  [101302] = {
    101302,
    3,
    nil,
    3010201,
    nil,
    nil,
    common[4]
  },
  [101303] = {
    101303,
    3,
    nil,
    3010301,
    nil,
    nil,
    common[4]
  },
  [101304] = {
    101304,
    3,
    nil,
    3010401,
    nil,
    nil,
    common[4]
  },
  [101305] = {
    101305,
    3,
    nil,
    3010501,
    nil,
    nil,
    common[4]
  },
  [101306] = {
    101306,
    3,
    nil,
    3010601,
    nil,
    nil,
    common[4]
  },
  [101307] = {
    101307,
    3,
    nil,
    3010701,
    nil,
    nil,
    common[4]
  },
  [101308] = {
    101308,
    3,
    nil,
    3010801,
    nil,
    nil,
    common[4]
  },
  [102101] = {
    102101,
    1,
    "MoviePath102/101",
    nil,
    "str_movie_item_name_102101",
    "str_movie_item_intro_102101",
    {
      {1601191, 2}
    }
  },
  [102102] = {
    102102,
    1,
    "MoviePath102/102",
    nil,
    "str_movie_item_name_102102",
    "str_movie_item_intro_102102",
    {
      {1601661, 2},
      {1600381, 0}
    }
  },
  [102103] = {
    102103,
    1,
    "MoviePath102/103",
    nil,
    "str_movie_item_name_102103",
    "str_movie_item_intro_102103",
    {
      {1601411, 2},
      {1500421, 0}
    }
  },
  [102104] = {
    102104,
    1,
    "MoviePath102/104",
    nil,
    "str_movie_item_name_102104",
    "str_movie_item_intro_102104",
    {
      {1600101, 2},
      {1501321, 0}
    }
  },
  [102201] = {
    102201,
    2,
    nil,
    nil,
    "str_movie_item_name_102201",
    "str_movie_item_intro_102201",
    common[5]
  },
  [102202] = {
    102202,
    2,
    nil,
    nil,
    "str_movie_item_name_102202",
    "str_movie_item_intro_102202",
    common[6]
  },
  [102203] = {
    102203,
    2,
    "MoviePath102/201",
    nil,
    "str_movie_item_name_102203",
    "str_movie_item_intro_102203",
    {
      {5273003, 2}
    },
    {49}
  },
  [102204] = {
    102204,
    2,
    "MoviePath102/202",
    nil,
    "str_movie_item_name_102204",
    "str_movie_item_intro_102204",
    {
      {5273004, 2},
      {5273005, 0},
      {5273006, 1}
    }
  },
  [102205] = {
    102205,
    2,
    "MoviePath102/203",
    nil,
    "str_movie_item_name_102205",
    "str_movie_item_intro_102205",
    {
      {5273007, 2},
      {5273008, 1},
      {5273009, 0}
    }
  },
  [102301] = {
    102301,
    3,
    nil,
    3020101,
    nil,
    nil,
    common[7]
  },
  [102303] = {
    102303,
    3,
    nil,
    3020301,
    nil,
    nil,
    common[7]
  },
  [102305] = {
    102305,
    3,
    nil,
    3020501,
    nil,
    nil,
    common[7]
  },
  [102307] = {
    102307,
    3,
    nil,
    3020701,
    nil,
    nil,
    common[7]
  },
  [103101] = {
    103101,
    1,
    "MoviePath103/101",
    nil,
    "str_movie_item_name_103101",
    "str_movie_item_intro_103101",
    {
      {1600251, 2}
    }
  },
  [103102] = {
    103102,
    1,
    "MoviePath103/102",
    nil,
    "str_movie_item_name_103102",
    "str_movie_item_intro_103102",
    {
      {1500781, 2}
    }
  },
  [103103] = {
    103103,
    1,
    "MoviePath103/103",
    nil,
    "str_movie_item_name_103103",
    "str_movie_item_intro_103103",
    {
      {1400851, 2},
      {1500551, 0}
    }
  },
  [103104] = {
    103104,
    1,
    "MoviePath103/104",
    nil,
    "str_movie_item_name_103104",
    "str_movie_item_intro_103104",
    {
      {1500761, 2},
      {1600301, 0}
    }
  },
  [103105] = {
    103105,
    1,
    "MoviePath103/105",
    nil,
    "str_movie_item_name_103105",
    "str_movie_item_intro_103105",
    common[8]
  },
  [103201] = {
    103201,
    2,
    nil,
    nil,
    "str_movie_item_name_103201",
    "str_movie_item_intro_103201",
    common[9]
  },
  [103202] = {
    103202,
    2,
    nil,
    nil,
    "str_movie_item_name_103202",
    "str_movie_item_intro_103202",
    common[10]
  },
  [103203] = {
    103203,
    2,
    "MoviePath103/201",
    nil,
    "str_movie_item_name_103203",
    "str_movie_item_intro_103203",
    {
      {5273021, 2}
    },
    {-42}
  },
  [103204] = {
    103204,
    2,
    "MoviePath103/202",
    nil,
    "str_movie_item_name_103204",
    "str_movie_item_intro_103204",
    {
      {5273022, 2},
      {5273023, 1},
      {5273024, 0}
    }
  },
  [103205] = {
    103205,
    2,
    "MoviePath103/203",
    nil,
    "str_movie_item_name_103205",
    "str_movie_item_intro_103205",
    {
      {5273025, 2},
      {5273026, 1},
      {5273027, 0}
    },
    {-144, 32}
  },
  [103301] = {
    103301,
    3,
    nil,
    3030101,
    nil,
    nil,
    common[11]
  },
  [103302] = {
    103302,
    3,
    nil,
    3030201,
    nil,
    nil,
    common[11]
  },
  [104101] = {
    104101,
    1,
    "MoviePath104/101",
    nil,
    "str_movie_item_name_104101",
    "str_movie_item_intro_104101",
    {
      {1601401, 2}
    }
  },
  [104102] = {
    104102,
    1,
    "MoviePath104/102",
    nil,
    "str_movie_item_name_104102",
    "str_movie_item_intro_104102",
    common[1]
  },
  [104103] = {
    104103,
    1,
    "MoviePath104/103",
    nil,
    "str_movie_item_name_104103",
    "str_movie_item_intro_104103",
    {
      {1601381, 2},
      {1501421, 0}
    }
  },
  [104104] = {
    104104,
    1,
    "MoviePath104/104",
    nil,
    "str_movie_item_name_104104",
    "str_movie_item_intro_104104",
    {
      {1601411, 2},
      {1501391, 0}
    }
  },
  [104105] = {
    104105,
    1,
    "MoviePath104/105",
    nil,
    "str_movie_item_name_104105",
    "str_movie_item_intro_104105",
    {
      {1601781, 2},
      {1601261, 0}
    }
  },
  [104201] = {
    104201,
    2,
    nil,
    nil,
    "str_movie_item_name_104201",
    "str_movie_item_intro_104201",
    {
      {5273028, 2},
      {5273037, 1},
      {5273049, 1}
    }
  },
  [104202] = {
    104202,
    2,
    nil,
    nil,
    "str_movie_item_name_104202",
    "str_movie_item_intro_104202",
    {
      {5273029, 2},
      {5273038, 1},
      {5273050, 1}
    }
  },
  [104203] = {
    104203,
    2,
    "MoviePath104/201",
    nil,
    "str_movie_item_name_104203",
    "str_movie_item_intro_104203",
    {
      {5273030, 2}
    }
  },
  [104204] = {
    104204,
    2,
    "MoviePath104/202",
    nil,
    "str_movie_item_name_104204",
    "str_movie_item_intro_104204",
    {
      {5273031, 2},
      {5273032, 0},
      {5273033, 1}
    }
  },
  [104205] = {
    104205,
    2,
    "MoviePath104/203",
    nil,
    "str_movie_item_name_104205",
    "str_movie_item_intro_104205",
    {
      {5273034, 2},
      {5273035, 0},
      {5273036, 1}
    }
  },
  [104301] = {
    104301,
    3,
    nil,
    6010101,
    nil,
    nil,
    common[12]
  },
  [104302] = {
    104302,
    3,
    nil,
    6010102,
    nil,
    nil,
    common[7]
  },
  [104303] = {
    104303,
    3,
    nil,
    6010103,
    nil,
    nil,
    common[13]
  },
  [104304] = {
    104304,
    3,
    nil,
    6010104,
    nil,
    nil,
    common[14]
  },
  [104305] = {
    104305,
    3,
    nil,
    6010201,
    nil,
    nil,
    common[12]
  },
  [104306] = {
    104306,
    3,
    nil,
    6010202,
    nil,
    nil,
    common[7]
  },
  [104307] = {
    104307,
    3,
    nil,
    6010203,
    nil,
    nil,
    common[13]
  },
  [104308] = {
    104308,
    3,
    nil,
    6010204,
    nil,
    nil,
    common[14]
  },
  [104309] = {
    104309,
    3,
    nil,
    6010301,
    nil,
    nil,
    common[12]
  },
  [104310] = {
    104310,
    3,
    nil,
    6010302,
    nil,
    nil,
    common[7]
  },
  [104311] = {
    104311,
    3,
    nil,
    6010303,
    nil,
    nil,
    common[13]
  },
  [104312] = {
    104312,
    3,
    nil,
    6010304,
    nil,
    nil,
    common[14]
  },
  [104313] = {
    104313,
    3,
    nil,
    6010401,
    nil,
    nil,
    common[12]
  },
  [104314] = {
    104314,
    3,
    nil,
    6010402,
    nil,
    nil,
    common[7]
  },
  [104315] = {
    104315,
    3,
    nil,
    6010403,
    nil,
    nil,
    common[13]
  },
  [104316] = {
    104316,
    3,
    nil,
    6010404,
    nil,
    nil,
    common[14]
  },
  [104317] = {
    104317,
    3,
    nil,
    6010501,
    nil,
    nil,
    common[12]
  },
  [104318] = {
    104318,
    3,
    nil,
    6010502,
    nil,
    nil,
    common[7]
  },
  [104319] = {
    104319,
    3,
    nil,
    6010503,
    nil,
    nil,
    common[13]
  },
  [104320] = {
    104320,
    3,
    nil,
    6010504,
    nil,
    nil,
    common[14]
  },
  [104321] = {
    104321,
    3,
    nil,
    6010601,
    nil,
    nil,
    common[12]
  },
  [104322] = {
    104322,
    3,
    nil,
    6010602,
    nil,
    nil,
    common[7]
  },
  [104323] = {
    104323,
    3,
    nil,
    6010603,
    nil,
    nil,
    common[13]
  },
  [104324] = {
    104324,
    3,
    nil,
    6010604,
    nil,
    nil,
    common[14]
  },
  [104325] = {
    104325,
    3,
    nil,
    6010701,
    nil,
    nil,
    common[12]
  },
  [104326] = {
    104326,
    3,
    nil,
    6010702,
    nil,
    nil,
    common[7]
  },
  [104327] = {
    104327,
    3,
    nil,
    6010703,
    nil,
    nil,
    common[13]
  },
  [104328] = {
    104328,
    3,
    nil,
    6010704,
    nil,
    nil,
    common[14]
  },
  [104329] = {
    104329,
    3,
    nil,
    6010801,
    nil,
    nil,
    common[12]
  },
  [104330] = {
    104330,
    3,
    nil,
    6010802,
    nil,
    nil,
    common[7]
  },
  [104331] = {
    104331,
    3,
    nil,
    6010803,
    nil,
    nil,
    common[13]
  },
  [104332] = {
    104332,
    3,
    nil,
    6010804,
    nil,
    nil,
    common[14]
  },
  [105101] = {
    105101,
    1,
    "MoviePath105/101",
    nil,
    "str_movie_item_name_105101",
    "str_movie_item_intro_105101",
    {
      {1501831, 2}
    }
  },
  [105102] = {
    105102,
    1,
    "MoviePath105/102",
    nil,
    "str_movie_item_name_105102",
    "str_movie_item_intro_105102",
    {
      {1601811, 2}
    }
  },
  [105103] = {
    105103,
    1,
    "MoviePath105/103",
    nil,
    "str_movie_item_name_105103",
    "str_movie_item_intro_105103",
    {
      {1601451, 2},
      {1400481, 0}
    }
  },
  [105104] = {
    105104,
    1,
    "MoviePath105/104",
    nil,
    "str_movie_item_name_105104",
    "str_movie_item_intro_105104",
    {
      {1601821, 2},
      {1600251, 0}
    }
  },
  [105105] = {
    105105,
    1,
    "MoviePath105/105",
    nil,
    "str_movie_item_name_105105",
    "str_movie_item_intro_105105",
    {
      {1601751, 2},
      {1600381, 0}
    }
  },
  [105201] = {
    105201,
    2,
    nil,
    nil,
    "str_movie_item_name_105201",
    "str_movie_item_intro_105201",
    {
      {5273028, 1},
      {5273037, 2},
      {5273049, 1}
    }
  },
  [105202] = {
    105202,
    2,
    nil,
    nil,
    "str_movie_item_name_105202",
    "str_movie_item_intro_105202",
    {
      {5273029, 1},
      {5273038, 2},
      {5273050, 1}
    }
  },
  [105203] = {
    105203,
    2,
    "MoviePath105/201",
    nil,
    "str_movie_item_name_105203",
    "str_movie_item_intro_105203",
    {
      {5273039, 2}
    }
  },
  [105204] = {
    105204,
    2,
    "MoviePath105/202",
    nil,
    "str_movie_item_name_105204",
    "str_movie_item_intro_105204",
    {
      {5273040, 2},
      {5273041, 0},
      {5273042, 1}
    }
  },
  [105205] = {
    105205,
    2,
    "MoviePath105/203",
    nil,
    "str_movie_item_name_105205",
    "str_movie_item_intro_105205",
    {
      {5273043, 2},
      {5273044, 1},
      {5273045, 0}
    }
  },
  [105206] = {
    105206,
    2,
    "MoviePath105/204",
    nil,
    "str_movie_item_name_105206",
    "str_movie_item_intro_105206",
    {
      {5273046, 2},
      {5273047, 1},
      {5241008, 0}
    }
  },
  [105301] = {
    105301,
    3,
    nil,
    6020101,
    nil,
    nil,
    common[11]
  },
  [105302] = {
    105302,
    3,
    nil,
    6020201,
    nil,
    nil,
    common[11]
  },
  [105303] = {
    105303,
    3,
    nil,
    6020301,
    nil,
    nil,
    common[11]
  },
  [105304] = {
    105304,
    3,
    nil,
    6020401,
    nil,
    nil,
    common[11]
  },
  [105305] = {
    105305,
    3,
    nil,
    6020501,
    nil,
    nil,
    common[11]
  },
  [105306] = {
    105306,
    3,
    nil,
    6020601,
    nil,
    nil,
    common[11]
  },
  [105307] = {
    105307,
    3,
    nil,
    6020701,
    nil,
    nil,
    common[11]
  },
  [105308] = {
    105308,
    3,
    nil,
    6020801,
    nil,
    nil,
    common[11]
  },
  [106101] = {
    106101,
    1,
    "MoviePath106/101",
    nil,
    "str_movie_item_name_106101",
    "str_movie_item_intro_106101",
    {
      {1601461, 2}
    }
  },
  [106102] = {
    106102,
    1,
    "MoviePath106/102",
    nil,
    "str_movie_item_name_106102",
    "str_movie_item_intro_106102",
    {
      {1600021, 2}
    }
  },
  [106103] = {
    106103,
    1,
    "MoviePath106/103",
    nil,
    "str_movie_item_name_106103",
    "str_movie_item_intro_106103",
    common[8]
  },
  [106104] = {
    106104,
    1,
    "MoviePath106/104",
    nil,
    "str_movie_item_name_106104",
    "str_movie_item_intro_106104",
    {
      {1600301, 2},
      {1600281, 0}
    }
  },
  [106105] = {
    106105,
    1,
    "MoviePath106/105",
    nil,
    "str_movie_item_name_106105",
    "str_movie_item_intro_106105",
    {
      {1501571, 2},
      {1300521, 0}
    }
  },
  [106201] = {
    106201,
    2,
    nil,
    nil,
    "str_movie_item_name_106201",
    "str_movie_item_intro_106201",
    {
      {5273028, 1},
      {5273037, 1},
      {5273049, 2}
    }
  },
  [106202] = {
    106202,
    2,
    nil,
    nil,
    "str_movie_item_name_106202",
    "str_movie_item_intro_106202",
    {
      {5273029, 1},
      {5273038, 1},
      {5273050, 2}
    }
  },
  [106203] = {
    106203,
    2,
    "MoviePath106/201",
    nil,
    "str_movie_item_name_106203",
    "str_movie_item_intro_106203",
    {
      {5273051, 2}
    }
  },
  [106204] = {
    106204,
    2,
    "MoviePath106/202",
    nil,
    "str_movie_item_name_106204",
    "str_movie_item_intro_106204",
    {
      {5273052, 2},
      {5273053, 1},
      {5273054, 0}
    }
  },
  [106205] = {
    106205,
    2,
    "MoviePath106/203",
    nil,
    "str_movie_item_name_106205",
    "str_movie_item_intro_106205",
    {
      {5273055, 2},
      {5273056, 1},
      {5273057, 0}
    }
  },
  [106206] = {
    106206,
    2,
    "MoviePath106/204",
    nil,
    "str_movie_item_name_106206",
    "str_movie_item_intro_106206",
    {
      {5211004, 2},
      {5272008, 1},
      {5273025, 0}
    }
  },
  [106301] = {
    106301,
    3,
    nil,
    6030101,
    nil,
    nil,
    common[7]
  },
  [106302] = {
    106302,
    3,
    nil,
    6030201,
    nil,
    nil,
    common[7]
  },
  [106303] = {
    106303,
    3,
    nil,
    6030301,
    nil,
    nil,
    common[7]
  },
  [106304] = {
    106304,
    3,
    nil,
    6030401,
    nil,
    nil,
    common[7]
  },
  [201101] = {
    201101,
    1,
    "MoviePath201/101",
    nil,
    "str_movie_item_name_201101",
    "str_movie_item_intro_201101",
    {
      {1600771, 2}
    }
  },
  [201102] = {
    201102,
    1,
    "MoviePath201/102",
    nil,
    "str_movie_item_name_201102",
    "str_movie_item_intro_201102",
    {
      {1501321, 2}
    }
  },
  [201103] = {
    201103,
    1,
    "MoviePath201/103",
    nil,
    "str_movie_item_name_201103",
    "str_movie_item_intro_201103",
    {
      {1601161, 2},
      {1601481, 1},
      {1601051, 0}
    }
  },
  [201201] = {
    201201,
    2,
    nil,
    nil,
    "str_movie_item_name_201201",
    "str_movie_item_intro_201201",
    common[5]
  },
  [201202] = {
    201202,
    2,
    nil,
    nil,
    "str_movie_item_name_201202",
    "str_movie_item_intro_201202",
    common[6]
  },
  [202101] = {
    202101,
    1,
    "MoviePath202/101",
    nil,
    "str_movie_item_name_202101",
    "str_movie_item_intro_202101",
    {
      {1500331, 2},
      {1601721, 1},
      {1601731, 0}
    }
  },
  [202201] = {
    202201,
    2,
    nil,
    nil,
    "str_movie_item_name_202201",
    "str_movie_item_intro_202201",
    common[2]
  },
  [202202] = {
    202202,
    2,
    nil,
    nil,
    "str_movie_item_name_202202",
    "str_movie_item_intro_202202",
    common[3]
  },
  [203101] = {
    203101,
    1,
    "MoviePath203/101",
    nil,
    "str_movie_item_name_203101",
    "str_movie_item_intro_203101",
    {
      {1601531, 2}
    }
  },
  [203102] = {
    203102,
    1,
    "MoviePath203/102",
    nil,
    "str_movie_item_name_203102",
    "str_movie_item_intro_203102",
    common[1]
  },
  [203103] = {
    203103,
    1,
    "MoviePath203/103",
    nil,
    "str_movie_item_name_203103",
    "str_movie_item_intro_203103",
    {
      {1601381, 2},
      {1400441, 1},
      {1500421, 0}
    }
  },
  [203201] = {
    203201,
    2,
    nil,
    nil,
    "str_movie_item_name_203201",
    "str_movie_item_intro_203201",
    common[9]
  },
  [203202] = {
    203202,
    2,
    nil,
    nil,
    "str_movie_item_name_203202",
    "str_movie_item_intro_203202",
    common[10]
  }
}
return config, "ID", key
