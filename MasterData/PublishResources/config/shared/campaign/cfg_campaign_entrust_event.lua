local key = {
  EventID = 1,
  EventType = 2,
  PointPos = 3,
  MissionID = 4,
  PointName = 5,
  PointPermitTeamID = 6,
  RewardList = 7,
  TargetID = 8,
  InteractionID = 9,
  LockedPointID = 10,
  TeamSpecialPoint = 11,
  Params = 12
}
local common = {
  {275, -250},
  {11, 76},
  {592, 12},
  {860, -141},
  {1},
  {1, 2},
  {2},
  {3},
  {1, 3},
  {
    {Type = 1}
  },
  {
    {BannerID = 101, BannerType = 3}
  },
  {
    {
      Desc = "str_n22_trans_1"
    }
  },
  {
    {
      Desc = "str_n22_entrust_stage_task_1_2",
      Head = "n22_wt_dfqb_hero06",
      ShowNumber = 1
    }
  },
  {
    {
      Desc = "str_n22_entrust_stage_task_2_2",
      Head = "n22_wt_dfqb_hero06",
      ShowNumber = 1
    }
  },
  {
    {
      Desc = "str_n22_entrust_stage_task_3_2",
      Head = "n22_wt_dfqb_hero06",
      ShowNumber = 1
    }
  },
  {
    {TeamID = 1}
  },
  {
    {
      Desc = "str_n30_entrust_transfer"
    }
  },
  {
    {
      Desc = "str_n30_entrust_interaction"
    }
  },
  {
    {TeamID = 2}
  },
  {
    {TeamID = 3}
  },
  {
    {3000003, 20}
  },
  {
    {3000230, 1}
  },
  {
    {3000002, 5000}
  },
  {
    {3500001, 100}
  },
  {
    {3000003, 80}
  },
  {
    {3000231, 1}
  },
  {
    {3100014, 3}
  },
  {
    {3400037, 2},
    {3000002, 5000}
  },
  {
    {3000232, 1}
  },
  {
    {3000233, 1}
  },
  {
    {3000234, 1}
  },
  {
    {3000235, 1}
  },
  {
    {3000271, 200}
  },
  {
    {3000003, 50}
  },
  {
    {3000272, 1}
  },
  {
    {3000003, 20},
    {3000002, 5000}
  },
  {
    {3000003, 20},
    {3100014, 2}
  },
  {
    {3000273, 1}
  },
  {
    {3000003, 20},
    {3400037, 2}
  },
  {
    {3000274, 1}
  },
  {
    {3000003, 20},
    {3500001, 150}
  },
  {
    {3000313, 90}
  },
  {
    {3000314, 1}
  },
  {
    {3000315, 1}
  },
  {
    {3000003, 25}
  },
  {
    {3000316, 1}
  },
  {
    {3000317, 1}
  },
  {
    {3000318, 1}
  },
  {
    {3000319, 1}
  },
  {
    {2},
    {101706011}
  }
}
local config = {
  [101501001] = {
    101501001,
    1,
    {-801, -275},
    0
  },
  [101501002] = {
    101501002,
    4,
    {-568, -137},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50160101,
        Desc = "str_n12_story_desc_1"
      }
    }
  },
  [101501003] = {
    101501003,
    3,
    {-203, 73},
    5123001
  },
  [101501004] = {
    101501004,
    3,
    {-477, 293},
    5123003,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[10]
  },
  [101501005] = {
    101501005,
    7,
    {-699, 200},
    0,
    nil,
    nil,
    common[21]
  },
  [101501006] = {
    101501006,
    4,
    {106, 244},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50160102,
        Desc = "str_n12_story_desc_2"
      }
    }
  },
  [101501007] = {
    101501007,
    6,
    {394, 390},
    0,
    nil,
    nil,
    common[22],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n12_entrust_stage_task_1_2",
        Head = "n12_ewai_icon_tesk01",
        ShowNumber = 1
      }
    }
  },
  [101501008] = {
    101501008,
    7,
    {45, -166},
    0,
    nil,
    nil,
    common[23]
  },
  [101501009] = {
    101501009,
    5,
    {225, -405},
    0,
    nil,
    nil,
    common[22],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n12_entrust_stage_task_1_1",
        Head = "n12_ewai_icon_tesk",
        ShowNumber = 1
      }
    }
  },
  [101501010] = {
    101501010,
    3,
    {354, -101},
    5123002
  },
  [101501011] = {
    101501011,
    7,
    {547, -305},
    0,
    nil,
    nil,
    common[24]
  },
  [101501012] = {
    101501012,
    2,
    {685, 88},
    0,
    nil,
    nil,
    common[25],
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [101502001] = {
    101502001,
    1,
    {-375, -397},
    0
  },
  [101502002] = {
    101502002,
    3,
    {-571, -199},
    5123004
  },
  [101502003] = {
    101502003,
    5,
    {-721, -415},
    0,
    nil,
    nil,
    common[26],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n12_entrust_stage_task_2_1",
        Head = "n12_ewai_icon_tesk10",
        ShowNumber = 1
      }
    }
  },
  [101502004] = {
    101502004,
    7,
    {-808, -8},
    0,
    nil,
    nil,
    common[27]
  },
  [101502005] = {
    101502005,
    4,
    {-614, 327},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50160201,
        Desc = "str_n12_story_desc_3"
      }
    }
  },
  [101502006] = {
    101502006,
    3,
    {-445, 161},
    5123005
  },
  [101502007] = {
    101502007,
    7,
    {-151, 307},
    0,
    nil,
    nil,
    common[28]
  },
  [101502008] = {
    101502008,
    3,
    {102, 200},
    5123006,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[10]
  },
  [101502009] = {
    101502009,
    7,
    {464, 73},
    0,
    nil,
    nil,
    common[21]
  },
  [101502010] = {
    101502010,
    4,
    {-90, -194},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50160202,
        Desc = "str_n12_story_desc_4"
      }
    }
  },
  [101502011] = {
    101502011,
    6,
    {226, -474},
    0,
    nil,
    nil,
    common[26],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n12_entrust_stage_task_2_2",
        Head = "n12_ewai_icon_tesk03",
        ShowNumber = 1
      }
    }
  },
  [101502012] = {
    101502012,
    2,
    {657, -317},
    0,
    nil,
    nil,
    common[25],
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [101503001] = {
    101503001,
    1,
    {-247, -401},
    0
  },
  [101503002] = {
    101503002,
    4,
    {-83, -237},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50160301,
        Desc = "str_n12_story_desc_5"
      }
    }
  },
  [101503003] = {
    101503003,
    3,
    {-288, 36},
    5123007
  },
  [101503004] = {
    101503004,
    7,
    {-520, 120},
    0,
    nil,
    nil,
    common[23]
  },
  [101503005] = {
    101503005,
    5,
    {-748, -12},
    0,
    nil,
    nil,
    common[29],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n12_entrust_stage_task_3_1",
        Head = "n12_ewai_icon_tesk05",
        ShowNumber = 1
      }
    }
  },
  [101503006] = {
    101503006,
    3,
    {232, -1},
    5123008
  },
  [101503007] = {
    101503007,
    7,
    {380, -199},
    0,
    nil,
    nil,
    common[24]
  },
  [101503008] = {
    101503008,
    5,
    {504, -367},
    0,
    nil,
    nil,
    common[29],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n12_entrust_stage_task_3_2",
        Head = "n12_ewai_icon_tesk07",
        ShowNumber = 1
      }
    }
  },
  [101503009] = {
    101503009,
    3,
    {86, 200},
    5123009,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[10]
  },
  [101503010] = {
    101503010,
    7,
    {-50, 337},
    0,
    nil,
    nil,
    common[21]
  },
  [101503011] = {
    101503011,
    6,
    {468, 164},
    0,
    nil,
    nil,
    {
      {3000232, 2}
    },
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n12_entrust_stage_task_3_3",
        Head = "n12_ewai_icon_tesk02",
        ShowNumber = 1
      }
    }
  },
  [101503012] = {
    101503012,
    4,
    {621, 13},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50160302,
        Desc = "str_n12_story_desc_6"
      }
    }
  },
  [101503013] = {
    101503013,
    2,
    {799, -194},
    0,
    nil,
    nil,
    common[25],
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [101504001] = {
    101504001,
    1,
    {712, 132},
    0
  },
  [101504002] = {
    101504002,
    3,
    {400, -27},
    5123010
  },
  [101504003] = {
    101504003,
    7,
    {190, 158},
    0,
    nil,
    nil,
    common[27]
  },
  [101504004] = {
    101504004,
    4,
    {550, -195},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50160401,
        Desc = "str_n12_story_desc_7"
      }
    }
  },
  [101504005] = {
    101504005,
    5,
    {725, -389},
    0,
    nil,
    nil,
    common[30],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n12_entrust_stage_task_4_1",
        Head = "n12_ewai_icon_tesk10",
        ShowNumber = 1
      }
    }
  },
  [101504006] = {
    101504006,
    6,
    {-206, 89},
    0,
    nil,
    nil,
    common[30],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n12_entrust_stage_task_4_2",
        Head = "n12_ewai_icon_tesk08",
        ShowNumber = 1
      }
    }
  },
  [101504007] = {
    101504007,
    3,
    {-345, 242},
    5123011
  },
  [101504008] = {
    101504008,
    7,
    {-571, 276},
    0,
    nil,
    nil,
    common[28]
  },
  [101504009] = {
    101504009,
    3,
    {90, -164},
    5123012,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[10]
  },
  [101504010] = {
    101504010,
    7,
    {321, -380},
    0,
    nil,
    nil,
    common[21]
  },
  [101504011] = {
    101504011,
    4,
    {-465, -29},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50160402,
        Desc = "str_n12_story_desc_8"
      }
    }
  },
  [101504012] = {
    101504012,
    2,
    {-763, -150},
    0,
    nil,
    nil,
    common[25],
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [101505001] = {
    101505001,
    1,
    {773, -340},
    0
  },
  [101505002] = {
    101505002,
    3,
    {623, -196},
    5123013
  },
  [101505003] = {
    101505003,
    4,
    {456, -29},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50160501,
        Desc = "str_n12_story_desc_9"
      }
    }
  },
  [101505004] = {
    101505004,
    3,
    {291, -219},
    5123014
  },
  [101505005] = {
    101505005,
    5,
    {157, -392},
    0,
    nil,
    nil,
    common[31],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n12_entrust_stage_task_5_1",
        Head = "n12_ewai_icon_tesk",
        ShowNumber = 1
      }
    }
  },
  [101505006] = {
    101505006,
    7,
    {596, 166},
    0,
    nil,
    nil,
    {
      {3000002, 8000}
    }
  },
  [101505007] = {
    101505007,
    5,
    {151, 302},
    0,
    nil,
    nil,
    common[31],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n12_entrust_stage_task_5_2",
        Head = "n12_ewai_icon_tesk06",
        ShowNumber = 1
      }
    }
  },
  [101505008] = {
    101505008,
    4,
    {-69, 75},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50160502,
        Desc = "str_n12_story_desc_10"
      }
    }
  },
  [101505009] = {
    101505009,
    3,
    {-186, 225},
    5123015,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[10]
  },
  [101505010] = {
    101505010,
    7,
    {-310, 363},
    0,
    nil,
    nil,
    common[21]
  },
  [101505011] = {
    101505011,
    6,
    {-314, -218},
    0,
    nil,
    nil,
    {
      {3000234, 2}
    },
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n12_entrust_stage_task_5_3",
        Head = "n12_ewai_icon_tesk10",
        ShowNumber = 1
      }
    }
  },
  [101505012] = {
    101505012,
    2,
    {-611, -286},
    0,
    nil,
    nil,
    common[25],
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [101506001] = {
    101506001,
    1,
    {670, 270},
    0
  },
  [101506002] = {
    101506002,
    4,
    {470, 140},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50160601,
        Desc = "str_n12_story_desc_11"
      }
    }
  },
  [101506003] = {
    101506003,
    3,
    {654, -29},
    5123016
  },
  [101506004] = {
    101506004,
    5,
    {808, -214},
    0,
    nil,
    nil,
    common[32],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n12_entrust_stage_task_6_1",
        Head = "n12_ewai_icon_tesk",
        ShowNumber = 1
      }
    }
  },
  [101506005] = {
    101506005,
    4,
    {154, 95},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50160602,
        Desc = "str_n12_story_desc_12"
      }
    }
  },
  [101506006] = {
    101506006,
    3,
    {-107, 287},
    5123017
  },
  [101506007] = {
    101506007,
    3,
    {-536, 178},
    5123018,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[10]
  },
  [101506008] = {
    101506008,
    7,
    {-721, -59},
    0,
    nil,
    nil,
    common[21]
  },
  [101506009] = {
    101506009,
    6,
    {-113, -26},
    0,
    nil,
    nil,
    {
      {3000235, 2}
    },
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n12_entrust_stage_task_6_2",
        Head = "n12_ewai_icon_tesk04",
        ShowNumber = 1
      }
    }
  },
  [101506010] = {
    101506010,
    7,
    {-369, -378},
    0,
    nil,
    nil,
    {
      {3500001, 150}
    }
  },
  [101506011] = {
    101506011,
    5,
    {328, -59},
    0,
    nil,
    nil,
    common[32],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n12_entrust_stage_task_6_3",
        Head = "n12_ewai_icon_tesk09",
        ShowNumber = 1
      }
    }
  },
  [101506012] = {
    101506012,
    2,
    {-95, -403},
    0,
    nil,
    nil,
    common[25],
    nil,
    nil,
    nil,
    nil,
    {
      {BannerID = 50160603, BannerType = 1}
    }
  },
  [101601001] = {
    101601001,
    1,
    {30, 414},
    0
  },
  [101601002] = {
    101601002,
    4,
    {428, 118},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50340101,
        Desc = "str_n22_story_desc_1"
      }
    }
  },
  [101601003] = {
    101601003,
    7,
    common[1],
    0,
    nil,
    nil,
    common[33]
  },
  [101601004] = {
    101601004,
    3,
    {-445, -252},
    5222016
  },
  [101601005] = {
    101601005,
    4,
    {-657, -42},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50340102,
        Desc = "str_n22_story_desc_2"
      }
    }
  },
  [101601006] = {
    101601006,
    2,
    {-843, 121},
    0,
    nil,
    nil,
    common[34],
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [101601007] = {
    101601007,
    8,
    {-70, -144},
    0,
    nil,
    nil,
    nil,
    101601008,
    nil,
    nil,
    nil,
    common[12]
  },
  [101601008] = {
    101601008,
    8,
    {-243, 46},
    0,
    nil,
    nil,
    nil,
    101601007,
    nil,
    nil,
    nil,
    common[12]
  },
  [101601009] = {
    101601009,
    5,
    {-431, 236},
    0,
    nil,
    nil,
    common[35],
    nil,
    nil,
    nil,
    nil,
    common[13]
  },
  [101601010] = {
    101601010,
    7,
    {-81, 231},
    0,
    nil,
    nil,
    common[36]
  },
  [101601011] = {
    101601011,
    7,
    {797, 201},
    0,
    nil,
    nil,
    common[37]
  },
  [101601012] = {
    101601012,
    7,
    {650, -284},
    0,
    nil,
    nil,
    common[33]
  },
  [101601013] = {
    101601013,
    5,
    {792, -54},
    0,
    nil,
    nil,
    common[35],
    nil,
    nil,
    nil,
    nil,
    common[13]
  },
  [101601014] = {
    101601014,
    6,
    {-43, -376},
    0,
    nil,
    nil,
    {
      {3000272, 2}
    },
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n22_entrust_stage_task_1_1",
        Head = "n22_wt_dfqb_hero01",
        ShowNumber = 1
      }
    }
  },
  [101602001] = {
    101602001,
    1,
    {94, 398},
    0
  },
  [101602002] = {
    101602002,
    4,
    {16, 194},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50340201,
        Desc = "str_n22_story_desc_3"
      }
    }
  },
  [101602003] = {
    101602003,
    3,
    {-80, -43},
    5222017
  },
  [101602004] = {
    101602004,
    6,
    {66, -270},
    0,
    nil,
    nil,
    {
      {3000273, 2}
    },
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n22_entrust_stage_task_2_1",
        Head = "n22_wt_dfqb_hero02",
        ShowNumber = 1
      }
    }
  },
  [101602005] = {
    101602005,
    4,
    {470, -205},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50340202,
        Desc = "str_n22_story_desc_4"
      }
    }
  },
  [101602006] = {
    101602006,
    2,
    {856, -213},
    0,
    nil,
    nil,
    common[34],
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [101602007] = {
    101602007,
    8,
    {-285, -245},
    0,
    nil,
    nil,
    nil,
    101602008,
    nil,
    nil,
    nil,
    common[12]
  },
  [101602008] = {
    101602008,
    8,
    {-683, 276},
    0,
    nil,
    nil,
    nil,
    101602007,
    nil,
    nil,
    nil,
    common[12]
  },
  [101602009] = {
    101602009,
    7,
    {-746, 26},
    0,
    nil,
    nil,
    common[33]
  },
  [101602010] = {
    101602010,
    5,
    {-844, -213},
    0,
    nil,
    nil,
    common[38],
    nil,
    nil,
    nil,
    nil,
    common[14]
  },
  [101602011] = {
    101602011,
    5,
    {-344, 265},
    0,
    nil,
    nil,
    common[38],
    nil,
    nil,
    nil,
    nil,
    common[14]
  },
  [101602012] = {
    101602012,
    7,
    {-476, -23},
    0,
    nil,
    nil,
    common[39]
  },
  [101602013] = {
    101602013,
    7,
    {-575, -396},
    0,
    nil,
    nil,
    common[36]
  },
  [101602014] = {
    101602014,
    7,
    {399, 174},
    0,
    nil,
    nil,
    common[33]
  },
  [101603001] = {
    101603001,
    1,
    {171, 405},
    0
  },
  [101603002] = {
    101603002,
    4,
    {241, 154},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50340301,
        Desc = "str_n22_story_desc_5"
      }
    }
  },
  [101603003] = {
    101603003,
    6,
    {21, -145},
    0,
    nil,
    nil,
    {
      {3000274, 2}
    },
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n22_entrust_stage_task_3_1",
        Head = "n22_wt_dfqb_hero01",
        ShowNumber = 1
      }
    }
  },
  [101603004] = {
    101603004,
    4,
    {-344, -273},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50340302,
        Desc = "str_n22_story_desc_6"
      }
    }
  },
  [101603005] = {
    101603005,
    2,
    {-782, -268},
    0,
    nil,
    nil,
    common[34],
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [101603006] = {
    101603006,
    8,
    {502, 308},
    0,
    nil,
    nil,
    nil,
    101603007,
    nil,
    nil,
    nil,
    common[12]
  },
  [101603007] = {
    101603007,
    8,
    {340, -414},
    0,
    nil,
    nil,
    nil,
    101603006,
    nil,
    nil,
    nil,
    common[12]
  },
  [101603008] = {
    101603008,
    5,
    {726, -363},
    0,
    nil,
    nil,
    common[40],
    nil,
    nil,
    nil,
    nil,
    common[15]
  },
  [101603009] = {
    101603009,
    7,
    {711, -33},
    0,
    nil,
    nil,
    common[33]
  },
  [101603010] = {
    101603010,
    8,
    {450, 106},
    0,
    nil,
    nil,
    nil,
    101603011,
    nil,
    nil,
    nil,
    common[12]
  },
  [101603011] = {
    101603011,
    8,
    {-274, 111},
    0,
    nil,
    nil,
    nil,
    101603010,
    nil,
    nil,
    nil,
    common[12]
  },
  [101603012] = {
    101603012,
    7,
    {-94, 301},
    0,
    nil,
    nil,
    common[41]
  },
  [101603013] = {
    101603013,
    7,
    {-511, 294},
    0,
    nil,
    nil,
    common[33]
  },
  [101603014] = {
    101603014,
    5,
    {-316, 432},
    0,
    nil,
    nil,
    common[40],
    nil,
    nil,
    nil,
    nil,
    common[15]
  },
  [101603015] = {
    101603015,
    7,
    {827, 170},
    0,
    nil,
    nil,
    common[37]
  },
  [101603016] = {
    101603016,
    8,
    {400, -124},
    0,
    nil,
    nil,
    nil,
    101603001,
    nil,
    nil,
    nil,
    common[12]
  },
  [101603017] = {
    101603017,
    3,
    {-101, -403},
    5222018
  },
  [101604001] = {
    101604001,
    1,
    {-539, 404},
    0
  },
  [101604002] = {
    101604002,
    4,
    {-249, 245},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50340401,
        Desc = "str_n22_story_desc_7"
      }
    }
  },
  [101604003] = {
    101604003,
    3,
    common[2],
    5222013
  },
  [101604004] = {
    101604004,
    8,
    {177, 299},
    0,
    nil,
    nil,
    nil,
    101604005,
    nil,
    nil,
    nil,
    common[12]
  },
  [101604005] = {
    101604005,
    8,
    common[3],
    0,
    nil,
    nil,
    nil,
    101604004,
    nil,
    nil,
    nil,
    common[12]
  },
  [101604006] = {
    101604006,
    7,
    common[4],
    0,
    nil,
    nil,
    common[33]
  },
  [101604007] = {
    101604007,
    7,
    {808, 153},
    0,
    nil,
    nil,
    common[37]
  },
  [101604008] = {
    101604008,
    8,
    {473, 308},
    0,
    nil,
    nil,
    nil,
    101604009,
    nil,
    nil,
    nil,
    common[12]
  },
  [101604009] = {
    101604009,
    8,
    {72, -204},
    0,
    nil,
    nil,
    nil,
    101604008,
    nil,
    nil,
    nil,
    common[12]
  },
  [101604010] = {
    101604010,
    8,
    {-250, -287},
    0,
    nil,
    nil,
    nil,
    101604013,
    nil,
    nil,
    nil,
    common[12]
  },
  [101604011] = {
    101604011,
    4,
    {383, -170},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50340402,
        Desc = "str_n22_story_desc_8"
      }
    }
  },
  [101604012] = {
    101604012,
    2,
    {649, -374},
    0,
    nil,
    nil,
    common[34],
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [101604013] = {
    101604013,
    7,
    {297, 126},
    0,
    nil,
    nil,
    common[33]
  },
  [101604014] = {
    101604014,
    7,
    {-380, -19},
    0,
    nil,
    nil,
    common[33]
  },
  [101604015] = {
    101604015,
    7,
    {-811, 8},
    0,
    nil,
    nil,
    common[36]
  },
  [101604016] = {
    101604016,
    8,
    {765, 391},
    0,
    nil,
    nil,
    nil,
    101604014,
    nil,
    nil,
    nil,
    common[12]
  },
  [101604017] = {
    101604017,
    7,
    {295, -401},
    0,
    nil,
    nil,
    common[41]
  },
  [101605001] = {
    101605001,
    1,
    {-808, -140},
    0
  },
  [101605002] = {
    101605002,
    4,
    {-554, -297},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50340501,
        Desc = "str_n22_story_desc_9"
      }
    }
  },
  [101605003] = {
    101605003,
    8,
    {-573, -76},
    0,
    nil,
    nil,
    nil,
    101605004,
    nil,
    nil,
    nil,
    common[12]
  },
  [101605004] = {
    101605004,
    8,
    {-618, 400},
    0,
    nil,
    nil,
    nil,
    101605003,
    nil,
    nil,
    nil,
    common[12]
  },
  [101605005] = {
    101605005,
    3,
    {-250, 277},
    5222014
  },
  [101605006] = {
    101605006,
    4,
    {307, 58},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50340502,
        Desc = "str_n22_story_desc_10"
      }
    }
  },
  [101605007] = {
    101605007,
    2,
    {55, -301},
    0,
    nil,
    nil,
    common[34],
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [101605008] = {
    101605008,
    7,
    {-275, -386},
    0,
    nil,
    nil,
    common[36]
  },
  [101605009] = {
    101605009,
    7,
    {-44, 415},
    0,
    nil,
    nil,
    common[39]
  },
  [101605010] = {
    101605010,
    8,
    {255, 320},
    0,
    nil,
    nil,
    nil,
    101605008,
    nil,
    nil,
    nil,
    common[12]
  },
  [101605011] = {
    101605011,
    7,
    {-423, 146},
    0,
    nil,
    nil,
    common[33]
  },
  [101605012] = {
    101605012,
    8,
    {-90, 29},
    0,
    nil,
    nil,
    nil,
    101605013,
    nil,
    nil,
    nil,
    common[12]
  },
  [101605013] = {
    101605013,
    8,
    {710, 260},
    0,
    nil,
    nil,
    nil,
    101605012,
    nil,
    nil,
    nil,
    common[12]
  },
  [101605014] = {
    101605014,
    7,
    {539, 74},
    0,
    nil,
    nil,
    common[33]
  },
  [101605015] = {
    101605015,
    7,
    {848, -31},
    0,
    nil,
    nil,
    common[37]
  },
  [101605016] = {
    101605016,
    7,
    {396, -162},
    0,
    nil,
    nil,
    common[33]
  },
  [101605017] = {
    101605017,
    8,
    {724, -287},
    0,
    nil,
    nil,
    nil,
    101605008,
    nil,
    nil,
    nil,
    common[12]
  },
  [101606001] = {
    101606001,
    1,
    {782, 258},
    0
  },
  [101606002] = {
    101606002,
    7,
    {454, 282},
    0,
    nil,
    nil,
    common[33]
  },
  [101606003] = {
    101606003,
    8,
    {491, 39},
    0,
    nil,
    nil,
    nil,
    101606013,
    nil,
    nil,
    nil,
    common[12]
  },
  [101606004] = {
    101606004,
    7,
    {774, -48},
    0,
    nil,
    nil,
    common[33]
  },
  [101606005] = {
    101606005,
    8,
    {763, -278},
    0,
    nil,
    nil,
    nil,
    101606006,
    nil,
    nil,
    nil,
    common[12]
  },
  [101606006] = {
    101606006,
    8,
    {-853, 273},
    0,
    nil,
    nil,
    nil,
    101606005,
    nil,
    nil,
    nil,
    common[12]
  },
  [101606007] = {
    101606007,
    4,
    {-825, 34},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50340601,
        Desc = "str_n22_story_desc_11"
      }
    }
  },
  [101606008] = {
    101606008,
    3,
    {-570, -73},
    5222015
  },
  [101606009] = {
    101606009,
    4,
    {-456, -305},
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50340602,
        Desc = "str_n22_story_desc_12"
      }
    }
  },
  [101606010] = {
    101606010,
    2,
    {-178, -445},
    0,
    nil,
    nil,
    common[34],
    nil,
    nil,
    nil,
    nil,
    {
      {BannerID = 50340603, BannerType = 1}
    }
  },
  [101606011] = {
    101606011,
    7,
    {137, 412},
    0,
    nil,
    nil,
    common[33]
  },
  [101606012] = {
    101606012,
    7,
    {-111, 359},
    0,
    nil,
    nil,
    common[33]
  },
  [101606013] = {
    101606013,
    8,
    {420, -162},
    0,
    nil,
    nil,
    nil,
    101606003,
    nil,
    nil,
    nil,
    common[12]
  },
  [101606014] = {
    101606014,
    7,
    {28, -117},
    0,
    nil,
    nil,
    common[33]
  },
  [101606015] = {
    101606015,
    7,
    {-338, 124},
    0,
    nil,
    nil,
    common[41]
  },
  [101606016] = {
    101606016,
    7,
    {-252, -141},
    0,
    nil,
    nil,
    common[33]
  },
  [101606017] = {
    101606017,
    7,
    {-711, -396},
    0,
    nil,
    nil,
    common[39]
  },
  [101701001] = {
    101701001,
    1,
    {132, 287},
    0,
    "str_n30_entrust_point_name_1_1",
    common[5],
    nil,
    nil,
    nil,
    nil,
    nil,
    common[16]
  },
  [101701002] = {
    101701002,
    4,
    {423, 250},
    0,
    "str_n30_entrust_point_name_1_2",
    common[5],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500101,
        Desc = "str_n30_entrust_story_desc_1_1"
      }
    }
  },
  [101701003] = {
    101701003,
    7,
    {194, 30},
    0,
    "str_n30_entrust_point_name_1_3",
    common[5],
    common[42]
  },
  [101701004] = {
    101701004,
    8,
    common[1],
    0,
    "str_n30_entrust_point_name_1_4",
    common[5],
    nil,
    101701005,
    nil,
    nil,
    nil,
    common[17]
  },
  [101701005] = {
    101701005,
    8,
    {-749, -379},
    0,
    "str_n30_entrust_point_name_1_5",
    common[5],
    nil,
    101701004,
    nil,
    nil,
    nil,
    common[17]
  },
  [101701006] = {
    101701006,
    3,
    {-807, -90},
    5303001,
    "str_n30_entrust_point_name_1_6",
    common[5],
    nil,
    nil,
    nil,
    nil,
    nil,
    common[10]
  },
  [101701007] = {
    101701007,
    6,
    {-113, 64},
    0,
    "str_n30_entrust_point_name_1_7",
    common[5],
    {
      {3000314, 2}
    },
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_submit_1",
        Head = "n30_wt_hero02",
        ShowNumber = 1
      }
    }
  },
  [101701008] = {
    101701008,
    4,
    {-407, -174},
    0,
    "str_n30_entrust_point_name_1_8",
    common[5],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500102,
        Desc = "str_n30_entrust_story_desc_1_2"
      }
    }
  },
  [101701009] = {
    101701009,
    2,
    {-125, -395},
    0,
    "str_n30_entrust_point_name_1_9",
    common[5],
    common[34],
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [101701010] = {
    101701010,
    3,
    {796, 189},
    5303002,
    "str_n30_entrust_point_name_1_10",
    common[5]
  },
  [101701011] = {
    101701011,
    5,
    {797, -74},
    0,
    "str_n30_entrust_point_name_1_11",
    common[5],
    common[43],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_accept_1_1",
        Head = "n30_wt_icon08",
        ShowNumber = 1
      }
    }
  },
  [101701012] = {
    101701012,
    7,
    {625, -394},
    0,
    "str_n30_entrust_point_name_1_12",
    common[5],
    common[42]
  },
  [101701013] = {
    101701013,
    5,
    {-610, 82},
    0,
    "str_n30_entrust_point_name_1_13",
    common[5],
    common[43],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_accept_1_2",
        Head = "n30_wt_icon08",
        ShowNumber = 1
      }
    }
  },
  [101701014] = {
    101701014,
    7,
    {-415, 231},
    0,
    "str_n30_entrust_point_name_1_14",
    common[5],
    common[36]
  },
  [101702001] = {
    101702001,
    1,
    {169, 305},
    0,
    "str_n30_entrust_point_name_2_1",
    common[6],
    nil,
    nil,
    nil,
    nil,
    nil,
    common[16]
  },
  [101702002] = {
    101702002,
    3,
    {432, 117},
    5303003,
    "str_n30_entrust_point_name_2_2",
    common[6]
  },
  [101702003] = {
    101702003,
    4,
    {808, 55},
    0,
    "str_n30_entrust_point_name_2_3",
    common[6],
    nil,
    nil,
    nil,
    nil,
    {
      {1},
      {101702004, 101702005}
    },
    {
      {
        StoryID = 50500201,
        Desc = "str_n30_entrust_story_desc_2_1"
      }
    }
  },
  [101702004] = {
    101702004,
    3,
    {677, -254},
    5303004,
    "str_n30_entrust_point_name_2_4",
    common[7]
  },
  [101702005] = {
    101702005,
    5,
    {558, -101},
    0,
    "str_n30_entrust_point_name_2_5",
    common[8],
    common[44],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_accept_2_1",
        Head = "n30_wt_icon07",
        ShowNumber = 1
      }
    }
  },
  [101702006] = {
    101702006,
    6,
    {173, 34},
    0,
    "str_n30_entrust_point_name_2_6",
    common[8],
    {
      {3000315, 2}
    },
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_submit_2",
        Head = "n30_wt_hero07",
        ShowNumber = 1
      }
    }
  },
  [101702007] = {
    101702007,
    4,
    {502, -466},
    0,
    "str_n30_entrust_point_name_2_7",
    common[7],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500202,
        Desc = "str_n30_entrust_story_desc_2_2"
      }
    }
  },
  [101702008] = {
    101702008,
    4,
    {315, -182},
    0,
    "str_n30_entrust_point_name_2_8",
    common[8],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500204,
        Desc = "str_n30_entrust_story_desc_2_4"
      }
    }
  },
  [101702009] = {
    101702009,
    9,
    {201, -405},
    0,
    "str_n30_entrust_point_name_2_9",
    common[7],
    nil,
    nil,
    101702010,
    101702006,
    nil,
    common[18]
  },
  [101702010] = {
    101702010,
    9,
    {17, -217},
    0,
    "str_n30_entrust_point_name_2_10",
    common[8],
    nil,
    nil,
    101702009,
    nil,
    nil,
    common[18]
  },
  [101702011] = {
    101702011,
    3,
    {-206, -450},
    5303005,
    "str_n30_entrust_point_name_2_11",
    common[7],
    nil,
    nil,
    nil,
    nil,
    nil,
    common[10]
  },
  [101702012] = {
    101702012,
    7,
    {-286, -100},
    0,
    "str_n30_entrust_point_name_2_12",
    common[8],
    common[42]
  },
  [101702013] = {
    101702013,
    4,
    {-490, -314},
    0,
    "str_n30_entrust_point_name_2_13",
    common[7],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500203,
        Desc = "str_n30_entrust_story_desc_2_3"
      }
    }
  },
  [101702014] = {
    101702014,
    4,
    {-556, 170},
    0,
    "str_n30_entrust_point_name_2_14",
    common[8],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500205,
        Desc = "str_n30_entrust_story_desc_2_5"
      }
    }
  },
  [101702015] = {
    101702015,
    2,
    {-829, -407},
    0,
    "str_n30_entrust_point_name_2_15",
    common[7],
    common[45],
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [101702016] = {
    101702016,
    2,
    {-844, 69},
    0,
    "str_n30_entrust_point_name_2_16",
    common[8],
    common[45],
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [101702017] = {
    101702017,
    8,
    {863, -452},
    0,
    "str_n30_entrust_point_name_2_17",
    common[7],
    nil,
    101702018,
    nil,
    nil,
    nil,
    common[17]
  },
  [101702018] = {
    101702018,
    8,
    {-302, 293},
    0,
    "str_n30_entrust_point_name_2_18",
    common[7],
    nil,
    101702017,
    nil,
    nil,
    nil,
    common[17]
  },
  [101702019] = {
    101702019,
    5,
    {-540, -99},
    0,
    "str_n30_entrust_point_name_2_19",
    common[7],
    common[44],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_accept_2_2",
        Head = "n30_wt_icon07",
        ShowNumber = 1
      }
    }
  },
  [101702020] = {
    101702020,
    7,
    {-861, -159},
    0,
    "str_n30_entrust_point_name_2_20",
    common[7],
    common[42]
  },
  [101702021] = {
    101702021,
    7,
    {-82, 106},
    0,
    "str_n30_entrust_point_name_2_21",
    common[7],
    common[39]
  },
  [101703001] = {
    101703001,
    1,
    {472, 23},
    0,
    "str_n30_entrust_point_name_3_1",
    common[7],
    nil,
    nil,
    nil,
    nil,
    nil,
    common[19]
  },
  [101703002] = {
    101703002,
    4,
    {181, -63},
    0,
    "str_n30_entrust_point_name_3_2",
    common[7],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500301,
        Desc = "str_n30_entrust_story_desc_3_1"
      }
    }
  },
  [101703003] = {
    101703003,
    5,
    {55, -348},
    0,
    "str_n30_entrust_point_name_3_3",
    common[7],
    common[46],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_accept_3_1",
        Head = "n30_wt_icon02",
        ShowNumber = 1
      }
    }
  },
  [101703004] = {
    101703004,
    3,
    {-464, -396},
    5303006,
    "str_n30_entrust_point_name_3_4",
    common[7]
  },
  [101703005] = {
    101703005,
    4,
    {-214, -82},
    0,
    "str_n30_entrust_point_name_3_5",
    common[7],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500302,
        Desc = "str_n30_entrust_story_desc_3_2"
      }
    }
  },
  [101703006] = {
    101703006,
    6,
    {407, 299},
    0,
    "str_n30_entrust_point_name_3_6",
    common[7],
    {
      {3000316, 2}
    },
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_submit_3",
        Head = "n30_wt_hero06",
        ShowNumber = 1
      }
    }
  },
  [101703007] = {
    101703007,
    4,
    {855, 141},
    0,
    "str_n30_entrust_point_name_3_7",
    common[7],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500303,
        Desc = "str_n30_entrust_story_desc_3_3"
      }
    }
  },
  [101703008] = {
    101703008,
    2,
    {704, -365},
    0,
    "str_n30_entrust_point_name_3_8",
    common[7],
    common[34],
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [101703009] = {
    101703009,
    8,
    {-822, -337},
    0,
    "str_n30_entrust_point_name_3_9",
    common[7],
    nil,
    101703011,
    nil,
    nil,
    nil,
    common[17]
  },
  [101703010] = {
    101703010,
    7,
    {-671, -121},
    0,
    "str_n30_entrust_point_name_3_10",
    common[7],
    common[42]
  },
  [101703011] = {
    101703011,
    8,
    {-296, 248},
    0,
    "str_n30_entrust_point_name_3_11",
    common[7],
    nil,
    101703009,
    nil,
    nil,
    nil,
    common[17]
  },
  [101703012] = {
    101703012,
    5,
    {40, 311},
    0,
    "str_n30_entrust_point_name_3_12",
    common[7],
    common[46],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_accept_3_2",
        Head = "n30_wt_icon02",
        ShowNumber = 1
      }
    }
  },
  [101703013] = {
    101703013,
    3,
    {-547, 69},
    5303007,
    "str_n30_entrust_point_name_3_13",
    common[7],
    nil,
    nil,
    nil,
    nil,
    nil,
    common[10]
  },
  [101703014] = {
    101703014,
    7,
    {-833, 141},
    0,
    "str_n30_entrust_point_name_3_14",
    common[7],
    common[37]
  },
  [101703015] = {
    101703015,
    7,
    {361, -354},
    0,
    "str_n30_entrust_point_name_3_15",
    common[7],
    common[42]
  },
  [101704001] = {
    101704001,
    1,
    {-474, 149},
    0,
    "str_n30_entrust_point_name_4_1",
    common[8],
    nil,
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [101704002] = {
    101704002,
    4,
    {-198, 301},
    0,
    "str_n30_entrust_point_name_4_2",
    common[8],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500401,
        Desc = "str_n30_entrust_story_desc_4_1"
      }
    }
  },
  [101704003] = {
    101704003,
    3,
    common[2],
    5303008,
    "str_n30_entrust_point_name_4_3",
    common[8]
  },
  [101704004] = {
    101704004,
    4,
    {269, 269},
    0,
    "str_n30_entrust_point_name_4_4",
    common[8],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500402,
        Desc = "str_n30_entrust_story_desc_4_2"
      }
    }
  },
  [101704005] = {
    101704005,
    3,
    common[3],
    5303009,
    "str_n30_entrust_point_name_4_5",
    common[8],
    nil,
    nil,
    nil,
    nil,
    nil,
    common[10]
  },
  [101704006] = {
    101704006,
    4,
    common[4],
    0,
    "str_n30_entrust_point_name_4_6",
    common[8],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500403,
        Desc = "str_n30_entrust_story_desc_4_3"
      }
    }
  },
  [101704007] = {
    101704007,
    2,
    {653, -373},
    0,
    "str_n30_entrust_point_name_4_7",
    common[8],
    common[34],
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [101704008] = {
    101704008,
    5,
    {838, 139},
    0,
    "str_n30_entrust_point_name_4_8",
    common[8],
    common[47],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_accept_4_1",
        Head = "n30_wt_icon01",
        ShowNumber = 1
      }
    }
  },
  [101704009] = {
    101704009,
    8,
    {238, -130},
    0,
    "str_n30_entrust_point_name_4_9",
    common[8],
    nil,
    101704013,
    nil,
    nil,
    nil,
    common[17]
  },
  [101704010] = {
    101704010,
    7,
    {233, -402},
    0,
    "str_n30_entrust_point_name_4_10",
    common[8],
    common[41]
  },
  [101704011] = {
    101704011,
    3,
    {-504, -401},
    5303010,
    "str_n30_entrust_point_name_4_11",
    common[8]
  },
  [101704012] = {
    101704012,
    5,
    {-77, -443},
    0,
    "str_n30_entrust_point_name_4_12",
    common[8],
    common[47],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_accept_4_2",
        Head = "n30_wt_icon01",
        ShowNumber = 1
      }
    }
  },
  [101704013] = {
    101704013,
    8,
    {-155, -226},
    0,
    "str_n30_entrust_point_name_4_13",
    common[8],
    nil,
    101704009,
    nil,
    nil,
    nil,
    common[17]
  },
  [101704014] = {
    101704014,
    6,
    {-529, -56},
    0,
    "str_n30_entrust_point_name_4_14",
    common[8],
    {
      {3000317, 2}
    },
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_submit_4",
        Head = "n30_wt_hero05",
        ShowNumber = 1
      }
    }
  },
  [101704015] = {
    101704015,
    7,
    {-863, 37},
    0,
    "str_n30_entrust_point_name_4_15",
    common[8],
    common[42]
  },
  [101704016] = {
    101704016,
    7,
    {-836, -316},
    0,
    "str_n30_entrust_point_name_4_16",
    common[8],
    common[42]
  },
  [101705001] = {
    101705001,
    1,
    {-889, -224},
    0,
    "str_n30_entrust_point_name_5_1",
    common[7],
    nil,
    nil,
    nil,
    nil,
    nil,
    common[19]
  },
  [101705002] = {
    101705002,
    1,
    {-711, -426},
    0,
    "str_n30_entrust_point_name_5_2",
    common[8],
    nil,
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [101705003] = {
    101705003,
    4,
    {-727, 1},
    0,
    "str_n30_entrust_point_name_5_3",
    common[7],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500501,
        Desc = "str_n30_entrust_story_desc_5_1"
      }
    }
  },
  [101705004] = {
    101705004,
    4,
    {-488, -205},
    0,
    "str_n30_entrust_point_name_5_4",
    common[8],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500502,
        Desc = "str_n30_entrust_story_desc_5_3"
      }
    }
  },
  [101705005] = {
    101705005,
    3,
    {-279, -386},
    5303011,
    "str_n30_entrust_point_name_5_5",
    common[8]
  },
  [101705006] = {
    101705006,
    7,
    {-485, 91},
    0,
    "str_n30_entrust_point_name_5_6",
    common[7],
    common[42]
  },
  [101705007] = {
    101705007,
    9,
    {-118, -179},
    0,
    "str_n30_entrust_point_name_5_7",
    common[8],
    nil,
    nil,
    101705008,
    nil,
    nil,
    common[18]
  },
  [101705008] = {
    101705008,
    9,
    {-151, 68},
    0,
    "str_n30_entrust_point_name_5_8",
    common[7],
    nil,
    nil,
    101705007,
    nil,
    nil,
    common[18]
  },
  [101705009] = {
    101705009,
    8,
    {81, -23},
    0,
    "str_n30_entrust_point_name_5_9",
    common[8],
    nil,
    101705011,
    nil,
    nil,
    nil,
    common[17]
  },
  [101705010] = {
    101705010,
    3,
    {246, 131},
    5303012,
    "str_n30_entrust_point_name_5_10",
    common[7]
  },
  [101705011] = {
    101705011,
    8,
    {372, -426},
    0,
    "str_n30_entrust_point_name_5_11",
    common[8],
    nil,
    101705009,
    nil,
    nil,
    nil,
    common[17]
  },
  [101705012] = {
    101705012,
    6,
    {728, -417},
    0,
    "str_n30_entrust_point_name_5_12",
    common[8],
    {
      {3000318, 3}
    },
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_submit_5",
        Head = "n30_wt_hero03",
        ShowNumber = 1
      }
    }
  },
  [101705013] = {
    101705013,
    3,
    {501, -166},
    5303013,
    "str_n30_entrust_point_name_5_13",
    common[8],
    nil,
    nil,
    nil,
    101705010,
    nil,
    common[10]
  },
  [101705014] = {
    101705014,
    4,
    {310, 350},
    0,
    "str_n30_entrust_point_name_5_14",
    common[7],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500503,
        Desc = "str_n30_entrust_story_desc_5_2"
      }
    }
  },
  [101705015] = {
    101705015,
    4,
    {550, 73},
    0,
    "str_n30_entrust_point_name_5_15",
    common[8],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500504,
        Desc = "str_n30_entrust_story_desc_5_4"
      }
    }
  },
  [101705016] = {
    101705016,
    2,
    {-14, 339},
    0,
    "str_n30_entrust_point_name_5_16",
    common[7],
    common[45],
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [101705017] = {
    101705017,
    2,
    {842, -157},
    0,
    "str_n30_entrust_point_name_5_17",
    common[8],
    common[45],
    101705008,
    nil,
    nil,
    nil,
    common[11]
  },
  [101705018] = {
    101705018,
    5,
    {-823, 184},
    0,
    "str_n30_entrust_point_name_5_18",
    common[7],
    common[48],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_accept_5_1",
        Head = "n30_wt_icon06",
        ShowNumber = 1
      }
    }
  },
  [101705019] = {
    101705019,
    5,
    {7, -432},
    0,
    "str_n30_entrust_point_name_5_19",
    common[8],
    common[48],
    101705013,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_accept_5_2",
        Head = "n30_wt_icon06",
        ShowNumber = 1
      }
    }
  },
  [101705020] = {
    101705020,
    7,
    {152, -242},
    0,
    "str_n30_entrust_point_name_5_20",
    common[8],
    common[42],
    101705012
  },
  [101705021] = {
    101705021,
    5,
    {-368, 290},
    0,
    "str_n30_entrust_point_name_5_21",
    common[7],
    common[48],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_accept_5_3",
        Head = "n30_wt_icon06",
        ShowNumber = 1
      }
    }
  },
  [101705022] = {
    101705022,
    7,
    {298, -60},
    0,
    "str_n30_entrust_point_name_5_22",
    common[8],
    common[39]
  },
  [101706001] = {
    101706001,
    1,
    {820, 143},
    0,
    "str_n30_entrust_point_name_6_1",
    common[6],
    nil,
    nil,
    nil,
    nil,
    nil,
    common[19]
  },
  [101706002] = {
    101706002,
    1,
    {-773, 116},
    0,
    "str_n30_entrust_point_name_6_2",
    common[9],
    nil,
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [101706003] = {
    101706003,
    4,
    {780, -69},
    0,
    "str_n30_entrust_point_name_6_3",
    common[6],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500601,
        Desc = "str_n30_entrust_story_desc_6_1"
      }
    }
  },
  [101706004] = {
    101706004,
    4,
    {-883, -91},
    0,
    "str_n30_entrust_point_name_6_4",
    common[9],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500602,
        Desc = "str_n30_entrust_story_desc_6_2"
      }
    }
  },
  [101706005] = {
    101706005,
    3,
    {823, -395},
    5303014,
    "str_n30_entrust_point_name_6_5",
    common[6]
  },
  [101706006] = {
    101706006,
    5,
    {-858, -382},
    0,
    "str_n30_entrust_point_name_6_6",
    common[9],
    common[49],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_accept_6_1",
        Head = "n30_wt_icon05",
        ShowNumber = 1
      }
    }
  },
  [101706007] = {
    101706007,
    6,
    {526, -272},
    0,
    "str_n30_entrust_point_name_6_7",
    common[6],
    {
      {3000319, 3}
    },
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_submit_6",
        Head = "n30_wt_hero04",
        ShowNumber = 1
      }
    }
  },
  [101706008] = {
    101706008,
    3,
    {-521, -233},
    5303015,
    "str_n30_entrust_point_name_6_8",
    common[9]
  },
  [101706009] = {
    101706009,
    9,
    {211, -391},
    0,
    "str_n30_entrust_point_name_6_9",
    common[6],
    nil,
    nil,
    101706010,
    nil,
    common[50],
    common[18]
  },
  [101706010] = {
    101706010,
    9,
    {-118, -385},
    0,
    "str_n30_entrust_point_name_6_10",
    common[9],
    nil,
    nil,
    101706009,
    101706007,
    common[50],
    common[18]
  },
  [101706011] = {
    101706011,
    4,
    {31, -154},
    0,
    "str_n30_entrust_point_name_6_11",
    common[5],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500603,
        Desc = "str_n30_entrust_story_desc_6_3"
      }
    }
  },
  [101706012] = {
    101706012,
    3,
    {315, -41},
    5303016,
    "str_n30_entrust_point_name_6_12",
    common[5],
    nil,
    nil,
    nil,
    nil,
    nil,
    common[10]
  },
  [101706013] = {
    101706013,
    4,
    {-251, 49},
    0,
    "str_n30_entrust_point_name_6_13",
    common[5],
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {
        StoryID = 50500604,
        Desc = "str_n30_entrust_story_desc_6_4"
      }
    }
  },
  [101706014] = {
    101706014,
    2,
    {36, 236},
    0,
    "str_n30_entrust_point_name_6_14",
    common[5],
    common[34],
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [101706015] = {
    101706015,
    5,
    {532, -19},
    0,
    "str_n30_entrust_point_name_6_15",
    common[6],
    common[49],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_accept_6_2",
        Head = "n30_wt_icon05",
        ShowNumber = 1
      }
    }
  },
  [101706016] = {
    101706016,
    8,
    {-507, -453},
    0,
    "str_n30_entrust_point_name_6_16",
    common[9],
    nil,
    101706017,
    nil,
    nil,
    nil,
    common[17]
  },
  [101706017] = {
    101706017,
    8,
    {-591, -52},
    0,
    "str_n30_entrust_point_name_6_17",
    common[9],
    nil,
    101706016,
    nil,
    nil,
    nil,
    common[17]
  },
  [101706018] = {
    101706018,
    5,
    {-498, 199},
    0,
    "str_n30_entrust_point_name_6_18",
    common[9],
    common[49],
    nil,
    nil,
    nil,
    nil,
    {
      {
        Desc = "str_n30_entrust_task_accept_6_3",
        Head = "n30_wt_icon05",
        ShowNumber = 1
      }
    }
  },
  [101706019] = {
    101706019,
    7,
    {-240, 301},
    0,
    "str_n30_entrust_point_name_6_19",
    common[9],
    common[42]
  },
  [101706020] = {
    101706020,
    7,
    {453, -483},
    0,
    "str_n30_entrust_point_name_6_20",
    common[6],
    common[42]
  },
  [101706021] = {
    101706021,
    7,
    {496, 223},
    0,
    "str_n30_entrust_point_name_6_21",
    common[5],
    common[37]
  }
}
return config, "EventID", key
