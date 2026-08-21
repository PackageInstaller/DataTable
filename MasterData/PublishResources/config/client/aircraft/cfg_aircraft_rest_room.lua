local key = {
  ID = 1,
  WalkCeiling = 2,
  PetCeiling = 3
}
local config = {
  [1001] = {
    1001,
    3,
    5
  },
  [2001] = {
    2001,
    3,
    5
  },
  [3001] = {
    3001,
    3,
    5
  },
  [4001] = {
    4001,
    3,
    5
  },
  [9999] = {
    9999,
    3,
    0
  }
}
return config, "ID", key
