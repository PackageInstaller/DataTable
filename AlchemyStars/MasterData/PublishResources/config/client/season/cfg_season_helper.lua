local key = {
  ID = 1,
  SeasonID = 2,
  Tab = 3,
  OrderInTab = 4,
  Icon = 5,
  Title = 6,
  Desc = 7,
  OpenTime = 8
}
local common = {
  "2024-01-17 09:00:00",
  "2024-03-22 09:00:00",
  "2024-05-15 09:00:00"
}
local config = {
  [101] = {
    101,
    8001,
    1,
    1,
    "help_season_s1_101",
    "str_help_season1_title_101",
    "str_help_season1_disc_101"
  },
  [102] = {
    102,
    8001,
    1,
    2,
    "help_season_s1_102",
    "str_help_season1_title_102",
    "str_help_season1_disc_102"
  },
  [103] = {
    103,
    8001,
    1,
    3,
    "help_season_s1_103",
    "str_help_season1_title_103",
    "str_help_season1_disc_103"
  },
  [104] = {
    104,
    8001,
    1,
    4,
    "help_season_s1_104",
    "str_help_season1_title_104",
    "str_help_season1_disc_104"
  },
  [105] = {
    105,
    8001,
    1,
    5,
    "help_season_s1_105",
    "str_help_season1_title_105",
    "str_help_season1_disc_105"
  },
  [201] = {
    201,
    8001,
    2,
    1,
    "help_season_s1_201",
    "str_help_season1_title_201",
    "str_help_season1_disc_201"
  },
  [202] = {
    202,
    8001,
    2,
    2,
    "help_season_s1_202",
    "str_help_season1_title_202",
    "str_help_season1_disc_202"
  },
  [203] = {
    203,
    8001,
    2,
    3,
    "help_season_s1_203",
    "str_help_season1_title_203",
    "str_help_season1_disc_203"
  },
  [204] = {
    204,
    8001,
    2,
    4,
    "help_season_s1_204",
    "str_help_season1_title_204",
    "str_help_season1_disc_204"
  },
  [205] = {
    205,
    8001,
    2,
    5,
    "help_season_s1_205",
    "str_help_season1_title_205",
    "str_help_season1_disc_205"
  },
  [206] = {
    206,
    8001,
    2,
    6,
    "help_season_s1_206",
    "str_help_season1_title_206",
    "str_help_season1_disc_206"
  },
  [207] = {
    207,
    8001,
    2,
    7,
    "help_season_s1_207",
    "str_help_season1_title_207",
    "str_help_season1_disc_207"
  },
  [208] = {
    208,
    8001,
    2,
    8,
    "help_season_s1_208",
    "str_help_season1_title_208",
    "str_help_season1_disc_208"
  },
  [209] = {
    209,
    8001,
    2,
    9,
    "help_season_s1_209",
    "str_help_season1_title_209",
    "str_help_season1_disc_209"
  },
  [301] = {
    301,
    8001,
    3,
    1,
    "help_season_s1_301",
    "str_help_season1_title_301",
    "str_help_season1_disc_301"
  },
  [302] = {
    302,
    8001,
    3,
    2,
    "help_season_s1_302",
    "str_help_season1_title_302",
    "str_help_season1_disc_302"
  },
  [303] = {
    303,
    8001,
    3,
    3,
    "help_season_s1_303",
    "str_help_season1_title_303",
    "str_help_season1_disc_303"
  },
  [304] = {
    304,
    8001,
    3,
    4,
    "help_season_s1_304",
    "str_help_season1_title_304",
    "str_help_season1_disc_304"
  },
  [305] = {
    305,
    8001,
    3,
    5,
    "help_season_s1_305",
    "str_help_season1_title_305",
    "str_help_season1_disc_305"
  },
  [401] = {
    401,
    8001,
    4,
    1,
    "help_season_s1_401",
    "str_help_season1_title_401",
    "str_help_season1_disc_401"
  },
  [402] = {
    402,
    8001,
    4,
    2,
    "help_season_s1_402",
    "str_help_season1_title_402",
    "str_help_season1_disc_402"
  },
  [403] = {
    403,
    8001,
    4,
    3,
    "help_season_s1_403",
    "str_help_season1_title_403",
    "str_help_season1_disc_403"
  },
  [501] = {
    501,
    8001,
    5,
    1,
    "help_season_s1_501",
    "str_help_season1_title_501",
    "str_help_season1_disc_501"
  },
  [502] = {
    502,
    8001,
    5,
    2,
    "help_season_s1_502",
    "str_help_season1_title_502",
    "str_help_season1_disc_502"
  },
  [503] = {
    503,
    8001,
    5,
    3,
    "help_season_s1_503",
    "str_help_season1_title_503",
    "str_help_season1_disc_503"
  },
  [504] = {
    504,
    8001,
    5,
    4,
    "help_season_s1_504",
    "str_help_season1_title_504",
    "str_help_season1_disc_504"
  },
  [505] = {
    505,
    8001,
    5,
    5,
    "help_season_s1_505",
    "str_help_season1_title_505",
    "str_help_season1_disc_505"
  },
  [2101] = {
    2101,
    8002,
    1,
    1,
    "help_season_s2_101",
    "str_help_season2_title_101",
    "str_help_season2_disc_101"
  },
  [2102] = {
    2102,
    8002,
    1,
    2,
    "help_season_s2_102",
    "str_help_season2_title_102",
    "str_help_season2_disc_102"
  },
  [2103] = {
    2103,
    8002,
    1,
    3,
    "help_season_s2_103",
    "str_help_season2_title_103",
    "str_help_season2_disc_103"
  },
  [2104] = {
    2104,
    8002,
    1,
    4,
    "help_season_s2_104",
    "str_help_season2_title_104",
    "str_help_season2_disc_104"
  },
  [2105] = {
    2105,
    8002,
    1,
    5,
    "help_season_s2_105",
    "str_help_season2_title_105",
    "str_help_season2_disc_105"
  },
  [2106] = {
    2106,
    8002,
    2,
    1,
    "help_season_s2_201",
    "str_help_season2_title_201",
    "str_help_season2_disc_201"
  },
  [2107] = {
    2107,
    8002,
    2,
    2,
    "help_season_s2_202",
    "str_help_season2_title_202",
    "str_help_season2_disc_202"
  },
  [2108] = {
    2108,
    8002,
    2,
    3,
    "help_season_s2_203",
    "str_help_season2_title_203",
    "str_help_season2_disc_203"
  },
  [2109] = {
    2109,
    8002,
    2,
    4,
    "help_season_s2_204",
    "str_help_season2_title_204",
    "str_help_season2_disc_204"
  },
  [2110] = {
    2110,
    8002,
    2,
    5,
    "help_season_s2_205",
    "str_help_season2_title_205",
    "str_help_season2_disc_205"
  },
  [2111] = {
    2111,
    8002,
    2,
    6,
    "help_season_s2_206",
    "str_help_season2_title_206",
    "str_help_season2_disc_206"
  },
  [2112] = {
    2112,
    8002,
    2,
    7,
    "help_season_s2_207",
    "str_help_season2_title_207",
    "str_help_season2_disc_207"
  },
  [2113] = {
    2113,
    8002,
    2,
    8,
    "help_season_s2_208",
    "str_help_season2_title_208",
    "str_help_season2_disc_208"
  },
  [2115] = {
    2115,
    8002,
    3,
    1,
    "help_season_s2_301",
    "str_help_season2_title_301",
    "str_help_season2_disc_301"
  },
  [2116] = {
    2116,
    8002,
    3,
    2,
    "help_season_s2_302",
    "str_help_season2_title_302",
    "str_help_season2_disc_302"
  },
  [2117] = {
    2117,
    8002,
    3,
    3,
    "help_season_s2_303",
    "str_help_season2_title_303",
    "str_help_season2_disc_303"
  },
  [2118] = {
    2118,
    8002,
    3,
    4,
    "help_season_s2_304",
    "str_help_season2_title_304",
    "str_help_season2_disc_304"
  },
  [2119] = {
    2119,
    8002,
    3,
    5,
    "help_season_s2_305",
    "str_help_season2_title_305",
    "str_help_season2_disc_305"
  },
  [2120] = {
    2120,
    8002,
    4,
    1,
    "help_season_s2_401",
    "str_help_season2_title_401",
    "str_help_season2_disc_401"
  },
  [2121] = {
    2121,
    8002,
    4,
    2,
    "help_season_s2_402",
    "str_help_season2_title_402",
    "str_help_season2_disc_402"
  },
  [2122] = {
    2122,
    8002,
    5,
    1,
    "help_season_s2_501",
    "str_help_season2_title_501",
    "str_help_season2_disc_501"
  },
  [2123] = {
    2123,
    8002,
    5,
    2,
    "help_season_s2_502",
    "str_help_season2_title_502",
    "str_help_season2_disc_502"
  },
  [2124] = {
    2124,
    8002,
    5,
    3,
    "help_season_s2_503",
    "str_help_season2_title_503",
    "str_help_season2_disc_503"
  },
  [2125] = {
    2125,
    8002,
    5,
    4,
    "help_season_s2_504",
    "str_help_season2_title_504",
    "str_help_season2_disc_504"
  },
  [3101] = {
    3101,
    8003,
    1,
    1,
    "help_season_s3_101",
    "str_help_season3_title_101",
    "str_help_season3_disc_101"
  },
  [3102] = {
    3102,
    8003,
    1,
    2,
    "help_season_s3_102",
    "str_help_season3_title_102",
    "str_help_season3_disc_102"
  },
  [3103] = {
    3103,
    8003,
    1,
    3,
    "help_season_s3_103",
    "str_help_season3_title_103",
    "str_help_season3_disc_103"
  },
  [3104] = {
    3104,
    8003,
    1,
    4,
    "help_season_s3_104",
    "str_help_season3_title_104",
    "str_help_season3_disc_104"
  },
  [3105] = {
    3105,
    8003,
    1,
    5,
    "help_season_s3_105",
    "str_help_season3_title_105",
    "str_help_season3_disc_105"
  },
  [3201] = {
    3201,
    8003,
    2,
    1,
    "help_season_s3_201",
    "str_help_season3_title_201",
    "str_help_season3_disc_201"
  },
  [3202] = {
    3202,
    8003,
    2,
    2,
    "help_season_s3_202",
    "str_help_season3_title_202",
    "str_help_season3_disc_202"
  },
  [3203] = {
    3203,
    8003,
    2,
    3,
    "help_season_s3_203",
    "str_help_season3_title_203",
    "str_help_season3_disc_203"
  },
  [3204] = {
    3204,
    8003,
    2,
    4,
    "help_season_s3_204",
    "str_help_season3_title_204",
    "str_help_season3_disc_204"
  },
  [3205] = {
    3205,
    8003,
    2,
    5,
    "help_season_s3_205",
    "str_help_season3_title_205",
    "str_help_season3_disc_205"
  },
  [3206] = {
    3206,
    8003,
    2,
    6,
    "help_season_s3_206",
    "str_help_season3_title_206",
    "str_help_season3_disc_206"
  },
  [3207] = {
    3207,
    8003,
    2,
    7,
    "help_season_s3_207",
    "str_help_season3_title_207",
    "str_help_season3_disc_207"
  },
  [3301] = {
    3301,
    8003,
    3,
    1,
    "help_season_s3_301",
    "str_help_season3_title_301",
    "str_help_season3_disc_301"
  },
  [3302] = {
    3302,
    8003,
    3,
    2,
    "help_season_s3_302",
    "str_help_season3_title_302",
    "str_help_season3_disc_302"
  },
  [3303] = {
    3303,
    8003,
    3,
    3,
    "help_season_s3_303",
    "str_help_season3_title_303",
    "str_help_season3_disc_303"
  },
  [3304] = {
    3304,
    8003,
    3,
    4,
    "help_season_s3_304",
    "str_help_season3_title_304",
    "str_help_season3_disc_304"
  },
  [3305] = {
    3305,
    8003,
    3,
    5,
    "help_season_s3_305",
    "str_help_season3_title_305",
    "str_help_season3_disc_305"
  },
  [3401] = {
    3401,
    8003,
    4,
    1,
    "help_season_s3_401",
    "str_help_season3_title_401",
    "str_help_season3_disc_401"
  },
  [3402] = {
    3402,
    8003,
    4,
    2,
    "help_season_s3_402",
    "str_help_season3_title_402",
    "str_help_season3_disc_402"
  },
  [3501] = {
    3501,
    8003,
    5,
    1,
    "help_season_s3_501",
    "str_help_season3_title_501",
    "str_help_season3_disc_501"
  },
  [3502] = {
    3502,
    8003,
    5,
    2,
    "help_season_s3_502",
    "str_help_season3_title_502",
    "str_help_season3_disc_502"
  },
  [3503] = {
    3503,
    8003,
    5,
    3,
    "help_season_s3_503",
    "str_help_season3_title_503",
    "str_help_season3_disc_503"
  },
  [3504] = {
    3504,
    8003,
    5,
    4,
    "help_season_s3_504",
    "str_help_season3_title_504",
    "str_help_season3_disc_504"
  },
  [4101] = {
    4101,
    8004,
    1,
    1,
    "help_season_s4_101",
    "str_help_season4_title_101",
    "str_help_season4_disc_101"
  },
  [4102] = {
    4102,
    8004,
    1,
    2,
    "help_season_s4_102",
    "str_help_season4_title_102",
    "str_help_season4_disc_102"
  },
  [4103] = {
    4103,
    8004,
    1,
    3,
    "help_season_s4_103",
    "str_help_season4_title_103",
    "str_help_season4_disc_103"
  },
  [4104] = {
    4104,
    8004,
    1,
    4,
    "help_season_s4_104",
    "str_help_season4_title_104",
    "str_help_season4_disc_104"
  },
  [4105] = {
    4105,
    8004,
    1,
    5,
    "help_season_s4_105",
    "str_help_season4_title_105",
    "str_help_season4_disc_105"
  },
  [4201] = {
    4201,
    8004,
    2,
    1,
    "help_season_s4_201",
    "str_help_season4_title_201",
    "str_help_season4_disc_201"
  },
  [4202] = {
    4202,
    8004,
    2,
    2,
    "help_season_s4_202",
    "str_help_season4_title_202",
    "str_help_season4_disc_202"
  },
  [4203] = {
    4203,
    8004,
    2,
    3,
    "help_season_s4_203",
    "str_help_season4_title_203",
    "str_help_season4_disc_203"
  },
  [4204] = {
    4204,
    8004,
    2,
    4,
    "help_season_s4_204",
    "str_help_season4_title_204",
    "str_help_season4_disc_204"
  },
  [4205] = {
    4205,
    8004,
    2,
    5,
    "help_season_s4_205",
    "str_help_season4_title_205",
    "str_help_season4_disc_205"
  },
  [4206] = {
    4206,
    8004,
    2,
    6,
    "help_season_s4_206",
    "str_help_season4_title_206",
    "str_help_season4_disc_206"
  },
  [4207] = {
    4207,
    8004,
    2,
    7,
    "help_season_s4_207",
    "str_help_season4_title_207",
    "str_help_season4_disc_207"
  },
  [4208] = {
    4208,
    8004,
    2,
    7,
    "help_season_s4_208",
    "str_help_season4_title_208",
    "str_help_season4_disc_208",
    "2024-02-14 05:00:00"
  },
  [4301] = {
    4301,
    8004,
    3,
    1,
    "help_season_s4_301",
    "str_help_season4_title_301",
    "str_help_season4_disc_301"
  },
  [4302] = {
    4302,
    8004,
    3,
    2,
    "help_season_s4_302",
    "str_help_season4_title_302",
    "str_help_season4_disc_302"
  },
  [4303] = {
    4303,
    8004,
    3,
    3,
    "help_season_s4_303",
    "str_help_season4_title_303",
    "str_help_season4_disc_303"
  },
  [4304] = {
    4304,
    8004,
    3,
    4,
    "help_season_s4_304",
    "str_help_season4_title_304",
    "str_help_season4_disc_304"
  },
  [4305] = {
    4305,
    8004,
    3,
    5,
    "help_season_s4_305",
    "str_help_season4_title_305",
    "str_help_season4_disc_305"
  },
  [4401] = {
    4401,
    8004,
    4,
    1,
    "help_season_s4_401",
    "str_help_season4_title_401",
    "str_help_season4_disc_401"
  },
  [4402] = {
    4402,
    8004,
    4,
    2,
    "help_season_s4_402",
    "str_help_season4_title_402",
    "str_help_season4_disc_402"
  },
  [4501] = {
    4501,
    8004,
    5,
    1,
    "help_season_s4_501",
    "str_help_season4_title_501",
    "str_help_season4_disc_501"
  },
  [4502] = {
    4502,
    8004,
    5,
    2,
    "help_season_s4_502",
    "str_help_season4_title_502",
    "str_help_season4_disc_502"
  },
  [4503] = {
    4503,
    8004,
    5,
    3,
    "help_season_s4_503",
    "str_help_season4_title_503",
    "str_help_season4_disc_503"
  },
  [4601] = {
    4601,
    8004,
    6,
    1,
    "help_season_s4_601",
    "str_help_season4_title_601",
    "str_help_season4_disc_601",
    common[1]
  },
  [4602] = {
    4602,
    8004,
    6,
    2,
    "help_season_s4_602",
    "str_help_season4_title_602",
    "str_help_season4_disc_602",
    common[1]
  },
  [4603] = {
    4603,
    8004,
    6,
    3,
    "help_season_s4_603",
    "str_help_season4_title_603",
    "str_help_season4_disc_603",
    common[1]
  },
  [4604] = {
    4604,
    8004,
    6,
    4,
    "help_season_s4_604",
    "str_help_season4_title_604",
    "str_help_season4_disc_604",
    common[1]
  },
  [4605] = {
    4605,
    8004,
    6,
    5,
    "help_season_s4_605",
    "str_help_season4_title_605",
    "str_help_season4_disc_605",
    common[1]
  },
  [4606] = {
    4606,
    8004,
    6,
    6,
    "help_season_s4_606",
    "str_help_season4_title_606",
    "str_help_season4_disc_606",
    common[1]
  },
  [4607] = {
    4607,
    8004,
    6,
    7,
    "help_season_s4_607",
    "str_help_season4_title_607",
    "str_help_season4_disc_607",
    common[1]
  },
  [4608] = {
    4608,
    8004,
    6,
    8,
    "help_season_s4_608",
    "str_help_season4_title_608",
    "str_help_season4_disc_608",
    common[1]
  },
  [4609] = {
    4609,
    8004,
    6,
    9,
    "help_season_s4_609",
    "str_help_season4_title_609",
    "str_help_season4_disc_609",
    common[1]
  },
  [4701] = {
    4701,
    8004,
    7,
    1,
    "help_season_s4_701",
    "str_help_season4_title_701",
    "str_help_season4_disc_701",
    common[1]
  },
  [4702] = {
    4702,
    8004,
    7,
    2,
    "help_season_s4_702",
    "str_help_season4_title_702",
    "str_help_season4_disc_702",
    common[1]
  },
  [4703] = {
    4703,
    8004,
    7,
    3,
    "help_season_s4_703",
    "str_help_season4_title_703",
    "str_help_season4_disc_703",
    common[1]
  },
  [4704] = {
    4704,
    8004,
    7,
    4,
    "help_season_s4_704",
    "str_help_season4_title_704",
    "str_help_season4_disc_704",
    common[1]
  },
  [4705] = {
    4705,
    8004,
    7,
    5,
    "help_season_s4_705",
    "str_help_season4_title_705",
    "str_help_season4_disc_705",
    common[1]
  },
  [8005101] = {
    8005101,
    8005,
    1,
    1,
    "help_season_s5_101",
    "str_help_season5_title_101",
    "str_help_season5_disc_101"
  },
  [8005102] = {
    8005102,
    8005,
    1,
    2,
    "help_season_s5_102",
    "str_help_season5_title_102",
    "str_help_season5_disc_102"
  },
  [8005103] = {
    8005103,
    8005,
    1,
    3,
    "help_season_s5_103",
    "str_help_season5_title_103",
    "str_help_season5_disc_103"
  },
  [8005104] = {
    8005104,
    8005,
    1,
    4,
    "help_season_s5_104",
    "str_help_season5_title_104",
    "str_help_season5_disc_104"
  },
  [8005105] = {
    8005105,
    8005,
    1,
    5,
    "help_season_s5_105",
    "str_help_season5_title_105",
    "str_help_season5_disc_105"
  },
  [8005201] = {
    8005201,
    8005,
    2,
    1,
    "help_season_s5_201",
    "str_help_season5_title_201",
    "str_help_season5_disc_201"
  },
  [8005202] = {
    8005202,
    8005,
    2,
    2,
    "help_season_s5_202",
    "str_help_season5_title_202",
    "str_help_season5_disc_202"
  },
  [8005203] = {
    8005203,
    8005,
    2,
    3,
    "help_season_s5_203",
    "str_help_season5_title_203",
    "str_help_season5_disc_203"
  },
  [8005204] = {
    8005204,
    8005,
    2,
    4,
    "help_season_s5_204",
    "str_help_season5_title_204",
    "str_help_season5_disc_204"
  },
  [8005205] = {
    8005205,
    8005,
    2,
    5,
    "help_season_s5_205",
    "str_help_season5_title_205",
    "str_help_season5_disc_205"
  },
  [8005206] = {
    8005206,
    8005,
    2,
    6,
    "help_season_s5_206",
    "str_help_season5_title_206",
    "str_help_season5_disc_206"
  },
  [8005301] = {
    8005301,
    8005,
    3,
    1,
    "help_season_s5_301",
    "str_help_season5_title_301",
    "str_help_season5_disc_301"
  },
  [8005302] = {
    8005302,
    8005,
    3,
    2,
    "help_season_s5_302",
    "str_help_season5_title_302",
    "str_help_season5_disc_302"
  },
  [8005303] = {
    8005303,
    8005,
    3,
    3,
    "help_season_s5_303",
    "str_help_season5_title_303",
    "str_help_season5_disc_303"
  },
  [8005304] = {
    8005304,
    8005,
    3,
    4,
    "help_season_s5_304",
    "str_help_season5_title_304",
    "str_help_season5_disc_304"
  },
  [8005305] = {
    8005305,
    8005,
    3,
    5,
    "help_season_s5_305",
    "str_help_season5_title_305",
    "str_help_season5_disc_305"
  },
  [8005401] = {
    8005401,
    8005,
    4,
    1,
    "help_season_s5_401",
    "str_help_season5_title_401",
    "str_help_season5_disc_401"
  },
  [8005402] = {
    8005402,
    8005,
    4,
    2,
    "help_season_s5_402",
    "str_help_season5_title_402",
    "str_help_season5_disc_402"
  },
  [8005501] = {
    8005501,
    8005,
    5,
    1,
    "help_season_s5_501",
    "str_help_season5_title_501",
    "str_help_season5_disc_501"
  },
  [8005502] = {
    8005502,
    8005,
    5,
    2,
    "help_season_s5_502",
    "str_help_season5_title_502",
    "str_help_season5_disc_502"
  },
  [8005503] = {
    8005503,
    8005,
    5,
    3,
    "help_season_s5_503",
    "str_help_season5_title_503",
    "str_help_season5_disc_503"
  },
  [8005601] = {
    8005601,
    8005,
    6,
    1,
    "help_season_s5_601",
    "str_help_season5_title_601",
    "str_help_season5_disc_601",
    common[2]
  },
  [8005602] = {
    8005602,
    8005,
    6,
    2,
    "help_season_s5_602",
    "str_help_season5_title_602",
    "str_help_season5_disc_602",
    common[2]
  },
  [8006101] = {
    8006101,
    8006,
    1,
    1,
    "help_season_s6_101",
    "str_season_s6_help_title_101",
    "str_season_s6_help_disc_101"
  },
  [8006102] = {
    8006102,
    8006,
    1,
    2,
    "help_season_s6_102",
    "str_season_s6_help_title_102",
    "str_season_s6_help_disc_102"
  },
  [8006103] = {
    8006103,
    8006,
    1,
    3,
    "help_season_s6_103",
    "str_season_s6_help_title_103",
    "str_season_s6_help_disc_103"
  },
  [8006104] = {
    8006104,
    8006,
    1,
    4,
    "help_season_s6_104",
    "str_season_s6_help_title_104",
    "str_season_s6_help_disc_104"
  },
  [8006105] = {
    8006105,
    8006,
    1,
    5,
    "help_season_s6_105",
    "str_season_s6_help_title_105",
    "str_season_s6_help_disc_105"
  },
  [8006201] = {
    8006201,
    8006,
    2,
    1,
    "help_season_s6_201",
    "str_season_s6_help_title_201",
    "str_season_s6_help_disc_201"
  },
  [8006202] = {
    8006202,
    8006,
    2,
    2,
    "help_season_s6_202",
    "str_season_s6_help_title_202",
    "str_season_s6_help_disc_202"
  },
  [8006203] = {
    8006203,
    8006,
    2,
    3,
    "help_season_s6_203",
    "str_season_s6_help_title_203",
    "str_season_s6_help_disc_203"
  },
  [8006204] = {
    8006204,
    8006,
    2,
    4,
    "help_season_s6_204",
    "str_season_s6_help_title_204",
    "str_season_s6_help_disc_204"
  },
  [8006205] = {
    8006205,
    8006,
    2,
    5,
    "help_season_s6_205",
    "str_season_s6_help_title_205",
    "str_season_s6_help_disc_205"
  },
  [8006206] = {
    8006206,
    8006,
    2,
    6,
    "help_season_s6_206",
    "str_season_s6_help_title_206",
    "str_season_s6_help_disc_206"
  },
  [8006301] = {
    8006301,
    8006,
    3,
    1,
    "help_season_s6_301",
    "str_season_s6_help_title_301",
    "str_season_s6_help_disc_301"
  },
  [8006302] = {
    8006302,
    8006,
    3,
    2,
    "help_season_s6_302",
    "str_season_s6_help_title_302",
    "str_season_s6_help_disc_302"
  },
  [8006303] = {
    8006303,
    8006,
    3,
    3,
    "help_season_s6_303",
    "str_season_s6_help_title_303",
    "str_season_s6_help_disc_303"
  },
  [8006304] = {
    8006304,
    8006,
    3,
    4,
    "help_season_s6_304",
    "str_season_s6_help_title_304",
    "str_season_s6_help_disc_304"
  },
  [8006305] = {
    8006305,
    8006,
    3,
    5,
    "help_season_s6_305",
    "str_season_s6_help_title_305",
    "str_season_s6_help_disc_305"
  },
  [8006401] = {
    8006401,
    8006,
    4,
    1,
    "help_season_s6_401",
    "str_season_s6_help_title_401",
    "str_season_s6_help_disc_401"
  },
  [8006402] = {
    8006402,
    8006,
    4,
    2,
    "help_season_s6_402",
    "str_season_s6_help_title_402",
    "str_season_s6_help_disc_402"
  },
  [8006501] = {
    8006501,
    8006,
    5,
    1,
    "help_season_s6_501",
    "str_season_s6_help_title_501",
    "str_season_s6_help_disc_501"
  },
  [8006502] = {
    8006502,
    8006,
    5,
    2,
    "help_season_s6_502",
    "str_season_s6_help_title_502",
    "str_season_s6_help_disc_502"
  },
  [8006503] = {
    8006503,
    8006,
    5,
    3,
    "help_season_s6_503",
    "str_season_s6_help_title_503",
    "str_season_s6_help_disc_503"
  },
  [8006601] = {
    8006601,
    8006,
    6,
    1,
    "help_season_s6_601",
    "str_season_s6_help_title_601",
    "str_season_s6_help_disc_601",
    common[3]
  },
  [8006602] = {
    8006602,
    8006,
    6,
    2,
    "help_season_s6_602",
    "str_season_s6_help_title_602",
    "str_season_s6_help_disc_602",
    common[3]
  }
}
return config, "ID", key
