local key = {
  SpecialIcon = 1,
  UseInBigCell = 2,
  UseInSmallCell = 3,
  IsSpecialSkin = 4,
  PosInBigCell = 5,
  SizeInBigCell = 6,
  PosInSmallCell = 7,
  SizeInSmallCell = 8
}
local common = {
  "0|-6.5",
  "225.7|269.1",
  "0|0",
  "15|100",
  "280|280",
  "n16_shop_di07_01",
  "0|133",
  "313|421",
  "316|642"
}
local config = {
  [1501041] = {
    "event_eve_tu5",
    true,
    true,
    false,
    "0|30.8",
    "364|482",
    common[1],
    common[2]
  },
  [1501131] = {
    "event_summer_tu1",
    true,
    false,
    false,
    common[3],
    "374|760",
    common[1],
    common[2]
  },
  [1501321] = {
    "event_n9_tu1",
    true,
    false,
    false,
    common[3],
    "332|603",
    common[1],
    common[2]
  },
  [1501471] = {
    "n14_shop_itembig2",
    true,
    false,
    false,
    common[4],
    common[5],
    common[1],
    common[2]
  },
  [3220147] = {
    "n14_shop_itembig3",
    true,
    false,
    false,
    common[4],
    common[5],
    common[1],
    common[2]
  },
  [3220152] = {
    "icon_item_3220152",
    true,
    false,
    false,
    "0|95",
    "350|350",
    common[1],
    common[2]
  },
  [1501521] = {
    common[6],
    true,
    false,
    false,
    common[7],
    common[8],
    common[1],
    common[2]
  },
  [1401691] = {
    "n23_shop_itembig1",
    true,
    false,
    true,
    common[3],
    common[9],
    common[1],
    common[2]
  },
  [1501801] = {
    "N44_shop_character2",
    true,
    false,
    true,
    common[3],
    common[9],
    common[1],
    common[2]
  },
  [3220180] = {
    "icon_item_3220180",
    true,
    false,
    false,
    "15|37",
    "220|220",
    common[1],
    common[2]
  },
  [1501831] = {
    "N26_shop_character2",
    true,
    false,
    false,
    "-2|25",
    "201|379",
    common[1],
    common[2]
  },
  [1502031] = {
    "n31_shop_1502031",
    true,
    false,
    false,
    "-5|25",
    "446|706",
    common[1],
    common[2]
  },
  [300338] = {
    common[6],
    true,
    false,
    false,
    common[7],
    common[8],
    common[1],
    common[2]
  },
  [1502131] = {
    "n35_store_role01",
    true,
    false,
    false,
    common[3],
    "280|340",
    common[1],
    common[2]
  },
  [1502201] = {
    "n39_shop_di08",
    true,
    false,
    false,
    common[3],
    "290|290",
    common[1],
    common[2]
  },
  [1502241] = {
    "event_cn12_tu1",
    true,
    false,
    true,
    common[3],
    common[9],
    common[1],
    common[2]
  },
  [1501901] = {
    "event_n42_tu1",
    true,
    false,
    true,
    common[3],
    common[9],
    common[1],
    common[2]
  },
  [1502281] = {
    "event_cn16_tu1",
    true,
    false,
    true,
    common[3],
    common[9],
    common[1],
    common[2]
  },
  [1502001] = {
    "event_cn17_tu1",
    true,
    false,
    true,
    common[3],
    common[9],
    common[1],
    common[2]
  },
  [1502321] = {
    "event_n48_tu1",
    true,
    false,
    true,
    common[3],
    common[9],
    common[1],
    common[2]
  },
  [1502351] = {
    "event_cn20_tu1",
    true,
    false,
    true,
    common[3],
    common[9],
    common[1],
    common[2]
  }
}
return config, "ItemId", key
