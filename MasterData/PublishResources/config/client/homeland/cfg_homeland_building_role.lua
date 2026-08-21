local key = {
  ID = 1,
  In = 2,
  Loop = 3,
  Out = 4
}
local config = {
  {
    1,
    {
      anim = "Sit",
      lerp = 0.2,
      duration = 0.2
    },
    nil,
    {lerp = 0.2, duration = 0.2}
  },
  {
    2,
    {
      anim = "tangyi_in",
      lerp = 0,
      duration = 2.5
    },
    nil,
    {lerp = 0, duration = 2.867}
  },
  [5212001] = {
    5212001,
    {
      anim = "huati_in",
      lerp = 0,
      duration = 1.2,
      camLookAt = "Bip001"
    },
    {camLookAt = "Bip001", duration = 1.767},
    {
      lerp = 0,
      duration = 2.833,
      leaveTransform = "leaveInteract"
    }
  },
  [5212002] = {
    5212002,
    {
      anim = "liaowang_in",
      lerp = 0,
      duration = 4.133,
      camLookAt = "Bip001"
    },
    {camLookAt = "Bip001"},
    {
      lerp = 0,
      duration = 3.233,
      leaveTransform = "leaveInteract",
      camLookAt = "Bip001"
    }
  },
  [5232007] = {
    5232007,
    {
      anim = "Sit",
      lerp = 0.2,
      duration = 1.333,
      buildingAnim = "jy_play_5232007_fly_in",
      camLookAt = "Bip001",
      followBuilding = "in"
    },
    {
      camLookAt = "Bip001",
      buildingAnim = "jy_play_5232007_fly_loop",
      followBuilding = "loop"
    },
    {
      lerp = 0.2,
      duration = 1.333,
      camLookAt = "Bip001",
      buildingAnim = "jy_play_5232007_fly_out",
      followBuilding = "in"
    }
  },
  [5234026] = {
    5234026,
    {
      anim = "shimo_in",
      lerp = 0,
      duration = 0.333,
      buildingAnim = "jy_play_shimo_in"
    },
    {
      buildingAnim = "jy_play_shimo_loop"
    },
    {
      lerp = 0,
      duration = 0.567,
      buildingAnim = "jy_play_shimo_out",
      byLoopEnd = true
    }
  },
  [5241002] = {
    5241002,
    {
      anim = "qiuqian_in",
      lerp = 0,
      duration = 0.4,
      buildingAnim = "jy_play_qiuqian_in"
    },
    {
      buildingAnim = "jy_play_qiuqian_loop"
    },
    {
      lerp = 0,
      duration = 1.133,
      buildingAnim = "jy_play_qiuqian_out"
    }
  },
  [5241003] = {
    5241003,
    {
      anim = "muma_in",
      lerp = 0,
      duration = 1.067,
      buildingAnim = "jy_play_muma_in"
    },
    {
      buildingAnim = "jy_play_muma_loop"
    },
    {
      lerp = 0,
      duration = 1.267,
      buildingAnim = "jy_play_muma_out"
    }
  },
  [5241004] = {
    5241004,
    {
      anim = "fengzheng_in",
      lerp = 0,
      duration = 3,
      buildingAnim = "jy_play_fengzheng_in"
    },
    {
      buildingAnim = "jy_play_fengzheng_loop"
    },
    {
      lerp = 0,
      duration = 3.533,
      buildingAnim = "jy_play_fengzheng_out"
    }
  },
  [5241014] = {
    5241014,
    {
      anim = "qiqiu_fly_in",
      lerp = 0,
      duration = 5.833,
      buildingAnim = "jy_play_qiqiu_fly_in",
      camLookAt = "Bip001",
      followBuilding = "in"
    },
    {
      camLookAt = "Bip001",
      buildingAnim = "jy_play_qiqiu_fly_loop",
      followBuilding = "loop"
    },
    {
      lerp = 0,
      duration = 4.6,
      camLookAt = "Bip001",
      buildingAnim = "jy_play_qiqiu_fly_out",
      followBuilding = "in"
    }
  },
  [5272001] = {
    5272001,
    {
      anim = "linyu_in",
      lerp = 0,
      duration = 5,
      buildingAnim = "jy_play_linyu_in",
      functionEnum = 1
    },
    nil,
    {
      anim = "linyu_out",
      lerp = 0,
      duration = 5,
      buildingAnim = "jy_play_linyu_out",
      leaveTransform = "leaveInteract"
    }
  },
  [5272003] = {
    5272003,
    {
      anim = "dadie_in",
      lerp = 0,
      duration = 3.333
    },
    nil,
    {lerp = 0, duration = 4.033}
  },
  [5212017] = {
    5212017,
    {
      anim = "lazhu_in",
      lerp = 0,
      duration = 8.03,
      roleEff = "eff_hl_pfb_5212017_in.prefab",
      roleEffHangPath = "Root"
    },
    {
      roleEff = "eff_hl_pfb_5212017_loop.prefab",
      roleEffHangPath = "Root"
    },
    {lerp = 0, duration = 3.2}
  },
  [5212018] = {
    5212018,
    {
      anim = "pinata_in",
      lerp = 0,
      duration = 1.633,
      buildingAnim = "jy_play_pinata_in",
      roleEff = "hl_tool_stick_z.prefab",
      roleEffHangPath = "Root/Bone_all/Dummy_1000011/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 R Clavicle/Bip001 R UpperArm/Bip001 R Forearm/Bip001 R Hand"
    },
    {
      buildingAnim = "jy_play_pinata_loop",
      roleEff = "hl_tool_stick_z.prefab",
      roleEffHangPath = "Root/Bone_all/Dummy_1000011/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 R Clavicle/Bip001 R UpperArm/Bip001 R Forearm/Bip001 R Hand",
      buildingEff = "eff_hl_pfb_5212018.prefab",
      buildingEffHangPath = "model/hl_pfb_5212018"
    },
    {
      lerp = 0,
      duration = 2,
      buildingAnim = "jy_play_pinata_out",
      roleEff = "hl_tool_stick_z.prefab",
      roleEffHangPath = "Root/Bone_all/Dummy_1000011/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 R Clavicle/Bip001 R UpperArm/Bip001 R Forearm/Bip001 R Hand"
    }
  },
  [5212019] = {
    5212019,
    {
      anim = "huishenggu_in",
      lerp = 0,
      duration = 3.333
    },
    nil,
    {lerp = 0, duration = 3.733}
  },
  [5212020] = {
    5212020,
    {
      anim = "mingxinjia_in",
      lerp = 0,
      duration = 2.1
    },
    {
      buildingAnim = "jy_play_mingxinjia_loop"
    },
    {lerp = 0, duration = 1.167}
  },
  [5276003] = {
    5276003,
    {
      anim = "dizzy_in",
      lerp = 0,
      duration = 2,
      buildingAnim = "jy_play_dizzy_in"
    },
    {
      buildingAnim = "jy_play_dizzy_loop"
    },
    {
      lerp = 0,
      duration = 6.667,
      buildingAnim = "jy_play_dizzy_out"
    }
  }
}
return config, "ID", key
