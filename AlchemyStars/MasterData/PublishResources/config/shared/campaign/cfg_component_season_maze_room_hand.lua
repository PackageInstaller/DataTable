local key = {
  ID = 1,
  ComponentID = 2,
  CurLv = 3,
  LvOdds = 4
}
local config = {
  {
    1,
    900308001,
    1,
    {
      {1, 60},
      {2, 30},
      {3, 10}
    }
  },
  {
    2,
    900308001,
    2,
    {
      {2, 70},
      {3, 30}
    }
  },
  {
    3,
    900308001,
    3,
    {
      {3, 100}
    }
  }
}
return config, "ID", key
