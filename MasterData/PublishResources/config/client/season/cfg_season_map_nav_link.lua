local key = {
  ID = 1,
  Start = 2,
  End = 3,
  Name = 4,
  SeasonID = 5
}
local common = {
  {
    -12.253,
    0,
    5.346
  },
  {
    -11.696,
    0,
    6.135
  },
  {
    -15.21,
    0,
    19.44
  },
  {
    -15.83,
    1.214,
    17.87
  }
}
local config = {
  {
    1,
    common[1],
    common[2],
    "nav_Land2Tonav_Water2",
    8004
  },
  {
    2,
    common[2],
    common[1],
    "nav_Water2Tonav_Land2",
    8004
  },
  {
    3,
    common[3],
    common[4],
    "nav_Water1Tonav_Land1",
    8004
  },
  {
    4,
    common[4],
    common[3],
    "nav_Land1Tonav_Water1",
    8004
  }
}
return config, "ID", key
