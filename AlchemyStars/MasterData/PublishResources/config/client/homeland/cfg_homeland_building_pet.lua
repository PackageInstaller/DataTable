local key = {
  ID = 1,
  InteractPointIndex = 2,
  petIDs = 3,
  In = 4,
  Loop = 5,
  Out = 6,
  InteractionBubbles = 7,
  BlackList = 8,
  BindingSkeleton = 9
}
local common = {
  {
    [1] = {
      anim = "sit",
      pholder = "Bip001 R Hand",
      bholder = "",
      crossFadeTime = 0.3
    }
  },
  {
    [1] = {
      anim = "sit",
      pholder = "Bip001 R Hand",
      bholder = "",
      weight = 10
    }
  },
  {
    [1] = {anim = "watch_hli"}
  },
  {
    [1] = {
      anim = "watch_in_hli"
    }
  },
  {
    [1] = {
      anim = "watch_out_hli"
    }
  },
  {
    [1] = {
      anim = "bench_in_hli"
    }
  },
  {
    [1] = {anim = "bench_hli"}
  },
  {
    [1] = {
      anim = "bench_out_hli"
    }
  },
  {
    [1] = {
      anim = "observe_in_hli"
    }
  },
  {
    [1] = {
      anim = "observe_hli"
    }
  },
  {
    [1] = {
      anim = "observe_out_hli"
    }
  },
  {
    [1] = {
      anim = "sleep_in_hli"
    }
  },
  {
    [1] = {anim = "sleep_hli"}
  },
  {
    [1] = {
      anim = "sleep_out_hli"
    }
  },
  {
    [1] = {
      anim = "changpianji_in_hli"
    }
  },
  {
    [1] = {
      anim = "changpianji_hli"
    }
  },
  {
    [1] = {anim = "stand"}
  },
  {
    [1] = {
      anim = "xinshang_in_hli"
    }
  },
  {
    [1] = {
      anim = "xinshang_hli"
    }
  },
  {
    [1] = {
      anim = "xinshang_out_hli"
    }
  },
  {4010001, 4010013},
  {1601811, 1601812},
  {4010001},
  {4010015},
  {1401691, 1401692}
}
local config = {
  {
    1,
    nil,
    nil,
    common[1],
    common[2],
    common[1],
    common[21],
    common[22]
  },
  {
    2,
    nil,
    nil,
    common[1],
    {
      [1] = {
        anim = "sit",
        pholder = "Bip001 R Hand",
        bholder = "",
        weight = 10
      },
      [2] = {
        anim = "sit",
        pholder = "Bip001 R Hand",
        bholder = "",
        weight = 90
      }
    },
    common[1],
    common[21],
    common[22]
  },
  {
    3,
    nil,
    {
      1400441,
      1400442,
      1400443,
      1500921,
      1500922,
      1500923,
      1500924
    },
    {
      [1] = {
        anim = "qiuqian_in_hli"
      }
    },
    {
      [1] = {
        anim = "qiuqian_hli"
      }
    },
    {
      [1] = {
        anim = "qiuqian_out_hli"
      }
    },
    common[21]
  },
  {
    4,
    nil,
    {
      1500331,
      1500332,
      1500333,
      1500334,
      1500335
    },
    {
      [1] = {
        anim = "shop_in_hli",
        pholder = "Bip001 L Hand",
        peff = "eff_1500331@shop_hli"
      }
    },
    {
      [1] = {
        anim = "shop_hli",
        pholder = "Bip001 L Hand",
        peff = "eff_1500331@shop_hli"
      }
    },
    {
      [1] = {
        anim = "shop_out_hli",
        pholder = "Bip001 L Hand",
        peff = "eff_1500331@shop_hli"
      }
    },
    common[21]
  },
  {
    5,
    nil,
    {
      1600061,
      1600062,
      1600063,
      1600064,
      1600021,
      1600022,
      1600023,
      1600065,
      1600024
    },
    {
      [1] = {
        anim = "wish_in_hli"
      }
    },
    {
      [1] = {anim = "wish_hli"}
    },
    {
      [1] = {
        anim = "wish_out_hli"
      }
    },
    {4010016}
  },
  {
    6,
    nil,
    {
      1600251,
      1600252,
      1600253
    },
    {
      [1] = {
        anim = "perform_in_hli"
      }
    },
    {
      [1] = {
        anim = "perform_hli"
      }
    },
    {
      [1] = {
        anim = "perform_out_hli"
      }
    },
    common[21]
  },
  {
    7,
    nil,
    {1600771, 1600772},
    {
      [1] = {
        anim = "read_in_hli"
      }
    },
    {
      [1] = {
        anim = "read_hli",
        peff = "eff_1600771@read_hli"
      }
    },
    {
      [1] = {
        anim = "read_out_hli"
      }
    },
    common[21]
  },
  {
    8,
    nil,
    {
      1600111,
      1600112,
      1600113,
      1600114
    },
    {
      [1] = {
        anim = "boxing_in_hli"
      }
    },
    {
      [1] = {anim = "boxing_hli"}
    },
    {
      [1] = {
        anim = "boxing_out_hli"
      }
    },
    common[21]
  },
  {
    9,
    nil,
    {1601531, 1601532},
    nil,
    common[3],
    nil,
    common[21]
  },
  {
    10,
    nil,
    {1601551, 1601552},
    common[4],
    common[3],
    common[5],
    common[23]
  },
  {
    11,
    nil,
    {
      1601541,
      1601542,
      1601543,
      1601544
    },
    {
      [1] = {
        anim = "museum_in_hli",
        peff = "eff_1601541@museum_hli",
        pholder = "eff_1601541@museum_hli"
      }
    },
    {
      [1] = {
        anim = "museum_hli",
        peff = "eff_1601541@museum_hli",
        pholder = "eff_1601541@museum_hli"
      }
    },
    {
      [1] = {
        anim = "museum_out_hli",
        peff = "eff_1601541@museum_hli",
        pholder = "eff_1601541@museum_hli"
      }
    },
    common[21]
  },
  {
    12,
    nil,
    {1500181, 1500182},
    {
      [1] = {
        anim = "show_in_hli"
      }
    },
    {
      [1] = {anim = "show_hli"}
    },
    {
      [1] = {
        anim = "show_out_hli"
      }
    },
    common[21]
  },
  {
    13,
    nil,
    {
      1500551,
      1500552,
      1500553
    },
    {
      [1] = {
        anim = "ride_in_hli"
      }
    },
    {
      [1] = {anim = "ride_hli"}
    },
    {
      [1] = {
        anim = "ride_out_hli"
      }
    },
    common[21]
  },
  {
    14,
    nil,
    {
      1500711,
      1500712,
      1500713
    },
    {
      [1] = {
        anim = "fengzheng_in_hli"
      }
    },
    {
      [1] = {
        anim = "fengzheng_hli"
      }
    },
    {
      [1] = {
        anim = "fengzheng_out_hli"
      }
    }
  },
  {
    15,
    nil,
    {
      1601171,
      1601172,
      1601173
    },
    common[4],
    common[3],
    nil,
    common[24]
  },
  {
    16,
    nil,
    {
      1601561,
      1601562,
      1601563
    },
    {
      [1] = {
        anim = "jy_play_muma_in"
      }
    },
    {
      [1] = {
        anim = "jy_play_muma_loop"
      }
    },
    {
      [1] = {
        anim = "jy_play_muma_out"
      }
    },
    common[23]
  },
  {
    17,
    nil,
    {
      1501571,
      1501572,
      1501573
    },
    common[4],
    common[3],
    common[5],
    common[24]
  },
  {
    18,
    nil,
    {1601641, 1601642},
    {
      [1] = {
        anim = "think_in_hli"
      }
    },
    {
      [1] = {anim = "think_hli"}
    },
    {
      [1] = {
        anim = "think_out_hli"
      }
    },
    common[21]
  },
  {
    19,
    nil,
    {
      1501651,
      1501652,
      1501653
    },
    {
      [1] = {
        anim = "warm_in_hli"
      }
    },
    {
      [1] = {anim = "warm_hli"}
    },
    {
      [1] = {
        anim = "warm_out_hli"
      }
    },
    common[21]
  },
  {
    20,
    nil,
    {1500873},
    {
      [1] = {
        anim = "bath_in_hli"
      }
    },
    {
      [1] = {
        anim = "bath_hli",
        bholder = "hl_pfb_5272001",
        beff = "eff_jy_5272001_muyu"
      }
    },
    {
      [1] = {
        anim = "bath_out_hli"
      }
    },
    common[24]
  },
  {
    21,
    nil,
    {1501681, 1501682},
    {
      [1] = {
        anim = "jy_play_dadie_in"
      }
    },
    {
      [1] = {
        anim = "jy_play_dadie_loop",
        bholder = "hl_pfb_5272003",
        beff = "eff_jy_5272003_dj"
      }
    },
    {
      [1] = {
        anim = "jy_play_dadie_out"
      }
    },
    common[24]
  },
  {
    22,
    nil,
    {
      1601671,
      1601672,
      1601673
    },
    common[6],
    common[7],
    common[8],
    common[24]
  },
  {
    23,
    nil,
    {1601661, 1601662},
    {
      [1] = {
        anim = "slide_in_hli"
      }
    },
    {
      [1] = {anim = "slide_hli", duration = 1.667}
    },
    {
      [1] = {
        anim = "slide_out_hli",
        leaveTransform = "leaveInteract"
      }
    },
    common[24]
  },
  {
    24,
    nil,
    {
      1400411,
      1400412,
      1400413,
      1601701,
      1601702,
      1601703
    },
    {
      [1] = {
        anim = "overlook_in_hli"
      }
    },
    {
      [1] = {
        anim = "overlook_hli"
      }
    },
    {
      [1] = {
        anim = "overlook_out_hli",
        leaveTransform = "leaveInteract"
      }
    },
    common[24]
  },
  {
    25,
    nil,
    {
      1601031,
      1601032,
      1601033,
      1601034
    },
    common[6],
    common[7],
    common[8],
    common[24]
  },
  {
    26,
    nil,
    {1601033},
    common[6],
    common[7],
    common[8],
    common[24]
  },
  {
    27,
    nil,
    {1600384},
    nil,
    common[3],
    nil,
    {4040001, 4040002}
  },
  {
    28,
    nil,
    {
      1500333,
      1400863,
      1600063,
      1601033,
      1500763,
      1500703,
      1400813,
      1601113,
      1500873,
      1400413,
      1601293,
      1600384,
      1501681,
      1501682,
      1601483,
      1601214,
      1601153,
      1400793,
      1601403,
      1600774,
      1601783
    },
    common[1],
    common[2],
    common[1],
    common[24]
  },
  {
    29,
    nil,
    {1501301},
    common[9],
    common[10],
    common[11],
    common[24]
  },
  {
    30,
    nil,
    {1501711, 1501712},
    common[9],
    common[10],
    common[11],
    common[24]
  },
  {
    31,
    nil,
    {
      1601211,
      1601212,
      1601213,
      1601214
    },
    common[12],
    common[13],
    common[14],
    common[24]
  },
  {
    32,
    nil,
    {1601201, 1601202},
    {
      [1] = {
        anim = "touch_in_hli"
      }
    },
    {
      [1] = {anim = "touch_hli"}
    },
    {
      [1] = {
        anim = "touch_out_hli"
      }
    },
    common[24]
  },
  {
    33,
    nil,
    {
      1601191,
      1601192,
      1601193,
      1601194
    },
    {
      [1] = {
        anim = "shifa_in_hli"
      }
    },
    {
      [1] = {anim = "shifa_hli"}
    },
    {
      [1] = {
        anim = "shifa_out_hli"
      }
    },
    common[24]
  },
  {
    34,
    nil,
    {
      1600251,
      1600252,
      1600253,
      1600254,
      1500781,
      1500782,
      1500783
    },
    common[15],
    common[16],
    nil,
    common[24]
  },
  [36] = {
    36,
    nil,
    {1601731, 1601732},
    {
      [1] = {
        anim = "candle_in_hli",
        beff = "eff_hl_pfb_5212017_loop",
        bholder = "hl_pfb_5212017"
      }
    },
    {
      [1] = {
        anim = "candle_hli",
        beff = "eff_hl_pfb_5212017_loop",
        bholder = "hl_pfb_5212017"
      }
    },
    {
      [1] = {
        anim = "candle_out_hli"
      }
    },
    common[24]
  },
  [37] = {
    37,
    nil,
    common[25],
    {
      [1] = {anim = "rap_in_hli"}
    },
    {
      [1] = {anim = "rap_hli"}
    },
    {
      [1] = {
        anim = "rap_out_hli"
      }
    },
    common[24]
  },
  [38] = {
    38,
    nil,
    {
      1601721,
      1601722,
      1601723
    },
    {
      [1] = {
        anim = "jy_play_pinata_in",
        peff = "hl_tool_stick_z",
        pholder = "Bip001 R Hand"
      }
    },
    {
      [1] = {
        anim = "jy_play_pinata_loop",
        peff = "hl_tool_stick_z",
        pholder = "Bip001 R Hand",
        beff = "eff_hl_pfb_5212018",
        bholder = "model/hl_pfb_5212018"
      }
    },
    {
      [1] = {
        anim = "jy_play_pinata_out",
        peff = "hl_tool_stick_z",
        pholder = "Bip001 R Hand"
      }
    },
    common[24]
  },
  [39] = {
    39,
    nil,
    common[25],
    {
      [1] = {
        anim = "drum_in_hli"
      }
    },
    {
      [1] = {anim = "drum_hli"}
    },
    {
      [1] = {
        anim = "drum_out_hli"
      }
    },
    common[24]
  },
  [40] = {
    40,
    {4},
    {1500121, 1500122},
    common[4],
    common[3],
    common[5],
    common[24]
  },
  [41] = {
    41,
    {
      1,
      2,
      3
    },
    nil,
    common[17],
    common[17],
    common[17],
    common[24]
  },
  [42] = {
    42,
    nil,
    {1501761, 1501762},
    common[4],
    common[3],
    common[5],
    common[24]
  },
  [43] = {
    43,
    nil,
    {
      1601751,
      1601752,
      1601753
    },
    common[12],
    common[13],
    common[14],
    common[24]
  },
  [44] = {
    44,
    nil,
    {1300491, 1300492},
    common[4],
    common[3],
    common[5],
    common[24]
  },
  [45] = {
    45,
    nil,
    {
      1600251,
      1600252,
      1600253,
      1600254
    },
    {
      [1] = {
        anim = "tanqin_in_hli"
      }
    },
    {
      [1] = {anim = "tanqin_hli"}
    },
    {
      [1] = {
        anim = "tanqin_out_hli"
      }
    },
    common[24]
  },
  [46] = {
    46,
    nil,
    {
      1601781,
      1601782,
      1601783
    },
    {
      [1] = {
        anim = "qiaogu_in_hli"
      }
    },
    {
      [1] = {anim = "qiaogu_hli"}
    },
    {
      [1] = {
        anim = "qiaogu_out_hli"
      }
    },
    common[24]
  },
  [47] = {
    47,
    nil,
    {
      1601771,
      1601772,
      1601773
    },
    {
      [1] = {
        anim = "sing_in_hli"
      }
    },
    {
      [1] = {anim = "sing_hli"}
    },
    {
      [1] = {
        anim = "sing_out_hli"
      }
    },
    common[24]
  },
  [48] = {
    48,
    nil,
    {
      1600641,
      1600642,
      1600643
    },
    common[4],
    common[3],
    common[5],
    common[24]
  },
  [49] = {
    49,
    nil,
    {1501851, 1501852},
    {
      [1] = {
        anim = "dizzy_in_hli"
      }
    },
    {
      [1] = {anim = "dizzy_hli"}
    },
    {
      [1] = {
        anim = "dizzy_out_hli"
      }
    },
    common[24],
    nil,
    {
      [1] = "Dummy002",
      [2] = "Dummy003",
      [3] = "Dummy004",
      [4] = "Dummy005",
      [5] = "Dummy006",
      [6] = "Dummy007"
    }
  },
  [50] = {
    50,
    nil,
    {
      1600771,
      1600772,
      1600773,
      1600774
    },
    common[1],
    common[2],
    common[1],
    common[24]
  },
  [51] = {
    51,
    nil,
    {
      1501801,
      1501802,
      1601771,
      1601772,
      1601773
    },
    {
      [1] = {
        anim = "tuili_in_hli"
      }
    },
    {
      [1] = {anim = "tuili_hli"}
    },
    {
      [1] = {
        anim = "tuili_out_hli"
      }
    },
    common[24]
  },
  [52] = {
    52,
    nil,
    {
      1400911,
      1400912,
      1400913
    },
    common[18],
    common[19],
    common[20],
    common[24]
  },
  [54] = {
    54,
    nil,
    {1601484},
    {
      [1] = {
        anim = "lumao_in_hli",
        peff = "eff_1601484@lumao_in_hli",
        pholder = "Dummy_1601484"
      }
    },
    {
      [1] = {
        anim = "lumao_hli",
        peff = "eff_1601484@lumao_hli",
        pholder = "Dummy_1601484"
      }
    },
    {
      [1] = {
        anim = "lumao_out_hli",
        peff = "eff_1601484@lumao_out_hli",
        pholder = "Dummy_1601484"
      }
    },
    common[24]
  },
  [55] = {
    55,
    nil,
    {
      1601161,
      1601162,
      1601163
    },
    common[18],
    common[19],
    common[20],
    common[24]
  },
  [56] = {
    56,
    nil,
    {1601921, 1601922},
    common[18],
    common[19],
    common[20],
    common[24]
  },
  [57] = {
    57,
    nil,
    {
      1601311,
      1601312,
      1601313
    },
    common[18],
    common[19],
    common[20],
    common[24]
  },
  [58] = {
    58,
    nil,
    {
      1601291,
      1601292,
      1601293
    },
    {
      [1] = {
        anim = "jushou_in_hli"
      }
    },
    {
      [1] = {anim = "jushou_hli"}
    },
    {
      [1] = {
        anim = "jushou_out_hli"
      }
    },
    common[24]
  },
  [59] = {
    59,
    nil,
    {
      1500991,
      1500992,
      1500993,
      1500994
    },
    {
      [1] = {
        anim = "julang_in_hli"
      }
    },
    {
      [1] = {anim = "julang_hli"}
    },
    {
      [1] = {
        anim = "julang_out_hli"
      }
    },
    common[24]
  },
  [60] = {
    60,
    nil,
    {
      1601261,
      1601262,
      1601263
    },
    common[15],
    common[16],
    nil,
    common[24]
  },
  [61] = {
    61,
    nil,
    {1601991, 1601992},
    common[18],
    common[19],
    common[20],
    common[24]
  },
  [62] = {
    62,
    nil,
    {1602041, 1602042},
    common[18],
    common[19],
    common[20],
    common[24]
  },
  [63] = {
    63,
    nil,
    {1502051},
    {
      [1] = {
        anim = "mingxiang_in_hli"
      }
    },
    {
      [1] = {
        anim = "mingxiang_hli"
      }
    },
    {
      [1] = {
        anim = "mingxiang_out_hli"
      }
    },
    common[24]
  },
  [64] = {
    64,
    nil,
    {1500751, 1500752},
    {
      [1] = {
        anim = "qiaoda_in_hli"
      }
    },
    {
      [1] = {anim = "qiaoda_hli"}
    },
    {
      [1] = {
        anim = "qiaoda_out_hli"
      }
    },
    common[24]
  },
  [65] = {
    65,
    nil,
    {1601214},
    common[1],
    common[2],
    common[1],
    common[24]
  },
  [66] = {
    66,
    nil,
    {1602121},
    common[17],
    common[17],
    common[17],
    common[21]
  },
  [67] = {
    67,
    nil,
    {1602111, 1602113},
    common[17],
    common[17],
    common[17],
    common[21]
  },
  [68] = {
    68,
    nil,
    {1502131},
    common[17],
    common[17],
    common[17],
    common[21]
  },
  [69] = {
    69,
    nil,
    {1602414},
    common[17],
    common[17],
    common[17],
    common[21]
  },
  [70] = {
    70,
    nil,
    {1502151},
    common[17],
    common[17],
    common[17],
    common[21]
  }
}
return config, "ID", key
