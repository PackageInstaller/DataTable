local key = {
  ID = 1,
  Pos = 2,
  LastWayPoint = 3
}
local config = {
  [4001001] = {
    4001001,
    {10, 10}
  },
  [4001002] = {
    4001002,
    {220, 200},
    4001001
  }
}
return config, "ID", key
