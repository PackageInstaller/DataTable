local key = {
  ID = 1,
  Level = 2,
  Output = 3,
  ToolType = 4,
  Res = 5,
  AttachPath = 6,
  Cost = 7,
  param = 8
}
local common = {
  "hl_tool_5011001_z.prefab",
  "Root/Bone_all/Dummy_1000011/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 R Clavicle/Bip001 R UpperArm/Bip001 R Forearm/Bip001 R Hand",
  "hl_tool_5012001_z.prefab",
  "Root",
  "hl_tool_5013001_z.prefab",
  "Root/Bone_all/Dummy_1000011/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 R Clavicle/Bip001 R UpperArm/Bip001 R Forearm/Bip001 R Hand/RHandSocket"
}
local config = {
  [5011001] = {
    5011001,
    1,
    5011002,
    1,
    common[1],
    common[2],
    {
      {5011012, 1},
      {5011001, 1}
    },
    1
  },
  [5011002] = {
    5011002,
    2,
    5011003,
    1,
    common[1],
    common[2],
    {
      {5011012, 1},
      {5011002, 1}
    },
    1
  },
  [5011003] = {
    5011003,
    3,
    5011004,
    1,
    common[1],
    common[2],
    {
      {5011012, 1},
      {5011003, 1}
    },
    1
  },
  [5011004] = {
    5011004,
    4,
    5011005,
    1,
    common[1],
    common[2],
    {
      {5011012, 1},
      {5011004, 1}
    },
    1
  },
  [5011005] = {
    5011005,
    5,
    0,
    1,
    common[1],
    common[2],
    nil,
    1
  },
  [5012001] = {
    5012001,
    1,
    5012002,
    2,
    common[3],
    common[4],
    {
      {5012012, 1},
      {5012001, 1}
    },
    6000
  },
  [5012002] = {
    5012002,
    2,
    5012003,
    2,
    common[3],
    common[4],
    {
      {5012012, 1},
      {5012002, 1}
    },
    5500
  },
  [5012003] = {
    5012003,
    3,
    5012004,
    2,
    common[3],
    common[4],
    {
      {5012012, 1},
      {5012003, 1}
    },
    5000
  },
  [5012004] = {
    5012004,
    4,
    5012005,
    2,
    common[3],
    common[4],
    {
      {5012012, 1},
      {5012004, 1}
    },
    4500
  },
  [5012005] = {
    5012005,
    5,
    0,
    2,
    common[3],
    common[4],
    nil,
    4000
  },
  [5013001] = {
    5013001,
    1,
    5013002,
    3,
    common[5],
    common[6],
    {
      {5013012, 1},
      {5013001, 1}
    },
    3
  },
  [5013002] = {
    5013002,
    2,
    5013003,
    3,
    common[5],
    common[6],
    {
      {5013012, 1},
      {5013002, 1}
    },
    2
  },
  [5013003] = {
    5013003,
    3,
    5013004,
    3,
    common[5],
    common[6],
    {
      {5013012, 1},
      {5013003, 1}
    },
    2
  },
  [5013004] = {
    5013004,
    4,
    5013005,
    3,
    common[5],
    common[6],
    {
      {5013012, 1},
      {5013004, 1}
    },
    1
  },
  [5013005] = {
    5013005,
    5,
    0,
    3,
    common[5],
    common[6],
    nil,
    1
  },
  [5014001] = {
    5014001,
    1,
    0,
    4,
    "hl_tool_5014001_z.prefab",
    "Root/Bone_all/Dummy_1000011/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 L Clavicle/Bip001 L UpperArm/Bip001 L Forearm/Bip001 L Hand/LHandSocket"
  }
}
return config, "ID", key
