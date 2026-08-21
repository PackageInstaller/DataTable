local key = {
  ID = 1,
  instancetype = 2,
  condition = 3,
  entrypic = 4,
  bgpic = 5,
  entryname = 6,
  entryresultname = 7,
  resname = 8,
  word = 9,
  voice = 10,
  loopTime = 11,
  dateshow = 12,
  opentime = 13,
  levelids = 14,
  pos = 15,
  spineOffsetScale = 16,
  spinePetID = 17,
  detailpic = 18,
  interactWord = 19
}
local common = {
  {
    1,
    2,
    3,
    4,
    5,
    6,
    0
  },
  "str_res_instance_entry_date_show2",
  "map_ziyuan_hui1"
}
local config = {
  {
    1,
    1,
    4002030,
    "map_ziyuan_tu4",
    "map_ziyuan_bg2",
    "str_res_instance_entry_money_entry_name",
    "str_res_instance_entry_money_entry_result_name",
    "str_res_instance_entry_money_res_name",
    "str_res_instance_entry_detail_word1",
    "8400058|8400059",
    30000,
    common[2],
    common[1],
    {
      101,
      102,
      103,
      104,
      105
    },
    {-243, -137},
    {
      -523,
      -162,
      0.38
    },
    "1500841_spine_idle",
    "map_ziyuan_hui2",
    {
      [1] = {
        word = "str_res_instance_entry_npc01_01",
        voice = 8400060
      },
      [2] = {
        word = "str_res_instance_entry_npc01_02",
        voice = 8400061
      },
      [3] = {
        word = "str_res_instance_entry_npc01_03",
        voice = 8400062
      }
    }
  },
  {
    2,
    2,
    4001110,
    "map_ziyuan_tu3",
    "map_ziyuan_bg3",
    "str_res_instance_entry_exp_entry_name",
    "str_res_instance_entry_exp_entry_result_name",
    "str_res_instance_entry_exp_res_name",
    "str_res_instance_entry_detail_word2",
    "999999|999999",
    30000,
    common[2],
    common[1],
    {
      201,
      202,
      203,
      204,
      205,
      211,
      212,
      213,
      214,
      215,
      221,
      222,
      223,
      224,
      225,
      231,
      232,
      233,
      234,
      235
    },
    {222, 176},
    nil,
    nil,
    common[3],
    {
      [1] = {
        word = "str_res_instance_entry_money_res_name",
        voice = 999999
      },
      [2] = {
        word = "str_res_instance_entry_money_res_name",
        voice = 999999
      },
      [3] = {
        word = "str_res_instance_entry_money_res_name",
        voice = 999999
      }
    }
  },
  {
    3,
    3,
    4002090,
    "map_ziyuan_tu1",
    "map_ziyuan_bg1",
    "str_res_instance_entry_aircraft_entry_name",
    "str_res_instance_entry_aircraft_entry_result_name",
    "str_res_instance_entry_aircraft_res_name",
    "str_res_instance_entry_detail_word3",
    "999999|7500059",
    30000,
    common[2],
    common[1],
    {
      301,
      302,
      303,
      304,
      305
    },
    {-688, 25},
    {
      -457,
      -151,
      1.25
    },
    "1500751_spine_idle",
    common[3],
    {
      [1] = {
        word = "str_res_instance_entry_npc02_01",
        voice = 7500060
      },
      [2] = {
        word = "str_res_instance_entry_npc02_02",
        voice = 7500061
      },
      [3] = {
        word = "str_res_instance_entry_npc02_03",
        voice = 7500062
      }
    }
  },
  {
    4,
    4,
    4004060,
    "map_ziyuan_tu2",
    "map_ziyuan_bg4",
    "str_pet_equip_entry_name",
    "str_pet_equip_entry_result_name",
    "str_pet_equip_res_name",
    "str_res_instance_entry_detail_word4",
    "3800058|3800059",
    30000,
    common[2],
    common[1],
    {
      401,
      402,
      403,
      404,
      405
    },
    {659, -141},
    {
      -656,
      -268,
      0.9
    },
    "1600381_spine_idle",
    "map_ziyuan_hui3",
    {
      [1] = {
        word = "str_res_instance_entry_npc03_01",
        voice = 3800060
      },
      [2] = {
        word = "str_res_instance_entry_npc03_02",
        voice = 3800061
      },
      [3] = {
        word = "str_res_instance_entry_npc03_03",
        voice = 3800062
      }
    }
  }
}
return config, "ID", key
