local key = {
  SpineBg = 1,
  SpineBg_Idle = 2,
  SpineNpc = 3,
  SpineNpc_Idle = 4,
  SpineNpc_Found = 5,
  SpineNpc_FoundTime = 6,
  SpineDraw = 7,
  SpineDraw_Once = 8,
  SpineDraw_OnceTime = 9,
  SpineDraw_Multi = 10,
  SpineDraw_MultiTime = 11
}
local common = {
  "idle",
  "found",
  "10",
  "1"
}
local config = {
  {
    "beijing_huatian",
    common[1],
    "ren_1_huatian",
    common[1],
    common[2],
    1100,
    "ren_2_huatian",
    common[3],
    2000,
    common[4],
    2700
  },
  {
    "beijing_linjian",
    common[1],
    "ren_1_linjian",
    common[1],
    common[2],
    1100,
    "ren_2_linjian",
    common[3],
    2000,
    common[4],
    2700
  },
  {
    "beijing_hepan",
    common[1],
    "ren_1_hepan",
    common[1],
    common[2],
    1100,
    "ren_2_hepan",
    common[3],
    2000,
    common[4],
    2700
  },
  {
    "beijing_kuangqu",
    common[1],
    "ren_1_kuangqu",
    common[1],
    common[2],
    1100,
    "ren_2_kuangqu",
    common[3],
    2000,
    common[4],
    2700
  },
  {
    "beijing_shenshan",
    common[1],
    "ren_1_shenshan",
    common[1],
    common[2],
    1100,
    "ren_2_shenshan",
    common[3],
    2000,
    common[4],
    2700
  },
  {
    "beijing_pingyuan",
    common[1],
    "ren_1_pingyuan",
    common[1],
    common[2],
    1100,
    "ren_2_pingyuan",
    common[3],
    2000,
    common[4],
    2700
  }
}
return config, "BoxIndex", key
