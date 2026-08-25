local System = require("System.System")
local readonly = System.readonly
local MonsterConfig = readonly({
  [14042] = {
    ID = 14042,
    CnID = "怪物@怪物24",
    BaseSortID = 1,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    MonsterName = "MonsterConfig_14042_MonsterName|「分裂患者」",
    Desc = "MonsterConfig_14042_Desc|自蜡像中爬出的神秘女士。她的大脑十分拥挤，疑似歇斯底里症晚期患者。",
    InitSkillList = {4232},
    CycleSkillList1 = {
      4695,
      4528,
      4232,
      4528,
      4232
    },
    AnimationID = 15634,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C06_AF.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = -11,
    MonsterProportion = 1
  },
  [14031] = {
    ID = 14031,
    CnID = "怪物@怪物艾继丝",
    BaseSortID = 2,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      84303
    },
    MonsterName = "MonsterConfig_14031_MonsterName|艾继丝",
    Desc = "MonsterConfig_14031_Desc|为了希望守护的人，她也可以变得坚强。",
    InitSkillList = {
      4652,
      4652,
      4356,
      4133,
      4626,
      4356,
      4652,
      4133,
      4626,
      4356
    },
    CycleSkillList1 = {
      4652,
      4652,
      4356,
      4133,
      4626,
      4356,
      4652,
      4133,
      4626,
      4356
    },
    AnimationID = 15664,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B03_AF.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.85,
    MonsterProportion = 1
  },
  [14065] = {
    ID = 14065,
    CnID = "怪物@大型黑泥怪",
    BaseSortID = 3,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 84293},
    MonsterName = "MonsterConfig_14065_MonsterName|融蚀浆",
    Desc = "MonsterConfig_14065_Desc|这肯定只是融蚀浆而已。别去思考其中包含着什么。",
    ExistState = {22074, 89575},
    StateLayers = 1,
    InitSkillList = {
      4862,
      4490,
      4614,
      4034
    },
    CycleSkillList1 = {
      4862,
      4490,
      4614,
      4034
    },
    AnimationID = 15623,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0002.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.87,
    MonsterProportion = 1
  },
  [13976] = {
    ID = 13976,
    CnID = "怪物@大型黑泥怪BOSS材料本",
    BaseSortID = 4,
    BattleTag = "Boss",
    MonsterTag = {84277, 84293},
    MonsterName = "MonsterConfig_13976_MonsterName|「万物寂灭」",
    Desc = "MonsterConfig_13976_Desc|融蚀浆平等地赐予万物死亡。万物寂灭合一。",
    ExistState = {89575},
    InitSkillList = {
      4411,
      4066,
      4143,
      3975
    },
    CycleSkillList1 = {
      4411,
      4066,
      4143,
      3975
    },
    AnimationID = 15616,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0002_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.31,
    MonsterProportion = 1
  },
  [14066] = {
    ID = 14066,
    CnID = "怪物@大型黑泥怪BOSS",
    BaseSortID = 5,
    BattleTag = "Boss",
    MonsterTag = {84277, 84293},
    MonsterName = "MonsterConfig_14066_MonsterName|「万物寂灭」",
    Desc = "MonsterConfig_14066_Desc|融蚀浆平等地赐予万物死亡。万物寂灭合一。",
    ExistState = {89575},
    InitSkillList = {
      4526,
      4066,
      4143,
      3975
    },
    CycleSkillList1 = {
      4526,
      4066,
      4143,
      3975
    },
    AnimationID = 15616,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0002_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.31,
    MonsterProportion = 1
  },
  [21380] = {
    ID = 21380,
    CnID = "怪物@大型黑泥怪BOSS模拟室",
    BaseSortID = 6,
    BattleTag = "Boss",
    MonsterTag = {84277},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_21380_MonsterName|「仿生溶浆-二重」",
    Desc = "MonsterConfig_21380_Desc|学院用来测试唤醒体战斗能力的仿生生物，纯天然无融蚀污染。",
    ExistState = {43818},
    StateLayers = 1,
    InitSkillList = {
      79758,
      79759,
      79760,
      79761,
      79758,
      79759,
      79760,
      79761,
      79758,
      79759,
      79760,
      79761,
      79758,
      79759,
      79760,
      79761,
      79758,
      79759,
      79760,
      79761,
      79758,
      79759,
      79760,
      79761,
      79758,
      79759,
      79760,
      79761,
      79758,
      79759,
      79760,
      79761,
      79758,
      79759,
      79760,
      79761,
      79758,
      79759,
      79760,
      79761,
      79758,
      79759,
      79760,
      79761,
      79758,
      79759,
      79760,
      79761
    },
    AnimationID = 15616,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0002_BOSSSIZE.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.655,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [14033] = {
    ID = 14033,
    CnID = "怪物@大型黑泥怪精英",
    BaseSortID = 7,
    BattleTag = "Elite",
    MonsterTag = {90641, 84293},
    MonsterName = "MonsterConfig_14033_MonsterName|「终末泥淖」",
    Desc = "MonsterConfig_14033_Desc|融蚀浆平等地赐予万物终点。我们终为一体。",
    ExistState = {89575},
    InitSkillList = {
      4128,
      4676,
      4041,
      4739
    },
    CycleSkillList1 = {
      4128,
      4676,
      4041,
      4739
    },
    AnimationID = 15623,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0002.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.87,
    MonsterProportion = 1
  },
  [14014] = {
    ID = 14014,
    CnID = "怪物@大型维度生物",
    BaseSortID = 8,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90644,
      84283,
      84291
    },
    MonsterName = "MonsterConfig_14014_MonsterName|猎犬之足",
    Desc = "MonsterConfig_14014_Desc|自其他维度撕裂缝隙而来的追逐之足，捕捉每个冒失的灵魂。",
    ExistState = {22074, 89574},
    StateLayers = 1,
    InitSkillList = {
      4472,
      23729,
      4044,
      4419
    },
    CycleSkillList1 = {
      4472,
      23729,
      4044,
      4419
    },
    AnimationID = 15691,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0403.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [14015] = {
    ID = 14015,
    CnID = "怪物@大型维度生物BOSS",
    BaseSortID = 9,
    BattleTag = "Boss",
    MonsterTag = {84277, 84293},
    MonsterName = "MonsterConfig_14015_MonsterName|撕裂维度之足",
    Desc = "MonsterConfig_14015_Desc|自其他维度撕裂缝隙而来的追逐之足，捕捉每个冒失的灵魂。",
    ExistState = {89574},
    InitSkillList = {
      4472,
      4629,
      4044,
      4419
    },
    CycleSkillList1 = {
      4472,
      4629,
      4044,
      4419
    },
    AnimationID = 15703,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0403_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [13988] = {
    ID = 13988,
    CnID = "怪物@大型维度生物精英",
    BaseSortID = 10,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84291,
      84283,
      90644
    },
    MonsterName = "MonsterConfig_13988_MonsterName|奔袭之足",
    Desc = "MonsterConfig_13988_Desc|自其他维度撕裂缝隙而来的追逐之足，捕捉每个冒失的灵魂。",
    ExistState = {89574},
    InitSkillList = {
      4472,
      23729,
      4044,
      4419
    },
    CycleSkillList1 = {
      4472,
      23729,
      4044,
      4419
    },
    AnimationID = 15691,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0403.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [14108] = {
    ID = 14108,
    CnID = "怪物@地狱犬头部",
    BaseSortID = 11,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_14108_MonsterName|「刻耳柏洛斯」",
    Desc = "MonsterConfig_14108_Desc|贪婪的猎犬之颅，威压之瞳盯上了你……",
    ExistState = {
      3018,
      3694,
      22068
    },
    StateLayers = "CmdCaster.max_hp*0.25,1,1",
    StateParams = "CmdCaster.max_hp*1,CmdCaster.max_hp*0.25",
    InitSkillList = {
      4833,
      4752,
      4477
    },
    CycleSkillList1 = {
      4833,
      4752,
      4477
    },
    AnimationID = 15656,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0405.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.19,
    MonsterProportion = 1
  },
  [14098] = {
    ID = 14098,
    CnID = "怪物@雕塑家改造人大",
    BaseSortID = 12,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84280,
      90645
    },
    MonsterName = "MonsterConfig_14098_MonsterName|执妄者",
    Desc = "MonsterConfig_14098_Desc|怀揣执念渴望启示的改造人。会呼唤信徒并对其强化。",
    ExistState = {
      80445,
      2921,
      22074
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      4553,
      4420,
      4867,
      4553,
      4139
    },
    CycleSkillList1 = {
      4420,
      4867,
      4139,
      4553
    },
    AnimationID = 15770,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0303.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.96,
    MonsterDefPercent = 2,
    MonsterProportion = 0.8
  },
  [13973] = {
    ID = 13973,
    CnID = "怪物@雕塑家改造人大BOSS",
    BaseSortID = 13,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90645,
      84280
    },
    MonsterName = "MonsterConfig_13973_MonsterName|「聆听启示」",
    Desc = "MonsterConfig_13973_Desc|怀揣执念渴望启示的改造人。会呼唤信徒并对其强化。",
    ExistState = {80445, 2921},
    StateLayers = "1,1",
    InitSkillList = {
      4553,
      4511,
      4743,
      4553,
      4139
    },
    CycleSkillList1 = {
      4511,
      4743,
      4139,
      4553
    },
    AnimationID = 15767,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0303_BOSSSIZE.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.96,
    MonsterDefPercent = 2,
    MonsterProportion = 0.8
  },
  [13990] = {
    ID = 13990,
    CnID = "怪物@雕塑家改造人大精英",
    BaseSortID = 14,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84280,
      90645
    },
    MonsterName = "MonsterConfig_13990_MonsterName|固守之执妄",
    Desc = "MonsterConfig_13990_Desc|怀揣执念固守于此的改造人。会呼唤自己的信徒并对其强化。",
    ExistState = {80445, 2921},
    StateLayers = "1,1",
    InitSkillList = {
      4126,
      3970,
      4556,
      4126,
      4657
    },
    CycleSkillList1 = {
      3970,
      4556,
      4657,
      4126
    },
    AnimationID = 15770,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0303.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.96,
    MonsterDefPercent = 0.79,
    MonsterProportion = 0.85
  },
  [14070] = {
    ID = 14070,
    CnID = "怪物@雕塑家改造人小",
    BaseSortID = 15,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84280},
    MonsterName = "MonsterConfig_14070_MonsterName|求告者",
    Desc = "MonsterConfig_14070_Desc|雕塑家协会的改造产物，融蚀症状在逐渐加深……",
    ExistState = {80445, 22074},
    StateLayers = "1,1",
    InitSkillList = {
      4749,
      4211,
      4352
    },
    CycleSkillList1 = {
      4749,
      4211,
      4352
    },
    AnimationID = 15701,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0301.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.86,
    MonsterProportion = 0.25
  },
  [22235] = {
    ID = 22235,
    CnID = "怪物@雕塑家改造人小维度",
    BaseSortID = 16,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84280,
      90644
    },
    MonsterName = "MonsterConfig_22235_MonsterName|多维者",
    Desc = "MonsterConfig_22235_Desc|误入维度间隙，形体受空间撕扯的求告之人。对雕塑家协会的忠心未曾有变。",
    ExistState = {80445, 22074},
    StateLayers = "1,1",
    InitSkillList = {
      4749,
      22234,
      22233
    },
    CycleSkillList1 = {
      4749,
      22234,
      22233
    },
    AnimationID = 22236,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0301_BT.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.04,
    MonsterProportion = 0.25
  },
  [14026] = {
    ID = 14026,
    CnID = "怪物@雕塑家改造人中A",
    BaseSortID = 17,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84280,
      84291
    },
    MonsterName = "MonsterConfig_14026_MonsterName|宣言者",
    Desc = "MonsterConfig_14026_Desc|雕塑家协会的改造产物，受过洗脑而充满信念，越战越勇。",
    ExistState = {
      80445,
      2517,
      22074
    },
    StateLayers = "1,1,1",
    InitSkillList = {4465},
    CycleSkillList1 = {
      4107,
      4567,
      4107
    },
    AnimationID = 15641,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0302_AT.png",
    MonsterHpPercent = 1.02,
    MonsterAtkPercent = 0.96,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [14025] = {
    ID = 14025,
    CnID = "怪物@雕塑家改造人中B",
    BaseSortID = 18,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84280,
      84291
    },
    MonsterName = "MonsterConfig_14025_MonsterName|俯仰者",
    Desc = "MonsterConfig_14025_Desc|雕塑家协会的改造产物，受过洗脑而充满信念，越战越勇。",
    ExistState = {
      80445,
      35684,
      22074
    },
    StateLayers = "1,1,1",
    InitSkillList = {4465},
    CycleSkillList1 = {
      4567,
      4107,
      4567
    },
    AnimationID = 15618,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0302_BT.png",
    MonsterHpPercent = 0.96,
    MonsterAtkPercent = 1.02,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [51385] = {
    ID = 51385,
    CnID = "怪物@雕塑家改造人中C",
    BaseSortID = 19,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84280,
      84291
    },
    MonsterName = "MonsterConfig_51385_MonsterName|苏醒者",
    Desc = "MonsterConfig_51385_Desc|雕塑家协会的改造产物，受过洗脑而充满信念，越战越勇。",
    ExistState = {
      80445,
      35684,
      22074
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      4567,
      4465,
      4107
    },
    CycleSkillList1 = {
      4567,
      4107,
      4567
    },
    AnimationID = 15618,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0302_BT.png",
    MonsterHpPercent = 0.96,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [13987] = {
    ID = 13987,
    CnID = "怪物@雕塑家改造人中BOSS",
    BaseSortID = 20,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84291,
      84280
    },
    MonsterName = "MonsterConfig_13987_MonsterName|「求诸己身」",
    Desc = "MonsterConfig_13987_Desc|雕塑家协会的改造产物，受过洗脑而充满信念，越战越勇。",
    ExistState = {80445, 2517},
    StateLayers = "1,1",
    InitSkillList = {4394},
    CycleSkillList1 = {
      4202,
      4782,
      4202,
      4030,
      4202,
      4782,
      4202
    },
    AnimationID = 15690,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0302_BT_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.84,
    MonsterProportion = 1
  },
  [14023] = {
    ID = 14023,
    CnID = "怪物@雕塑家改造人中精英",
    BaseSortID = 21,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84280,
      84291
    },
    MonsterName = "MonsterConfig_14023_MonsterName|超脱之俯仰",
    Desc = "MonsterConfig_14023_Desc|雕塑家协会的改造产物，受过洗脑而充满信念，越战越勇。",
    ExistState = {80445, 2517},
    StateLayers = "1,1",
    InitSkillList = {
      4187,
      4115,
      3988,
      4347
    },
    CycleSkillList1 = {4115, 3988},
    AnimationID = 15641,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0302_AT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.5,
    MonsterProportion = 1
  },
  [14006] = {
    ID = 14006,
    CnID = "怪物@乔治BOSS",
    BaseSortID = 22,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84294,
      84280
    },
    MonsterName = "MonsterConfig_14006_MonsterName|「爱哭鬼乔▼」",
    Desc = "MonsterConfig_14006_Desc|乔治和蜡像们融合而成的悲伤怪物。既然你搅碎了它的人生，那就用生命来偿还吧。",
    ExistState = {
      3938,
      3805,
      2921
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      4354,
      4557,
      4452,
      4665
    },
    CycleSkillList1 = {
      4354,
      4557,
      4452,
      4665
    },
    AnimationID = 15655,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0002.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 4,
    MonsterProportion = 1
  },
  [14088] = {
    ID = 14088,
    CnID = "怪物@黑泥鼠王剧情",
    BaseSortID = 23,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84291},
    MonsterName = "MonsterConfig_14088_MonsterName|融蚀鼠王",
    Desc = "MonsterConfig_14088_Desc|沾满融蚀的尾巴将它们粘合在一起，痛苦却无法分离。",
    ExistState = {2613},
    StateLayers = 1,
    InitSkillList = {4843},
    CycleSkillList1 = {4272},
    AnimationID = 15750,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0201.png",
    MonsterHpPercent = 4,
    MonsterAtkPercent = 3,
    MonsterDefPercent = 0.25,
    MonsterProportion = 1
  },
  [14046] = {
    ID = 14046,
    CnID = "怪物@黑泥鼠王",
    BaseSortID = 24,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84291},
    MonsterName = "MonsterConfig_14046_MonsterName|融蚀鼠王",
    Desc = "MonsterConfig_14046_Desc|沾满融蚀的尾巴将它们粘合在一起，痛苦却无法分离。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {4843},
    CycleSkillList1 = {4272},
    AnimationID = 15750,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0201.png",
    MonsterHpPercent = 4,
    MonsterAtkPercent = 3,
    MonsterDefPercent = 0.25,
    MonsterProportion = 1
  },
  [13991] = {
    ID = 13991,
    CnID = "怪物@济贫院疯子A",
    BaseSortID = 25,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_13991_MonsterName|裁缝",
    Desc = "MonsterConfig_13991_Desc|裁缝被融蚀侵蚀了理智，剪刀剪开的不再是布料，而是血肉。攻击频率较高。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      4599,
      4439,
      4324,
      4308
    },
    CycleSkillList1 = {
      4599,
      4439,
      4324
    },
    AnimationID = 15731,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0102_AT.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [13992] = {
    ID = 13992,
    CnID = "怪物@济贫院疯子B",
    BaseSortID = 26,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_13992_MonsterName|碎石工",
    Desc = "MonsterConfig_13992_Desc|碎石工被融蚀侵蚀了理智，手里的铁镐成了伤人的利器。会积蓄力量，在第三回合使用超重击。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      4479,
      4639,
      4820
    },
    CycleSkillList1 = {
      4479,
      4639,
      4820,
      4479
    },
    AnimationID = 15730,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0102_BT.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 2.67,
    MonsterProportion = 0.6
  },
  [14061] = {
    ID = 14061,
    CnID = "怪物@济贫院疯子BOSS",
    BaseSortID = 27,
    BattleTag = "Boss",
    MonsterTag = {84277, 90645},
    MonsterName = "MonsterConfig_14061_MonsterName|「铁镐」卢森",
    Desc = "MonsterConfig_14061_Desc|他也曾有过家人，现在却只剩下癫狂。会使用重击，攻击能使其退缩。",
    ExistState = {2559},
    StateLayers = "CmdCaster.atk*0.03",
    InitSkillList = {
      4263,
      4387,
      4448
    },
    CycleSkillList1 = {
      4263,
      4387,
      4448
    },
    AnimationID = 15642,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0102_BT_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [35525] = {
    ID = 35525,
    CnID = "怪物@济贫院疯子BOSS莉莉",
    BaseSortID = 28,
    BattleTag = "Boss",
    MonsterTag = {84277, 90645},
    MonsterName = "MonsterConfig_35525_MonsterName|「鲜花守卫」@2",
    Desc = "MonsterConfig_35525_Desc|曾为瑞尼镇花店店主的@1，现在已经分不清百合和马蒂莲。",
    ExistState = {2559},
    StateLayers = "CmdCaster.atk*0.03",
    InitSkillList = {
      35524,
      35523,
      35522
    },
    CycleSkillList1 = {
      35524,
      35523,
      35522
    },
    AnimationID = 15642,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0102_BT_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [13955] = {
    ID = 13955,
    CnID = "怪物@济贫院疯子精英",
    BaseSortID = 29,
    BattleTag = "Elite",
    MonsterTag = {90641, 90645},
    MonsterName = "MonsterConfig_13955_MonsterName|疯狂碎石工",
    Desc = "MonsterConfig_13955_Desc|他也曾有过家人，现在却只剩下癫狂。会使用重击，攻击能使其退缩。",
    ExistState = {2559},
    StateLayers = "CmdCaster.atk*0.03",
    InitSkillList = {
      4263,
      4387,
      21902
    },
    CycleSkillList1 = {
      4263,
      4387,
      21902
    },
    AnimationID = 15730,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0102_BT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [22337] = {
    ID = 22337,
    CnID = "怪物@济贫院疯子A冰镐",
    BaseSortID = 30,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_22337_MonsterName|离弃之人",
    Desc = "MonsterConfig_22337_Desc|被挚爱抛弃的歇斯底里患者，已经分不清现实与记忆的区别。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      22331,
      22332,
      22333,
      22331
    },
    CycleSkillList1 = {
      22331,
      22332,
      22333,
      22331
    },
    AnimationID = 22338,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0102_DT.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 2,
    MonsterProportion = 0.6
  },
  [22336] = {
    ID = 22336,
    CnID = "怪物@济贫院疯子B冰镐",
    BaseSortID = 31,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_22336_MonsterName|谵妄之人",
    Desc = "MonsterConfig_22336_Desc|主动离开的歇斯底里患者，已经分不清现实与记忆的区别。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      22333,
      22332,
      22331
    },
    CycleSkillList1 = {
      22333,
      22332,
      22331
    },
    AnimationID = 22338,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0102_DT.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 2,
    MonsterProportion = 0.6
  },
  [22335] = {
    ID = 22335,
    CnID = "怪物@济贫院疯子精英冰镐",
    BaseSortID = 32,
    BattleTag = "Elite",
    MonsterTag = {90641, 90645},
    MonsterName = "MonsterConfig_22335_MonsterName|「歇斯底里患者」",
    Desc = "MonsterConfig_22335_Desc|曾饱读苏格拉底，曾信仰弗洛伊德。可惜的是，现在脑子里只剩尖叫的歇斯底里。",
    ExistState = {2559},
    StateLayers = "CmdCaster.atk*0.03",
    InitSkillList = {
      22346,
      22344,
      22345
    },
    CycleSkillList1 = {
      22346,
      22344,
      22345
    },
    AnimationID = 22338,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0102_DT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [14034] = {
    ID = 14034,
    CnID = "怪物@街头小孩A",
    BaseSortID = 33,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_14034_MonsterName|快步跑",
    Desc = "MonsterConfig_14034_Desc|身手敏捷的东区街童。开场就会展开迅捷的攻击。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      4544,
      4565,
      4341
    },
    CycleSkillList1 = {
      4544,
      4565,
      4341,
      4544
    },
    AnimationID = 15715,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0101_AT.png",
    MonsterHpPercent = 0.93,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0,
    MonsterProportion = 0.3
  },
  [14035] = {
    ID = 14035,
    CnID = "怪物@街头小孩B",
    BaseSortID = 34,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_14035_MonsterName|大力气",
    Desc = "MonsterConfig_14035_Desc|强壮有力的东区街童。攻击能够削弱敌方，并会展开护盾保护自己。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      4333,
      4600,
      3965
    },
    CycleSkillList1 = {
      4333,
      4600,
      3965,
      4333
    },
    AnimationID = 15718,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0101_BT.png",
    MonsterHpPercent = 0.87,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.25,
    MonsterProportion = 0.3
  },
  [14116] = {
    ID = 14116,
    CnID = "怪物@街头小孩BOSS",
    BaseSortID = 35,
    BattleTag = "Boss",
    MonsterTag = {84277, 90645},
    MonsterName = "MonsterConfig_14116_MonsterName|扳手杰克逊",
    Desc = "MonsterConfig_14116_Desc|他的橄榄球护具看起来很不合身，但生满铁锈的扳手却不乏威力，能造成大量伤口。",
    ExistState = {21826},
    StateLayers = 1,
    InitSkillList = {
      4798,
      4320,
      4148,
      4798
    },
    CycleSkillList1 = {
      4798,
      4320,
      4148,
      4798
    },
    AnimationID = 15758,
    MonsterClass = "Boss",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0101_CT_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 4.66,
    MonsterProportion = 1
  },
  [14036] = {
    ID = 14036,
    CnID = "怪物@街头小孩C",
    BaseSortID = 36,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_14036_MonsterName|孩子王",
    Desc = "MonsterConfig_14036_Desc|身经百战的孩子王。手里的酒瓶会造成伤口。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      4450,
      4123,
      4732
    },
    CycleSkillList1 = {
      4450,
      4123,
      4732,
      4450
    },
    AnimationID = 15717,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0101_CT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.63,
    MonsterProportion = 0.5
  },
  [80957] = {
    ID = 80957,
    CnID = "怪物@街头小孩C特化",
    BaseSortID = 37,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_80957_MonsterName|孩子王",
    Desc = "MonsterConfig_80957_Desc|身经百战的孩子王。手里的酒瓶会造成伤口。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      4123,
      4732,
      4450
    },
    CycleSkillList1 = {
      4123,
      4732,
      4450
    },
    AnimationID = 15717,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0101_CT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.63,
    MonsterProportion = 0.5
  },
  [36869] = {
    ID = 36869,
    CnID = "怪物@街头小孩C奥瑞塔支线",
    BaseSortID = 38,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_36869_MonsterName|「维特」",
    Desc = "MonsterConfig_36869_Desc|曾是一个多愁善感的小孩，但这并不妨碍他成为奥瑞塔的朋友。爬树下海，他们无所不能。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      4450,
      4123,
      4732
    },
    CycleSkillList1 = {
      4450,
      4123,
      4732,
      4450
    },
    AnimationID = 15717,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0101_CT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.63,
    MonsterProportion = 0.5
  },
  [14069] = {
    ID = 14069,
    CnID = "怪物@斯芬克斯",
    BaseSortID = 39,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90645,
      84291
    },
    MonsterName = "MonsterConfig_14069_MonsterName|库姆",
    Desc = "MonsterConfig_14069_Desc|体型巨大的类犬怪物……为何会留下人类的啃咬痕迹呢？",
    ExistState = {3541},
    StateLayers = 1,
    InitSkillList = {
      3978,
      4105,
      4188,
      4105
    },
    CycleSkillList1 = {
      3978,
      4105,
      4188
    },
    AnimationID = 15746,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0303.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.1,
    MonsterProportion = 1
  },
  [14114] = {
    ID = 14114,
    CnID = "怪物@斯芬克斯低数值",
    BaseSortID = 40,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90645,
      84291
    },
    MonsterName = "MonsterConfig_14114_MonsterName|库姆",
    Desc = "MonsterConfig_14114_Desc|体型巨大的类犬怪物……为何会留下人类的啃咬痕迹呢？",
    InitSkillList = {
      4242,
      4756,
      4507,
      4105
    },
    CycleSkillList1 = {
      4242,
      4756,
      4507
    },
    AnimationID = 15746,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0303.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.75,
    MonsterProportion = 1
  },
  [14054] = {
    ID = 14054,
    CnID = "怪物@斯芬克斯精英",
    BaseSortID = 41,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90645,
      84291
    },
    MonsterName = "MonsterConfig_14054_MonsterName|库姆",
    Desc = "MonsterConfig_14054_Desc|体型巨大的类犬怪物……为何会留下人类的啃咬痕迹呢？",
    InitSkillList = {
      4274,
      4396,
      4483
    },
    CycleSkillList1 = {
      4274,
      4396,
      4483
    },
    AnimationID = 15746,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0303.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.75,
    MonsterProportion = 1
  },
  [14005] = {
    ID = 14005,
    CnID = "怪物@斯芬克斯逃跑版",
    BaseSortID = 42,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90645,
      84291
    },
    MonsterName = "MonsterConfig_14005_MonsterName|库姆",
    Desc = "MonsterConfig_14005_Desc|体型巨大的类犬怪物……为何会留下人类的啃咬痕迹呢？",
    ExistState = {21843},
    StateLayers = 1,
    InitSkillList = {
      3978,
      4105,
      21837,
      4105
    },
    CycleSkillList1 = {
      3978,
      4105,
      21837
    },
    AnimationID = 15653,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0303.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.1,
    MonsterProportion = 1
  },
  [13969] = {
    ID = 13969,
    CnID = "怪物@蜡像男",
    BaseSortID = 43,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84280,
      90645
    },
    MonsterName = "MonsterConfig_13969_MonsterName|蜡像绅士",
    Desc = "MonsterConfig_13969_Desc|垂头丧气的新派绅士，厌恶一切柔软的东西，包括他自己。",
    ExistState = {80445, 22074},
    StateLayers = "1,1",
    InitSkillList = {4704},
    CycleSkillList1 = {
      4543,
      4157,
      4103,
      4157
    },
    AnimationID = 15630,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0202.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 2,
    MonsterProportion = 0.5
  },
  [13958] = {
    ID = 13958,
    CnID = "怪物@蜡像男BOSS",
    BaseSortID = 44,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90645,
      84280
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_13958_MonsterName|「劳伦斯先生」",
    Desc = "MonsterConfig_13958_Desc|他早已被繁重的任务压弯了背脊。工作、工作、工作——这就是他现在的生活！",
    ExistState = {80445},
    StateLayers = 1,
    InitSkillList = {4634},
    CycleSkillList1 = {
      3992,
      4634,
      4209,
      4634
    },
    AnimationID = 15695,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0202_BOSSSIZE.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.49,
    MonsterProportion = 0.75
  },
  [14056] = {
    ID = 14056,
    CnID = "怪物@蜡像男精英",
    BaseSortID = 45,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90645,
      84280
    },
    MonsterName = "MonsterConfig_14056_MonsterName|高礼帽",
    Desc = "MonsterConfig_14056_Desc|总是弯着腰的沉默绅士，只在需要时为女伴献上溢美之词。",
    ExistState = {80445},
    StateLayers = 1,
    InitSkillList = {4495},
    CycleSkillList1 = {
      4445,
      4495,
      4346,
      4495
    },
    AnimationID = 15630,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0202.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 4.2,
    MonsterProportion = 0.75
  },
  [53764] = {
    ID = 53764,
    CnID = "怪物@蜡像男BOSS小",
    BaseSortID = 46,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90645,
      84280
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_53764_MonsterName|高礼帽",
    Desc = "MonsterConfig_53764_Desc|总是弯着腰的沉默绅士，只在需要时为女伴献上溢美之词。",
    ExistState = {80445},
    StateLayers = 1,
    InitSkillList = {4495},
    CycleSkillList1 = {
      4445,
      4495,
      4346,
      4495
    },
    AnimationID = 15630,
    MonsterClass = "Boss",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0202.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.49,
    MonsterProportion = 0.5
  },
  [13985] = {
    ID = 13985,
    CnID = "怪物@蜡像女",
    BaseSortID = 47,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84280,
      90645
    },
    MonsterName = "MonsterConfig_13985_MonsterName|蜡像淑女",
    Desc = "MonsterConfig_13985_Desc|恪守礼仪的老派淑女，即使成为蜡像也不会错过每日下午茶。",
    ExistState = {80445, 22074},
    StateLayers = "1,1",
    InitSkillList = {4110},
    CycleSkillList1 = {
      4563,
      4127,
      4151,
      4127,
      4151,
      4127
    },
    AnimationID = 15654,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0203.png",
    MonsterHpPercent = 1.2,
    MonsterAtkPercent = 0.8,
    MonsterDefPercent = 0.63,
    MonsterProportion = 0.5
  },
  [14047] = {
    ID = 14047,
    CnID = "怪物@蜡像女BOSS",
    BaseSortID = 48,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90645,
      84280
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_14047_MonsterName|「查泰德夫人」",
    Desc = "MonsterConfig_14047_Desc|红酒、甜品、美好的恋爱都已离她远去。站在你面前的，是一位充满怨念的失意者。",
    ExistState = {80445},
    StateLayers = 1,
    InitSkillList = {4435},
    CycleSkillList1 = {
      4542,
      4435,
      4762,
      4435
    },
    AnimationID = 15660,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0203_BOSSSIZE.png",
    MonsterHpPercent = 1.2,
    MonsterAtkPercent = 0.8,
    MonsterDefPercent = 2.31,
    MonsterProportion = 0.75
  },
  [13963] = {
    ID = 13963,
    CnID = "怪物@蜡像女精英",
    BaseSortID = 49,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90645,
      84280
    },
    MonsterName = "MonsterConfig_13963_MonsterName|大裙摆",
    Desc = "MonsterConfig_13963_Desc|身着过气礼装的傲慢淑女，千万别给她看最新款的穿搭杂志。",
    ExistState = {80445},
    StateLayers = 1,
    InitSkillList = {4712},
    CycleSkillList1 = {
      4685,
      4712,
      4149,
      4712
    },
    AnimationID = 15654,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0203.png",
    MonsterHpPercent = 1.2,
    MonsterAtkPercent = 0.8,
    MonsterDefPercent = 3.08,
    MonsterProportion = 0.75
  },
  [53763] = {
    ID = 53763,
    CnID = "怪物@蜡像女BOSS小",
    BaseSortID = 50,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90645,
      84280
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_53763_MonsterName|大裙摆",
    Desc = "MonsterConfig_53763_Desc|身着过气礼装的傲慢淑女，千万别给她看最新款的穿搭杂志。",
    ExistState = {80445},
    StateLayers = 1,
    InitSkillList = {4712},
    CycleSkillList1 = {
      4685,
      4712,
      4149,
      4712
    },
    AnimationID = 15654,
    MonsterClass = "Boss",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0203.png",
    MonsterHpPercent = 1.2,
    MonsterAtkPercent = 0.8,
    MonsterDefPercent = 2.31,
    MonsterProportion = 0.5
  },
  [14115] = {
    ID = 14115,
    CnID = "怪物@蜡像犬A",
    BaseSortID = 51,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84291,
      84280
    },
    MonsterName = "MonsterConfig_14115_MonsterName|蜡像野猫",
    Desc = "MonsterConfig_14115_Desc|它曾像风一样自由。",
    ExistState = {80445, 22074},
    StateLayers = "1,1",
    InitSkillList = {
      4656,
      4024,
      4598,
      4656
    },
    CycleSkillList1 = {
      4024,
      4598,
      4656
    },
    AnimationID = 15628,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0201.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.5,
    MonsterProportion = 0.35
  },
  [14113] = {
    ID = 14113,
    CnID = "怪物@蜡像犬B",
    BaseSortID = 52,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84291,
      84280
    },
    MonsterName = "MonsterConfig_14113_MonsterName|蜡像家猫",
    Desc = "MonsterConfig_14113_Desc|如果可以的话，它更愿意被称作「小甜饼」。",
    ExistState = {80445, 22074},
    StateLayers = "1,1",
    InitSkillList = {
      4024,
      4656,
      4598
    },
    CycleSkillList1 = {
      4024,
      4656,
      4598,
      4024
    },
    AnimationID = 15628,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0201.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.5,
    MonsterProportion = 0.35
  },
  [81053] = {
    ID = 81053,
    CnID = "怪物@蜡像犬C",
    BaseSortID = 53,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84291,
      84280
    },
    MonsterName = "MonsterConfig_81053_MonsterName|蜡像@2猫",
    Desc = "MonsterConfig_81053_Desc|它比犬科生物还要凶猛。",
    ExistState = {80445, 22074},
    StateLayers = "1,1",
    InitSkillList = {
      4598,
      4024,
      4656
    },
    CycleSkillList1 = {
      4598,
      4024,
      4656
    },
    AnimationID = 15628,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0201.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.5,
    MonsterProportion = 0.35
  },
  [13977] = {
    ID = 13977,
    CnID = "怪物@蜡像犬甜蜜恶鬼召唤",
    BaseSortID = 54,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84291,
      84280
    },
    MonsterName = "MonsterConfig_13977_MonsterName|第▼▼号奴隶",
    Desc = "MonsterConfig_13977_Desc|潘狄娅钟爱的奴隶猫之一。她的奴隶不分种族与信仰，只有一个标准：足够可爱。",
    ExistState = {3638, 22074},
    StateLayers = "6,1",
    InitSkillList = {
      4656,
      4024,
      4598,
      4656
    },
    CycleSkillList1 = {
      4024,
      4598,
      4656
    },
    AnimationID = 15628,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0201.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.2,
    MonsterDefPercent = 0.5,
    MonsterProportion = 0.3
  },
  [14052] = {
    ID = 14052,
    CnID = "怪物@怪物雷娅",
    BaseSortID = 55,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      84303
    },
    MonsterName = "MonsterConfig_14052_MonsterName|「渴血患者」",
    Desc = "MonsterConfig_14052_Desc|隐匿在角落的苍白少女，似乎对鲜血情有独钟……？",
    InitSkillList = {3958, 4117},
    CycleSkillList1 = {
      4117,
      4073,
      4097
    },
    AnimationID = 15745,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B08_AF.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 3.2,
    MonsterProportion = 1
  },
  [13959] = {
    ID = 13959,
    CnID = "怪物@莉莉",
    BaseSortID = 56,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    MonsterName = "MonsterConfig_13959_MonsterName|莉莉",
    Desc = "MonsterConfig_13959_Desc|因怪异的低语声而陷入疯狂的少女莉莉。",
    ExistState = {
      3289,
      2921,
      21901
    },
    StateLayers = "CmdCaster.max_hp*0.35,1,1",
    InitSkillList = {
      4468,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051
    },
    CycleSkillList1 = {
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051
    },
    CycleSkillList2 = {
      4590,
      4590,
      4098
    },
    AnimationID = 15657,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C10_AF.png",
    MonsterHpPercent = 1.3,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 3.48,
    MonsterProportion = 1
  },
  [22037] = {
    ID = 22037,
    CnID = "怪物@莉莉2",
    BaseSortID = 57,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    MonsterName = "MonsterConfig_22037_MonsterName|莉莉",
    Desc = "MonsterConfig_22037_Desc|因怪异的低语声而陷入疯狂的少女莉莉。",
    ExistState = {
      3289,
      2921,
      22036
    },
    StateLayers = "CmdCaster.max_hp*0.35,1,1",
    InitSkillList = {
      4468,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051
    },
    CycleSkillList1 = {
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051
    },
    CycleSkillList2 = {
      4590,
      4590,
      4098
    },
    AnimationID = 15657,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C10_AF.png",
    MonsterHpPercent = 1.3,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 3.48,
    MonsterProportion = 1
  },
  [14041] = {
    ID = 14041,
    CnID = "怪物@六翼塔薇",
    BaseSortID = 58,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_14041_MonsterName|「塔薇」",
    Desc = "MonsterConfig_14041_Desc|自弥萨格黑池中涌现出的银色六翼怪物。有种熟悉的感觉。",
    InitSkillList = {
      4268,
      4391,
      4253,
      4217,
      4675,
      3982,
      3984
    },
    CycleSkillList1 = {
      4268,
      4391,
      4253,
      4217,
      4675,
      3982,
      3984
    },
    AnimationID = 15687,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0003.png",
    MonsterHpPercent = 2.02,
    MonsterAtkPercent = 0.13,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [24742] = {
    ID = 24742,
    CnID = "怪物@六翼塔薇B",
    BaseSortID = 59,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_24742_MonsterName|「塔薇」",
    Desc = "MonsterConfig_24742_Desc|自弥萨格黑池中涌现出的银色六翼怪物。有种熟悉的感觉。",
    ExistState = {24720},
    InitSkillList = {
      4217,
      25183,
      25182,
      25184
    },
    CycleSkillList1 = {
      4217,
      25183,
      25182,
      25184
    },
    CycleSkillList2 = {
      24638,
      24636,
      24634,
      24635
    },
    AnimationID = 15687,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0003.png",
    MonsterHpPercent = 0.27,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.38,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [60102] = {
    ID = 60102,
    CnID = "怪物@六翼塔薇完全体",
    BaseSortID = 60,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_60102_MonsterName|「塔薇」",
    Desc = "MonsterConfig_60102_Desc|智之质体的代行者。知识权柄的拥有者。弥萨格的指引者。令人恐惧的敌人。",
    ExistState = {60298},
    InitSkillList = {
      4217,
      25183,
      25182,
      25184
    },
    CycleSkillList1 = {
      4217,
      25183,
      25182,
      25184
    },
    CycleSkillList2 = {
      24638,
      60286,
      60288,
      60287
    },
    AnimationID = 15687,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0003.png",
    MonsterHpPercent = 0.27,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.38,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [13986] = {
    ID = 13986,
    CnID = "怪物@罗杰斯蜡像小人BOSS",
    BaseSortID = 61,
    BattleTag = "Boss",
    MonsterTag = {84277, 84280},
    MonsterName = "MonsterConfig_13986_MonsterName|「以眼还眼」",
    Desc = "MonsterConfig_13986_Desc|群聚在地下的蜡像弃儿。时刻准备着，为罗杰斯大人的艺术献出一切！",
    ExistState = {
      80445,
      3776,
      2921
    },
    StateLayers = "1,1,1",
    InitSkillList = {4534},
    CycleSkillList1 = {
      4488,
      4099,
      4286,
      3953
    },
    AnimationID = 15675,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0204_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 3.38,
    MonsterProportion = 0.9
  },
  [13960] = {
    ID = 13960,
    CnID = "怪物@罗杰斯蜡像小人精英",
    BaseSortID = 62,
    BattleTag = "Elite",
    MonsterTag = {90641, 84280},
    MonsterName = "MonsterConfig_13960_MonsterName|「替代品」",
    Desc = "MonsterConfig_13960_Desc|小乔治的无数个前身之一。再悉心的保存也经不住长期磨损。",
    ExistState = {
      80445,
      3776,
      2921
    },
    StateLayers = "1,1,1",
    InitSkillList = {4484},
    CycleSkillList1 = {
      4757,
      4141,
      4692,
      4839
    },
    AnimationID = 15658,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0204.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.82,
    MonsterProportion = 0.9
  },
  [14109] = {
    ID = 14109,
    CnID = "怪物@罗杰斯替身蜡像小人BOSS",
    BaseSortID = 63,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84280},
    MonsterName = "MonsterConfig_14109_MonsterName|「头重脚轻」",
    Desc = "MonsterConfig_14109_Desc|说实话，无视物理定律的感觉还不赖。自从丢掉身子，它便获得了前所未有的宁静。",
    ExistState = {80445},
    StateLayers = 1,
    InitSkillList = {4028},
    CycleSkillList1 = {4028},
    AnimationID = 15702,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0206_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [14048] = {
    ID = 14048,
    CnID = "怪物@罗杰斯替身蜡像小人",
    BaseSortID = 64,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84280},
    MonsterName = "MonsterConfig_14048_MonsterName|「被遗忘的」",
    Desc = "MonsterConfig_14048_Desc|就让它在角落独自腐烂吧，别烦它。",
    ExistState = {80445},
    StateLayers = 1,
    InitSkillList = {4028},
    CycleSkillList1 = {4028},
    AnimationID = 15658,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0206.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [14105] = {
    ID = 14105,
    CnID = "怪物@罗杰斯召唤蜡像小人",
    BaseSortID = 65,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84280},
    MonsterName = "MonsterConfig_14105_MonsterName|「被损毁的」",
    Desc = "MonsterConfig_14105_Desc|它不介意你在它的心上再插一刀，反正它早就没有心了。",
    ExistState = {80445},
    StateLayers = 1,
    InitSkillList = {
      4620,
      4395,
      4269
    },
    CycleSkillList1 = {
      4620,
      4395,
      4269
    },
    AnimationID = 15637,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0205.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [13996] = {
    ID = 13996,
    CnID = "怪物@鲸跃",
    BaseSortID = 66,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    MonsterName = "MonsterConfig_13996_MonsterName|萝坦",
    Desc = "MonsterConfig_13996_Desc|旅途无聊的萝坦，陷入癫狂的战斗欲望中。",
    ExistState = {3943, 21787},
    StateLayers = "1,1",
    InitSkillList = {
      4283,
      4432,
      4224
    },
    CycleSkillList1 = {
      4283,
      4432,
      4224
    },
    CycleSkillList2 = {
      4283,
      4432,
      4224,
      4283,
      4432,
      4224,
      4283,
      4432,
      4224,
      4283,
      4432,
      4224
    },
    AnimationID = 15719,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C04_AF.png",
    MonsterHpPercent = 0.5,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [14086] = {
    ID = 14086,
    CnID = "怪物@怪物睡莲",
    BaseSortID = 67,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    MonsterName = "MonsterConfig_14086_MonsterName|宁菲亚",
    Desc = "MonsterConfig_14086_Desc|她曾经是孤独的漂流落花，如今是拉伊精神疗养院的居民和屏障。",
    ExistState = {
      3494,
      3656,
      21972
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      4063,
      4118,
      4014,
      4003
    },
    CycleSkillList1 = {
      4118,
      4014,
      4003
    },
    CycleSkillList2 = {
      4192,
      4859,
      4003,
      4192,
      4859,
      4003,
      4192,
      4859,
      4003,
      4192,
      4859,
      4003,
      4192,
      4859,
      4003,
      4192,
      4859,
      4003
    },
    AnimationID = 15615,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C08_AF.png",
    MonsterHpPercent = 0.5,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.79,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [14049] = {
    ID = 14049,
    CnID = "怪物@脓疱A",
    BaseSortID = 68,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84283},
    MonsterName = "MonsterConfig_14049_MonsterName|脓疱",
    Desc = "MonsterConfig_14049_Desc|眼球状的黑色脓疱怪物。",
    ExistState = {22074, 89574},
    StateLayers = 1,
    InitSkillList = {4182},
    CycleSkillList1 = {
      4849,
      4792,
      4849,
      4849,
      4792,
      4849
    },
    AnimationID = 15620,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0301.png",
    MonsterHpPercent = 1.02,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 1.86,
    MonsterProportion = 0.5
  },
  [14050] = {
    ID = 14050,
    CnID = "怪物@脓疱B",
    BaseSortID = 69,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84283},
    MonsterName = "MonsterConfig_14050_MonsterName|脓疱",
    Desc = "MonsterConfig_14050_Desc|眼球状的黑色脓疱怪物。",
    ExistState = {22074, 89574},
    StateLayers = 1,
    InitSkillList = {4792, 4161},
    CycleSkillList1 = {
      4849,
      4792,
      4849,
      4849
    },
    AnimationID = 15620,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0301.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.02,
    MonsterDefPercent = 1.86,
    MonsterProportion = 0.5
  },
  [22308] = {
    ID = 22308,
    CnID = "怪物@脓疱A冰霜",
    BaseSortID = 70,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      84284
    },
    MonsterName = "MonsterConfig_22308_MonsterName|覆雪之芽",
    Desc = "MonsterConfig_22308_Desc|看起来有些眼熟的眼球状白色脓疱怪物，是不是被冻住了？",
    ExistState = {22074, 89574},
    StateLayers = 1,
    InitSkillList = {4182},
    CycleSkillList1 = {
      22306,
      4792,
      22306,
      22306,
      4792,
      22306
    },
    AnimationID = 22309,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0301_AT.png",
    MonsterHpPercent = 1.02,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 4.47,
    MonsterProportion = 0.5
  },
  [22307] = {
    ID = 22307,
    CnID = "怪物@脓疱B冰霜",
    BaseSortID = 71,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      84284
    },
    MonsterName = "MonsterConfig_22307_MonsterName|渴雪之芽",
    Desc = "MonsterConfig_22307_Desc|看起来有些眼熟的眼球状白色脓疱怪物，居然真的不怕冷啊！",
    ExistState = {22074, 89574},
    StateLayers = 1,
    InitSkillList = {22306, 4161},
    CycleSkillList1 = {
      4792,
      22306,
      4792,
      22306
    },
    AnimationID = 22309,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0301_AT.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.02,
    MonsterDefPercent = 4.47,
    MonsterProportion = 0.5
  },
  [14089] = {
    ID = 14089,
    CnID = "怪物@乔治蜡像小人",
    BaseSortID = 72,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84280},
    MonsterName = "MonsterConfig_14089_MonsterName|「都怪你」",
    Desc = "MonsterConfig_14089_Desc|它们伤心地哭啊，哭啊，哭啊……眼泪汇聚成黑色的河流。",
    ExistState = {80445, 22074},
    StateLayers = "1,1",
    InitSkillList = {4316, 4205},
    CycleSkillList1 = {4316, 4205},
    AnimationID = 15637,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0205.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.85
  },
  [14051] = {
    ID = 14051,
    CnID = "怪物@融蚀怪物大",
    BaseSortID = 73,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 84291},
    MonsterName = "MonsterConfig_14051_MonsterName|融蚀疯马",
    Desc = "MonsterConfig_14051_Desc|满身是融蚀创口的疯马。体型较大，生命力顽强，但融蚀创口也使其更容易受伤。",
    ExistState = {3524, 22074},
    StateLayers = "CmdCaster.def*0.5,1",
    InitSkillList = {
      4385,
      4797,
      4372,
      4047
    },
    CycleSkillList1 = {
      4385,
      4797,
      4372,
      4047
    },
    AnimationID = 15685,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0203.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = -2.55,
    MonsterProportion = 1
  },
  [13972] = {
    ID = 13972,
    CnID = "怪物@融蚀怪物大BOSS",
    BaseSortID = 74,
    BattleTag = "Boss",
    MonsterTag = {84277, 84291},
    MonsterName = "MonsterConfig_13972_MonsterName|「垂死嘶鸣」",
    Desc = "MonsterConfig_13972_Desc|满身是融蚀创口的疯马。体型较大，生命力顽强，但融蚀创口也使其更容易受伤。",
    ExistState = {
      3088,
      3661,
      21928
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      4386,
      4257,
      4788,
      4466
    },
    CycleSkillList1 = {
      4386,
      4257,
      4788,
      4466
    },
    AnimationID = 15784,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0203_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = -1.66,
    MonsterProportion = 1
  },
  [36868] = {
    ID = 36868,
    CnID = "怪物@融蚀怪物大BOSS奥瑞塔支线",
    BaseSortID = 75,
    BattleTag = "Boss",
    MonsterTag = {84277, 84291},
    MonsterName = "MonsterConfig_36868_MonsterName|「泼尼」",
    Desc = "MonsterConfig_36868_Desc|婆婆曾经答应奥瑞塔，等奥瑞塔长大，长大到能够着马背了，就带她一起去伦蒂尼恩旅行。",
    ExistState = {
      3088,
      3661,
      21928
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      4386,
      4257,
      4788,
      4466
    },
    CycleSkillList1 = {
      4386,
      4257,
      4788,
      4466
    },
    AnimationID = 15784,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0203_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = -1.66,
    MonsterProportion = 1
  },
  [14107] = {
    ID = 14107,
    CnID = "怪物@融蚀怪物大BOSS材料本",
    BaseSortID = 76,
    BattleTag = "Boss",
    MonsterTag = {84277, 84291},
    MonsterName = "MonsterConfig_14107_MonsterName|「垂死嘶鸣」",
    Desc = "MonsterConfig_14107_Desc|满身是融蚀创口的疯马。体型较大，生命力顽强，但融蚀创口也使其更容易受伤。",
    ExistState = {3088, 2801},
    InitSkillList = {
      4386,
      4257,
      4788,
      4466
    },
    CycleSkillList1 = {
      4386,
      4257,
      4788,
      4466
    },
    AnimationID = 15784,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0203_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = -16,
    MonsterProportion = 1
  },
  [13954] = {
    ID = 13954,
    CnID = "怪物@融蚀怪物大精英",
    BaseSortID = 77,
    BattleTag = "Elite",
    MonsterTag = {90641, 84291},
    MonsterName = "MonsterConfig_13954_MonsterName|创痛疯马",
    Desc = "MonsterConfig_13954_Desc|满身是融蚀创口的疯马。体型较大，生命力顽强，但融蚀创口也使其更容易受伤。",
    ExistState = {3524},
    StateLayers = "CmdCaster.def*0.5",
    InitSkillList = {
      4220,
      4219,
      4294,
      4204,
      4220,
      4219
    },
    CycleSkillList1 = {
      4220,
      4219,
      4294,
      4204,
      4220,
      4219
    },
    AnimationID = 15685,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0203.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = -1.23,
    MonsterProportion = 1
  },
  [13962] = {
    ID = 13962,
    CnID = "怪物@融蚀怪物中",
    BaseSortID = 78,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 84291},
    MonsterName = "MonsterConfig_13962_MonsterName|融蚀野犬",
    Desc = "MonsterConfig_13962_Desc|身上满是融蚀痕的流浪犬，它的攻击迅猛而连续。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {4738, 4227},
    CycleSkillList1 = {4738, 4227},
    AnimationID = 15762,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0202.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.75
  },
  [14078] = {
    ID = 14078,
    CnID = "怪物@融蚀怪物中BOSS材料本",
    BaseSortID = 79,
    BattleTag = "Boss",
    MonsterTag = {84277, 84291},
    MonsterName = "MonsterConfig_14078_MonsterName|吞噬之吠",
    Desc = "MonsterConfig_14078_Desc|因融蚀加深而变得狂躁的流浪犬，它的攻击迅猛而连续，让人难以招架。",
    InitSkillList = {
      4487,
      3962,
      4606,
      3962,
      4688
    },
    CycleSkillList1 = {
      4487,
      3962,
      4606,
      3962,
      4688,
      4487,
      3962,
      4606
    },
    AnimationID = 15724,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0202_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.26,
    MonsterProportion = 1
  },
  [13966] = {
    ID = 13966,
    CnID = "怪物@融蚀怪物中BOSS",
    BaseSortID = 80,
    BattleTag = "Boss",
    MonsterTag = {84277, 84291},
    MonsterName = "MonsterConfig_13966_MonsterName|吞噬之吠",
    Desc = "MonsterConfig_13966_Desc|因融蚀加深而变得狂躁的流浪犬，它的攻击迅猛而连续，让人难以招架。",
    InitSkillList = {
      4631,
      4022,
      4612,
      4022,
      4689
    },
    CycleSkillList1 = {
      4631,
      4022,
      4612,
      4022,
      4689,
      4631,
      4022,
      4612
    },
    AnimationID = 15724,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0202_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.26,
    MonsterProportion = 1
  },
  [127225] = {
    ID = 127225,
    CnID = "怪物@融蚀怪物中BOSS试玩缩放",
    BaseSortID = 81,
    BattleTag = "Boss",
    MonsterTag = {84277, 84291},
    MonsterName = "MonsterConfig_127225_MonsterName|吞噬之吠",
    Desc = "MonsterConfig_127225_Desc|因融蚀加深而变得狂躁的流浪犬，它的攻击迅猛而连续，让人难以招架。",
    InitSkillList = {
      4631,
      4022,
      4612,
      4022,
      4689
    },
    CycleSkillList1 = {
      4631,
      4022,
      4612,
      4022,
      4689,
      4631,
      4022,
      4612
    },
    AnimationID = 15724,
    MonsterClass = "Boss",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0202_BOSSSIZE.png",
    Scale = 0.8,
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.26,
    MonsterProportion = 1
  },
  [14110] = {
    ID = 14110,
    CnID = "怪物@融蚀怪物中精英",
    BaseSortID = 82,
    BattleTag = "Elite",
    MonsterTag = {90641, 84291},
    MonsterName = "MonsterConfig_14110_MonsterName|狂躁野犬",
    Desc = "MonsterConfig_14110_Desc|因为融蚀而变得狂躁的流浪犬，它的攻击迅猛而连续。",
    InitSkillList = {
      4498,
      4021,
      4498,
      4021,
      4806
    },
    CycleSkillList1 = {
      4498,
      4021,
      4498,
      4021,
      4806
    },
    AnimationID = 15762,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0202.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 0.27,
    MonsterProportion = 1
  },
  [36870] = {
    ID = 36870,
    CnID = "怪物@融蚀怪物中精英奥瑞塔支线",
    BaseSortID = 83,
    BattleTag = "Elite",
    MonsterTag = {90641, 84291},
    MonsterName = "MonsterConfig_36870_MonsterName|「白雪」",
    Desc = "MonsterConfig_36870_Desc|曾是奥瑞塔最好的朋友（之一），具体表现在它会在奥瑞塔靠近时撕心裂肺地哀嚎。",
    InitSkillList = {
      4498,
      4021,
      4498,
      4021,
      4806
    },
    CycleSkillList1 = {
      4498,
      4021,
      4498,
      4021,
      4806
    },
    AnimationID = 15762,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0202.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 0.27,
    MonsterProportion = 1
  },
  [13998] = {
    ID = 13998,
    CnID = "怪物@融蚀三角大",
    BaseSortID = 84,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 84293},
    MonsterName = "MonsterConfig_13998_MonsterName|复合型融蚀体",
    Desc = "MonsterConfig_13998_Desc|大量融蚀浆聚合成的异变体，生命较低时会分裂。",
    ExistState = {
      2558,
      22074,
      89575
    },
    StateLayers = "1,1",
    StateParams = "math.ceil(CmdCaster.max_hp*0.5)",
    InitSkillList = {
      4310,
      4559,
      4310,
      4504,
      22700,
      4559,
      4310,
      4504
    },
    CycleSkillList1 = {
      4310,
      4559,
      4310,
      4504,
      22700,
      4559,
      4310,
      4504
    },
    AnimationID = 15707,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0103.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 5.5,
    MonsterProportion = 1
  },
  [14106] = {
    ID = 14106,
    CnID = "怪物@融蚀三角大BOSS",
    BaseSortID = 85,
    BattleTag = "Boss",
    MonsterTag = {84277, 84293},
    MonsterName = "MonsterConfig_14106_MonsterName|「维度之孔」",
    Desc = "MonsterConfig_14106_Desc|大量融蚀浆聚合成的异变体，生命较低时会分裂。",
    ExistState = {2558, 89575},
    StateLayers = 1,
    StateParams = "math.ceil(CmdCaster.max_hp*0.5)",
    InitSkillList = {
      4310,
      4559,
      4310,
      4504,
      4004,
      4559,
      4310,
      4504
    },
    CycleSkillList1 = {
      4310,
      4559,
      4310,
      4504,
      4004,
      4559,
      4310,
      4504
    },
    AnimationID = 15741,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0103_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 5.5,
    MonsterProportion = 1
  },
  [14032] = {
    ID = 14032,
    CnID = "怪物@融蚀三角大BOSS材料",
    BaseSortID = 86,
    BattleTag = "Boss",
    MonsterTag = {84277, 84293},
    MonsterName = "MonsterConfig_14032_MonsterName|「维度之孔」",
    Desc = "MonsterConfig_14032_Desc|大量融蚀浆聚合成的异变体，生命较低时会分裂。",
    ExistState = {2779, 89575},
    StateLayers = 1,
    StateParams = "math.ceil(CmdCaster.max_hp*0.5)",
    InitSkillList = {
      4310,
      4559,
      4310,
      4504,
      4004,
      4559,
      4310,
      4504
    },
    CycleSkillList1 = {
      4310,
      4559,
      4310,
      4504,
      4004,
      4559,
      4310,
      4504
    },
    AnimationID = 15741,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0103_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 5.5,
    MonsterProportion = 1
  },
  [14074] = {
    ID = 14074,
    CnID = "怪物@融蚀三角大精英",
    BaseSortID = 87,
    BattleTag = "Elite",
    MonsterTag = {90641, 84293},
    MonsterName = "MonsterConfig_14074_MonsterName|超变融蚀体",
    Desc = "MonsterConfig_14074_Desc|大量融蚀浆聚合成的异变体，生命较低时会分裂。",
    ExistState = {2558, 89575},
    StateLayers = 1,
    StateParams = "math.ceil(CmdCaster.max_hp*0.5)",
    InitSkillList = {
      4310,
      4559,
      4310,
      4504,
      22700,
      4559,
      4310,
      4504
    },
    CycleSkillList1 = {
      4310,
      4559,
      4310,
      4504,
      22700,
      4559,
      4310,
      4504
    },
    AnimationID = 15707,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0103.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 5.5,
    MonsterProportion = 1
  },
  [22159] = {
    ID = 22159,
    CnID = "怪物@融蚀三角大海洋",
    BaseSortID = 88,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84293,
      90643
    },
    MonsterName = "MonsterConfig_22159_MonsterName|深海型复合异变体",
    Desc = "MonsterConfig_22159_Desc|受深海之力影响的复合型融蚀异变体。诃勒特专门提醒过不要给祂们取过于花哨的名字。",
    ExistState = {
      22157,
      22074,
      83816,
      89575
    },
    StateLayers = "1,1,1",
    StateParams = "math.ceil(CmdCaster.max_hp*0.5)",
    InitSkillList = {
      22155,
      22153,
      22152,
      22156
    },
    CycleSkillList1 = {
      22155,
      22153,
      22152,
      22156
    },
    AnimationID = 22205,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0103_CT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 5.5,
    MonsterProportion = 1
  },
  [22163] = {
    ID = 22163,
    CnID = "怪物@融蚀三角大精英海洋",
    BaseSortID = 89,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84293,
      90643
    },
    MonsterName = "MonsterConfig_22163_MonsterName|深海型超变异变体",
    Desc = "MonsterConfig_22163_Desc|受深海之力影响的超变型融蚀异变体。诃勒特专门提醒过不要给祂们取过于花哨的名字。",
    ExistState = {
      22157,
      22074,
      83816,
      89575
    },
    StateLayers = "1,1,1",
    StateParams = "math.ceil(CmdCaster.max_hp*0.5)",
    InitSkillList = {
      22155,
      22153,
      22162,
      22156
    },
    CycleSkillList1 = {
      22155,
      22153,
      22162,
      22156
    },
    AnimationID = 22205,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0103_CT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 5.5,
    MonsterProportion = 1
  },
  [22201] = {
    ID = 22201,
    CnID = "怪物@融蚀三角大BOSS海洋",
    BaseSortID = 90,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84293,
      90643
    },
    MonsterName = "MonsterConfig_22201_MonsterName|「海洋之星」",
    Desc = "MonsterConfig_22201_Desc|受深海之力影响的「维度之孔」，思虑再三，诃勒特还是决定给祂取一个华丽的名字。",
    ExistState = {
      22157,
      83816,
      89575
    },
    StateLayers = "1,1",
    StateParams = "math.ceil(CmdCaster.max_hp*0.5)",
    InitSkillList = {
      22198,
      22199,
      22198,
      22197,
      22196,
      22199,
      22198,
      22197
    },
    CycleSkillList1 = {
      22198,
      22199,
      22198,
      22197,
      22196,
      22199,
      22198,
      22197
    },
    AnimationID = 22206,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0103_CT_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 5.5,
    MonsterProportion = 1
  },
  [14016] = {
    ID = 14016,
    CnID = "怪物@融蚀三角大BOSS蜡像材料1",
    BaseSortID = 91,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84293,
      84280
    },
    MonsterName = "MonsterConfig_14016_MonsterName|无垢之孔",
    Desc = "MonsterConfig_14016_Desc|大量融蚀浆与蜡像的结合体，心地善良，不可直视。生命力很低的时候会分裂。",
    ExistState = {
      80445,
      2609,
      89575
    },
    StateLayers = "1,1",
    StateParams = "math.ceil(CmdCaster.max_hp*0.3)",
    InitSkillList = {
      4449,
      4358,
      4630,
      4803
    },
    CycleSkillList1 = {
      4449,
      4358,
      4630,
      4803
    },
    AnimationID = 15736,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0103_BT.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.93,
    MonsterProportion = 1
  },
  [14019] = {
    ID = 14019,
    CnID = "怪物@融蚀三角大BOSS蜡像材料2",
    BaseSortID = 92,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84293,
      84280
    },
    MonsterName = "MonsterConfig_14019_MonsterName|无垢之孔",
    Desc = "MonsterConfig_14019_Desc|大量融蚀浆与蜡像的结合体，心地善良，不可直视。生命力很低的时候会分裂。",
    ExistState = {
      80445,
      2611,
      89575
    },
    StateLayers = "1,1",
    StateParams = "math.ceil(CmdCaster.max_hp*0.5)",
    InitSkillList = {
      4449,
      4358,
      4630,
      4803
    },
    CycleSkillList1 = {
      4449,
      4358,
      4630,
      4803
    },
    AnimationID = 15736,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0103_BT.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.93,
    MonsterProportion = 1
  },
  [14018] = {
    ID = 14018,
    CnID = "怪物@融蚀三角大BOSS蜡像材料3",
    BaseSortID = 93,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84293,
      84280
    },
    MonsterName = "MonsterConfig_14018_MonsterName|无垢之孔",
    Desc = "MonsterConfig_14018_Desc|大量融蚀浆与蜡像的结合体，心地善良，不可直视。生命力很低的时候会分裂。",
    ExistState = {
      80445,
      2610,
      89575
    },
    StateLayers = "1,1",
    StateParams = "math.ceil(CmdCaster.max_hp*0.7)",
    InitSkillList = {
      4449,
      4358,
      4630,
      4803
    },
    CycleSkillList1 = {
      4449,
      4358,
      4630,
      4803
    },
    AnimationID = 15736,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0103_BT.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.93,
    MonsterProportion = 1
  },
  [14021] = {
    ID = 14021,
    CnID = "怪物@融蚀三角大BOSS蜡像材料4",
    BaseSortID = 94,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84293,
      84280
    },
    MonsterName = "MonsterConfig_14021_MonsterName|无垢之孔",
    Desc = "MonsterConfig_14021_Desc|大量融蚀浆与蜡像的结合体，心地善良，不可直视。生命力很低的时候会分裂。",
    ExistState = {
      80445,
      2606,
      89575
    },
    StateLayers = "1,1",
    StateParams = "math.ceil(CmdCaster.max_hp*0.9)",
    InitSkillList = {
      4449,
      4358,
      4630,
      4803
    },
    CycleSkillList1 = {
      4449,
      4358,
      4630,
      4803
    },
    AnimationID = 15736,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0103_BT.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.93,
    MonsterProportion = 1
  },
  [14020] = {
    ID = 14020,
    CnID = "怪物@融蚀三角大BOSS蜡像材料5",
    BaseSortID = 95,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84293,
      84280
    },
    MonsterName = "MonsterConfig_14020_MonsterName|无垢之孔",
    Desc = "MonsterConfig_14020_Desc|大量融蚀浆与蜡像的结合体，心地善良，不可直视。生命力很低的时候会分裂。",
    ExistState = {
      80445,
      2605,
      89575
    },
    StateLayers = "1,1",
    StateParams = "math.ceil(CmdCaster.max_hp*0.95)",
    InitSkillList = {
      4449,
      4358,
      4630,
      4803
    },
    CycleSkillList1 = {
      4449,
      4358,
      4630,
      4803
    },
    AnimationID = 15736,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0103_BT.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.93,
    MonsterProportion = 1
  },
  [14030] = {
    ID = 14030,
    CnID = "怪物@融蚀三角大BOSS蜡像",
    BaseSortID = 96,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84293,
      84280
    },
    MonsterName = "MonsterConfig_14030_MonsterName|无垢之孔",
    Desc = "MonsterConfig_14030_Desc|大量融蚀浆与蜡像的结合体，心地善良，不可直视。生命力很低的时候会分裂。",
    ExistState = {
      80445,
      3106,
      89575
    },
    StateLayers = "1,1",
    StateParams = "math.ceil(CmdCaster.max_hp*0.5)",
    InitSkillList = {
      4449,
      4358,
      4630,
      4803
    },
    CycleSkillList1 = {
      4449,
      4358,
      4630,
      4803
    },
    AnimationID = 15736,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0103_BT.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 4,
    MonsterProportion = 1
  },
  [14003] = {
    ID = 14003,
    CnID = "怪物@融蚀三角大精英蜡像",
    BaseSortID = 97,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84293,
      84280
    },
    MonsterName = "MonsterConfig_14003_MonsterName|先锋艺术",
    Desc = "MonsterConfig_14003_Desc|将蜡像与融蚀结合的艺术。曾在西岱博览会展出，因引起巨大恐慌而被撤回。",
    ExistState = {
      80445,
      3106,
      89575
    },
    StateLayers = "1,1",
    StateParams = "math.ceil(CmdCaster.max_hp*0.5)",
    InitSkillList = {
      4449,
      4358,
      4630,
      4803
    },
    CycleSkillList1 = {
      4449,
      4358,
      4630,
      4803
    },
    AnimationID = 15736,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0103_BT.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 4,
    MonsterProportion = 1
  },
  [13975] = {
    ID = 13975,
    CnID = "怪物@融蚀三角小A",
    BaseSortID = 98,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84293},
    MonsterName = "MonsterConfig_13975_MonsterName|协作型融蚀体",
    Desc = "MonsterConfig_13975_Desc|融蚀浆中诞生的小型怪物，威胁性较低。",
    ExistState = {22074, 89575},
    StateLayers = 1,
    InitSkillList = {
      4038,
      4124,
      4489,
      4124
    },
    CycleSkillList1 = {
      4038,
      4124,
      4489
    },
    AnimationID = 15629,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0101.png",
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.53,
    MonsterProportion = 0.25
  },
  [13974] = {
    ID = 13974,
    CnID = "怪物@融蚀三角小B",
    BaseSortID = 99,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84293},
    MonsterName = "MonsterConfig_13974_MonsterName|协作型融蚀体",
    Desc = "MonsterConfig_13974_Desc|融蚀浆中诞生的小型怪物，威胁性较低。",
    ExistState = {22074, 89575},
    StateLayers = 1,
    InitSkillList = {
      4124,
      4489,
      4124,
      4038
    },
    CycleSkillList1 = {
      4124,
      4489,
      4124
    },
    AnimationID = 15629,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0101.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.25,
    MonsterProportion = 0.25
  },
  [14101] = {
    ID = 14101,
    CnID = "怪物@融蚀三角小A序章",
    BaseSortID = 100,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84293},
    MonsterName = "MonsterConfig_14101_MonsterName|协作型融蚀体",
    Desc = "MonsterConfig_14101_Desc|融蚀浆中诞生的小型怪物，威胁性较低。",
    ExistState = {22074, 89575},
    StateLayers = 1,
    InitSkillList = {4613, 4011},
    CycleSkillList1 = {4613, 4011},
    AnimationID = 15629,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0101.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.075,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [14040] = {
    ID = 14040,
    CnID = "怪物@融蚀三角小A蜡像",
    BaseSortID = 101,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84293,
      84280
    },
    MonsterName = "MonsterConfig_14040_MonsterName|简单习作Ⅰ",
    Desc = "MonsterConfig_14040_Desc|简单的蜡像习作。它们被扭曲成不可思议的形状，却毫无怨言。",
    ExistState = {
      80445,
      22074,
      89575
    },
    StateLayers = "1,1",
    InitSkillList = {
      3955,
      3993,
      4710,
      3993
    },
    CycleSkillList1 = {
      3955,
      3993,
      4710
    },
    AnimationID = 15748,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0101_BT.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.34,
    MonsterProportion = 0.25
  },
  [14080] = {
    ID = 14080,
    CnID = "怪物@融蚀三角小B蜡像",
    BaseSortID = 102,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84293,
      84280
    },
    MonsterName = "MonsterConfig_14080_MonsterName|简单习作Ⅱ",
    Desc = "MonsterConfig_14080_Desc|简单的蜡像习作。它们被扭曲成不可思议的形状，却毫无怨言。",
    ExistState = {
      80445,
      22074,
      89575
    },
    StateLayers = "1,1",
    InitSkillList = {
      4710,
      3993,
      3955,
      3993
    },
    CycleSkillList1 = {
      4710,
      3993,
      3955
    },
    AnimationID = 15748,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0101_BT.png",
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.48,
    MonsterProportion = 0.25
  },
  [14094] = {
    ID = 14094,
    CnID = "怪物@融蚀三角中A",
    BaseSortID = 103,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84293},
    MonsterName = "MonsterConfig_14094_MonsterName|干涉型融蚀体",
    Desc = "MonsterConfig_14094_Desc|融蚀浆中诞生的中型怪物，攻击时会对敌人的心智进行干扰。",
    ExistState = {22074, 89575},
    StateLayers = 1,
    InitSkillList = {4189, 4131},
    CycleSkillList1 = {4189, 4131},
    AnimationID = 15614,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0102.png",
    MonsterHpPercent = 0.98,
    MonsterAtkPercent = 1.02,
    MonsterDefPercent = 2.53,
    MonsterProportion = 0.5
  },
  [14095] = {
    ID = 14095,
    CnID = "怪物@融蚀三角中B",
    BaseSortID = 104,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84293},
    MonsterName = "MonsterConfig_14095_MonsterName|干涉型融蚀体",
    Desc = "MonsterConfig_14095_Desc|融蚀浆中诞生的中型怪物，攻击时会对敌人的心智进行干扰。",
    ExistState = {22074, 89575},
    StateLayers = 1,
    InitSkillList = {4131, 4189},
    CycleSkillList1 = {4131, 4189},
    AnimationID = 15614,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0102.png",
    MonsterHpPercent = 1.02,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 1.78,
    MonsterProportion = 0.5
  },
  [34678] = {
    ID = 34678,
    CnID = "怪物@融蚀三角中A海洋",
    BaseSortID = 105,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84293,
      90643
    },
    MonsterName = "MonsterConfig_34678_MonsterName|「洋流」",
    Desc = "MonsterConfig_34678_Desc|受深海之力影响的干涉型融蚀体，有着不逊于热带珊瑚的美丽。",
    ExistState = {
      22074,
      83816,
      89575
    },
    StateLayers = "1,1",
    InitSkillList = {34677, 34675},
    CycleSkillList1 = {
      34677,
      34675,
      34677,
      34675,
      34677
    },
    AnimationID = 24171,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0102_CT.png",
    MonsterHpPercent = 0.98,
    MonsterAtkPercent = 1.02,
    MonsterDefPercent = 2.53,
    MonsterProportion = 0.5
  },
  [34681] = {
    ID = 34681,
    CnID = "怪物@融蚀三角中B海洋",
    BaseSortID = 106,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84293,
      90643
    },
    MonsterName = "MonsterConfig_34681_MonsterName|「潮汐」",
    Desc = "MonsterConfig_34681_Desc|受深海之力影响的干涉型融蚀体，有着不逊于热带珊瑚的美丽。",
    ExistState = {
      22074,
      83816,
      89575
    },
    StateLayers = "1,1",
    InitSkillList = {34675, 34677},
    CycleSkillList1 = {
      34675,
      34677,
      34675,
      34675,
      34677
    },
    AnimationID = 24171,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0102_CT.png",
    MonsterHpPercent = 1.02,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 1.78,
    MonsterProportion = 0.5
  },
  [34680] = {
    ID = 34680,
    CnID = "怪物@融蚀三角中A维度",
    BaseSortID = 107,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84293,
      90644
    },
    MonsterName = "MonsterConfig_34680_MonsterName|「立体」",
    Desc = "MonsterConfig_34680_Desc|受维度之力影响的干涉型融蚀体，滴落的融蚀浆或许能扭曲光线。",
    ExistState = {22074, 89575},
    StateLayers = 1,
    InitSkillList = {34676, 34674},
    CycleSkillList1 = {
      34676,
      34674,
      34676,
      34674,
      34676
    },
    AnimationID = 24172,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0102_DT.png",
    MonsterHpPercent = 0.98,
    MonsterAtkPercent = 1.02,
    MonsterDefPercent = 2.53,
    MonsterProportion = 0.5
  },
  [34679] = {
    ID = 34679,
    CnID = "怪物@融蚀三角中B维度",
    BaseSortID = 108,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84293,
      90644
    },
    MonsterName = "MonsterConfig_34679_MonsterName|「几何体」",
    Desc = "MonsterConfig_34679_Desc|受维度之力影响的干涉型融蚀体，滴落的融蚀浆或许能扭曲光线。",
    ExistState = {22074, 89575},
    StateLayers = 1,
    InitSkillList = {34674, 34676},
    CycleSkillList1 = {
      34674,
      34676,
      34674,
      34674,
      34676
    },
    AnimationID = 24172,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0102_DT.png",
    MonsterHpPercent = 1.02,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 1.78,
    MonsterProportion = 0.5
  },
  [14079] = {
    ID = 14079,
    CnID = "怪物@融蚀三角中A蜡像",
    BaseSortID = 109,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84293,
      84280
    },
    MonsterName = "MonsterConfig_14079_MonsterName|实验习作Ⅰ",
    Desc = "MonsterConfig_14079_Desc|前沿的蜡像习作。充满了蜡像师对融蚀的无尽想象与探索。",
    ExistState = {
      80445,
      22074,
      89575
    },
    StateLayers = "1,1",
    InitSkillList = {
      4482,
      4070,
      4145,
      4070
    },
    CycleSkillList1 = {
      4482,
      4070,
      4145
    },
    AnimationID = 15710,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0102_BT.png",
    MonsterHpPercent = 0.98,
    MonsterAtkPercent = 1.02,
    MonsterDefPercent = 1.91,
    MonsterProportion = 0.5
  },
  [14038] = {
    ID = 14038,
    CnID = "怪物@融蚀三角中B蜡像",
    BaseSortID = 110,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84293,
      84280
    },
    MonsterName = "MonsterConfig_14038_MonsterName|实验习作Ⅱ",
    Desc = "MonsterConfig_14038_Desc|前沿的蜡像习作。充满了蜡像师对融蚀的无尽想象与探索。",
    ExistState = {
      80445,
      22074,
      89575
    },
    StateLayers = "1,1",
    InitSkillList = {
      4070,
      4145,
      4070,
      4482
    },
    CycleSkillList1 = {
      4070,
      4145,
      4070
    },
    AnimationID = 15710,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0102_BT.png",
    MonsterHpPercent = 0.98,
    MonsterAtkPercent = 1.02,
    MonsterDefPercent = 1.78,
    MonsterProportion = 0.5
  },
  [14075] = {
    ID = 14075,
    CnID = "怪物@融蚀怪物小A",
    BaseSortID = 111,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84291},
    MonsterName = "MonsterConfig_14075_MonsterName|融蚀鼠王",
    Desc = "MonsterConfig_14075_Desc|沾满融蚀的尾巴将它们粘合在一起，痛苦却无法分离。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      3950,
      3956,
      3986,
      4279
    },
    CycleSkillList1 = {
      3950,
      3956,
      3986
    },
    AnimationID = 15750,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0201.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0.13,
    MonsterProportion = 0.4
  },
  [14077] = {
    ID = 14077,
    CnID = "怪物@融蚀怪物小B",
    BaseSortID = 112,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84291},
    MonsterName = "MonsterConfig_14077_MonsterName|融蚀鼠王",
    Desc = "MonsterConfig_14077_Desc|沾满融蚀的尾巴将它们粘合在一起，痛苦却无法分离。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      3986,
      4279,
      3950,
      3956
    },
    CycleSkillList1 = {
      3986,
      4279,
      3950
    },
    AnimationID = 15750,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0201.png",
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.13,
    MonsterProportion = 0.4
  },
  [13993] = {
    ID = 13993,
    CnID = "怪物@融蚀怪物小C",
    BaseSortID = 113,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84291},
    MonsterName = "MonsterConfig_13993_MonsterName|融蚀鼠王",
    Desc = "MonsterConfig_13993_Desc|沾满融蚀的尾巴将它们粘合在一起，痛苦却无法分离。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      3956,
      3986,
      4279,
      3950
    },
    CycleSkillList1 = {
      3956,
      3986,
      4279,
      3950
    },
    AnimationID = 15750,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0201.png",
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.13,
    MonsterProportion = 0.4
  },
  [22221] = {
    ID = 22221,
    CnID = "怪物@融蚀怪物小A冰霜",
    BaseSortID = 114,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_22221_MonsterName|纯白鼠王",
    Desc = "MonsterConfig_22221_Desc|融蚀与寒冷，伦蒂尼恩深冬的两大死神。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      22218,
      3956,
      3986,
      4279
    },
    CycleSkillList1 = {
      22218,
      3956,
      3986
    },
    AnimationID = 22222,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0201_BT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0.64,
    MonsterProportion = 0.4
  },
  [22220] = {
    ID = 22220,
    CnID = "怪物@融蚀怪物小B冰霜",
    BaseSortID = 115,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_22220_MonsterName|纯白鼠王",
    Desc = "MonsterConfig_22220_Desc|融蚀与寒冷，伦蒂尼恩深冬的两大死神。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      3986,
      4279,
      22218,
      3956
    },
    CycleSkillList1 = {
      3986,
      4279,
      22218
    },
    AnimationID = 22222,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0201_BT.png",
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.64,
    MonsterProportion = 0.4
  },
  [22219] = {
    ID = 22219,
    CnID = "怪物@融蚀怪物小C冰霜",
    BaseSortID = 116,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_22219_MonsterName|纯白鼠王",
    Desc = "MonsterConfig_22219_Desc|融蚀与寒冷，伦蒂尼恩深冬的两大死神。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      3956,
      3986,
      4279,
      22218
    },
    CycleSkillList1 = {
      3956,
      3986,
      4279,
      22218
    },
    AnimationID = 22222,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0201_BT.png",
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.13,
    MonsterProportion = 0.4
  },
  [14103] = {
    ID = 14103,
    CnID = "怪物@融蚀怪物小2-15特殊关卡1",
    BaseSortID = 117,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84291},
    MonsterName = "MonsterConfig_14103_MonsterName|融蚀鼠王",
    Desc = "MonsterConfig_14103_Desc|沾满融蚀的尾巴将它们粘合在一起，痛苦却无法分离。",
    InitSkillList = {4015},
    CycleSkillList1 = {4015},
    AnimationID = 15750,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0201.png",
    MonsterHpPercent = 2,
    MonsterAtkPercent = 0.09,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [14104] = {
    ID = 14104,
    CnID = "怪物@融蚀怪物小2-15特殊关卡2",
    BaseSortID = 118,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84291},
    MonsterName = "MonsterConfig_14104_MonsterName|融蚀鼠王",
    Desc = "MonsterConfig_14104_Desc|沾满融蚀的尾巴将它们粘合在一起，痛苦却无法分离。",
    InitSkillList = {4015},
    CycleSkillList1 = {4015},
    AnimationID = 15750,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0201.png",
    MonsterHpPercent = 0.18,
    MonsterAtkPercent = 0.09,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [13989] = {
    ID = 13989,
    CnID = "怪物@修格斯BOSS",
    BaseSortID = 119,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84294,
      84303
    },
    MonsterName = "MonsterConfig_13989_MonsterName|「修▼▼」",
    Desc = "MonsterConfig_13989_Desc|曾经名为“希洛”的、失去理智的怪物。它的溶解会让你瞬间变得强大，但也会逐渐失去理智。",
    InitSkillList = {
      4258,
      4270,
      4497,
      4029,
      4258,
      4270,
      4497,
      4085,
      4258,
      4270,
      4497,
      4564
    },
    CycleSkillList1 = {
      4258,
      4270,
      4497,
      4029,
      4258,
      4270,
      4497,
      4085,
      4258,
      4270,
      4497,
      4564
    },
    AnimationID = 15706,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0003.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = -5.66,
    MonsterProportion = 1
  },
  [14067] = {
    ID = 14067,
    CnID = "怪物@莎拉BOSS",
    BaseSortID = 120,
    BattleTag = "Boss",
    MonsterTag = {84277, 90645},
    MonsterName = "MonsterConfig_14067_MonsterName|「院长」莎拉",
    Desc = "MonsterConfig_14067_Desc|对不起……都是我的错……",
    ExistState = {2921},
    StateLayers = "CmdCaster.atk*0.03",
    InitSkillList = {
      4711,
      4210,
      4725,
      4713
    },
    CycleSkillList1 = {
      4711,
      4210,
      4725,
      4713
    },
    AnimationID = 15783,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0102_CT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.67,
    MonsterProportion = 1
  },
  [14062] = {
    ID = 14062,
    CnID = "怪物@莎拉的执念",
    BaseSortID = 121,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_14062_MonsterName|「对不起」",
    Desc = "MonsterConfig_14062_Desc|她的理智被愧疚淹没。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {3991, 4380},
    CycleSkillList1 = {3991, 4380},
    AnimationID = 15759,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0101.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [14083] = {
    ID = 14083,
    CnID = "怪物@地狱追猎者",
    BaseSortID = 122,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_14083_MonsterName|「梭行维度之犬」",
    Desc = "MonsterConfig_14083_Desc|被称为“地狱犬”的怪物，能够穿梭于所有维度，追猎时空异常的旅者。",
    ExistState = {
      2703,
      3018,
      3694,
      3056
    },
    StateLayers = "1,CmdCaster.max_hp*0.25",
    StateParams = "CmdCaster.max_hp*1,CmdCaster.max_hp*0.25",
    InitSkillList = {
      4296,
      4208,
      4440,
      4622,
      4296,
      4208,
      4440,
      4622,
      4296,
      4208,
      4401,
      4622
    },
    CycleSkillList1 = {
      4296,
      4208,
      4440,
      4622
    },
    AnimationID = 15636,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0004.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.6,
    MonsterProportion = 1
  },
  [13950] = {
    ID = 13950,
    CnID = "怪物@提灯教众大",
    BaseSortID = 123,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 90646},
    MonsterName = "MonsterConfig_13950_MonsterName|提灯教牧",
    Desc = "MonsterConfig_13950_Desc|提灯教会内负责传递提灯旨意的教牧，指挥各堂教众在融蚀区域活动。",
    ExistState = {2921, 22074},
    StateLayers = "1,1",
    InitSkillList = {
      4071,
      4226,
      4683,
      4580,
      4071,
      4226,
      4683,
      4071
    },
    CycleSkillList1 = {
      4071,
      4226,
      4683,
      4174,
      4071,
      4226,
      4683,
      4071
    },
    AnimationID = 15774,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0403.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [14060] = {
    ID = 14060,
    CnID = "怪物@提灯教众大BOSS",
    BaseSortID = 124,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90646,
      90645
    },
    MonsterName = "MonsterConfig_14060_MonsterName|「灯芯侍者」",
    Desc = "MonsterConfig_14060_Desc|提灯教会内负责传递提灯旨意的教牧，指挥各堂教众在融蚀区域活动。",
    ExistState = {2921},
    StateLayers = 1,
    InitSkillList = {
      21949,
      21948,
      4383,
      4174,
      21949,
      21948,
      4383,
      21949
    },
    CycleSkillList1 = {
      21949,
      21948,
      4383,
      4174,
      21949,
      21948,
      4383,
      21949
    },
    AnimationID = 15725,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0403_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0.75,
    MonsterProportion = 1
  },
  [14010] = {
    ID = 14010,
    CnID = "怪物@提灯教众大BOSS材料本",
    BaseSortID = 125,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90646,
      90645
    },
    MonsterName = "MonsterConfig_14010_MonsterName|「灯芯侍者」",
    Desc = "MonsterConfig_14010_Desc|提灯教会内负责传递提灯旨意的教牧，指挥各堂教众在融蚀区域活动。",
    ExistState = {2921},
    StateLayers = 1,
    InitSkillList = {
      4071,
      4226,
      4383,
      4174,
      4071,
      4226,
      4383,
      4071
    },
    CycleSkillList1 = {
      4071,
      4226,
      4383,
      4174,
      4071,
      4226,
      4383,
      4071
    },
    AnimationID = 15725,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0403_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0.75,
    MonsterProportion = 1
  },
  [14043] = {
    ID = 14043,
    CnID = "怪物@提灯教众大精英",
    BaseSortID = 126,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90646,
      90645
    },
    MonsterName = "MonsterConfig_14043_MonsterName|核心教牧",
    Desc = "MonsterConfig_14043_Desc|提灯教会内负责传递提灯旨意的教牧，指挥各堂教众在融蚀区域活动。",
    ExistState = {2921},
    StateLayers = 1,
    InitSkillList = {
      4071,
      4226,
      4683,
      4174,
      4071,
      4226,
      4683,
      4071
    },
    CycleSkillList1 = {
      4071,
      4226,
      4683,
      4174,
      4071,
      4226,
      4683,
      4071
    },
    AnimationID = 15774,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0403.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [14007] = {
    ID = 14007,
    CnID = "怪物@提灯教众小A",
    BaseSortID = 127,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90646
    },
    MonsterName = "MonsterConfig_14007_MonsterName|提灯",
    Desc = "MonsterConfig_14007_Desc|提灯教会象征物的具象化。请勿追究其灵知的来源。",
    ExistState = {22074, 89574},
    StateLayers = 1,
    InitSkillList = {
      4733,
      4417,
      4459
    },
    CycleSkillList1 = {
      4733,
      4417,
      4459,
      4733
    },
    AnimationID = 15752,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0401.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.8,
    MonsterProportion = 0.35
  },
  [14111] = {
    ID = 14111,
    CnID = "怪物@提灯教众小B",
    BaseSortID = 128,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90646
    },
    MonsterName = "MonsterConfig_14111_MonsterName|提灯",
    Desc = "MonsterConfig_14111_Desc|提灯教会象征物的具象化。请勿追究其灵知的来源。",
    ExistState = {22074, 89574},
    StateLayers = 1,
    InitSkillList = {
      4459,
      4733,
      4417
    },
    CycleSkillList1 = {
      4459,
      4733,
      4417,
      4459
    },
    AnimationID = 15752,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0401.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.02,
    MonsterProportion = 0.35
  },
  [49239] = {
    ID = 49239,
    CnID = "怪物@提灯教众小亚兰A",
    BaseSortID = 129,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90646
    },
    MonsterName = "MonsterConfig_49239_MonsterName|亚兰行灯",
    Desc = "MonsterConfig_49239_Desc|提灯教会象征物的具象化。请勿追究其灵知的来源。",
    ExistState = {22074, 89574},
    StateLayers = 1,
    InitSkillList = {
      49280,
      49279,
      49282,
      49281
    },
    CycleSkillList1 = {
      49280,
      49279,
      49282,
      49281
    },
    AnimationID = 48877,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0705.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1.02,
    MonsterDefPercent = 1.39,
    MonsterProportion = 0.35
  },
  [49238] = {
    ID = 49238,
    CnID = "怪物@提灯教众小亚兰B",
    BaseSortID = 130,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90646
    },
    MonsterName = "MonsterConfig_49238_MonsterName|亚兰行灯",
    Desc = "MonsterConfig_49238_Desc|提灯教会象征物的具象化。请勿追究其灵知的来源。",
    ExistState = {22074, 89574},
    StateLayers = 1,
    InitSkillList = {
      49281,
      49279,
      49280,
      49282
    },
    CycleSkillList1 = {
      49281,
      49279,
      49280,
      49282
    },
    AnimationID = 48877,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0705.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 1.39,
    MonsterProportion = 0.35
  },
  [14059] = {
    ID = 14059,
    CnID = "怪物@提灯教众小B材料本",
    BaseSortID = 131,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90646
    },
    MonsterName = "MonsterConfig_14059_MonsterName|提灯",
    Desc = "MonsterConfig_14059_Desc|提灯教会象征物的具象化。请勿追究其灵知的来源。",
    ExistState = {22074, 89574},
    StateLayers = 1,
    InitSkillList = {
      4459,
      4064,
      4417
    },
    CycleSkillList1 = {
      4459,
      4064,
      4417
    },
    AnimationID = 15752,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0401.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.02,
    MonsterProportion = 0.35
  },
  [13970] = {
    ID = 13970,
    CnID = "怪物@提灯教众中",
    BaseSortID = 132,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 90646},
    MonsterName = "MonsterConfig_13970_MonsterName|提灯教众",
    Desc = "MonsterConfig_13970_Desc|提灯教会的一般教众，盲目地崇拜着教义宣传的毁灭。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      4865,
      4378,
      4226,
      4683
    },
    CycleSkillList1 = {
      4865,
      4378,
      4226
    },
    AnimationID = 15773,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0402.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.9
  },
  [14087] = {
    ID = 14087,
    CnID = "怪物@提灯教众中BOSS材料本",
    BaseSortID = 133,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90646,
      90645
    },
    MonsterName = "MonsterConfig_14087_MonsterName|「守灯人」",
    Desc = "MonsterConfig_14087_Desc|提灯教会的一般教众，盲目地崇拜着教义宣传的毁灭。",
    ExistState = {2862},
    StateLayers = 1,
    InitSkillList = {
      4071,
      4226,
      4383
    },
    CycleSkillList1 = {
      4071,
      4226,
      4383
    },
    AnimationID = 15647,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0402_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.78,
    MonsterProportion = 1
  },
  [13956] = {
    ID = 13956,
    CnID = "怪物@提灯教众中BOSS",
    BaseSortID = 134,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90646,
      90645
    },
    MonsterName = "MonsterConfig_13956_MonsterName|「守灯人」",
    Desc = "MonsterConfig_13956_Desc|提灯教会的一般教众，盲目地崇拜着教义宣传的毁灭。",
    InitSkillList = {
      4865,
      21939,
      21940,
      4683
    },
    CycleSkillList1 = {
      4865,
      21939,
      21940,
      4383
    },
    AnimationID = 15647,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0402_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.78,
    MonsterProportion = 1
  },
  [14022] = {
    ID = 14022,
    CnID = "怪物@提灯教众中精英",
    BaseSortID = 135,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90646,
      90645
    },
    MonsterName = "MonsterConfig_14022_MonsterName|虔心教众",
    Desc = "MonsterConfig_14022_Desc|提灯教会的一般教众，盲目地崇拜着教义宣传的毁灭。",
    InitSkillList = {
      4865,
      4378,
      4226,
      4683
    },
    CycleSkillList1 = {
      4865,
      4378,
      4226,
      4683
    },
    AnimationID = 15773,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0402.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [14002] = {
    ID = 14002,
    CnID = "怪物@甜蜜恶鬼",
    BaseSortID = 136,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      143654
    },
    MonsterName = "MonsterConfig_14002_MonsterName|「潘狄娅」",
    Desc = "MonsterConfig_14002_Desc|擅长调教的活泼少女。已经拥有102个奴隶，正在寻觅命中注定的下一位。",
    InitSkillList = {4444},
    CycleSkillList1 = {
      4181,
      4059,
      4690,
      4181
    },
    AnimationID = 15698,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C09_AF.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [14072] = {
    ID = 14072,
    CnID = "怪物@甜蜜恶鬼低数值",
    BaseSortID = 137,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      143654
    },
    MonsterName = "MonsterConfig_14072_MonsterName|「蜡像潘狄娅」",
    Desc = "MonsterConfig_14072_Desc|擅长调教的活泼少女。已经拥有102个奴隶，正在寻觅命中注定的下一位。",
    ExistState = {2894},
    StateLayers = "1,1",
    InitSkillList = {
      4080,
      4430,
      4690,
      4661
    },
    CycleSkillList1 = {
      4080,
      4430,
      4690,
      4661
    },
    AnimationID = 15698,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C09_AF.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [14093] = {
    ID = 14093,
    CnID = "怪物@维度碎片A",
    BaseSortID = 138,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90644
    },
    MonsterName = "MonsterConfig_14093_MonsterName|维度碎片",
    Desc = "MonsterConfig_14093_Desc|脆弱、游弋的维度碎片，当维度的罅隙被撕裂，它们便会四处飘荡。",
    ExistState = {22074, 89574},
    StateLayers = 1,
    InitSkillList = {
      4013,
      4726,
      4013,
      4726,
      4013,
      4726
    },
    CycleSkillList1 = {4013},
    AnimationID = 15682,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0401.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.08,
    MonsterProportion = 0.35
  },
  [14055] = {
    ID = 14055,
    CnID = "怪物@维度碎片B",
    BaseSortID = 139,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90644
    },
    MonsterName = "MonsterConfig_14055_MonsterName|维度碎片",
    Desc = "MonsterConfig_14055_Desc|脆弱、游弋的维度碎片，当维度的罅隙被撕裂，它们便会四处飘荡。",
    ExistState = {22074, 89574},
    StateLayers = 1,
    InitSkillList = {
      4451,
      4013,
      4451,
      4013,
      4451,
      4013
    },
    CycleSkillList1 = {4451},
    AnimationID = 15682,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0401.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.08,
    MonsterProportion = 0.35
  },
  [14027] = {
    ID = 14027,
    CnID = "怪物@破链者",
    BaseSortID = 140,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      84303
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_14027_MonsterName|希洛",
    Desc = "MonsterConfig_14027_Desc|迅捷如风的唤醒体杀手，自称希洛。她和莉莉之间似乎有什么微妙的联系……",
    ExistState = {3515, 21895},
    StateLayers = "1,1",
    InitSkillList = {
      4469,
      4441,
      3969
    },
    CycleSkillList1 = {
      4469,
      4441,
      3969
    },
    CycleSkillList2 = {
      4166,
      4441,
      3969
    },
    AnimationID = 15714,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B05_AF.png",
    MonsterHpPercent = 0.5,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [22057] = {
    ID = 22057,
    CnID = "怪物@破链者2",
    BaseSortID = 141,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      84303
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_22057_MonsterName|希洛",
    Desc = "MonsterConfig_22057_Desc|迅捷如风的唤醒体杀手，自称希洛。她和莉莉之间似乎有什么微妙的联系……",
    ExistState = {22055, 22054},
    StateLayers = "1,1",
    InitSkillList = {
      4469,
      4441,
      3969
    },
    CycleSkillList1 = {
      4469,
      4441,
      3969
    },
    CycleSkillList2 = {
      4166,
      4441,
      3969
    },
    AnimationID = 15714,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B05_AF.png",
    MonsterHpPercent = 0.5,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [13957] = {
    ID = 13957,
    CnID = "怪物@小型黑泥怪A",
    BaseSortID = 142,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_13957_MonsterName|融蚀人型",
    Desc = "MonsterConfig_13957_Desc|被融蚀浆蚀化的人类，形貌凄惨。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      4478,
      4586,
      4364
    },
    CycleSkillList1 = {
      4478,
      4586,
      4364,
      4478
    },
    AnimationID = 15751,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0001.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = -0.75,
    MonsterProportion = 0.4
  },
  [13984] = {
    ID = 13984,
    CnID = "怪物@小型黑泥怪B",
    BaseSortID = 143,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_13984_MonsterName|融蚀人型",
    Desc = "MonsterConfig_13984_Desc|被融蚀浆蚀化的人类，形貌凄惨。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      4364,
      4478,
      4586
    },
    CycleSkillList1 = {
      4364,
      4478,
      4586,
      4364
    },
    AnimationID = 15753,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0001.png",
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0.38,
    MonsterProportion = 0.4
  },
  [13978] = {
    ID = 13978,
    CnID = "怪物@邪恶医生A",
    BaseSortID = 144,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 90645},
    MonsterName = "MonsterConfig_13978_MonsterName|手术医生",
    Desc = "MonsterConfig_13978_Desc|医生的刀刃本应切除伤病，他们却用其带来疼痛。攻击力很高的个体。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      4632,
      4653,
      4868,
      4225
    },
    CycleSkillList1 = {
      4632,
      4653,
      4868,
      4225
    },
    AnimationID = 15649,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0103_AT.png",
    MonsterHpPercent = 0.8,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 0.5,
    MonsterProportion = 0.5
  },
  [14013] = {
    ID = 14013,
    CnID = "怪物@邪恶医生ABOSS",
    BaseSortID = 145,
    BattleTag = "Boss",
    MonsterTag = {84277, 90645},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_14013_MonsterName|「手术利刃」",
    Desc = "MonsterConfig_14013_Desc|躺下来，放轻松，医生将为你切除所有烦恼。攻击力很高的个体。",
    InitSkillList = {
      4616,
      4086,
      4338,
      4245
    },
    CycleSkillList1 = {
      4616,
      4086,
      4338,
      4245
    },
    AnimationID = 15680,
    MonsterClass = "Boss",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0103_AT_BOSSSIZE.png",
    MonsterHpPercent = 0.8,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [14000] = {
    ID = 14000,
    CnID = "怪物@邪恶医生ABOSS材料本",
    BaseSortID = 146,
    BattleTag = "Boss",
    MonsterTag = {84277, 90645},
    MonsterName = "MonsterConfig_14000_MonsterName|「手术利刃」",
    Desc = "MonsterConfig_14000_Desc|躺下来，放轻松，医生将为你切除所有烦恼。攻击力很高的个体。",
    ExistState = {3918, 3573},
    StateLayers = "1,1",
    InitSkillList = {
      4616,
      4086,
      4338,
      4245
    },
    CycleSkillList1 = {
      4616,
      4086,
      4338,
      4245
    },
    AnimationID = 15680,
    MonsterClass = "Boss",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0103_AT_BOSSSIZE.png",
    MonsterHpPercent = 0.8,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = -19,
    MonsterProportion = 0.5
  },
  [14096] = {
    ID = 14096,
    CnID = "怪物@邪恶医生A蜡像",
    BaseSortID = 147,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90645,
      84280
    },
    MonsterName = "MonsterConfig_14096_MonsterName|蜡像医生",
    Desc = "MonsterConfig_14096_Desc|如同手术刀一般精准、冷酷。攻击力很高的个体。",
    ExistState = {80445, 22074},
    StateLayers = "1,1",
    InitSkillList = {
      4633,
      4474,
      4461,
      4835
    },
    CycleSkillList1 = {
      4633,
      4474,
      4461,
      4835
    },
    AnimationID = 15632,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0103_CT.png",
    MonsterHpPercent = 0.8,
    MonsterAtkPercent = 1.2,
    MonsterDefPercent = 0.5,
    MonsterProportion = 0.5
  },
  [13979] = {
    ID = 13979,
    CnID = "怪物@邪恶医生B",
    BaseSortID = 148,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 90645},
    MonsterName = "MonsterConfig_13979_MonsterName|诊疗医生",
    Desc = "MonsterConfig_13979_Desc|他们的诊断即是你的死亡。会保护其他友方的个体。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {4313},
    CycleSkillList1 = {
      4207,
      4535,
      4535,
      4207,
      4535,
      4535
    },
    AnimationID = 15650,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0103_BT.png",
    MonsterHpPercent = 1.2,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 1,
    MonsterProportion = 0.5
  },
  [14008] = {
    ID = 14008,
    CnID = "怪物@邪恶医生BBOSS",
    BaseSortID = 149,
    BattleTag = "Boss",
    MonsterTag = {84277, 90645},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_14008_MonsterName|「镇痛剂」",
    Desc = "MonsterConfig_14008_Desc|深呼吸，数到十，疼痛很快会消失。会保护其他友方的个体。",
    InitSkillList = {3963},
    CycleSkillList1 = {4572, 4817},
    AnimationID = 15661,
    MonsterClass = "Boss",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0103_BT_BOSSSIZE.png",
    MonsterHpPercent = 1.2,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 2.67,
    MonsterProportion = 0.5
  },
  [13981] = {
    ID = 13981,
    CnID = "怪物@邪恶医生BBOSS材料本",
    BaseSortID = 150,
    BattleTag = "Boss",
    MonsterTag = {84277, 90645},
    MonsterName = "MonsterConfig_13981_MonsterName|「镇痛剂」",
    Desc = "MonsterConfig_13981_Desc|深呼吸，数到十，疼痛很快会消失。会保护其他友方的个体。",
    ExistState = {3918, 3573},
    StateLayers = "1,1",
    InitSkillList = {3963},
    CycleSkillList1 = {4572, 4817},
    AnimationID = 15661,
    MonsterClass = "Boss",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0103_BT_BOSSSIZE.png",
    MonsterHpPercent = 1.2,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = -19,
    MonsterProportion = 0.5
  },
  [14085] = {
    ID = 14085,
    CnID = "怪物@邪恶医生B蜡像",
    BaseSortID = 151,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90645,
      84280
    },
    MonsterName = "MonsterConfig_14085_MonsterName|蜡像护工",
    Desc = "MonsterConfig_14085_Desc|曾有56人在她的悉心照料下死亡。会保护其他友方个体。",
    ExistState = {80445, 22074},
    StateLayers = "1,1",
    InitSkillList = {4313},
    CycleSkillList1 = {
      4336,
      3980,
      3980,
      4336,
      3980,
      3980
    },
    AnimationID = 15627,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0103_DT.png",
    MonsterHpPercent = 1.2,
    MonsterAtkPercent = 0.8,
    MonsterDefPercent = 1,
    MonsterProportion = 0.5
  },
  [14068] = {
    ID = 14068,
    CnID = "怪物@新手大型黑泥怪序章",
    BaseSortID = 152,
    BattleTag = "Elite",
    MonsterTag = {90641, 84293},
    MonsterName = "MonsterConfig_14068_MonsterName|「前辈」玛丽",
    Desc = "MonsterConfig_14068_Desc|哀泣的黑色怪物表面浮现出似曾相识的脸……",
    ExistState = {3362, 3113},
    InitSkillList = {4846},
    CycleSkillList1 = {4409, 4742},
    AnimationID = 15623,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0002.png",
    MonsterHpPercent = 2.4,
    MonsterAtkPercent = 0.15,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [13953] = {
    ID = 13953,
    CnID = "怪物@新手鲸跃幻影序章",
    BaseSortID = 153,
    BattleTag = "Elite",
    MonsterTag = {90641, 84297},
    MonsterName = "MonsterConfig_13953_MonsterName|失控萝坦",
    Desc = "MonsterConfig_13953_Desc|被融蚀激发的萝坦，陷入癫狂的战斗欲望中。",
    ExistState = {3341},
    InitSkillList = {
      4693,
      4249,
      3954,
      4693
    },
    CycleSkillList1 = {
      4637,
      3954,
      4249
    },
    AnimationID = 15719,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C04_AF.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 0.06,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [13997] = {
    ID = 13997,
    CnID = "怪物@新手小型黑泥怪序章",
    BaseSortID = 154,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_13997_MonsterName|「艾米丽」",
    Desc = "MonsterConfig_13997_Desc|被融蚀浆蚀化的弥萨格学生，形貌凄惨。",
    ExistState = {3229, 3116},
    InitSkillList = {4523},
    CycleSkillList1 = {
      4260,
      4282,
      4032
    },
    AnimationID = 15677,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0001.png",
    MonsterHpPercent = 0.27,
    MonsterAtkPercent = 0.06,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [13951] = {
    ID = 13951,
    CnID = "怪物@新手小型黑泥怪序章2",
    BaseSortID = 155,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_13951_MonsterName|「海伦」",
    Desc = "MonsterConfig_13951_Desc|被融蚀浆蚀化的弥萨格学生，形貌凄惨。",
    ExistState = {3856, 3114},
    InitSkillList = {
      4032,
      4260,
      4282
    },
    CycleSkillList1 = {
      4032,
      4260,
      4282
    },
    AnimationID = 15785,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0001.png",
    MonsterHpPercent = 0.7,
    MonsterAtkPercent = 0.06,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [13968] = {
    ID = 13968,
    CnID = "怪物@艾继丝BOSS",
    BaseSortID = 156,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84294,
      84303
    },
    MonsterName = "MonsterConfig_13968_MonsterName|「▼阿▼▼亚」",
    Desc = "MonsterConfig_13968_Desc|女孩的啜泣隐没在哀嚎声中，她既是艾继丝，又不是艾继丝。请确保有足够的算力来应对其凝滞诅咒。",
    StateLayers = "CmdCaster.atk*0.05",
    InitSkillList = {
      4823,
      4531,
      4502,
      4531,
      4521
    },
    CycleSkillList1 = {
      4823,
      4531,
      4502,
      4531,
      4521
    },
    AnimationID = 15716,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0001.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 4.06,
    MonsterProportion = 1
  },
  [14001] = {
    ID = 14001,
    CnID = "怪物@布朗詹金BOSS",
    BaseSortID = 157,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90644
    },
    MonsterName = "MonsterConfig_14001_MonsterName|「窜行者」詹金",
    Desc = "MonsterConfig_14001_Desc|她神出鬼没，对东区的每一个街巷都了若指掌，她就是「窜行者」。",
    InitSkillList = {
      4016,
      4025,
      4539,
      4470
    },
    CycleSkillList1 = {
      4016,
      4025,
      4539,
      4470
    },
    AnimationID = 15763,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D07_AF.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 1,
    MonsterProportion = 1
  },
  [14099] = {
    ID = 14099,
    CnID = "怪物@中型维度生物",
    BaseSortID = 158,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90644,
      84283,
      84291
    },
    MonsterName = "MonsterConfig_14099_MonsterName|维度异兽",
    Desc = "MonsterConfig_14099_Desc|游离的维度碎片拼合而成的异兽，与祂的战利品和谐相处。",
    ExistState = {22074, 89574},
    StateLayers = 1,
    InitSkillList = {
      4773,
      4423,
      4841,
      4423
    },
    CycleSkillList1 = {
      4773,
      4423,
      4841,
      4423
    },
    AnimationID = 15668,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0402.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.85,
    MonsterProportion = 0.8
  },
  [50376] = {
    ID = 50376,
    CnID = "怪物@中型维度生物半减",
    BaseSortID = 159,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90644,
      84283,
      84291
    },
    MonsterName = "MonsterConfig_50376_MonsterName|维度异兽",
    Desc = "MonsterConfig_50376_Desc|游离的维度碎片拼合而成的异兽，与祂的战利品和谐相处。",
    ExistState = {22074, 89574},
    StateLayers = 1,
    InitSkillList = {
      4773,
      4423,
      4841,
      4423
    },
    CycleSkillList1 = {
      4773,
      4423,
      4841,
      4423
    },
    AnimationID = 15668,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0402.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 1.85,
    MonsterProportion = 0.8
  },
  [13961] = {
    ID = 13961,
    CnID = "怪物@中型维度生物BOSS",
    BaseSortID = 160,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84291,
      84283,
      90644
    },
    MonsterName = "MonsterConfig_13961_MonsterName|「嘉尔姆？」",
    Desc = "MonsterConfig_13961_Desc|游离的维度碎片拼合而成的异兽，与祂的战利品和谐相处。",
    ExistState = {2398, 89574},
    StateLayers = "CmdCaster.def*0.1",
    InitSkillList = {
      4199,
      4100,
      4416,
      4100
    },
    CycleSkillList1 = {
      4199,
      4100,
      4416,
      4100
    },
    AnimationID = 15755,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0402_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.21,
    MonsterProportion = 1
  },
  [14084] = {
    ID = 14084,
    CnID = "怪物@中型维度生物精英",
    BaseSortID = 161,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84291,
      84283,
      90644
    },
    MonsterName = "MonsterConfig_14084_MonsterName|维度猎手",
    Desc = "MonsterConfig_14084_Desc|游离的维度碎片拼合而成的异兽，与祂的战利品和谐相处。",
    ExistState = {2398, 89574},
    StateLayers = "CmdCaster.def*0.1",
    InitSkillList = {
      4605,
      4561,
      4326,
      4561
    },
    CycleSkillList1 = {
      4605,
      4561,
      4326,
      4561
    },
    AnimationID = 15668,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0402.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.05,
    MonsterProportion = 1
  },
  [13965] = {
    ID = 13965,
    CnID = "怪物@中型修格斯",
    BaseSortID = 162,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 84283},
    MonsterName = "MonsterConfig_13965_MonsterName|双生脓疱",
    Desc = "MonsterConfig_13965_Desc|双生的命运纠缠于一体，相互牵扯，相互裹挟，无处可逃。",
    ExistState = {22074, 89574},
    StateLayers = 1,
    InitSkillList = {
      4588,
      4368,
      4007,
      4589
    },
    CycleSkillList1 = {
      4588,
      4368,
      4007,
      4589
    },
    AnimationID = 15709,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0302.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2,
    MonsterProportion = 0.75
  },
  [14012] = {
    ID = 14012,
    CnID = "怪物@中型修格斯精英",
    BaseSortID = 163,
    BattleTag = "Elite",
    MonsterTag = {90641, 84283},
    MonsterName = "MonsterConfig_14012_MonsterName|反叛宿命之子",
    Desc = "MonsterConfig_14012_Desc|祂曾抗拒被奴役的命运。",
    ExistState = {89574},
    InitSkillList = {
      4588,
      4368,
      4007,
      4589
    },
    CycleSkillList1 = {
      4588,
      4368,
      4007,
      4589
    },
    AnimationID = 15709,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0302.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2,
    MonsterProportion = 1
  },
  [13971] = {
    ID = 13971,
    CnID = "怪物@中型修格斯BOSS",
    BaseSortID = 164,
    BattleTag = "Boss",
    MonsterTag = {84277, 84283},
    MonsterName = "MonsterConfig_13971_MonsterName|「斯特里戈伊之心？」",
    Desc = "MonsterConfig_13971_Desc|祂被认为拥有两颗共同搏动的心脏，但无人知晓刺穿其中一颗的结果。",
    ExistState = {89574},
    InitSkillList = {
      4588,
      4442,
      4007,
      4081
    },
    CycleSkillList1 = {
      4588,
      4442,
      4007,
      4081
    },
    AnimationID = 15777,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0302_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2,
    MonsterProportion = 1
  },
  [14009] = {
    ID = 14009,
    CnID = "怪物@脓疱爆炸",
    BaseSortID = 165,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84283},
    MonsterName = "MonsterConfig_14009_MonsterName|自爆脓疱",
    Desc = "MonsterConfig_14009_Desc|眼球状的黑色脓泡怪物，总感觉要爆裂开来。",
    ExistState = {22074, 89574},
    StateLayers = 1,
    InitSkillList = {4317},
    CycleSkillList1 = {4317},
    AnimationID = 15620,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0301.png",
    MonsterHpPercent = 1.02,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 1.86,
    MonsterProportion = 0.5
  },
  [20791] = {
    ID = 20791,
    CnID = "怪物@阿格里帕支线小型黑泥怪A",
    BaseSortID = 166,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_20791_MonsterName|「悲伤的夏洛特」",
    Desc = "MonsterConfig_20791_Desc|被融蚀浆蚀化的弥萨格学生，形貌凄惨。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      4478,
      4586,
      4364
    },
    CycleSkillList1 = {
      4478,
      4586,
      4364,
      4478
    },
    AnimationID = 15785,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0001.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = -0.75,
    MonsterProportion = 0.4
  },
  [20789] = {
    ID = 20789,
    CnID = "怪物@阿格里帕支线小型黑泥怪B",
    BaseSortID = 167,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_20789_MonsterName|「贪玩的夏洛特」",
    Desc = "MonsterConfig_20789_Desc|被融蚀浆蚀化的弥萨格学生，形貌凄惨。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      4364,
      4478,
      4586
    },
    CycleSkillList1 = {
      4364,
      4478,
      4586,
      4364
    },
    AnimationID = 15785,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0001.png",
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0.38,
    MonsterProportion = 0.4
  },
  [20790] = {
    ID = 20790,
    CnID = "怪物@阿格里帕支线小型黑泥怪C",
    BaseSortID = 168,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_20790_MonsterName|「无聊的夏洛特」",
    Desc = "MonsterConfig_20790_Desc|被融蚀浆蚀化的弥萨格学生，形貌凄惨。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      4478,
      4586,
      4364
    },
    CycleSkillList1 = {
      4478,
      4586,
      4364,
      4478
    },
    AnimationID = 15785,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0001.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = -0.75,
    MonsterProportion = 0.4
  },
  [20792] = {
    ID = 20792,
    CnID = "怪物@阿格里帕支线大型黑泥怪BOSS",
    BaseSortID = 169,
    BattleTag = "Boss",
    MonsterTag = {84277, 84293},
    MonsterName = "MonsterConfig_20792_MonsterName|「夏洛特」",
    Desc = "MonsterConfig_20792_Desc|哀泣的黑色怪物表面浮现出似曾相识的脸……",
    ExistState = {89575},
    InitSkillList = {
      4526,
      4066,
      4143,
      3975
    },
    CycleSkillList1 = {
      4526,
      4066,
      4143,
      3975
    },
    AnimationID = 15616,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0002_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.31,
    MonsterProportion = 1
  },
  [65534] = {
    ID = 65534,
    CnID = "怪物@冰封企鹅A",
    BaseSortID = 170,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_65534_MonsterName|异化企鹅",
    Desc = "MonsterConfig_65534_Desc|当融蚀与冰焰降临这片土地，宁静对艾尔沃斯的生物来说便成为奢望。",
    ExistState = {65346, 22074},
    InitSkillList = {45704, 45692},
    CycleSkillList1 = {45704, 45692},
    AnimationID = 35628,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0501.png",
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 0.36,
    MonsterProportion = 0.25
  },
  [65532] = {
    ID = 65532,
    CnID = "怪物@冰封企鹅B",
    BaseSortID = 171,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_65532_MonsterName|异化企鹅",
    Desc = "MonsterConfig_65532_Desc|当融蚀与冰焰降临这片土地，宁静对艾尔沃斯的生物来说便成为奢望。",
    ExistState = {65346, 22074},
    InitSkillList = {45692, 45704},
    CycleSkillList1 = {45692, 45704},
    AnimationID = 35628,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0501.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1.02,
    MonsterDefPercent = 0.36,
    MonsterProportion = 0.25
  },
  [65533] = {
    ID = 65533,
    CnID = "怪物@融蚀登山客精英",
    BaseSortID = 172,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90645,
      84284
    },
    MonsterName = "MonsterConfig_65533_MonsterName|探险者领队",
    Desc = "MonsterConfig_65533_Desc|他不愿舍弃那些被群山淹没的队员们。他勇敢折返。他如愿以偿。",
    ExistState = {65553},
    StateLayers = "CmdCaster.atk*0.01",
    InitSkillList = {
      65549,
      65546,
      65547,
      65548
    },
    CycleSkillList1 = {
      65549,
      65546,
      65547,
      65548
    },
    AnimationID = 35631,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0502.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.63,
    MonsterProportion = 1
  },
  [65530] = {
    ID = 65530,
    CnID = "怪物@融蚀登山客A",
    BaseSortID = 173,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90645,
      84284
    },
    MonsterName = "MonsterConfig_65530_MonsterName|遇难探险队",
    Desc = "MonsterConfig_65530_Desc|雪山吞噬了那些勇敢无知的人类，他们在死后亦不得安宁。",
    ExistState = {65553, 22074},
    StateLayers = "CmdCaster.atk*0.01",
    InitSkillList = {
      65549,
      65546,
      65547,
      65548
    },
    CycleSkillList1 = {
      65549,
      65546,
      65547,
      65548
    },
    AnimationID = 35631,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0502.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = 0.51,
    MonsterProportion = 0.6
  },
  [65531] = {
    ID = 65531,
    CnID = "怪物@融蚀登山客B",
    BaseSortID = 174,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90645,
      84284
    },
    MonsterName = "MonsterConfig_65531_MonsterName|遇难探险队",
    Desc = "MonsterConfig_65531_Desc|雪山吞噬了那些勇敢无知的人类，他们在死后亦不得安宁。",
    ExistState = {65553, 22074},
    StateLayers = "CmdCaster.atk*0.01",
    InitSkillList = {
      65548,
      65547,
      65549,
      65546
    },
    CycleSkillList1 = {
      65548,
      65547,
      65549,
      65546
    },
    AnimationID = 35631,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0502.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 0.63,
    MonsterProportion = 0.6
  },
  [149048] = {
    ID = 149048,
    CnID = "怪物@冻死者之魂BOSS",
    BaseSortID = 175,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90645,
      84284
    },
    MonsterName = "MonsterConfig_149048_MonsterName|献予女神之物",
    Desc = "MonsterConfig_149048_Desc|他因目睹真相而执迷，他因叙述真相而葬身。",
    ExistState = {65362, 2899},
    StateLayers = 5,
    StateParams = 5,
    InitSkillList = {
      65550,
      65545,
      65551,
      65550,
      149049,
      65551
    },
    CycleSkillList1 = {
      65550,
      65545,
      65551,
      65550
    },
    AnimationID = 35630,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0503.png",
    Scale = 1.35,
    MonsterHpPercent = 1,
    MonsterAtkPercent = 0.8,
    MonsterDefPercent = 1.75,
    MonsterProportion = 1
  },
  [65528] = {
    ID = 65528,
    CnID = "怪物@冻死者之魂精英",
    BaseSortID = 176,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90645,
      84284
    },
    MonsterName = "MonsterConfig_65528_MonsterName|雪之祭品",
    Desc = "MonsterConfig_65528_Desc|雪山舔舐了他的血肉。雪山吞噬了他的枯骨。雪山奴役着他的魂灵，为自己寻觅下一个祭品。",
    ExistState = {65362, 2899},
    StateLayers = 5,
    StateParams = 5,
    InitSkillList = {
      65550,
      65545,
      65551
    },
    CycleSkillList1 = {
      65550,
      65545,
      65551,
      65550
    },
    AnimationID = 35630,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0503.png",
    MonsterHpPercent = 1.5,
    MonsterAtkPercent = 0.8,
    MonsterDefPercent = 1.33,
    MonsterProportion = 1
  },
  [65527] = {
    ID = 65527,
    CnID = "怪物@冻死者之魂",
    BaseSortID = 177,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90645,
      84284
    },
    MonsterName = "MonsterConfig_65527_MonsterName|雪山之蛹",
    Desc = "MonsterConfig_65527_Desc|充满勇气与力量的考察队员。艾尔沃斯最钟爱的祭品。",
    ExistState = {
      65362,
      2899,
      22074
    },
    StateLayers = 5,
    StateParams = 5,
    InitSkillList = {
      65550,
      65545,
      65551
    },
    CycleSkillList1 = {
      65550,
      65545,
      65551,
      65550
    },
    AnimationID = 35630,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0503.png",
    MonsterHpPercent = 1.5,
    MonsterAtkPercent = 0.8,
    MonsterDefPercent = 1.33,
    MonsterProportion = 1
  },
  [44630] = {
    ID = 44630,
    CnID = "怪物@镇民A",
    BaseSortID = 178,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_44630_MonsterName|「乐善好施」肯尼",
    Desc = "MonsterConfig_44630_Desc|他曾经是个好人，愿意一天工作20个小时，只为「抚养」邻居家的孤儿。",
    ExistState = {22074},
    InitSkillList = {
      44695,
      44694,
      44696
    },
    CycleSkillList1 = {
      44695,
      44694,
      44696
    },
    AnimationID = 44627,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0701_AT.png",
    MonsterHpPercent = 0.75,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.55
  },
  [44632] = {
    ID = 44632,
    CnID = "怪物@镇民B",
    BaseSortID = 179,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_44632_MonsterName|「心地善良」弗里曼",
    Desc = "MonsterConfig_44632_Desc|他曾经是个好人，愿意一天打扫20条街道，只为能让更多人「窥视」到伦蒂尼恩的平静。",
    ExistState = {22074},
    InitSkillList = {
      44697,
      44698,
      44699,
      44698
    },
    CycleSkillList1 = {
      44697,
      44698,
      44699,
      44698
    },
    AnimationID = 44628,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0701_BT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.5,
    MonsterProportion = 0.55
  },
  [44631] = {
    ID = 44631,
    CnID = "怪物@镇民C",
    BaseSortID = 180,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_44631_MonsterName|「助人为乐」杰克逊",
    Desc = "MonsterConfig_44631_Desc|他曾经是个好人，愿意在雨夜守护每一个路人，只为能让所有人「平安归家」。",
    ExistState = {22074},
    InitSkillList = {
      44693,
      44691,
      44692
    },
    CycleSkillList1 = {
      44693,
      44691,
      44692
    },
    AnimationID = 44629,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0701_CT.png",
    MonsterHpPercent = 1.25,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 1.55,
    MonsterProportion = 0.55
  },
  [129787] = {
    ID = 129787,
    CnID = "怪物@专列精英版唤醒体詹金",
    BaseSortID = 181,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      90644
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129787_MonsterName|「窜行者」",
    Desc = "MonsterConfig_129787_Desc|她神出鬼没，对东区的每一个街巷都了若指掌，她就是「窜行者」。",
    ExistState = {3389},
    InitSkillList = {
      4235,
      4819,
      4780
    },
    CycleSkillList1 = {
      4235,
      4819,
      4780
    },
    CycleSkillList2 = {
      4720,
      4861,
      4235,
      4819,
      4720
    },
    AnimationID = 15763,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D07_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.275,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129793] = {
    ID = 129793,
    CnID = "怪物@专列精英版唤醒体艾继丝",
    BaseSortID = 182,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      84303
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129793_MonsterName|「石之眼」",
    Desc = "MonsterConfig_129793_Desc|为了希望守护的人，她也可以变得坚强。请确保有足够的算力来应对其凝滞诅咒。",
    ExistState = {2812},
    InitSkillList = {
      4652,
      4652,
      4356,
      4735
    },
    CycleSkillList1 = {
      4652,
      4652,
      4356,
      4735
    },
    CycleSkillList2 = {
      4350,
      4702,
      4206,
      4350
    },
    AnimationID = 15664,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B03_AF.png",
    MonsterHpPercent = 0.48,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 2,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129784] = {
    ID = 129784,
    CnID = "怪物@专列精英版唤醒体潘迪娅",
    BaseSortID = 183,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      143654
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129784_MonsterName|「甜蜜恶鬼」",
    Desc = "MonsterConfig_129784_Desc|擅长调教的活泼少女。已经拥有102个奴隶，正在寻觅命中注定的下一位。",
    ExistState = {2894, 3314},
    StateLayers = "1,1",
    InitSkillList = {
      4080,
      4430,
      4690,
      4661
    },
    CycleSkillList1 = {
      4080,
      4430,
      4690,
      4661
    },
    AnimationID = 15698,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C09_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129788] = {
    ID = 129788,
    CnID = "怪物@专列精英版唤醒体24",
    BaseSortID = 184,
    BattleTag = "Elite",
    MonsterTag = {90641, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129788_MonsterName|「24」",
    Desc = "MonsterConfig_129788_Desc|自蜡像中爬出的神秘女士。她的大脑十分拥挤，疑似歇斯底里症晚期患者。",
    ExistState = {2681},
    InitSkillList = {4232},
    CycleSkillList1 = {
      4695,
      4528,
      4232,
      4528,
      4232
    },
    CycleSkillList2 = {
      4528,
      4232,
      4528,
      4232,
      4232
    },
    AnimationID = 15634,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C06_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = -5.5,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129792] = {
    ID = 129792,
    CnID = "怪物@专列精英版唤醒体希洛",
    BaseSortID = 185,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      84303
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129792_MonsterName|「破链者」",
    Desc = "MonsterConfig_129792_Desc|迅捷如风的唤醒体杀手，自称希洛。她和莉莉之间似乎有什么微妙的联系……",
    ExistState = {2671},
    StateLayers = 1,
    InitSkillList = {
      4469,
      4441,
      3969
    },
    CycleSkillList1 = {
      4469,
      4441,
      3969
    },
    CycleSkillList2 = {
      4166,
      4441,
      3969,
      4166,
      4441,
      3969,
      4166,
      4441,
      3969,
      4166,
      4441,
      3969,
      4166,
      4441,
      3969,
      4166,
      4441,
      3969,
      4166,
      4441,
      3969
    },
    AnimationID = 15714,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B05_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129796] = {
    ID = 129796,
    CnID = "怪物@专列精英版唤醒体莉莉",
    BaseSortID = 186,
    BattleTag = "Elite",
    MonsterTag = {90641, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129796_MonsterName|「淤泥之花」",
    Desc = "MonsterConfig_129796_Desc|因怪异的低语声而陷入疯狂的少女莉莉。",
    ExistState = {
      3684,
      2921,
      2769
    },
    StateLayers = "CmdCaster.max_hp*0.35,1,1",
    InitSkillList = {
      4468,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051
    },
    CycleSkillList1 = {
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051
    },
    CycleSkillList2 = {4590, 4098},
    AnimationID = 15657,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C10_AF.png",
    MonsterHpPercent = 0.52,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 1.74,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129783] = {
    ID = 129783,
    CnID = "怪物@专列精英版唤醒体达芙黛尔",
    BaseSortID = 187,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      90644
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129783_MonsterName|「猎颅魔女」",
    Desc = "MonsterConfig_129783_Desc|来自过去的神秘商人，喜欢通过交易丈量一切。",
    ExistState = {23517, 23525},
    StateLayers = "1,1",
    InitSkillList = {
      23480,
      23490,
      23482,
      23487
    },
    CycleSkillList1 = {
      23480,
      23490,
      23482,
      23487
    },
    CycleSkillList2 = {
      23481,
      23480,
      23509,
      23479,
      23488
    },
    AnimationID = 15713,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D02_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1.01,
    MonsterDefPercent = 0.45,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129799] = {
    ID = 129799,
    CnID = "怪物@专列精英版唤醒体卡茜亚",
    BaseSortID = 188,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      90644,
      143654
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129799_MonsterName|「奇术师」",
    Desc = "MonsterConfig_129799_Desc|天哪！我的《伦蒂尼恩犯罪实录》放哪了？！这可是我千辛万苦才从警局借来的——在图书管理员的哀嚎中，魔术大师卡茜亚正从知识的海洋中，汲取新的「情绪」。",
    ExistState = {
      23769,
      2921,
      35636,
      35688
    },
    StateLayers = 1,
    InitSkillList = {23814},
    CycleSkillList1 = {
      23817,
      23810,
      23812,
      23758
    },
    CycleSkillList2 = {
      23814,
      23817,
      23810,
      23812,
      23758
    },
    AnimationID = 15742,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D09_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.04,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129776] = {
    ID = 129776,
    CnID = "怪物@专列精英版唤醒体海洋之刃",
    BaseSortID = 189,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      90643
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129776_MonsterName|「复仇巨刃」",
    Desc = "MonsterConfig_129776_Desc|以巨人之力挥动重刃的强大战士。",
    ExistState = {3403, 83816},
    StateLayers = 1,
    InitSkillList = {
      4454,
      4609,
      4454,
      4505,
      4168,
      4171,
      4170,
      4609
    },
    CycleSkillList1 = {
      4454,
      4609,
      4454,
      4505,
      4168,
      4171,
      4170,
      4609
    },
    CycleSkillList2 = {
      4168,
      4168,
      4171,
      4170,
      4609,
      4454,
      4505,
      4168,
      4171,
      4170,
      4609,
      4454,
      4505
    },
    AnimationID = 15704,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O06_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129790] = {
    ID = 129790,
    CnID = "怪物@专列精英版唤醒体凯刻斯",
    BaseSortID = 190,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      90643
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129790_MonsterName|「沉渊者」",
    Desc = "MonsterConfig_129790_Desc|与蹈海者同行的神秘少年。嶙峋的棘刺，似鱼的耳鳍，一切都暗示着他并非常人。",
    ExistState = {23405, 83816},
    StateLayers = "1,1",
    InitSkillList = {
      23411,
      23408,
      23410,
      23408
    },
    CycleSkillList1 = {
      23411,
      23408,
      23410,
      23408
    },
    CycleSkillList2 = {
      23408,
      23411,
      23410,
      23407
    },
    AnimationID = 15624,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O04_AF.png",
    MonsterHpPercent = 0.46,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 2.755,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129781] = {
    ID = 129781,
    CnID = "怪物@专列精英版唤醒体图鲁",
    BaseSortID = 191,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      90643
    },
    Category = "MotherTreeMonster",
    MonsterName = "MonsterConfig_129781_MonsterName|「沉睡之主」",
    Desc = "MonsterConfig_129781_Desc|群星正位之刻，他将结束亿万年的沉眠，荣归祂的王座。而这是否是他心中所愿，便无人知晓了。",
    ExistState = {
      129865,
      57953,
      36314,
      57952,
      83816
    },
    StateLayers = "1,1,1,1,1",
    StateParams = "CmdCaster.atk*0.05",
    InitSkillList = {58494, 58495},
    CycleSkillList1 = {58494, 58495},
    CycleSkillList2 = {57949, 57950},
    AnimationID = 15640,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O01_AF.png",
    MonsterHpPercent = 0.15,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129797] = {
    ID = 129797,
    CnID = "怪物@专列精英版唤醒体墨菲",
    BaseSortID = 192,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      90643
    },
    MonsterName = "MonsterConfig_129797_MonsterName|「深海淑女」",
    Desc = "MonsterConfig_129797_Desc|「我不是第一个被献祭的母体，也不是最后的一个……但是，我想活下去！」",
    ExistState = {
      118937,
      118118,
      118943,
      118741,
      118935,
      118973,
      121015
    },
    StateLayers = "1,1,CmdCaster.max_hp*0.15,1,1,1,1",
    InitSkillList = {
      118087,
      118095,
      118072,
      118060
    },
    CycleSkillList1 = {
      118087,
      118095,
      118072,
      118060
    },
    CycleSkillList2 = {
      118974,
      118975,
      118065,
      118072
    },
    AnimationID = 118053,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O02_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.5,
    MonsterAtkPercent = 0.85,
    MonsterDefPercent = 1.3,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129791] = {
    ID = 129791,
    CnID = "怪物@专列精英版唤醒体泰旖丝",
    BaseSortID = 193,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      84303
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129791_MonsterName|「丰穰之息」",
    Desc = "MonsterConfig_129791_Desc|「击溃它们，安抚它们，即使你窥见我的幻影，也在所不惜。」",
    ExistState = {
      60493,
      60486,
      60500,
      60487,
      61047,
      61057,
      2921
    },
    StateLayers = "CmdCaster.max_hp*0.8,1,1,1,1,CmdCaster.max_hp",
    InitSkillList = {
      60483,
      60481,
      60479,
      60479,
      60479
    },
    CycleSkillList1 = {
      60483,
      60481,
      60479,
      60479,
      60479
    },
    AnimationID = 15776,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B01_AF.png",
    MonsterHpPercent = 0.2,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.85,
    MonsterHpNum = 2
  },
  [129794] = {
    ID = 129794,
    CnID = "怪物@专列精英版唤醒体艾尔瓦",
    BaseSortID = 194,
    BattleTag = "Elite",
    MonsterTag = {90641, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129794_MonsterName|「空想利刃」",
    Desc = "MonsterConfig_129794_Desc|亚兰族族长，她将以自身为旗、为刃、为盾，指引亚兰的子民，开辟未来的道路，守候她的归来。",
    ExistState = {
      49595,
      49583,
      49833
    },
    StateLayers = "1,1,1",
    StateParams = "CmdCaster.def*1,CmdCaster.atk*0.1",
    InitSkillList = {49576},
    CycleSkillList1 = {
      49580,
      49579,
      49581
    },
    CycleSkillList2 = {
      49576,
      49580,
      49579
    },
    AnimationID = 15781,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C11_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = 1.95,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129789] = {
    ID = 129789,
    CnID = "怪物@专列精英版唤醒体哈姆林",
    BaseSortID = 195,
    BattleTag = "Elite",
    MonsterTag = {90641, 84297},
    MonsterName = "MonsterConfig_129789_MonsterName|「@2奏者」",
    Desc = "MonsterConfig_129789_Desc|指挥棒的轨迹之下，究竟隐藏着什么样的乐曲？",
    ExistState = {60430},
    StateLayers = 1,
    InitSkillList = {
      60424,
      60426,
      60428,
      60427,
      60425,
      60428
    },
    CycleSkillList1 = {
      60424,
      60426,
      60428,
      60427,
      60425,
      60428
    },
    CycleSkillList2 = {
      60424,
      60426,
      60428,
      60427,
      60425,
      60428
    },
    AnimationID = 60361,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D12_AF.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.45,
    MonsterProportion = 1
  },
  [129778] = {
    ID = 129778,
    CnID = "怪物@专列精英版唤醒体拉蒙娜",
    BaseSortID = 196,
    BattleTag = "Elite",
    MonsterTag = {90641, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129778_MonsterName|「知者」",
    Desc = "MonsterConfig_129778_Desc|无需任何词汇描述她。她是拉蒙娜。斩断与她的链接吧。",
    ExistState = {
      67255,
      67257,
      2921
    },
    StateLayers = "1,1,1",
    InitSkillList = {67176},
    CycleSkillList1 = {
      67175,
      67187,
      67175,
      67181
    },
    CycleSkillList2 = {
      67175,
      67187,
      67175,
      67181,
      67176,
      67175,
      67187,
      67175,
      67181,
      67176,
      67175,
      67187,
      67175,
      67181,
      67176
    },
    AnimationID = 15700,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C01_AF.png",
    MonsterHpPercent = 0.33,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.02,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129777] = {
    ID = 129777,
    CnID = "怪物@专列精英版唤醒体奥吉尔",
    BaseSortID = 197,
    BattleTag = "Elite",
    MonsterTag = {90641, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129777_MonsterName|「美德骑士」",
    Desc = "MonsterConfig_129777_Desc|年幼的骑士曾向你宣誓效忠，他从未背弃他的誓言。",
    ExistState = {
      67265,
      67241,
      67258,
      67246,
      60263,
      60087,
      2921
    },
    StateLayers = "1,1,1,35,50,50,1",
    StateParams = "CmdCaster.def*5,CmdCaster.max_hp*0.25,CmdCaster.atk*0.3,CmdCaster.def*5",
    InitSkillList = {67177},
    CycleSkillList1 = {
      67173,
      67182,
      67177,
      67171,
      67182,
      67177
    },
    CycleSkillList2 = {
      67177,
      67173,
      67182,
      67177,
      67171,
      67182,
      67177,
      67173,
      67182,
      67177,
      67171,
      67182,
      67177,
      67173,
      67182,
      67177,
      67171,
      67182
    },
    AnimationID = 15667,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C03_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 2.03,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129780] = {
    ID = 129780,
    CnID = "怪物@专列精英版唤醒体朵尔",
    BaseSortID = 198,
    BattleTag = "Elite",
    MonsterTag = {90641, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129780_MonsterName|「缸中之脑」",
    Desc = "MonsterConfig_129780_Desc|她的声音从通讯器中响起时，是你任务中最安心的时刻。卓越的智慧，你已依赖得够多。",
    ExistState = {
      67242,
      67249,
      62213,
      67346,
      67784
    },
    StateLayers = "1,1,50,1,1",
    InitSkillList = {67183},
    CycleSkillList1 = {
      67180,
      67185,
      129858,
      67183
    },
    CycleSkillList2 = {
      67183,
      129858,
      67185
    },
    AnimationID = 15686,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C02_AF.png",
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129782] = {
    ID = 129782,
    CnID = "怪物@专列精英版唤醒体艾瑞卡",
    BaseSortID = 199,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      90644,
      143654
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129782_MonsterName|「嘀嗒人」",
    Desc = "MonsterConfig_129782_Desc|艾瑞卡已经完全失去了自我的意识……是受黑池的影响吗？",
    ExistState = {
      60151,
      60150,
      60155
    },
    StateLayers = "1,1,1",
    StateParams = "CmdCaster.atk*0.1,CmdCaster.max_hp*0.2",
    InitSkillList = {
      60134,
      60133,
      60135,
      60137
    },
    CycleSkillList1 = {
      60134,
      60133,
      60135,
      60137
    },
    CycleSkillList2 = {
      60135,
      60137,
      60134
    },
    AnimationID = 15754,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D08_AF.png",
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.7,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129798] = {
    ID = 129798,
    CnID = "怪物@专列精英版唤醒体克莱门汀突袭版",
    BaseSortID = 200,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      90644
    },
    MonsterName = "MonsterConfig_129798_MonsterName|「催眠妖虫」",
    Desc = "MonsterConfig_129798_Desc|总是十分温柔的心理医生，无论何时都保持着得体的微笑。",
    ExistState = {73533, 73535},
    StateLayers = "1,1",
    InitSkillList = {80355},
    CycleSkillList1 = {
      80969,
      73476,
      80969,
      73476,
      73482
    },
    AnimationID = 73549,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D13_AF.png",
    Scale = 1,
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 1.31,
    MonsterProportion = 1
  },
  [129785] = {
    ID = 129785,
    CnID = "怪物@专列精英版唤醒体杜勒赛因",
    BaseSortID = 201,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      84303
    },
    MonsterName = "MonsterConfig_129785_MonsterName|「葬骸之主」",
    Desc = "MonsterConfig_129785_Desc|「粗鲁的动作可不符合客人应有的礼仪，守密人阁下。」",
    ExistState = {
      95960,
      95953,
      95959,
      96337
    },
    StateLayers = "10,1,1",
    InitSkillList = {95821},
    CycleSkillList1 = {
      95826,
      95827,
      95825,
      95821
    },
    CycleSkillList2 = {
      95816,
      95818,
      95823,
      95807
    },
    AnimationID = 95802,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B10_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.068,
    MonsterProportion = 0.75,
    MonsterHpNum = 2
  },
  [129795] = {
    ID = 129795,
    CnID = "怪物@专列精英版唤醒体皮克曼",
    BaseSortID = 202,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      84303
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129795_MonsterName|「绘者」",
    Desc = "MonsterConfig_129795_Desc|我会向你展现这世界的真相……",
    ExistState = {
      99136,
      99138,
      99134,
      99356,
      116340,
      116341,
      116342,
      116361,
      2921
    },
    StateLayers = "1,1,5,1,1,1,1,1,1",
    InitSkillList = {
      99121,
      99118,
      99116
    },
    CycleSkillList1 = {
      99121,
      99118,
      99116
    },
    CycleSkillList2 = {
      99119,
      99120,
      99117
    },
    AnimationID = 99240,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B12_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.33,
    MonsterAtkPercent = 0.85,
    MonsterDefPercent = 0.176,
    MonsterProportion = 0.8,
    MonsterHpNum = 2
  },
  [129779] = {
    ID = 129779,
    CnID = "怪物@专列精英版唤醒体诞妄墨菲",
    BaseSortID = 203,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      90643
    },
    MonsterName = "MonsterConfig_129779_MonsterName|「海嗣神母」",
    Desc = "MonsterConfig_129779_Desc|曾经软弱天真的「她」已经死去，现在的她，是尊贵的「神母」，是不可违抗的「天后」。",
    ExistState = {
      118118,
      119109,
      118741,
      119107,
      119106,
      119103
    },
    StateLayers = "1,CmdCaster.max_hp*0.1,1,1,1,1",
    InitSkillList = {
      118091,
      118058,
      118105
    },
    CycleSkillList1 = {
      118091,
      118058,
      118105
    },
    CycleSkillList2 = {
      118091,
      118058,
      118105
    },
    AnimationID = 118052,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O02EX_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.6,
    MonsterAtkPercent = 0.85,
    MonsterDefPercent = 1.05,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [129786] = {
    ID = 129786,
    CnID = "怪物@专列精英版唤醒体法洛思",
    BaseSortID = 204,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      90643
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129786_MonsterName|「原初信徒」",
    Desc = "MonsterConfig_129786_Desc|驻守永恒之国入口之人，指引归乡者的灯塔。",
    ExistState = {
      100620,
      100631,
      100643,
      100690,
      118741,
      118118
    },
    StateLayers = "1,1,1,1,1,1",
    StateParams = "CmdCaster.atk*0.05",
    InitSkillList = {
      100600,
      100604,
      100602
    },
    CycleSkillList1 = {
      100600,
      100604,
      100602
    },
    CycleSkillList2 = {
      100598,
      100603,
      100599
    },
    AnimationID = 100597,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O03_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.4,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [14044] = {
    ID = 14044,
    CnID = "怪物@唤醒体24",
    BaseSortID = 205,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_14044_MonsterName|「24」",
    Desc = "MonsterConfig_14044_Desc|自蜡像中爬出的神秘女士。她的大脑十分拥挤，疑似歇斯底里症晚期患者。",
    ExistState = {2681},
    InitSkillList = {4232},
    CycleSkillList1 = {
      4695,
      4528,
      4232,
      4528,
      4232
    },
    CycleSkillList2 = {
      4528,
      4232,
      4528,
      4232,
      4232
    },
    AnimationID = 15634,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C06_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = -5.5,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [14017] = {
    ID = 14017,
    CnID = "怪物@唤醒体鲸跃",
    BaseSortID = 206,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_14017_MonsterName|「鲸跃」",
    Desc = "MonsterConfig_14017_Desc|旅途无聊的萝坦，陷入癫狂的战斗欲望中。当心其觉醒后的不竭战意，能够每回合移除多层虚弱和易伤状态。",
    ExistState = {3372},
    StateLayers = 1,
    InitSkillList = {
      4224,
      4283,
      4432,
      4224
    },
    CycleSkillList1 = {
      4283,
      4432,
      4224
    },
    CycleSkillList2 = {
      4283,
      4224,
      4432
    },
    AnimationID = 15719,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C04_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.75,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [14011] = {
    ID = 14011,
    CnID = "怪物@唤醒体艾继丝",
    BaseSortID = 207,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      84303
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_14011_MonsterName|「石之眼」",
    Desc = "MonsterConfig_14011_Desc|为了希望守护的人，她也可以变得坚强。请确保有足够的算力来应对其凝滞诅咒。",
    ExistState = {2812},
    InitSkillList = {
      4652,
      4652,
      4356,
      4735
    },
    CycleSkillList1 = {
      4652,
      4652,
      4356,
      4735
    },
    CycleSkillList2 = {
      4350,
      4702,
      4206,
      4350
    },
    AnimationID = 15664,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B03_AF.png",
    MonsterHpPercent = 0.48,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 2,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [14063] = {
    ID = 14063,
    CnID = "怪物@唤醒体詹金",
    BaseSortID = 208,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90644
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_14063_MonsterName|「窜行者」",
    Desc = "MonsterConfig_14063_Desc|她神出鬼没，对东区的每一个街巷都了若指掌，她就是「窜行者」。",
    ExistState = {3389},
    InitSkillList = {
      4235,
      4819,
      4780
    },
    CycleSkillList1 = {
      4235,
      4819,
      4780
    },
    CycleSkillList2 = {
      4720,
      4861,
      4235,
      4819,
      4720
    },
    AnimationID = 15763,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D07_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.275,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [24743] = {
    ID = 24743,
    CnID = "怪物@唤醒体珈伦",
    BaseSortID = 209,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_24743_MonsterName|「凸月侍女」",
    Desc = "MonsterConfig_24743_Desc|索蕾尔最亲近的女仆，沉迷各种美白秘方。",
    ExistState = {24977},
    StateLayers = 1,
    InitSkillList = {
      24988,
      24984,
      24983,
      24982,
      24986
    },
    CycleSkillList1 = {
      24984,
      24983,
      24982,
      24986
    },
    CycleSkillList2 = {
      24984,
      24983,
      24982,
      24986,
      24988
    },
    AnimationID = 15626,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C12_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.275,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [13994] = {
    ID = 13994,
    CnID = "怪物@唤醒体雷娅",
    BaseSortID = 210,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      84303
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_13994_MonsterName|「渴血患者」",
    Desc = "MonsterConfig_13994_Desc|隐匿在角落的苍白少女，似乎对鲜血情有独钟……？",
    ExistState = {3882},
    InitSkillList = {3958, 4117},
    CycleSkillList1 = {
      4117,
      4073,
      4097
    },
    CycleSkillList2 = {
      4097,
      4371,
      4045
    },
    AnimationID = 15745,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B08_AF.png",
    MonsterHpPercent = 0.44,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 2.25,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [14039] = {
    ID = 14039,
    CnID = "怪物@唤醒体睡莲",
    BaseSortID = 211,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_14039_MonsterName|「睡莲」",
    Desc = "MonsterConfig_14039_Desc|她曾经是孤独的漂流落花，如今是拉伊精神疗养院的居民和屏障。",
    ExistState = {3494, 3656},
    StateLayers = "1,1",
    InitSkillList = {
      4063,
      4118,
      4014,
      4003
    },
    CycleSkillList1 = {
      4118,
      4014,
      4003
    },
    CycleSkillList2 = {
      4192,
      4859,
      4003,
      4192,
      4859,
      4003,
      4192,
      4859,
      4003,
      4192,
      4859,
      4003,
      4192,
      4859,
      4003,
      4192,
      4859,
      4003
    },
    AnimationID = 15615,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C08_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.895,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [13952] = {
    ID = 13952,
    CnID = "怪物@唤醒体希洛",
    BaseSortID = 212,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      84303
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_13952_MonsterName|「破链者」",
    Desc = "MonsterConfig_13952_Desc|迅捷如风的唤醒体杀手，自称希洛。她和莉莉之间似乎有什么微妙的联系……",
    ExistState = {2671},
    StateLayers = 1,
    InitSkillList = {
      4469,
      4441,
      3969
    },
    CycleSkillList1 = {
      4469,
      4441,
      3969
    },
    CycleSkillList2 = {
      4166,
      4441,
      3969,
      4166,
      4441,
      3969,
      4166,
      4441,
      3969,
      4166,
      4441,
      3969,
      4166,
      4441,
      3969,
      4166,
      4441,
      3969,
      4166,
      4441,
      3969
    },
    AnimationID = 15714,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B05_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [14071] = {
    ID = 14071,
    CnID = "怪物@唤醒体莉莉",
    BaseSortID = 213,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_14071_MonsterName|「淤泥之花」",
    Desc = "MonsterConfig_14071_Desc|因怪异的低语声而陷入疯狂的少女莉莉。",
    ExistState = {
      3684,
      2921,
      2769
    },
    StateLayers = "CmdCaster.max_hp*0.35,1,1",
    InitSkillList = {
      4468,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051
    },
    CycleSkillList1 = {
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051,
      4590,
      4051
    },
    CycleSkillList2 = {4590, 4098},
    AnimationID = 15657,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C10_AF.png",
    MonsterHpPercent = 0.52,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 1.74,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [14037] = {
    ID = 14037,
    CnID = "怪物@唤醒体潘迪娅",
    BaseSortID = 214,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      143654
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_14037_MonsterName|「甜蜜恶鬼」",
    Desc = "MonsterConfig_14037_Desc|擅长调教的活泼少女。已经拥有102个奴隶，正在寻觅命中注定的下一位。",
    ExistState = {2894, 3314},
    StateLayers = "1,1",
    InitSkillList = {
      4080,
      4430,
      4690,
      4661
    },
    CycleSkillList1 = {
      4080,
      4430,
      4690,
      4661
    },
    AnimationID = 15698,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C09_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [14064] = {
    ID = 14064,
    CnID = "怪物@唤醒体海洋之刃",
    BaseSortID = 215,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90643
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_14064_MonsterName|「复仇巨刃」",
    Desc = "MonsterConfig_14064_Desc|以巨人之力挥动重刃的强大战士。",
    ExistState = {3403, 83816},
    StateLayers = 1,
    InitSkillList = {
      4454,
      4609,
      4454,
      4505,
      4168,
      4171,
      4170,
      4609
    },
    CycleSkillList1 = {
      4454,
      4609,
      4454,
      4505,
      4168,
      4171,
      4170,
      4609
    },
    CycleSkillList2 = {
      4168,
      4168,
      4171,
      4170,
      4609,
      4454,
      4505,
      4168,
      4171,
      4170,
      4609,
      4454,
      4505
    },
    AnimationID = 15704,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O06_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [23537] = {
    ID = 23537,
    CnID = "怪物@唤醒体达芙黛尔",
    BaseSortID = 216,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90644
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_23537_MonsterName|「猎颅魔女」",
    Desc = "MonsterConfig_23537_Desc|来自过去的神秘商人，喜欢通过交易丈量一切。",
    ExistState = {23517, 23525},
    StateLayers = "1,1",
    InitSkillList = {
      23480,
      23490,
      23482,
      23487
    },
    CycleSkillList1 = {
      23480,
      23490,
      23482,
      23487
    },
    CycleSkillList2 = {
      23481,
      23480,
      23509,
      23479,
      23488
    },
    AnimationID = 15713,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D02_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1.01,
    MonsterDefPercent = 0.45,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [20804] = {
    ID = 20804,
    CnID = "怪物@唤醒体尤乌哈希",
    BaseSortID = 217,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      84303
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_20804_MonsterName|「猩红」",
    Desc = "MonsterConfig_20804_Desc|自遥远的群星而来，现今世上最早的魔像。",
    ExistState = {
      21385,
      20982,
      20851
    },
    StateLayers = "CmdCaster.max_hp*0.33,1,1",
    StateParams = "CmdCaster.max_hp*0.33",
    InitSkillList = {
      20841,
      20844,
      20843
    },
    CycleSkillList1 = {
      20841,
      20844,
      20843
    },
    CycleSkillList2 = {
      20841,
      20844,
      21308,
      20843
    },
    AnimationID = 15659,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B07_AF.png",
    MonsterHpPercent = 0.36,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [23417] = {
    ID = 23417,
    CnID = "怪物@唤醒体凯刻斯",
    BaseSortID = 218,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90643
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_23417_MonsterName|「沉渊者」",
    Desc = "MonsterConfig_23417_Desc|与蹈海者同行的神秘少年。嶙峋的棘刺，似鱼的耳鳍，一切都暗示着他并非常人。",
    ExistState = {23405, 83816},
    StateLayers = "1,1",
    InitSkillList = {
      23411,
      23408,
      23410,
      23408
    },
    CycleSkillList1 = {
      23411,
      23408,
      23410,
      23408
    },
    CycleSkillList2 = {
      23408,
      23411,
      23410,
      23407
    },
    AnimationID = 15624,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O04_AF.png",
    MonsterHpPercent = 0.46,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 2.755,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [49592] = {
    ID = 49592,
    CnID = "怪物@唤醒体艾尔瓦",
    BaseSortID = 219,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_49592_MonsterName|「空想利刃」",
    Desc = "MonsterConfig_49592_Desc|亚兰族族长，她将以自身为旗、为刃、为盾，指引亚兰的子民，开辟未来的道路，守候她的归来。",
    ExistState = {
      49595,
      49583,
      49833
    },
    StateLayers = "1,1,1",
    StateParams = "CmdCaster.def*1,CmdCaster.atk*0.1",
    InitSkillList = {49576},
    CycleSkillList1 = {
      49580,
      49579,
      49581
    },
    CycleSkillList2 = {
      49576,
      49580,
      49579
    },
    AnimationID = 15781,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C11_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = 1.95,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [51698] = {
    ID = 51698,
    CnID = "怪物@唤醒体弥利亚姆",
    BaseSortID = 220,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90643
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_51698_MonsterName|「海之使徒」",
    Desc = "MonsterConfig_51698_Desc|她放弃了抵抗「灾厄」的侵蚀，精神维度的污染，让曾经矜贵强大的唤醒体，染上了彻头彻尾的疯狂。",
    ExistState = {
      51695,
      51822,
      2921,
      83816
    },
    StateLayers = "1,1,1,1",
    StateParams = "CmdCaster.atk*0.03",
    InitSkillList = {
      51692,
      51693,
      51690,
      51694
    },
    CycleSkillList1 = {
      51692,
      51693,
      51690,
      51694
    },
    CycleSkillList2 = {
      51700,
      51702,
      51701,
      51703
    },
    AnimationID = 15732,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O07_AF.png",
    MonsterHpPercent = 0.384,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.5,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [57954] = {
    ID = 57954,
    CnID = "怪物@唤醒体图鲁",
    BaseSortID = 221,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90643
    },
    Category = "MotherTreeMonster",
    MonsterName = "MonsterConfig_57954_MonsterName|「沉睡之主」",
    Desc = "MonsterConfig_57954_Desc|群星正位之刻，他将结束亿万年的沉眠，荣归祂的王座。而这是否是他心中所愿，便无人知晓了。",
    ExistState = {
      58492,
      57953,
      36314,
      57952,
      83816
    },
    StateLayers = "1,1,1,1,1",
    StateParams = "CmdCaster.atk*0.05",
    InitSkillList = {58494, 58495},
    CycleSkillList1 = {58494, 58495},
    CycleSkillList2 = {57949, 57950},
    AnimationID = 15640,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O01_AF.png",
    MonsterHpPercent = 0.15,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [60092] = {
    ID = 60092,
    CnID = "怪物@唤醒体泰旖丝",
    BaseSortID = 222,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      84303
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_60092_MonsterName|「丰穰之息」",
    Desc = "MonsterConfig_60092_Desc|「击溃它们，安抚它们，即使你窥见我的幻影，也在所不惜。」",
    ExistState = {
      60493,
      60486,
      60500,
      60487,
      61047,
      61057,
      2921
    },
    StateLayers = "CmdCaster.max_hp*0.8,1,1,1,1,CmdCaster.max_hp",
    InitSkillList = {
      60483,
      60481,
      60479,
      60479,
      60479
    },
    CycleSkillList1 = {
      60483,
      60481,
      60479,
      60479,
      60479
    },
    AnimationID = 15776,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B01_AF.png",
    MonsterHpPercent = 0.2,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.85,
    MonsterHpNum = 2
  },
  [60496] = {
    ID = 60496,
    CnID = "怪物@唤醒体泰旖丝@拟态艾继丝",
    BaseSortID = 223,
    BattleTag = "Elite",
    MonsterTag = {
      90640,
      84297,
      84303
    },
    MonsterName = "MonsterConfig_60496_MonsterName|「拟态-石之眼」",
    Desc = "MonsterConfig_60496_Desc|为了希望守护的人，她也可以变得坚强。请确保有足够的算力来应对其凝滞诅咒。",
    ExistState = {60490},
    InitSkillList = {60482, 60480},
    CycleSkillList1 = {60482, 60480},
    AnimationID = 15664,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B03_AF.png",
    MonsterHpPercent = 0.45,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.275,
    MonsterProportion = 1
  },
  [60494] = {
    ID = 60494,
    CnID = "怪物@唤醒体泰旖丝@拟态雷娅",
    BaseSortID = 224,
    BattleTag = "Elite",
    MonsterTag = {
      90640,
      84297,
      84303
    },
    MonsterName = "MonsterConfig_60494_MonsterName|「拟态-渴血患者」",
    Desc = "MonsterConfig_60494_Desc|隐匿在角落的苍白少女，似乎对鲜血情有独钟……？",
    ExistState = {60490},
    InitSkillList = {60498, 60501},
    CycleSkillList1 = {60498, 60501},
    AnimationID = 15745,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B08_AF.png",
    MonsterHpPercent = 0.55,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 2.25,
    MonsterProportion = 1
  },
  [60497] = {
    ID = 60497,
    CnID = "怪物@唤醒体泰旖丝@拟态尤乌哈希",
    BaseSortID = 225,
    BattleTag = "Elite",
    MonsterTag = {
      90640,
      84297,
      84303
    },
    MonsterName = "MonsterConfig_60497_MonsterName|「拟态-猩红」",
    Desc = "MonsterConfig_60497_Desc|自遥远的群星而来，现今世上最早的魔像。",
    ExistState = {60490},
    InitSkillList = {
      20841,
      20843,
      20842
    },
    CycleSkillList1 = {
      20841,
      20843,
      20842
    },
    AnimationID = 15659,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B07_AF.png",
    MonsterHpPercent = 0.45,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [60495] = {
    ID = 60495,
    CnID = "怪物@唤醒体泰旖丝@拟态希洛",
    BaseSortID = 226,
    BattleTag = "Elite",
    MonsterTag = {
      90640,
      84297,
      84303
    },
    MonsterName = "MonsterConfig_60495_MonsterName|「拟态-破链者」",
    Desc = "MonsterConfig_60495_Desc|迅捷如风的唤醒体杀手，自称希洛。她和莉莉之间似乎有什么微妙的联系……",
    ExistState = {60490},
    InitSkillList = {60475, 60476},
    CycleSkillList1 = {4469, 3969},
    AnimationID = 15714,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B05_AF.png",
    MonsterHpPercent = 0.5,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [60096] = {
    ID = 60096,
    CnID = "怪物@唤醒体哈姆林",
    BaseSortID = 227,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    MonsterName = "MonsterConfig_60096_MonsterName|「@2奏者」",
    Desc = "MonsterConfig_60096_Desc|指挥棒的轨迹之下，究竟隐藏着什么样的乐曲？",
    ExistState = {60430},
    StateLayers = 1,
    InitSkillList = {
      60424,
      60426,
      60428,
      60427,
      60425,
      60428
    },
    CycleSkillList1 = {
      60424,
      60426,
      60428,
      60427,
      60425,
      60428
    },
    CycleSkillList2 = {
      60424,
      60426,
      60428,
      60427,
      60425,
      60428
    },
    AnimationID = 60361,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D12_AF.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.45,
    MonsterProportion = 1
  },
  [60099] = {
    ID = 60099,
    CnID = "怪物@唤醒体艾瑞卡",
    BaseSortID = 228,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90644,
      143654
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_60099_MonsterName|「嘀嗒人」",
    Desc = "MonsterConfig_60099_Desc|艾瑞卡已经完全失去了自我的意识……是受黑池的影响吗？",
    ExistState = {
      60151,
      60150,
      60155
    },
    StateLayers = "1,1,1",
    StateParams = "CmdCaster.atk*0.1,CmdCaster.max_hp*0.2",
    InitSkillList = {
      60134,
      60133,
      60135,
      60137
    },
    CycleSkillList1 = {
      60134,
      60133,
      60135,
      60137
    },
    CycleSkillList2 = {
      60135,
      60137,
      60134
    },
    AnimationID = 15754,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D08_AF.png",
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.7,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [23773] = {
    ID = 23773,
    CnID = "怪物@唤醒体卡茜亚",
    BaseSortID = 229,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90644,
      143654
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_23773_MonsterName|「奇术师」",
    Desc = "MonsterConfig_23773_Desc|天哪！我的《伦蒂尼恩犯罪实录》放哪了？！这可是我千辛万苦才从警局借来的——在图书管理员的哀嚎中，魔术大师卡茜亚正从知识的海洋中，汲取新的「情绪」。",
    ExistState = {
      23769,
      2921,
      35636,
      35688
    },
    StateLayers = 1,
    InitSkillList = {23814},
    CycleSkillList1 = {
      23817,
      23810,
      23812,
      23758
    },
    CycleSkillList2 = {
      23814,
      23817,
      23810,
      23812,
      23758
    },
    AnimationID = 15742,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D09_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.04,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [14053] = {
    ID = 14053,
    CnID = "怪物@唤醒体凯刻斯主线",
    BaseSortID = 230,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90643
    },
    MonsterName = "MonsterConfig_14053_MonsterName|蹈海者少年",
    Desc = "MonsterConfig_14053_Desc|与蹈海者同行的神秘少年。嶙峋的棘刺，似鱼的耳鳍，一切都暗示着他并非常人。",
    ExistState = {83816},
    StateLayers = 1,
    InitSkillList = {
      4522,
      4012,
      4810,
      4012
    },
    CycleSkillList1 = {
      4522,
      4012,
      4810,
      4012
    },
    AnimationID = 15624,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O04_AF.png",
    MonsterHpPercent = 1.15,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 4.83,
    MonsterProportion = 1
  },
  [119849] = {
    ID = 119849,
    CnID = "怪物@唤醒体凯刻斯精英",
    BaseSortID = 231,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      90643
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_119849_MonsterName|「沉渊者」",
    Desc = "MonsterConfig_119849_Desc|现在，就是昭示深海血脉力量的时刻。他会让戈利亚大人看到自己的实力。",
    ExistState = {23405, 83816},
    StateLayers = "1,1",
    InitSkillList = {
      23411,
      23408,
      23410,
      23408
    },
    CycleSkillList1 = {
      23411,
      23408,
      23410,
      23408
    },
    CycleSkillList2 = {
      23408,
      23411,
      23410,
      23407
    },
    AnimationID = 15624,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O04_AF.png",
    MonsterHpPercent = 0.46,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 2.755,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [119851] = {
    ID = 119851,
    CnID = "怪物@唤醒体戈利亚精英",
    BaseSortID = 232,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      90643
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_119851_MonsterName|「复仇巨刃」",
    Desc = "MonsterConfig_119851_Desc|以巨人之力挥动重刃的强大战士，因自身的野心，追随着「主祭」的步伐。",
    ExistState = {3403, 83816},
    StateLayers = 1,
    InitSkillList = {
      4454,
      4609,
      4454,
      4505,
      4168,
      4171,
      4170,
      4609
    },
    CycleSkillList1 = {
      4454,
      4609,
      4454,
      4505,
      4168,
      4171,
      4170,
      4609
    },
    CycleSkillList2 = {
      4168,
      4168,
      4171,
      4170,
      4609,
      4454,
      4505,
      4168,
      4171,
      4170,
      4609,
      4454,
      4505
    },
    AnimationID = 15704,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O06_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [119850] = {
    ID = 119850,
    CnID = "怪物@唤醒体法洛思精英",
    BaseSortID = 233,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84297,
      90643
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_119850_MonsterName|「原初信徒」",
    Desc = "MonsterConfig_119850_Desc|一切，都是为了筑成通往神国的道路。",
    ExistState = {
      100620,
      100631,
      100643,
      100690,
      118741,
      118118
    },
    StateLayers = "1,1,1,1,1,1",
    StateParams = "CmdCaster.atk*0.05",
    InitSkillList = {
      100600,
      100604,
      100602
    },
    CycleSkillList1 = {
      100600,
      100604,
      100602
    },
    CycleSkillList2 = {
      100598,
      100603,
      100599
    },
    AnimationID = 100597,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O03_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.4,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [14092] = {
    ID = 14092,
    CnID = "怪物@小型星之眷族A",
    BaseSortID = 234,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_14092_MonsterName|海中之物",
    Desc = "MonsterConfig_14092_Desc|变形者们选择了这幅躯壳，灵活而坚韧。当心它们的寄生攻击。",
    ExistState = {
      22074,
      83816,
      89574
    },
    StateLayers = "1,1",
    InitSkillList = {
      4787,
      4518,
      4734,
      4042
    },
    CycleSkillList1 = {
      4787,
      4518,
      4734
    },
    AnimationID = 15648,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0501.png",
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.25
  },
  [14091] = {
    ID = 14091,
    CnID = "怪物@小型星之眷族B",
    BaseSortID = 235,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_14091_MonsterName|海中之物",
    Desc = "MonsterConfig_14091_Desc|变形者们选择了这幅躯壳，久远而恒常。当心它们的寄生攻击。",
    ExistState = {
      22074,
      83816,
      89574
    },
    StateLayers = "1,1",
    InitSkillList = {4734, 4042},
    CycleSkillList1 = {
      4787,
      4518,
      4734
    },
    AnimationID = 15648,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0501.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.25
  },
  [14100] = {
    ID = 14100,
    CnID = "怪物@小型星之眷族初生",
    BaseSortID = 236,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_14100_MonsterName|「新生」",
    Desc = "MonsterConfig_14100_Desc|变形者啜饮生命，为自己带来永恒的新生。",
    ExistState = {
      22074,
      83816,
      89574
    },
    StateLayers = "1,1",
    InitSkillList = {4555},
    CycleSkillList1 = {
      4787,
      4518,
      4734
    },
    AnimationID = 15648,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0501.png",
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.25
  },
  [14058] = {
    ID = 14058,
    CnID = "怪物@幻影水手A",
    BaseSortID = 237,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      94556,
      90643
    },
    MonsterName = "MonsterConfig_14058_MonsterName|水手的哀恸",
    Desc = "MonsterConfig_14058_Desc|曾随着货轮一同沉入深海的水手，这份哀伤的记忆永远刻印在了船上，永不消散。",
    ExistState = {22074, 83816},
    StateLayers = "1,1",
    InitSkillList = {
      4266,
      4293,
      4319,
      4293
    },
    CycleSkillList1 = {
      4293,
      4319,
      4293
    },
    AnimationID = 15673,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0504_AT.png",
    MonsterHpPercent = 1.2,
    MonsterAtkPercent = 0.93,
    MonsterDefPercent = 0.5,
    MonsterProportion = 0.6
  },
  [14057] = {
    ID = 14057,
    CnID = "怪物@幻影水手B",
    BaseSortID = 238,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      94556,
      90643
    },
    MonsterName = "MonsterConfig_14057_MonsterName|水手的恸哭",
    Desc = "MonsterConfig_14057_Desc|曾随着货轮一同沉入深海的水手，这滴痛苦的眼泪与船融为一体，永不分离。",
    ExistState = {22074, 83816},
    StateLayers = "1,1",
    InitSkillList = {
      4768,
      4218,
      4786,
      4768
    },
    CycleSkillList1 = {
      4768,
      4786,
      4768
    },
    AnimationID = 15672,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0504_BT.png",
    MonsterHpPercent = 0.85,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [120341] = {
    ID = 120341,
    CnID = "怪物@幻影水手A余烬",
    BaseSortID = 239,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      94556,
      90643
    },
    MonsterName = "MonsterConfig_120341_MonsterName|水手的哀恸",
    Desc = "MonsterConfig_120341_Desc|曾随着货轮一同沉入深海的水手，这份哀伤的记忆永远刻印在了船上，永不消散。",
    ExistState = {
      22074,
      83816,
      80787
    },
    StateLayers = "1,1,CmdCaster.max_hp*0.05",
    InitSkillList = {
      4266,
      4293,
      4319,
      4293
    },
    CycleSkillList1 = {
      4293,
      4319,
      4293
    },
    AnimationID = 15673,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0504_AT.png",
    MonsterHpPercent = 1.2,
    MonsterAtkPercent = 0.93,
    MonsterDefPercent = 0.5,
    MonsterProportion = 0.6
  },
  [120342] = {
    ID = 120342,
    CnID = "怪物@幻影水手B余烬",
    BaseSortID = 240,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      94556,
      90643
    },
    MonsterName = "MonsterConfig_120342_MonsterName|水手的恸哭",
    Desc = "MonsterConfig_120342_Desc|曾随着货轮一同沉入深海的水手，这滴痛苦的眼泪与船融为一体，永不分离。",
    ExistState = {
      22074,
      83816,
      80787
    },
    StateLayers = "1,1,CmdCaster.max_hp*0.05",
    InitSkillList = {
      4768,
      4218,
      4786,
      4768
    },
    CycleSkillList1 = {
      4768,
      4786,
      4768
    },
    AnimationID = 15672,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0504_BT.png",
    MonsterHpPercent = 0.85,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [14090] = {
    ID = 14090,
    CnID = "怪物@幻影水手精英",
    BaseSortID = 241,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      94556,
      90643
    },
    MonsterName = "MonsterConfig_14090_MonsterName|「远洋回忆」",
    Desc = "MonsterConfig_14090_Desc|为了生活奔赴大海，可成为一段记忆的现在，他早已遗失了那个故乡。",
    ExistState = {83816},
    StateLayers = 1,
    InitSkillList = {
      4431,
      4718,
      4754,
      4706,
      4718,
      4754
    },
    CycleSkillList1 = {
      4718,
      4754,
      4718,
      4754
    },
    AnimationID = 15672,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0504_BT.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 1.41,
    MonsterProportion = 1
  },
  [14024] = {
    ID = 14024,
    CnID = "怪物@幻影水手BOSS",
    BaseSortID = 242,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      94556,
      90643
    },
    MonsterName = "MonsterConfig_14024_MonsterName|「以实玛利」",
    Desc = "MonsterConfig_14024_Desc|这份记忆选择了讲述远洋的故事，以期留下曾存在过的痕迹。",
    ExistState = {83816},
    StateLayers = 1,
    InitSkillList = {
      4853,
      4650,
      4092,
      4298,
      4562,
      4650,
      4092,
      4298
    },
    CycleSkillList1 = {
      4650,
      4092,
      4298,
      4650,
      4092,
      4298
    },
    AnimationID = 15699,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0504_BOSSSIZE.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 3.68,
    MonsterProportion = 1
  },
  [13999] = {
    ID = 13999,
    CnID = "怪物@深潜者",
    BaseSortID = 243,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_13999_MonsterName|蹈海者",
    Desc = "MonsterConfig_13999_Desc|忠仆，孝子，虔信者。你可以用任何代表忠诚的词汇形容他们。",
    ExistState = {
      22074,
      83816,
      89574
    },
    StateLayers = "1,1",
    InitSkillList = {
      4577,
      4610,
      4517,
      3989,
      4816
    },
    CycleSkillList1 = {
      4577,
      4610,
      4517,
      3989,
      4816
    },
    AnimationID = 15771,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0502.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.9
  },
  [14073] = {
    ID = 14073,
    CnID = "怪物@深潜者精英",
    BaseSortID = 244,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90645,
      90643
    },
    MonsterName = "MonsterConfig_14073_MonsterName|「永恒狂热者」",
    Desc = "MonsterConfig_14073_Desc|杀戮、诵经、献祭……为了永恒之国，祂们将献出一切。",
    ExistState = {
      2921,
      83816,
      89574
    },
    StateLayers = "1,1",
    InitSkillList = {
      4223,
      4651,
      4863,
      4530,
      4796
    },
    CycleSkillList1 = {
      4223,
      4651,
      4863,
      4530,
      4796
    },
    AnimationID = 15771,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0502.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 3.66,
    MonsterProportion = 1
  },
  [14076] = {
    ID = 14076,
    CnID = "怪物@深潜者BOSS",
    BaseSortID = 245,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_14076_MonsterName|蹈海者亲卫",
    Desc = "MonsterConfig_14076_Desc|血的纽带赋予了祂们傲然亲族的权力，祂发誓永远为神明的降临而生。",
    ExistState = {
      2921,
      83816,
      89574
    },
    StateLayers = "1,1",
    InitSkillList = {
      4818,
      4473,
      4574,
      4255,
      4512
    },
    CycleSkillList1 = {
      4818,
      4473,
      4574,
      4255,
      4512
    },
    AnimationID = 15726,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0502_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 3.87,
    MonsterProportion = 1
  },
  [22339] = {
    ID = 22339,
    CnID = "怪物@深潜者BOSS达贡",
    BaseSortID = 246,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_22339_MonsterName|蹈海者近卫",
    Desc = "MonsterConfig_22339_Desc|血的纽带赋予了祂们傲然亲族的权力，祂发誓永远为主人的命令而动。",
    ExistState = {
      2921,
      22328,
      83816,
      89574
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      22316,
      22317,
      22318,
      22320,
      22319
    },
    CycleSkillList1 = {
      22316,
      22317,
      22318,
      22320,
      22319
    },
    AnimationID = 22327,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0502_BT_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 3.42,
    MonsterProportion = 1
  },
  [14081] = {
    ID = 14081,
    CnID = "怪物@蛇头人",
    BaseSortID = 247,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84283,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_14081_MonsterName|吟诵者",
    Desc = "MonsterConfig_14081_Desc|永恒之国的虔信者，神王最忠实的仆人。",
    ExistState = {
      22074,
      3014,
      83816,
      89574
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      4727,
      4362,
      4289,
      4642
    },
    CycleSkillList1 = {
      4727,
      4362,
      4289,
      4642
    },
    AnimationID = 15693,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0503.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.41,
    MonsterProportion = 1
  },
  [13967] = {
    ID = 13967,
    CnID = "怪物@蛇头人精英",
    BaseSortID = 248,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90645,
      90643
    },
    MonsterName = "MonsterConfig_13967_MonsterName|「永恒助祭」",
    Desc = "MonsterConfig_13967_Desc|永恒之国的低级祭司，在得到主祭首肯前，祂们不被允许踏入神殿。",
    ExistState = {
      2899,
      83816,
      89574
    },
    StateLayers = "1,1",
    InitSkillList = {
      4194,
      4259,
      3987,
      4761
    },
    CycleSkillList1 = {
      4194,
      4259,
      3987,
      4761
    },
    AnimationID = 15693,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0503.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.72,
    MonsterProportion = 1
  },
  [13964] = {
    ID = 13964,
    CnID = "怪物@蛇头人BOSS",
    BaseSortID = 249,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_13964_MonsterName|「波纳佩颂歌」",
    Desc = "MonsterConfig_13964_Desc|深受主祭信任的高级祭者，祂们匍匐主祭足边，对她俯首称臣。",
    ExistState = {
      3435,
      2899,
      83816,
      89574
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      4456,
      4621,
      4348,
      4494
    },
    CycleSkillList1 = {
      4456,
      4621,
      4348,
      4494
    },
    AnimationID = 15721,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0503_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.74,
    MonsterProportion = 1
  },
  [24249] = {
    ID = 24249,
    CnID = "怪物@祭礼蛇",
    BaseSortID = 250,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_24249_MonsterName|「阿吉达哈卡」",
    Desc = "MonsterConfig_24249_Desc|蹈海者们相信，弥利亚姆的力量来自旧日神明。她鞠躬尽瘁，将为神国献出一切。",
    ExistState = {
      2730,
      83816,
      147776
    },
    StateLayers = "1,1",
    InitSkillList = {
      4008,
      4008,
      4008
    },
    CycleSkillList1 = {4424},
    AnimationID = 15676,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0005_AT.png",
    MonsterHpPercent = 5.031,
    MonsterAtkPercent = 8.3688,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [24251] = {
    ID = 24251,
    CnID = "怪物@祭礼蛇B",
    BaseSortID = 251,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_24251_MonsterName|「勒耳纳恩」",
    Desc = "MonsterConfig_24251_Desc|蹈海者们相信，利莫里亚是神明的国度。而那位贤明的代行之王，本应带领神国迈入永世。",
    ExistState = {
      2730,
      83816,
      147776
    },
    StateLayers = "1,1",
    InitSkillList = {
      4008,
      4008,
      4008
    },
    CycleSkillList1 = {4363},
    AnimationID = 15768,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0005_BT.png",
    MonsterHpPercent = 5.031,
    MonsterAtkPercent = 8.3688,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [24248] = {
    ID = 24248,
    CnID = "怪物@祭礼蛇特殊",
    BaseSortID = 252,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_24248_MonsterName|「阿吉达哈卡」",
    Desc = "MonsterConfig_24248_Desc|蹈海者们相信，弥利亚姆的力量来自旧日神明。她鞠躬尽瘁，将为神国献出一切。",
    ExistState = {
      2730,
      83816,
      147776
    },
    StateLayers = "1,1",
    InitSkillList = {
      24243,
      4008,
      4008,
      4008
    },
    CycleSkillList1 = {4424},
    AnimationID = 15676,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0005_AT.png",
    MonsterHpPercent = 5.031,
    MonsterAtkPercent = 8.3688,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [24252] = {
    ID = 24252,
    CnID = "怪物@祭礼蛇特殊B",
    BaseSortID = 253,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_24252_MonsterName|「勒耳纳恩」",
    Desc = "MonsterConfig_24252_Desc|蹈海者们相信，利莫里亚是神明的国度。而那位贤明的代行之王，本应带领神国迈入永世。",
    ExistState = {
      2730,
      83816,
      147776
    },
    StateLayers = "1,1",
    InitSkillList = {
      24243,
      4008,
      4008,
      4008
    },
    CycleSkillList1 = {4363},
    AnimationID = 15768,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0005_BT.png",
    MonsterHpPercent = 5.031,
    MonsterAtkPercent = 8.3688,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [14082] = {
    ID = 14082,
    CnID = "怪物@癫狂海德拉",
    BaseSortID = 254,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_14082_MonsterName|「海德拉」",
    Desc = "MonsterConfig_14082_Desc|践行万古之言，明久远之志……一切皆如幻梦，从绚烂的梦境醒来，她却早已无法脱身。",
    ExistState = {
      3494,
      21345,
      3056,
      83816
    },
    StateLayers = "1,1,1,1",
    InitSkillList = {4705},
    CycleSkillList1 = {4813, 4471},
    CycleSkillList2 = {
      4532,
      4519,
      24418,
      24417,
      24418,
      24417,
      24418,
      24417,
      24418,
      24417,
      4519,
      24418,
      24417,
      24418,
      24417,
      24418,
      24417,
      24418,
      24417
    },
    AnimationID = 15670,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0005.png",
    MonsterHpPercent = 0.18,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [36008] = {
    ID = 36008,
    CnID = "怪物@假孕船蛸A",
    BaseSortID = 255,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84291,
      90643
    },
    MonsterName = "MonsterConfig_36008_MonsterName|「阿戈纳斯」",
    Desc = "MonsterConfig_36008_Desc|受「未知」影响后，发生异变的某种海洋生物。软化的外壳与皮肉紧密粘连，让它不再能像风帆般舒展。",
    ExistState = {
      36006,
      22074,
      83816
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      36003,
      36005,
      36004
    },
    CycleSkillList1 = {
      36003,
      36005,
      36004
    },
    AnimationID = 35594,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0601.png",
    MonsterHpPercent = 0.92,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0.51,
    MonsterProportion = 0.5
  },
  [36007] = {
    ID = 36007,
    CnID = "怪物@假孕船蛸B",
    BaseSortID = 256,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84291,
      90643
    },
    MonsterName = "MonsterConfig_36007_MonsterName|「奥格诺茨」",
    Desc = "MonsterConfig_36007_Desc|受「未知」影响后，发生异变的某种海洋生物。软化的外壳与皮肉紧密粘连，强行剥离，只会让它永远失去抵达彼岸的能力。",
    ExistState = {
      36006,
      22074,
      83816
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      36005,
      36004,
      36003
    },
    CycleSkillList1 = {
      36005,
      36004,
      36003
    },
    AnimationID = 35594,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0601.png",
    MonsterHpPercent = 0.8,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0.76,
    MonsterProportion = 0.5
  },
  [35584] = {
    ID = 35584,
    CnID = "怪物@假孕深潜者",
    BaseSortID = 257,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_35584_MonsterName|「寄生种」",
    Desc = "MonsterConfig_35584_Desc|因「灾厄」影响而异变的蹈海者，赘生物自内向外生长，将它蚕食成一具空壳。",
    ExistState = {
      36022,
      36024,
      22074,
      83816,
      89574
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      36036,
      36047,
      36042,
      36031,
      36029
    },
    CycleSkillList1 = {
      36036,
      36047,
      36042,
      36031,
      36029
    },
    AnimationID = 35597,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0602.png",
    MonsterHpPercent = 1.8,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.1,
    MonsterProportion = 0.6
  },
  [35580] = {
    ID = 35580,
    CnID = "怪物@假孕蛇头人",
    BaseSortID = 258,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_35580_MonsterName|「养育者」",
    Desc = "MonsterConfig_35580_Desc|它的模样大变，只令人隐约感到熟悉。数次对视后，你才意识到这是无法抵抗「灾厄」影响的蹈海者助祭。",
    ExistState = {
      22074,
      3014,
      83816,
      89574
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      36366,
      36367,
      36368,
      36365
    },
    CycleSkillList1 = {
      36366,
      36367,
      36368,
      36365
    },
    AnimationID = 35599,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0603.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 3.51,
    MonsterProportion = 1
  },
  [36369] = {
    ID = 36369,
    CnID = "怪物@假孕蛇头人精英",
    BaseSortID = 259,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90645,
      90643
    },
    MonsterName = "MonsterConfig_36369_MonsterName|「受控者」",
    Desc = "MonsterConfig_36369_Desc|出于生命的本能，它心甘情愿供养着寄生物。",
    ExistState = {
      36632,
      3014,
      36631,
      2921,
      83816,
      89574
    },
    StateLayers = "1,1,1,1,1",
    StateParams = "CmdCaster.atk*0.05",
    InitSkillList = {
      36657,
      36652,
      36650,
      36654
    },
    CycleSkillList1 = {
      36657,
      36652,
      36650,
      36654
    },
    AnimationID = 35599,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0603.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 4.53,
    MonsterProportion = 1
  },
  [35581] = {
    ID = 35581,
    CnID = "怪物@珊瑚深潜者",
    BaseSortID = 260,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_35581_MonsterName|「佩因」",
    Desc = "MonsterConfig_35581_Desc|在潜入大洋，越过深海前，它记得佩因街是通向广场的一条窄路。",
    ExistState = {
      36022,
      36023,
      22074,
      83816,
      89574
    },
    StateLayers = "1,1,1,1",
    InitSkillList = {
      36040,
      36039,
      36035,
      36049
    },
    CycleSkillList1 = {
      36040,
      36039,
      36035,
      36049
    },
    AnimationID = 35593,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0602_AT.png",
    MonsterHpPercent = 1.8,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.32,
    MonsterProportion = 0.6
  },
  [36117] = {
    ID = 36117,
    CnID = "怪物@珊瑚深潜者精英",
    BaseSortID = 261,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90645,
      90643
    },
    MonsterName = "MonsterConfig_36117_MonsterName|「瓦拉几亚」",
    Desc = "MonsterConfig_36117_Desc|在潜入大洋，越过深海前，它曾以为自己不会流淌着这样的血脉。",
    ExistState = {
      36022,
      2921,
      83816,
      89574
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      36045,
      36046,
      36041,
      36025,
      36048
    },
    CycleSkillList1 = {
      36045,
      36046,
      36041,
      36025,
      36048
    },
    AnimationID = 35593,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0602_AT.png",
    MonsterHpPercent = 1.8,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.84,
    MonsterProportion = 0.9
  },
  [36114] = {
    ID = 36114,
    CnID = "怪物@假孕深潜者精英",
    BaseSortID = 262,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90645,
      90643
    },
    MonsterName = "MonsterConfig_36114_MonsterName|「寄主」",
    Desc = "MonsterConfig_36114_Desc|它不受控制地向未知奉献出自己的肉身，没有人在意它的意志。",
    ExistState = {
      36022,
      2921,
      83816,
      89574
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      36043,
      36044,
      36034,
      36027,
      36032
    },
    CycleSkillList1 = {
      36043,
      36044,
      36034,
      36027,
      36032
    },
    AnimationID = 35597,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0602.png",
    MonsterHpPercent = 1.8,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.05,
    MonsterProportion = 0.9
  },
  [36065] = {
    ID = 36065,
    CnID = "怪物@假孕深潜者BOSS",
    BaseSortID = 263,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_36065_MonsterName|「永恒寄主」",
    Desc = "MonsterConfig_36065_Desc|它不受控制地向未知奉献出自己的肉身，没有人在意它的意志。",
    ExistState = {
      36022,
      2921,
      83816,
      89574
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      36038,
      36037,
      36028,
      36033,
      36026
    },
    CycleSkillList1 = {
      36038,
      36037,
      36028,
      36033,
      36026
    },
    AnimationID = 36066,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0602_BOSSSIZE.png",
    MonsterHpPercent = 1.9,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.52,
    MonsterProportion = 0.9
  },
  [36658] = {
    ID = 36658,
    CnID = "怪物@假孕蛇头人BOSS",
    BaseSortID = 264,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_36658_MonsterName|「海之@2」",
    Desc = "MonsterConfig_36658_Desc|她放弃了抵抗「灾厄」的侵蚀，精神维度的污染，让曾经矜贵强大的唤醒体，染上了彻头彻尾的疯狂。",
    ExistState = {
      36632,
      3014,
      36635,
      2921,
      83816,
      89574
    },
    StateLayers = "1,1,1,1,1,1,1",
    StateParams = "CmdCaster.atk*0.03",
    InitSkillList = {
      36651,
      36656,
      36648,
      36649
    },
    CycleSkillList1 = {
      36651,
      36656,
      36648,
      36649
    },
    AnimationID = 15732,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O07_AF.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 3.33,
    MonsterProportion = 0.9
  },
  [35579] = {
    ID = 35579,
    CnID = "怪物@珊瑚蛇头人",
    BaseSortID = 265,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_35579_MonsterName|「塞勒菲斯的倒影」",
    Desc = "MonsterConfig_35579_Desc|珊瑚、寄生物……不同的赘生物是否来自同一灾厄的源头？我们无从知晓。",
    ExistState = {
      22074,
      83816,
      89574
    },
    StateLayers = "1,1",
    InitSkillList = {
      36080,
      36086,
      36078,
      36081
    },
    CycleSkillList1 = {
      36080,
      36086,
      36078,
      36081
    },
    AnimationID = 35600,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0603_AT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 3.4,
    MonsterProportion = 1
  },
  [36120] = {
    ID = 36120,
    CnID = "怪物@珊瑚蛇头人精英",
    BaseSortID = 266,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90645,
      90643
    },
    MonsterName = "MonsterConfig_36120_MonsterName|「恩瑟雷的回音」",
    Desc = "MonsterConfig_36120_Desc|珊瑚、寄生物……不同的赘生物是否来自同一灾厄的源头？我们无从知晓。",
    ExistState = {
      36093,
      2921,
      83816,
      89574
    },
    StateLayers = "CmdCaster.max_hp*0.25,1,1",
    InitSkillList = {
      36090,
      36083,
      36084,
      36077
    },
    CycleSkillList1 = {
      36090,
      36083,
      36084,
      36077
    },
    AnimationID = 35600,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0603_AT.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 3.82,
    MonsterProportion = 1
  },
  [36118] = {
    ID = 36118,
    CnID = "怪物@珊瑚蛇头人BOSS",
    BaseSortID = 267,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_36118_MonsterName|「伊恩斯莫的守卫」",
    Desc = "MonsterConfig_36118_Desc|它与赘生物融合得是如此恰到好处，美丽到几乎让人以为它本该如此。",
    ExistState = {
      36094,
      2921,
      36199,
      83816,
      89574
    },
    StateLayers = "CmdCaster.max_hp*0.15,1,1,1",
    InitSkillList = {
      36082,
      36085,
      36088,
      36079,
      36177,
      36085,
      36088,
      36079
    },
    CycleSkillList1 = {
      36082,
      36085,
      36088,
      36079,
      36177,
      36085,
      36088,
      36079
    },
    AnimationID = 35589,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0603_AT_BOSSSIZE.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 3.21,
    MonsterProportion = 0.9
  },
  [36113] = {
    ID = 36113,
    CnID = "怪物@畸变神胎A肉盾",
    BaseSortID = 268,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643,
      84303
    },
    MonsterName = "MonsterConfig_36113_MonsterName|睡梦之子",
    Desc = "MonsterConfig_36113_Desc|如果可以，它也不愿醒来。",
    ExistState = {
      35971,
      22074,
      83816,
      89574
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      35965,
      35962,
      36179
    },
    CycleSkillList1 = {
      35965,
      35962,
      36179
    },
    AnimationID = 35591,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0604.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 1.23,
    MonsterProportion = 0.2
  },
  [36112] = {
    ID = 36112,
    CnID = "怪物@畸变神胎A召唤",
    BaseSortID = 269,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643,
      84303
    },
    MonsterName = "MonsterConfig_36112_MonsterName|睡梦之子",
    Desc = "MonsterConfig_36112_Desc|如果可以，它也不愿醒来。",
    ExistState = {
      35971,
      36154,
      83816,
      89574
    },
    StateLayers = "1,1,1",
    InitSkillList = {35965, 35963},
    CycleSkillList1 = {35965, 35963},
    AnimationID = 35591,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0604.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 1.64,
    MonsterProportion = 0.2
  },
  [36116] = {
    ID = 36116,
    CnID = "怪物@畸变神胎C",
    BaseSortID = 270,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643,
      84303
    },
    MonsterName = "MonsterConfig_36116_MonsterName|灵觉之子",
    Desc = "MonsterConfig_36116_Desc|它脑子里那些疯狂的想法，注定胎死腹中。",
    ExistState = {
      36111,
      36154,
      83816,
      89574,
      22074
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      36087,
      36089,
      36076
    },
    CycleSkillList1 = {
      36087,
      36089,
      36076
    },
    AnimationID = 35598,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0604_CT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 1.64,
    MonsterProportion = 0.2
  },
  [36364] = {
    ID = 36364,
    CnID = "怪物@畸变神胎D",
    BaseSortID = 271,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643,
      84303
    },
    MonsterName = "MonsterConfig_36364_MonsterName|「利莫里亚的希望」",
    Desc = "MonsterConfig_36364_Desc|弥利亚姆无比笃定，它是神明承认她虔诚的证明。",
    ExistState = {
      36361,
      83816,
      89574,
      22074
    },
    StateLayers = "CmdCaster.atk*0.3,1",
    InitSkillList = {
      36358,
      36357,
      36356
    },
    CycleSkillList1 = {
      36358,
      36357,
      36356
    },
    AnimationID = 35596,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0604_AT.png",
    MonsterHpPercent = 0.18,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [36115] = {
    ID = 36115,
    CnID = "怪物@畸变神胎B侵食",
    BaseSortID = 272,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643,
      84303
    },
    MonsterName = "MonsterConfig_36115_MonsterName|水之子",
    Desc = "MonsterConfig_36115_Desc|与常识相悖，它讨厌水。",
    ExistState = {
      35970,
      22074,
      83816,
      89574
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      35960,
      35964,
      36180
    },
    CycleSkillList1 = {
      35960,
      35964,
      36180
    },
    AnimationID = 35592,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0604_BT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 0.25,
    MonsterProportion = 0.2
  },
  [36119] = {
    ID = 36119,
    CnID = "怪物@畸变神胎B召唤",
    BaseSortID = 273,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643,
      84303
    },
    MonsterName = "MonsterConfig_36119_MonsterName|水之子",
    Desc = "MonsterConfig_36119_Desc|与常识相悖，它讨厌水。",
    ExistState = {
      35970,
      36154,
      83816,
      89574
    },
    StateLayers = "1,1,1",
    InitSkillList = {35960, 35961},
    CycleSkillList1 = {35960, 35961},
    AnimationID = 35592,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0604_BT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 0.33,
    MonsterProportion = 0.2
  },
  [35585] = {
    ID = 35585,
    CnID = "怪物@胚胎变异珊瑚",
    BaseSortID = 274,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643,
      84303
    },
    MonsterName = "MonsterConfig_35585_MonsterName|灵觉之子",
    Desc = "MonsterConfig_35585_Desc|它脑子里那些疯狂的想法，注定胎死腹中。",
    ExistState = {89574},
    InitSkillList = {4586},
    CycleSkillList1 = {4586, 35671},
    AnimationID = 35598,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0604_CT.png",
    MonsterHpPercent = 0.18,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [35132] = {
    ID = 35132,
    CnID = "怪物@圣婴",
    BaseSortID = 275,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84294,
      90643
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_35132_MonsterName|「圣婴」",
    Desc = "MonsterConfig_35132_Desc|祂在沉眠中静候，静候世界的臣服，静候现实的膜拜。",
    ExistState = {
      36242,
      36314,
      36335,
      36346,
      36781,
      83816
    },
    StateLayers = "1,1,1,1,1,1",
    StateParams = "CmdCaster.def*2,CmdCaster.atk*0.06",
    InitSkillList = {
      36255,
      36255,
      36255
    },
    CycleSkillList1 = {36260, 36259},
    CycleSkillList2 = {36256, 36258},
    AnimationID = 35134,
    ExAnimations = {35133},
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0006_AT.png",
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.21,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [14028] = {
    ID = 14028,
    CnID = "怪物@普通猎颅者",
    BaseSortID = 276,
    BattleTag = "Boss",
    MonsterTag = {84277, 90645},
    MonsterName = "MonsterConfig_14028_MonsterName|猎颅者",
    Desc = "MonsterConfig_14028_Desc|手持镰刀的神秘来客。它对头颅的欲望永无止境。",
    ExistState = {23741, 131682},
    StateLayers = 1,
    InitSkillList = {
      4382,
      4447,
      4795,
      4437
    },
    CycleSkillList1 = {
      4382,
      4447,
      4795,
      4437
    },
    AnimationID = 21695,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD02_01_BT_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.28,
    MonsterProportion = 1
  },
  [14097] = {
    ID = 14097,
    CnID = "怪物@无头猎颅者",
    BaseSortID = 277,
    BattleTag = "Boss",
    MonsterTag = {84277, 90645},
    MonsterName = "MonsterConfig_14097_MonsterName|无头猎颅者",
    Desc = "MonsterConfig_14097_Desc|失去头颅的猎颅者。它无法忍受残缺。",
    InitSkillList = {
      21668,
      4731,
      4340,
      4309
    },
    CycleSkillList1 = {
      21668,
      4731,
      4340,
      4309
    },
    AnimationID = 21694,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD02_01_AT_BOSSSIZE.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 1.14,
    MonsterProportion = 1
  },
  [131444] = {
    ID = 131444,
    CnID = "怪物@无头猎颅者精英",
    BaseSortID = 278,
    BattleTag = "Elite",
    MonsterTag = {84277, 90645},
    MonsterName = "MonsterConfig_131444_MonsterName|无头猎颅者",
    Desc = "MonsterConfig_131444_Desc|失去头颅的猎颅者。它无法忍受残缺。",
    InitSkillList = {
      21668,
      4731,
      4340,
      4309
    },
    CycleSkillList1 = {
      21668,
      4731,
      4340,
      4309
    },
    AnimationID = 21694,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD02_01_AT_BOSSSIZE.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 1.14,
    MonsterProportion = 1
  },
  [13980] = {
    ID = 13980,
    CnID = "怪物@暴走猎颅者",
    BaseSortID = 279,
    BattleTag = "Boss",
    MonsterTag = {84277, 90645},
    MonsterName = "MonsterConfig_13980_MonsterName|暴走猎颅者",
    Desc = "MonsterConfig_13980_Desc|滑滑的、黏黏的。头颅们温暖的家。",
    ExistState = {
      20019,
      21829,
      23744
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      4094,
      4104,
      3974,
      21721
    },
    CycleSkillList1 = {
      4094,
      4104,
      3974,
      21721
    },
    AnimationID = 21697,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD02_02_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.26,
    MonsterProportion = 1
  },
  [14112] = {
    ID = 14112,
    CnID = "怪物@记忆封印",
    BaseSortID = 280,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 84283},
    MonsterName = "MonsterConfig_14112_MonsterName|死者No.12",
    Desc = "MonsterConfig_14112_Desc|吧唧，吧唧。它能一口吃掉你的记忆。",
    ExistState = {21754},
    StateLayers = 1,
    InitSkillList = {4723},
    CycleSkillList1 = {4723},
    AnimationID = 21766,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0301.png",
    MonsterHpPercent = 0.12,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1,
    MonsterProportion = 1
  },
  [30363] = {
    ID = 30363,
    CnID = "怪物@唤醒体卡茜亚@分身",
    BaseSortID = 281,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84297,
      143654
    },
    MonsterName = "MonsterConfig_30363_MonsterName|「奇术师」的分身",
    Desc = "MonsterConfig_30363_Desc|魔术大师卡茜亚的助手——或者说，魔术道具。",
    ExistState = {35277},
    StateLayers = 1,
    InitSkillList = {30362},
    CycleSkillList1 = {30362},
    AnimationID = 15742,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D09_AF.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [23774] = {
    ID = 23774,
    CnID = "怪物@大魔术师胡迪尼",
    BaseSortID = 282,
    BattleTag = "Boss",
    MonsterTag = {84277, 143654},
    MonsterName = "MonsterConfig_23774_MonsterName|「大魔术师霍迪妮」",
    Desc = "MonsterConfig_23774_Desc|大魔术师霍迪妮闪亮登场！根据海报上的自我介绍，曾有41人在她的演出现场失踪。",
    ExistState = {
      30358,
      34685,
      2921,
      89574
    },
    StateLayers = 1,
    InitSkillList = {23816},
    CycleSkillList1 = {
      23813,
      23811,
      23815,
      23818
    },
    CycleSkillList2 = {
      23813,
      23811,
      23815,
      23818
    },
    AnimationID = 24169,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCC10_01_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.46,
    MonsterProportion = 1
  },
  [25393] = {
    ID = 25393,
    CnID = "怪物@大魔术师的玩偶",
    BaseSortID = 283,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84283},
    MonsterName = "MonsterConfig_25393_MonsterName|「霍迪妮」的玩偶",
    Desc = "MonsterConfig_25393_Desc|大魔术师霍迪妮忠实的魔术道具，或许，它就是那四十一分之一？",
    InitSkillList = {25389},
    CycleSkillList1 = {25389},
    AnimationID = 15658,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0206.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [60100] = {
    ID = 60100,
    CnID = "怪物@N的幻影精英版",
    BaseSortID = 284,
    BattleTag = "Elite",
    MonsterTag = {84277, 143654},
    MonsterName = "MonsterConfig_60100_MonsterName|「N？」",
    Desc = "MonsterConfig_60100_Desc|一个玩笑。",
    ExistState = {89574},
    StateLayers = 1,
    InitSkillList = {
      25175,
      25176,
      25174,
      25173
    },
    CycleSkillList1 = {
      25175,
      25176,
      25174,
      25173
    },
    CycleSkillList2 = {
      25175,
      25176,
      25174,
      25173
    },
    AnimationID = 24168,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCB04_01_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.87,
    MonsterProportion = 1
  },
  [24592] = {
    ID = 24592,
    CnID = "怪物@N",
    BaseSortID = 285,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84294,
      143654
    },
    MonsterName = "MonsterConfig_24592_MonsterName|「N」",
    Desc = "MonsterConfig_24592_Desc|伏行世间的混沌之雾，祂因人类的痛苦与绝望而愉悦。",
    ExistState = {
      24594,
      25195,
      25206,
      2921,
      89574
    },
    StateLayers = 1,
    InitSkillList = {24605},
    CycleSkillList1 = {
      24609,
      24608,
      24606
    },
    CycleSkillList2 = {
      24609,
      24608,
      24606
    },
    AnimationID = 24168,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCB04_01_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.87,
    MonsterProportion = 1
  },
  [59880] = {
    ID = 59880,
    CnID = "怪物@N完全体",
    BaseSortID = 286,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84294,
      143654
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_59880_MonsterName|「N」",
    Desc = "MonsterConfig_59880_Desc|伏行世间的混沌之雾，祂因人类的痛苦与绝望而愉悦。",
    ExistState = {
      24594,
      25195,
      25206,
      59876,
      2921,
      89574
    },
    StateLayers = 1,
    InitSkillList = {24605},
    CycleSkillList1 = {
      24609,
      24608,
      24606
    },
    CycleSkillList2 = {
      24609,
      60060,
      24609,
      60060,
      24609,
      60060,
      24609,
      60060
    },
    AnimationID = 24168,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCB04_01_BOSSSIZE.png",
    MonsterHpPercent = 0.33,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.87,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [24176] = {
    ID = 24176,
    CnID = "怪物@N的分身",
    BaseSortID = 287,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      143654
    },
    MonsterName = "MonsterConfig_24176_MonsterName|盲目者",
    Desc = "MonsterConfig_24176_Desc|「N」的分身之一。它笨拙地吹响笛声。",
    ExistState = {
      24595,
      24879,
      25194,
      89574
    },
    StateLayers = 1,
    InitSkillList = {
      24649,
      24648,
      24587
    },
    CycleSkillList1 = {
      24649,
      24648,
      24587
    },
    AnimationID = 24614,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCB04_01_BT_BOSSSIZE.png",
    MonsterHpPercent = 0.45,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 5.51,
    MonsterProportion = 1
  },
  [24643] = {
    ID = 24643,
    CnID = "怪物@N的分身2",
    BaseSortID = 288,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      143654
    },
    MonsterName = "MonsterConfig_24643_MonsterName|混沌者",
    Desc = "MonsterConfig_24643_Desc|「N」的分身之一。它缓慢地跳起舞蹈。",
    ExistState = {
      24595,
      24879,
      25194,
      89574
    },
    StateLayers = 1,
    InitSkillList = {
      24706,
      24695,
      24705
    },
    CycleSkillList1 = {
      24706,
      24695,
      24705
    },
    AnimationID = 24614,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCB04_01_BT_BOSSSIZE.png",
    MonsterHpPercent = 0.45,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 5.51,
    MonsterProportion = 1
  },
  [24644] = {
    ID = 24644,
    CnID = "怪物@N的分身3",
    BaseSortID = 289,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      143654
    },
    MonsterName = "MonsterConfig_24644_MonsterName|迷雾者",
    Desc = "MonsterConfig_24644_Desc|「N」的分身之一。它荒谬地吟诵诗篇。",
    ExistState = {
      24595,
      24879,
      25194,
      89574
    },
    StateLayers = 1,
    InitSkillList = {
      24697,
      24703,
      24696
    },
    CycleSkillList1 = {
      24697,
      24703,
      24696
    },
    AnimationID = 24614,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCB04_01_BT_BOSSSIZE.png",
    MonsterHpPercent = 0.45,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 5.51,
    MonsterProportion = 1
  },
  [54102] = {
    ID = 54102,
    CnID = "怪物@玫瑰花怪A",
    BaseSortID = 290,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84299},
    MonsterName = "MonsterConfig_54102_MonsterName|欲之花",
    Desc = "MonsterConfig_54102_Desc|往昔的花园中，欲望是仅有的养分。",
    ExistState = {140645, 22074},
    InitSkillList = {
      54450,
      54451,
      54443,
      52078
    },
    CycleSkillList1 = {
      54450,
      54451,
      54443,
      52078
    },
    AnimationID = 52082,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD06_01.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1.02,
    MonsterDefPercent = 1.89,
    MonsterProportion = 0.55
  },
  [54103] = {
    ID = 54103,
    CnID = "怪物@玫瑰花怪B",
    BaseSortID = 291,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84299},
    MonsterName = "MonsterConfig_54103_MonsterName|婪之花",
    Desc = "MonsterConfig_54103_Desc|贪婪是人生唯一的意象。不是吗？",
    ExistState = {140645, 22074},
    InitSkillList = {
      54443,
      52078,
      54450,
      54451
    },
    CycleSkillList1 = {
      54443,
      52078,
      54450,
      54451
    },
    AnimationID = 52082,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD06_01.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = 1.89,
    MonsterProportion = 0.55
  },
  [52080] = {
    ID = 52080,
    CnID = "怪物@玫瑰花怪BOSS",
    BaseSortID = 292,
    BattleTag = "Boss",
    MonsterTag = {84277, 84299},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_52080_MonsterName|「致奥尔拉」",
    Desc = "MonsterConfig_52080_Desc|在自己所写的唯一一首诗中，她描述花园、阳光、欢笑。她用花瓣埋葬挚友的身躯。在诗中，她良善如同玫瑰。",
    ExistState = {
      140651,
      2921,
      54577
    },
    InitSkillList = {
      54446,
      54439,
      54448,
      54448
    },
    CycleSkillList1 = {
      54439,
      54448,
      54448
    },
    CycleSkillList2 = {
      54439,
      54446,
      54456,
      54439,
      54457,
      54439,
      54445
    },
    AnimationID = 52083,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD06_01_BOSSSIZE.png",
    MonsterHpPercent = 0.25,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.2,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [56172] = {
    ID = 56172,
    CnID = "怪物@小型黑泥怪彩墨A",
    BaseSortID = 293,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_56172_MonsterName|追随者",
    Desc = "MonsterConfig_56172_Desc|在诗中的西岱，他们追随柯蕾特的身影。",
    ExistState = {140659, 22074},
    InitSkillList = {
      54458,
      54459,
      54460
    },
    CycleSkillList1 = {
      54458,
      54459,
      54460
    },
    AnimationID = 140584,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD06_02.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = -0.75,
    MonsterProportion = 0.4
  },
  [56173] = {
    ID = 56173,
    CnID = "怪物@小型黑泥怪彩墨B",
    BaseSortID = 294,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_56173_MonsterName|渴求者",
    Desc = "MonsterConfig_56173_Desc|在诗中的西岱，他们渴求柯蕾特的恩典。",
    ExistState = {140659, 22074},
    InitSkillList = {
      54460,
      54458,
      54459
    },
    CycleSkillList1 = {
      54460,
      54458,
      54459
    },
    AnimationID = 140584,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD06_02.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = -0.75,
    MonsterProportion = 0.4
  },
  [56170] = {
    ID = 56170,
    CnID = "怪物@大型黑泥怪精英彩墨",
    BaseSortID = 295,
    BattleTag = "Elite",
    MonsterTag = {90641, 84293},
    MonsterName = "MonsterConfig_56170_MonsterName|伯爵夫人",
    Desc = "MonsterConfig_56170_Desc|「亲爱的伯爵夫人，我曾经的渴望。而如今，你已成为了我忠实的侍卫。替我向她，献上一首诗吧。」",
    ExistState = {140654, 89575},
    InitSkillList = {
      54453,
      54441,
      54449,
      54461
    },
    CycleSkillList1 = {
      54453,
      54441,
      54449,
      54461
    },
    AnimationID = 140583,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD06_03.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.9,
    MonsterProportion = 1
  },
  [56169] = {
    ID = 56169,
    CnID = "怪物@大型黑泥怪彩墨",
    BaseSortID = 296,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 84293},
    MonsterName = "MonsterConfig_56169_MonsterName|诗中人",
    Desc = "MonsterConfig_56169_Desc|坚定的拥护者，这是她能写出的全部意象。",
    ExistState = {
      140654,
      89575,
      22074
    },
    InitSkillList = {
      54454,
      54444,
      54447,
      54461
    },
    CycleSkillList1 = {
      54454,
      54444,
      54447,
      54461
    },
    AnimationID = 140583,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD06_03.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.9,
    MonsterProportion = 1
  },
  [54466] = {
    ID = 54466,
    CnID = "怪物@丛生玫瑰A",
    BaseSortID = 297,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84299},
    MonsterName = "MonsterConfig_54466_MonsterName|荆棘侍从",
    Desc = "MonsterConfig_54466_Desc|「在我们渺小的王国里，我会为你，撑起所有荆棘」",
    ExistState = {56372},
    InitSkillList = {54455, 54442},
    CycleSkillList1 = {54455, 54442},
    AnimationID = 52082,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD06_01.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1.02,
    MonsterDefPercent = 1.89,
    MonsterProportion = 0.55
  },
  [54465] = {
    ID = 54465,
    CnID = "怪物@丛生玫瑰B",
    BaseSortID = 298,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84299},
    MonsterName = "MonsterConfig_54465_MonsterName|荆棘侍从",
    Desc = "MonsterConfig_54465_Desc|「在我们渺小的王国里，我会为你，撑起所有荆棘」",
    ExistState = {56372},
    InitSkillList = {54442, 54455},
    CycleSkillList1 = {54442, 54455},
    AnimationID = 52082,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD06_01.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = 1.89,
    MonsterProportion = 0.55
  },
  [57143] = {
    ID = 57143,
    CnID = "怪物@亚弗姆扎",
    BaseSortID = 299,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_57143_MonsterName|亚弗姆扎",
    Desc = "MonsterConfig_57143_Desc|艾尔沃斯的神祇，提灯的改造之物，为雪山的重生燃起永恒不灭的冰焰。",
    ExistState = {
      65249,
      65342,
      2921,
      89574
    },
    InitSkillList = {
      57141,
      62312,
      57140,
      62311
    },
    CycleSkillList1 = {
      57141,
      62312,
      57140,
      62311
    },
    CycleSkillList2 = {
      62315,
      57140,
      62316,
      65341
    },
    AnimationID = 57144,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCB05_01.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [61538] = {
    ID = 61538,
    CnID = "怪物@亚弗姆扎小怪",
    BaseSortID = 300,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      84284
    },
    MonsterName = "MonsterConfig_61538_MonsterName|冷冽之灵",
    Desc = "MonsterConfig_61538_Desc|亚弗姆扎的冰焰与融蚀所结合出的产物。逡巡于终年极寒的艾尔沃斯，狩猎每一位合格的祭品。",
    ExistState = {65332, 89574},
    InitSkillList = {61535, 61537},
    CycleSkillList1 = {61535, 61537},
    AnimationID = 61539,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCB05_02.png",
    MonsterHpPercent = 0.25,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.2,
    MonsterProportion = 1
  },
  [65333] = {
    ID = 65333,
    CnID = "怪物@亚弗姆扎小怪2",
    BaseSortID = 301,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      84284
    },
    MonsterName = "MonsterConfig_65333_MonsterName|冷冽之灵",
    Desc = "MonsterConfig_65333_Desc|亚弗姆扎的冰焰与融蚀所结合出的产物。逡巡于终年极寒的艾尔沃斯，狩猎每一位合格的祭品。",
    ExistState = {65332, 89574},
    InitSkillList = {61537, 61535},
    CycleSkillList1 = {61537, 61535},
    AnimationID = 61539,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCB05_02.png",
    MonsterHpPercent = 0.25,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.2,
    MonsterProportion = 1
  },
  [25133] = {
    ID = 25133,
    CnID = "怪物@小型黑泥怪本源拉蒙娜1",
    BaseSortID = 302,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_25133_MonsterName|「艾米丽」",
    Desc = "MonsterConfig_25133_Desc|被融蚀浆蚀化的弥萨格学生，形貌凄惨。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      4478,
      4586,
      4364
    },
    CycleSkillList1 = {
      4478,
      4586,
      4364,
      4478
    },
    AnimationID = 15751,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0001.png",
    MonsterHpPercent = 1.9,
    MonsterAtkPercent = 2.1,
    MonsterDefPercent = -0.75,
    MonsterProportion = 0.4
  },
  [25134] = {
    ID = 25134,
    CnID = "怪物@小型黑泥怪本源拉蒙娜2",
    BaseSortID = 303,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_25134_MonsterName|「海伦」",
    Desc = "MonsterConfig_25134_Desc|被融蚀浆蚀化的弥萨格学生，形貌凄惨。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      4364,
      4478,
      4586
    },
    CycleSkillList1 = {
      4364,
      4478,
      4586,
      4364
    },
    AnimationID = 15753,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0001.png",
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0.38,
    MonsterProportion = 0.4
  },
  [25135] = {
    ID = 25135,
    CnID = "怪物@大型黑泥怪本源拉蒙娜3",
    BaseSortID = 304,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 84293},
    MonsterName = "MonsterConfig_25135_MonsterName|「前辈」玛丽",
    Desc = "MonsterConfig_25135_Desc|哀泣的黑色怪物表面浮现出似曾相识的脸……",
    ExistState = {22074, 89575},
    StateLayers = 1,
    InitSkillList = {
      4862,
      4490,
      4614,
      4034
    },
    CycleSkillList1 = {
      4862,
      4490,
      4614,
      4034
    },
    AnimationID = 15623,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0002.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.87,
    MonsterProportion = 1
  },
  [25162] = {
    ID = 25162,
    CnID = "怪物@N弱化版",
    BaseSortID = 305,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84294,
      143654
    },
    MonsterName = "MonsterConfig_25162_MonsterName|「千面@2」",
    Desc = "MonsterConfig_25162_Desc|萦绕歌剧院内的幻影。祂的落败亦是故事的一部分。",
    StateLayers = 1,
    InitSkillList = {
      25175,
      25176,
      25174,
      25173
    },
    CycleSkillList1 = {
      25175,
      25176,
      25174,
      25173
    },
    AnimationID = 24168,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCB04_01_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.31,
    MonsterProportion = 1
  },
  [44479] = {
    ID = 44479,
    CnID = "怪物@索菲亚精英",
    BaseSortID = 306,
    BattleTag = "Elite",
    MonsterTag = {90641, 90645},
    MonsterName = "MonsterConfig_44479_MonsterName|「索菲亚」",
    Desc = "MonsterConfig_44479_Desc|悲苦的命运将她扭曲。一切都是仇恨，一切都是不公。",
    ExistState = {44752},
    StateLayers = "CmdCaster.max_hp*0.33",
    StateParams = "CmdCaster.max_hp*0.15,CmdCaster.max_hp*0.33",
    InitSkillList = {
      44612,
      44680,
      44677
    },
    CycleSkillList1 = {
      44612,
      44680,
      44677
    },
    AnimationID = 43797,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCB02_02.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [44480] = {
    ID = 44480,
    CnID = "怪物@人面犬BOSS",
    BaseSortID = 307,
    BattleTag = "Boss",
    MonsterTag = {84277, 90645},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_44480_MonsterName|「审判」的使徒",
    Desc = "MonsterConfig_44480_Desc|她抛却人形，抛却人性，只为带来虚幻的幸福。但极端的善举是否还能被称为善举？",
    ExistState = {44807, 45210},
    StateLayers = "CmdCaster.max_hp,1,1",
    StateParams = "CmdCaster.max_hp",
    InitSkillList = {
      44681,
      44679,
      44678,
      44675
    },
    CycleSkillList1 = {
      44681,
      44679,
      44678,
      44675
    },
    AnimationID = 60902,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCB02_01_BOSSSIZE.png",
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 0.66,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [60097] = {
    ID = 60097,
    CnID = "怪物@鬼面犬BOSS",
    BaseSortID = 308,
    BattleTag = "Boss",
    MonsterTag = {84277, 90645},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_60097_MonsterName|阴影的忠犬",
    Desc = "MonsterConfig_60097_Desc|他不介意为于丽埃特的光明而伏于阴影。能成为于丽埃特的犬，是他一生中最崇高的荣耀。",
    ExistState = {60564, 45210},
    StateLayers = "CmdCaster.max_hp,1,1",
    StateParams = "CmdCaster.max_hp",
    InitSkillList = {
      44681,
      60399,
      44678,
      44675
    },
    CycleSkillList1 = {
      44681,
      60399,
      44678,
      44675
    },
    AnimationID = 60572,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0804_BOSSSIZE.png",
    MonsterHpPercent = 0.25,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 0.66,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [47981] = {
    ID = 47981,
    CnID = "怪物@唤醒体24特遣记录",
    BaseSortID = 309,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_47981_MonsterName|影子「24」",
    Desc = "MonsterConfig_47981_Desc|诞生自阴影的「24」。痛恨一切弱小的事物，包括老鼠。",
    ExistState = {48589},
    StateLayers = 1,
    InitSkillList = {48595},
    CycleSkillList1 = {
      4695,
      48593,
      48595,
      48593,
      48595
    },
    CycleSkillList2 = {
      48581,
      48585,
      48582,
      48584,
      48600,
      48583
    },
    AnimationID = 15634,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C06_AF.png",
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 1,
    MonsterDefPercent = -2,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [44177] = {
    ID = 44177,
    CnID = "怪物@丰穰母树",
    BaseSortID = 310,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84294,
      84299
    },
    Category = "MotherTreeMonster",
    MonsterName = "MonsterConfig_44177_MonsterName|「丰穰母树」",
    Desc = "MonsterConfig_44177_Desc|欲之质体，圣河之源，亚兰永恒且唯一的血脉之核，其名为——「丰穰母树」。",
    ExistState = {
      44589,
      45658,
      50854,
      50859,
      51014
    },
    StateLayers = "1,1,1,1,1",
    StateParams = "CmdCaster.atk*0.01,math.ceil(CmdCaster.def*0.2),math.ceil(CmdCaster.def*0.4)",
    InitSkillList = {44285},
    CycleSkillList1 = {
      50381,
      50383,
      49743,
      49743,
      49743,
      49743
    },
    CycleSkillList2 = {
      50382,
      50384,
      50867,
      50867,
      50867
    },
    AnimationID = 44176,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0007.png",
    MonsterHpPercent = 0.15,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.76,
    MonsterProportion = 1,
    MonsterHpNum = 4
  },
  [48867] = {
    ID = 48867,
    CnID = "怪物@黑山羊幼崽一阶段A",
    BaseSortID = 311,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84299,
      84303
    },
    MonsterName = "MonsterConfig_48867_MonsterName|胎动·努比亚幼崽",
    Desc = "MonsterConfig_48867_Desc|长着羊蹄的小型怪物，体表纠缠着异常的血肉。受到致命伤后会立刻消失。",
    ExistState = {
      49628,
      49638,
      45348,
      51017
    },
    StateLayers = "1,1,1,1",
    StateParams = "CmdCaster.atk*0.07",
    InitSkillList = {49631, 49632},
    CycleSkillList1 = {49631, 49632},
    AnimationID = 48872,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0701_AT.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 0,
    MonsterProportion = 0.25,
    IsHide = 1
  },
  [48866] = {
    ID = 48866,
    CnID = "怪物@黑山羊幼崽一阶段B",
    BaseSortID = 312,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84299,
      84303
    },
    MonsterName = "MonsterConfig_48866_MonsterName|胎动·努比亚幼崽",
    Desc = "MonsterConfig_48866_Desc|长着羊蹄的小型怪物，体表纠缠着异常的血肉。受到致命伤后会立刻消失。",
    ExistState = {
      49628,
      49638,
      45348,
      51017
    },
    StateLayers = "1,1,1,1",
    StateParams = "CmdCaster.atk*0.07",
    InitSkillList = {49632, 49631},
    CycleSkillList1 = {49632, 49631},
    AnimationID = 48872,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0701_AT.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = 0,
    MonsterProportion = 0.25,
    IsHide = 1
  },
  [48862] = {
    ID = 48862,
    CnID = "怪物@黑山羊幼崽二阶段A",
    BaseSortID = 313,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84299,
      84303
    },
    MonsterName = "MonsterConfig_48862_MonsterName|孳乳·努比亚幼崽",
    Desc = "MonsterConfig_48862_Desc|长着羊蹄的小型怪物，体表遍布着神秘的纹路。受到致命伤后会立刻消失。",
    ExistState = {
      49627,
      49638,
      45662,
      51016
    },
    StateLayers = "1,1,1,1",
    StateParams = "CmdCaster.atk*0.04",
    InitSkillList = {49630, 49633},
    CycleSkillList1 = {49630, 49633},
    AnimationID = 48871,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0701_BOSSSIZE.png",
    MonsterHpPercent = 1.2,
    MonsterAtkPercent = 0.94,
    MonsterDefPercent = 1.03,
    MonsterProportion = 0.55,
    IsHide = 1
  },
  [48861] = {
    ID = 48861,
    CnID = "怪物@黑山羊幼崽二阶段B",
    BaseSortID = 314,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84299,
      84303
    },
    MonsterName = "MonsterConfig_48861_MonsterName|孳乳·努比亚幼崽",
    Desc = "MonsterConfig_48861_Desc|长着羊蹄的小型怪物，体表遍布着神秘的纹路。受到致命伤后会立刻消失。",
    ExistState = {
      49627,
      49638,
      45662,
      51016
    },
    StateLayers = "1,1,1,1",
    StateParams = "CmdCaster.atk*0.04",
    InitSkillList = {49633, 49630},
    CycleSkillList1 = {49633, 49630},
    AnimationID = 48871,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0701_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.03,
    MonsterProportion = 0.55,
    IsHide = 1
  },
  [49629] = {
    ID = 49629,
    CnID = "怪物@黑山羊变体",
    BaseSortID = 315,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84299,
      84303
    },
    MonsterName = "MonsterConfig_49629_MonsterName|胎动·努比亚幼崽",
    Desc = "MonsterConfig_49629_Desc|长着羊蹄的小型怪物，体表纠缠着异常的血肉。受到致命伤后会立刻消失。",
    ExistState = {
      49628,
      49638,
      22074
    },
    StateLayers = "1,1",
    StateParams = "CmdCaster.atk*0.2",
    InitSkillList = {49631, 49632},
    CycleSkillList1 = {49631, 49632},
    AnimationID = 50690,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0701_AT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.25
  },
  [44456] = {
    ID = 44456,
    CnID = "怪物@黑山羊守卫",
    BaseSortID = 316,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84299,
      84303
    },
    MonsterName = "MonsterConfig_44456_MonsterName|孳乳·努比亚幼崽",
    Desc = "MonsterConfig_44456_Desc|长着羊蹄的小型怪物，体表遍布着神秘的纹路。受到致命伤后会立刻消失。",
    ExistState = {
      49627,
      49638,
      22074
    },
    StateLayers = "1,1",
    StateParams = "CmdCaster.atk*0.15",
    InitSkillList = {49633, 49630},
    CycleSkillList1 = {49633, 49630},
    AnimationID = 50691,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0701_BOSSSIZE.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = 1.03,
    MonsterProportion = 0.55
  },
  [49157] = {
    ID = 49157,
    CnID = "怪物@小型黑山羊A",
    BaseSortID = 317,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84299,
      84303
    },
    MonsterName = "MonsterConfig_49157_MonsterName|努比亚幼崽",
    Desc = "MonsterConfig_49157_Desc|它长着羊的蹄子，位于体表中央的瞳孔被刺穿后会立刻消失。",
    ExistState = {
      49148,
      49638,
      22074
    },
    StateLayers = "1,1",
    InitSkillList = {
      49124,
      49129,
      49624,
      49126
    },
    CycleSkillList1 = {
      49124,
      49129,
      49624,
      49126
    },
    AnimationID = 44289,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0701.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 2,
    MonsterProportion = 0.3
  },
  [49156] = {
    ID = 49156,
    CnID = "怪物@小型黑山羊B",
    BaseSortID = 318,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84299,
      84303
    },
    MonsterName = "MonsterConfig_49156_MonsterName|努比亚幼崽",
    Desc = "MonsterConfig_49156_Desc|它长着羊的蹄子，位于体表中央的瞳孔被刺穿后会立刻消失。",
    ExistState = {
      49148,
      49638,
      22074
    },
    StateLayers = "1,1",
    InitSkillList = {
      49624,
      49126,
      49124,
      49129
    },
    CycleSkillList1 = {
      49624,
      49126,
      49124,
      49129
    },
    AnimationID = 44289,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0701.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = 2,
    MonsterProportion = 0.3
  },
  [49283] = {
    ID = 49283,
    CnID = "怪物@森之黑山羊",
    BaseSortID = 319,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84299,
      84303
    },
    MonsterName = "MonsterConfig_49283_MonsterName|努比亚",
    Desc = "MonsterConfig_49283_Desc|小心勒姆瓦希的每一束枯藤，小心它睁开的血色的方形眼瞳。",
    ExistState = {
      49278,
      49638,
      22074
    },
    StateLayers = "1,1",
    StateParams = "CmdCaster.max_hp*0.5,CmdCaster.atk*0.1",
    InitSkillList = {
      49290,
      49291,
      49289,
      49288
    },
    CycleSkillList1 = {
      49290,
      49291,
      49289,
      49288
    },
    AnimationID = 47809,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0702.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 3.22,
    MonsterProportion = 1
  },
  [49481] = {
    ID = 49481,
    CnID = "怪物@森之黑山羊精英",
    BaseSortID = 320,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84299,
      84303
    },
    MonsterName = "MonsterConfig_49481_MonsterName|「塞尔凯特」",
    Desc = "MonsterConfig_49481_Desc|小心勒姆瓦希的每一束枯藤，小心它睁开的血色的方形眼瞳。",
    ExistState = {
      49278,
      49638,
      2921
    },
    StateLayers = "1,1,1",
    StateParams = "CmdCaster.max_hp*0.5,CmdCaster.atk*0.05",
    InitSkillList = {
      49435,
      49437,
      49438,
      49436,
      49439
    },
    CycleSkillList1 = {
      49435,
      49437,
      49438,
      49436,
      49439
    },
    AnimationID = 47809,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0702.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 1.69,
    MonsterProportion = 1
  },
  [49479] = {
    ID = 49479,
    CnID = "怪物@森之黑山羊BOSS",
    BaseSortID = 321,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84299,
      84303
    },
    MonsterName = "MonsterConfig_49479_MonsterName|圣河努比亚",
    Desc = "MonsterConfig_49479_Desc|小心勒姆瓦希的每一束枯藤，它跃动的心脏将鼓动你化作圣河的水脉。",
    ExistState = {
      49278,
      49638,
      2921
    },
    StateLayers = "1,1,1",
    StateParams = "CmdCaster.max_hp*0.5,CmdCaster.atk*0.05",
    InitSkillList = {
      49456,
      49455,
      49460,
      49454,
      49459
    },
    CycleSkillList1 = {
      49456,
      49458,
      49460,
      49454,
      49459
    },
    AnimationID = 48875,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0702_BOSSSIZE.png",
    MonsterHpPercent = 0.85,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = 3.6,
    MonsterProportion = 1
  },
  [49483] = {
    ID = 49483,
    CnID = "怪物@巨型森之黑山羊",
    BaseSortID = 322,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84299,
      84303
    },
    MonsterName = "MonsterConfig_49483_MonsterName|努比亚巨木",
    Desc = "MonsterConfig_49483_Desc|有一天种子会发芽，新芽会长成巨树——如果它不曾被污染的话。",
    ExistState = {
      49524,
      49638,
      50373,
      22074
    },
    StateLayers = "1,1,1",
    StateParams = "CmdCaster.atk*0.02",
    InitSkillList = {
      49490,
      49492,
      49491,
      49493
    },
    CycleSkillList1 = {
      49490,
      49492,
      49491,
      49493
    },
    AnimationID = 49485,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0703.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 3.42,
    MonsterProportion = 1
  },
  [49482] = {
    ID = 49482,
    CnID = "怪物@巨型森之黑山羊精英",
    BaseSortID = 323,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84299,
      84303
    },
    MonsterName = "MonsterConfig_49482_MonsterName|「海窟特」",
    Desc = "MonsterConfig_49482_Desc|有一天种子会发芽，新芽会长成巨树——如果它不曾被污染的话。",
    ExistState = {
      49524,
      49638,
      50373
    },
    StateLayers = "1,1,1",
    StateParams = "CmdCaster.atk*0.03",
    InitSkillList = {
      49522,
      49516,
      49523,
      49519
    },
    CycleSkillList1 = {
      49522,
      49516,
      49523,
      49519
    },
    AnimationID = 49485,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0703.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.22,
    MonsterProportion = 1
  },
  [49480] = {
    ID = 49480,
    CnID = "怪物@巨型森之黑山羊BOSS",
    BaseSortID = 324,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84299,
      90646,
      84303
    },
    MonsterName = "MonsterConfig_49480_MonsterName|长明·努比亚巨木",
    Desc = "MonsterConfig_49480_Desc|祂不再隐藏自己的内核。「愿提灯长明。」",
    ExistState = {
      49524,
      49526,
      49638,
      50373,
      2921
    },
    StateLayers = "1,1,1,1,1",
    StateParams = "CmdCaster.atk*0.02,CmdCaster.max_hp*0.25",
    InitSkillList = {
      49518,
      49515,
      49521,
      49520
    },
    CycleSkillList1 = {
      49518,
      49515,
      49521,
      49520
    },
    AnimationID = 49484,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0703_BOSSSIZE.png",
    MonsterHpPercent = 0.75,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 3.64,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [49240] = {
    ID = 49240,
    CnID = "怪物@亚兰人A",
    BaseSortID = 325,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_49240_MonsterName|亚兰战士",
    Desc = "MonsterConfig_49240_Desc|亚兰人拥有异常的繁衍能力，但亚兰的战士依然是某人的儿子，某人的父亲。",
    ExistState = {22074},
    InitSkillList = {
      49236,
      49234,
      49233,
      49235
    },
    CycleSkillList1 = {
      49236,
      49234,
      49233,
      49235
    },
    AnimationID = 48876,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0704.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 1.36,
    MonsterProportion = 0.6
  },
  [49237] = {
    ID = 49237,
    CnID = "怪物@亚兰人B",
    BaseSortID = 326,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_49237_MonsterName|亚兰战士",
    Desc = "MonsterConfig_49237_Desc|亚兰人拥有异常的繁衍能力，但亚兰的战士依然是某人的儿子，某人的父亲。",
    ExistState = {22074},
    InitSkillList = {
      49233,
      49235,
      49236,
      49234
    },
    CycleSkillList1 = {
      49233,
      49235,
      49236,
      49234
    },
    AnimationID = 48876,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0704.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = 1.36,
    MonsterProportion = 0.6
  },
  [52491] = {
    ID = 52491,
    CnID = "怪物@亚兰人C",
    BaseSortID = 327,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_52491_MonsterName|亚兰战士",
    Desc = "MonsterConfig_52491_Desc|亚兰人拥有异常的繁衍能力，但亚兰的战士依然是某人的儿子，某人的父亲。",
    ExistState = {22074},
    InitSkillList = {
      49235,
      49233,
      49236,
      49234
    },
    CycleSkillList1 = {
      49235,
      49233,
      49236,
      49234
    },
    AnimationID = 48876,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0704.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.36,
    MonsterProportion = 0.6
  },
  [53768] = {
    ID = 53768,
    CnID = "怪物@亚兰人D",
    BaseSortID = 328,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_53768_MonsterName|亚兰战士",
    Desc = "MonsterConfig_53768_Desc|亚兰人拥有异常的繁衍能力，但亚兰的战士依然是某人的儿子，某人的父亲。",
    ExistState = {22074},
    InitSkillList = {
      49235,
      49236,
      49234,
      49233
    },
    CycleSkillList1 = {
      49235,
      49236,
      49234,
      49233
    },
    AnimationID = 48876,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0704.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.36,
    MonsterProportion = 0.6
  },
  [49598] = {
    ID = 49598,
    CnID = "怪物@亚兰人幻影A",
    BaseSortID = 329,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_49598_MonsterName|亚兰战士幻影",
    Desc = "MonsterConfig_49598_Desc|母树的意识之海中，漂浮着葬于往昔的幻影。",
    ExistState = {22074},
    InitSkillList = {
      49236,
      49234,
      49233,
      49235
    },
    CycleSkillList1 = {
      49236,
      49234,
      49233,
      49235
    },
    AnimationID = 48876,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0704.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 1.36,
    MonsterProportion = 0.6
  },
  [49599] = {
    ID = 49599,
    CnID = "怪物@亚兰人幻影B",
    BaseSortID = 330,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_49599_MonsterName|亚兰战士幻影",
    Desc = "MonsterConfig_49599_Desc|母树的意识之海中，漂浮着葬于往昔的幻影。",
    ExistState = {22074},
    InitSkillList = {
      49233,
      49235,
      49236,
      49234
    },
    CycleSkillList1 = {
      49233,
      49235,
      49236,
      49234
    },
    AnimationID = 48876,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0704.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = 1.36,
    MonsterProportion = 0.6
  },
  [48881] = {
    ID = 48881,
    CnID = "怪物@亚兰士官长",
    BaseSortID = 331,
    BattleTag = "Boss",
    MonsterTag = {84277, 90645},
    MonsterName = "MonsterConfig_48881_MonsterName|亚兰卫队长",
    Desc = "MonsterConfig_48881_Desc|每代篝火晚会后，最杰出的种子都会成长为新的卫队长。",
    ExistState = {49546, 2921},
    StateLayers = 1,
    InitSkillList = {
      49531,
      49530,
      49532,
      49533
    },
    CycleSkillList1 = {
      49531,
      49530,
      49532,
      49533
    },
    AnimationID = 48873,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0704_BOSSSIZE.png",
    MonsterHpPercent = 0.7,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.01,
    MonsterProportion = 1
  },
  [49535] = {
    ID = 49535,
    CnID = "怪物@亚兰人精英护卫A",
    BaseSortID = 332,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_49535_MonsterName|精英亚兰护卫",
    Desc = "MonsterConfig_49535_Desc|他守卫亚兰的未来，但从未过问那未来究竟是什么模样。",
    ExistState = {49547},
    StateLayers = 1,
    StateParams = "CmdCaster.atk*0.03",
    InitSkillList = {49544, 49543},
    CycleSkillList1 = {49544, 49543},
    AnimationID = 48876,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0704.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.01,
    MonsterProportion = 3.8
  },
  [49534] = {
    ID = 49534,
    CnID = "怪物@亚兰人精英护卫B",
    BaseSortID = 333,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_49534_MonsterName|精英亚兰护卫",
    Desc = "MonsterConfig_49534_Desc|他守卫亚兰的未来，但从未过问那未来究竟是什么模样。",
    ExistState = {49547},
    StateLayers = 1,
    StateParams = "CmdCaster.atk*0.03",
    InitSkillList = {49543, 49544},
    CycleSkillList1 = {49543, 49544},
    AnimationID = 48876,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0704.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.01,
    MonsterProportion = 3.8
  },
  [43794] = {
    ID = 43794,
    CnID = "怪物@人面犬",
    BaseSortID = 334,
    BattleTag = "Elite",
    MonsterTag = {90641, 84291},
    MonsterName = "MonsterConfig_43794_MonsterName|「涅弗鲁瑞」",
    Desc = "MonsterConfig_43794_Desc|睡吧，涅弗鲁瑞。睡吧，我的乖孩子。睡吧，在太过短暂的童年，在迎风而长的梦中。",
    ExistState = {
      50735,
      50731,
      45210
    },
    StateLayers = "CmdCaster.max_hp,1,1",
    StateParams = "CmdCaster.max_hp",
    InitSkillList = {
      50704,
      50700,
      50699,
      50703
    },
    CycleSkillList1 = {
      50704,
      50700,
      50699,
      50703
    },
    AnimationID = 50274,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0801.png",
    MonsterHpPercent = 0.45,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 0.66,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [48892] = {
    ID = 48892,
    CnID = "怪物@雕塑家改造人中亚兰BOSS",
    BaseSortID = 335,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84291,
      84280
    },
    MonsterName = "MonsterConfig_48892_MonsterName|亚兰圣鹭",
    Desc = "MonsterConfig_48892_Desc|造就自身者，自圣树之火中诞生，引领诸位前往死之领域。",
    ExistState = {80445, 2517},
    StateLayers = "1,1",
    InitSkillList = {
      49552,
      49554,
      49553,
      49554,
      50335,
      49555
    },
    CycleSkillList1 = {49556, 49551},
    AnimationID = 48878,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0706_BOSSSIZE.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 4.99,
    MonsterProportion = 1
  },
  [46084] = {
    ID = 46084,
    CnID = "怪物@雕塑家改造人大维度",
    BaseSortID = 336,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84280,
      90644
    },
    MonsterName = "MonsterConfig_46084_MonsterName|窥视者",
    Desc = "MonsterConfig_46084_Desc|笨拙的窃取者，在废弃的厂房中徘徊。",
    ExistState = {
      80445,
      2921,
      22074
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      46128,
      56370,
      46131,
      56371
    },
    CycleSkillList1 = {
      46129,
      48086,
      46135,
      48085
    },
    AnimationID = 46090,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0303_AT.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.96,
    MonsterDefPercent = 2,
    MonsterProportion = 0.8
  },
  [46083] = {
    ID = 46083,
    CnID = "怪物@雕塑家改造人大维度BOSS",
    BaseSortID = 337,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90645,
      84280,
      90644
    },
    MonsterName = "MonsterConfig_46083_MonsterName|「以图存续」",
    Desc = "MonsterConfig_46083_Desc|这里充斥着对存续的渴望，他探求如逐火的灯蛾。",
    ExistState = {
      80445,
      2921,
      49959
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      46129,
      48086,
      46135,
      48085
    },
    CycleSkillList1 = {
      46129,
      48086,
      46135,
      48085
    },
    AnimationID = 46089,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0303_AT_BOSSSIZE.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.96,
    MonsterDefPercent = 2,
    MonsterProportion = 0.8
  },
  [55833] = {
    ID = 55833,
    CnID = "怪物@模拟战靶子",
    BaseSortID = 338,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 84291},
    MonsterName = "MonsterConfig_55833_MonsterName|诊疗医生",
    Desc = "MonsterConfig_55833_Desc|他们的诊断即是你的死亡。会保护其他友方的个体。",
    ExistState = {22074},
    StateLayers = 1,
    AnimationID = 15650,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0103_BT.png",
    MonsterHpPercent = 1000,
    MonsterAtkPercent = 1000,
    MonsterDefPercent = 1000,
    MonsterProportion = 1000
  },
  [55851] = {
    ID = 55851,
    CnID = "怪物@模拟战小怪",
    BaseSortID = 339,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84291},
    MonsterName = "MonsterConfig_55851_MonsterName|融蚀鼠王",
    Desc = "MonsterConfig_55851_Desc|沾满融蚀的尾巴将它们粘合在一起，痛苦却无法分离。",
    ExistState = {22074},
    StateLayers = 1,
    AnimationID = 15750,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0201.png",
    MonsterHpPercent = 1000,
    MonsterAtkPercent = 1000,
    MonsterDefPercent = 1000,
    MonsterProportion = 1000
  },
  [74804] = {
    ID = 74804,
    CnID = "怪物@模拟战BOSS",
    BaseSortID = 340,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_74804_MonsterName|融蚀鼠王",
    Desc = "MonsterConfig_74804_Desc|沾满融蚀的尾巴将它们粘合在一起，痛苦却无法分离。",
    StateLayers = 1,
    AnimationID = 15750,
    MonsterClass = "Boss",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0201.png",
    MonsterHpPercent = 1000,
    MonsterAtkPercent = 1000,
    MonsterDefPercent = 1000,
    MonsterProportion = 1000
  },
  [56424] = {
    ID = 56424,
    CnID = "怪物@双子塔薇",
    BaseSortID = 341,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    Category = "TaweiMonster",
    MonsterName = "MonsterConfig_56424_MonsterName|「双生矛盾」",
    Desc = "MonsterConfig_56424_Desc|「战胜我们。杀死我们。然后，拯救我们。」",
    ExistState = {
      57701,
      57703,
      57963,
      60162,
      57942,
      60184,
      60313,
      60087,
      60263,
      62213,
      62368,
      131409
    },
    StateLayers = "1,1,1,1,5,1,CmdCaster.max_hp,50,50,50,1",
    InitSkillList = {
      57558,
      57557,
      57556
    },
    CycleSkillList1 = {
      57558,
      57557,
      57556
    },
    CycleSkillList2 = {57550, 57551},
    CycleSkillList3 = {
      57555,
      57553,
      57552
    },
    CycleSkillList4 = {
      57568,
      57554,
      59738
    },
    CycleSkillList5 = {
      57557,
      57556,
      57558
    },
    CycleSkillList6 = {
      57556,
      57558,
      57557
    },
    CycleSkillList7 = {
      59737,
      59736,
      59739
    },
    AnimationID = 56425,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0008.png",
    MonsterHpPercent = 0.15,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.76,
    MonsterProportion = 1,
    MonsterHpNum = 4
  },
  [57704] = {
    ID = 57704,
    CnID = "怪物@双子塔薇白",
    BaseSortID = 342,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_57704_MonsterName|「光之子」",
    Desc = "MonsterConfig_57704_Desc|神像从未停止对她的吞噬。痛苦与恐惧不会令她绝望，因为她相信你。",
    ExistState = {57706},
    StateLayers = "1,1,1,1,1",
    InitSkillList = {
      59740,
      57699,
      59735
    },
    CycleSkillList1 = {
      59740,
      57699,
      59735
    },
    CycleSkillList2 = {4173},
    AnimationID = 57705,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0008_AT.png",
    MonsterHpPercent = 0.15,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.76,
    MonsterProportion = 1
  },
  [59744] = {
    ID = 59744,
    CnID = "怪物@审查会猫咪A",
    BaseSortID = 343,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84291,
      84279
    },
    MonsterName = "MonsterConfig_59744_MonsterName|搜查猫",
    Desc = "MonsterConfig_59744_Desc|某些工作不止犬科能做。",
    ExistState = {60000, 22074},
    StateLayers = "1,1",
    InitSkillList = {
      60003,
      60002,
      60001
    },
    CycleSkillList1 = {
      60003,
      60002,
      60001
    },
    AnimationID = 35625,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0602.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = 0.85,
    MonsterProportion = 0.4
  },
  [59745] = {
    ID = 59745,
    CnID = "怪物@审查会猫咪B",
    BaseSortID = 344,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84291,
      84279
    },
    MonsterName = "MonsterConfig_59745_MonsterName|陆战猫",
    Desc = "MonsterConfig_59745_Desc|审查会的试验性产物，迄今已伤害了七任训练员。",
    ExistState = {60000, 22074},
    StateLayers = "1,1",
    InitSkillList = {
      60002,
      60001,
      60003
    },
    CycleSkillList1 = {
      60002,
      60001,
      60003
    },
    AnimationID = 35625,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0602.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.85,
    MonsterProportion = 0.4
  },
  [59750] = {
    ID = 59750,
    CnID = "怪物@告死之鸟",
    BaseSortID = 345,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84291,
      84279
    },
    MonsterName = "MonsterConfig_59750_MonsterName|「小蜜蜂」",
    Desc = "MonsterConfig_59750_Desc|训练员这样称呼它。虽然性情相对温顺，但也请小心它的刺。",
    ExistState = {
      60028,
      3638,
      22074
    },
    StateLayers = "1,2,1",
    InitSkillList = {
      60025,
      60026,
      60027
    },
    CycleSkillList1 = {
      60025,
      60026,
      60027
    },
    AnimationID = 35626,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0601.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.85,
    MonsterProportion = 0.25
  },
  [59746] = {
    ID = 59746,
    CnID = "怪物@告死之鸟易爆版",
    BaseSortID = 346,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84291,
      84279
    },
    MonsterName = "MonsterConfig_59746_MonsterName|「小马蜂」",
    Desc = "MonsterConfig_59746_Desc|最让训练员头疼的成员。生性易怒，小心它的刺。",
    ExistState = {
      60028,
      3638,
      22074
    },
    StateLayers = "1,2,1",
    InitSkillList = {60026, 60027},
    CycleSkillList1 = {60026, 60027},
    AnimationID = 35626,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0601.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.25
  },
  [59749] = {
    ID = 59749,
    CnID = "怪物@弥撒格碎片A",
    BaseSortID = 347,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90644
    },
    MonsterName = "MonsterConfig_59749_MonsterName|异维学子",
    Desc = "MonsterConfig_59749_Desc|从这些来自异维的怪物身上，你看到了属于弥萨格的标志。",
    ExistState = {
      60898,
      22074,
      89574
    },
    StateLayers = "1,1",
    InitSkillList = {60047, 60048},
    CycleSkillList1 = {60047, 60048},
    AnimationID = 60573,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0801.png",
    MonsterHpPercent = 0.9,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 2,
    MonsterProportion = 0.3
  },
  [59747] = {
    ID = 59747,
    CnID = "怪物@弥撒格碎片B",
    BaseSortID = 348,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90644
    },
    MonsterName = "MonsterConfig_59747_MonsterName|异维学子",
    Desc = "MonsterConfig_59747_Desc|从这些来自异维的怪物身上，你看到了属于弥萨格的标志。",
    ExistState = {
      60898,
      22074,
      89574
    },
    StateLayers = "1,1",
    InitSkillList = {60048, 60047},
    CycleSkillList1 = {60048, 60047},
    AnimationID = 60573,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0801.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = 2,
    MonsterProportion = 0.3
  },
  [59741] = {
    ID = 59741,
    CnID = "怪物@提灯蜡像男",
    BaseSortID = 349,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90645,
      90646
    },
    MonsterName = "MonsterConfig_59741_MonsterName|「绅士」",
    Desc = "MonsterConfig_59741_Desc|雕塑家协会通过这组雕像获得了于丽埃特的认可。提灯教会从不浪费任何一个遗产。",
    ExistState = {
      80445,
      60926,
      22074
    },
    StateLayers = "1,CmdCaster.atk*0.1",
    StateParams = 1,
    InitSkillList = {
      60934,
      60929,
      60931,
      60930
    },
    CycleSkillList1 = {
      60929,
      60931,
      60930
    },
    AnimationID = 60901,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0802.png",
    MonsterHpPercent = 0.8,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 0.54,
    MonsterProportion = 0.55
  },
  [59742] = {
    ID = 59742,
    CnID = "怪物@提灯蜡像女",
    BaseSortID = 350,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90645,
      90646
    },
    MonsterName = "MonsterConfig_59742_MonsterName|「淑女」",
    Desc = "MonsterConfig_59742_Desc|雕塑家协会通过这组雕像获得了于丽埃特的认可。提灯教会从不浪费任何一个遗产。",
    ExistState = {
      80445,
      60925,
      22074
    },
    StateLayers = "1,CmdCaster.atk*0.02",
    InitSkillList = {
      60932,
      60927,
      60933,
      60928
    },
    CycleSkillList1 = {
      60927,
      60933,
      60928
    },
    AnimationID = 60904,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0803.png",
    MonsterHpPercent = 1.2,
    MonsterAtkPercent = 0.94,
    MonsterDefPercent = 2.73,
    MonsterProportion = 0.55
  },
  [60009] = {
    ID = 60009,
    CnID = "怪物@提灯蜡像男精英",
    BaseSortID = 351,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90645,
      84280,
      90646
    },
    MonsterName = "MonsterConfig_60009_MonsterName|正直先生",
    Desc = "MonsterConfig_60009_Desc|灯芯快要压断他的腰……为什么没有人搀他的肩？",
    ExistState = {80445, 60926},
    StateLayers = "1,CmdCaster.atk*0.1",
    StateParams = 2,
    InitSkillList = {
      60939,
      60929,
      60931,
      60930
    },
    CycleSkillList1 = {
      60929,
      60931,
      60930
    },
    AnimationID = 60901,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0802.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 0.61,
    MonsterProportion = 0.7
  },
  [60006] = {
    ID = 60006,
    CnID = "怪物@提灯蜡像女精英",
    BaseSortID = 352,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90645,
      84280,
      90646
    },
    MonsterName = "MonsterConfig_60006_MonsterName|谦和女士",
    Desc = "MonsterConfig_60006_Desc|灯光快要晒化她的脸……为什么没有人替她打伞？",
    ExistState = {80445, 60925},
    StateLayers = "1,CmdCaster.atk*0.02",
    InitSkillList = {
      60937,
      60927,
      60933,
      60938
    },
    CycleSkillList1 = {
      60927,
      60933,
      60938
    },
    AnimationID = 60904,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0803.png",
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = 4.92,
    MonsterProportion = 0.7
  },
  [59748] = {
    ID = 59748,
    CnID = "怪物@审查会男",
    BaseSortID = 353,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90645,
      84279
    },
    MonsterName = "MonsterConfig_59748_MonsterName|探员",
    Desc = "MonsterConfig_59748_Desc|越底层的成员，越为这场难得一见的重大行动感到亢奋。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      60173,
      60172,
      60175,
      60179
    },
    CycleSkillList1 = {
      60173,
      60172,
      60175,
      60179
    },
    AnimationID = 35629,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0603_BT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.75,
    MonsterProportion = 0.65
  },
  [60091] = {
    ID = 60091,
    CnID = "怪物@审查会男精英",
    BaseSortID = 354,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90645,
      84279
    },
    MonsterName = "MonsterConfig_60091_MonsterName|高级探员",
    Desc = "MonsterConfig_60091_Desc|更少的退路，更少的回报。更多的风险，更多的烦恼。",
    ExistState = {60087},
    StateLayers = 50,
    InitSkillList = {
      60194,
      60193,
      60195,
      60192
    },
    CycleSkillList1 = {
      60194,
      60193,
      60195,
      60192
    },
    AnimationID = 35629,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0603_BT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.75,
    MonsterProportion = 1
  },
  [59743] = {
    ID = 59743,
    CnID = "怪物@审查会女",
    BaseSortID = 355,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90645,
      84279
    },
    MonsterName = "MonsterConfig_59743_MonsterName|作战员",
    Desc = "MonsterConfig_59743_Desc|越底层的成员，越为这场难得一见的重大行动感到亢奋。",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {
      60180,
      60171,
      60181,
      60176
    },
    CycleSkillList1 = {
      60180,
      60171,
      60181,
      60176
    },
    AnimationID = 35632,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0603_AT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.75,
    MonsterProportion = 0.65
  },
  [60095] = {
    ID = 60095,
    CnID = "怪物@审查会女精英",
    BaseSortID = 356,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90645,
      84279
    },
    MonsterName = "MonsterConfig_60095_MonsterName|高级作战员",
    Desc = "MonsterConfig_60095_Desc|更少的退路，更少的回报。更多的风险，更多的烦恼。",
    ExistState = {60263},
    StateLayers = 50,
    InitSkillList = {
      60177,
      60178,
      60174,
      60182
    },
    CycleSkillList1 = {
      60177,
      60178,
      60174,
      60182
    },
    AnimationID = 35632,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0603_AT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.75,
    MonsterProportion = 1
  },
  [89528] = {
    ID = 89528,
    CnID = "怪物@审查会女BOSS",
    BaseSortID = 357,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90645,
      84279
    },
    MonsterName = "MonsterConfig_89528_MonsterName|剑术教官",
    Desc = "MonsterConfig_89528_Desc|从所有协定国中选拔出的剑术精英，请小心应对。",
    ExistState = {
      60264,
      60263,
      60284,
      61036
    },
    StateLayers = "1,66,1,1",
    InitSkillList = {
      60256,
      60253,
      60254,
      60252
    },
    CycleSkillList1 = {
      60255,
      60253,
      60254,
      60252
    },
    AnimationID = 43814,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0603_BOSSSIZE.png",
    MonsterHpPercent = 0.75,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 4.99,
    MonsterProportion = 1
  },
  [60007] = {
    ID = 60007,
    CnID = "怪物@审查会队长",
    BaseSortID = 358,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90645,
      84279
    },
    MonsterName = "MonsterConfig_60007_MonsterName|军士长",
    Desc = "MonsterConfig_60007_Desc|审查会初级指挥人员，通常为作战小队队长。",
    ExistState = {
      60086,
      60087,
      2921,
      22074
    },
    StateLayers = "1,50,1,1",
    InitSkillList = {
      60074,
      60073,
      60077,
      60082
    },
    CycleSkillList1 = {
      60074,
      60073,
      60077,
      60082
    },
    AnimationID = 35627,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0604.png",
    MonsterHpPercent = 0.85,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 1.43,
    MonsterProportion = 1
  },
  [60090] = {
    ID = 60090,
    CnID = "怪物@审查会队长精英",
    BaseSortID = 359,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90645,
      84279
    },
    MonsterName = "MonsterConfig_60090_MonsterName|上尉",
    Desc = "MonsterConfig_60090_Desc|审查会中级指挥人员，拥有良好的个人能力与指挥素养。",
    ExistState = {
      60086,
      60087,
      2921
    },
    StateLayers = "1,50,1",
    InitSkillList = {
      60078,
      60071,
      60075,
      60081
    },
    CycleSkillList1 = {
      60078,
      60071,
      60075,
      60081
    },
    AnimationID = 35627,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0604.png",
    MonsterHpPercent = 0.85,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [60008] = {
    ID = 60008,
    CnID = "怪物@审查会队长BOSS",
    BaseSortID = 360,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90645,
      84279
    },
    MonsterName = "MonsterConfig_60008_MonsterName|少校",
    Desc = "MonsterConfig_60008_Desc|审查会高级指挥人员，帝国勋章获得者，曾在数次对抗融蚀的行动中立下功勋。",
    ExistState = {
      60085,
      60087,
      2921,
      61035
    },
    StateLayers = "1,66,1,1",
    InitSkillList = {
      60079,
      60072,
      60076,
      60080
    },
    CycleSkillList1 = {
      60079,
      60072,
      60076,
      60080
    },
    AnimationID = 43815,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0604_BOSSSIZE.png",
    MonsterHpPercent = 0.85,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.56,
    MonsterProportion = 1
  },
  [60094] = {
    ID = 60094,
    CnID = "怪物@提灯审查会队长",
    BaseSortID = 361,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90645,
      84279,
      90646
    },
    MonsterName = "MonsterConfig_60094_MonsterName|提灯·卫道士",
    Desc = "MonsterConfig_60094_Desc|被提灯选中的前审查会成员，她匍匐于提灯的控制，渴望光芒照亮自己的衣衫。",
    ExistState = {
      60524,
      60087,
      60263,
      22074
    },
    StateLayers = "5,50,50,1",
    InitSkillList = {
      60517,
      60514,
      60515,
      60516
    },
    CycleSkillList1 = {
      60517,
      60514,
      60515,
      60516
    },
    AnimationID = 60905,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0805.png",
    MonsterHpPercent = 0.75,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0.98,
    MonsterProportion = 1
  },
  [60101] = {
    ID = 60101,
    CnID = "怪物@提灯审查会队长精英",
    BaseSortID = 362,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90645,
      84279,
      90646
    },
    MonsterName = "MonsterConfig_60101_MonsterName|提灯·指挥官",
    Desc = "MonsterConfig_60101_Desc|审查会的优秀指挥，提灯的护卫队长。她守望灯火，直到光芒传播到每一个角落。",
    ExistState = {
      60524,
      60087,
      60263
    },
    StateLayers = "5,50,50",
    InitSkillList = {
      60517,
      60514,
      60515,
      60516
    },
    CycleSkillList1 = {
      60517,
      60514,
      60515,
      60516
    },
    AnimationID = 60905,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0805.png",
    MonsterHpPercent = 0.75,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [60103] = {
    ID = 60103,
    CnID = "怪物@提灯审查会BOSS",
    BaseSortID = 363,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90645,
      84279,
      90646
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_60103_MonsterName|「灯罩」阿依莎",
    Desc = "MonsterConfig_60103_Desc|曾经的英雄，如今守护在于丽埃特身边。她们一同等待，等待那个长明的未来。",
    ExistState = {
      60524,
      60087,
      60263,
      60578
    },
    StateLayers = "5,50,50,1",
    InitSkillList = {
      60535,
      60541,
      60537,
      60540,
      60535,
      60541,
      60537,
      60542
    },
    CycleSkillList1 = {
      60535,
      60541,
      60537,
      60540,
      60535,
      60541,
      60537,
      60542
    },
    CycleSkillList2 = {
      60542,
      60536,
      60540
    },
    AnimationID = 60903,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0805_BOSSSIZE.png",
    MonsterHpPercent = 0.85,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 2.14,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [62226] = {
    ID = 62226,
    CnID = "怪物@托乎瓦波1",
    BaseSortID = 364,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_62226_MonsterName|「原初之视」",
    Desc = "MonsterConfig_62226_Desc|原初的混沌，盲目痴愚的神明，宇宙的造物主与毁灭者，正在睁开祂的眼…",
    ExistState = {65558},
    InitSkillList = {
      66296,
      66296,
      66303,
      66303,
      66282
    },
    CycleSkillList1 = {
      66296,
      66296,
      66303,
      66303,
      66282
    },
    AnimationID = 62230,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_BT.png",
    MonsterHpPercent = 0.2,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1,
    MonsterProportion = 1,
    MonsterHpNum = 6
  },
  [62228] = {
    ID = 62228,
    CnID = "怪物@托乎瓦波2",
    BaseSortID = 365,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_62228_MonsterName|「托乎瓦波之影」",
    Desc = "MonsterConfig_62228_Desc|祂从睡梦中惊醒。梦境中所构筑的一切，从未存在。",
    ExistState = {65557},
    InitSkillList = {
      68950,
      68950,
      68951,
      68951,
      68952
    },
    CycleSkillList1 = {
      68950,
      68950,
      68951,
      68951,
      68952
    },
    CycleSkillList2 = {
      66291,
      66285,
      66290,
      66285,
      66289,
      66284,
      66292,
      66283,
      66298
    },
    CycleSkillList3 = {
      66285,
      66285,
      70043,
      66284,
      66284,
      70043,
      66283,
      70043
    },
    CycleSkillList4 = {70043, 70043},
    AnimationID = 62230,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009.png",
    MonsterHpPercent = 0.035,
    MonsterAtkPercent = 0.85,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [66322] = {
    ID = 66322,
    CnID = "怪物@托乎瓦波小怪1",
    BaseSortID = 366,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84283},
    MonsterName = "MonsterConfig_66322_MonsterName|「无上意志之眼」",
    Desc = "MonsterConfig_66322_Desc|碎片举起它的锋刃。卑微的蝼蚁，正与无上的意志对视。",
    ExistState = {65559},
    StateLayers = 1,
    InitSkillList = {
      62216,
      66286,
      66288,
      66287,
      62218
    },
    CycleSkillList1 = {
      62216,
      66286,
      66288,
      66287,
      62218
    },
    AnimationID = 62229,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_BT.png",
    MonsterHpPercent = 0.75,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0.98,
    MonsterProportion = 1
  },
  [66320] = {
    ID = 66320,
    CnID = "怪物@托乎瓦波小怪2",
    BaseSortID = 367,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84283},
    MonsterName = "MonsterConfig_66320_MonsterName|「无上意志之眼」",
    Desc = "MonsterConfig_66320_Desc|碎片举起它的锋刃。卑微的蝼蚁，正与无上的意志对视。",
    ExistState = {65559},
    StateLayers = 1,
    InitSkillList = {
      62218,
      62216,
      66286,
      66288,
      66287
    },
    CycleSkillList1 = {
      62218,
      62216,
      66286,
      66288,
      66287
    },
    AnimationID = 62229,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_BT.png",
    MonsterHpPercent = 0.75,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0.98,
    MonsterProportion = 1
  },
  [66321] = {
    ID = 66321,
    CnID = "怪物@托乎瓦波小怪3",
    BaseSortID = 368,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84283},
    MonsterName = "MonsterConfig_66321_MonsterName|「无上意志之眼」",
    Desc = "MonsterConfig_66321_Desc|碎片举起它的锋刃。卑微的蝼蚁，正与无上的意志对视。",
    ExistState = {66306, 65559},
    StateLayers = "1,1",
    InitSkillList = {
      66287,
      62218,
      62216,
      66286,
      66288
    },
    CycleSkillList1 = {
      66287,
      62218,
      62216,
      66286,
      66288
    },
    AnimationID = 62229,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_BT.png",
    MonsterHpPercent = 0.75,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0.98,
    MonsterProportion = 1
  },
  [66318] = {
    ID = 66318,
    CnID = "怪物@托乎瓦波小怪4",
    BaseSortID = 369,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84283},
    MonsterName = "MonsterConfig_66318_MonsterName|「无上意志之眼」",
    Desc = "MonsterConfig_66318_Desc|碎片举起它的锋刃。卑微的蝼蚁，正与无上的意志对视。",
    ExistState = {66306, 65559},
    StateLayers = "2,1",
    InitSkillList = {
      66288,
      66287,
      62218,
      62216,
      66286
    },
    CycleSkillList1 = {
      66288,
      66287,
      62218,
      62216,
      66286
    },
    AnimationID = 62229,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_BT.png",
    MonsterHpPercent = 0.75,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0.98,
    MonsterProportion = 1
  },
  [66319] = {
    ID = 66319,
    CnID = "怪物@托乎瓦波小怪5",
    BaseSortID = 370,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84283},
    MonsterName = "MonsterConfig_66319_MonsterName|「无上意志之眼」",
    Desc = "MonsterConfig_66319_Desc|碎片举起它的锋刃。卑微的蝼蚁，正与无上的意志对视。",
    ExistState = {66306, 65559},
    StateLayers = "3,1",
    InitSkillList = {
      66286,
      66288,
      66287,
      62218,
      62216
    },
    CycleSkillList1 = {
      66286,
      66288,
      66287,
      62218,
      62216
    },
    AnimationID = 62229,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_BT.png",
    MonsterHpPercent = 0.75,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0.98,
    MonsterProportion = 1
  },
  [67134] = {
    ID = 67134,
    CnID = "怪物@托乎瓦波小怪2剧情",
    BaseSortID = 371,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84283},
    MonsterName = "MonsterConfig_67134_MonsterName|「无上意志的注目」",
    Desc = "MonsterConfig_67134_Desc|在这只眼中，你看到梦境的降诞。",
    ExistState = {67844},
    InitSkillList = {67421},
    AnimationID = 67136,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_CT.png",
    MonsterHpPercent = 0.75,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0.98,
    MonsterProportion = 1
  },
  [67135] = {
    ID = 67135,
    CnID = "怪物@托乎瓦波小怪3剧情",
    BaseSortID = 372,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84283},
    MonsterName = "MonsterConfig_67135_MonsterName|「无上意志的凝视」",
    Desc = "MonsterConfig_67135_Desc|在这只眼中，你看到文明的消亡。",
    ExistState = {67844},
    InitSkillList = {67421},
    AnimationID = 67137,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_BT.png",
    MonsterHpPercent = 0.75,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0.98,
    MonsterProportion = 1
  },
  [67132] = {
    ID = 67132,
    CnID = "怪物@托乎瓦波小怪4剧情",
    BaseSortID = 373,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84283},
    MonsterName = "MonsterConfig_67132_MonsterName|「无上意志的余光」",
    Desc = "MonsterConfig_67132_Desc|在这只眼中，你看到永恒的混沌。",
    ExistState = {67844},
    InitSkillList = {67421},
    AnimationID = 67138,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_DT.png",
    MonsterHpPercent = 0.75,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0.98,
    MonsterProportion = 1
  },
  [68700] = {
    ID = 68700,
    CnID = "怪物@托乎瓦波之子A",
    BaseSortID = 374,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84283},
    MonsterName = "MonsterConfig_68700_MonsterName|「亘古痴愚之瞳」",
    Desc = "MonsterConfig_68700_Desc|直视吧，这亘古痴愚的真相……",
    InitSkillList = {
      68552,
      68550,
      68551,
      68699
    },
    CycleSkillList1 = {
      68552,
      68550,
      68699
    },
    AnimationID = 62229,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_AT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 0.8,
    MonsterDefPercent = 0.98,
    MonsterProportion = 0.5
  },
  [68701] = {
    ID = 68701,
    CnID = "怪物@托乎瓦波之子B",
    BaseSortID = 375,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84283},
    MonsterName = "MonsterConfig_68701_MonsterName|「亘古痴愚之瞳」",
    Desc = "MonsterConfig_68701_Desc|直视吧，这亘古痴愚的真相……",
    InitSkillList = {
      68550,
      68551,
      68552,
      68699
    },
    CycleSkillList1 = {
      68550,
      68552,
      68699
    },
    AnimationID = 62229,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_AT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 0.8,
    MonsterDefPercent = 0.98,
    MonsterProportion = 0.5
  },
  [67343] = {
    ID = 67343,
    CnID = "怪物@唤醒体萝坦精英版",
    BaseSortID = 376,
    BattleTag = "Elite",
    MonsterTag = {90641, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_67343_MonsterName|「鲸跃」",
    Desc = "MonsterConfig_67343_Desc|你的剑术老师，你的第一位一往无前的战士。斩断与她的链接吧。",
    ExistState = {3372, 67320},
    StateLayers = 1,
    InitSkillList = {
      4224,
      4283,
      4432,
      4224
    },
    CycleSkillList1 = {
      4283,
      4432,
      4224
    },
    CycleSkillList2 = {
      4283,
      4224,
      4432
    },
    AnimationID = 15719,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C04_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.75,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [67100] = {
    ID = 67100,
    CnID = "怪物@唤醒体本源朵尔",
    BaseSortID = 377,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_67100_MonsterName|「腐坏之脑」",
    Desc = "MonsterConfig_67100_Desc|她跨入门扉，终于看清宇宙盲目混沌的真相。痴愚之人啊，躬身迎接毁灭，才是唯一存在的未来。",
    ExistState = {
      67235,
      62213,
      67266,
      2921
    },
    StateLayers = "1,50,1,1",
    InitSkillList = {67188},
    CycleSkillList1 = {67348, 67349},
    CycleSkillList2 = {
      67178,
      67190,
      67178,
      67186
    },
    CycleSkillList3 = {67172, 67172},
    AnimationID = 67273,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C02EX_AF.png",
    MonsterHpPercent = 0.27,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1,
    MonsterProportion = 0.85,
    MonsterHpNum = 3
  },
  [67344] = {
    ID = 67344,
    CnID = "怪物@唤醒体朵尔精英版",
    BaseSortID = 378,
    BattleTag = "Elite",
    MonsterTag = {90641, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_67344_MonsterName|「缸中之脑」",
    Desc = "MonsterConfig_67344_Desc|她的声音从通讯器中响起时，是你任务中最安心的时刻。卓越的智慧，你已依赖得够多。斩断与她的链接吧。",
    ExistState = {
      67242,
      67249,
      62213,
      67346,
      67321,
      67784
    },
    StateLayers = "1,1,50,1,1,1",
    InitSkillList = {67183},
    CycleSkillList1 = {
      67180,
      67185,
      67383,
      67183
    },
    CycleSkillList2 = {
      67183,
      67383,
      67185
    },
    AnimationID = 15686,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C02_AF.png",
    MonsterHpPercent = 0.432,
    MonsterAtkPercent = 1.21,
    MonsterDefPercent = 1,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [67342] = {
    ID = 67342,
    CnID = "怪物@唤醒体奥吉尔精英版",
    BaseSortID = 379,
    BattleTag = "Elite",
    MonsterTag = {90641, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_67342_MonsterName|「美德骑士」",
    Desc = "MonsterConfig_67342_Desc|年幼的骑士曾向你宣誓效忠，他从未背弃他的誓言。斩断与他的链接吧。",
    ExistState = {
      67265,
      67241,
      67258,
      67246,
      60263,
      60087,
      2921
    },
    StateLayers = "1,1,1,35,50,50,1",
    StateParams = "CmdCaster.def*5,CmdCaster.max_hp*0.25,CmdCaster.atk*0.3,CmdCaster.def*5",
    InitSkillList = {67177},
    CycleSkillList1 = {
      67173,
      67182,
      67177,
      67171,
      67182,
      67177
    },
    CycleSkillList2 = {
      67177,
      67173,
      67182,
      67177,
      67171,
      67182,
      67177,
      67173,
      67182,
      67177,
      67171,
      67182,
      67177,
      67173,
      67182,
      67177,
      67171,
      67182
    },
    AnimationID = 15667,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C03_AF.png",
    MonsterHpPercent = 0.48,
    MonsterAtkPercent = 0.99,
    MonsterDefPercent = 2.03,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [67097] = {
    ID = 67097,
    CnID = "怪物@唤醒体拉蒙娜",
    BaseSortID = 380,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_67097_MonsterName|「知者」",
    Desc = "MonsterConfig_67097_Desc|无需任何词汇描述她。她是拉蒙娜。斩断与她的链接吧。",
    ExistState = {
      67255,
      67257,
      2921
    },
    StateLayers = "1,1,1",
    InitSkillList = {67176},
    CycleSkillList1 = {
      67175,
      67187,
      67175,
      67181
    },
    CycleSkillList2 = {
      67175,
      67187,
      67175,
      67181,
      67176,
      67175,
      67187,
      67175,
      67181,
      67176,
      67175,
      67187,
      67175,
      67181,
      67176
    },
    AnimationID = 15700,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C01_AF.png",
    MonsterHpPercent = 0.33,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.02,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [81279] = {
    ID = 81279,
    CnID = "怪物@唤醒体拉蒙娜通用版",
    BaseSortID = 381,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_81279_MonsterName|「知者」",
    Desc = "MonsterConfig_81279_Desc|从你的记忆中提取的虚无幻影，你知道那并不是真实。",
    ExistState = {
      67255,
      81278,
      2921
    },
    StateLayers = "1,1,1",
    InitSkillList = {81300},
    CycleSkillList1 = {
      67175,
      67187,
      67175,
      67181
    },
    CycleSkillList2 = {
      67175,
      67187,
      67175,
      67181,
      67176,
      67175,
      67187,
      67175,
      67181,
      67176,
      67175,
      67187,
      67175,
      67181,
      67176
    },
    AnimationID = 15700,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C01_AF.png",
    MonsterHpPercent = 0.33,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.02,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [67259] = {
    ID = 67259,
    CnID = "怪物@缸中之脑分体",
    BaseSortID = 382,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84297},
    MonsterName = "MonsterConfig_67259_MonsterName|复制体",
    Desc = "MonsterConfig_67259_Desc|卓越大脑制作出的复制体。看起来柔弱的外表下，是避无可避的陷阱。",
    ExistState = {67252},
    StateLayers = 1,
    StateParams = "CmdCaster.atk*0.23",
    InitSkillList = {67780},
    CycleSkillList1 = {67780},
    AnimationID = 15686,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C02_AF.png",
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1,
    MonsterProportion = 1
  },
  [67103] = {
    ID = 67103,
    CnID = "怪物@唤醒体朵尔",
    BaseSortID = 383,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_67103_MonsterName|「缸中之脑」",
    Desc = "MonsterConfig_67103_Desc|她的声音从通讯器中响起时，是你任务中最安心的时刻。卓越的智慧，你已依赖得够多。",
    ExistState = {
      67242,
      67249,
      62213,
      67346,
      67784
    },
    StateLayers = "1,1,50,1,1",
    InitSkillList = {67183},
    CycleSkillList1 = {
      67180,
      67185,
      67169,
      67183
    },
    CycleSkillList2 = {
      67183,
      67169,
      67185
    },
    AnimationID = 15686,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C02_AF.png",
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [67102] = {
    ID = 67102,
    CnID = "怪物@唤醒体奥吉尔",
    BaseSortID = 384,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_67102_MonsterName|「美德骑士」",
    Desc = "MonsterConfig_67102_Desc|年幼的骑士曾向你宣誓效忠，他从未背弃他的誓言。",
    ExistState = {
      67265,
      67241,
      67258,
      67246,
      60263,
      60087,
      2921
    },
    StateLayers = "1,1,1,35,50,50,1",
    StateParams = "CmdCaster.def*5,CmdCaster.max_hp*0.25,CmdCaster.atk*0.3,CmdCaster.def*5",
    InitSkillList = {67177},
    CycleSkillList1 = {
      67173,
      67182,
      67177,
      67171,
      67182,
      67177
    },
    CycleSkillList2 = {
      67177,
      67173,
      67182,
      67177,
      67171,
      67182,
      67177,
      67173,
      67182,
      67177,
      67171,
      67182,
      67177,
      67173,
      67182,
      67177,
      67171,
      67182
    },
    AnimationID = 15667,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C03_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 2.03,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [67709] = {
    ID = 67709,
    CnID = "怪物@托乎瓦波活动1",
    BaseSortID = 385,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_67709_MonsterName|「原初悲泣之视」",
    Desc = "MonsterConfig_67709_Desc|你们的哭声，祂已全部听见。济贫院中的悲泣，将再度上演。",
    ExistState = {68298, 68632},
    InitSkillList = {
      69800,
      69800,
      69803,
      69803,
      69802
    },
    CycleSkillList1 = {
      69800,
      69800,
      69803,
      69803,
      69802
    },
    CycleSkillList2 = {
      69800,
      69800,
      69803,
      69803,
      69802
    },
    CycleSkillList3 = {
      69800,
      69800,
      69803,
      69803,
      69802
    },
    AnimationID = 68301,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_1T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [67710] = {
    ID = 67710,
    CnID = "怪物@托乎瓦波活动2",
    BaseSortID = 386,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_67710_MonsterName|「原初恐惧之视」",
    Desc = "MonsterConfig_67710_Desc|你们曾于蜡像馆中体会的恐惧，不及祂的分毫。",
    ExistState = {68298, 68626},
    InitSkillList = {
      69788,
      69788,
      69786,
      69786,
      69787
    },
    CycleSkillList1 = {
      69788,
      69788,
      69786,
      69786,
      69787
    },
    CycleSkillList2 = {
      69788,
      69788,
      69786,
      69786,
      69787
    },
    CycleSkillList3 = {
      69788,
      69788,
      69786,
      69786,
      69787
    },
    AnimationID = 68306,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_2T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [67711] = {
    ID = 67711,
    CnID = "怪物@托乎瓦波活动3",
    BaseSortID = 387,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_67711_MonsterName|「原初刺骨之视」",
    Desc = "MonsterConfig_67711_Desc|在与祂的对视中，感受比拉伊刺骨的冰雪更加深刻的痛楚。",
    ExistState = {68298, 68627},
    InitSkillList = {
      69798,
      69798,
      69797,
      69797,
      69796
    },
    CycleSkillList1 = {
      69798,
      69798,
      69797,
      69797,
      69796
    },
    CycleSkillList2 = {
      69798,
      69798,
      69797,
      69797,
      69796
    },
    CycleSkillList3 = {
      69798,
      69798,
      69797,
      69797,
      69796
    },
    AnimationID = 68303,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_3T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [67705] = {
    ID = 67705,
    CnID = "怪物@托乎瓦波活动4",
    BaseSortID = 388,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_67705_MonsterName|「原初诡谲之视」",
    Desc = "MonsterConfig_67705_Desc|维度的变换，只是低劣的戏法。你们所面对的，是诡谲的规则本身。",
    ExistState = {68298, 68621},
    InitSkillList = {
      69790,
      69790,
      69791,
      69791,
      69792
    },
    CycleSkillList1 = {
      69790,
      69790,
      69791,
      69791,
      69792
    },
    CycleSkillList2 = {
      69790,
      69790,
      69791,
      69791,
      69792
    },
    CycleSkillList3 = {
      69790,
      69790,
      69791,
      69791,
      69792
    },
    AnimationID = 68302,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_4T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [67706] = {
    ID = 67706,
    CnID = "怪物@托乎瓦波活动5",
    BaseSortID = 389,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_67706_MonsterName|「原初邪信之视」",
    Desc = "MonsterConfig_67706_Desc|一切的邪信，都归于原初。低下你们的头颅吧。信仰祂。朝拜祂。",
    ExistState = {68298, 68622},
    InitSkillList = {
      69801,
      69801,
      69799,
      69799,
      69784
    },
    CycleSkillList1 = {
      69801,
      69801,
      69799,
      69799,
      69784
    },
    CycleSkillList2 = {
      69801,
      69801,
      69799,
      69799,
      69784
    },
    CycleSkillList3 = {
      69801,
      69801,
      69799,
      69799,
      69784
    },
    AnimationID = 68304,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_5T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [67707] = {
    ID = 67707,
    CnID = "怪物@托乎瓦波活动6",
    BaseSortID = 390,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_67707_MonsterName|「原初疯狂之视」",
    Desc = "MonsterConfig_67707_Desc|无序，疯狂，才是宇宙的真相。如今，真相已来到你们身前。",
    ExistState = {68298, 68623},
    InitSkillList = {
      69795,
      69795,
      69793,
      69793,
      69794
    },
    CycleSkillList1 = {
      69795,
      69795,
      69793,
      69793,
      69794
    },
    CycleSkillList2 = {
      69795,
      69795,
      69793,
      69793,
      69794
    },
    CycleSkillList3 = {
      69795,
      69795,
      69793,
      69793,
      69794
    },
    AnimationID = 68300,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_6T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [67708] = {
    ID = 67708,
    CnID = "怪物@托乎瓦波活动7",
    BaseSortID = 391,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_67708_MonsterName|「原初诞临之视」",
    Desc = "MonsterConfig_67708_Desc|新生，即为终结。",
    ExistState = {68298, 68624},
    InitSkillList = {
      69785,
      69785,
      69789,
      69789,
      69783
    },
    CycleSkillList1 = {
      69785,
      69785,
      69789,
      69789,
      69783
    },
    CycleSkillList2 = {
      69785,
      69785,
      69789,
      69789,
      69783
    },
    CycleSkillList3 = {
      69785,
      69785,
      69789,
      69789,
      69783
    },
    AnimationID = 68305,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_7T.png",
    MonsterHpPercent = 0.2,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [71644] = {
    ID = 71644,
    CnID = "怪物@弥撒格校猫",
    BaseSortID = 392,
    BattleTag = "Boss",
    MonsterTag = {84277, 84291},
    MonsterName = "MonsterConfig_71644_MonsterName|熟悉的黑猫",
    Desc = "MonsterConfig_71644_Desc|经常出没在弥萨格的熟悉身影，捣乱和银芯不一定会带来哪个。",
    ExistState = {
      71650,
      71651,
      71856,
      2921
    },
    StateLayers = "3,5,1",
    StateParams = "CmdCaster.atk*0.02,CmdCaster.max_hp*0.03",
    InitSkillList = {
      71639,
      71638,
      71637,
      71636
    },
    CycleSkillList1 = {
      71639,
      71638,
      71637,
      71636
    },
    AnimationID = 71645,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S1001.png",
    Scale = 1,
    MonsterHpPercent = 0.33,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.85,
    MonsterHpNum = 4
  },
  [71654] = {
    ID = 71654,
    CnID = "怪物@弥撒格校猫迷你",
    BaseSortID = 393,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84291},
    MonsterName = "MonsterConfig_71654_MonsterName|陌生的黑猫",
    Desc = "MonsterConfig_71654_Desc|和你熟悉的那只黑猫十分相似，或许是穿越维度的缘故，变得有些…迷你？",
    ExistState = {71651, 71856},
    StateLayers = "5,1",
    StateParams = "CmdCaster.atk*0.02,CmdCaster.max_hp*0.03",
    InitSkillList = {
      72025,
      71639,
      72025,
      71637
    },
    CycleSkillList1 = {
      72025,
      72025,
      71637
    },
    AnimationID = 71645,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S1001.png",
    Scale = 0.85,
    MonsterHpPercent = 0.33,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.85
  },
  [71845] = {
    ID = 71845,
    CnID = "怪物@弥撒格校猫迷你2",
    BaseSortID = 394,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84291},
    MonsterName = "MonsterConfig_71845_MonsterName|陌生的黑猫",
    Desc = "MonsterConfig_71845_Desc|和你熟悉的那只黑猫十分相似，或许是穿越维度的缘故，变得有些…迷你？",
    ExistState = {71651, 71856},
    StateLayers = "5,1",
    StateParams = "CmdCaster.atk*0.02,CmdCaster.max_hp*0.03",
    InitSkillList = {
      71637,
      72025,
      71639,
      72025
    },
    CycleSkillList1 = {
      71637,
      72025,
      72025
    },
    AnimationID = 71645,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S1001.png",
    Scale = 0.85,
    MonsterHpPercent = 0.33,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.85
  },
  [71846] = {
    ID = 71846,
    CnID = "怪物@弥撒格校猫迷你3",
    BaseSortID = 395,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84291},
    MonsterName = "MonsterConfig_71846_MonsterName|陌生的黑猫",
    Desc = "MonsterConfig_71846_Desc|和你熟悉的那只黑猫十分相似，或许是穿越维度的缘故，变得有些…迷你？",
    ExistState = {71651, 71856},
    StateLayers = "5,1",
    StateParams = "CmdCaster.atk*0.02,CmdCaster.max_hp*0.03",
    InitSkillList = {
      71639,
      72025,
      71637,
      72025
    },
    CycleSkillList1 = {
      72025,
      71637,
      72025
    },
    AnimationID = 71645,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S1001.png",
    Scale = 0.85,
    MonsterHpPercent = 0.33,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.85
  },
  [72142] = {
    ID = 72142,
    CnID = "怪物@环形融蚀体小A",
    BaseSortID = 396,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84293},
    MonsterName = "MonsterConfig_72142_MonsterName|灰烬融蚀体",
    Desc = "MonsterConfig_72142_Desc|诞生于灰烬之中，已经被融蚀磨灭大部分灵性。",
    ExistState = {
      73518,
      22074,
      89575
    },
    StateLayers = "1,1",
    InitSkillList = {
      72116,
      72108,
      72123,
      72117
    },
    CycleSkillList1 = {
      72116,
      72108,
      72123,
      72117
    },
    AnimationID = 73554,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0901.png",
    Scale = 1,
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1.02,
    MonsterDefPercent = 1.42,
    MonsterProportion = 0.35
  },
  [72144] = {
    ID = 72144,
    CnID = "怪物@环形融蚀体小B",
    BaseSortID = 397,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84293},
    MonsterName = "MonsterConfig_72144_MonsterName|灰烬融蚀体",
    Desc = "MonsterConfig_72144_Desc|诞生于灰烬之中，已经被融蚀磨灭大部分灵性。",
    ExistState = {
      73518,
      22074,
      89575
    },
    StateLayers = "1,1",
    InitSkillList = {
      72123,
      72117,
      72116,
      72108
    },
    CycleSkillList1 = {
      72123,
      72117,
      72116,
      72108
    },
    AnimationID = 73552,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0901.png",
    Scale = 1,
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 1.42,
    MonsterProportion = 0.35
  },
  [72150] = {
    ID = 72150,
    CnID = "怪物@环形融蚀体中A",
    BaseSortID = 398,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84293},
    MonsterName = "MonsterConfig_72150_MonsterName|紧急联络",
    Desc = "MonsterConfig_72150_Desc|「姐姐啊，我好想好想再听一次你的声音。」",
    ExistState = {
      73567,
      22074,
      89575
    },
    StateLayers = "1,1",
    StateParams = "CmdCaster.atk*0.025,CmdCaster.max_hp*0.05",
    InitSkillList = {
      72125,
      72115,
      72119,
      72115
    },
    CycleSkillList1 = {
      72125,
      72115,
      72119,
      72115
    },
    AnimationID = 73555,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0902.png",
    Scale = 1,
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1.02,
    MonsterDefPercent = 0.26,
    MonsterProportion = 0.55
  },
  [72152] = {
    ID = 72152,
    CnID = "怪物@环形融蚀体中B",
    BaseSortID = 399,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84293},
    MonsterName = "MonsterConfig_72152_MonsterName|紧急联络",
    Desc = "MonsterConfig_72152_Desc|「姐姐啊，我好想好想再听一次你的声音。」",
    ExistState = {
      73566,
      22074,
      89575
    },
    StateLayers = "1,1",
    StateParams = "CmdCaster.atk*0.025,CmdCaster.max_hp*0.05",
    InitSkillList = {
      72115,
      72119,
      72115,
      72125
    },
    CycleSkillList1 = {
      72115,
      72119,
      72115,
      72125
    },
    AnimationID = 73556,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0902.png",
    Scale = 1,
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 0.26,
    MonsterProportion = 0.55
  },
  [72151] = {
    ID = 72151,
    CnID = "怪物@环形融蚀体大",
    BaseSortID = 400,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 84293},
    MonsterName = "MonsterConfig_72151_MonsterName|拥抱你我",
    Desc = "MonsterConfig_72151_Desc|「亲爱的，我还能和你再次拥抱吗？」",
    ExistState = {
      73520,
      22074,
      89575,
      122675
    },
    StateLayers = "1,1",
    InitSkillList = {
      72107,
      72114,
      72122,
      72113
    },
    CycleSkillList1 = {
      72107,
      72114,
      72122,
      72113
    },
    AnimationID = 73548,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0903.png",
    Scale = 1,
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 0.8,
    MonsterProportion = 0.75
  },
  [72141] = {
    ID = 72141,
    CnID = "怪物@环形融蚀体中精英",
    BaseSortID = 401,
    BattleTag = "Elite",
    MonsterTag = {90641, 84297},
    MonsterName = "MonsterConfig_72141_MonsterName|失联之人",
    Desc = "MonsterConfig_72141_Desc|末日已至，残余的灵性相互呼告：请与我产生联络。",
    ExistState = {73570, 89575},
    StateLayers = 1,
    StateParams = "CmdCaster.atk*0.025,CmdCaster.max_hp*0.03",
    InitSkillList = {
      74030,
      72110,
      74030,
      72118
    },
    CycleSkillList1 = {
      74030,
      72110,
      74030,
      72118
    },
    AnimationID = 73551,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0902.png",
    Scale = 1.1,
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 0.07,
    MonsterProportion = 1
  },
  [72145] = {
    ID = 72145,
    CnID = "怪物@环形融蚀体大精英",
    BaseSortID = 402,
    BattleTag = "Elite",
    MonsterTag = {90641, 84293},
    MonsterName = "MonsterConfig_72145_MonsterName|融合你我",
    Desc = "MonsterConfig_72145_Desc|末日已至，残余的灵性相互呼告：请与我的灵性融为一体。",
    ExistState = {73520, 89575},
    StateLayers = 1,
    InitSkillList = {
      72124,
      74028,
      72120,
      72113
    },
    CycleSkillList1 = {
      72124,
      72114,
      72120,
      72113
    },
    AnimationID = 73559,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0903.png",
    Scale = 1.1,
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 0.92,
    MonsterProportion = 0.75
  },
  [72149] = {
    ID = 72149,
    CnID = "怪物@环形融蚀体中BOSS",
    BaseSortID = 403,
    BattleTag = "Boss",
    MonsterTag = {84277, 84293},
    MonsterName = "MonsterConfig_72149_MonsterName|「@2无法@1传递」",
    Desc = "MonsterConfig_72149_Desc|讯号飘散在灰雾笼罩的空中。",
    ExistState = {73573, 89575},
    StateLayers = 1,
    StateParams = "CmdCaster.atk*0.025,CmdCaster.max_hp*0.02",
    InitSkillList = {
      74030,
      72110,
      74030,
      72118,
      74040
    },
    CycleSkillList1 = {
      74030,
      72110,
      74030,
      72118
    },
    AnimationID = 73550,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0902.png",
    Scale = 1.25,
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 0.06,
    MonsterProportion = 1
  },
  [72143] = {
    ID = 72143,
    CnID = "怪物@环形融蚀体大BOSS",
    BaseSortID = 404,
    BattleTag = "Boss",
    MonsterTag = {84277, 84293},
    MonsterName = "MonsterConfig_72143_MonsterName|「@2银芯@1一体」",
    Desc = "MonsterConfig_72143_Desc|扭曲的肢体绞缠在一处。",
    ExistState = {73520, 89575},
    StateLayers = 1,
    InitSkillList = {
      72113,
      72124,
      74028,
      74029
    },
    CycleSkillList1 = {
      72113,
      72124,
      74028,
      72120
    },
    AnimationID = 73558,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0903.png",
    Scale = 1.25,
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 0.71,
    MonsterProportion = 0.75
  },
  [73524] = {
    ID = 73524,
    CnID = "怪物@唤醒体本源朵尔深渊形态",
    BaseSortID = 405,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      84294
    },
    MonsterName = "MonsterConfig_73524_MonsterName|「熔毁·朵尔」",
    Desc = "MonsterConfig_73524_Desc|她开启深渊，她带来末日。",
    ExistState = {
      77688,
      60312,
      62213,
      2921,
      67266
    },
    StateLayers = "1,15,50,1",
    InitSkillList = {77684},
    CycleSkillList1 = {
      77847,
      77846,
      77847,
      77846,
      77847,
      77846,
      77847,
      77846
    },
    AnimationID = 73547,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C02EX_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0,
    MonsterProportion = 0.8,
    MonsterHpNum = 2
  },
  [74035] = {
    ID = 74035,
    CnID = "怪物@恶堕莎拉BOSS",
    BaseSortID = 406,
    BattleTag = "Boss",
    MonsterTag = {84277, 90645},
    MonsterName = "MonsterConfig_74035_MonsterName|「院长」莎拉",
    Desc = "MonsterConfig_74035_Desc|无法自控陷入癫狂的莎拉，额角的伤疤透露出一丝银色的瘢痕。",
    ExistState = {2921},
    StateLayers = "CmdCaster.atk*0.03",
    InitSkillList = {
      73527,
      73528,
      73525,
      73526
    },
    CycleSkillList1 = {
      73527,
      73528,
      73525,
      73526
    },
    AnimationID = 15783,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0102_CT.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.67,
    MonsterProportion = 1
  },
  [73521] = {
    ID = 73521,
    CnID = "怪物@唤醒体克莱门汀突袭版",
    BaseSortID = 407,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90644
    },
    MonsterName = "MonsterConfig_73521_MonsterName|「催眠妖虫」",
    Desc = "MonsterConfig_73521_Desc|总是十分温柔的心理医生，无论何时都保持着得体的微笑。",
    ExistState = {73533, 73535},
    StateLayers = "1,1",
    InitSkillList = {80355},
    CycleSkillList1 = {
      80969,
      73476,
      80969,
      73476,
      73482
    },
    AnimationID = 73549,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D13_AF.png",
    Scale = 1,
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 1.31,
    MonsterProportion = 1
  },
  [73523] = {
    ID = 73523,
    CnID = "怪物@都怪你狂放版",
    BaseSortID = 408,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_73523_MonsterName|「不会吧…」",
    Desc = "MonsterConfig_73523_Desc|「不会的不会的不会的，我们已经很努力地活下去了…」",
    ExistState = {22074},
    StateLayers = 1,
    InitSkillList = {73475, 73477},
    AnimationID = 15759,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0001.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [79935] = {
    ID = 79935,
    CnID = "怪物@虫化人类A",
    BaseSortID = 409,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84298},
    MonsterName = "MonsterConfig_79935_MonsterName|初变者",
    Desc = "MonsterConfig_79935_Desc|「@2仪式 」初期的人类，正跨越自身的层次，迈入生命进化的门槛。",
    ExistState = {
      80787,
      80432,
      80778,
      22074
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1",
    InitSkillList = {
      80591,
      80590,
      80588
    },
    CycleSkillList1 = {
      80591,
      80590,
      80588
    },
    AnimationID = 79955,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0201.png",
    Scale = 1,
    MonsterHpPercent = 1.5,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [79944] = {
    ID = 79944,
    CnID = "怪物@虫化人类B",
    BaseSortID = 410,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84298},
    MonsterName = "MonsterConfig_79944_MonsterName|初变者",
    Desc = "MonsterConfig_79944_Desc|「@2仪式 」初期的人类，正跨越自身的层次，迈入生命进化的门槛。",
    ExistState = {
      80787,
      80432,
      80778,
      22074
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1",
    InitSkillList = {
      80588,
      80587,
      80590
    },
    CycleSkillList1 = {
      80588,
      80587,
      80590
    },
    AnimationID = 79956,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0201.png",
    Scale = 1,
    MonsterHpPercent = 1.3,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [81360] = {
    ID = 81360,
    CnID = "怪物@虫化人类换皮A",
    BaseSortID = 411,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84298},
    MonsterName = "MonsterConfig_81360_MonsterName|初变者",
    Desc = "MonsterConfig_81360_Desc|「@2仪式 」初期的人类，正跨越自身的层次，迈入生命进化的门槛。",
    ExistState = {
      80787,
      80432,
      80778,
      22074
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1",
    InitSkillList = {
      80591,
      80590,
      80588
    },
    CycleSkillList1 = {
      80591,
      80590,
      80588
    },
    AnimationID = 81365,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0201_AT.png",
    Scale = 1,
    MonsterHpPercent = 1.5,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [81359] = {
    ID = 81359,
    CnID = "怪物@虫化人类换皮B",
    BaseSortID = 412,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84298},
    MonsterName = "MonsterConfig_81359_MonsterName|初变者",
    Desc = "MonsterConfig_81359_Desc|「@2仪式 」初期的人类，正跨越自身的层次，迈入生命进化的门槛。",
    ExistState = {
      80787,
      80432,
      80778,
      22074
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1",
    InitSkillList = {
      80588,
      80587,
      80590
    },
    CycleSkillList1 = {
      80588,
      80587,
      80590
    },
    AnimationID = 81365,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0201_AT.png",
    Scale = 1,
    MonsterHpPercent = 1.3,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [79942] = {
    ID = 79942,
    CnID = "怪物@小型虫族A",
    BaseSortID = 413,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84298},
    MonsterName = "MonsterConfig_79942_MonsterName|蜕化者",
    Desc = "MonsterConfig_79942_Desc|「@2仪式 」后期的人类。血肉消融的痛苦里，它必将超脱人类的极限。",
    ExistState = {
      80787,
      80432,
      80791,
      80777,
      22074
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1",
    StateParams = "CmdCaster.atk*0.15,CmdCaster.max_hp*0.01",
    InitSkillList = {
      80585,
      80586,
      80589,
      80586
    },
    CycleSkillList1 = {
      80585,
      80586,
      80589,
      80586
    },
    AnimationID = 79947,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0202.png",
    Scale = 1,
    MonsterHpPercent = 1.6,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0,
    MonsterProportion = 0.4
  },
  [79941] = {
    ID = 79941,
    CnID = "怪物@小型虫族B",
    BaseSortID = 414,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84298},
    MonsterName = "MonsterConfig_79941_MonsterName|蜕化者",
    Desc = "MonsterConfig_79941_Desc|「@2仪式 」后期的人类。血肉消融的痛苦里，它必将超脱人类的极限。",
    ExistState = {
      80787,
      80432,
      80791,
      80777,
      22074
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1",
    StateParams = "CmdCaster.atk*0.15,CmdCaster.max_hp*0.01",
    InitSkillList = {
      80589,
      80586,
      80585,
      80586
    },
    CycleSkillList1 = {
      80589,
      80586,
      80585,
      80586
    },
    AnimationID = 79945,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0202.png",
    Scale = 1,
    MonsterHpPercent = 1.45,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.4
  },
  [81358] = {
    ID = 81358,
    CnID = "怪物@小型虫族C",
    BaseSortID = 415,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84298},
    MonsterName = "MonsterConfig_81358_MonsterName|蜕化者",
    Desc = "MonsterConfig_81358_Desc|「@2仪式 」后期的人类。血肉消融的痛苦里，它必将超脱人类的极限。",
    ExistState = {
      80787,
      80432,
      80791,
      80777,
      22074
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1",
    StateParams = "CmdCaster.atk*0.15,CmdCaster.max_hp*0.01",
    InitSkillList = {
      80586,
      80585,
      80586,
      80589
    },
    CycleSkillList1 = {
      80586,
      80585,
      80586,
      80589
    },
    AnimationID = 79945,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0202.png",
    Scale = 1,
    MonsterHpPercent = 1.52,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.4
  },
  [81363] = {
    ID = 81363,
    CnID = "怪物@小型虫族换皮A",
    BaseSortID = 416,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84298},
    MonsterName = "MonsterConfig_81363_MonsterName|蜕化者",
    Desc = "MonsterConfig_81363_Desc|「@2仪式 」后期的人类。血肉消融的痛苦里，它必将超脱人类的极限。",
    ExistState = {
      80787,
      80432,
      80791,
      80777
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1",
    StateParams = "CmdCaster.atk*0.15,CmdCaster.max_hp*0.01",
    InitSkillList = {
      80585,
      80586,
      80589,
      80585
    },
    CycleSkillList1 = {
      80585,
      80586,
      80589,
      80585
    },
    AnimationID = 81066,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0202_AT.png",
    Scale = 1,
    MonsterHpPercent = 1.8,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0,
    MonsterProportion = 0.4
  },
  [81364] = {
    ID = 81364,
    CnID = "怪物@小型虫族换皮B",
    BaseSortID = 417,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84298},
    MonsterName = "MonsterConfig_81364_MonsterName|蜕化者",
    Desc = "MonsterConfig_81364_Desc|「@2仪式 」后期的人类。血肉消融的痛苦里，它必将超脱人类的极限。",
    ExistState = {
      80787,
      80432,
      80791,
      80777
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1",
    StateParams = "CmdCaster.atk*0.15,CmdCaster.max_hp*0.01",
    InitSkillList = {
      80589,
      80586,
      80585,
      80586
    },
    CycleSkillList1 = {
      80589,
      80586,
      80585,
      80586
    },
    AnimationID = 81066,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0202_AT.png",
    Scale = 1,
    MonsterHpPercent = 1.6,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.4
  },
  [81366] = {
    ID = 81366,
    CnID = "怪物@小型虫族换皮C",
    BaseSortID = 418,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 84298},
    MonsterName = "MonsterConfig_81366_MonsterName|蜕化者",
    Desc = "MonsterConfig_81366_Desc|「@2仪式 」后期的人类。血肉消融的痛苦里，它必将超脱人类的极限。",
    ExistState = {
      80787,
      80432,
      80791,
      80777
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1",
    StateParams = "CmdCaster.atk*0.15,CmdCaster.max_hp*0.01",
    InitSkillList = {80586, 80585},
    CycleSkillList1 = {
      80586,
      80589,
      80586,
      80585
    },
    AnimationID = 81066,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0202.png",
    Scale = 1,
    MonsterHpPercent = 1.7,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.4
  },
  [80817] = {
    ID = 80817,
    CnID = "怪物@大型虫族A",
    BaseSortID = 419,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 84298},
    MonsterName = "MonsterConfig_80817_MonsterName|至善至美",
    Desc = "MonsterConfig_80817_Desc|扭曲的新生中，它超越自身，获得了最完美的生命形态。",
    ExistState = {
      80787,
      80432,
      80792,
      80785,
      22074
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1",
    InitSkillList = {
      80606,
      80607,
      80605,
      80607
    },
    CycleSkillList1 = {
      80606,
      80607,
      80605,
      80607
    },
    AnimationID = 80822,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0203.png",
    Scale = 1,
    MonsterHpPercent = 2,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 0,
    MonsterProportion = 0.7
  },
  [80816] = {
    ID = 80816,
    CnID = "怪物@大型虫族B",
    BaseSortID = 420,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 84298},
    MonsterName = "MonsterConfig_80816_MonsterName|至善至美",
    Desc = "MonsterConfig_80816_Desc|扭曲的新生中，它超越自身，获得了最完美的生命形态。",
    ExistState = {
      80787,
      80432,
      80792,
      80785,
      22074
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1",
    InitSkillList = {
      80607,
      80605,
      80607,
      80606
    },
    CycleSkillList1 = {
      80607,
      80605,
      80607,
      80606
    },
    AnimationID = 80820,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0203.png",
    Scale = 1,
    MonsterHpPercent = 2.2,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.7
  },
  [81361] = {
    ID = 81361,
    CnID = "怪物@大型虫族换皮A",
    BaseSortID = 421,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 84298},
    MonsterName = "MonsterConfig_81361_MonsterName|至善至美",
    Desc = "MonsterConfig_81361_Desc|扭曲的新生中，它超越自身，获得了最完美的生命形态。",
    ExistState = {
      80787,
      80432,
      80792,
      80785
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1",
    InitSkillList = {
      80606,
      80607,
      80605,
      80607
    },
    CycleSkillList1 = {
      80606,
      80607,
      80605,
      80607
    },
    AnimationID = 81065,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0203.png",
    Scale = 1,
    MonsterHpPercent = 2,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 0,
    MonsterProportion = 0.7
  },
  [81362] = {
    ID = 81362,
    CnID = "怪物@大型虫族换皮B",
    BaseSortID = 422,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 84298},
    MonsterName = "MonsterConfig_81362_MonsterName|至善至美",
    Desc = "MonsterConfig_81362_Desc|扭曲的新生中，它超越自身，获得了最完美的生命形态。",
    ExistState = {
      80787,
      80432,
      80792,
      80785
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1",
    InitSkillList = {
      80607,
      80605,
      80607,
      80606
    },
    CycleSkillList1 = {
      80607,
      80605,
      80607,
      80606
    },
    AnimationID = 81065,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0203_AT.png",
    Scale = 1,
    MonsterHpPercent = 2.2,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.7
  },
  [79934] = {
    ID = 79934,
    CnID = "怪物@大型虫化植物",
    BaseSortID = 423,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 84298},
    MonsterName = "MonsterConfig_79934_MonsterName|融为一体",
    Desc = "MonsterConfig_79934_Desc|融合的仪式中，已分不清那一块属于「你」，那一块属于「我」。",
    ExistState = {
      80787,
      80432,
      80772,
      80784,
      2921,
      22074,
      125004
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1,1",
    InitSkillList = {
      80766,
      80765,
      80760,
      80765
    },
    CycleSkillList1 = {
      80766,
      80765,
      80760,
      80765
    },
    AnimationID = 79949,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0204.png",
    Scale = 1,
    MonsterHpPercent = 2.6,
    MonsterAtkPercent = 0.85,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [80819] = {
    ID = 80819,
    CnID = "怪物@大型虫族精英",
    BaseSortID = 424,
    BattleTag = "Elite",
    MonsterTag = {90641, 84298},
    MonsterName = "MonsterConfig_80819_MonsterName|拥抱进化",
    Desc = "MonsterConfig_80819_Desc|世界在燃烧，唯有觉悟抛弃一切之人才可获得救赎。",
    ExistState = {
      80787,
      80432,
      80785,
      2921
    },
    StateLayers = "CmdCaster.max_hp*0.03,1,1,1",
    InitSkillList = {
      80606,
      80608,
      80768,
      80609
    },
    CycleSkillList1 = {
      80606,
      80608,
      80768,
      80609
    },
    AnimationID = 80821,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0203.png",
    Scale = 1.1,
    MonsterHpPercent = 1.9,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [80818] = {
    ID = 80818,
    CnID = "怪物@大型虫族BOSS",
    BaseSortID = 425,
    BattleTag = "Boss",
    MonsterTag = {84277, 84298},
    MonsterName = "MonsterConfig_80818_MonsterName|「@2庇护者」",
    Desc = "MonsterConfig_80818_Desc|眼目所在之处，巢群意志无所不知，",
    ExistState = {
      80811,
      80432,
      80788,
      2921
    },
    StateLayers = "CmdCaster.max_hp*0.01,1,1,1",
    InitSkillList = {
      80606,
      80608,
      80755,
      80609,
      80763,
      80608,
      80755,
      80609
    },
    CycleSkillList1 = {
      80753,
      80608,
      80755,
      80609,
      80763,
      80608,
      80755,
      80609
    },
    AnimationID = 80823,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0203.png",
    Scale = 1.2,
    MonsterHpPercent = 1.4,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [79933] = {
    ID = 79933,
    CnID = "怪物@大型虫化植物精英",
    BaseSortID = 426,
    BattleTag = "Elite",
    MonsterTag = {90641, 84298},
    MonsterName = "MonsterConfig_79933_MonsterName|感受进化",
    Desc = "MonsterConfig_79933_Desc|世界在燃烧，唯有聆听宇宙嗡鸣之人才可获得救赎。",
    ExistState = {
      80787,
      80432,
      80772,
      80784,
      2921,
      125004
    },
    StateLayers = "CmdCaster.max_hp*0.03,1,1,1,1",
    InitSkillList = {
      80762,
      80751,
      80750,
      80751
    },
    CycleSkillList1 = {
      80762,
      80751,
      80750,
      80751
    },
    AnimationID = 79950,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0204.png",
    Scale = 1.05,
    MonsterHpPercent = 3,
    MonsterAtkPercent = 0.85,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [79943] = {
    ID = 79943,
    CnID = "怪物@大型虫化植物BOSS",
    BaseSortID = 427,
    BattleTag = "Boss",
    MonsterTag = {84277, 84298},
    MonsterName = "MonsterConfig_79943_MonsterName|「@2赐福者」",
    Desc = "MonsterConfig_79943_Desc|爪牙所到之处，巢群意志无所不在。",
    ExistState = {
      80787,
      80432,
      80772,
      81073,
      2921,
      125004
    },
    StateLayers = "CmdCaster.max_hp*0.06,1,1,1,1",
    InitSkillList = {
      81071,
      80751,
      80750,
      80751,
      80769,
      80751,
      80750,
      80751
    },
    CycleSkillList1 = {
      81071,
      80751,
      80750,
      80751,
      80769,
      80751,
      80750,
      80751
    },
    AnimationID = 79954,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0204.png",
    Scale = 1.25,
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.85,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [79938] = {
    ID = 79938,
    CnID = "怪物@夏盖投影",
    BaseSortID = 428,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84294,
      84298
    },
    MonsterName = "MonsterConfig_79938_MonsterName|「超维@2之蛹」",
    Desc = "MonsterConfig_79938_Desc|它跨越维度，响应呼唤而来。",
    ExistState = {
      80770,
      80432,
      80790,
      80773,
      80807,
      125004
    },
    StateLayers = "CmdCaster.max_hp*0.1,1,4,1,1",
    InitSkillList = {
      80759,
      80754,
      80759,
      81343,
      80752
    },
    CycleSkillList1 = {
      80757,
      80758,
      80764,
      80758,
      80757,
      80764
    },
    AnimationID = 79946,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0002.png",
    Scale = 1,
    MonsterHpPercent = 0.65,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [80576] = {
    ID = 80576,
    CnID = "怪物@提灯蜡像男BOSS",
    BaseSortID = 429,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90646,
      90645,
      84280
    },
    MonsterName = "MonsterConfig_80576_MonsterName|残酷的「父亲」",
    Desc = "MonsterConfig_80576_Desc|实验品没有父母，但仍渴望有人承担「父亲」的身份。哪怕他并不称职。",
    ExistState = {80445, 60926},
    StateLayers = "1,CmdCaster.atk*0.1",
    StateParams = 2,
    InitSkillList = {
      60939,
      60929,
      60931,
      60930
    },
    CycleSkillList1 = {
      60929,
      60931,
      60930
    },
    AnimationID = 60901,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0802.png",
    Scale = 1.25,
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 0.98,
    MonsterDefPercent = 0.24,
    MonsterProportion = 0.65
  },
  [80577] = {
    ID = 80577,
    CnID = "怪物@提灯蜡像女BOSS",
    BaseSortID = 430,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90646,
      90645,
      84280
    },
    MonsterName = "MonsterConfig_80577_MonsterName|沉默的「母亲」",
    Desc = "MonsterConfig_80577_Desc|实验品没有父母，但仍渴望有人承担「母亲」的身份。哪怕她并不称职。",
    ExistState = {80445, 60925},
    StateLayers = "1,CmdCaster.atk*0.02",
    InitSkillList = {
      60937,
      60927,
      60933,
      60938
    },
    CycleSkillList1 = {
      60927,
      60933,
      60938
    },
    AnimationID = 60904,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0803.png",
    Scale = 1.25,
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = 2.68,
    MonsterProportion = 0.65
  },
  [80795] = {
    ID = 80795,
    CnID = "怪物@济贫院疯子BOSS冰镐",
    BaseSortID = 431,
    BattleTag = "Boss",
    MonsterTag = {84277, 90645},
    MonsterName = "MonsterConfig_80795_MonsterName|精神分裂患者",
    Desc = "MonsterConfig_80795_Desc|「医生、医生！你明明说过我已经痊愈，为什么我的幻视和幻听仍旧存在？」",
    ExistState = {2559, 80827},
    StateLayers = "CmdCaster.atk*0.02,15",
    InitSkillList = {
      22346,
      22344,
      22345,
      80749
    },
    CycleSkillList1 = {
      22344,
      22345,
      80749
    },
    AnimationID = 22338,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0102_DT.png",
    Scale = 1.5,
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [81020] = {
    ID = 81020,
    CnID = "怪物@克莱门汀试玩大搜查猫",
    BaseSortID = 432,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84291,
      84279
    },
    MonsterName = "MonsterConfig_81020_MonsterName|大搜查猫",
    Desc = "MonsterConfig_81020_Desc|某些工作不止犬科能做。",
    ExistState = {60000},
    StateLayers = "1,1",
    InitSkillList = {
      60003,
      60002,
      60001
    },
    CycleSkillList1 = {
      60003,
      60002,
      60001
    },
    AnimationID = 35625,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S0602.png",
    Scale = 1.25,
    MonsterHpPercent = 1.1,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0.85,
    MonsterProportion = 0.4
  },
  [84437] = {
    ID = 84437,
    CnID = "怪物@唤醒体克珀珊特",
    BaseSortID = 433,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90643
    },
    MonsterName = "MonsterConfig_84437_MonsterName|「冷光」",
    Desc = "MonsterConfig_84437_Desc|测算、规划、挥舞旗帜。她会不计一切代价，完成自己的使命！",
    ExistState = {
      84401,
      84398,
      84397,
      83816,
      89261
    },
    StateLayers = "1,0,1,1,1",
    InitSkillList = {84383},
    CycleSkillList1 = {
      84384,
      84388,
      84383
    },
    CycleSkillList2 = {
      84387,
      84387,
      84385,
      84388
    },
    AnimationID = 89240,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O10_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.25,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.6,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [91739] = {
    ID = 91739,
    CnID = "怪物@唤醒体卡斯托尔",
    BaseSortID = 434,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90644
    },
    MonsterName = "MonsterConfig_91739_MonsterName|「圣子·黑羽」",
    Desc = "MonsterConfig_91739_Desc|「我会夺回我们的自由，波吕克斯……」",
    ExistState = {
      91762,
      91758,
      91760
    },
    StateLayers = "1,1",
    InitSkillList = {91745},
    CycleSkillList1 = {
      91743,
      91746,
      91743,
      91745
    },
    CycleSkillList2 = {
      91744,
      91745,
      91742,
      91742
    },
    AnimationID = 91740,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D11_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.44,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = 1.072,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [95784] = {
    ID = 95784,
    CnID = "怪物@唤醒体杜勒赛因",
    BaseSortID = 435,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      84303
    },
    MonsterName = "MonsterConfig_95784_MonsterName|「葬骸之主」",
    Desc = "MonsterConfig_95784_Desc|「粗鲁的动作可不符合客人应有的礼仪，守密人阁下。」",
    ExistState = {
      95960,
      95953,
      95959,
      96337
    },
    StateLayers = "10,1,1",
    InitSkillList = {95821},
    CycleSkillList1 = {
      95826,
      95827,
      95825,
      95821
    },
    CycleSkillList2 = {
      95816,
      95818,
      95823,
      95807
    },
    AnimationID = 95802,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B10_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.068,
    MonsterProportion = 0.75,
    MonsterHpNum = 2
  },
  [98118] = {
    ID = 98118,
    CnID = "怪物@唤醒体凯蒂古拉",
    BaseSortID = 436,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    MonsterName = "MonsterConfig_98118_MonsterName|「爆燃之主」",
    Desc = "MonsterConfig_98118_Desc|「统御无数炎精的爆燃之主，会伴随琥珀色的火焰从极天坠下。当祂降临之时，所有的一切都会迎来平等的死亡。」",
    ExistState = {
      98148,
      98140,
      123275,
      123277,
      123281,
      124748
    },
    StateLayers = "1,5,1,1,1",
    InitSkillList = {
      98127,
      98121,
      98119
    },
    CycleSkillList1 = {
      98127,
      98121,
      98119
    },
    CycleSkillList2 = {
      98127,
      123270,
      98119
    },
    AnimationID = 98514,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C16_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.33,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [94654] = {
    ID = 94654,
    CnID = "怪物@食尸鬼团块A",
    BaseSortID = 437,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      94556,
      84303
    },
    MonsterName = "MonsterConfig_94654_MonsterName|腐尸分殖体",
    Desc = "MonsterConfig_94654_Desc|葬骸城秘术制造出的产物。一位一往无前的战士，一道差强人意的甜点。",
    ExistState = {
      94603,
      94693,
      96337,
      22074
    },
    StateLayers = "1,1",
    InitSkillList = {94685},
    CycleSkillList1 = {
      94686,
      94684,
      94683,
      94685
    },
    AnimationID = 94681,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_BUnit_Monster_S2C0301_BT.png",
    Scale = 1,
    MonsterHpPercent = 1.4,
    MonsterAtkPercent = 0.8,
    MonsterDefPercent = 0,
    MonsterProportion = 0.2
  },
  [94679] = {
    ID = 94679,
    CnID = "怪物@食尸鬼团块B",
    BaseSortID = 438,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      94556,
      84303
    },
    MonsterName = "MonsterConfig_94679_MonsterName|腐尸分殖体",
    Desc = "MonsterConfig_94679_Desc|葬骸城秘术制造出的产物。一位一往无前的战士，一道差强人意的甜点。",
    ExistState = {
      94603,
      94693,
      96337,
      22074
    },
    StateLayers = "1,1",
    InitSkillList = {94683},
    CycleSkillList1 = {
      94685,
      94686,
      94684,
      94683
    },
    AnimationID = 94681,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_BUnit_Monster_S2C0301_BT.png",
    Scale = 1,
    MonsterHpPercent = 1.5,
    MonsterAtkPercent = 0.75,
    MonsterDefPercent = 0.86,
    MonsterProportion = 0.2
  },
  [94680] = {
    ID = 94680,
    CnID = "怪物@食尸鬼团块C",
    BaseSortID = 439,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      94556,
      84303
    },
    MonsterName = "MonsterConfig_94680_MonsterName|腐尸分殖体",
    Desc = "MonsterConfig_94680_Desc|葬骸城秘术制造出的产物。一位一往无前的战士，一道差强人意的甜点。",
    ExistState = {
      94603,
      94693,
      96183,
      96337,
      22074
    },
    StateLayers = "1,1,1",
    InitSkillList = {94684},
    CycleSkillList1 = {
      94683,
      94685,
      94686,
      94684
    },
    AnimationID = 94681,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_BUnit_Monster_S2C0301_BT.png",
    Scale = 1,
    MonsterHpPercent = 1.65,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 0,
    MonsterProportion = 0.2
  },
  [94700] = {
    ID = 94700,
    CnID = "怪物@蹈海者团块A",
    BaseSortID = 440,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      94556,
      90643
    },
    MonsterName = "MonsterConfig_94700_MonsterName|深海分殖体",
    Desc = "MonsterConfig_94700_Desc|蹈海者用葬骸城秘术制造出的产物，拥有蹈海者需要的一切……除了信仰。",
    ExistState = {
      94603,
      94708,
      96337,
      22074
    },
    StateLayers = "1,1",
    InitSkillList = {94703},
    CycleSkillList1 = {
      94686,
      94704,
      94685,
      94703
    },
    AnimationID = 94682,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_BUnit_Monster_S2C0301_CT.png",
    Scale = 1,
    MonsterHpPercent = 1.4,
    MonsterAtkPercent = 0.8,
    MonsterDefPercent = 0.26,
    MonsterProportion = 0.2
  },
  [94701] = {
    ID = 94701,
    CnID = "怪物@蹈海者团块B",
    BaseSortID = 441,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      94556,
      90643
    },
    MonsterName = "MonsterConfig_94701_MonsterName|深海分殖体",
    Desc = "MonsterConfig_94701_Desc|蹈海者用葬骸城秘术制造出的产物，拥有蹈海者需要的一切……除了信仰。",
    ExistState = {
      94708,
      96337,
      22074
    },
    StateLayers = 1,
    InitSkillList = {94685},
    CycleSkillList1 = {
      94703,
      94686,
      94704,
      94685
    },
    AnimationID = 94682,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_BUnit_Monster_S2C0301_CT.png",
    Scale = 1,
    MonsterHpPercent = 1.5,
    MonsterAtkPercent = 0.75,
    MonsterDefPercent = 0.26,
    MonsterProportion = 0.2
  },
  [94702] = {
    ID = 94702,
    CnID = "怪物@蹈海者团块C",
    BaseSortID = 442,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      94556,
      90643
    },
    MonsterName = "MonsterConfig_94702_MonsterName|深海分殖体",
    Desc = "MonsterConfig_94702_Desc|蹈海者用葬骸城秘术制造出的产物，拥有蹈海者需要的一切……除了信仰。",
    ExistState = {
      94708,
      96337,
      22074
    },
    StateLayers = 1,
    InitSkillList = {94704},
    CycleSkillList1 = {
      94685,
      94703,
      94686,
      94704
    },
    AnimationID = 94682,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_BUnit_Monster_S2C0301_CT.png",
    Scale = 1,
    MonsterHpPercent = 1.6,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 0.9,
    MonsterProportion = 0.2
  },
  [94718] = {
    ID = 94718,
    CnID = "怪物@小型食尸鬼A",
    BaseSortID = 443,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      94556,
      84303
    },
    MonsterName = "MonsterConfig_94718_MonsterName|食尸鬼侍从",
    Desc = "MonsterConfig_94718_Desc|葬骸城随处可见的居民，拙劣的食客，粗粝的食材。",
    ExistState = {
      94603,
      80787,
      95040,
      96337,
      22074
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,50,1",
    InitSkillList = {94711},
    CycleSkillList1 = {
      94709,
      94725,
      94711
    },
    AnimationID = 94721,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0302.png",
    Scale = 1,
    MonsterHpPercent = 1.81,
    MonsterAtkPercent = 0.97,
    MonsterDefPercent = 1.03,
    MonsterProportion = 0.6
  },
  [94715] = {
    ID = 94715,
    CnID = "怪物@小型食尸鬼B",
    BaseSortID = 444,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      94556,
      84303
    },
    MonsterName = "MonsterConfig_94715_MonsterName|食尸鬼侍从",
    Desc = "MonsterConfig_94715_Desc|葬骸城随处可见的居民，拙劣的食客，粗粝的食材。",
    ExistState = {
      94603,
      80787,
      95040,
      96337,
      22074
    },
    StateLayers = "1,CmdCaster.max_hp*0.04,50,1",
    InitSkillList = {94709},
    CycleSkillList1 = {
      94726,
      94711,
      94709
    },
    AnimationID = 94721,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0302.png",
    Scale = 1,
    MonsterHpPercent = 1.65,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.52,
    MonsterProportion = 0.6
  },
  [94717] = {
    ID = 94717,
    CnID = "怪物@小型食尸鬼精英",
    BaseSortID = 445,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      94556,
      84303
    },
    MonsterName = "MonsterConfig_94717_MonsterName|食尸鬼护卫",
    Desc = "MonsterConfig_94717_Desc|他为看护王邸、也为看护王邸中的餐点而战。",
    ExistState = {
      94603,
      80787,
      60087,
      95040,
      96337,
      2921
    },
    StateLayers = "1,CmdCaster.max_hp*0.03,50,1",
    InitSkillList = {94731},
    CycleSkillList1 = {
      94725,
      94722,
      94711,
      94731
    },
    AnimationID = 94719,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0302.png",
    Scale = 1.05,
    MonsterHpPercent = 1.9,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.69,
    MonsterProportion = 0.95
  },
  [94716] = {
    ID = 94716,
    CnID = "怪物@小型食尸鬼BOSS",
    BaseSortID = 446,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      94556,
      84303
    },
    MonsterName = "MonsterConfig_94716_MonsterName|食尸鬼卫队长",
    Desc = "MonsterConfig_94716_Desc|没有任何可为人称道的天赋，只有甘愿为王城献身的勇气。",
    ExistState = {
      94603,
      80787,
      60087,
      95040,
      96337,
      2921
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,50,1",
    InitSkillList = {94731},
    CycleSkillList1 = {
      94732,
      94723,
      94711,
      94731
    },
    AnimationID = 94720,
    MonsterClass = "Boss",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0302.png",
    Scale = 1.15,
    MonsterHpPercent = 2.25,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.61,
    MonsterProportion = 0.9
  },
  [94944] = {
    ID = 94944,
    CnID = "怪物@大型食尸鬼",
    BaseSortID = 447,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      94556,
      84303
    },
    MonsterName = "MonsterConfig_94944_MonsterName|墓穴督工",
    Desc = "MonsterConfig_94944_Desc|天赋出众的食尸鬼，承担着王邸的期许——有什么工作比制作精良的食物储存地更加重要？",
    ExistState = {
      94600,
      94603,
      80787,
      96337,
      22074
    },
    StateLayers = "3,1,CmdCaster.max_hp*0.05",
    InitSkillList = {94964},
    CycleSkillList1 = {
      94965,
      94960,
      94955,
      94964
    },
    AnimationID = 94947,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0303.png",
    Scale = 1,
    MonsterHpPercent = 1.65,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 1.61,
    MonsterProportion = 0.9
  },
  [94945] = {
    ID = 94945,
    CnID = "怪物@大型食尸鬼精英",
    BaseSortID = 448,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      94556,
      84303
    },
    MonsterName = "MonsterConfig_94945_MonsterName|骸骨哨卫",
    Desc = "MonsterConfig_94945_Desc|他守护族人腐朽的尸骨。他守护同伴不舍的魂灵。",
    ExistState = {
      94600,
      94603,
      80787,
      96337
    },
    StateLayers = "5,1,CmdCaster.max_hp*0.04",
    InitSkillList = {94953},
    CycleSkillList1 = {
      94965,
      94960,
      94956,
      94953
    },
    AnimationID = 94947,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0303.png",
    Scale = 1.05,
    MonsterHpPercent = 1.8,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 1.53,
    MonsterProportion = 1
  },
  [96324] = {
    ID = 96324,
    CnID = "怪物@大型食尸鬼BOSS",
    BaseSortID = 449,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      94556,
      84303
    },
    MonsterName = "MonsterConfig_96324_MonsterName|「无尽饥渊」",
    Desc = "MonsterConfig_96324_Desc|王邸祭坛的祭司，为亡故的尸骸安葬。依悲鸣的记忆所愿，将他们献予葬骸城的王。",
    ExistState = {
      94600,
      94603,
      80787,
      94998,
      96337
    },
    StateLayers = "5,1,CmdCaster.max_hp*0.03,1",
    InitSkillList = {94953},
    CycleSkillList1 = {
      94965,
      94968,
      94954
    },
    CycleSkillList2 = {
      94953,
      94965,
      94968,
      94955
    },
    AnimationID = 94947,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0303.png",
    Scale = 1.15,
    MonsterHpPercent = 1.8,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 2.09,
    MonsterProportion = 1
  },
  [94940] = {
    ID = 94940,
    CnID = "怪物@大型食尸鬼管家",
    BaseSortID = 450,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      94556,
      84303
    },
    MonsterName = "MonsterConfig_94940_MonsterName|「王邸管家」弗兰",
    Desc = "MonsterConfig_94940_Desc|长相厮守的誓言，早在竭诚尽忠之前。",
    ExistState = {
      94600,
      94603,
      80787,
      96356,
      96354,
      96337,
      96610
    },
    StateLayers = "3,1,CmdCaster.max_hp*0.03,1,CmdCaster.max_hp,1",
    InitSkillList = {96344},
    CycleSkillList1 = {
      94965,
      96343,
      96345
    },
    CycleSkillList2 = {
      96344,
      94965,
      96343,
      96342
    },
    AnimationID = 96417,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0303_AT.png",
    Scale = 1.15,
    MonsterHpPercent = 1.35,
    MonsterAtkPercent = 1.03,
    MonsterDefPercent = 2.09,
    MonsterProportion = 1
  },
  [94941] = {
    ID = 94941,
    CnID = "怪物@蹈海者祭祀",
    BaseSortID = 451,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      94556,
      90643
    },
    MonsterName = "MonsterConfig_94941_MonsterName|蹈海者之骸",
    Desc = "MonsterConfig_94941_Desc|他们仍活着，他们已死去。他们苦难的大脑中仅剩唯一的记忆——唯有吾主的目光，能将痛苦驱离。",
    ExistState = {
      94600,
      80787,
      94995,
      94994,
      94993,
      96412,
      96337,
      22074
    },
    StateLayers = "2,CmdCaster.max_hp*0.05,1,6,1,1,1,1",
    InitSkillList = {94961},
    CycleSkillList1 = {
      94952,
      94966,
      94962,
      94961
    },
    AnimationID = 94946,
    ExAnimations = {94946},
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0304.png",
    Scale = 1,
    MonsterHpPercent = 1.8,
    MonsterAtkPercent = 0.85,
    MonsterDefPercent = 3.21,
    MonsterProportion = 0.9
  },
  [94942] = {
    ID = 94942,
    CnID = "怪物@蹈海者祭祀精英",
    BaseSortID = 452,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      94556,
      90643
    },
    MonsterName = "MonsterConfig_94942_MonsterName|殉道者",
    Desc = "MonsterConfig_94942_Desc|他们执行神明的意志，没有人在意生存与毁灭，没有人在意错误与正确。",
    ExistState = {
      96613,
      94600,
      80787,
      94995,
      95001,
      94999,
      96412,
      96337,
      2921
    },
    StateLayers = "1,2,CmdCaster.max_hp*0.04,1,8,1,1,1",
    InitSkillList = {94967},
    CycleSkillList1 = {
      94952,
      94966,
      94959,
      94967
    },
    AnimationID = 94948,
    ExAnimations = {94948},
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0304.png",
    Scale = 1.05,
    MonsterHpPercent = 1.7,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 3.37,
    MonsterProportion = 0.9
  },
  [94943] = {
    ID = 94943,
    CnID = "怪物@蹈海者祭祀首领",
    BaseSortID = 453,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      94556,
      90643
    },
    MonsterName = "MonsterConfig_94943_MonsterName|「瞑海祭司」",
    Desc = "MonsterConfig_94943_Desc|聆听吾主。归依……吾主！",
    ExistState = {
      96613,
      94600,
      80787,
      94995,
      95001,
      94999,
      96412,
      96337,
      2921
    },
    StateLayers = "1,2,CmdCaster.max_hp*0.04,1,8,1,1,1",
    InitSkillList = {94958},
    CycleSkillList1 = {
      94963,
      94966,
      94959,
      94958
    },
    AnimationID = 94950,
    ExAnimations = {94950},
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0304.png",
    Scale = 1.15,
    MonsterHpPercent = 1.28,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.09,
    MonsterProportion = 0.9
  },
  [96000] = {
    ID = 96000,
    CnID = "怪物@大型黑泥怪BOSS彩墨",
    BaseSortID = 454,
    BattleTag = "Boss",
    MonsterTag = {84277, 84293},
    MonsterName = "MonsterConfig_96000_MonsterName|倒错的画作",
    Desc = "MonsterConfig_96000_Desc|艺术，是疯狂的书面用语。",
    ExistState = {
      140654,
      89575,
      96337
    },
    InitSkillList = {
      96326,
      96328,
      96327,
      54461
    },
    CycleSkillList1 = {
      96326,
      96328,
      96327,
      54461
    },
    AnimationID = 140583,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD06_03.png",
    Scale = 1.15,
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.9,
    MonsterProportion = 1
  },
  [96656] = {
    ID = 96656,
    CnID = "怪物@小型黑泥怪彩墨A通用",
    BaseSortID = 455,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_96656_MonsterName|追随者",
    Desc = "MonsterConfig_96656_Desc|在诗中的西岱，他们追随柯蕾特的身影。",
    ExistState = {140659, 22074},
    InitSkillList = {
      54458,
      54459,
      54460
    },
    CycleSkillList1 = {
      54458,
      54459,
      54460
    },
    AnimationID = 140584,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD06_02.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = -0.75,
    MonsterProportion = 0.4
  },
  [96658] = {
    ID = 96658,
    CnID = "怪物@小型黑泥怪彩墨B通用",
    BaseSortID = 456,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_96658_MonsterName|渴求者",
    Desc = "MonsterConfig_96658_Desc|在诗中的西岱，他们渴求柯蕾特的恩典。",
    ExistState = {140659, 22074},
    InitSkillList = {
      54460,
      54458,
      54459
    },
    CycleSkillList1 = {
      54460,
      54458,
      54459
    },
    AnimationID = 140584,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD06_02.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = -0.75,
    MonsterProportion = 0.4
  },
  [96657] = {
    ID = 96657,
    CnID = "怪物@大型黑泥怪精英彩墨通用",
    BaseSortID = 457,
    BattleTag = "Elite",
    MonsterTag = {90641, 84293},
    MonsterName = "MonsterConfig_96657_MonsterName|伯爵夫人",
    Desc = "MonsterConfig_96657_Desc|「亲爱的伯爵夫人，我曾经的渴望。而如今，你已成为了我忠实的侍卫。替我向她，献上一首诗吧。」",
    ExistState = {140654, 89575},
    InitSkillList = {
      54453,
      54441,
      54449,
      54461
    },
    CycleSkillList1 = {
      54453,
      54441,
      54449,
      54461
    },
    AnimationID = 140583,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD06_03.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.9,
    MonsterProportion = 1
  },
  [96659] = {
    ID = 96659,
    CnID = "怪物@大型黑泥怪彩墨通用",
    BaseSortID = 458,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 84293},
    MonsterName = "MonsterConfig_96659_MonsterName|诗中人",
    Desc = "MonsterConfig_96659_Desc|坚定的拥护者，这是她能写出的全部意象。",
    ExistState = {
      140654,
      89575,
      22074
    },
    InitSkillList = {
      54454,
      54444,
      54447,
      54461
    },
    CycleSkillList1 = {
      54454,
      54444,
      54447,
      54461
    },
    AnimationID = 140583,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD06_03.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.9,
    MonsterProportion = 1
  },
  [96799] = {
    ID = 96799,
    CnID = "怪物@腐潮之傀",
    BaseSortID = 459,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      94556,
      90643,
      84294
    },
    MonsterName = "MonsterConfig_96799_MonsterName|「腐潮之傀」",
    Desc = "MonsterConfig_96799_Desc|聆听吧，那海洋的恸哭……聆听吧，那信众们的悲鸣！",
    ExistState = {
      96354,
      80787,
      96774,
      96808,
      97256,
      97118,
      97270,
      2921
    },
    StateLayers = "CmdCaster.max_hp,CmdCaster.max_hp*0.1,1,1,1,5,1",
    InitSkillList = {
      96762,
      96761,
      96762,
      96761,
      96759
    },
    CycleSkillList1 = {
      96760,
      96758,
      96755,
      96757
    },
    AnimationID = 96014,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2B0003.png",
    Scale = 1,
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [98056] = {
    ID = 98056,
    CnID = "怪物@唤醒体图鲁连战",
    BaseSortID = 460,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90643
    },
    Category = "MotherTreeMonster",
    MonsterName = "MonsterConfig_98056_MonsterName|「沉睡之主」",
    Desc = "MonsterConfig_98056_Desc|群星正位之刻，他将结束亿万年的沉眠，荣归祂的王座。而这是否是他心中所愿，便无人知晓了。",
    ExistState = {
      98060,
      98055,
      36314,
      57952,
      83816
    },
    StateLayers = "1,1,1,1,1",
    StateParams = "CmdCaster.atk*0.05",
    InitSkillList = {58494, 58495},
    CycleSkillList1 = {58494, 58495},
    CycleSkillList2 = {57949, 57950},
    AnimationID = 15640,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O01_AF.png",
    MonsterHpPercent = 0.15,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [98702] = {
    ID = 98702,
    CnID = "怪物@唤醒体阿格里帕",
    BaseSortID = 461,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      84303
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_98702_MonsterName|「迷宫蛛」",
    Desc = "MonsterConfig_98702_Desc|踏入蜘蛛领地的人类终将在无数通道和入口中迷失方向。",
    ExistState = {98740, 98756},
    StateLayers = "1,1",
    InitSkillList = {
      98704,
      98707,
      98705,
      98706
    },
    CycleSkillList1 = {
      98704,
      98705,
      98707,
      98704,
      98706
    },
    CycleSkillList2 = {
      98731,
      98730,
      98705
    },
    AnimationID = 98703,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B06_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.032,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [99114] = {
    ID = 99114,
    CnID = "怪物@唤醒体皮克曼",
    BaseSortID = 462,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      84303
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_99114_MonsterName|「绘者」",
    Desc = "MonsterConfig_99114_Desc|我会向你展现这世界的真相……",
    ExistState = {
      99136,
      99138,
      99134,
      99356,
      116340,
      116341,
      116342,
      116361,
      2921
    },
    StateLayers = "1,1,5,1,1,1,1,1,1",
    InitSkillList = {
      99121,
      99118,
      99116
    },
    CycleSkillList1 = {
      99121,
      99118,
      99116
    },
    CycleSkillList2 = {
      99119,
      99120,
      99117
    },
    AnimationID = 99240,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B12_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.33,
    MonsterAtkPercent = 0.85,
    MonsterDefPercent = 0.176,
    MonsterProportion = 0.8,
    MonsterHpNum = 2
  },
  [120904] = {
    ID = 120904,
    CnID = "怪物@唤醒体法洛思",
    BaseSortID = 463,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90643
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_120904_MonsterName|「原初信徒」",
    Desc = "MonsterConfig_120904_Desc|驻守永恒之国入口之人，指引归乡者的灯塔。",
    ExistState = {
      100620,
      100631,
      100643,
      100690,
      118741,
      118118
    },
    StateLayers = "1,1,1,1,1,1",
    StateParams = "CmdCaster.atk*0.05",
    InitSkillList = {
      100600,
      100604,
      100602
    },
    CycleSkillList1 = {
      100600,
      100604,
      100602
    },
    CycleSkillList2 = {
      100598,
      100603,
      100599
    },
    AnimationID = 100597,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O03_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.4,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [140581] = {
    ID = 140581,
    CnID = "怪物@小型黑泥怪认知错乱A通用",
    BaseSortID = 464,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_140581_MonsterName|融蚀-追随者",
    Desc = "MonsterConfig_140581_Desc|在诗中的西岱，他们追随柯蕾特的身影。",
    ExistState = {140659, 22074},
    InitSkillList = {
      140600,
      140598,
      140608
    },
    CycleSkillList1 = {
      140600,
      140598,
      140608
    },
    AnimationID = 140584,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD06_02.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = -0.75,
    MonsterProportion = 0.4
  },
  [140582] = {
    ID = 140582,
    CnID = "怪物@小型黑泥怪认知错乱B通用",
    BaseSortID = 465,
    BattleTag = "MonsterGrade1",
    MonsterTag = {90640, 90645},
    MonsterName = "MonsterConfig_140582_MonsterName|融蚀-渴求者",
    Desc = "MonsterConfig_140582_Desc|在诗中的西岱，他们渴求柯蕾特的恩典。",
    ExistState = {140659, 22074},
    InitSkillList = {
      140608,
      140600,
      140598
    },
    CycleSkillList1 = {
      140608,
      140600,
      140598
    },
    AnimationID = 140584,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD06_02.png",
    MonsterHpPercent = 0.95,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = -0.75,
    MonsterProportion = 0.4
  },
  [140572] = {
    ID = 140572,
    CnID = "怪物@大型黑泥怪认知错乱通用",
    BaseSortID = 466,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 84293},
    MonsterName = "MonsterConfig_140572_MonsterName|融蚀-诗中人",
    Desc = "MonsterConfig_140572_Desc|坚定的拥护者，这是她能写出的全部意象。",
    ExistState = {
      140654,
      89575,
      22074
    },
    InitSkillList = {
      140604,
      140609,
      140601,
      140592
    },
    CycleSkillList1 = {
      140604,
      140609,
      140601,
      140592
    },
    AnimationID = 140583,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCD06_03.png",
    MonsterHpPercent = 1,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.9,
    MonsterProportion = 1
  },
  [117856] = {
    ID = 117856,
    CnID = "怪物@深海飞鱼A",
    BaseSortID = 467,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_117856_MonsterName|秽血幼鱼",
    Desc = "MonsterConfig_117856_Desc|受祭仪影响发生畸变，传承污秽血脉的幼鱼。",
    ExistState = {117889, 22074},
    StateLayers = 1,
    StateParams = "CmdCaster.max_hp*0.1,CmdCaster.atk*0.02",
    InitSkillList = {
      117862,
      117863,
      117861,
      117862
    },
    CycleSkillList1 = {
      117862,
      117863,
      117861,
      117862
    },
    AnimationID = 118046,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0401.png",
    Scale = 1,
    MonsterHpPercent = 1,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0,
    MonsterProportion = 0.25
  },
  [117857] = {
    ID = 117857,
    CnID = "怪物@深海飞鱼B",
    BaseSortID = 468,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_117857_MonsterName|腐溃幼鱼",
    Desc = "MonsterConfig_117857_Desc|受祭仪影响发生畸变，通体腐烂溃败的幼鱼。",
    ExistState = {117889, 22074},
    StateLayers = 1,
    StateParams = "CmdCaster.max_hp*0.1,CmdCaster.atk*0.02",
    InitSkillList = {
      117863,
      117861,
      117862,
      117863
    },
    CycleSkillList1 = {
      117863,
      117861,
      117862,
      117863
    },
    AnimationID = 118041,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0401.png",
    Scale = 1,
    MonsterHpPercent = 0.75,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.25
  },
  [117855] = {
    ID = 117855,
    CnID = "怪物@深海飞鱼C",
    BaseSortID = 469,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_117855_MonsterName|恶咒幼鱼",
    Desc = "MonsterConfig_117855_Desc|受祭仪影响发生畸变，散播厄运不幸的幼鱼。",
    ExistState = {117889, 22074},
    StateLayers = 1,
    StateParams = "CmdCaster.max_hp*0.1,CmdCaster.atk*0.02",
    InitSkillList = {
      117861,
      117862,
      117863,
      117861
    },
    CycleSkillList1 = {
      117861,
      117862,
      117863,
      117861
    },
    AnimationID = 118035,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0401.png",
    Scale = 1,
    MonsterHpPercent = 0.65,
    MonsterAtkPercent = 1.1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.25
  },
  [120308] = {
    ID = 120308,
    CnID = "怪物@深海飞鱼群ABOSS",
    BaseSortID = 470,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_120308_MonsterName|秽血鱼王",
    Desc = "MonsterConfig_120308_Desc|幼鱼已经成王，这污秽的血脉日渐茁壮。",
    ExistState = {117889, 120312},
    StateLayers = "1,5",
    StateParams = "CmdCaster.max_hp*0.1,CmdCaster.atk*0.04",
    InitSkillList = {
      117862,
      117863,
      117861,
      117862
    },
    CycleSkillList1 = {
      117862,
      117863,
      117861,
      117862
    },
    AnimationID = 118047,
    MonsterClass = "Boss",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0401.png",
    Scale = 1.5,
    MonsterHpPercent = 0.05,
    MonsterAtkPercent = 0.3,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [120310] = {
    ID = 120310,
    CnID = "怪物@深海飞鱼群BBOSS",
    BaseSortID = 471,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_120310_MonsterName|腐溃鱼王",
    Desc = "MonsterConfig_120310_Desc|幼鱼已经成王，这溃烂的身躯因信仰而不朽。",
    ExistState = {117889, 120312},
    StateLayers = "1,5",
    StateParams = "CmdCaster.max_hp*0.1,CmdCaster.atk*0.04",
    InitSkillList = {
      117863,
      117861,
      117862,
      117863
    },
    CycleSkillList1 = {
      117863,
      117861,
      117862,
      117863
    },
    AnimationID = 118049,
    MonsterClass = "Boss",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0401.png",
    Scale = 1.5,
    MonsterHpPercent = 0.045,
    MonsterAtkPercent = 0.33,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [120306] = {
    ID = 120306,
    CnID = "怪物@深海飞鱼群CBOSS",
    BaseSortID = 472,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_120306_MonsterName|恶咒鱼王",
    Desc = "MonsterConfig_120306_Desc|幼鱼已经成王，总有一日，不幸与灾厄将遍布世界。",
    ExistState = {117889, 120312},
    StateLayers = "1,5",
    StateParams = "CmdCaster.max_hp*0.1,CmdCaster.atk*0.04",
    InitSkillList = {
      117861,
      117862,
      117863,
      117861
    },
    CycleSkillList1 = {
      117861,
      117862,
      117863,
      117861
    },
    AnimationID = 118040,
    MonsterClass = "Boss",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0401.png",
    Scale = 1.5,
    MonsterHpPercent = 0.04,
    MonsterAtkPercent = 0.35,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [120309] = {
    ID = 120309,
    CnID = "怪物@深海飞鱼群ABOSS召唤",
    BaseSortID = 473,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_120309_MonsterName|秽血鱼王",
    Desc = "MonsterConfig_120309_Desc|幼鱼已经成王，这污秽的血脉日渐茁壮。",
    ExistState = {117889},
    StateLayers = 1,
    StateParams = "CmdCaster.max_hp*0.1,CmdCaster.atk*0.04",
    InitSkillList = {
      117862,
      117863,
      117861,
      117862
    },
    CycleSkillList1 = {
      117862,
      117863,
      117861,
      117862
    },
    AnimationID = 118047,
    MonsterClass = "Boss",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0401.png",
    Scale = 1.5,
    MonsterHpPercent = 0.05,
    MonsterAtkPercent = 0.3,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [120307] = {
    ID = 120307,
    CnID = "怪物@深海飞鱼群BBOSS召唤",
    BaseSortID = 474,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_120307_MonsterName|腐溃鱼王",
    Desc = "MonsterConfig_120307_Desc|幼鱼已经成王，这溃烂的身躯因信仰而不朽。",
    ExistState = {117889},
    StateLayers = 1,
    StateParams = "CmdCaster.max_hp*0.1,CmdCaster.atk*0.04",
    InitSkillList = {
      117863,
      117861,
      117862,
      117863
    },
    CycleSkillList1 = {
      117863,
      117861,
      117862,
      117863
    },
    AnimationID = 118049,
    MonsterClass = "Boss",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0401.png",
    Scale = 1.5,
    MonsterHpPercent = 0.045,
    MonsterAtkPercent = 0.33,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [120305] = {
    ID = 120305,
    CnID = "怪物@深海飞鱼群CBOSS召唤",
    BaseSortID = 475,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_120305_MonsterName|恶咒鱼王",
    Desc = "MonsterConfig_120305_Desc|幼鱼已经成王，总有一日，不幸与灾厄将遍布世界。",
    ExistState = {117889},
    StateLayers = 1,
    StateParams = "CmdCaster.max_hp*0.1,CmdCaster.atk*0.04",
    InitSkillList = {
      117861,
      117862,
      117863,
      117861
    },
    CycleSkillList1 = {
      117861,
      117862,
      117863,
      117861
    },
    AnimationID = 118040,
    MonsterClass = "Boss",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0401.png",
    Scale = 1.5,
    MonsterHpPercent = 0.04,
    MonsterAtkPercent = 0.35,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [117859] = {
    ID = 117859,
    CnID = "怪物@深海飞鱼群A",
    BaseSortID = 476,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_117859_MonsterName|秽血鱼潮",
    Desc = "MonsterConfig_117859_Desc|秽血的幼鱼聚集，形成污秽亵渎的鱼潮。",
    ExistState = {
      117889,
      119958,
      22074
    },
    StateLayers = "1,2",
    StateParams = "CmdCaster.max_hp*0.1,CmdCaster.atk*0.04",
    InitSkillList = {
      117862,
      117863,
      117861,
      117862
    },
    CycleSkillList1 = {
      117862,
      117863,
      117861,
      117862
    },
    AnimationID = 118047,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0401.png",
    Scale = 1.25,
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 0.6,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [117858] = {
    ID = 117858,
    CnID = "怪物@深海飞鱼群B",
    BaseSortID = 477,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_117858_MonsterName|腐溃鱼潮",
    Desc = "MonsterConfig_117858_Desc|腐溃的幼鱼聚集，形成恶臭糜烂的鱼潮。",
    ExistState = {
      117889,
      119958,
      22074
    },
    StateLayers = "1,2",
    StateParams = "CmdCaster.max_hp*0.1,CmdCaster.atk*0.04",
    InitSkillList = {
      117863,
      117861,
      117862,
      117863
    },
    CycleSkillList1 = {
      117863,
      117861,
      117862,
      117863
    },
    AnimationID = 118049,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0401.png",
    Scale = 1.25,
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [117860] = {
    ID = 117860,
    CnID = "怪物@深海飞鱼群C",
    BaseSortID = 478,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_117860_MonsterName|恶咒鱼潮",
    Desc = "MonsterConfig_117860_Desc|恶咒的幼鱼聚集，形成散播灾厄的鱼潮。",
    ExistState = {
      117889,
      119958,
      22074
    },
    StateLayers = "1,2",
    StateParams = "CmdCaster.max_hp*0.1,CmdCaster.atk*0.04",
    InitSkillList = {
      117861,
      117862,
      117863,
      117861
    },
    CycleSkillList1 = {
      117861,
      117862,
      117863,
      117861
    },
    AnimationID = 118040,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0401.png",
    Scale = 1.25,
    MonsterHpPercent = 0.25,
    MonsterAtkPercent = 0.8,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [118646] = {
    ID = 118646,
    CnID = "怪物@深海飞鱼群A召唤",
    BaseSortID = 479,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_118646_MonsterName|秽血鱼潮",
    Desc = "MonsterConfig_118646_Desc|秽血的幼鱼聚集，形成污秽亵渎的鱼潮。",
    ExistState = {117889, 22074},
    StateLayers = 1,
    StateParams = "CmdCaster.max_hp*0.1,CmdCaster.atk*0.04",
    InitSkillList = {
      117862,
      117863,
      117861,
      117862
    },
    CycleSkillList1 = {
      117862,
      117863,
      117861,
      117862
    },
    AnimationID = 118047,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0401.png",
    Scale = 1.25,
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 0.6,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [118645] = {
    ID = 118645,
    CnID = "怪物@深海飞鱼群B召唤",
    BaseSortID = 480,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_118645_MonsterName|腐溃鱼潮",
    Desc = "MonsterConfig_118645_Desc|腐溃的幼鱼聚集，形成恶臭糜烂的鱼潮。",
    ExistState = {117889, 22074},
    StateLayers = 1,
    StateParams = "CmdCaster.max_hp*0.1,CmdCaster.atk*0.04",
    InitSkillList = {
      117863,
      117861,
      117862,
      117863
    },
    CycleSkillList1 = {
      117863,
      117861,
      117862,
      117863
    },
    AnimationID = 118049,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0401.png",
    Scale = 1.25,
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [118644] = {
    ID = 118644,
    CnID = "怪物@深海飞鱼群C召唤",
    BaseSortID = 481,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_118644_MonsterName|恶咒鱼潮",
    Desc = "MonsterConfig_118644_Desc|恶咒的幼鱼聚集，形成散播灾厄的鱼潮。",
    ExistState = {117889, 22074},
    StateLayers = 1,
    StateParams = "CmdCaster.max_hp*0.1,CmdCaster.atk*0.04",
    InitSkillList = {
      117861,
      117862,
      117863,
      117861
    },
    CycleSkillList1 = {
      117861,
      117862,
      117863,
      117861
    },
    AnimationID = 118040,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0401.png",
    Scale = 1.25,
    MonsterHpPercent = 0.25,
    MonsterAtkPercent = 0.8,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [118033] = {
    ID = 118033,
    CnID = "怪物@余烬星之眷族A",
    BaseSortID = 482,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_118033_MonsterName|「祭品」",
    Desc = "MonsterConfig_118033_Desc|无论它之前是何身份，现在都只是等待「神使」附身的祭仪道具。",
    ExistState = {
      80787,
      22074,
      83816,
      89574
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1",
    InitSkillList = {
      4787,
      4518,
      118648,
      4042
    },
    CycleSkillList1 = {
      4787,
      4518,
      118648
    },
    AnimationID = 118051,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0501.png",
    Scale = 1,
    MonsterHpPercent = 2,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [118020] = {
    ID = 118020,
    CnID = "怪物@余烬星之眷族B",
    BaseSortID = 483,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_118020_MonsterName|「祭品」",
    Desc = "MonsterConfig_118020_Desc|无论它之前是何身份，现在都只是等待「神使」附身的祭仪道具。",
    ExistState = {
      80787,
      22074,
      83816,
      89574
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1",
    InitSkillList = {118648, 4042},
    CycleSkillList1 = {
      4787,
      4518,
      118648
    },
    AnimationID = 118038,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0501.png",
    Scale = 1,
    MonsterHpPercent = 1.75,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [118647] = {
    ID = 118647,
    CnID = "怪物@余烬星之眷族初生",
    BaseSortID = 484,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643
    },
    MonsterName = "MonsterConfig_118647_MonsterName|「神使？」",
    Desc = "MonsterConfig_118647_Desc|可悲的失败品。它孱弱的躯壳不足以承载「神使」的力量。",
    ExistState = {
      80787,
      22074,
      83816,
      89574
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1",
    InitSkillList = {4555},
    CycleSkillList1 = {
      4787,
      4518,
      4734
    },
    AnimationID = 15648,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0501.png",
    Scale = 1,
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [118027] = {
    ID = 118027,
    CnID = "怪物@蓝环章鱼",
    BaseSortID = 485,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_118027_MonsterName|普通仆役",
    Desc = "MonsterConfig_118027_Desc|为了更接近「神母」意志而改变自身形态的仆从，以自身的使命为荣。",
    ExistState = {
      80787,
      118118,
      118113,
      120450,
      22074
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1",
    InitSkillList = {
      118101,
      118074,
      118076,
      118109
    },
    CycleSkillList1 = {
      118101,
      118074,
      118076,
      118109
    },
    AnimationID = 118036,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0402.png",
    Scale = 1,
    MonsterHpPercent = 1.2,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.93,
    MonsterProportion = 1
  },
  [118025] = {
    ID = 118025,
    CnID = "怪物@蓝环章鱼精英",
    BaseSortID = 486,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_118025_MonsterName|贴身管家",
    Desc = "MonsterConfig_118025_Desc|为了更接近「神母」意志而改变自身形态的仆从，愿意为「神母」献出一切。",
    ExistState = {
      80787,
      118118,
      118119,
      117875,
      2921,
      120450
    },
    StateLayers = "CmdCaster.max_hp*0.04,1,1,5,1,1",
    InitSkillList = {
      118083,
      118074,
      118100,
      118109
    },
    CycleSkillList1 = {
      118083,
      118074,
      118100,
      118109
    },
    AnimationID = 118044,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0402.png",
    Scale = 1.05,
    MonsterHpPercent = 1.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.14,
    MonsterProportion = 0.9
  },
  [118026] = {
    ID = 118026,
    CnID = "怪物@蓝环章鱼BOSS",
    BaseSortID = 487,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_118026_MonsterName|「谕令神官」",
    Desc = "MonsterConfig_118026_Desc|为了更接近「神母」意志而改变自身形态的仆从，职责是确保「神母」的谕令得以传达与执行。",
    ExistState = {
      80787,
      118118,
      118114,
      117875,
      118766,
      2921,
      120450
    },
    StateLayers = "CmdCaster.max_hp*0.03,1,1,10,1,1,1",
    InitSkillList = {
      118083,
      118074,
      118100,
      118109,
      118767,
      118074,
      118100,
      118109
    },
    CycleSkillList1 = {
      118083,
      118074,
      118100,
      118109,
      118083,
      118074,
      118100,
      118109
    },
    AnimationID = 118048,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0402.png",
    Scale = 1.15,
    MonsterHpPercent = 1.6,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 3.34,
    MonsterProportion = 0.9
  },
  [118021] = {
    ID = 118021,
    CnID = "怪物@新世界蛇头人",
    BaseSortID = 488,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_118021_MonsterName|布道者",
    Desc = "MonsterConfig_118021_Desc|由「主祭」创造的畸形存在，实力弱小，随处可见。",
    ExistState = {
      80787,
      118118,
      117885,
      118663,
      118669,
      22074
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1,1",
    InitSkillList = {
      118068,
      118086,
      118059,
      118080
    },
    CycleSkillList1 = {
      118068,
      118086,
      118059,
      118080
    },
    AnimationID = 118039,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0403.png",
    Scale = 1,
    MonsterHpPercent = 1.5,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [118023] = {
    ID = 118023,
    CnID = "怪物@新世界蛇头人精英",
    BaseSortID = 489,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_118023_MonsterName|神选者",
    Desc = "MonsterConfig_118023_Desc|由「主祭」创造的畸形存在，因其绝对的忠诚而受到「主祭」驱使。",
    ExistState = {
      80787,
      118118,
      117885,
      118663,
      118669
    },
    StateLayers = "CmdCaster.max_hp*0.04,1,1,1,1",
    InitSkillList = {
      118061,
      118086,
      118108,
      118080
    },
    CycleSkillList1 = {
      118068,
      118086,
      118059,
      118080
    },
    AnimationID = 118054,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0403.png",
    Scale = 1.05,
    MonsterHpPercent = 1.75,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [118024] = {
    ID = 118024,
    CnID = "怪物@新世界蛇头人BOSS",
    BaseSortID = 490,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90643,
      84291
    },
    MonsterName = "MonsterConfig_118024_MonsterName|「祝圣司铎」",
    Desc = "MonsterConfig_118024_Desc|由「主祭」创造的畸形存在，实力强大，深受「主祭」信赖。",
    ExistState = {
      80787,
      118118,
      117885,
      118663,
      118669,
      118741
    },
    StateLayers = "CmdCaster.max_hp*0.03,1,1,1,1",
    InitSkillList = {
      118061,
      118086,
      118108,
      118080,
      118090,
      118086,
      118059,
      118080
    },
    CycleSkillList1 = {
      118061,
      118086,
      118059,
      118080
    },
    AnimationID = 118037,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0403.png",
    Scale = 1.15,
    MonsterHpPercent = 2,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [118019] = {
    ID = 118019,
    CnID = "怪物@银芯提灯",
    BaseSortID = 491,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90643,
      90646
    },
    MonsterName = "MonsterConfig_118019_MonsterName|提灯信徒",
    Desc = "MonsterConfig_118019_Desc|提灯教会的普通教众，因信仰而远离家乡，来到此处。",
    ExistState = {
      80787,
      118118,
      60087,
      118112,
      118741,
      118769,
      22074,
      125004
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,50,1,1,1",
    StateParams = "CmdCaster.max_hp*0.1",
    InitSkillList = {
      118077,
      118056,
      118094,
      118107
    },
    CycleSkillList1 = {
      118077,
      118056,
      118094,
      118107
    },
    AnimationID = 118042,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0404.png",
    Scale = 1,
    MonsterHpPercent = 1.5,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.75
  },
  [118030] = {
    ID = 118030,
    CnID = "怪物@银芯提灯精英",
    BaseSortID = 492,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90643,
      90646
    },
    MonsterName = "MonsterConfig_118030_MonsterName|提灯虔诚者",
    Desc = "MonsterConfig_118030_Desc|信奉「燃己的灯芯必定得到救赎」的虔诚者，因信仰而无所畏惧。",
    ExistState = {
      80787,
      118118,
      60087,
      118116,
      118741,
      118769,
      2921,
      125004
    },
    StateLayers = "CmdCaster.max_hp*0.04,1,50,1,1,1,1",
    StateParams = "CmdCaster.max_hp*0.05",
    InitSkillList = {
      118055,
      118057,
      118103,
      118102
    },
    CycleSkillList1 = {
      118093,
      118057,
      118103,
      118102
    },
    AnimationID = 118034,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0404.png",
    Scale = 1.15,
    MonsterHpPercent = 1.75,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.75
  },
  [118022] = {
    ID = 118022,
    CnID = "怪物@银芯提灯BOSS",
    BaseSortID = 493,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90643,
      90646
    },
    MonsterName = "MonsterConfig_118022_MonsterName|「护灯尊者」",
    Desc = "MonsterConfig_118022_Desc|「愿提灯长明……」",
    ExistState = {
      80787,
      118118,
      60087,
      118117,
      118741,
      118769,
      125004,
      2921
    },
    StateLayers = "CmdCaster.max_hp*0.03,1,50,1,1,1",
    StateParams = "CmdCaster.max_hp*0.03",
    InitSkillList = {
      118055,
      118099,
      118102,
      118064,
      118096,
      118099,
      118102
    },
    CycleSkillList1 = {
      118055,
      118096,
      118099,
      118102
    },
    AnimationID = 118043,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0404.png",
    Scale = 1.3,
    MonsterHpPercent = 2,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.75
  },
  [118029] = {
    ID = 118029,
    CnID = "怪物@唤醒体墨菲",
    BaseSortID = 494,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90643
    },
    MonsterName = "MonsterConfig_118029_MonsterName|「深海淑女」",
    Desc = "MonsterConfig_118029_Desc|「我不是第一个被献祭的母体，也不是最后的一个……但是，我想活下去！」",
    ExistState = {
      118937,
      118118,
      118943,
      118741,
      118935,
      118973,
      121015
    },
    StateLayers = "1,1,CmdCaster.max_hp*0.15,1,1,1,1",
    InitSkillList = {
      118087,
      118095,
      118072,
      118060
    },
    CycleSkillList1 = {
      118087,
      118095,
      118072,
      118060
    },
    CycleSkillList2 = {
      118974,
      118975,
      118065,
      118072
    },
    AnimationID = 118053,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O02_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.5,
    MonsterAtkPercent = 0.85,
    MonsterDefPercent = 1.3,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [118032] = {
    ID = 118032,
    CnID = "怪物@唤醒体诞妄墨菲",
    BaseSortID = 495,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90643
    },
    MonsterName = "MonsterConfig_118032_MonsterName|「海嗣神母」",
    Desc = "MonsterConfig_118032_Desc|曾经软弱天真的「她」已经死去，现在的她，是尊贵的「神母」，是不可违抗的「天后」。",
    ExistState = {
      118118,
      119109,
      118741,
      119107,
      119106,
      119103
    },
    StateLayers = "1,CmdCaster.max_hp*0.1,1,1,1,1",
    InitSkillList = {
      118091,
      118058,
      118105
    },
    CycleSkillList1 = {
      118091,
      118058,
      118105
    },
    CycleSkillList2 = {
      118091,
      118058,
      118105
    },
    AnimationID = 118052,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O02EX_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.6,
    MonsterAtkPercent = 0.85,
    MonsterDefPercent = 1.05,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [118031] = {
    ID = 118031,
    CnID = "怪物@唤醒体弥利亚姆_海国祭祀",
    BaseSortID = 496,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90643
    },
    MonsterName = "MonsterConfig_118031_MonsterName|「海之使徒」",
    Desc = "MonsterConfig_118031_Desc|此刻，她的所作所为并非出于精神维度感染的疯狂，而是出于对神明最为虔诚的信仰。",
    ExistState = {
      117869,
      118741,
      119075
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      118063,
      118078,
      118084,
      118062
    },
    CycleSkillList1 = {
      118063,
      118078,
      118084,
      118062
    },
    CycleSkillList2 = {
      119090,
      119089,
      119088,
      119092
    },
    AnimationID = 15732,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O07_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.48,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.52,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [118028] = {
    ID = 118028,
    CnID = "怪物@天之帷幕",
    BaseSortID = 497,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90643,
      84294
    },
    MonsterName = "MonsterConfig_118028_MonsterName|「乐园帷幕」",
    Desc = "MonsterConfig_118028_Desc|这梦境终会溃散，但没关系，它总会重启。",
    ExistState = {
      119750,
      119757,
      119760,
      117876,
      121862
    },
    StateLayers = "1,4,7,1,1",
    InitSkillList = {
      118070,
      118092,
      118070,
      118092,
      118070,
      118092,
      119313
    },
    CycleSkillList1 = {
      118106,
      118097,
      118071,
      118097,
      118071,
      119714
    },
    CycleSkillList2 = {
      118097,
      118071,
      118097,
      118071
    },
    AnimationID = 118050,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2B0004_AT.png",
    Scale = 1,
    MonsterHpPercent = 0.125,
    MonsterAtkPercent = 0.85,
    MonsterDefPercent = 0.0915,
    MonsterProportion = 1,
    MonsterHpNum = 5
  },
  [119069] = {
    ID = 119069,
    CnID = "怪物@唤醒体弥利亚姆_海国祭祀@召唤凯刻斯",
    BaseSortID = 498,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90643
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_119069_MonsterName|「沉渊之影」",
    Desc = "MonsterConfig_119069_Desc|现在，就是昭示深海血脉力量的时刻。他会让戈利亚大人看到自己的实力。",
    ExistState = {83816},
    StateLayers = "1,1",
    InitSkillList = {120896, 23408},
    CycleSkillList1 = {120896, 23408},
    AnimationID = 15624,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O04_AF.png",
    MonsterHpPercent = 0.46,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 2.755,
    MonsterProportion = 1,
    MonsterHpNum = 1
  },
  [119068] = {
    ID = 119068,
    CnID = "怪物@唤醒体弥利亚姆_海国祭祀@召唤海洋之刃",
    BaseSortID = 499,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90643
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_119068_MonsterName|「巨刃之影」",
    Desc = "MonsterConfig_119068_Desc|以巨人之力挥动重刃的强大战士，因自身的野心，追随着「主祭」的步伐。",
    ExistState = {83816},
    StateLayers = 1,
    InitSkillList = {
      4168,
      4171,
      4170
    },
    CycleSkillList1 = {
      4171,
      4170,
      4168
    },
    AnimationID = 15704,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O06_AF.png",
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 1
  },
  [120905] = {
    ID = 120905,
    CnID = "怪物@唤醒体弥利亚姆_海国祭祀@召唤法洛思",
    BaseSortID = 500,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90643
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_120905_MonsterName|「信徒之影」",
    Desc = "MonsterConfig_120905_Desc|一切，都是为了筑成通往神国的道路。",
    ExistState = {
      100631,
      100643,
      100690,
      118741,
      118118
    },
    StateLayers = "1,1,1,1,1",
    StateParams = "CmdCaster.atk*0.05",
    InitSkillList = {121138, 100600},
    CycleSkillList1 = {121138, 100600},
    AnimationID = 100597,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_O03_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.4,
    MonsterProportion = 1,
    MonsterHpNum = 1
  },
  [120935] = {
    ID = 120935,
    CnID = "怪物@蹈海者祭祀首领新",
    BaseSortID = 501,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      94556,
      90643
    },
    MonsterName = "MonsterConfig_120935_MonsterName|「福音执事」",
    Desc = "MonsterConfig_120935_Desc|将自身一切都献于神明的祭祀，其意志不可动摇，其信仰坚不可摧。",
    ExistState = {
      96613,
      94600,
      80787,
      120934,
      95001,
      94999,
      96412,
      96337,
      2921
    },
    StateLayers = "1,2,CmdCaster.max_hp*0.04,1,8,1,1,1,1",
    InitSkillList = {94958},
    CycleSkillList1 = {
      94963,
      94966,
      94959,
      94958
    },
    AnimationID = 94950,
    ExAnimations = {94950},
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0304.png",
    Scale = 1.15,
    MonsterHpPercent = 1.28,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 2.09,
    MonsterProportion = 0.9
  },
  [119854] = {
    ID = 119854,
    CnID = "怪物@畸变神胎群A",
    BaseSortID = 502,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643,
      84303
    },
    MonsterName = "MonsterConfig_119854_MonsterName|秽血胎群",
    Desc = "MonsterConfig_119854_Desc|偶尔，弥利亚姆也会思考这究竟是轮回的赘生物，还是神明承认她虔诚的证明？",
    ExistState = {
      35971,
      83816,
      89574,
      119959,
      22074
    },
    StateLayers = "1,1,1,2",
    InitSkillList = {
      35965,
      35962,
      36179
    },
    CycleSkillList1 = {
      35965,
      35962,
      36179
    },
    AnimationID = 35591,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0604.png",
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 0.49,
    MonsterDefPercent = 1.23,
    MonsterProportion = 0.5
  },
  [119853] = {
    ID = 119853,
    CnID = "怪物@畸变神胎群B",
    BaseSortID = 503,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643,
      84303
    },
    MonsterName = "MonsterConfig_119853_MonsterName|腐溃胎群",
    Desc = "MonsterConfig_119853_Desc|偶尔，弥利亚姆也会思考这究竟是轮回的赘生物，还是神明承认她虔诚的证明？",
    ExistState = {
      35970,
      83816,
      89574,
      119959,
      22074
    },
    StateLayers = "1,1,1,2",
    InitSkillList = {
      35960,
      35964,
      36180
    },
    CycleSkillList1 = {
      35960,
      35964,
      36180
    },
    AnimationID = 35592,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0604_BT.png",
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 0.49,
    MonsterDefPercent = 0.25,
    MonsterProportion = 0.5
  },
  [119852] = {
    ID = 119852,
    CnID = "怪物@畸变神胎群C",
    BaseSortID = 504,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643,
      84303
    },
    MonsterName = "MonsterConfig_119852_MonsterName|恶咒胎群",
    Desc = "MonsterConfig_119852_Desc|偶尔，弥利亚姆也会思考这究竟是轮回的赘生物，还是神明承认她虔诚的证明？",
    ExistState = {
      36111,
      83816,
      89574,
      119959,
      22074
    },
    StateLayers = "1,1,1,2",
    InitSkillList = {
      36087,
      36089,
      36076
    },
    CycleSkillList1 = {
      36087,
      36089,
      36076
    },
    AnimationID = 35598,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0604_CT.png",
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 0.49,
    MonsterDefPercent = 1.64,
    MonsterProportion = 0.5
  },
  [119955] = {
    ID = 119955,
    CnID = "怪物@畸变神胎群A召唤",
    BaseSortID = 505,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643,
      84303
    },
    MonsterName = "MonsterConfig_119955_MonsterName|秽血胎群",
    Desc = "MonsterConfig_119955_Desc|偶尔，弥利亚姆也会思考这究竟是轮回的赘生物，还是神明承认她虔诚的证明？",
    ExistState = {
      35971,
      83816,
      89574,
      22074
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      35965,
      35962,
      36179
    },
    CycleSkillList1 = {
      35965,
      35962,
      36179
    },
    AnimationID = 35591,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0604.png",
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 0.49,
    MonsterDefPercent = 1.23,
    MonsterProportion = 0.5
  },
  [119953] = {
    ID = 119953,
    CnID = "怪物@畸变神胎群B召唤",
    BaseSortID = 506,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643,
      84303
    },
    MonsterName = "MonsterConfig_119953_MonsterName|腐溃胎群",
    Desc = "MonsterConfig_119953_Desc|偶尔，弥利亚姆也会思考这究竟是轮回的赘生物，还是神明承认她虔诚的证明？",
    ExistState = {
      35970,
      83816,
      89574,
      22074
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      35960,
      35964,
      36180
    },
    CycleSkillList1 = {
      35960,
      35964,
      36180
    },
    AnimationID = 35592,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0604_BT.png",
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 0.49,
    MonsterDefPercent = 0.25,
    MonsterProportion = 0.5
  },
  [119954] = {
    ID = 119954,
    CnID = "怪物@畸变神胎群C召唤",
    BaseSortID = 507,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      84283,
      90643,
      84303
    },
    MonsterName = "MonsterConfig_119954_MonsterName|恶咒胎群",
    Desc = "MonsterConfig_119954_Desc|偶尔，弥利亚姆也会思考这究竟是轮回的赘生物，还是神明承认她虔诚的证明？",
    ExistState = {
      36111,
      83816,
      89574,
      22074
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      36087,
      36089,
      36076
    },
    CycleSkillList1 = {
      36087,
      36089,
      36076
    },
    AnimationID = 35598,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_C0604_CT.png",
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 0.49,
    MonsterDefPercent = 1.64,
    MonsterProportion = 0.5
  },
  [121722] = {
    ID = 121722,
    CnID = "怪物@新托乎瓦波活动1",
    BaseSortID = 508,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_121722_MonsterName|「群星裂隙·悲泣之视」",
    Desc = "MonsterConfig_121722_Desc|你们的哭声，祂已全部听见。济贫院中的悲泣，将再度上演。",
    ExistState = {68298, 121735},
    InitSkillList = {
      69800,
      69800,
      69803,
      69803,
      69802
    },
    CycleSkillList1 = {
      69800,
      69800,
      69803,
      69803,
      69802
    },
    CycleSkillList2 = {
      69800,
      69800,
      69803,
      69803,
      69802
    },
    CycleSkillList3 = {
      69800,
      69800,
      69803,
      69803,
      69802
    },
    AnimationID = 68301,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_1T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [121726] = {
    ID = 121726,
    CnID = "怪物@新托乎瓦波活动2",
    BaseSortID = 509,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_121726_MonsterName|「群星裂隙·恐惧之视」",
    Desc = "MonsterConfig_121726_Desc|你们曾于蜡像馆中体会的恐惧，不及祂的分毫。",
    ExistState = {68298, 121739},
    InitSkillList = {
      69788,
      69788,
      69786,
      69786,
      69787
    },
    CycleSkillList1 = {
      69788,
      69788,
      69786,
      69786,
      69787
    },
    CycleSkillList2 = {
      69788,
      69788,
      69786,
      69786,
      69787
    },
    CycleSkillList3 = {
      69788,
      69788,
      69786,
      69786,
      69787
    },
    AnimationID = 68306,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_2T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [121728] = {
    ID = 121728,
    CnID = "怪物@新托乎瓦波活动3",
    BaseSortID = 510,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_121728_MonsterName|「群星裂隙·刺骨之视」",
    Desc = "MonsterConfig_121728_Desc|在与祂的对视中，感受比拉伊刺骨的冰雪更加深刻的痛楚。",
    ExistState = {68298, 121737},
    InitSkillList = {
      69798,
      69798,
      69797,
      69797,
      69796
    },
    CycleSkillList1 = {
      69798,
      69798,
      69797,
      69797,
      69796
    },
    CycleSkillList2 = {
      69798,
      69798,
      69797,
      69797,
      69796
    },
    CycleSkillList3 = {
      69798,
      69798,
      69797,
      69797,
      69796
    },
    AnimationID = 68303,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_3T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [121725] = {
    ID = 121725,
    CnID = "怪物@新托乎瓦波活动4",
    BaseSortID = 511,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_121725_MonsterName|「群星裂隙·诡谲之视」",
    Desc = "MonsterConfig_121725_Desc|维度的变换，只是低劣的戏法。你们所面对的，是诡谲的规则本身。",
    ExistState = {68298, 121740},
    InitSkillList = {
      69790,
      69790,
      69791,
      69791,
      69792
    },
    CycleSkillList1 = {
      69790,
      69790,
      69791,
      69791,
      69792
    },
    CycleSkillList2 = {
      69790,
      69790,
      69791,
      69791,
      69792
    },
    CycleSkillList3 = {
      69790,
      69790,
      69791,
      69791,
      69792
    },
    AnimationID = 68302,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_4T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [121727] = {
    ID = 121727,
    CnID = "怪物@新托乎瓦波活动5",
    BaseSortID = 512,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_121727_MonsterName|「群星裂隙·邪信之视」",
    Desc = "MonsterConfig_121727_Desc|一切的邪信，都归于原初。低下你们的头颅吧。信仰祂。朝拜祂。",
    ExistState = {68298, 121738},
    InitSkillList = {
      69801,
      69801,
      69799,
      69799,
      69784
    },
    CycleSkillList1 = {
      69801,
      69801,
      69799,
      69799,
      69784
    },
    CycleSkillList2 = {
      69801,
      69801,
      69799,
      69799,
      69784
    },
    CycleSkillList3 = {
      69801,
      69801,
      69799,
      69799,
      69784
    },
    AnimationID = 68304,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_5T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [121723] = {
    ID = 121723,
    CnID = "怪物@新托乎瓦波活动6",
    BaseSortID = 513,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_121723_MonsterName|「群星裂隙·疯狂之视」",
    Desc = "MonsterConfig_121723_Desc|无序，疯狂，才是宇宙的真相。如今，真相已来到你们身前。",
    ExistState = {68298, 121734},
    InitSkillList = {
      69795,
      69795,
      69793,
      69793,
      69794
    },
    CycleSkillList1 = {
      69795,
      69795,
      69793,
      69793,
      69794
    },
    CycleSkillList2 = {
      69795,
      69795,
      69793,
      69793,
      69794
    },
    CycleSkillList3 = {
      69795,
      69795,
      69793,
      69793,
      69794
    },
    AnimationID = 68300,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_6T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [121724] = {
    ID = 121724,
    CnID = "怪物@新托乎瓦波活动7",
    BaseSortID = 514,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_121724_MonsterName|「群星裂隙·诞临之视」",
    Desc = "MonsterConfig_121724_Desc|新生，即为终结。",
    ExistState = {68298, 121736},
    InitSkillList = {
      69785,
      69785,
      69789,
      69789,
      69783
    },
    CycleSkillList1 = {
      69785,
      69785,
      69789,
      69789,
      69783
    },
    CycleSkillList2 = {
      69785,
      69785,
      69789,
      69789,
      69783
    },
    CycleSkillList3 = {
      69785,
      69785,
      69789,
      69789,
      69783
    },
    AnimationID = 68305,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_7T.png",
    MonsterHpPercent = 0.2,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [122412] = {
    ID = 122412,
    CnID = "怪物@唤醒体茉夏",
    BaseSortID = 515,
    BattleTag = "Boss",
    MonsterTag = {84277, 90645},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_122412_MonsterName|「雾中骇兽」",
    Desc = "MonsterConfig_122412_Desc|被「繁星黎明会」召唤来的异世界少女，可爱的外表之下埋藏着凡人难以理解的疯狂。",
    ExistState = {
      122428,
      60188,
      123178,
      94600,
      122452,
      60263,
      100619,
      125004
    },
    StateLayers = "1,1,1,3,1,50,1",
    InitSkillList = {
      122417,
      122414,
      122415
    },
    CycleSkillList1 = {
      122417,
      122414,
      122415
    },
    CycleSkillList2 = {
      122417,
      122414,
      122416
    },
    AnimationID = 123633,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C17_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.25,
    MonsterAtkPercent = 1.08,
    MonsterDefPercent = 0.825,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [122787] = {
    ID = 122787,
    CnID = "怪物@新托乎瓦波支线1",
    BaseSortID = 516,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_122787_MonsterName|「群星裂隙·悲泣之视」",
    Desc = "MonsterConfig_122787_Desc|你们的哭声，祂已全部听见。济贫院中的悲泣，将再度上演。",
    ExistState = {
      68298,
      121735,
      122796
    },
    InitSkillList = {
      69800,
      69800,
      69803,
      69803,
      69802
    },
    CycleSkillList1 = {
      69800,
      69800,
      69803,
      69803,
      69802
    },
    CycleSkillList2 = {
      69800,
      69800,
      69803,
      69803,
      69802
    },
    CycleSkillList3 = {
      69800,
      69800,
      69803,
      69803,
      69802
    },
    AnimationID = 68301,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_1T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [122785] = {
    ID = 122785,
    CnID = "怪物@新托乎瓦波支线2",
    BaseSortID = 517,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_122785_MonsterName|「群星裂隙·恐惧之视」",
    Desc = "MonsterConfig_122785_Desc|你们曾于蜡像馆中体会的恐惧，不及祂的分毫。",
    ExistState = {
      68298,
      121739,
      122801
    },
    InitSkillList = {
      69788,
      69788,
      69786,
      69786,
      69787
    },
    CycleSkillList1 = {
      69788,
      69788,
      69786,
      69786,
      69787
    },
    CycleSkillList2 = {
      69788,
      69788,
      69786,
      69786,
      69787
    },
    CycleSkillList3 = {
      69788,
      69788,
      69786,
      69786,
      69787
    },
    AnimationID = 68306,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_2T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [122786] = {
    ID = 122786,
    CnID = "怪物@新托乎瓦波支线3",
    BaseSortID = 518,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_122786_MonsterName|「群星裂隙·刺骨之视」",
    Desc = "MonsterConfig_122786_Desc|在与祂的对视中，感受比拉伊刺骨的冰雪更加深刻的痛楚。",
    ExistState = {
      68298,
      121737,
      122795
    },
    InitSkillList = {
      69798,
      69798,
      69797,
      69797,
      69796
    },
    CycleSkillList1 = {
      69798,
      69798,
      69797,
      69797,
      69796
    },
    CycleSkillList2 = {
      69798,
      69798,
      69797,
      69797,
      69796
    },
    CycleSkillList3 = {
      69798,
      69798,
      69797,
      69797,
      69796
    },
    AnimationID = 68303,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_3T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [122783] = {
    ID = 122783,
    CnID = "怪物@新托乎瓦波支线4",
    BaseSortID = 519,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_122783_MonsterName|「群星裂隙·诡谲之视」",
    Desc = "MonsterConfig_122783_Desc|维度的变换，只是低劣的戏法。你们所面对的，是诡谲的规则本身。",
    ExistState = {
      68298,
      121740,
      122799
    },
    InitSkillList = {
      69790,
      69790,
      69791,
      69791,
      69792
    },
    CycleSkillList1 = {
      69790,
      69790,
      69791,
      69791,
      69792
    },
    CycleSkillList2 = {
      69790,
      69790,
      69791,
      69791,
      69792
    },
    CycleSkillList3 = {
      69790,
      69790,
      69791,
      69791,
      69792
    },
    AnimationID = 68302,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_4T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [122781] = {
    ID = 122781,
    CnID = "怪物@新托乎瓦波支线5",
    BaseSortID = 520,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_122781_MonsterName|「群星裂隙·邪信之视」",
    Desc = "MonsterConfig_122781_Desc|一切的邪信，都归于原初。低下你们的头颅吧。信仰祂。朝拜祂。",
    ExistState = {
      68298,
      121738,
      122800
    },
    InitSkillList = {
      69801,
      69801,
      69799,
      69799,
      69784
    },
    CycleSkillList1 = {
      69801,
      69801,
      69799,
      69799,
      69784
    },
    CycleSkillList2 = {
      69801,
      69801,
      69799,
      69799,
      69784
    },
    CycleSkillList3 = {
      69801,
      69801,
      69799,
      69799,
      69784
    },
    AnimationID = 68304,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_5T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [122784] = {
    ID = 122784,
    CnID = "怪物@新托乎瓦波支线6",
    BaseSortID = 521,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_122784_MonsterName|「群星裂隙·疯狂之视」",
    Desc = "MonsterConfig_122784_Desc|无序，疯狂，才是宇宙的真相。如今，真相已来到你们身前。",
    ExistState = {
      68298,
      121734,
      122798
    },
    InitSkillList = {
      69795,
      69795,
      69793,
      69793,
      69794
    },
    CycleSkillList1 = {
      69795,
      69795,
      69793,
      69793,
      69794
    },
    CycleSkillList2 = {
      69795,
      69795,
      69793,
      69793,
      69794
    },
    CycleSkillList3 = {
      69795,
      69795,
      69793,
      69793,
      69794
    },
    AnimationID = 68300,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_6T.png",
    MonsterHpPercent = 0.16,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [122782] = {
    ID = 122782,
    CnID = "怪物@新托乎瓦波支线7",
    BaseSortID = 522,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_122782_MonsterName|「群星裂隙·诞临之视」",
    Desc = "MonsterConfig_122782_Desc|新生，即为终结。",
    ExistState = {
      68298,
      121736,
      122797
    },
    InitSkillList = {
      69785,
      69785,
      69789,
      69789,
      69783
    },
    CycleSkillList1 = {
      69785,
      69785,
      69789,
      69789,
      69783
    },
    CycleSkillList2 = {
      69785,
      69785,
      69789,
      69789,
      69783
    },
    CycleSkillList3 = {
      69785,
      69785,
      69789,
      69789,
      69783
    },
    AnimationID = 68305,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_B0009_7T.png",
    MonsterHpPercent = 0.2,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 3
  },
  [123647] = {
    ID = 123647,
    CnID = "怪物@唤醒体汀克特",
    BaseSortID = 523,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90644
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_123647_MonsterName|「歌者」",
    Desc = "MonsterConfig_123647_Desc|群星间的歌者，但美妙的嗓音只会为了姐姐的安眠而响起。",
    ExistState = {
      124107,
      124115,
      124191
    },
    StateLayers = "1,2,1",
    InitSkillList = {
      124073,
      124086,
      124071,
      124075
    },
    CycleSkillList1 = {
      124073,
      124086,
      124071,
      124075
    },
    CycleSkillList2 = {
      124079,
      124072,
      124079,
      124074,
      124069
    },
    AnimationID = 15779,
    MonsterClass = "Boss",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D03_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.2145,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0.51,
    MonsterProportion = 1,
    MonsterHpNum = 1
  },
  [124068] = {
    ID = 124068,
    CnID = "怪物@唤醒体菲茵特",
    BaseSortID = 524,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      84303
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_124068_MonsterName|「星之芽」",
    Desc = "MonsterConfig_124068_Desc|能掠夺大量生命的「不幸」，为了妹妹的幸福愿意付出一切。",
    ExistState = {
      124112,
      124109,
      124192,
      124194,
      124204
    },
    StateLayers = "1,1,1,1,1",
    InitSkillList = {
      124085,
      124076,
      124077,
      124081
    },
    CycleSkillList1 = {
      124085,
      124076,
      124077,
      124081
    },
    CycleSkillList2 = {
      124084,
      124083,
      124078,
      124080
    },
    AnimationID = 15683,
    MonsterClass = "Boss",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B09_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.325,
    MonsterAtkPercent = 0.425,
    MonsterDefPercent = 2.835,
    MonsterProportion = 1,
    MonsterHpNum = 1
  },
  [124837] = {
    ID = 124837,
    CnID = "怪物@唤醒体汀克特精英版",
    BaseSortID = 525,
    BattleTag = "Boss",
    MonsterTag = {
      90641,
      84297,
      90644
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_124837_MonsterName|「歌者」",
    Desc = "MonsterConfig_124837_Desc|群星间的歌者，但美妙的嗓音只会为了姐姐的安眠而响起。",
    ExistState = {124198, 124191},
    StateLayers = "1,2,1",
    InitSkillList = {
      124073,
      124839,
      124071,
      124075
    },
    CycleSkillList1 = {
      124073,
      124839,
      124071,
      124075
    },
    AnimationID = 15779,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D03_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.2145,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0.51,
    MonsterProportion = 1,
    MonsterHpNum = 1
  },
  [124838] = {
    ID = 124838,
    CnID = "怪物@唤醒体菲茵特精英版",
    BaseSortID = 526,
    BattleTag = "Boss",
    MonsterTag = {
      90641,
      84297,
      84303
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_124838_MonsterName|「星之芽」",
    Desc = "MonsterConfig_124838_Desc|能掠夺大量生命的「不幸」，为了妹妹的幸福愿意付出一切。",
    ExistState = {
      124190,
      124192,
      124194
    },
    StateLayers = "1,1,1,1,1",
    InitSkillList = {
      124085,
      124076,
      124077,
      124840
    },
    CycleSkillList1 = {
      124085,
      124076,
      124077,
      124840
    },
    AnimationID = 15683,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B09_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.325,
    MonsterAtkPercent = 0.425,
    MonsterDefPercent = 2.835,
    MonsterProportion = 1,
    MonsterHpNum = 1
  },
  [148509] = {
    ID = 148509,
    CnID = "怪物@唤醒体汀克特单人BOSS版",
    BaseSortID = 527,
    BattleTag = "Boss",
    MonsterTag = {
      90641,
      84297,
      90644
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_148509_MonsterName|「歌者」",
    Desc = "MonsterConfig_148509_Desc|群星间的歌者，但美妙的嗓音只会为了姐姐的安眠而响起。",
    ExistState = {
      124198,
      124191,
      148513
    },
    StateLayers = "1,2,1",
    InitSkillList = {
      124079,
      124072,
      124079,
      124074,
      124069
    },
    CycleSkillList1 = {
      124079,
      124072,
      124079,
      124074,
      124069
    },
    AnimationID = 15779,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D03_AF.png",
    Scale = 1,
    MonsterHpPercent = 1,
    MonsterAtkPercent = 0.5,
    MonsterDefPercent = 0.51,
    MonsterProportion = 1,
    MonsterHpNum = 1
  },
  [125901] = {
    ID = 125901,
    CnID = "怪物@唤醒体塔薇",
    BaseSortID = 528,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_125901_MonsterName|「门之钥」",
    Desc = "MonsterConfig_125901_Desc|穷极之门的守护者，时空之外的存在，绝对智识的象征。",
    ExistState = {
      125925,
      125930,
      125931,
      125932
    },
    StateLayers = "1,1,1,1,1",
    InitSkillList = {
      125907,
      125906,
      125903,
      125906
    },
    CycleSkillList1 = {
      125907,
      125906,
      125903,
      125906
    },
    CycleSkillList2 = {
      125907,
      125906,
      125903,
      125906
    },
    AnimationID = 125902,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C15_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.16,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [131822] = {
    ID = 131822,
    CnID = "怪物@唤醒体塔薇精英版",
    BaseSortID = 529,
    BattleTag = "Elite",
    MonsterTag = {84277, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_131822_MonsterName|「门之钥」",
    Desc = "MonsterConfig_131822_Desc|穷极之门的守护者，时空之外的存在，绝对智识的象征。",
    ExistState = {
      125925,
      125930,
      125931,
      125932
    },
    StateLayers = "1,1,1,1,1",
    InitSkillList = {
      125907,
      125906,
      125903,
      125906
    },
    CycleSkillList1 = {
      125907,
      125906,
      125903,
      125906
    },
    CycleSkillList2 = {
      125907,
      125906,
      125903,
      125906
    },
    AnimationID = 125902,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C15_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.16,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [126444] = {
    ID = 126444,
    CnID = "怪物@唤醒体莉兹",
    BaseSortID = 530,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90644
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_126444_MonsterName|「青炎舞者」",
    Desc = "MonsterConfig_126444_Desc|对芭蕾的爱，对艺术的崇敬……舞者将以焚尽污浊的绿焰尽数诉说。",
    ExistState = {
      126467,
      126466,
      126465,
      126464
    },
    StateLayers = "1,1,1,2",
    InitSkillList = {
      126449,
      126448,
      126452,
      126448
    },
    CycleSkillList1 = {
      126449,
      126448,
      126452,
      126448
    },
    CycleSkillList2 = {
      126448,
      126451,
      126448,
      126449
    },
    AnimationID = 15669,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D01_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.3,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [127245] = {
    ID = 127245,
    CnID = "怪物@唤醒体环行拉蒙娜",
    BaseSortID = 531,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_127245_MonsterName|「觉者」",
    Desc = "MonsterConfig_127245_Desc|穿行于无尽昨日的回溯者，遮蔽的双眼，映着尚未发生的永恒。",
    ExistState = {
      127272,
      127271,
      127266,
      127270,
      127265
    },
    StateLayers = "2,1,1,3",
    InitSkillList = {
      127248,
      127247,
      127250,
      127249,
      127247
    },
    CycleSkillList1 = {
      127248,
      127247,
      127250,
      127249,
      127247
    },
    CycleSkillList2 = {
      127252,
      127247,
      127250,
      127251,
      127247
    },
    AnimationID = 15733,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_C01EX_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.318,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [127696] = {
    ID = 127696,
    CnID = "怪物@小型冷蛛黑A",
    BaseSortID = 532,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_127696_MonsterName|渊狱之蛛",
    Desc = "MonsterConfig_127696_Desc|被丢入渊狱的错误命运的残片，在涅芙蕾亚的意志下凝结成了蜘蛛的形态。",
    ExistState = {
      22074,
      80787,
      127708
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      127700,
      127699,
      127698,
      127700
    },
    CycleSkillList1 = {
      127700,
      127699,
      127698,
      127700
    },
    AnimationID = 132880,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    MonsterHpPercent = 1.8,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [127695] = {
    ID = 127695,
    CnID = "怪物@小型冷蛛黑B",
    BaseSortID = 533,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_127695_MonsterName|渊狱之蛛",
    Desc = "MonsterConfig_127695_Desc|被丢入渊狱的错误命运的残片，在涅芙蕾亚的意志下凝结成了蜘蛛的形态。",
    ExistState = {
      22074,
      80787,
      127708
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      127699,
      127698,
      127700,
      127699
    },
    CycleSkillList1 = {
      127699,
      127698,
      127700,
      127699
    },
    AnimationID = 132880,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    MonsterHpPercent = 1.65,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [127697] = {
    ID = 127697,
    CnID = "怪物@小型冷蛛黑C",
    BaseSortID = 534,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_127697_MonsterName|渊狱之蛛",
    Desc = "MonsterConfig_127697_Desc|被丢入渊狱的错误命运的残片，在涅芙蕾亚的意志下凝结成了蜘蛛的形态。",
    ExistState = {
      22074,
      80787,
      127708
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      127698,
      127700,
      127699,
      127698
    },
    CycleSkillList1 = {
      127698,
      127700,
      127699,
      127698
    },
    AnimationID = 132880,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    MonsterHpPercent = 1.5,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [128018] = {
    ID = 128018,
    CnID = "怪物@小型冷蛛白A",
    BaseSortID = 535,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_128018_MonsterName|冷蛛",
    Desc = "MonsterConfig_128018_Desc|由人类转化而成，阿拉克涅侍女的蜘蛛形态。它们挂载着命运的丝缕，为阿拉克涅编织那张无垠的巨网。",
    ExistState = {
      22074,
      80787,
      128027
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      127700,
      128021,
      128020,
      127700
    },
    CycleSkillList1 = {
      127700,
      128021,
      128020,
      127700
    },
    AnimationID = 132882,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    MonsterHpPercent = 2,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [128019] = {
    ID = 128019,
    CnID = "怪物@小型冷蛛白B",
    BaseSortID = 536,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_128019_MonsterName|冷蛛",
    Desc = "MonsterConfig_128019_Desc|由人类转化而成，阿拉克涅侍女的蜘蛛形态。它们挂载着命运的丝缕，为阿拉克涅编织那张无垠的巨网。",
    ExistState = {
      22074,
      80787,
      128027
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      128021,
      128020,
      127700,
      128021
    },
    CycleSkillList1 = {
      128021,
      128020,
      127700,
      128021
    },
    AnimationID = 132882,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    MonsterHpPercent = 1.8,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [128017] = {
    ID = 128017,
    CnID = "怪物@小型冷蛛白C",
    BaseSortID = 537,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_128017_MonsterName|冷蛛",
    Desc = "MonsterConfig_128017_Desc|由人类转化而成，阿拉克涅侍女的蜘蛛形态。它们挂载着命运的丝缕，为阿拉克涅编织那张无垠的巨网。",
    ExistState = {
      22074,
      80787,
      128027
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      128020,
      127700,
      128021,
      128020
    },
    CycleSkillList1 = {
      128020,
      127700,
      128021,
      128020
    },
    AnimationID = 132882,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    MonsterHpPercent = 1.6,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [131431] = {
    ID = 131431,
    CnID = "怪物@小型冷蛛黑群A",
    BaseSortID = 538,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131431_MonsterName|渊狱蜘群",
    Desc = "MonsterConfig_131431_Desc|它们模仿着冷蛛的姿态行走，却没有丝线可供攀附。无主的仆从，侍奉着一个已被删除的未来。",
    ExistState = {
      22074,
      80787,
      127708,
      131637
    },
    StateLayers = "1,CmdCaster.max_hp*0.15,1,2",
    InitSkillList = {
      127700,
      133473,
      127698,
      127700
    },
    CycleSkillList1 = {
      127700,
      133473,
      127698,
      127700
    },
    AnimationID = 132880,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 0.85,
    MonsterHpPercent = 0.6,
    MonsterAtkPercent = 0.6,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131428] = {
    ID = 131428,
    CnID = "怪物@小型冷蛛黑群B",
    BaseSortID = 539,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131428_MonsterName|渊狱蜘群",
    Desc = "MonsterConfig_131428_Desc|它们模仿着冷蛛的姿态行走，却没有丝线可供攀附。无主的仆从，侍奉着一个已被删除的未来。",
    ExistState = {
      22074,
      80787,
      127708,
      131637
    },
    StateLayers = "1,CmdCaster.max_hp*0.15,1,2",
    InitSkillList = {
      133473,
      127698,
      127700,
      133473
    },
    CycleSkillList1 = {
      133473,
      127698,
      127700,
      133473
    },
    AnimationID = 132880,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 0.85,
    MonsterHpPercent = 0.55,
    MonsterAtkPercent = 0.65,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131426] = {
    ID = 131426,
    CnID = "怪物@小型冷蛛黑群C",
    BaseSortID = 540,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131426_MonsterName|渊狱蜘群",
    Desc = "MonsterConfig_131426_Desc|它们模仿着冷蛛的姿态行走，却没有丝线可供攀附。无主的仆从，侍奉着一个已被删除的未来。",
    ExistState = {
      22074,
      80787,
      127708,
      131637
    },
    StateLayers = "1,CmdCaster.max_hp*0.15,1,2",
    InitSkillList = {
      127698,
      127700,
      133473,
      127698
    },
    CycleSkillList1 = {
      127698,
      127700,
      133473,
      127698
    },
    AnimationID = 132880,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 0.85,
    MonsterHpPercent = 0.5,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131427] = {
    ID = 131427,
    CnID = "怪物@小型冷蛛白群A",
    BaseSortID = 541,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131427_MonsterName|冷蛛群",
    Desc = "MonsterConfig_131427_Desc|冷蛛的集群，命运之网的分子。那诸多蛛体凝集而成的，便是命运本身。",
    ExistState = {
      22074,
      80787,
      128027,
      131637
    },
    StateLayers = "1,CmdCaster.max_hp*0.15,1,2",
    InitSkillList = {
      127700,
      133474,
      128020,
      127700
    },
    CycleSkillList1 = {
      127700,
      133474,
      128020,
      127700
    },
    AnimationID = 132882,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 0.85,
    MonsterHpPercent = 0.6,
    MonsterAtkPercent = 0.6,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131424] = {
    ID = 131424,
    CnID = "怪物@小型冷蛛白群B",
    BaseSortID = 542,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131424_MonsterName|冷蛛群",
    Desc = "MonsterConfig_131424_Desc|冷蛛的集群，命运之网的分子。那诸多蛛体凝集而成的，便是命运本身。",
    ExistState = {
      22074,
      80787,
      128027,
      131637
    },
    StateLayers = "1,CmdCaster.max_hp*0.15,1,2",
    InitSkillList = {
      133474,
      128020,
      127700,
      133474
    },
    CycleSkillList1 = {
      133474,
      128020,
      127700,
      133474
    },
    AnimationID = 132882,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 0.85,
    MonsterHpPercent = 0.55,
    MonsterAtkPercent = 0.65,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131420] = {
    ID = 131420,
    CnID = "怪物@小型冷蛛白群C",
    BaseSortID = 543,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131420_MonsterName|冷蛛群",
    Desc = "MonsterConfig_131420_Desc|冷蛛的集群，命运之网的分子。那诸多蛛体凝集而成的，便是命运本身。",
    ExistState = {
      22074,
      80787,
      128027,
      131637
    },
    StateLayers = "1,CmdCaster.max_hp*0.15,1,2",
    InitSkillList = {
      128020,
      127700,
      133474,
      128020
    },
    CycleSkillList1 = {
      128020,
      127700,
      133474,
      128020
    },
    AnimationID = 132882,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 0.85,
    MonsterHpPercent = 0.5,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131841] = {
    ID = 131841,
    CnID = "怪物@小型冷蛛黑群Aboss召唤版",
    BaseSortID = 544,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131841_MonsterName|渊狱蜘群",
    Desc = "MonsterConfig_131841_Desc|它们模仿着冷蛛的姿态行走，却没有丝线可供攀附。无主的仆从，侍奉着一个已被删除的未来。",
    ExistState = {
      22074,
      80787,
      127708,
      131846
    },
    StateLayers = "1,CmdCaster.max_hp*0.15,1,1",
    InitSkillList = {
      127700,
      133473,
      127698,
      127700
    },
    CycleSkillList1 = {
      127700,
      133473,
      127698,
      127700
    },
    AnimationID = 132880,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.6,
    MonsterAtkPercent = 0.6,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131843] = {
    ID = 131843,
    CnID = "怪物@小型冷蛛黑群Bboss召唤版",
    BaseSortID = 545,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131843_MonsterName|渊狱蜘群",
    Desc = "MonsterConfig_131843_Desc|它们模仿着冷蛛的姿态行走，却没有丝线可供攀附。无主的仆从，侍奉着一个已被删除的未来。",
    ExistState = {
      22074,
      80787,
      127708,
      131846
    },
    StateLayers = "1,CmdCaster.max_hp*0.15,1,1",
    InitSkillList = {
      133473,
      127698,
      127700,
      133473
    },
    CycleSkillList1 = {
      133473,
      127698,
      127700,
      133473
    },
    AnimationID = 132880,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.55,
    MonsterAtkPercent = 0.65,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131839] = {
    ID = 131839,
    CnID = "怪物@小型冷蛛黑群Cboss召唤版",
    BaseSortID = 546,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131839_MonsterName|渊狱蜘群",
    Desc = "MonsterConfig_131839_Desc|它们模仿着冷蛛的姿态行走，却没有丝线可供攀附。无主的仆从，侍奉着一个已被删除的未来。",
    ExistState = {
      22074,
      80787,
      127708,
      131846
    },
    StateLayers = "1,CmdCaster.max_hp*0.15,1,1",
    InitSkillList = {
      127698,
      127700,
      133473,
      127698
    },
    CycleSkillList1 = {
      127698,
      127700,
      133473,
      127698
    },
    AnimationID = 132880,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.5,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131840] = {
    ID = 131840,
    CnID = "怪物@小型冷蛛白群Aboss召唤版",
    BaseSortID = 547,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131840_MonsterName|冷蛛群",
    Desc = "MonsterConfig_131840_Desc|冷蛛的集群，命运之网的分子。那诸多蛛体凝集而成的，便是命运本身。",
    ExistState = {
      22074,
      80787,
      128027,
      131846
    },
    StateLayers = "1,CmdCaster.max_hp*0.15,1,1",
    InitSkillList = {
      127700,
      133474,
      128020,
      127700
    },
    CycleSkillList1 = {
      127700,
      133474,
      128020,
      127700
    },
    AnimationID = 132882,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.6,
    MonsterAtkPercent = 0.6,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131844] = {
    ID = 131844,
    CnID = "怪物@小型冷蛛白群Bboss召唤版",
    BaseSortID = 548,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131844_MonsterName|冷蛛群",
    Desc = "MonsterConfig_131844_Desc|冷蛛的集群，命运之网的分子。那诸多蛛体凝集而成的，便是命运本身。",
    ExistState = {
      22074,
      80787,
      128027,
      131846
    },
    StateLayers = "1,CmdCaster.max_hp*0.15,1,1",
    InitSkillList = {
      133474,
      128020,
      127700,
      133474
    },
    CycleSkillList1 = {
      133474,
      128020,
      127700,
      133474
    },
    AnimationID = 132882,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.55,
    MonsterAtkPercent = 0.65,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131842] = {
    ID = 131842,
    CnID = "怪物@小型冷蛛白群Cboss召唤版",
    BaseSortID = 549,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131842_MonsterName|冷蛛群",
    Desc = "MonsterConfig_131842_Desc|冷蛛的集群，命运之网的分子。那诸多蛛体凝集而成的，便是命运本身。",
    ExistState = {
      22074,
      80787,
      128027,
      131846
    },
    StateLayers = "1,CmdCaster.max_hp*0.15,1,1",
    InitSkillList = {
      128020,
      127700,
      133474,
      128020
    },
    CycleSkillList1 = {
      128020,
      127700,
      133474,
      128020
    },
    AnimationID = 132882,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.5,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131449] = {
    ID = 131449,
    CnID = "怪物@小型冷蛛黑群A精英",
    BaseSortID = 550,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131449_MonsterName|碎相母体",
    Desc = "MonsterConfig_131449_Desc|冷蛛群的核心，以自身为锚点吸收着周围散落的维度余烬，产出新的冷蛛个体。阿拉克涅偶尔会将一段完整的命运丝线赐予它——这是一只冷蛛所能触及的最高恩赏。",
    ExistState = {
      80787,
      127708,
      131638
    },
    StateLayers = "CmdCaster.max_hp*0.15,1,4",
    InitSkillList = {
      127700,
      133473,
      127698,
      127700
    },
    CycleSkillList1 = {
      127700,
      133473,
      127698,
      127700
    },
    AnimationID = 132880,
    MonsterClass = "Elite",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.6,
    MonsterAtkPercent = 0.6,
    MonsterDefPercent = 0,
    MonsterProportion = 0.33
  },
  [131446] = {
    ID = 131446,
    CnID = "怪物@小型冷蛛黑群B精英",
    BaseSortID = 551,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131446_MonsterName|碎相母体",
    Desc = "MonsterConfig_131446_Desc|冷蛛群的核心，以自身为锚点吸收着周围散落的维度余烬，产出新的冷蛛个体。阿拉克涅偶尔会将一段完整的命运丝线赐予它——这是一只冷蛛所能触及的最高恩赏。",
    ExistState = {
      80787,
      127708,
      131638
    },
    StateLayers = "CmdCaster.max_hp*0.15,1,4",
    InitSkillList = {
      133473,
      127698,
      127700,
      133473
    },
    CycleSkillList1 = {
      133473,
      127698,
      127700,
      133473
    },
    AnimationID = 132880,
    MonsterClass = "Elite",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.55,
    MonsterAtkPercent = 0.65,
    MonsterDefPercent = 0,
    MonsterProportion = 0.33
  },
  [131441] = {
    ID = 131441,
    CnID = "怪物@小型冷蛛黑群C精英",
    BaseSortID = 552,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131441_MonsterName|碎相母体",
    Desc = "MonsterConfig_131441_Desc|冷蛛群的核心，以自身为锚点吸收着周围散落的维度余烬，产出新的冷蛛个体。阿拉克涅偶尔会将一段完整的命运丝线赐予它——这是一只冷蛛所能触及的最高恩赏。",
    ExistState = {
      80787,
      127708,
      131638
    },
    StateLayers = "CmdCaster.max_hp*0.15,1,4",
    InitSkillList = {
      127698,
      127700,
      133473,
      127698
    },
    CycleSkillList1 = {
      127698,
      127700,
      133473,
      127698
    },
    AnimationID = 132880,
    MonsterClass = "Elite",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.5,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 0,
    MonsterProportion = 0.33
  },
  [131445] = {
    ID = 131445,
    CnID = "怪物@小型冷蛛白群A精英",
    BaseSortID = 553,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131445_MonsterName|缠丝母体",
    Desc = "MonsterConfig_131445_Desc|冷蛛群的核心，以自身为锚点吸收着周围散落的维度余烬，产出新的冷蛛个体。阿拉克涅偶尔会将一段完整的命运丝线赐予它——这是一只冷蛛所能触及的最高恩赏。",
    ExistState = {
      80787,
      128027,
      131638
    },
    StateLayers = "CmdCaster.max_hp*0.15,1,4",
    InitSkillList = {
      127700,
      133474,
      128020,
      127700
    },
    CycleSkillList1 = {
      127700,
      133474,
      128020,
      127700
    },
    AnimationID = 132882,
    MonsterClass = "Elite",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.6,
    MonsterAtkPercent = 0.6,
    MonsterDefPercent = 0,
    MonsterProportion = 0.33
  },
  [131448] = {
    ID = 131448,
    CnID = "怪物@小型冷蛛白群B精英",
    BaseSortID = 554,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131448_MonsterName|缠丝母体",
    Desc = "MonsterConfig_131448_Desc|冷蛛群的核心，以自身为锚点吸收着周围散落的维度余烬，产出新的冷蛛个体。阿拉克涅偶尔会将一段完整的命运丝线赐予它——这是一只冷蛛所能触及的最高恩赏。",
    ExistState = {
      80787,
      128027,
      131638
    },
    StateLayers = "CmdCaster.max_hp*0.15,1,4",
    InitSkillList = {
      133474,
      128020,
      127700,
      133474
    },
    CycleSkillList1 = {
      133474,
      128020,
      127700,
      133474
    },
    AnimationID = 132882,
    MonsterClass = "Elite",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.55,
    MonsterAtkPercent = 0.65,
    MonsterDefPercent = 0,
    MonsterProportion = 0.33
  },
  [131440] = {
    ID = 131440,
    CnID = "怪物@小型冷蛛白群C精英",
    BaseSortID = 555,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131440_MonsterName|缠丝母体",
    Desc = "MonsterConfig_131440_Desc|冷蛛群的核心，以自身为锚点吸收着周围散落的维度余烬，产出新的冷蛛个体。阿拉克涅偶尔会将一段完整的命运丝线赐予它——这是一只冷蛛所能触及的最高恩赏。",
    ExistState = {
      80787,
      128027,
      131638
    },
    StateLayers = "CmdCaster.max_hp*0.15,1,4",
    InitSkillList = {
      128020,
      127700,
      133474,
      128020
    },
    CycleSkillList1 = {
      128020,
      127700,
      133474,
      128020
    },
    AnimationID = 132882,
    MonsterClass = "Elite",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.5,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 0,
    MonsterProportion = 0.33
  },
  [131430] = {
    ID = 131430,
    CnID = "怪物@小型冷蛛黑群召唤A",
    BaseSortID = 556,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131430_MonsterName|冷蛛群",
    Desc = "MonsterConfig_131430_Desc|冷蛛的集群，命运之网的分子。那诸多蛛体凝集而成的，便是命运本身。",
    ExistState = {
      22074,
      80787,
      127708
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      127700,
      133473,
      127698,
      127700
    },
    CycleSkillList1 = {
      127700,
      133473,
      127698,
      127700
    },
    AnimationID = 132880,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.6,
    MonsterAtkPercent = 0.6,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131425] = {
    ID = 131425,
    CnID = "怪物@小型冷蛛黑群召唤B",
    BaseSortID = 557,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131425_MonsterName|冷蛛群",
    Desc = "MonsterConfig_131425_Desc|冷蛛的集群，命运之网的分子。那诸多蛛体凝集而成的，便是命运本身。",
    ExistState = {
      22074,
      80787,
      127708
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      133473,
      127698,
      127700,
      133473
    },
    CycleSkillList1 = {
      133473,
      127698,
      127700,
      133473
    },
    AnimationID = 132880,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.55,
    MonsterAtkPercent = 0.65,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131422] = {
    ID = 131422,
    CnID = "怪物@小型冷蛛黑群召唤C",
    BaseSortID = 558,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131422_MonsterName|冷蛛群",
    Desc = "MonsterConfig_131422_Desc|冷蛛的集群，命运之网的分子。那诸多蛛体凝集而成的，便是命运本身。",
    ExistState = {
      22074,
      80787,
      127708
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      127698,
      127700,
      133473,
      127698
    },
    CycleSkillList1 = {
      127698,
      127700,
      133473,
      127698
    },
    AnimationID = 132880,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.5,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131421] = {
    ID = 131421,
    CnID = "怪物@小型冷蛛白群召唤A",
    BaseSortID = 559,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131421_MonsterName|渊狱蜘群",
    Desc = "MonsterConfig_131421_Desc|它们模仿着冷蛛的姿态行走，却没有丝线可供攀附。无主的仆从，侍奉着一个已被删除的未来。",
    ExistState = {
      22074,
      80787,
      128027
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      127700,
      133474,
      128020,
      127700
    },
    CycleSkillList1 = {
      127700,
      133474,
      128020,
      127700
    },
    AnimationID = 132882,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.6,
    MonsterAtkPercent = 0.6,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131429] = {
    ID = 131429,
    CnID = "怪物@小型冷蛛白群召唤B",
    BaseSortID = 560,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131429_MonsterName|渊狱蜘群",
    Desc = "MonsterConfig_131429_Desc|它们模仿着冷蛛的姿态行走，却没有丝线可供攀附。无主的仆从，侍奉着一个已被删除的未来。",
    ExistState = {
      22074,
      80787,
      128027
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      133474,
      128020,
      127700,
      133474
    },
    CycleSkillList1 = {
      133474,
      128020,
      127700,
      133474
    },
    AnimationID = 132882,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.55,
    MonsterAtkPercent = 0.65,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131423] = {
    ID = 131423,
    CnID = "怪物@小型冷蛛白群召唤C",
    BaseSortID = 561,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131423_MonsterName|渊狱蜘群",
    Desc = "MonsterConfig_131423_Desc|它们模仿着冷蛛的姿态行走，却没有丝线可供攀附。无主的仆从，侍奉着一个已被删除的未来。",
    ExistState = {
      22074,
      80787,
      128027
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      128020,
      127700,
      133474,
      128020
    },
    CycleSkillList1 = {
      128020,
      127700,
      133474,
      128020
    },
    AnimationID = 132882,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.5,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [131630] = {
    ID = 131630,
    CnID = "怪物@小型冷蛛黑群召唤A精英",
    BaseSortID = 562,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131630_MonsterName|碎相母体",
    Desc = "MonsterConfig_131630_Desc|冷蛛群的核心，以自身为锚点吸收着周围散落的维度余烬，产出新的冷蛛个体。阿拉克涅偶尔会将一段完整的命运丝线赐予它——这是一只冷蛛所能触及的最高恩赏。",
    ExistState = {80787, 127708},
    StateLayers = "CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      127700,
      133473,
      127698,
      127700
    },
    CycleSkillList1 = {
      127700,
      133473,
      127698,
      127700
    },
    AnimationID = 132880,
    MonsterClass = "Elite",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 1.1,
    MonsterHpPercent = 0.6,
    MonsterAtkPercent = 0.6,
    MonsterDefPercent = 0,
    MonsterProportion = 0.33
  },
  [131632] = {
    ID = 131632,
    CnID = "怪物@小型冷蛛黑群召唤B精英",
    BaseSortID = 563,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131632_MonsterName|碎相母体",
    Desc = "MonsterConfig_131632_Desc|冷蛛群的核心，以自身为锚点吸收着周围散落的维度余烬，产出新的冷蛛个体。阿拉克涅偶尔会将一段完整的命运丝线赐予它——这是一只冷蛛所能触及的最高恩赏。",
    ExistState = {80787, 127708},
    StateLayers = "CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      133473,
      127698,
      127700,
      133473
    },
    CycleSkillList1 = {
      133473,
      127698,
      127700,
      133473
    },
    AnimationID = 132880,
    MonsterClass = "Elite",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 1.1,
    MonsterHpPercent = 0.55,
    MonsterAtkPercent = 0.65,
    MonsterDefPercent = 0,
    MonsterProportion = 0.33
  },
  [131633] = {
    ID = 131633,
    CnID = "怪物@小型冷蛛黑群召唤C精英",
    BaseSortID = 564,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131633_MonsterName|碎相母体",
    Desc = "MonsterConfig_131633_Desc|冷蛛群的核心，以自身为锚点吸收着周围散落的维度余烬，产出新的冷蛛个体。阿拉克涅偶尔会将一段完整的命运丝线赐予它——这是一只冷蛛所能触及的最高恩赏。",
    ExistState = {80787, 127708},
    StateLayers = "CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      127698,
      127700,
      133473,
      127698
    },
    CycleSkillList1 = {
      127698,
      127700,
      133473,
      127698
    },
    AnimationID = 132880,
    MonsterClass = "Elite",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 1.1,
    MonsterHpPercent = 0.5,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 0,
    MonsterProportion = 0.33
  },
  [131629] = {
    ID = 131629,
    CnID = "怪物@小型冷蛛白群召唤A精英",
    BaseSortID = 565,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131629_MonsterName|缠丝母体",
    Desc = "MonsterConfig_131629_Desc|冷蛛群的核心，以自身为锚点吸收着周围散落的维度余烬，产出新的冷蛛个体。阿拉克涅偶尔会将一段完整的命运丝线赐予它——这是一只冷蛛所能触及的最高恩赏。",
    ExistState = {80787, 128027},
    StateLayers = "CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      127700,
      133474,
      128020,
      127700
    },
    CycleSkillList1 = {
      127700,
      133474,
      128020,
      127700
    },
    AnimationID = 132882,
    MonsterClass = "Elite",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 1.1,
    MonsterHpPercent = 0.6,
    MonsterAtkPercent = 0.6,
    MonsterDefPercent = 0,
    MonsterProportion = 0.33
  },
  [131634] = {
    ID = 131634,
    CnID = "怪物@小型冷蛛白群召唤B精英",
    BaseSortID = 566,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131634_MonsterName|缠丝母体",
    Desc = "MonsterConfig_131634_Desc|冷蛛群的核心，以自身为锚点吸收着周围散落的维度余烬，产出新的冷蛛个体。阿拉克涅偶尔会将一段完整的命运丝线赐予它——这是一只冷蛛所能触及的最高恩赏。",
    ExistState = {80787, 128027},
    StateLayers = "CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      133474,
      128020,
      127700,
      133474
    },
    CycleSkillList1 = {
      133474,
      128020,
      127700,
      133474
    },
    AnimationID = 132882,
    MonsterClass = "Elite",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 1.1,
    MonsterHpPercent = 0.55,
    MonsterAtkPercent = 0.65,
    MonsterDefPercent = 0,
    MonsterProportion = 0.33
  },
  [131631] = {
    ID = 131631,
    CnID = "怪物@小型冷蛛白群召唤C精英",
    BaseSortID = 567,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131631_MonsterName|缠丝母体",
    Desc = "MonsterConfig_131631_Desc|冷蛛群的核心，以自身为锚点吸收着周围散落的维度余烬，产出新的冷蛛个体。阿拉克涅偶尔会将一段完整的命运丝线赐予它——这是一只冷蛛所能触及的最高恩赏。",
    ExistState = {80787, 128027},
    StateLayers = "CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      128020,
      127700,
      133474,
      128020
    },
    CycleSkillList1 = {
      128020,
      127700,
      133474,
      128020
    },
    AnimationID = 132882,
    MonsterClass = "Elite",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 1.1,
    MonsterHpPercent = 0.5,
    MonsterAtkPercent = 0.7,
    MonsterDefPercent = 0,
    MonsterProportion = 0.33
  },
  [128045] = {
    ID = 128045,
    CnID = "怪物@冷蛛侍女白",
    BaseSortID = 568,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90644,
      84291,
      90645
    },
    MonsterName = "MonsterConfig_128045_MonsterName|冷蛛侍女",
    Desc = "MonsterConfig_128045_Desc|被赐予人形外壳的冷蛛，穿戴整洁地穿行于命运剧院的舞台之间。命运的操控者从不强迫木偶成为她的侍女，但她们总是心甘情愿地选择这条属于自己的道路。",
    ExistState = {
      22074,
      80787,
      128067,
      128086,
      129633
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1,1",
    InitSkillList = {
      128474,
      128049,
      128474,
      128048
    },
    CycleSkillList1 = {
      128474,
      128049,
      128474,
      128048
    },
    AnimationID = 132883,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0502_AT.png",
    MonsterHpPercent = 1.75,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 1.02,
    MonsterProportion = 0.6
  },
  [128047] = {
    ID = 128047,
    CnID = "怪物@冷蛛侍女白精英",
    BaseSortID = 569,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90644,
      84291,
      90645
    },
    MonsterName = "MonsterConfig_128047_MonsterName|量体师",
    Desc = "MonsterConfig_128047_Desc|侍女中被授权「度量」命运的个体。她丈量每一段命运的分量，向命运的操控者报告那些线缕的错乱。至于之后将发生的，她从不关心。",
    ExistState = {
      80787,
      128067,
      128086,
      2921,
      129635,
      2921
    },
    StateLayers = "CmdCaster.max_hp*0.04,1,1,1",
    InitSkillList = {
      128474,
      128052,
      128474,
      128048
    },
    CycleSkillList1 = {
      128474,
      128052,
      128474,
      128048
    },
    AnimationID = 132883,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0502_AT.png",
    Scale = 1.15,
    MonsterHpPercent = 1.8,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 2.18,
    MonsterProportion = 0.9
  },
  [131447] = {
    ID = 131447,
    CnID = "怪物@冷蛛侍女白BOSS",
    BaseSortID = 570,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90644,
      84291,
      90645
    },
    MonsterName = "MonsterConfig_131447_MonsterName|「织幕者」",
    Desc = "MonsterConfig_131447_Desc|命运女神的亲侍。她亲手为舞台织造幕布，帮助命运的女神，为一个世界编写开场与落幕。每一座她经手的舞台都运行得精确而冷酷，如同她主人的意志本身。",
    ExistState = {
      80787,
      128067,
      128086,
      128253,
      2921,
      129634,
      2921,
      2921
    },
    StateLayers = "CmdCaster.max_hp*0.03,1,1,1",
    InitSkillList = {
      128474,
      128053,
      128474,
      128048
    },
    CycleSkillList1 = {
      128474,
      128053,
      128474,
      128048
    },
    CycleSkillList2 = {
      128053,
      128474,
      128048,
      128474
    },
    AnimationID = 132883,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0502_AT.png",
    Scale = 1.3,
    MonsterHpPercent = 1,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 1.68,
    MonsterProportion = 0.9,
    MonsterHpNum = 2
  },
  [128224] = {
    ID = 128224,
    CnID = "怪物@冷蛛侍女黑",
    BaseSortID = 571,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90644,
      84291,
      90645
    },
    MonsterName = "MonsterConfig_128224_MonsterName|渊狱侍从",
    Desc = "MonsterConfig_128224_Desc|坠入渊狱的侍女，依然保持着侍女的姿势，在苦痛的虚空中重复擦拭、整理、微笑，侍奉一座早已不复存在的舞台。",
    ExistState = {
      22074,
      80787,
      128067,
      128251,
      129633
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1,1",
    InitSkillList = {
      128476,
      128233,
      128476,
      128227
    },
    CycleSkillList1 = {
      128476,
      128233,
      128476,
      128227
    },
    AnimationID = 132879,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0502_BT.png",
    MonsterHpPercent = 1.4,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [128223] = {
    ID = 128223,
    CnID = "怪物@冷蛛侍女黑精英",
    BaseSortID = 572,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90644,
      84291,
      90645
    },
    MonsterName = "MonsterConfig_128223_MonsterName|剪裁师",
    Desc = "MonsterConfig_128223_Desc|渊狱中的并没有可供剪断之物。她与她疯狂的主人一同等待，等待能够亲手剪断命运的那一天。",
    ExistState = {
      80787,
      128067,
      128251,
      2921,
      129635,
      2921
    },
    StateLayers = "CmdCaster.max_hp*0.04,1,1,1",
    InitSkillList = {
      128476,
      128229,
      128476,
      128227
    },
    CycleSkillList1 = {
      128476,
      128229,
      128476,
      128227
    },
    AnimationID = 132879,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0502_BT.png",
    Scale = 1.15,
    MonsterHpPercent = 1.5,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.9
  },
  [131442] = {
    ID = 131442,
    CnID = "怪物@冷蛛侍女黑BOSS",
    BaseSortID = 573,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90644,
      84291,
      90645
    },
    MonsterName = "MonsterConfig_131442_MonsterName|「缚命人」",
    Desc = "MonsterConfig_131442_Desc|一位曾经的织幕者，阿拉克涅身边最亲近的侍女。她或许曾理解命运女神的决定，而在渊狱中的无数年里，残留在这具躯壳中的，只剩疯狂与仇恨。",
    ExistState = {
      80787,
      128067,
      128251,
      128247,
      2921,
      129634,
      2921
    },
    StateLayers = "CmdCaster.max_hp*0.04,1,1,1",
    InitSkillList = {
      128476,
      128230,
      128476,
      128227
    },
    CycleSkillList1 = {
      128476,
      128230,
      128476,
      128227
    },
    CycleSkillList2 = {
      128230,
      128476,
      128227,
      128476
    },
    AnimationID = 132879,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0502_BT.png",
    Scale = 1.3,
    MonsterHpPercent = 0.8,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.9,
    MonsterHpNum = 2
  },
  [131887] = {
    ID = 131887,
    CnID = "怪物@冷蛛侍女白2",
    BaseSortID = 574,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90644,
      84291,
      90645
    },
    MonsterName = "MonsterConfig_131887_MonsterName|冷蛛侍女",
    Desc = "MonsterConfig_131887_Desc|被赐予人形外壳的冷蛛，穿戴整洁地穿行于命运剧院的舞台之间。命运的操控者从不强迫木偶成为她的侍女，但她们总是心甘情愿地选择这条属于自己的道路。",
    ExistState = {
      22074,
      80787,
      128067,
      128086,
      129633
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1,1",
    InitSkillList = {
      128049,
      128474,
      128048,
      128474
    },
    CycleSkillList1 = {
      128049,
      128474,
      128048,
      128474
    },
    AnimationID = 132883,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0502_AT.png",
    MonsterHpPercent = 1.5,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 1.02,
    MonsterProportion = 0.6
  },
  [131884] = {
    ID = 131884,
    CnID = "怪物@冷蛛侍女白精英2",
    BaseSortID = 575,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90644,
      84291,
      90645
    },
    MonsterName = "MonsterConfig_131884_MonsterName|量体师",
    Desc = "MonsterConfig_131884_Desc|侍女中被授权「度量」命运的个体。她丈量每一段命运的分量，向命运的操控者报告那些线缕的错乱。至于之后将发生的，她从不关心。",
    ExistState = {
      80787,
      128067,
      128086,
      2921,
      129635,
      2921
    },
    StateLayers = "CmdCaster.max_hp*0.04,1,1,1",
    InitSkillList = {
      128052,
      128474,
      128048,
      128474
    },
    CycleSkillList1 = {
      128052,
      128474,
      128048,
      128474
    },
    AnimationID = 132883,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0502_AT.png",
    Scale = 1.05,
    MonsterHpPercent = 1.7,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 2.18,
    MonsterProportion = 0.9
  },
  [131883] = {
    ID = 131883,
    CnID = "怪物@冷蛛侍女白BOSS2",
    BaseSortID = 576,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90644,
      84291,
      90645
    },
    MonsterName = "MonsterConfig_131883_MonsterName|「织幕者」",
    Desc = "MonsterConfig_131883_Desc|命运女神的亲侍。她亲手为舞台织造幕布，帮助命运的女神，为一个世界编写开场与落幕。每一座她经手的舞台都运行得精确而冷酷，如同她主人的意志本身。",
    ExistState = {
      80787,
      128067,
      128086,
      128253,
      2921,
      129634,
      2921,
      2921
    },
    StateLayers = "CmdCaster.max_hp*0.03,1,1,1",
    InitSkillList = {
      128053,
      128474,
      128048,
      128474
    },
    CycleSkillList1 = {
      128053,
      128474,
      128048,
      128474
    },
    CycleSkillList2 = {
      128053,
      128474,
      128048,
      128474
    },
    AnimationID = 132883,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0502_AT.png",
    Scale = 1.3,
    MonsterHpPercent = 1,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 1.68,
    MonsterProportion = 0.9,
    MonsterHpNum = 2
  },
  [131886] = {
    ID = 131886,
    CnID = "怪物@冷蛛侍女黑2",
    BaseSortID = 577,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90644,
      84291,
      90645
    },
    MonsterName = "MonsterConfig_131886_MonsterName|渊狱侍从",
    Desc = "MonsterConfig_131886_Desc|坠入渊狱的侍女，依然保持着侍女的姿势，在苦痛的虚空中重复擦拭、整理、微笑，侍奉一座早已不复存在的舞台。",
    ExistState = {
      22074,
      80787,
      128067,
      128251,
      129633
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1,1",
    InitSkillList = {
      128233,
      128476,
      128227,
      128476
    },
    CycleSkillList1 = {
      128233,
      128476,
      128227,
      128476
    },
    AnimationID = 132879,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0502_BT.png",
    MonsterHpPercent = 1.2,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [131885] = {
    ID = 131885,
    CnID = "怪物@冷蛛侍女黑精英2",
    BaseSortID = 578,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90644,
      84291,
      90645
    },
    MonsterName = "MonsterConfig_131885_MonsterName|剪裁师",
    Desc = "MonsterConfig_131885_Desc|渊狱中的并没有可供剪断之物。她与她疯狂的主人一同等待，等待能够亲手剪断命运的那一天。",
    ExistState = {
      80787,
      128067,
      128251,
      2921,
      129635,
      2921
    },
    StateLayers = "CmdCaster.max_hp*0.04,1,1,1",
    InitSkillList = {
      128229,
      128476,
      128227,
      128476
    },
    CycleSkillList1 = {
      128229,
      128476,
      128227,
      128476
    },
    AnimationID = 132879,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0502_BT.png",
    Scale = 1.05,
    MonsterHpPercent = 1.4,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.9
  },
  [131888] = {
    ID = 131888,
    CnID = "怪物@冷蛛侍女黑BOSS2",
    BaseSortID = 579,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90644,
      84291,
      90645
    },
    MonsterName = "MonsterConfig_131888_MonsterName|「缚命人」",
    Desc = "MonsterConfig_131888_Desc|一位曾经的织幕者，阿拉克涅身边最亲近的侍女。她或许曾理解命运女神的决定，而在渊狱中的无数年里，残留在这具躯壳中的，只剩疯狂与仇恨。",
    ExistState = {
      80787,
      128067,
      128251,
      128247,
      2921,
      129634,
      2921
    },
    StateLayers = "CmdCaster.max_hp*0.04,1,1,1",
    InitSkillList = {
      128230,
      128476,
      128227,
      128476
    },
    CycleSkillList1 = {
      128230,
      128476,
      128227,
      128476
    },
    CycleSkillList2 = {
      128230,
      128476,
      128227,
      128476
    },
    AnimationID = 132879,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0502_BT.png",
    Scale = 1.3,
    MonsterHpPercent = 0.8,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.9,
    MonsterHpNum = 2
  },
  [128551] = {
    ID = 128551,
    CnID = "怪物@错乱的命运",
    BaseSortID = 580,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      90644,
      84293
    },
    MonsterName = "MonsterConfig_128551_MonsterName|迷途之人",
    Desc = "MonsterConfig_128551_Desc|每一张脸，都曾是某个世界、某个人的一生。",
    ExistState = {
      80787,
      22074,
      128645,
      128695
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1",
    InitSkillList = {
      128628,
      128624,
      128627,
      128625
    },
    CycleSkillList1 = {
      128628,
      128624,
      128627,
      128625
    },
    AnimationID = 132881,
    MonsterClass = "Common",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0503.png",
    MonsterHpPercent = 1.25,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.42,
    MonsterProportion = 1
  },
  [129602] = {
    ID = 129602,
    CnID = "怪物@错乱的命运精英",
    BaseSortID = 581,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      90644,
      84293
    },
    MonsterName = "MonsterConfig_129602_MonsterName|噬线集群",
    Desc = "MonsterConfig_129602_Desc|大量破碎的命运汇聚在一起，互相撕咬、吞噬，拧成一团无法辨认原貌的风暴。每一根丝线都在试图成为唯一的正确命运，每一根都注定失败。",
    ExistState = {
      80787,
      129612,
      128695
    },
    StateLayers = "CmdCaster.max_hp*0.04,1,1",
    InitSkillList = {
      129617,
      129618,
      129616,
      129615
    },
    CycleSkillList1 = {
      129617,
      129618,
      129616,
      129615
    },
    AnimationID = 132881,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0503.png",
    Scale = 1.15,
    MonsterHpPercent = 1.25,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.42,
    MonsterProportion = 1
  },
  [131443] = {
    ID = 131443,
    CnID = "怪物@错乱的命运BOSS",
    BaseSortID = 582,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90644,
      84293
    },
    MonsterName = "MonsterConfig_131443_MonsterName|「命运残兆」",
    Desc = "MonsterConfig_131443_Desc|渊狱的梦境里，被遗弃的命运们看到了自己的丝线。它们哀嚎着，沿着那条脆弱的丝线，蠕动向它们的来处。亲爱的命运母亲啊……您可有听见我们的呼唤？",
    ExistState = {
      80787,
      129625,
      128695,
      129642,
      131765
    },
    StateLayers = "CmdCaster.max_hp*0.03,1,1,1",
    InitSkillList = {
      129617,
      129618,
      129616,
      129622
    },
    CycleSkillList1 = {
      129617,
      129618,
      129616,
      129622
    },
    AnimationID = 132881,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0503.png",
    Scale = 1.45,
    MonsterHpPercent = 1.25,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 1.42,
    MonsterProportion = 1
  },
  [129821] = {
    ID = 129821,
    CnID = "怪物@唤醒体阿拉克涅",
    BaseSortID = 583,
    BattleTag = "Boss",
    MonsterTag = {84277, 84297},
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_129821_MonsterName|「永恒之网」",
    Desc = "MonsterConfig_129821_Desc|网的主人。网的囚徒。",
    ExistState = {
      129845,
      129849,
      129854,
      129897,
      131157
    },
    StateLayers = "1,1,1,1,1",
    InitSkillList = {129826},
    CycleSkillList1 = {
      129824,
      129823,
      129822,
      129823
    },
    CycleSkillList2 = {
      129824,
      129823,
      129822,
      129823
    },
    AnimationID = 129879,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D10_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.716,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [130469] = {
    ID = 130469,
    CnID = "怪物@暗黑阿拉克涅",
    BaseSortID = 584,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90644,
      84294
    },
    MonsterName = "MonsterConfig_130469_MonsterName|「背弃之网」涅芙蕾亚",
    Desc = "MonsterConfig_130469_Desc|解脱，是她唯一能赠予你的礼物。",
    ExistState = {
      117876,
      131118,
      80787,
      131104,
      131127,
      131157,
      131165,
      131163,
      131168
    },
    StateLayers = "1,1,CmdCaster.max_hp*0.03,1,1,1,1,1,1",
    InitSkillList = {130473, 130474},
    CycleSkillList1 = {130473, 130474},
    CycleSkillList2 = {
      130471,
      130479,
      130471,
      130479
    },
    AnimationID = 130470,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2B0005_AT.png",
    Scale = 1,
    MonsterHpPercent = 0.6,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.33,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [131246] = {
    ID = 131246,
    CnID = "怪物@暗黑阿拉克涅动特版",
    BaseSortID = 585,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      90644,
      84294
    },
    MonsterName = "MonsterConfig_131246_MonsterName|「背弃之网」涅芙蕾亚",
    Desc = "MonsterConfig_131246_Desc|解脱，是她唯一能赠予你的礼物。",
    ExistState = {
      117876,
      131118,
      80787,
      131104,
      131127,
      131157,
      131168
    },
    StateLayers = "1,0,CmdCaster.max_hp*0.03,1,1,1,1,1,1",
    InitSkillList = {
      130473,
      130474,
      130477,
      130471,
      130479,
      130478,
      130472,
      130475,
      130476
    },
    CycleSkillList1 = {
      130473,
      130474,
      130477,
      130471,
      130479,
      130478,
      130472,
      130475,
      130476
    },
    AnimationID = 130470,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2B0005_AT.png",
    Scale = 1,
    MonsterHpPercent = 0.6,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0.33,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [131184] = {
    ID = 131184,
    CnID = "怪物@小型冷蛛黑A召唤",
    BaseSortID = 586,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131184_MonsterName|渊狱之蛛",
    Desc = "MonsterConfig_131184_Desc|被丢入渊狱的错误命运的残片，在涅芙蕾亚的意志下凝结成了蜘蛛的形态。",
    ExistState = {
      22074,
      127708,
      131134,
      80787
    },
    StateLayers = "1,1,1,CmdCaster.max_hp*0.1",
    InitSkillList = {
      127700,
      127699,
      127698,
      127700
    },
    CycleSkillList1 = {
      127700,
      127699,
      127698,
      127700
    },
    AnimationID = 132880,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 0.85,
    MonsterHpPercent = 1.8,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [131181] = {
    ID = 131181,
    CnID = "怪物@小型冷蛛黑B召唤",
    BaseSortID = 587,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131181_MonsterName|渊狱之蛛",
    Desc = "MonsterConfig_131181_Desc|被丢入渊狱的错误命运的残片，在涅芙蕾亚的意志下凝结成了蜘蛛的形态。",
    ExistState = {
      22074,
      127708,
      131134,
      80787
    },
    StateLayers = "1,1,1,CmdCaster.max_hp*0.1",
    InitSkillList = {
      127699,
      127698,
      127700,
      127699
    },
    CycleSkillList1 = {
      127699,
      127698,
      127700,
      127699
    },
    AnimationID = 132880,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 0.85,
    MonsterHpPercent = 1.65,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [131182] = {
    ID = 131182,
    CnID = "怪物@小型冷蛛黑C召唤",
    BaseSortID = 588,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131182_MonsterName|渊狱之蛛",
    Desc = "MonsterConfig_131182_Desc|被丢入渊狱的错误命运的残片，在涅芙蕾亚的意志下凝结成了蜘蛛的形态。",
    ExistState = {
      22074,
      127708,
      131134,
      80787
    },
    StateLayers = "1,1,1,CmdCaster.max_hp*0.1",
    InitSkillList = {
      127698,
      127700,
      127699,
      127698
    },
    CycleSkillList1 = {
      127698,
      127700,
      127699,
      127698
    },
    AnimationID = 132880,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_AT.png",
    Scale = 0.85,
    MonsterHpPercent = 1.5,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [131179] = {
    ID = 131179,
    CnID = "怪物@小型冷蛛白A召唤",
    BaseSortID = 589,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131179_MonsterName|冷蛛",
    Desc = "MonsterConfig_131179_Desc|由人类转化而成，阿拉克涅侍女的蜘蛛形态。它们挂载着命运的丝缕，为阿拉克涅编织那张无垠的巨网。",
    ExistState = {
      22074,
      128027,
      131134,
      80787
    },
    StateLayers = "1,1,1,CmdCaster.max_hp*0.1",
    InitSkillList = {
      127700,
      128021,
      128020,
      127700
    },
    CycleSkillList1 = {
      127700,
      128021,
      128020,
      127700
    },
    AnimationID = 132882,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 0.85,
    MonsterHpPercent = 2,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [131180] = {
    ID = 131180,
    CnID = "怪物@小型冷蛛白B召唤",
    BaseSortID = 590,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131180_MonsterName|冷蛛",
    Desc = "MonsterConfig_131180_Desc|由人类转化而成，阿拉克涅侍女的蜘蛛形态。它们挂载着命运的丝缕，为阿拉克涅编织那张无垠的巨网。",
    ExistState = {
      22074,
      128027,
      131134,
      80787
    },
    StateLayers = "1,1,1,CmdCaster.max_hp*0.1",
    InitSkillList = {
      128021,
      128020,
      127700,
      128021
    },
    CycleSkillList1 = {
      128021,
      128020,
      127700,
      128021
    },
    AnimationID = 132882,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 0.85,
    MonsterHpPercent = 1.8,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [131183] = {
    ID = 131183,
    CnID = "怪物@小型冷蛛白C召唤",
    BaseSortID = 591,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90644,
      84291
    },
    MonsterName = "MonsterConfig_131183_MonsterName|冷蛛",
    Desc = "MonsterConfig_131183_Desc|由人类转化而成，阿拉克涅侍女的蜘蛛形态。它们挂载着命运的丝缕，为阿拉克涅编织那张无垠的巨网。",
    ExistState = {
      22074,
      128027,
      131134,
      80787
    },
    StateLayers = "1,1,1,CmdCaster.max_hp*0.1",
    InitSkillList = {
      128020,
      127700,
      128021,
      128020
    },
    CycleSkillList1 = {
      128020,
      127700,
      128021,
      128020
    },
    AnimationID = 132882,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0501_BT.png",
    Scale = 0.85,
    MonsterHpPercent = 1.6,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.35
  },
  [140713] = {
    ID = 140713,
    CnID = "怪物@沙耶剧情肉块",
    BaseSortID = 592,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84303,
      90645
    },
    MonsterName = "MonsterConfig_140713_MonsterName|榖ｦ圣7ﾋ肉ｸk塊Q",
    Desc = "MonsterConfig_140713_Desc|难ﾃ以ｨ分A辨ﾑ爨轮9廓ｴ的ﾅ肉ｷ块z,ﾉ散ｲ发驫出8令ﾃP人ｬ厌ﾗ憎ｸ的ﾎ靇恶ﾑ臭w味ｦ。 不J知ﾒ为ｩ何ﾇ,ｯ对7你ﾘ表L现ﾝ出Q亲ｱ近ﾏ。",
    ExistState = {
      80787,
      140725,
      140730,
      140772
    },
    StateLayers = "CmdCaster.max_hp*0.03,1,1,1",
    InitSkillList = {
      140714,
      140767,
      140714
    },
    CycleSkillList1 = {
      140714,
      140767,
      140714
    },
    CycleSkillList2 = {
      140714,
      140767,
      140714
    },
    AnimationID = 140827,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_DCB15_01.png",
    Scale = 1.5,
    MonsterHpPercent = 1.05,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0.12,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [141068] = {
    ID = 141068,
    CnID = "怪物@终极塔薇",
    BaseSortID = 593,
    BattleTag = "Boss",
    MonsterTag = {84277, 84294},
    MonsterName = "MonsterConfig_141068_MonsterName|「@2：万象门扉」",
    Desc = "MonsterConfig_141068_Desc|智之质体的代行者。知识权柄的拥有者。弥萨格的指引者。令人恐惧的敌人。",
    ExistState = {
      142066,
      80787,
      60312,
      142072,
      142057,
      142452,
      142060,
      142061,
      142093,
      142062
    },
    StateLayers = "1,CmdCaster.max_hp*0.03,20,1,1,1,1,1,1,1",
    InitSkillList = {
      142026,
      142043,
      142023,
      142034
    },
    CycleSkillList1 = {
      142026,
      142043,
      142023,
      142034
    },
    CycleSkillList2 = {
      142026,
      142030,
      142050,
      142031
    },
    AnimationID = 15687,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_A0003.png",
    Scale = 1,
    MonsterHpPercent = 0.8,
    MonsterAtkPercent = 0.72,
    MonsterDefPercent = 0.8,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [147675] = {
    ID = 147675,
    CnID = "怪物@唤醒体卡拉布",
    BaseSortID = 594,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      84284,
      84303
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_147675_MonsterName|「白雪仙女」",
    Desc = "MonsterConfig_147675_Desc|别被她楚楚可怜的模样骗了——所谓「赐福」，从来都是她精心编织的又一场谎言。",
    ExistState = {
      149391,
      149394,
      149568
    },
    StateLayers = "1,1,1",
    InitSkillList = {
      149373,
      149347,
      149378
    },
    CycleSkillList1 = {
      149373,
      149347,
      149378
    },
    CycleSkillList2 = {
      149369,
      149347,
      149347,
      149378
    },
    AnimationID = 148008,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B11_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.55,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 1.456,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [147935] = {
    ID = 147935,
    CnID = "怪物@唤醒体波吕克斯",
    BaseSortID = 595,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      90646,
      90644
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_147935_MonsterName|「圣子·白夜」",
    Desc = "MonsterConfig_147935_Desc|稚龄的雏鸟啊，尚未学会飞翔，就已被囚笼标记了信号。",
    ExistState = {
      147971,
      147975,
      147969,
      60263,
      147970,
      148079
    },
    StateLayers = "1,1,1,50,1,2",
    InitSkillList = {
      147940,
      147942,
      147940,
      147944,
      147939
    },
    CycleSkillList1 = {
      147940,
      147942,
      147940,
      147944,
      147939
    },
    CycleSkillList2 = {
      147943,
      147940,
      147944,
      147940,
      147939
    },
    AnimationID = 147936,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_D14_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.4,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [148007] = {
    ID = 148007,
    CnID = "怪物@唤醒体本源希洛",
    BaseSortID = 596,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84297,
      84303
    },
    Category = "AwakerMonster",
    MonsterName = "MonsterConfig_148007_MonsterName|「索魂者」",
    Desc = "MonsterConfig_148007_Desc|嗜血之物啊，挣脱锁链之时，她将许下向举世「复仇」的心愿。",
    ExistState = {
      148387,
      148385,
      148384,
      148390,
      60264,
      148442
    },
    StateLayers = "1,1,1,1,1,1",
    InitSkillList = {
      148362,
      148361,
      148362,
      148365
    },
    CycleSkillList1 = {
      148362,
      148361,
      148362,
      148365
    },
    CycleSkillList2 = {
      148362,
      148360,
      148362,
      148365
    },
    AnimationID = 148009,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Minihead_EnemyAwaker_B05EX_AF.png",
    Scale = 1,
    MonsterHpPercent = 0.6,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 2
  },
  [149069] = {
    ID = 149069,
    CnID = "怪物@提灯犬小A",
    BaseSortID = 597,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90646,
      84291
    },
    MonsterName = "MonsterConfig_149069_MonsterName|斯库尔",
    Desc = "MonsterConfig_149069_Desc|追逐太阳的猛犬，祂将被烈日灼伤。",
    ExistState = {
      149093,
      149123,
      80787,
      22074
    },
    StateLayers = "1,1,CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      149078,
      149077,
      149081
    },
    CycleSkillList1 = {
      149078,
      149077,
      149081
    },
    AnimationID = 149072,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0601_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 1.08,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.4
  },
  [149071] = {
    ID = 149071,
    CnID = "怪物@提灯犬小B",
    BaseSortID = 598,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90646,
      84291
    },
    MonsterName = "MonsterConfig_149071_MonsterName|斯库尔",
    Desc = "MonsterConfig_149071_Desc|追逐太阳的猛犬，祂将被烈日灼伤。",
    ExistState = {
      149093,
      149123,
      80787,
      22074
    },
    StateLayers = "1,1,CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      149077,
      149081,
      149078
    },
    CycleSkillList1 = {
      149077,
      149081,
      149078
    },
    AnimationID = 149072,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0601_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 1.31,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0,
    MonsterProportion = 0.4
  },
  [149107] = {
    ID = 149107,
    CnID = "怪物@提灯犬小群A",
    BaseSortID = 599,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90646,
      84291
    },
    MonsterName = "MonsterConfig_149107_MonsterName|斯库尔猎群",
    Desc = "MonsterConfig_149107_Desc|蛮荒的身体中流淌着巨人的血。在太阳被吞噬之时，众神迎来祂们的黄昏。",
    ExistState = {
      149093,
      149123,
      149126,
      80787,
      22074
    },
    StateLayers = "1,1,2,CmdCaster.max_hp*0.15,1",
    InitSkillList = {
      149078,
      149077,
      149081
    },
    CycleSkillList1 = {
      149078,
      149077,
      149081
    },
    AnimationID = 149072,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0601_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.35,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [149098] = {
    ID = 149098,
    CnID = "怪物@提灯犬小群B",
    BaseSortID = 600,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90646,
      84291
    },
    MonsterName = "MonsterConfig_149098_MonsterName|斯库尔猎群",
    Desc = "MonsterConfig_149098_Desc|蛮荒的身体中流淌着巨人的血。在太阳被吞噬之时，众神迎来祂们的黄昏。",
    ExistState = {
      149093,
      149123,
      149126,
      80787,
      22074
    },
    StateLayers = "1,1,2,CmdCaster.max_hp*0.15,1",
    InitSkillList = {
      149077,
      149081,
      149078
    },
    CycleSkillList1 = {
      149077,
      149081,
      149078
    },
    AnimationID = 149072,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0601_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.44,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [149104] = {
    ID = 149104,
    CnID = "怪物@提灯犬小群召唤A",
    BaseSortID = 601,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90646,
      84291
    },
    MonsterName = "MonsterConfig_149104_MonsterName|斯库尔猎群",
    Desc = "MonsterConfig_149104_Desc|蛮荒的身体中流淌着巨人的血。在太阳被吞噬之时，众神迎来祂们的黄昏。",
    ExistState = {
      149093,
      149123,
      80787,
      22074
    },
    StateLayers = "1,1,CmdCaster.max_hp*0.15,1",
    InitSkillList = {
      149078,
      149077,
      149081
    },
    CycleSkillList1 = {
      149078,
      149077,
      149081
    },
    AnimationID = 149072,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0601_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.35,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [149101] = {
    ID = 149101,
    CnID = "怪物@提灯犬小群召唤B",
    BaseSortID = 602,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90646,
      84291
    },
    MonsterName = "MonsterConfig_149101_MonsterName|斯库尔猎群",
    Desc = "MonsterConfig_149101_Desc|蛮荒的身体中流淌着巨人的血。在太阳被吞噬之时，众神迎来祂们的黄昏。",
    ExistState = {
      149093,
      149123,
      80787,
      22074
    },
    StateLayers = "1,1,CmdCaster.max_hp*0.15,1",
    InitSkillList = {
      149077,
      149081,
      149078
    },
    CycleSkillList1 = {
      149077,
      149081,
      149078
    },
    AnimationID = 149072,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0601_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.44,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [149068] = {
    ID = 149068,
    CnID = "怪物@冰雪提灯犬小A",
    BaseSortID = 603,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90646,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_149068_MonsterName|哈提",
    Desc = "MonsterConfig_149068_Desc|追逐月亮的猛犬，祂将被冰雪封冻。",
    ExistState = {
      149127,
      149124,
      80787,
      22074
    },
    StateLayers = "1,1,CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      149079,
      149080,
      149082
    },
    CycleSkillList1 = {
      149079,
      149080,
      149082
    },
    AnimationID = 149073,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0601_BT.png",
    Scale = 0.95,
    MonsterHpPercent = 1.08,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.4
  },
  [149070] = {
    ID = 149070,
    CnID = "怪物@冰雪提灯犬小B",
    BaseSortID = 604,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90646,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_149070_MonsterName|哈提",
    Desc = "MonsterConfig_149070_Desc|追逐月亮的猛犬，祂将被冰雪封冻。",
    ExistState = {
      149127,
      149124,
      80787,
      22074
    },
    StateLayers = "1,1,CmdCaster.max_hp*0.05,1",
    InitSkillList = {
      149080,
      149082,
      149079
    },
    CycleSkillList1 = {
      149080,
      149082,
      149079
    },
    AnimationID = 149073,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0601_BT.png",
    Scale = 0.95,
    MonsterHpPercent = 1.31,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0,
    MonsterProportion = 0.4
  },
  [149116] = {
    ID = 149116,
    CnID = "怪物@冰雪提灯犬小群A",
    BaseSortID = 605,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90646,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_149116_MonsterName|哈提猎群",
    Desc = "MonsterConfig_149116_Desc|蛮荒的身体中流淌着神明的血。在月亮被吞噬之时，众神迎来祂们的黄昏。",
    ExistState = {
      149127,
      149124,
      149122,
      80787,
      22074
    },
    StateLayers = "1,1,2,CmdCaster.max_hp*0.15,1",
    InitSkillList = {
      149079,
      149080,
      149082
    },
    CycleSkillList1 = {
      149079,
      149080,
      149082
    },
    AnimationID = 149073,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0601_BT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.35,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [149117] = {
    ID = 149117,
    CnID = "怪物@冰雪提灯犬小群B",
    BaseSortID = 606,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90646,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_149117_MonsterName|哈提猎群",
    Desc = "MonsterConfig_149117_Desc|蛮荒的身体中流淌着神明的血。在月亮被吞噬之时，众神迎来祂们的黄昏。",
    ExistState = {
      149127,
      149124,
      149122,
      80787,
      22074
    },
    StateLayers = "1,1,2,CmdCaster.max_hp*0.15,1",
    InitSkillList = {
      149080,
      149082,
      149079
    },
    CycleSkillList1 = {
      149080,
      149082,
      149079
    },
    AnimationID = 149073,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0601_BT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.44,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [149114] = {
    ID = 149114,
    CnID = "怪物@冰雪提灯犬小群召唤A",
    BaseSortID = 607,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90646,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_149114_MonsterName|哈提猎群",
    Desc = "MonsterConfig_149114_Desc|蛮荒的身体中流淌着神明的血。在月亮被吞噬之时，众神迎来祂们的黄昏。",
    ExistState = {
      149127,
      149124,
      80787,
      22074
    },
    StateLayers = "1,1,CmdCaster.max_hp*0.15,1",
    InitSkillList = {
      149079,
      149080,
      149082
    },
    CycleSkillList1 = {
      149079,
      149080,
      149082
    },
    AnimationID = 149073,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0601_BT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.35,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [149100] = {
    ID = 149100,
    CnID = "怪物@冰雪提灯犬小群召唤B",
    BaseSortID = 608,
    BattleTag = "MonsterGrade1",
    MonsterTag = {
      90640,
      90646,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_149100_MonsterName|哈提猎群",
    Desc = "MonsterConfig_149100_Desc|蛮荒的身体中流淌着神明的血。在月亮被吞噬之时，众神迎来祂们的黄昏。",
    ExistState = {
      149127,
      149124,
      80787,
      22074
    },
    StateLayers = "1,1,CmdCaster.max_hp*0.15,1",
    InitSkillList = {
      149080,
      149082,
      149079
    },
    CycleSkillList1 = {
      149080,
      149082,
      149079
    },
    AnimationID = 149073,
    MonsterClass = "Common",
    BodySize = "Mini",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0601_BT.png",
    Scale = 0.95,
    MonsterHpPercent = 0.44,
    MonsterAtkPercent = 0.95,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [149109] = {
    ID = 149109,
    CnID = "怪物@提灯祈祷者A",
    BaseSortID = 609,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 90646},
    MonsterName = "MonsterConfig_149109_MonsterName|赤心圣徒",
    Desc = "MonsterConfig_149109_Desc|她的赤心献予无心者。 挚爱世人者，永失对现世苦难的知觉。",
    ExistState = {
      149143,
      80787,
      22074
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1",
    StateParams = "1,1,1,1",
    InitSkillList = {
      149129,
      149131,
      149132,
      149130
    },
    CycleSkillList1 = {
      149129,
      149131,
      149132,
      149130
    },
    AnimationID = 149076,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0602_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 1.6,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [149102] = {
    ID = 149102,
    CnID = "怪物@提灯祈祷者B",
    BaseSortID = 610,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90642, 90646},
    MonsterName = "MonsterConfig_149102_MonsterName|赤心圣徒",
    Desc = "MonsterConfig_149102_Desc|她的赤心献予无心者。 挚爱世人者，永失对现世苦难的知觉。",
    ExistState = {
      149143,
      80787,
      22074
    },
    StateLayers = "1,CmdCaster.max_hp*0.05,1",
    StateParams = "1,1,1,1",
    InitSkillList = {
      149131,
      149132,
      149130,
      149129
    },
    CycleSkillList1 = {
      149131,
      149132,
      149130,
      149129
    },
    AnimationID = 149076,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0602_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 1.36,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.6
  },
  [149103] = {
    ID = 149103,
    CnID = "怪物@提灯祈祷者精英",
    BaseSortID = 611,
    BattleTag = "MonsterGrade2",
    MonsterTag = {90641, 90646},
    MonsterName = "MonsterConfig_149103_MonsterName|怜爱世人者",
    Desc = "MonsterConfig_149103_Desc|神以她之手怜爱世人。神以她之手埋葬世人。",
    ExistState = {149143, 80787},
    StateLayers = "1,CmdCaster.max_hp*0.04",
    StateParams = "1,1,1,2",
    InitSkillList = {
      149129,
      149131,
      149177,
      149130
    },
    CycleSkillList1 = {
      149129,
      149131,
      149177,
      149130
    },
    AnimationID = 149076,
    MonsterClass = "Elite",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0602_AT.png",
    Scale = 1.15,
    MonsterHpPercent = 1.42,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [149106] = {
    ID = 149106,
    CnID = "怪物@提灯祈祷者首领",
    BaseSortID = 612,
    BattleTag = "MonsterGrade2",
    MonsterTag = {84277, 90646},
    MonsterName = "MonsterConfig_149106_MonsterName|无瑕的怜心",
    Desc = "MonsterConfig_149106_Desc|不必害怕，信徒。一切现世的苦难，都是通往神国的台阶。",
    ExistState = {149143, 80787},
    StateLayers = "1,CmdCaster.max_hp*0.03",
    StateParams = "1,2,1,3",
    InitSkillList = {
      149129,
      149131,
      149178,
      149130,
      149176
    },
    CycleSkillList1 = {
      149129,
      149131,
      149178,
      149130
    },
    AnimationID = 149076,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0602_AT.png",
    Scale = 1.35,
    MonsterHpPercent = 1.08,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1
  },
  [149111] = {
    ID = 149111,
    CnID = "怪物@霜雪温迪戈A",
    BaseSortID = 613,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_149111_MonsterName|雪域温迪戈",
    Desc = "MonsterConfig_149111_Desc|无论如何坚持呼唤，也无法寻回旧日温情。 它带来的仅是恐惧。",
    ExistState = {
      80787,
      149227,
      149229,
      22074
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1",
    StateParams = 100,
    InitSkillList = {
      149152,
      149150,
      149151,
      149153
    },
    CycleSkillList1 = {
      149152,
      149150,
      149151,
      149153
    },
    AnimationID = 149074,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0603_BT.png",
    Scale = 0.95,
    MonsterHpPercent = 1.96,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0,
    MonsterProportion = 0.95
  },
  [149096] = {
    ID = 149096,
    CnID = "怪物@霜雪温迪戈B",
    BaseSortID = 614,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_149096_MonsterName|雪域温迪戈",
    Desc = "MonsterConfig_149096_Desc|无论如何坚持呼唤，也无法寻回旧日温情。 它带来的仅是恐惧。",
    ExistState = {
      80787,
      149227,
      149229,
      22074
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1",
    StateParams = 100,
    InitSkillList = {
      149151,
      149153,
      149152,
      149150
    },
    CycleSkillList1 = {
      149151,
      149153,
      149152,
      149150
    },
    AnimationID = 149074,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0603_BT.png",
    Scale = 0.95,
    MonsterHpPercent = 1.61,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.95
  },
  [149110] = {
    ID = 149110,
    CnID = "怪物@霜雪温迪戈群A精英",
    BaseSortID = 615,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_149110_MonsterName|亡雪者集群",
    Desc = "MonsterConfig_149110_Desc|刺穿同伴的心脏，撕咬同伴的喉咙，啃食同伴的血肉。 然后，去吞噬你们看到的一切。",
    ExistState = {
      80787,
      149227,
      149229,
      149265
    },
    StateLayers = "CmdCaster.max_hp*0.15,1,1,2",
    StateParams = 125,
    InitSkillList = {
      149277,
      149283,
      149289,
      149153
    },
    CycleSkillList1 = {
      149277,
      149283,
      149289,
      149153
    },
    AnimationID = 149074,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0603_BT.png",
    Scale = 1.05,
    MonsterHpPercent = 0.65,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [149099] = {
    ID = 149099,
    CnID = "怪物@霜雪温迪戈群B精英",
    BaseSortID = 616,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_149099_MonsterName|亡雪者集群",
    Desc = "MonsterConfig_149099_Desc|刺穿同伴的心脏，撕咬同伴的喉咙，啃食同伴的血肉。 然后，去吞噬你们看到的一切。",
    ExistState = {
      80787,
      149227,
      149229,
      149265
    },
    StateLayers = "CmdCaster.max_hp*0.15,1,1,2",
    StateParams = 125,
    InitSkillList = {
      149289,
      149153,
      149277,
      149283
    },
    CycleSkillList1 = {
      149289,
      149153,
      149277,
      149283
    },
    AnimationID = 149074,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0603_BT.png",
    Scale = 1.05,
    MonsterHpPercent = 0.65,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [149115] = {
    ID = 149115,
    CnID = "怪物@霜雪温迪戈首领",
    BaseSortID = 617,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_149115_MonsterName|永冬之主",
    Desc = "MonsterConfig_149115_Desc|向所有的生命与希望告别——永恒的冬天，已降临你身前。",
    ExistState = {
      80787,
      149227,
      149229,
      149268
    },
    StateLayers = "CmdCaster.max_hp*0.03,1,1,2",
    StateParams = 150,
    InitSkillList = {
      149278,
      149282,
      149287,
      149278,
      149282,
      149280,
      149278,
      149282,
      149287,
      149280
    },
    CycleSkillList1 = {
      149278,
      149282,
      149287,
      149278,
      149282,
      149280,
      149278,
      149282,
      149287,
      149280
    },
    AnimationID = 149074,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0603_BT.png",
    Scale = 1.5,
    MonsterHpPercent = 1.8,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0,
    MonsterProportion = 0.9
  },
  [149097] = {
    ID = 149097,
    CnID = "怪物@提灯温迪戈A",
    BaseSortID = 618,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_149097_MonsterName|燃灯温迪戈",
    Desc = "MonsterConfig_149097_Desc|无论如何坚持追索，也无法点燃旧日余烬。 它进奉的仅是谎言。",
    ExistState = {
      80787,
      149232,
      149234,
      22074
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1",
    StateParams = 100,
    InitSkillList = {
      149210,
      149209,
      149208,
      149153
    },
    CycleSkillList1 = {
      149210,
      149209,
      149208,
      149153
    },
    AnimationID = 149075,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0603_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 1.96,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0,
    MonsterProportion = 0.95
  },
  [149112] = {
    ID = 149112,
    CnID = "怪物@提灯温迪戈B",
    BaseSortID = 619,
    BattleTag = "MonsterGrade2",
    MonsterTag = {
      90642,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_149112_MonsterName|燃灯温迪戈",
    Desc = "MonsterConfig_149112_Desc|无论如何坚持追索，也无法点燃旧日余烬。 它进奉的仅是谎言。",
    ExistState = {
      80787,
      149232,
      149234,
      22074
    },
    StateLayers = "CmdCaster.max_hp*0.05,1,1,1",
    StateParams = 100,
    InitSkillList = {
      149208,
      149153,
      149210,
      149209
    },
    CycleSkillList1 = {
      149208,
      149153,
      149210,
      149209
    },
    AnimationID = 149075,
    MonsterClass = "Common",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0603_AT.png",
    Scale = 0.95,
    MonsterHpPercent = 1.61,
    MonsterAtkPercent = 1.05,
    MonsterDefPercent = 0,
    MonsterProportion = 0.95
  },
  [149105] = {
    ID = 149105,
    CnID = "怪物@提灯温迪戈群A精英",
    BaseSortID = 620,
    BattleTag = "Elite",
    MonsterTag = {
      90642,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_149105_MonsterName|噬灯者集群",
    Desc = "MonsterConfig_149105_Desc|献上心脏作灯芯，献上喉咙作灯座，献上血肉作灯油。 啊，虔诚的旅人，温迪戈们将以此灯为你祈祷。",
    ExistState = {
      80787,
      149232,
      149234,
      149270
    },
    StateLayers = "CmdCaster.max_hp*0.15,1,1,2",
    StateParams = 125,
    InitSkillList = {
      149281,
      149286,
      149284,
      149153
    },
    CycleSkillList1 = {
      149281,
      149286,
      149284,
      149153
    },
    AnimationID = 149075,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0603_AT.png",
    Scale = 1.05,
    MonsterHpPercent = 0.65,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [149113] = {
    ID = 149113,
    CnID = "怪物@提灯温迪戈群B精英",
    BaseSortID = 621,
    BattleTag = "Elite",
    MonsterTag = {
      90641,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_149113_MonsterName|噬灯者集群",
    Desc = "MonsterConfig_149113_Desc|献上心脏作灯芯，献上喉咙作灯座，献上血肉作灯油。 啊，虔诚的旅人，温迪戈们将以此灯为你祈祷。",
    ExistState = {
      80787,
      149232,
      149234,
      149270
    },
    StateLayers = "CmdCaster.max_hp*0.15,1,1,2",
    StateParams = 125,
    InitSkillList = {
      149284,
      149153,
      149281,
      149286
    },
    CycleSkillList1 = {
      149284,
      149153,
      149281,
      149286
    },
    AnimationID = 149075,
    MonsterClass = "Elite",
    BodySize = "Middle",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0603_AT.png",
    Scale = 1.05,
    MonsterHpPercent = 0.65,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0,
    MonsterProportion = 0.5
  },
  [149108] = {
    ID = 149108,
    CnID = "怪物@提灯温迪戈首领",
    BaseSortID = 622,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84291,
      84284
    },
    MonsterName = "MonsterConfig_149108_MonsterName|终夜之主",
    Desc = "MonsterConfig_149108_Desc|一切的灯火都照不出黎明——无尽的终夜，已降临你身前。",
    ExistState = {
      80787,
      149232,
      149234,
      149269
    },
    StateLayers = "CmdCaster.max_hp*0.03,1,1,2",
    StateParams = 150,
    InitSkillList = {
      149288,
      149285,
      149279,
      149288,
      149285,
      149280,
      149288,
      149285,
      149279,
      149280
    },
    CycleSkillList1 = {
      149288,
      149285,
      149279,
      149288,
      149285,
      149280,
      149288,
      149285,
      149279,
      149280
    },
    AnimationID = 149075,
    MonsterClass = "Boss",
    BodySize = "Big",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2C0603_AT.png",
    Scale = 1.5,
    MonsterHpPercent = 1.8,
    MonsterAtkPercent = 0.9,
    MonsterDefPercent = 0,
    MonsterProportion = 0.9
  },
  [149840] = {
    ID = 149840,
    CnID = "怪物@巨噬蠕虫动特版",
    BaseSortID = 623,
    BattleTag = "Boss",
    MonsterTag = {
      84277,
      84303,
      84294
    },
    MonsterName = "MonsterConfig_149840_MonsterName|「巨噬蠕虫」",
    InitSkillList = {
      149843,
      149842,
      149847
    },
    CycleSkillList1 = {
      149846,
      149844,
      149845
    },
    CycleSkillList2 = {
      149846,
      149844,
      149845
    },
    AnimationID = 149841,
    MonsterClass = "Boss",
    BodySize = "Huge",
    MiniIcon = "Portraits/Minihead/Portrait_Small_Monster_S2B0006_AT.png",
    Scale = 1,
    MonsterHpPercent = 0.3,
    MonsterAtkPercent = 1,
    MonsterDefPercent = 0,
    MonsterProportion = 1,
    MonsterHpNum = 1
  }
})
return MonsterConfig
