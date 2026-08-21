local key = {
  ID = 1,
  StartTime = 2,
  EndTime = 3,
  TimeType = 4,
  Active = 5,
  Cg = 6
}
local config = {
  {
    1,
    "2022-03-31 15:00:00",
    "2022-04-01 15:00:00",
    0,
    true,
    202
  },
  {
    2,
    "2024-04-01 05:00:00",
    "2024-04-02 05:00:00",
    1,
    true,
    20026
  }
}
return config, "ID", key
