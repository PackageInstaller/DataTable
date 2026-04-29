local key = {
  StarPos = 1,
  Time = 2,
  EndPos = 3,
  ExitPos = 4
}
local common = {
  {1150, 200}
}
local config = {
  {
    common[1],
    2,
    {300, 180},
    {-1150, 150}
  },
  {
    common[1],
    3,
    {200, 100},
    {-1150, 100}
  },
  {
    common[1],
    4,
    {400, 50},
    {-1150, 50}
  }
}
return config, "ID", key
