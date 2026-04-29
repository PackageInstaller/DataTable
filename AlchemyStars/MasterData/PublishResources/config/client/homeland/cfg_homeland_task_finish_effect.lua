local key = {
  Id = 1,
  CloseTime = 2,
  NpcRotateMc = 3,
  McRotatePosition = 4,
  McAnimation = 5,
  McAnimationTime = 6,
  McEffectPrefab = 7,
  McEffectAttachPath = 8,
  McEffectTime = 9
}
local common = {
  "TakeWater",
  "hl_pfb_clean_tools_tong.prefab",
  "Root",
  "CleanUseWater",
  "hl_pfb_clean_tools.prefab",
  {0, 4500},
  {0, 6000}
}
local config = {
  [-2] = {
    -2,
    4500,
    false,
    true,
    common[1],
    common[6],
    common[2],
    common[3],
    common[6]
  },
  [-1] = {
    -1,
    6000,
    false,
    true,
    common[4],
    common[7],
    common[5],
    common[3],
    common[7]
  },
  [0] = {0},
  [1] = {
    1,
    4500,
    false,
    true,
    common[1],
    common[6],
    common[2],
    common[3],
    common[6]
  },
  [2] = {
    2,
    6000,
    false,
    true,
    common[4],
    common[7],
    common[5],
    common[3],
    common[7]
  },
  [3] = {
    3,
    3000,
    false,
    true,
    "CleanMend",
    {0, 3000}
  }
}
return config, "Id", key
