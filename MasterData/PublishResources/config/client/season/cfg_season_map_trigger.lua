local key = {
  ID = 1,
  Type = 2,
  Shape = 3,
  Position = 4,
  Rotation = 5,
  Param = 6,
  SeasonID = 7,
  BacktrackID = 8,
  Count = 9,
  Condition = 10,
  Content = 11,
  Stop = 12
}
local common = {
  {1, 5},
  {
    -9.96,
    1,
    4.2
  },
  {1.9, 3.02},
  {2.56, 2.23},
  "8008501,2",
  {id = 8008501, progress = 3},
  {id = 80008501, progress = 3}
}
local config = {
  {
    1,
    1,
    1,
    {
      -11.058,
      1,
      4.836
    },
    53.77,
    common[1],
    8002,
    nil,
    nil,
    "8002001,2|8002001,3",
    {id = 8002401, progress = 2},
    true
  },
  {
    2,
    3,
    1,
    {
      -8.262,
      1,
      1.876
    },
    53.77,
    {4.131952, 5},
    8002,
    nil,
    nil,
    nil,
    {id = 8002408, progress = 2}
  },
  {
    3,
    3,
    1,
    common[2],
    53.77,
    common[1],
    8002,
    nil,
    nil,
    "8002408,2",
    {id = 8002408, progress = 3}
  },
  {
    4,
    3,
    1,
    {
      -7.67,
      1,
      0.44
    },
    53.77,
    {7.34, 5},
    nil,
    8002,
    nil,
    nil,
    {id = 80002408, progress = 2}
  },
  {
    5,
    3,
    1,
    common[2],
    53.77,
    common[1],
    nil,
    8002,
    nil,
    "80002408,2",
    {id = 80002408, progress = 3}
  },
  {
    6,
    3,
    1,
    {
      -13.35,
      1,
      1.66
    },
    42.49,
    {11.9, 3.59},
    8008,
    nil,
    nil,
    nil,
    {id = 8008501, progress = 2}
  },
  {
    7,
    3,
    1,
    {
      -18.62,
      1,
      7.03
    },
    44.83,
    common[3],
    8008,
    nil,
    nil,
    common[5],
    common[6]
  },
  {
    8,
    3,
    1,
    {
      -7.19,
      1,
      0.57
    },
    44.83,
    common[4],
    8008,
    nil,
    nil,
    common[5],
    common[6]
  },
  {
    9,
    3,
    1,
    {
      -15.67,
      1,
      3.57
    },
    44.83,
    {18.89, 3.59},
    nil,
    8008,
    nil,
    nil,
    {id = 80008501, progress = 2}
  },
  {
    10,
    3,
    1,
    {
      -22.9,
      1,
      10.88
    },
    44.83,
    common[3],
    nil,
    8008,
    nil,
    common[5],
    common[7]
  },
  {
    11,
    3,
    1,
    {
      -8.11,
      1,
      -0.36
    },
    44.83,
    common[4],
    nil,
    8008,
    nil,
    common[5],
    common[7]
  }
}
return config, "ID", key
