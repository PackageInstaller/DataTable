local key = {
  ID = 1,
  SkinAClass = 2,
  SkinAPrefab = 3,
  SkinAPos = 4,
  SkinBClass = 5,
  SkinBPrefab = 6,
  SkinBPos = 7
}
local common = {
  "UIBattlePassCN1SkinBtn",
  "UIBattlePassCN1_SkinBtn_Common_A.prefab",
  "UIBattlePassCN1_SkinBtn_Common_B.prefab",
  {0, 0},
  {-400, -19},
  {-551, -318},
  {-789, 85},
  {-500, -318},
  {-780, 250},
  {-780, 150}
}
local config = {
  [1019] = {
    1019,
    common[1],
    "UIBattlePassCN1_SkinBtn_1_A.prefab",
    common[4],
    common[1],
    "UIBattlePassCN1_SkinBtn_1_B.prefab",
    common[4]
  },
  [1012] = {
    1012,
    common[1],
    "UIBattlePassCN1_SkinBtn_3_A.prefab",
    {-563, -315},
    common[1],
    "UIBattlePassCN1_SkinBtn_3_B.prefab",
    common[5]
  },
  [1013] = {
    1013,
    common[1],
    "UIBattlePassCN1_SkinBtn_5_A.prefab",
    common[6],
    common[1],
    "UIBattlePassCN1_SkinBtn_5_B.prefab",
    common[5]
  },
  [1020] = {
    1020,
    common[1],
    "UIBattlePassCN1_SkinBtn_7_A.prefab",
    common[6],
    common[1],
    "UIBattlePassCN1_SkinBtn_7_B.prefab",
    common[7]
  },
  [2004] = {
    2004,
    common[1],
    common[2],
    common[6],
    common[1],
    common[3],
    common[7]
  },
  [2005] = {
    2005,
    common[1],
    common[2],
    common[6],
    common[1],
    common[3],
    {-795, 0}
  },
  [2006] = {
    2006,
    common[1],
    common[2],
    {-727, -135},
    common[1],
    common[3],
    common[6]
  },
  [2007] = {
    2007,
    common[1],
    common[2],
    common[6],
    common[1],
    common[3],
    {-780, -135}
  },
  [2008] = {
    2008,
    common[1],
    common[2],
    common[8],
    common[1],
    common[3],
    common[9]
  },
  [2009] = {
    2009,
    common[1],
    common[2],
    common[8],
    common[1],
    common[3],
    common[9]
  },
  [2010] = {
    2010,
    common[1],
    common[2],
    common[8],
    common[1],
    common[3],
    common[10]
  },
  [2011] = {
    2011,
    common[1],
    common[2],
    common[8],
    common[1],
    common[3],
    common[10]
  },
  [2012] = {
    2012,
    common[1],
    common[2],
    common[8],
    common[1],
    common[3],
    common[10]
  }
}
return config, "ID", key
