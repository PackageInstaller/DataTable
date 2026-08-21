local key = {
  ID = 1,
  ReferralsScore = 2,
  GradeScore0 = 3,
  GradeScore1 = 4,
  GradeScore2 = 5,
  GradeScore3 = 6
}
local config = {
  [3] = {
    3,
    10,
    8,
    8,
    9,
    10
  },
  [4] = {
    4,
    10,
    8,
    10,
    12,
    15
  },
  [5] = {
    5,
    15,
    8,
    12,
    15,
    20
  },
  [6] = {
    6,
    20,
    8,
    12,
    15,
    20
  }
}
return config, "ID", key
