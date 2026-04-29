local key = {
  ID = 1,
  Name = 2,
  Type = 3,
  RandProb = 4,
  NodeAreaName = 5,
  RecommendAwaken = 6,
  RecommendLV = 7,
  MonsterCG = 8
}
local common = {
  "boss_2900021_map",
  "boss_2900401_map",
  "boss_2900411_map",
  "boss_2900661_map",
  "boss_2902201_map",
  "boss_2906401_map"
}
local config = {
  [4001010] = {
    4001010,
    "str_waypoint_4001010",
    1,
    10,
    "str_node_area_name_4001010",
    0,
    1
  },
  [4001020] = {
    4001020,
    "str_waypoint_4001020",
    1,
    10,
    "str_node_area_name_4001020",
    0,
    1
  },
  [4001030] = {
    4001030,
    "str_waypoint_4001030",
    1,
    10,
    "str_node_area_name_4001030",
    0,
    1
  },
  [4001045] = {
    4001045,
    "str_waypoint_4001045",
    1,
    10,
    "str_node_area_name_4001045",
    0,
    1
  },
  [4001040] = {
    4001040,
    "str_waypoint_4001040",
    1,
    10,
    "str_node_area_name_4001040",
    0,
    2
  },
  [4001041] = {
    4001041,
    "str_waypoint_4001041",
    1,
    10,
    "str_node_area_name_4001041",
    0,
    1
  },
  [4001050] = {
    4001050,
    "str_waypoint_4001050",
    1,
    10,
    "str_node_area_name_4001050",
    0,
    2
  },
  [4001051] = {
    4001051,
    "str_waypoint_4001051",
    1,
    10,
    "str_node_area_name_4001051",
    0,
    1
  },
  [4001060] = {
    4001060,
    "str_waypoint_4001060",
    1,
    10,
    "str_node_area_name_4001060",
    0,
    1
  },
  [4001070] = {
    4001070,
    "str_waypoint_4001070",
    1,
    10,
    "str_node_area_name_4001070",
    0,
    3,
    "boss_2900201_map"
  },
  [4001095] = {
    4001095,
    "str_waypoint_4001095",
    1,
    10,
    "str_node_area_name_4001095",
    0,
    1
  },
  [4001080] = {
    4001080,
    "str_waypoint_4001080",
    1,
    10,
    "str_node_area_name_4001080",
    0,
    4
  },
  [4001090] = {
    4001090,
    "str_waypoint_4001090",
    1,
    10,
    "str_node_area_name_4001090",
    0,
    5
  },
  [4001100] = {
    4001100,
    "str_waypoint_4001100",
    1,
    10,
    "str_node_area_name_4001100",
    0,
    5
  },
  [4001101] = {
    4001101,
    "str_waypoint_4001101",
    1,
    10,
    "str_node_area_name_4001101",
    0,
    5
  },
  [4001110] = {
    4001110,
    "str_waypoint_4001110",
    1,
    10,
    "str_node_area_name_4001110",
    0,
    6
  },
  [4001120] = {
    4001120,
    "str_waypoint_4001120",
    1,
    10,
    "str_node_area_name_4001120",
    0,
    15
  },
  [4001130] = {
    4001130,
    "str_waypoint_4001130",
    1,
    10,
    "str_node_area_name_4001130",
    0,
    15,
    common[1]
  },
  [4002015] = {
    4002015,
    "str_waypoint_4002015",
    1,
    10,
    "str_node_area_name_4002015",
    0,
    1
  },
  [4002010] = {
    4002010,
    "str_waypoint_4002010",
    1,
    10,
    "str_node_area_name_4002010",
    0,
    15
  },
  [4002035] = {
    4002035,
    "str_waypoint_4002035",
    1,
    10,
    "str_node_area_name_4002035",
    0,
    1
  },
  [4002020] = {
    4002020,
    "str_waypoint_4002020",
    1,
    10,
    "str_node_area_name_4002020",
    0,
    15
  },
  [4002030] = {
    4002030,
    "str_waypoint_4002030",
    1,
    10,
    "str_node_area_name_4002030",
    0,
    16
  },
  [4002031] = {
    4002031,
    "str_waypoint_4002031",
    1,
    10,
    "str_node_area_name_4002031",
    0,
    16
  },
  [4002040] = {
    4002040,
    "str_waypoint_4002040",
    1,
    10,
    "str_node_area_name_4002040",
    0,
    17
  },
  [4002050] = {
    4002050,
    "str_waypoint_4002050",
    1,
    10,
    "str_node_area_name_4002050",
    0,
    18
  },
  [4002060] = {
    4002060,
    "str_waypoint_4002060",
    1,
    10,
    "str_node_area_name_4002060",
    0,
    20,
    "boss_2900211_map"
  },
  [4002095] = {
    4002095,
    "str_waypoint_4002095",
    1,
    10,
    "str_node_area_name_4002095",
    0,
    1
  },
  [4002070] = {
    4002070,
    "str_waypoint_4002070",
    1,
    10,
    "str_node_area_name_4002070",
    0,
    21
  },
  [4002080] = {
    4002080,
    "str_waypoint_4002080",
    1,
    10,
    "str_node_area_name_4002080",
    0,
    22
  },
  [4002090] = {
    4002090,
    "str_waypoint_4002090",
    1,
    10,
    "str_node_area_name_4002090",
    0,
    23
  },
  [4002100] = {
    4002100,
    "str_waypoint_4002100",
    1,
    10,
    "str_node_area_name_4002100",
    0,
    24
  },
  [4002101] = {
    4002101,
    "str_waypoint_4002101",
    1,
    10,
    "str_node_area_name_4002101",
    0,
    25
  },
  [4002110] = {
    4002110,
    "str_waypoint_4002110",
    1,
    10,
    "str_node_area_name_4002110",
    0,
    26
  },
  [4002120] = {
    4002120,
    "str_waypoint_4002120",
    1,
    10,
    "str_node_area_name_4002120",
    0,
    27,
    common[1]
  },
  [4003015] = {
    4003015,
    "str_waypoint_4003015",
    1,
    10,
    "str_node_area_name_4003015",
    0,
    1
  },
  [4003010] = {
    4003010,
    "str_waypoint_4003010",
    1,
    10,
    "str_node_area_name_4003010",
    0,
    28
  },
  [4003020] = {
    4003020,
    "str_waypoint_4003020",
    1,
    10,
    "str_node_area_name_4003020",
    0,
    29
  },
  [4003030] = {
    4003030,
    "str_waypoint_4003030",
    1,
    10,
    "str_node_area_name_4003030",
    0,
    30
  },
  [4003031] = {
    4003031,
    "str_waypoint_4003031",
    1,
    10,
    "str_node_area_name_4003031",
    1,
    1
  },
  [4003040] = {
    4003040,
    "str_waypoint_4003040",
    1,
    10,
    "str_node_area_name_4003040",
    1,
    1
  },
  [4003050] = {
    4003050,
    "str_waypoint_4003050",
    1,
    10,
    "str_node_area_name_4003050",
    1,
    2
  },
  [4003060] = {
    4003060,
    "str_waypoint_4003060",
    1,
    10,
    "str_node_area_name_4003060",
    1,
    3,
    "boss_2900231_map"
  },
  [4003070] = {
    4003070,
    "str_waypoint_4003070",
    1,
    10,
    "str_node_area_name_4003070",
    1,
    4
  },
  [4003080] = {
    4003080,
    "str_waypoint_4003080",
    1,
    10,
    "str_node_area_name_4003080",
    1,
    5
  },
  [4003090] = {
    4003090,
    "str_waypoint_4003090",
    1,
    10,
    "str_node_area_name_4003090",
    1,
    6
  },
  [4003100] = {
    4003100,
    "str_waypoint_4003100",
    1,
    10,
    "str_node_area_name_4003100",
    1,
    7
  },
  [4003091] = {
    4003091,
    "str_waypoint_4003091",
    1,
    10,
    "str_node_area_name_4003091",
    1,
    7
  },
  [4003110] = {
    4003110,
    "str_waypoint_4003110",
    1,
    10,
    "str_node_area_name_4003110",
    1,
    8
  },
  [4003120] = {
    4003120,
    "str_waypoint_4003120",
    1,
    10,
    "str_node_area_name_4003120",
    1,
    10,
    "boss_2900241_map"
  },
  [4003145] = {
    4003145,
    "str_waypoint_4003145",
    1,
    10,
    "str_node_area_name_4003145",
    0,
    1
  },
  [4004015] = {
    4004015,
    "str_waypoint_4004015",
    1,
    10,
    "str_node_area_name_4004015",
    0,
    1
  },
  [4004010] = {
    4004010,
    "str_waypoint_4004010",
    1,
    10,
    "str_node_area_name_4004010",
    1,
    11
  },
  [4004020] = {
    4004020,
    "str_waypoint_4004020",
    1,
    10,
    "str_node_area_name_4004020",
    1,
    11
  },
  [4004030] = {
    4004030,
    "str_waypoint_4004030",
    1,
    10,
    "str_node_area_name_4004030",
    1,
    12
  },
  [4004031] = {
    4004031,
    "str_waypoint_4004031",
    1,
    10,
    "str_node_area_name_4004031",
    1,
    12
  },
  [4004040] = {
    4004040,
    "str_waypoint_4004040",
    1,
    10,
    "str_node_area_name_4004040",
    1,
    13
  },
  [4004050] = {
    4004050,
    "str_waypoint_4004050",
    1,
    10,
    "str_node_area_name_4004050",
    1,
    13
  },
  [4004060] = {
    4004060,
    "str_waypoint_4004060",
    1,
    10,
    "str_node_area_name_4004060",
    1,
    14,
    "boss_2900181_map"
  },
  [4004085] = {
    4004085,
    "str_waypoint_4004085",
    1,
    10,
    "str_node_area_name_4004085",
    0,
    1
  },
  [4004070] = {
    4004070,
    "str_waypoint_4004070",
    1,
    10,
    "str_node_area_name_4004070",
    1,
    15
  },
  [4004080] = {
    4004080,
    "str_waypoint_4004080",
    1,
    10,
    "str_node_area_name_4004080",
    1,
    15
  },
  [4004090] = {
    4004090,
    "str_waypoint_4004090",
    1,
    10,
    "str_node_area_name_4004090",
    1,
    16
  },
  [4004091] = {
    4004091,
    "str_waypoint_4004091",
    1,
    10,
    "str_node_area_name_4004091",
    1,
    16
  },
  [4004100] = {
    4004100,
    "str_waypoint_4004100",
    1,
    10,
    "str_node_area_name_4004100",
    1,
    17
  },
  [4004110] = {
    4004110,
    "str_waypoint_4004110",
    1,
    10,
    "str_node_area_name_4004110",
    1,
    17
  },
  [4004120] = {
    4004120,
    "str_waypoint_4004120",
    1,
    10,
    "str_node_area_name_4004120",
    1,
    18,
    "boss_2900221_map"
  },
  [4005015] = {
    4005015,
    "str_waypoint_4005015",
    1,
    10,
    "str_node_area_name_4005015",
    0,
    1
  },
  [4005010] = {
    4005010,
    "str_waypoint_4005010",
    1,
    10,
    "str_node_area_name_4005010",
    1,
    19
  },
  [4005020] = {
    4005020,
    "str_waypoint_4005020",
    1,
    10,
    "str_node_area_name_4005020",
    1,
    19
  },
  [4005030] = {
    4005030,
    "str_waypoint_4005030",
    1,
    10,
    "str_node_area_name_4005030",
    1,
    20
  },
  [4005031] = {
    4005031,
    "str_waypoint_4005031",
    1,
    10,
    "str_node_area_name_4005031",
    1,
    20
  },
  [4005040] = {
    4005040,
    "str_waypoint_4005040",
    1,
    10,
    "str_node_area_name_4005040",
    1,
    21
  },
  [4005050] = {
    4005050,
    "str_waypoint_4005050",
    1,
    10,
    "str_node_area_name_4005050",
    1,
    21
  },
  [4005060] = {
    4005060,
    "str_waypoint_4005060",
    1,
    10,
    "str_node_area_name_4005060",
    1,
    22,
    common[2]
  },
  [4005070] = {
    4005070,
    "str_waypoint_4005070",
    1,
    10,
    "str_node_area_name_4005070",
    1,
    22
  },
  [4005080] = {
    4005080,
    "str_waypoint_4005080",
    1,
    10,
    "str_node_area_name_4005080",
    1,
    23
  },
  [4005090] = {
    4005090,
    "str_waypoint_4005090",
    1,
    10,
    "str_node_area_name_4005090",
    1,
    23
  },
  [4005091] = {
    4005091,
    "str_waypoint_4005091",
    1,
    10,
    "str_node_area_name_4005091",
    1,
    23
  },
  [4005100] = {
    4005100,
    "str_waypoint_4005100",
    1,
    10,
    "str_node_area_name_4005100",
    1,
    24
  },
  [4005110] = {
    4005110,
    "str_waypoint_4005110",
    1,
    10,
    "str_node_area_name_4005110",
    1,
    24
  },
  [4005120] = {
    4005120,
    "str_waypoint_4005120",
    1,
    10,
    "str_node_area_name_4005120",
    1,
    25,
    common[2]
  },
  [4006015] = {
    4006015,
    "str_waypoint_4006015",
    1,
    10,
    "str_node_area_name_4006015",
    0,
    1
  },
  [4006010] = {
    4006010,
    "str_waypoint_4006010",
    1,
    10,
    "str_node_area_name_4006010",
    1,
    26
  },
  [4006020] = {
    4006020,
    "str_waypoint_4006020",
    1,
    10,
    "str_node_area_name_4006020",
    1,
    26
  },
  [4006030] = {
    4006030,
    "str_waypoint_4006030",
    1,
    10,
    "str_node_area_name_4006030",
    1,
    27
  },
  [4006031] = {
    4006031,
    "str_waypoint_4006031",
    1,
    10,
    "str_node_area_name_4006031",
    1,
    27
  },
  [4006040] = {
    4006040,
    "str_waypoint_4006040",
    1,
    10,
    "str_node_area_name_4006040",
    1,
    28
  },
  [4006050] = {
    4006050,
    "str_waypoint_4006050",
    1,
    10,
    "str_node_area_name_4006050",
    1,
    28
  },
  [4006060] = {
    4006060,
    "str_waypoint_4006060",
    1,
    10,
    "str_node_area_name_4006060",
    1,
    29,
    common[3]
  },
  [4006085] = {
    4006085,
    "str_waypoint_4006085",
    1,
    10,
    "str_node_area_name_4006085",
    0,
    1
  },
  [4006070] = {
    4006070,
    "str_waypoint_4006070",
    1,
    10,
    "str_node_area_name_4006070",
    1,
    30
  },
  [4006080] = {
    4006080,
    "str_waypoint_4006080",
    1,
    10,
    "str_node_area_name_4006080",
    1,
    30
  },
  [4006090] = {
    4006090,
    "str_waypoint_4006090",
    1,
    10,
    "str_node_area_name_4006090",
    1,
    31
  },
  [4006091] = {
    4006091,
    "str_waypoint_4006091",
    1,
    10,
    "str_node_area_name_4006091",
    1,
    31
  },
  [4006100] = {
    4006100,
    "str_waypoint_4006100",
    1,
    10,
    "str_node_area_name_4006100",
    1,
    32
  },
  [4006110] = {
    4006110,
    "str_waypoint_4006110",
    1,
    10,
    "str_node_area_name_4006110",
    1,
    32
  },
  [4006120] = {
    4006120,
    "str_waypoint_4006120",
    1,
    10,
    "str_node_area_name_4006120",
    1,
    33,
    "boss_2900421_map"
  },
  [4007015] = {
    4007015,
    "str_waypoint_4007015",
    1,
    10,
    "str_node_area_name_4007015",
    0,
    1
  },
  [4007010] = {
    4007010,
    "str_waypoint_4007010",
    1,
    10,
    "str_node_area_name_4007010",
    1,
    34
  },
  [4007020] = {
    4007020,
    "str_waypoint_4007020",
    1,
    10,
    "str_node_area_name_4007020",
    1,
    34
  },
  [4007030] = {
    4007030,
    "str_waypoint_4007030",
    1,
    10,
    "str_node_area_name_4007030",
    1,
    35
  },
  [4007031] = {
    4007031,
    "str_waypoint_4007031",
    1,
    10,
    "str_node_area_name_4007031",
    1,
    35
  },
  [4007040] = {
    4007040,
    "str_waypoint_4007040",
    1,
    10,
    "str_node_area_name_4007040",
    1,
    36
  },
  [4007050] = {
    4007050,
    "str_waypoint_4007050",
    1,
    10,
    "str_node_area_name_4007050",
    1,
    36
  },
  [4007060] = {
    4007060,
    "str_waypoint_4007060",
    1,
    10,
    "str_node_area_name_4007060",
    1,
    37,
    "boss_2900431_map"
  },
  [4007085] = {
    4007085,
    "str_waypoint_4007085",
    1,
    10,
    "str_node_area_name_4007085",
    0,
    1
  },
  [4007070] = {
    4007070,
    "str_waypoint_4007070",
    1,
    10,
    "str_node_area_name_4007070",
    1,
    38
  },
  [4007080] = {
    4007080,
    "str_waypoint_4007080",
    1,
    10,
    "str_node_area_name_4007080",
    1,
    38
  },
  [4007090] = {
    4007090,
    "str_waypoint_4007090",
    1,
    10,
    "str_node_area_name_4007090",
    1,
    39
  },
  [4007100] = {
    4007100,
    "str_waypoint_4007100",
    1,
    10,
    "str_node_area_name_4007100",
    1,
    39
  },
  [4007110] = {
    4007110,
    "str_waypoint_4007110",
    1,
    10,
    "str_node_area_name_4007110",
    1,
    40
  },
  [4007111] = {
    4007111,
    "str_waypoint_4007111",
    1,
    10,
    "str_node_area_name_4007111",
    1,
    40
  },
  [4007120] = {
    4007120,
    "str_waypoint_4007120",
    1,
    10,
    "str_node_area_name_4007120",
    2,
    1,
    common[2]
  },
  [4008015] = {
    4008015,
    "str_waypoint_4008015",
    1,
    10,
    "str_node_area_name_4008015",
    0,
    1
  },
  [4008020] = {
    4008020,
    "str_waypoint_4008020",
    1,
    10,
    "str_node_area_name_4008020",
    2,
    2
  },
  [4008030] = {
    4008030,
    "str_waypoint_4008030",
    1,
    10,
    "str_node_area_name_4008030",
    2,
    5
  },
  [4008040] = {
    4008040,
    "str_waypoint_4008040",
    1,
    10,
    "str_node_area_name_4008040",
    2,
    8
  },
  [4008041] = {
    4008041,
    "str_waypoint_4008041",
    1,
    10,
    "str_node_area_name_4008041",
    2,
    8
  },
  [4008050] = {
    4008050,
    "str_waypoint_4008050",
    1,
    10,
    "str_node_area_name_4008050",
    2,
    11
  },
  [4008060] = {
    4008060,
    "str_waypoint_4008060",
    1,
    10,
    "str_node_area_name_4008060",
    2,
    14
  },
  [4008070] = {
    4008070,
    "str_waypoint_4008070",
    1,
    10,
    "str_node_area_name_4008070",
    2,
    17,
    "boss_2900601_map"
  },
  [4008085] = {
    4008085,
    "str_waypoint_4008085",
    1,
    10,
    "str_node_area_name_4008085",
    0,
    1
  },
  [4008090] = {
    4008090,
    "str_waypoint_4008090",
    1,
    10,
    "str_node_area_name_4008090",
    2,
    20
  },
  [4008100] = {
    4008100,
    "str_waypoint_4008100",
    1,
    10,
    "str_node_area_name_4008100",
    2,
    23
  },
  [4008110] = {
    4008110,
    "str_waypoint_4008110",
    1,
    10,
    "str_node_area_name_4008110",
    2,
    26
  },
  [4008111] = {
    4008111,
    "str_waypoint_4008111",
    1,
    10,
    "str_node_area_name_4008111",
    2,
    26
  },
  [4008120] = {
    4008120,
    "str_waypoint_4008120",
    1,
    10,
    "str_node_area_name_4008120",
    2,
    29
  },
  [4008130] = {
    4008130,
    "str_waypoint_4008130",
    1,
    10,
    "str_node_area_name_4008130",
    2,
    32
  },
  [4008140] = {
    4008140,
    "str_waypoint_4008140",
    1,
    10,
    "str_node_area_name_4008140",
    2,
    35,
    "boss_2900611_map"
  },
  [4008155] = {
    4008155,
    "str_waypoint_4008155",
    1,
    10,
    "str_node_area_name_4008155",
    0,
    1
  },
  [4009015] = {
    4009015,
    "str_waypoint_4009015",
    1,
    10,
    "str_node_area_name_4009015",
    0,
    1
  },
  [4009020] = {
    4009020,
    "str_waypoint_4009020",
    1,
    10,
    "str_node_area_name_4009020",
    2,
    36
  },
  [4009030] = {
    4009030,
    "str_waypoint_4009030",
    1,
    10,
    "str_node_area_name_4009030",
    2,
    37
  },
  [4009040] = {
    4009040,
    "str_waypoint_4009040",
    1,
    10,
    "str_node_area_name_4009040",
    2,
    38
  },
  [4009041] = {
    4009041,
    "str_waypoint_4009041",
    1,
    10,
    "str_node_area_name_4009041",
    2,
    38
  },
  [4009050] = {
    4009050,
    "str_waypoint_4009050",
    1,
    10,
    "str_node_area_name_4009050",
    2,
    39
  },
  [4009060] = {
    4009060,
    "str_waypoint_4009060",
    1,
    10,
    "str_node_area_name_4009060",
    2,
    40
  },
  [4009070] = {
    4009070,
    "str_waypoint_4009070",
    1,
    10,
    "str_node_area_name_4009070",
    2,
    42,
    "boss_2900641_map"
  },
  [4009085] = {
    4009085,
    "str_waypoint_4009085",
    1,
    10,
    "str_node_area_name_4009085",
    0,
    1
  },
  [4009090] = {
    4009090,
    "str_waypoint_4009090",
    1,
    10,
    "str_node_area_name_4009090",
    2,
    43
  },
  [4009100] = {
    4009100,
    "str_waypoint_4009100",
    1,
    10,
    "str_node_area_name_4009100",
    2,
    44
  },
  [4009110] = {
    4009110,
    "str_waypoint_4009110",
    1,
    10,
    "str_node_area_name_4009110",
    2,
    45
  },
  [4009111] = {
    4009111,
    "str_waypoint_4009111",
    1,
    10,
    "str_node_area_name_4009111",
    2,
    45
  },
  [4009120] = {
    4009120,
    "str_waypoint_4009120",
    1,
    10,
    "str_node_area_name_4009120",
    2,
    46
  },
  [4009130] = {
    4009130,
    "str_waypoint_4009130",
    1,
    10,
    "str_node_area_name_4009130",
    2,
    47
  },
  [4009140] = {
    4009140,
    "str_waypoint_4009140",
    1,
    10,
    "str_node_area_name_4009140",
    2,
    50,
    "boss_2900651_map"
  },
  [4010015] = {
    4010015,
    "str_waypoint_4010015",
    1,
    10,
    "str_node_area_name_4010015",
    0,
    1
  },
  [4010020] = {
    4010020,
    "str_waypoint_4010020",
    1,
    10,
    "str_node_area_name_4010020",
    3,
    1
  },
  [4010030] = {
    4010030,
    "str_waypoint_4010030",
    1,
    10,
    "str_node_area_name_4010030",
    3,
    2
  },
  [4010040] = {
    4010040,
    "str_waypoint_4010040",
    1,
    10,
    "str_node_area_name_4010040",
    3,
    3
  },
  [4010041] = {
    4010041,
    "str_waypoint_4010041",
    1,
    10,
    "str_node_area_name_4010041",
    3,
    3
  },
  [4010050] = {
    4010050,
    "str_waypoint_4010050",
    1,
    10,
    "str_node_area_name_4010050",
    3,
    4
  },
  [4010060] = {
    4010060,
    "str_waypoint_4010060",
    1,
    10,
    "str_node_area_name_4010060",
    3,
    5
  },
  [4010070] = {
    4010070,
    "str_waypoint_4010070",
    1,
    10,
    "str_node_area_name_4010070",
    3,
    7,
    common[4]
  },
  [4010085] = {
    4010085,
    "str_waypoint_4010085",
    1,
    10,
    "str_node_area_name_4010085",
    0,
    1
  },
  [4010090] = {
    4010090,
    "str_waypoint_4010090",
    1,
    10,
    "str_node_area_name_4010090",
    3,
    8
  },
  [4010100] = {
    4010100,
    "str_waypoint_4010100",
    1,
    10,
    "str_node_area_name_4010100",
    3,
    9
  },
  [4010110] = {
    4010110,
    "str_waypoint_4010110",
    1,
    10,
    "str_node_area_name_4010110",
    3,
    10
  },
  [4010111] = {
    4010111,
    "str_waypoint_4010111",
    1,
    10,
    "str_node_area_name_4010111",
    3,
    10
  },
  [4010120] = {
    4010120,
    "str_waypoint_4010120",
    1,
    10,
    "str_node_area_name_4010120",
    3,
    11
  },
  [4010130] = {
    4010130,
    "str_waypoint_4010130",
    1,
    10,
    "str_node_area_name_4010130",
    3,
    12
  },
  [4010140] = {
    4010140,
    "str_waypoint_4010140",
    1,
    10,
    "str_node_area_name_4010140",
    3,
    15,
    "boss_2900671_map"
  },
  [4010155] = {
    4010155,
    "str_waypoint_4010155",
    1,
    10,
    "str_node_area_name_4010155",
    3,
    1
  },
  [4101015] = {
    4101015,
    "str_waypoint_4101015",
    1,
    10,
    "str_node_area_name_4101015",
    2,
    30
  },
  [4101020] = {
    4101020,
    "str_waypoint_4101020",
    1,
    10,
    "str_node_area_name_4101020",
    2,
    30
  },
  [4101030] = {
    4101030,
    "str_waypoint_4101030",
    1,
    10,
    "str_node_area_name_4101030",
    3,
    13
  },
  [4101040] = {
    4101040,
    "str_waypoint_4101040",
    1,
    10,
    "str_node_area_name_4101040",
    3,
    16,
    common[5]
  },
  [4101055] = {
    4101055,
    "str_waypoint_4101055",
    1,
    10,
    "str_node_area_name_4101055",
    3,
    16
  },
  [4101060] = {
    4101060,
    "str_waypoint_4101060",
    1,
    10,
    "str_node_area_name_4101060",
    3,
    20
  },
  [4101070] = {
    4101070,
    "str_waypoint_4101070",
    1,
    10,
    "str_node_area_name_4101070",
    3,
    23
  },
  [4101080] = {
    4101080,
    "str_waypoint_4101080",
    1,
    10,
    "str_node_area_name_4101080",
    3,
    26
  },
  [4101090] = {
    4101090,
    "str_waypoint_4101090",
    1,
    10,
    "str_node_area_name_4101090",
    3,
    30,
    common[5]
  },
  [4101105] = {
    4101105,
    "str_waypoint_4101105",
    1,
    10,
    "str_node_area_name_4101105",
    3,
    30
  },
  [4201015] = {
    4201015,
    "str_waypoint_4201015",
    1,
    10,
    "str_node_area_name_4201015",
    0,
    1
  },
  [4201020] = {
    4201020,
    "str_waypoint_4201020",
    1,
    10,
    "str_node_area_name_4201020",
    3,
    10
  },
  [4201030] = {
    4201030,
    "str_waypoint_4201030",
    1,
    10,
    "str_node_area_name_4201030",
    3,
    12
  },
  [4201040] = {
    4201040,
    "str_waypoint_4201040",
    1,
    10,
    "str_node_area_name_4201040",
    3,
    15
  },
  [4201041] = {
    4201041,
    "str_waypoint_4201041",
    1,
    10,
    "str_node_area_name_4201041",
    3,
    15
  },
  [4201050] = {
    4201050,
    "str_waypoint_4201050",
    1,
    10,
    "str_node_area_name_4201050",
    3,
    17
  },
  [4201060] = {
    4201060,
    "str_waypoint_4201060",
    1,
    10,
    "str_node_area_name_4201060",
    3,
    20
  },
  [4201061] = {
    4201061,
    "str_waypoint_4201061",
    1,
    10,
    "str_node_area_name_4201061",
    3,
    20
  },
  [4201070] = {
    4201070,
    "str_waypoint_4201070",
    1,
    10,
    "str_node_area_name_4201070",
    3,
    22
  },
  [4201080] = {
    4201080,
    "str_waypoint_4201080",
    1,
    10,
    "str_node_area_name_4201080",
    3,
    25
  },
  [4201090] = {
    4201090,
    "str_waypoint_4201090",
    1,
    10,
    "str_node_area_name_4201090",
    3,
    25,
    "boss_2902602_map"
  },
  [4201100] = {
    4201100,
    "str_waypoint_4201100",
    1,
    10,
    "str_node_area_name_4201100",
    3,
    27
  },
  [4201115] = {
    4201115,
    "str_waypoint_4201115",
    1,
    10,
    "str_node_area_name_4201115",
    0,
    1
  },
  [4201120] = {
    4201120,
    "str_waypoint_4201120",
    1,
    10,
    "str_node_area_name_4201120",
    3,
    30
  },
  [4201130] = {
    4201130,
    "str_waypoint_4201130",
    1,
    10,
    "str_node_area_name_4201130",
    3,
    32
  },
  [4201140] = {
    4201140,
    "str_waypoint_4201140",
    1,
    10,
    "str_node_area_name_4201140",
    3,
    35,
    "boss_2902301_map"
  },
  [4201155] = {
    4201155,
    "str_waypoint_4201155",
    1,
    10,
    "str_node_area_name_4201155",
    0,
    1
  },
  [4202015] = {
    4202015,
    "str_waypoint_4202015",
    1,
    10,
    "str_node_area_name_4202015",
    0,
    1
  },
  [4202020] = {
    4202020,
    "str_waypoint_4202020",
    1,
    10,
    "str_node_area_name_4202020",
    3,
    35
  },
  [4202030] = {
    4202030,
    "str_waypoint_4202030",
    1,
    10,
    "str_node_area_name_4202030",
    3,
    36
  },
  [4202040] = {
    4202040,
    "str_waypoint_4202040",
    1,
    10,
    "str_node_area_name_4202040",
    3,
    37
  },
  [4202041] = {
    4202041,
    "str_waypoint_4202041",
    1,
    10,
    "str_node_area_name_4202041",
    3,
    37
  },
  [4202050] = {
    4202050,
    "str_waypoint_4202050",
    1,
    10,
    "str_node_area_name_4202050",
    3,
    38
  },
  [4202060] = {
    4202060,
    "str_waypoint_4202060",
    1,
    10,
    "str_node_area_name_4202060",
    3,
    39
  },
  [4202070] = {
    4202070,
    "str_waypoint_4202070",
    1,
    10,
    "str_node_area_name_4202070",
    3,
    40,
    "boss_2902701_map"
  },
  [4202085] = {
    4202085,
    "str_waypoint_4202085",
    1,
    10,
    "str_node_area_name_4202085",
    0,
    1
  },
  [4202090] = {
    4202090,
    "str_waypoint_4202090",
    1,
    10,
    "str_node_area_name_4202090",
    3,
    40
  },
  [4202100] = {
    4202100,
    "str_waypoint_4202100",
    1,
    10,
    "str_node_area_name_4202100",
    3,
    42
  },
  [4202110] = {
    4202110,
    "str_waypoint_4202110",
    1,
    10,
    "str_node_area_name_4202110",
    3,
    44
  },
  [4202111] = {
    4202111,
    "str_waypoint_4202111",
    1,
    10,
    "str_node_area_name_4202111",
    3,
    44
  },
  [4202120] = {
    4202120,
    "str_waypoint_4202120",
    1,
    10,
    "str_node_area_name_4202120",
    3,
    46
  },
  [4202130] = {
    4202130,
    "str_waypoint_4202130",
    1,
    10,
    "str_node_area_name_4202130",
    3,
    48
  },
  [4202140] = {
    4202140,
    "str_waypoint_4202140",
    1,
    10,
    "str_node_area_name_4202140",
    3,
    50,
    "boss_2902401_map"
  },
  [4202155] = {
    4202155,
    "str_waypoint_4202155",
    1,
    10,
    "str_node_area_name_4202155",
    0,
    1
  },
  [4203015] = {
    4203015,
    "str_waypoint_4203015",
    1,
    10,
    "str_node_area_name_4203015",
    0,
    1
  },
  [4203020] = {
    4203020,
    "str_waypoint_4203020",
    1,
    10,
    "str_node_area_name_4203020",
    3,
    40
  },
  [4203030] = {
    4203030,
    "str_waypoint_4203030",
    1,
    10,
    "str_node_area_name_4203030",
    3,
    41
  },
  [4203040] = {
    4203040,
    "str_waypoint_4203040",
    1,
    10,
    "str_node_area_name_4203040",
    3,
    42
  },
  [4203041] = {
    4203041,
    "str_waypoint_4203041",
    1,
    10,
    "str_node_area_name_4203041",
    3,
    43
  },
  [4203050] = {
    4203050,
    "str_waypoint_4203050",
    1,
    10,
    "str_node_area_name_4203050",
    3,
    44
  },
  [4203060] = {
    4203060,
    "str_waypoint_4203060",
    1,
    10,
    "str_node_area_name_4203060",
    3,
    44
  },
  [4203070] = {
    4203070,
    "str_waypoint_4203070",
    1,
    10,
    "str_node_area_name_4203070",
    3,
    45,
    "boss_2902901_map"
  },
  [4203085] = {
    4203085,
    "str_waypoint_4203085",
    1,
    10,
    "str_node_area_name_4203085",
    0,
    1
  },
  [4203090] = {
    4203090,
    "str_waypoint_4203090",
    1,
    10,
    "str_node_area_name_4203090",
    3,
    45
  },
  [4203100] = {
    4203100,
    "str_waypoint_4203100",
    1,
    10,
    "str_node_area_name_4203100",
    3,
    45
  },
  [4203110] = {
    4203110,
    "str_waypoint_4203110",
    1,
    10,
    "str_node_area_name_4203110",
    3,
    47
  },
  [4203111] = {
    4203111,
    "str_waypoint_4203111",
    1,
    10,
    "str_node_area_name_4203111",
    3,
    49
  },
  [4203120] = {
    4203120,
    "str_waypoint_4203120",
    1,
    10,
    "str_node_area_name_4203120",
    3,
    51
  },
  [4203130] = {
    4203130,
    "str_waypoint_4203130",
    1,
    10,
    "str_node_area_name_4203130",
    3,
    53
  },
  [4203140] = {
    4203140,
    "str_waypoint_4203140",
    1,
    10,
    "str_node_area_name_4203140",
    3,
    55,
    "boss_2903601_map"
  },
  [4203155] = {
    4203155,
    "str_waypoint_4203155",
    1,
    10,
    "str_node_area_name_4203155",
    0,
    1
  },
  [4204015] = {
    4204015,
    "str_waypoint_4204015",
    1,
    10,
    "str_node_area_name_4204015",
    0,
    1
  },
  [4204020] = {
    4204020,
    "str_waypoint_4204020",
    1,
    10,
    "str_node_area_name_4204020",
    3,
    45
  },
  [4204030] = {
    4204030,
    "str_waypoint_4204030",
    1,
    10,
    "str_node_area_name_4204030",
    3,
    46
  },
  [4204031] = {
    4204031,
    "str_waypoint_4204031",
    1,
    10,
    "str_node_area_name_4204031",
    3,
    47
  },
  [4204040] = {
    4204040,
    "str_waypoint_4204040",
    1,
    10,
    "str_node_area_name_4204040",
    3,
    47
  },
  [4204050] = {
    4204050,
    "str_waypoint_4204050",
    1,
    10,
    "str_node_area_name_4204050",
    3,
    48
  },
  [4204060] = {
    4204060,
    "str_waypoint_4204060",
    1,
    10,
    "str_node_area_name_4204060",
    3,
    49
  },
  [4204070] = {
    4204070,
    "str_waypoint_4204070",
    1,
    10,
    "str_node_area_name_4204070",
    3,
    50,
    "boss_2903501_map"
  },
  [4204085] = {
    4204085,
    "str_waypoint_4204085",
    1,
    10,
    "str_node_area_name_4204085",
    0,
    1
  },
  [4204090] = {
    4204090,
    "str_waypoint_4204090",
    1,
    10,
    "str_node_area_name_4204090",
    3,
    50
  },
  [4204100] = {
    4204100,
    "str_waypoint_4204100",
    1,
    10,
    "str_node_area_name_4204100",
    3,
    52
  },
  [4204101] = {
    4204101,
    "str_waypoint_4204101",
    1,
    10,
    "str_node_area_name_4204101",
    3,
    54
  },
  [4204110] = {
    4204110,
    "str_waypoint_4204110",
    1,
    10,
    "str_node_area_name_4204110",
    3,
    54
  },
  [4204120] = {
    4204120,
    "str_waypoint_4204120",
    1,
    10,
    "str_node_area_name_4204120",
    3,
    56
  },
  [4204130] = {
    4204130,
    "str_waypoint_4204130",
    1,
    10,
    "str_node_area_name_4204130",
    3,
    58
  },
  [4204140] = {
    4204140,
    "str_waypoint_4204140",
    1,
    10,
    "str_node_area_name_4204140",
    3,
    60,
    "boss_2903401_map"
  },
  [4204155] = {
    4204155,
    "str_waypoint_4204155",
    1,
    10,
    "str_node_area_name_4204155",
    0,
    1
  },
  [4205015] = {
    4205015,
    "str_waypoint_4205015",
    1,
    10,
    "str_node_area_name_4205015",
    0,
    1
  },
  [4205020] = {
    4205020,
    "str_waypoint_4205020",
    1,
    10,
    "str_node_area_name_4205020",
    3,
    40
  },
  [4205030] = {
    4205030,
    "str_waypoint_4205030",
    1,
    10,
    "str_node_area_name_4205030",
    3,
    41
  },
  [4205040] = {
    4205040,
    "str_waypoint_4205040",
    1,
    10,
    "str_node_area_name_4205040",
    3,
    42
  },
  [4205041] = {
    4205041,
    "str_waypoint_4205041",
    1,
    10,
    "str_node_area_name_4205041",
    3,
    42
  },
  [4205050] = {
    4205050,
    "str_waypoint_4205050",
    1,
    10,
    "str_node_area_name_4205050",
    3,
    43
  },
  [4205065] = {
    4205065,
    "str_waypoint_4205065",
    1,
    10,
    "str_node_area_name_4205065",
    0,
    1
  },
  [4205070] = {
    4205070,
    "str_waypoint_4205070",
    1,
    10,
    "str_node_area_name_4205070",
    3,
    44
  },
  [4205080] = {
    4205080,
    "str_waypoint_4205080",
    1,
    10,
    "str_node_area_name_4205080",
    3,
    45
  },
  [4205090] = {
    4205090,
    "str_waypoint_4205090",
    1,
    10,
    "str_node_area_name_4205090",
    3,
    45,
    "boss_2905101_map"
  },
  [4205100] = {
    4205100,
    "str_waypoint_4205100",
    1,
    10,
    "str_node_area_name_4205100",
    3,
    47
  },
  [4205101] = {
    4205101,
    "str_waypoint_4205101",
    1,
    10,
    "str_node_area_name_4205101",
    3,
    47
  },
  [4205110] = {
    4205110,
    "str_waypoint_4205110",
    1,
    10,
    "str_node_area_name_4205110",
    3,
    49
  },
  [4205120] = {
    4205120,
    "str_waypoint_4205120",
    1,
    10,
    "str_node_area_name_4205120",
    3,
    51
  },
  [4205130] = {
    4205130,
    "str_waypoint_4205130",
    1,
    10,
    "str_node_area_name_4205130",
    3,
    53
  },
  [4205140] = {
    4205140,
    "str_waypoint_4205140",
    1,
    10,
    "str_node_area_name_4205140",
    3,
    55,
    "boss_2905301_map"
  },
  [4205155] = {
    4205155,
    "str_waypoint_4205155",
    1,
    10,
    "str_node_area_name_4205155",
    0,
    1
  },
  [4206015] = {
    4206015,
    "str_waypoint_4206015",
    1,
    10,
    "str_node_area_name_4206015",
    0,
    1
  },
  [4206020] = {
    4206020,
    "str_waypoint_4206020",
    1,
    10,
    "str_node_area_name_4206020",
    3,
    45
  },
  [4206030] = {
    4206030,
    "str_waypoint_4206030",
    1,
    10,
    "str_node_area_name_4206030",
    3,
    46
  },
  [4206040] = {
    4206040,
    "str_waypoint_4206040",
    1,
    10,
    "str_node_area_name_4206040",
    3,
    47
  },
  [4206041] = {
    4206041,
    "str_waypoint_4206041",
    1,
    10,
    "str_node_area_name_4206041",
    3,
    47
  },
  [4206050] = {
    4206050,
    "str_waypoint_4206050",
    1,
    10,
    "str_node_area_name_4206050",
    3,
    48
  },
  [4206060] = {
    4206060,
    "str_waypoint_4206060",
    1,
    10,
    "str_node_area_name_4206060",
    3,
    49
  },
  [4206070] = {
    4206070,
    "str_waypoint_4206070",
    1,
    10,
    "str_node_area_name_4206070",
    3,
    50
  },
  [4206080] = {
    4206080,
    "str_waypoint_4206080",
    1,
    10,
    "str_node_area_name_4206080",
    3,
    50
  },
  [4206090] = {
    4206090,
    "str_waypoint_4206090",
    1,
    10,
    "str_node_area_name_4206090",
    3,
    52,
    "boss_2905001_map"
  },
  [4206105] = {
    4206105,
    "str_waypoint_4206105",
    1,
    10,
    "str_node_area_name_4206105",
    0,
    1
  },
  [4206110] = {
    4206110,
    "str_waypoint_4206110",
    1,
    10,
    "str_node_area_name_4206110",
    3,
    54
  },
  [4206120] = {
    4206120,
    "str_waypoint_4206120",
    1,
    10,
    "str_node_area_name_4206120",
    3,
    56
  },
  [4206121] = {
    4206121,
    "str_waypoint_4206121",
    1,
    10,
    "str_node_area_name_4206121",
    3,
    56
  },
  [4206130] = {
    4206130,
    "str_waypoint_4206130",
    1,
    10,
    "str_node_area_name_4206130",
    3,
    58
  },
  [4206140] = {
    4206140,
    "str_waypoint_4206140",
    1,
    10,
    "str_node_area_name_4206140",
    3,
    60,
    "boss_2905201_map"
  },
  [4206155] = {
    4206155,
    "str_waypoint_4206155",
    1,
    10,
    "str_node_area_name_4206155",
    0,
    1
  },
  [4207015] = {
    4207015,
    "str_waypoint_4207015",
    1,
    10,
    "str_node_area_name_4207015",
    0,
    1
  },
  [4207020] = {
    4207020,
    "str_waypoint_4207020",
    1,
    10,
    "str_node_area_name_4207020",
    3,
    40
  },
  [4207030] = {
    4207030,
    "str_waypoint_4207030",
    1,
    10,
    "str_node_area_name_4207030",
    3,
    41
  },
  [4207031] = {
    4207031,
    "str_waypoint_4207031",
    1,
    10,
    "str_node_area_name_4207031",
    3,
    41
  },
  [4207040] = {
    4207040,
    "str_waypoint_4207040",
    1,
    10,
    "str_node_area_name_4207040",
    3,
    42
  },
  [4207050] = {
    4207050,
    "str_waypoint_4207050",
    1,
    10,
    "str_node_area_name_4207050",
    3,
    43
  },
  [4207060] = {
    4207060,
    "str_waypoint_4207060",
    1,
    10,
    "str_node_area_name_4207060",
    3,
    44
  },
  [4207075] = {
    4207075,
    "str_waypoint_4207075",
    1,
    10,
    "str_node_area_name_4207075",
    0,
    1
  },
  [4207080] = {
    4207080,
    "str_waypoint_4207080",
    1,
    10,
    "str_node_area_name_4207080",
    3,
    45
  },
  [4207090] = {
    4207090,
    "str_waypoint_4207090",
    1,
    10,
    "str_node_area_name_4207090",
    3,
    45,
    "boss_2900441_map"
  },
  [4207100] = {
    4207100,
    "str_waypoint_4207100",
    1,
    10,
    "str_node_area_name_4207100",
    3,
    47
  },
  [4207110] = {
    4207110,
    "str_waypoint_4207110",
    1,
    10,
    "str_node_area_name_4207110",
    3,
    49
  },
  [4207111] = {
    4207111,
    "str_waypoint_4207111",
    1,
    10,
    "str_node_area_name_4207111",
    3,
    47
  },
  [4207120] = {
    4207120,
    "str_waypoint_4207120",
    1,
    10,
    "str_node_area_name_4207120",
    3,
    51
  },
  [4207130] = {
    4207130,
    "str_waypoint_4207130",
    1,
    10,
    "str_node_area_name_4207130",
    3,
    53
  },
  [4207140] = {
    4207140,
    "str_waypoint_4207140",
    1,
    10,
    "str_node_area_name_4207140",
    3,
    55,
    "boss_2905701_map"
  },
  [4207155] = {
    4207155,
    "str_waypoint_4207155",
    1,
    10,
    "str_node_area_name_4207155",
    0,
    1
  },
  [4208015] = {
    4208015,
    "str_waypoint_4208015",
    1,
    10,
    "str_node_area_name_4208015",
    0,
    1
  },
  [4208020] = {
    4208020,
    "str_waypoint_4208020",
    1,
    10,
    "str_node_area_name_4208020",
    3,
    45
  },
  [4208030] = {
    4208030,
    "str_waypoint_4208030",
    1,
    10,
    "str_node_area_name_4208030",
    3,
    46
  },
  [4208040] = {
    4208040,
    "str_waypoint_4208040",
    1,
    10,
    "str_node_area_name_4208040",
    3,
    47
  },
  [4208041] = {
    4208041,
    "str_waypoint_4208041",
    1,
    10,
    "str_node_area_name_4208041",
    3,
    47
  },
  [4208050] = {
    4208050,
    "str_waypoint_4208050",
    1,
    10,
    "str_node_area_name_4208050",
    3,
    48
  },
  [4208060] = {
    4208060,
    "str_waypoint_4208060",
    1,
    10,
    "str_node_area_name_4208060",
    3,
    49,
    "boss_2003401_map"
  },
  [4208070] = {
    4208070,
    "str_waypoint_4208070",
    1,
    10,
    "str_node_area_name_4208070",
    3,
    50
  },
  [4208080] = {
    4208080,
    "str_waypoint_4208080",
    1,
    10,
    "str_node_area_name_4208080",
    3,
    50
  },
  [4208095] = {
    4208095,
    "str_waypoint_4208095",
    1,
    10,
    "str_node_area_name_4208095",
    0,
    1
  },
  [4208100] = {
    4208100,
    "str_waypoint_4208100",
    1,
    10,
    "str_node_area_name_4208100",
    3,
    52
  },
  [4208110] = {
    4208110,
    "str_waypoint_4208110",
    1,
    10,
    "str_node_area_name_4208110",
    3,
    54
  },
  [4208111] = {
    4208111,
    "str_waypoint_4208111",
    1,
    10,
    "str_node_area_name_4208111",
    3,
    54
  },
  [4208120] = {
    4208120,
    "str_waypoint_4208120",
    1,
    10,
    "str_node_area_name_4208120",
    3,
    56
  },
  [4208130] = {
    4208130,
    "str_waypoint_4208130",
    1,
    10,
    "str_node_area_name_4208130",
    3,
    58
  },
  [4208140] = {
    4208140,
    "str_waypoint_4208140",
    1,
    10,
    "str_node_area_name_4208140",
    3,
    60,
    "boss_2906101_map"
  },
  [4208155] = {
    4208155,
    "str_waypoint_4208155",
    1,
    10,
    "str_node_area_name_4208155",
    0,
    1
  },
  [4209015] = {
    4209015,
    "str_waypoint_4209015",
    1,
    10,
    "str_node_area_name_4209015",
    0,
    1
  },
  [4209020] = {
    4209020,
    "str_waypoint_4209020",
    1,
    10,
    "str_node_area_name_4209020",
    3,
    40
  },
  [4209030] = {
    4209030,
    "str_waypoint_4209030",
    1,
    10,
    "str_node_area_name_4209030",
    3,
    41
  },
  [4209040] = {
    4209040,
    "str_waypoint_4209040",
    1,
    10,
    "str_node_area_name_4209040",
    3,
    42
  },
  [4209050] = {
    4209050,
    "str_waypoint_4209050",
    1,
    10,
    "str_node_area_name_4209050",
    3,
    42
  },
  [4209065] = {
    4209065,
    "str_waypoint_4209065",
    1,
    10,
    "str_node_area_name_4209065",
    0,
    1
  },
  [4209070] = {
    4209070,
    "str_waypoint_4209070",
    1,
    10,
    "str_node_area_name_4209070",
    3,
    43
  },
  [4209080] = {
    4209080,
    "str_waypoint_4209080",
    1,
    10,
    "str_node_area_name_4209080",
    3,
    44
  },
  [4209081] = {
    4209081,
    "str_waypoint_4209081",
    1,
    10,
    "str_node_area_name_4209081",
    3,
    44
  },
  [4209090] = {
    4209090,
    "str_waypoint_4209090",
    1,
    10,
    "str_node_area_name_4209090",
    3,
    45,
    "boss_2004601_map"
  },
  [4209100] = {
    4209100,
    "str_waypoint_4209100",
    1,
    10,
    "str_node_area_name_4209100",
    3,
    47
  },
  [4209115] = {
    4209115,
    "str_waypoint_4209115",
    1,
    10,
    "str_node_area_name_4209115",
    0,
    1
  },
  [4209120] = {
    4209120,
    "str_waypoint_4209120",
    1,
    10,
    "str_node_area_name_4209120",
    3,
    49
  },
  [4209121] = {
    4209121,
    "str_waypoint_4209121",
    1,
    10,
    "str_node_area_name_4209121",
    3,
    49
  },
  [4209130] = {
    4209130,
    "str_waypoint_4209130",
    1,
    10,
    "str_node_area_name_4209130",
    3,
    51
  },
  [4209140] = {
    4209140,
    "str_waypoint_4209140",
    1,
    10,
    "str_node_area_name_4209140",
    3,
    53
  },
  [4209150] = {
    4209150,
    "str_waypoint_4209150",
    1,
    10,
    "str_node_area_name_4209150",
    3,
    55,
    common[6]
  },
  [4210015] = {
    4210015,
    "str_waypoint_4210015",
    1,
    10,
    "str_node_area_name_4210015",
    0,
    1
  },
  [4210020] = {
    4210020,
    "str_waypoint_4210020",
    1,
    10,
    "str_node_area_name_4210020",
    3,
    45
  },
  [4210030] = {
    4210030,
    "str_waypoint_4210030",
    1,
    10,
    "str_node_area_name_4210030",
    3,
    46
  },
  [4210045] = {
    4210045,
    "str_waypoint_4210045",
    1,
    10,
    "str_node_area_name_4210045",
    0,
    1
  },
  [4210050] = {
    4210050,
    "str_waypoint_4210050",
    1,
    10,
    "str_node_area_name_4210050",
    3,
    47
  },
  [4210060] = {
    4210060,
    "str_waypoint_4210060",
    1,
    10,
    "str_node_area_name_4210060",
    3,
    47
  },
  [4210070] = {
    4210070,
    "str_waypoint_4210070",
    1,
    10,
    "str_node_area_name_4210070",
    3,
    48
  },
  [4210071] = {
    4210071,
    "str_waypoint_4210071",
    1,
    10,
    "str_node_area_name_4210071",
    3,
    48
  },
  [4210080] = {
    4210080,
    "str_waypoint_4210080",
    1,
    10,
    "str_node_area_name_4210080",
    3,
    49,
    common[6]
  },
  [4210090] = {
    4210090,
    "str_waypoint_4210090",
    1,
    10,
    "str_node_area_name_4210090",
    3,
    50
  },
  [4210100] = {
    4210100,
    "str_waypoint_4210100",
    1,
    10,
    "str_node_area_name_4210100",
    3,
    52
  },
  [4210110] = {
    4210110,
    "str_waypoint_4210110",
    1,
    10,
    "str_node_area_name_4210110",
    3,
    54
  },
  [4210120] = {
    4210120,
    "str_waypoint_4210120",
    1,
    10,
    "str_node_area_name_4210120",
    3,
    56
  },
  [4210121] = {
    4210121,
    "str_waypoint_4210121",
    1,
    10,
    "str_node_area_name_4210121",
    3,
    56
  },
  [4210130] = {
    4210130,
    "str_waypoint_4210130",
    1,
    10,
    "str_node_area_name_4210130",
    3,
    58
  },
  [4210140] = {
    4210140,
    "str_waypoint_4210140",
    1,
    10,
    "str_node_area_name_4210140",
    3,
    60,
    "boss_2906301_map"
  },
  [4210155] = {
    4210155,
    "str_waypoint_4210155",
    1,
    10,
    "str_node_area_name_4210155",
    0,
    1
  },
  [4301015] = {
    4301015,
    "str_waypoint_4301015",
    1,
    10,
    "str_node_area_name_4301015",
    3,
    1
  },
  [4301020] = {
    4301020,
    "str_waypoint_4301020",
    1,
    10,
    "str_node_area_name_4301020",
    3,
    50
  },
  [4301030] = {
    4301030,
    "str_waypoint_4301030",
    1,
    10,
    "str_node_area_name_4301030",
    3,
    54
  },
  [4301040] = {
    4301040,
    "str_waypoint_4301040",
    1,
    10,
    "str_node_area_name_4301040",
    3,
    58
  },
  [4301055] = {
    4301055,
    "str_waypoint_4301055",
    1,
    10,
    "str_node_area_name_4301055",
    3,
    62
  },
  [4301060] = {
    4301060,
    "str_waypoint_4301060",
    1,
    10,
    "str_node_area_name_4301060",
    3,
    66
  },
  [4301070] = {
    4301070,
    "str_waypoint_4301070",
    1,
    10,
    "str_node_area_name_4301070",
    3,
    1
  },
  [4301080] = {
    4301080,
    "str_waypoint_4301080",
    1,
    10,
    "str_node_area_name_4301080",
    3,
    68
  },
  [4301090] = {
    4301090,
    "str_waypoint_4301090",
    1,
    10,
    "str_node_area_name_4301090",
    3,
    70,
    "boss_2909401_map"
  },
  [4301105] = {
    4301105,
    "str_waypoint_4301105",
    1,
    10,
    "str_node_area_name_4301105",
    3,
    1
  },
  [4220015] = {
    4220015,
    "str_waypoint_4220015",
    1,
    10,
    "str_node_area_name_4220015",
    3,
    70
  },
  [4220020] = {
    4220020,
    "str_waypoint_4220020",
    1,
    10,
    "str_node_area_name_4220020",
    3,
    70
  },
  [4220030] = {
    4220030,
    "str_waypoint_4220030",
    1,
    10,
    "str_node_area_name_4220030",
    3,
    70
  },
  [4220040] = {
    4220040,
    "str_waypoint_4220040",
    1,
    10,
    "str_node_area_name_4220040",
    3,
    70
  },
  [4220050] = {
    4220050,
    "str_waypoint_4220050",
    1,
    10,
    "str_node_area_name_4220050",
    3,
    70
  },
  [4220060] = {
    4220060,
    "str_waypoint_4220060",
    1,
    10,
    "str_node_area_name_4220060",
    3,
    70
  },
  [4220061] = {
    4220061,
    "str_waypoint_4220061",
    1,
    10,
    "str_node_area_name_4220061",
    3,
    70
  },
  [4220070] = {
    4220070,
    "str_waypoint_4220070",
    1,
    10,
    "str_node_area_name_4220070",
    3,
    70
  },
  [4220071] = {
    4220071,
    "str_waypoint_4220071",
    1,
    10,
    "str_node_area_name_4220071",
    3,
    70
  },
  [4220085] = {
    4220085,
    "str_waypoint_4220085",
    1,
    10,
    "str_node_area_name_4220085",
    3,
    1
  },
  [4220090] = {
    4220090,
    "str_waypoint_4220090",
    1,
    10,
    "str_node_area_name_4220090",
    3,
    70,
    common[3]
  },
  [4220100] = {
    4220100,
    "str_waypoint_4220100",
    1,
    10,
    "str_node_area_name_4220100",
    3,
    70
  },
  [4220110] = {
    4220110,
    "str_waypoint_4220110",
    1,
    10,
    "str_node_area_name_4220110",
    3,
    70,
    common[4]
  },
  [4220125] = {
    4220125,
    "str_waypoint_4220125",
    1,
    10,
    "str_node_area_name_4220125",
    3,
    1
  }
}
return config, "ID", key
