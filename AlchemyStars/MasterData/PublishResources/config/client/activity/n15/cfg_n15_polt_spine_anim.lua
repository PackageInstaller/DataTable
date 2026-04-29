local key = {
  AnimNames = 1,
  AnimTime = 2,
  Ingreet = 3,
  StarPos = 4,
  Time = 5,
  EndPos = 6,
  StarState = 7
}
local common = {
  "idle",
  {1000, 99999},
  {1050, 150},
  {300, 150},
  {
    1000,
    1000,
    99999
  }
}
local config = {
  {
    {"cheer", "idle"},
    common[2],
    "1",
    common[3],
    3,
    common[4],
    "cheer"
  },
  {
    {
      "fight",
      "shoot",
      "die"
    },
    common[5],
    "2",
    common[3],
    3,
    common[4],
    "fight"
  },
  {
    {"greet", "greet_idle"},
    common[2],
    "4",
    common[3],
    3,
    common[4],
    "greet_idle"
  },
  {
    {"eat", "greet"},
    common[2],
    "3",
    common[3],
    3,
    common[4],
    "eat"
  },
  {
    {
      "idle",
      "shy",
      "shy_idle"
    },
    common[5],
    "6",
    common[3],
    3,
    common[4],
    common[1]
  },
  {
    {"idle"},
    {99999},
    "5",
    common[3],
    3,
    common[4],
    common[1]
  }
}
return config, "ID", key
