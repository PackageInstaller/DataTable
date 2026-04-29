local key = {
  ID = 1,
  rawImageName = 2,
  RewardMainPos = 3,
  BuyGiftPos = 4
}
local common = {
  "sjb_zjm_bg2",
  {0, 0},
  {57, -34},
  {-605, -72},
  {-470, -142}
}
local config = {
  [1019] = {
    1019,
    common[1],
    common[2],
    common[2]
  },
  [1012] = {
    1012,
    common[1],
    {-475, -140},
    common[3]
  },
  [1013] = {
    1013,
    "n5bp_zjm_lh01",
    common[4],
    common[3]
  },
  [1020] = {
    1020,
    "n7bp_zjm_lh01",
    common[4],
    common[3]
  },
  [2004] = {
    2004,
    "n37bp_zjm_lh01",
    common[4],
    common[3]
  },
  [2005] = {
    2005,
    "n39bp_zjm_lh01",
    common[4],
    common[3]
  },
  [2006] = {
    2006,
    "n41bp_zjm_lh01",
    {-550, -122},
    common[3]
  },
  [2007] = {
    2007,
    "n43bp_zjm_lh01",
    {-450, -122},
    common[3]
  },
  [2008] = {
    2008,
    "n45bp_zjm_lh01",
    common[5],
    common[3]
  },
  [2009] = {
    2009,
    "n47bp_zjm_lh01",
    common[5],
    common[3]
  },
  [2010] = {
    2010,
    "n49bp_zjm_lh01",
    common[5],
    common[3]
  },
  [2011] = {
    2011,
    "n51bp_zjm_lh01",
    common[5],
    common[3]
  },
  [2012] = {
    2012,
    "n52bp_zjm_lh01",
    common[5],
    common[3]
  }
}
return config, "ID", key
