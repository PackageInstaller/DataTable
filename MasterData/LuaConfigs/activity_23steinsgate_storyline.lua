local __rt_1 = {}
local __rt_2 = {8}
local __rt_3 = {3}
local activity_23steinsgate_storyline = {
  {
    arg_text = 1,
    interact_perform = 0,
    lobby_index = 1,
    show_or_condition = __rt_1,
    special = 0,
    story_id = 4500101,
    succeed = 2
  },
  {
    arg_text = 1,
    avg_code = {"A Stage 01", "A Stage 01"},
    avg_preview = {45001001, 45001002},
    code = "A Stage",
    id = 2,
    interact_id = 2,
    interact_para = {2, 0},
    lobby_index = 1,
    precursor = 1,
    special = 0,
    stage_id = {450012101, 450011101},
    succeed = 3
  },
  {
    code_num = "02",
    id = 3,
    interact_id = 3,
    interact_para = {8, 0},
    interact_perform = 12,
    lobby_index = 2,
    precursor = 2,
    show_or_condition = {
      {
        a1 = {450012101},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011101},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    story_id = 4500102,
    succeed = 4
  },
  {
    arg_text = 2,
    code_num = "03",
    id = 4,
    interact_id = 4,
    interact_para = {3, 0},
    interact_perform = 12,
    lobby_index = 8,
    precursor = 3,
    show_or_condition = {
      {
        a1 = {4500102},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    story_id = 4500103,
    succeed = 5
  },
  {
    arg_text = 3,
    code_num = "04",
    id = 5,
    interact_id = 5,
    interact_para = {11, 0},
    interact_perform = 12,
    lobby_index = 3,
    precursor = 4,
    show_or_condition = {
      {
        a1 = {4500103},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    story_id = 4500104,
    succeed = 6
  },
  {
    arg_text = 4,
    avg_code = {"A Stage 02", "A Stage 02"},
    avg_preview = {45001011, 45001012},
    code = "A Stage",
    code_num = "02",
    id = 6,
    interact_id = 6,
    interact_para = {6, 0},
    lobby_index = 11,
    precursor = 5,
    show_or_condition = {
      {
        a1 = {4500104},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    special = 0,
    stage_id = {450012102, 450011102},
    succeed = 7
  },
  {
    code_num = "05",
    id = 7,
    interact_id = 7,
    interact_para = {
      13,
      1,
      1
    },
    interact_perform = 13,
    lobby_index = 12,
    precursor = 6,
    show_or_condition = {
      {
        a1 = {450012102},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011102},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    story_id = 4500105,
    succeed = 8
  },
  {
    avg_code = {"B Stage 01", "B Stage 01"},
    avg_preview = {45001021, 45001022},
    code = "B Stage",
    id = 8,
    interact_id = 8,
    interact_para = {8, 1},
    lobby_index = 13,
    precursor = 7,
    show_or_condition = {
      {
        a1 = {4500105},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    special = 0,
    stage_id = {450012103, 450011103},
    succeed = 9
  },
  {
    code = "B Part",
    id = 9,
    interact_id = 9,
    interact_para = {15, 0},
    interact_perform = 12,
    lobby_index = 14,
    precursor = 8,
    show_or_condition = {
      {
        a1 = {450012103},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011103},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    story_id = 4500106,
    succeed = 10
  },
  {
    arg_text = 5,
    avg_code = {"B Stage 02", "B Stage 02"},
    avg_preview = {45001031, 45001032},
    code = "B Stage",
    code_num = "02",
    id = 10,
    interact_id = 10,
    interact_para = {10, 0},
    lobby_index = 15,
    precursor = 9,
    show_or_condition = {
      {
        a1 = {4500106},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    special = 0,
    stage_id = {450012104, 450011104},
    succeed = 11
  },
  {
    arg_text = 6,
    code = "B Part",
    code_num = "02",
    id = 11,
    interact_id = 11,
    interact_para = {
      16,
      2,
      1
    },
    interact_perform = 13,
    precursor = 10,
    show_or_condition = {
      {
        a1 = {450012104},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011104},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    story_id = 4500107,
    succeed = 12
  },
  {
    arg_text = 7,
    avg_code = {
      "B2 Stage 01",
      "B2 Stage 01"
    },
    avg_preview = {45001041, 45001042},
    code = "B2 Stage",
    id = 12,
    interact_id = 12,
    interact_para = {12, 1},
    precursor = 11,
    show_or_condition = {
      {
        a1 = {4500107},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    special = 0,
    stage_id = {450012105, 450011105},
    succeed = 13
  },
  {
    code = "B2 Part",
    id = 13,
    interact_id = 13,
    interact_para = {19, 0},
    interact_perform = 12,
    precursor = 12,
    show_or_condition = {
      {
        a1 = {450012105},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011105},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    story_id = 4500108,
    succeed = 14
  },
  {
    arg_text = 8,
    avg_code = {
      "B2 Stage 02",
      "B2 Stage 02"
    },
    avg_preview = {45001051, 45001052},
    code = "B2 Stage",
    code_num = "02",
    id = 14,
    interact_id = 14,
    interact_para = {14, 0},
    lobby_index = 19,
    precursor = 13,
    show_or_condition = {
      {
        a1 = {4500108},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    special = 0,
    stage_id = {450012106, 450011106},
    succeed = 15
  },
  {
    code = "B2 Part",
    code_num = "02",
    id = 15,
    interact_id = 15,
    interact_para = {
      26,
      3,
      0
    },
    interact_perform = 13,
    lobby_index = 19,
    precursor = 14,
    show_or_condition = {
      {
        a1 = {450012106},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011106},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    story_id = 4500109,
    succeed = 16
  },
  {
    code = "B3 Part",
    id = 16,
    interact_id = 16,
    interact_para = {26, 0},
    interact_perform = 12,
    lobby_index = 26,
    precursor = 15,
    show_or_condition = {
      {
        a1 = {4500109},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    story_id = 4500110,
    succeed = 17
  },
  {
    avg_code = {
      "B3 Stage 01",
      "B3 Stage 01",
      "B3 Stage 01",
      "B3 Stage 01",
      "B3 Stage 01"
    },
    avg_preview = {
      45001061,
      45001062,
      45001063,
      45001064,
      45001065
    },
    code = "B3 Stage",
    id = 17,
    interact_id = 16,
    interact_para = {17, 1},
    lobby_index = 26,
    precursor = 16,
    show_or_condition = {
      {
        a1 = {4500110},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    special = 0,
    stage_id = {450012107, 450011107},
    succeed = 18
  },
  {
    arg_text = 9,
    code = "B3 Part",
    code_num = "02",
    id = 18,
    interact_id = 17,
    interact_para = {22, 1},
    interact_perform = 12,
    lobby_index = 21,
    precursor = 17,
    show_or_condition = {
      {
        a1 = {450012107},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011107},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    story_id = 4500111,
    succeed = 19
  },
  {
    code = "B3 Part",
    code_num = "03",
    id = 19,
    interact_id = 18,
    interact_para = {20},
    lobby_index = 22,
    precursor = 18,
    show_or_condition = {
      {
        a1 = {4500111},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    story_id = 4500112,
    succeed = 20
  },
  {
    arg_text = 10,
    avg_code = {
      "B3 Stage 02",
      "B3 Stage 02"
    },
    avg_preview = {45001071, 45001072},
    code = "B3 Stage",
    code_num = "02",
    id = 20,
    interact_perform = 0,
    lobby_index = 22,
    precursor = 19,
    show_or_condition = {
      {
        a1 = {4500112},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    special = 0,
    stage_id = {450012108, 450011108},
    succeed = 21
  },
  {
    avg_code = {
      "B3 Stage 03",
      "B3 Stage 03",
      "B3 Stage 03",
      "B3 Stage 03",
      "B3 Stage 03"
    },
    avg_preview = {
      45001081,
      45001082,
      45001083,
      45001084,
      45001085
    },
    code = "B3 Stage",
    code_num = "03",
    id = 21,
    interact_id = 19,
    interact_para = {21},
    lobby_index = 22,
    precursor = 20,
    show_or_condition = {
      {
        a1 = {450012108},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011108},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    special = 0,
    stage_id = {450012109, 450011109},
    succeed = 22,
    win_para = {4, 10},
    win_perform = 13
  },
  {
    code = "B2 Part",
    code_num = "03",
    id = 22,
    interact_id = 20,
    interact_para = {23},
    lobby_index = 4,
    precursor = 21,
    show_or_condition = {
      {
        a1 = {450012109},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011109},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    story_id = 4500113,
    succeed = 23,
    win_para = {23, 4},
    win_perform = 13
  },
  {
    avg_code = {
      "B2 Stage 03",
      "B2 Stage 03",
      "B2 Stage 03",
      "B2 Stage 03",
      "B2 Stage 03"
    },
    avg_preview = {
      45001091,
      45001092,
      45001093,
      45001094,
      45001095
    },
    code = "B2 Stage",
    code_num = "03",
    id = 23,
    interact_perform = 0,
    lobby_index = 23,
    precursor = 22,
    show_or_condition = {
      {
        a1 = {4500113},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    special = 0,
    stage_id = {450012110, 450011110},
    succeed = 24
  },
  {
    code = "B Part",
    code_num = "03",
    id = 24,
    interact_id = 21,
    interact_para = {30, 0},
    interact_perform = 12,
    lobby_index = 23,
    precursor = 23,
    show_or_condition = {
      {
        a1 = {450012110},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011110},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    story_id = 4500114,
    succeed = 25,
    win_para = {24, 5},
    win_perform = 13
  },
  {
    avg_code = {"B Stage 03"},
    avg_preview = {45001101},
    code = "B Stage",
    code_num = "03",
    id = 25,
    interact_id = 22,
    interact_para = {25},
    lobby_index = 30,
    precursor = 24,
    show_or_condition = {
      {
        a1 = {4500114},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    special = 0,
    stage_id = {450012111, 450011111},
    succeed = 26
  },
  {
    avg_code = {"B Stage 04", "B Stage 04"},
    avg_preview = {45001111, 45001112},
    code = "B Stage",
    code_num = "04",
    id = 26,
    interact_perform = 0,
    lobby_index = 30,
    precursor = 25,
    show_or_condition = {
      {
        a1 = {450012111},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011111},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    special = 0,
    stage_id = {450012112, 450011112},
    succeed = 27,
    win_para = {26},
    win_perform = 1
  },
  {
    arg_text = 11,
    code = "B Part",
    code_num = "04",
    id = 27,
    interact_id = 23,
    interact_para = {
      5,
      6,
      0
    },
    interact_perform = 13,
    lobby_index = 4,
    precursor = 26,
    show_or_condition = {
      {
        a1 = {450012112},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011112},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    story_id = 4500115,
    succeed = 28
  },
  {
    code_num = "06",
    id = 28,
    interact_id = 24,
    interact_para = {5, 0},
    interact_perform = 12,
    lobby_index = 5,
    precursor = 27,
    show_or_condition = {
      {
        a1 = {4500115},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    story_id = 4500116,
    succeed = 29
  },
  {
    avg_code = {"A Stage 03"},
    avg_preview = {45001121},
    code = "A Stage",
    code_num = "03",
    id = 29,
    interact_id = 24,
    interact_para = {29},
    lobby_index = 5,
    precursor = 28,
    show_or_condition = {
      {
        a1 = {4500116},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    special = 0,
    stage_id = {450012113, 450011113},
    succeed = 30
  },
  {
    arg_text = 12,
    code_num = "07",
    id = 30,
    interact_id = 25,
    interact_para = {
      25,
      7,
      0
    },
    interact_perform = 13,
    lobby_index = 18,
    precursor = 29,
    show_or_condition = {
      {
        a1 = {450012113},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011113},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    story_id = 4500117,
    succeed = 33
  },
  {
    arg_text = 13,
    code = "A0 Part",
    code_num = "0",
    id = 31,
    interact_id = 26,
    interact_para = {25, 0},
    interact_perform = 12,
    lobby_index = 25,
    show_or_condition = {
      {
        a1 = {4500117},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    special = 0,
    story_id = 4500118,
    succeed = 32
  },
  {
    avg_code = {"A0 Stage 0", "A0 Stage 0"},
    avg_preview = {45001131, 45001132},
    code = "A0 Stage",
    code_num = "0",
    id = 32,
    interact_id = 26,
    interact_para = {
      32,
      30,
      0
    },
    interact_perform = 2,
    lobby_index = 25,
    precursor = 31,
    show_or_condition = {
      {
        a1 = {4500118},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    special = 0,
    stage_id = {450012114, 450011114}
  },
  {
    code = "A0 Part",
    id = 33,
    interact_id = 27,
    interact_para = {18, 0},
    interact_perform = 12,
    lobby_index = 25,
    precursor = 30,
    show_or_condition = {
      {
        a1 = {450012114},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011114},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    story_id = 4500119,
    succeed = 34,
    win_para = {18, 7},
    win_perform = 13
  },
  {
    arg_text = 14,
    avg_code = {
      "A0 Stage 01",
      "A0 Stage 01"
    },
    avg_preview = {45001141, 45001142},
    code = "A0 Stage",
    id = 34,
    interact_id = 27,
    interact_para = {34},
    lobby_index = 18,
    precursor = 33,
    show_or_condition = {
      {
        a1 = {4500119},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    special = 0,
    stage_id = {450012115, 450011115},
    succeed = 35
  },
  {
    code = "A0 Part",
    code_num = "02",
    id = 35,
    interact_id = 28,
    interact_para = {
      36,
      35,
      1
    },
    interact_perform = 2,
    lobby_index = 28,
    precursor = 36,
    show_or_condition = {
      {
        a1 = {450012115},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011115},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    story_id = 4500120,
    succeed = 37
  },
  {
    avg_code = {
      "O Stage 0",
      "O Stage 0",
      "O Stage 0",
      "O Stage 0",
      "O Stage 0",
      "O Stage 0",
      "O Stage 0"
    },
    avg_preview = {
      45001151,
      45001152,
      45001153,
      45001154,
      45001155,
      45001156,
      45001157
    },
    code = "O Stage",
    code_num = "0",
    fold_step = 2,
    id = 36,
    interact_perform = 0,
    lobby_index = 28,
    show_or_condition = {
      {
        a1 = {4500120},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    stage_id = {450012116, 450011116},
    succeed = 35
  },
  {
    arg_text = 15,
    avg_code = {
      "A0 Stage 02",
      "A0 Stage 02",
      "A0 Stage 02"
    },
    avg_preview = {
      45001161,
      45001162,
      45001163
    },
    code = "A0 Stage",
    code_num = "02",
    fold_step = 2,
    id = 37,
    interact_id = 29,
    interact_para = {37},
    lobby_index = 27,
    precursor = 35,
    show_or_condition = {
      {
        a1 = {450012116},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011116},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    special = 0,
    stage_id = {450012117, 450011117},
    succeed = 38
  },
  {
    code = "A0 Part",
    code_num = "03",
    fold_step = 2,
    id = 38,
    interact_id = 30,
    interact_para = {9, 0},
    interact_perform = 12,
    lobby_index = 9,
    precursor = 37,
    show_or_condition = {
      {
        a1 = {450012117},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011117},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    story_id = 4500121,
    succeed = 39
  },
  {
    avg_code = {
      "A0 Stage 03",
      "A0 Stage 03",
      "A0 Stage 03",
      "A0 Stage 03",
      "A0 Stage 03",
      "A0 Stage 03",
      "A0 Stage 03",
      "A0 Stage 03",
      "A0 Stage 03",
      "A0 Stage 03",
      "A0 Stage 03",
      "A0 Stage 03",
      "A0 Stage 03",
      "A0 Stage 03"
    },
    avg_preview = {
      45001171,
      45001172,
      45001173,
      45001174,
      45001175,
      45001176,
      45001177,
      45001178,
      45001179,
      45001180,
      45001181,
      45001182,
      45001183,
      45001184
    },
    code = "A0 Stage",
    code_num = "03",
    fold_step = 2,
    id = 39,
    interact_id = 30,
    interact_para = {39},
    lobby_index = 9,
    precursor = 38,
    show_or_condition = {
      {
        a1 = {4500121},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    special = 0,
    stage_id = {450012118, 450011118},
    succeed = 40
  },
  {
    arg_text = 16,
    code = "A0 Part",
    code_num = "04",
    fold_step = 2,
    id = 40,
    interact_id = 31,
    interact_para = {7, 0},
    interact_perform = 12,
    lobby_index = 6,
    precursor = 39,
    show_or_condition = {
      {
        a1 = {450012118},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011118},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    story_id = 4500122,
    succeed = 41
  },
  {
    avg_code = {
      "A0 Stage 04",
      "A0 Stage 04",
      "A0 Stage 04",
      "A0 Stage 04",
      "A0 Stage 04",
      "A0 Stage 04",
      "A0 Stage 04",
      "A0 Stage 04",
      "A0 Stage 04",
      "A0 Stage 04",
      "A0 Stage 04",
      "A0 Stage 04",
      "A0 Stage 04",
      "A0 Stage 04",
      "A0 Stage 04"
    },
    avg_preview = {
      45001185,
      45001186,
      45001187,
      45001188,
      45001189,
      45001190,
      45001191,
      45001192,
      45001193,
      45001194,
      45001195,
      45001196,
      45001197,
      45001198,
      45001199
    },
    code = "A0 Stage",
    code_num = "04",
    fold_step = 2,
    id = 41,
    interact_id = 32,
    interact_para = {41},
    lobby_index = 7,
    precursor = 40,
    show_or_condition = {
      {
        a1 = {4500122},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    special = 2,
    stage_id = {450012119, 450011119},
    succeed = 43
  },
  {
    code = "ND",
    code_num = "",
    fold_step = 2,
    id = 42,
    interact_perform = 0,
    lobby_index = 29,
    show_or_condition = {
      {
        a1 = {450012119},
        a2 = __rt_1,
        c = __rt_3
      },
      {
        a1 = {450011119},
        a2 = __rt_1,
        c = __rt_3
      }
    },
    special = 0
  },
  {
    code = "TE Part",
    fold_step = 3,
    id = 43,
    interact_id = 33,
    interact_para = {43},
    lobby_index = 7,
    precursor = 41,
    show_or_condition = {
      {
        a1 = {45001192},
        a2 = __rt_1,
        c = __rt_2
      }
    },
    special = 2,
    story_id = 4500123,
    win_para = {17, 9},
    win_perform = 13
  }
}
local __default_values = {
  arg_text = 0,
  avg_code = __rt_1,
  avg_preview = __rt_1,
  code = "A Part",
  code_num = "01",
  fold_step = 1,
  id = 1,
  interact_id = 0,
  interact_para = __rt_1,
  interact_perform = 1,
  lobby_index = 16,
  precursor = 0,
  show_or_condition = {
    {
      a1 = {4500101},
      a2 = __rt_1,
      c = __rt_2
    }
  },
  special = 1,
  stage_id = __rt_1,
  story_id = 0,
  succeed = 0,
  win_para = __rt_1,
  win_perform = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_23steinsgate_storyline) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  interact2NodeId = {
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [16] = 17,
    [17] = 18,
    [18] = 19,
    [19] = 21,
    [20] = 22,
    [21] = 24,
    [22] = 25,
    [23] = 27,
    [24] = 29,
    [25] = 30,
    [26] = 32,
    [27] = 34,
    [28] = 35,
    [29] = 37,
    [30] = 39,
    [31] = 40,
    [32] = 41,
    [33] = 43
  }
}
setmetatable(activity_23steinsgate_storyline, {__index = __rawdata})
return activity_23steinsgate_storyline
