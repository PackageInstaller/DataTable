local key = {
  ID = 1,
  MissionID = 2,
  UnlockTime = 3,
  CloseTime = 4,
  TimeTransform = 5
}
local config = {
  [8003] = {
    8003,
    {8003029, 2},
    "2023-12-06 05:00:00",
    "2024-01-10 04:00:00",
    0
  }
}
return config, "ID", key
