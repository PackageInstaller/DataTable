require("piece_type")
require("render_entity_id")
require("pet_info")
require("mission_info")
RenderEntityConfig = {
  [EntityConfigIDRender.Grid] = {
    EntityConfigID = EntityConfigIDRender.Grid,
    EntityConfigName = "PieceGray",
    EntityConfigComponents = {
      EntityType = {Type = "Piece"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = ""
      },
      Piece = {Type = "None"},
      BodyArea = {
        {0, 0}
      }
    }
  },
  [EntityConfigIDRender.GridFake] = {
    EntityConfigID = EntityConfigIDRender.GridFake,
    EntityConfigName = "PieceGray",
    EntityConfigComponents = {
      EntityType = {Type = "PieceFake"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = ""
      },
      PieceFake = {Type = "None"},
      BodyArea = {
        {0, 0}
      }
    }
  },
  [EntityConfigIDRender.GridPrefab] = {
    EntityConfigID = EntityConfigIDRender.GridPrefab,
    EntityConfigName = "GridPrefab",
    EntityConfigComponents = {
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = ""
      }
    }
  },
  [EntityConfigIDRender.Effect] = {
    EntityConfigID = EntityConfigIDRender.Effect,
    EntityConfigName = "Effect",
    EntityConfigComponents = {
      EntityType = {Type = "Effect"}
    }
  },
  [EntityConfigIDRender.EmptyGridEffect] = {
    EntityConfigID = EntityConfigIDRender.EmptyGridEffect,
    EntityConfigName = "GridEffect",
    EntityConfigComponents = {
      EntityType = {Type = "GridEffect"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_hybs_gezixiaoshi.prefab"
      },
      GridEffect = {GridEffectType = "Empty"}
    }
  },
  [EntityConfigIDRender.MoveRange] = {
    EntityConfigID = EntityConfigIDRender.MoveRange,
    EntityConfigName = "MoveRange",
    EntityConfigComponents = {
      EntityType = {Type = "MoveRange"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_bossyj_normal.prefab"
      },
      MonsterAttackRange = {
        entityConfigID = EntityConfigIDRender.MoveRange
      },
      Location = {
        Pos = {
          0,
          1000,
          0
        },
        Dir = {
          1,
          0,
          0
        }
      }
    }
  },
  [EntityConfigIDRender.MoveRangePro] = {
    EntityConfigID = EntityConfigIDRender.MoveRangePro,
    EntityConfigName = "MoveRange",
    EntityConfigComponents = {
      EntityType = {Type = "MoveRange"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_bossyj_pro.prefab"
      },
      MonsterAttackRange = {
        entityConfigID = EntityConfigIDRender.MoveRangePro
      },
      Location = {
        Pos = {
          0,
          1000,
          0
        },
        Dir = {
          1,
          0,
          0
        }
      }
    }
  },
  [EntityConfigIDRender.MoveRangeArrow] = {
    EntityConfigID = EntityConfigIDRender.MoveRangeArrow,
    EntityConfigName = "MoveRange",
    EntityConfigComponents = {
      EntityType = {Type = "MoveRange"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_hybs_yulan_bai.prefab"
      },
      MonsterAttackRange = {
        entityConfigID = EntityConfigIDRender.MoveRangeArrow
      },
      Location = {
        Pos = {
          0,
          1000,
          0
        },
        Dir = {
          1,
          0,
          0
        }
      }
    }
  },
  [EntityConfigIDRender.MoveRangeGrid] = {
    EntityConfigID = EntityConfigIDRender.MoveRangeGrid,
    EntityConfigName = "MoveRange",
    EntityConfigComponents = {
      EntityType = {Type = "MoveRange"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_hybs_yulan_honggezi.prefab"
      },
      MonsterAttackRange = {
        entityConfigID = EntityConfigIDRender.MoveRangeGrid
      },
      Location = {
        Pos = {
          0,
          1000,
          0
        },
        Dir = {
          1,
          0,
          0
        }
      }
    }
  },
  [EntityConfigIDRender.SkillRangeOutline] = {
    EntityConfigID = EntityConfigIDRender.SkillRangeOutline,
    EntityConfigName = "SkillRangeOutline",
    EntityConfigComponents = {
      EntityType = {
        Type = "SkillRangeOutline"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_ingame_boundingbox.prefab"
      },
      SkillRangeOutline = {},
      Location = {
        Pos = {
          0,
          1000,
          0
        },
        Dir = {
          1,
          0,
          0
        }
      }
    }
  },
  [EntityConfigIDRender.WarningArea] = {
    EntityConfigID = EntityConfigIDRender.WarningArea,
    EntityConfigName = "WarningArea",
    EntityConfigComponents = {
      EntityType = {
        Type = "WarningArea"
      },
      DamageWarningAreaElement = {},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_bossyj_normal.prefab"
      },
      Location = {
        Pos = {
          0,
          1000,
          0
        },
        Dir = {
          1,
          0,
          0
        }
      }
    }
  },
  [EntityConfigIDRender.WarningArea] = {
    EntityConfigID = EntityConfigIDRender.WarningArea,
    EntityConfigName = "WarningArea",
    EntityConfigComponents = {
      EntityType = {
        Type = "WarningArea"
      },
      DamageWarningAreaElement = {},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_bossyj_normal.prefab"
      },
      Location = {
        Pos = {
          0,
          1000,
          0
        },
        Dir = {
          1,
          0,
          0
        }
      }
    }
  },
  [EntityConfigIDRender.TrapAurasArea] = {
    EntityConfigID = EntityConfigIDRender.WarningArea,
    EntityConfigName = "WarningArea",
    EntityConfigComponents = {
      EntityType = {
        Type = "WarningArea"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_bossyj_normal.prefab"
      },
      Location = {
        Pos = {
          0,
          1000,
          0
        },
        Dir = {
          1,
          0,
          0
        }
      }
    }
  },
  [EntityConfigIDRender.TrapAreaOutline] = {
    EntityConfigID = EntityConfigIDRender.TrapAreaOutline,
    EntityConfigName = "TrapAreaOutline",
    EntityConfigComponents = {
      EntityType = {
        Type = "TrapAreaOutline"
      },
      DamageWarningAreaElement = {},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_2902701_gezi_01.prefab"
      },
      Location = {
        Pos = {
          0,
          1000,
          0
        },
        Dir = {
          1,
          0,
          0
        }
      },
      TrapAreaElement = {}
    }
  },
  [EntityConfigIDRender.WaringDeathArea] = {
    EntityConfigID = EntityConfigIDRender.WaringDeathArea,
    EntityConfigName = "WaringDeathArea",
    EntityConfigComponents = {
      EntityType = {
        Type = "WaringDeathArea"
      },
      DamageWarningAreaElement = {},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_bossyj_sj.prefab"
      },
      Location = {
        Pos = {
          0,
          1000,
          0
        },
        Dir = {
          0,
          0,
          0
        }
      }
    }
  },
  [EntityConfigIDRender.DeathArea] = {
    EntityConfigID = EntityConfigIDRender.DeathArea,
    EntityConfigName = "DeathArea",
    EntityConfigComponents = {
      EntityType = {Type = "DeathArea"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_bossyj_sj.prefab"
      },
      MonsterAttackRange = {
        entityConfigID = EntityConfigIDRender.DeathArea
      },
      Location = {
        Pos = {
          0,
          1000,
          0
        },
        Dir = {
          0,
          0,
          0
        }
      }
    }
  },
  [EntityConfigIDRender.ConvertElement_Blue] = {
    EntityConfigID = EntityConfigIDRender.ConvertElement_Blue,
    EntityConfigName = "ConvertElement_Blue",
    EntityConfigComponents = {
      EntityType = {
        Type = "PreviewConvertElement"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_hybs_biankuang_lan_chang.prefab"
      }
    }
  },
  [EntityConfigIDRender.ConvertElement_Green] = {
    EntityConfigID = EntityConfigIDRender.ConvertElement_Green,
    EntityConfigName = "ConvertElement_Green",
    EntityConfigComponents = {
      EntityType = {
        Type = "PreviewConvertElement"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_hybs_biankuang_lv_chang.prefab"
      }
    }
  },
  [EntityConfigIDRender.ConvertElement_Red] = {
    EntityConfigID = EntityConfigIDRender.ConvertElement_Red,
    EntityConfigName = "ConvertElement_Red",
    EntityConfigComponents = {
      EntityType = {
        Type = "PreviewConvertElement"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_hybs_biankuang_hong_chang.prefab"
      }
    }
  },
  [EntityConfigIDRender.ConvertElement_Yellow] = {
    EntityConfigID = EntityConfigIDRender.ConvertElement_Yellow,
    EntityConfigName = "ConvertElement_Yellow",
    EntityConfigComponents = {
      EntityType = {
        Type = "PreviewConvertElement"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_hybs_biankuang_huang_chang.prefab"
      }
    }
  },
  [EntityConfigIDRender.TurnChangeEffect] = {
    EntityConfigID = EntityConfigIDRender.TurnChangeEffect,
    EntityConfigName = "TurnChangeEffect",
    EntityConfigComponents = {
      EntityType = {
        Type = "TurnChangeEffect"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_huiheqiehuan_bq.prefab"
      },
      BoardOutline = {}
    }
  },
  [EntityConfigIDRender.LinkLine_Red] = {
    EntityConfigID = EntityConfigIDRender.LinkLine_Red,
    EntityConfigName = "LinkLineRender",
    EntityConfigComponents = {
      EntityType = {
        Type = "LinkLineRender"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_xianduan_red.prefab"
      },
      GridLocation = {},
      LinkLineIndex = {},
      LinkLineRender = {},
      GridEffect = {GridEffectType = "LinkLine"}
    }
  },
  [EntityConfigIDRender.LinkLine_Green] = {
    EntityConfigID = EntityConfigIDRender.LinkLine_Green,
    EntityConfigName = "LinkLineRender",
    EntityConfigComponents = {
      EntityType = {
        Type = "LinkLineRender"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_xianduan_green.prefab"
      },
      GridLocation = {},
      LinkLineIndex = {},
      LinkLineRender = {},
      GridEffect = {GridEffectType = "LinkLine"}
    }
  },
  [EntityConfigIDRender.LinkLine_Blue] = {
    EntityConfigID = EntityConfigIDRender.LinkLine_Blue,
    EntityConfigName = "LinkLineRender",
    EntityConfigComponents = {
      EntityType = {
        Type = "LinkLineRender"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_xianduan_blue.prefab"
      },
      GridLocation = {},
      LinkLineIndex = {},
      LinkLineRender = {},
      GridEffect = {GridEffectType = "LinkLine"}
    }
  },
  [EntityConfigIDRender.LinkLine_Yellow] = {
    EntityConfigID = EntityConfigIDRender.LinkLine_Yellow,
    EntityConfigName = "LinkLineRender",
    EntityConfigComponents = {
      EntityType = {
        Type = "LinkLineRender"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_xianduan.prefab"
      },
      GridLocation = {},
      LinkLineIndex = {},
      LinkLineRender = {},
      GridEffect = {GridEffectType = "LinkLine"}
    }
  },
  [EntityConfigIDRender.LinkLine_Any] = {
    EntityConfigID = EntityConfigIDRender.LinkLine_Any,
    EntityConfigName = "LinkLineRender",
    EntityConfigComponents = {
      EntityType = {
        Type = "LinkLineRender"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_xianduan.prefab"
      },
      GridLocation = {},
      LinkLineIndex = {},
      LinkLineRender = {},
      GridEffect = {GridEffectType = "LinkLine"}
    }
  },
  [EntityConfigIDRender.LinkGridDot_Red] = {
    EntityConfigID = EntityConfigIDRender.LinkGridDot_Red,
    EntityConfigName = "LinkLineDotEff",
    EntityConfigComponents = {
      EntityType = {
        Type = "LinkLineDotEff"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_main.prefab"
      },
      GridLocation = {},
      LinkLineIndex = {}
    }
  },
  [EntityConfigIDRender.LinkGridDot_Green] = {
    EntityConfigID = EntityConfigIDRender.LinkGridDot_Red,
    EntityConfigName = "LinkLineDotEff",
    EntityConfigComponents = {
      EntityType = {
        Type = "LinkLineDotEff"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_main.prefab"
      },
      GridLocation = {},
      LinkLineIndex = {}
    }
  },
  [EntityConfigIDRender.LinkGridDot_Blue] = {
    EntityConfigID = EntityConfigIDRender.LinkGridDot_Red,
    EntityConfigName = "LinkLineDotEff",
    EntityConfigComponents = {
      EntityType = {
        Type = "LinkLineDotEff"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_main.prefab"
      },
      GridLocation = {},
      LinkLineIndex = {}
    }
  },
  [EntityConfigIDRender.LinkGridDot_Yellow] = {
    EntityConfigID = EntityConfigIDRender.LinkGridDot_Red,
    EntityConfigName = "LinkLineDotEff",
    EntityConfigComponents = {
      EntityType = {
        Type = "LinkLineDotEff"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_main.prefab"
      },
      GridLocation = {},
      LinkLineIndex = {}
    }
  },
  [EntityConfigIDRender.LinkGridDot_Any] = {
    EntityConfigID = EntityConfigIDRender.LinkGridDot_Red,
    EntityConfigName = "LinkLineDotEff",
    EntityConfigComponents = {
      EntityType = {
        Type = "LinkLineDotEff"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_main.prefab"
      },
      GridLocation = {},
      LinkLineIndex = {}
    }
  },
  [EntityConfigIDRender.LinkGridInPath_Red] = {
    EntityConfigID = EntityConfigIDRender.LinkGridInPath_Red,
    EntityConfigName = "GridEffect",
    EntityConfigComponents = {
      EntityType = {Type = "GridEffect"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_xingdong.prefab"
      },
      GridEffect = {GridEffectType = "InPath"}
    }
  },
  [EntityConfigIDRender.LinkGridInPath_Green] = {
    EntityConfigID = EntityConfigIDRender.LinkGridInPath_Green,
    EntityConfigName = "GridEffect",
    EntityConfigComponents = {
      EntityType = {Type = "GridEffect"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_xingdong.prefab"
      },
      GridEffect = {GridEffectType = "InPath"}
    }
  },
  [EntityConfigIDRender.LinkGridInPath_Blue] = {
    EntityConfigID = EntityConfigIDRender.LinkGridInPath_Blue,
    EntityConfigName = "GridEffect",
    EntityConfigComponents = {
      EntityType = {Type = "GridEffect"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_xingdong.prefab"
      },
      GridEffect = {GridEffectType = "InPath"}
    }
  },
  [EntityConfigIDRender.LinkGridInPath_Yellow] = {
    EntityConfigID = EntityConfigIDRender.LinkGridInPath_Yellow,
    EntityConfigName = "GridEffect",
    EntityConfigComponents = {
      EntityType = {Type = "GridEffect"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_xingdong.prefab"
      },
      GridEffect = {GridEffectType = "InPath"}
    }
  },
  [EntityConfigIDRender.LinkGridInPath_Any] = {
    EntityConfigID = EntityConfigIDRender.LinkGridInPath_Any,
    EntityConfigName = "GridEffect",
    EntityConfigComponents = {
      EntityType = {Type = "GridEffect"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_xingdong.prefab"
      },
      GridEffect = {GridEffectType = "InPath"}
    }
  },
  [EntityConfigIDRender.LinkNum_Red] = {
    EntityConfigID = EntityConfigIDRender.LinkNum_Red,
    EntityConfigName = "LinkageNum",
    EntityConfigComponents = {
      EntityType = {Type = "LinkageNum"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_shuzi.prefab"
      },
      LinkageNum = {
        LinkageNumOffset = {0, 0}
      }
    }
  },
  [EntityConfigIDRender.LinkNum_Green] = {
    EntityConfigID = EntityConfigIDRender.LinkNum_Green,
    EntityConfigName = "LinkageNum",
    EntityConfigComponents = {
      EntityType = {Type = "LinkageNum"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_shuzi.prefab"
      },
      LinkageNum = {
        LinkageNumOffset = {0, 0}
      }
    }
  },
  [EntityConfigIDRender.LinkNum_Blue] = {
    EntityConfigID = EntityConfigIDRender.LinkNum_Blue,
    EntityConfigName = "LinkageNum",
    EntityConfigComponents = {
      EntityType = {Type = "LinkageNum"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_shuzi.prefab"
      },
      LinkageNum = {
        LinkageNumOffset = {0, 0}
      }
    }
  },
  [EntityConfigIDRender.LinkNum_Yellow] = {
    EntityConfigID = EntityConfigIDRender.LinkNum_Yellow,
    EntityConfigName = "LinkageNum",
    EntityConfigComponents = {
      EntityType = {Type = "LinkageNum"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_shuzi.prefab"
      },
      LinkageNum = {
        LinkageNumOffset = {0, 0}
      }
    }
  },
  [EntityConfigIDRender.LinkNum_Any] = {
    EntityConfigID = EntityConfigIDRender.LinkNum_Any,
    EntityConfigName = "LinkageNum",
    EntityConfigComponents = {
      EntityType = {Type = "LinkageNum"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_shuzi.prefab"
      },
      LinkageNum = {
        LinkageNumOffset = {0, 0}
      }
    }
  },
  [EntityConfigIDRender.LinkPos_Red] = {
    EntityConfigID = EntityConfigIDRender.LinkPos_Red,
    EntityConfigName = "GridEffect",
    EntityConfigComponents = {
      EntityType = {Type = "GridEffect"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_shouzhi_red.prefab"
      },
      GridEffect = {GridEffectType = "TouchPos"}
    }
  },
  [EntityConfigIDRender.LinkPos_Green] = {
    EntityConfigID = EntityConfigIDRender.LinkPos_Green,
    EntityConfigName = "GridEffect",
    EntityConfigComponents = {
      EntityType = {Type = "GridEffect"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_shouzhi_green.prefab"
      },
      GridEffect = {GridEffectType = "TouchPos"}
    }
  },
  [EntityConfigIDRender.LinkPos_Blue] = {
    EntityConfigID = EntityConfigIDRender.LinkPos_Blue,
    EntityConfigName = "GridEffect",
    EntityConfigComponents = {
      EntityType = {Type = "GridEffect"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_shouzhi_blue.prefab"
      },
      GridEffect = {GridEffectType = "TouchPos"}
    }
  },
  [EntityConfigIDRender.LinkPos_Yellow] = {
    EntityConfigID = EntityConfigIDRender.LinkPos_Yellow,
    EntityConfigName = "GridEffect",
    EntityConfigComponents = {
      EntityType = {Type = "GridEffect"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_shouzhi.prefab"
      },
      GridEffect = {GridEffectType = "TouchPos"}
    }
  },
  [EntityConfigIDRender.LinkPos_Any] = {
    EntityConfigID = EntityConfigIDRender.LinkPos_Any,
    EntityConfigName = "GridEffect",
    EntityConfigComponents = {
      EntityType = {Type = "GridEffect"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_shouzhi.prefab"
      },
      GridEffect = {GridEffectType = "TouchPos"}
    }
  },
  [EntityConfigIDRender.CanMoveArrow] = {
    EntityConfigID = EntityConfigIDRender.CanMoveArrow,
    EntityConfigName = "CanMoveArrow",
    EntityConfigComponents = {
      EntityType = {
        Type = "CanMoveArrow"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_system_gezi_juesejiantou.prefab"
      },
      GridLocation = {}
    }
  },
  [EntityConfigIDRender.FinalAttackEffect] = {
    EntityConfigID = EntityConfigIDRender.FinalAttackEffect,
    EntityConfigName = "FinalAttackEffect",
    EntityConfigComponents = {
      EntityType = {
        Type = "FinalAttackEffect"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_finalatk.prefab"
      }
    }
  },
  [EntityConfigIDRender.HPSlider] = {
    EntityConfigID = EntityConfigIDRender.HPSlider,
    EntityConfigName = "HPSlider",
    EntityConfigComponents = {
      EntityType = {Type = "HPSlider"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "HPSlider.prefab"
      },
      HUD = {}
    }
  },
  [EntityConfigIDRender.BossHPSlider] = {
    EntityConfigID = EntityConfigIDRender.BossHPSlider,
    EntityConfigName = "HPSlider",
    EntityConfigComponents = {
      EntityType = {Type = "HPSlider"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "BossHPSlider.prefab"
      },
      HUD = {}
    }
  },
  [EntityConfigIDRender.TrapHPSlider] = {
    EntityConfigID = EntityConfigIDRender.TrapHPSlider,
    EntityConfigName = "HPSlider",
    EntityConfigComponents = {
      EntityType = {Type = "HPSlider"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "TrapHPSlider.prefab"
      },
      HUD = {}
    }
  },
  [EntityConfigIDRender.PlayerHPSlider] = {
    EntityConfigID = EntityConfigIDRender.PlayerHPSlider,
    EntityConfigName = "HPSlider",
    EntityConfigComponents = {
      EntityType = {Type = "HPSlider"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "PlayerHPSlider.prefab"
      },
      HUD = {}
    }
  },
  [EntityConfigIDRender.Ghost] = {
    EntityConfigID = EntityConfigIDRender.Ghost,
    EntityConfigName = "Ghost",
    EntityConfigComponents = {
      EntityType = {Type = "Ghost"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = ""
      },
      GridLocation = {},
      Ghost = {}
    }
  },
  [EntityConfigIDRender.GuideGhost] = {
    EntityConfigID = EntityConfigIDRender.GuideGhost,
    EntityConfigName = "GuideGhost",
    EntityConfigComponents = {
      EntityType = {Type = "GuideGhost"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = ""
      },
      GridLocation = {},
      GuideGhost = {}
    }
  },
  [EntityConfigIDRender.LinkageInfo] = {
    EntityConfigID = EntityConfigIDRender.LinkageInfo,
    EntityConfigName = "LinkageInfo",
    EntityConfigComponents = {
      EntityType = {
        Type = "LinkageInfo"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "LinkageInfo.prefab"
      },
      LinkageInfo = {
        LinkTextOffset = {0.1, -0.1},
        AttackRate = {0.1, -0.1},
        MaxCount = 4,
        LinkTextOffsetPopStarPro = {0.1, 0.05}
      },
      HUD = {}
    }
  },
  [EntityConfigIDRender.LinkageNum] = {
    EntityConfigID = EntityConfigIDRender.LinkageNum,
    EntityConfigName = "LinkageNum",
    EntityConfigComponents = {
      EntityType = {Type = "LinkageNum"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "LinkageNum.prefab"
      },
      LinkageNum = {
        LinkageNumOffset = {0, 0}
      }
    }
  },
  [EntityConfigIDRender.LinkNumStep] = {
    EntityConfigID = EntityConfigIDRender.LinkNumStep,
    EntityConfigName = "LinkNumStep",
    EntityConfigComponents = {
      EntityType = {
        Type = "LinkageRestStep"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_lianxian_shuzi_step.prefab"
      },
      LinkageNum = {
        LinkageNumOffset = {0, 0}
      }
    }
  },
  [EntityConfigIDRender.SkillTips] = {
    EntityConfigID = EntityConfigIDRender.SkillTips,
    EntityConfigName = "SkillTips",
    EntityConfigComponents = {
      EntityType = {Type = "SkillTips"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "SkillTips.prefab"
      },
      SkillTips = {},
      HUD = {}
    }
  },
  [EntityConfigIDRender.NormalDamage] = {
    EntityConfigID = EntityConfigIDRender.NormalDamage,
    EntityConfigName = "NormalDamage",
    EntityConfigComponents = {
      EntityType = {
        Type = "NormalDamage"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "NormalDamageText.prefab"
      },
      HUD = {}
    }
  },
  [EntityConfigIDRender.RealDamage] = {
    EntityConfigID = EntityConfigIDRender.RealDamage,
    EntityConfigName = "RealDamage",
    EntityConfigComponents = {
      EntityType = {Type = "RealDamage"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "RealDamageText.prefab"
      },
      HUD = {}
    }
  },
  [EntityConfigIDRender.CriticalDamage] = {
    EntityConfigID = EntityConfigIDRender.CriticalDamage,
    EntityConfigName = "CriticalDamage",
    EntityConfigComponents = {
      EntityType = {
        Type = "CriticalDamage"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "CriticalDamageText.prefab"
      },
      HUD = {}
    }
  },
  [EntityConfigIDRender.RecoverDamage] = {
    EntityConfigID = EntityConfigIDRender.RecoverDamage,
    EntityConfigName = "RecoverDamage",
    EntityConfigComponents = {
      EntityType = {
        Type = "RecoverDamage"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "RecoverText.prefab"
      },
      HUD = {}
    }
  },
  [EntityConfigIDRender.GuardDamage] = {
    EntityConfigID = EntityConfigIDRender.GuardDamage,
    EntityConfigName = "GuardDamage",
    EntityConfigComponents = {
      EntityType = {
        Type = "GuardDamage"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "GuardText.prefab"
      },
      HUD = {}
    }
  },
  [EntityConfigIDRender.DeBuffDamage] = {
    EntityConfigID = EntityConfigIDRender.DeBuffDamage,
    EntityConfigName = "DeBuffDamage",
    EntityConfigComponents = {
      EntityType = {
        Type = "DeBuffDamage"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "SpecialDamageText.prefab"
      },
      HUD = {}
    }
  },
  [EntityConfigIDRender.MissDamage] = {
    EntityConfigID = EntityConfigIDRender.MissDamage,
    EntityConfigName = "MissDamage",
    EntityConfigComponents = {
      EntityType = {Type = "MissDamage"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "MissDamageImage.prefab"
      },
      HUD = {}
    }
  },
  [EntityConfigIDRender.PickUpArrow] = {
    EntityConfigID = EntityConfigIDRender.PickUpArrow,
    EntityConfigName = "PickUpArrow",
    EntityConfigComponents = {
      EntityType = {
        Type = "PickUpArrow"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_zhuanxiang.prefab"
      },
      PickUpArrow = {}
    }
  },
  [EntityConfigIDRender.Projectile] = {
    EntityConfigID = EntityConfigIDRender.Projectile,
    EntityConfigName = "Projectile",
    EntityConfigComponents = {
      EntityType = {Type = "Projectile"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = ""
      },
      GridLocation = {Height = 50}
    }
  },
  [EntityConfigIDRender.GuideFinger] = {
    EntityConfigID = EntityConfigIDRender.GuideFinger,
    EntityConfigName = "GuideFinger",
    EntityConfigComponents = {
      EntityType = {
        Type = "GuideFinger"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "guide_finger.prefab"
      },
      GuideFinger = {},
      HUD = {}
    }
  },
  [EntityConfigIDRender.GuideLinkLine] = {
    EntityConfigID = EntityConfigIDRender.GuideLinkLine,
    EntityConfigName = "GuideLink",
    EntityConfigComponents = {
      EntityType = {Type = "GuideLink"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_system_gezi_yindao_duanxian.prefab"
      },
      GridLocation = {},
      GuideLinkLine = {},
      LinkLineRender = {}
    }
  },
  [EntityConfigIDRender.GuideSpot] = {
    EntityConfigID = EntityConfigIDRender.GuideSpot,
    EntityConfigName = "GuideSpot",
    EntityConfigComponents = {
      EntityType = {Type = "GuideSpot"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_system_gezi_yindao_yuandi.prefab"
      },
      GridLocation = {},
      GuideSpot = {}
    }
  },
  [EntityConfigIDRender.GuidePiece] = {
    EntityConfigID = EntityConfigIDRender.GuidePiece,
    EntityConfigName = "GuidePiece",
    EntityConfigComponents = {
      EntityType = {Type = "GuidePiece"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "Eff_Ingame_xsyd_kuang.prefab"
      },
      GuidePiece = {}
    }
  },
  [EntityConfigIDRender.HeadStoryTips] = {
    EntityConfigID = EntityConfigIDRender.HeadStoryTips,
    EntityConfigName = "HeadStoryTips",
    EntityConfigComponents = {
      EntityType = {
        Type = "HeadStoryTips"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "StoryTips.prefab"
      },
      HUD = {}
    }
  },
  [EntityConfigIDRender.EditorInfo] = {
    EntityConfigID = EntityConfigIDRender.EditorInfo,
    EntityConfigName = "EditorInfo",
    EntityConfigComponents = {
      EntityType = {Type = "EditorInfo"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "EditorInfo.prefab"
      },
      HUD = {},
      EditorInfo = {}
    }
  },
  [EntityConfigIDRender.Preview] = {
    EntityConfigID = EntityConfigIDRender.Preview,
    EntityConfigName = "Preview",
    EntityConfigComponents = {
      EntityType = {Type = "Preview"},
      RenderState = {},
      PreviewEnv = {},
      PreviewChainSkill = {
        {},
        {},
        Vector2.zero
      },
      PreviewChainSelectPet = {},
      PreviewChainPath = {},
      BulletTime = {},
      PreviewLinkLine = {},
      PreviewPuzzle = {}
    }
  },
  [EntityConfigIDRender.RenderBoard] = {
    EntityConfigID = EntityConfigIDRender.RenderBoard,
    EntityConfigName = "RenderBoard",
    EntityConfigComponents = {
      EntityType = {
        Type = "RenderBoard"
      },
      RenderBoard = {},
      RenderMultiBoard = {},
      RenderBoardSplice = {},
      RenderBoardPush = {},
      WaveData = {},
      BoardCollider = {},
      PreviewChainSkillRange = {},
      ChainPreviewMonsterBehavior = {},
      PreviewBrightGrid = {},
      GuidePath = {},
      GuideWeakPath = {},
      GuidePreviewLinkLine = {},
      LinkRendererData = {},
      LogicResult = {},
      PickUpTarget = {},
      RenderRoundTeam = {},
      RenderChainPath = {},
      AIRecorder = {},
      PickUpChessResult = {},
      RenderChessPath = {},
      PreviewChessPet = {},
      RenderFeature = {},
      PopStarPickUpResult = {},
      UnscaledCountDownRender = {}
    }
  },
  [EntityConfigIDRender.HeadTrapRoundInfo] = {
    EntityConfigID = EntityConfigIDRender.HeadTrapRoundInfo,
    EntityConfigName = "HeadTrapRoundInfo",
    EntityConfigComponents = {
      EntityType = {
        Type = "HeadTrapRoundInfo"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "hud_trap_round_info.prefab"
      }
    }
  },
  [EntityConfigIDRender.MonsterAreaOutLine] = {
    EntityConfigID = EntityConfigIDRender.MonsterAreaOutLine,
    EntityConfigName = "MonsterAreaOutLine",
    EntityConfigComponents = {
      EntityType = {
        Type = "MonsterAreaOutLine"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "eff_gezi_line_red_01.prefab"
      },
      Location = {
        Pos = {
          0,
          1000,
          0
        },
        Dir = {
          1,
          0,
          0
        }
      }
    }
  },
  [EntityConfigIDRender.CutsceneMonster] = {
    EntityConfigID = EntityConfigIDRender.CutsceneMonster,
    EntityConfigName = "CutsceneMonster",
    EntityConfigComponents = {
      EntityType = {
        Type = "CutsceneMonster"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = ""
      },
      Location = {
        Pos = {
          0,
          1000,
          0
        },
        Dir = {
          1,
          0,
          0
        }
      },
      CutsceneMonster = {}
    }
  },
  [EntityConfigIDRender.CutscenePlayer] = {
    EntityConfigID = EntityConfigIDRender.CutscenePlayer,
    EntityConfigName = "CutscenePlayer",
    EntityConfigComponents = {
      EntityType = {
        Type = "CutscenePlayer"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "1500331.prefab"
      },
      Location = {
        Pos = {
          0,
          0,
          0
        },
        Dir = {
          1,
          0,
          0
        }
      },
      CutscenePlayer = {}
    }
  },
  [EntityConfigIDRender.StuntMonster] = {
    EntityConfigID = EntityConfigIDRender.StuntMonster,
    EntityConfigName = "StuntMonster",
    EntityConfigComponents = {
      EntityType = {
        Type = "StuntMonster"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = ""
      },
      Location = {
        Pos = {
          0,
          0,
          0
        },
        Dir = {
          1,
          0,
          0
        }
      }
    }
  }
}
