local key = {
  id = 1,
  Spine = 2,
  EnterAnim = 3,
  ClickAni = 4
}
local common = {"show"}
local config = {
  [90384] = {
    90384,
    "1600381_2_super_spine_idle",
    common[1],
    {"click", "click2"}
  },
  [91484] = {
    91484,
    "N37_qingtong_main_spine_idle"
  },
  [90254] = {
    90254,
    "1600254_5_cg_spine_idle",
    common[1],
    {"click"}
  },
  [90773] = {
    90773,
    "1600773_senior_skin_draw_spine_idle",
    common[1]
  }
}
return config, "id", key
