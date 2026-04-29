local key = {
  ID = 1,
  Name = 2,
  Desc = 3,
  PickupType = 4,
  EffectType = 5,
  EffectParam = 6
}
local common = {
  "金钱袋",
  "加金币",
  {"3000002"}
}
local config = {
  [3] = {
    3,
    common[1],
    common[2],
    3,
    2,
    common[3]
  },
  [4] = {
    4,
    common[1],
    common[2],
    3,
    2,
    common[3]
  },
  [5] = {
    5,
    "秘境币",
    "加秘境币",
    3,
    2,
    {"3000007"}
  }
}
return config, "ID", key
