local key = {
  ID = 1,
  RoomType = 2,
  Room = 3,
  TrapRefreshID = 4
}
local common = {
  {
    {
      1,
      1,
      1,
      1,
      1
    },
    {
      1,
      1,
      1,
      1,
      1
    },
    {
      1,
      1,
      1,
      1,
      1
    },
    {
      1,
      1,
      1,
      1,
      1
    },
    {
      1,
      1,
      1,
      1,
      1
    }
  }
}
local config = {
  {
    1,
    1,
    common[1]
  },
  {
    2,
    2,
    common[1]
  },
  {
    3,
    3,
    common[1]
  },
  {
    4,
    4,
    common[1]
  },
  {
    5,
    5,
    common[1]
  },
  {
    6,
    6,
    common[1]
  }
}
return config, "ID", key
