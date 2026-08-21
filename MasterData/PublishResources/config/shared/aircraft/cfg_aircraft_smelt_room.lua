local key = {
  ID = 1,
  StorageMax = 2,
  OneSpeed = 3,
  LockDesc = 4,
  LevelUpTip = 5
}
local common = {
  "str_aircraft_unlock_highlevel_item"
}
local config = {
  [7109001] = {
    7109001,
    1200,
    120,
    common[1],
    false
  },
  [7109002] = {
    7109002,
    1350,
    120,
    common[1],
    true
  },
  [7109003] = {
    7109003,
    1500,
    120,
    common[1],
    true
  },
  [7109004] = {
    7109004,
    1650,
    120,
    common[1],
    true
  },
  [7109005] = {
    7109005,
    1800,
    120,
    common[1],
    false
  }
}
return config, "ID", key
