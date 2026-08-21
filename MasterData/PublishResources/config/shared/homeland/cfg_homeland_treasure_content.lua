local key = {
  ID = 1,
  Quality = 2,
  Weight = 3,
  ViewType = 4,
  Prefab = 5,
  PrefabEffect = 6,
  BeDugEffect = 7,
  ShowEffect = 8,
  EffectAni = 9,
  EffectAniOver = 10,
  AttachPath = 11,
  DigAnim = 12,
  DigAnimTime = 13,
  OverAnim = 14,
  OverAnimTime = 15,
  UIDelay = 16,
  DigDelay = 17,
  DigOverDelay = 18,
  AssoState = 19,
  WishCornRandomID = 20,
  RewardRandomID = 21
}
local common = {
  "hl_collect_tu.prefab",
  "eff_cllect_treasure_loop.prefab",
  "eff_cllect_treasure_dug.prefab",
  "Root/Bone_all/Dummy_1000011/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 R Clavicle/Bip001 R UpperArm/Bip001 R Forearm/Bip001 R Hand",
  "Dig",
  "jy_collect_dig",
  "DigOver",
  "jy_collect_cancel"
}
local config = {
  {
    1,
    1,
    1,
    {
      {2, 3},
      {3, 7}
    },
    common[1],
    common[2],
    common[3],
    "eff_collect_colour_Rhand.prefab",
    "effanim_hl_collect_R_bai",
    "effanim_hl_collect_R_bai_cancel",
    common[4],
    common[5],
    common[6],
    common[7],
    common[8],
    300,
    300,
    1000,
    2,
    100000,
    2000004
  },
  {
    2,
    2,
    1,
    {
      {2, 7},
      {3, 3}
    },
    common[1],
    common[2],
    common[3],
    "eff_collect_orange_Rhand.prefab",
    "effanim_hl_collect_R_huang",
    "effanim_hl_collect_R_huang_cancel",
    common[4],
    common[5],
    common[6],
    common[7],
    common[8],
    300,
    300,
    1000,
    2,
    100000,
    2000004
  },
  {
    3,
    3,
    1,
    {
      {1, 1}
    },
    common[1],
    common[2],
    common[3],
    "eff_collect_purple_Rhand.prefab",
    "effanim_hl_collect_R_zi",
    "effanim_hl_collect_R_zi_cancel",
    common[4],
    common[5],
    common[6],
    common[7],
    common[8],
    300,
    300,
    1000,
    2,
    100000,
    2000003
  }
}
return config, "ID", key
