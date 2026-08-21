local key = {
  ID = 1,
  ComponentID = 2,
  NeedFragment = 3,
  Waypoint = 4,
  ReasoningRule = 5,
  FragmentList = 6,
  ClueList = 7,
  ClueFree = 8,
  BeforeReasoningPlot = 9,
  AfterReasoningPlot = 10,
  IntroPlot = 11
}
local common = {
  {
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12
  },
  {34},
  {
    35,
    36,
    37
  }
}
local config = {
  {
    1,
    108911209,
    nil,
    common[1],
    {1},
    common[2],
    {
      1,
      2,
      3,
      4,
      5,
      6,
      7
    },
    {1, 2},
    50470401,
    50470601,
    50470501
  },
  {
    2,
    108911209,
    common[2],
    common[1],
    {
      2,
      3,
      4
    },
    common[3],
    {
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24
    },
    nil,
    50470402,
    50470602,
    50470502
  },
  {
    3,
    108911209,
    common[3],
    {
      1,
      2,
      3,
      4,
      7,
      8,
      9,
      10,
      11,
      12
    },
    {
      5,
      6,
      7
    },
    {
      38,
      39,
      40
    },
    {
      25,
      26,
      27,
      28,
      29,
      30,
      31,
      32,
      33
    },
    nil,
    50470403,
    50470603,
    50470503
  }
}
return config, "ID", key
