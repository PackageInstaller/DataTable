local key = {
  ID = 1,
  cg = 2,
  rects = 3,
  pets = 4,
  imgs = 5,
  effect = 6,
  unlockImgs = 7,
  Vigorous1 = 8,
  award1 = 9,
  Vigorous2 = 10,
  award2 = 11,
  Vigorous3 = 12,
  award3 = 13,
  Vigorous4 = 14,
  award4 = 15,
  Vigorous5 = 16,
  award5 = 17,
  Vigorous6 = 18,
  award6 = 19,
  Vigorous7 = 20,
  award7 = 21,
  Vigorous8 = 22,
  award8 = 23,
  Vigorous9 = 24,
  award9 = 25,
  Vigorous10 = 26,
  award10 = 27
}
local common = {
  {
    {3000002, 30000}
  },
  {
    {3100014, 5}
  },
  {
    {3400038, 2}
  },
  {
    {3500001, 200}
  },
  {
    {3000003, 600}
  },
  {
    [1] = {
      s = "main_prec_di1",
      f = "main_prec_di2",
      bg = "main_prec_di3"
    },
    [2] = {
      s = "main_prec_di4",
      f = "main_prec_di5",
      bg = "main_prec_di6"
    },
    [3] = {
      s = "main_prec_di7",
      f = "main_prec_di8",
      bg = "main_prec_di9"
    },
    [4] = {
      s = "main_prec_di10",
      f = "main_prec_di11",
      bg = "main_prec_di12"
    },
    [5] = {
      s = "main_prec_di13",
      f = "main_prec_di14",
      bg = "main_prec_di15"
    }
  },
  {
    [1] = {
      x = -438,
      y = 220,
      x2 = 451.3,
      y2 = -237.3,
      w = 623,
      h = 423,
      ax = 0,
      ay = 0,
      aw = 250,
      ah = 250,
      px = -205,
      py = 105
    },
    [2] = {
      x = -416,
      y = -178,
      x2 = 426.8,
      y2 = 173.4,
      w = 667,
      h = 543,
      ax = 0,
      ay = 0,
      aw = 250,
      ah = 250,
      px = -229,
      py = 140
    },
    [3] = {
      x = 31,
      y = 163,
      x2 = -32.7,
      y2 = -178.6,
      w = 499,
      h = 537,
      ax = 0,
      ay = 0,
      aw = 350,
      ah = 350,
      px = -125.2,
      py = 159
    },
    [4] = {
      x = 20,
      y = -254,
      x2 = -21.7,
      y2 = 251.3,
      w = 393,
      h = 412,
      ax = 0,
      ay = 0,
      aw = 250,
      ah = 250,
      px = -88.3,
      py = 101.3
    },
    [5] = {
      x = 427,
      y = -7,
      x2 = -441.6,
      y2 = 0,
      w = 639,
      h = 877,
      ax = 0,
      ay = 0,
      aw = 450,
      ah = 450,
      px = -88.8,
      py = 330
    }
  },
  {
    [1] = {
      s = "main_prec_comic2_select1",
      f = "main_prec_comic2_mask1",
      bg = "main_prec_comic_mask1"
    },
    [2] = {
      s = "main_prec_comic2_select2",
      f = "main_prec_comic2_mask2",
      bg = "main_prec_comic_mask2"
    },
    [3] = {
      s = "main_prec_comic2_select3",
      f = "main_prec_comic2_mask3",
      bg = "main_prec_comic_mask3"
    },
    [4] = {
      s = "main_prec_comic2_select4",
      f = "main_prec_comic2_mask4",
      bg = "main_prec_comic_mask4"
    },
    [5] = {
      s = "main_prec_comic2_select5",
      f = "main_prec_comic2_mask5",
      bg = "main_prec_comic_mask5"
    }
  },
  {
    enter = "main_open_di6",
    bg = "main_prec_frame_bg5",
    colorLeftTime = {
      142,
      9,
      9,
      255
    },
    bgTitle = "main_prec_bg5_mask"
  },
  {
    [1] = {
      x = -438,
      y = 220,
      x2 = 440,
      y2 = -232,
      w = 623,
      h = 423,
      ax = 0,
      ay = 0,
      aw = 250,
      ah = 250,
      px = -205,
      py = 105
    },
    [2] = {
      x = -416,
      y = -178,
      x2 = 418,
      y2 = 167,
      w = 667,
      h = 543,
      ax = 0,
      ay = 0,
      aw = 250,
      ah = 250,
      px = -229,
      py = 140
    },
    [3] = {
      x = 31,
      y = 163,
      x2 = -34,
      y2 = -174,
      w = 499,
      h = 537,
      ax = 0,
      ay = 0,
      aw = 350,
      ah = 350,
      px = -125.2,
      py = 159
    },
    [4] = {
      x = 20,
      y = -254,
      x2 = -21,
      y2 = 250,
      w = 393,
      h = 412,
      ax = 0,
      ay = 0,
      aw = 250,
      ah = 250,
      px = -88.3,
      py = 101.3
    },
    [5] = {
      x = 427,
      y = -7,
      x2 = -430,
      y2 = -4,
      w = 639,
      h = 877,
      ax = 0,
      ay = 0,
      aw = 450,
      ah = 450,
      px = -88.8,
      py = 330
    }
  },
  {
    [1] = {
      s = "main_prec_comic5_select1",
      f = "main_prec_comic5_mask1",
      bg = "main_prec_comic_mask1"
    },
    [2] = {
      s = "main_prec_comic5_select2",
      f = "main_prec_comic5_mask2",
      bg = "main_prec_comic_mask2"
    },
    [3] = {
      s = "main_prec_comic5_select3",
      f = "main_prec_comic5_mask3",
      bg = "main_prec_comic_mask3"
    },
    [4] = {
      s = "main_prec_comic5_select4",
      f = "main_prec_comic5_mask4",
      bg = "main_prec_comic_mask4"
    },
    [5] = {
      s = "main_prec_comic5_select5",
      f = "main_prec_comic5_mask5",
      bg = "main_prec_comic_mask5"
    }
  },
  {
    [1] = {
      x = -527,
      y = 259.5,
      w = 405,
      h = 327,
      ax = 33,
      ay = -13,
      aw = 200,
      ah = 200,
      px = -105,
      py = 59
    },
    [2] = {
      x = -497,
      y = -135,
      w = 466,
      h = 577,
      ax = 0,
      ay = 0,
      aw = 250,
      ah = 250,
      px = -130,
      py = 166
    },
    [3] = {
      x = -53,
      y = 216.7,
      w = 684,
      h = 413,
      ax = 0,
      ay = 0,
      aw = 350,
      ah = 350,
      px = -229,
      py = 104
    },
    [4] = {
      x = -58,
      y = -186,
      w = 589,
      h = 476,
      ax = 0,
      ay = 0,
      aw = 250,
      ah = 250,
      px = -191,
      py = 143
    },
    [5] = {
      x = 433,
      y = -0.9,
      w = 591,
      h = 849,
      ax = 0,
      ay = 0,
      aw = 450,
      ah = 450,
      px = -81.3,
      py = 322.7
    }
  },
  {
    [1] = {
      s = "main_prec_comic10_select1",
      f = "main_prec_comic10_mask1",
      comic = "main_prec_comic10_1",
      bg = "main_prec_comic_mask16"
    },
    [2] = {
      s = "main_prec_comic10_select2",
      f = "main_prec_comic10_mask2",
      comic = "main_prec_comic10_2",
      bg = "main_prec_comic_mask17"
    },
    [3] = {
      s = "main_prec_comic10_select3",
      f = "main_prec_comic10_mask3",
      comic = "main_prec_comic10_3",
      bg = "main_prec_comic_mask18"
    },
    [4] = {
      s = "main_prec_comic10_select4",
      f = "main_prec_comic10_mask4",
      comic = "main_prec_comic10_4",
      bg = "main_prec_comic_mask19"
    },
    [5] = {
      s = "main_prec_comic10_select5",
      f = "main_prec_comic10_mask5",
      comic = "main_prec_comic10_5",
      bg = "main_prec_comic_mask20"
    }
  },
  {
    [1] = {
      s = "main_prec_comic22_select1",
      f = "main_prec_comic22_di1",
      comic = "main_prec_comic22_1",
      bg = "main_prec_comic22_di1"
    },
    [2] = {
      s = "main_prec_comic22_select2",
      f = "main_prec_comic22_di2",
      comic = "main_prec_comic22_2",
      bg = "main_prec_comic22_di2"
    },
    [3] = {
      s = "main_prec_comic22_select3",
      f = "main_prec_comic22_di3",
      comic = "main_prec_comic22_3",
      bg = "main_prec_comic22_di3"
    },
    [4] = {
      s = "main_prec_comic22_select4",
      f = "main_prec_comic22_di4",
      comic = "main_prec_comic22_4",
      bg = "main_prec_comic22_di4"
    },
    [5] = {
      s = "main_prec_comic22_select5",
      f = "main_prec_comic22_di5",
      comic = "main_prec_comic22_5",
      bg = "main_prec_comic22_di5"
    }
  },
  {
    [1] = {
      s = "main_prec_comic23_select1",
      f = "main_prec_comic23_di1",
      comic = "main_prec_comic23_1",
      bg = "main_prec_comic23_di1"
    },
    [2] = {
      s = "main_prec_comic23_select2",
      f = "main_prec_comic23_di2",
      comic = "main_prec_comic23_2",
      bg = "main_prec_comic23_di2"
    },
    [3] = {
      s = "main_prec_comic23_select3",
      f = "main_prec_comic23_di3",
      comic = "main_prec_comic23_3",
      bg = "main_prec_comic23_di3"
    },
    [4] = {
      s = "main_prec_comic23_select4",
      f = "main_prec_comic23_di4",
      comic = "main_prec_comic23_4",
      bg = "main_prec_comic23_di4"
    },
    [5] = {
      s = "main_prec_comic23_select5",
      f = "main_prec_comic23_di5",
      comic = "main_prec_comic23_5",
      bg = "main_prec_comic23_di5"
    }
  },
  {
    [1] = {
      s = "main_prec_comic25_select1",
      f = "main_prec_comic25_di1",
      comic = "main_prec_comic25_1",
      bg = "main_prec_comic25_di1"
    },
    [2] = {
      s = "main_prec_comic25_select2",
      f = "main_prec_comic25_di2",
      comic = "main_prec_comic25_2",
      bg = "main_prec_comic25_di2"
    },
    [3] = {
      s = "main_prec_comic25_select3",
      f = "main_prec_comic25_di3",
      comic = "main_prec_comic25_3",
      bg = "main_prec_comic25_di3"
    },
    [4] = {
      s = "main_prec_comic25_select4",
      f = "main_prec_comic25_di4",
      comic = "main_prec_comic25_4",
      bg = "main_prec_comic25_di4"
    },
    [5] = {
      s = "main_prec_comic25_select5",
      f = "main_prec_comic25_di5",
      comic = "main_prec_comic25_5",
      bg = "main_prec_comic25_di5"
    }
  },
  {
    [1] = {
      x = -455,
      y = 330.7,
      w = 472,
      h = 406,
      ax = -11,
      ay = 18,
      aw = 225,
      ah = 225,
      px = -159,
      py = 122
    },
    [2] = {
      x = 3,
      y = 319,
      w = 553,
      h = 426,
      ax = -16,
      ay = 21,
      aw = 250,
      ah = 250,
      px = -187,
      py = 134
    },
    [3] = {
      x = 454,
      y = 306,
      w = 546,
      h = 456,
      ax = 29,
      ay = 25,
      aw = 250,
      ah = 250,
      px = -104,
      py = 148
    },
    [4] = {
      x = -429,
      y = -59,
      w = 527,
      h = 410,
      ax = -39,
      ay = -9,
      aw = 275,
      ah = 275,
      px = -185,
      py = 123
    },
    [5] = {
      x = 254,
      y = -67,
      w = 944,
      h = 387,
      ax = -21,
      ay = -13,
      aw = 275,
      ah = 275,
      px = -378,
      py = 112
    }
  }
}
local empty = {}
local config = {
  [1000001] = {
    1000001,
    {
      enter = "main_open_di1",
      bg = "main_prec_frame9"
    },
    {
      [1] = {
        x = -784,
        y = 176,
        x2 = 0,
        y2 = 0,
        w = 1010,
        h = 314,
        ax = 142,
        ay = 25,
        aw = 250,
        ah = 250,
        px = 415,
        py = 62
      },
      [2] = {
        x = -772,
        y = -119,
        x2 = 0,
        y2 = 0,
        w = 1035,
        h = 430,
        ax = 142,
        ay = 0,
        aw = 250,
        ah = 250,
        px = 408,
        py = 110
      },
      [3] = {
        x = 62,
        y = 142,
        x2 = 0,
        y2 = 0,
        w = 770,
        h = 382,
        ax = 0,
        ay = 0,
        aw = 350,
        ah = 350,
        px = -284,
        py = 97
      },
      [4] = {
        x = 63,
        y = -175,
        x2 = 0,
        y2 = 0,
        w = 726,
        h = 318,
        ax = 0,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -257,
        py = 62
      },
      [5] = {
        x = 834.5,
        y = 0,
        x2 = 0,
        y2 = 0,
        w = 911,
        h = 668,
        ax = -142,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -316,
        py = 225
      }
    },
    {
      [1] = {
        petId = 1600021,
        x = 313,
        y = -150
      }
    },
    common[6],
    empty,
    empty,
    60,
    {
      {3000002, 70000}
    },
    60,
    {
      {3202032, 10}
    },
    60,
    {
      {3100003, 4}
    },
    60,
    {
      {3232104, 3}
    },
    60,
    {
      {3000003, 1000}
    }
  },
  [1000002] = {
    1000002,
    {
      enter = "main_open_di2",
      bg = "main_prec_frame9"
    },
    {
      [1] = {
        x = -459.5,
        y = 227.2,
        x2 = 451.3,
        y2 = -237.3,
        w = 636,
        h = 429,
        ax = 0,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -211.7,
        py = 108
      },
      [2] = {
        x = -435.2,
        y = -183.8,
        x2 = 426.8,
        y2 = 173.4,
        w = 683,
        h = 554,
        ax = 0,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -236.6,
        py = 149.9
      },
      [3] = {
        x = 25,
        y = 167.7,
        x2 = -32.7,
        y2 = -178.6,
        w = 508,
        h = 548,
        ax = 0,
        ay = 0,
        aw = 350,
        ah = 350,
        px = -125.2,
        py = 167.8
      },
      [4] = {
        x = 14.5,
        y = -251.8,
        x2 = -21.7,
        y2 = 251.3,
        w = 397,
        h = 418,
        ax = 0,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -88.3,
        py = 101.3
      },
      [5] = {
        x = 433.5,
        y = -9.8,
        x2 = -441.6,
        y2 = 0,
        w = 654,
        h = 902,
        ax = 0,
        ay = 0,
        aw = 450,
        ah = 450,
        px = -88.8,
        py = 344.8
      }
    },
    empty,
    common[6],
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000003] = {
    1000003,
    {
      enter = "main_open_di3",
      bg = "main_prec_frame_bg2",
      colorLeftTime = {
        217,
        35,
        112,
        255
      }
    },
    common[7],
    empty,
    common[8],
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000004] = {
    1000004,
    {
      enter = "main_open_di3",
      bg = "main_prec_frame_bg2"
    },
    common[7],
    empty,
    common[8],
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000005] = {
    1000005,
    common[9],
    common[10],
    empty,
    common[11],
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000006] = {
    1000006,
    common[9],
    common[10],
    empty,
    common[11],
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000007] = {
    1000007,
    {
      enter = "main_open_di8",
      bg = "main_prec_frame_bg7",
      colorLeftTime = {
        175,
        100,
        52,
        255
      },
      bgTitle = "main_prec_bg7_mask"
    },
    common[10],
    empty,
    {
      [1] = {
        s = "main_prec_comic7_select1",
        f = "main_prec_comic7_mask1",
        bg = "main_prec_comic_mask1"
      },
      [2] = {
        s = "main_prec_comic7_select2",
        f = "main_prec_comic7_mask2",
        bg = "main_prec_comic_mask2"
      },
      [3] = {
        s = "main_prec_comic7_select3",
        f = "main_prec_comic7_mask3",
        bg = "main_prec_comic_mask3"
      },
      [4] = {
        s = "main_prec_comic7_select4",
        f = "main_prec_comic7_mask4",
        bg = "main_prec_comic_mask4"
      },
      [5] = {
        s = "main_prec_comic7_select5",
        f = "main_prec_comic7_mask5",
        bg = "main_prec_comic_mask5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000008] = {
    1000008,
    {
      prefab = "UIPetForecast2",
      enter = "n9_prev_zjm_ent",
      bg = "n9_prev_bg",
      colorLeftTime = {
        254,
        135,
        35
      },
      imgTitle = "n9_prev_title"
    },
    {
      [1] = {
        x = -564,
        y = 89,
        w = 419,
        h = 323,
        ax = 49,
        ay = 1,
        aw = 200,
        ah = 200,
        px = -116,
        py = 41
      },
      [2] = {
        x = -512,
        y = -222,
        w = 480,
        h = 374,
        ax = 3,
        ay = -16,
        aw = 250,
        ah = 250,
        px = -135,
        py = 57
      },
      [3] = {
        x = -99,
        y = 131,
        w = 572,
        h = 444,
        ax = 47,
        ay = -12,
        aw = 280,
        ah = 280,
        px = -138,
        py = 86
      },
      [4] = {
        x = -42,
        y = -263,
        w = 532,
        h = 412,
        ax = 25,
        ay = 6,
        aw = 300,
        ah = 300,
        px = -126,
        py = 64
      },
      [5] = {
        x = 478,
        y = 153,
        w = 651,
        h = 492,
        ax = 2,
        ay = 25,
        aw = 360,
        ah = 360,
        px = -139,
        py = 93
      },
      [6] = {
        x = 502,
        y = -263,
        w = 619,
        h = 433,
        ax = -9,
        ay = 1,
        aw = 360,
        ah = 360,
        px = -179,
        py = 69
      }
    },
    empty,
    {
      [1] = {
        s = "n9_prev_click1",
        f = "n9_prev_cover1",
        bg = "n9_prev_close1",
        comic = "n9_prev_tu1",
        sentence = "n9_prev_subtit1"
      },
      [2] = {
        s = "n9_prev_click2",
        f = "n9_prev_cover2",
        bg = "n9_prev_close2",
        comic = "n9_prev_tu2",
        sentence = "n9_prev_subtit2"
      },
      [3] = {
        s = "n9_prev_click3",
        f = "n9_prev_cover3",
        bg = "n9_prev_close3",
        comic = "n9_prev_tu3",
        sentence = "n9_prev_subtit3"
      },
      [4] = {
        s = "n9_prev_click4",
        f = "n9_prev_cover4",
        bg = "n9_prev_close4",
        comic = "n9_prev_tu4",
        sentence = "n9_prev_subtit4"
      },
      [5] = {
        s = "n9_prev_click5",
        f = "n9_prev_cover5",
        bg = "n9_prev_close5",
        comic = "n9_prev_tu5",
        sentence = "n9_prev_subtit5"
      },
      [6] = {
        s = "n9_prev_click6",
        f = "n9_prev_cover6",
        bg = "n9_prev_close6",
        comic = "n9_prev_tu6",
        sentence = "n9_prev_subtit6"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    {
      {3400049, 1}
    },
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000009] = {
    1000009,
    {
      enter = "main_open_di10",
      bg = "main_prec_frame_bg8",
      colorLeftTime = {
        255,
        255,
        255,
        255
      },
      bgTitle = "main_prec_bg8_mask",
      imgLeftTime = "main_prec_timebg1",
      colorLeftTimeBG = {
        255,
        255,
        255,
        255
      },
      colorLeftTimeHint = {
        33,
        126,
        14,
        255
      },
      titleRect = {
        x = 0,
        y = -394.6,
        w = 1800,
        h = 196
      }
    },
    {
      [1] = {
        x = -435.3,
        y = 226.8,
        x2 = 437.6,
        y2 = -226.8,
        w = 623,
        h = 423,
        ax = 0,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -205,
        py = 105
      },
      [2] = {
        x = -413.7,
        y = -168.2,
        x2 = 417.3,
        y2 = 165,
        w = 667,
        h = 543,
        ax = 0,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -229,
        py = 140
      },
      [3] = {
        x = 32.2,
        y = 169.2,
        x2 = -33.3,
        y2 = -167.8,
        w = 499,
        h = 537,
        ax = 0,
        ay = 0,
        aw = 350,
        ah = 350,
        px = -125.2,
        py = 159
      },
      [4] = {
        x = 21.7,
        y = -233.5,
        x2 = -16.8,
        y2 = 233.9,
        w = 393,
        h = 412,
        ax = 0,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -88.3,
        py = 101.3
      },
      [5] = {
        x = 425.1,
        y = 1.5,
        x2 = -422.6,
        y2 = -1.1,
        w = 639,
        h = 877,
        ax = 0,
        ay = 0,
        aw = 450,
        ah = 450,
        px = -88.8,
        py = 330
      }
    },
    empty,
    {
      [1] = {
        s = "main_prec_comic8_select1",
        f = "main_prec_comic8_mask1",
        comic = "n9_prev_tu1",
        bg = "main_prec_comic_mask1"
      },
      [2] = {
        s = "main_prec_comic8_select2",
        f = "main_prec_comic8_mask2",
        comic = "n9_prev_tu1",
        bg = "main_prec_comic_mask2"
      },
      [3] = {
        s = "main_prec_comic8_select3",
        f = "main_prec_comic8_mask3",
        comic = "n9_prev_tu1",
        bg = "main_prec_comic_mask3"
      },
      [4] = {
        s = "main_prec_comic8_select4",
        f = "main_prec_comic8_mask4",
        comic = "n9_prev_tu1",
        bg = "main_prec_comic_mask4"
      },
      [5] = {
        s = "main_prec_comic8_select5",
        f = "main_prec_comic8_mask5",
        comic = "n9_prev_tu1",
        bg = "main_prec_comic_mask5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000010] = {
    1000010,
    {
      enter = "main_open_di11",
      bg = "main_prec_frame_bg9",
      colorLeftTime = {
        140,
        170,
        66,
        255
      },
      bgTitle = "main_prec_bg9_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        140,
        170,
        66,
        255
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      titleRect = {
        x = 1,
        y = -394.6,
        w = 1800,
        h = 196
      }
    },
    common[12],
    empty,
    {
      [1] = {
        s = "main_prec_comic9_select1",
        f = "main_prec_comic9_mask1",
        comic = "main_prec_comic9_1",
        bg = "main_prec_comic_mask16"
      },
      [2] = {
        s = "main_prec_comic9_select2",
        f = "main_prec_comic9_mask2",
        comic = "main_prec_comic9_2",
        bg = "main_prec_comic_mask17"
      },
      [3] = {
        s = "main_prec_comic9_select3",
        f = "main_prec_comic9_mask3",
        comic = "main_prec_comic9_3",
        bg = "main_prec_comic_mask18"
      },
      [4] = {
        s = "main_prec_comic9_select4",
        f = "main_prec_comic9_mask4",
        comic = "main_prec_comic9_4",
        bg = "main_prec_comic_mask19"
      },
      [5] = {
        s = "main_prec_comic9_select5",
        f = "main_prec_comic9_mask5",
        comic = "main_prec_comic9_5",
        bg = "main_prec_comic_mask20"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000011] = {
    1000011,
    {
      enter = "main_open_di12",
      bg = "main_prec_frame_bg10",
      colorLeftTime = {
        228,
        55,
        56,
        255
      },
      bgTitle = "main_prec_bg10_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        228,
        55,
        56,
        255
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      titleRect = {
        x = 1,
        y = -394.6,
        w = 1800,
        h = 196
      },
      colorUnlock = {
        99,
        99,
        99,
        99
      }
    },
    common[12],
    empty,
    common[13],
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000012] = {
    1000012,
    {
      enter = "main_open_di12",
      bg = "main_prec_frame_bg10",
      colorLeftTime = {
        228,
        55,
        56,
        255
      },
      bgTitle = "main_prec_bg10_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        228,
        55,
        56,
        255
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      titleRect = {
        x = 1,
        y = -394.6,
        w = 1800,
        h = 196
      }
    },
    common[12],
    empty,
    common[13],
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000013] = {
    1000013,
    {
      enter = "main_open_di14",
      bg = "main_prec_frame_bg12",
      colorLeftTime = {
        214,
        204,
        153,
        255
      },
      bgTitle = "main_prec_bg12_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        214,
        204,
        153,
        255
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      titleRect = {
        x = 1,
        y = -394.6,
        w = 1800,
        h = 196
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -508,
        y = 184.7,
        w = 457,
        h = 492,
        ax = 33,
        ay = -13,
        aw = 200,
        ah = 200,
        px = -125,
        py = 128
      },
      [2] = {
        x = -486,
        y = -210,
        w = 500,
        h = 441,
        ax = 0,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -145,
        py = 109
      },
      [3] = {
        x = -43,
        y = 220,
        w = 683,
        h = 421,
        ax = 0,
        ay = 0,
        aw = 350,
        ah = 350,
        px = -229,
        py = 88
      },
      [4] = {
        x = -46,
        y = -180,
        w = 591,
        h = 503,
        ax = 0,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -180,
        py = 139
      },
      [5] = {
        x = 435,
        y = 0,
        w = 603,
        h = 862,
        ax = 0,
        ay = 0,
        aw = 450,
        ah = 450,
        px = -90,
        py = 313
      }
    },
    empty,
    {
      [1] = {
        s = "main_prec_comic12_select1",
        f = "main_prec_comic12_mask1",
        comic = "main_prec_comic12_1",
        bg = "main_prec_comic12_mask1"
      },
      [2] = {
        s = "main_prec_comic12_select2",
        f = "main_prec_comic12_mask2",
        comic = "main_prec_comic12_2",
        bg = "main_prec_comic12_mask2"
      },
      [3] = {
        s = "main_prec_comic12_select3",
        f = "main_prec_comic12_mask3",
        comic = "main_prec_comic12_3",
        bg = "main_prec_comic12_mask3"
      },
      [4] = {
        s = "main_prec_comic12_select4",
        f = "main_prec_comic12_mask4",
        comic = "main_prec_comic12_4",
        bg = "main_prec_comic12_mask4"
      },
      [5] = {
        s = "main_prec_comic12_select5",
        f = "main_prec_comic12_mask5",
        comic = "main_prec_comic12_5",
        bg = "main_prec_comic12_mask5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000016] = {
    1000016,
    {
      enter = "main_open_di17",
      bg = "main_prec_frame_bg15",
      colorLeftTime = {
        225,
        204,
        153,
        255
      },
      bgTitle = "main_prec_bg15_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        225,
        204,
        153,
        255
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      titleRect = {
        x = 1,
        y = -394.6,
        w = 1800,
        h = 196
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -458,
        y = 230,
        w = 554,
        h = 399,
        ax = -5,
        ay = -19,
        aw = 254,
        ah = 254,
        px = -168,
        py = 91
      },
      [2] = {
        x = -428,
        y = -167,
        w = 615,
        h = 508,
        ax = -23,
        ay = -2,
        aw = 345,
        ah = 345,
        px = -199,
        py = 148
      },
      [3] = {
        x = 33,
        y = 181,
        w = 630,
        h = 498,
        ax = 0,
        ay = 0,
        aw = 300,
        ah = 300,
        px = -201,
        py = 143
      },
      [4] = {
        x = 30,
        y = -214,
        w = 504,
        h = 414,
        ax = 0,
        ay = 0,
        aw = 230,
        ah = 230,
        px = -142,
        py = 97
      },
      [5] = {
        x = 492,
        y = 258,
        w = 489,
        h = 365,
        ax = 0,
        ay = 0,
        aw = 214,
        ah = 214,
        px = -101,
        py = 78
      },
      [6] = {
        x = 455,
        y = -150,
        w = 562,
        h = 542,
        ax = 9,
        ay = 1,
        aw = 359,
        ah = 359,
        px = -113,
        py = 159
      }
    },
    empty,
    {
      [1] = {
        s = "main_prec_comic15_select1",
        f = "main_prec_comic15_mask1",
        comic = "main_prec_comic15_1",
        bg = "main_prec_comic15_mask1"
      },
      [2] = {
        s = "main_prec_comic15_select2",
        f = "main_prec_comic15_mask2",
        comic = "main_prec_comic15_2",
        bg = "main_prec_comic15_mask2"
      },
      [3] = {
        s = "main_prec_comic15_select3",
        f = "main_prec_comic15_mask3",
        comic = "main_prec_comic15_3",
        bg = "main_prec_comic15_mask3"
      },
      [4] = {
        s = "main_prec_comic15_select4",
        f = "main_prec_comic15_mask4",
        comic = "main_prec_comic15_4",
        bg = "main_prec_comic15_mask4"
      },
      [5] = {
        s = "main_prec_comic15_select5",
        f = "main_prec_comic15_mask5",
        comic = "main_prec_comic15_5",
        bg = "main_prec_comic15_mask5"
      },
      [6] = {
        s = "main_prec_comic15_select6",
        f = "main_prec_comic15_mask6",
        comic = "main_prec_comic15_6",
        bg = "main_prec_comic15_mask6"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    {
      {3400068, 1}
    },
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000017] = {
    1000017,
    {
      enter = "main_open_di18",
      bg = "main_prec_frame_bg18",
      colorLeftTime = {
        111,
        212,
        231,
        255
      },
      bgTitle = "main_prec_bg6_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        111,
        212,
        231,
        255
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      titleRect = {
        x = 1,
        y = -394.6,
        w = 1800,
        h = 196
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -422,
        y = 228,
        w = 607,
        h = 386,
        ax = 33,
        ay = -13,
        aw = 200,
        ah = 200,
        px = -210,
        py = 94
      },
      [2] = {
        x = -463,
        y = -158,
        w = 525,
        h = 522,
        ax = 0,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -170,
        py = 146
      },
      [3] = {
        x = 42,
        y = 127,
        w = 647,
        h = 588,
        ax = 0,
        ay = 0,
        aw = 350,
        ah = 350,
        px = -110,
        py = 196
      },
      [4] = {
        x = 27,
        y = -260,
        w = 734,
        h = 326,
        ax = 0,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -219,
        py = 31
      },
      [5] = {
        x = 504,
        y = 1,
        w = 445,
        h = 843,
        ax = 0,
        ay = 0,
        aw = 450,
        ah = 450,
        px = -117,
        py = 319
      }
    },
    empty,
    {
      [1] = {
        s = "main_prec_comic18_select1",
        f = "main_prec_comic18_di1",
        comic = "main_prec_comic18_1",
        bg = "main_prec_comic18_di1"
      },
      [2] = {
        s = "main_prec_comic18_select2",
        f = "main_prec_comic18_di2",
        comic = "main_prec_comic18_2",
        bg = "main_prec_comic18_di2"
      },
      [3] = {
        s = "main_prec_comic18_select3",
        f = "main_prec_comic18_di3",
        comic = "main_prec_comic18_3",
        bg = "main_prec_comic18_di3"
      },
      [4] = {
        s = "main_prec_comic18_select4",
        f = "main_prec_comic18_di4",
        comic = "main_prec_comic18_4",
        bg = "main_prec_comic18_di4"
      },
      [5] = {
        s = "main_prec_comic18_select5",
        f = "main_prec_comic18_di5",
        comic = "main_prec_comic18_5",
        bg = "main_prec_comic18_di5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000019] = {
    1000019,
    {
      enter = "main_open_di20",
      bg = "main_prec_frame_bg20",
      colorLeftTime = {
        111,
        212,
        231,
        255
      },
      bgTitle = "main_prec_bg20_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        111,
        212,
        231,
        255
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      titleRect = {
        x = 2,
        y = -394.6,
        w = 1800,
        h = 196
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -445,
        y = 259,
        w = 617,
        h = 404,
        ax = -27,
        ay = 19,
        aw = 200,
        ah = 200,
        px = -183,
        py = 69
      },
      [2] = {
        x = -468,
        y = -120,
        w = 588,
        h = 667,
        ax = -27,
        ay = -18,
        aw = 250,
        ah = 250,
        px = -157,
        py = 114
      },
      [3] = {
        x = 26,
        y = 159,
        w = 669,
        h = 584,
        ax = 5,
        ay = 3,
        aw = 350,
        ah = 350,
        px = -105,
        py = 163
      },
      [4] = {
        x = 21,
        y = -221,
        w = 778,
        h = 440,
        ax = 3,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -192,
        py = 56
      },
      [5] = {
        x = 489,
        y = 1,
        w = 548,
        h = 898,
        ax = 8,
        ay = 23,
        aw = 450,
        ah = 450,
        px = -125,
        py = 321
      }
    },
    empty,
    {
      [1] = {
        s = "main_prec_comic20_select1",
        f = "main_prec_comic20_di1",
        comic = "main_prec_comic20_1",
        bg = "main_prec_comic20_di1"
      },
      [2] = {
        s = "main_prec_comic20_select2",
        f = "main_prec_comic20_di2",
        comic = "main_prec_comic20_2",
        bg = "main_prec_comic20_di2"
      },
      [3] = {
        s = "main_prec_comic20_select3",
        f = "main_prec_comic20_di3",
        comic = "main_prec_comic20_3",
        bg = "main_prec_comic20_di3"
      },
      [4] = {
        s = "main_prec_comic20_select4",
        f = "main_prec_comic20_di4",
        comic = "main_prec_comic20_4",
        bg = "main_prec_comic20_di4"
      },
      [5] = {
        s = "main_prec_comic20_select5",
        f = "main_prec_comic20_di5",
        comic = "main_prec_comic20_5",
        bg = "main_prec_comic20_di5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000020] = {
    1000020,
    {
      enter = "main_open_di21",
      bg = "main_prec_frame_bg21",
      colorLeftTime = {
        111,
        212,
        231,
        255
      },
      bgTitle = "main_prec_bg21_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        111,
        212,
        231,
        255
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      titleRect = {
        x = 0,
        y = -394.6,
        w = 1800,
        h = 196
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -442,
        y = 256.8,
        w = 558,
        h = 321,
        ax = -27,
        ay = 19,
        aw = 200,
        ah = 200,
        px = -179,
        py = 59
      },
      [2] = {
        x = -467,
        y = -132,
        w = 508,
        h = 572,
        ax = -27,
        ay = -18,
        aw = 250,
        ah = 250,
        px = -147,
        py = 166
      },
      [3] = {
        x = 27.5,
        y = 169,
        w = 588,
        h = 496,
        ax = 5,
        ay = 3,
        aw = 350,
        ah = 350,
        px = -117,
        py = 150
      },
      [4] = {
        x = 12.5,
        y = -225,
        w = 674,
        h = 387,
        ax = 3,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -194,
        py = 68
      },
      [5] = {
        x = 491,
        y = 0,
        w = 460,
        h = 835,
        ax = 8,
        ay = 23,
        aw = 450,
        ah = 450,
        px = -125,
        py = 321
      }
    },
    empty,
    {
      [1] = {
        s = "main_prec_comic21_select_1",
        f = "main_prec_comic21_di_1",
        comic = "main_prec_comic21_1",
        bg = "main_prec_comic21_di_1"
      },
      [2] = {
        s = "main_prec_comic21_select_2",
        f = "main_prec_comic21_di_2",
        comic = "main_prec_comic21_2",
        bg = "main_prec_comic21_di_2"
      },
      [3] = {
        s = "main_prec_comic21_select_3",
        f = "main_prec_comic21_di_3",
        comic = "main_prec_comic21_3",
        bg = "main_prec_comic21_di_3"
      },
      [4] = {
        s = "main_prec_comic21_select_4",
        f = "main_prec_comic21_di_4",
        comic = "main_prec_comic21_4",
        bg = "main_prec_comic21_di_4"
      },
      [5] = {
        s = "main_prec_comic21_select_5",
        f = "main_prec_comic21_di_5",
        comic = "main_prec_comic21_5",
        bg = "main_prec_comic21_di_5"
      }
    },
    {
      last = {
        [1] = {
          [1] = "Wait,1000",
          [2] = "PlayEffect,eff_UIPetForecas_in,effNodeTop",
          [3] = "PlayAudio,10099",
          [4] = "Wait,500",
          [5] = "PlayAudio,10100",
          [6] = "ReplaceImage",
          [7] = "PlayEffect,UIEff_ruqin,effNodeUnderPiece"
        }
      },
      normal = {
        [1] = {
          [1] = "PlayAudio,10100",
          [2] = "PlayEffect,UIEff_ruqin,effNodeUnderPiece",
          [3] = "ReplaceImage"
        }
      },
      close = {
        [1] = {
          [1] = "PlayEffect,UIEff_ganrao,effNodeTop",
          [2] = "Wait,1000"
        }
      }
    },
    common[14],
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000021] = {
    1000021,
    {
      enter = "main_open_di22",
      bg = "main_prec_frame_bg22",
      colorLeftTime = {
        171,
        165,
        153,
        255
      },
      bgTitle = "main_prec_bg22_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        171,
        165,
        153,
        255
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      titleRect = {
        x = 0,
        y = -394.6,
        w = 1804,
        h = 196
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -515,
        y = 232.3,
        w = 442,
        h = 395,
        ax = -16,
        ay = -20,
        aw = 200,
        ah = 200,
        px = -121,
        py = 88
      },
      [2] = {
        x = -489,
        y = -160,
        w = 494,
        h = 522,
        ax = -27,
        ay = -11,
        aw = 250,
        ah = 250,
        px = -141,
        py = 137
      },
      [3] = {
        x = -42,
        y = 182.4,
        w = 690,
        h = 496,
        ax = 5,
        ay = 3,
        aw = 350,
        ah = 350,
        px = -230,
        py = 142
      },
      [4] = {
        x = -49,
        y = -212,
        w = 578,
        h = 418,
        ax = 3,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -183,
        py = 98
      },
      [5] = {
        x = 436,
        y = 5,
        w = 600,
        h = 851,
        ax = 8,
        ay = 23,
        aw = 450,
        ah = 450,
        px = -94,
        py = 321
      }
    },
    empty,
    common[14],
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000022] = {
    1000022,
    {
      enter = "main_open_di23",
      bg = "main_prec_frame_bg23",
      colorLeftTime = {
        111,
        232,
        231,
        255
      },
      bgTitle = "main_prec_bg23_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        111,
        232,
        231,
        255
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      titleRect = {
        x = 0,
        y = -394.6,
        w = 1800,
        h = 196
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -447,
        y = 251,
        w = 617,
        h = 404,
        ax = -27,
        ay = 19,
        aw = 200,
        ah = 200,
        px = -179,
        py = 74
      },
      [2] = {
        x = -470,
        y = -121,
        w = 588,
        h = 667,
        ax = -27,
        ay = -18,
        aw = 250,
        ah = 250,
        px = -154,
        py = 135
      },
      [3] = {
        x = 28,
        y = 161,
        w = 669,
        h = 584,
        ax = 5,
        ay = 3,
        aw = 350,
        ah = 350,
        px = -113,
        py = 163
      },
      [4] = {
        x = 14,
        y = -225,
        w = 778,
        h = 440,
        ax = 3,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -185,
        py = 68
      },
      [5] = {
        x = 491,
        y = 2,
        w = 544,
        h = 898,
        ax = 8,
        ay = 23,
        aw = 450,
        ah = 450,
        px = -125,
        py = 323
      }
    },
    empty,
    common[15],
    {
      last = {
        [1] = {
          [1] = "PlayEffect,eff_UIPetForecas_in,effNodeTop",
          [2] = "PlayAudio,10099",
          [3] = "Wait,2000",
          [4] = "PlayAudio,10100",
          [5] = "ReplaceImage"
        }
      },
      normal = {
        [1] = {
          [1] = "PlayAudio,10100",
          [2] = "PlayEffect,eff_UIPetForecas_in,effNodeTop",
          [3] = "ReplaceImage"
        }
      },
      close = {
        [1] = {
          [1] = "PlayEffect,eff_UIPetForecas_out,effNodeTop",
          [2] = "PlayAnim,UICanvas",
          [3] = "Wait,200"
        }
      }
    },
    common[15],
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000023] = {
    1000023,
    {
      enter = "main_open_di25",
      bg = "main_prec_comic25_bg25",
      colorLeftTime = {
        161,
        238,
        234,
        255
      },
      bgTitle = "main_prec_comic25_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        161,
        238,
        234,
        255
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      titleRect = {
        x = 1,
        y = -394.6,
        w = 1802,
        h = 196
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -512.5,
        y = 215,
        w = 436,
        h = 420,
        ax = -14,
        ay = 4,
        aw = 250,
        ah = 250,
        px = -130,
        py = 114
      },
      [2] = {
        x = -488,
        y = -174,
        w = 484,
        h = 474,
        ax = -25,
        ay = -4,
        aw = 290,
        ah = 290,
        px = -144,
        py = 138
      },
      [3] = {
        x = -41.8,
        y = 221.5,
        w = 670,
        h = 409,
        ax = -4,
        ay = 5,
        aw = 290,
        ah = 290,
        px = -253,
        py = 109
      },
      [4] = {
        x = -46,
        y = -171,
        w = 578,
        h = 476,
        ax = 0,
        ay = 0,
        aw = 290,
        ah = 290,
        px = -185,
        py = 130
      },
      [5] = {
        x = 438,
        y = 7,
        w = 583,
        h = 838,
        ax = 0,
        ay = 0,
        aw = 430,
        ah = 430,
        px = -95,
        py = 319
      }
    },
    empty,
    common[16],
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000024] = {
    1000024,
    {
      enter = "main_open_di25",
      bg = "main_prec_frame_bg25",
      colorLeftTime = {
        253,
        221,
        239,
        255
      },
      bgTitle = "main_prec_bg25_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        253,
        221,
        239,
        255
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      titleRect = {
        x = 0,
        y = -394.6,
        w = 1802,
        h = 196
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -477,
        y = 167,
        w = 575,
        h = 544,
        ax = -14,
        ay = 4,
        aw = 250,
        ah = 250,
        px = -161,
        py = 160
      },
      [2] = {
        x = -477,
        y = -226,
        w = 534,
        h = 403,
        ax = -25,
        ay = -4,
        aw = 290,
        ah = 290,
        px = -166,
        py = 80
      },
      [3] = {
        x = 17,
        y = 230,
        w = 576,
        h = 423,
        ax = -4,
        ay = 5,
        aw = 290,
        ah = 290,
        px = -168,
        py = 97
      },
      [4] = {
        x = 14,
        y = -162,
        w = 648,
        h = 560,
        ax = 0,
        ay = 0,
        aw = 290,
        ah = 290,
        px = -178,
        py = 139
      },
      [5] = {
        x = 482,
        y = 7,
        w = 564,
        h = 904,
        ax = 0,
        ay = 0,
        aw = 430,
        ah = 430,
        px = -147,
        py = 321
      }
    },
    empty,
    common[16],
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    {
      {3400083, 1}
    },
    60,
    common[4],
    60,
    common[5]
  },
  [1000025] = {
    1000025,
    {
      enter = "main_open_di26",
      bg = "main_prec_frame_bg26",
      colorLeftTime = {
        183,
        75,
        37,
        265
      },
      bgTitle = "main_prec_bg26_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        183,
        75,
        37,
        265
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        265
      },
      titleRect = {
        x = 0,
        y = -394.5,
        w = 1802,
        h = 196
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -514,
        y = 214,
        w = 436,
        h = 420,
        ax = -14,
        ay = 4,
        aw = 240,
        ah = 240,
        px = -124,
        py = 109
      },
      [2] = {
        x = -490,
        y = -173,
        w = 484,
        h = 474,
        ax = -26,
        ay = -4,
        aw = 290,
        ah = 290,
        px = -149,
        py = 130
      },
      [3] = {
        x = -44,
        y = 220.5,
        w = 670,
        h = 409,
        ax = -4,
        ay = 5,
        aw = 290,
        ah = 290,
        px = -228,
        py = 107
      },
      [4] = {
        x = -49,
        y = -171,
        w = 578,
        h = 476,
        ax = 0,
        ay = 0,
        aw = 290,
        ah = 290,
        px = -186,
        py = 139
      },
      [5] = {
        x = 436,
        y = 7,
        w = 591,
        h = 834,
        ax = 0,
        ay = 0,
        aw = 430,
        ah = 430,
        px = -95,
        py = 321
      }
    },
    empty,
    {
      [1] = {
        s = "main_prec_comic26_select1",
        f = "main_prec_comic26_di1",
        comic = "main_prec_comic26_1",
        bg = "main_prec_comic26_di1"
      },
      [2] = {
        s = "main_prec_comic26_select2",
        f = "main_prec_comic26_di2",
        comic = "main_prec_comic26_2",
        bg = "main_prec_comic26_di2"
      },
      [3] = {
        s = "main_prec_comic26_select3",
        f = "main_prec_comic26_di3",
        comic = "main_prec_comic26_3",
        bg = "main_prec_comic26_di3"
      },
      [4] = {
        s = "main_prec_comic26_select4",
        f = "main_prec_comic26_di4",
        comic = "main_prec_comic26_4",
        bg = "main_prec_comic26_di4"
      },
      [5] = {
        s = "main_prec_comic26_select5",
        f = "main_prec_comic26_di5",
        comic = "main_prec_comic26_5",
        bg = "main_prec_comic26_di5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000026] = {
    1000026,
    {
      enter = "main_open_di27",
      bg = "main_prec_frame_bg27",
      colorLeftTime = {
        54,
        177,
        255,
        275
      },
      bgTitle = "main_prec_bg27_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        54,
        177,
        255,
        275
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        275
      },
      titleRect = {
        x = 0,
        y = -394.5,
        w = 1802,
        h = 196
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -430,
        y = 258.1,
        w = 531,
        h = 302,
        ax = -14,
        ay = 4,
        aw = 240,
        ah = 240,
        px = -182,
        py = 61
      },
      [2] = {
        x = -454,
        y = -120,
        w = 483,
        h = 546,
        ax = -26,
        ay = -4,
        aw = 290,
        ah = 290,
        px = -159,
        py = 175
      },
      [3] = {
        x = 26,
        y = 172.5,
        w = 558,
        h = 471,
        ax = -4,
        ay = 5,
        aw = 290,
        ah = 290,
        px = -120,
        py = 147
      },
      [4] = {
        x = 12,
        y = -211,
        w = 643,
        h = 366,
        ax = 0,
        ay = 0,
        aw = 290,
        ah = 290,
        px = -185,
        py = 78
      },
      [5] = {
        x = 477,
        y = 8.3,
        w = 437,
        h = 803,
        ax = 0,
        ay = 0,
        aw = 430,
        ah = 430,
        px = -133,
        py = 311
      }
    },
    empty,
    {
      [1] = {
        s = "main_prec_comic27_select1",
        f = "main_prec_comic27_di1",
        comic = "main_prec_comic27_1",
        bg = "main_prec_comic27_di1"
      },
      [2] = {
        s = "main_prec_comic27_select2",
        f = "main_prec_comic27_di2",
        comic = "main_prec_comic27_2",
        bg = "main_prec_comic27_di2"
      },
      [3] = {
        s = "main_prec_comic27_select3",
        f = "main_prec_comic27_di3",
        comic = "main_prec_comic27_3",
        bg = "main_prec_comic27_di3"
      },
      [4] = {
        s = "main_prec_comic27_select4",
        f = "main_prec_comic27_di4",
        comic = "main_prec_comic27_4",
        bg = "main_prec_comic27_di4"
      },
      [5] = {
        s = "main_prec_comic27_select5",
        f = "main_prec_comic27_di5",
        comic = "main_prec_comic27_5",
        bg = "main_prec_comic27_di5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000027] = {
    1000027,
    {
      enter = "main_open_di28",
      bg = "main_prec_frame_bg28",
      colorLeftTime = {
        238,
        199,
        161,
        275
      },
      bgTitle = "main_prec_bg28_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        238,
        199,
        161,
        275
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        275
      },
      titleRect = {
        x = 0,
        y = -394.5,
        w = 1802,
        h = 196
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -485,
        y = 220,
        w = 465,
        h = 385,
        ax = -14,
        ay = 4,
        aw = 240,
        ah = 240,
        px = -154,
        py = 104
      },
      [2] = {
        x = -458,
        y = -174,
        w = 521,
        h = 443,
        ax = -26,
        ay = -4,
        aw = 290,
        ah = 290,
        px = -169,
        py = 135
      },
      [3] = {
        x = -14.4,
        y = 194,
        w = 598,
        h = 438,
        ax = -4,
        ay = 5,
        aw = 290,
        ah = 290,
        px = -205,
        py = 131
      },
      [4] = {
        x = 22,
        y = -191,
        w = 564,
        h = 407,
        ax = 0,
        ay = 0,
        aw = 290,
        ah = 290,
        px = -194,
        py = 91
      },
      [5] = {
        x = 484,
        y = 9,
        w = 463,
        h = 807,
        ax = 0,
        ay = 0,
        aw = 430,
        ah = 430,
        px = -146,
        py = 320
      }
    },
    empty,
    {
      [1] = {
        s = "main_prec_comic28_select1",
        f = "main_prec_comic28_di1",
        comic = "main_prec_comic28_1",
        bg = "main_prec_comic28_di1"
      },
      [2] = {
        s = "main_prec_comic28_select2",
        f = "main_prec_comic28_di2",
        comic = "main_prec_comic28_2",
        bg = "main_prec_comic28_di2"
      },
      [3] = {
        s = "main_prec_comic28_select3",
        f = "main_prec_comic28_di3",
        comic = "main_prec_comic28_3",
        bg = "main_prec_comic28_di3"
      },
      [4] = {
        s = "main_prec_comic28_select4",
        f = "main_prec_comic28_di4",
        comic = "main_prec_comic28_4",
        bg = "main_prec_comic28_di4"
      },
      [5] = {
        s = "main_prec_comic28_select5",
        f = "main_prec_comic28_di5",
        comic = "main_prec_comic28_5",
        bg = "main_prec_comic28_di5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000028] = {
    1000028,
    {
      enter = "main_open_di29",
      bg = "main_prec_frame_bg29",
      colorLeftTime = {
        105,
        137,
        255,
        275
      },
      bgTitle = "main_prec_bg29_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        105,
        137,
        255,
        275
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        275
      },
      titleRect = {
        x = 0,
        y = -439,
        w = 1802,
        h = 170
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      },
      mainBg = "main_prec_bgn0_n29"
    },
    {
      [1] = {
        x = -441.4,
        y = 239,
        w = 553,
        h = 346,
        ax = -14,
        ay = 4,
        aw = 240,
        ah = 240,
        px = -191,
        py = 89
      },
      [2] = {
        x = -469,
        y = -142,
        w = 495,
        h = 507,
        ax = -26,
        ay = -4,
        aw = 290,
        ah = 290,
        px = -155,
        py = 125
      },
      [3] = {
        x = 24.5,
        y = 204.7,
        w = 494,
        h = 412,
        ax = 47,
        ay = 40,
        aw = 290,
        ah = 290,
        px = -121,
        py = 121
      },
      [4] = {
        x = 11,
        y = -124,
        w = 649,
        h = 547,
        ax = 0,
        ay = 0,
        aw = 290,
        ah = 290,
        px = -166,
        py = 149
      },
      [5] = {
        x = 457,
        y = 9,
        w = 517,
        h = 807,
        ax = 0,
        ay = 0,
        aw = 430,
        ah = 430,
        px = -166,
        py = 320
      }
    },
    empty,
    {
      [1] = {
        s = "main_prec_comic29_select1",
        f = "main_prec_comic29_di1",
        comic = "main_prec_comic29_1",
        bg = "main_prec_comic29_di1"
      },
      [2] = {
        s = "main_prec_comic29_select2",
        f = "main_prec_comic29_di2",
        comic = "main_prec_comic29_2",
        bg = "main_prec_comic29_di2"
      },
      [3] = {
        s = "main_prec_comic29_select3",
        f = "main_prec_comic29_di3",
        comic = "main_prec_comic29_3",
        bg = "main_prec_comic29_di3"
      },
      [4] = {
        s = "main_prec_comic29_select4",
        f = "main_prec_comic29_di4",
        comic = "main_prec_comic29_4",
        bg = "main_prec_comic29_di4"
      },
      [5] = {
        s = "main_prec_comic29_select5",
        f = "main_prec_comic29_di5",
        comic = "main_prec_comic29_5",
        bg = "main_prec_comic29_di5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000029] = {
    1000029,
    {
      enter = "main_open_di30",
      bg = "main_prec_frame_bg30",
      colorLeftTime = {
        200,
        203,
        202,
        275
      },
      bgTitle = "main_prec_bg30_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        200,
        203,
        202,
        275
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        275
      },
      titleRect = {
        x = 0,
        y = -394.5,
        w = 1802,
        h = 196
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -483,
        y = 243,
        w = 469,
        h = 330,
        ax = -14,
        ay = 4,
        aw = 240,
        ah = 240,
        px = -152,
        py = 87
      },
      [2] = {
        x = -447,
        y = -152,
        w = 544,
        h = 489,
        ax = -26,
        ay = -4,
        aw = 290,
        ah = 290,
        px = -175,
        py = 166
      },
      [3] = {
        x = -9,
        y = 185,
        w = 607,
        h = 447,
        ax = 47,
        ay = 40,
        aw = 290,
        ah = 290,
        px = -193,
        py = 146
      },
      [4] = {
        x = 18,
        y = -210,
        w = 527,
        h = 371,
        ax = 0,
        ay = 0,
        aw = 290,
        ah = 290,
        px = -177,
        py = 107
      },
      [5] = {
        x = 488,
        y = 6,
        w = 467,
        h = 805,
        ax = 0,
        ay = 0,
        aw = 430,
        ah = 430,
        px = -128,
        py = 322
      }
    },
    empty,
    {
      [1] = {
        s = "main_prec_comic30_select1",
        f = "main_prec_comic30_di1",
        comic = "main_prec_comic30_1",
        bg = "main_prec_comic30_di1"
      },
      [2] = {
        s = "main_prec_comic30_select2",
        f = "main_prec_comic30_di2",
        comic = "main_prec_comic30_2",
        bg = "main_prec_comic30_di2"
      },
      [3] = {
        s = "main_prec_comic30_select3",
        f = "main_prec_comic30_di3",
        comic = "main_prec_comic30_3",
        bg = "main_prec_comic30_di3"
      },
      [4] = {
        s = "main_prec_comic30_select4",
        f = "main_prec_comic30_di4",
        comic = "main_prec_comic30_4",
        bg = "main_prec_comic30_di4"
      },
      [5] = {
        s = "main_prec_comic30_select5",
        f = "main_prec_comic30_di5",
        comic = "main_prec_comic30_5",
        bg = "main_prec_comic30_di5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000030] = {
    1000030,
    {
      enter = "main_open_di31",
      mainBg = "main_prec_bg31",
      bg = "main_prec_frame_bg31",
      titleRect = {
        x = 0,
        y = -408,
        w = 1811,
        h = 104
      },
      bgTitle = "main_prec_bg31_mask",
      imgLeftTime = "main_prec_timebg",
      colorLeftTimeHint = {
        0,
        0,
        0,
        275
      },
      colorLeftTime = {
        202,
        176,
        149,
        255
      },
      colorLeftTimeBG = {
        202,
        176,
        149,
        255
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -464,
        y = 181,
        w = 506,
        h = 465,
        ax = -14,
        ay = 4,
        aw = 240,
        ah = 240,
        px = -172,
        py = 140
      },
      [2] = {
        x = -473,
        y = -211,
        w = 487,
        h = 373,
        ax = -26,
        ay = -4,
        aw = 290,
        ah = 290,
        px = -164,
        py = 90
      },
      [3] = {
        x = 22,
        y = 219,
        w = 526,
        h = 387,
        ax = -11,
        ay = 24,
        aw = 290,
        ah = 290,
        px = -171,
        py = 106
      },
      [4] = {
        x = 25,
        y = -158,
        w = 568,
        h = 476,
        ax = 0,
        ay = -45,
        aw = 290,
        ah = 290,
        px = -181,
        py = 109
      },
      [5] = {
        x = 485,
        y = 182,
        w = 461,
        h = 464,
        ax = 0,
        ay = 0,
        aw = 430,
        ah = 430,
        px = -130,
        py = 146
      },
      [6] = {
        x = 496,
        y = -214,
        w = 440,
        h = 366,
        ax = -9,
        ay = 1,
        aw = 250,
        ah = 250,
        px = -132,
        py = 91
      }
    },
    empty,
    {
      [1] = {
        s = "main_prec_comic31_select1",
        f = "main_prec_comic31_di1",
        comic = "main_prec_comic31_1",
        bg = "main_prec_comic31_di1"
      },
      [2] = {
        s = "main_prec_comic31_select2",
        f = "main_prec_comic31_di2",
        comic = "main_prec_comic31_2",
        bg = "main_prec_comic31_di2"
      },
      [3] = {
        s = "main_prec_comic31_select3",
        f = "main_prec_comic31_di3",
        comic = "main_prec_comic31_3",
        bg = "main_prec_comic31_di3"
      },
      [4] = {
        s = "main_prec_comic31_select4",
        f = "main_prec_comic31_di4",
        comic = "main_prec_comic31_4",
        bg = "main_prec_comic31_di4"
      },
      [5] = {
        s = "main_prec_comic31_select5",
        f = "main_prec_comic31_di5",
        comic = "main_prec_comic31_5",
        bg = "main_prec_comic31_di5"
      },
      [6] = {
        s = "main_prec_comic31_select6",
        f = "main_prec_comic31_di6",
        comic = "main_prec_comic31_6",
        bg = "main_prec_comic31_di6"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    {
      {3400094, 1}
    },
    60,
    common[4],
    60,
    common[5]
  },
  [1000031] = {
    1000031,
    {
      enter = "main_open_di32",
      mainBg = "main_prec_bg32",
      bg = "main_prec_frame_bg32",
      colorLeftTime = {
        74,
        146,
        168,
        275
      },
      bgTitle = "main_prec_bg32_mask",
      imgLeftTime = "main_prec_timebg0",
      colorLeftTimeBG = {
        74,
        146,
        168,
        275
      },
      colorLeftTimeHint = {
        0,
        0,
        0,
        275
      },
      titleRect = {
        x = 0,
        y = -408,
        w = 1811,
        h = 104
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -446,
        y = 264,
        w = 549,
        h = 296,
        ax = -11,
        ay = 12,
        aw = 200,
        ah = 200,
        px = -194,
        py = 59
      },
      [2] = {
        x = -469.5,
        y = -121.5,
        w = 502,
        h = 565,
        ax = -26,
        ay = 2,
        aw = 300,
        ah = 300,
        px = -172,
        py = 195
      },
      [3] = {
        x = 28.5,
        y = 177.5,
        w = 578,
        h = 472,
        ax = 0,
        ay = 13,
        aw = 300,
        ah = 300,
        px = -145,
        py = 146
      },
      [4] = {
        x = 12.7,
        y = -214,
        w = 666,
        h = 378,
        ax = 11,
        ay = -19,
        aw = 250,
        ah = 250,
        px = -198,
        py = 85
      },
      [5] = {
        x = 495.5,
        y = 6,
        w = 452,
        h = 815,
        ax = 11,
        ay = 3,
        aw = 400,
        ah = 400,
        px = -136,
        py = 317
      }
    },
    empty,
    {
      [1] = {
        s = "main_prec_comic32_select1",
        f = "main_prec_comic32_di1",
        comic = "main_prec_comic32_1",
        bg = "main_prec_comic32_di1"
      },
      [2] = {
        s = "main_prec_comic32_select2",
        f = "main_prec_comic32_di2",
        comic = "main_prec_comic32_2",
        bg = "main_prec_comic32_di2"
      },
      [3] = {
        s = "main_prec_comic32_select3",
        f = "main_prec_comic32_di3",
        comic = "main_prec_comic32_3",
        bg = "main_prec_comic32_di3"
      },
      [4] = {
        s = "main_prec_comic32_select4",
        f = "main_prec_comic32_di4",
        comic = "main_prec_comic32_4",
        bg = "main_prec_comic32_di4"
      },
      [5] = {
        s = "main_prec_comic32_select5",
        f = "main_prec_comic32_di5",
        comic = "main_prec_comic32_5",
        bg = "main_prec_comic32_di5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000032] = {
    1000032,
    {
      enter = "main_open_di33",
      mainBg = "main_prec_bg33",
      bg = "main_prec_frame_bg33",
      titleRect = {
        x = 0,
        y = -410,
        w = 1802,
        h = 104
      },
      bgTitle = "main_prec_bg33_mask",
      imgLeftTime = "main_prec_timebg",
      colorLeftTimeHint = {
        0,
        0,
        0,
        275
      },
      colorLeftTime = {
        202,
        176,
        149,
        255
      },
      colorLeftTimeBG = {
        202,
        176,
        149,
        255
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -454,
        y = 195.5,
        w = 532,
        h = 433,
        ax = -14,
        ay = 4,
        aw = 280,
        ah = 280,
        px = -180,
        py = 132
      },
      [2] = {
        x = -21,
        y = 177.6,
        w = 541,
        h = 466,
        ax = 7,
        ay = 2,
        aw = 290,
        ah = 290,
        px = -99,
        py = 148
      },
      [3] = {
        x = 475.6,
        y = 163.7,
        w = 494,
        h = 495,
        ax = 11,
        ay = 12,
        aw = 300,
        ah = 300,
        px = -153,
        py = 165
      },
      [4] = {
        x = -421,
        y = -192.6,
        w = 598,
        h = 420,
        ax = -18,
        ay = 2,
        aw = 300,
        ah = 300,
        px = -213,
        py = 121
      },
      [5] = {
        x = 263.8,
        y = -212,
        w = 915,
        h = 386,
        ax = -13,
        ay = -18,
        aw = 300,
        ah = 300,
        px = -324,
        py = 101
      }
    },
    empty,
    {
      [1] = {
        s = "main_prec_comic33_select1",
        f = "main_prec_comic33_di1",
        comic = "main_prec_comic33_1",
        bg = "main_prec_comic33_di1"
      },
      [2] = {
        s = "main_prec_comic33_select2",
        f = "main_prec_comic33_di2",
        comic = "main_prec_comic33_2",
        bg = "main_prec_comic33_di2"
      },
      [3] = {
        s = "main_prec_comic33_select3",
        f = "main_prec_comic33_di3",
        comic = "main_prec_comic33_3",
        bg = "main_prec_comic33_di3"
      },
      [4] = {
        s = "main_prec_comic33_select4",
        f = "main_prec_comic33_di4",
        comic = "main_prec_comic33_4",
        bg = "main_prec_comic33_di4"
      },
      [5] = {
        s = "main_prec_comic33_select5",
        f = "main_prec_comic33_di5",
        comic = "main_prec_comic33_5",
        bg = "main_prec_comic33_di5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000033] = {
    1000033,
    {
      enter = "main_open_di34",
      mainBg = "main_prec_bg34",
      bg = "main_prec_frame_bg34",
      titleRect = {
        x = 0,
        y = -410,
        w = 1802,
        h = 104
      },
      bgTitle = "main_prec_bg34_mask",
      imgLeftTime = "main_prec_timebg",
      colorLeftTimeHint = {
        0,
        0,
        0,
        275
      },
      colorLeftTime = {
        188,
        53,
        86,
        255
      },
      colorLeftTimeBG = {
        188,
        53,
        86,
        255
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -456,
        y = 203,
        w = 528,
        h = 417,
        ax = -17,
        ay = 19,
        aw = 275,
        ah = 275,
        px = -182,
        py = 121
      },
      [2] = {
        x = -424.4,
        y = -172,
        w = 592,
        h = 463,
        ax = -27,
        ay = -13,
        aw = 300,
        ah = 300,
        px = -213,
        py = 94
      },
      [3] = {
        x = 13,
        y = 191,
        w = 526,
        h = 440,
        ax = 2,
        ay = 25,
        aw = 275,
        ah = 275,
        px = -166,
        py = 133
      },
      [4] = {
        x = 57,
        y = -185.7,
        w = 496,
        h = 435,
        ax = 7,
        ay = -13,
        aw = 250,
        ah = 250,
        px = -153,
        py = 84
      },
      [5] = {
        x = 479,
        y = 5,
        w = 482,
        h = 812,
        ax = 17,
        ay = 1,
        aw = 325,
        ah = 325,
        px = -154,
        py = 321
      }
    },
    empty,
    {
      [1] = {
        s = "main_prec_comic34_select1",
        f = "main_prec_comic34_di1",
        comic = "main_prec_comic34_1",
        bg = "main_prec_comic34_di1"
      },
      [2] = {
        s = "main_prec_comic34_select2",
        f = "main_prec_comic34_di2",
        comic = "main_prec_comic34_2",
        bg = "main_prec_comic34_di2"
      },
      [3] = {
        s = "main_prec_comic34_select3",
        f = "main_prec_comic34_di3",
        comic = "main_prec_comic34_3",
        bg = "main_prec_comic34_di3"
      },
      [4] = {
        s = "main_prec_comic34_select4",
        f = "main_prec_comic34_di4",
        comic = "main_prec_comic34_4",
        bg = "main_prec_comic34_di4"
      },
      [5] = {
        s = "main_prec_comic34_select5",
        f = "main_prec_comic34_di5",
        comic = "main_prec_comic34_5",
        bg = "main_prec_comic34_di5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000034] = {
    1000034,
    {
      enter = "main_open_di35",
      mainBg = "main_prec_bg35",
      bg = "main_prec_frame_bg35",
      titleRect = {
        x = 0,
        y = -410,
        w = 1811,
        h = 104
      },
      bgTitle = "main_prec_bg35_mask",
      imgLeftTime = "main_prec_timebg",
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      colorLeftTime = {
        152,
        249,
        255,
        255
      },
      colorLeftTimeBG = {
        152,
        249,
        255,
        255
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -479,
        y = 204,
        w = 477,
        h = 414,
        ax = -25,
        ay = 11,
        aw = 250,
        ah = 250,
        px = -158,
        py = 122
      },
      [2] = {
        x = -449.2,
        y = -197.4,
        w = 537,
        h = 412,
        ax = -40,
        ay = -2,
        aw = 275,
        ah = 275,
        px = -187,
        py = 115
      },
      [3] = {
        x = 469,
        y = 204.3,
        w = 494,
        h = 414,
        ax = 10,
        ay = 18,
        aw = 250,
        ah = 250,
        px = -124,
        py = 121
      },
      [4] = {
        x = 450.1,
        y = -197,
        w = 532,
        h = 412,
        ax = 10,
        ay = 0,
        aw = 275,
        ah = 275,
        px = -146,
        py = 116
      },
      [5] = {
        x = -20,
        y = 4,
        w = 570,
        h = 814,
        ax = 10,
        ay = 4,
        aw = 400,
        ah = 400,
        px = -171,
        py = 322.3
      }
    },
    empty,
    {
      [1] = {
        s = "main_prec_comic35_select1",
        f = "main_prec_comic35_di1",
        comic = "main_prec_comic35_1",
        bg = "main_prec_comic35_di1"
      },
      [2] = {
        s = "main_prec_comic35_select2",
        f = "main_prec_comic35_di2",
        comic = "main_prec_comic35_2",
        bg = "main_prec_comic35_di2"
      },
      [3] = {
        s = "main_prec_comic35_select3",
        f = "main_prec_comic35_di3",
        comic = "main_prec_comic35_3",
        bg = "main_prec_comic35_di3"
      },
      [4] = {
        s = "main_prec_comic35_select4",
        f = "main_prec_comic35_di4",
        comic = "main_prec_comic35_4",
        bg = "main_prec_comic35_di4"
      },
      [5] = {
        s = "main_prec_comic35_select5",
        f = "main_prec_comic35_di5",
        comic = "main_prec_comic35_5",
        bg = "main_prec_comic35_di5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000035] = {
    1000035,
    {
      enter = "main_open_di36",
      mainBg = "main_prec_bg36",
      bg = "main_prec_frame_bg36",
      titleRect = {
        x = 0,
        y = -410,
        w = 1811,
        h = 104
      },
      bgTitle = "main_prec_bg36_mask",
      imgLeftTime = "main_prec_timebg",
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      colorLeftTime = {
        145,
        255,
        131,
        255
      },
      colorLeftTimeBG = {
        145,
        255,
        131,
        255
      },
      colorUnlock = {
        195,
        195,
        195,
        195
      }
    },
    {
      [1] = {
        x = -493.4,
        y = 216.4,
        w = 444,
        h = 389,
        ax = -15,
        ay = 11,
        aw = 250,
        ah = 250,
        px = -145,
        py = 111
      },
      [2] = {
        x = -467.4,
        y = -183,
        w = 497,
        h = 441,
        ax = -51,
        ay = -2,
        aw = 275,
        ah = 275,
        px = -172,
        py = 136
      },
      [3] = {
        x = -29.8,
        y = 188.3,
        w = 593,
        h = 441,
        ax = 6,
        ay = 22,
        aw = 275,
        ah = 275,
        px = -213,
        py = 140
      },
      [4] = {
        x = 7.2,
        y = -199.8,
        w = 560,
        h = 405,
        ax = -5,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -192,
        py = 96
      },
      [5] = {
        x = 484.6,
        y = 4,
        w = 493,
        h = 811,
        ax = 10,
        ay = 4,
        aw = 350,
        ah = 350,
        px = -165,
        py = 326
      }
    },
    empty,
    {
      [1] = {
        s = "main_prec_comic36_select1",
        f = "main_prec_comic36_di1",
        comic = "main_prec_comic36_1",
        bg = "main_prec_comic36_di1"
      },
      [2] = {
        s = "main_prec_comic36_select2",
        f = "main_prec_comic36_di2",
        comic = "main_prec_comic36_2",
        bg = "main_prec_comic36_di2"
      },
      [3] = {
        s = "main_prec_comic36_select3",
        f = "main_prec_comic36_di3",
        comic = "main_prec_comic36_3",
        bg = "main_prec_comic36_di3"
      },
      [4] = {
        s = "main_prec_comic36_select4",
        f = "main_prec_comic36_di4",
        comic = "main_prec_comic36_4",
        bg = "main_prec_comic36_di4"
      },
      [5] = {
        s = "main_prec_comic36_select5",
        f = "main_prec_comic36_di5",
        comic = "main_prec_comic36_5",
        bg = "main_prec_comic36_di5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000036] = {
    1000036,
    {
      enter = "main_open_di37",
      mainBg = "main_prec_bg37",
      bg = "main_prec_frame_bg37",
      titleRect = {
        x = 0,
        y = -367,
        w = 1812,
        h = 104
      },
      bgTitle = "main_prec_bg37_mask",
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      colorLeftTime = {
        129,
        228,
        215,
        255
      },
      colorLeftTimeBG = {
        129,
        228,
        215,
        255
      },
      colorUnreach = {
        0,
        0,
        0,
        125
      },
      atlasName = "UIPetForecast_N37.spriteatlas",
      comicFrame = "main_prec_comic37_frame"
    },
    {
      [1] = {
        x = -448.5,
        y = 301,
        w = 488,
        h = 471,
        ax = -2,
        ay = 3,
        aw = 300,
        ah = 300,
        px = -172,
        py = 152
      },
      [2] = {
        x = -459.6,
        y = -99.9,
        w = 468,
        h = 328,
        ax = -12,
        ay = 7,
        aw = 250,
        ah = 250,
        px = -162,
        py = 79
      },
      [3] = {
        x = 40.6,
        y = 356.5,
        w = 508,
        h = 354,
        ax = -1,
        ay = 12,
        aw = 225,
        ah = 225,
        px = -167,
        py = 96
      },
      [4] = {
        x = 38.8,
        y = -26.4,
        w = 551,
        h = 473,
        ax = -19,
        ay = -21,
        aw = 275,
        ah = 275,
        px = -177,
        py = 124
      },
      [5] = {
        x = 502.3,
        y = 134.2,
        w = 443,
        h = 793,
        ax = 25,
        ay = 11,
        aw = 350,
        ah = 350,
        px = -138,
        py = 320
      }
    },
    empty,
    {
      [1] = {
        select = "main_prec_comic37_select1",
        unlock = "main_prec_comic37_1",
        lock = "main_prec_comic37_di1",
        btn = "main_prec_comic37_choose1"
      },
      [2] = {
        select = "main_prec_comic37_select2",
        unlock = "main_prec_comic37_2",
        lock = "main_prec_comic37_di2",
        btn = "main_prec_comic37_choose2"
      },
      [3] = {
        select = "main_prec_comic37_select3",
        unlock = "main_prec_comic37_3",
        lock = "main_prec_comic37_di3",
        btn = "main_prec_comic37_choose3"
      },
      [4] = {
        select = "main_prec_comic37_select4",
        unlock = "main_prec_comic37_4",
        lock = "main_prec_comic37_di4",
        btn = "main_prec_comic37_choose4"
      },
      [5] = {
        select = "main_prec_comic37_select5",
        unlock = "main_prec_comic37_5",
        lock = "main_prec_comic37_di5",
        btn = "main_prec_comic37_choose5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000037] = {
    1000037,
    {
      enter = "main_open_di38",
      mainBg = "main_prec_bg38",
      bg = "main_prec_frame_bg38",
      titleRect = {
        x = 0,
        y = -367,
        w = 1812,
        h = 104
      },
      bgTitle = "main_prec_bg38_mask",
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      colorLeftTime = {
        217,
        203,
        159,
        255
      },
      colorLeftTimeBG = {
        217,
        203,
        159,
        255
      },
      colorUnreach = {
        0,
        0,
        0,
        175
      },
      atlasName = "UIPetForecast_N38.spriteatlas",
      comicFrame = "main_prec_comic38_frame"
    },
    {
      [1] = {
        x = -457,
        y = 329,
        w = 472,
        h = 407,
        ax = -13,
        ay = 18,
        aw = 225,
        ah = 225,
        px = -161,
        py = 120
      },
      [2] = {
        x = -429,
        y = -33,
        w = 530,
        h = 455,
        ax = -38,
        ay = -14,
        aw = 250,
        ah = 250,
        px = -187,
        py = 126
      },
      [3] = {
        x = 485,
        y = 338,
        w = 481,
        h = 397,
        ax = -1,
        ay = 18,
        aw = 225,
        ah = 225,
        px = -134,
        py = 111
      },
      [4] = {
        x = 464,
        y = -39,
        w = 521,
        h = 444,
        ax = 7,
        ay = -16,
        aw = 250,
        ah = 250,
        px = -148,
        py = 100
      },
      [5] = {
        x = -4,
        y = 137,
        w = 558,
        h = 796,
        ax = 12,
        ay = 10,
        aw = 325,
        ah = 325,
        px = -183,
        py = 313
      }
    },
    empty,
    {
      [1] = {
        select = "main_prec_comic38_select1",
        unlock = "main_prec_comic38_1",
        lock = "main_prec_comic38_di1",
        btn = "main_prec_comic38_choose1"
      },
      [2] = {
        select = "main_prec_comic38_select2",
        unlock = "main_prec_comic38_2",
        lock = "main_prec_comic38_di2",
        btn = "main_prec_comic38_choose2"
      },
      [3] = {
        select = "main_prec_comic38_select3",
        unlock = "main_prec_comic38_3",
        lock = "main_prec_comic38_di3",
        btn = "main_prec_comic38_choose3"
      },
      [4] = {
        select = "main_prec_comic38_select4",
        unlock = "main_prec_comic38_4",
        lock = "main_prec_comic38_di4",
        btn = "main_prec_comic38_choose4"
      },
      [5] = {
        select = "main_prec_comic38_select5",
        unlock = "main_prec_comic38_5",
        lock = "main_prec_comic38_di5",
        btn = "main_prec_comic38_choose5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000038] = {
    1000038,
    {
      enter = "main_open_di39",
      mainBg = "main_prec_bg39",
      bg = "main_prec_frame_bg39",
      titleRect = {
        x = 0,
        y = -367,
        w = 1812,
        h = 104
      },
      bgTitle = "main_prec_bg39_mask",
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      colorLeftTime = {
        114,
        88,
        207,
        255
      },
      colorLeftTimeBG = {
        114,
        88,
        207,
        255
      },
      colorUnreach = {
        0,
        0,
        0,
        200
      },
      atlasName = "UIPetForecast_N39.spriteatlas",
      comicFrame = "main_prec_comic39_frame"
    },
    common[17],
    empty,
    {
      [1] = {
        select = "main_prec_comic39_select1",
        unlock = "main_prec_comic39_1",
        lock = "main_prec_comic39_di1",
        btn = "main_prec_comic39_choose1"
      },
      [2] = {
        select = "main_prec_comic39_select2",
        unlock = "main_prec_comic39_2",
        lock = "main_prec_comic39_di2",
        btn = "main_prec_comic39_choose2"
      },
      [3] = {
        select = "main_prec_comic39_select3",
        unlock = "main_prec_comic39_3",
        lock = "main_prec_comic39_di3",
        btn = "main_prec_comic39_choose3"
      },
      [4] = {
        select = "main_prec_comic39_select4",
        unlock = "main_prec_comic39_4",
        lock = "main_prec_comic39_di4",
        btn = "main_prec_comic39_choose4"
      },
      [5] = {
        select = "main_prec_comic39_select5",
        unlock = "main_prec_comic39_5",
        lock = "main_prec_comic39_di5",
        btn = "main_prec_comic39_choose5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000039] = {
    1000039,
    {
      enter = "main_open_di40",
      mainBg = "main_prec_bg40",
      bg = "main_prec_frame_bg40",
      titleRect = {
        x = 0,
        y = -367,
        w = 1812,
        h = 104
      },
      bgTitle = "main_prec_bg40_mask",
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      colorLeftTime = {
        114,
        88,
        207,
        255
      },
      colorLeftTimeBG = {
        114,
        88,
        207,
        255
      },
      colorUnreach = {
        0,
        0,
        0,
        200
      },
      atlasName = "UIPetForecast_N40.spriteatlas",
      comicFrame = "main_prec_comic40_frame"
    },
    common[17],
    empty,
    {
      [1] = {
        select = "main_prec_comic40_select1",
        unlock = "main_prec_comic40_1",
        lock = "main_prec_comic40_di1",
        btn = "main_prec_comic40_choose1"
      },
      [2] = {
        select = "main_prec_comic40_select2",
        unlock = "main_prec_comic40_2",
        lock = "main_prec_comic40_di2",
        btn = "main_prec_comic40_choose2"
      },
      [3] = {
        select = "main_prec_comic40_select3",
        unlock = "main_prec_comic40_3",
        lock = "main_prec_comic40_di3",
        btn = "main_prec_comic40_choose3"
      },
      [4] = {
        select = "main_prec_comic40_select4",
        unlock = "main_prec_comic40_4",
        lock = "main_prec_comic40_di4",
        btn = "main_prec_comic40_choose4"
      },
      [5] = {
        select = "main_prec_comic40_select5",
        unlock = "main_prec_comic40_5",
        lock = "main_prec_comic40_di5",
        btn = "main_prec_comic40_choose5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000040] = {
    1000040,
    {
      enter = "main_open_di41",
      mainBg = "main_prec_bg41",
      bg = "main_prec_frame_bg41",
      titleRect = {
        x = 0,
        y = -367,
        w = 1812,
        h = 104
      },
      bgTitle = "main_prec_bg41_mask",
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      colorLeftTime = {
        251,
        124,
        66,
        255
      },
      colorLeftTimeBG = {
        251,
        124,
        66,
        255
      },
      colorUnreach = {
        121,
        121,
        121,
        255
      },
      atlasName = "UIPetForecast_N41.spriteatlas",
      comicFrame = "main_prec_comic41_frame"
    },
    {
      [1] = {
        x = -463,
        y = 330.7,
        w = 465,
        h = 410,
        ax = -7,
        ay = -1,
        aw = 250,
        ah = 250,
        px = -159,
        py = 122
      },
      [2] = {
        x = -444,
        y = -56,
        w = 503,
        h = 414,
        ax = -27,
        ay = -11,
        aw = 250,
        ah = 250,
        px = -179,
        py = 111
      },
      [3] = {
        x = 491,
        y = 330,
        w = 465,
        h = 415,
        ax = 6,
        ay = 0,
        aw = 250,
        ah = 250,
        px = -122,
        py = 123
      },
      [4] = {
        x = 470,
        y = -54,
        w = 499,
        h = 413,
        ax = -1,
        ay = -27,
        aw = 250,
        ah = 250,
        px = -127,
        py = 98
      },
      [5] = {
        x = 11,
        y = 139,
        w = 572,
        h = 794,
        ax = 6,
        ay = -20,
        aw = 350,
        ah = 350,
        px = -195,
        py = 315
      }
    },
    empty,
    {
      [1] = {
        select = "main_prec_comic41_select1",
        unlock = "main_prec_comic41_1",
        lock = "main_prec_comic41_di1",
        btn = "main_prec_comic41_choose1"
      },
      [2] = {
        select = "main_prec_comic41_select2",
        unlock = "main_prec_comic41_2",
        lock = "main_prec_comic41_di2",
        btn = "main_prec_comic41_choose2"
      },
      [3] = {
        select = "main_prec_comic41_select3",
        unlock = "main_prec_comic41_3",
        lock = "main_prec_comic41_di3",
        btn = "main_prec_comic41_choose3"
      },
      [4] = {
        select = "main_prec_comic41_select4",
        unlock = "main_prec_comic41_4",
        lock = "main_prec_comic41_di4",
        btn = "main_prec_comic41_choose4"
      },
      [5] = {
        select = "main_prec_comic41_select5",
        unlock = "main_prec_comic41_5",
        lock = "main_prec_comic41_di5",
        btn = "main_prec_comic41_choose5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000041] = {
    1000041,
    {
      enter = "main_open_di43",
      mainBg = "main_prec_bg43",
      bg = "main_prec_frame_bg43",
      titleRect = {
        x = 0,
        y = -367,
        w = 1812,
        h = 104
      },
      bgTitle = "main_prec_bg43_mask",
      colorLeftTimeHint = {
        0,
        0,
        0,
        255
      },
      colorLeftTime = {
        2,
        76,
        226,
        255
      },
      colorLeftTimeBG = {
        2,
        76,
        226,
        255
      },
      colorUnreach = {
        105,
        105,
        105,
        255
      },
      atlasName = "UIPetForecast_N43.spriteatlas",
      comicFrame = "main_prec_comic43_frame"
    },
    {
      [1] = {
        x = -428.5,
        y = 291,
        w = 528,
        h = 486,
        ax = -12,
        ay = 14,
        aw = 275,
        ah = 275,
        px = -179,
        py = 155
      },
      [2] = {
        x = -445,
        y = -88,
        w = 495,
        h = 346,
        ax = -12,
        ay = -10,
        aw = 225,
        ah = 225,
        px = -162,
        py = 85
      },
      [3] = {
        x = 59.4,
        y = 343,
        w = 499,
        h = 383,
        ax = -1,
        ay = 15,
        aw = 225,
        ah = 225,
        px = -146,
        py = 103
      },
      [4] = {
        x = 55.2,
        y = -37,
        w = 545,
        h = 450,
        ax = -1,
        ay = -19,
        aw = 250,
        ah = 250,
        px = -160,
        py = 104
      },
      [5] = {
        x = 510,
        y = 137.5,
        w = 431,
        h = 796,
        ax = 6,
        ay = -20,
        aw = 350,
        ah = 350,
        px = -125,
        py = 309
      }
    },
    empty,
    {
      [1] = {
        select = "main_prec_comic43_select1",
        unlock = "main_prec_comic43_1",
        lock = "main_prec_comic43_di1",
        btn = "main_prec_comic43_choose1"
      },
      [2] = {
        select = "main_prec_comic43_select2",
        unlock = "main_prec_comic43_2",
        lock = "main_prec_comic43_di2",
        btn = "main_prec_comic43_choose2"
      },
      [3] = {
        select = "main_prec_comic43_select3",
        unlock = "main_prec_comic43_3",
        lock = "main_prec_comic43_di3",
        btn = "main_prec_comic43_choose3"
      },
      [4] = {
        select = "main_prec_comic43_select4",
        unlock = "main_prec_comic43_4",
        lock = "main_prec_comic43_di4",
        btn = "main_prec_comic43_choose4"
      },
      [5] = {
        select = "main_prec_comic43_select5",
        unlock = "main_prec_comic43_5",
        lock = "main_prec_comic43_di5",
        btn = "main_prec_comic43_choose5"
      }
    },
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000042] = {
    1000042,
    empty,
    empty,
    empty,
    empty,
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000043] = {
    1000043,
    empty,
    empty,
    empty,
    empty,
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  },
  [1000044] = {
    1000044,
    empty,
    empty,
    empty,
    empty,
    empty,
    empty,
    60,
    common[1],
    60,
    common[2],
    60,
    common[3],
    60,
    common[4],
    60,
    common[5]
  }
}
return config, "ID", key
