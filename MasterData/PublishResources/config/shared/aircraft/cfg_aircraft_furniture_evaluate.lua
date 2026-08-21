local key = {
  AmbientLimit = 1,
  DropGroupIdId = 2,
  VisitPetDropGroupId = 3
}
local common = {
  {1, 1}
}
local config = {
  [0] = {
    0,
    636011,
    636022
  },
  [2000] = {
    2000,
    636012,
    636022
  },
  [4000] = {
    4000,
    636013,
    636023
  },
  [6000] = {
    6000,
    636014,
    636024
  },
  [8000] = {
    8000,
    636015,
    636025
  },
  [10000] = {
    10000,
    636016,
    636026
  }
}
return config, "AmbientLimit", key
