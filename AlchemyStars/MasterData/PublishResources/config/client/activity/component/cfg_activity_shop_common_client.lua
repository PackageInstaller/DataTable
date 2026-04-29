local key = {
  ComponentIds = 1,
  NpcName = 2,
  NpcWord = 3,
  NpcSpine = 4,
  CurrencyId = 5,
  SpecialCellWidth = 6,
  NormalCellWidth = 7
}
local common = {
  {1},
  {5},
  {6},
  "1601311_spine_idle",
  "str_n14_shop_npc_name_1",
  "str_n14_shop_npc_word_1",
  "1501471_spine_idle",
  "str_n22_shop_npc_name_1",
  "str_n22_shop_npc_word_1",
  "palake_n22_spine_idle",
  "33hao_n35_spine_idle"
}
local config = {
  [1001] = {
    common[1],
    "str_activity_evesinsa_shop_npc_name_1",
    "str_activity_evesinsa_shop_npc_word_1",
    "1500901_spine_idle",
    3000201,
    400,
    350
  },
  [1003] = {
    common[1],
    "str_activity_summer_i_shop_npc_name_1",
    "str_activity_summer_i_shop_npc_word_1",
    "fulaoersuit_spine_idle",
    3000211,
    400,
    350
  },
  [1010] = {
    common[1],
    "str_activity_n9_shop_npc_name_1",
    "str_activity_n9_shop_npc_word_1",
    common[4],
    3000221,
    380,
    350
  },
  [1017] = {
    common[1],
    "str_n11_shop_npc_name_1",
    "str_n11_shop_npc_word_1",
    common[4],
    3000227,
    312,
    312
  },
  [1022] = {
    common[1],
    common[5],
    common[6],
    common[7],
    3000241,
    312,
    312
  },
  [1026] = {
    common[1],
    "str_activity_n16_shop_npc_name_1",
    "str_activity_n16_shop_npc_word_1",
    "1501521_spine_idle",
    3000245,
    400,
    350
  },
  [1060] = {
    common[2],
    common[5],
    common[6],
    common[7],
    3000253,
    503,
    394
  },
  [1063] = {
    common[2],
    nil,
    nil,
    "1600061_spine_idle",
    3000259,
    312,
    312
  },
  [1068] = {
    common[3],
    common[8],
    common[9],
    common[10],
    3000271,
    616,
    616
  },
  [1069] = {
    common[2],
    nil,
    nil,
    nil,
    3000276,
    403,
    293
  },
  [1076] = {
    common[3],
    "str_n25_shop_npc_name_1",
    "str_n25_shop_npc_word_1",
    common[10],
    3000292,
    616,
    616
  },
  [1080] = {
    common[3],
    common[8],
    common[9],
    common[7],
    3000300,
    616,
    616
  },
  [1084] = {
    common[3],
    "str_n28_shop_npc_name_1",
    "str_n28_shop_npc_word_1",
    "1601861_spine_idle",
    3000307,
    616,
    616
  },
  [1098] = {
    common[2],
    "str_n31_shop_npc_name_1",
    "str_n31_shop_npc_word_1",
    "1602011_spine_idle",
    3000321,
    616,
    616
  },
  [5025] = {
    common[2],
    "str_cn6&n35_shop_npc_name_1",
    "str_cn6&n35_shop_npc_word_1",
    common[11],
    3000338,
    503,
    394
  },
  [5028] = {
    common[2],
    "str_n37_shop_npc_name_1",
    "str_n37_shop_npc_word_1",
    common[11],
    3000344,
    503,
    394
  },
  [5032] = {
    common[2],
    "str_n38_shop_npc_name_1",
    "str_n38_shop_npc_word_1",
    "xuanjidasan_n38_spine_idle",
    3000348,
    616,
    616
  },
  [5039] = {
    common[2],
    "str_n39_shop_npc_name_1",
    "str_n39_shop_npc_word_1",
    "1602181_spine_idle",
    3000349,
    616,
    616
  }
}
return config, "CampaignID", key
