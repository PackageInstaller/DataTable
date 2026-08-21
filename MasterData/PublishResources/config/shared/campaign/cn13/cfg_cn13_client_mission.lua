local key = {
  ID = 1,
  VisitImage = 2,
  PuzzlePiece = 3,
  OriginPiecePos = 4,
  ActivityCmptID = 5,
  Name = 6,
  UnLockCost = 7
}
local common = {
  "test",
  {101, 10},
  {
    {
      "test4x4_1_1",
      "test4x4_1_2",
      "test4x4_1_3",
      "test4x4_1_4"
    },
    {
      "test4x4_2_1",
      "test4x4_2_2",
      "test4x4_2_3",
      "test4x4_2_4"
    },
    {
      "test4x4_3_1",
      "test4x4_3_2",
      "test4x4_3_3",
      "test4x4_3_4"
    },
    {
      "test4x4_4_1",
      "test4x4_4_2",
      "test4x4_4_3",
      "test4x4_4_4"
    }
  },
  {
    {
      "test4x4_1_2",
      "test4x4_1_1",
      "test4x4_1_3",
      "test4x4_1_4"
    },
    {
      "test4x4_2_1",
      "test4x4_2_4",
      "test4x4_2_3",
      "test4x4_2_2"
    },
    {
      "test4x4_3_2",
      "test4x4_3_1",
      "test4x4_3_3",
      "test4x4_3_4"
    },
    {
      "test4x4_4_1",
      "test4x4_4_3",
      "test4x4_4_2",
      "test4x4_4_4"
    }
  }
}
local config = {
  [1001] = {
    1001,
    common[1],
    {
      {
        "test_1_1",
        "test_1_2",
        "test_1_3"
      },
      {
        "test_2_1",
        "test_2_2",
        "test_2_3"
      },
      {
        "test_3_1",
        "test_3_2",
        "test_3_3"
      }
    },
    {
      {
        "test_3_1",
        "test_2_1",
        "test_3_3"
      },
      {
        "test_1_2",
        "test_3_2",
        "test_2_3"
      },
      {
        "test_1_1",
        "test_2_2",
        "test_1_3"
      }
    },
    700612101,
    "str_cn13_PerfectPuzzle_level_1",
    common[2]
  },
  [1002] = {
    1002,
    common[1],
    common[3],
    common[4],
    700612101,
    "str_cn13_PerfectPuzzle_level_2",
    common[2]
  },
  [1003] = {
    1003,
    common[1],
    common[3],
    common[4],
    700612101,
    "str_cn13_PerfectPuzzle_level_3",
    common[2]
  },
  [1004] = {
    1004,
    common[1],
    common[3],
    common[4],
    700612101,
    "str_cn13_PerfectPuzzle_level_4",
    common[2]
  },
  [1005] = {
    1005,
    common[1],
    common[3],
    common[4],
    700612101,
    "str_cn13_PerfectPuzzle_level_5",
    common[2]
  },
  [1006] = {
    1006,
    common[1],
    common[3],
    common[4],
    700612101,
    "str_cn13_PerfectPuzzle_level_6",
    common[2]
  },
  [1007] = {
    1007,
    common[1],
    common[3],
    common[4],
    700612101,
    "str_cn13_PerfectPuzzle_level_7",
    common[2]
  }
}
return config, "ID", key
