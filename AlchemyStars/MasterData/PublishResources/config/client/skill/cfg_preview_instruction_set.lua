local key = {ID = 1, InstructionSet = 2}
local common = {
  {
    "PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark"
  },
  {
    " PlayAllPieceAnim,Anim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; "
  },
  {
    " PlayTargetMaterialAnim,Anim=Flash; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; "
  },
  {
    " PlayTargetMaterialAnim,Anim=FlashAlpha; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
  },
  {
    " PlayCreateCasterGhost,Type=PickUp; PlayTargetMaterialAnim,Anim=FlashAlpha; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; "
  },
  {
    " PlayAllPieceAnim,Anim=Dark; PlayTargetMaterialAnim,Anim=Transparent; "
  },
  {
    " PlayTargetMaterialAnim,Anim=FlashAlpha; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; "
  },
  {
    " PlayAllMaterialAnim,Anim=Transparent; PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; "
  },
  {
    " PlayScopePieceAnim,ScopeAnim=Normal; PlayTargetMaterialAnim,Anim=Flash; "
  },
  {
    " PlayTargetMaterialAnim,Anim=Flash; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Normal; "
  },
  {
    " PlayDeleteCasterGhost; PlayDeletePickUpEffect; "
  },
  {
    " PlayMultiTraction; PlayTargetMaterialAnim,Anim=Flash; "
  },
  {
    " Wait,TimeMs=300; PlayCasterEffect,EffectID=1109; "
  },
  {
    " PlayDeleteEffect,EffectID=1109; PlayDeletePickUpEffect; "
  },
  {
    "PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark;"
  },
  {
    "PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Flash;"
  },
  {
    " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
  },
  {
    "PlayAllPieceAnim,Anim=Dark;"
  },
  {
    " PlayAllPieceAnim,Anim=Gray; PlayActiveSkillAddBuff; CheckActiveSkill; "
  },
  {
    " PlayPickAnim,Anim=Invalid; "
  },
  {
    " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; "
  },
  {
    " PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=Flash; "
  },
  {
    " PlayScopePieceAnim,ScopeAnim=Dark,OtherAnim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; InitArrowByScope; "
  },
  {
    " PlayScopePieceAnim,ScopeAnim=Dark,OtherAnim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; "
  },
  {
    " PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=FlashAlpha; "
  },
  {
    " PlayAllPieceAnim,Anim=Dark; PlayDeleteGhost; PlayAllMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; "
  },
  {
    " RevertConvertAnim; PlayScopeConvertGrid,ShowSource=false; PlaySummonOnPickupNoTrapPos,trapID=15014911,effectID=3509; "
  },
  {
    " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Transparent; "
  },
  {
    "PlayScopePieceAnim,ScopeAnim=Silver"
  },
  {
    "PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Flash;"
  },
  {
    " StopTargetMaterialAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayAllPieceAnim,Anim=Dark; "
  },
  {
    " PlayDeletePickUpEffect; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Transparent; "
  },
  {
    " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
  },
  {
    " PlayTargetMaterialAnim,Anim=Flash;"
  },
  {
    " StopTargetMaterialAnim; PlayDeleteCasterGhost; PlayScopePieceAnim,ScopeAnim=Add,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Flash; PlayCreateCasterGhost,Type=TeleportTargetAroundNearestCaster; "
  },
  {
    " PlayAllPieceAnim,Anim=Dark; PlayDeleteGhost; PlayAllMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; InitArrowByScope; "
  },
  {
    " PlayDeleteGhost; PlayAllMaterialAnim,ExceptCaster=true; XingshanStrike,teleportScopeCenterType=3,teleportScopeTargetType=5,teleportScopeType=164,teleportScopeParam={1}, damageScopeCenterType=3,damageScopeTargetType=10,damageScopeType=46,damageScopeParam=0; "
  },
  {
    " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Flash; "
  },
  {
    " PlayAllPieceAnim,Anim=Dark; PlayScopeConvertGrid,showSource=false; "
  },
  {
    " PlayDeletePickUpEffect;"
  },
  {
    " PlayAllPieceAnim,Anim=Dark; "
  }
}
local config = {
  {
    1,
    {
      "PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Gray"
    }
  },
  {
    2,
    {
      " PlayAllPieceAnim,Anim=Dark; PlayTargetMaterialAnim,Anim=Flash; "
    }
  },
  {
    3,
    {
      " PlayTargetMaterialAnim,Anim=Flash; PlayTargetHitBack,casterPosBlock=true; PlayScopeConvertGrid,ShowSource=true "
    }
  },
  [300022] = {
    300022,
    {
      " PlayTargetMaterialAnim,Anim=Flash; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayTargetHitBack,casterPosBlock=true; "
    }
  },
  {
    4,
    {
      " RevertConvertAnim; PlayScopeConvertGrid,ShowSource=false; "
    }
  },
  {
    5,
    {
      " PlayCreateCasterGhost,Type=PickUp; "
    }
  },
  {
    6,
    {
      " PlayDeleteCasterGhost; "
    }
  },
  {
    7,
    common[1]
  },
  {
    8,
    {
      " PlayAllPieceAnim,Anim=Dark; PlayCasterActive,Enbale=false; PlayCasterEffect,EffectID=417; "
    }
  },
  {
    9,
    {
      " PlayAllPieceAnim,Anim=Normal; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayCreateCasterGhost,Type=Scope; "
    }
  },
  {
    10,
    {
      " PlayAllPieceAnim,Anim=Dark; PlayDeleteCasterGhost; "
    }
  },
  {
    11,
    {
      " RevertConvertAnim; PlayAllPieceAnim,Anim=Dark; PlayCreateCasterGhost,Type=PickUp; PlayTargetMaterialAnim,Anim=FlashAlpha; PlayTargetHitBack,casterPosBlock=true; PlayScopeConvertGrid,ShowSource=true; "
    }
  },
  {
    12,
    common[2]
  },
  {
    13,
    common[2]
  },
  {
    14,
    {
      "RevertConvertAnim;"
    }
  },
  {
    15,
    common[3]
  },
  [4502] = {
    4502,
    common[4]
  },
  [9301] = {
    9301,
    common[5]
  },
  {
    16,
    {
      " PlayTargetMaterialAnim,Anim=FlashAlpha; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayScopeConvertGrid,ShowSource=false; "
    }
  },
  {
    17,
    {
      " PlayAllPieceAnim,Anim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; RevertConvertAnim; "
    }
  },
  {
    18,
    common[6]
  },
  {
    19,
    common[7]
  },
  {
    20,
    {
      " PlayAllMaterialAnim,Anim=Transparent; PlayTargetMaterialAnim,Anim=FlashAlpha; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayPickGridConvertAnim,showSource=false; "
    }
  },
  {
    21,
    {
      " PlayAllPieceAnim,Anim=Dark; PlayDeleteGhost; PlayAllMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; InitArrow,Number=4,ShowOutGrid=true; "
    }
  },
  [210] = {
    210,
    {
      " PlayAllPieceAnim,Anim=Dark; PlayDeleteGhost; PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; "
    }
  },
  {
    22,
    {
      " PlayDeleteGhost; StopAllMaterialAnim,ExceptCaster=true; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=FlashAlpha; "
    }
  },
  [24] = {
    24,
    {
      " Wait,TimeMs=1000; DataSetHitBackDir; PlayTargetHitBack; "
    }
  },
  [25] = {
    25,
    {
      " Wait,TimeMs=1000; PlayAllPieceAnim,Anim=Dark; PlayScopeConvertGrid,ShowSource=false; "
    }
  },
  [26] = {
    26,
    common[8]
  },
  [16126] = {
    16126,
    common[8]
  },
  [27] = {
    27,
    {
      " PlayAllPieceAnim,Anim=Dark; StopAllMaterialAnim,ExceptCaster=true; PlayScopePieceAnim,ScopeAnim=Gray,OtherAnim=Dark; InitArrow,Number=8; "
    }
  },
  [270] = {
    270,
    {
      " PlayAllPieceAnim,Anim=Dark; StopAllMaterialAnim,ExceptCaster=true; PlayScopePieceAnim,ScopeAnim=Gray,OtherAnim=Dark; "
    }
  },
  [271] = {
    271,
    {
      " DeleteArrow; "
    }
  },
  [28] = {
    28,
    {
      " PlayDeleteCasterGhost; PlayCasterEffect,EffectID=417; PlayAllPieceAnim,Anim=Normal; PlayTargetMaterialAnim,Anim=Transparent; "
    }
  },
  [29] = {
    29,
    {
      " PlayScopePieceAnim,ScopeAnim=Silver; PlayCreateCasterGhost,Type=PickUp; PlayTargetMaterialAnim,Anim=FlashAlpha; "
    }
  },
  [30] = {
    30,
    {
      " PlayDeleteEffect,EffectID=417; PlayTargetMaterialAnim,Anim=Transparent; "
    }
  },
  [31] = {
    31,
    {
      " StopAllMaterialAnim,exceptCaster=true; PlayDeleteCasterGhost; PlayAllPieceAnim,Anim=Dark; PlayTargetMaterialAnim,Anim=Transparent; "
    }
  },
  [100] = {
    100,
    {
      " PlayAllPieceAnim,Anim=Dark; PlayCreateCasterGhost,Type=PickUp; "
    }
  },
  [101] = {
    101,
    {
      " CreateOutlineRange; PlayCreateCasterGhost,Type=PickUp; PlayTargetMaterialAnim,Anim=Transparent; "
    }
  },
  [102] = {
    102,
    {
      " SetHudBgAlpha,alpha=0.5,isDark=1; PlayAllPieceAnim,Anim=Dark; PlayTargetMaterialAnim,Anim=Transparent; "
    }
  },
  [103] = {
    103,
    {
      " DestroyOutlineRange; "
    }
  },
  [1171] = {
    1171,
    {
      " PlayCreateCasterGhost,Type=PickUp; PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=Flash; PlayTargetHitBack,casterPosBlock=true; "
    }
  },
  [1181] = {
    1181,
    {
      " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Normal; PlayTargetHitBack,casterPosBlock=true; PlayTargetMaterialAnim,Anim=Flash; "
    }
  },
  [9031] = {
    9031,
    {
      " PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Normal; PlayTargetMaterialAnim,Anim=Flash; "
    }
  },
  [9400] = {
    9400,
    {
      " StopAllMaterialAnim,exceptCaster=true; PlayDeleteCasterGhost; PlayCreateCasterGhost,Type=PickUpRotate,Prefab=1500152.prefab; PlayTargetMaterialAnim,Anim=FlashAlpha; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; "
    }
  },
  [9401] = {
    9401,
    {
      " StopAllMaterialAnim,exceptCaster=true; PlayRotateCasterGhost,DirCount=2; PlayTargetMaterialAnim,Anim=FlashAlpha; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; "
    }
  },
  [9402] = {
    9402,
    {
      " StopAllMaterialAnim,exceptCaster=true; PlayRotateCasterGhost,DirCount=4; PlayTargetMaterialAnim,Anim=FlashAlpha; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; "
    }
  },
  [1321] = {
    1321,
    common[9]
  },
  [1522] = {
    1522,
    {
      " StopAllMaterialAnim,exceptCaster=true; PlayCreateCasterGhost,Type=PickUp; PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=Flash; "
    }
  },
  [500150] = {
    500150,
    common[10]
  },
  [500251] = {
    500251,
    {
      " PlayAllPieceAnim,Anim=Dark; PlayCreateTeamLeaderGhost,Type=Scope; "
    }
  },
  [1511] = {
    1511,
    {
      " Wait,TimeMs=10; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; "
    }
  },
  [1513] = {
    1513,
    {
      " PlayTargetMaterialAnim,Anim=Transparent; "
    }
  },
  [10005] = {
    10005,
    {
      " PlayTargetMaterialAnim,Anim=Flash; PlaySerialKiller "
    }
  },
  [1291] = {
    1291,
    {
      " PlayAbsorb; "
    }
  },
  [1292] = {
    1292,
    {
      " Wait,TimeMs=1000; PlayTargetMaterialAnim,Anim=Flash; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Black; "
    }
  },
  [1131] = {
    1131,
    {
      " PlayScopePieceAnim,ScopeAnim=Add,OtherAnim=Dark; "
    }
  },
  [1261] = {
    1261,
    {
      " PlayScopePieceAnim,ScopeAnim=Reflash,OtherAnim=Dark; "
    }
  },
  [1461] = {
    1461,
    {
      " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayEffectOnPickupPos,effectID=130046101; PlayMultiTraction; "
    }
  },
  [1462] = {
    1462,
    common[11]
  },
  [1741] = {
    1741,
    common[12]
  },
  [1742] = {
    1742,
    {
      "PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark"
    }
  },
  [1541] = {
    1541,
    common[13]
  },
  [1542] = {
    1542,
    common[14]
  },
  [11271] = {
    11271,
    {
      " RevertConvertAnim; PlayScopeConvertGrid,ShowSource=false; PlayEffectOnPickupPos,effectID=2794; "
    }
  },
  [11272] = {
    11272,
    {
      " PlayDeleteEffect,EffectID=2794; PlayDeletePickUpEffect; "
    }
  },
  [11273] = {
    11273,
    {
      " PlayAllPieceAnim,Anim=Dark; PlayPickGridConvertAnim,showSource=false; PlayDeleteEffectOnPickUpPos,effectID=2794; "
    }
  },
  [301021] = {
    301021,
    {
      " PlayCasterEffect,EffectID=2342; "
    }
  },
  [301022] = {
    301022,
    common[12]
  },
  [301023] = {
    301023,
    {
      " PlayDeleteEffect,EffectID=2342; PlayDeletePickUpEffect; "
    }
  },
  [1294] = {
    1294,
    common[15]
  },
  [1295] = {
    1295,
    {
      "PlayPickColorAnim,Anim=Add;"
    }
  },
  [1296] = {
    1296,
    {
      " PlayPickAnim,Anim=Invalid; Wait,TimeMs=500; PlayPickAnim,Anim=Dark; "
    }
  },
  [1501] = {
    1501,
    {
      " PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Flash; PlayTargetHitBack,casterPosBlock=true; "
    }
  },
  [4403] = {
    4403,
    common[16]
  },
  [6101] = {
    6101,
    {
      "PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; StopTargetMaterialAnim; "
    }
  },
  [6102] = {
    6102,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=Flash; "
    }
  },
  [5801] = {
    5801,
    common[17]
  },
  [821001] = {
    821001,
    {
      " RevertConvertAnim; PlayScopePieceAnim,ScopeAnim=Dark; "
    }
  },
  [821002] = {
    821002,
    {
      "PlayExchangeGridColor;"
    }
  },
  [821003] = {
    821003,
    {
      " RevertConvertAnim; PlayExchangeGridColor; "
    }
  },
  [821004] = {
    821004,
    {
      " PlayCreateCasterGhost,Type=PickUp,NoDeleteCasterBlock=true; PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=Flash; PlayTargetHitBack; "
    }
  },
  [821005] = {
    821005,
    {
      " PlayScopePieceAnim,ScopeAnim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; "
    }
  },
  [831001] = {
    831001,
    {
      " PlayDeleteCasterGhost; StopAllMaterialAnim; "
    }
  },
  [861001] = {
    861001,
    common[18]
  },
  [110] = {
    110,
    {
      "PlayAllPieceAnim,Anim=Dark; PlayScopeConvertGrid,ShowSource=false; "
    }
  },
  [111] = {
    111,
    common[3]
  },
  [112] = {
    112,
    {
      "PlayAllPieceAnim,Anim=Gray; PlayTargetMaterialAnim,Anim=Flash; "
    }
  },
  [113] = {
    113,
    {
      " PlayAllPieceAnim,Anim=Gray; PlayActiveSkillAddBuff; "
    }
  },
  [114] = {
    114,
    {
      "PlayTargetSnipeEffect;"
    }
  },
  [115] = {
    115,
    common[7]
  },
  [116] = {
    116,
    {
      "PlayTargetMaterialAnim,Anim=N15Cure; PlayTargetOutline,DownSample=1,BlurNum=1,Intensity=2.18,OutlineSize=3.97,BlendType=Add,OutlinColorR=112,OutlinColorG=255,OutlinColorB=0; "
    }
  },
  [117] = {
    117,
    {
      " PlayTargetMaterialAnim,Anim=Flash; PlayTargetHitBack; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; "
    }
  },
  [118] = {
    118,
    common[3]
  },
  [119] = {
    119,
    {
      " PlayTargetMaterialAnim,Anim=Flash; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayCalcScopePieceAnim,ScopeAnim=Gray,skillID=150114101; "
    }
  },
  [120] = {
    120,
    common[19]
  },
  [121] = {
    121,
    {
      " PlayAllPieceAnim,Anim=Gray; PlayActiveSkillAddBuff; CheckActiveSkillSan; "
    }
  },
  [2702] = {
    2702,
    common[5]
  },
  [5802] = {
    5802,
    {
      "PlayAllPieceAnim,Anim=Normal;"
    }
  },
  [1773] = {
    1773,
    common[20]
  },
  [1774] = {
    1774,
    {
      "PlayScopePieceAnim,ScopeAnim=Dark,OtherAnim=Normal;"
    }
  },
  [17741] = {
    17741,
    common[15]
  },
  [9801] = {
    9801,
    common[21]
  },
  [9802] = {
    9802,
    {
      " PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=FlashAlpha; PlayFirstPickMonsterInSecondPos; PlayFirstPickGridAnim,Anim=Silver; "
    }
  },
  [11117] = {
    11117,
    {
      "PlayTargetMaterialAnim,Anim=FlashAlpha;"
    }
  },
  [9702] = {
    9702,
    {
      " PlayAllPieceAnim,Anim=Dark; PlayCreateCasterGhost,Type=PickUp; PlayTargetMaterialAnim,Anim=FlashAlpha; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; "
    }
  },
  [6201] = {
    6201,
    {
      " PlayScopePieceAnim,ScopeAnim=Add,OtherAnim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; InitArrowByScope; "
    }
  },
  [6202] = {
    6202,
    common[20]
  },
  [6203] = {
    6203,
    {
      " PlayScopePieceAnim,ScopeAnim=Add,OtherAnim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; "
    }
  },
  [9501] = {
    9501,
    {
      " Wait,TimeMs=300; PlayCasterEffect,EffectID=2362; "
    }
  },
  [9502] = {
    9502,
    {
      " PlayDeleteEffect,EffectID=2362; PlayDeletePickUpEffect; "
    }
  },
  [1711] = {
    1711,
    {
      " PlayAllMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [1712] = {
    1712,
    {
      " PlayAllMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=FlashAlpha; "
    }
  },
  [1713] = {
    1713,
    {
      " PlayAllMaterialAnim,Anim=Transparent; PlayTargetMaterialAnim,Anim=FlashAlpha; PlayScopeConvertGrid,ShowSource=true;"
    }
  },
  [5601] = {
    5601,
    {
      " PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark;"
    }
  },
  [5602] = {
    5602,
    common[22]
  },
  [7501] = {
    7501,
    common[16]
  },
  [8901] = {
    8901,
    {
      " PlayAllPieceAnim,Anim=Dark; PlayPickGridConvertAnim,showSource=false; "
    }
  },
  [10901] = {
    10901,
    common[23]
  },
  [10902] = {
    10902,
    common[7]
  },
  [10903] = {
    10903,
    common[24]
  },
  [10802] = {
    10802,
    common[25]
  },
  [3200301] = {
    3200301,
    {
      " PlayDeleteGhost; PlayAllMaterialAnim,ExceptCaster=true; XingshanStrike,teleportScopeCenterType=3,teleportScopeTargetType=3,teleportScopeType=60,teleportScopeParam=0, damageScopeCenterType=1,damageScopeTargetType=10,damageScopeType=61,damageScopeParam=1; "
    }
  },
  [3200302] = {
    3200302,
    {
      " PlayDeleteGhost; StopAllMaterialAnim,ExceptCaster=true; XingshanStrike,teleportScopeCenterType=3,teleportScopeTargetType=3,teleportScopeType=60,teleportScopeParam=0, damageScopeCenterType=1,damageScopeTargetType=10,damageScopeType=61,damageScopeParam=2; "
    }
  },
  [3200303] = {
    3200303,
    common[26]
  },
  [2100111] = {
    2100111,
    {
      " PlayAllPieceAnim,Anim=Dark; PlayDeleteGhost; PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; InitArrow,Number=4,ShowOutGrid=true; "
    }
  },
  [300113] = {
    300113,
    {
      " PlayTargetMaterialAnim,Anim=Flash; PlayForceMovement; "
    }
  },
  [300112] = {
    300112,
    {
      " PlayDeleteCasterGhost; PlayAllPieceAnim,Anim=Dark; StopAllMaterialAnim; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [300121] = {
    300121,
    {
      " DeleteArrow; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; "
    }
  },
  [3001211] = {
    3001211,
    {
      " PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; PlayFirstPickGridAnim,Anim=Silver; InitArrow,Number=4,ShowOutGrid=false; "
    }
  },
  [3001212] = {
    3001212,
    {
      " PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=FlashAlpha; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; "
    }
  },
  [3001261] = {
    3001261,
    {
      " PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Normal; PlayEffectOnPickupPos,effectID=3071; PlaySummonMeantimeLimit,visible=0,trapID=16012610,limitCount=2; "
    }
  },
  [3001262] = {
    3001262,
    {
      " PlayDeletePickUpEffect; PlaySummonMeantimeLimit,visible=1,trapID=16012610,limitCount=2; PlayAllPieceAnim,Anim=Normal; PlayTargetMaterialAnim,Anim=Transparent; "
    }
  },
  [3000551] = {
    3000551,
    common[23]
  },
  [3000552] = {
    3000552,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=FlashAlpha; Wait,TimeMs=500; DataSetHitBackDir; PlayTargetHitBack; "
    }
  },
  [3001230] = {
    3001230,
    {
      " PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayCasterEffect,EffectID=3157; PlayCasterMaterialAnim,Anim=effanim_1601231_atkult_weapom_01; "
    }
  },
  [3001231] = {
    3001231,
    {
      " PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [3001232] = {
    3001232,
    common[22]
  },
  [3001233] = {
    3001233,
    {
      " StopCasterMaterialAnim,Anim=effanim_1601231_atkult_weapom_01; PlayDeleteEffect,EffectID=3157; "
    }
  },
  [3001310] = {
    3001310,
    {
      "PlayTargetMaterialAnim,Anim=FlashAlpha; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark;"
    }
  },
  [3001331] = {
    3001331,
    common[21]
  },
  [3001332] = {
    3001332,
    {
      " PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=Flash; PlayTargetHitBack; "
    }
  },
  [3001371] = {
    3001371,
    {
      "StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; SetUiPickUpTextState,TextState=5; "
    }
  },
  [3001372] = {
    3001372,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Add,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Flash; "
    }
  },
  [3001341] = {
    3001341,
    common[24]
  },
  [3001342] = {
    3001342,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=FlashAlpha; Wait,TimeMs=501; DataSetHitBackDir; PlayTargetHitBack; "
    }
  },
  [306141] = {
    306141,
    {
      " PlayDeleteGhost; StopAllMaterialAnim; RevertConvertAnim; InitArrowByScope; SetUiPickUpTextState,TextState=7; PlayTargetMaterialAnim,Anim=Flash; PlayTargetHitBack; PlayScopeConvertGrid,ShowSource=true "
    }
  },
  [306143] = {
    306143,
    {
      " RevertConvertAnim; PlayScopeConvertGrid,ShowSource=true "
    }
  },
  [306144] = {
    306144,
    {
      " PlayDeleteGhost; StopAllMaterialAnim; PlayTargetMaterialAnim,Anim=Flash; PlayTargetHitBack; "
    }
  },
  [3001420] = {
    3001420,
    {
      " PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayCasterEffect,EffectID=3331; PlayCasterMaterialAnim,Anim=effanim_1501421_ult_wploop; "
    }
  },
  [3001421] = {
    3001421,
    {
      " PlayDeleteGhost; StopTargetMaterialAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [3001422] = {
    3001422,
    {
      " PlayDeleteGhost; StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=Flash; PlayMultiTraction; "
    }
  },
  [3001423] = {
    3001423,
    {
      " StopCasterMaterialAnim,Anim=effanim_1501421_ult_wploop; PlayDeleteEffect,EffectID=3331; "
    }
  },
  [3001431] = {
    3001431,
    {
      " PlayScopePieceAnim,ScopeAnim=Add,OtherAnim=Dark; Wait,TimeMs=500; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [3001441] = {
    3001441,
    {
      " ClearSelectTeamPos; ShowHideSelectTeamPos,show=true; "
    }
  },
  [3001442] = {
    3001442,
    {
      " ShowHideSelectTeamPos,show=false; "
    }
  },
  [3001451] = {
    3001451,
    {
      " StopAllMaterialAnim; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Flash; PlayDeleteGhost; PlayDeleteEffect,EffectID=3423; PlayDeletePickUpEffect; "
    }
  },
  [3001452] = {
    3001452,
    {
      " PlayDeleteGhost; PlayDeleteEffect,EffectID=3423; PlayDeletePickUpEffect; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayCreateGhostOrSummonOnPickupPos,trapID=16014511,effectID=3423,scopeCenterType=3,scopeTargetType=10,scopeType=5,scopeParam=0; "
    }
  },
  [3001453] = {
    3001453,
    {
      " StopAllMaterialAnim; PlayDeleteGhost; PlayDeleteEffect,EffectID=3423; PlayDeletePickUpEffect; "
    }
  },
  [3001454] = {
    3001454,
    {
      " PlayDeleteGhost; PlayDeleteEffect,EffectID=3423; PlayDeletePickUpEffect; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayCreateGhostOrSummonOnPickupPos,trapID=16014511,effectID=3423,scopeCenterType=3,scopeTargetType=1,scopeType=4,scopeParam=; PlayTargetMaterialAnim,Anim=Flash; "
    }
  },
  [280060103] = {
    280060103,
    common[10]
  },
  [280060109] = {
    280060109,
    common[13]
  },
  [280060110] = {
    280060110,
    common[14]
  },
  [280061105] = {
    280061105,
    {
      " PlayScopePieceAnim,ScopeAnim=Normal; "
    }
  },
  [3001491] = {
    3001491,
    {
      " PlayDeleteEffect,EffectID=3509; PlayDeletePickUpEffect; RevertConvertAnim; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [3001492] = {
    3001492,
    common[27]
  },
  [3001493] = {
    3001493,
    common[27]
  },
  [3001494] = {
    3001494,
    {
      " PlayDeleteEffect,EffectID=3509; PlayDeletePickUpEffect; "
    }
  },
  [3001481] = {
    3001481,
    {
      " PlayDeletePickUpEffect; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [3001482] = {
    3001482,
    {
      " PlayDeleteEffect,EffectID=3504; PlayDeleteEffect,EffectID=160148415; PlayDeletePickUpEffect; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Normal; PlayShowAtkOrSummonOnPickupPos,skinUseEffectID=91481|3504|91482|3504|91483|3504|91484|160148419; "
    }
  },
  [3001483] = {
    3001483,
    common[11]
  },
  [3001484] = {
    3001484,
    {
      " PlayCreateCasterGhost,Type=Scope; "
    }
  },
  [16014811] = {
    16014811,
    common[4]
  },
  [3301481] = {
    3301481,
    {
      " PlayDeleteEffect,EffectID=3504; PlayDeleteEffect,EffectID=160148419; PlayDeletePickUpEffect; PlayShowAtkOrSummonOnPickupPos,trapIDList=16014811|16014812|16014813|16014841|16014842|16014843,skinUseEffectID=91481|3504|91482|3504|91483|3504|91484|160148419,scopeCenterType=3,scopeTargetType=1,scopeType=7,scopeParam=2; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=FlashAlpha; "
    }
  },
  [3301482] = {
    3301482,
    {
      " PlayDeleteEffect,EffectID=3504; PlayDeleteEffect,EffectID=160148419; PlayDeletePickUpEffect; PlayShowAtkOrSummonOnPickupPos,trapIDList=16014811|16014812|16014813|16014841|16014842|16014843,skinUseEffectID=91481|3504|91482|3504|91483|3504|91484|160148419,scopeCenterType=3,scopeTargetType=1,scopeType=7,scopeParam=2,matchType=1,matchScopeCenterType=3,matchScopeTargetType=1,matchScopeType=5,matchScopeParam=2; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=FlashAlpha; "
    }
  },
  [3001501] = {
    3001501,
    {
      " StopTargetMaterialAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayAllPieceAnim,Anim=Dark; CheckActiveSkillSan,skillID = 3001501; "
    }
  },
  [3001502] = {
    3001502,
    {
      " StopTargetMaterialAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; CheckActiveSkillSan,skillID = 3001501; "
    }
  },
  [3001503] = {
    3001503,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=Flash; CheckActiveSkillSan,skillID = 3001501; "
    }
  },
  [30015011] = {
    30015011,
    {
      " StopTargetMaterialAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayAllPieceAnim,Anim=Dark; CheckActiveSkillSan,skillID = 3031501; "
    }
  },
  [30015021] = {
    30015021,
    {
      " StopTargetMaterialAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; CheckActiveSkillSan,skillID = 3031501; "
    }
  },
  [30015031] = {
    30015031,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=Flash; CheckActiveSkillSan,skillID = 3031501; "
    }
  },
  [3001510] = {
    3001510,
    {
      " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; CheckActiveSkillSan,skillID = 300151; "
    }
  },
  [30015100] = {
    30015100,
    {
      " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; CheckActiveSkillSan,skillID = 3001510; "
    }
  },
  [300151] = {
    300151,
    {
      " PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=FlashAlpha; CheckActiveSkillSan,skillID = 300151; "
    }
  },
  [30015120] = {
    30015120,
    {
      " PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=FlashAlpha; CheckActiveSkillSan,skillID = 3001510; "
    }
  },
  [3001511] = {
    3001511,
    {
      " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; CheckActiveSkillSan,skillID = 3001511; "
    }
  },
  [3001512] = {
    3001512,
    {
      " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; CheckActiveSkillSan,skillID = 3001512; "
    }
  },
  [3001513] = {
    3001513,
    {
      " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; CheckActiveSkillSan,skillID = 3001513; "
    }
  },
  [3001514] = {
    3001514,
    {
      " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; CheckActiveSkillSan,skillID = 3001514; "
    }
  },
  [3001521] = {
    3001521,
    {
      "CheckActiveSkillSan,skillID = 300152;"
    }
  },
  [302152] = {
    302152,
    {
      "CheckActiveSkillSan,skillID = 302152;"
    }
  },
  [305152] = {
    305152,
    {
      "CheckActiveSkillSan,skillID = 305152;"
    }
  },
  [30015101] = {
    30015101,
    {
      " PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=FlashAlpha; CheckActiveSkillSan,skillID = 3001511; "
    }
  },
  [30015102] = {
    30015102,
    {
      " PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=FlashAlpha; CheckActiveSkillSan,skillID = 3001512; "
    }
  },
  [30015103] = {
    30015103,
    {
      " PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=FlashAlpha; CheckActiveSkillSan,skillID = 3001513; "
    }
  },
  [30015104] = {
    30015104,
    {
      " PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=FlashAlpha; CheckActiveSkillSan,skillID = 3001514; "
    }
  },
  [3001531] = {
    3001531,
    {
      " StopTargetMaterialAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayAllPieceAnim,Anim=Dark; "
    }
  },
  [3001532] = {
    3001532,
    common[17]
  },
  [3001571] = {
    3001571,
    common[28]
  },
  [3001572] = {
    3001572,
    {
      " PlayDeleteEffect,EffectID=3708; PlayDeletePickUpEffect; StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=FlashAlpha; "
    }
  },
  [3001573] = {
    3001573,
    {
      " PlayEffectOnPickupPos,effectID=3708;"
    }
  },
  [3001574] = {
    3001574,
    {
      " PlayDeletePickUpEffect; PlayDeleteEffect,EffectID=3708; StopTargetMaterialAnim; "
    }
  },
  [3001561] = {
    3001561,
    common[28]
  },
  [3001562] = {
    3001562,
    {
      " PlayDeleteEffect,EffectID=3677; PlayDeletePickUpEffect; StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=FlashAlpha; "
    }
  },
  [3001563] = {
    3001563,
    {
      " PlayEffectOnPickupPos,effectID=3677;"
    }
  },
  [3001564] = {
    3001564,
    {
      " PlayDeletePickUpEffect; PlayDeleteEffect,EffectID=3677; "
    }
  },
  [3001565] = {
    3001565,
    common[29]
  },
  [3001621] = {
    3001621,
    common[24]
  },
  [3001622] = {
    3001622,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=FlashAlpha; Wait,TimeMs=501; "
    }
  },
  [300160] = {
    300160,
    common[30]
  },
  [3001641] = {
    3001641,
    {
      " RemoveCasterPosConvert; PlayDeleteCasterGhost; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayTeleportScopeArrow;"
    }
  },
  [3001642] = {
    3001642,
    {
      " RevertConvertAnim; PlayCreateCasterGhost,Type=PickUp; PlayScopeConvertGrid,ShowSource=true; PlayCasterPosConvert; "
    }
  },
  [3001643] = {
    3001643,
    {
      " RemoveCasterPosConvert; PlayDeleteCasterGhost; "
    }
  },
  [3001671] = {
    3001671,
    {
      " PlayUIAddFeatureCardBuff,toTeamTail=1,cardBuffType=1; "
    }
  },
  [3001672] = {
    3001672,
    {
      " PlayUIAddFeatureCardBuff,toTeamLeader=1,cardBuffType=2; "
    }
  },
  [3001673] = {
    3001673,
    {
      " PlayUIRecoverFeatureCardBuff; "
    }
  },
  [3001661] = {
    3001661,
    {
      " PlayDeleteEffect,EffectID=3860; PlayDeletePickUpEffect; StopAllMaterialAnim; PlayScopePieceAnim,ScopeAnim=Dark; PlayTargetMaterialAnim,Anim=Transparent; PlayDeletePreviewEffect; PlayEffectOnTrapByBuffLayer,trapIDList=16016611, checkBuffEffectType=40016611, effectIDList=-1|3887|3888|3889; "
    }
  },
  [3001662] = {
    3001662,
    {
      " PlayDeletePreviewEffect; StopAllMaterialAnim; PlayDeleteEffect,EffectID=3860; PlayDeletePickUpEffect; "
    }
  },
  [3001663] = {
    3001663,
    {
      " PlayDeleteEffect,EffectID=3860; PlayDeletePickUpEffect; PlayPickTrapBuffDamageOrSummon,trapIDList=16016611, checkBuffEffectType=40016611, effectIDList=-1|-1|-1|-1, summonEffectID=3860; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=FlashAlpha; "
    }
  },
  [300167] = {
    300167,
    {
      " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Transparent; CheckActiveSkillSan,skillID = 300167; "
    }
  },
  [303167] = {
    303167,
    {
      " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Transparent; CheckActiveSkillSan,skillID = 303167; "
    }
  },
  [306167] = {
    306167,
    {
      " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Transparent; CheckActiveSkillSan,skillID = 306167; "
    }
  },
  [320167] = {
    320167,
    {
      " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Transparent; CheckActiveSkillSan,skillID = 320167; "
    }
  },
  [323167] = {
    323167,
    {
      " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Transparent; CheckActiveSkillSan,skillID = 323167; "
    }
  },
  [326167] = {
    326167,
    {
      " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Transparent; CheckActiveSkillSan,skillID = 326167; "
    }
  },
  [3001301] = {
    3001301,
    {
      " ShowHideLevelTrapHeadHud,isShow=1,trapIDList=15013011|15013012|15013013|15013014|15013015; PlayScopePieceAnim,ScopeAnim=Dark; "
    }
  },
  [3001302] = {
    3001302,
    common[17]
  },
  [3001303] = {
    3001303,
    {
      " ShowHideLevelTrapHeadHud,isShow=0,trapIDList=15013011|15013012|15013013|15013014|15013015; "
    }
  },
  [300170] = {
    300170,
    {
      " RevertConvertAnim; DeleteArrow; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; "
    }
  },
  [3001701] = {
    3001701,
    {
      " RevertConvertAnim; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [3001702] = {
    3001702,
    {
      " RevertConvertAnim; RevertTransportGrid; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=FlashAlpha; TransportGrid; "
    }
  },
  [3001703] = {
    3001703,
    {
      " RevertConvertAnim; PlayScopeConvertGrid,ShowSource=true,createConvertGrid=1; "
    }
  },
  [3001704] = {
    3001704,
    {
      " PlayDeleteCasterGhost; RevertConvertAnim; RevertTransportGrid; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [3001705] = {
    3001705,
    {
      " PlayDeleteCasterGhost; RevertConvertAnim; RevertTransportGrid; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; RevertPieceAnim; "
    }
  },
  [3001731] = {
    3001731,
    common[31]
  },
  [3001732] = {
    3001732,
    {
      " StopTargetMaterialAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [3001733] = {
    3001733,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Normal; PlayTargetMaterialAnim,Anim=FlashAlpha; "
    }
  },
  [3001691] = {
    3001691,
    {
      " SetUiPickUpTextState,TextState=1; PlayDeleteGhost; PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [3001692] = {
    3001692,
    {
      " PlayDeleteGhost; DataSetHitBackDir; PlayTargetHitBack; PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=Flash; "
    }
  },
  [3001751] = {
    3001751,
    common[32]
  },
  [30017521] = {
    30017521,
    common[33]
  },
  [30017522] = {
    30017522,
    common[33]
  },
  [30017523] = {
    30017523,
    common[33]
  },
  [30017524] = {
    30017524,
    common[33]
  },
  [3001753] = {
    3001753,
    {
      " PlayDeletePickUpEffect; PlayDeleteEffect,EffectID=160175111; StopTargetMaterialAnim; "
    }
  },
  [30017531] = {
    30017531,
    common[32]
  },
  [30017532] = {
    30017532,
    {
      " PlayDeletePickUpEffect; PlayScanTrapOnPickupPos; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [30017533] = {
    30017533,
    {
      " PlayDeletePickUpEffect; StopTargetMaterialAnim; "
    }
  },
  [30017811] = {
    30017811,
    common[16]
  },
  [30017812] = {
    30017812,
    common[34]
  },
  [30017813] = {
    30017813,
    common[34]
  },
  [30018121] = {
    30018121,
    {
      " PlayZhongxuPickupSkill02,trapID=16018111,forceMovementIndex=1; "
    }
  },
  [30018122] = {
    30018122,
    {
      " PlayDeleteGhost; "
    }
  },
  [30018211] = {
    30018211,
    {
      " PlayDeletePickUpEffect; StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Flash;"
    }
  },
  [30018212] = {
    30018212,
    {
      " PlayDeletePickUpEffect; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; "
    }
  },
  [30018511] = {
    30018511,
    common[1]
  },
  [30018521] = {
    30018521,
    common[35]
  },
  [30018520] = {
    30018520,
    {
      " StopTargetMaterialAnim; PlayDeleteCasterGhost; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; SetUiPickUpTextState,TextState=5; "
    }
  },
  [3001841] = {
    3001841,
    {
      " YeliyaRefreshPickGhost, GhostAnim=eff_1601841_atkult_linerender_line_in, LineEffectID=160184109, PickPosEffectID=160184108, BindPos=Root; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [888526101] = {
    888526101,
    common[17]
  },
  [3001891] = {
    3001891,
    {
      " StopTargetMaterialAnim; PlayAllPieceAnim,Anim=Dark; PlayAllMaterialAnim,Anim=Transparent; PlayPickAnim,Anim=Silver; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; InitArrow,Number=4,ShowOutGrid=true; "
    }
  },
  [3001892] = {
    3001892,
    {
      " DeleteArrow; StopAllMaterialAnim,exceptCaster=true; PlayAllPieceAnim,Anim=Dark; PlayScopePieceAnim,ScopeAnim=Silver; PlayPickAnim,Anim=Silver; PlayTargetMaterialAnim,Anim=Flash; InitArrow,Number=4,ShowOutGrid=true; "
    }
  },
  [3001893] = {
    3001893,
    {
      " StopAllMaterialAnim,exceptCaster=true; PlayAllPieceAnim,Anim=Dark; PlayAllMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; InitArrow,Number=4,ShowOutGrid=true; "
    }
  },
  [3301892] = {
    3301892,
    {
      "StopAllMaterialAnim,exceptCaster=true; PlayAllPieceAnim,Anim=Dark; PlayAllMaterialAnim,Anim=Transparent;"
    }
  },
  [30019310] = {
    30019310,
    common[36]
  },
  [30019320] = {
    30019320,
    common[37]
  },
  [30019330] = {
    30019330,
    common[26]
  },
  [3001931] = {
    3001931,
    common[36]
  },
  [3001932] = {
    3001932,
    common[37]
  },
  [3001933] = {
    3001933,
    common[26]
  },
  [3001910] = {
    3001910,
    {
      " StopTargetMaterialAnim; PlayDeleteCasterGhost; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [3001911] = {
    3001911,
    common[35]
  },
  [3001912] = {
    3001912,
    {
      " PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Flash; "
    }
  },
  [3002002] = {
    3002002,
    {
      "PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; StopTargetMaterialAnim; PlayDeleteGhost; "
    }
  },
  [3002001] = {
    3002001,
    {
      " PlayDeleteGhost; PlayScopePieceAnim,ScopeAnim=Normal; PlayTargetMaterialAnim,Anim=Flash; PlayMultiTraction,transCenter=1; "
    }
  },
  [3002003] = {
    3002003,
    {
      " PlayDeleteGhost; PlayScopePieceAnim,ScopeAnim=Normal; PlayTargetMaterialAnim,Anim=Flash; "
    }
  },
  [3002004] = {
    3002004,
    {
      " PlayDeleteGhost; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Flash; PlayMultiTraction,transCenter=1; "
    }
  },
  [3302021] = {
    3302021,
    common[28]
  },
  [3302022] = {
    3302022,
    {
      " PlayDeletePickUpEffect; StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=FlashAlpha; "
    }
  },
  [3002031] = {
    3002031,
    common[19]
  },
  [500011] = {
    500011,
    {
      " RevertConvertAnim; PlayAllPieceAnim,Anim=Dark; PlayTargetMaterialAnim,Anim=FlashAlpha; PlayScopeConvertGrid,ShowSource=true; "
    }
  },
  [500012] = {
    500012,
    common[6]
  },
  [1742001] = {
    1742001,
    common[29]
  },
  [3002042] = {
    3002042,
    common[38]
  },
  [3002052] = {
    3002052,
    common[39]
  },
  [150097101] = {
    150097101,
    {
      "PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayDeleteCasterGhost;"
    }
  },
  [3002071] = {
    3002071,
    {
      " PlayDeletePickUpEffect; PlayEffectOnPickupPos,effectID=160207108; Wait; PlayPickUpGridTogether; "
    }
  },
  [3002072] = {
    3002072,
    {
      " PlayDeletePickUpEffect; RevertConvertAnim; PlayAllPieceAnim,Anim=Dark; "
    }
  },
  [3002073] = {
    3002073,
    {
      " RevertConvertAnim; PlayAllPieceAnim,Anim=Dark; PlayScopeConvertGrid,ShowSource=true; "
    }
  },
  [3002074] = {
    3002074,
    common[40]
  },
  [3002075] = {
    3002075,
    {
      " PlayAllPieceAnim,Anim=Dark; RevertConvertAnim; PlayDeletePickUpEffect; PlayEffectOnPickupPos,effectID=160207108; Wait; PlayPickUpGridTogether; "
    }
  },
  [3002061] = {
    3002061,
    {
      " RevertConvertAnim; PlayAllPieceAnim,Anim=Dark; PlayTargetMaterialAnim,Anim=FlashAlpha; PlayTargetHitBack; PlayScopeConvertGrid,ShowSource=true; "
    }
  },
  [3002062] = {
    3002062,
    common[2]
  },
  [3102061] = {
    3102061,
    {
      " PlayDeleteCasterGhost; RevertConvertAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [3102062] = {
    3102062,
    {
      " RevertConvertAnim; PlayTargetMaterialAnim,Anim=Flash; PlayScopeConvertGrid,ShowSource=true; "
    }
  },
  [3002091] = {
    3002091,
    common[22]
  },
  [30010511] = {
    30010511,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [3001050] = {
    3001050,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Transparent; "
    }
  },
  [3001051] = {
    3001051,
    common[38]
  },
  [30013815] = {
    30013815,
    {
      " RevertConvertAnim; PlayAllScopeConvertGrid; "
    }
  },
  [30021010] = {
    30021010,
    common[36]
  },
  [30021020] = {
    30021020,
    {
      " PlayDeleteGhost; PlayAllMaterialAnim,ExceptCaster=true; PlayCasterDirToPick; PlayJocelyneCreateCasterGhost; "
    }
  },
  [280240101] = {
    280240101,
    {
      "PlayTargetMaterialAnim,Anim=Flash;"
    }
  },
  [3002121] = {
    3002121,
    common[31]
  },
  [3002122] = {
    3002122,
    {
      " PlayAllPieceAnim,Anim=Dark; Wait; StopTargetMaterialAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [3002123] = {
    3002123,
    {
      " PlayAllPieceAnim,Anim=Dark; Wait; StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Normal; PlayTargetMaterialAnim,Anim=Transparent; "
    }
  },
  [3002131] = {
    3002131,
    {
      " StopAllMaterialAnim; PlayAllMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; "
    }
  },
  [3002132] = {
    3002132,
    common[17]
  },
  [3002133] = {
    3002133,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Normal; PlayTargetMaterialAnim,Anim=Transparent; "
    }
  },
  [3002134] = {
    3002134,
    {
      " PlayAudio,audioID=9037,audioType=1; PlaySkillCGEffect,petID=1502131,waitTime=2000; PlayCameraEffect,EffectID=150213107; PlayCasterMaterialAnim,Anim=eff_1502131_atkult_out; PlayCasterAnim,Anim=AtkUlt; PlayAudio,audioID=150213103,audioType=1; PlayCasterEffect,EffectID=150213111; PlayEffectOnPickupPos,effectID=150213106; PlayCasterActive,Enable=false; "
    }
  },
  [3002135] = {
    3002135,
    {
      " PlayDeleteEffectOnPickUpPos,effectID=150213106,ignorePos=1; PlayDeletePreviewEffect,EffectID=150213107; "
    }
  },
  [30013411] = {
    30013411,
    {
      " PlayDeleteGhost; PlayAllPieceAnim,Anim=Dark; PlayTargetMaterialAnim,Anim=Transparent; "
    }
  },
  [30013412] = {
    30013412,
    {
      " PlayDeleteGhost; StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=FlashAlpha; Wait; DataSetHitBackDir; PlayTargetHitBack; "
    }
  },
  [300187] = {
    300187,
    common[30]
  },
  [3002151] = {
    3002151,
    common[30]
  },
  [3002152] = {
    3002152,
    {
      " PlayZhongxuPickupSkill02,forceMovementIndex=2; "
    }
  },
  [3002153] = {
    3002153,
    {
      " PlayDeleteGhost; "
    }
  },
  [30021411] = {
    30021411,
    {
      " PlayDeletePickUpEffect; StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark;"
    }
  },
  [30021412] = {
    30021412,
    {
      " PlayAllMaterialAnim,Anim=Transparent; RevertConvertAnim; PlayPickGridConvertAnim,showSource=false; "
    }
  },
  [30021413] = {
    30021413,
    common[39]
  },
  [30021410] = {
    30021410,
    {
      " RevertConvertAnim; PlayAllPieceAnim,Anim=Dark; PlayTargetMaterialAnim,Anim=Transparent; "
    }
  },
  [3002160] = {
    3002160,
    common[6]
  },
  [3002161] = {
    3002161,
    common[9]
  },
  [3002190] = {
    3002190,
    {
      " PlayScopePieceAnim,ScopeAnim=Dark; SetUiPickUpTextState,TextState=5; "
    }
  },
  [3002191] = {
    3002191,
    {
      "BeginUIPreview; "
    }
  },
  [3002192] = {
    3002192,
    {
      " ClearUIPreview; "
    }
  },
  [3002193] = {
    3002193,
    {
      " BeginUIPreview; "
    }
  },
  [3302190] = {
    3302190,
    {
      " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; SetUiPickUpTextState,TextState=5; "
    }
  },
  [3302191] = {
    3302191,
    {
      "BeginUIPreview; PlayDeletePickUpEffect; SetUiPickUpTextState,TextState=5;"
    }
  },
  [3302192] = {
    3302192,
    {
      " ClearUIPreview; PlayDeletePickUpEffect; "
    }
  },
  [3302193] = {
    3302193,
    {
      " PlayDeletePickUpEffect; PlayEffectOnPickupPos,effectID=160207108; BeginUIPreview; SetUiPickUpTextState,TextState=5; "
    }
  },
  [3302194] = {
    3302194,
    {
      " PlayDeletePickUpEffect; SetUiPickUpTextState,TextState=5; "
    }
  },
  [3002181] = {
    3002181,
    {
      " PlayAllMaterialAnim,Anim=Transparent; PlayTargetMaterialAnim,Anim=FlashAlpha; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayPickGridConvertAnim,showSource=false; "
    }
  },
  [3002182] = {
    3002182,
    common[17]
  },
  [16021912] = {
    16021912,
    common[17]
  },
  [3002211] = {
    3002211,
    common[18]
  },
  [3002212] = {
    3002212,
    {
      "PlayAllPieceAnim,Anim=Dark; PlayOnlyScopePieceAnim,ScopeAnim=Add;"
    }
  },
  [3002213] = {
    3002213,
    {
      "PlayOnlyScopePieceAnim,ScopeAnim=Normal;"
    }
  },
  [3002214] = {
    3002214,
    {
      " PlayDeletePickUpEffect; PlayHudEffectInScope,effectPrefabName=hud_yeliya_ghost_index_info.prefab;"
    }
  },
  [3002215] = {
    3002215,
    common[40]
  },
  [3002216] = {
    3002216,
    {
      " PlayOnlyScopePieceAnim,ScopeAnim=Dark;"
    }
  },
  [3002231] = {
    3002231,
    {
      " RevertConvertAnim; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; InitArrow,Number=8; "
    }
  },
  [3002232] = {
    3002232,
    {
      " RevertConvertAnim; PlayTargetMaterialAnim,Anim=Flash; PlayScopeConvertGrid,ShowSource=true "
    }
  },
  [3002233] = {
    3002233,
    {
      " RevertConvertAnim; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Flash; "
    }
  },
  [802401] = {
    802401,
    {
      " PlayDeleteGhost; PlayScopePieceAnim,ScopeAnim=Dark,OtherAnim=Normal; "
    }
  },
  [802402] = {
    802402,
    {
      " PlayDeleteGhost; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; DataSetHitBackDir; PlayTargetHitBack; "
    }
  },
  [802403] = {
    802403,
    {
      " PlayScopePieceAnim,ScopeAnim=Dark; DataSetHitBackDir; PlayTargetMaterialAnim,Anim=Transparent; "
    }
  },
  [3002251] = {
    3002251,
    common[28]
  },
  [3002252] = {
    3002252,
    {
      " PlayScopePieceAnim,ScopeAnim=Silver,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=FlashAlpha; "
    }
  },
  [3002282] = {
    3002282,
    common[17]
  },
  [300229101] = {
    300229101,
    {
      "PlayTetris,tetrisEffectList=160229105|160229117|160229118|160229119|160229120|160229121|160229122;"
    }
  },
  [300229102] = {
    300229102,
    {
      "PlayDeletePickUpEffect,ignorePos=1;"
    }
  },
  [300229103] = {
    300229103,
    {
      "TurnTetris,Time=100,Anim=eff_1602291_atkult_gezi01_loop; PlayAudio,audioID=160229103,audioType=1;"
    }
  },
  [300229104] = {
    300229104,
    common[1]
  },
  [3002311] = {
    3002311,
    {
      " StopTargetMaterialAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayAllPieceAnim,Anim=Dark; CheckActiveSkillSan,skillID = 3002311; "
    }
  },
  [3002312] = {
    3002312,
    {
      " StopTargetMaterialAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; CheckActiveSkillSan,skillID = 3002311; "
    }
  },
  [3002313] = {
    3002313,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=Flash; CheckActiveSkillSan,skillID = 3002311; "
    }
  },
  [3032311] = {
    3032311,
    {
      " StopTargetMaterialAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayAllPieceAnim,Anim=Dark; CheckActiveSkillSan,skillID = 3032311; "
    }
  },
  [3032312] = {
    3032312,
    {
      " StopTargetMaterialAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; CheckActiveSkillSan,skillID = 3032311; "
    }
  },
  [3032313] = {
    3032313,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=Flash; CheckActiveSkillSan,skillID = 3032311; "
    }
  },
  [3202311] = {
    3202311,
    {
      " StopTargetMaterialAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayAllPieceAnim,Anim=Dark; CheckActiveSkillSan,skillID = 3202311; "
    }
  },
  [3202312] = {
    3202312,
    {
      " StopTargetMaterialAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; CheckActiveSkillSan,skillID = 3202311; "
    }
  },
  [3202313] = {
    3202313,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=Flash; CheckActiveSkillSan,skillID = 3202311; "
    }
  },
  [3232311] = {
    3232311,
    {
      " StopTargetMaterialAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayAllPieceAnim,Anim=Dark; CheckActiveSkillSan,skillID = 3232311; "
    }
  },
  [3232312] = {
    3232312,
    {
      " StopTargetMaterialAnim; PlayTargetMaterialAnim,Anim=Transparent; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; CheckActiveSkillSan,skillID = 3232311; "
    }
  },
  [3232313] = {
    3232313,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Silver; PlayTargetMaterialAnim,Anim=Flash; CheckActiveSkillSan,skillID = 3232311; "
    }
  },
  [109011] = {
    109011,
    common[24]
  },
  [300232101] = {
    300232101,
    {
      "PlayScopePieceAnim,ScopeAnim=Dark,OtherAnim=Normal; CheckActiveSkill;"
    }
  },
  [3661081] = {
    3661081,
    {
      " PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; PlayDeleteCasterGhost; PlayTargetMaterialAnim,Anim=Transparent; PlayTargetHpSliderBlink,compareType=5,compareParam=0.1; "
    }
  },
  [3661082] = {
    3661082,
    common[25]
  },
  [3661083] = {
    3661083,
    {
      " StopTargetHpSliderBlink; "
    }
  },
  [3002301] = {
    3002301,
    {
      "StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; SetUiPickUpTextState,TextState=5; CheckActiveSkillSan,skillID = 3002301; "
    }
  },
  [3002302] = {
    3002302,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Add,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Flash; CheckActiveSkillSan,skillID = 3002301; "
    }
  },
  [3002303] = {
    3002303,
    {
      "StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; SetUiPickUpTextState,TextState=5; CheckActiveSkillSan,skillID = 3042301; "
    }
  },
  [3002304] = {
    3002304,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Add,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Flash; CheckActiveSkillSan,skillID = 3042301; "
    }
  },
  [3002305] = {
    3002305,
    {
      "StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; SetUiPickUpTextState,TextState=5; CheckActiveSkillSan,skillID = 30023011; "
    }
  },
  [3002306] = {
    3002306,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Add,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Flash; CheckActiveSkillSan,skillID = 30023011; "
    }
  },
  [3002307] = {
    3002307,
    {
      "StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Normal,OtherAnim=Dark; SetUiPickUpTextState,TextState=5; CheckActiveSkillSan,skillID = 30423011; "
    }
  },
  [3002308] = {
    3002308,
    {
      " StopTargetMaterialAnim; PlayScopePieceAnim,ScopeAnim=Add,OtherAnim=Dark; PlayTargetMaterialAnim,Anim=Flash; CheckActiveSkillSan,skillID = 30423011; "
    }
  },
  [3002331] = {
    3002331,
    common[28]
  },
  [3002332] = {
    3002332,
    common[22]
  },
  [3002371] = {
    3002371,
    common[17]
  },
  [30023610] = {
    30023610,
    common[41]
  },
  [30023611] = {
    30023611,
    {
      " PlayAudio,audioID=170236103,audioType=1; PlayPet1702361Anim,animTeamLeader=AtkUlt1,animNotTeamLeader=AtkUlt2; PlayCasterEffect,EffectID=17023611,isPet1702361=1; PlayGridEffect,effectID=17023612,playType=1,x=5,y=4; PlayCasterMaterialAnim,Anim=eff_1702361_ult_main,isPet1702361=1; Wait,TimeMs=1000; PlayGridEffect,effectID=17023613,playType=2; Wait,TimeMs=2500; "
    }
  },
  [30023612] = {
    30023612,
    {
      " PlayEffectAnimByEffectID,effectID=17023612,anim=eff_1702361_ult_scene_out; PlayEffectAnimByEffectID,effectID=17023613,anim=eff_1702361_ult_gezi_out; Wait,TimeMs=500; PlayDeletePickUpEffect; "
    }
  },
  [30023621] = {
    30023621,
    {
      " PlayCasterAnim,animName=AtkUlt2; PlayCasterEffect,effectID=17023611; PlayGridEffect,effectID=17023612,playType=1,x=5,y=4; PlayCasterMaterialAnim,Anim=eff_1702361_ult_main; Wait,TimeMs=1000; PlayGridEffect,effectID=17023613,playType=2; "
    }
  },
  [3002381] = {
    3002381,
    common[41]
  },
  [3002382] = {
    3002382,
    common[17]
  }
}
return config, "ID", key
