local key = {
  ID = 1,
  BG = 2,
  Spine = 3,
  RandomChat = 4,
  NormalFace = 5,
  RightFace = 6,
  WrongFace = 7,
  NoTalkChat = 8,
  ChatPos = 9,
  PersonPos = 10,
  Rightchat = 11,
  Wrongchat = 12,
  SpineSize = 13
}
local common = {
  "n29_ts_sushe",
  "Story_norm",
  "Story_surprise",
  "Story_sad",
  "Story_angry",
  "n29_ts_wutai"
}
local config = {
  {
    1,
    common[1],
    "n29_g_baoyuyuan_spine_idle",
    {
      "str_n29_detective_character_random_1",
      "str_n29_detective_character_random_2",
      "str_n29_detective_character_random_3"
    },
    common[2],
    common[3],
    common[4],
    "str_n29_detective_character_notalk_1",
    {-602.0, 338.0},
    {-185.0, -234.0},
    "str_n29_detective_character_rightclue_1",
    "str_n29_detective_character_wrongclue_1",
    0.9688682
  },
  {
    2,
    "n29_dh_zoulang",
    "n29_g_qingjiegong_spine_idle",
    {
      "str_n29_detective_character_random_4",
      "str_n29_detective_character_random_5",
      "str_n29_detective_character_random_6"
    },
    common[2],
    common[3],
    common[5],
    "str_n29_detective_character_notalk_2",
    {-633.0, 339.0},
    {-195.0, -252.0},
    "str_n29_detective_character_rightclue_2",
    "str_n29_detective_character_wrongclue_2",
    0.9688682
  },
  {
    3,
    common[1],
    "n29_g_nvhai_spine_idle",
    {
      "str_n29_detective_character_random_7",
      "str_n29_detective_character_random_8",
      "str_n29_detective_character_random_9"
    },
    common[2],
    common[3],
    common[4],
    "str_n29_detective_character_notalk_3",
    {-593.0, 117.0},
    {-172.0, -215.0},
    "str_n29_detective_character_rightclue_3",
    "str_n29_detective_character_wrongclue_3",
    0.9688682
  },
  {
    4,
    common[6],
    "n29_g_genban_spine_idle",
    {
      "str_n29_detective_character_random_10",
      "str_n29_detective_character_random_11",
      "str_n29_detective_character_random_12"
    },
    common[2],
    common[2],
    common[2],
    "str_n29_detective_character_notalk_4",
    {-623.0, 102.0},
    {-194.0, -231.0},
    nil,
    nil,
    0.9688682
  },
  {
    5,
    common[6],
    "n29_g_huaihaizi_spine_idle",
    {
      "str_n29_detective_character_random_13",
      "str_n29_detective_character_random_14",
      "str_n29_detective_character_random_15"
    },
    common[2],
    common[3],
    common[5],
    "str_n29_detective_character_notalk_5",
    {-598.0, 161.0},
    {-213.0, -175.0},
    "str_n29_detective_character_rightclue_5",
    "str_n29_detective_character_wrongclue_5",
    0.9688682
  },
  {
    6,
    "n29_ts_xiaozhangshi",
    "n29_g_xiaozhang_spine_idle",
    {
      "str_n29_detective_character_random_16",
      "str_n29_detective_character_random_17",
      "str_n29_detective_character_random_18"
    },
    common[2],
    common[2],
    common[2],
    "str_n29_detective_character_notalk_6",
    {-685.0, 345.0},
    {-181.0, -138.0},
    nil,
    nil,
    0.8542705
  },
  {
    7,
    "n29_dh_houmen",
    "n29_g_songhuoshang_spine_idle",
    {
      "str_n29_detective_character_random_19",
      "str_n29_detective_character_random_20",
      "str_n29_detective_character_random_21"
    },
    common[2],
    "Story_laugh",
    common[2],
    "str_n29_detective_character_notalk_7",
    {-685.0, 348.0},
    {-204.0, -126.0},
    "str_n29_detective_character_rightclue_7",
    "str_n29_detective_character_wrongclue_7",
    0.790284
  },
  {
    8,
    "n29_ts_yuanzi",
    "n29_g_gudongshang_spine_idle",
    {
      "str_n29_detective_character_random_22",
      "str_n29_detective_character_random_23",
      "str_n29_detective_character_random_24"
    },
    common[2],
    common[2],
    common[2],
    "str_n29_detective_character_notalk_8",
    {-657.0, 332.0},
    {-182.0, -73.0},
    nil,
    nil,
    0.9688682
  }
}
return config, "ID", key
