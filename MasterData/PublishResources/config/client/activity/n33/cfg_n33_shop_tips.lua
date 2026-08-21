local key = {
  ID = 1,
  FacePic = 2,
  TipsText = 3,
  beizhu = 4
}
local common = {
  {
    "n33_sd_image05"
  },
  {
    "n33_sd_image03"
  },
  {
    "n33_sd_image02"
  },
  {
    "str_n33_shop_tips_2110"
  },
  {
    "str_n33_shop_tips_2120"
  },
  {
    "str_n33_shop_tips_21301"
  },
  {
    "str_n33_shop_tips_21401"
  }
}
local config = {
  [1110] = {
    1110,
    common[1],
    {
      "str_n33_shop_tips_11101"
    },
    "单抽钩子下落"
  },
  [1121] = {
    1121,
    {
      "n33_sd_image01"
    },
    {
      "str_n33_shop_tips_1121"
    },
    "单抽钩子上升无标记"
  },
  [1122] = {
    1122,
    common[2],
    {
      "str_n33_shop_tips_1122"
    },
    "单抽钩子上升小奖"
  },
  [1123] = {
    1123,
    common[3],
    {
      "str_n33_shop_tips_1123"
    },
    "单抽钩子上升大奖"
  },
  [1210] = {
    1210,
    {
      "n33_sd_image04"
    },
    {
      "str_n33_shop_tips_1210"
    },
    "十连抽钩子下落"
  },
  [1221] = {
    1221,
    {
      "n33_sd_image06"
    },
    {
      "str_n33_shop_tips_1221"
    },
    "十连抽钩子上升无标记"
  },
  [1222] = {
    1222,
    common[2],
    {
      "str_n33_shop_tips_1222"
    },
    "十连抽钩子上升小奖"
  },
  [1223] = {
    1223,
    common[3],
    {
      "str_n33_shop_tips_1223"
    },
    "十连抽钩子上升大奖"
  },
  [2110] = {
    2110,
    common[2],
    common[4],
    "待机奖池1未解锁"
  },
  [2120] = {
    2120,
    common[1],
    common[5],
    "待机奖池1未抽空大奖"
  },
  [2130] = {
    2130,
    common[2],
    common[6],
    "待机奖池1抽空大奖后"
  },
  [2140] = {
    2140,
    common[3],
    common[7],
    "待机奖池1全部抽空后"
  },
  [2210] = {
    2210,
    common[2],
    common[4],
    "待机奖池2未解锁"
  },
  [2220] = {
    2220,
    common[1],
    common[5],
    "待机奖池2未抽空大奖"
  },
  [2230] = {
    2230,
    common[2],
    common[6],
    "待机奖池2抽空大奖后"
  },
  [2240] = {
    2240,
    common[3],
    common[7],
    "待机奖池2全部抽空后"
  },
  [2310] = {
    2310,
    common[2],
    common[4],
    "待机奖池3未解锁"
  },
  [2320] = {
    2320,
    common[1],
    common[5],
    "待机奖池3未抽空大奖"
  },
  [2330] = {
    2330,
    common[2],
    common[6],
    "待机奖池3抽空大奖后"
  },
  [2340] = {
    2340,
    common[3],
    common[7],
    "待机奖池3全部抽空后"
  },
  [2410] = {
    2410,
    common[2],
    common[4],
    "待机奖池4未解锁"
  },
  [2420] = {
    2420,
    common[1],
    common[5],
    "待机奖池4未抽空大奖"
  },
  [2430] = {
    2430,
    common[2],
    common[6],
    "待机奖池4抽空大奖后"
  },
  [2440] = {
    2440,
    common[3],
    common[7],
    "待机奖池4全部抽空后"
  },
  [2510] = {
    2510,
    common[2],
    common[4],
    "待机奖池5未解锁"
  },
  [2520] = {
    2520,
    common[1],
    common[5],
    "待机奖池5未抽空大奖"
  },
  [2530] = {
    2530,
    common[2],
    common[6],
    "待机奖池5抽空大奖后"
  },
  [2540] = {
    2540,
    common[3],
    common[7],
    "待机奖池5全部抽空后"
  },
  [2610] = {
    2610,
    common[2],
    common[4],
    "待机奖池6未解锁"
  },
  [2620] = {
    2620,
    common[1],
    common[5],
    "待机奖池6未抽空大奖"
  },
  [2630] = {
    2630,
    common[2],
    common[6],
    "待机奖池6抽空大奖后"
  },
  [2640] = {
    2640,
    common[3],
    common[7],
    "待机奖池6全部抽空后"
  }
}
return config, "ID", key
