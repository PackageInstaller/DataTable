local key = {
  ID = 1,
  MaxScore = 2,
  RoundScore = 3,
  ScoreGroupId = 4,
  DropMax = 5,
  NewScoreGroupId = 6,
  NewDropMax = 7,
  MaxRound = 8,
  RoundRatio = 9,
  ResetRuleID = 10
}
local common = {
  {999210, 999211}
}
local config = {
  {
    1,
    1600,
    750,
    1,
    90,
    6,
    180,
    100,
    0.5,
    common[1]
  },
  {
    2,
    2400,
    1200,
    2,
    90,
    7,
    180,
    100,
    0.5,
    common[1]
  },
  {
    3,
    4000,
    2000,
    3,
    90,
    8,
    180,
    100,
    0.5,
    common[1]
  },
  {
    4,
    4800,
    2400,
    4,
    90,
    9,
    180,
    100,
    0.5,
    common[1]
  },
  {
    5,
    8000,
    4000,
    5,
    90,
    10,
    180,
    100,
    0.5,
    common[1]
  }
}
return config, "ID", key
