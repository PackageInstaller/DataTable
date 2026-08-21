local key = {
  id = 1,
  Spine = 2,
  ClickAni = 3
}
local common = {
  {"click", "click2"}
}
local config = {
  {
    1,
    "1600381_2_super_spine_idle",
    common[1]
  },
  {
    2,
    "1600064_4_cg_spine_idle",
    common[1]
  },
  {
    3,
    "1600254_5_cg_spine_idle",
    {"click", "click1"}
  },
  {
    4,
    "1600773_5_cg_spine_idle",
    common[1]
  },
  {
    5,
    "1601484_5_cg_spine_idle",
    {"click1", "click2"}
  }
}
return config, "id", key
