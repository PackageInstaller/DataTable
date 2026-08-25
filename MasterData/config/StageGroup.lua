local System = require("System.System")
local readonly = System.readonly
local StageGroup = readonly({
  [15935] = {
    ID = 15935,
    CnID = "关卡组@序章",
    BaseSortID = 1,
    Type = 8,
    Name = "StageGroup_15935_Name|入学日",
    Desc = "StageGroup_15935_Desc|启程日，钥冢细雨霏霏。在这里埋下你的墓碑、姓名和誓言。",
    TypeText = "StageGroup_15935_TypeText|调查",
    Sequence = 0,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0
  },
  [15927] = {
    ID = 15927,
    CnID = "关卡组@第一章",
    BaseSortID = 2,
    Type = 1,
    Name = "StageGroup_15927_Name|东区秘事",
    Desc = "StageGroup_15927_Desc|古老的伦蒂尼恩夜雾弥漫，在昏黄路灯无法照亮的角落，黑暗正伺机而动。",
    HardMode = {15917, 15896},
    TypeText = "StageGroup_15927_TypeText|调查",
    Sequence = 1,
    Backgrand = "Scenebg/SScene_LondonDaytime.png",
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_01.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter1"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      6,
      14163,
      12,
      14356,
      18,
      14447,
      24,
      14426
    }
  },
  [15901] = {
    ID = 15901,
    CnID = "关卡组@第二章",
    BaseSortID = 3,
    Type = 1,
    Name = "StageGroup_15901_Name|以蜡像之名",
    Desc = "StageGroup_15901_Desc|一家能免费参观的蜡像馆。\n它只在午夜张开黑洞洞的大门，迎接那些不怀好意的访客……",
    HardMode = {15895, 15918},
    TypeText = "StageGroup_15901_TypeText|调查",
    Sequence = 2,
    Backgrand = "Scenebg/SScene_WaxRoom.png",
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_02.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter2"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14340,
      18,
      14385,
      27,
      14468,
      36,
      14399
    }
  },
  [15922] = {
    ID = 15922,
    CnID = "关卡组@第三章",
    BaseSortID = 4,
    Type = 1,
    Name = "StageGroup_15922_Name|谨防恶犬",
    Desc = "StageGroup_15922_Desc|欢迎来到热情好客的拉伊小镇——冬夜的犬吠会让每位来访者宾至如归。",
    HardMode = {15906, 15913},
    TypeText = "StageGroup_15922_TypeText|调查",
    Sequence = 3,
    Backgrand = "Scenebg/SScene_TownST_Night.png",
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_03.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter3"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14210,
      18,
      14358,
      24,
      14494,
      30,
      14425
    }
  },
  [15882] = {
    ID = 15882,
    CnID = "关卡组@第四章",
    BaseSortID = 5,
    Type = 1,
    Name = "StageGroup_15882_Name|于无声处",
    Desc = "StageGroup_15882_Desc|与“歇斯底里”的刻板印象相悖，此处是静止的无声世界。",
    HardMode = {15921, 15925},
    TypeText = "StageGroup_15882_TypeText|调查",
    Sequence = 4,
    Backgrand = "Scenebg/SScene_SnowWind.png",
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_04.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter4"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14208,
      18,
      14362,
      27,
      14473,
      36,
      14409
    }
  },
  [15907] = {
    ID = 15907,
    CnID = "关卡组@第五章",
    BaseSortID = 6,
    Type = 1,
    Name = "StageGroup_15907_Name|风暴之眼",
    Desc = "StageGroup_15907_Desc|陌生的船只，陌生的少女，陌生的敌人。飘摇于大海之中，等待着调查员们的，是一场与命运的抗争……",
    HardMode = {15905, 15919},
    TypeText = "StageGroup_15907_TypeText|调查",
    Sequence = 5,
    Backgrand = "Scenebg/SScene_DeckIllusion.png",
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_05.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter5"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14189,
      18,
      14386,
      24,
      14466,
      30,
      14393
    }
  },
  [15890] = {
    ID = 15890,
    CnID = "关卡组@第六章",
    BaseSortID = 7,
    Type = 1,
    Name = "StageGroup_15890_Name|倒错的群星",
    Desc = "StageGroup_15890_Desc|群星落入深海，在海底闪烁着无人能解读的愿望。",
    HardMode = {15946, 15920},
    TypeText = "StageGroup_15890_TypeText|调查",
    Sequence = 6,
    Backgrand = "Scenebg/SScene_Dock.png",
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_06.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter6"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14497,
      15,
      14296,
      24,
      14219,
      30,
      14289
    }
  },
  [48870] = {
    ID = 48870,
    CnID = "关卡组@第七章",
    BaseSortID = 8,
    Type = 1,
    Name = "StageGroup_48870_Name|欲河",
    Desc = "StageGroup_48870_Desc|勒姆瓦希，卡达斯中部地带的黄沙之国。在被当地人称为“圣河”的母亲河哺育下，名为亚兰的文明正在暗中滋长与消亡……",
    HardMode = {48869, 48868},
    TypeText = "StageGroup_48870_TypeText|调查",
    Sequence = 7,
    Backgrand = "Scenebg/SScene_Dock.png",
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_07.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter7"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      48919,
      18,
      48918,
      27,
      48917,
      36,
      48916
    }
  },
  [58900] = {
    ID = 58900,
    CnID = "关卡组@第八章",
    BaseSortID = 9,
    Type = 1,
    Name = "StageGroup_58900_Name|终末交响曲",
    Desc = "StageGroup_58900_Desc|入场。静坐。等待。渴求。\n指挥棒轻轻扬起。准备好，聆听这宇宙最深邃的隐秘了吗？",
    HardMode = {58906, 58904},
    TypeText = "StageGroup_58900_TypeText|调查",
    Sequence = 8,
    Backgrand = "Scenebg/SScene_Dock.png",
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_08.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter8"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      59084,
      15,
      59083,
      24,
      59082,
      30,
      59081
    },
    StageDisplayDate = 1725843600
  },
  [67786] = {
    ID = 67786,
    CnID = "关卡组@第九章",
    BaseSortID = 10,
    Type = 1,
    Name = "StageGroup_67786_Name|长梦尽时",
    Desc = "StageGroup_67786_Desc|祂做了一场漫长的梦。\n祂梦见神与星辰，梦见尘埃衍化文明，文明化为尘埃。\n祂梦见恨与爱，梦见欢愉与恐惧。 \n祂从睡梦中惊醒。梦境中的一切，从未存在。",
    HardMode = {67785, 67787},
    TypeText = "StageGroup_67786_TypeText|调查",
    Sequence = 9,
    Backgrand = "Scenebg/SScene_Dock.png",
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_09.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter9"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      3,
      66020,
      6,
      66019,
      9,
      66022,
      12,
      66021
    },
    StageDisplayDate = 1731891600
  },
  [15917] = {
    ID = 15917,
    CnID = "关卡组@困难第一章",
    BaseSortID = 11,
    Type = 7,
    Name = "StageGroup_15917_Name|东区秘事",
    Desc = "StageGroup_15917_Desc|古老的伦蒂尼恩夜雾弥漫，在昏黄路灯无法照亮的角落，黑暗正伺机而动。",
    TypeText = "StageGroup_15917_TypeText|调查困难",
    Sequence = 1,
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_01.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter1"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      6,
      14177,
      12,
      14412,
      18,
      14176,
      24,
      14264
    }
  },
  [15895] = {
    ID = 15895,
    CnID = "关卡组@困难第二章",
    BaseSortID = 12,
    Type = 7,
    Name = "StageGroup_15895_Name|以蜡像之名",
    Desc = "StageGroup_15895_Desc|一家能免费参观的蜡像馆。\n它只在午夜张开黑洞洞的大门，迎接那些不怀好意的访客……",
    TypeText = "StageGroup_15895_TypeText|调查困难",
    Sequence = 2,
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_02.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter2"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      27,
      14176,
      33,
      14264
    }
  },
  [15906] = {
    ID = 15906,
    CnID = "关卡组@困难第三章",
    BaseSortID = 13,
    Type = 7,
    Name = "StageGroup_15906_Name|谨防恶犬",
    Desc = "StageGroup_15906_Desc|欢迎来到热情好客的拉伊小镇——冬夜的犬吠会让每位来访者宾至如归。",
    TypeText = "StageGroup_15906_TypeText|调查困难",
    Sequence = 3,
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_03.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter3"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      24,
      14176,
      30,
      14264
    }
  },
  [15921] = {
    ID = 15921,
    CnID = "关卡组@困难第四章",
    BaseSortID = 14,
    Type = 7,
    Name = "StageGroup_15921_Name|于无声处",
    Desc = "StageGroup_15921_Desc|与“歇斯底里”的刻板印象相悖，此处是静止的无声世界。",
    TypeText = "StageGroup_15921_TypeText|调查困难",
    Sequence = 4,
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_04.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter4"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      27,
      14176,
      36,
      14264
    }
  },
  [15905] = {
    ID = 15905,
    CnID = "关卡组@困难第五章",
    BaseSortID = 15,
    Type = 7,
    Name = "StageGroup_15905_Name|风暴之眼",
    Desc = "StageGroup_15905_Desc|陌生的船只，陌生的少女，陌生的敌人。飘摇于大海之中，等待着调查员们的，是一场与命运的抗争……",
    TypeText = "StageGroup_15905_TypeText|调查困难",
    Sequence = 5,
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_05.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter5"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      24,
      14176,
      30,
      14264
    }
  },
  [15946] = {
    ID = 15946,
    CnID = "关卡组@困难第六章",
    BaseSortID = 16,
    Type = 7,
    Name = "StageGroup_15946_Name|倒错的群星",
    Desc = "StageGroup_15946_Desc|群星落入深海，在海底闪烁着无人能解读的愿望。",
    TypeText = "StageGroup_15946_TypeText|调查困难",
    Sequence = 6,
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_06.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter6"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      15,
      14412,
      24,
      14176,
      30,
      14264
    }
  },
  [48869] = {
    ID = 48869,
    CnID = "关卡组@困难第七章",
    BaseSortID = 17,
    Type = 7,
    Name = "StageGroup_48869_Name|欲河",
    Desc = "StageGroup_48869_Desc|勒姆瓦希，卡达斯中部地带的黄沙之国。在被当地人称为“圣河”的母亲河哺育下，名为亚兰的文明正在暗中滋长与消亡……",
    TypeText = "StageGroup_48869_TypeText|调查困难",
    Sequence = 7,
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_07.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter7"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      27,
      14176,
      36,
      14264
    }
  },
  [58906] = {
    ID = 58906,
    CnID = "关卡组@困难第八章",
    BaseSortID = 18,
    Type = 7,
    Name = "StageGroup_58906_Name|终末交响曲",
    Desc = "StageGroup_58906_Desc|入场。静坐。等待。渴求。\n指挥棒轻轻扬起。准备好，聆听这宇宙最深邃的隐秘了吗？",
    TypeText = "StageGroup_58906_TypeText|调查困难",
    Sequence = 8,
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_08.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter8"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      15,
      14412,
      24,
      14176,
      30,
      14264
    },
    StageDisplayDate = 1725843600
  },
  [67785] = {
    ID = 67785,
    CnID = "关卡组@困难第九章",
    BaseSortID = 19,
    Type = 7,
    Name = "StageGroup_67785_Name|长梦尽时",
    Desc = "StageGroup_67785_Desc|祂做了一场漫长的梦。\n祂梦见神与星辰，梦见尘埃衍化文明，文明化为尘埃。\n祂梦见恨与爱，梦见欢愉与恐惧。 \n祂从睡梦中惊醒。梦境中的一切，从未存在。",
    TypeText = "StageGroup_67785_TypeText|调查困难",
    Sequence = 9,
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_09.prefab",
    BattleBuff = {
      1,
      "ResonanceGroupChapter9"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      3,
      14177,
      6,
      14412,
      9,
      14176,
      12,
      14264
    },
    StageDisplayDate = 1731891600
  },
  [15896] = {
    ID = 15896,
    CnID = "关卡组@癫狂第一章",
    BaseSortID = 20,
    Type = 19,
    Name = "StageGroup_15896_Name|东区秘事(未完成)",
    Desc = "StageGroup_15896_Desc|古老的伦蒂尼恩夜雾弥漫，在昏黄路灯无法照亮的角落，黑暗正伺机而动。",
    TypeText = "StageGroup_15896_TypeText|调查癫狂",
    Sequence = 1,
    BattleBuff = {
      1,
      "ResonanceGroupChapter1"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      6,
      14177,
      12,
      14412,
      18,
      14176,
      24,
      14264
    }
  },
  [15918] = {
    ID = 15918,
    CnID = "关卡组@癫狂第二章",
    BaseSortID = 21,
    Type = 19,
    Name = "StageGroup_15918_Name|以蜡像之名(未完成)",
    Desc = "StageGroup_15918_Desc|一家能免费参观的蜡像馆。\n它只在午夜张开黑洞洞的大门，迎接那些不怀好意的访客……",
    TypeText = "StageGroup_15918_TypeText|调查癫狂",
    Sequence = 2,
    BattleBuff = {
      1,
      "ResonanceGroupChapter2"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      27,
      14176,
      33,
      14264
    }
  },
  [15913] = {
    ID = 15913,
    CnID = "关卡组@癫狂第三章",
    BaseSortID = 22,
    Type = 19,
    Name = "StageGroup_15913_Name|谨防恶犬(未完成)",
    Desc = "StageGroup_15913_Desc|欢迎来到热情好客的拉伊小镇——冬夜的犬吠会让每位来访者宾至如归。",
    TypeText = "StageGroup_15913_TypeText|调查癫狂",
    Sequence = 3,
    BattleBuff = {
      1,
      "ResonanceGroupChapter3"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      24,
      14176,
      30,
      14264
    }
  },
  [15925] = {
    ID = 15925,
    CnID = "关卡组@癫狂第四章",
    BaseSortID = 23,
    Type = 19,
    Name = "StageGroup_15925_Name|于无声处(未完成)",
    Desc = "StageGroup_15925_Desc|与“歇斯底里”的刻板印象相悖，此处是静止的无声世界。",
    TypeText = "StageGroup_15925_TypeText|调查癫狂",
    Sequence = 4,
    BattleBuff = {
      1,
      "ResonanceGroupChapter4"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      27,
      14176,
      36,
      14264
    }
  },
  [15919] = {
    ID = 15919,
    CnID = "关卡组@癫狂第五章",
    BaseSortID = 24,
    Type = 19,
    Name = "StageGroup_15919_Name|风暴之眼(未完成)",
    Desc = "StageGroup_15919_Desc|陌生的船只，陌生的少女，陌生的敌人。飘摇于大海之中，等待着调查员们的，是一场与命运的抗争……",
    TypeText = "StageGroup_15919_TypeText|调查癫狂",
    Sequence = 5,
    BattleBuff = {
      1,
      "ResonanceGroupChapter5"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      27,
      14176,
      36,
      14264
    }
  },
  [15920] = {
    ID = 15920,
    CnID = "关卡组@癫狂第六章",
    BaseSortID = 25,
    Type = 19,
    Name = "StageGroup_15920_Name|倒错的群星(未完成)",
    Desc = "StageGroup_15920_Desc|群星落入深海，在海底闪烁着无人能解读的愿望。",
    TypeText = "StageGroup_15920_TypeText|调查癫狂",
    Sequence = 6,
    BattleBuff = {
      1,
      "ResonanceGroupChapter6"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      24,
      14176,
      30,
      14264
    }
  },
  [48868] = {
    ID = 48868,
    CnID = "关卡组@癫狂第七章",
    BaseSortID = 26,
    Type = 19,
    Name = "StageGroup_48868_Name|欲河",
    Desc = "StageGroup_48868_Desc|勒姆瓦希，卡达斯中部地带的黄沙之国。在被当地人称为“圣河”的母亲河哺育下，名为亚兰的文明正在暗中滋长与消亡……",
    TypeText = "StageGroup_48868_TypeText|调查癫狂",
    Sequence = 7,
    BattleBuff = {
      1,
      "ResonanceGroupChapter7"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      27,
      14176,
      36,
      14264
    }
  },
  [58904] = {
    ID = 58904,
    CnID = "关卡组@癫狂第八章",
    BaseSortID = 27,
    Type = 19,
    Name = "StageGroup_58904_Name|终末交响曲",
    Desc = "StageGroup_58904_Desc|入场。静坐。等待。渴求。\n指挥棒轻轻扬起。准备好，聆听这宇宙最深邃的隐秘了吗？",
    TypeText = "StageGroup_58904_TypeText|调查癫狂",
    Sequence = 8,
    BattleBuff = {
      1,
      "ResonanceGroupChapter8"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      24,
      14176,
      30,
      14264
    },
    StageDisplayDate = 1725843600
  },
  [67787] = {
    ID = 67787,
    CnID = "关卡组@癫狂第九章",
    BaseSortID = 28,
    Type = 19,
    Name = "StageGroup_67787_Name|长梦尽时",
    Desc = "StageGroup_67787_Desc|祂做了一场漫长的梦。\n祂梦见神与星辰，梦见尘埃衍化文明，文明化为尘埃。\n祂梦见恨与爱，梦见欢愉与恐惧。 \n祂从睡梦中惊醒。梦境中的一切，从未存在。",
    TypeText = "StageGroup_67787_TypeText|调查癫狂",
    Sequence = 9,
    BattleBuff = {
      1,
      "ResonanceGroupChapter9"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageGroupDrop = {
      3,
      14177,
      6,
      14412,
      9,
      14176,
      12,
      14264
    },
    StageDisplayDate = 1731891600
  },
  [70939] = {
    ID = 70939,
    CnID = "关卡组@星辰篇普通第一章",
    BaseSortID = 29,
    Type = 1,
    Name = "StageGroup_70939_Name|重临雾都",
    Desc = "StageGroup_70939_Desc|被灰雾埋葬的旧日废都\n跨越无光的星辰，与无上意志的碎念在毁损维度重逢",
    HardMode = {72075},
    TypeText = "StageGroup_70939_TypeText|调查",
    Sequence = 1,
    Backgrand = "Scenebg/SScene_Dock.png",
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_10.prefab",
    BattleBuff = {
      1,
      "ResonanceGroup2Chapter1"
    },
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      24,
      14176,
      30,
      14264
    }
  },
  [70938] = {
    ID = 70938,
    CnID = "关卡组@星辰篇普通第二章",
    BaseSortID = 30,
    Type = 1,
    Name = "StageGroup_70938_Name|蜕变",
    Desc = "StageGroup_70938_Desc|群体潜意识构筑的疗养院\n在这里，躯壳的消解并非终点，心灵的死亡才是终结。\n踏入者啊，请保持理智，人性是你穿行心灵迷宫的唯一依仗。",
    HardMode = {72074},
    TypeText = "StageGroup_70938_TypeText|调查",
    Sequence = 2,
    Backgrand = "Scenebg/SScene_Dock.png",
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_11.prefab",
    BattleBuff = {
      1,
      "ResonanceGroup2Chapter2"
    },
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      27,
      14176,
      36,
      14264
    }
  },
  [70940] = {
    ID = 70940,
    CnID = "关卡组@星辰篇普通第三章",
    BaseSortID = 31,
    Type = 1,
    Name = "StageGroup_70940_Name|餍飨",
    Desc = "StageGroup_70940_Desc|欢庆吧，我的朋友♪\n月光下的骸骨悄然绽放，一位挚爱被送上餐盘♪\n所有的宾客都已到来！唱呀，跳呀♪\n我们从不为亡灵祈祷，我们从不为尸首哀悼♪\n她将记忆交予了我，她将眼泪交予了我♪\n让我们咽下她的魂灵与腐肉♪\n在死亡的盛宴中，我们再度重圆♪",
    HardMode = {72073},
    TypeText = "StageGroup_70940_TypeText|调查",
    Sequence = 3,
    Backgrand = "Scenebg/SScene_Dock.png",
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_12.prefab",
    BattleBuff = {
      1,
      "ResonanceGroup2Chapter3"
    },
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      24,
      14176,
      30,
      14264
    }
  },
  [118158] = {
    ID = 118158,
    CnID = "关卡组@星辰篇普通第四章",
    BaseSortID = 32,
    Type = 1,
    Name = "StageGroup_118158_Name|乐园",
    Desc = "StageGroup_118158_Desc|帕拉黛斯号，蹈海者教会巡航无际汪洋的海上乐园。只要你于此献上愿望，渴求的幸福便永无终结。",
    HardMode = {118157},
    TypeText = "StageGroup_118158_TypeText|调查",
    Sequence = 4,
    Backgrand = "Scenebg/SScene_Dock.png",
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_13.prefab",
    BattleBuff = {
      1,
      "ResonanceGroup2Chapter4"
    },
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      24,
      14176,
      30,
      14264
    },
    StageDisplayDate = 1763946000
  },
  [125684] = {
    ID = 125684,
    CnID = "关卡组@星辰篇普通第五章",
    BaseSortID = 33,
    Type = 1,
    Name = "StageGroup_125684_Name|织命剧场",
    Desc = "StageGroup_125684_Desc|吱呀——吱呀——命运的女神转动她的纺机。\n吱呀——吱呀——命运的丝线在她手中汇集。\n木偶们排队入场，踏入命运的巨网。\n它们跳舞。它们欢唱。吱呀——吱呀——\n它们与巨网一同死去，悄无声息。",
    HardMode = {125685},
    TypeText = "StageGroup_125684_TypeText|调查",
    Sequence = 5,
    Backgrand = "Scenebg/SScene_Dock.png",
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_14.prefab",
    BattleBuff = {
      1,
      "ResonanceGroup2Chapter5"
    },
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      27,
      14176,
      33,
      14264
    },
    StageDisplayDate = 1776646800
  },
  [146257] = {
    ID = 146257,
    CnID = "关卡组@星辰篇普通第六章",
    BaseSortID = 34,
    Type = 1,
    Name = "StageGroup_146257_Name|山宴",
    Desc = "StageGroup_146257_Desc|群山矗立于世界尽头。\n终年封冻的连绵冰雪之上，古老的饥饿正从漫长的沉眠中苏醒。\n山咧开血盆大口，绽出低沉而讥嘲的笑。\n耐心等待吧——祈愿者已在赴宴的路上。",
    HardMode = {146256},
    TypeText = "StageGroup_146257_TypeText|调查",
    Sequence = 6,
    Backgrand = "Scenebg/SScene_Dock.png",
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_15.prefab",
    BattleBuff = {
      1,
      "ResonanceGroup2Chapter6"
    },
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      24,
      14176,
      30,
      14264
    },
    StageDisplayDate = 1787533200,
    BestExperienceCondition = {89731, 99730},
    PromptNumber = "BestExperienceTips_MainStoryS1_6"
  },
  [72075] = {
    ID = 72075,
    CnID = "关卡组@星辰篇困难第一章",
    BaseSortID = 35,
    Type = 7,
    Name = "StageGroup_72075_Name|重临雾都",
    Desc = "StageGroup_72075_Desc|被灰雾埋葬的旧日废都\n跨越无光的星辰，与无上意志的碎念在毁损维度重逢",
    TypeText = "StageGroup_72075_TypeText|调查困难",
    Sequence = 1,
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_10.prefab",
    BattleBuff = {
      1,
      "ResonanceGroup2Chapter1"
    },
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      24,
      14176,
      30,
      14264
    }
  },
  [72074] = {
    ID = 72074,
    CnID = "关卡组@星辰篇困难第二章",
    BaseSortID = 36,
    Type = 7,
    Name = "StageGroup_72074_Name|蜕变",
    Desc = "StageGroup_72074_Desc|群体潜意识构筑的疗养院\n在这里，躯壳的消解并非终点，心灵的死亡才是终结。\n踏入者啊，请保持理智，人性是你穿行心灵迷宫的唯一依仗。",
    TypeText = "StageGroup_72074_TypeText|调查困难",
    Sequence = 2,
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_11.prefab",
    BattleBuff = {
      1,
      "ResonanceGroup2Chapter2"
    },
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      27,
      14176,
      36,
      14264
    }
  },
  [72073] = {
    ID = 72073,
    CnID = "关卡组@星辰篇困难第三章",
    BaseSortID = 37,
    Type = 7,
    Name = "StageGroup_72073_Name|餍飨",
    Desc = "StageGroup_72073_Desc|欢庆吧，我的朋友♪\n月光下的骸骨悄然绽放，一位挚爱被送上餐盘♪\n所有的宾客都已到来！唱呀，跳呀♪\n我们从不为亡灵祈祷，我们从不为尸首哀悼♪\n她将记忆交予了我，她将眼泪交予了我♪\n让我们咽下她的魂灵与腐肉♪\n在死亡的盛宴中，我们再度重圆♪",
    TypeText = "StageGroup_72073_TypeText|调查困难",
    Sequence = 3,
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_12.prefab",
    BattleBuff = {
      1,
      "ResonanceGroup2Chapter3"
    },
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      24,
      14176,
      30,
      14264
    }
  },
  [118157] = {
    ID = 118157,
    CnID = "关卡组@星辰篇困难第四章",
    BaseSortID = 38,
    Type = 7,
    Name = "StageGroup_118157_Name|乐园",
    Desc = "StageGroup_118157_Desc|帕拉黛斯号，蹈海者教会巡航无际汪洋的海上乐园。只要你于此献上愿望，渴求的幸福便永无终结。",
    TypeText = "StageGroup_118157_TypeText|调查困难",
    Sequence = 4,
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_13.prefab",
    BattleBuff = {
      1,
      "ResonanceGroup2Chapter4"
    },
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      24,
      14176,
      30,
      14264
    },
    StageDisplayDate = 1763946000
  },
  [125685] = {
    ID = 125685,
    CnID = "关卡组@星辰篇困难第五章",
    BaseSortID = 39,
    Type = 7,
    Name = "StageGroup_125685_Name|织命剧场",
    Desc = "StageGroup_125685_Desc|吱呀——吱呀——命运的女神转动她的纺机。\n吱呀——吱呀——命运的丝线在她手中汇集。\n木偶们排队入场，踏入命运的巨网。\n它们跳舞。它们欢唱。吱呀——吱呀——\n它们与巨网一同死去，悄无声息。",
    TypeText = "StageGroup_125685_TypeText|调查困难",
    Sequence = 5,
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_14.prefab",
    BattleBuff = {
      1,
      "ResonanceGroup2Chapter5"
    },
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      27,
      14176,
      33,
      14264
    },
    StageDisplayDate = 1776646800
  },
  [146256] = {
    ID = 146256,
    CnID = "关卡组@星辰篇困难第六章",
    BaseSortID = 40,
    Type = 7,
    Name = "StageGroup_146256_Name|山宴",
    Desc = "StageGroup_146256_Desc|群山矗立于世界尽头。\n终年封冻的连绵冰雪之上，古老的饥饿正从漫长的沉眠中苏醒。\n山咧开血盆大口，绽出低沉而讥嘲的笑。\n耐心等待吧——祈愿者已在赴宴的路上。",
    TypeText = "StageGroup_146256_TypeText|调查困难",
    Sequence = 6,
    BackgrandPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_15.prefab",
    BattleBuff = {
      1,
      "ResonanceGroup2Chapter6"
    },
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageGroupDrop = {
      9,
      14177,
      18,
      14412,
      24,
      14176,
      30,
      14264
    },
    StageDisplayDate = 1787533200
  },
  [15940] = {
    ID = 15940,
    CnID = "关卡组@经验本",
    BaseSortID = 41,
    Type = 2,
    Name = "StageGroup_15940_Name|制剂淬炼",
    Desc = "StageGroup_15940_Desc|成为天才药理师的第一步。",
    TypeText = "StageGroup_15940_TypeText|制剂淬炼",
    Sequence = 1,
    Backgrand = "Icon/CopyTitle/GoldCoinStage.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_02.png",
      "队伍由不同界域的唤醒体组成时，队伍生命与所有唤醒体的攻击与防御提高 200%。"
    },
    StageGroupDropPreview = {
      9762,
      9834,
      10064
    },
    StageGroupRewardDescription = "StageGroup_15940_StageGroupRewardDescription|<Black:灵知制剂>",
    StageGroupJumpID = 17927
  },
  [15951] = {
    ID = 15951,
    CnID = "关卡组@金币本",
    BaseSortID = 42,
    Type = 2,
    Name = "StageGroup_15951_Name|金券搜查",
    Desc = "StageGroup_15951_Desc|与隐秘有关或无关的生活，都离不开蔷薇金券。\n常人无法居住的融蚀废墟中，或许藏有价值连城的宝物。",
    TypeText = "StageGroup_15951_TypeText|金券搜查",
    Sequence = 2,
    Backgrand = "Icon/CopyTitle/ExpStage.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_01.png",
      "队伍由不同界域的唤醒体组成时，队伍生命与所有唤醒体的攻击与防御提高 200%。"
    },
    StageGroupDropPreview = {10108},
    StageGroupRewardDescription = "StageGroup_15951_StageGroupRewardDescription|<Black:蔷薇金券>",
    StageGroupJumpID = 17853
  },
  [15936] = {
    ID = 15936,
    CnID = "关卡组@混沌本",
    BaseSortID = 43,
    Type = 2,
    Name = "StageGroup_15936_Name|浑浊残像",
    Desc = "StageGroup_15936_Desc|早在群星诞生之前，它们便存在于此。\n它们既是虚无，也是一切。",
    TypeText = "StageGroup_15936_TypeText|浑浊残像",
    Sequence = 3,
    Backgrand = "Icon/CopyTitle/ChaosStage.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_07.png",
      "队伍中每有一个深海界域的唤醒体，队伍生命与所有唤醒体的攻击与防御提高 50%"
    },
    StageGroupDropPreview = {
      9799,
      9793,
      9940
    },
    StageGroupRewardDescription = "StageGroup_15936_StageGroupRewardDescription|<Black:升格素材>",
    StageGroupJumpID = 17945
  },
  [15915] = {
    ID = 15915,
    CnID = "关卡组@深海本",
    BaseSortID = 44,
    Type = 2,
    Name = "StageGroup_15915_Name|海渊残像",
    Desc = "StageGroup_15915_Desc|它们无言地守护着海洋的秘密，灵魂和宇宙一样深沉。",
    TypeText = "StageGroup_15915_TypeText|海渊残像",
    Sequence = 4,
    Backgrand = "Icon/CopyTitle/OceanStage.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_04.png",
      "队伍中每有一个血肉界域的唤醒体，队伍生命与所有唤醒体的攻击与防御提高 50%"
    },
    StageGroupDropPreview = {
      9971,
      9758,
      10030
    },
    StageGroupRewardDescription = "StageGroup_15915_StageGroupRewardDescription|<Black:升格素材>",
    StageGroupJumpID = 18018
  },
  [15887] = {
    ID = 15887,
    CnID = "关卡组@血肉本",
    BaseSortID = 45,
    Type = 2,
    Name = "StageGroup_15887_Name|器质残像",
    Desc = "StageGroup_15887_Desc|献上血肉铸就的现实吧，它们是永不餍足的深渊。",
    TypeText = "StageGroup_15887_TypeText|器质残像",
    Sequence = 5,
    Backgrand = "Icon/CopyTitle/BloodStage.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_03.png",
      "队伍中每有一个超维界域的唤醒体，队伍生命与所有唤醒体的攻击与防御提高 50%"
    },
    StageGroupDropPreview = {
      9925,
      9740,
      9755
    },
    StageGroupRewardDescription = "StageGroup_15887_StageGroupRewardDescription|<Black:升格素材>",
    StageGroupJumpID = 18017
  },
  [15872] = {
    ID = 15872,
    CnID = "关卡组@超维本",
    BaseSortID = 46,
    Type = 2,
    Name = "StageGroup_15872_Name|维度残像",
    Desc = "StageGroup_15872_Desc|它们像捉摸不定的魔法师，游走在时空的夹缝里。\n没有仇恨，没有恐惧，也没有怜悯。",
    TypeText = "StageGroup_15872_TypeText|维度残像",
    Sequence = 6,
    Backgrand = "Icon/CopyTitle/DimensionStage.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_05.png",
      "队伍中每有一个深海界域的唤醒体，队伍生命与所有唤醒体的攻击与防御提高 50%"
    },
    StageGroupDropPreview = {
      9768,
      9904,
      10044
    },
    StageGroupRewardDescription = "StageGroup_15872_StageGroupRewardDescription|<Black:升格素材>",
    StageGroupJumpID = 17921
  },
  [15904] = {
    ID = 15904,
    CnID = "关卡组@混沌技能本",
    BaseSortID = 47,
    Type = 2,
    Name = "StageGroup_15904_Name|混沌集群",
    Desc = "StageGroup_15904_Desc|一堆粗鲁的、未消化的物质。人们称其为排泄物，或是混沌。 \n世界从排泄物中诞生。",
    TypeText = "StageGroup_15904_TypeText|混沌集群",
    Sequence = 7,
    Backgrand = "Icon/CopyTitle/SkillAtk.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_08.png",
      "队伍中每有一个超维界域的唤醒体，队伍生命与所有唤醒体的攻击与防御提高 50%"
    },
    StageGroupDropPreview = {
      9769,
      9621,
      9825
    },
    StageGroupRewardDescription = "StageGroup_15904_StageGroupRewardDescription|<Black:技能素材>",
    StageGroupJumpID = 17856
  },
  [15891] = {
    ID = 15891,
    CnID = "关卡组@深海技能本",
    BaseSortID = 48,
    Type = 2,
    Name = "StageGroup_15891_Name|波纳佩之墟",
    Desc = "StageGroup_15891_Desc|这里沉睡着一座古老城市的废墟。\n它和它的主人一样嗜睡。",
    TypeText = "StageGroup_15891_TypeText|波纳佩之墟",
    Sequence = 8,
    Backgrand = "Icon/CopyTitle/SkillDef.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_09.png",
      "队伍中每有一个深海界域的唤醒体，队伍生命与所有唤醒体的攻击与防御提高 50%"
    },
    StageGroupDropPreview = {
      9812,
      10117,
      9771
    },
    StageGroupRewardDescription = "StageGroup_15891_StageGroupRewardDescription|<Black:技能素材>",
    StageGroupJumpID = 17998
  },
  [15893] = {
    ID = 15893,
    CnID = "关卡组@血肉技能本",
    BaseSortID = 49,
    Type = 2,
    Name = "StageGroup_15893_Name|蠕虫之所",
    Desc = "StageGroup_15893_Desc|祂的国度是宇宙躯壳，祂的欲望无边无际。",
    TypeText = "StageGroup_15893_TypeText|蠕虫之所",
    Sequence = 9,
    Backgrand = "Icon/CopyTitle/SkillSupport.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_10.png",
      "队伍中每有一个深海界域的唤醒体，队伍生命与所有唤醒体的攻击与防御提高 50%"
    },
    StageGroupDropPreview = {
      9671,
      9601,
      9549
    },
    StageGroupRewardDescription = "StageGroup_15893_StageGroupRewardDescription|<Black:技能素材>",
    StageGroupJumpID = 17896
  },
  [15903] = {
    ID = 15903,
    CnID = "关卡组@超维技能本",
    BaseSortID = 50,
    Type = 2,
    Name = "StageGroup_15903_Name|史瓦西喉",
    Desc = "StageGroup_15903_Desc|潜藏在宇宙深处的弯曲视界。 \n它能带你从黑暗抵达另一处黑暗。",
    TypeText = "StageGroup_15903_TypeText|史瓦西喉",
    Sequence = 10,
    Backgrand = "Icon/CopyTitle/ChaosSkill.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_11.png",
      "队伍中每有一个深海界域的唤醒体，队伍生命与所有唤醒体的攻击与防御提高 50%"
    },
    StageGroupDropPreview = {
      9756,
      10013,
      9726
    },
    StageGroupRewardDescription = "StageGroup_15903_StageGroupRewardDescription|<Black:技能素材>",
    StageGroupJumpID = 17897
  },
  [15945] = {
    ID = 15945,
    CnID = "关卡组@周常BOSSA本",
    BaseSortID = 51,
    Type = 10,
    Name = "StageGroup_15945_Name|玩偶之泪",
    Desc = "StageGroup_15945_Desc|它以乖巧的姿态靠在床沿，暗淡的纽扣眼睛望着虚空。\n小小的身躯承受了主人的全部眼泪，却无法出言安慰。",
    TypeText = "StageGroup_15945_TypeText|玩偶之泪",
    Sequence = 1,
    Backgrand = "Icon/CopyTitle/WeeklyBoss_001.png",
    BattleBuff = {
      1,
      "ResonanceGroupChapter1"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_13.png"
    },
    StageGroupDropPreview = {
      9776,
      9966,
      20482
    },
    StageGroupRewardDescription = "StageGroup_15945_StageGroupRewardDescription|<Black:高阶技能素材>",
    StageGroupJumpID = 17894
  },
  [15892] = {
    ID = 15892,
    CnID = "关卡组@周常BOSSB本",
    BaseSortID = 52,
    Type = 10,
    Name = "StageGroup_15892_Name|蜡像之秘",
    Desc = "StageGroup_15892_Desc|它们原本是悲伤、扭曲和懵懂组成的无意识集合，\n却被打扮成幸福的小孩、大人和宠物。\n因着从未品尝过幸福的滋味，它们成了最糟糕的演员。",
    TypeText = "StageGroup_15892_TypeText|蜡像之秘",
    Sequence = 2,
    Backgrand = "Icon/CopyTitle/WeeklyBoss_002.png",
    BattleBuff = {
      1,
      "ResonanceGroupChapter2"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_13.png"
    },
    StageGroupDropPreview = {
      9779,
      9966,
      20482
    },
    StageGroupRewardDescription = "StageGroup_15892_StageGroupRewardDescription|<Black:高阶技能素材>",
    StageGroupJumpID = 17916
  },
  [15878] = {
    ID = 15878,
    CnID = "关卡组@周常BOSSC本",
    BaseSortID = 53,
    Type = 10,
    Name = "StageGroup_15878_Name|漆黑之链",
    Desc = "StageGroup_15878_Desc|蠕动着、流淌着……原生质的肿泡正从枷锁的缝隙中溜走。\n这是她为「自由」付出的代价。",
    TypeText = "StageGroup_15878_TypeText|漆黑之链",
    Sequence = 3,
    Backgrand = "Icon/CopyTitle/WeeklyBoss_003.png",
    BattleBuff = {
      1,
      "ResonanceGroupChapter3"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_13.png"
    },
    StageGroupDropPreview = {
      9778,
      9966,
      20482
    },
    StageGroupRewardDescription = "StageGroup_15878_StageGroupRewardDescription|<Black:高阶技能素材>",
    StageGroupJumpID = 17941
  },
  [15909] = {
    ID = 15909,
    CnID = "关卡组@周常BOSSD本",
    BaseSortID = 54,
    Type = 10,
    Name = "StageGroup_15909_Name|界外之影",
    Desc = "StageGroup_15909_Desc|它一刻不停地追逐那些打破规则的僭越者。\n至于何为「规则」，何为「打破」？\n猎犬从不思考——那只会阻碍它奔袭的速度。",
    TypeText = "StageGroup_15909_TypeText|界外之影",
    Sequence = 4,
    Backgrand = "Icon/CopyTitle/WeeklyBoss_004.png",
    BattleBuff = {
      1,
      "ResonanceGroupChapter4"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_13.png"
    },
    StageGroupDropPreview = {
      9781,
      9966,
      20482
    },
    StageGroupRewardDescription = "StageGroup_15909_StageGroupRewardDescription|<Black:高阶技能素材>",
    StageGroupJumpID = 18011
  },
  [15897] = {
    ID = 15897,
    CnID = "关卡组@周常BOSSE本",
    BaseSortID = 55,
    Type = 10,
    Name = "StageGroup_15897_Name|虔诚之握",
    Desc = "StageGroup_15897_Desc|她以己身承纳圣骸，以教义训导眷众，以毒牙布散信仰。\n她的祈祷永无止息，她的呼告永不停歇。",
    TypeText = "StageGroup_15897_TypeText|虔诚之握",
    Sequence = 5,
    Backgrand = "Icon/CopyTitle/WeeklyBoss_005.png",
    BattleBuff = {
      1,
      "ResonanceGroupChapter5"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_13.png"
    },
    StageGroupDropPreview = {
      9780,
      9966,
      20482
    },
    StageGroupRewardDescription = "StageGroup_15897_StageGroupRewardDescription|<Black:高阶技能素材>",
    StageGroupJumpID = 17977
  },
  [15928] = {
    ID = 15928,
    CnID = "关卡组@周常BOSSF本",
    BaseSortID = 56,
    Type = 10,
    Name = "StageGroup_15928_Name|圣胎之咏",
    Desc = "StageGroup_15928_Desc|不被祝福的孩子在海中吟咏圣歌。\n嘘……请保持安静，切勿惊扰祂的长眠。",
    TypeText = "StageGroup_15928_TypeText|圣胎之咏",
    Sequence = 6,
    Backgrand = "Icon/CopyTitle/WeeklyBoss_006.png",
    BattleBuff = {
      1,
      "ResonanceGroupChapter6"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_13.png"
    },
    StageGroupDropPreview = {
      9783,
      9966,
      20482
    },
    StageGroupRewardDescription = "StageGroup_15928_StageGroupRewardDescription|<Black:高阶技能素材>",
    StageGroupJumpID = 18001
  },
  [49169] = {
    ID = 49169,
    CnID = "关卡组@周常BOSSG本",
    BaseSortID = 57,
    Type = 10,
    Name = "StageGroup_49169_Name|沙海遗存",
    Desc = "StageGroup_49169_Desc|母树的幻影于银色火焰中轰然倒塌，但祂的血脉终将在根系中复苏。",
    TypeText = "StageGroup_49169_TypeText|沙海遗存",
    Sequence = 7,
    Backgrand = "Icon/CopyTitle/WeeklyBoss_007.png",
    BattleBuff = {
      1,
      "ResonanceGroupChapter7"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_13.png"
    },
    StageGroupDropPreview = {
      9782,
      9966,
      20482
    },
    StageGroupRewardDescription = "StageGroup_49169_StageGroupRewardDescription|<Black:高阶技能素材>",
    StageGroupJumpID = 49174
  },
  [58901] = {
    ID = 58901,
    CnID = "关卡组@周常BOSSH本",
    BaseSortID = 58,
    Type = 10,
    Name = "StageGroup_58901_Name|黑池之潮",
    Desc = "StageGroup_58901_Desc|黑色的池水狂躁地舞动，迎接它们最初的、唯一的主人。",
    TypeText = "StageGroup_58901_TypeText|黑池之潮",
    Sequence = 8,
    Backgrand = "Icon/CopyTitle/WeeklyBoss_008.png",
    BattleBuff = {
      1,
      "ResonanceGroupChapter8"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_13.png"
    },
    StageGroupDropPreview = {
      9785,
      9966,
      20482
    },
    StageGroupRewardDescription = "StageGroup_58901_StageGroupRewardDescription|<Black:高阶技能素材>",
    StageGroupJumpID = 59100,
    StageDisplayDate = 1725843600
  },
  [15873] = {
    ID = 15873,
    CnID = "关卡组@饰品A本",
    BaseSortID = 59,
    Type = 3,
    Name = "StageGroup_15873_Name|怪雾之都",
    Desc = "StageGroup_15873_Desc|伦蒂尼恩以灿烂的工业文明，以及笼罩市区的铅灰色浓雾闻名。\n雾气无处不在，对路人来说是更像是一种偶然、无意义的不便。",
    TypeText = "StageGroup_15873_TypeText|怪雾之都",
    Sequence = 1,
    Backgrand = "Icon/CopyTitle/TrinketStage_001.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_12.png"
    },
    StageGroupDropPreview = {9600},
    StageGroupRewardDescription = "StageGroup_15873_StageGroupRewardDescription|<Black:密契>",
    StageGroupJumpID = 22696
  },
  [15958] = {
    ID = 15958,
    CnID = "关卡组@饰品B本",
    BaseSortID = 60,
    Type = 3,
    Name = "StageGroup_15958_Name|狂躁蜡馆",
    Desc = "StageGroup_15958_Desc|罗杰斯蜡像馆坐落在南华克街的最深处，靠近泰姆河的支流。\n它毫不起眼，却有众多先锋艺术爱好者慕名而来。",
    TypeText = "StageGroup_15958_TypeText|狂躁蜡馆",
    Sequence = 2,
    Backgrand = "Icon/CopyTitle/TrinketStage_002.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_12.png"
    },
    StageGroupDropPreview = {9584},
    StageGroupRewardDescription = "StageGroup_15958_StageGroupRewardDescription|<Black:密契>",
    StageGroupJumpID = 22696
  },
  [15942] = {
    ID = 15942,
    CnID = "关卡组@饰品C本",
    BaseSortID = 61,
    Type = 3,
    Name = "StageGroup_15942_Name|错乱异镇",
    Desc = "StageGroup_15942_Desc|拉伊小镇位于伦蒂尼恩东北部，隐没在绵延的山脉中。\n沉默的乡民、无处不在的视线……当心，这里的一切都不太寻常。",
    TypeText = "StageGroup_15942_TypeText|错乱异镇",
    Sequence = 3,
    Backgrand = "Icon/CopyTitle/TrinketStage_003.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_12.png"
    },
    StageGroupDropPreview = {9664},
    StageGroupRewardDescription = "StageGroup_15942_StageGroupRewardDescription|<Black:密契>",
    StageGroupJumpID = 22696
  },
  [15924] = {
    ID = 15924,
    CnID = "关卡组@饰品D本",
    BaseSortID = 62,
    Type = 3,
    Name = "StageGroup_15924_Name|失序山脉",
    Desc = "StageGroup_15924_Desc|艾尔沃斯位于卡达斯的极点，终年被不融的冰雪覆盖，\n厚实而坚硬的冰壳下，隐约潜藏着生命的搏动。",
    TypeText = "StageGroup_15924_TypeText|失序山脉",
    Sequence = 4,
    Backgrand = "Icon/CopyTitle/TrinketStage_004.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_12.png"
    },
    StageGroupDropPreview = {9708},
    StageGroupRewardDescription = "StageGroup_15924_StageGroupRewardDescription|<Black:密契>",
    StageGroupJumpID = 22696
  },
  [15908] = {
    ID = 15908,
    CnID = "关卡组@饰品E本",
    BaseSortID = 63,
    Type = 3,
    Name = "StageGroup_15908_Name|暗海之舟",
    Desc = "StageGroup_15908_Desc|索纳尼尔号曾以伦蒂尼恩为母港，淹没在络绎来往的船只中。\n在风暴中失去音讯后，它彻底从俗世视野中消失，只留下只言片语的传说。",
    TypeText = "StageGroup_15908_TypeText|暗海之舟",
    Sequence = 5,
    Backgrand = "Icon/CopyTitle/TrinketStage_005.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_12.png"
    },
    StageGroupDropPreview = {10018},
    StageGroupRewardDescription = "StageGroup_15908_StageGroupRewardDescription|<Black:密契>",
    StageGroupJumpID = 22696
  },
  [15932] = {
    ID = 15932,
    CnID = "关卡组@饰品F本",
    BaseSortID = 64,
    Type = 3,
    Name = "StageGroup_15932_Name|风暴外海",
    Desc = "StageGroup_15932_Desc|雷欧王国的北海，拥有温和而平静的仲夏。\n她的冬季看起来也淑静典雅，但宁静华美的霞云之下，往往暗藏着致命的风暴。",
    TypeText = "StageGroup_15932_TypeText|风暴外海",
    Sequence = 6,
    Backgrand = "Icon/CopyTitle/TrinketStage_006.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_12.png"
    },
    StageGroupDropPreview = {9688},
    StageGroupRewardDescription = "StageGroup_15932_StageGroupRewardDescription|<Black:密契>",
    StageGroupJumpID = 22696
  },
  [49168] = {
    ID = 49168,
    CnID = "关卡组@饰品G本",
    BaseSortID = 65,
    Type = 3,
    Name = "StageGroup_49168_Name|荒沙之壁",
    Desc = "StageGroup_49168_Desc|A.F.225年，风暴之壁诞生于勒姆瓦希沙漠，形成一道环绕圣河源头的天然屏障。",
    TypeText = "StageGroup_49168_TypeText|荒沙之壁",
    Sequence = 7,
    Backgrand = "Icon/CopyTitle/TrinketStage_007.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_12.png"
    },
    StageGroupDropPreview = {10061},
    StageGroupRewardDescription = "StageGroup_49168_StageGroupRewardDescription|<Black:密契>",
    StageGroupJumpID = 22696
  },
  [58897] = {
    ID = 58897,
    CnID = "关卡组@饰品H本",
    BaseSortID = 66,
    Type = 3,
    Name = "StageGroup_58897_Name|原初裂隙",
    Desc = "StageGroup_58897_Desc|在弥萨格的地底，隐藏着这个世界最初、也是最后的灾难。",
    TypeText = "StageGroup_58897_TypeText|原初裂隙",
    Sequence = 8,
    Backgrand = "Icon/CopyTitle/TrinketStage_008.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_12.png"
    },
    StageGroupDropPreview = {9753},
    StageGroupRewardDescription = "StageGroup_58897_StageGroupRewardDescription|<Black:密契>",
    StageGroupJumpID = 22696,
    StageDisplayDate = 1725843600
  },
  [15933] = {
    ID = 15933,
    CnID = "关卡组@日常挑战本",
    BaseSortID = 67,
    Type = 9,
    Name = "StageGroup_15933_Name|幻梦深潜",
    Desc = "StageGroup_15933_Desc|所有唤醒体等级、技能等级、造物强度调整为1级。\n自由选择关卡共鸣组合，共鸣组合星级越高，通关获得的奖励越多。",
    TypeText = "StageGroup_15933_TypeText|幻梦深潜",
    Sequence = 1,
    Backgrand = "Icon/CopyTitle/ExpStage.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [15916] = {
    ID = 15916,
    CnID = "关卡组@无光之境深海之遗间隙",
    BaseSortID = 68,
    Type = 17,
    Name = "StageGroup_15916_Name|深海之遗",
    Desc = "StageGroup_15916_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_15916_TypeText|深海之遗",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14347,
      6,
      14500,
      9,
      14172,
      12,
      14226,
      15,
      14502,
      18,
      14217,
      21,
      14508,
      24,
      14259
    }
  },
  [15959] = {
    ID = 15959,
    CnID = "关卡组@无光之境血肉之沼间隙",
    BaseSortID = 69,
    Type = 17,
    Name = "StageGroup_15959_Name|血肉之沼",
    Desc = "StageGroup_15959_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_15959_TypeText|血肉之沼",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big04.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14347,
      6,
      14500,
      9,
      14172,
      12,
      14226,
      15,
      14502,
      18,
      14217,
      21,
      14508,
      24,
      14259
    }
  },
  [15884] = {
    ID = 15884,
    CnID = "关卡组@无光之境超维之旅间隙",
    BaseSortID = 70,
    Type = 17,
    Name = "StageGroup_15884_Name|超维之旅",
    Desc = "StageGroup_15884_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_15884_TypeText|超维之旅",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14347,
      6,
      14500,
      9,
      14172,
      12,
      14226,
      15,
      14502,
      18,
      14217,
      21,
      14508,
      24,
      14259
    }
  },
  [15874] = {
    ID = 15874,
    CnID = "关卡组@无光之境混沌之域间隙",
    BaseSortID = 71,
    Type = 17,
    Name = "StageGroup_15874_Name|混沌之域",
    Desc = "StageGroup_15874_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_15874_TypeText|混沌之域",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14347,
      6,
      14500,
      9,
      14172,
      12,
      14226,
      15,
      14502,
      18,
      14217,
      21,
      14508,
      24,
      14259
    }
  },
  [15898] = {
    ID = 15898,
    CnID = "关卡组@无光之境深海之遗轮转间隙_1",
    BaseSortID = 72,
    Type = 18,
    Name = "StageGroup_15898_Name|深海之遗",
    Desc = "StageGroup_15898_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_15898_TypeText|深海之遗",
    Sequence = 2,
    Batch = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14405,
      6,
      14274,
      9,
      14476,
      12,
      14310
    }
  },
  [15931] = {
    ID = 15931,
    CnID = "关卡组@无光之境血肉之沼轮转间隙_1",
    BaseSortID = 73,
    Type = 18,
    Name = "StageGroup_15931_Name|血肉之沼",
    Desc = "StageGroup_15931_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_15931_TypeText|血肉之沼",
    Sequence = 3,
    Batch = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big04.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14405,
      6,
      14274,
      9,
      14476,
      12,
      14310
    }
  },
  [15869] = {
    ID = 15869,
    CnID = "关卡组@无光之境超维之旅轮转间隙_1",
    BaseSortID = 74,
    Type = 18,
    Name = "StageGroup_15869_Name|超维之旅",
    Desc = "StageGroup_15869_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_15869_TypeText|超维之旅",
    Sequence = 4,
    Batch = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14405,
      6,
      14274,
      9,
      14476,
      12,
      14310
    }
  },
  [15910] = {
    ID = 15910,
    CnID = "关卡组@无光之境混沌之域轮转间隙_1",
    BaseSortID = 75,
    Type = 18,
    Name = "StageGroup_15910_Name|混沌之域",
    Desc = "StageGroup_15910_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_15910_TypeText|混沌之域",
    Sequence = 1,
    Batch = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14405,
      6,
      14274,
      9,
      14476,
      12,
      14310
    }
  },
  [15900] = {
    ID = 15900,
    CnID = "关卡组@无光之境深海之遗轮转间隙_2",
    BaseSortID = 76,
    Type = 18,
    Name = "StageGroup_15900_Name|深海之遗",
    Desc = "StageGroup_15900_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_15900_TypeText|深海之遗",
    Sequence = 2,
    Batch = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14405,
      6,
      14274,
      9,
      14476,
      12,
      14310
    }
  },
  [15930] = {
    ID = 15930,
    CnID = "关卡组@无光之境血肉之沼轮转间隙_2",
    BaseSortID = 77,
    Type = 18,
    Name = "StageGroup_15930_Name|血肉之沼",
    Desc = "StageGroup_15930_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_15930_TypeText|血肉之沼",
    Sequence = 3,
    Batch = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big04.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14405,
      6,
      14274,
      9,
      14476,
      12,
      14310
    }
  },
  [15870] = {
    ID = 15870,
    CnID = "关卡组@无光之境超维之旅轮转间隙_2",
    BaseSortID = 78,
    Type = 18,
    Name = "StageGroup_15870_Name|超维之旅",
    Desc = "StageGroup_15870_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_15870_TypeText|超维之旅",
    Sequence = 4,
    Batch = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14405,
      6,
      14274,
      9,
      14476,
      12,
      14310
    }
  },
  [15911] = {
    ID = 15911,
    CnID = "关卡组@无光之境混沌之域轮转间隙_2",
    BaseSortID = 79,
    Type = 18,
    Name = "StageGroup_15911_Name|混沌之域",
    Desc = "StageGroup_15911_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_15911_TypeText|混沌之域",
    Sequence = 1,
    Batch = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14405,
      6,
      14274,
      9,
      14476,
      12,
      14310
    }
  },
  [15899] = {
    ID = 15899,
    CnID = "关卡组@无光之境深海之遗轮转间隙_3",
    BaseSortID = 80,
    Type = 18,
    Name = "StageGroup_15899_Name|深海之遗",
    Desc = "StageGroup_15899_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_15899_TypeText|深海之遗",
    Sequence = 2,
    Batch = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14405,
      6,
      14274,
      9,
      14476,
      12,
      14310
    }
  },
  [15929] = {
    ID = 15929,
    CnID = "关卡组@无光之境血肉之沼轮转间隙_3",
    BaseSortID = 81,
    Type = 18,
    Name = "StageGroup_15929_Name|血肉之沼",
    Desc = "StageGroup_15929_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_15929_TypeText|血肉之沼",
    Sequence = 3,
    Batch = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big04.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14405,
      6,
      14274,
      9,
      14476,
      12,
      14310
    }
  },
  [15871] = {
    ID = 15871,
    CnID = "关卡组@无光之境超维之旅轮转间隙_3",
    BaseSortID = 82,
    Type = 18,
    Name = "StageGroup_15871_Name|超维之旅",
    Desc = "StageGroup_15871_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_15871_TypeText|超维之旅",
    Sequence = 4,
    Batch = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14405,
      6,
      14274,
      9,
      14476,
      12,
      14310
    }
  },
  [15912] = {
    ID = 15912,
    CnID = "关卡组@无光之境混沌之域轮转间隙_3",
    BaseSortID = 83,
    Type = 18,
    Name = "StageGroup_15912_Name|混沌之域",
    Desc = "StageGroup_15912_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_15912_TypeText|混沌之域",
    Sequence = 1,
    Batch = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14405,
      6,
      14274,
      9,
      14476,
      12,
      14310
    }
  },
  [23663] = {
    ID = 23663,
    CnID = "关卡组@无光之境深海之遗轮转间隙_4",
    BaseSortID = 84,
    Type = 18,
    Name = "StageGroup_23663_Name|深海之遗",
    Desc = "StageGroup_23663_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_23663_TypeText|深海之遗",
    Sequence = 2,
    Batch = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14405,
      6,
      14274,
      9,
      14476,
      12,
      14310
    }
  },
  [23664] = {
    ID = 23664,
    CnID = "关卡组@无光之境血肉之沼轮转间隙_4",
    BaseSortID = 85,
    Type = 18,
    Name = "StageGroup_23664_Name|血肉之沼",
    Desc = "StageGroup_23664_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_23664_TypeText|血肉之沼",
    Sequence = 3,
    Batch = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big04.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14405,
      6,
      14274,
      9,
      14476,
      12,
      14310
    }
  },
  [23665] = {
    ID = 23665,
    CnID = "关卡组@无光之境超维之旅轮转间隙_4",
    BaseSortID = 86,
    Type = 18,
    Name = "StageGroup_23665_Name|超维之旅",
    Desc = "StageGroup_23665_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_23665_TypeText|超维之旅",
    Sequence = 4,
    Batch = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14405,
      6,
      14274,
      9,
      14476,
      12,
      14310
    }
  },
  [23666] = {
    ID = 23666,
    CnID = "关卡组@无光之境混沌之域轮转间隙_4",
    BaseSortID = 87,
    Type = 18,
    Name = "StageGroup_23666_Name|混沌之域",
    Desc = "StageGroup_23666_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_23666_TypeText|混沌之域",
    Sequence = 1,
    Batch = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14405,
      6,
      14274,
      9,
      14476,
      12,
      14310
    }
  },
  [15889] = {
    ID = 15889,
    CnID = "关卡组@测试关卡",
    BaseSortID = 88,
    Type = 99,
    Name = "StageGroup_15889_Name|测试关卡",
    Desc = "StageGroup_15889_Desc|这是一个测试关卡",
    TypeText = "StageGroup_15889_TypeText|调查",
    Sequence = 99,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [15926] = {
    ID = 15926,
    CnID = "关卡组@角色试玩活动关卡",
    BaseSortID = 89,
    Type = 4,
    Name = "StageGroup_15926_Name|角色试玩活动关卡",
    TypeText = "StageGroup_15926_TypeText|活动关卡",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [99329] = {
    ID = 99329,
    CnID = "关卡组@星辰篇角色试玩活动关卡",
    BaseSortID = 90,
    Type = 112,
    Name = "StageGroup_99329_Name|星辰篇角色试玩活动关卡",
    TypeText = "StageGroup_99329_TypeText|活动关卡",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [121205] = {
    ID = 121205,
    CnID = "关卡组@日常挑战难度选择",
    BaseSortID = 91,
    Type = 9,
    Name = "StageGroup_121205_Name|幻梦深潜",
    Desc = "StageGroup_121205_Desc|「不要温和地沉入深梦，幻梦之底应有不可直视的魂灵无声静候。」",
    TypeText = "StageGroup_121205_TypeText|幻梦深潜",
    Sequence = 0,
    Backgrand = "Icon/CopyTitle/DailyChallenge6.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15950] = {
    ID = 15950,
    CnID = "关卡组@日常挑战风格1",
    BaseSortID = 92,
    Type = 9,
    Name = "StageGroup_15950_Name|幻梦深潜",
    Desc = "StageGroup_15950_Desc|「手」掀开夜的帷幕，悄悄来到这个世界。",
    TypeText = "StageGroup_15950_TypeText|幻梦深潜",
    Sequence = 1,
    Backgrand = "Icon/CopyTitle/DailyChallenge1.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15953] = {
    ID = 15953,
    CnID = "关卡组@日常挑战风格2",
    BaseSortID = 93,
    Type = 9,
    Name = "StageGroup_15953_Name|幻梦深潜",
    Desc = "StageGroup_15953_Desc|「此处埋葬着一所大学，千疮百孔，疲惫不堪\n它曾为人类存续奉献了一点希望与勇气\n至于结果如何，你现在都看到了」",
    TypeText = "StageGroup_15953_TypeText|幻梦深潜",
    Sequence = 2,
    Backgrand = "Icon/CopyTitle/DailyChallenge2.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15952] = {
    ID = 15952,
    CnID = "关卡组@日常挑战风格3",
    BaseSortID = 94,
    Type = 9,
    Name = "StageGroup_15952_Name|幻梦深潜",
    Desc = "StageGroup_15952_Desc|坍塌的偶像注视着自己的子民。\n看他们生存、繁衍、互相争斗，然后将自己彻底遗忘。\n坍塌的偶像怀念着自己的子民。",
    TypeText = "StageGroup_15952_TypeText|幻梦深潜",
    Sequence = 3,
    Backgrand = "Icon/CopyTitle/DailyChallenge3.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15943] = {
    ID = 15943,
    CnID = "关卡组@日常挑战风格4",
    BaseSortID = 95,
    Type = 9,
    Name = "StageGroup_15943_Name|幻梦深潜",
    Desc = "StageGroup_15943_Desc|「每把钥匙都有唯一的编号，只对应唯一的调查员。」\n因此，每把钥匙的陨落也对应着唯一的调查员之死。\n真好啊。就连死亡都是独一无二的。」",
    TypeText = "StageGroup_15943_TypeText|幻梦深潜",
    Sequence = 4,
    Backgrand = "Icon/CopyTitle/DailyChallenge4.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15954] = {
    ID = 15954,
    CnID = "关卡组@日常挑战风格5",
    BaseSortID = 96,
    Type = 9,
    Name = "StageGroup_15954_Name|幻梦深潜",
    Desc = "StageGroup_15954_Desc|「它是唯一，它是全部，它是开启真相之门的希望。」\n无数钥匙围城了一个圈。它们自天空中坠落，带给人们沉甸甸的希望。\n也带来沉甸甸的坟墓。",
    TypeText = "StageGroup_15954_TypeText|幻梦深潜",
    Sequence = 5,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15957] = {
    ID = 15957,
    CnID = "关卡组@日常挑战风格6",
    BaseSortID = 97,
    Type = 9,
    Name = "StageGroup_15957_Name|幻梦深潜",
    Desc = "StageGroup_15957_Desc|「手」掀开夜的帷幕，悄悄来到这个世界。",
    TypeText = "StageGroup_15957_TypeText|幻梦深潜",
    Sequence = 6,
    Backgrand = "Icon/CopyTitle/DailyChallenge1.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15956] = {
    ID = 15956,
    CnID = "关卡组@日常挑战风格7",
    BaseSortID = 98,
    Type = 9,
    Name = "StageGroup_15956_Name|幻梦深潜",
    Desc = "StageGroup_15956_Desc|「此处埋葬着一所大学，千疮百孔，疲惫不堪\n它曾为人类存续奉献了一点希望与勇气\n至于结果如何，你现在都看到了」",
    TypeText = "StageGroup_15956_TypeText|幻梦深潜",
    Sequence = 7,
    Backgrand = "Icon/CopyTitle/DailyChallenge2.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15949] = {
    ID = 15949,
    CnID = "关卡组@日常挑战风格8",
    BaseSortID = 99,
    Type = 9,
    Name = "StageGroup_15949_Name|幻梦深潜",
    Desc = "StageGroup_15949_Desc|坍塌的偶像注视着自己的子民。\n看他们生存、繁衍、互相争斗，然后将自己彻底遗忘。\n坍塌的偶像怀念着自己的子民。",
    TypeText = "StageGroup_15949_TypeText|幻梦深潜",
    Sequence = 8,
    Backgrand = "Icon/CopyTitle/DailyChallenge3.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15948] = {
    ID = 15948,
    CnID = "关卡组@日常挑战风格9",
    BaseSortID = 100,
    Type = 9,
    Name = "StageGroup_15948_Name|幻梦深潜",
    Desc = "StageGroup_15948_Desc|「每把钥匙都有唯一的编号，只对应唯一的调查员。」\n因此，每把钥匙的陨落也对应着唯一的调查员之死。\n真好啊。就连死亡都是独一无二的。",
    TypeText = "StageGroup_15948_TypeText|幻梦深潜",
    Sequence = 9,
    Backgrand = "Icon/CopyTitle/DailyChallenge4.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15881] = {
    ID = 15881,
    CnID = "关卡组@日常挑战风格10",
    BaseSortID = 101,
    Type = 9,
    Name = "StageGroup_15881_Name|幻梦深潜",
    Desc = "StageGroup_15881_Desc|「它是唯一，它是全部，它是开启真相之门的希望。」\n无数钥匙围城了一个圈。它们自天空中坠落，带给人们沉甸甸的希望。\n也带来沉甸甸的坟墓。",
    TypeText = "StageGroup_15881_TypeText|幻梦深潜",
    Sequence = 10,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15880] = {
    ID = 15880,
    CnID = "关卡组@日常挑战风格11",
    BaseSortID = 102,
    Type = 9,
    Name = "StageGroup_15880_Name|幻梦深潜",
    Desc = "StageGroup_15880_Desc|「手」掀开夜的帷幕，悄悄来到这个世界。",
    TypeText = "StageGroup_15880_TypeText|幻梦深潜",
    Sequence = 11,
    Backgrand = "Icon/CopyTitle/DailyChallenge1.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15883] = {
    ID = 15883,
    CnID = "关卡组@日常挑战风格12",
    BaseSortID = 103,
    Type = 9,
    Name = "StageGroup_15883_Name|幻梦深潜",
    Desc = "StageGroup_15883_Desc|「此处埋葬着一所大学，千疮百孔，疲惫不堪\n它曾为人类存续奉献了一点希望与勇气\n至于结果如何，你现在都看到了」",
    TypeText = "StageGroup_15883_TypeText|幻梦深潜",
    Sequence = 12,
    Backgrand = "Icon/CopyTitle/DailyChallenge2.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15868] = {
    ID = 15868,
    CnID = "关卡组@日常挑战风格13",
    BaseSortID = 104,
    Type = 9,
    Name = "StageGroup_15868_Name|幻梦深潜",
    Desc = "StageGroup_15868_Desc|坍塌的偶像注视着自己的子民。\n看他们生存、繁衍、互相争斗，然后将自己彻底遗忘。\n坍塌的偶像怀念着自己的子民。",
    TypeText = "StageGroup_15868_TypeText|幻梦深潜",
    Sequence = 13,
    Backgrand = "Icon/CopyTitle/DailyChallenge3.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15877] = {
    ID = 15877,
    CnID = "关卡组@日常挑战风格14",
    BaseSortID = 105,
    Type = 9,
    Name = "StageGroup_15877_Name|幻梦深潜",
    Desc = "StageGroup_15877_Desc|「每把钥匙都有唯一的编号，只对应唯一的调查员。」\n因此，每把钥匙的陨落也对应着唯一的调查员之死。\n真好啊。就连死亡都是独一无二的。」",
    TypeText = "StageGroup_15877_TypeText|幻梦深潜",
    Sequence = 14,
    Backgrand = "Icon/CopyTitle/DailyChallenge4.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15876] = {
    ID = 15876,
    CnID = "关卡组@日常挑战风格15",
    BaseSortID = 106,
    Type = 9,
    Name = "StageGroup_15876_Name|幻梦深潜",
    Desc = "StageGroup_15876_Desc|「它是唯一，它是全部，它是开启真相之门的希望。」\n无数钥匙围城了一个圈。它们自天空中坠落，带给人们沉甸甸的希望。\n也带来沉甸甸的坟墓。",
    TypeText = "StageGroup_15876_TypeText|幻梦深潜",
    Sequence = 15,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15879] = {
    ID = 15879,
    CnID = "关卡组@日常挑战风格16",
    BaseSortID = 107,
    Type = 9,
    Name = "StageGroup_15879_Name|幻梦深潜",
    Desc = "StageGroup_15879_Desc|「手」掀开夜的帷幕，悄悄来到这个世界。",
    TypeText = "StageGroup_15879_TypeText|幻梦深潜",
    Sequence = 16,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15955] = {
    ID = 15955,
    CnID = "关卡组@日常挑战风格17",
    BaseSortID = 108,
    Type = 9,
    Name = "StageGroup_15955_Name|幻梦深潜",
    Desc = "StageGroup_15955_Desc|「此处埋葬着一所大学，千疮百孔，疲惫不堪\n它曾为人类存续奉献了一点希望与勇气\n至于结果如何，你现在都看到了」",
    TypeText = "StageGroup_15955_TypeText|幻梦深潜",
    Sequence = 17,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15886] = {
    ID = 15886,
    CnID = "关卡组@日常挑战风格18",
    BaseSortID = 109,
    Type = 9,
    Name = "StageGroup_15886_Name|幻梦深潜",
    Desc = "StageGroup_15886_Desc|坍塌的偶像注视着自己的子民。\n看他们生存、繁衍、互相争斗，然后将自己彻底遗忘。\n坍塌的偶像怀念着自己的子民。",
    TypeText = "StageGroup_15886_TypeText|幻梦深潜",
    Sequence = 18,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15885] = {
    ID = 15885,
    CnID = "关卡组@日常挑战风格19",
    BaseSortID = 110,
    Type = 9,
    Name = "StageGroup_15885_Name|幻梦深潜",
    Desc = "StageGroup_15885_Desc|「每把钥匙都有唯一的编号，只对应唯一的调查员。」\n因此，每把钥匙的陨落也对应着唯一的调查员之死。\n真好啊。就连死亡都是独一无二的。」",
    TypeText = "StageGroup_15885_TypeText|幻梦深潜",
    Sequence = 19,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15941] = {
    ID = 15941,
    CnID = "关卡组@日常挑战风格20",
    BaseSortID = 111,
    Type = 9,
    Name = "StageGroup_15941_Name|幻梦深潜",
    Desc = "StageGroup_15941_Desc|「手」掀开夜的帷幕，悄悄来到这个世界。",
    TypeText = "StageGroup_15941_TypeText|幻梦深潜",
    Sequence = 20,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15937] = {
    ID = 15937,
    CnID = "关卡组@日常挑战风格21",
    BaseSortID = 112,
    Type = 9,
    Name = "StageGroup_15937_Name|幻梦深潜",
    Desc = "StageGroup_15937_Desc|「此处埋葬着一所大学，千疮百孔，疲惫不堪\n它曾为人类存续奉献了一点希望与勇气\n至于结果如何，你现在都看到了」",
    TypeText = "StageGroup_15937_TypeText|幻梦深潜",
    Sequence = 21,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15938] = {
    ID = 15938,
    CnID = "关卡组@日常挑战风格22",
    BaseSortID = 113,
    Type = 9,
    Name = "StageGroup_15938_Name|幻梦深潜",
    Desc = "StageGroup_15938_Desc|坍塌的偶像注视着自己的子民。\n看他们生存、繁衍、互相争斗，然后将自己彻底遗忘。\n坍塌的偶像怀念着自己的子民。",
    TypeText = "StageGroup_15938_TypeText|幻梦深潜",
    Sequence = 22,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15939] = {
    ID = 15939,
    CnID = "关卡组@日常挑战风格23",
    BaseSortID = 114,
    Type = 9,
    Name = "StageGroup_15939_Name|幻梦深潜",
    Desc = "StageGroup_15939_Desc|「每把钥匙都有唯一的编号，只对应唯一的调查员。」\n因此，每把钥匙的陨落也对应着唯一的调查员之死。\n真好啊。就连死亡都是独一无二的。」",
    TypeText = "StageGroup_15939_TypeText|幻梦深潜",
    Sequence = 23,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15934] = {
    ID = 15934,
    CnID = "关卡组@日常挑战风格24",
    BaseSortID = 115,
    Type = 9,
    Name = "StageGroup_15934_Name|幻梦深潜",
    Desc = "StageGroup_15934_Desc|「它是唯一，它是全部，它是开启真相之门的希望。」\n无数钥匙围城了一个圈。它们自天空中坠落，带给人们沉甸甸的希望。\n也带来沉甸甸的坟墓。",
    TypeText = "StageGroup_15934_TypeText|幻梦深潜",
    Sequence = 24,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {118305},
    IntegralTerm = {
      121897,
      144311,
      39279,
      122110
    }
  },
  [15947] = {
    ID = 15947,
    CnID = "关卡组@达芙戴尔支线关卡普通",
    BaseSortID = 116,
    Type = 11,
    Name = "StageGroup_15947_Name|雨镇幽影",
    Desc = "StageGroup_15947_Desc|每个下着雨的夜晚，都伴随着杀意。\n这次你将前往拉伊小镇北部的瑞尼镇，独自调查一桩离奇的案件……",
    HardMode = {15894, 15875},
    TypeText = "StageGroup_15947_TypeText|特遣纪录",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15590,
    BestExperienceCondition = {7869},
    PromptNumber = "20111",
    UnlockItem = {36863, 7},
    UnlockCompensation = {
      "DaffodilActivity",
      20160,
      75786,
      700
    }
  },
  [15894] = {
    ID = 15894,
    CnID = "关卡组@达芙戴尔支线关卡困难",
    BaseSortID = 117,
    Type = 12,
    Name = "StageGroup_15894_Name|雨镇幽影",
    Desc = "StageGroup_15894_Desc|每个下着雨的夜晚，都伴随着杀意。\n这次你将前往拉伊小镇北部的瑞尼镇，独自调查一桩离奇的案件……",
    TypeText = "StageGroup_15894_TypeText|特遣纪录",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15590
  },
  [15875] = {
    ID = 15875,
    CnID = "关卡组@达芙戴尔支线关卡癫狂",
    BaseSortID = 118,
    Type = 13,
    Name = "StageGroup_15875_Name|雨镇幽影",
    Desc = "StageGroup_15875_Desc|每个下着雨的夜晚，都伴随着杀意。\n这次你将前往拉伊小镇北部的瑞尼镇，独自调查一桩离奇的案件……",
    TypeText = "StageGroup_15875_TypeText|特遣纪录",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15590
  },
  [24436] = {
    ID = 24436,
    CnID = "关卡组@索蕾尔支线关卡普通",
    BaseSortID = 119,
    Type = 11,
    Name = "StageGroup_24436_Name|蔷薇礼赞",
    Desc = "StageGroup_24436_Desc|女士们，先生们。\n温和的良夜已经拉开帷幕，准备好手边的佳酿吧。\n这是一个漫长的故事，且听我们慢慢道来……",
    HardMode = {24438, 24437},
    TypeText = "StageGroup_24436_TypeText|特遣纪录",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15584,
    BestExperienceCondition = {7755},
    PromptNumber = "20130",
    UnlockItem = {36863, 7},
    UnlockCompensation = {
      "SorelActivity",
      20160,
      53746,
      700
    }
  },
  [24438] = {
    ID = 24438,
    CnID = "关卡组@索蕾尔支线关卡困难",
    BaseSortID = 120,
    Type = 12,
    Name = "StageGroup_24438_Name|蔷薇礼赞",
    Desc = "StageGroup_24438_Desc|女士们，先生们。\n温和的良夜已经拉开帷幕，准备好手边的佳酿吧。\n这是一个漫长的故事，且听我们慢慢道来……",
    TypeText = "StageGroup_24438_TypeText|特遣纪录",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15584
  },
  [24437] = {
    ID = 24437,
    CnID = "关卡组@索蕾尔支线关卡癫狂",
    BaseSortID = 121,
    Type = 13,
    Name = "StageGroup_24437_Name|蔷薇礼赞",
    Desc = "StageGroup_24437_Desc|女士们，先生们。\n温和的良夜已经拉开帷幕，准备好手边的佳酿吧。\n这是一个漫长的故事，且听我们慢慢道来……",
    TypeText = "StageGroup_24437_TypeText|特遣纪录",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15584
  },
  [23622] = {
    ID = 23622,
    CnID = "关卡组@莉莉支线关卡普通",
    BaseSortID = 122,
    Type = 11,
    Name = "StageGroup_23622_Name|故事的魔法",
    Desc = "StageGroup_23622_Desc|一台神奇摄像机，一盘魔法胶片，一帮连字都不太认得的小家伙……这次的「实验」任务，注定不会一帆风顺。",
    HardMode = {23621, 23623},
    TypeText = "StageGroup_23622_TypeText|特遣纪录",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_04.png",
    BattleBuff = {
      1,
      "ResonanceGroupMagicStoryActivity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageDisplayDate = 1706734800,
    RelatedAwaker = 15581,
    BestExperienceCondition = {7869},
    PromptNumber = "20111",
    UnlockItem = {36863, 7},
    UnlockCompensation = {
      "MagicStoryActivityReproduce",
      20160,
      51105,
      700
    }
  },
  [23621] = {
    ID = 23621,
    CnID = "关卡组@莉莉支线关卡困难",
    BaseSortID = 123,
    Type = 12,
    Name = "StageGroup_23621_Name|故事的魔法",
    Desc = "StageGroup_23621_Desc|一台神奇摄像机，一盘魔法胶片，一帮连字都不太认得的小家伙……这次的「实验」任务，注定不会一帆风顺。",
    TypeText = "StageGroup_23621_TypeText|特遣纪录",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_04.png",
    BattleBuff = {
      1,
      "ResonanceGroupMagicStoryActivity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15581
  },
  [23623] = {
    ID = 23623,
    CnID = "关卡组@莉莉支线关卡癫狂",
    BaseSortID = 124,
    Type = 13,
    Name = "StageGroup_23623_Name|故事的魔法",
    Desc = "StageGroup_23623_Desc|一台神奇摄像机，一盘魔法胶片，一帮连字都不太认得的小家伙……这次的「实验」任务，注定不会一帆风顺。",
    TypeText = "StageGroup_23623_TypeText|特遣纪录",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_04.png",
    BattleBuff = {
      1,
      "ResonanceGroupMagicStoryActivity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15581
  },
  [44564] = {
    ID = 44564,
    CnID = "关卡组@萨尔瓦多支线关卡普通",
    BaseSortID = 125,
    Type = 11,
    Name = "StageGroup_44564_Name|血的颜色",
    Desc = "StageGroup_44564_Desc|被黑暗与痛苦蒙蔽双眼的人失却了方向，他们徒劳摸索，妄图在错误的道路上寻求出路。",
    HardMode = {44565, 44566},
    TypeText = "StageGroup_44564_TypeText|特遣纪录",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_05.png",
    BattleBuff = {
      1,
      "ResonanceGroupSEWD"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageDisplayDate = 1712192400,
    RelatedAwaker = 15599,
    BestExperienceCondition = {8030},
    PromptNumber = "20250",
    UnlockItem = {36863, 7},
    UnlockCompensation = {
      "SalvadorActivityReproduce",
      20160,
      44265,
      700
    }
  },
  [44565] = {
    ID = 44565,
    CnID = "关卡组@萨尔瓦多支线关卡困难",
    BaseSortID = 126,
    Type = 12,
    Name = "StageGroup_44565_Name|血的颜色",
    Desc = "StageGroup_44565_Desc|被黑暗与痛苦蒙蔽双眼的人失却了方向，他们徒劳摸索，妄图在错误的道路上寻求出路。",
    TypeText = "StageGroup_44565_TypeText|特遣纪录",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_05.png",
    BattleBuff = {
      1,
      "ResonanceGroupSEWD"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15599
  },
  [44566] = {
    ID = 44566,
    CnID = "关卡组@萨尔瓦多支线关卡癫狂",
    BaseSortID = 127,
    Type = 13,
    Name = "StageGroup_44566_Name|血的颜色",
    Desc = "StageGroup_44566_Desc|被黑暗与痛苦蒙蔽双眼的人失却了方向，他们徒劳摸索，妄图在错误的道路上寻求出路。",
    TypeText = "StageGroup_44566_TypeText|特遣纪录",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_05.png",
    BattleBuff = {
      1,
      "ResonanceGroupSEWD"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15599
  },
  [46185] = {
    ID = 46185,
    CnID = "关卡组@「24」支线关卡普通",
    BaseSortID = 128,
    Type = 11,
    Name = "StageGroup_46185_Name|宁静的裂殖",
    Desc = "StageGroup_46185_Desc|从不惹麻烦的梅森又惹上麻烦了。\n等等，让我们先确认一下，惹上麻烦的是哪一个「梅森」？",
    HardMode = {46184, 46183},
    TypeText = "StageGroup_46185_TypeText|特遣纪录",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_06.png",
    BattleBuff = {
      1,
      "ResonanceGroup24"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageDisplayDate = 1714179600,
    RelatedAwaker = 15601,
    BestExperienceCondition = {7755},
    PromptNumber = "20130",
    UnlockItem = {36863, 7},
    UnlockCompensation = {
      "A24ActivityReproduce",
      20160,
      46606,
      700
    }
  },
  [46184] = {
    ID = 46184,
    CnID = "关卡组@「24」支线关卡困难",
    BaseSortID = 129,
    Type = 12,
    Name = "StageGroup_46184_Name|宁静的裂殖",
    Desc = "StageGroup_46184_Desc|从不惹麻烦的梅森又惹上麻烦了。\n等等，让我们先确认一下，惹上麻烦的是哪一个「梅森」？",
    TypeText = "StageGroup_46184_TypeText|特遣纪录",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_06.png",
    BattleBuff = {
      1,
      "ResonanceGroup24"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15601
  },
  [46183] = {
    ID = 46183,
    CnID = "关卡组@「24」支线关卡癫狂",
    BaseSortID = 130,
    Type = 13,
    Name = "StageGroup_46183_Name|宁静的裂殖",
    Desc = "StageGroup_46183_Desc|从不惹麻烦的梅森又惹上麻烦了。\n等等，让我们先确认一下，惹上麻烦的是哪一个「梅森」？",
    TypeText = "StageGroup_46183_TypeText|特遣纪录",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_06.png",
    BattleBuff = {
      1,
      "ResonanceGroup24"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15601
  },
  [55455] = {
    ID = 55455,
    CnID = "关卡组@奥尔拉支线关卡普通",
    BaseSortID = 131,
    Type = 11,
    Name = "StageGroup_55455_Name|玫瑰的栖居",
    Desc = "StageGroup_55455_Desc|所有的文字都化为灰烬，所有的花瓣都零落成泥。\n呼吸着花园的余焰，让我再为你献上一首诗吧。\n在人们荒寂的心脏里，玫瑰正殷红地栖居。",
    HardMode = {55454, 55453},
    TypeText = "StageGroup_55455_TypeText|特遣纪录",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_07.png",
    BattleBuff = {
      1,
      "ResonanceGroupHorla"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageDisplayDate = 1721005200,
    RelatedAwaker = 15583,
    BestExperienceCondition = {7755},
    PromptNumber = "20130",
    UnlockItem = {36863, 7},
    UnlockCompensation = {
      "HorlaActivity",
      20160,
      55128,
      700
    }
  },
  [55454] = {
    ID = 55454,
    CnID = "关卡组@奥尔拉支线关卡困难",
    BaseSortID = 132,
    Type = 12,
    Name = "StageGroup_55454_Name|玫瑰的栖居",
    Desc = "StageGroup_55454_Desc|所有的文字都化为灰烬，所有的花瓣都零落成泥。\n呼吸着花园的余焰，让我再为你献上一首诗吧。\n在人们荒寂的心脏里，玫瑰正殷红地栖居。",
    TypeText = "StageGroup_55454_TypeText|特遣纪录",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_07.png",
    BattleBuff = {
      1,
      "ResonanceGroupHorla"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15583
  },
  [55453] = {
    ID = 55453,
    CnID = "关卡组@奥尔拉支线关卡癫狂",
    BaseSortID = 133,
    Type = 13,
    Name = "StageGroup_55453_Name|玫瑰的栖居",
    Desc = "StageGroup_55453_Desc|所有的文字都化为灰烬，所有的花瓣都零落成泥。\n呼吸着花园的余焰，让我再为你献上一首诗吧。\n在人们荒寂的心脏里，玫瑰正殷红地栖居。",
    TypeText = "StageGroup_55453_TypeText|特遣纪录",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_07.png",
    BattleBuff = {
      1,
      "ResonanceGroupHorla"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15583
  },
  [56441] = {
    ID = 56441,
    CnID = "关卡组@莱克支线关卡普通",
    BaseSortID = 134,
    Type = 11,
    Name = "StageGroup_56441_Name|狩猎愉快！",
    Desc = "StageGroup_56441_Desc|守密人意外踏入由「祂」设下的棋局。\n红月、古宅、暴风雪和各怀鬼胎的参与者……\n心与脑的较量，即刻拉开序幕。",
    HardMode = {56446, 56440},
    TypeText = "StageGroup_56441_TypeText|特遣纪录",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_08.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageDisplayDate = 1723424400,
    RelatedAwaker = 15604,
    BestExperienceCondition = {48069},
    PromptNumber = "BestExperienceTips_Chapter7",
    UnlockItem = {36863, 7},
    UnlockCompensation = {
      "RykerActivity",
      20160,
      56484,
      700
    }
  },
  [56446] = {
    ID = 56446,
    CnID = "关卡组@莱克支线关卡困难",
    BaseSortID = 135,
    Type = 12,
    Name = "StageGroup_56446_Name|狩猎愉快！",
    Desc = "StageGroup_56446_Desc|守密人意外踏入由「祂」设下的棋局。\n红月、古宅、暴风雪和各怀鬼胎的参与者……\n心与脑的较量，即刻拉开序幕。",
    TypeText = "StageGroup_56446_TypeText|特遣纪录",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_08.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15604
  },
  [56440] = {
    ID = 56440,
    CnID = "关卡组@莱克支线关卡癫狂",
    BaseSortID = 136,
    Type = 13,
    Name = "StageGroup_56440_Name|狩猎愉快！",
    Desc = "StageGroup_56440_Desc|守密人意外踏入由「祂」设下的棋局。\n红月、古宅、暴风雪和各怀鬼胎的参与者……\n心与脑的较量，即刻拉开序幕。",
    TypeText = "StageGroup_56440_TypeText|特遣纪录",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_08.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15604
  },
  [56443] = {
    ID = 56443,
    CnID = "关卡组@本源希洛支线关卡普通",
    BaseSortID = 137,
    Type = 11,
    Name = "StageGroup_56443_Name|艾尔沃斯的归人",
    Desc = "StageGroup_56443_Desc|大雪掩埋着群山静谧的呼吸，和归人们各自追寻的命运。\n终年苦寒的艾尔沃斯，战士举起了手中的剑。\n她将为之战斗的，是她生命中的第一个春天。",
    HardMode = {56445, 56447},
    TypeText = "StageGroup_56443_TypeText|特遣纪录",
    Sequence = 8,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_05.png",
    BattleBuff = {
      1,
      "ResonanceGroupOriginHelot"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageDisplayDate = 1728262800,
    RelatedAwaker = 15567,
    BestExperienceCondition = {7869},
    PromptNumber = "20111",
    UnlockItem = {36863, 7},
    UnlockCompensation = {
      "OriginHelotActivity",
      20160,
      56490,
      700
    }
  },
  [56445] = {
    ID = 56445,
    CnID = "关卡组@本源希洛支线关卡困难",
    BaseSortID = 138,
    Type = 12,
    Name = "StageGroup_56445_Name|艾尔沃斯的归人",
    Desc = "StageGroup_56445_Desc|大雪掩埋着群山静谧的呼吸，和归人们各自追寻的命运。\n终年苦寒的艾尔沃斯，战士举起了手中的剑。\n她将为之战斗的，是她生命中的第一个春天。",
    TypeText = "StageGroup_56445_TypeText|特遣纪录",
    Sequence = 8,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_05.png",
    BattleBuff = {
      1,
      "ResonanceGroupOriginHelot"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15567
  },
  [56447] = {
    ID = 56447,
    CnID = "关卡组@本源希洛支线关卡癫狂",
    BaseSortID = 139,
    Type = 13,
    Name = "StageGroup_56447_Name|艾尔沃斯的归人",
    Desc = "StageGroup_56447_Desc|大雪掩埋着群山静谧的呼吸，和归人们各自追寻的命运。\n终年苦寒的艾尔沃斯，战士举起了手中的剑。\n她将为之战斗的，是她生命中的第一个春天。",
    TypeText = "StageGroup_56447_TypeText|特遣纪录",
    Sequence = 8,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_05.png",
    BattleBuff = {
      1,
      "ResonanceGroupOriginHelot"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15567
  },
  [120952] = {
    ID = 120952,
    CnID = "关卡组@2周年支线关卡普通",
    BaseSortID = 140,
    Type = 11,
    Name = "StageGroup_120952_Name|群星咏叹调",
    Desc = "StageGroup_120952_Desc|维度的另一头，久别的故乡传来微弱的呼唤。\n神明的意识再次投来毁灭的注视，阻挡它，战胜它，跨越遥远的时空，再次站在彼此身前。\n约定，在这条漫长、黑暗的旅途里，它将是唯一指引我们的光点。",
    HardMode = {120951, 120953},
    TypeText = "StageGroup_120952_TypeText|特遣纪录",
    Sequence = 9,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_09.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageDisplayDate = 1764550800,
    RelatedAwaker = 15595,
    BestExperienceCondition = {118146},
    PromptNumber = "BestExperienceTips_ChapterS4",
    UnlockItem = {36863, 7},
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    },
    AdjustNeedActivityOpen = {120954}
  },
  [120951] = {
    ID = 120951,
    CnID = "关卡组@2周年支线关卡困难",
    BaseSortID = 141,
    Type = 12,
    Name = "StageGroup_120951_Name|群星咏叹调",
    Desc = "StageGroup_120951_Desc|维度的另一头，久别的故乡传来微弱的呼唤。\n神明的意识再次投来毁灭的注视，阻挡它，战胜它，跨越遥远的时空，再次站在彼此身前。\n约定，在这条漫长、黑暗的旅途里，它将是唯一指引我们的光点。",
    TypeText = "StageGroup_120951_TypeText|特遣纪录",
    Sequence = 9,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_09.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    RelatedAwaker = 15595,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    },
    AdjustNeedActivityOpen = {120954}
  },
  [120953] = {
    ID = 120953,
    CnID = "关卡组@2周年支线关卡癫狂",
    BaseSortID = 142,
    Type = 13,
    Name = "StageGroup_120953_Name|群星咏叹调",
    Desc = "StageGroup_120953_Desc|维度的另一头，久别的故乡传来微弱的呼唤。\n神明的意识再次投来毁灭的注视，阻挡它，战胜它，跨越遥远的时空，再次站在彼此身前。\n约定，在这条漫长、黑暗的旅途里，它将是唯一指引我们的光点。",
    TypeText = "StageGroup_120953_TypeText|特遣纪录",
    Sequence = 9,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_09.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    RelatedAwaker = 15595
  },
  [129506] = {
    ID = 129506,
    CnID = "关卡组@26年春节活动支线关卡普通",
    BaseSortID = 143,
    Type = 11,
    Name = "StageGroup_129506_Name|开往祈岁节的列车",
    Desc = "StageGroup_129506_Desc|家，甜蜜的家。\n依据磐龙古国的风俗，岁初之时，离家的游子将乘上拥挤的列车，风尘仆仆地穿过晨雾与远山，拥抱久别重逢的亲爱之人。\n你也不例外。",
    TypeText = "StageGroup_129506_TypeText|特遣纪录",
    Sequence = 10,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_SpecialOps_Com_10.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Bg_Subplot_Railway.png"
    },
    StageDisplayDate = 1770598800,
    BestExperienceCondition = {125646},
    PromptNumber = "BestExperienceTips_ChapterS5",
    UnlockItem = {36863, 7}
  },
  [20452] = {
    ID = 20452,
    CnID = "关卡组@奥吉尔支线关卡普通",
    BaseSortID = 144,
    Type = 14,
    Name = "StageGroup_20452_Name|骑士的愿望",
    Desc = "StageGroup_20452_Desc|灵与心的共振让你得以进入他们的记忆，进入他们的梦。\n亲历爱与痛苦，目击壮烈与温情吧。如此，你才理解情感之磅礴。",
    HardMode = {20454, 20449},
    TypeText = "StageGroup_20452_TypeText|意识潜游",
    Sequence = 0,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Chaos.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15585
  },
  [20454] = {
    ID = 20454,
    CnID = "关卡组@奥吉尔支线关卡困难",
    BaseSortID = 145,
    Type = 15,
    Name = "StageGroup_20454_Name|骑士的愿望",
    Desc = "StageGroup_20454_Desc|灵与心的共振让你得以进入他们的记忆，进入他们的梦。\n亲历爱与痛苦，目击壮烈与温情吧。如此，你才理解情感之磅礴。",
    TypeText = "StageGroup_20454_TypeText|意识潜游",
    Sequence = 0,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Chaos.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15585
  },
  [20449] = {
    ID = 20449,
    CnID = "关卡组@奥吉尔支线关卡癫狂",
    BaseSortID = 146,
    Type = 16,
    Name = "StageGroup_20449_Name|骑士的愿望",
    Desc = "StageGroup_20449_Desc|灵与心的共振让你得以进入他们的记忆，进入他们的梦。\n亲历爱与痛苦，目击壮烈与温情吧。如此，你才理解情感之磅礴。",
    TypeText = "StageGroup_20449_TypeText|意识潜游",
    Sequence = 0,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Chaos.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15585
  },
  [20223] = {
    ID = 20223,
    CnID = "关卡组@珊支线关卡普通",
    BaseSortID = 147,
    Type = 14,
    Name = "StageGroup_20223_Name|如歌的雕琢",
    Desc = "StageGroup_20223_Desc|侍女卡米耶在五岁时被带到小姐珊的面前。\n 珊就像雕塑一般美丽、若即若离。她迎着日光对卡米耶微笑。\n 从那天起，卡米耶许下心愿：我们要永远在一起。",
    HardMode = {20224, 20222},
    TypeText = "StageGroup_20223_TypeText|意识潜游",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Aequor.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15592,
    BestExperienceCondition = {8030, 20435},
    PromptNumber = "20129",
    UnlockItem = {36863, 3}
  },
  [20224] = {
    ID = 20224,
    CnID = "关卡组@珊支线关卡困难",
    BaseSortID = 148,
    Type = 15,
    Name = "StageGroup_20224_Name|如歌的雕琢",
    Desc = "StageGroup_20224_Desc|侍女卡米耶在五岁时被带到小姐珊的面前。\n 珊就像雕塑一般美丽、若即若离。她迎着日光对卡米耶微笑。\n 从那天起，卡米耶许下心愿：我们要永远在一起。",
    TypeText = "StageGroup_20224_TypeText|意识潜游",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Aequor.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15592
  },
  [20222] = {
    ID = 20222,
    CnID = "关卡组@珊支线关卡癫狂",
    BaseSortID = 149,
    Type = 16,
    Name = "StageGroup_20222_Name|如歌的雕琢",
    Desc = "StageGroup_20222_Desc|侍女卡米耶在五岁时被带到小姐珊的面前。\n 珊就像雕塑一般美丽、若即若离。她迎着日光对卡米耶微笑。\n 从那天起，卡米耶许下心愿：我们要永远在一起。",
    TypeText = "StageGroup_20222_TypeText|意识潜游",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Aequor.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15592
  },
  [15923] = {
    ID = 15923,
    CnID = "关卡组@尤乌哈希支线关卡普通",
    BaseSortID = 150,
    Type = 14,
    Name = "StageGroup_15923_Name|血与沙",
    Desc = "StageGroup_15923_Desc|根据官方记载，共计三千余人参与了第@1次神圣东征。\n圣徒们的目标不尽相同，有人为了生计，有人为了复仇。\n还有人为了杀戮。",
    HardMode = {15888, 15960},
    TypeText = "StageGroup_15923_TypeText|意识潜游",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Caro.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15598,
    BestExperienceCondition = {8030, 20435},
    PromptNumber = "20129",
    UnlockItem = {36863, 3}
  },
  [15888] = {
    ID = 15888,
    CnID = "关卡组@尤乌哈希支线关卡困难",
    BaseSortID = 151,
    Type = 15,
    Name = "StageGroup_15888_Name|血与沙",
    Desc = "StageGroup_15888_Desc|根据官方记载，共计三千余人参与了第@1次神圣东征。\n圣徒们的目标不尽相同，有人为了生计，有人为了复仇。\n还有人为了杀戮。",
    TypeText = "StageGroup_15888_TypeText|意识潜游",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Caro.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15598
  },
  [15960] = {
    ID = 15960,
    CnID = "关卡组@尤乌哈希支线关卡癫狂",
    BaseSortID = 152,
    Type = 16,
    Name = "StageGroup_15960_Name|血与沙",
    Desc = "StageGroup_15960_Desc|根据官方记载，共计三千余人参与了第@1次神圣东征。\n圣徒们的目标不尽相同，有人为了生计，有人为了复仇。\n还有人为了杀戮。",
    TypeText = "StageGroup_15960_TypeText|意识潜游",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Caro.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15598
  },
  [20448] = {
    ID = 20448,
    CnID = "关卡组@艾瑞卡支线关卡普通",
    BaseSortID = 153,
    Type = 14,
    Name = "StageGroup_20448_Name|扭曲核心",
    Desc = "StageGroup_20448_Desc|她是由弥萨格大学复原而成的人偶。\n 她的骨架是金属，她的心脏是银芯，她的结构无比精妙，即使对着设计图纸，也再难造出第二个。 \n而在她成为冰冷的机械前，她有着一颗人类的心。",
    HardMode = {20451, 20447},
    TypeText = "StageGroup_20448_TypeText|意识潜游",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Ultra.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15603,
    BestExperienceCondition = {8030, 20435},
    PromptNumber = "20129",
    UnlockItem = {36863, 3}
  },
  [20451] = {
    ID = 20451,
    CnID = "关卡组@艾瑞卡支线关卡困难",
    BaseSortID = 154,
    Type = 15,
    Name = "StageGroup_20451_Name|扭曲核心",
    Desc = "StageGroup_20451_Desc|她是由弥萨格大学复原而成的人偶。\n 她的骨架是金属，她的心脏是银芯，她的结构无比精妙，即使对着设计图纸，也再难造出第二个。 \n而在她成为冰冷的机械前，她有着一颗人类的心。",
    TypeText = "StageGroup_20451_TypeText|意识潜游",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Ultra.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15603
  },
  [20447] = {
    ID = 20447,
    CnID = "关卡组@艾瑞卡支线关卡癫狂",
    BaseSortID = 155,
    Type = 16,
    Name = "StageGroup_20447_Name|扭曲核心",
    Desc = "StageGroup_20447_Desc|她是由弥萨格大学复原而成的人偶。\n 她的骨架是金属，她的心脏是银芯，她的结构无比精妙，即使对着设计图纸，也再难造出第二个。 \n而在她成为冰冷的机械前，她有着一颗人类的心。",
    TypeText = "StageGroup_20447_TypeText|意识潜游",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Ultra.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15603
  },
  [20446] = {
    ID = 20446,
    CnID = "关卡组@阿格里帕支线关卡普通",
    BaseSortID = 156,
    Type = 14,
    Name = "StageGroup_20446_Name|苍白后裔",
    Desc = "StageGroup_20446_Desc|相传在伦蒂尼恩的地下，有一扇唯一的门。\n 它通向苍白之主的所在……",
    HardMode = {20453, 20450},
    TypeText = "StageGroup_20446_TypeText|意识潜游",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Caro.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15600,
    BestExperienceCondition = {8030, 20435},
    PromptNumber = "20129",
    UnlockItem = {36863, 3}
  },
  [20453] = {
    ID = 20453,
    CnID = "关卡组@阿格里帕支线关卡困难",
    BaseSortID = 157,
    Type = 15,
    Name = "StageGroup_20453_Name|苍白后裔",
    Desc = "StageGroup_20453_Desc|相传在伦蒂尼恩的地下，有一扇唯一的门。\n 它通向苍白之主的所在……",
    TypeText = "StageGroup_20453_TypeText|意识潜游",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Caro.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15600
  },
  [20450] = {
    ID = 20450,
    CnID = "关卡组@阿格里帕支线关卡癫狂",
    BaseSortID = 158,
    Type = 16,
    Name = "StageGroup_20450_Name|苍白后裔",
    Desc = "StageGroup_20450_Desc|相传在伦蒂尼恩的地下，有一扇唯一的门。\n 它通向苍白之主的所在……",
    TypeText = "StageGroup_20450_TypeText|意识潜游",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Caro.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15600
  },
  [24553] = {
    ID = 24553,
    CnID = "关卡组@本源拉蒙娜支线关卡普通",
    BaseSortID = 159,
    Type = 14,
    Name = "StageGroup_24553_Name|一步之遥",
    Desc = "StageGroup_24553_Desc|你向前一步，跨入了另一个时空。",
    HardMode = {24554, 24552},
    TypeText = "StageGroup_24553_TypeText|意识潜游",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_RamonaTimeworn.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15568,
    BestExperienceCondition = {7869, 20435},
    PromptNumber = "20238",
    UnlockItem = {36863, 3}
  },
  [24554] = {
    ID = 24554,
    CnID = "关卡组@本源拉蒙娜支线关卡困难",
    BaseSortID = 160,
    Type = 15,
    Name = "StageGroup_24554_Name|一步之遥",
    Desc = "StageGroup_24554_Desc|你向前一步，跨入了另一个时空。",
    TypeText = "StageGroup_24554_TypeText|意识潜游",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_RamonaTimeworn.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15568
  },
  [24552] = {
    ID = 24552,
    CnID = "关卡组@本源拉蒙娜支线关卡癫狂",
    BaseSortID = 161,
    Type = 16,
    Name = "StageGroup_24552_Name|一步之遥",
    Desc = "StageGroup_24552_Desc|你向前一步，跨入了另一个时空。",
    TypeText = "StageGroup_24552_TypeText|意识潜游",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_RamonaTimeworn.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15568
  },
  [35545] = {
    ID = 35545,
    CnID = "关卡组@奥瑞塔支线关卡普通",
    BaseSortID = 162,
    Type = 14,
    Name = "StageGroup_35545_Name|诸事如常",
    Desc = "StageGroup_35545_Desc|这是奥瑞塔生命中平常的一天，平常得一如灾难降临后，她独自度过的每一天。",
    HardMode = {35546, 35544},
    TypeText = "StageGroup_35545_TypeText|意识潜游",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Aequor.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageDisplayDate = 1709758800,
    RelatedAwaker = 15573,
    BestExperienceCondition = {8030, 20435},
    PromptNumber = "20129",
    UnlockItem = {36863, 3}
  },
  [35546] = {
    ID = 35546,
    CnID = "关卡组@奥瑞塔支线关卡困难",
    BaseSortID = 163,
    Type = 15,
    Name = "StageGroup_35546_Name|诸事如常",
    Desc = "StageGroup_35546_Desc|这是奥瑞塔生命中平常的一天，平常得一如灾难降临后，她独自度过的每一天。",
    TypeText = "StageGroup_35546_TypeText|意识潜游",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Aequor.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15573
  },
  [35544] = {
    ID = 35544,
    CnID = "关卡组@奥瑞塔支线关卡癫狂",
    BaseSortID = 164,
    Type = 16,
    Name = "StageGroup_35544_Name|诸事如常",
    Desc = "StageGroup_35544_Desc|这是奥瑞塔生命中平常的一天，平常得一如灾难降临后，她独自度过的每一天。",
    TypeText = "StageGroup_35544_TypeText|意识潜游",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Aequor.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15573
  },
  [36627] = {
    ID = 36627,
    CnID = "关卡组@旺达支线关卡普通",
    BaseSortID = 165,
    Type = 14,
    Name = "StageGroup_36627_Name|燃烧的群宴",
    Desc = "StageGroup_36627_Desc|这是一个修士与女王的故事。\n他们来自不同的时空，最后终将归于一处。",
    HardMode = {36625, 36626},
    TypeText = "StageGroup_36627_TypeText|意识潜游",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Ultra.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageDisplayDate = 1710378000,
    RelatedAwaker = 15586,
    BestExperienceCondition = {7755, 20435},
    PromptNumber = "20239",
    UnlockItem = {36863, 3},
    UnlockCompensation = {
      "WandaActivityReproduce",
      20160,
      38704,
      300
    }
  },
  [36625] = {
    ID = 36625,
    CnID = "关卡组@旺达支线关卡困难",
    BaseSortID = 166,
    Type = 15,
    Name = "StageGroup_36625_Name|燃烧的群宴",
    Desc = "StageGroup_36625_Desc|这是一个修士与女王的故事。\n他们来自不同的时空，最后终将归于一处。",
    TypeText = "StageGroup_36625_TypeText|意识潜游",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Ultra.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15586
  },
  [36626] = {
    ID = 36626,
    CnID = "关卡组@旺达支线关卡癫狂",
    BaseSortID = 167,
    Type = 16,
    Name = "StageGroup_36626_Name|燃烧的群宴",
    Desc = "StageGroup_36626_Desc|这是一个修士与女王的故事。\n他们来自不同的时空，最后终将归于一处。",
    TypeText = "StageGroup_36626_TypeText|意识潜游",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Ultra.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15586
  },
  [43517] = {
    ID = 43517,
    CnID = "关卡组@戈利亚支线关卡普通",
    BaseSortID = 168,
    Type = 14,
    Name = "StageGroup_43517_Name|巨人的陨落",
    Desc = "StageGroup_43517_Desc|无尽的海洋、烈日，被流放的非利士英雄和他唯一的随从。\n这是一个关于「陨落」的故事。",
    HardMode = {43515, 43516},
    TypeText = "StageGroup_43517_TypeText|意识潜游",
    Sequence = 8,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Aequor.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageDisplayDate = 1713402000,
    RelatedAwaker = 15564,
    BestExperienceCondition = {35857, 20435},
    PromptNumber = "20131",
    UnlockItem = {36863, 3}
  },
  [43515] = {
    ID = 43515,
    CnID = "关卡组@戈利亚支线关卡困难",
    BaseSortID = 169,
    Type = 15,
    Name = "StageGroup_43515_Name|巨人的陨落",
    Desc = "StageGroup_43515_Desc|无尽的海洋、烈日，被流放的非利士英雄和他唯一的随从。\n这是一个关于「陨落」的故事。",
    TypeText = "StageGroup_43515_TypeText|意识潜游",
    Sequence = 8,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Aequor.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15564
  },
  [43516] = {
    ID = 43516,
    CnID = "关卡组@戈利亚支线关卡癫狂",
    BaseSortID = 170,
    Type = 16,
    Name = "StageGroup_43516_Name|巨人的陨落",
    Desc = "StageGroup_43516_Desc|无尽的海洋、烈日，被流放的非利士英雄和他唯一的随从。\n这是一个关于「陨落」的故事。",
    TypeText = "StageGroup_43516_TypeText|意识潜游",
    Sequence = 8,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Aequor.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    RelatedAwaker = 15564
  },
  [71850] = {
    ID = 71850,
    CnID = "关卡组@图鲁支线关卡普通",
    BaseSortID = 171,
    Type = 14,
    Name = "StageGroup_71850_Name|加冕之日",
    Desc = "StageGroup_71850_Desc|荣耀、敬仰、无限的权力，王的位置至高无上。\n登上王座所需要的只是被神选中。\n那么，这一切会付出怎样的代价呢？",
    TypeText = "StageGroup_71850_TypeText|意识潜游",
    Sequence = 9,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Aequor.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    StageDisplayDate = 1736730000,
    RelatedAwaker = 15563,
    BestExperienceCondition = {22313, 20435},
    PromptNumber = "SubBestExperienceTips_Chapter5",
    UnlockItem = {36863, 3},
    UnlockCompensation = {
      "TuluActivity",
      20160,
      68421,
      300
    }
  },
  [51755] = {
    ID = 51755,
    CnID = "关卡组@弥利亚姆支线关卡普通",
    BaseSortID = 172,
    Type = 102,
    Name = "StageGroup_51755_Name|亵渎",
    Desc = "StageGroup_51755_Desc|一个海洋死去了，她埋葬海的尸体。\n深海的倒影上，王的梦境消散，神的国度也已腐朽。\n她看见，自己从旧日的幻梦中走来，走入未来坍塌的废墟。\n她询问深渊，深渊缄默不语。\n她向深渊祭祀，回应她的，只有她自己。",
    TypeText = "StageGroup_51755_TypeText|异梦视界",
    Sequence = 0,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_Dreamscape_Com.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    DailyIcon = {
      "UI/UI_Chapter/UI_Chapter_Prefab/Optimized/UI_Chapter_Item_Dream_01.prefab"
    },
    RelatedAwaker = 15582,
    BestExperienceCondition = {35857},
    PromptNumber = "20251",
    UnlockItem = {36863, 7},
    UnlockCompensation = {
      "MiryamActivityReproduce",
      20160,
      52039,
      700
    }
  },
  [74237] = {
    ID = 74237,
    CnID = "关卡组@莉兹支线关卡普通",
    BaseSortID = 173,
    Type = 14,
    Name = "StageGroup_74237_Name|热情归尘",
    Desc = "StageGroup_74237_Desc|火光焚天的那一夜，不止有她的艺术获得了新生。",
    HardMode = {74236, 74238},
    TypeText = "StageGroup_74237_TypeText|意识潜游",
    Sequence = 11,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Ultra.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageDisplayDate = 1748221200,
    RelatedAwaker = 15562,
    BestExperienceCondition = {8030, 20435},
    PromptNumber = "20129",
    UnlockItem = {36863, 3}
  },
  [74236] = {
    ID = 74236,
    CnID = "关卡组@莉兹支线关卡困难",
    BaseSortID = 174,
    Type = 15,
    Name = "StageGroup_74236_Name|热情归尘",
    Desc = "StageGroup_74236_Desc|火光焚天的那一夜，不止有她的艺术获得了新生。",
    TypeText = "StageGroup_74236_TypeText|意识潜游",
    Sequence = 11,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Ultra.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    RelatedAwaker = 15562
  },
  [74238] = {
    ID = 74238,
    CnID = "关卡组@莉兹支线关卡癫狂",
    BaseSortID = 175,
    Type = 16,
    Name = "StageGroup_74238_Name|热情归尘",
    Desc = "StageGroup_74238_Desc|火光焚天的那一夜，不止有她的艺术获得了新生。",
    TypeText = "StageGroup_74238_TypeText|意识潜游",
    Sequence = 11,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Ultra.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    RelatedAwaker = 15562
  },
  [81262] = {
    ID = 81262,
    CnID = "关卡组@克珀珊特支线关卡普通",
    BaseSortID = 176,
    Type = 14,
    Name = "StageGroup_81262_Name|最后的引航",
    Desc = "StageGroup_81262_Desc|这本该是一场充满欢声笑语的航行。\n豪华的游轮，梭巡大西洋，载着胜利品，载着人们征服海洋的野望。\n但海洋有自己的脾气。\n在远超理解的恐怖与未知面前，人类，终究渺小如蝼蚁。",
    TypeText = "StageGroup_81262_TypeText|意识潜游",
    Sequence = 10,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Aequor.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageDisplayDate = 1746406800,
    RelatedAwaker = 77922,
    BestExperienceCondition = {70928, 20435},
    PromptNumber = "20230",
    UnlockItem = {36863, 3},
    UnlockCompensation = {
      "StElmosFireActivity",
      20160,
      81250,
      300
    }
  },
  [95184] = {
    ID = 95184,
    CnID = "关卡组@凯蒂古拉支线关卡普通",
    BaseSortID = 177,
    Type = 14,
    Name = "StageGroup_95184_Name|不朽极昼",
    Desc = "StageGroup_95184_Desc|琥珀色的火焰盛开，犹如一场辉煌的葬礼。\n爆燃之主于死亡中降生，那里埋葬了她曾经的世界。",
    TypeText = "StageGroup_95184_TypeText|意识潜游",
    Sequence = 12,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Chaos.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageDisplayDate = 1755478800,
    RelatedAwaker = 77913,
    BestExperienceCondition = {80242, 20435},
    PromptNumber = "SubBestExperienceTips_ChapterS2",
    UnlockItem = {36863, 3},
    UnlockCompensation = {
      "KathiguRaActivity",
      20160,
      95120,
      300
    }
  },
  [96834] = {
    ID = 96834,
    CnID = "关卡组@皮克曼支线关卡普通",
    BaseSortID = 178,
    Type = 14,
    Name = "StageGroup_96834_Name|畸世绘",
    Desc = "StageGroup_96834_Desc|狂躁的线条，混乱的构图，狰狞的色彩，疯狂的意象……\n画里还是画外？真实还是虚幻？没有人真的想知道答案。\n动物们想要的，不过一场狂欢。",
    TypeText = "StageGroup_96834_TypeText|意识潜游",
    Sequence = 13,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Caro.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageDisplayDate = 1757293200,
    RelatedAwaker = 77926,
    BestExperienceCondition = {90680, 20435},
    PromptNumber = "20231",
    UnlockItem = {36863, 3},
    UnlockCompensation = {
      "PickManActivity",
      20160,
      96827,
      300
    }
  },
  [125338] = {
    ID = 125338,
    CnID = "关卡组@徐支线关卡普通",
    BaseSortID = 179,
    Type = 14,
    Name = "StageGroup_125338_Name|扇下夜谈",
    Desc = "StageGroup_125338_Desc|华灯初上，四下荒寂。\n注视吧，注视着那双美丽的眼睛。\n然后温顺地依从，温顺地匍匐，温顺地步入那片缠绵的夜雾。",
    TypeText = "StageGroup_125338_TypeText|意识潜游",
    Sequence = 14,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Caro.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageDisplayDate = 1769389200,
    RelatedAwaker = 125346,
    BestExperienceCondition = {80242, 20435},
    PromptNumber = "SubBestExperienceTips_ChapterS2",
    UnlockItem = {36863, 3},
    UnlockCompensation = {
      "XuActivity",
      20160,
      125173,
      300
    }
  },
  [130895] = {
    ID = 130895,
    CnID = "关卡组@莫丝支线关卡普通",
    BaseSortID = 180,
    Type = 14,
    Name = "StageGroup_130895_Name|沉溺",
    Desc = "StageGroup_130895_Desc|贪婪的赐予更多，容易满足的，将其本拥有的全部拿走。\n当我们凝望海洋，凝望的并非只是祂的浩瀚与美，海洋吞没记忆，海洋吞没恐惧，洋流的所有汇聚都转瞬即逝。\n海洋在呼唤你，没入永恒孤独的沉寂。",
    TypeText = "StageGroup_130895_TypeText|意识潜游",
    Sequence = 15,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Aequor.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageDisplayDate = 1773018000,
    RelatedAwaker = 130901,
    BestExperienceCondition = {8045, 20435},
    PromptNumber = "SubBestExperienceTips_Chapter3",
    UnlockItem = {36863, 3},
    UnlockCompensation = {
      "MoskActivity",
      20160,
      130742,
      300
    }
  },
  [141292] = {
    ID = 141292,
    CnID = "关卡组@庞托斯支线关卡普通",
    BaseSortID = 181,
    Type = 14,
    Name = "StageGroup_141292_Name|永远的厄波扬斯",
    Desc = "StageGroup_141292_Desc|我们准备了两个故事。\n在其中一个故事里，你度过了漫长的、幸福的一生。",
    HardMode = {143317, 143316},
    TypeText = "StageGroup_141292_TypeText|意识潜游",
    Sequence = 16,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Aequor.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageDisplayDate = 1782694800,
    RelatedAwaker = 141302,
    BestExperienceCondition = {70928, 20435},
    PromptNumber = "20230",
    UnlockItem = {36863, 3},
    UnlockCompensation = {
      "PontosActivity",
      20160,
      141230,
      300
    }
  },
  [143317] = {
    ID = 143317,
    CnID = "关卡组@庞托斯支线关卡困难",
    BaseSortID = 182,
    Type = 15,
    Name = "StageGroup_143317_Name|永远的厄波扬斯",
    Desc = "StageGroup_143317_Desc|我们准备了两个故事。\n在其中一个故事里，你度过了漫长的、幸福的一生。",
    TypeText = "StageGroup_143317_TypeText|意识潜游",
    Sequence = 16,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Aequor.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    RelatedAwaker = 141302
  },
  [143316] = {
    ID = 143316,
    CnID = "关卡组@庞托斯支线关卡癫狂",
    BaseSortID = 183,
    Type = 16,
    Name = "StageGroup_143316_Name|永远的厄波扬斯",
    Desc = "StageGroup_143316_Desc|我们准备了两个故事。\n在其中一个故事里，你度过了漫长的、幸福的一生。",
    TypeText = "StageGroup_143316_TypeText|意识潜游",
    Sequence = 16,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Aequor.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    RelatedAwaker = 141302
  },
  [145356] = {
    ID = 145356,
    CnID = "关卡组@蚀灭·萝坦支线关卡普通",
    BaseSortID = 184,
    Type = 14,
    Name = "StageGroup_145356_Name|直至鲸天陨落",
    Desc = "StageGroup_145356_Desc|一万两千年的等待，利维坦早已厌倦。\n诸王在祂脚下加冕，圣人在祂面前变得贪婪，英雄坦然沐浴祂无尽的权欲。浴血的王冠掉落，从一颗头颅到另一颗头颅。\n祂咀嚼那些千篇一律的戏码，如同吞噬星河中那些无味的尘埃。祂本以为，这就是祂永恒生命中将见到的全部。\n直到她来到祂的面前。",
    TypeText = "StageGroup_145356_TypeText|意识潜游",
    Sequence = 17,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Chaos.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageDisplayDate = 1785114000,
    RelatedAwaker = 145363,
    BestExperienceCondition = {80242, 20435},
    PromptNumber = "SubBestExperienceTips_ChapterS2",
    UnlockItem = {36863, 3},
    UnlockCompensation = {
      "LotanCetarchonActivity",
      20160,
      145276,
      300
    }
  },
  [146787] = {
    ID = 146787,
    CnID = "关卡组@本源奥吉尔支线关卡普通",
    BaseSortID = 185,
    Type = 14,
    Name = "StageGroup_146787_Name|五日谈",
    Desc = "StageGroup_146787_Desc|已过的世代，无人记念，将来的世代，后来的人也不记念。\n对逝去的执着犹如捕风，所以我恨恶生命。",
    TypeText = "StageGroup_146787_TypeText|意识潜游",
    Sequence = 18,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Chaos.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageDisplayDate = 1789952400,
    RelatedAwaker = 94451,
    UnlockItem = {36863, 3},
    UnlockCompensation = {
      "GenesisOgierActivity",
      20160,
      146872,
      300
    }
  },
  [146795] = {
    ID = 146795,
    CnID = "关卡组@本源奥吉尔支线关卡困难",
    BaseSortID = 186,
    Type = 15,
    Name = "StageGroup_146795_Name|五日谈",
    Desc = "StageGroup_146795_Desc|已过的世代，无人记念，将来的世代，后来的人也不记念。\n对逝去的执着犹如捕风，所以我恨恶生命。",
    TypeText = "StageGroup_146795_TypeText|意识潜游",
    Sequence = 18,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Chaos.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    RelatedAwaker = 94451
  },
  [146792] = {
    ID = 146792,
    CnID = "关卡组@本源奥吉尔支线关卡癫狂",
    BaseSortID = 187,
    Type = 16,
    Name = "StageGroup_146792_Name|五日谈",
    Desc = "StageGroup_146792_Desc|已过的世代，无人记念，将来的世代，后来的人也不记念。\n对逝去的执着犹如捕风，所以我恨恶生命。",
    TypeText = "StageGroup_146792_TypeText|意识潜游",
    Sequence = 18,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Chaos.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    RelatedAwaker = 94451
  },
  [147368] = {
    ID = 147368,
    CnID = "关卡组@暮星·汀克特支线关卡普通",
    BaseSortID = 188,
    Type = 14,
    Name = "StageGroup_147368_Name|临时文本",
    Desc = "StageGroup_147368_Desc|临时文本",
    TypeText = "StageGroup_147368_TypeText|意识潜游",
    Sequence = 18,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Chaos.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageDisplayDate = 1798419600,
    RelatedAwaker = 147397,
    UnlockItem = {36863, 3},
    UnlockCompensation = {
      "GenesisTinctActivity",
      20160,
      147274,
      300
    }
  },
  [147363] = {
    ID = 147363,
    CnID = "关卡组@暮星·汀克特支线关卡困难",
    BaseSortID = 189,
    Type = 15,
    Name = "StageGroup_147363_Name|临时文本",
    Desc = "StageGroup_147363_Desc|临时文本",
    TypeText = "StageGroup_147363_TypeText|意识潜游",
    Sequence = 18,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Chaos.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    RelatedAwaker = 147397
  },
  [147371] = {
    ID = 147371,
    CnID = "关卡组@暮星·汀克特支线关卡癫狂",
    BaseSortID = 190,
    Type = 16,
    Name = "StageGroup_147371_Name|临时文本",
    Desc = "StageGroup_147371_Desc|临时文本",
    TypeText = "StageGroup_147371_TypeText|意识潜游",
    Sequence = 18,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Chaos.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    RelatedAwaker = 147397
  },
  [143931] = {
    ID = 143931,
    CnID = "关卡组@太岁支线关卡普通",
    BaseSortID = 191,
    Type = 14,
    Name = "StageGroup_143931_Name|临时文本",
    Desc = "StageGroup_143931_Desc|临时文本",
    TypeText = "StageGroup_143931_TypeText|意识潜游",
    Sequence = 17,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_PsycheDeepdive_Chaos.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    StageDisplayDate = 1800838800,
    RelatedAwaker = 143941,
    BestExperienceCondition = {8045, 20435},
    PromptNumber = "SubBestExperienceTips_Chapter3",
    UnlockItem = {36863, 3},
    UnlockCompensation = {
      "TaisuiActivity",
      20160,
      143937,
      300
    }
  },
  [88934] = {
    ID = 88934,
    CnID = "关卡组@卡斯托尔支线关卡普通",
    BaseSortID = 192,
    Type = 102,
    Name = "StageGroup_88934_Name|天边之外·上",
    Desc = "StageGroup_88934_Desc|这是一首鸟儿对天空鸣唱的歌谣。\n外面的世界究竟是什么样？\n是否有忠诚的骑士与美丽的公主，有无垠的草原与神勇的骏马？\n去吧，去看看吧，今天就准备出发。\n咬断脚镣与栏杆，向着星空与月亮飞吧。\n不必害怕受伤与饥渴。\n那自由之路的尽头，必将充满清泉与鲜花。",
    TypeText = "StageGroup_88934_TypeText|异梦视界",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_Dreamscape_Com.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    DailyIcon = {
      "UI/UI_Chapter/UI_Chapter_Prefab/Optimized/UI_Chapter_Item_Dream_02.prefab"
    },
    StageDisplayDate = 1748826000,
    RelatedAwaker = 77923,
    BestExperienceCondition = {48069},
    PromptNumber = "BestExperienceTips_Chapter7",
    UnlockItem = {36863, 7},
    UnlockCompensation = {
      "CastorActivity",
      20160,
      88804,
      700
    }
  },
  [91021] = {
    ID = 91021,
    CnID = "关卡组@罗马支线关卡普通",
    BaseSortID = 193,
    Type = 102,
    Name = "StageGroup_91021_Name|征厨房记",
    Desc = "StageGroup_91021_Desc|这是一场源于饥饿的战争。\n我们以战士的名义起誓：厨房虽小，征之必胜。",
    TypeText = "StageGroup_91021_TypeText|异梦视界",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_Dreamscape_Com.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    DailyIcon = {
      "UI/UI_Chapter/UI_Chapter_Prefab/Optimized/UI_Chapter_Item_Dream_03.prefab"
    },
    StageDisplayDate = 1751245200,
    RelatedAwaker = 91769,
    BestExperienceCondition = {7663, 20430},
    PromptNumber = "20235",
    UnlockItem = {36863, 7},
    UnlockCompensation = {
      "RomeActivity",
      20160,
      90957,
      700
    }
  },
  [99734] = {
    ID = 99734,
    CnID = "关卡组@波吕克斯支线关卡普通",
    BaseSortID = 194,
    Type = 102,
    Name = "StageGroup_99734_Name|天边之外·下",
    Desc = "StageGroup_99734_Desc|这是一首鸟儿对天空鸣唱的歌谣。\n外面的世界究竟是什么样？\n是否有忠诚的骑士与美丽的公主，有无垠的草原与神勇的骏马？\n去吧，去看看吧，今天就准备出发。\n咬断脚镣与栏杆，向着星空与月亮飞吧。\n不必害怕受伤与饥渴。\n那自由之路的尽头，必将充满清泉与鲜花。",
    TypeText = "StageGroup_99734_TypeText|异梦视界",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_Dreamscape_Com.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    DailyIcon = {
      "UI/UI_Chapter/UI_Chapter_Prefab/Optimized/UI_Chapter_Item_Dream_02.prefab"
    },
    StageDisplayDate = 1760922000,
    RelatedAwaker = 77917,
    BestExperienceCondition = {89731},
    PromptNumber = "20252",
    UnlockItem = {36863, 7},
    UnlockCompensation = {
      "CastorActivity",
      20160,
      88804,
      700
    }
  },
  [94850] = {
    ID = 94850,
    CnID = "关卡组@夏日活动上支线关卡普通",
    BaseSortID = 195,
    Type = 102,
    Name = "StageGroup_94850_Name|再见永无乡",
    Desc = "StageGroup_94850_Desc|奇妙的幻想总被划分为儿童的特权，从而被排除在真实的规则外。 但在转身面对残酷的世界之前，你愿意在这里暂时忘掉一切。",
    HardMode = {97849},
    TypeText = "StageGroup_94850_TypeText|异梦视界",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_Dreamscape_Com.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    DailyIcon = {
      "UI/UI_Chapter/UI_Chapter_Prefab/Optimized/UI_Chapter_Item_Dream_02.prefab"
    },
    StageDisplayDate = 1756688400,
    RelatedAwaker = 116876,
    BestExperienceCondition = {90680},
    PromptNumber = "BestExperienceTips_ChapterS3",
    UnlockItem = {36863, 7},
    LevelAdjustment = {
      60,
      -1,
      -1,
      -1,
      -1,
      -1
    },
    PopupAvgTids = {98293},
    PopupAvgParams = {94860}
  },
  [97849] = {
    ID = 97849,
    CnID = "关卡组@夏日活动上支线关卡困难",
    BaseSortID = 196,
    Type = 104,
    Name = "StageGroup_97849_Name|再见永无乡",
    Desc = "StageGroup_97849_Desc|奇妙的幻想总被划分为儿童的特权，从而被排除在真实的规则外。 但在转身面对残酷的世界之前，你愿意在这里暂时忘掉一切。",
    TypeText = "StageGroup_97849_TypeText|异梦视界",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_Dreamscape_Com.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    DailyIcon = {
      "UI/UI_Chapter/UI_Chapter_Prefab/Optimized/UI_Chapter_Item_Dream_02.prefab"
    },
    StageDisplayDate = 1756688400,
    RelatedAwaker = 116876,
    LevelAdjustment = {
      70,
      -1,
      -1,
      -1,
      -1,
      -1
    }
  },
  [97852] = {
    ID = 97852,
    CnID = "关卡组@夏日活动下支线关卡普通",
    BaseSortID = 197,
    Type = 102,
    Name = "StageGroup_97852_Name|再见，永无乡",
    Desc = "StageGroup_97852_Desc|孩子会长大，梦会醒来，那些你日日牵挂的人啊，也在盼望着你的归来。",
    HardMode = {116228},
    TypeText = "StageGroup_97852_TypeText|异梦视界",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_Dreamscape_Com.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    DailyIcon = {
      "UI/UI_Chapter/UI_Chapter_Prefab/Optimized/UI_Chapter_Item_Dream_01.prefab",
      "UIResources/UIBigImages/UI_Chapter/UI_Chapter_Dream/Portrait_Dream_Summon2.png"
    },
    StageDisplayDate = 1759712400,
    RelatedAwaker = 116876,
    BestExperienceCondition = {90680},
    PromptNumber = "BestExperienceTips_ChapterS3",
    UnlockItem = {36863, 7},
    UnlockCompensation = {
      "SummerChapter2Activity",
      20160,
      97789,
      700
    }
  },
  [116228] = {
    ID = 116228,
    CnID = "关卡组@夏日活动下支线关卡困难",
    BaseSortID = 198,
    Type = 104,
    Name = "StageGroup_116228_Name|再见，永无乡",
    Desc = "StageGroup_116228_Desc|孩子会长大，梦会醒来，那些你日日牵挂的人啊，也在盼望着你的归来。",
    TypeText = "StageGroup_116228_TypeText|异梦视界",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_Dreamscape_Com.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    DailyIcon = {
      "UI/UI_Chapter/UI_Chapter_Prefab/Optimized/UI_Chapter_Item_Dream_01.prefab"
    },
    StageDisplayDate = 1759712400,
    RelatedAwaker = 116876
  },
  [74338] = {
    ID = 74338,
    CnID = "关卡组@逆转回合活动支线普通",
    BaseSortID = 199,
    Type = 105,
    Name = "StageGroup_74338_Name|逆转回合",
    Desc = "StageGroup_74338_Desc|相位对弈迎来了神秘存在，头生双角的少女向众人发起赌约。\n收集橡果，击败强敌，一切都为了将空间再次逆转。\n当划破长空的银光击破照耀万象的烈阳之时，少女才恍然明悟。\n原来她始终无法放下的，是来自过去的执念。\n镣铐已破，执念已除，结束旅途的少女，为朋友送上最真挚的祝福。",
    TypeText = "StageGroup_74338_TypeText|多维连接",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_MultiverseLink_Com.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0,
    DailyIcon = {
      "UI/UI_Chapter/UI_Chapter_Prefab/Optimized/UI_Chapter_Item_Special_01.prefab",
      "UIResources/UIBigImages/UI_Chapter/UI_Chapter_Dream/Portrait_Dream_PVPReRound.png",
      "UI_Chapter_LinkLogo_PVPReRound_CN"
    },
    StageDisplayDate = 1742259600,
    BestExperienceCondition = {8045},
    PromptNumber = "20237",
    UnlockItem = {36863, 3}
  },
  [122187] = {
    ID = 122187,
    CnID = "关卡组@茉夏支线关卡普通",
    BaseSortID = 200,
    Type = 105,
    Name = "StageGroup_122187_Name|银与血的洗礼",
    Desc = "StageGroup_122187_Desc|我的孩子，痛苦与悲伤如迷雾，遮住了你的眼。\n但不必忧心，若你想要自救，神必会救助于你，洗礼于你。\n哪怕是用银与血。",
    HardMode = {123115, 123114},
    TypeText = "StageGroup_122187_TypeText|多维连接",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_MultiverseLink_Com.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    DailyIcon = {
      "UI/UI_Chapter/UI_Chapter_Prefab/Optimized/UI_Chapter_Item_Special_02.prefab",
      0,
      "UI_Chapter_LinkLogo_Multiverse_COM"
    },
    StageDisplayDate = 1766970000,
    RelatedAwaker = 94450,
    BestExperienceCondition = {118146},
    PromptNumber = "BestExperienceTips_ChapterS4",
    UnlockItem = {36863, 3},
    UnlockCompensation = {
      "MouchetteActivity",
      20160,
      122263,
      300
    }
  },
  [123115] = {
    ID = 123115,
    CnID = "关卡组@茉夏支线关卡困难",
    BaseSortID = 201,
    Type = 106,
    Name = "StageGroup_123115_Name|银与血的洗礼",
    Desc = "StageGroup_123115_Desc|我的孩子，痛苦与悲伤如迷雾，遮住了你的眼。\n但不必忧心，若你想要自救，神必会救助于你，洗礼于你。\n哪怕是用银与血。",
    TypeText = "StageGroup_123115_TypeText|多维连接",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_MultiverseLink_Com.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    DailyIcon = {
      "UI/UI_Chapter/UI_Chapter_Prefab/Optimized/UI_Chapter_Item_Special_01.prefab"
    },
    RelatedAwaker = 94450
  },
  [123114] = {
    ID = 123114,
    CnID = "关卡组@茉夏支线关卡癫狂",
    BaseSortID = 202,
    Type = 107,
    Name = "StageGroup_123114_Name|银与血的洗礼",
    Desc = "StageGroup_123114_Desc|我的孩子，痛苦与悲伤如迷雾，遮住了你的眼。\n但不必忧心，若你想要自救，神必会救助于你，洗礼于你。\n哪怕是用银与血。",
    TypeText = "StageGroup_123114_TypeText|多维连接",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_MultiverseLink_Com.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    DailyIcon = {
      "UI/UI_Chapter/UI_Chapter_Prefab/Optimized/UI_Chapter_Item_Special_01.prefab"
    },
    RelatedAwaker = 94450
  },
  [130167] = {
    ID = 130167,
    CnID = "关卡组@沙耶支线关卡普通",
    BaseSortID = 203,
    Type = 105,
    Name = "StageGroup_130167_Name|被遗忘的爱之种",
    Desc = "StageGroup_130167_Desc|请你记得，\n那个早被遗忘的春天里，\n第一颗学会爱的种子。",
    HardMode = {140302, 140303},
    TypeText = "StageGroup_130167_TypeText|多维连接",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_MultiverseLink_Com.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    DailyIcon = {
      "UI/UI_Chapter/UI_Chapter_Prefab/Optimized/UI_Chapter_Item_Special_01.prefab",
      0,
      "UI_Chapter_LinkLogo_Saya_COM"
    },
    StageDisplayDate = 1780102800,
    RelatedAwaker = 130226,
    BestExperienceCondition = {48069},
    PromptNumber = "BestExperienceTips_Chapter7",
    UnlockItem = {36863, 3},
    UnlockCompensation = {
      "SayaActivity",
      20160,
      130049,
      300
    }
  },
  [140302] = {
    ID = 140302,
    CnID = "关卡组@沙耶支线关卡困难",
    BaseSortID = 204,
    Type = 106,
    Name = "StageGroup_140302_Name|被遗忘的爱之种",
    Desc = "StageGroup_140302_Desc|请你记得，\n那个早被遗忘的春天里，\n第一颗学会爱的种子。",
    TypeText = "StageGroup_140302_TypeText|多维连接",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_MultiverseLink_Com.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    DailyIcon = {
      "UI/UI_Chapter/UI_Chapter_Prefab/Optimized/UI_Chapter_Item_Special_01.prefab"
    },
    StageDisplayDate = 1780102800,
    RelatedAwaker = 130226
  },
  [140303] = {
    ID = 140303,
    CnID = "关卡组@沙耶支线关卡癫狂",
    BaseSortID = 205,
    Type = 107,
    Name = "StageGroup_140303_Name|被遗忘的爱之种",
    Desc = "StageGroup_140303_Desc|请你记得，\n那个早被遗忘的春天里，\n第一颗学会爱的种子。",
    TypeText = "StageGroup_140303_TypeText|多维连接",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Chapter_Bg_MultiverseLink_Com.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 0,
    DailyIcon = {
      "UI/UI_Chapter/UI_Chapter_Prefab/Optimized/UI_Chapter_Item_Special_01.prefab"
    },
    StageDisplayDate = 1780102800,
    RelatedAwaker = 130226
  },
  [15902] = {
    ID = 15902,
    CnID = "关卡组@周常挑战本第1层",
    BaseSortID = 206,
    Type = 5,
    Name = "StageGroup_15902_Name|混沌无光之境Ⅰ",
    Desc = "StageGroup_15902_Desc|它们在黑暗中扭曲、融合，然后被小心翼翼地保管在造像里。\n这是一次蓄谋已久的重逢。",
    TypeText = "StageGroup_15902_TypeText|无光之境",
    Sequence = 1,
    Backgrand = "Icon/CopyTitle/DoubleWeeklyChallenge1.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14347,
      6,
      14500,
      9,
      14172,
      12,
      14226,
      15,
      14502,
      18,
      14217,
      21,
      14508,
      24,
      14259
    },
    StageGroupDropPreview = {
      9567,
      9834,
      10108
    }
  },
  [15914] = {
    ID = 15914,
    CnID = "关卡组@周常挑战本第2层",
    BaseSortID = 207,
    Type = 6,
    Name = "StageGroup_15914_Name|混沌无光之境Ⅱ",
    Desc = "StageGroup_15914_Desc|来历不明的造像在黑暗中游荡、战栗。\n它们踏着古老的节拍，循着来自远方的笛声起舞。",
    TypeText = "StageGroup_15914_TypeText|无光之境",
    Sequence = 1,
    Backgrand = "Icon/CopyTitle/DoubleWeeklyChallenge1.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_D_Image_Battle_Icon.png"
    },
    StageGroupDrop = {
      3,
      14405,
      6,
      14274,
      9,
      14476,
      12,
      14310
    },
    StageGroupDropPreview = {
      9567,
      9834,
      10108
    }
  },
  [132467] = {
    ID = 132467,
    CnID = "关卡组@测试@忘却环境",
    BaseSortID = 208,
    Type = 99,
    Name = "StageGroup_132467_Name|忘却篇测试环境",
    Desc = "StageGroup_132467_Desc|内部测试专用",
    TypeText = "StageGroup_132467_TypeText|忘却篇测试环境",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [15944] = {
    ID = 15944,
    CnID = "关卡组@内部测试关卡组",
    BaseSortID = 209,
    Type = 99,
    Name = "StageGroup_15944_Name|测试关卡组",
    Desc = "StageGroup_15944_Desc|仅供占位，测试用",
    TypeText = "StageGroup_15944_TypeText|调查",
    Sequence = 1,
    Backgrand = "Icon/CopyTitle/DoubleWeeklyChallenge1.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [20305] = {
    ID = 20305,
    CnID = "关卡组@模拟战",
    BaseSortID = 210,
    Type = 20,
    Name = "StageGroup_20305_Name|模拟战",
    Desc = "StageGroup_20305_Desc|（临时文本）",
    TypeText = "StageGroup_20305_TypeText|模拟战",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [48737] = {
    ID = 48737,
    CnID = "关卡组@常驻角色试玩关卡",
    BaseSortID = 211,
    Type = 101,
    Name = "StageGroup_48737_Name|常驻角色试玩关卡",
    TypeText = "StageGroup_48737_TypeText|常驻试玩",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [34961] = {
    ID = 34961,
    CnID = "关卡组@融蚀深渊1期1",
    BaseSortID = 212,
    Type = 21,
    Name = "StageGroup_34961_Name|融灾禁区·第1波",
    TypeText = "StageGroup_34961_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [34963] = {
    ID = 34963,
    CnID = "关卡组@融蚀深渊1期2",
    BaseSortID = 213,
    Type = 21,
    Name = "StageGroup_34963_Name|融灾禁区·第2波",
    TypeText = "StageGroup_34963_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [34962] = {
    ID = 34962,
    CnID = "关卡组@融蚀深渊1期3",
    BaseSortID = 214,
    Type = 21,
    Name = "StageGroup_34962_Name|融灾禁区·第3波",
    TypeText = "StageGroup_34962_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [34959] = {
    ID = 34959,
    CnID = "关卡组@融蚀深渊1期4",
    BaseSortID = 215,
    Type = 21,
    Name = "StageGroup_34959_Name|融灾禁区·第4波",
    TypeText = "StageGroup_34959_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [34954] = {
    ID = 34954,
    CnID = "关卡组@融蚀深渊1期5",
    BaseSortID = 216,
    Type = 21,
    Name = "StageGroup_34954_Name|融灾禁区·第5波",
    TypeText = "StageGroup_34954_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [34960] = {
    ID = 34960,
    CnID = "关卡组@融蚀深渊2期1",
    BaseSortID = 217,
    Type = 21,
    Name = "StageGroup_34960_Name|融灾禁区·第1波",
    TypeText = "StageGroup_34960_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [34958] = {
    ID = 34958,
    CnID = "关卡组@融蚀深渊2期2",
    BaseSortID = 218,
    Type = 21,
    Name = "StageGroup_34958_Name|融灾禁区·第2波",
    TypeText = "StageGroup_34958_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [34956] = {
    ID = 34956,
    CnID = "关卡组@融蚀深渊2期3",
    BaseSortID = 219,
    Type = 21,
    Name = "StageGroup_34956_Name|融灾禁区·第3波",
    TypeText = "StageGroup_34956_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [34955] = {
    ID = 34955,
    CnID = "关卡组@融蚀深渊2期4",
    BaseSortID = 220,
    Type = 21,
    Name = "StageGroup_34955_Name|融灾禁区·第4波",
    TypeText = "StageGroup_34955_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [34957] = {
    ID = 34957,
    CnID = "关卡组@融蚀深渊2期5",
    BaseSortID = 221,
    Type = 21,
    Name = "StageGroup_34957_Name|融灾禁区·第5波",
    TypeText = "StageGroup_34957_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [36224] = {
    ID = 36224,
    CnID = "关卡组@融蚀深渊3期1",
    BaseSortID = 222,
    Type = 21,
    Name = "StageGroup_36224_Name|融灾禁区·第1波",
    TypeText = "StageGroup_36224_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [36223] = {
    ID = 36223,
    CnID = "关卡组@融蚀深渊3期2",
    BaseSortID = 223,
    Type = 21,
    Name = "StageGroup_36223_Name|融灾禁区·第2波",
    TypeText = "StageGroup_36223_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [36222] = {
    ID = 36222,
    CnID = "关卡组@融蚀深渊3期3",
    BaseSortID = 224,
    Type = 21,
    Name = "StageGroup_36222_Name|融灾禁区·第3波",
    TypeText = "StageGroup_36222_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [36226] = {
    ID = 36226,
    CnID = "关卡组@融蚀深渊3期4",
    BaseSortID = 225,
    Type = 21,
    Name = "StageGroup_36226_Name|融灾禁区·第4波",
    TypeText = "StageGroup_36226_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [36225] = {
    ID = 36225,
    CnID = "关卡组@融蚀深渊3期5",
    BaseSortID = 226,
    Type = 21,
    Name = "StageGroup_36225_Name|融灾禁区·第5波",
    TypeText = "StageGroup_36225_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [39308] = {
    ID = 39308,
    CnID = "关卡组@融蚀深渊4期1",
    BaseSortID = 227,
    Type = 21,
    Name = "StageGroup_39308_Name|融灾禁区·第1波",
    TypeText = "StageGroup_39308_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [39309] = {
    ID = 39309,
    CnID = "关卡组@融蚀深渊4期2",
    BaseSortID = 228,
    Type = 21,
    Name = "StageGroup_39309_Name|融灾禁区·第2波",
    TypeText = "StageGroup_39309_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [39310] = {
    ID = 39310,
    CnID = "关卡组@融蚀深渊4期3",
    BaseSortID = 229,
    Type = 21,
    Name = "StageGroup_39310_Name|融灾禁区·第3波",
    TypeText = "StageGroup_39310_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [39311] = {
    ID = 39311,
    CnID = "关卡组@融蚀深渊4期4",
    BaseSortID = 230,
    Type = 21,
    Name = "StageGroup_39311_Name|融灾禁区·第4波",
    TypeText = "StageGroup_39311_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [39312] = {
    ID = 39312,
    CnID = "关卡组@融蚀深渊4期5",
    BaseSortID = 231,
    Type = 21,
    Name = "StageGroup_39312_Name|融灾禁区·第5波",
    TypeText = "StageGroup_39312_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [43778] = {
    ID = 43778,
    CnID = "关卡组@融蚀深渊5期1",
    BaseSortID = 232,
    Type = 21,
    Name = "StageGroup_43778_Name|融灾禁区·第1波",
    TypeText = "StageGroup_43778_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [43780] = {
    ID = 43780,
    CnID = "关卡组@融蚀深渊5期2",
    BaseSortID = 233,
    Type = 21,
    Name = "StageGroup_43780_Name|融灾禁区·第2波",
    TypeText = "StageGroup_43780_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [43779] = {
    ID = 43779,
    CnID = "关卡组@融蚀深渊5期3",
    BaseSortID = 234,
    Type = 21,
    Name = "StageGroup_43779_Name|融灾禁区·第3波",
    TypeText = "StageGroup_43779_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [43782] = {
    ID = 43782,
    CnID = "关卡组@融蚀深渊5期4",
    BaseSortID = 235,
    Type = 21,
    Name = "StageGroup_43782_Name|融灾禁区·第4波",
    TypeText = "StageGroup_43782_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [43781] = {
    ID = 43781,
    CnID = "关卡组@融蚀深渊5期5",
    BaseSortID = 236,
    Type = 21,
    Name = "StageGroup_43781_Name|融灾禁区·第5波",
    TypeText = "StageGroup_43781_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [44514] = {
    ID = 44514,
    CnID = "关卡组@融蚀深渊6期1",
    BaseSortID = 237,
    Type = 21,
    Name = "StageGroup_44514_Name|融灾禁区·第1波",
    TypeText = "StageGroup_44514_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [44512] = {
    ID = 44512,
    CnID = "关卡组@融蚀深渊6期2",
    BaseSortID = 238,
    Type = 21,
    Name = "StageGroup_44512_Name|融灾禁区·第2波",
    TypeText = "StageGroup_44512_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [44513] = {
    ID = 44513,
    CnID = "关卡组@融蚀深渊6期3",
    BaseSortID = 239,
    Type = 21,
    Name = "StageGroup_44513_Name|融灾禁区·第3波",
    TypeText = "StageGroup_44513_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [44510] = {
    ID = 44510,
    CnID = "关卡组@融蚀深渊6期4",
    BaseSortID = 240,
    Type = 21,
    Name = "StageGroup_44510_Name|融灾禁区·第4波",
    TypeText = "StageGroup_44510_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [44511] = {
    ID = 44511,
    CnID = "关卡组@融蚀深渊6期5",
    BaseSortID = 241,
    Type = 21,
    Name = "StageGroup_44511_Name|融灾禁区·第5波",
    TypeText = "StageGroup_44511_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [44519] = {
    ID = 44519,
    CnID = "关卡组@融蚀深渊7期1",
    BaseSortID = 242,
    Type = 21,
    Name = "StageGroup_44519_Name|融灾禁区·第1波",
    TypeText = "StageGroup_44519_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [44518] = {
    ID = 44518,
    CnID = "关卡组@融蚀深渊7期2",
    BaseSortID = 243,
    Type = 21,
    Name = "StageGroup_44518_Name|融灾禁区·第2波",
    TypeText = "StageGroup_44518_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [44517] = {
    ID = 44517,
    CnID = "关卡组@融蚀深渊7期3",
    BaseSortID = 244,
    Type = 21,
    Name = "StageGroup_44517_Name|融灾禁区·第3波",
    TypeText = "StageGroup_44517_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [44516] = {
    ID = 44516,
    CnID = "关卡组@融蚀深渊7期4",
    BaseSortID = 245,
    Type = 21,
    Name = "StageGroup_44516_Name|融灾禁区·第4波",
    TypeText = "StageGroup_44516_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [44515] = {
    ID = 44515,
    CnID = "关卡组@融蚀深渊7期5",
    BaseSortID = 246,
    Type = 21,
    Name = "StageGroup_44515_Name|融灾禁区·第5波",
    TypeText = "StageGroup_44515_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [47447] = {
    ID = 47447,
    CnID = "关卡组@融蚀深渊8期1",
    BaseSortID = 247,
    Type = 21,
    Name = "StageGroup_47447_Name|融灾禁区·第1波",
    TypeText = "StageGroup_47447_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [47448] = {
    ID = 47448,
    CnID = "关卡组@融蚀深渊8期2",
    BaseSortID = 248,
    Type = 21,
    Name = "StageGroup_47448_Name|融灾禁区·第2波",
    TypeText = "StageGroup_47448_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [47449] = {
    ID = 47449,
    CnID = "关卡组@融蚀深渊8期3",
    BaseSortID = 249,
    Type = 21,
    Name = "StageGroup_47449_Name|融灾禁区·第3波",
    TypeText = "StageGroup_47449_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [47445] = {
    ID = 47445,
    CnID = "关卡组@融蚀深渊8期4",
    BaseSortID = 250,
    Type = 21,
    Name = "StageGroup_47445_Name|融灾禁区·第4波",
    TypeText = "StageGroup_47445_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [47446] = {
    ID = 47446,
    CnID = "关卡组@融蚀深渊8期5",
    BaseSortID = 251,
    Type = 21,
    Name = "StageGroup_47446_Name|融灾禁区·第5波",
    TypeText = "StageGroup_47446_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [50641] = {
    ID = 50641,
    CnID = "关卡组@融蚀深渊9期1",
    BaseSortID = 252,
    Type = 21,
    Name = "StageGroup_50641_Name|融灾禁区·第1波",
    TypeText = "StageGroup_50641_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [50640] = {
    ID = 50640,
    CnID = "关卡组@融蚀深渊9期2",
    BaseSortID = 253,
    Type = 21,
    Name = "StageGroup_50640_Name|融灾禁区·第2波",
    TypeText = "StageGroup_50640_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [50643] = {
    ID = 50643,
    CnID = "关卡组@融蚀深渊9期3",
    BaseSortID = 254,
    Type = 21,
    Name = "StageGroup_50643_Name|融灾禁区·第3波",
    TypeText = "StageGroup_50643_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [50631] = {
    ID = 50631,
    CnID = "关卡组@融蚀深渊9期4",
    BaseSortID = 255,
    Type = 21,
    Name = "StageGroup_50631_Name|融灾禁区·第4波",
    TypeText = "StageGroup_50631_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [50633] = {
    ID = 50633,
    CnID = "关卡组@融蚀深渊9期5",
    BaseSortID = 256,
    Type = 21,
    Name = "StageGroup_50633_Name|融灾禁区·第5波",
    TypeText = "StageGroup_50633_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [50642] = {
    ID = 50642,
    CnID = "关卡组@融蚀深渊10期1",
    BaseSortID = 257,
    Type = 21,
    Name = "StageGroup_50642_Name|融灾禁区·第1波",
    TypeText = "StageGroup_50642_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [50635] = {
    ID = 50635,
    CnID = "关卡组@融蚀深渊10期2",
    BaseSortID = 258,
    Type = 21,
    Name = "StageGroup_50635_Name|融灾禁区·第2波",
    TypeText = "StageGroup_50635_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [50644] = {
    ID = 50644,
    CnID = "关卡组@融蚀深渊10期3",
    BaseSortID = 259,
    Type = 21,
    Name = "StageGroup_50644_Name|融灾禁区·第3波",
    TypeText = "StageGroup_50644_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [50638] = {
    ID = 50638,
    CnID = "关卡组@融蚀深渊10期4",
    BaseSortID = 260,
    Type = 21,
    Name = "StageGroup_50638_Name|融灾禁区·第4波",
    TypeText = "StageGroup_50638_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [50639] = {
    ID = 50639,
    CnID = "关卡组@融蚀深渊10期5",
    BaseSortID = 261,
    Type = 21,
    Name = "StageGroup_50639_Name|融灾禁区·第5波",
    TypeText = "StageGroup_50639_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [50634] = {
    ID = 50634,
    CnID = "关卡组@融蚀深渊11期1",
    BaseSortID = 262,
    Type = 21,
    Name = "StageGroup_50634_Name|融灾禁区·第1波",
    TypeText = "StageGroup_50634_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [50637] = {
    ID = 50637,
    CnID = "关卡组@融蚀深渊11期2",
    BaseSortID = 263,
    Type = 21,
    Name = "StageGroup_50637_Name|融灾禁区·第2波",
    TypeText = "StageGroup_50637_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [50636] = {
    ID = 50636,
    CnID = "关卡组@融蚀深渊11期3",
    BaseSortID = 264,
    Type = 21,
    Name = "StageGroup_50636_Name|融灾禁区·第3波",
    TypeText = "StageGroup_50636_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [50630] = {
    ID = 50630,
    CnID = "关卡组@融蚀深渊11期4",
    BaseSortID = 265,
    Type = 21,
    Name = "StageGroup_50630_Name|融灾禁区·第4波",
    TypeText = "StageGroup_50630_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [50632] = {
    ID = 50632,
    CnID = "关卡组@融蚀深渊11期5",
    BaseSortID = 266,
    Type = 21,
    Name = "StageGroup_50632_Name|融灾禁区·第5波",
    TypeText = "StageGroup_50632_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53430] = {
    ID = 53430,
    CnID = "关卡组@融蚀深渊12期1",
    BaseSortID = 267,
    Type = 21,
    Name = "StageGroup_53430_Name|融灾禁区·第1波",
    TypeText = "StageGroup_53430_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53415] = {
    ID = 53415,
    CnID = "关卡组@融蚀深渊12期2",
    BaseSortID = 268,
    Type = 21,
    Name = "StageGroup_53415_Name|融灾禁区·第2波",
    TypeText = "StageGroup_53415_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53429] = {
    ID = 53429,
    CnID = "关卡组@融蚀深渊12期3",
    BaseSortID = 269,
    Type = 21,
    Name = "StageGroup_53429_Name|融灾禁区·第3波",
    TypeText = "StageGroup_53429_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53377] = {
    ID = 53377,
    CnID = "关卡组@融蚀深渊12期4",
    BaseSortID = 270,
    Type = 21,
    Name = "StageGroup_53377_Name|融灾禁区·第4波",
    TypeText = "StageGroup_53377_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53381] = {
    ID = 53381,
    CnID = "关卡组@融蚀深渊12期5",
    BaseSortID = 271,
    Type = 21,
    Name = "StageGroup_53381_Name|融灾禁区·第5波",
    TypeText = "StageGroup_53381_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53380] = {
    ID = 53380,
    CnID = "关卡组@融蚀深渊13期1",
    BaseSortID = 272,
    Type = 21,
    Name = "StageGroup_53380_Name|融灾禁区·第1波",
    TypeText = "StageGroup_53380_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53379] = {
    ID = 53379,
    CnID = "关卡组@融蚀深渊13期2",
    BaseSortID = 273,
    Type = 21,
    Name = "StageGroup_53379_Name|融灾禁区·第2波",
    TypeText = "StageGroup_53379_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53411] = {
    ID = 53411,
    CnID = "关卡组@融蚀深渊13期3",
    BaseSortID = 274,
    Type = 21,
    Name = "StageGroup_53411_Name|融灾禁区·第3波",
    TypeText = "StageGroup_53411_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53426] = {
    ID = 53426,
    CnID = "关卡组@融蚀深渊13期4",
    BaseSortID = 275,
    Type = 21,
    Name = "StageGroup_53426_Name|融灾禁区·第4波",
    TypeText = "StageGroup_53426_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53425] = {
    ID = 53425,
    CnID = "关卡组@融蚀深渊13期5",
    BaseSortID = 276,
    Type = 21,
    Name = "StageGroup_53425_Name|融灾禁区·第5波",
    TypeText = "StageGroup_53425_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53393] = {
    ID = 53393,
    CnID = "关卡组@融蚀深渊14期1",
    BaseSortID = 277,
    Type = 21,
    Name = "StageGroup_53393_Name|融灾禁区·第1波",
    TypeText = "StageGroup_53393_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53394] = {
    ID = 53394,
    CnID = "关卡组@融蚀深渊14期2",
    BaseSortID = 278,
    Type = 21,
    Name = "StageGroup_53394_Name|融灾禁区·第2波",
    TypeText = "StageGroup_53394_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53395] = {
    ID = 53395,
    CnID = "关卡组@融蚀深渊14期3",
    BaseSortID = 279,
    Type = 21,
    Name = "StageGroup_53395_Name|融灾禁区·第3波",
    TypeText = "StageGroup_53395_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53396] = {
    ID = 53396,
    CnID = "关卡组@融蚀深渊14期4",
    BaseSortID = 280,
    Type = 21,
    Name = "StageGroup_53396_Name|融灾禁区·第4波",
    TypeText = "StageGroup_53396_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53397] = {
    ID = 53397,
    CnID = "关卡组@融蚀深渊14期5",
    BaseSortID = 281,
    Type = 21,
    Name = "StageGroup_53397_Name|融灾禁区·第5波",
    TypeText = "StageGroup_53397_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53385] = {
    ID = 53385,
    CnID = "关卡组@融蚀深渊15期1",
    BaseSortID = 282,
    Type = 21,
    Name = "StageGroup_53385_Name|融灾禁区·第1波",
    TypeText = "StageGroup_53385_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53388] = {
    ID = 53388,
    CnID = "关卡组@融蚀深渊15期2",
    BaseSortID = 283,
    Type = 21,
    Name = "StageGroup_53388_Name|融灾禁区·第2波",
    TypeText = "StageGroup_53388_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53387] = {
    ID = 53387,
    CnID = "关卡组@融蚀深渊15期3",
    BaseSortID = 284,
    Type = 21,
    Name = "StageGroup_53387_Name|融灾禁区·第3波",
    TypeText = "StageGroup_53387_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53390] = {
    ID = 53390,
    CnID = "关卡组@融蚀深渊15期4",
    BaseSortID = 285,
    Type = 21,
    Name = "StageGroup_53390_Name|融灾禁区·第4波",
    TypeText = "StageGroup_53390_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53389] = {
    ID = 53389,
    CnID = "关卡组@融蚀深渊15期5",
    BaseSortID = 286,
    Type = 21,
    Name = "StageGroup_53389_Name|融灾禁区·第5波",
    TypeText = "StageGroup_53389_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53410] = {
    ID = 53410,
    CnID = "关卡组@融蚀深渊16期1",
    BaseSortID = 287,
    Type = 21,
    Name = "StageGroup_53410_Name|融灾禁区·第1波",
    TypeText = "StageGroup_53410_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53408] = {
    ID = 53408,
    CnID = "关卡组@融蚀深渊16期2",
    BaseSortID = 288,
    Type = 21,
    Name = "StageGroup_53408_Name|融灾禁区·第2波",
    TypeText = "StageGroup_53408_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53409] = {
    ID = 53409,
    CnID = "关卡组@融蚀深渊16期3",
    BaseSortID = 289,
    Type = 21,
    Name = "StageGroup_53409_Name|融灾禁区·第3波",
    TypeText = "StageGroup_53409_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53406] = {
    ID = 53406,
    CnID = "关卡组@融蚀深渊16期4",
    BaseSortID = 290,
    Type = 21,
    Name = "StageGroup_53406_Name|融灾禁区·第4波",
    TypeText = "StageGroup_53406_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53407] = {
    ID = 53407,
    CnID = "关卡组@融蚀深渊16期5",
    BaseSortID = 291,
    Type = 21,
    Name = "StageGroup_53407_Name|融灾禁区·第5波",
    TypeText = "StageGroup_53407_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53404] = {
    ID = 53404,
    CnID = "关卡组@融蚀深渊17期1",
    BaseSortID = 292,
    Type = 21,
    Name = "StageGroup_53404_Name|融灾禁区·第1波",
    TypeText = "StageGroup_53404_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53403] = {
    ID = 53403,
    CnID = "关卡组@融蚀深渊17期2",
    BaseSortID = 293,
    Type = 21,
    Name = "StageGroup_53403_Name|融灾禁区·第2波",
    TypeText = "StageGroup_53403_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53402] = {
    ID = 53402,
    CnID = "关卡组@融蚀深渊17期3",
    BaseSortID = 294,
    Type = 21,
    Name = "StageGroup_53402_Name|融灾禁区·第3波",
    TypeText = "StageGroup_53402_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53401] = {
    ID = 53401,
    CnID = "关卡组@融蚀深渊17期4",
    BaseSortID = 295,
    Type = 21,
    Name = "StageGroup_53401_Name|融灾禁区·第4波",
    TypeText = "StageGroup_53401_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53400] = {
    ID = 53400,
    CnID = "关卡组@融蚀深渊17期5",
    BaseSortID = 296,
    Type = 21,
    Name = "StageGroup_53400_Name|融灾禁区·第5波",
    TypeText = "StageGroup_53400_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53421] = {
    ID = 53421,
    CnID = "关卡组@融蚀深渊18期1",
    BaseSortID = 297,
    Type = 21,
    Name = "StageGroup_53421_Name|融灾禁区·第1波",
    TypeText = "StageGroup_53421_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53422] = {
    ID = 53422,
    CnID = "关卡组@融蚀深渊18期2",
    BaseSortID = 298,
    Type = 21,
    Name = "StageGroup_53422_Name|融灾禁区·第2波",
    TypeText = "StageGroup_53422_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53423] = {
    ID = 53423,
    CnID = "关卡组@融蚀深渊18期3",
    BaseSortID = 299,
    Type = 21,
    Name = "StageGroup_53423_Name|融灾禁区·第3波",
    TypeText = "StageGroup_53423_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53419] = {
    ID = 53419,
    CnID = "关卡组@融蚀深渊18期4",
    BaseSortID = 300,
    Type = 21,
    Name = "StageGroup_53419_Name|融灾禁区·第4波",
    TypeText = "StageGroup_53419_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53420] = {
    ID = 53420,
    CnID = "关卡组@融蚀深渊18期5",
    BaseSortID = 301,
    Type = 21,
    Name = "StageGroup_53420_Name|融灾禁区·第5波",
    TypeText = "StageGroup_53420_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53416] = {
    ID = 53416,
    CnID = "关卡组@融蚀深渊19期1",
    BaseSortID = 302,
    Type = 21,
    Name = "StageGroup_53416_Name|融灾禁区·第1波",
    TypeText = "StageGroup_53416_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53418] = {
    ID = 53418,
    CnID = "关卡组@融蚀深渊19期2",
    BaseSortID = 303,
    Type = 21,
    Name = "StageGroup_53418_Name|融灾禁区·第2波",
    TypeText = "StageGroup_53418_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53417] = {
    ID = 53417,
    CnID = "关卡组@融蚀深渊19期3",
    BaseSortID = 304,
    Type = 21,
    Name = "StageGroup_53417_Name|融灾禁区·第3波",
    TypeText = "StageGroup_53417_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53414] = {
    ID = 53414,
    CnID = "关卡组@融蚀深渊19期4",
    BaseSortID = 305,
    Type = 21,
    Name = "StageGroup_53414_Name|融灾禁区·第4波",
    TypeText = "StageGroup_53414_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53413] = {
    ID = 53413,
    CnID = "关卡组@融蚀深渊19期5",
    BaseSortID = 306,
    Type = 21,
    Name = "StageGroup_53413_Name|融灾禁区·第5波",
    TypeText = "StageGroup_53413_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53382] = {
    ID = 53382,
    CnID = "关卡组@融蚀深渊20期1",
    BaseSortID = 307,
    Type = 21,
    Name = "StageGroup_53382_Name|融灾禁区·第1波",
    TypeText = "StageGroup_53382_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53384] = {
    ID = 53384,
    CnID = "关卡组@融蚀深渊20期2",
    BaseSortID = 308,
    Type = 21,
    Name = "StageGroup_53384_Name|融灾禁区·第2波",
    TypeText = "StageGroup_53384_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53383] = {
    ID = 53383,
    CnID = "关卡组@融蚀深渊20期3",
    BaseSortID = 309,
    Type = 21,
    Name = "StageGroup_53383_Name|融灾禁区·第3波",
    TypeText = "StageGroup_53383_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53412] = {
    ID = 53412,
    CnID = "关卡组@融蚀深渊20期4",
    BaseSortID = 310,
    Type = 21,
    Name = "StageGroup_53412_Name|融灾禁区·第4波",
    TypeText = "StageGroup_53412_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53378] = {
    ID = 53378,
    CnID = "关卡组@融蚀深渊20期5",
    BaseSortID = 311,
    Type = 21,
    Name = "StageGroup_53378_Name|融灾禁区·第5波",
    TypeText = "StageGroup_53378_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53431] = {
    ID = 53431,
    CnID = "关卡组@融蚀深渊21期1",
    BaseSortID = 312,
    Type = 21,
    Name = "StageGroup_53431_Name|融灾禁区·第1波",
    TypeText = "StageGroup_53431_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53391] = {
    ID = 53391,
    CnID = "关卡组@融蚀深渊21期2",
    BaseSortID = 313,
    Type = 21,
    Name = "StageGroup_53391_Name|融灾禁区·第2波",
    TypeText = "StageGroup_53391_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53392] = {
    ID = 53392,
    CnID = "关卡组@融蚀深渊21期3",
    BaseSortID = 314,
    Type = 21,
    Name = "StageGroup_53392_Name|融灾禁区·第3波",
    TypeText = "StageGroup_53392_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53427] = {
    ID = 53427,
    CnID = "关卡组@融蚀深渊21期4",
    BaseSortID = 315,
    Type = 21,
    Name = "StageGroup_53427_Name|融灾禁区·第4波",
    TypeText = "StageGroup_53427_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53386] = {
    ID = 53386,
    CnID = "关卡组@融蚀深渊21期5",
    BaseSortID = 316,
    Type = 21,
    Name = "StageGroup_53386_Name|融灾禁区·第5波",
    TypeText = "StageGroup_53386_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53424] = {
    ID = 53424,
    CnID = "关卡组@融蚀深渊22期1",
    BaseSortID = 317,
    Type = 21,
    Name = "StageGroup_53424_Name|融灾禁区·第1波",
    TypeText = "StageGroup_53424_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53399] = {
    ID = 53399,
    CnID = "关卡组@融蚀深渊22期2",
    BaseSortID = 318,
    Type = 21,
    Name = "StageGroup_53399_Name|融灾禁区·第2波",
    TypeText = "StageGroup_53399_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53398] = {
    ID = 53398,
    CnID = "关卡组@融蚀深渊22期3",
    BaseSortID = 319,
    Type = 21,
    Name = "StageGroup_53398_Name|融灾禁区·第3波",
    TypeText = "StageGroup_53398_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53405] = {
    ID = 53405,
    CnID = "关卡组@融蚀深渊22期4",
    BaseSortID = 320,
    Type = 21,
    Name = "StageGroup_53405_Name|融灾禁区·第4波",
    TypeText = "StageGroup_53405_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [53428] = {
    ID = 53428,
    CnID = "关卡组@融蚀深渊22期5",
    BaseSortID = 321,
    Type = 21,
    Name = "StageGroup_53428_Name|融灾禁区·第5波",
    TypeText = "StageGroup_53428_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69346] = {
    ID = 69346,
    CnID = "关卡组@融蚀深渊23期1",
    BaseSortID = 322,
    Type = 21,
    Name = "StageGroup_69346_Name|融灾禁区·第1波",
    TypeText = "StageGroup_69346_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69338] = {
    ID = 69338,
    CnID = "关卡组@融蚀深渊23期2",
    BaseSortID = 323,
    Type = 21,
    Name = "StageGroup_69338_Name|融灾禁区·第2波",
    TypeText = "StageGroup_69338_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69339] = {
    ID = 69339,
    CnID = "关卡组@融蚀深渊23期3",
    BaseSortID = 324,
    Type = 21,
    Name = "StageGroup_69339_Name|融灾禁区·第3波",
    TypeText = "StageGroup_69339_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69344] = {
    ID = 69344,
    CnID = "关卡组@融蚀深渊23期4",
    BaseSortID = 325,
    Type = 21,
    Name = "StageGroup_69344_Name|融灾禁区·第4波",
    TypeText = "StageGroup_69344_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69345] = {
    ID = 69345,
    CnID = "关卡组@融蚀深渊23期5",
    BaseSortID = 326,
    Type = 21,
    Name = "StageGroup_69345_Name|融灾禁区·第5波",
    TypeText = "StageGroup_69345_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69361] = {
    ID = 69361,
    CnID = "关卡组@融蚀深渊24期1",
    BaseSortID = 327,
    Type = 21,
    Name = "StageGroup_69361_Name|融灾禁区·第1波",
    TypeText = "StageGroup_69361_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69336] = {
    ID = 69336,
    CnID = "关卡组@融蚀深渊24期2",
    BaseSortID = 328,
    Type = 21,
    Name = "StageGroup_69336_Name|融灾禁区·第2波",
    TypeText = "StageGroup_69336_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69340] = {
    ID = 69340,
    CnID = "关卡组@融蚀深渊24期3",
    BaseSortID = 329,
    Type = 21,
    Name = "StageGroup_69340_Name|融灾禁区·第3波",
    TypeText = "StageGroup_69340_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69343] = {
    ID = 69343,
    CnID = "关卡组@融蚀深渊24期4",
    BaseSortID = 330,
    Type = 21,
    Name = "StageGroup_69343_Name|融灾禁区·第4波",
    TypeText = "StageGroup_69343_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69342] = {
    ID = 69342,
    CnID = "关卡组@融蚀深渊24期5",
    BaseSortID = 331,
    Type = 21,
    Name = "StageGroup_69342_Name|融灾禁区·第5波",
    TypeText = "StageGroup_69342_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69337] = {
    ID = 69337,
    CnID = "关卡组@融蚀深渊25期1",
    BaseSortID = 332,
    Type = 21,
    Name = "StageGroup_69337_Name|融灾禁区·第1波",
    TypeText = "StageGroup_69337_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69347] = {
    ID = 69347,
    CnID = "关卡组@融蚀深渊25期2",
    BaseSortID = 333,
    Type = 21,
    Name = "StageGroup_69347_Name|融灾禁区·第2波",
    TypeText = "StageGroup_69347_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69348] = {
    ID = 69348,
    CnID = "关卡组@融蚀深渊25期3",
    BaseSortID = 334,
    Type = 21,
    Name = "StageGroup_69348_Name|融灾禁区·第3波",
    TypeText = "StageGroup_69348_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69349] = {
    ID = 69349,
    CnID = "关卡组@融蚀深渊25期4",
    BaseSortID = 335,
    Type = 21,
    Name = "StageGroup_69349_Name|融灾禁区·第4波",
    TypeText = "StageGroup_69349_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69350] = {
    ID = 69350,
    CnID = "关卡组@融蚀深渊25期5",
    BaseSortID = 336,
    Type = 21,
    Name = "StageGroup_69350_Name|融灾禁区·第5波",
    TypeText = "StageGroup_69350_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69355] = {
    ID = 69355,
    CnID = "关卡组@融蚀深渊26期1",
    BaseSortID = 337,
    Type = 21,
    Name = "StageGroup_69355_Name|融灾禁区·第1波",
    TypeText = "StageGroup_69355_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69354] = {
    ID = 69354,
    CnID = "关卡组@融蚀深渊26期2",
    BaseSortID = 338,
    Type = 21,
    Name = "StageGroup_69354_Name|融灾禁区·第2波",
    TypeText = "StageGroup_69354_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69353] = {
    ID = 69353,
    CnID = "关卡组@融蚀深渊26期3",
    BaseSortID = 339,
    Type = 21,
    Name = "StageGroup_69353_Name|融灾禁区·第3波",
    TypeText = "StageGroup_69353_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69352] = {
    ID = 69352,
    CnID = "关卡组@融蚀深渊26期4",
    BaseSortID = 340,
    Type = 21,
    Name = "StageGroup_69352_Name|融灾禁区·第4波",
    TypeText = "StageGroup_69352_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69351] = {
    ID = 69351,
    CnID = "关卡组@融蚀深渊26期5",
    BaseSortID = 341,
    Type = 21,
    Name = "StageGroup_69351_Name|融灾禁区·第5波",
    TypeText = "StageGroup_69351_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69341] = {
    ID = 69341,
    CnID = "关卡组@融蚀深渊27期1",
    BaseSortID = 342,
    Type = 21,
    Name = "StageGroup_69341_Name|融灾禁区·第1波",
    TypeText = "StageGroup_69341_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69335] = {
    ID = 69335,
    CnID = "关卡组@融蚀深渊27期2",
    BaseSortID = 343,
    Type = 21,
    Name = "StageGroup_69335_Name|融灾禁区·第2波",
    TypeText = "StageGroup_69335_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69327] = {
    ID = 69327,
    CnID = "关卡组@融蚀深渊27期3",
    BaseSortID = 344,
    Type = 21,
    Name = "StageGroup_69327_Name|融灾禁区·第3波",
    TypeText = "StageGroup_69327_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69324] = {
    ID = 69324,
    CnID = "关卡组@融蚀深渊27期4",
    BaseSortID = 345,
    Type = 21,
    Name = "StageGroup_69324_Name|融灾禁区·第4波",
    TypeText = "StageGroup_69324_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69325] = {
    ID = 69325,
    CnID = "关卡组@融蚀深渊27期5",
    BaseSortID = 346,
    Type = 21,
    Name = "StageGroup_69325_Name|融灾禁区·第5波",
    TypeText = "StageGroup_69325_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [69326] = {
    ID = 69326,
    CnID = "关卡组@融蚀深渊28期1",
    BaseSortID = 347,
    Type = 21,
    Name = "StageGroup_69326_Name|融灾禁区·第1波",
    TypeText = "StageGroup_69326_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [69329] = {
    ID = 69329,
    CnID = "关卡组@融蚀深渊28期2",
    BaseSortID = 348,
    Type = 21,
    Name = "StageGroup_69329_Name|融灾禁区·第2波",
    TypeText = "StageGroup_69329_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [69328] = {
    ID = 69328,
    CnID = "关卡组@融蚀深渊28期3",
    BaseSortID = 349,
    Type = 21,
    Name = "StageGroup_69328_Name|融灾禁区·第3波",
    TypeText = "StageGroup_69328_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [69323] = {
    ID = 69323,
    CnID = "关卡组@融蚀深渊28期4",
    BaseSortID = 350,
    Type = 21,
    Name = "StageGroup_69323_Name|融灾禁区·第4波",
    TypeText = "StageGroup_69323_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [69322] = {
    ID = 69322,
    CnID = "关卡组@融蚀深渊28期5",
    BaseSortID = 351,
    Type = 21,
    Name = "StageGroup_69322_Name|融灾禁区·第5波",
    TypeText = "StageGroup_69322_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [69332] = {
    ID = 69332,
    CnID = "关卡组@融蚀深渊29期1",
    BaseSortID = 352,
    Type = 21,
    Name = "StageGroup_69332_Name|融灾禁区·第1波",
    TypeText = "StageGroup_69332_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [69333] = {
    ID = 69333,
    CnID = "关卡组@融蚀深渊29期2",
    BaseSortID = 353,
    Type = 21,
    Name = "StageGroup_69333_Name|融灾禁区·第2波",
    TypeText = "StageGroup_69333_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [69334] = {
    ID = 69334,
    CnID = "关卡组@融蚀深渊29期3",
    BaseSortID = 354,
    Type = 21,
    Name = "StageGroup_69334_Name|融灾禁区·第3波",
    TypeText = "StageGroup_69334_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [69330] = {
    ID = 69330,
    CnID = "关卡组@融蚀深渊29期4",
    BaseSortID = 355,
    Type = 21,
    Name = "StageGroup_69330_Name|融灾禁区·第4波",
    TypeText = "StageGroup_69330_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [69331] = {
    ID = 69331,
    CnID = "关卡组@融蚀深渊29期5",
    BaseSortID = 356,
    Type = 21,
    Name = "StageGroup_69331_Name|融灾禁区·第5波",
    TypeText = "StageGroup_69331_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [69358] = {
    ID = 69358,
    CnID = "关卡组@融蚀深渊30期1",
    BaseSortID = 357,
    Type = 21,
    Name = "StageGroup_69358_Name|融灾禁区·第1波",
    TypeText = "StageGroup_69358_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [69356] = {
    ID = 69356,
    CnID = "关卡组@融蚀深渊30期2",
    BaseSortID = 358,
    Type = 21,
    Name = "StageGroup_69356_Name|融灾禁区·第2波",
    TypeText = "StageGroup_69356_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [69357] = {
    ID = 69357,
    CnID = "关卡组@融蚀深渊30期3",
    BaseSortID = 359,
    Type = 21,
    Name = "StageGroup_69357_Name|融灾禁区·第3波",
    TypeText = "StageGroup_69357_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [69359] = {
    ID = 69359,
    CnID = "关卡组@融蚀深渊30期4",
    BaseSortID = 360,
    Type = 21,
    Name = "StageGroup_69359_Name|融灾禁区·第4波",
    TypeText = "StageGroup_69359_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [69360] = {
    ID = 69360,
    CnID = "关卡组@融蚀深渊30期5",
    BaseSortID = 361,
    Type = 21,
    Name = "StageGroup_69360_Name|融灾禁区·第5波",
    TypeText = "StageGroup_69360_TypeText|融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [34756] = {
    ID = 34756,
    CnID = "关卡组@剧本迷思",
    BaseSortID = 362,
    Type = 22,
    Name = "StageGroup_34756_Name|剧本迷思",
    TypeText = "StageGroup_34756_TypeText|剧本迷思",
    Sequence = 1,
    BattleBuff = {
      1,
      "ResonanceGroupMagicStoryActivity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 0
  },
  [38806] = {
    ID = 38806,
    CnID = "关卡组@湖中之城1",
    BaseSortID = 363,
    Type = 23,
    Name = "StageGroup_38806_Name|启示录",
    TypeText = "StageGroup_38806_TypeText|湖中之城",
    Sequence = 1,
    BattleBuff = {
      1,
      "ResonanceGroupWangda"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Events_Image/UI_Events_Image_Icon_12.png"
    },
    StageGroupDropPreview = {38704},
    StageDisplayDate = 1710378000
  },
  [38808] = {
    ID = 38808,
    CnID = "关卡组@湖中之城2",
    BaseSortID = 364,
    Type = 23,
    Name = "StageGroup_38808_Name|黄金之城",
    TypeText = "StageGroup_38808_TypeText|湖中之城",
    Sequence = 2,
    BattleBuff = {
      1,
      "ResonanceGroupWangda"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Events_Image/UI_Events_Image_Icon_11.png"
    },
    StageGroupDropPreview = {38703},
    StageDisplayDate = 1710550800
  },
  [38807] = {
    ID = 38807,
    CnID = "关卡组@湖中之城3",
    BaseSortID = 365,
    Type = 23,
    Name = "StageGroup_38807_Name|小苍兰",
    TypeText = "StageGroup_38807_TypeText|湖中之城",
    Sequence = 3,
    BattleBuff = {
      1,
      "ResonanceGroupWangda"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Events_Image/UI_Events_Image_Icon_10.png"
    },
    StageGroupDropPreview = {38702},
    StageDisplayDate = 1710723600
  },
  [38810] = {
    ID = 38810,
    CnID = "关卡组@湖中之城4",
    BaseSortID = 366,
    Type = 23,
    Name = "StageGroup_38810_Name|真实",
    TypeText = "StageGroup_38810_TypeText|湖中之城",
    Sequence = 4,
    BattleBuff = {
      1,
      "ResonanceGroupWangda"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Events_Image/UI_Events_Image_Icon_12.png"
    },
    StageGroupDropPreview = {38704, 38703},
    StageDisplayDate = 1710896400
  },
  [38809] = {
    ID = 38809,
    CnID = "关卡组@湖中之城5",
    BaseSortID = 367,
    Type = 23,
    Name = "StageGroup_38809_Name|井",
    TypeText = "StageGroup_38809_TypeText|湖中之城",
    Sequence = 5,
    BattleBuff = {
      1,
      "ResonanceGroupWangda"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Events_Image/UI_Events_Image_Icon_11.png"
    },
    StageGroupDropPreview = {38703, 38702},
    StageDisplayDate = 1711069200
  },
  [38812] = {
    ID = 38812,
    CnID = "关卡组@湖中之城6",
    BaseSortID = 368,
    Type = 23,
    Name = "StageGroup_38812_Name|海市蜃楼",
    TypeText = "StageGroup_38812_TypeText|湖中之城",
    Sequence = 6,
    BattleBuff = {
      1,
      "ResonanceGroupWangda"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Events_Image/UI_Events_Image_Icon_10.png"
    },
    StageGroupDropPreview = {38704, 38702},
    StageDisplayDate = 1711242000
  },
  [38811] = {
    ID = 38811,
    CnID = "关卡组@湖中之城7",
    BaseSortID = 369,
    Type = 23,
    Name = "StageGroup_38811_Name|一段记忆",
    TypeText = "StageGroup_38811_TypeText|湖中之城",
    Sequence = 7,
    BattleBuff = {
      1,
      "ResonanceGroupWangda"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/AtlasSource/UI_Events_Image/UI_Events_Image_Icon_12.png"
    },
    StageGroupDropPreview = {
      38704,
      38703,
      38702
    },
    StageDisplayDate = 1711414800
  },
  [44278] = {
    ID = 44278,
    CnID = "关卡组@圣堂区域1",
    BaseSortID = 370,
    Type = 24,
    Name = "StageGroup_44278_Name|索取",
    TypeText = "StageGroup_44278_TypeText|圣堂之路",
    Sequence = 1,
    BattleBuff = {
      1,
      "ResonanceGroupSEWD"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    Bonus = {44282, 44927},
    BonusTips = {
      "BonusCardRateText",
      "BonusCardTipsTitle",
      "BonusCardTipsContent",
      "BonusCardAwardText"
    }
  },
  [44277] = {
    ID = 44277,
    CnID = "关卡组@圣堂区域2",
    BaseSortID = 371,
    Type = 24,
    Name = "StageGroup_44277_Name|争夺",
    TypeText = "StageGroup_44277_TypeText|圣堂之路",
    Sequence = 2,
    BattleBuff = {
      1,
      "ResonanceGroupSEWD"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    Bonus = {44282, 44927},
    BonusTips = {
      "BonusCardRateText",
      "BonusCardTipsTitle",
      "BonusCardTipsContent",
      "BonusCardAwardText"
    }
  },
  [44276] = {
    ID = 44276,
    CnID = "关卡组@圣堂区域3",
    BaseSortID = 372,
    Type = 24,
    Name = "StageGroup_44276_Name|指责",
    TypeText = "StageGroup_44276_TypeText|圣堂之路",
    Sequence = 3,
    BattleBuff = {
      1,
      "ResonanceGroupSEWD"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    Bonus = {44282, 44927},
    BonusTips = {
      "BonusCardRateText",
      "BonusCardTipsTitle",
      "BonusCardTipsContent",
      "BonusCardAwardText"
    }
  },
  [44275] = {
    ID = 44275,
    CnID = "关卡组@圣堂区域4",
    BaseSortID = 373,
    Type = 24,
    Name = "StageGroup_44275_Name|偏执",
    TypeText = "StageGroup_44275_TypeText|圣堂之路",
    Sequence = 4,
    BattleBuff = {
      1,
      "ResonanceGroupSEWD"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    Bonus = {44282, 44927},
    BonusTips = {
      "BonusCardRateText",
      "BonusCardTipsTitle",
      "BonusCardTipsContent",
      "BonusCardAwardText"
    }
  },
  [44274] = {
    ID = 44274,
    CnID = "关卡组@圣堂区域5",
    BaseSortID = 374,
    Type = 24,
    Name = "StageGroup_44274_Name|忏悔",
    TypeText = "StageGroup_44274_TypeText|圣堂之路",
    Sequence = 5,
    BattleBuff = {
      1,
      "ResonanceGroupSEWD"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    Bonus = {44282, 44927},
    BonusTips = {
      "BonusCardRateText",
      "BonusCardTipsTitle",
      "BonusCardTipsContent",
      "BonusCardAwardText"
    }
  },
  [46612] = {
    ID = 46612,
    CnID = "关卡组@记忆编码1",
    BaseSortID = 375,
    Type = 25,
    Name = "StageGroup_46612_Name|无意识记",
    TypeText = "StageGroup_46612_TypeText|记忆编码",
    Sequence = 1,
    BattleBuff = {
      1,
      "ResonanceGroup24"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {46606},
    Bonus = {
      46621,
      46620,
      46623,
      46619,
      46622,
      46618,
      47510,
      47509,
      47511
    },
    BonusTips = {
      "BonusCardRateText",
      "BonusCardTipsTitle",
      "BonusCardTipsContent",
      "BonusCardAwardText"
    }
  },
  [46610] = {
    ID = 46610,
    CnID = "关卡组@记忆编码2",
    BaseSortID = 376,
    Type = 25,
    Name = "StageGroup_46610_Name|杏仁体",
    TypeText = "StageGroup_46610_TypeText|记忆编码",
    Sequence = 2,
    BattleBuff = {
      1,
      "ResonanceGroup24"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {46606, 46608},
    Bonus = {
      46621,
      46620,
      46623,
      46619,
      46622,
      46618,
      47510,
      47509,
      47511
    },
    BonusTips = {
      "BonusCardRateText",
      "BonusCardTipsTitle",
      "BonusCardTipsContent",
      "BonusCardAwardText"
    }
  },
  [46611] = {
    ID = 46611,
    CnID = "关卡组@记忆编码3",
    BaseSortID = 377,
    Type = 25,
    Name = "StageGroup_46611_Name|爬虫脑",
    TypeText = "StageGroup_46611_TypeText|记忆编码",
    Sequence = 3,
    BattleBuff = {
      1,
      "ResonanceGroup24"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {46606, 46607},
    Bonus = {
      46621,
      46620,
      46623,
      46619,
      46622,
      46618,
      47510,
      47509,
      47511
    },
    BonusTips = {
      "BonusCardRateText",
      "BonusCardTipsTitle",
      "BonusCardTipsContent",
      "BonusCardAwardText"
    }
  },
  [46613] = {
    ID = 46613,
    CnID = "关卡组@记忆编码4",
    BaseSortID = 378,
    Type = 25,
    Name = "StageGroup_46613_Name|遗忘曲线",
    TypeText = "StageGroup_46613_TypeText|记忆编码",
    Sequence = 4,
    BattleBuff = {
      1,
      "ResonanceGroup24"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {46608, 46607},
    Bonus = {
      46621,
      46620,
      46623,
      46619,
      46622,
      46618,
      47510,
      47509,
      47511
    },
    BonusTips = {
      "BonusCardRateText",
      "BonusCardTipsTitle",
      "BonusCardTipsContent",
      "BonusCardAwardText"
    }
  },
  [46614] = {
    ID = 46614,
    CnID = "关卡组@记忆编码5",
    BaseSortID = 379,
    Type = 25,
    Name = "StageGroup_46614_Name|镜子",
    TypeText = "StageGroup_46614_TypeText|记忆编码",
    Sequence = 5,
    BattleBuff = {
      1,
      "ResonanceGroup24"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      46606,
      46608,
      46607
    },
    Bonus = {
      46621,
      46620,
      46623,
      46619,
      46622,
      46618,
      47510,
      47509,
      47511
    },
    BonusTips = {
      "BonusCardRateText",
      "BonusCardTipsTitle",
      "BonusCardTipsContent",
      "BonusCardAwardText"
    }
  },
  [49375] = {
    ID = 49375,
    CnID = "关卡组@紊乱情欲1",
    BaseSortID = 380,
    Type = 26,
    Name = "StageGroup_49375_Name|花萼",
    Desc = "StageGroup_49375_Desc|泰旖丝活动关卡1",
    TypeText = "StageGroup_49375_TypeText|紊乱情欲",
    Sequence = 1,
    Backgrand = "Scenebg/Scene_B09_AF_1.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_01.png"
    },
    StageGroupDropPreview = {
      48700,
      9762,
      9834
    },
    StageDisplayDate = 1765760400,
    Bonus = {48732, 48731},
    BonusTips = {
      "BonusTips_ThaisActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ThaisActivity",
      "BonusAffix_ThaisActivity"
    }
  },
  [49374] = {
    ID = 49374,
    CnID = "关卡组@紊乱情欲2",
    BaseSortID = 381,
    Type = 26,
    Name = "StageGroup_49374_Name|蜜腺",
    Desc = "StageGroup_49374_Desc|泰旖丝活动关卡2",
    TypeText = "StageGroup_49374_TypeText|紊乱情欲",
    Sequence = 2,
    Backgrand = "Scenebg/Scene_B09_AF_1.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_02.png"
    },
    StageGroupDropPreview = {
      48700,
      9799,
      9793
    },
    StageDisplayDate = 1765846800,
    Bonus = {48732, 48731},
    BonusTips = {
      "BonusTips_ThaisActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ThaisActivity",
      "BonusAffix_ThaisActivity"
    }
  },
  [49373] = {
    ID = 49373,
    CnID = "关卡组@紊乱情欲3",
    BaseSortID = 382,
    Type = 26,
    Name = "StageGroup_49373_Name|授粉",
    Desc = "StageGroup_49373_Desc|泰旖丝活动关卡3",
    TypeText = "StageGroup_49373_TypeText|紊乱情欲",
    Sequence = 3,
    Backgrand = "Scenebg/Scene_B09_AF_1.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_03.png"
    },
    StageGroupDropPreview = {
      48700,
      9971,
      9758
    },
    StageDisplayDate = 1765933200,
    Bonus = {48732, 48731},
    BonusTips = {
      "BonusTips_ThaisActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ThaisActivity",
      "BonusAffix_ThaisActivity"
    }
  },
  [49379] = {
    ID = 49379,
    CnID = "关卡组@紊乱情欲4",
    BaseSortID = 383,
    Type = 26,
    Name = "StageGroup_49379_Name|多胚生殖",
    Desc = "StageGroup_49379_Desc|泰旖丝活动关卡4",
    TypeText = "StageGroup_49379_TypeText|紊乱情欲",
    Sequence = 4,
    Backgrand = "Scenebg/Scene_B09_AF_1.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_04.png"
    },
    StageGroupDropPreview = {
      48700,
      9925,
      9740
    },
    StageDisplayDate = 1766019600,
    Bonus = {48732, 48731},
    BonusTips = {
      "BonusTips_ThaisActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ThaisActivity",
      "BonusAffix_ThaisActivity"
    }
  },
  [49378] = {
    ID = 49378,
    CnID = "关卡组@紊乱情欲5",
    BaseSortID = 384,
    Type = 26,
    Name = "StageGroup_49378_Name|落果",
    Desc = "StageGroup_49378_Desc|泰旖丝活动关卡5",
    TypeText = "StageGroup_49378_TypeText|紊乱情欲",
    Sequence = 5,
    Backgrand = "Scenebg/Scene_B09_AF_1.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_05.png"
    },
    StageGroupDropPreview = {
      48700,
      9768,
      9904
    },
    StageDisplayDate = 1766106000,
    Bonus = {48732, 48731},
    BonusTips = {
      "BonusTips_ThaisActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ThaisActivity",
      "BonusAffix_ThaisActivity"
    }
  },
  [49377] = {
    ID = 49377,
    CnID = "关卡组@紊乱情欲6",
    BaseSortID = 385,
    Type = 26,
    Name = "StageGroup_49377_Name|幼根",
    Desc = "StageGroup_49377_Desc|泰旖丝活动关卡6",
    TypeText = "StageGroup_49377_TypeText|紊乱情欲",
    Sequence = 6,
    Backgrand = "Scenebg/Scene_B09_AF_1.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_06.png"
    },
    StageGroupDropPreview = {
      48700,
      9769,
      9621
    },
    StageDisplayDate = 1766192400,
    Bonus = {48732, 48731},
    BonusTips = {
      "BonusTips_ThaisActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ThaisActivity",
      "BonusAffix_ThaisActivity"
    }
  },
  [49376] = {
    ID = 49376,
    CnID = "关卡组@紊乱情欲7",
    BaseSortID = 386,
    Type = 26,
    Name = "StageGroup_49376_Name|出芽",
    Desc = "StageGroup_49376_Desc|泰旖丝活动关卡7",
    TypeText = "StageGroup_49376_TypeText|紊乱情欲",
    Sequence = 7,
    Backgrand = "Scenebg/Scene_B09_AF_1.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_07.png"
    },
    StageGroupDropPreview = {
      48700,
      9812,
      10117
    },
    StageDisplayDate = 1766278800,
    Bonus = {48732, 48731},
    BonusTips = {
      "BonusTips_ThaisActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ThaisActivity",
      "BonusAffix_ThaisActivity"
    }
  },
  [49372] = {
    ID = 49372,
    CnID = "关卡组@紊乱情欲8",
    BaseSortID = 387,
    Type = 26,
    Name = "StageGroup_49372_Name|年轮",
    Desc = "StageGroup_49372_Desc|泰旖丝活动关卡8",
    TypeText = "StageGroup_49372_TypeText|紊乱情欲",
    Sequence = 8,
    Backgrand = "Scenebg/Scene_B09_AF_1.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_08.png"
    },
    StageGroupDropPreview = {
      48700,
      9671,
      9601
    },
    StageDisplayDate = 1766365200,
    Bonus = {48732, 48731},
    BonusTips = {
      "BonusTips_ThaisActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ThaisActivity",
      "BonusAffix_ThaisActivity"
    }
  },
  [49371] = {
    ID = 49371,
    CnID = "关卡组@紊乱情欲9",
    BaseSortID = 388,
    Type = 26,
    Name = "StageGroup_49371_Name|再生花",
    Desc = "StageGroup_49371_Desc|泰旖丝活动关卡9",
    TypeText = "StageGroup_49371_TypeText|紊乱情欲",
    Sequence = 9,
    Backgrand = "Scenebg/Scene_B09_AF_1.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_09.png"
    },
    StageGroupDropPreview = {
      48700,
      9756,
      10013
    },
    StageDisplayDate = 1766451600,
    Bonus = {48732, 48731},
    BonusTips = {
      "BonusTips_ThaisActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ThaisActivity",
      "BonusAffix_ThaisActivity"
    }
  },
  [49370] = {
    ID = 49370,
    CnID = "关卡组@紊乱情欲10",
    BaseSortID = 389,
    Type = 26,
    Name = "StageGroup_49370_Name|胚珠",
    Desc = "StageGroup_49370_Desc|泰旖丝活动关卡10",
    TypeText = "StageGroup_49370_TypeText|紊乱情欲",
    Sequence = 10,
    Backgrand = "Scenebg/Scene_B09_AF_1.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_10.png"
    },
    StageGroupDropPreview = {48700, 9619},
    StageDisplayDate = 1766538000,
    Bonus = {48732, 48731},
    BonusTips = {
      "BonusTips_ThaisActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ThaisActivity",
      "BonusAffix_ThaisActivity"
    }
  },
  [48811] = {
    ID = 48811,
    CnID = "关卡组@表白事件",
    BaseSortID = 390,
    Type = 27,
    Name = "StageGroup_48811_Name|繁衍狂热",
    TypeText = "StageGroup_48811_TypeText|繁衍狂热",
    Sequence = 1,
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1
  },
  [51132] = {
    ID = 51132,
    CnID = "关卡组@剧本迷思复刻1",
    BaseSortID = 391,
    Type = 28,
    Name = "StageGroup_51132_Name|三一律",
    TypeText = "StageGroup_51132_TypeText|剧本迷思",
    Sequence = 1,
    Backgrand = "Scenebg/Scene_C10_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroupMagicStoryActivity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Script_02.png"
    },
    StageGroupDropPreview = {
      51105,
      9762,
      9834
    },
    StageDisplayDate = 1736730000,
    Bonus = {51139, 51138},
    BonusTips = {
      "BonusTips_MagicStoryActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MagicStoryActivity",
      "BonusAffix_MagicStoryActivity"
    }
  },
  [51133] = {
    ID = 51133,
    CnID = "关卡组@剧本迷思复刻2",
    BaseSortID = 392,
    Type = 28,
    Name = "StageGroup_51133_Name|卡塔西斯",
    TypeText = "StageGroup_51133_TypeText|剧本迷思",
    Sequence = 2,
    Backgrand = "Scenebg/Scene_C10_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroupMagicStoryActivity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Script_02.png"
    },
    StageGroupDropPreview = {
      51105,
      9799,
      9793
    },
    StageDisplayDate = 1736816400,
    Bonus = {51139, 51138},
    BonusTips = {
      "BonusTips_MagicStoryActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MagicStoryActivity",
      "BonusAffix_MagicStoryActivity"
    }
  },
  [51134] = {
    ID = 51134,
    CnID = "关卡组@剧本迷思复刻3",
    BaseSortID = 393,
    Type = 28,
    Name = "StageGroup_51134_Name|情节轮转",
    TypeText = "StageGroup_51134_TypeText|剧本迷思",
    Sequence = 3,
    Backgrand = "Scenebg/Scene_C10_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroupMagicStoryActivity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Script_02.png"
    },
    StageGroupDropPreview = {
      51105,
      9971,
      9758
    },
    StageDisplayDate = 1736902800,
    Bonus = {51139, 51138},
    BonusTips = {
      "BonusTips_MagicStoryActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MagicStoryActivity",
      "BonusAffix_MagicStoryActivity"
    }
  },
  [51128] = {
    ID = 51128,
    CnID = "关卡组@剧本迷思复刻4",
    BaseSortID = 394,
    Type = 28,
    Name = "StageGroup_51128_Name|静场时刻",
    TypeText = "StageGroup_51128_TypeText|剧本迷思",
    Sequence = 4,
    Backgrand = "Scenebg/Scene_C10_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroupMagicStoryActivity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Script_02.png"
    },
    StageGroupDropPreview = {
      51105,
      9925,
      9740
    },
    StageDisplayDate = 1736989200,
    Bonus = {51139, 51138},
    BonusTips = {
      "BonusTips_MagicStoryActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MagicStoryActivity",
      "BonusAffix_MagicStoryActivity"
    }
  },
  [51129] = {
    ID = 51129,
    CnID = "关卡组@剧本迷思复刻5",
    BaseSortID = 395,
    Type = 28,
    Name = "StageGroup_51129_Name|假面喜剧",
    TypeText = "StageGroup_51129_TypeText|剧本迷思",
    Sequence = 5,
    Backgrand = "Scenebg/Scene_C10_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroupMagicStoryActivity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Script_02.png"
    },
    StageGroupDropPreview = {
      51105,
      9768,
      9904
    },
    StageDisplayDate = 1737075600,
    Bonus = {51139, 51138},
    BonusTips = {
      "BonusTips_MagicStoryActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MagicStoryActivity",
      "BonusAffix_MagicStoryActivity"
    }
  },
  [51130] = {
    ID = 51130,
    CnID = "关卡组@剧本迷思复刻6",
    BaseSortID = 396,
    Type = 28,
    Name = "StageGroup_51130_Name|弧光理论",
    TypeText = "StageGroup_51130_TypeText|剧本迷思",
    Sequence = 6,
    Backgrand = "Scenebg/Scene_C10_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroupMagicStoryActivity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Script_02.png"
    },
    StageGroupDropPreview = {
      51105,
      9769,
      9621
    },
    StageDisplayDate = 1737162000,
    Bonus = {51139, 51138},
    BonusTips = {
      "BonusTips_MagicStoryActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MagicStoryActivity",
      "BonusAffix_MagicStoryActivity"
    }
  },
  [51131] = {
    ID = 51131,
    CnID = "关卡组@剧本迷思复刻7",
    BaseSortID = 397,
    Type = 28,
    Name = "StageGroup_51131_Name|剧作金字塔",
    TypeText = "StageGroup_51131_TypeText|剧本迷思",
    Sequence = 7,
    Backgrand = "Scenebg/Scene_C10_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroupMagicStoryActivity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Script_02.png"
    },
    StageGroupDropPreview = {
      51105,
      9812,
      10117
    },
    StageDisplayDate = 1737248400,
    Bonus = {51139, 51138},
    BonusTips = {
      "BonusTips_MagicStoryActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MagicStoryActivity",
      "BonusAffix_MagicStoryActivity"
    }
  },
  [51135] = {
    ID = 51135,
    CnID = "关卡组@剧本迷思复刻8",
    BaseSortID = 398,
    Type = 28,
    Name = "StageGroup_51135_Name|陌生化效果",
    TypeText = "StageGroup_51135_TypeText|剧本迷思",
    Sequence = 8,
    Backgrand = "Scenebg/Scene_C10_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroupMagicStoryActivity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Script_02.png"
    },
    StageGroupDropPreview = {
      51105,
      9671,
      9601
    },
    StageDisplayDate = 1737334800,
    Bonus = {51139, 51138},
    BonusTips = {
      "BonusTips_MagicStoryActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MagicStoryActivity",
      "BonusAffix_MagicStoryActivity"
    }
  },
  [51136] = {
    ID = 51136,
    CnID = "关卡组@剧本迷思复刻9",
    BaseSortID = 399,
    Type = 28,
    Name = "StageGroup_51136_Name|戏剧的第四壁",
    TypeText = "StageGroup_51136_TypeText|剧本迷思",
    Sequence = 9,
    Backgrand = "Scenebg/Scene_C10_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroupMagicStoryActivity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Script_02.png"
    },
    StageGroupDropPreview = {
      51105,
      9756,
      10013
    },
    StageDisplayDate = 1737421200,
    Bonus = {51139, 51138},
    BonusTips = {
      "BonusTips_MagicStoryActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MagicStoryActivity",
      "BonusAffix_MagicStoryActivity"
    }
  },
  [52043] = {
    ID = 52043,
    CnID = "关卡组@弥利亚姆活动关卡1",
    BaseSortID = 400,
    Type = 29,
    Name = "StageGroup_52043_Name|质疑",
    TypeText = "StageGroup_52043_TypeText|沉渊之祀",
    Sequence = 1,
    Backgrand = "Scenebg/SScene_UnderSea.png",
    BattleBuff = {
      1,
      "ResonanceGroupO07Activity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {52039},
    StageDisplayDate = 1718586000,
    Bonus = {
      52054,
      52053,
      52052,
      52051,
      52050,
      52049
    },
    BonusTips = {
      "BonusTips_MiryamActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MiryamActivity",
      "BonusAffix_MiryamActivity"
    }
  },
  [52044] = {
    ID = 52044,
    CnID = "关卡组@弥利亚姆活动关卡2",
    BaseSortID = 401,
    Type = 29,
    Name = "StageGroup_52044_Name|见证",
    TypeText = "StageGroup_52044_TypeText|沉渊之祀",
    Sequence = 2,
    Backgrand = "Scenebg/SScene_UnderSea.png",
    BattleBuff = {
      1,
      "ResonanceGroupO07Activity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {52039, 52038},
    StageDisplayDate = 1718758800,
    Bonus = {
      52054,
      52053,
      52052,
      52051,
      52050,
      52049
    },
    BonusTips = {
      "BonusTips_MiryamActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MiryamActivity",
      "BonusAffix_MiryamActivity"
    }
  },
  [52045] = {
    ID = 52045,
    CnID = "关卡组@弥利亚姆活动关卡3",
    BaseSortID = 402,
    Type = 29,
    Name = "StageGroup_52045_Name|动摇",
    TypeText = "StageGroup_52045_TypeText|沉渊之祀",
    Sequence = 3,
    Backgrand = "Scenebg/SScene_UnderSea.png",
    BattleBuff = {
      1,
      "ResonanceGroupO07Activity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {52039, 52037},
    StageDisplayDate = 1718931600,
    Bonus = {
      52054,
      52053,
      52052,
      52051,
      52050,
      52049
    },
    BonusTips = {
      "BonusTips_MiryamActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MiryamActivity",
      "BonusAffix_MiryamActivity"
    }
  },
  [52041] = {
    ID = 52041,
    CnID = "关卡组@弥利亚姆活动关卡4",
    BaseSortID = 403,
    Type = 29,
    Name = "StageGroup_52041_Name|笃信",
    TypeText = "StageGroup_52041_TypeText|沉渊之祀",
    Sequence = 4,
    Backgrand = "Scenebg/SScene_UnderSea.png",
    BattleBuff = {
      1,
      "ResonanceGroupO07Activity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {52038, 52037},
    StageDisplayDate = 1719104400,
    Bonus = {
      52054,
      52053,
      52052,
      52051,
      52050,
      52049
    },
    BonusTips = {
      "BonusTips_MiryamActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MiryamActivity",
      "BonusAffix_MiryamActivity"
    }
  },
  [52042] = {
    ID = 52042,
    CnID = "关卡组@弥利亚姆活动关卡5",
    BaseSortID = 404,
    Type = 29,
    Name = "StageGroup_52042_Name|降临",
    TypeText = "StageGroup_52042_TypeText|沉渊之祀",
    Sequence = 5,
    Backgrand = "Scenebg/SScene_UnderSea.png",
    BattleBuff = {
      1,
      "ResonanceGroupO07Activity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      52039,
      52038,
      52037
    },
    StageDisplayDate = 1719277200,
    Bonus = {
      52054,
      52053,
      52052,
      52051,
      52050,
      52049
    },
    BonusTips = {
      "BonusTips_MiryamActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MiryamActivity",
      "BonusAffix_MiryamActivity"
    }
  },
  [53832] = {
    ID = 53832,
    CnID = "关卡组@索蕾尔活动1",
    BaseSortID = 405,
    Type = 30,
    Name = "StageGroup_53832_Name|目光",
    TypeText = "StageGroup_53832_TypeText|蔷薇忆事",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Sorel01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      53746,
      9762,
      9834
    },
    StageDisplayDate = 1737939600,
    Bonus = {53840, 53841},
    BonusTips = {
      "BonusTips_SorelActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SorelActivity",
      "BonusAffix_SorelActivity"
    }
  },
  [53834] = {
    ID = 53834,
    CnID = "关卡组@索蕾尔活动2",
    BaseSortID = 406,
    Type = 30,
    Name = "StageGroup_53834_Name|傀儡游戏",
    TypeText = "StageGroup_53834_TypeText|蔷薇忆事",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Sorel01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      53746,
      9799,
      9793
    },
    StageDisplayDate = 1738026000,
    Bonus = {53840, 53841},
    BonusTips = {
      "BonusTips_SorelActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SorelActivity",
      "BonusAffix_SorelActivity"
    }
  },
  [53833] = {
    ID = 53833,
    CnID = "关卡组@索蕾尔活动3",
    BaseSortID = 407,
    Type = 30,
    Name = "StageGroup_53833_Name|釜底游鱼",
    TypeText = "StageGroup_53833_TypeText|蔷薇忆事",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Sorel01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      53746,
      9971,
      9758
    },
    StageDisplayDate = 1738112400,
    Bonus = {53840, 53841},
    BonusTips = {
      "BonusTips_SorelActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SorelActivity",
      "BonusAffix_SorelActivity"
    }
  },
  [53836] = {
    ID = 53836,
    CnID = "关卡组@索蕾尔活动4",
    BaseSortID = 408,
    Type = 30,
    Name = "StageGroup_53836_Name|礼物",
    TypeText = "StageGroup_53836_TypeText|蔷薇忆事",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Sorel01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      53746,
      9925,
      9740
    },
    StageDisplayDate = 1738198800,
    Bonus = {53840, 53841},
    BonusTips = {
      "BonusTips_SorelActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SorelActivity",
      "BonusAffix_SorelActivity"
    }
  },
  [53835] = {
    ID = 53835,
    CnID = "关卡组@索蕾尔活动5",
    BaseSortID = 409,
    Type = 30,
    Name = "StageGroup_53835_Name|长腿叔叔",
    TypeText = "StageGroup_53835_TypeText|蔷薇忆事",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Sorel01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      53746,
      9768,
      9904
    },
    StageDisplayDate = 1738285200,
    Bonus = {53840, 53841},
    BonusTips = {
      "BonusTips_SorelActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SorelActivity",
      "BonusAffix_SorelActivity"
    }
  },
  [53838] = {
    ID = 53838,
    CnID = "关卡组@索蕾尔活动6",
    BaseSortID = 410,
    Type = 30,
    Name = "StageGroup_53838_Name|蔷薇角",
    TypeText = "StageGroup_53838_TypeText|蔷薇忆事",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Sorel01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      53746,
      9769,
      9621
    },
    StageDisplayDate = 1738371600,
    Bonus = {53840, 53841},
    BonusTips = {
      "BonusTips_SorelActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SorelActivity",
      "BonusAffix_SorelActivity"
    }
  },
  [53837] = {
    ID = 53837,
    CnID = "关卡组@索蕾尔活动7",
    BaseSortID = 411,
    Type = 30,
    Name = "StageGroup_53837_Name|未完的剧本",
    TypeText = "StageGroup_53837_TypeText|蔷薇忆事",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Sorel01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      53746,
      9812,
      10117
    },
    StageDisplayDate = 1738458000,
    Bonus = {53840, 53841},
    BonusTips = {
      "BonusTips_SorelActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SorelActivity",
      "BonusAffix_SorelActivity"
    }
  },
  [53831] = {
    ID = 53831,
    CnID = "关卡组@索蕾尔活动8",
    BaseSortID = 412,
    Type = 30,
    Name = "StageGroup_53831_Name|脸",
    TypeText = "StageGroup_53831_TypeText|蔷薇忆事",
    Sequence = 8,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Sorel01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      53746,
      9671,
      9601
    },
    StageDisplayDate = 1738544400,
    Bonus = {53840, 53841},
    BonusTips = {
      "BonusTips_SorelActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SorelActivity",
      "BonusAffix_SorelActivity"
    }
  },
  [53830] = {
    ID = 53830,
    CnID = "关卡组@索蕾尔活动9",
    BaseSortID = 413,
    Type = 30,
    Name = "StageGroup_53830_Name|终曲",
    TypeText = "StageGroup_53830_TypeText|蔷薇忆事",
    Sequence = 9,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Sorel01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      53746,
      9756,
      10013
    },
    StageDisplayDate = 1738630800,
    Bonus = {53840, 53841},
    BonusTips = {
      "BonusTips_SorelActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SorelActivity",
      "BonusAffix_SorelActivity"
    }
  },
  [55117] = {
    ID = 55117,
    CnID = "关卡组@奥尔拉活动关卡1",
    BaseSortID = 414,
    Type = 31,
    Name = "StageGroup_55117_Name|执手",
    TypeText = "StageGroup_55117_TypeText|花园往事",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Horla01.png",
    BattleBuff = {
      1,
      "ResonanceGroupHorla"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {55128},
    StageDisplayDate = 1786323600,
    Bonus = {
      55125,
      55123,
      55124,
      55121,
      55122,
      55120
    },
    BonusTips = {
      "BonusTips_HorlaActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_HorlaActivity",
      "BonusAffix_HorlaActivity"
    }
  },
  [55116] = {
    ID = 55116,
    CnID = "关卡组@奥尔拉活动关卡2",
    BaseSortID = 415,
    Type = 31,
    Name = "StageGroup_55116_Name|渺小王国",
    TypeText = "StageGroup_55116_TypeText|花园往事",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Horla01.png",
    BattleBuff = {
      1,
      "ResonanceGroupHorla"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {55128, 55126},
    StageDisplayDate = 1786496400,
    Bonus = {
      55125,
      55123,
      55124,
      55121,
      55122,
      55120
    },
    BonusTips = {
      "BonusTips_HorlaActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_HorlaActivity",
      "BonusAffix_HorlaActivity"
    }
  },
  [55115] = {
    ID = 55115,
    CnID = "关卡组@奥尔拉活动关卡3",
    BaseSortID = 416,
    Type = 31,
    Name = "StageGroup_55115_Name|第一朵玫瑰",
    TypeText = "StageGroup_55115_TypeText|花园往事",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Horla01.png",
    BattleBuff = {
      1,
      "ResonanceGroupHorla"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {55128, 55127},
    StageDisplayDate = 1786669200,
    Bonus = {
      55125,
      55123,
      55124,
      55121,
      55122,
      55120
    },
    BonusTips = {
      "BonusTips_HorlaActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_HorlaActivity",
      "BonusAffix_HorlaActivity"
    }
  },
  [55119] = {
    ID = 55119,
    CnID = "关卡组@奥尔拉活动关卡4",
    BaseSortID = 417,
    Type = 31,
    Name = "StageGroup_55119_Name|盛开的诗篇",
    TypeText = "StageGroup_55119_TypeText|花园往事",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Horla01.png",
    BattleBuff = {
      1,
      "ResonanceGroupHorla"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {55126, 55127},
    StageDisplayDate = 1786842000,
    Bonus = {
      55125,
      55123,
      55124,
      55121,
      55122,
      55120
    },
    BonusTips = {
      "BonusTips_HorlaActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_HorlaActivity",
      "BonusAffix_HorlaActivity"
    }
  },
  [55118] = {
    ID = 55118,
    CnID = "关卡组@奥尔拉活动关卡5",
    BaseSortID = 418,
    Type = 31,
    Name = "StageGroup_55118_Name|灰烬",
    TypeText = "StageGroup_55118_TypeText|花园往事",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Horla01.png",
    BattleBuff = {
      1,
      "ResonanceGroupHorla"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      55128,
      55126,
      55127
    },
    StageDisplayDate = 1787014800,
    Bonus = {
      55125,
      55123,
      55124,
      55121,
      55122,
      55120
    },
    BonusTips = {
      "BonusTips_HorlaActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_HorlaActivity",
      "BonusAffix_HorlaActivity"
    }
  },
  [55076] = {
    ID = 55076,
    CnID = "关卡组@墨菲活动1",
    BaseSortID = 419,
    Type = 32,
    Name = "StageGroup_55076_Name|裹尸布",
    TypeText = "StageGroup_55076_TypeText|黑暗子宫",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Murphy01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56487},
    StageDisplayDate = 1741568400,
    Bonus = {
      57162,
      57164,
      57163,
      57160,
      57159,
      57161
    },
    BonusTips = {
      "BonusTips_MurphyActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MurphyActivity",
      "BonusAffix_MurphyActivity"
    }
  },
  [55077] = {
    ID = 55077,
    CnID = "关卡组@墨菲活动2",
    BaseSortID = 420,
    Type = 32,
    Name = "StageGroup_55077_Name|蛰伏",
    TypeText = "StageGroup_55077_TypeText|黑暗子宫",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Murphy01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56489},
    StageDisplayDate = 1741654800,
    Bonus = {
      57162,
      57164,
      57163,
      57160,
      57159,
      57161
    },
    BonusTips = {
      "BonusTips_MurphyActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MurphyActivity",
      "BonusAffix_MurphyActivity"
    }
  },
  [55078] = {
    ID = 55078,
    CnID = "关卡组@墨菲活动3",
    BaseSortID = 421,
    Type = 32,
    Name = "StageGroup_55078_Name|屠戮羔羊",
    TypeText = "StageGroup_55078_TypeText|黑暗子宫",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Murphy01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56488},
    StageDisplayDate = 1741741200,
    Bonus = {
      57162,
      57164,
      57163,
      57160,
      57159,
      57161
    },
    BonusTips = {
      "BonusTips_MurphyActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MurphyActivity",
      "BonusAffix_MurphyActivity"
    }
  },
  [55079] = {
    ID = 55079,
    CnID = "关卡组@墨菲活动4",
    BaseSortID = 422,
    Type = 32,
    Name = "StageGroup_55079_Name|黄色星辰",
    TypeText = "StageGroup_55079_TypeText|黑暗子宫",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Murphy01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56487, 56489},
    StageDisplayDate = 1741827600,
    Bonus = {
      57162,
      57164,
      57163,
      57160,
      57159,
      57161
    },
    BonusTips = {
      "BonusTips_MurphyActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MurphyActivity",
      "BonusAffix_MurphyActivity"
    }
  },
  [55080] = {
    ID = 55080,
    CnID = "关卡组@墨菲活动5",
    BaseSortID = 423,
    Type = 32,
    Name = "StageGroup_55080_Name|时空沟壑",
    TypeText = "StageGroup_55080_TypeText|黑暗子宫",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Murphy01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56489, 56488},
    StageDisplayDate = 1741914000,
    Bonus = {
      57162,
      57164,
      57163,
      57160,
      57159,
      57161
    },
    BonusTips = {
      "BonusTips_MurphyActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MurphyActivity",
      "BonusAffix_MurphyActivity"
    }
  },
  [55081] = {
    ID = 55081,
    CnID = "关卡组@墨菲活动6",
    BaseSortID = 424,
    Type = 32,
    Name = "StageGroup_55081_Name|行刑者",
    TypeText = "StageGroup_55081_TypeText|黑暗子宫",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Murphy01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56487, 56488},
    StageDisplayDate = 1742000400,
    Bonus = {
      57162,
      57164,
      57163,
      57160,
      57159,
      57161
    },
    BonusTips = {
      "BonusTips_MurphyActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MurphyActivity",
      "BonusAffix_MurphyActivity"
    }
  },
  [55082] = {
    ID = 55082,
    CnID = "关卡组@墨菲活动7",
    BaseSortID = 425,
    Type = 32,
    Name = "StageGroup_55082_Name|祂的降临",
    TypeText = "StageGroup_55082_TypeText|黑暗子宫",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Murphy01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      56487,
      56489,
      56488
    },
    StageDisplayDate = 1742086800,
    Bonus = {
      57162,
      57164,
      57163,
      57160,
      57159,
      57161
    },
    BonusTips = {
      "BonusTips_MurphyActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MurphyActivity",
      "BonusAffix_MurphyActivity"
    }
  },
  [55089] = {
    ID = 55089,
    CnID = "关卡组@莱克活动1",
    BaseSortID = 426,
    Type = 33,
    Name = "StageGroup_55089_Name|不速之客",
    TypeText = "StageGroup_55089_TypeText|月夜传说",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Ryker01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56484, 9762},
    StageDisplayDate = 1758502800,
    Bonus = {57147, 57146},
    BonusTips = {
      "BonusTips_RykerActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_RykerActivity",
      "BonusAffix_RykerActivity"
    }
  },
  [55087] = {
    ID = 55087,
    CnID = "关卡组@莱克活动2",
    BaseSortID = 427,
    Type = 33,
    Name = "StageGroup_55087_Name|无头尸",
    TypeText = "StageGroup_55087_TypeText|月夜传说",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Ryker01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56484, 9799},
    StageDisplayDate = 1758589200,
    Bonus = {57147, 57146},
    BonusTips = {
      "BonusTips_RykerActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_RykerActivity",
      "BonusAffix_RykerActivity"
    }
  },
  [55088] = {
    ID = 55088,
    CnID = "关卡组@莱克活动3",
    BaseSortID = 428,
    Type = 33,
    Name = "StageGroup_55088_Name|侦探之友",
    TypeText = "StageGroup_55088_TypeText|月夜传说",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Ryker01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56484, 9971},
    StageDisplayDate = 1758675600,
    Bonus = {57147, 57146},
    BonusTips = {
      "BonusTips_RykerActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_RykerActivity",
      "BonusAffix_RykerActivity"
    }
  },
  [55085] = {
    ID = 55085,
    CnID = "关卡组@莱克活动4",
    BaseSortID = 429,
    Type = 33,
    Name = "StageGroup_55085_Name|密室迷思",
    TypeText = "StageGroup_55085_TypeText|月夜传说",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Ryker01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56484, 9925},
    StageDisplayDate = 1758762000,
    Bonus = {57147, 57146},
    BonusTips = {
      "BonusTips_RykerActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_RykerActivity",
      "BonusAffix_RykerActivity"
    }
  },
  [55086] = {
    ID = 55086,
    CnID = "关卡组@莱克活动5",
    BaseSortID = 430,
    Type = 33,
    Name = "StageGroup_55086_Name|幸运庸众",
    TypeText = "StageGroup_55086_TypeText|月夜传说",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Ryker01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56484, 9768},
    StageDisplayDate = 1758848400,
    Bonus = {57147, 57146},
    BonusTips = {
      "BonusTips_RykerActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_RykerActivity",
      "BonusAffix_RykerActivity"
    }
  },
  [55083] = {
    ID = 55083,
    CnID = "关卡组@莱克活动6",
    BaseSortID = 431,
    Type = 33,
    Name = "StageGroup_55083_Name|衔树枝",
    TypeText = "StageGroup_55083_TypeText|月夜传说",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Ryker01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56484, 9769},
    StageDisplayDate = 1758934800,
    Bonus = {57147, 57146},
    BonusTips = {
      "BonusTips_RykerActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_RykerActivity",
      "BonusAffix_RykerActivity"
    }
  },
  [55084] = {
    ID = 55084,
    CnID = "关卡组@莱克活动7",
    BaseSortID = 432,
    Type = 33,
    Name = "StageGroup_55084_Name|不在场供述",
    TypeText = "StageGroup_55084_TypeText|月夜传说",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Ryker01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56484, 9812},
    StageDisplayDate = 1759021200,
    Bonus = {57147, 57146},
    BonusTips = {
      "BonusTips_RykerActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_RykerActivity",
      "BonusAffix_RykerActivity"
    }
  },
  [55090] = {
    ID = 55090,
    CnID = "关卡组@莱克活动8",
    BaseSortID = 433,
    Type = 33,
    Name = "StageGroup_55090_Name|翻转诡计",
    TypeText = "StageGroup_55090_TypeText|月夜传说",
    Sequence = 8,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Ryker01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56484, 9671},
    StageDisplayDate = 1759107600,
    Bonus = {57147, 57146},
    BonusTips = {
      "BonusTips_RykerActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_RykerActivity",
      "BonusAffix_RykerActivity"
    }
  },
  [55091] = {
    ID = 55091,
    CnID = "关卡组@莱克活动9",
    BaseSortID = 434,
    Type = 33,
    Name = "StageGroup_55091_Name|后记",
    TypeText = "StageGroup_55091_TypeText|月夜传说",
    Sequence = 9,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Ryker01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56484, 9756},
    StageDisplayDate = 1759194000,
    Bonus = {57147, 57146},
    BonusTips = {
      "BonusTips_RykerActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_RykerActivity",
      "BonusAffix_RykerActivity"
    }
  },
  [58101] = {
    ID = 58101,
    CnID = "关卡组@萨尔瓦多复刻活动1",
    BaseSortID = 435,
    Type = 38,
    Name = "StageGroup_58101_Name|索取",
    TypeText = "StageGroup_58101_TypeText|圣堂之路",
    Sequence = 1,
    Backgrand = "Scenebg/Scene_B02_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroupSEWD"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageDisplayDate = 1742778000,
    Bonus = {44282, 44927},
    BonusTips = {
      "BonusTips_SalvadorActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SalvadorActivity",
      "BonusAffix_SalvadorActivity"
    }
  },
  [58099] = {
    ID = 58099,
    CnID = "关卡组@萨尔瓦多复刻活动2",
    BaseSortID = 436,
    Type = 38,
    Name = "StageGroup_58099_Name|争夺",
    TypeText = "StageGroup_58099_TypeText|圣堂之路",
    Sequence = 2,
    Backgrand = "Scenebg/Scene_B02_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroupSEWD"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageDisplayDate = 1742950800,
    Bonus = {44282, 44927},
    BonusTips = {
      "BonusTips_SalvadorActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SalvadorActivity",
      "BonusAffix_SalvadorActivity"
    }
  },
  [58100] = {
    ID = 58100,
    CnID = "关卡组@萨尔瓦多复刻活动3",
    BaseSortID = 437,
    Type = 38,
    Name = "StageGroup_58100_Name|指责",
    TypeText = "StageGroup_58100_TypeText|圣堂之路",
    Sequence = 3,
    Backgrand = "Scenebg/Scene_B02_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroupSEWD"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageDisplayDate = 1743123600,
    Bonus = {44282, 44927},
    BonusTips = {
      "BonusTips_SalvadorActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SalvadorActivity",
      "BonusAffix_SalvadorActivity"
    }
  },
  [58102] = {
    ID = 58102,
    CnID = "关卡组@萨尔瓦多复刻活动4",
    BaseSortID = 438,
    Type = 38,
    Name = "StageGroup_58102_Name|偏执",
    TypeText = "StageGroup_58102_TypeText|圣堂之路",
    Sequence = 4,
    Backgrand = "Scenebg/Scene_B02_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroupSEWD"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageDisplayDate = 1743296400,
    Bonus = {44282, 44927},
    BonusTips = {
      "BonusTips_SalvadorActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SalvadorActivity",
      "BonusAffix_SalvadorActivity"
    }
  },
  [58103] = {
    ID = 58103,
    CnID = "关卡组@萨尔瓦多复刻活动5",
    BaseSortID = 439,
    Type = 38,
    Name = "StageGroup_58103_Name|忏悔",
    TypeText = "StageGroup_58103_TypeText|圣堂之路",
    Sequence = 5,
    Backgrand = "Scenebg/Scene_B02_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroupSEWD"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageDisplayDate = 1743469200,
    Bonus = {44282, 44927},
    BonusTips = {
      "BonusTips_SalvadorActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SalvadorActivity",
      "BonusAffix_SalvadorActivity"
    }
  },
  [56469] = {
    ID = 56469,
    CnID = "关卡组@哈姆林活动1",
    BaseSortID = 440,
    Type = 35,
    Name = "StageGroup_56469_Name|迷途梦引",
    TypeText = "StageGroup_56469_TypeText|轰鸣之音",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Hameln01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56485, 9762},
    StageDisplayDate = 1781485200,
    Bonus = {57156, 57158},
    BonusTips = {
      "BonusTips_HamelnActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_HamelnActivity",
      "BonusAffix_HamelnActivity"
    }
  },
  [56467] = {
    ID = 56467,
    CnID = "关卡组@哈姆林活动2",
    BaseSortID = 441,
    Type = 35,
    Name = "StageGroup_56467_Name|管弦编制",
    TypeText = "StageGroup_56467_TypeText|轰鸣之音",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Hameln01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56485, 9799},
    StageDisplayDate = 1781571600,
    Bonus = {57156, 57158},
    BonusTips = {
      "BonusTips_HamelnActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_HamelnActivity",
      "BonusAffix_HamelnActivity"
    }
  },
  [56468] = {
    ID = 56468,
    CnID = "关卡组@哈姆林活动3",
    BaseSortID = 442,
    Type = 35,
    Name = "StageGroup_56468_Name|序曲",
    TypeText = "StageGroup_56468_TypeText|轰鸣之音",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Hameln01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56485, 9971},
    StageDisplayDate = 1781658000,
    Bonus = {57156, 57158},
    BonusTips = {
      "BonusTips_HamelnActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_HamelnActivity",
      "BonusAffix_HamelnActivity"
    }
  },
  [56472] = {
    ID = 56472,
    CnID = "关卡组@哈姆林活动4",
    BaseSortID = 443,
    Type = 35,
    Name = "StageGroup_56472_Name|快板",
    TypeText = "StageGroup_56472_TypeText|轰鸣之音",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Hameln01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56485, 9925},
    StageDisplayDate = 1781744400,
    Bonus = {57156, 57158},
    BonusTips = {
      "BonusTips_HamelnActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_HamelnActivity",
      "BonusAffix_HamelnActivity"
    }
  },
  [56473] = {
    ID = 56473,
    CnID = "关卡组@哈姆林活动5",
    BaseSortID = 444,
    Type = 35,
    Name = "StageGroup_56473_Name|慢板",
    TypeText = "StageGroup_56473_TypeText|轰鸣之音",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Hameln01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56485, 9768},
    StageDisplayDate = 1781830800,
    Bonus = {57156, 57158},
    BonusTips = {
      "BonusTips_HamelnActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_HamelnActivity",
      "BonusAffix_HamelnActivity"
    }
  },
  [56470] = {
    ID = 56470,
    CnID = "关卡组@哈姆林活动6",
    BaseSortID = 445,
    Type = 35,
    Name = "StageGroup_56470_Name|小步舞曲",
    TypeText = "StageGroup_56470_TypeText|轰鸣之音",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Hameln01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56485, 9769},
    StageDisplayDate = 1781917200,
    Bonus = {57156, 57158},
    BonusTips = {
      "BonusTips_HamelnActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_HamelnActivity",
      "BonusAffix_HamelnActivity"
    }
  },
  [56471] = {
    ID = 56471,
    CnID = "关卡组@哈姆林活动7",
    BaseSortID = 446,
    Type = 35,
    Name = "StageGroup_56471_Name|终曲",
    TypeText = "StageGroup_56471_TypeText|轰鸣之音",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Hameln01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56485, 9812},
    StageDisplayDate = 1782003600,
    Bonus = {57156, 57158},
    BonusTips = {
      "BonusTips_HamelnActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_HamelnActivity",
      "BonusAffix_HamelnActivity"
    }
  },
  [56474] = {
    ID = 56474,
    CnID = "关卡组@哈姆林活动8",
    BaseSortID = 447,
    Type = 35,
    Name = "StageGroup_56474_Name|幕落",
    TypeText = "StageGroup_56474_TypeText|轰鸣之音",
    Sequence = 8,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Hameln01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56485, 9671},
    StageDisplayDate = 1782090000,
    Bonus = {57156, 57158},
    BonusTips = {
      "BonusTips_HamelnActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_HamelnActivity",
      "BonusAffix_HamelnActivity"
    }
  },
  [56475] = {
    ID = 56475,
    CnID = "关卡组@哈姆林活动9",
    BaseSortID = 448,
    Type = 35,
    Name = "StageGroup_56475_Name|余音",
    TypeText = "StageGroup_56475_TypeText|轰鸣之音",
    Sequence = 9,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Hameln01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56485, 9756},
    StageDisplayDate = 1782176400,
    Bonus = {57156, 57158},
    BonusTips = {
      "BonusTips_HamelnActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_HamelnActivity",
      "BonusAffix_HamelnActivity"
    }
  },
  [58312] = {
    ID = 58312,
    CnID = "关卡组@24复刻活动1",
    BaseSortID = 449,
    Type = 39,
    Name = "StageGroup_58312_Name|无意识记",
    TypeText = "StageGroup_58312_TypeText|记忆编码",
    Sequence = 1,
    Backgrand = "Scenebg/Scene_B08_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroup24"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {46606},
    StageDisplayDate = 1771808400,
    Bonus = {
      65748,
      65747,
      65746,
      65751,
      65750,
      65749
    },
    BonusTips = {
      "BonusTips_A24Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_A24Activity",
      "BonusAffix_A24Activity"
    }
  },
  [58310] = {
    ID = 58310,
    CnID = "关卡组@24复刻活动2",
    BaseSortID = 450,
    Type = 39,
    Name = "StageGroup_58310_Name|杏仁体",
    TypeText = "StageGroup_58310_TypeText|记忆编码",
    Sequence = 2,
    Backgrand = "Scenebg/Scene_B08_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroup24"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {46606, 46608},
    StageDisplayDate = 1771981200,
    Bonus = {
      65748,
      65747,
      65746,
      65751,
      65750,
      65749
    },
    BonusTips = {
      "BonusTips_A24Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_A24Activity",
      "BonusAffix_A24Activity"
    }
  },
  [58311] = {
    ID = 58311,
    CnID = "关卡组@24复刻活动3",
    BaseSortID = 451,
    Type = 39,
    Name = "StageGroup_58311_Name|爬虫脑",
    TypeText = "StageGroup_58311_TypeText|记忆编码",
    Sequence = 3,
    Backgrand = "Scenebg/Scene_B08_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroup24"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {46606, 46607},
    StageDisplayDate = 1772154000,
    Bonus = {
      65748,
      65747,
      65746,
      65751,
      65750,
      65749
    },
    BonusTips = {
      "BonusTips_A24Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_A24Activity",
      "BonusAffix_A24Activity"
    }
  },
  [58313] = {
    ID = 58313,
    CnID = "关卡组@24复刻活动4",
    BaseSortID = 452,
    Type = 39,
    Name = "StageGroup_58313_Name|遗忘曲线",
    TypeText = "StageGroup_58313_TypeText|记忆编码",
    Sequence = 4,
    Backgrand = "Scenebg/Scene_B08_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroup24"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {46608, 46607},
    StageDisplayDate = 1772326800,
    Bonus = {
      65748,
      65747,
      65746,
      65751,
      65750,
      65749
    },
    BonusTips = {
      "BonusTips_A24Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_A24Activity",
      "BonusAffix_A24Activity"
    }
  },
  [58314] = {
    ID = 58314,
    CnID = "关卡组@24复刻活动5",
    BaseSortID = 453,
    Type = 39,
    Name = "StageGroup_58314_Name|镜子",
    TypeText = "StageGroup_58314_TypeText|记忆编码",
    Sequence = 5,
    Backgrand = "Scenebg/Scene_B08_AF_1.png",
    BattleBuff = {
      1,
      "ResonanceGroup24"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      46606,
      46608,
      46607
    },
    StageDisplayDate = 1772499600,
    Bonus = {
      65748,
      65747,
      65746,
      65751,
      65750,
      65749
    },
    BonusTips = {
      "BonusTips_A24Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_A24Activity",
      "BonusAffix_A24Activity"
    }
  },
  [55796] = {
    ID = 55796,
    CnID = "关卡组@本源希洛活动关卡1",
    BaseSortID = 454,
    Type = 34,
    Name = "StageGroup_55796_Name|归来",
    TypeText = "StageGroup_55796_TypeText|野兽雄心",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriHelot02.png",
    BattleBuff = {
      1,
      "ResonanceGroupOriginHelot"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56490},
    StageDisplayDate = 1783904400,
    Bonus = {
      57152,
      57153,
      57154,
      57149,
      57150,
      57151
    },
    BonusTips = {
      "BonusTips_OriginHelotActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginHelotActivity",
      "BonusAffix_OriginHelotActivity"
    }
  },
  [55795] = {
    ID = 55795,
    CnID = "关卡组@本源希洛活动关卡2",
    BaseSortID = 455,
    Type = 34,
    Name = "StageGroup_55795_Name|寒夜",
    TypeText = "StageGroup_55795_TypeText|野兽雄心",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriHelot02.png",
    BattleBuff = {
      1,
      "ResonanceGroupOriginHelot"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56490, 56491},
    StageDisplayDate = 1784077200,
    Bonus = {
      57152,
      57153,
      57154,
      57149,
      57150,
      57151
    },
    BonusTips = {
      "BonusTips_OriginHelotActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginHelotActivity",
      "BonusAffix_OriginHelotActivity"
    }
  },
  [55794] = {
    ID = 55794,
    CnID = "关卡组@本源希洛活动关卡3",
    BaseSortID = 456,
    Type = 34,
    Name = "StageGroup_55794_Name|斗兽",
    TypeText = "StageGroup_55794_TypeText|野兽雄心",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriHelot02.png",
    BattleBuff = {
      1,
      "ResonanceGroupOriginHelot"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56490, 56492},
    StageDisplayDate = 1784250000,
    Bonus = {
      57152,
      57153,
      57154,
      57149,
      57150,
      57151
    },
    BonusTips = {
      "BonusTips_OriginHelotActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginHelotActivity",
      "BonusAffix_OriginHelotActivity"
    }
  },
  [55793] = {
    ID = 55793,
    CnID = "关卡组@本源希洛活动关卡4",
    BaseSortID = 457,
    Type = 34,
    Name = "StageGroup_55793_Name|见山",
    TypeText = "StageGroup_55793_TypeText|野兽雄心",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriHelot02.png",
    BattleBuff = {
      1,
      "ResonanceGroupOriginHelot"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56491, 56492},
    StageDisplayDate = 1784422800,
    Bonus = {
      57152,
      57153,
      57154,
      57149,
      57150,
      57151
    },
    BonusTips = {
      "BonusTips_OriginHelotActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginHelotActivity",
      "BonusAffix_OriginHelotActivity"
    }
  },
  [55792] = {
    ID = 55792,
    CnID = "关卡组@本源希洛活动关卡5",
    BaseSortID = 458,
    Type = 34,
    Name = "StageGroup_55792_Name|破土",
    TypeText = "StageGroup_55792_TypeText|野兽雄心",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriHelot02.png",
    BattleBuff = {
      1,
      "ResonanceGroupOriginHelot"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      56490,
      56491,
      56492
    },
    StageDisplayDate = 1784595600,
    Bonus = {
      57152,
      57153,
      57154,
      57149,
      57150,
      57151
    },
    BonusTips = {
      "BonusTips_OriginHelotActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginHelotActivity",
      "BonusAffix_OriginHelotActivity"
    }
  },
  [58303] = {
    ID = 58303,
    CnID = "关卡组@旺达复刻活动1",
    BaseSortID = 459,
    Type = 40,
    Name = "StageGroup_58303_Name|启示录",
    TypeText = "StageGroup_58303_TypeText|湖中之城",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Wanda01.png",
    BattleBuff = {
      1,
      "ResonanceGroupWangda"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Icon_12.png"
    },
    StageGroupDropPreview = {38704},
    StageDisplayDate = 1774227600,
    Bonus = {
      58320,
      58322,
      58321,
      58324,
      58323,
      58325
    },
    BonusTips = {
      "BonusTips_WandaActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_WandaActivity",
      "BonusAffix_WandaActivity"
    }
  },
  [58304] = {
    ID = 58304,
    CnID = "关卡组@旺达复刻活动2",
    BaseSortID = 460,
    Type = 40,
    Name = "StageGroup_58304_Name|黄金之城",
    TypeText = "StageGroup_58304_TypeText|湖中之城",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Wanda01.png",
    BattleBuff = {
      1,
      "ResonanceGroupWangda"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Icon_11.png"
    },
    StageGroupDropPreview = {38703},
    StageDisplayDate = 1774314000,
    Bonus = {
      58320,
      58322,
      58321,
      58324,
      58323,
      58325
    },
    BonusTips = {
      "BonusTips_WandaActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_WandaActivity",
      "BonusAffix_WandaActivity"
    }
  },
  [58305] = {
    ID = 58305,
    CnID = "关卡组@旺达复刻活动3",
    BaseSortID = 461,
    Type = 40,
    Name = "StageGroup_58305_Name|小苍兰",
    TypeText = "StageGroup_58305_TypeText|湖中之城",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Wanda01.png",
    BattleBuff = {
      1,
      "ResonanceGroupWangda"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Icon_10.png"
    },
    StageGroupDropPreview = {38702},
    StageDisplayDate = 1774400400,
    Bonus = {
      58320,
      58322,
      58321,
      58324,
      58323,
      58325
    },
    BonusTips = {
      "BonusTips_WandaActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_WandaActivity",
      "BonusAffix_WandaActivity"
    }
  },
  [58306] = {
    ID = 58306,
    CnID = "关卡组@旺达复刻活动4",
    BaseSortID = 462,
    Type = 40,
    Name = "StageGroup_58306_Name|真实",
    TypeText = "StageGroup_58306_TypeText|湖中之城",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Wanda01.png",
    BattleBuff = {
      1,
      "ResonanceGroupWangda"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Icon_12.png"
    },
    StageGroupDropPreview = {38704, 38703},
    StageDisplayDate = 1774486800,
    Bonus = {
      58320,
      58322,
      58321,
      58324,
      58323,
      58325
    },
    BonusTips = {
      "BonusTips_WandaActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_WandaActivity",
      "BonusAffix_WandaActivity"
    }
  },
  [58307] = {
    ID = 58307,
    CnID = "关卡组@旺达复刻活动5",
    BaseSortID = 463,
    Type = 40,
    Name = "StageGroup_58307_Name|井",
    TypeText = "StageGroup_58307_TypeText|湖中之城",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Wanda01.png",
    BattleBuff = {
      1,
      "ResonanceGroupWangda"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Icon_11.png"
    },
    StageGroupDropPreview = {38703, 38702},
    StageDisplayDate = 1774573200,
    Bonus = {
      58320,
      58322,
      58321,
      58324,
      58323,
      58325
    },
    BonusTips = {
      "BonusTips_WandaActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_WandaActivity",
      "BonusAffix_WandaActivity"
    }
  },
  [58308] = {
    ID = 58308,
    CnID = "关卡组@旺达复刻活动6",
    BaseSortID = 464,
    Type = 40,
    Name = "StageGroup_58308_Name|海市蜃楼",
    TypeText = "StageGroup_58308_TypeText|湖中之城",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Wanda01.png",
    BattleBuff = {
      1,
      "ResonanceGroupWangda"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Icon_10.png"
    },
    StageGroupDropPreview = {38704, 38702},
    StageDisplayDate = 1774659600,
    Bonus = {
      58320,
      58322,
      58321,
      58324,
      58323,
      58325
    },
    BonusTips = {
      "BonusTips_WandaActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_WandaActivity",
      "BonusAffix_WandaActivity"
    }
  },
  [58309] = {
    ID = 58309,
    CnID = "关卡组@旺达复刻活动7",
    BaseSortID = 465,
    Type = 40,
    Name = "StageGroup_58309_Name|一段记忆",
    TypeText = "StageGroup_58309_TypeText|湖中之城",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Wanda01.png",
    BattleBuff = {
      1,
      "ResonanceGroupWangda"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "UIResources/UIBigImages/UI_Events/UI_Events_Image_Icon_12.png"
    },
    StageGroupDropPreview = {
      38704,
      38703,
      38702
    },
    StageDisplayDate = 1774746000,
    Bonus = {
      58320,
      58322,
      58321,
      58324,
      58323,
      58325
    },
    BonusTips = {
      "BonusTips_WandaActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_WandaActivity",
      "BonusAffix_WandaActivity"
    }
  },
  [56455] = {
    ID = 56455,
    CnID = "关卡组@塔薇活动1",
    BaseSortID = 466,
    Type = 36,
    Name = "StageGroup_56455_Name|启程",
    TypeText = "StageGroup_56455_TypeText|最终测试",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Tawil01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56486, 9762},
    StageDisplayDate = 1762131600,
    Bonus = {57148, 57145},
    BonusTips = {
      "BonusTips_TawilActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_TawilActivity",
      "BonusAffix_TawilActivity"
    }
  },
  [56454] = {
    ID = 56454,
    CnID = "关卡组@塔薇活动2",
    BaseSortID = 467,
    Type = 36,
    Name = "StageGroup_56454_Name|本性之门",
    TypeText = "StageGroup_56454_TypeText|最终测试",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Tawil01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56486, 9799},
    StageDisplayDate = 1762218000,
    Bonus = {57148, 57145},
    BonusTips = {
      "BonusTips_TawilActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_TawilActivity",
      "BonusAffix_TawilActivity"
    }
  },
  [56453] = {
    ID = 56453,
    CnID = "关卡组@塔薇活动3",
    BaseSortID = 468,
    Type = 36,
    Name = "StageGroup_56453_Name|是非之门",
    TypeText = "StageGroup_56453_TypeText|最终测试",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Tawil01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56486, 9971},
    StageDisplayDate = 1762304400,
    Bonus = {57148, 57145},
    BonusTips = {
      "BonusTips_TawilActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_TawilActivity",
      "BonusAffix_TawilActivity"
    }
  },
  [56452] = {
    ID = 56452,
    CnID = "关卡组@塔薇活动4",
    BaseSortID = 469,
    Type = 36,
    Name = "StageGroup_56452_Name|理智之门",
    TypeText = "StageGroup_56452_TypeText|最终测试",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Tawil01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56486, 9925},
    StageDisplayDate = 1762390800,
    Bonus = {57148, 57145},
    BonusTips = {
      "BonusTips_TawilActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_TawilActivity",
      "BonusAffix_TawilActivity"
    }
  },
  [56451] = {
    ID = 56451,
    CnID = "关卡组@塔薇活动5",
    BaseSortID = 470,
    Type = 36,
    Name = "StageGroup_56451_Name|知行之门",
    TypeText = "StageGroup_56451_TypeText|最终测试",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Tawil01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56486, 9768},
    StageDisplayDate = 1762477200,
    Bonus = {57148, 57145},
    BonusTips = {
      "BonusTips_TawilActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_TawilActivity",
      "BonusAffix_TawilActivity"
    }
  },
  [56450] = {
    ID = 56450,
    CnID = "关卡组@塔薇活动6",
    BaseSortID = 471,
    Type = 36,
    Name = "StageGroup_56450_Name|归一之门",
    TypeText = "StageGroup_56450_TypeText|最终测试",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Tawil01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56486, 9769},
    StageDisplayDate = 1762563600,
    Bonus = {57148, 57145},
    BonusTips = {
      "BonusTips_TawilActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_TawilActivity",
      "BonusAffix_TawilActivity"
    }
  },
  [56449] = {
    ID = 56449,
    CnID = "关卡组@塔薇活动7",
    BaseSortID = 472,
    Type = 36,
    Name = "StageGroup_56449_Name|诸世之门",
    TypeText = "StageGroup_56449_TypeText|最终测试",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Tawil01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56486, 9812},
    StageDisplayDate = 1762650000,
    Bonus = {57148, 57145},
    BonusTips = {
      "BonusTips_TawilActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_TawilActivity",
      "BonusAffix_TawilActivity"
    }
  },
  [56457] = {
    ID = 56457,
    CnID = "关卡组@塔薇活动8",
    BaseSortID = 473,
    Type = 36,
    Name = "StageGroup_56457_Name|穷极之门",
    TypeText = "StageGroup_56457_TypeText|最终测试",
    Sequence = 8,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Tawil01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56486, 9671},
    StageDisplayDate = 1762736400,
    Bonus = {57148, 57145},
    BonusTips = {
      "BonusTips_TawilActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_TawilActivity",
      "BonusAffix_TawilActivity"
    }
  },
  [56456] = {
    ID = 56456,
    CnID = "关卡组@塔薇活动9",
    BaseSortID = 474,
    Type = 36,
    Name = "StageGroup_56456_Name|门扉之内",
    TypeText = "StageGroup_56456_TypeText|最终测试",
    Sequence = 9,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Tawil01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56486, 9756},
    StageDisplayDate = 1762822800,
    Bonus = {57148, 57145},
    BonusTips = {
      "BonusTips_TawilActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_TawilActivity",
      "BonusAffix_TawilActivity"
    }
  },
  [58315] = {
    ID = 58315,
    CnID = "关卡组@弥利亚姆复刻活动1",
    BaseSortID = 475,
    Type = 41,
    Name = "StageGroup_58315_Name|质疑",
    TypeText = "StageGroup_58315_TypeText|沉渊之祀",
    Sequence = 1,
    Backgrand = "Scenebg/SScene_UnderSea.png",
    BattleBuff = {
      1,
      "ResonanceGroupO07Activity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {52039},
    StageDisplayDate = 1793581200,
    Bonus = {
      52054,
      52053,
      52052,
      52051,
      52050,
      52049
    },
    BonusTips = {
      "BonusTips_MiryamActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MiryamActivity",
      "BonusAffix_MiryamActivity"
    }
  },
  [58316] = {
    ID = 58316,
    CnID = "关卡组@弥利亚姆复刻活动2",
    BaseSortID = 476,
    Type = 41,
    Name = "StageGroup_58316_Name|见证",
    TypeText = "StageGroup_58316_TypeText|沉渊之祀",
    Sequence = 2,
    Backgrand = "Scenebg/SScene_UnderSea.png",
    BattleBuff = {
      1,
      "ResonanceGroupO07Activity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {52039, 52038},
    StageDisplayDate = 1793754000,
    Bonus = {
      52054,
      52053,
      52052,
      52051,
      52050,
      52049
    },
    BonusTips = {
      "BonusTips_MiryamActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MiryamActivity",
      "BonusAffix_MiryamActivity"
    }
  },
  [58317] = {
    ID = 58317,
    CnID = "关卡组@弥利亚姆复刻活动3",
    BaseSortID = 477,
    Type = 41,
    Name = "StageGroup_58317_Name|动摇",
    TypeText = "StageGroup_58317_TypeText|沉渊之祀",
    Sequence = 3,
    Backgrand = "Scenebg/SScene_UnderSea.png",
    BattleBuff = {
      1,
      "ResonanceGroupO07Activity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {52039, 52037},
    StageDisplayDate = 1793926800,
    Bonus = {
      52054,
      52053,
      52052,
      52051,
      52050,
      52049
    },
    BonusTips = {
      "BonusTips_MiryamActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MiryamActivity",
      "BonusAffix_MiryamActivity"
    }
  },
  [58318] = {
    ID = 58318,
    CnID = "关卡组@弥利亚姆复刻活动4",
    BaseSortID = 478,
    Type = 41,
    Name = "StageGroup_58318_Name|笃信",
    TypeText = "StageGroup_58318_TypeText|沉渊之祀",
    Sequence = 4,
    Backgrand = "Scenebg/SScene_UnderSea.png",
    BattleBuff = {
      1,
      "ResonanceGroupO07Activity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {52038, 52037},
    StageDisplayDate = 1794099600,
    Bonus = {
      52054,
      52053,
      52052,
      52051,
      52050,
      52049
    },
    BonusTips = {
      "BonusTips_MiryamActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MiryamActivity",
      "BonusAffix_MiryamActivity"
    }
  },
  [58319] = {
    ID = 58319,
    CnID = "关卡组@弥利亚姆复刻活动5",
    BaseSortID = 479,
    Type = 41,
    Name = "StageGroup_58319_Name|降临",
    TypeText = "StageGroup_58319_TypeText|沉渊之祀",
    Sequence = 5,
    Backgrand = "Scenebg/SScene_UnderSea.png",
    BattleBuff = {
      1,
      "ResonanceGroupO07Activity"
    },
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      52039,
      52038,
      52037
    },
    StageDisplayDate = 1794272400,
    Bonus = {
      52054,
      52053,
      52052,
      52051,
      52050,
      52049
    },
    BonusTips = {
      "BonusTips_MiryamActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MiryamActivity",
      "BonusAffix_MiryamActivity"
    }
  },
  [56460] = {
    ID = 56460,
    CnID = "关卡组@本源朵尔活动1",
    BaseSortID = 480,
    Type = 37,
    Name = "StageGroup_56460_Name|狂灾",
    TypeText = "StageGroup_56460_TypeText|虚无之门",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriDoll02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56483, 9762},
    StageDisplayDate = 1750035600,
    Bonus = {57155, 57157},
    BonusTips = {
      "BonusTips_OriginDollActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginDollActivity",
      "BonusAffix_OriginDollActivity"
    }
  },
  [56462] = {
    ID = 56462,
    CnID = "关卡组@本源朵尔活动2",
    BaseSortID = 481,
    Type = 37,
    Name = "StageGroup_56462_Name|星星",
    TypeText = "StageGroup_56462_TypeText|虚无之门",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriDoll02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56483, 9799},
    StageDisplayDate = 1750122000,
    Bonus = {57155, 57157},
    BonusTips = {
      "BonusTips_OriginDollActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginDollActivity",
      "BonusAffix_OriginDollActivity"
    }
  },
  [56461] = {
    ID = 56461,
    CnID = "关卡组@本源朵尔活动3",
    BaseSortID = 482,
    Type = 37,
    Name = "StageGroup_56461_Name|璀璨消亡",
    TypeText = "StageGroup_56461_TypeText|虚无之门",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriDoll02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56483, 9971},
    StageDisplayDate = 1750208400,
    Bonus = {57155, 57157},
    BonusTips = {
      "BonusTips_OriginDollActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginDollActivity",
      "BonusAffix_OriginDollActivity"
    }
  },
  [56464] = {
    ID = 56464,
    CnID = "关卡组@本源朵尔活动4",
    BaseSortID = 483,
    Type = 37,
    Name = "StageGroup_56464_Name|人偶之屋",
    TypeText = "StageGroup_56464_TypeText|虚无之门",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriDoll02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56483, 9925},
    StageDisplayDate = 1750294800,
    Bonus = {57155, 57157},
    BonusTips = {
      "BonusTips_OriginDollActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginDollActivity",
      "BonusAffix_OriginDollActivity"
    }
  },
  [56463] = {
    ID = 56463,
    CnID = "关卡组@本源朵尔活动5",
    BaseSortID = 484,
    Type = 37,
    Name = "StageGroup_56463_Name|真实毒药",
    TypeText = "StageGroup_56463_TypeText|虚无之门",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriDoll02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56483, 9768},
    StageDisplayDate = 1750381200,
    Bonus = {57155, 57157},
    BonusTips = {
      "BonusTips_OriginDollActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginDollActivity",
      "BonusAffix_OriginDollActivity"
    }
  },
  [56466] = {
    ID = 56466,
    CnID = "关卡组@本源朵尔活动6",
    BaseSortID = 485,
    Type = 37,
    Name = "StageGroup_56466_Name|傀儡线",
    TypeText = "StageGroup_56466_TypeText|虚无之门",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriDoll02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56483, 9769},
    StageDisplayDate = 1750467600,
    Bonus = {57155, 57157},
    BonusTips = {
      "BonusTips_OriginDollActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginDollActivity",
      "BonusAffix_OriginDollActivity"
    }
  },
  [56465] = {
    ID = 56465,
    CnID = "关卡组@本源朵尔活动7",
    BaseSortID = 486,
    Type = 37,
    Name = "StageGroup_56465_Name|混沌预言",
    TypeText = "StageGroup_56465_TypeText|虚无之门",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriDoll02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56483, 9812},
    StageDisplayDate = 1750554000,
    Bonus = {57155, 57157},
    BonusTips = {
      "BonusTips_OriginDollActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginDollActivity",
      "BonusAffix_OriginDollActivity"
    }
  },
  [56459] = {
    ID = 56459,
    CnID = "关卡组@本源朵尔活动8",
    BaseSortID = 487,
    Type = 37,
    Name = "StageGroup_56459_Name|邀请",
    TypeText = "StageGroup_56459_TypeText|虚无之门",
    Sequence = 8,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriDoll02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56483, 9671},
    StageDisplayDate = 1750640400,
    Bonus = {57155, 57157},
    BonusTips = {
      "BonusTips_OriginDollActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginDollActivity",
      "BonusAffix_OriginDollActivity"
    }
  },
  [56458] = {
    ID = 56458,
    CnID = "关卡组@本源朵尔活动9",
    BaseSortID = 488,
    Type = 37,
    Name = "StageGroup_56458_Name|狂欢舞会",
    TypeText = "StageGroup_56458_TypeText|虚无之门",
    Sequence = 9,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriDoll02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {56483, 9756},
    StageDisplayDate = 1750726800,
    Bonus = {57155, 57157},
    BonusTips = {
      "BonusTips_OriginDollActivity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginDollActivity",
      "BonusAffix_OriginDollActivity"
    }
  },
  [75731] = {
    ID = 75731,
    CnID = "关卡组@达芙黛尔活动1",
    BaseSortID = 489,
    Type = 43,
    Name = "StageGroup_75731_Name|雨夜追猎",
    TypeText = "StageGroup_75731_TypeText|魔女小店",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Daffodil01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {75786},
    StageDisplayDate = 1768179600,
    Bonus = {
      75903,
      75902,
      75901,
      75906,
      75905,
      75904
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_DaffodilActivity",
      "BonusAffix_Activity"
    }
  },
  [75729] = {
    ID = 75729,
    CnID = "关卡组@达芙黛尔活动2",
    BaseSortID = 490,
    Type = 43,
    Name = "StageGroup_75729_Name|无头尸",
    TypeText = "StageGroup_75729_TypeText|魔女小店",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Daffodil01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {75786, 75785},
    StageDisplayDate = 1768352400,
    Bonus = {
      75903,
      75902,
      75901,
      75906,
      75905,
      75904
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_DaffodilActivity",
      "BonusAffix_Activity"
    }
  },
  [75730] = {
    ID = 75730,
    CnID = "关卡组@达芙黛尔活动3",
    BaseSortID = 491,
    Type = 43,
    Name = "StageGroup_75730_Name|沼泽恶鬼",
    TypeText = "StageGroup_75730_TypeText|魔女小店",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Daffodil01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {75786, 75784},
    StageDisplayDate = 1768525200,
    Bonus = {
      75903,
      75902,
      75901,
      75906,
      75905,
      75904
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_DaffodilActivity",
      "BonusAffix_Activity"
    }
  },
  [75734] = {
    ID = 75734,
    CnID = "关卡组@达芙黛尔活动4",
    BaseSortID = 492,
    Type = 43,
    Name = "StageGroup_75734_Name|它与她",
    TypeText = "StageGroup_75734_TypeText|魔女小店",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Daffodil01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {75785, 75784},
    StageDisplayDate = 1768698000,
    Bonus = {
      75903,
      75902,
      75901,
      75906,
      75905,
      75904
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_DaffodilActivity",
      "BonusAffix_Activity"
    }
  },
  [75735] = {
    ID = 75735,
    CnID = "关卡组@达芙黛尔活动5",
    BaseSortID = 493,
    Type = 43,
    Name = "StageGroup_75735_Name|归于灰海",
    TypeText = "StageGroup_75735_TypeText|魔女小店",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Daffodil01.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      75786,
      75785,
      75784
    },
    StageDisplayDate = 1768870800,
    Bonus = {
      75903,
      75902,
      75901,
      75906,
      75905,
      75904
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_DaffodilActivity",
      "BonusAffix_Activity"
    }
  },
  [79571] = {
    ID = 79571,
    CnID = "关卡组@克莱门汀活动1",
    BaseSortID = 494,
    Type = 44,
    Name = "StageGroup_79571_Name|侵梦之时",
    TypeText = "StageGroup_79571_TypeText|恐惧愈疗",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Clementine01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {79568},
    StageDisplayDate = 1743987600,
    Bonus = {79642, 79644},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ClementineActivity",
      "BonusAffix_Activity"
    }
  },
  [79572] = {
    ID = 79572,
    CnID = "关卡组@克莱门汀活动2",
    BaseSortID = 495,
    Type = 44,
    Name = "StageGroup_79572_Name|记忆诊所",
    TypeText = "StageGroup_79572_TypeText|恐惧愈疗",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Clementine01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {79568},
    StageDisplayDate = 1744160400,
    Bonus = {79642, 79644},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ClementineActivity",
      "BonusAffix_Activity"
    }
  },
  [79573] = {
    ID = 79573,
    CnID = "关卡组@克莱门汀活动3",
    BaseSortID = 496,
    Type = 44,
    Name = "StageGroup_79573_Name|燃烧的世界",
    TypeText = "StageGroup_79573_TypeText|恐惧愈疗",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Clementine01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {79568},
    StageDisplayDate = 1744333200,
    Bonus = {79642, 79644},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ClementineActivity",
      "BonusAffix_Activity"
    }
  },
  [79569] = {
    ID = 79569,
    CnID = "关卡组@克莱门汀活动4",
    BaseSortID = 497,
    Type = 44,
    Name = "StageGroup_79569_Name|逐火之蛾",
    TypeText = "StageGroup_79569_TypeText|恐惧愈疗",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Clementine01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {79568},
    StageDisplayDate = 1744506000,
    Bonus = {79642, 79644},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ClementineActivity",
      "BonusAffix_Activity"
    }
  },
  [79570] = {
    ID = 79570,
    CnID = "关卡组@克莱门汀活动5",
    BaseSortID = 498,
    Type = 44,
    Name = "StageGroup_79570_Name|新生",
    TypeText = "StageGroup_79570_TypeText|恐惧愈疗",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Clementine01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {79568},
    StageDisplayDate = 1744678800,
    Bonus = {79642, 79644},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ClementineActivity",
      "BonusAffix_Activity"
    }
  },
  [81253] = {
    ID = 81253,
    CnID = "关卡组@克珀珊特活动1",
    BaseSortID = 499,
    Type = 45,
    Name = "StageGroup_81253_Name|老式六分仪",
    TypeText = "StageGroup_81253_TypeText|邃海迷航",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_StElmosFire02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {81250, 9762},
    StageDisplayDate = 1746406800,
    Bonus = {81265, 81264},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_StElmosFireActivity",
      "BonusAffix_Activity"
    }
  },
  [81251] = {
    ID = 81251,
    CnID = "关卡组@克珀珊特活动2",
    BaseSortID = 500,
    Type = 45,
    Name = "StageGroup_81251_Name|古老海图",
    TypeText = "StageGroup_81251_TypeText|邃海迷航",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_StElmosFire02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {81250, 9799},
    StageDisplayDate = 1746493200,
    Bonus = {81265, 81264},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_StElmosFireActivity",
      "BonusAffix_Activity"
    }
  },
  [81252] = {
    ID = 81252,
    CnID = "关卡组@克珀珊特活动3",
    BaseSortID = 501,
    Type = 45,
    Name = "StageGroup_81252_Name|破旧罗盘",
    TypeText = "StageGroup_81252_TypeText|邃海迷航",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_StElmosFire02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {81250, 9971},
    StageDisplayDate = 1746579600,
    Bonus = {81265, 81264},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_StElmosFireActivity",
      "BonusAffix_Activity"
    }
  },
  [81256] = {
    ID = 81256,
    CnID = "关卡组@克珀珊特活动4",
    BaseSortID = 502,
    Type = 45,
    Name = "StageGroup_81256_Name|斑驳星盘",
    TypeText = "StageGroup_81256_TypeText|邃海迷航",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_StElmosFire02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {81250, 9925},
    StageDisplayDate = 1746666000,
    Bonus = {81265, 81264},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_StElmosFireActivity",
      "BonusAffix_Activity"
    }
  },
  [81257] = {
    ID = 81257,
    CnID = "关卡组@克珀珊特活动5",
    BaseSortID = 503,
    Type = 45,
    Name = "StageGroup_81257_Name|星辰轨迹",
    TypeText = "StageGroup_81257_TypeText|邃海迷航",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_StElmosFire02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {81250, 9768},
    StageDisplayDate = 1746752400,
    Bonus = {81265, 81264},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_StElmosFireActivity",
      "BonusAffix_Activity"
    }
  },
  [81254] = {
    ID = 81254,
    CnID = "关卡组@克珀珊特活动6",
    BaseSortID = 504,
    Type = 45,
    Name = "StageGroup_81254_Name|导航员手册",
    TypeText = "StageGroup_81254_TypeText|邃海迷航",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_StElmosFire02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {81250, 9769},
    StageDisplayDate = 1746838800,
    Bonus = {81265, 81264},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_StElmosFireActivity",
      "BonusAffix_Activity"
    }
  },
  [81255] = {
    ID = 81255,
    CnID = "关卡组@克珀珊特活动7",
    BaseSortID = 505,
    Type = 45,
    Name = "StageGroup_81255_Name|信号旗语",
    TypeText = "StageGroup_81255_TypeText|邃海迷航",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_StElmosFire02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {81250, 9812},
    StageDisplayDate = 1746925200,
    Bonus = {81265, 81264},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_StElmosFireActivity",
      "BonusAffix_Activity"
    }
  },
  [81259] = {
    ID = 81259,
    CnID = "关卡组@克珀珊特活动8",
    BaseSortID = 506,
    Type = 45,
    Name = "StageGroup_81259_Name|领航之光",
    TypeText = "StageGroup_81259_TypeText|邃海迷航",
    Sequence = 8,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_StElmosFire02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {81250, 9671},
    StageDisplayDate = 1747011600,
    Bonus = {81265, 81264},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_StElmosFireActivity",
      "BonusAffix_Activity"
    }
  },
  [81260] = {
    ID = 81260,
    CnID = "关卡组@克珀珊特活动9",
    BaseSortID = 507,
    Type = 45,
    Name = "StageGroup_81260_Name|最终挽歌",
    TypeText = "StageGroup_81260_TypeText|邃海迷航",
    Sequence = 9,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_StElmosFire02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {81250, 9756},
    StageDisplayDate = 1747098000,
    Bonus = {81265, 81264},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_StElmosFireActivity",
      "BonusAffix_Activity"
    }
  },
  [88940] = {
    ID = 88940,
    CnID = "关卡组@卡斯托尔活动1",
    BaseSortID = 508,
    Type = 46,
    Name = "StageGroup_88940_Name|破开囚笼",
    TypeText = "StageGroup_88940_TypeText|飞跃青空",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Castor01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {88804},
    StageDisplayDate = 1791162000,
    Bonus = {88725, 88727},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_CastorActivity",
      "BonusAffix_Activity"
    }
  },
  [88935] = {
    ID = 88935,
    CnID = "关卡组@卡斯托尔活动2",
    BaseSortID = 509,
    Type = 46,
    Name = "StageGroup_88935_Name|昨日之梦",
    TypeText = "StageGroup_88935_TypeText|飞跃青空",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Castor01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {88844},
    StageDisplayDate = 1791248400,
    Bonus = {88728, 88726},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_CastorActivity",
      "BonusAffix_Activity"
    }
  },
  [88939] = {
    ID = 88939,
    CnID = "关卡组@卡斯托尔活动3",
    BaseSortID = 510,
    Type = 46,
    Name = "StageGroup_88939_Name|传烛者",
    TypeText = "StageGroup_88939_TypeText|飞跃青空",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Castor01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {88809},
    StageDisplayDate = 1791334800,
    Bonus = {88724, 88729},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_CastorActivity",
      "BonusAffix_Activity"
    }
  },
  [88936] = {
    ID = 88936,
    CnID = "关卡组@卡斯托尔活动4",
    BaseSortID = 511,
    Type = 46,
    Name = "StageGroup_88936_Name|愚者",
    TypeText = "StageGroup_88936_TypeText|飞跃青空",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Castor01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {88804, 88844},
    StageDisplayDate = 1791421200,
    Bonus = {
      88725,
      88727,
      88728,
      88726
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_CastorActivity",
      "BonusAffix_Activity"
    }
  },
  [88937] = {
    ID = 88937,
    CnID = "关卡组@卡斯托尔活动5",
    BaseSortID = 512,
    Type = 46,
    Name = "StageGroup_88937_Name|孤独之旅",
    TypeText = "StageGroup_88937_TypeText|飞跃青空",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Castor01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {88844, 88809},
    StageDisplayDate = 1791507600,
    Bonus = {
      88728,
      88726,
      88724,
      88729
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_CastorActivity",
      "BonusAffix_Activity"
    }
  },
  [88933] = {
    ID = 88933,
    CnID = "关卡组@卡斯托尔活动6",
    BaseSortID = 513,
    Type = 46,
    Name = "StageGroup_88933_Name|无尽沙",
    TypeText = "StageGroup_88933_TypeText|飞跃青空",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Castor01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {88804, 88809},
    StageDisplayDate = 1791594000,
    Bonus = {
      88725,
      88727,
      88724,
      88729
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_CastorActivity",
      "BonusAffix_Activity"
    }
  },
  [88938] = {
    ID = 88938,
    CnID = "关卡组@卡斯托尔活动7",
    BaseSortID = 514,
    Type = 46,
    Name = "StageGroup_88938_Name|自由与死亡",
    TypeText = "StageGroup_88938_TypeText|飞跃青空",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Castor01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      88804,
      88844,
      88809
    },
    StageDisplayDate = 1791680400,
    Bonus = {
      88725,
      88727,
      88728,
      88726,
      88724,
      88729
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_CastorActivity",
      "BonusAffix_Activity"
    }
  },
  [91020] = {
    ID = 91020,
    CnID = "关卡组@罗马活动1",
    BaseSortID = 515,
    Type = 48,
    Name = "StageGroup_91020_Name|远征号角",
    TypeText = "StageGroup_91020_TypeText|神圣的猎食",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Rome02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {90957},
    StageDisplayDate = 1777856400
  },
  [91022] = {
    ID = 91022,
    CnID = "关卡组@罗马活动2",
    BaseSortID = 516,
    Type = 48,
    Name = "StageGroup_91022_Name|凶猛猎手",
    TypeText = "StageGroup_91022_TypeText|神圣的猎食",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Rome02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {90957},
    StageDisplayDate = 1778029200
  },
  [91023] = {
    ID = 91023,
    CnID = "关卡组@罗马活动3",
    BaseSortID = 517,
    Type = 48,
    Name = "StageGroup_91023_Name|合作智慧",
    TypeText = "StageGroup_91023_TypeText|神圣的猎食",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Rome02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {90957},
    StageDisplayDate = 1778202000
  },
  [91024] = {
    ID = 91024,
    CnID = "关卡组@罗马活动4",
    BaseSortID = 518,
    Type = 48,
    Name = "StageGroup_91024_Name|勇士桂冠",
    TypeText = "StageGroup_91024_TypeText|神圣的猎食",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Rome02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {90957},
    StageDisplayDate = 1778374800
  },
  [91025] = {
    ID = 91025,
    CnID = "关卡组@罗马活动5",
    BaseSortID = 519,
    Type = 48,
    Name = "StageGroup_91025_Name|荣耀凯旋",
    TypeText = "StageGroup_91025_TypeText|神圣的猎食",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Rome02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {90957},
    StageDisplayDate = 1778547600
  },
  [95782] = {
    ID = 95782,
    CnID = "关卡组@杜勒赛因活动1",
    BaseSortID = 520,
    Type = 47,
    Name = "StageGroup_95782_Name|沉棺开启",
    TypeText = "StageGroup_95782_TypeText|噬灵之飨",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Doresain02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {95678},
    StageDisplayDate = 1753059600,
    Bonus = {95602, 95603},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_DoresainActivity",
      "BonusAffix_Activity"
    }
  },
  [95781] = {
    ID = 95781,
    CnID = "关卡组@杜勒赛因活动2",
    BaseSortID = 521,
    Type = 47,
    Name = "StageGroup_95781_Name|骨血剥离",
    TypeText = "StageGroup_95781_TypeText|噬灵之飨",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Doresain02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {95678},
    StageDisplayDate = 1753232400,
    Bonus = {95602, 95603},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_DoresainActivity",
      "BonusAffix_Activity"
    }
  },
  [95780] = {
    ID = 95780,
    CnID = "关卡组@杜勒赛因活动3",
    BaseSortID = 522,
    Type = 47,
    Name = "StageGroup_95780_Name|腐殖调香",
    TypeText = "StageGroup_95780_TypeText|噬灵之飨",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Doresain02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {95678},
    StageDisplayDate = 1753405200,
    Bonus = {95602, 95603},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_DoresainActivity",
      "BonusAffix_Activity"
    }
  },
  [95779] = {
    ID = 95779,
    CnID = "关卡组@杜勒赛因活动4",
    BaseSortID = 523,
    Type = 47,
    Name = "StageGroup_95779_Name|亡焰炙魂",
    TypeText = "StageGroup_95779_TypeText|噬灵之飨",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Doresain02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {95678},
    StageDisplayDate = 1753578000,
    Bonus = {95602, 95603},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_DoresainActivity",
      "BonusAffix_Activity"
    }
  },
  [95778] = {
    ID = 95778,
    CnID = "关卡组@杜勒赛因活动5",
    BaseSortID = 524,
    Type = 47,
    Name = "StageGroup_95778_Name|灵龛盛筵",
    TypeText = "StageGroup_95778_TypeText|噬灵之飨",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Doresain02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {95678},
    StageDisplayDate = 1753750800,
    Bonus = {95602, 95603},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_DoresainActivity",
      "BonusAffix_Activity"
    }
  },
  [95181] = {
    ID = 95181,
    CnID = "关卡组@凯蒂古拉活动1",
    BaseSortID = 525,
    Type = 50,
    Name = "StageGroup_95181_Name|亘古誓言",
    TypeText = "StageGroup_95181_TypeText|烬灭追猎",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_KathiguRa04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {95120},
    StageDisplayDate = 1788742800,
    Bonus = {95101, 95102},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_KathiguRaActivity",
      "BonusAffix_Activity"
    }
  },
  [95189] = {
    ID = 95189,
    CnID = "关卡组@凯蒂古拉活动2",
    BaseSortID = 526,
    Type = 50,
    Name = "StageGroup_95189_Name|契约目标",
    TypeText = "StageGroup_95189_TypeText|烬灭追猎",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_KathiguRa04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {95119},
    StageDisplayDate = 1788829200,
    Bonus = {95099, 95103},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_KathiguRaActivity",
      "BonusAffix_Activity"
    }
  },
  [95183] = {
    ID = 95183,
    CnID = "关卡组@凯蒂古拉活动3",
    BaseSortID = 527,
    Type = 50,
    Name = "StageGroup_95183_Name|炽焰宣判",
    TypeText = "StageGroup_95183_TypeText|烬灭追猎",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_KathiguRa04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {95169},
    StageDisplayDate = 1788915600,
    Bonus = {95100, 95104},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_KathiguRaActivity",
      "BonusAffix_Activity"
    }
  },
  [95188] = {
    ID = 95188,
    CnID = "关卡组@凯蒂古拉活动4",
    BaseSortID = 528,
    Type = 50,
    Name = "StageGroup_95188_Name|覆世之光",
    TypeText = "StageGroup_95188_TypeText|烬灭追猎",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_KathiguRa04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {95120, 95119},
    StageDisplayDate = 1789002000,
    Bonus = {
      95101,
      95102,
      95099,
      95103
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_KathiguRaActivity",
      "BonusAffix_Activity"
    }
  },
  [95180] = {
    ID = 95180,
    CnID = "关卡组@凯蒂古拉活动5",
    BaseSortID = 529,
    Type = 50,
    Name = "StageGroup_95180_Name|地表的太阳",
    TypeText = "StageGroup_95180_TypeText|烬灭追猎",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_KathiguRa04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {95119, 95169},
    StageDisplayDate = 1789088400,
    Bonus = {
      95099,
      95103,
      95100,
      95104
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_KathiguRaActivity",
      "BonusAffix_Activity"
    }
  },
  [95187] = {
    ID = 95187,
    CnID = "关卡组@凯蒂古拉活动6",
    BaseSortID = 530,
    Type = 50,
    Name = "StageGroup_95187_Name|炼狱之歌",
    TypeText = "StageGroup_95187_TypeText|烬灭追猎",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_KathiguRa04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {95120, 95169},
    StageDisplayDate = 1789174800,
    Bonus = {
      95101,
      95102,
      95100,
      95104
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_KathiguRaActivity",
      "BonusAffix_Activity"
    }
  },
  [95185] = {
    ID = 95185,
    CnID = "关卡组@凯蒂古拉活动7",
    BaseSortID = 531,
    Type = 50,
    Name = "StageGroup_95185_Name|无声的世界",
    TypeText = "StageGroup_95185_TypeText|烬灭追猎",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_KathiguRa04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      95120,
      95119,
      95169
    },
    StageDisplayDate = 1789261200,
    Bonus = {
      95101,
      95102,
      95099,
      95103,
      95100,
      95104
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_KathiguRaActivity",
      "BonusAffix_Activity"
    }
  },
  [96828] = {
    ID = 96828,
    CnID = "关卡组@皮克曼活动1",
    BaseSortID = 532,
    Type = 51,
    Name = "StageGroup_96828_Name|灵感侵染",
    TypeText = "StageGroup_96828_TypeText|异界图卷",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pickman04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {96827},
    StageDisplayDate = 1757293200,
    Bonus = {96817, 96820},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PickmanActivity",
      "BonusAffix_Activity"
    }
  },
  [96832] = {
    ID = 96832,
    CnID = "关卡组@皮克曼活动2",
    BaseSortID = 533,
    Type = 51,
    Name = "StageGroup_96832_Name|线魂肆虐",
    TypeText = "StageGroup_96832_TypeText|异界图卷",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pickman04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {96825},
    StageDisplayDate = 1757379600,
    Bonus = {96821, 96818},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PickmanActivity",
      "BonusAffix_Activity"
    }
  },
  [96837] = {
    ID = 96837,
    CnID = "关卡组@皮克曼活动3",
    BaseSortID = 534,
    Type = 51,
    Name = "StageGroup_96837_Name|血色蔓延",
    TypeText = "StageGroup_96837_TypeText|异界图卷",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pickman04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {96826},
    StageDisplayDate = 1757466000,
    Bonus = {96819, 96816},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PickmanActivity",
      "BonusAffix_Activity"
    }
  },
  [96830] = {
    ID = 96830,
    CnID = "关卡组@皮克曼活动4",
    BaseSortID = 535,
    Type = 51,
    Name = "StageGroup_96830_Name|梦魇堆垒",
    TypeText = "StageGroup_96830_TypeText|异界图卷",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pickman04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {96827, 96825},
    StageDisplayDate = 1757552400,
    Bonus = {
      96817,
      96820,
      96821,
      96818
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PickmanActivity",
      "BonusAffix_Activity"
    }
  },
  [96836] = {
    ID = 96836,
    CnID = "关卡组@皮克曼活动5",
    BaseSortID = 536,
    Type = 51,
    Name = "StageGroup_96836_Name|地狱之变",
    TypeText = "StageGroup_96836_TypeText|异界图卷",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pickman04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {96825, 96826},
    StageDisplayDate = 1757638800,
    Bonus = {
      96821,
      96818,
      96819,
      96816
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PickmanActivity",
      "BonusAffix_Activity"
    }
  },
  [96833] = {
    ID = 96833,
    CnID = "关卡组@皮克曼活动6",
    BaseSortID = 537,
    Type = 51,
    Name = "StageGroup_96833_Name|金牛疯舞",
    TypeText = "StageGroup_96833_TypeText|异界图卷",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pickman04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {96827, 96826},
    StageDisplayDate = 1757725200,
    Bonus = {
      96817,
      96820,
      96819,
      96816
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PickmanActivity",
      "BonusAffix_Activity"
    }
  },
  [96829] = {
    ID = 96829,
    CnID = "关卡组@皮克曼活动7",
    BaseSortID = 538,
    Type = 51,
    Name = "StageGroup_96829_Name|狂欢定格",
    TypeText = "StageGroup_96829_TypeText|异界图卷",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pickman04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      96827,
      96825,
      96826
    },
    StageDisplayDate = 1757811600,
    Bonus = {
      96817,
      96820,
      96821,
      96818,
      96819,
      96816
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PickmanActivity",
      "BonusAffix_Activity"
    }
  },
  [97664] = {
    ID = 97664,
    CnID = "关卡组@本源深海淑女活动1",
    BaseSortID = 539,
    Type = 52,
    Name = "StageGroup_97664_Name|第一日",
    TypeText = "StageGroup_97664_TypeText|创生七日",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriMurphy04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {97594},
    StageDisplayDate = 1763946000,
    Bonus = {97709, 97713},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginMurphyActivity",
      "BonusAffix_Activity"
    }
  },
  [97669] = {
    ID = 97669,
    CnID = "关卡组@本源深海淑女活动2",
    BaseSortID = 540,
    Type = 52,
    Name = "StageGroup_97669_Name|第二日",
    TypeText = "StageGroup_97669_TypeText|创生七日",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriMurphy04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {97585},
    StageDisplayDate = 1764032400,
    Bonus = {97710, 97708},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginMurphyActivity",
      "BonusAffix_Activity"
    }
  },
  [97665] = {
    ID = 97665,
    CnID = "关卡组@本源深海淑女活动3",
    BaseSortID = 541,
    Type = 52,
    Name = "StageGroup_97665_Name|第三日",
    TypeText = "StageGroup_97665_TypeText|创生七日",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriMurphy04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {97575},
    StageDisplayDate = 1764118800,
    Bonus = {97711, 97712},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginMurphyActivity",
      "BonusAffix_Activity"
    }
  },
  [97668] = {
    ID = 97668,
    CnID = "关卡组@本源深海淑女活动4",
    BaseSortID = 542,
    Type = 52,
    Name = "StageGroup_97668_Name|第四日",
    TypeText = "StageGroup_97668_TypeText|创生七日",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriMurphy04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {97594, 97585},
    StageDisplayDate = 1764205200,
    Bonus = {
      97709,
      97713,
      97710,
      97708
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginMurphyActivity",
      "BonusAffix_Activity"
    }
  },
  [97670] = {
    ID = 97670,
    CnID = "关卡组@本源深海淑女活动5",
    BaseSortID = 543,
    Type = 52,
    Name = "StageGroup_97670_Name|第五日",
    TypeText = "StageGroup_97670_TypeText|创生七日",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriMurphy04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {97594, 97575},
    StageDisplayDate = 1764291600,
    Bonus = {
      97709,
      97713,
      97711,
      97712
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginMurphyActivity",
      "BonusAffix_Activity"
    }
  },
  [97667] = {
    ID = 97667,
    CnID = "关卡组@本源深海淑女活动6",
    BaseSortID = 544,
    Type = 52,
    Name = "StageGroup_97667_Name|第六日",
    TypeText = "StageGroup_97667_TypeText|创生七日",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriMurphy04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {97585, 97575},
    StageDisplayDate = 1764378000,
    Bonus = {
      97710,
      97708,
      97711,
      97712
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginMurphyActivity",
      "BonusAffix_Activity"
    }
  },
  [97666] = {
    ID = 97666,
    CnID = "关卡组@本源深海淑女活动7",
    BaseSortID = 545,
    Type = 52,
    Name = "StageGroup_97666_Name|第七日",
    TypeText = "StageGroup_97666_TypeText|创生七日",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OriMurphy04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      97594,
      97585,
      97575
    },
    StageDisplayDate = 1764464400,
    Bonus = {
      97709,
      97713,
      97710,
      97708,
      97711,
      97712
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_OriginMurphyActivity",
      "BonusAffix_Activity"
    }
  },
  [98881] = {
    ID = 98881,
    CnID = "关卡组@波吕克斯活动1",
    BaseSortID = 546,
    Type = 53,
    Name = "StageGroup_98881_Name|天真时代",
    TypeText = "StageGroup_98881_TypeText|交融的苦血",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pollux05.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {116527},
    StageDisplayDate = 1760922000,
    Bonus = {116464, 116461},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PolluxActivity",
      "BonusAffix_Activity"
    }
  },
  [98882] = {
    ID = 98882,
    CnID = "关卡组@波吕克斯活动2",
    BaseSortID = 547,
    Type = 53,
    Name = "StageGroup_98882_Name|沉默觉醒",
    TypeText = "StageGroup_98882_TypeText|交融的苦血",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pollux05.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {116559},
    StageDisplayDate = 1761008400,
    Bonus = {116463, 116460},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PolluxActivity",
      "BonusAffix_Activity"
    }
  },
  [98878] = {
    ID = 98878,
    CnID = "关卡组@波吕克斯活动3",
    BaseSortID = 548,
    Type = 53,
    Name = "StageGroup_98878_Name|冒险童话",
    TypeText = "StageGroup_98878_TypeText|交融的苦血",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pollux05.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {116547},
    StageDisplayDate = 1761094800,
    Bonus = {116465, 116462},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PolluxActivity",
      "BonusAffix_Activity"
    }
  },
  [98879] = {
    ID = 98879,
    CnID = "关卡组@波吕克斯活动4",
    BaseSortID = 549,
    Type = 53,
    Name = "StageGroup_98879_Name|遗忘毒药",
    TypeText = "StageGroup_98879_TypeText|交融的苦血",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pollux05.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {116527, 116559},
    StageDisplayDate = 1761181200,
    Bonus = {
      116464,
      116461,
      116463,
      116460
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PolluxActivity",
      "BonusAffix_Activity"
    }
  },
  [98883] = {
    ID = 98883,
    CnID = "关卡组@波吕克斯活动5",
    BaseSortID = 550,
    Type = 53,
    Name = "StageGroup_98883_Name|旧账本",
    TypeText = "StageGroup_98883_TypeText|交融的苦血",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pollux05.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {116559, 116547},
    StageDisplayDate = 1761267600,
    Bonus = {
      116463,
      116460,
      116465,
      116462
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PolluxActivity",
      "BonusAffix_Activity"
    }
  },
  [98884] = {
    ID = 98884,
    CnID = "关卡组@波吕克斯活动6",
    BaseSortID = 551,
    Type = 53,
    Name = "StageGroup_98884_Name|风的托举",
    TypeText = "StageGroup_98884_TypeText|交融的苦血",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pollux05.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {116527, 116547},
    StageDisplayDate = 1761354000,
    Bonus = {
      116464,
      116461,
      116465,
      116462
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PolluxActivity",
      "BonusAffix_Activity"
    }
  },
  [98880] = {
    ID = 98880,
    CnID = "关卡组@波吕克斯活动7",
    BaseSortID = 552,
    Type = 53,
    Name = "StageGroup_98880_Name|双生羽翼",
    TypeText = "StageGroup_98880_TypeText|交融的苦血",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pollux05.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      116527,
      116559,
      116547
    },
    StageDisplayDate = 1761440400,
    Bonus = {
      116464,
      116461,
      116463,
      116460,
      116465,
      116462
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PolluxActivity",
      "BonusAffix_Activity"
    }
  },
  [97848] = {
    ID = 97848,
    CnID = "关卡组@夏日活动下活动1",
    BaseSortID = 553,
    Type = 49,
    Name = "StageGroup_97848_Name|故地重游",
    TypeText = "StageGroup_97848_TypeText|日光下新事",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Summer2_02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {97789},
    StageDisplayDate = 1785718800,
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_Summer2Activity",
      "BonusAffix_Activity"
    }
  },
  [97850] = {
    ID = 97850,
    CnID = "关卡组@夏日活动下活动2",
    BaseSortID = 554,
    Type = 49,
    Name = "StageGroup_97850_Name|机械之梦",
    TypeText = "StageGroup_97850_TypeText|日光下新事",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Summer2_02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {97789},
    StageDisplayDate = 1785891600,
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_Summer2Activity",
      "BonusAffix_Activity"
    }
  },
  [97846] = {
    ID = 97846,
    CnID = "关卡组@夏日活动下活动3",
    BaseSortID = 555,
    Type = 49,
    Name = "StageGroup_97846_Name|诗意花园",
    TypeText = "StageGroup_97846_TypeText|日光下新事",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Summer2_02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {97789},
    StageDisplayDate = 1786064400,
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_Summer2Activity",
      "BonusAffix_Activity"
    }
  },
  [97851] = {
    ID = 97851,
    CnID = "关卡组@夏日活动下活动4",
    BaseSortID = 556,
    Type = 49,
    Name = "StageGroup_97851_Name|完美童话",
    TypeText = "StageGroup_97851_TypeText|日光下新事",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Summer2_02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {97789},
    StageDisplayDate = 1786237200,
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_Summer2Activity",
      "BonusAffix_Activity"
    }
  },
  [97847] = {
    ID = 97847,
    CnID = "关卡组@夏日活动下活动5",
    BaseSortID = 557,
    Type = 49,
    Name = "StageGroup_97847_Name|直面黑阳",
    TypeText = "StageGroup_97847_TypeText|日光下新事",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Summer2_02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {97789},
    StageDisplayDate = 1786410000,
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_Summer2Activity",
      "BonusAffix_Activity"
    }
  },
  [122189] = {
    ID = 122189,
    CnID = "关卡组@茉夏活动1",
    BaseSortID = 558,
    Type = 54,
    Name = "StageGroup_122189_Name|支配四肢",
    TypeText = "StageGroup_122189_TypeText|迷失的自我",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Mouchette04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {122263},
    StageDisplayDate = 1766970000,
    Bonus = {122127, 122129},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MouchetteActivity",
      "BonusAffix_Activity"
    }
  },
  [122191] = {
    ID = 122191,
    CnID = "关卡组@茉夏活动2",
    BaseSortID = 559,
    Type = 54,
    Name = "StageGroup_122191_Name|控制言语",
    TypeText = "StageGroup_122191_TypeText|迷失的自我",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Mouchette04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {122265},
    StageDisplayDate = 1767056400,
    Bonus = {122126, 122131},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MouchetteActivity",
      "BonusAffix_Activity"
    }
  },
  [122193] = {
    ID = 122193,
    CnID = "关卡组@茉夏活动3",
    BaseSortID = 560,
    Type = 54,
    Name = "StageGroup_122193_Name|切割阑尾",
    TypeText = "StageGroup_122193_TypeText|迷失的自我",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Mouchette04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {122264},
    StageDisplayDate = 1767142800,
    Bonus = {122128, 122130},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MouchetteActivity",
      "BonusAffix_Activity"
    }
  },
  [122192] = {
    ID = 122192,
    CnID = "关卡组@茉夏活动4",
    BaseSortID = 561,
    Type = 54,
    Name = "StageGroup_122192_Name|蒙蔽双眼",
    TypeText = "StageGroup_122192_TypeText|迷失的自我",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Mouchette04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {122263, 122265},
    StageDisplayDate = 1767229200,
    Bonus = {
      122127,
      122129,
      122126,
      122131
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MouchetteActivity",
      "BonusAffix_Activity"
    }
  },
  [122194] = {
    ID = 122194,
    CnID = "关卡组@茉夏活动5",
    BaseSortID = 562,
    Type = 54,
    Name = "StageGroup_122194_Name|本能思考",
    TypeText = "StageGroup_122194_TypeText|迷失的自我",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Mouchette04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {122265, 122264},
    StageDisplayDate = 1767315600,
    Bonus = {
      122126,
      122131,
      122128,
      122130
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MouchetteActivity",
      "BonusAffix_Activity"
    }
  },
  [122188] = {
    ID = 122188,
    CnID = "关卡组@茉夏活动6",
    BaseSortID = 563,
    Type = 54,
    Name = "StageGroup_122188_Name|敲碎心脏",
    TypeText = "StageGroup_122188_TypeText|迷失的自我",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Mouchette04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {122263, 122264},
    StageDisplayDate = 1767402000,
    Bonus = {
      122127,
      122129,
      122128,
      122130
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MouchetteActivity",
      "BonusAffix_Activity"
    }
  },
  [122190] = {
    ID = 122190,
    CnID = "关卡组@茉夏活动7",
    BaseSortID = 564,
    Type = 54,
    Name = "StageGroup_122190_Name|真我的解放",
    TypeText = "StageGroup_122190_TypeText|迷失的自我",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Mouchette04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      122263,
      122265,
      122264
    },
    StageDisplayDate = 1767488400,
    Bonus = {
      122127,
      122129,
      122126,
      122131,
      122128,
      122130
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MouchetteActivity",
      "BonusAffix_Activity"
    }
  },
  [125341] = {
    ID = 125341,
    CnID = "关卡组@徐活动1",
    BaseSortID = 565,
    Type = 55,
    Name = "StageGroup_125341_Name|爱怨相生",
    TypeText = "StageGroup_125341_TypeText|玄女无相",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Xu02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {125173, 9762},
    StageDisplayDate = 1769389200,
    Bonus = {125043, 125042},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_XuActivity",
      "BonusAffix_Activity"
    }
  },
  [125335] = {
    ID = 125335,
    CnID = "关卡组@徐活动2",
    BaseSortID = 566,
    Type = 55,
    Name = "StageGroup_125335_Name|枉死",
    TypeText = "StageGroup_125335_TypeText|玄女无相",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Xu02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {125173, 9799},
    StageDisplayDate = 1769475600,
    Bonus = {125043, 125042},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_XuActivity",
      "BonusAffix_Activity"
    }
  },
  [125334] = {
    ID = 125334,
    CnID = "关卡组@徐活动3",
    BaseSortID = 567,
    Type = 55,
    Name = "StageGroup_125334_Name|尸解",
    TypeText = "StageGroup_125334_TypeText|玄女无相",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Xu02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {125173, 9971},
    StageDisplayDate = 1769562000,
    Bonus = {125043, 125042},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_XuActivity",
      "BonusAffix_Activity"
    }
  },
  [125337] = {
    ID = 125337,
    CnID = "关卡组@徐活动4",
    BaseSortID = 568,
    Type = 55,
    Name = "StageGroup_125337_Name|循香",
    TypeText = "StageGroup_125337_TypeText|玄女无相",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Xu02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {125173, 9925},
    StageDisplayDate = 1769648400,
    Bonus = {125043, 125042},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_XuActivity",
      "BonusAffix_Activity"
    }
  },
  [125339] = {
    ID = 125339,
    CnID = "关卡组@徐活动5",
    BaseSortID = 569,
    Type = 55,
    Name = "StageGroup_125339_Name|窗后影",
    TypeText = "StageGroup_125339_TypeText|玄女无相",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Xu02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {125173, 9768},
    StageDisplayDate = 1769734800,
    Bonus = {125043, 125042},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_XuActivity",
      "BonusAffix_Activity"
    }
  },
  [125336] = {
    ID = 125336,
    CnID = "关卡组@徐活动6",
    BaseSortID = 570,
    Type = 55,
    Name = "StageGroup_125336_Name|吮",
    TypeText = "StageGroup_125336_TypeText|玄女无相",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Xu02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {125173, 9769},
    StageDisplayDate = 1769821200,
    Bonus = {125043, 125042},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_XuActivity",
      "BonusAffix_Activity"
    }
  },
  [125342] = {
    ID = 125342,
    CnID = "关卡组@徐活动7",
    BaseSortID = 571,
    Type = 55,
    Name = "StageGroup_125342_Name|极乐",
    TypeText = "StageGroup_125342_TypeText|玄女无相",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Xu02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {125173, 9812},
    StageDisplayDate = 1769907600,
    Bonus = {125043, 125042},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_XuActivity",
      "BonusAffix_Activity"
    }
  },
  [125343] = {
    ID = 125343,
    CnID = "关卡组@徐活动8",
    BaseSortID = 572,
    Type = 55,
    Name = "StageGroup_125343_Name|罗织",
    TypeText = "StageGroup_125343_TypeText|玄女无相",
    Sequence = 8,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Xu02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {125173, 9671},
    StageDisplayDate = 1769994000,
    Bonus = {125043, 125042},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_XuActivity",
      "BonusAffix_Activity"
    }
  },
  [125340] = {
    ID = 125340,
    CnID = "关卡组@徐活动9",
    BaseSortID = 573,
    Type = 55,
    Name = "StageGroup_125340_Name|臃容众",
    TypeText = "StageGroup_125340_TypeText|玄女无相",
    Sequence = 9,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Xu02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {125173, 9756},
    StageDisplayDate = 1770080400,
    Bonus = {125043, 125042},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_XuActivity",
      "BonusAffix_Activity"
    }
  },
  [130898] = {
    ID = 130898,
    CnID = "关卡组@莫丝活动1",
    BaseSortID = 574,
    Type = 56,
    Name = "StageGroup_130898_Name|平凡的每天",
    TypeText = "StageGroup_130898_TypeText|莫丝与海",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Mosk01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {130742},
    StageDisplayDate = 1773018000,
    Bonus = {130574, 130575},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MoskActivity",
      "BonusAffix_Activity"
    }
  },
  [130893] = {
    ID = 130893,
    CnID = "关卡组@莫丝活动2",
    BaseSortID = 575,
    Type = 56,
    Name = "StageGroup_130893_Name|漂流的宝物",
    TypeText = "StageGroup_130893_TypeText|莫丝与海",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Mosk01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {130721},
    StageDisplayDate = 1773104400,
    Bonus = {130572, 130573},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MoskActivity",
      "BonusAffix_Activity"
    }
  },
  [130891] = {
    ID = 130891,
    CnID = "关卡组@莫丝活动3",
    BaseSortID = 576,
    Type = 56,
    Name = "StageGroup_130891_Name|同伴发现",
    TypeText = "StageGroup_130891_TypeText|莫丝与海",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Mosk01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {130778},
    StageDisplayDate = 1773190800,
    Bonus = {130576, 130577},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MoskActivity",
      "BonusAffix_Activity"
    }
  },
  [130892] = {
    ID = 130892,
    CnID = "关卡组@莫丝活动4",
    BaseSortID = 577,
    Type = 56,
    Name = "StageGroup_130892_Name|出海时刻",
    TypeText = "StageGroup_130892_TypeText|莫丝与海",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Mosk01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {130742, 130721},
    StageDisplayDate = 1773277200,
    Bonus = {
      130574,
      130575,
      130572,
      130573
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MoskActivity",
      "BonusAffix_Activity"
    }
  },
  [130896] = {
    ID = 130896,
    CnID = "关卡组@莫丝活动5",
    BaseSortID = 578,
    Type = 56,
    Name = "StageGroup_130896_Name|轰鸣的雷暴",
    TypeText = "StageGroup_130896_TypeText|莫丝与海",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Mosk01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {130721, 130778},
    StageDisplayDate = 1773363600,
    Bonus = {
      130572,
      130573,
      130576,
      130577
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MoskActivity",
      "BonusAffix_Activity"
    }
  },
  [130894] = {
    ID = 130894,
    CnID = "关卡组@莫丝活动6",
    BaseSortID = 579,
    Type = 56,
    Name = "StageGroup_130894_Name|大·漩·涡",
    TypeText = "StageGroup_130894_TypeText|莫丝与海",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Mosk01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {130742, 130778},
    StageDisplayDate = 1773450000,
    Bonus = {
      130574,
      130575,
      130576,
      130577
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MoskActivity",
      "BonusAffix_Activity"
    }
  },
  [130897] = {
    ID = 130897,
    CnID = "关卡组@莫丝活动7",
    BaseSortID = 580,
    Type = 56,
    Name = "StageGroup_130897_Name|返航之路",
    TypeText = "StageGroup_130897_TypeText|莫丝与海",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Mosk01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      130742,
      130721,
      130778
    },
    StageDisplayDate = 1773536400,
    Bonus = {
      130574,
      130575,
      130572,
      130573,
      130576,
      130577
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_MoskActivity",
      "BonusAffix_Activity"
    }
  },
  [126267] = {
    ID = 126267,
    CnID = "关卡组@阿拉克涅活动1",
    BaseSortID = 581,
    Type = 57,
    Name = "StageGroup_126267_Name|入场",
    TypeText = "StageGroup_126267_TypeText|木偶的舞台",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Arachne02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {126172},
    StageDisplayDate = 1776646800,
    Bonus = {126063, 126064},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ArachneActivity",
      "BonusAffix_Activity"
    }
  },
  [126270] = {
    ID = 126270,
    CnID = "关卡组@阿拉克涅活动2",
    BaseSortID = 582,
    Type = 57,
    Name = "StageGroup_126270_Name|墙壁上的枪",
    TypeText = "StageGroup_126270_TypeText|木偶的舞台",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Arachne02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {126172},
    StageDisplayDate = 1776819600,
    Bonus = {126063, 126064},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ArachneActivity",
      "BonusAffix_Activity"
    }
  },
  [126268] = {
    ID = 126268,
    CnID = "关卡组@阿拉克涅活动3",
    BaseSortID = 583,
    Type = 57,
    Name = "StageGroup_126268_Name|反转，反转",
    TypeText = "StageGroup_126268_TypeText|木偶的舞台",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Arachne02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {126172},
    StageDisplayDate = 1776992400,
    Bonus = {126063, 126064},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ArachneActivity",
      "BonusAffix_Activity"
    }
  },
  [126272] = {
    ID = 126272,
    CnID = "关卡组@阿拉克涅活动4",
    BaseSortID = 584,
    Type = 57,
    Name = "StageGroup_126272_Name|燃烧",
    TypeText = "StageGroup_126272_TypeText|木偶的舞台",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Arachne02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {126172},
    StageDisplayDate = 1777165200,
    Bonus = {126063, 126064},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ArachneActivity",
      "BonusAffix_Activity"
    }
  },
  [126265] = {
    ID = 126265,
    CnID = "关卡组@阿拉克涅活动5",
    BaseSortID = 585,
    Type = 57,
    Name = "StageGroup_126265_Name|请勿剧透",
    TypeText = "StageGroup_126265_TypeText|木偶的舞台",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Arachne02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {126172},
    StageDisplayDate = 1777338000,
    Bonus = {126063, 126064},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_ArachneActivity",
      "BonusAffix_Activity"
    }
  },
  [130170] = {
    ID = 130170,
    CnID = "关卡组@沙耶活动1",
    BaseSortID = 586,
    Type = 58,
    Name = "StageGroup_130170_Name|脑损伤",
    TypeText = "StageGroup_130170_TypeText|暗室手记",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {130049},
    StageDisplayDate = 1780102800,
    Bonus = {129910, 129908},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [130171] = {
    ID = 130171,
    CnID = "关卡组@沙耶活动2",
    BaseSortID = 587,
    Type = 58,
    Name = "StageGroup_130171_Name|医院",
    TypeText = "StageGroup_130171_TypeText|暗室手记",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {130097},
    StageDisplayDate = 1780189200,
    Bonus = {129913, 129909},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [130166] = {
    ID = 130166,
    CnID = "关卡组@沙耶活动3",
    BaseSortID = 588,
    Type = 58,
    Name = "StageGroup_130166_Name|学校",
    TypeText = "StageGroup_130166_TypeText|暗室手记",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {130077},
    StageDisplayDate = 1780275600,
    Bonus = {129912, 129911},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [130164] = {
    ID = 130164,
    CnID = "关卡组@沙耶活动4",
    BaseSortID = 589,
    Type = 58,
    Name = "StageGroup_130164_Name|家",
    TypeText = "StageGroup_130164_TypeText|暗室手记",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {130049, 130097},
    StageDisplayDate = 1780362000,
    Bonus = {
      129910,
      129908,
      129913,
      129909
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [130165] = {
    ID = 130165,
    CnID = "关卡组@沙耶活动5",
    BaseSortID = 590,
    Type = 58,
    Name = "StageGroup_130165_Name|餐桌",
    TypeText = "StageGroup_130165_TypeText|暗室手记",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {130097, 130077},
    StageDisplayDate = 1780448400,
    Bonus = {
      129913,
      129909,
      129912,
      129911
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [130168] = {
    ID = 130168,
    CnID = "关卡组@沙耶活动6",
    BaseSortID = 591,
    Type = 58,
    Name = "StageGroup_130168_Name|水井",
    TypeText = "StageGroup_130168_TypeText|暗室手记",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {130049, 130077},
    StageDisplayDate = 1780534800,
    Bonus = {
      129910,
      129908,
      129912,
      129911
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [130169] = {
    ID = 130169,
    CnID = "关卡组@沙耶活动7",
    BaseSortID = 592,
    Type = 58,
    Name = "StageGroup_130169_Name|最后的小酌",
    TypeText = "StageGroup_130169_TypeText|暗室手记",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      130049,
      130097,
      130077
    },
    StageDisplayDate = 1780621200,
    Bonus = {
      129910,
      129908,
      129913,
      129909,
      129912,
      129911
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [141298] = {
    ID = 141298,
    CnID = "关卡组@庞托斯活动1",
    BaseSortID = 593,
    Type = 59,
    Name = "StageGroup_141298_Name|森林法典",
    TypeText = "StageGroup_141298_TypeText|高屋巡猎",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pontos04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {141230},
    StageDisplayDate = 1782694800,
    Bonus = {141072, 141073},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PontosActivity",
      "BonusAffix_Activity"
    }
  },
  [141299] = {
    ID = 141299,
    CnID = "关卡组@庞托斯活动2",
    BaseSortID = 594,
    Type = 59,
    Name = "StageGroup_141299_Name|哨音",
    TypeText = "StageGroup_141299_TypeText|高屋巡猎",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pontos04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {141193},
    StageDisplayDate = 1782781200,
    Bonus = {141075, 141076},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PontosActivity",
      "BonusAffix_Activity"
    }
  },
  [141293] = {
    ID = 141293,
    CnID = "关卡组@庞托斯活动3",
    BaseSortID = 595,
    Type = 59,
    Name = "StageGroup_141293_Name|追逃游戏",
    TypeText = "StageGroup_141293_TypeText|高屋巡猎",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pontos04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {141225},
    StageDisplayDate = 1782867600,
    Bonus = {141077, 141074},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PontosActivity",
      "BonusAffix_Activity"
    }
  },
  [141296] = {
    ID = 141296,
    CnID = "关卡组@庞托斯活动4",
    BaseSortID = 596,
    Type = 59,
    Name = "StageGroup_141296_Name|剖白",
    TypeText = "StageGroup_141296_TypeText|高屋巡猎",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pontos04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {141230, 141193},
    StageDisplayDate = 1782954000,
    Bonus = {
      141072,
      141073,
      141075,
      141076
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PontosActivity",
      "BonusAffix_Activity"
    }
  },
  [141295] = {
    ID = 141295,
    CnID = "关卡组@庞托斯活动5",
    BaseSortID = 597,
    Type = 59,
    Name = "StageGroup_141295_Name|麦酒与香料",
    TypeText = "StageGroup_141295_TypeText|高屋巡猎",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pontos04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {141193, 141225},
    StageDisplayDate = 1783040400,
    Bonus = {
      141075,
      141076,
      141077,
      141074
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PontosActivity",
      "BonusAffix_Activity"
    }
  },
  [141294] = {
    ID = 141294,
    CnID = "关卡组@庞托斯活动6",
    BaseSortID = 598,
    Type = 59,
    Name = "StageGroup_141294_Name|肋软骨",
    TypeText = "StageGroup_141294_TypeText|高屋巡猎",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pontos04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {141230, 141225},
    StageDisplayDate = 1783126800,
    Bonus = {
      141072,
      141073,
      141077,
      141074
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PontosActivity",
      "BonusAffix_Activity"
    }
  },
  [141297] = {
    ID = 141297,
    CnID = "关卡组@庞托斯活动7",
    BaseSortID = 599,
    Type = 59,
    Name = "StageGroup_141297_Name|二元论",
    TypeText = "StageGroup_141297_TypeText|高屋巡猎",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Pontos04.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      141230,
      141193,
      141225
    },
    StageDisplayDate = 1783213200,
    Bonus = {
      141072,
      141073,
      141075,
      141076,
      141077,
      141074
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_PontosActivity",
      "BonusAffix_Activity"
    }
  },
  [145360] = {
    ID = 145360,
    CnID = "关卡组@蚀灭·萝坦活动1",
    BaseSortID = 600,
    Type = 60,
    Name = "StageGroup_145360_Name|觐献",
    TypeText = "StageGroup_145360_TypeText|贪戮角逐",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_LotanCetarchon01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {145276},
    StageDisplayDate = 1785114000,
    Bonus = {145236, 145235},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_LotanCetarchon",
      "BonusAffix_Activity"
    }
  },
  [145357] = {
    ID = 145357,
    CnID = "关卡组@蚀灭·萝坦活动2",
    BaseSortID = 601,
    Type = 60,
    Name = "StageGroup_145357_Name|困兽",
    TypeText = "StageGroup_145357_TypeText|贪戮角逐",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_LotanCetarchon01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {145276},
    StageDisplayDate = 1785286800,
    Bonus = {145236, 145235},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_LotanCetarchon",
      "BonusAffix_Activity"
    }
  },
  [145355] = {
    ID = 145355,
    CnID = "关卡组@蚀灭·萝坦活动3",
    BaseSortID = 602,
    Type = 60,
    Name = "StageGroup_145355_Name|无人之镜",
    TypeText = "StageGroup_145355_TypeText|贪戮角逐",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_LotanCetarchon01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {145276},
    StageDisplayDate = 1785459600,
    Bonus = {145236, 145235},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_LotanCetarchon",
      "BonusAffix_Activity"
    }
  },
  [145358] = {
    ID = 145358,
    CnID = "关卡组@蚀灭·萝坦活动4",
    BaseSortID = 603,
    Type = 60,
    Name = "StageGroup_145358_Name|杀戮殿堂",
    TypeText = "StageGroup_145358_TypeText|贪戮角逐",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_LotanCetarchon01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {145276},
    StageDisplayDate = 1785632400,
    Bonus = {145236, 145235},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_LotanCetarchon",
      "BonusAffix_Activity"
    }
  },
  [145359] = {
    ID = 145359,
    CnID = "关卡组@蚀灭·萝坦活动5",
    BaseSortID = 604,
    Type = 60,
    Name = "StageGroup_145359_Name|权欲王冠",
    TypeText = "StageGroup_145359_TypeText|贪戮角逐",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_LotanCetarchon01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {145276},
    StageDisplayDate = 1785805200,
    Bonus = {145236, 145235},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_LotanCetarchon",
      "BonusAffix_Activity"
    }
  },
  [141792] = {
    ID = 141792,
    CnID = "关卡组@卡拉布活动1",
    BaseSortID = 605,
    Type = 61,
    Name = "StageGroup_141792_Name|镜子",
    TypeText = "StageGroup_141792_TypeText|乌摩钵蒂的宝物",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Caraboo01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {141680},
    StageDisplayDate = 1787533200,
    Bonus = {141546, 141547},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_CarabooActivity",
      "BonusAffix_Activity"
    }
  },
  [141794] = {
    ID = 141794,
    CnID = "关卡组@卡拉布活动2",
    BaseSortID = 606,
    Type = 61,
    Name = "StageGroup_141794_Name|羽毛",
    TypeText = "StageGroup_141794_TypeText|乌摩钵蒂的宝物",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Caraboo01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {141721},
    StageDisplayDate = 1787619600,
    Bonus = {141548, 141551},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_CarabooActivity",
      "BonusAffix_Activity"
    }
  },
  [141791] = {
    ID = 141791,
    CnID = "关卡组@卡拉布活动3",
    BaseSortID = 607,
    Type = 61,
    Name = "StageGroup_141791_Name|丝线",
    TypeText = "StageGroup_141791_TypeText|乌摩钵蒂的宝物",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Caraboo01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {141673},
    StageDisplayDate = 1787706000,
    Bonus = {141550, 141549},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_CarabooActivity",
      "BonusAffix_Activity"
    }
  },
  [141795] = {
    ID = 141795,
    CnID = "关卡组@卡拉布活动4",
    BaseSortID = 608,
    Type = 61,
    Name = "StageGroup_141795_Name|钥匙",
    TypeText = "StageGroup_141795_TypeText|乌摩钵蒂的宝物",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Caraboo01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {141680, 141721},
    StageDisplayDate = 1787792400,
    Bonus = {
      141546,
      141547,
      141548,
      141551
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_CarabooActivity",
      "BonusAffix_Activity"
    }
  },
  [141793] = {
    ID = 141793,
    CnID = "关卡组@卡拉布活动5",
    BaseSortID = 609,
    Type = 61,
    Name = "StageGroup_141793_Name|眼睛",
    TypeText = "StageGroup_141793_TypeText|乌摩钵蒂的宝物",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Caraboo01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {141721, 141673},
    StageDisplayDate = 1787878800,
    Bonus = {
      141548,
      141551,
      141550,
      141549
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_CarabooActivity",
      "BonusAffix_Activity"
    }
  },
  [141796] = {
    ID = 141796,
    CnID = "关卡组@卡拉布活动6",
    BaseSortID = 610,
    Type = 61,
    Name = "StageGroup_141796_Name|王冠",
    TypeText = "StageGroup_141796_TypeText|乌摩钵蒂的宝物",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Caraboo01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {141680, 141673},
    StageDisplayDate = 1787965200,
    Bonus = {
      141546,
      141547,
      141550,
      141549
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_CarabooActivity",
      "BonusAffix_Activity"
    }
  },
  [141797] = {
    ID = 141797,
    CnID = "关卡组@卡拉布活动7",
    BaseSortID = 611,
    Type = 61,
    Name = "StageGroup_141797_Name|苹果",
    TypeText = "StageGroup_141797_TypeText|乌摩钵蒂的宝物",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Caraboo01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      141680,
      141721,
      141673
    },
    StageDisplayDate = 1788051600,
    Bonus = {
      141546,
      141547,
      141548,
      141551,
      141550,
      141549
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_CarabooActivity",
      "BonusAffix_Activity"
    }
  },
  [146797] = {
    ID = 146797,
    CnID = "关卡组@本源奥吉尔活动1",
    BaseSortID = 612,
    Type = 62,
    Name = "StageGroup_146797_Name|临时文本",
    TypeText = "StageGroup_146797_TypeText|临时文本",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {146872, 9762},
    StageDisplayDate = 1789952400,
    Bonus = {146869, 146870},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [146789] = {
    ID = 146789,
    CnID = "关卡组@本源奥吉尔活动2",
    BaseSortID = 613,
    Type = 62,
    Name = "StageGroup_146789_Name|临时文本",
    TypeText = "StageGroup_146789_TypeText|临时文本",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {146872, 9799},
    StageDisplayDate = 1790038800,
    Bonus = {146869, 146870},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [146793] = {
    ID = 146793,
    CnID = "关卡组@本源奥吉尔活动3",
    BaseSortID = 614,
    Type = 62,
    Name = "StageGroup_146793_Name|临时文本",
    TypeText = "StageGroup_146793_TypeText|临时文本",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {146872, 9971},
    StageDisplayDate = 1790125200,
    Bonus = {146869, 146870},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [146790] = {
    ID = 146790,
    CnID = "关卡组@本源奥吉尔活动4",
    BaseSortID = 615,
    Type = 62,
    Name = "StageGroup_146790_Name|临时文本",
    TypeText = "StageGroup_146790_TypeText|临时文本",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {146872, 9925},
    StageDisplayDate = 1790211600,
    Bonus = {146869, 146870},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [146796] = {
    ID = 146796,
    CnID = "关卡组@本源奥吉尔活动5",
    BaseSortID = 616,
    Type = 62,
    Name = "StageGroup_146796_Name|临时文本",
    TypeText = "StageGroup_146796_TypeText|临时文本",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {146872, 9768},
    StageDisplayDate = 1790298000,
    Bonus = {146869, 146870},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [146798] = {
    ID = 146798,
    CnID = "关卡组@本源奥吉尔活动6",
    BaseSortID = 617,
    Type = 62,
    Name = "StageGroup_146798_Name|临时文本",
    TypeText = "StageGroup_146798_TypeText|临时文本",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {146872, 9769},
    StageDisplayDate = 1790384400,
    Bonus = {146869, 146870},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [146791] = {
    ID = 146791,
    CnID = "关卡组@本源奥吉尔活动7",
    BaseSortID = 618,
    Type = 62,
    Name = "StageGroup_146791_Name|临时文本",
    TypeText = "StageGroup_146791_TypeText|临时文本",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {146872, 9812},
    StageDisplayDate = 1790470800,
    Bonus = {146869, 146870},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [146794] = {
    ID = 146794,
    CnID = "关卡组@本源奥吉尔活动8",
    BaseSortID = 619,
    Type = 62,
    Name = "StageGroup_146794_Name|临时文本",
    TypeText = "StageGroup_146794_TypeText|临时文本",
    Sequence = 8,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {146872, 9671},
    StageDisplayDate = 1790557200,
    Bonus = {146869, 146870},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [146788] = {
    ID = 146788,
    CnID = "关卡组@本源奥吉尔活动9",
    BaseSortID = 620,
    Type = 62,
    Name = "StageGroup_146788_Name|临时文本",
    TypeText = "StageGroup_146788_TypeText|临时文本",
    Sequence = 9,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {146872, 9756},
    StageDisplayDate = 1790643600,
    Bonus = {146869, 146870},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [147367] = {
    ID = 147367,
    CnID = "关卡组@暮星·汀克特活动1",
    BaseSortID = 621,
    Type = 63,
    Name = "StageGroup_147367_Name|临时文本",
    TypeText = "StageGroup_147367_TypeText|临时文本",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_GenesisTinct01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {147274},
    StageDisplayDate = 1798419600,
    Bonus = {147103, 147098},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_GenesisTinctActivity",
      "BonusAffix_Activity"
    }
  },
  [147365] = {
    ID = 147365,
    CnID = "关卡组@暮星·汀克特活动2",
    BaseSortID = 622,
    Type = 63,
    Name = "StageGroup_147365_Name|临时文本",
    TypeText = "StageGroup_147365_TypeText|临时文本",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_GenesisTinct01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {147299},
    StageDisplayDate = 1798506000,
    Bonus = {147099, 147102},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_GenesisTinctActivity",
      "BonusAffix_Activity"
    }
  },
  [147366] = {
    ID = 147366,
    CnID = "关卡组@暮星·汀克特活动3",
    BaseSortID = 623,
    Type = 63,
    Name = "StageGroup_147366_Name|临时文本",
    TypeText = "StageGroup_147366_TypeText|临时文本",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_GenesisTinct01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {147254},
    StageDisplayDate = 1798592400,
    Bonus = {147101, 147100},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_GenesisTinctActivity",
      "BonusAffix_Activity"
    }
  },
  [147369] = {
    ID = 147369,
    CnID = "关卡组@暮星·汀克特活动4",
    BaseSortID = 624,
    Type = 63,
    Name = "StageGroup_147369_Name|临时文本",
    TypeText = "StageGroup_147369_TypeText|临时文本",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_GenesisTinct01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {147274, 147299},
    StageDisplayDate = 1798678800,
    Bonus = {
      147103,
      147098,
      147099,
      147102
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_GenesisTinctActivity",
      "BonusAffix_Activity"
    }
  },
  [147362] = {
    ID = 147362,
    CnID = "关卡组@暮星·汀克特活动5",
    BaseSortID = 625,
    Type = 63,
    Name = "StageGroup_147362_Name|临时文本",
    TypeText = "StageGroup_147362_TypeText|临时文本",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_GenesisTinct01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {147299, 147254},
    StageDisplayDate = 1798765200,
    Bonus = {
      147099,
      147102,
      147101,
      147100
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_GenesisTinctActivity",
      "BonusAffix_Activity"
    }
  },
  [147370] = {
    ID = 147370,
    CnID = "关卡组@暮星·汀克特活动6",
    BaseSortID = 626,
    Type = 63,
    Name = "StageGroup_147370_Name|临时文本",
    TypeText = "StageGroup_147370_TypeText|临时文本",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_GenesisTinct01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {147274, 147254},
    StageDisplayDate = 1798851600,
    Bonus = {
      147103,
      147098,
      147101,
      147100
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_GenesisTinctActivity",
      "BonusAffix_Activity"
    }
  },
  [147364] = {
    ID = 147364,
    CnID = "关卡组@暮星·汀克特活动7",
    BaseSortID = 627,
    Type = 63,
    Name = "StageGroup_147364_Name|临时文本",
    TypeText = "StageGroup_147364_TypeText|临时文本",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_GenesisTinct01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      147274,
      147299,
      147254
    },
    StageDisplayDate = 1798938000,
    Bonus = {
      147103,
      147098,
      147099,
      147102,
      147101,
      147100
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_GenesisTinctActivity",
      "BonusAffix_Activity"
    }
  },
  [143928] = {
    ID = 143928,
    CnID = "关卡组@太岁活动1",
    BaseSortID = 628,
    Type = 64,
    Name = "StageGroup_143928_Name|临时文本",
    TypeText = "StageGroup_143928_TypeText|临时文本",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {143937},
    StageDisplayDate = 1800838800,
    Bonus = {143755, 143759},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [143927] = {
    ID = 143927,
    CnID = "关卡组@太岁活动2",
    BaseSortID = 629,
    Type = 64,
    Name = "StageGroup_143927_Name|临时文本",
    TypeText = "StageGroup_143927_TypeText|临时文本",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {143938},
    StageDisplayDate = 1800925200,
    Bonus = {143756, 143757},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [143925] = {
    ID = 143925,
    CnID = "关卡组@太岁活动3",
    BaseSortID = 630,
    Type = 64,
    Name = "StageGroup_143925_Name|临时文本",
    TypeText = "StageGroup_143925_TypeText|临时文本",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {143940},
    StageDisplayDate = 1801011600,
    Bonus = {143760, 143758},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [143926] = {
    ID = 143926,
    CnID = "关卡组@太岁活动4",
    BaseSortID = 631,
    Type = 64,
    Name = "StageGroup_143926_Name|临时文本",
    TypeText = "StageGroup_143926_TypeText|临时文本",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {143937, 143938},
    StageDisplayDate = 1801098000,
    Bonus = {
      143755,
      143759,
      143756,
      143757
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [143930] = {
    ID = 143930,
    CnID = "关卡组@太岁活动5",
    BaseSortID = 632,
    Type = 64,
    Name = "StageGroup_143930_Name|临时文本",
    TypeText = "StageGroup_143930_TypeText|临时文本",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {143938, 143940},
    StageDisplayDate = 1801184400,
    Bonus = {
      143756,
      143757,
      143760,
      143758
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [143929] = {
    ID = 143929,
    CnID = "关卡组@太岁活动6",
    BaseSortID = 633,
    Type = 64,
    Name = "StageGroup_143929_Name|临时文本",
    TypeText = "StageGroup_143929_TypeText|临时文本",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {143937, 143940},
    StageDisplayDate = 1801270800,
    Bonus = {
      143755,
      143759,
      143760,
      143758
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [143932] = {
    ID = 143932,
    CnID = "关卡组@太岁活动7",
    BaseSortID = 634,
    Type = 64,
    Name = "StageGroup_143932_Name|临时文本",
    TypeText = "StageGroup_143932_TypeText|临时文本",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Saya01.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      143937,
      143938,
      143940
    },
    StageDisplayDate = 1801357200,
    Bonus = {
      143755,
      143759,
      143756,
      143757,
      143760,
      143758
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_SayaActivity",
      "BonusAffix_Activity"
    }
  },
  [66376] = {
    ID = 66376,
    CnID = "关卡组@第9章世界BOSS活动1",
    BaseSortID = 635,
    Type = 100,
    Name = "StageGroup_66376_Name|济贫院·悲泣之视",
    TypeText = "StageGroup_66376_TypeText|共战原初",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_WorladBoss02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9719,
      9567,
      9556
    },
    StageDisplayDate = 1732928400,
    BanCondition = {66422},
    ForceAssist = 1
  },
  [66378] = {
    ID = 66378,
    CnID = "关卡组@第9章世界BOSS活动2",
    BaseSortID = 636,
    Type = 100,
    Name = "StageGroup_66378_Name|蜡像馆·恐惧之视",
    TypeText = "StageGroup_66378_TypeText|共战原初",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_WorladBoss02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9966,
      9567,
      9556
    },
    StageDisplayDate = 1732928400,
    BanCondition = {66423},
    ForceAssist = 1
  },
  [66377] = {
    ID = 66377,
    CnID = "关卡组@第9章世界BOSS活动3",
    BaseSortID = 637,
    Type = 100,
    Name = "StageGroup_66377_Name|拉伊·刺骨之视",
    TypeText = "StageGroup_66377_TypeText|共战原初",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_WorladBoss02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9676,
      9567,
      9556
    },
    StageDisplayDate = 1732928400,
    BanCondition = {66424},
    ForceAssist = 1
  },
  [66380] = {
    ID = 66380,
    CnID = "关卡组@第9章世界BOSS活动4",
    BaseSortID = 638,
    Type = 100,
    Name = "StageGroup_66380_Name|疗养院·诡谲之视",
    TypeText = "StageGroup_66380_TypeText|共战原初",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_WorladBoss02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      25219,
      9567,
      9556
    },
    StageDisplayDate = 1733187600,
    BanCondition = {66425},
    ForceAssist = 1
  },
  [66379] = {
    ID = 66379,
    CnID = "关卡组@第9章世界BOSS活动5",
    BaseSortID = 639,
    Type = 100,
    Name = "StageGroup_66379_Name|布里尔珀特·邪信之视",
    TypeText = "StageGroup_66379_TypeText|共战原初",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_WorladBoss02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9619,
      9567,
      9556
    },
    StageDisplayDate = 1733446800,
    BanCondition = {66426},
    ForceAssist = 1
  },
  [67128] = {
    ID = 67128,
    CnID = "关卡组@第9章世界BOSS活动6",
    BaseSortID = 640,
    Type = 100,
    Name = "StageGroup_67128_Name|索纳尼尔号·疯狂之视",
    TypeText = "StageGroup_67128_TypeText|共战原初",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_WorladBoss02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9522,
      9567,
      9556
    },
    StageDisplayDate = 1733706000,
    BanCondition = {67125},
    ForceAssist = 1
  },
  [67127] = {
    ID = 67127,
    CnID = "关卡组@第9章世界BOSS活动7",
    BaseSortID = 641,
    Type = 100,
    Name = "StageGroup_67127_Name|勒姆瓦希·诞临之视",
    TypeText = "StageGroup_67127_TypeText|共战原初",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_WorladBoss02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9802,
      9567,
      9556
    },
    StageDisplayDate = 1733965200,
    BanCondition = {67126},
    ForceAssist = 1
  },
  [68416] = {
    ID = 68416,
    CnID = "关卡组@图鲁活动1",
    BaseSortID = 642,
    Type = 42,
    Name = "StageGroup_68416_Name|神之眸",
    TypeText = "StageGroup_68416_TypeText|深海凝视",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Tulu02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {68421},
    StageDisplayDate = 1775437200,
    Bonus = {68835, 68833},
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_TuluActivity",
      "BonusAffix_Activity"
    }
  },
  [68415] = {
    ID = 68415,
    CnID = "关卡组@图鲁活动2",
    BaseSortID = 643,
    Type = 42,
    Name = "StageGroup_68415_Name|衰亡国度",
    TypeText = "StageGroup_68415_TypeText|深海凝视",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Tulu02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {68421, 68419},
    StageDisplayDate = 1775610000,
    Bonus = {
      68835,
      68833,
      68834,
      68831
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_TuluActivity",
      "BonusAffix_Activity"
    }
  },
  [68414] = {
    ID = 68414,
    CnID = "关卡组@图鲁活动3",
    BaseSortID = 644,
    Type = 42,
    Name = "StageGroup_68414_Name|人性崩毁",
    TypeText = "StageGroup_68414_TypeText|深海凝视",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Tulu02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {68421, 68420},
    StageDisplayDate = 1775782800,
    Bonus = {
      68835,
      68833,
      68832,
      68830
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_TuluActivity",
      "BonusAffix_Activity"
    }
  },
  [68413] = {
    ID = 68413,
    CnID = "关卡组@图鲁活动4",
    BaseSortID = 645,
    Type = 42,
    Name = "StageGroup_68413_Name|乡愁",
    TypeText = "StageGroup_68413_TypeText|深海凝视",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Tulu02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {68419, 68420},
    StageDisplayDate = 1775955600,
    Bonus = {
      68834,
      68831,
      68832,
      68830
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_TuluActivity",
      "BonusAffix_Activity"
    }
  },
  [68412] = {
    ID = 68412,
    CnID = "关卡组@图鲁活动5",
    BaseSortID = 646,
    Type = 42,
    Name = "StageGroup_68412_Name|美好幻梦",
    TypeText = "StageGroup_68412_TypeText|深海凝视",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_Tulu02.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      68421,
      68419,
      68420
    },
    StageDisplayDate = 1776128400,
    Bonus = {
      68835,
      68833,
      68834,
      68831,
      68832,
      68830
    },
    BonusTips = {
      "BonusTips_Activity",
      "BonusRuleTitle_Activity",
      "BonusRuleContent_TuluActivity",
      "BonusAffix_Activity"
    }
  },
  [70401] = {
    ID = 70401,
    CnID = "关卡组@25年春节活动1",
    BaseSortID = 647,
    Type = 103,
    Name = "StageGroup_70401_Name|猫的问候",
    TypeText = "StageGroup_70401_TypeText|校猫挑战",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageDisplayDate = 1737680400,
    StageGroupCloseDate = 1737766800
  },
  [70400] = {
    ID = 70400,
    CnID = "关卡组@25年春节活动2",
    BaseSortID = 648,
    Type = 103,
    Name = "StageGroup_70400_Name|猫的凝视",
    TypeText = "StageGroup_70400_TypeText|校猫挑战",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageDisplayDate = 1737766800,
    StageGroupCloseDate = 1737853200
  },
  [70399] = {
    ID = 70399,
    CnID = "关卡组@25年春节活动3",
    BaseSortID = 649,
    Type = 103,
    Name = "StageGroup_70399_Name|猫的爪印",
    TypeText = "StageGroup_70399_TypeText|校猫挑战",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageDisplayDate = 1737853200,
    StageGroupCloseDate = 1737939600
  },
  [70398] = {
    ID = 70398,
    CnID = "关卡组@25年春节活动4",
    BaseSortID = 650,
    Type = 103,
    Name = "StageGroup_70398_Name|猫的低语",
    TypeText = "StageGroup_70398_TypeText|校猫挑战",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageDisplayDate = 1737939600,
    StageGroupCloseDate = 1738026000
  },
  [70397] = {
    ID = 70397,
    CnID = "关卡组@25年春节活动5",
    BaseSortID = 651,
    Type = 103,
    Name = "StageGroup_70397_Name|猫的舞蹈",
    TypeText = "StageGroup_70397_TypeText|校猫挑战",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageDisplayDate = 1738026000,
    StageGroupCloseDate = 1738112400
  },
  [70396] = {
    ID = 70396,
    CnID = "关卡组@25年春节活动6",
    BaseSortID = 652,
    Type = 103,
    Name = "StageGroup_70396_Name|猫的魔法",
    TypeText = "StageGroup_70396_TypeText|校猫挑战",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageDisplayDate = 1738112400,
    StageGroupCloseDate = 1738198800
  },
  [70395] = {
    ID = 70395,
    CnID = "关卡组@25年春节活动7",
    BaseSortID = 653,
    Type = 103,
    Name = "StageGroup_70395_Name|猫的诡计",
    TypeText = "StageGroup_70395_TypeText|校猫挑战",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageDisplayDate = 1738198800,
    StageGroupCloseDate = 1738285200
  },
  [70394] = {
    ID = 70394,
    CnID = "关卡组@25年春节活动8",
    BaseSortID = 654,
    Type = 103,
    Name = "StageGroup_70394_Name|猫的喜悦",
    TypeText = "StageGroup_70394_TypeText|校猫挑战",
    Sequence = 8,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageDisplayDate = 1738285200,
    StageGroupCloseDate = 1738371600
  },
  [70393] = {
    ID = 70393,
    CnID = "关卡组@25年春节活动9",
    BaseSortID = 655,
    Type = 103,
    Name = "StageGroup_70393_Name|猫的偏爱",
    TypeText = "StageGroup_70393_TypeText|校猫挑战",
    Sequence = 9,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageDisplayDate = 1738371600,
    StageGroupCloseDate = 1738458000
  },
  [70392] = {
    ID = 70392,
    CnID = "关卡组@25年春节活动10",
    BaseSortID = 656,
    Type = 103,
    Name = "StageGroup_70392_Name|猫的派对",
    TypeText = "StageGroup_70392_TypeText|校猫挑战",
    Sequence = 10,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageDisplayDate = 1738458000,
    StageGroupCloseDate = 1738544400
  },
  [70391] = {
    ID = 70391,
    CnID = "关卡组@25年春节活动11",
    BaseSortID = 657,
    Type = 103,
    Name = "StageGroup_70391_Name|猫的狂欢",
    TypeText = "StageGroup_70391_TypeText|校猫挑战",
    Sequence = 11,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageDisplayDate = 1738544400,
    StageGroupCloseDate = 1738630800
  },
  [70390] = {
    ID = 70390,
    CnID = "关卡组@25年春节活动12",
    BaseSortID = 658,
    Type = 103,
    Name = "StageGroup_70390_Name|猫的祝福",
    TypeText = "StageGroup_70390_TypeText|校猫挑战",
    Sequence = 12,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {72102},
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    StageDisplayDate = 1738630800,
    StageGroupCloseDate = 1738717200
  },
  [81765] = {
    ID = 81765,
    CnID = "关卡组@深海入侵击退战活动1",
    BaseSortID = 659,
    Type = 111,
    Name = "StageGroup_81765_Name|圣象的注视",
    TypeText = "StageGroup_81765_TypeText|异动海潮",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OceanBoss02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9719,
      9567,
      9556
    },
    StageDisplayDate = 1748221200,
    BanCondition = {81772},
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [81764] = {
    ID = 81764,
    CnID = "关卡组@深海入侵击退战活动2",
    BaseSortID = 660,
    Type = 111,
    Name = "StageGroup_81764_Name|躯壳的悸动",
    TypeText = "StageGroup_81764_TypeText|异动海潮",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OceanBoss02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9966,
      9567,
      9556
    },
    StageDisplayDate = 1748221200,
    BanCondition = {81776},
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [81767] = {
    ID = 81767,
    CnID = "关卡组@深海入侵击退战活动3",
    BaseSortID = 661,
    Type = 111,
    Name = "StageGroup_81767_Name|虚空的召唤",
    TypeText = "StageGroup_81767_TypeText|异动海潮",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OceanBoss02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9676,
      9567,
      9556
    },
    StageDisplayDate = 1748221200,
    BanCondition = {81775},
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [81768] = {
    ID = 81768,
    CnID = "关卡组@深海入侵击退战活动4",
    BaseSortID = 662,
    Type = 111,
    Name = "StageGroup_81768_Name|神国的低喃",
    TypeText = "StageGroup_81768_TypeText|异动海潮",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OceanBoss02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      25219,
      9567,
      9556
    },
    StageDisplayDate = 1748480400,
    BanCondition = {81778},
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [81766] = {
    ID = 81766,
    CnID = "关卡组@深海入侵击退战活动5",
    BaseSortID = 663,
    Type = 111,
    Name = "StageGroup_81766_Name|祭礼的回应",
    TypeText = "StageGroup_81766_TypeText|异动海潮",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OceanBoss02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9619,
      9567,
      9556
    },
    StageDisplayDate = 1748739600,
    BanCondition = {81779},
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [81769] = {
    ID = 81769,
    CnID = "关卡组@深海入侵击退战活动6",
    BaseSortID = 664,
    Type = 111,
    Name = "StageGroup_81769_Name|神王的圣谕",
    TypeText = "StageGroup_81769_TypeText|异动海潮",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OceanBoss02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9522,
      9567,
      9556
    },
    StageDisplayDate = 1748998800,
    BanCondition = {81777},
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [81770] = {
    ID = 81770,
    CnID = "关卡组@深海入侵击退战活动7",
    BaseSortID = 665,
    Type = 111,
    Name = "StageGroup_81770_Name|无妄的皈依",
    TypeText = "StageGroup_81770_TypeText|异动海潮",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_OceanBoss02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9802,
      9567,
      9556
    },
    StageDisplayDate = 1749258000,
    BanCondition = {81773},
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [116813] = {
    ID = 116813,
    CnID = "关卡组@2周年世界BOSS活动1",
    BaseSortID = 666,
    Type = 113,
    Name = "StageGroup_116813_Name|失谐序曲",
    TypeText = "StageGroup_116813_TypeText|再战原初",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_2ndAnnivWorldBoss02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9567,
      9719,
      74093,
      9556
    },
    StageDisplayDate = 1764550800,
    BanCondition = {116824},
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [116814] = {
    ID = 116814,
    CnID = "关卡组@2周年世界BOSS活动2",
    BaseSortID = 667,
    Type = 113,
    Name = "StageGroup_116814_Name|无序前奏",
    TypeText = "StageGroup_116814_TypeText|再战原初",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_2ndAnnivWorldBoss02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9567,
      9966,
      74093,
      9556
    },
    StageDisplayDate = 1764637200,
    BanCondition = {116827},
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [116816] = {
    ID = 116816,
    CnID = "关卡组@2周年世界BOSS活动3",
    BaseSortID = 668,
    Type = 113,
    Name = "StageGroup_116816_Name|死寂韵律",
    TypeText = "StageGroup_116816_TypeText|再战原初",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_2ndAnnivWorldBoss02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9567,
      9676,
      74093,
      9556
    },
    StageDisplayDate = 1764723600,
    BanCondition = {116820},
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [116812] = {
    ID = 116812,
    CnID = "关卡组@2周年世界BOSS活动4",
    BaseSortID = 669,
    Type = 113,
    Name = "StageGroup_116812_Name|倒错和声",
    TypeText = "StageGroup_116812_TypeText|再战原初",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_2ndAnnivWorldBoss02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9567,
      25219,
      74093,
      9556
    },
    StageDisplayDate = 1764723600,
    BanCondition = {116825},
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [116811] = {
    ID = 116811,
    CnID = "关卡组@2周年世界BOSS活动5",
    BaseSortID = 670,
    Type = 113,
    Name = "StageGroup_116811_Name|邪信奏音",
    TypeText = "StageGroup_116811_TypeText|再战原初",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_2ndAnnivWorldBoss02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9567,
      9619,
      74093,
      9556
    },
    StageDisplayDate = 1764723600,
    BanCondition = {116823},
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [116817] = {
    ID = 116817,
    CnID = "关卡组@2周年世界BOSS活动6",
    BaseSortID = 671,
    Type = 113,
    Name = "StageGroup_116817_Name|癫狂尾章",
    TypeText = "StageGroup_116817_TypeText|再战原初",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_2ndAnnivWorldBoss02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9567,
      9522,
      74093,
      9556
    },
    StageDisplayDate = 1764810000,
    BanCondition = {116821},
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [116815] = {
    ID = 116815,
    CnID = "关卡组@2周年世界BOSS活动7",
    BaseSortID = 672,
    Type = 113,
    Name = "StageGroup_116815_Name|永恒沉眠",
    TypeText = "StageGroup_116815_TypeText|再战原初",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_2ndAnnivWorldBoss02.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {
      9567,
      9802,
      74093,
      9556
    },
    StageDisplayDate = 1764896400,
    BanCondition = {116826},
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [139587] = {
    ID = 139587,
    CnID = "关卡组@2.5周年RAID关卡1",
    BaseSortID = 673,
    Type = 114,
    Name = "StageGroup_139587_Name|黑金潮",
    TypeText = "StageGroup_139587_TypeText|猫海淘银",
    Sequence = 1,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageDisplayDate = 1779066000,
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [139585] = {
    ID = 139585,
    CnID = "关卡组@2.5周年RAID关卡2",
    BaseSortID = 674,
    Type = 114,
    Name = "StageGroup_139585_Name|第一桶银芯",
    TypeText = "StageGroup_139585_TypeText|猫海淘银",
    Sequence = 2,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageDisplayDate = 1779152400,
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [139584] = {
    ID = 139584,
    CnID = "关卡组@2.5周年RAID关卡3",
    BaseSortID = 675,
    Type = 114,
    Name = "StageGroup_139584_Name|拒捕",
    TypeText = "StageGroup_139584_TypeText|猫海淘银",
    Sequence = 3,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageDisplayDate = 1779238800,
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [139589] = {
    ID = 139589,
    CnID = "关卡组@2.5周年RAID关卡4",
    BaseSortID = 676,
    Type = 114,
    Name = "StageGroup_139589_Name|巨物",
    TypeText = "StageGroup_139589_TypeText|猫海淘银",
    Sequence = 4,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageDisplayDate = 1779325200,
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [139590] = {
    ID = 139590,
    CnID = "关卡组@2.5周年RAID关卡5",
    BaseSortID = 677,
    Type = 114,
    Name = "StageGroup_139590_Name|收网！收网！",
    TypeText = "StageGroup_139590_TypeText|猫海淘银",
    Sequence = 5,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageDisplayDate = 1779411600,
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [139586] = {
    ID = 139586,
    CnID = "关卡组@2.5周年RAID关卡6",
    BaseSortID = 678,
    Type = 114,
    Name = "StageGroup_139586_Name|满载而归",
    TypeText = "StageGroup_139586_TypeText|猫海淘银",
    Sequence = 6,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageDisplayDate = 1779498000,
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [139588] = {
    ID = 139588,
    CnID = "关卡组@2.5周年RAID关卡7",
    BaseSortID = 679,
    Type = 114,
    Name = "StageGroup_139588_Name|再来一次",
    TypeText = "StageGroup_139588_TypeText|猫海淘银",
    Sequence = 7,
    Backgrand = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_TeamSchool03.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageDisplayDate = 1779584400,
    ForceAssist = 1,
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    }
  },
  [75275] = {
    ID = 75275,
    CnID = "关卡组@星辰日常挑战风格1",
    BaseSortID = 680,
    Type = 9,
    Name = "StageGroup_75275_Name|幻梦深潜",
    Desc = "StageGroup_75275_Desc|「手」掀开夜的帷幕，悄悄来到这个世界。",
    TypeText = "StageGroup_75275_TypeText|幻梦深潜",
    Sequence = 1,
    Backgrand = "Icon/CopyTitle/DailyChallenge1.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75276] = {
    ID = 75276,
    CnID = "关卡组@星辰日常挑战风格2",
    BaseSortID = 681,
    Type = 9,
    Name = "StageGroup_75276_Name|幻梦深潜",
    Desc = "StageGroup_75276_Desc|「此处埋葬着一所大学，千疮百孔，疲惫不堪\n它曾为人类存续奉献了一点希望与勇气\n至于结果如何，你现在都看到了」",
    TypeText = "StageGroup_75276_TypeText|幻梦深潜",
    Sequence = 2,
    Backgrand = "Icon/CopyTitle/DailyChallenge2.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75277] = {
    ID = 75277,
    CnID = "关卡组@星辰日常挑战风格3",
    BaseSortID = 682,
    Type = 9,
    Name = "StageGroup_75277_Name|幻梦深潜",
    Desc = "StageGroup_75277_Desc|坍塌的偶像注视着自己的子民。\n看他们生存、繁衍、互相争斗，然后将自己彻底遗忘。\n坍塌的偶像怀念着自己的子民。",
    TypeText = "StageGroup_75277_TypeText|幻梦深潜",
    Sequence = 3,
    Backgrand = "Icon/CopyTitle/DailyChallenge3.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75278] = {
    ID = 75278,
    CnID = "关卡组@星辰日常挑战风格4",
    BaseSortID = 683,
    Type = 9,
    Name = "StageGroup_75278_Name|幻梦深潜",
    Desc = "StageGroup_75278_Desc|「每把钥匙都有唯一的编号，只对应唯一的调查员。」\n因此，每把钥匙的陨落也对应着唯一的调查员之死。\n真好啊。就连死亡都是独一无二的。」",
    TypeText = "StageGroup_75278_TypeText|幻梦深潜",
    Sequence = 4,
    Backgrand = "Icon/CopyTitle/DailyChallenge4.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75279] = {
    ID = 75279,
    CnID = "关卡组@星辰日常挑战风格5",
    BaseSortID = 684,
    Type = 9,
    Name = "StageGroup_75279_Name|幻梦深潜",
    Desc = "StageGroup_75279_Desc|「它是唯一，它是全部，它是开启真相之门的希望。」\n无数钥匙围城了一个圈。它们自天空中坠落，带给人们沉甸甸的希望。\n也带来沉甸甸的坟墓。",
    TypeText = "StageGroup_75279_TypeText|幻梦深潜",
    Sequence = 5,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75280] = {
    ID = 75280,
    CnID = "关卡组@星辰日常挑战风格6",
    BaseSortID = 685,
    Type = 9,
    Name = "StageGroup_75280_Name|幻梦深潜",
    Desc = "StageGroup_75280_Desc|「手」掀开夜的帷幕，悄悄来到这个世界。",
    TypeText = "StageGroup_75280_TypeText|幻梦深潜",
    Sequence = 6,
    Backgrand = "Icon/CopyTitle/DailyChallenge1.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75281] = {
    ID = 75281,
    CnID = "关卡组@星辰日常挑战风格7",
    BaseSortID = 686,
    Type = 9,
    Name = "StageGroup_75281_Name|幻梦深潜",
    Desc = "StageGroup_75281_Desc|「此处埋葬着一所大学，千疮百孔，疲惫不堪\n它曾为人类存续奉献了一点希望与勇气\n至于结果如何，你现在都看到了」",
    TypeText = "StageGroup_75281_TypeText|幻梦深潜",
    Sequence = 7,
    Backgrand = "Icon/CopyTitle/DailyChallenge2.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75273] = {
    ID = 75273,
    CnID = "关卡组@星辰日常挑战风格8",
    BaseSortID = 687,
    Type = 9,
    Name = "StageGroup_75273_Name|幻梦深潜",
    Desc = "StageGroup_75273_Desc|坍塌的偶像注视着自己的子民。\n看他们生存、繁衍、互相争斗，然后将自己彻底遗忘。\n坍塌的偶像怀念着自己的子民。",
    TypeText = "StageGroup_75273_TypeText|幻梦深潜",
    Sequence = 8,
    Backgrand = "Icon/CopyTitle/DailyChallenge3.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75274] = {
    ID = 75274,
    CnID = "关卡组@星辰日常挑战风格9",
    BaseSortID = 688,
    Type = 9,
    Name = "StageGroup_75274_Name|幻梦深潜",
    Desc = "StageGroup_75274_Desc|「每把钥匙都有唯一的编号，只对应唯一的调查员。」\n因此，每把钥匙的陨落也对应着唯一的调查员之死。\n真好啊。就连死亡都是独一无二的。",
    TypeText = "StageGroup_75274_TypeText|幻梦深潜",
    Sequence = 9,
    Backgrand = "Icon/CopyTitle/DailyChallenge4.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75265] = {
    ID = 75265,
    CnID = "关卡组@星辰日常挑战风格10",
    BaseSortID = 689,
    Type = 9,
    Name = "StageGroup_75265_Name|幻梦深潜",
    Desc = "StageGroup_75265_Desc|「它是唯一，它是全部，它是开启真相之门的希望。」\n无数钥匙围城了一个圈。它们自天空中坠落，带给人们沉甸甸的希望。\n也带来沉甸甸的坟墓。",
    TypeText = "StageGroup_75265_TypeText|幻梦深潜",
    Sequence = 10,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75266] = {
    ID = 75266,
    CnID = "关卡组@星辰日常挑战风格11",
    BaseSortID = 690,
    Type = 9,
    Name = "StageGroup_75266_Name|幻梦深潜",
    Desc = "StageGroup_75266_Desc|「手」掀开夜的帷幕，悄悄来到这个世界。",
    TypeText = "StageGroup_75266_TypeText|幻梦深潜",
    Sequence = 11,
    Backgrand = "Icon/CopyTitle/DailyChallenge1.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75263] = {
    ID = 75263,
    CnID = "关卡组@星辰日常挑战风格12",
    BaseSortID = 691,
    Type = 9,
    Name = "StageGroup_75263_Name|幻梦深潜",
    Desc = "StageGroup_75263_Desc|「此处埋葬着一所大学，千疮百孔，疲惫不堪\n它曾为人类存续奉献了一点希望与勇气\n至于结果如何，你现在都看到了」",
    TypeText = "StageGroup_75263_TypeText|幻梦深潜",
    Sequence = 12,
    Backgrand = "Icon/CopyTitle/DailyChallenge2.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75264] = {
    ID = 75264,
    CnID = "关卡组@星辰日常挑战风格13",
    BaseSortID = 692,
    Type = 9,
    Name = "StageGroup_75264_Name|幻梦深潜",
    Desc = "StageGroup_75264_Desc|坍塌的偶像注视着自己的子民。\n看他们生存、繁衍、互相争斗，然后将自己彻底遗忘。\n坍塌的偶像怀念着自己的子民。",
    TypeText = "StageGroup_75264_TypeText|幻梦深潜",
    Sequence = 13,
    Backgrand = "Icon/CopyTitle/DailyChallenge3.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75269] = {
    ID = 75269,
    CnID = "关卡组@星辰日常挑战风格14",
    BaseSortID = 693,
    Type = 9,
    Name = "StageGroup_75269_Name|幻梦深潜",
    Desc = "StageGroup_75269_Desc|「每把钥匙都有唯一的编号，只对应唯一的调查员。」\n因此，每把钥匙的陨落也对应着唯一的调查员之死。\n真好啊。就连死亡都是独一无二的。」",
    TypeText = "StageGroup_75269_TypeText|幻梦深潜",
    Sequence = 14,
    Backgrand = "Icon/CopyTitle/DailyChallenge4.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75270] = {
    ID = 75270,
    CnID = "关卡组@星辰日常挑战风格15",
    BaseSortID = 694,
    Type = 9,
    Name = "StageGroup_75270_Name|幻梦深潜",
    Desc = "StageGroup_75270_Desc|「它是唯一，它是全部，它是开启真相之门的希望。」\n无数钥匙围城了一个圈。它们自天空中坠落，带给人们沉甸甸的希望。\n也带来沉甸甸的坟墓。",
    TypeText = "StageGroup_75270_TypeText|幻梦深潜",
    Sequence = 15,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75267] = {
    ID = 75267,
    CnID = "关卡组@星辰日常挑战风格16",
    BaseSortID = 695,
    Type = 9,
    Name = "StageGroup_75267_Name|幻梦深潜",
    Desc = "StageGroup_75267_Desc|「手」掀开夜的帷幕，悄悄来到这个世界。",
    TypeText = "StageGroup_75267_TypeText|幻梦深潜",
    Sequence = 16,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75268] = {
    ID = 75268,
    CnID = "关卡组@星辰日常挑战风格17",
    BaseSortID = 696,
    Type = 9,
    Name = "StageGroup_75268_Name|幻梦深潜",
    Desc = "StageGroup_75268_Desc|「此处埋葬着一所大学，千疮百孔，疲惫不堪\n它曾为人类存续奉献了一点希望与勇气\n至于结果如何，你现在都看到了」",
    TypeText = "StageGroup_75268_TypeText|幻梦深潜",
    Sequence = 17,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75271] = {
    ID = 75271,
    CnID = "关卡组@星辰日常挑战风格18",
    BaseSortID = 697,
    Type = 9,
    Name = "StageGroup_75271_Name|幻梦深潜",
    Desc = "StageGroup_75271_Desc|坍塌的偶像注视着自己的子民。\n看他们生存、繁衍、互相争斗，然后将自己彻底遗忘。\n坍塌的偶像怀念着自己的子民。",
    TypeText = "StageGroup_75271_TypeText|幻梦深潜",
    Sequence = 18,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75272] = {
    ID = 75272,
    CnID = "关卡组@星辰日常挑战风格19",
    BaseSortID = 698,
    Type = 9,
    Name = "StageGroup_75272_Name|幻梦深潜",
    Desc = "StageGroup_75272_Desc|「每把钥匙都有唯一的编号，只对应唯一的调查员。」\n因此，每把钥匙的陨落也对应着唯一的调查员之死。\n真好啊。就连死亡都是独一无二的。」",
    TypeText = "StageGroup_75272_TypeText|幻梦深潜",
    Sequence = 19,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75285] = {
    ID = 75285,
    CnID = "关卡组@星辰日常挑战风格20",
    BaseSortID = 699,
    Type = 9,
    Name = "StageGroup_75285_Name|幻梦深潜",
    Desc = "StageGroup_75285_Desc|「手」掀开夜的帷幕，悄悄来到这个世界。",
    TypeText = "StageGroup_75285_TypeText|幻梦深潜",
    Sequence = 20,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75284] = {
    ID = 75284,
    CnID = "关卡组@星辰日常挑战风格21",
    BaseSortID = 700,
    Type = 9,
    Name = "StageGroup_75284_Name|幻梦深潜",
    Desc = "StageGroup_75284_Desc|「此处埋葬着一所大学，千疮百孔，疲惫不堪\n它曾为人类存续奉献了一点希望与勇气\n至于结果如何，你现在都看到了」",
    TypeText = "StageGroup_75284_TypeText|幻梦深潜",
    Sequence = 21,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75283] = {
    ID = 75283,
    CnID = "关卡组@星辰日常挑战风格22",
    BaseSortID = 701,
    Type = 9,
    Name = "StageGroup_75283_Name|幻梦深潜",
    Desc = "StageGroup_75283_Desc|坍塌的偶像注视着自己的子民。\n看他们生存、繁衍、互相争斗，然后将自己彻底遗忘。\n坍塌的偶像怀念着自己的子民。",
    TypeText = "StageGroup_75283_TypeText|幻梦深潜",
    Sequence = 22,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75282] = {
    ID = 75282,
    CnID = "关卡组@星辰日常挑战风格23",
    BaseSortID = 702,
    Type = 9,
    Name = "StageGroup_75282_Name|幻梦深潜",
    Desc = "StageGroup_75282_Desc|「每把钥匙都有唯一的编号，只对应唯一的调查员。」\n因此，每把钥匙的陨落也对应着唯一的调查员之死。\n真好啊。就连死亡都是独一无二的。」",
    TypeText = "StageGroup_75282_TypeText|幻梦深潜",
    Sequence = 23,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [75286] = {
    ID = 75286,
    CnID = "关卡组@星辰日常挑战风格24",
    BaseSortID = 703,
    Type = 9,
    Name = "StageGroup_75286_Name|幻梦深潜",
    Desc = "StageGroup_75286_Desc|「它是唯一，它是全部，它是开启真相之门的希望。」\n无数钥匙围城了一个圈。它们自天空中坠落，带给人们沉甸甸的希望。\n也带来沉甸甸的坟墓。",
    TypeText = "StageGroup_75286_TypeText|幻梦深潜",
    Sequence = 24,
    Backgrand = "Icon/CopyTitle/DailyChallenge5.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108},
    IntegralTerm = {
      40476,
      40468,
      40470,
      40469,
      71867,
      40475,
      40474,
      40473,
      40472,
      71868,
      39279
    }
  },
  [77134] = {
    ID = 77134,
    CnID = "关卡组@融蚀深渊31期1",
    BaseSortID = 704,
    Type = 21,
    Name = "StageGroup_77134_Name|融灾禁区·第1波",
    TypeText = "StageGroup_77134_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77133] = {
    ID = 77133,
    CnID = "关卡组@融蚀深渊31期2",
    BaseSortID = 705,
    Type = 21,
    Name = "StageGroup_77133_Name|融灾禁区·第2波",
    TypeText = "StageGroup_77133_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77132] = {
    ID = 77132,
    CnID = "关卡组@融蚀深渊31期3",
    BaseSortID = 706,
    Type = 21,
    Name = "StageGroup_77132_Name|融灾禁区·第3波",
    TypeText = "StageGroup_77132_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77138] = {
    ID = 77138,
    CnID = "关卡组@融蚀深渊31期4",
    BaseSortID = 707,
    Type = 21,
    Name = "StageGroup_77138_Name|融灾禁区·第4波",
    TypeText = "StageGroup_77138_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77137] = {
    ID = 77137,
    CnID = "关卡组@融蚀深渊31期5",
    BaseSortID = 708,
    Type = 21,
    Name = "StageGroup_77137_Name|融灾禁区·第5波",
    TypeText = "StageGroup_77137_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77124] = {
    ID = 77124,
    CnID = "关卡组@融蚀深渊32期1",
    BaseSortID = 709,
    Type = 21,
    Name = "StageGroup_77124_Name|融灾禁区·第1波",
    TypeText = "StageGroup_77124_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77125] = {
    ID = 77125,
    CnID = "关卡组@融蚀深渊32期2",
    BaseSortID = 710,
    Type = 21,
    Name = "StageGroup_77125_Name|融灾禁区·第2波",
    TypeText = "StageGroup_77125_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77126] = {
    ID = 77126,
    CnID = "关卡组@融蚀深渊32期3",
    BaseSortID = 711,
    Type = 21,
    Name = "StageGroup_77126_Name|融灾禁区·第3波",
    TypeText = "StageGroup_77126_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77121] = {
    ID = 77121,
    CnID = "关卡组@融蚀深渊32期4",
    BaseSortID = 712,
    Type = 21,
    Name = "StageGroup_77121_Name|融灾禁区·第4波",
    TypeText = "StageGroup_77121_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77122] = {
    ID = 77122,
    CnID = "关卡组@融蚀深渊32期5",
    BaseSortID = 713,
    Type = 21,
    Name = "StageGroup_77122_Name|融灾禁区·第5波",
    TypeText = "StageGroup_77122_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77118] = {
    ID = 77118,
    CnID = "关卡组@融蚀深渊33期1",
    BaseSortID = 714,
    Type = 21,
    Name = "StageGroup_77118_Name|融灾禁区·第1波",
    TypeText = "StageGroup_77118_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77120] = {
    ID = 77120,
    CnID = "关卡组@融蚀深渊33期2",
    BaseSortID = 715,
    Type = 21,
    Name = "StageGroup_77120_Name|融灾禁区·第2波",
    TypeText = "StageGroup_77120_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77119] = {
    ID = 77119,
    CnID = "关卡组@融蚀深渊33期3",
    BaseSortID = 716,
    Type = 21,
    Name = "StageGroup_77119_Name|融灾禁区·第3波",
    TypeText = "StageGroup_77119_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77117] = {
    ID = 77117,
    CnID = "关卡组@融蚀深渊33期4",
    BaseSortID = 717,
    Type = 21,
    Name = "StageGroup_77117_Name|融灾禁区·第4波",
    TypeText = "StageGroup_77117_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77116] = {
    ID = 77116,
    CnID = "关卡组@融蚀深渊33期5",
    BaseSortID = 718,
    Type = 21,
    Name = "StageGroup_77116_Name|融灾禁区·第5波",
    TypeText = "StageGroup_77116_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77115] = {
    ID = 77115,
    CnID = "关卡组@融蚀深渊34期1",
    BaseSortID = 719,
    Type = 21,
    Name = "StageGroup_77115_Name|融灾禁区·第1波",
    TypeText = "StageGroup_77115_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77113] = {
    ID = 77113,
    CnID = "关卡组@融蚀深渊34期2",
    BaseSortID = 720,
    Type = 21,
    Name = "StageGroup_77113_Name|融灾禁区·第2波",
    TypeText = "StageGroup_77113_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77114] = {
    ID = 77114,
    CnID = "关卡组@融蚀深渊34期3",
    BaseSortID = 721,
    Type = 21,
    Name = "StageGroup_77114_Name|融灾禁区·第3波",
    TypeText = "StageGroup_77114_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77111] = {
    ID = 77111,
    CnID = "关卡组@融蚀深渊34期4",
    BaseSortID = 722,
    Type = 21,
    Name = "StageGroup_77111_Name|融灾禁区·第4波",
    TypeText = "StageGroup_77111_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77112] = {
    ID = 77112,
    CnID = "关卡组@融蚀深渊34期5",
    BaseSortID = 723,
    Type = 21,
    Name = "StageGroup_77112_Name|融灾禁区·第5波",
    TypeText = "StageGroup_77112_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77153] = {
    ID = 77153,
    CnID = "关卡组@融蚀深渊35期1",
    BaseSortID = 724,
    Type = 21,
    Name = "StageGroup_77153_Name|融灾禁区·第1波",
    TypeText = "StageGroup_77153_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77152] = {
    ID = 77152,
    CnID = "关卡组@融蚀深渊35期2",
    BaseSortID = 725,
    Type = 21,
    Name = "StageGroup_77152_Name|融灾禁区·第2波",
    TypeText = "StageGroup_77152_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77151] = {
    ID = 77151,
    CnID = "关卡组@融蚀深渊35期3",
    BaseSortID = 726,
    Type = 21,
    Name = "StageGroup_77151_Name|融灾禁区·第3波",
    TypeText = "StageGroup_77151_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77150] = {
    ID = 77150,
    CnID = "关卡组@融蚀深渊35期4",
    BaseSortID = 727,
    Type = 21,
    Name = "StageGroup_77150_Name|融灾禁区·第4波",
    TypeText = "StageGroup_77150_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77149] = {
    ID = 77149,
    CnID = "关卡组@融蚀深渊35期5",
    BaseSortID = 728,
    Type = 21,
    Name = "StageGroup_77149_Name|融灾禁区·第5波",
    TypeText = "StageGroup_77149_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77144] = {
    ID = 77144,
    CnID = "关卡组@融蚀深渊36期1",
    BaseSortID = 729,
    Type = 21,
    Name = "StageGroup_77144_Name|融灾禁区·第1波",
    TypeText = "StageGroup_77144_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77145] = {
    ID = 77145,
    CnID = "关卡组@融蚀深渊36期2",
    BaseSortID = 730,
    Type = 21,
    Name = "StageGroup_77145_Name|融灾禁区·第2波",
    TypeText = "StageGroup_77145_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77146] = {
    ID = 77146,
    CnID = "关卡组@融蚀深渊36期3",
    BaseSortID = 731,
    Type = 21,
    Name = "StageGroup_77146_Name|融灾禁区·第3波",
    TypeText = "StageGroup_77146_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77147] = {
    ID = 77147,
    CnID = "关卡组@融蚀深渊36期4",
    BaseSortID = 732,
    Type = 21,
    Name = "StageGroup_77147_Name|融灾禁区·第4波",
    TypeText = "StageGroup_77147_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77148] = {
    ID = 77148,
    CnID = "关卡组@融蚀深渊36期5",
    BaseSortID = 733,
    Type = 21,
    Name = "StageGroup_77148_Name|融灾禁区·第5波",
    TypeText = "StageGroup_77148_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77139] = {
    ID = 77139,
    CnID = "关卡组@融蚀深渊37期1",
    BaseSortID = 734,
    Type = 21,
    Name = "StageGroup_77139_Name|融灾禁区·第1波",
    TypeText = "StageGroup_77139_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77141] = {
    ID = 77141,
    CnID = "关卡组@融蚀深渊37期2",
    BaseSortID = 735,
    Type = 21,
    Name = "StageGroup_77141_Name|融灾禁区·第2波",
    TypeText = "StageGroup_77141_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77140] = {
    ID = 77140,
    CnID = "关卡组@融蚀深渊37期3",
    BaseSortID = 736,
    Type = 21,
    Name = "StageGroup_77140_Name|融灾禁区·第3波",
    TypeText = "StageGroup_77140_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77143] = {
    ID = 77143,
    CnID = "关卡组@融蚀深渊37期4",
    BaseSortID = 737,
    Type = 21,
    Name = "StageGroup_77143_Name|融灾禁区·第4波",
    TypeText = "StageGroup_77143_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77142] = {
    ID = 77142,
    CnID = "关卡组@融蚀深渊37期5",
    BaseSortID = 738,
    Type = 21,
    Name = "StageGroup_77142_Name|融灾禁区·第5波",
    TypeText = "StageGroup_77142_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77123] = {
    ID = 77123,
    CnID = "关卡组@融蚀深渊38期1",
    BaseSortID = 739,
    Type = 21,
    Name = "StageGroup_77123_Name|融灾禁区·第1波",
    TypeText = "StageGroup_77123_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77110] = {
    ID = 77110,
    CnID = "关卡组@融蚀深渊38期2",
    BaseSortID = 740,
    Type = 21,
    Name = "StageGroup_77110_Name|融灾禁区·第2波",
    TypeText = "StageGroup_77110_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77135] = {
    ID = 77135,
    CnID = "关卡组@融蚀深渊38期3",
    BaseSortID = 741,
    Type = 21,
    Name = "StageGroup_77135_Name|融灾禁区·第3波",
    TypeText = "StageGroup_77135_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77136] = {
    ID = 77136,
    CnID = "关卡组@融蚀深渊38期4",
    BaseSortID = 742,
    Type = 21,
    Name = "StageGroup_77136_Name|融灾禁区·第4波",
    TypeText = "StageGroup_77136_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77104] = {
    ID = 77104,
    CnID = "关卡组@融蚀深渊38期5",
    BaseSortID = 743,
    Type = 21,
    Name = "StageGroup_77104_Name|融灾禁区·第5波",
    TypeText = "StageGroup_77104_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77129] = {
    ID = 77129,
    CnID = "关卡组@融蚀深渊39期1",
    BaseSortID = 744,
    Type = 21,
    Name = "StageGroup_77129_Name|第1波",
    TypeText = "StageGroup_77129_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77128] = {
    ID = 77128,
    CnID = "关卡组@融蚀深渊39期2",
    BaseSortID = 745,
    Type = 21,
    Name = "StageGroup_77128_Name|第2波",
    TypeText = "StageGroup_77128_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77127] = {
    ID = 77127,
    CnID = "关卡组@融蚀深渊39期3",
    BaseSortID = 746,
    Type = 21,
    Name = "StageGroup_77127_Name|第3波",
    TypeText = "StageGroup_77127_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77131] = {
    ID = 77131,
    CnID = "关卡组@融蚀深渊39期4",
    BaseSortID = 747,
    Type = 21,
    Name = "StageGroup_77131_Name|第4波",
    TypeText = "StageGroup_77131_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77130] = {
    ID = 77130,
    CnID = "关卡组@融蚀深渊39期5",
    BaseSortID = 748,
    Type = 21,
    Name = "StageGroup_77130_Name|第5波",
    TypeText = "StageGroup_77130_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77107] = {
    ID = 77107,
    CnID = "关卡组@融蚀深渊40期1",
    BaseSortID = 749,
    Type = 21,
    Name = "StageGroup_77107_Name|第1波",
    TypeText = "StageGroup_77107_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77106] = {
    ID = 77106,
    CnID = "关卡组@融蚀深渊40期2",
    BaseSortID = 750,
    Type = 21,
    Name = "StageGroup_77106_Name|第2波",
    TypeText = "StageGroup_77106_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77105] = {
    ID = 77105,
    CnID = "关卡组@融蚀深渊40期3",
    BaseSortID = 751,
    Type = 21,
    Name = "StageGroup_77105_Name|第3波",
    TypeText = "StageGroup_77105_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77109] = {
    ID = 77109,
    CnID = "关卡组@融蚀深渊40期4",
    BaseSortID = 752,
    Type = 21,
    Name = "StageGroup_77109_Name|第4波",
    TypeText = "StageGroup_77109_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [77108] = {
    ID = 77108,
    CnID = "关卡组@融蚀深渊40期5",
    BaseSortID = 753,
    Type = 21,
    Name = "StageGroup_77108_Name|第5波",
    TypeText = "StageGroup_77108_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80885] = {
    ID = 80885,
    CnID = "关卡组@融蚀深渊41期1",
    BaseSortID = 754,
    Type = 21,
    Name = "StageGroup_80885_Name|第1波",
    TypeText = "StageGroup_80885_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80883] = {
    ID = 80883,
    CnID = "关卡组@融蚀深渊41期2",
    BaseSortID = 755,
    Type = 21,
    Name = "StageGroup_80883_Name|第2波",
    TypeText = "StageGroup_80883_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80884] = {
    ID = 80884,
    CnID = "关卡组@融蚀深渊41期3",
    BaseSortID = 756,
    Type = 21,
    Name = "StageGroup_80884_Name|第3波",
    TypeText = "StageGroup_80884_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80886] = {
    ID = 80886,
    CnID = "关卡组@融蚀深渊41期4",
    BaseSortID = 757,
    Type = 21,
    Name = "StageGroup_80886_Name|第4波",
    TypeText = "StageGroup_80886_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80887] = {
    ID = 80887,
    CnID = "关卡组@融蚀深渊41期5",
    BaseSortID = 758,
    Type = 21,
    Name = "StageGroup_80887_Name|第5波",
    TypeText = "StageGroup_80887_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80875] = {
    ID = 80875,
    CnID = "关卡组@融蚀深渊42期1",
    BaseSortID = 759,
    Type = 21,
    Name = "StageGroup_80875_Name|第1波",
    TypeText = "StageGroup_80875_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80877] = {
    ID = 80877,
    CnID = "关卡组@融蚀深渊42期2",
    BaseSortID = 760,
    Type = 21,
    Name = "StageGroup_80877_Name|第2波",
    TypeText = "StageGroup_80877_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80876] = {
    ID = 80876,
    CnID = "关卡组@融蚀深渊42期3",
    BaseSortID = 761,
    Type = 21,
    Name = "StageGroup_80876_Name|第3波",
    TypeText = "StageGroup_80876_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80874] = {
    ID = 80874,
    CnID = "关卡组@融蚀深渊42期4",
    BaseSortID = 762,
    Type = 21,
    Name = "StageGroup_80874_Name|第4波",
    TypeText = "StageGroup_80874_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80873] = {
    ID = 80873,
    CnID = "关卡组@融蚀深渊42期5",
    BaseSortID = 763,
    Type = 21,
    Name = "StageGroup_80873_Name|第5波",
    TypeText = "StageGroup_80873_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80880] = {
    ID = 80880,
    CnID = "关卡组@融蚀深渊43期1",
    BaseSortID = 764,
    Type = 21,
    Name = "StageGroup_80880_Name|第1波",
    TypeText = "StageGroup_80880_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80881] = {
    ID = 80881,
    CnID = "关卡组@融蚀深渊43期2",
    BaseSortID = 765,
    Type = 21,
    Name = "StageGroup_80881_Name|第2波",
    TypeText = "StageGroup_80881_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80882] = {
    ID = 80882,
    CnID = "关卡组@融蚀深渊43期3",
    BaseSortID = 766,
    Type = 21,
    Name = "StageGroup_80882_Name|第3波",
    TypeText = "StageGroup_80882_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80878] = {
    ID = 80878,
    CnID = "关卡组@融蚀深渊43期4",
    BaseSortID = 767,
    Type = 21,
    Name = "StageGroup_80878_Name|第4波",
    TypeText = "StageGroup_80878_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80879] = {
    ID = 80879,
    CnID = "关卡组@融蚀深渊43期5",
    BaseSortID = 768,
    Type = 21,
    Name = "StageGroup_80879_Name|第5波",
    TypeText = "StageGroup_80879_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80906] = {
    ID = 80906,
    CnID = "关卡组@融蚀深渊44期1",
    BaseSortID = 769,
    Type = 21,
    Name = "StageGroup_80906_Name|第1波",
    TypeText = "StageGroup_80906_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80850] = {
    ID = 80850,
    CnID = "关卡组@融蚀深渊44期2",
    BaseSortID = 770,
    Type = 21,
    Name = "StageGroup_80850_Name|第2波",
    TypeText = "StageGroup_80850_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80904] = {
    ID = 80904,
    CnID = "关卡组@融蚀深渊44期3",
    BaseSortID = 771,
    Type = 21,
    Name = "StageGroup_80904_Name|第3波",
    TypeText = "StageGroup_80904_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80903] = {
    ID = 80903,
    CnID = "关卡组@融蚀深渊44期4",
    BaseSortID = 772,
    Type = 21,
    Name = "StageGroup_80903_Name|第4波",
    TypeText = "StageGroup_80903_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80847] = {
    ID = 80847,
    CnID = "关卡组@融蚀深渊44期5",
    BaseSortID = 773,
    Type = 21,
    Name = "StageGroup_80847_Name|第5波",
    TypeText = "StageGroup_80847_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80912] = {
    ID = 80912,
    CnID = "关卡组@融蚀深渊45期1",
    BaseSortID = 774,
    Type = 21,
    Name = "StageGroup_80912_Name|第1波",
    TypeText = "StageGroup_80912_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80846] = {
    ID = 80846,
    CnID = "关卡组@融蚀深渊45期2",
    BaseSortID = 775,
    Type = 21,
    Name = "StageGroup_80846_Name|第2波",
    TypeText = "StageGroup_80846_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80862] = {
    ID = 80862,
    CnID = "关卡组@融蚀深渊45期3",
    BaseSortID = 776,
    Type = 21,
    Name = "StageGroup_80862_Name|第3波",
    TypeText = "StageGroup_80862_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80851] = {
    ID = 80851,
    CnID = "关卡组@融蚀深渊45期4",
    BaseSortID = 777,
    Type = 21,
    Name = "StageGroup_80851_Name|第4波",
    TypeText = "StageGroup_80851_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80833] = {
    ID = 80833,
    CnID = "关卡组@融蚀深渊45期5",
    BaseSortID = 778,
    Type = 21,
    Name = "StageGroup_80833_Name|第5波",
    TypeText = "StageGroup_80833_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80890] = {
    ID = 80890,
    CnID = "关卡组@融蚀深渊46期1",
    BaseSortID = 779,
    Type = 21,
    Name = "StageGroup_80890_Name|第1波",
    TypeText = "StageGroup_80890_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80892] = {
    ID = 80892,
    CnID = "关卡组@融蚀深渊46期2",
    BaseSortID = 780,
    Type = 21,
    Name = "StageGroup_80892_Name|第2波",
    TypeText = "StageGroup_80892_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80891] = {
    ID = 80891,
    CnID = "关卡组@融蚀深渊46期3",
    BaseSortID = 781,
    Type = 21,
    Name = "StageGroup_80891_Name|第3波",
    TypeText = "StageGroup_80891_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80894] = {
    ID = 80894,
    CnID = "关卡组@融蚀深渊46期4",
    BaseSortID = 782,
    Type = 21,
    Name = "StageGroup_80894_Name|第4波",
    TypeText = "StageGroup_80894_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80893] = {
    ID = 80893,
    CnID = "关卡组@融蚀深渊46期5",
    BaseSortID = 783,
    Type = 21,
    Name = "StageGroup_80893_Name|第5波",
    TypeText = "StageGroup_80893_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80896] = {
    ID = 80896,
    CnID = "关卡组@融蚀深渊47期1",
    BaseSortID = 784,
    Type = 21,
    Name = "StageGroup_80896_Name|第1波",
    TypeText = "StageGroup_80896_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80834] = {
    ID = 80834,
    CnID = "关卡组@融蚀深渊47期2",
    BaseSortID = 785,
    Type = 21,
    Name = "StageGroup_80834_Name|第2波",
    TypeText = "StageGroup_80834_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80898] = {
    ID = 80898,
    CnID = "关卡组@融蚀深渊47期3",
    BaseSortID = 786,
    Type = 21,
    Name = "StageGroup_80898_Name|第3波",
    TypeText = "StageGroup_80898_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80899] = {
    ID = 80899,
    CnID = "关卡组@融蚀深渊47期4",
    BaseSortID = 787,
    Type = 21,
    Name = "StageGroup_80899_Name|第4波",
    TypeText = "StageGroup_80899_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80900] = {
    ID = 80900,
    CnID = "关卡组@融蚀深渊47期5",
    BaseSortID = 788,
    Type = 21,
    Name = "StageGroup_80900_Name|第5波",
    TypeText = "StageGroup_80900_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80915] = {
    ID = 80915,
    CnID = "关卡组@融蚀深渊48期1",
    BaseSortID = 789,
    Type = 21,
    Name = "StageGroup_80915_Name|第1波",
    TypeText = "StageGroup_80915_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80914] = {
    ID = 80914,
    CnID = "关卡组@融蚀深渊48期2",
    BaseSortID = 790,
    Type = 21,
    Name = "StageGroup_80914_Name|第2波",
    TypeText = "StageGroup_80914_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80913] = {
    ID = 80913,
    CnID = "关卡组@融蚀深渊48期3",
    BaseSortID = 791,
    Type = 21,
    Name = "StageGroup_80913_Name|第3波",
    TypeText = "StageGroup_80913_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80920] = {
    ID = 80920,
    CnID = "关卡组@融蚀深渊48期4",
    BaseSortID = 792,
    Type = 21,
    Name = "StageGroup_80920_Name|第4波",
    TypeText = "StageGroup_80920_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80919] = {
    ID = 80919,
    CnID = "关卡组@融蚀深渊48期5",
    BaseSortID = 793,
    Type = 21,
    Name = "StageGroup_80919_Name|第5波",
    TypeText = "StageGroup_80919_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80832] = {
    ID = 80832,
    CnID = "关卡组@融蚀深渊49期1",
    BaseSortID = 794,
    Type = 21,
    Name = "StageGroup_80832_Name|第1波",
    TypeText = "StageGroup_80832_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80921] = {
    ID = 80921,
    CnID = "关卡组@融蚀深渊49期2",
    BaseSortID = 795,
    Type = 21,
    Name = "StageGroup_80921_Name|第2波",
    TypeText = "StageGroup_80921_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80956] = {
    ID = 80956,
    CnID = "关卡组@融蚀深渊49期3",
    BaseSortID = 796,
    Type = 21,
    Name = "StageGroup_80956_Name|第3波",
    TypeText = "StageGroup_80956_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80927] = {
    ID = 80927,
    CnID = "关卡组@融蚀深渊49期4",
    BaseSortID = 797,
    Type = 21,
    Name = "StageGroup_80927_Name|第4波",
    TypeText = "StageGroup_80927_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80928] = {
    ID = 80928,
    CnID = "关卡组@融蚀深渊49期5",
    BaseSortID = 798,
    Type = 21,
    Name = "StageGroup_80928_Name|第5波",
    TypeText = "StageGroup_80928_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80901] = {
    ID = 80901,
    CnID = "关卡组@融蚀深渊50期1",
    BaseSortID = 799,
    Type = 21,
    Name = "StageGroup_80901_Name|第1波",
    TypeText = "StageGroup_80901_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80902] = {
    ID = 80902,
    CnID = "关卡组@融蚀深渊50期2",
    BaseSortID = 800,
    Type = 21,
    Name = "StageGroup_80902_Name|第2波",
    TypeText = "StageGroup_80902_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80848] = {
    ID = 80848,
    CnID = "关卡组@融蚀深渊50期3",
    BaseSortID = 801,
    Type = 21,
    Name = "StageGroup_80848_Name|第3波",
    TypeText = "StageGroup_80848_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80849] = {
    ID = 80849,
    CnID = "关卡组@融蚀深渊50期4",
    BaseSortID = 802,
    Type = 21,
    Name = "StageGroup_80849_Name|第4波",
    TypeText = "StageGroup_80849_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80905] = {
    ID = 80905,
    CnID = "关卡组@融蚀深渊50期5",
    BaseSortID = 803,
    Type = 21,
    Name = "StageGroup_80905_Name|第5波",
    TypeText = "StageGroup_80905_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80895] = {
    ID = 80895,
    CnID = "关卡组@融蚀深渊51期1",
    BaseSortID = 804,
    Type = 21,
    Name = "StageGroup_80895_Name|第1波",
    TypeText = "StageGroup_80895_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80837] = {
    ID = 80837,
    CnID = "关卡组@融蚀深渊51期2",
    BaseSortID = 805,
    Type = 21,
    Name = "StageGroup_80837_Name|第2波",
    TypeText = "StageGroup_80837_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80897] = {
    ID = 80897,
    CnID = "关卡组@融蚀深渊51期3",
    BaseSortID = 806,
    Type = 21,
    Name = "StageGroup_80897_Name|第3波",
    TypeText = "StageGroup_80897_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80845] = {
    ID = 80845,
    CnID = "关卡组@融蚀深渊51期4",
    BaseSortID = 807,
    Type = 21,
    Name = "StageGroup_80845_Name|第4波",
    TypeText = "StageGroup_80845_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80842] = {
    ID = 80842,
    CnID = "关卡组@融蚀深渊51期5",
    BaseSortID = 808,
    Type = 21,
    Name = "StageGroup_80842_Name|第5波",
    TypeText = "StageGroup_80842_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80934] = {
    ID = 80934,
    CnID = "关卡组@融蚀深渊52期1",
    BaseSortID = 809,
    Type = 21,
    Name = "StageGroup_80934_Name|第1波",
    TypeText = "StageGroup_80934_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80932] = {
    ID = 80932,
    CnID = "关卡组@融蚀深渊52期2",
    BaseSortID = 810,
    Type = 21,
    Name = "StageGroup_80932_Name|第2波",
    TypeText = "StageGroup_80932_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80933] = {
    ID = 80933,
    CnID = "关卡组@融蚀深渊52期3",
    BaseSortID = 811,
    Type = 21,
    Name = "StageGroup_80933_Name|第3波",
    TypeText = "StageGroup_80933_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80930] = {
    ID = 80930,
    CnID = "关卡组@融蚀深渊52期4",
    BaseSortID = 812,
    Type = 21,
    Name = "StageGroup_80930_Name|第4波",
    TypeText = "StageGroup_80930_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80931] = {
    ID = 80931,
    CnID = "关卡组@融蚀深渊52期5",
    BaseSortID = 813,
    Type = 21,
    Name = "StageGroup_80931_Name|第5波",
    TypeText = "StageGroup_80931_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80911] = {
    ID = 80911,
    CnID = "关卡组@融蚀深渊53期1",
    BaseSortID = 814,
    Type = 21,
    Name = "StageGroup_80911_Name|第1波",
    TypeText = "StageGroup_80911_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80910] = {
    ID = 80910,
    CnID = "关卡组@融蚀深渊53期2",
    BaseSortID = 815,
    Type = 21,
    Name = "StageGroup_80910_Name|第2波",
    TypeText = "StageGroup_80910_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80909] = {
    ID = 80909,
    CnID = "关卡组@融蚀深渊53期3",
    BaseSortID = 816,
    Type = 21,
    Name = "StageGroup_80909_Name|第3波",
    TypeText = "StageGroup_80909_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80908] = {
    ID = 80908,
    CnID = "关卡组@融蚀深渊53期4",
    BaseSortID = 817,
    Type = 21,
    Name = "StageGroup_80908_Name|第4波",
    TypeText = "StageGroup_80908_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80907] = {
    ID = 80907,
    CnID = "关卡组@融蚀深渊53期5",
    BaseSortID = 818,
    Type = 21,
    Name = "StageGroup_80907_Name|第5波",
    TypeText = "StageGroup_80907_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80943] = {
    ID = 80943,
    CnID = "关卡组@融蚀深渊54期1",
    BaseSortID = 819,
    Type = 21,
    Name = "StageGroup_80943_Name|第1波",
    TypeText = "StageGroup_80943_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80944] = {
    ID = 80944,
    CnID = "关卡组@融蚀深渊54期2",
    BaseSortID = 820,
    Type = 21,
    Name = "StageGroup_80944_Name|第2波",
    TypeText = "StageGroup_80944_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80945] = {
    ID = 80945,
    CnID = "关卡组@融蚀深渊54期3",
    BaseSortID = 821,
    Type = 21,
    Name = "StageGroup_80945_Name|第3波",
    TypeText = "StageGroup_80945_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80941] = {
    ID = 80941,
    CnID = "关卡组@融蚀深渊54期4",
    BaseSortID = 822,
    Type = 21,
    Name = "StageGroup_80941_Name|第4波",
    TypeText = "StageGroup_80941_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80942] = {
    ID = 80942,
    CnID = "关卡组@融蚀深渊54期5",
    BaseSortID = 823,
    Type = 21,
    Name = "StageGroup_80942_Name|第5波",
    TypeText = "StageGroup_80942_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80937] = {
    ID = 80937,
    CnID = "关卡组@融蚀深渊55期1",
    BaseSortID = 824,
    Type = 21,
    Name = "StageGroup_80937_Name|第1波",
    TypeText = "StageGroup_80937_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80940] = {
    ID = 80940,
    CnID = "关卡组@融蚀深渊55期2",
    BaseSortID = 825,
    Type = 21,
    Name = "StageGroup_80940_Name|第2波",
    TypeText = "StageGroup_80940_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80939] = {
    ID = 80939,
    CnID = "关卡组@融蚀深渊55期3",
    BaseSortID = 826,
    Type = 21,
    Name = "StageGroup_80939_Name|第3波",
    TypeText = "StageGroup_80939_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80936] = {
    ID = 80936,
    CnID = "关卡组@融蚀深渊55期4",
    BaseSortID = 827,
    Type = 21,
    Name = "StageGroup_80936_Name|第4波",
    TypeText = "StageGroup_80936_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80935] = {
    ID = 80935,
    CnID = "关卡组@融蚀深渊55期5",
    BaseSortID = 828,
    Type = 21,
    Name = "StageGroup_80935_Name|第5波",
    TypeText = "StageGroup_80935_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80953] = {
    ID = 80953,
    CnID = "关卡组@融蚀深渊56期1",
    BaseSortID = 829,
    Type = 21,
    Name = "StageGroup_80953_Name|第1波",
    TypeText = "StageGroup_80953_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80951] = {
    ID = 80951,
    CnID = "关卡组@融蚀深渊56期2",
    BaseSortID = 830,
    Type = 21,
    Name = "StageGroup_80951_Name|第2波",
    TypeText = "StageGroup_80951_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80952] = {
    ID = 80952,
    CnID = "关卡组@融蚀深渊56期3",
    BaseSortID = 831,
    Type = 21,
    Name = "StageGroup_80952_Name|第3波",
    TypeText = "StageGroup_80952_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80954] = {
    ID = 80954,
    CnID = "关卡组@融蚀深渊56期4",
    BaseSortID = 832,
    Type = 21,
    Name = "StageGroup_80954_Name|第4波",
    TypeText = "StageGroup_80954_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80955] = {
    ID = 80955,
    CnID = "关卡组@融蚀深渊56期5",
    BaseSortID = 833,
    Type = 21,
    Name = "StageGroup_80955_Name|第5波",
    TypeText = "StageGroup_80955_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80948] = {
    ID = 80948,
    CnID = "关卡组@融蚀深渊57期1",
    BaseSortID = 834,
    Type = 21,
    Name = "StageGroup_80948_Name|第1波",
    TypeText = "StageGroup_80948_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80947] = {
    ID = 80947,
    CnID = "关卡组@融蚀深渊57期2",
    BaseSortID = 835,
    Type = 21,
    Name = "StageGroup_80947_Name|第2波",
    TypeText = "StageGroup_80947_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80946] = {
    ID = 80946,
    CnID = "关卡组@融蚀深渊57期3",
    BaseSortID = 836,
    Type = 21,
    Name = "StageGroup_80946_Name|第3波",
    TypeText = "StageGroup_80946_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80950] = {
    ID = 80950,
    CnID = "关卡组@融蚀深渊57期4",
    BaseSortID = 837,
    Type = 21,
    Name = "StageGroup_80950_Name|第4波",
    TypeText = "StageGroup_80950_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80949] = {
    ID = 80949,
    CnID = "关卡组@融蚀深渊57期5",
    BaseSortID = 838,
    Type = 21,
    Name = "StageGroup_80949_Name|第5波",
    TypeText = "StageGroup_80949_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80922] = {
    ID = 80922,
    CnID = "关卡组@融蚀深渊58期1",
    BaseSortID = 839,
    Type = 21,
    Name = "StageGroup_80922_Name|第1波",
    TypeText = "StageGroup_80922_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80923] = {
    ID = 80923,
    CnID = "关卡组@融蚀深渊58期2",
    BaseSortID = 840,
    Type = 21,
    Name = "StageGroup_80923_Name|第2波",
    TypeText = "StageGroup_80923_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80924] = {
    ID = 80924,
    CnID = "关卡组@融蚀深渊58期3",
    BaseSortID = 841,
    Type = 21,
    Name = "StageGroup_80924_Name|第3波",
    TypeText = "StageGroup_80924_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80925] = {
    ID = 80925,
    CnID = "关卡组@融蚀深渊58期4",
    BaseSortID = 842,
    Type = 21,
    Name = "StageGroup_80925_Name|第4波",
    TypeText = "StageGroup_80925_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80926] = {
    ID = 80926,
    CnID = "关卡组@融蚀深渊58期5",
    BaseSortID = 843,
    Type = 21,
    Name = "StageGroup_80926_Name|第5波",
    TypeText = "StageGroup_80926_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80929] = {
    ID = 80929,
    CnID = "关卡组@融蚀深渊59期1",
    BaseSortID = 844,
    Type = 21,
    Name = "StageGroup_80929_Name|第1波",
    TypeText = "StageGroup_80929_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80916] = {
    ID = 80916,
    CnID = "关卡组@融蚀深渊59期2",
    BaseSortID = 845,
    Type = 21,
    Name = "StageGroup_80916_Name|第2波",
    TypeText = "StageGroup_80916_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80938] = {
    ID = 80938,
    CnID = "关卡组@融蚀深渊59期3",
    BaseSortID = 846,
    Type = 21,
    Name = "StageGroup_80938_Name|第3波",
    TypeText = "StageGroup_80938_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80918] = {
    ID = 80918,
    CnID = "关卡组@融蚀深渊59期4",
    BaseSortID = 847,
    Type = 21,
    Name = "StageGroup_80918_Name|第4波",
    TypeText = "StageGroup_80918_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80917] = {
    ID = 80917,
    CnID = "关卡组@融蚀深渊59期5",
    BaseSortID = 848,
    Type = 21,
    Name = "StageGroup_80917_Name|第5波",
    TypeText = "StageGroup_80917_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80852] = {
    ID = 80852,
    CnID = "关卡组@融蚀深渊60期1",
    BaseSortID = 849,
    Type = 21,
    Name = "StageGroup_80852_Name|第1波",
    TypeText = "StageGroup_80852_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80854] = {
    ID = 80854,
    CnID = "关卡组@融蚀深渊60期2",
    BaseSortID = 850,
    Type = 21,
    Name = "StageGroup_80854_Name|第2波",
    TypeText = "StageGroup_80854_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80853] = {
    ID = 80853,
    CnID = "关卡组@融蚀深渊60期3",
    BaseSortID = 851,
    Type = 21,
    Name = "StageGroup_80853_Name|第3波",
    TypeText = "StageGroup_80853_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80856] = {
    ID = 80856,
    CnID = "关卡组@融蚀深渊60期4",
    BaseSortID = 852,
    Type = 21,
    Name = "StageGroup_80856_Name|第4波",
    TypeText = "StageGroup_80856_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80855] = {
    ID = 80855,
    CnID = "关卡组@融蚀深渊60期5",
    BaseSortID = 853,
    Type = 21,
    Name = "StageGroup_80855_Name|第5波",
    TypeText = "StageGroup_80855_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80857] = {
    ID = 80857,
    CnID = "关卡组@融蚀深渊61期1",
    BaseSortID = 854,
    Type = 21,
    Name = "StageGroup_80857_Name|第1波",
    TypeText = "StageGroup_80857_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80858] = {
    ID = 80858,
    CnID = "关卡组@融蚀深渊61期2",
    BaseSortID = 855,
    Type = 21,
    Name = "StageGroup_80858_Name|第2波",
    TypeText = "StageGroup_80858_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80859] = {
    ID = 80859,
    CnID = "关卡组@融蚀深渊61期3",
    BaseSortID = 856,
    Type = 21,
    Name = "StageGroup_80859_Name|第3波",
    TypeText = "StageGroup_80859_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80860] = {
    ID = 80860,
    CnID = "关卡组@融蚀深渊61期4",
    BaseSortID = 857,
    Type = 21,
    Name = "StageGroup_80860_Name|第4波",
    TypeText = "StageGroup_80860_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80861] = {
    ID = 80861,
    CnID = "关卡组@融蚀深渊61期5",
    BaseSortID = 858,
    Type = 21,
    Name = "StageGroup_80861_Name|第5波",
    TypeText = "StageGroup_80861_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80867] = {
    ID = 80867,
    CnID = "关卡组@融蚀深渊62期1",
    BaseSortID = 859,
    Type = 21,
    Name = "StageGroup_80867_Name|第1波",
    TypeText = "StageGroup_80867_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80866] = {
    ID = 80866,
    CnID = "关卡组@融蚀深渊62期2",
    BaseSortID = 860,
    Type = 21,
    Name = "StageGroup_80866_Name|第2波",
    TypeText = "StageGroup_80866_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80865] = {
    ID = 80865,
    CnID = "关卡组@融蚀深渊62期3",
    BaseSortID = 861,
    Type = 21,
    Name = "StageGroup_80865_Name|第3波",
    TypeText = "StageGroup_80865_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80864] = {
    ID = 80864,
    CnID = "关卡组@融蚀深渊62期4",
    BaseSortID = 862,
    Type = 21,
    Name = "StageGroup_80864_Name|第4波",
    TypeText = "StageGroup_80864_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80863] = {
    ID = 80863,
    CnID = "关卡组@融蚀深渊62期5",
    BaseSortID = 863,
    Type = 21,
    Name = "StageGroup_80863_Name|第5波",
    TypeText = "StageGroup_80863_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80872] = {
    ID = 80872,
    CnID = "关卡组@融蚀深渊63期1",
    BaseSortID = 864,
    Type = 21,
    Name = "StageGroup_80872_Name|第1波",
    TypeText = "StageGroup_80872_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80870] = {
    ID = 80870,
    CnID = "关卡组@融蚀深渊63期2",
    BaseSortID = 865,
    Type = 21,
    Name = "StageGroup_80870_Name|第2波",
    TypeText = "StageGroup_80870_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80871] = {
    ID = 80871,
    CnID = "关卡组@融蚀深渊63期3",
    BaseSortID = 866,
    Type = 21,
    Name = "StageGroup_80871_Name|第3波",
    TypeText = "StageGroup_80871_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80868] = {
    ID = 80868,
    CnID = "关卡组@融蚀深渊63期4",
    BaseSortID = 867,
    Type = 21,
    Name = "StageGroup_80868_Name|第4波",
    TypeText = "StageGroup_80868_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80869] = {
    ID = 80869,
    CnID = "关卡组@融蚀深渊63期5",
    BaseSortID = 868,
    Type = 21,
    Name = "StageGroup_80869_Name|第5波",
    TypeText = "StageGroup_80869_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80838] = {
    ID = 80838,
    CnID = "关卡组@融蚀深渊64期1",
    BaseSortID = 869,
    Type = 21,
    Name = "StageGroup_80838_Name|第1波",
    TypeText = "StageGroup_80838_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80840] = {
    ID = 80840,
    CnID = "关卡组@融蚀深渊64期2",
    BaseSortID = 870,
    Type = 21,
    Name = "StageGroup_80840_Name|第2波",
    TypeText = "StageGroup_80840_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80839] = {
    ID = 80839,
    CnID = "关卡组@融蚀深渊64期3",
    BaseSortID = 871,
    Type = 21,
    Name = "StageGroup_80839_Name|第3波",
    TypeText = "StageGroup_80839_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80836] = {
    ID = 80836,
    CnID = "关卡组@融蚀深渊64期4",
    BaseSortID = 872,
    Type = 21,
    Name = "StageGroup_80836_Name|第4波",
    TypeText = "StageGroup_80836_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80835] = {
    ID = 80835,
    CnID = "关卡组@融蚀深渊64期5",
    BaseSortID = 873,
    Type = 21,
    Name = "StageGroup_80835_Name|第5波",
    TypeText = "StageGroup_80835_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80843] = {
    ID = 80843,
    CnID = "关卡组@融蚀深渊65期1",
    BaseSortID = 874,
    Type = 21,
    Name = "StageGroup_80843_Name|第1波",
    TypeText = "StageGroup_80843_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80844] = {
    ID = 80844,
    CnID = "关卡组@融蚀深渊65期2",
    BaseSortID = 875,
    Type = 21,
    Name = "StageGroup_80844_Name|第2波",
    TypeText = "StageGroup_80844_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80889] = {
    ID = 80889,
    CnID = "关卡组@融蚀深渊65期3",
    BaseSortID = 876,
    Type = 21,
    Name = "StageGroup_80889_Name|第3波",
    TypeText = "StageGroup_80889_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80841] = {
    ID = 80841,
    CnID = "关卡组@融蚀深渊65期4",
    BaseSortID = 877,
    Type = 21,
    Name = "StageGroup_80841_Name|第4波",
    TypeText = "StageGroup_80841_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [80888] = {
    ID = 80888,
    CnID = "关卡组@融蚀深渊65期5",
    BaseSortID = 878,
    Type = 21,
    Name = "StageGroup_80888_Name|第5波",
    TypeText = "StageGroup_80888_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83381] = {
    ID = 83381,
    CnID = "关卡组@融蚀深渊66期1",
    BaseSortID = 879,
    Type = 21,
    Name = "StageGroup_83381_Name|第1波",
    TypeText = "StageGroup_83381_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83380] = {
    ID = 83380,
    CnID = "关卡组@融蚀深渊66期2",
    BaseSortID = 880,
    Type = 21,
    Name = "StageGroup_83380_Name|第2波",
    TypeText = "StageGroup_83380_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83379] = {
    ID = 83379,
    CnID = "关卡组@融蚀深渊66期3",
    BaseSortID = 881,
    Type = 21,
    Name = "StageGroup_83379_Name|第3波",
    TypeText = "StageGroup_83379_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83383] = {
    ID = 83383,
    CnID = "关卡组@融蚀深渊66期4",
    BaseSortID = 882,
    Type = 21,
    Name = "StageGroup_83383_Name|第4波",
    TypeText = "StageGroup_83383_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83382] = {
    ID = 83382,
    CnID = "关卡组@融蚀深渊66期5",
    BaseSortID = 883,
    Type = 21,
    Name = "StageGroup_83382_Name|第5波",
    TypeText = "StageGroup_83382_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83386] = {
    ID = 83386,
    CnID = "关卡组@融蚀深渊67期1",
    BaseSortID = 884,
    Type = 21,
    Name = "StageGroup_83386_Name|第1波",
    TypeText = "StageGroup_83386_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83384] = {
    ID = 83384,
    CnID = "关卡组@融蚀深渊67期2",
    BaseSortID = 885,
    Type = 21,
    Name = "StageGroup_83384_Name|第2波",
    TypeText = "StageGroup_83384_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83385] = {
    ID = 83385,
    CnID = "关卡组@融蚀深渊67期3",
    BaseSortID = 886,
    Type = 21,
    Name = "StageGroup_83385_Name|第3波",
    TypeText = "StageGroup_83385_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83387] = {
    ID = 83387,
    CnID = "关卡组@融蚀深渊67期4",
    BaseSortID = 887,
    Type = 21,
    Name = "StageGroup_83387_Name|第4波",
    TypeText = "StageGroup_83387_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83388] = {
    ID = 83388,
    CnID = "关卡组@融蚀深渊67期5",
    BaseSortID = 888,
    Type = 21,
    Name = "StageGroup_83388_Name|第5波",
    TypeText = "StageGroup_83388_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83389] = {
    ID = 83389,
    CnID = "关卡组@融蚀深渊68期1",
    BaseSortID = 889,
    Type = 21,
    Name = "StageGroup_83389_Name|第1波",
    TypeText = "StageGroup_83389_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83391] = {
    ID = 83391,
    CnID = "关卡组@融蚀深渊68期2",
    BaseSortID = 890,
    Type = 21,
    Name = "StageGroup_83391_Name|第2波",
    TypeText = "StageGroup_83391_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83390] = {
    ID = 83390,
    CnID = "关卡组@融蚀深渊68期3",
    BaseSortID = 891,
    Type = 21,
    Name = "StageGroup_83390_Name|第3波",
    TypeText = "StageGroup_83390_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83393] = {
    ID = 83393,
    CnID = "关卡组@融蚀深渊68期4",
    BaseSortID = 892,
    Type = 21,
    Name = "StageGroup_83393_Name|第4波",
    TypeText = "StageGroup_83393_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83392] = {
    ID = 83392,
    CnID = "关卡组@融蚀深渊68期5",
    BaseSortID = 893,
    Type = 21,
    Name = "StageGroup_83392_Name|第5波",
    TypeText = "StageGroup_83392_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83394] = {
    ID = 83394,
    CnID = "关卡组@融蚀深渊69期1",
    BaseSortID = 894,
    Type = 21,
    Name = "StageGroup_83394_Name|第1波",
    TypeText = "StageGroup_83394_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83395] = {
    ID = 83395,
    CnID = "关卡组@融蚀深渊69期2",
    BaseSortID = 895,
    Type = 21,
    Name = "StageGroup_83395_Name|第2波",
    TypeText = "StageGroup_83395_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83396] = {
    ID = 83396,
    CnID = "关卡组@融蚀深渊69期3",
    BaseSortID = 896,
    Type = 21,
    Name = "StageGroup_83396_Name|第3波",
    TypeText = "StageGroup_83396_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83397] = {
    ID = 83397,
    CnID = "关卡组@融蚀深渊69期4",
    BaseSortID = 897,
    Type = 21,
    Name = "StageGroup_83397_Name|第4波",
    TypeText = "StageGroup_83397_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83398] = {
    ID = 83398,
    CnID = "关卡组@融蚀深渊69期5",
    BaseSortID = 898,
    Type = 21,
    Name = "StageGroup_83398_Name|第5波",
    TypeText = "StageGroup_83398_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83444] = {
    ID = 83444,
    CnID = "关卡组@融蚀深渊70期1",
    BaseSortID = 899,
    Type = 21,
    Name = "StageGroup_83444_Name|第1波",
    TypeText = "StageGroup_83444_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83441] = {
    ID = 83441,
    CnID = "关卡组@融蚀深渊70期2",
    BaseSortID = 900,
    Type = 21,
    Name = "StageGroup_83441_Name|第2波",
    TypeText = "StageGroup_83441_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83442] = {
    ID = 83442,
    CnID = "关卡组@融蚀深渊70期3",
    BaseSortID = 901,
    Type = 21,
    Name = "StageGroup_83442_Name|第3波",
    TypeText = "StageGroup_83442_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83439] = {
    ID = 83439,
    CnID = "关卡组@融蚀深渊70期4",
    BaseSortID = 902,
    Type = 21,
    Name = "StageGroup_83439_Name|第4波",
    TypeText = "StageGroup_83439_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83440] = {
    ID = 83440,
    CnID = "关卡组@融蚀深渊70期5",
    BaseSortID = 903,
    Type = 21,
    Name = "StageGroup_83440_Name|第5波",
    TypeText = "StageGroup_83440_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83438] = {
    ID = 83438,
    CnID = "关卡组@融蚀深渊71期1",
    BaseSortID = 904,
    Type = 21,
    Name = "StageGroup_83438_Name|第1波",
    TypeText = "StageGroup_83438_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83437] = {
    ID = 83437,
    CnID = "关卡组@融蚀深渊71期2",
    BaseSortID = 905,
    Type = 21,
    Name = "StageGroup_83437_Name|第2波",
    TypeText = "StageGroup_83437_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83436] = {
    ID = 83436,
    CnID = "关卡组@融蚀深渊71期3",
    BaseSortID = 906,
    Type = 21,
    Name = "StageGroup_83436_Name|第3波",
    TypeText = "StageGroup_83436_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83435] = {
    ID = 83435,
    CnID = "关卡组@融蚀深渊71期4",
    BaseSortID = 907,
    Type = 21,
    Name = "StageGroup_83435_Name|第4波",
    TypeText = "StageGroup_83435_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83434] = {
    ID = 83434,
    CnID = "关卡组@融蚀深渊71期5",
    BaseSortID = 908,
    Type = 21,
    Name = "StageGroup_83434_Name|第5波",
    TypeText = "StageGroup_83434_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83429] = {
    ID = 83429,
    CnID = "关卡组@融蚀深渊72期1",
    BaseSortID = 909,
    Type = 21,
    Name = "StageGroup_83429_Name|第1波",
    TypeText = "StageGroup_83429_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83430] = {
    ID = 83430,
    CnID = "关卡组@融蚀深渊72期2",
    BaseSortID = 910,
    Type = 21,
    Name = "StageGroup_83430_Name|第2波",
    TypeText = "StageGroup_83430_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83431] = {
    ID = 83431,
    CnID = "关卡组@融蚀深渊72期3",
    BaseSortID = 911,
    Type = 21,
    Name = "StageGroup_83431_Name|第3波",
    TypeText = "StageGroup_83431_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83432] = {
    ID = 83432,
    CnID = "关卡组@融蚀深渊72期4",
    BaseSortID = 912,
    Type = 21,
    Name = "StageGroup_83432_Name|第4波",
    TypeText = "StageGroup_83432_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83433] = {
    ID = 83433,
    CnID = "关卡组@融蚀深渊72期5",
    BaseSortID = 913,
    Type = 21,
    Name = "StageGroup_83433_Name|第5波",
    TypeText = "StageGroup_83433_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83424] = {
    ID = 83424,
    CnID = "关卡组@融蚀深渊73期1",
    BaseSortID = 914,
    Type = 21,
    Name = "StageGroup_83424_Name|第1波",
    TypeText = "StageGroup_83424_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83426] = {
    ID = 83426,
    CnID = "关卡组@融蚀深渊73期2",
    BaseSortID = 915,
    Type = 21,
    Name = "StageGroup_83426_Name|第2波",
    TypeText = "StageGroup_83426_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83425] = {
    ID = 83425,
    CnID = "关卡组@融蚀深渊73期3",
    BaseSortID = 916,
    Type = 21,
    Name = "StageGroup_83425_Name|第3波",
    TypeText = "StageGroup_83425_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83428] = {
    ID = 83428,
    CnID = "关卡组@融蚀深渊73期4",
    BaseSortID = 917,
    Type = 21,
    Name = "StageGroup_83428_Name|第4波",
    TypeText = "StageGroup_83428_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83427] = {
    ID = 83427,
    CnID = "关卡组@融蚀深渊73期5",
    BaseSortID = 918,
    Type = 21,
    Name = "StageGroup_83427_Name|第5波",
    TypeText = "StageGroup_83427_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83416] = {
    ID = 83416,
    CnID = "关卡组@融蚀深渊74期1",
    BaseSortID = 919,
    Type = 21,
    Name = "StageGroup_83416_Name|第1波",
    TypeText = "StageGroup_83416_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83414] = {
    ID = 83414,
    CnID = "关卡组@融蚀深渊74期2",
    BaseSortID = 920,
    Type = 21,
    Name = "StageGroup_83414_Name|第2波",
    TypeText = "StageGroup_83414_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83415] = {
    ID = 83415,
    CnID = "关卡组@融蚀深渊74期3",
    BaseSortID = 921,
    Type = 21,
    Name = "StageGroup_83415_Name|第3波",
    TypeText = "StageGroup_83415_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83417] = {
    ID = 83417,
    CnID = "关卡组@融蚀深渊74期4",
    BaseSortID = 922,
    Type = 21,
    Name = "StageGroup_83417_Name|第4波",
    TypeText = "StageGroup_83417_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83418] = {
    ID = 83418,
    CnID = "关卡组@融蚀深渊74期5",
    BaseSortID = 923,
    Type = 21,
    Name = "StageGroup_83418_Name|第5波",
    TypeText = "StageGroup_83418_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83411] = {
    ID = 83411,
    CnID = "关卡组@融蚀深渊75期1",
    BaseSortID = 924,
    Type = 21,
    Name = "StageGroup_83411_Name|第1波",
    TypeText = "StageGroup_83411_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83410] = {
    ID = 83410,
    CnID = "关卡组@融蚀深渊75期2",
    BaseSortID = 925,
    Type = 21,
    Name = "StageGroup_83410_Name|第2波",
    TypeText = "StageGroup_83410_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83409] = {
    ID = 83409,
    CnID = "关卡组@融蚀深渊75期3",
    BaseSortID = 926,
    Type = 21,
    Name = "StageGroup_83409_Name|第3波",
    TypeText = "StageGroup_83409_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83413] = {
    ID = 83413,
    CnID = "关卡组@融蚀深渊75期4",
    BaseSortID = 927,
    Type = 21,
    Name = "StageGroup_83413_Name|第4波",
    TypeText = "StageGroup_83413_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83412] = {
    ID = 83412,
    CnID = "关卡组@融蚀深渊75期5",
    BaseSortID = 928,
    Type = 21,
    Name = "StageGroup_83412_Name|第5波",
    TypeText = "StageGroup_83412_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83406] = {
    ID = 83406,
    CnID = "关卡组@融蚀深渊76期1",
    BaseSortID = 929,
    Type = 21,
    Name = "StageGroup_83406_Name|第1波",
    TypeText = "StageGroup_83406_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83407] = {
    ID = 83407,
    CnID = "关卡组@融蚀深渊76期2",
    BaseSortID = 930,
    Type = 21,
    Name = "StageGroup_83407_Name|第2波",
    TypeText = "StageGroup_83407_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83408] = {
    ID = 83408,
    CnID = "关卡组@融蚀深渊76期3",
    BaseSortID = 931,
    Type = 21,
    Name = "StageGroup_83408_Name|第3波",
    TypeText = "StageGroup_83408_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83404] = {
    ID = 83404,
    CnID = "关卡组@融蚀深渊76期4",
    BaseSortID = 932,
    Type = 21,
    Name = "StageGroup_83404_Name|第4波",
    TypeText = "StageGroup_83404_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83405] = {
    ID = 83405,
    CnID = "关卡组@融蚀深渊76期5",
    BaseSortID = 933,
    Type = 21,
    Name = "StageGroup_83405_Name|第5波",
    TypeText = "StageGroup_83405_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83401] = {
    ID = 83401,
    CnID = "关卡组@融蚀深渊77期1",
    BaseSortID = 934,
    Type = 21,
    Name = "StageGroup_83401_Name|第1波",
    TypeText = "StageGroup_83401_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83403] = {
    ID = 83403,
    CnID = "关卡组@融蚀深渊77期2",
    BaseSortID = 935,
    Type = 21,
    Name = "StageGroup_83403_Name|第2波",
    TypeText = "StageGroup_83403_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83402] = {
    ID = 83402,
    CnID = "关卡组@融蚀深渊77期3",
    BaseSortID = 936,
    Type = 21,
    Name = "StageGroup_83402_Name|第3波",
    TypeText = "StageGroup_83402_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83400] = {
    ID = 83400,
    CnID = "关卡组@融蚀深渊77期4",
    BaseSortID = 937,
    Type = 21,
    Name = "StageGroup_83400_Name|第4波",
    TypeText = "StageGroup_83400_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83399] = {
    ID = 83399,
    CnID = "关卡组@融蚀深渊77期5",
    BaseSortID = 938,
    Type = 21,
    Name = "StageGroup_83399_Name|第5波",
    TypeText = "StageGroup_83399_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83449] = {
    ID = 83449,
    CnID = "关卡组@融蚀深渊78期1",
    BaseSortID = 939,
    Type = 21,
    Name = "StageGroup_83449_Name|第1波",
    TypeText = "StageGroup_83449_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83447] = {
    ID = 83447,
    CnID = "关卡组@融蚀深渊78期2",
    BaseSortID = 940,
    Type = 21,
    Name = "StageGroup_83447_Name|第2波",
    TypeText = "StageGroup_83447_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83448] = {
    ID = 83448,
    CnID = "关卡组@融蚀深渊78期3",
    BaseSortID = 941,
    Type = 21,
    Name = "StageGroup_83448_Name|第3波",
    TypeText = "StageGroup_83448_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83445] = {
    ID = 83445,
    CnID = "关卡组@融蚀深渊78期4",
    BaseSortID = 942,
    Type = 21,
    Name = "StageGroup_83445_Name|第4波",
    TypeText = "StageGroup_83445_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83446] = {
    ID = 83446,
    CnID = "关卡组@融蚀深渊78期5",
    BaseSortID = 943,
    Type = 21,
    Name = "StageGroup_83446_Name|第5波",
    TypeText = "StageGroup_83446_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83423] = {
    ID = 83423,
    CnID = "关卡组@融蚀深渊79期1",
    BaseSortID = 944,
    Type = 21,
    Name = "StageGroup_83423_Name|第1波",
    TypeText = "StageGroup_83423_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83422] = {
    ID = 83422,
    CnID = "关卡组@融蚀深渊79期2",
    BaseSortID = 945,
    Type = 21,
    Name = "StageGroup_83422_Name|第2波",
    TypeText = "StageGroup_83422_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83421] = {
    ID = 83421,
    CnID = "关卡组@融蚀深渊79期3",
    BaseSortID = 946,
    Type = 21,
    Name = "StageGroup_83421_Name|第3波",
    TypeText = "StageGroup_83421_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83420] = {
    ID = 83420,
    CnID = "关卡组@融蚀深渊79期4",
    BaseSortID = 947,
    Type = 21,
    Name = "StageGroup_83420_Name|第4波",
    TypeText = "StageGroup_83420_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83419] = {
    ID = 83419,
    CnID = "关卡组@融蚀深渊79期5",
    BaseSortID = 948,
    Type = 21,
    Name = "StageGroup_83419_Name|第5波",
    TypeText = "StageGroup_83419_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83464] = {
    ID = 83464,
    CnID = "关卡组@融蚀深渊80期1",
    BaseSortID = 949,
    Type = 21,
    Name = "StageGroup_83464_Name|第1波",
    TypeText = "StageGroup_83464_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83463] = {
    ID = 83463,
    CnID = "关卡组@融蚀深渊80期2",
    BaseSortID = 950,
    Type = 21,
    Name = "StageGroup_83463_Name|第2波",
    TypeText = "StageGroup_83463_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83462] = {
    ID = 83462,
    CnID = "关卡组@融蚀深渊80期3",
    BaseSortID = 951,
    Type = 21,
    Name = "StageGroup_83462_Name|第3波",
    TypeText = "StageGroup_83462_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83461] = {
    ID = 83461,
    CnID = "关卡组@融蚀深渊80期4",
    BaseSortID = 952,
    Type = 21,
    Name = "StageGroup_83461_Name|第4波",
    TypeText = "StageGroup_83461_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83460] = {
    ID = 83460,
    CnID = "关卡组@融蚀深渊80期5",
    BaseSortID = 953,
    Type = 21,
    Name = "StageGroup_83460_Name|第5波",
    TypeText = "StageGroup_83460_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83353] = {
    ID = 83353,
    CnID = "关卡组@融蚀深渊81期1",
    BaseSortID = 954,
    Type = 21,
    Name = "StageGroup_83353_Name|第1波",
    TypeText = "StageGroup_83353_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83351] = {
    ID = 83351,
    CnID = "关卡组@融蚀深渊81期2",
    BaseSortID = 955,
    Type = 21,
    Name = "StageGroup_83351_Name|第2波",
    TypeText = "StageGroup_83351_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83352] = {
    ID = 83352,
    CnID = "关卡组@融蚀深渊81期3",
    BaseSortID = 956,
    Type = 21,
    Name = "StageGroup_83352_Name|第3波",
    TypeText = "StageGroup_83352_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83349] = {
    ID = 83349,
    CnID = "关卡组@融蚀深渊81期4",
    BaseSortID = 957,
    Type = 21,
    Name = "StageGroup_83349_Name|第4波",
    TypeText = "StageGroup_83349_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83350] = {
    ID = 83350,
    CnID = "关卡组@融蚀深渊81期5",
    BaseSortID = 958,
    Type = 21,
    Name = "StageGroup_83350_Name|第5波",
    TypeText = "StageGroup_83350_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83450] = {
    ID = 83450,
    CnID = "关卡组@融蚀深渊82期1",
    BaseSortID = 959,
    Type = 21,
    Name = "StageGroup_83450_Name|第1波",
    TypeText = "StageGroup_83450_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83452] = {
    ID = 83452,
    CnID = "关卡组@融蚀深渊82期2",
    BaseSortID = 960,
    Type = 21,
    Name = "StageGroup_83452_Name|第2波",
    TypeText = "StageGroup_83452_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83451] = {
    ID = 83451,
    CnID = "关卡组@融蚀深渊82期3",
    BaseSortID = 961,
    Type = 21,
    Name = "StageGroup_83451_Name|第3波",
    TypeText = "StageGroup_83451_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83454] = {
    ID = 83454,
    CnID = "关卡组@融蚀深渊82期4",
    BaseSortID = 962,
    Type = 21,
    Name = "StageGroup_83454_Name|第4波",
    TypeText = "StageGroup_83454_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83453] = {
    ID = 83453,
    CnID = "关卡组@融蚀深渊82期5",
    BaseSortID = 963,
    Type = 21,
    Name = "StageGroup_83453_Name|第5波",
    TypeText = "StageGroup_83453_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83455] = {
    ID = 83455,
    CnID = "关卡组@融蚀深渊83期1",
    BaseSortID = 964,
    Type = 21,
    Name = "StageGroup_83455_Name|第1波",
    TypeText = "StageGroup_83455_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83456] = {
    ID = 83456,
    CnID = "关卡组@融蚀深渊83期2",
    BaseSortID = 965,
    Type = 21,
    Name = "StageGroup_83456_Name|第2波",
    TypeText = "StageGroup_83456_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83457] = {
    ID = 83457,
    CnID = "关卡组@融蚀深渊83期3",
    BaseSortID = 966,
    Type = 21,
    Name = "StageGroup_83457_Name|第3波",
    TypeText = "StageGroup_83457_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83458] = {
    ID = 83458,
    CnID = "关卡组@融蚀深渊83期4",
    BaseSortID = 967,
    Type = 21,
    Name = "StageGroup_83458_Name|第4波",
    TypeText = "StageGroup_83458_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83459] = {
    ID = 83459,
    CnID = "关卡组@融蚀深渊83期5",
    BaseSortID = 968,
    Type = 21,
    Name = "StageGroup_83459_Name|第5波",
    TypeText = "StageGroup_83459_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83491] = {
    ID = 83491,
    CnID = "关卡组@融蚀深渊84期1",
    BaseSortID = 969,
    Type = 21,
    Name = "StageGroup_83491_Name|第1波",
    TypeText = "StageGroup_83491_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83490] = {
    ID = 83490,
    CnID = "关卡组@融蚀深渊84期2",
    BaseSortID = 970,
    Type = 21,
    Name = "StageGroup_83490_Name|第2波",
    TypeText = "StageGroup_83490_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83489] = {
    ID = 83489,
    CnID = "关卡组@融蚀深渊84期3",
    BaseSortID = 971,
    Type = 21,
    Name = "StageGroup_83489_Name|第3波",
    TypeText = "StageGroup_83489_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83493] = {
    ID = 83493,
    CnID = "关卡组@融蚀深渊84期4",
    BaseSortID = 972,
    Type = 21,
    Name = "StageGroup_83493_Name|第4波",
    TypeText = "StageGroup_83493_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83492] = {
    ID = 83492,
    CnID = "关卡组@融蚀深渊84期5",
    BaseSortID = 973,
    Type = 21,
    Name = "StageGroup_83492_Name|第5波",
    TypeText = "StageGroup_83492_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83496] = {
    ID = 83496,
    CnID = "关卡组@融蚀深渊85期1",
    BaseSortID = 974,
    Type = 21,
    Name = "StageGroup_83496_Name|第1波",
    TypeText = "StageGroup_83496_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83494] = {
    ID = 83494,
    CnID = "关卡组@融蚀深渊85期2",
    BaseSortID = 975,
    Type = 21,
    Name = "StageGroup_83494_Name|第2波",
    TypeText = "StageGroup_83494_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83495] = {
    ID = 83495,
    CnID = "关卡组@融蚀深渊85期3",
    BaseSortID = 976,
    Type = 21,
    Name = "StageGroup_83495_Name|第3波",
    TypeText = "StageGroup_83495_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83497] = {
    ID = 83497,
    CnID = "关卡组@融蚀深渊85期4",
    BaseSortID = 977,
    Type = 21,
    Name = "StageGroup_83497_Name|第4波",
    TypeText = "StageGroup_83497_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83498] = {
    ID = 83498,
    CnID = "关卡组@融蚀深渊85期5",
    BaseSortID = 978,
    Type = 21,
    Name = "StageGroup_83498_Name|第5波",
    TypeText = "StageGroup_83498_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83356] = {
    ID = 83356,
    CnID = "关卡组@融蚀深渊86期1",
    BaseSortID = 979,
    Type = 21,
    Name = "StageGroup_83356_Name|第1波",
    TypeText = "StageGroup_83356_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83358] = {
    ID = 83358,
    CnID = "关卡组@融蚀深渊86期2",
    BaseSortID = 980,
    Type = 21,
    Name = "StageGroup_83358_Name|第2波",
    TypeText = "StageGroup_83358_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83357] = {
    ID = 83357,
    CnID = "关卡组@融蚀深渊86期3",
    BaseSortID = 981,
    Type = 21,
    Name = "StageGroup_83357_Name|第3波",
    TypeText = "StageGroup_83357_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83355] = {
    ID = 83355,
    CnID = "关卡组@融蚀深渊86期4",
    BaseSortID = 982,
    Type = 21,
    Name = "StageGroup_83355_Name|第4波",
    TypeText = "StageGroup_83355_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83354] = {
    ID = 83354,
    CnID = "关卡组@融蚀深渊86期5",
    BaseSortID = 983,
    Type = 21,
    Name = "StageGroup_83354_Name|第5波",
    TypeText = "StageGroup_83354_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83361] = {
    ID = 83361,
    CnID = "关卡组@融蚀深渊87期1",
    BaseSortID = 984,
    Type = 21,
    Name = "StageGroup_83361_Name|第1波",
    TypeText = "StageGroup_83361_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83362] = {
    ID = 83362,
    CnID = "关卡组@融蚀深渊87期2",
    BaseSortID = 985,
    Type = 21,
    Name = "StageGroup_83362_Name|第2波",
    TypeText = "StageGroup_83362_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83363] = {
    ID = 83363,
    CnID = "关卡组@融蚀深渊87期3",
    BaseSortID = 986,
    Type = 21,
    Name = "StageGroup_83363_Name|第3波",
    TypeText = "StageGroup_83363_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83359] = {
    ID = 83359,
    CnID = "关卡组@融蚀深渊87期4",
    BaseSortID = 987,
    Type = 21,
    Name = "StageGroup_83359_Name|第4波",
    TypeText = "StageGroup_83359_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83360] = {
    ID = 83360,
    CnID = "关卡组@融蚀深渊87期5",
    BaseSortID = 988,
    Type = 21,
    Name = "StageGroup_83360_Name|第5波",
    TypeText = "StageGroup_83360_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83479] = {
    ID = 83479,
    CnID = "关卡组@融蚀深渊88期1",
    BaseSortID = 989,
    Type = 21,
    Name = "StageGroup_83479_Name|第1波",
    TypeText = "StageGroup_83479_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83468] = {
    ID = 83468,
    CnID = "关卡组@融蚀深渊88期2",
    BaseSortID = 990,
    Type = 21,
    Name = "StageGroup_83468_Name|第2波",
    TypeText = "StageGroup_83468_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83467] = {
    ID = 83467,
    CnID = "关卡组@融蚀深渊88期3",
    BaseSortID = 991,
    Type = 21,
    Name = "StageGroup_83467_Name|第3波",
    TypeText = "StageGroup_83467_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83466] = {
    ID = 83466,
    CnID = "关卡组@融蚀深渊88期4",
    BaseSortID = 992,
    Type = 21,
    Name = "StageGroup_83466_Name|第4波",
    TypeText = "StageGroup_83466_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83465] = {
    ID = 83465,
    CnID = "关卡组@融蚀深渊88期5",
    BaseSortID = 993,
    Type = 21,
    Name = "StageGroup_83465_Name|第5波",
    TypeText = "StageGroup_83465_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83485] = {
    ID = 83485,
    CnID = "关卡组@融蚀深渊89期1",
    BaseSortID = 994,
    Type = 21,
    Name = "StageGroup_83485_Name|第1波",
    TypeText = "StageGroup_83485_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83482] = {
    ID = 83482,
    CnID = "关卡组@融蚀深渊89期2",
    BaseSortID = 995,
    Type = 21,
    Name = "StageGroup_83482_Name|第2波",
    TypeText = "StageGroup_83482_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83483] = {
    ID = 83483,
    CnID = "关卡组@融蚀深渊89期3",
    BaseSortID = 996,
    Type = 21,
    Name = "StageGroup_83483_Name|第3波",
    TypeText = "StageGroup_83483_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83480] = {
    ID = 83480,
    CnID = "关卡组@融蚀深渊89期4",
    BaseSortID = 997,
    Type = 21,
    Name = "StageGroup_83480_Name|第4波",
    TypeText = "StageGroup_83480_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83481] = {
    ID = 83481,
    CnID = "关卡组@融蚀深渊89期5",
    BaseSortID = 998,
    Type = 21,
    Name = "StageGroup_83481_Name|第5波",
    TypeText = "StageGroup_83481_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83376] = {
    ID = 83376,
    CnID = "关卡组@融蚀深渊90期1",
    BaseSortID = 999,
    Type = 21,
    Name = "StageGroup_83376_Name|第1波",
    TypeText = "StageGroup_83376_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83377] = {
    ID = 83377,
    CnID = "关卡组@融蚀深渊90期2",
    BaseSortID = 1000,
    Type = 21,
    Name = "StageGroup_83377_Name|第2波",
    TypeText = "StageGroup_83377_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83378] = {
    ID = 83378,
    CnID = "关卡组@融蚀深渊90期3",
    BaseSortID = 1001,
    Type = 21,
    Name = "StageGroup_83378_Name|第3波",
    TypeText = "StageGroup_83378_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83374] = {
    ID = 83374,
    CnID = "关卡组@融蚀深渊90期4",
    BaseSortID = 1002,
    Type = 21,
    Name = "StageGroup_83374_Name|第4波",
    TypeText = "StageGroup_83374_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83375] = {
    ID = 83375,
    CnID = "关卡组@融蚀深渊90期5",
    BaseSortID = 1003,
    Type = 21,
    Name = "StageGroup_83375_Name|第5波",
    TypeText = "StageGroup_83375_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83371] = {
    ID = 83371,
    CnID = "关卡组@融蚀深渊91期1",
    BaseSortID = 1004,
    Type = 21,
    Name = "StageGroup_83371_Name|第1波",
    TypeText = "StageGroup_83371_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83373] = {
    ID = 83373,
    CnID = "关卡组@融蚀深渊91期2",
    BaseSortID = 1005,
    Type = 21,
    Name = "StageGroup_83373_Name|第2波",
    TypeText = "StageGroup_83373_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83372] = {
    ID = 83372,
    CnID = "关卡组@融蚀深渊91期3",
    BaseSortID = 1006,
    Type = 21,
    Name = "StageGroup_83372_Name|第3波",
    TypeText = "StageGroup_83372_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83370] = {
    ID = 83370,
    CnID = "关卡组@融蚀深渊91期4",
    BaseSortID = 1007,
    Type = 21,
    Name = "StageGroup_83370_Name|第4波",
    TypeText = "StageGroup_83370_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83369] = {
    ID = 83369,
    CnID = "关卡组@融蚀深渊91期5",
    BaseSortID = 1008,
    Type = 21,
    Name = "StageGroup_83369_Name|第5波",
    TypeText = "StageGroup_83369_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83346] = {
    ID = 83346,
    CnID = "关卡组@融蚀深渊92期1",
    BaseSortID = 1009,
    Type = 21,
    Name = "StageGroup_83346_Name|第1波",
    TypeText = "StageGroup_83346_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83344] = {
    ID = 83344,
    CnID = "关卡组@融蚀深渊92期2",
    BaseSortID = 1010,
    Type = 21,
    Name = "StageGroup_83344_Name|第2波",
    TypeText = "StageGroup_83344_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83345] = {
    ID = 83345,
    CnID = "关卡组@融蚀深渊92期3",
    BaseSortID = 1011,
    Type = 21,
    Name = "StageGroup_83345_Name|第3波",
    TypeText = "StageGroup_83345_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83347] = {
    ID = 83347,
    CnID = "关卡组@融蚀深渊92期4",
    BaseSortID = 1012,
    Type = 21,
    Name = "StageGroup_83347_Name|第4波",
    TypeText = "StageGroup_83347_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83348] = {
    ID = 83348,
    CnID = "关卡组@融蚀深渊92期5",
    BaseSortID = 1013,
    Type = 21,
    Name = "StageGroup_83348_Name|第5波",
    TypeText = "StageGroup_83348_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83341] = {
    ID = 83341,
    CnID = "关卡组@融蚀深渊93期1",
    BaseSortID = 1014,
    Type = 21,
    Name = "StageGroup_83341_Name|第1波",
    TypeText = "StageGroup_83341_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83340] = {
    ID = 83340,
    CnID = "关卡组@融蚀深渊93期2",
    BaseSortID = 1015,
    Type = 21,
    Name = "StageGroup_83340_Name|第2波",
    TypeText = "StageGroup_83340_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83339] = {
    ID = 83339,
    CnID = "关卡组@融蚀深渊93期3",
    BaseSortID = 1016,
    Type = 21,
    Name = "StageGroup_83339_Name|第3波",
    TypeText = "StageGroup_83339_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83343] = {
    ID = 83343,
    CnID = "关卡组@融蚀深渊93期4",
    BaseSortID = 1017,
    Type = 21,
    Name = "StageGroup_83343_Name|第4波",
    TypeText = "StageGroup_83343_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83342] = {
    ID = 83342,
    CnID = "关卡组@融蚀深渊93期5",
    BaseSortID = 1018,
    Type = 21,
    Name = "StageGroup_83342_Name|第5波",
    TypeText = "StageGroup_83342_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83474] = {
    ID = 83474,
    CnID = "关卡组@融蚀深渊94期1",
    BaseSortID = 1019,
    Type = 21,
    Name = "StageGroup_83474_Name|第1波",
    TypeText = "StageGroup_83474_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83475] = {
    ID = 83475,
    CnID = "关卡组@融蚀深渊94期2",
    BaseSortID = 1020,
    Type = 21,
    Name = "StageGroup_83475_Name|第2波",
    TypeText = "StageGroup_83475_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83476] = {
    ID = 83476,
    CnID = "关卡组@融蚀深渊94期3",
    BaseSortID = 1021,
    Type = 21,
    Name = "StageGroup_83476_Name|第3波",
    TypeText = "StageGroup_83476_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83477] = {
    ID = 83477,
    CnID = "关卡组@融蚀深渊94期4",
    BaseSortID = 1022,
    Type = 21,
    Name = "StageGroup_83477_Name|第4波",
    TypeText = "StageGroup_83477_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83478] = {
    ID = 83478,
    CnID = "关卡组@融蚀深渊94期5",
    BaseSortID = 1023,
    Type = 21,
    Name = "StageGroup_83478_Name|第5波",
    TypeText = "StageGroup_83478_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83469] = {
    ID = 83469,
    CnID = "关卡组@融蚀深渊95期1",
    BaseSortID = 1024,
    Type = 21,
    Name = "StageGroup_83469_Name|第1波",
    TypeText = "StageGroup_83469_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83471] = {
    ID = 83471,
    CnID = "关卡组@融蚀深渊95期2",
    BaseSortID = 1025,
    Type = 21,
    Name = "StageGroup_83471_Name|第2波",
    TypeText = "StageGroup_83471_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83470] = {
    ID = 83470,
    CnID = "关卡组@融蚀深渊95期3",
    BaseSortID = 1026,
    Type = 21,
    Name = "StageGroup_83470_Name|第3波",
    TypeText = "StageGroup_83470_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83473] = {
    ID = 83473,
    CnID = "关卡组@融蚀深渊95期4",
    BaseSortID = 1027,
    Type = 21,
    Name = "StageGroup_83473_Name|第4波",
    TypeText = "StageGroup_83473_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83472] = {
    ID = 83472,
    CnID = "关卡组@融蚀深渊95期5",
    BaseSortID = 1028,
    Type = 21,
    Name = "StageGroup_83472_Name|第5波",
    TypeText = "StageGroup_83472_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83368] = {
    ID = 83368,
    CnID = "关卡组@融蚀深渊96期1",
    BaseSortID = 1029,
    Type = 21,
    Name = "StageGroup_83368_Name|第1波",
    TypeText = "StageGroup_83368_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83366] = {
    ID = 83366,
    CnID = "关卡组@融蚀深渊96期2",
    BaseSortID = 1030,
    Type = 21,
    Name = "StageGroup_83366_Name|第2波",
    TypeText = "StageGroup_83366_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83367] = {
    ID = 83367,
    CnID = "关卡组@融蚀深渊96期3",
    BaseSortID = 1031,
    Type = 21,
    Name = "StageGroup_83367_Name|第3波",
    TypeText = "StageGroup_83367_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83364] = {
    ID = 83364,
    CnID = "关卡组@融蚀深渊96期4",
    BaseSortID = 1032,
    Type = 21,
    Name = "StageGroup_83364_Name|第4波",
    TypeText = "StageGroup_83364_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83365] = {
    ID = 83365,
    CnID = "关卡组@融蚀深渊96期5",
    BaseSortID = 1033,
    Type = 21,
    Name = "StageGroup_83365_Name|第5波",
    TypeText = "StageGroup_83365_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83484] = {
    ID = 83484,
    CnID = "关卡组@融蚀深渊97期1",
    BaseSortID = 1034,
    Type = 21,
    Name = "StageGroup_83484_Name|第1波",
    TypeText = "StageGroup_83484_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83488] = {
    ID = 83488,
    CnID = "关卡组@融蚀深渊97期2",
    BaseSortID = 1035,
    Type = 21,
    Name = "StageGroup_83488_Name|第2波",
    TypeText = "StageGroup_83488_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83487] = {
    ID = 83487,
    CnID = "关卡组@融蚀深渊97期3",
    BaseSortID = 1036,
    Type = 21,
    Name = "StageGroup_83487_Name|第3波",
    TypeText = "StageGroup_83487_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83486] = {
    ID = 83486,
    CnID = "关卡组@融蚀深渊97期4",
    BaseSortID = 1037,
    Type = 21,
    Name = "StageGroup_83486_Name|第4波",
    TypeText = "StageGroup_83486_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83443] = {
    ID = 83443,
    CnID = "关卡组@融蚀深渊97期5",
    BaseSortID = 1038,
    Type = 21,
    Name = "StageGroup_83443_Name|第5波",
    TypeText = "StageGroup_83443_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83506] = {
    ID = 83506,
    CnID = "关卡组@融蚀深渊98期1",
    BaseSortID = 1039,
    Type = 21,
    Name = "StageGroup_83506_Name|第1波",
    TypeText = "StageGroup_83506_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83507] = {
    ID = 83507,
    CnID = "关卡组@融蚀深渊98期2",
    BaseSortID = 1040,
    Type = 21,
    Name = "StageGroup_83507_Name|第2波",
    TypeText = "StageGroup_83507_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83508] = {
    ID = 83508,
    CnID = "关卡组@融蚀深渊98期3",
    BaseSortID = 1041,
    Type = 21,
    Name = "StageGroup_83508_Name|第3波",
    TypeText = "StageGroup_83508_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83504] = {
    ID = 83504,
    CnID = "关卡组@融蚀深渊98期4",
    BaseSortID = 1042,
    Type = 21,
    Name = "StageGroup_83504_Name|第4波",
    TypeText = "StageGroup_83504_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83505] = {
    ID = 83505,
    CnID = "关卡组@融蚀深渊98期5",
    BaseSortID = 1043,
    Type = 21,
    Name = "StageGroup_83505_Name|第5波",
    TypeText = "StageGroup_83505_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83501] = {
    ID = 83501,
    CnID = "关卡组@融蚀深渊99期1",
    BaseSortID = 1044,
    Type = 21,
    Name = "StageGroup_83501_Name|第1波",
    TypeText = "StageGroup_83501_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83503] = {
    ID = 83503,
    CnID = "关卡组@融蚀深渊99期2",
    BaseSortID = 1045,
    Type = 21,
    Name = "StageGroup_83503_Name|第2波",
    TypeText = "StageGroup_83503_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83502] = {
    ID = 83502,
    CnID = "关卡组@融蚀深渊99期3",
    BaseSortID = 1046,
    Type = 21,
    Name = "StageGroup_83502_Name|第3波",
    TypeText = "StageGroup_83502_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83500] = {
    ID = 83500,
    CnID = "关卡组@融蚀深渊99期4",
    BaseSortID = 1047,
    Type = 21,
    Name = "StageGroup_83500_Name|第4波",
    TypeText = "StageGroup_83500_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [83499] = {
    ID = 83499,
    CnID = "关卡组@融蚀深渊99期5",
    BaseSortID = 1048,
    Type = 21,
    Name = "StageGroup_83499_Name|第5波",
    TypeText = "StageGroup_83499_TypeText|队伍配置-融灾禁区",
    Sequence = 1,
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1
  },
  [129175] = {
    ID = 129175,
    CnID = "关卡组@疾驰的欢愉专列",
    BaseSortID = 1049,
    Type = 201,
    Name = "StageGroup_129175_Name|疾驰的欢愉专列",
    TypeText = "StageGroup_129175_TypeText|疾驰的欢愉专列",
    Sequence = 1,
    BattleBuff = {
      1,
      "ResonanceGroupRailway"
    },
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageDisplayDate = 1770598800,
    BonusTips = {
      "RailWayLevelAdjustmentTips",
      "RailWayLevelAdjustmentTipsTitle",
      "RailWayLevelAdjustmentTipsContent"
    },
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    },
    SaveAndContinue = 168
  },
  [147780] = {
    ID = 147780,
    CnID = "关卡组@疾驰的欢愉专列V2",
    BaseSortID = 1050,
    Type = 201,
    Name = "StageGroup_147780_Name|疾驰的欢愉专列",
    TypeText = "StageGroup_147780_TypeText|疾驰的欢愉专列",
    Sequence = 1,
    BattleBuff = {
      1,
      "ResonanceGroupRailway"
    },
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    BonusTips = {
      "RailWayLevelAdjustmentTips",
      "RailWayLevelAdjustmentTipsTitle",
      "RailWayLevelAdjustmentTipsContent"
    },
    LevelAdjustment = {
      60,
      60,
      5,
      5,
      6,
      5
    },
    SaveAndContinue = 168
  },
  [116435] = {
    ID = 116435,
    CnID = "关卡组@尖塔肉鸽关卡组",
    BaseSortID = 1051,
    Type = 100000000,
    Name = "StageGroup_116435_Name|幻梦深潜",
    TypeText = "StageGroup_116435_TypeText|尖塔肉鸽模式",
    Sequence = 1,
    Backgrand = "Icon/CopyTitle/DailyChallenge1.png",
    StageChapterState = {
      76236,
      74791,
      89559
    },
    StageChapterText = "StageChapterStarsCameRight",
    IsAllUnlock = 1,
    StageGroupDropPreview = {10108}
  },
  [90491] = {
    ID = 90491,
    CnID = "关卡组@战斗教学",
    BaseSortID = 1052,
    Type = 120,
    Name = "StageGroup_90491_Name|战斗训练",
    Sequence = 1,
    Backgrand = "Icon/CopyTitle/GoldCoinStage.png",
    StageChapterText = "StageChapterMorimens",
    IsAllUnlock = 1,
    DailyIcon = {
      "Icon/Dispatch/Icon_Dispatch_Untie_02.png"
    }
  }
})
return StageGroup
