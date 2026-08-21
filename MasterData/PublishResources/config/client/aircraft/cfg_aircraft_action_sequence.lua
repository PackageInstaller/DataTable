local key = {
  ID = 1,
  seqType = 2,
  peopleCount = 3,
  beginSequence = 4,
  loopCount = 5,
  loopSequence = 6,
  finishSequence = 7
}
local common = {
  {"chess_idle", "4000"}
}
local config = {
  {
    1,
    1004,
    1,
    common[1],
    10,
    {
      "chess_idle,4000",
      "chess,4000",
      "chess,4000",
      "chess_idle,4000"
    },
    common[1]
  },
  {
    2,
    1004,
    2,
    common[1],
    10,
    {
      "chess,4000;chess_idle,4000",
      "chess_idle,4000;chess,4000"
    },
    {
      "chess_idle,4000",
      "chess_idle,4000"
    }
  },
  {
    3,
    2006,
    1
  },
  {
    4,
    2006,
    2
  },
  {
    5,
    3004,
    1
  },
  {
    6,
    3004,
    2
  },
  {
    7,
    4004,
    1
  },
  {
    8,
    4004,
    2
  },
  {
    9,
    4006,
    1
  },
  {
    10,
    4006,
    2
  }
}
return config, "ID", key
