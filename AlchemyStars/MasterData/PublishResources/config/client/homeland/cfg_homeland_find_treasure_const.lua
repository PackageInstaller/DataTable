local key = {
  ID = 1,
  SkillCD = 2,
  NPCModel = 3,
  NPCRotateTime = 4,
  NPCHeadImage = 5,
  NPCPosition = 6,
  FindTreasureMinDistance = 7,
  SkillMinDistance = 8,
  SkillMaxDistance = 9,
  MaxDistanceEffect = 10,
  MiddleDistanceEffect = 11,
  MinDistanceEffect = 12,
  MaxAngle = 13,
  MiddleAngle = 14,
  MinAngle = 15,
  ForwardDistance = 16,
  BackpackModel = 17,
  BackpackAttachPath = 18,
  NPCName = 19,
  NPCMinimapIcon = 20,
  NPCIcon = 21,
  NPCDes = 22,
  StartPosition = 23,
  StartDirection = 24,
  StartCameraAngleX = 25,
  StartCameraAngleY = 26,
  StartCameraScale = 27,
  SpecialEffectPrefab = 28,
  SpecialEffectAttachPath = 29,
  NormalEffectPrefab = 30,
  NormalEffectAttachPath = 31,
  ToolPrefab = 32,
  ToolAttachPath = 33,
  TreasureShowDis = 34
}
local common = {
  "N17_mascot_icon13",
  "Root/Bone_all/Dummy_1000011/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 R Clavicle/Bip001 R UpperArm/Bip001 R Forearm/Bip001 R Hand/Bip001 R Finger2/Bip001 R Finger21"
}
local config = {
  {
    1,
    8000,
    "1022001_beibao.prefab",
    1000,
    common[1],
    {
      11000,
      3000,
      17000
    },
    500,
    15000,
    80000,
    "eff_jy_tanbao_red.prefab",
    "eff_jy_tanbao_yellow.prefab",
    "eff_jy_tanbao_green.prefab",
    30000,
    20000,
    10000,
    0,
    "1000011_tanceqi.prefab",
    "Root/Bone_all/Dummy_1000011/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1",
    "str_n17_tanbao_qiubu_name",
    common[1],
    common[1],
    "str_n17_tanbao_qiubu_desc",
    {
      11000,
      3000,
      20000
    },
    {
      1000,
      0,
      0
    },
    0,
    -50000,
    2000,
    "eff_collect_colour_Rhand.prefab",
    common[2],
    "eff_collect_orange_Rhand.prefab",
    common[2],
    "hl_tool_5014001_z.prefab",
    "Root/Bone_all/Dummy_1000011/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 L Clavicle/Bip001 L UpperArm/Bip001 L Forearm/Bip001 L Hand/LHandSocket",
    1500
  }
}
return config, "ID", key
