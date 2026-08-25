local System = require("System.System")
local readonly = System.readonly
local AvgRole = readonly({
  [1] = {
    ID = 1,
    CnID = "默认配置",
    BaseSortID = 1
  },
  [1001] = {
    ID = 1001,
    CnID = "玩家",
    BaseSortID = 2,
    RoleName = "AvgRole_1001_RoleName|<Yellow:%player%>",
    Tittle = "AvgRole_1001_Tittle|守密人",
    ShowAsPlayer = 1,
    AwakerResource = "SpChar_PlayerM_NF"
  },
  [1002] = {
    ID = 1002,
    CnID = "护工",
    BaseSortID = 3,
    RoleName = "AvgRole_1002_RoleName|护工",
    Tittle = "AvgRole_1002_Tittle|济贫院护工",
    AwakerResource = "SpChar_Male_NF"
  },
  [1003] = {
    ID = 1003,
    CnID = "女人",
    BaseSortID = 4,
    RoleName = "AvgRole_1003_RoleName|女人",
    AwakerResource = "SpChar_Female_NF"
  },
  [1004] = {
    ID = 1004,
    CnID = "寡妇",
    BaseSortID = 5,
    RoleName = "AvgRole_1004_RoleName|中年女子",
    AwakerResource = "SpChar_LisaMon_NF"
  },
  [1005] = {
    ID = 1005,
    CnID = "碎嘴的女员工",
    BaseSortID = 6,
    RoleName = "AvgRole_1005_RoleName|碎嘴的女员工",
    AwakerResource = "SpChar_Female_NF"
  },
  [1006] = {
    ID = 1006,
    CnID = "苦恼的男员工",
    BaseSortID = 7,
    RoleName = "AvgRole_1006_RoleName|苦恼的男员工",
    AwakerResource = "SpChar_Male_NF"
  },
  [1007] = {
    ID = 1007,
    CnID = "女孩",
    BaseSortID = 8,
    RoleName = "AvgRole_1007_RoleName|女孩",
    AwakerResource = "SpChar_Girl_NF"
  },
  [1008] = {
    ID = 1008,
    CnID = "梅森",
    BaseSortID = 9,
    RoleName = "AvgRole_1008_RoleName|梅森",
    Tittle = "AvgRole_1008_Tittle|「24」",
    AwakerResource = "C06_NF"
  },
  [1009] = {
    ID = 1009,
    CnID = "保安",
    BaseSortID = 10,
    RoleName = "AvgRole_1009_RoleName|保安",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1010] = {
    ID = 1010,
    CnID = "？？",
    BaseSortID = 11,
    RoleName = "AvgRole_1010_RoleName|？？",
    Tittle = "AvgRole_1010_Tittle|白衣女孩",
    AwakerResource = "B03_HF"
  },
  [1011] = {
    ID = 1011,
    CnID = "中年男子",
    BaseSortID = 12,
    RoleName = "AvgRole_1011_RoleName|中年男子",
    AwakerResource = "SpChar_Male_NF"
  },
  [1012] = {
    ID = 1012,
    CnID = "年轻女子",
    BaseSortID = 13,
    RoleName = "AvgRole_1012_RoleName|年轻女子",
    AwakerResource = "SpChar_Female_NF"
  },
  [1013] = {
    ID = 1013,
    CnID = "米勒博士",
    BaseSortID = 14,
    RoleName = "AvgRole_1013_RoleName|米勒博士",
    AwakerResource = "SpChar_Sculptor_NF"
  },
  [1014] = {
    ID = 1014,
    CnID = "研究员",
    BaseSortID = 15,
    RoleName = "AvgRole_1014_RoleName|研究员",
    AwakerResource = "SpChar_SculptorNorm_NF"
  },
  [1015] = {
    ID = 1015,
    CnID = "队长",
    BaseSortID = 16,
    RoleName = "AvgRole_1015_RoleName|队长",
    Tittle = "AvgRole_1015_Tittle|密斯底亚协定审查会第三响应队队长",
    AwakerResource = "SpChar_MTCAgent_NF"
  },
  [1016] = {
    ID = 1016,
    CnID = "孩子",
    BaseSortID = 17,
    RoleName = "AvgRole_1016_RoleName|流浪儿",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1017] = {
    ID = 1017,
    CnID = "罗伯特",
    BaseSortID = 18,
    RoleName = "AvgRole_1017_RoleName|罗伯特",
    AwakerResource = "SpChar_DisMale_NF"
  },
  [1018] = {
    ID = 1018,
    CnID = "小女孩",
    BaseSortID = 19,
    RoleName = "AvgRole_1018_RoleName|流浪儿",
    AwakerResource = "SpChar_Girl_NF"
  },
  [1019] = {
    ID = 1019,
    CnID = "艾继丝？",
    BaseSortID = 20,
    RoleName = "AvgRole_1019_RoleName|？？？",
    AwakerResource = "B03_HF"
  },
  [1020] = {
    ID = 1020,
    CnID = "罗杰斯？",
    BaseSortID = 21,
    RoleName = "AvgRole_1020_RoleName|？？？",
    AwakerResource = "SpChar_Rogers_NF"
  },
  [1021] = {
    ID = 1021,
    CnID = "朵尔？",
    BaseSortID = 22,
    RoleName = "AvgRole_1021_RoleName|？？",
    AwakerResource = "C02_AF"
  },
  [1022] = {
    ID = 1022,
    CnID = "提尤格",
    BaseSortID = 23,
    RoleName = "AvgRole_1022_RoleName|提尤格",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1023] = {
    ID = 1023,
    CnID = "小玩偶",
    BaseSortID = 24,
    RoleName = "AvgRole_1023_RoleName|乔治",
    Tittle = "AvgRole_1023_Tittle|罗杰斯的玩偶",
    AwakerResource = "SpChar_RogersDoll_NF"
  },
  [1024] = {
    ID = 1024,
    CnID = "艾继丝怪",
    BaseSortID = 25,
    RoleName = "AvgRole_1024_RoleName|@1塔@2亚"
  },
  [1025] = {
    ID = 1025,
    CnID = "？？？",
    BaseSortID = 26,
    RoleName = "AvgRole_1025_RoleName|？？？"
  },
  [1026] = {
    ID = 1026,
    CnID = "乔治？",
    BaseSortID = 27,
    RoleName = "AvgRole_1026_RoleName|？？？",
    AwakerResource = "SpChar_RogersDoll_NF"
  },
  [1027] = {
    ID = 1027,
    CnID = "月兽？",
    BaseSortID = 28,
    RoleName = "AvgRole_1027_RoleName|？？？",
    AwakerResource = "C09_NF"
  },
  [1028] = {
    ID = 1028,
    CnID = "千面之月",
    BaseSortID = 29,
    RoleName = "AvgRole_1028_RoleName|神秘女士",
    AwakerResource = "D02_HF"
  },
  [1029] = {
    ID = 1029,
    CnID = "赫伯特？",
    BaseSortID = 30,
    RoleName = "AvgRole_1029_RoleName|？？？",
    AwakerResource = "SpChar_Herbert_NF"
  },
  [1030] = {
    ID = 1030,
    CnID = "劳伦斯先生",
    BaseSortID = 31,
    RoleName = "AvgRole_1030_RoleName|劳伦斯先生",
    HeadIcon = "Portrait_Small_Monster_C0202",
    Sign = "AvgRole_1030_Sign|Portrait_Small_Monster_C0202"
  },
  [1031] = {
    ID = 1031,
    CnID = "劳伦斯先生？",
    BaseSortID = 32,
    RoleName = "AvgRole_1031_RoleName|？？？",
    HeadIcon = "Portrait_Small_Monster_C0202",
    Sign = "AvgRole_1031_Sign|Portrait_Small_Monster_C0202"
  },
  [1032] = {
    ID = 1032,
    CnID = "阿利斯泰尔",
    BaseSortID = 33,
    RoleName = "AvgRole_1032_RoleName|阿利斯泰尔",
    AwakerResource = "SpChar_AlistairDark_NF"
  },
  [1033] = {
    ID = 1033,
    CnID = "二十四？",
    BaseSortID = 34,
    RoleName = "AvgRole_1033_RoleName|？？？",
    AwakerResource = "C06_NF"
  },
  [1034] = {
    ID = 1034,
    CnID = "查泰德夫人？",
    BaseSortID = 35,
    RoleName = "AvgRole_1034_RoleName|女蜡像",
    HeadIcon = "Portrait_Small_Monster_C0203",
    Sign = "AvgRole_1034_Sign|Portrait_Small_Monster_C0203"
  },
  [1035] = {
    ID = 1035,
    CnID = "查泰德夫人",
    BaseSortID = 36,
    RoleName = "AvgRole_1035_RoleName|查泰德夫人",
    HeadIcon = "Portrait_Small_Monster_C0203",
    Sign = "AvgRole_1035_Sign|Portrait_Small_Monster_C0203"
  },
  [1036] = {
    ID = 1036,
    CnID = "蜡像？",
    BaseSortID = 37,
    RoleName = "AvgRole_1036_RoleName|？？？",
    AwakerResource = "SpChar_TheWax_NF_NF"
  },
  [1037] = {
    ID = 1037,
    CnID = "蜡像们",
    BaseSortID = 38,
    RoleName = "AvgRole_1037_RoleName|蜡像们",
    AwakerResource = "SpChar_Girl_NF"
  },
  [1038] = {
    ID = 1038,
    CnID = "小男孩",
    BaseSortID = 39,
    RoleName = "AvgRole_1038_RoleName|小男孩",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1039] = {
    ID = 1039,
    CnID = "众人",
    BaseSortID = 40,
    RoleName = "AvgRole_1039_RoleName|众人",
    AwakerResource = "SpChar_Male_NF"
  },
  [1040] = {
    ID = 1040,
    CnID = "哭泣的乔治",
    BaseSortID = 41,
    RoleName = "AvgRole_1040_RoleName|哭泣的乔治",
    HeadIcon = "Portrait_Small_Monster_B0002",
    Sign = "AvgRole_1040_Sign|Portrait_Small_Monster_B0002"
  },
  [1041] = {
    ID = 1041,
    CnID = "协会成员",
    BaseSortID = 42,
    RoleName = "AvgRole_1041_RoleName|协会成员",
    HeadIcon = "Portrait_Small_Monster_S0302_BT",
    Sign = "AvgRole_1041_Sign|Portrait_Small_Monster_S0302_BT"
  },
  [1042] = {
    ID = 1042,
    CnID = "古老的声音",
    BaseSortID = 43,
    RoleName = "AvgRole_1042_RoleName|古老的声音"
  },
  [1043] = {
    ID = 1043,
    CnID = "弗朗西斯？",
    BaseSortID = 44,
    RoleName = "AvgRole_1043_RoleName|？？？？",
    AwakerResource = "SpChar_FrancisNormal_NF",
    HeadIcon = "SpChar_FrancisNormal_NF",
    Sign = "AvgRole_1043_Sign|SpChar_FrancisNormal_NF"
  },
  [1044] = {
    ID = 1044,
    CnID = "地狱犬",
    BaseSortID = 45,
    RoleName = "AvgRole_1044_RoleName|？？？"
  },
  [1045] = {
    ID = 1045,
    CnID = "莉莉？",
    BaseSortID = 46,
    RoleName = "AvgRole_1045_RoleName|？？",
    AwakerResource = "SpChar_Lily_NF"
  },
  [1046] = {
    ID = 1046,
    CnID = "睡眼惺忪的女孩",
    BaseSortID = 47,
    RoleName = "AvgRole_1046_RoleName|睡眼惺忪的女孩",
    AwakerResource = "SpChar_Lily_NF"
  },
  [1047] = {
    ID = 1047,
    CnID = "驾驶员",
    BaseSortID = 48,
    RoleName = "AvgRole_1047_RoleName|驾驶员",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1048] = {
    ID = 1048,
    CnID = "墨菲？",
    BaseSortID = 49,
    RoleName = "AvgRole_1048_RoleName|少女",
    AwakerResource = "SpChar_Murphy_NF"
  },
  [1049] = {
    ID = 1049,
    CnID = "纯白的少女",
    BaseSortID = 50,
    RoleName = "AvgRole_1049_RoleName|纯白的少女",
    AwakerResource = "SpChar_Lily_NF"
  },
  [1050] = {
    ID = 1050,
    CnID = "咳嗽的老人",
    BaseSortID = 51,
    RoleName = "AvgRole_1050_RoleName|咳嗽的老人",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1051] = {
    ID = 1051,
    CnID = "平静的老人",
    BaseSortID = 52,
    RoleName = "AvgRole_1051_RoleName|平静的老人",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1052] = {
    ID = 1052,
    CnID = "诡异的语言",
    BaseSortID = 53,
    RoleName = "AvgRole_1052_RoleName|诡异的语言"
  },
  [1053] = {
    ID = 1053,
    CnID = "“你”",
    BaseSortID = 54,
    RoleName = "AvgRole_1053_RoleName|「你」",
    AwakerResource = "SpChar_Male_NF"
  },
  [1054] = {
    ID = 1054,
    CnID = "塔薇",
    BaseSortID = 55,
    RoleName = "AvgRole_1054_RoleName|塔薇",
    AwakerResource = "C15_NF",
    Sign = "AvgRole_1054_Sign|我将尽我所能。"
  },
  [1055] = {
    ID = 1055,
    CnID = "“塔薇”",
    BaseSortID = 56,
    RoleName = "AvgRole_1055_RoleName|「塔薇」"
  },
  [1056] = {
    ID = 1056,
    CnID = "小蜡像",
    BaseSortID = 57,
    RoleName = "AvgRole_1056_RoleName|？？？",
    AwakerResource = "SpChar_RogersDoll_NF"
  },
  [1057] = {
    ID = 1057,
    CnID = "警探",
    BaseSortID = 58,
    RoleName = "AvgRole_1057_RoleName|警探",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1058] = {
    ID = 1058,
    CnID = "贵妇人",
    BaseSortID = 59,
    RoleName = "AvgRole_1058_RoleName|哭泣的妇人",
    AwakerResource = "SpChar_Female_NF"
  },
  [1059] = {
    ID = 1059,
    CnID = "哭泣的蜡像",
    BaseSortID = 60,
    RoleName = "AvgRole_1059_RoleName|哭泣的蜡像",
    HeadIcon = "Portrait_Small_Monster_C0205",
    Sign = "AvgRole_1059_Sign|Portrait_Small_Monster_C0205"
  },
  [1060] = {
    ID = 1060,
    CnID = "塞西莉",
    BaseSortID = 61,
    RoleName = "AvgRole_1060_RoleName|塞西莉",
    Tittle = "AvgRole_1060_Tittle|登山队成员",
    AwakerResource = "SpChar_Female_NF"
  },
  [1061] = {
    ID = 1061,
    CnID = "小男孩A",
    BaseSortID = 62,
    RoleName = "AvgRole_1061_RoleName|小男孩A",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1062] = {
    ID = 1062,
    CnID = "小男孩B",
    BaseSortID = 63,
    RoleName = "AvgRole_1062_RoleName|小男孩B",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1063] = {
    ID = 1063,
    CnID = "金发孩子",
    BaseSortID = 64,
    RoleName = "AvgRole_1063_RoleName|金发孩子",
    Tittle = "AvgRole_1063_Tittle|街头流浪儿",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1064] = {
    ID = 1064,
    CnID = "缺牙孩子",
    BaseSortID = 65,
    RoleName = "AvgRole_1064_RoleName|缺牙孩子",
    Tittle = "AvgRole_1064_Tittle|街头流浪儿",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1065] = {
    ID = 1065,
    CnID = "戴破眼镜的孩子",
    BaseSortID = 66,
    RoleName = "AvgRole_1065_RoleName|戴破眼镜的孩子",
    Tittle = "AvgRole_1065_Tittle|街头流浪儿",
    AwakerResource = "SpChar_Girl_NF"
  },
  [1066] = {
    ID = 1066,
    CnID = "戴安娜",
    BaseSortID = 67,
    RoleName = "AvgRole_1066_RoleName|戴安娜",
    AwakerResource = "SpChar_FemaleNurse_NF"
  },
  [1067] = {
    ID = 1067,
    CnID = "孩子们",
    BaseSortID = 68,
    RoleName = "AvgRole_1067_RoleName|孩子们",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1068] = {
    ID = 1068,
    CnID = "队员",
    BaseSortID = 69,
    RoleName = "AvgRole_1068_RoleName|审查会探员",
    Tittle = "AvgRole_1068_Tittle|密斯底亚协定审查会第一响应队队员",
    AwakerResource = "SpChar_Male_NF"
  },
  [1069] = {
    ID = 1069,
    CnID = "露西",
    BaseSortID = 70,
    RoleName = "AvgRole_1069_RoleName|露西",
    AwakerResource = "SpChar_Girl_NF"
  },
  [1070] = {
    ID = 1070,
    CnID = "神秘声音",
    BaseSortID = 71,
    RoleName = "AvgRole_1070_RoleName|神秘声音"
  },
  [1071] = {
    ID = 1071,
    CnID = "学长",
    BaseSortID = 72,
    RoleName = "AvgRole_1071_RoleName|学长",
    Tittle = "AvgRole_1071_Tittle|弥萨格大学学生",
    AwakerResource = "SpChar_Male_NF"
  },
  [1072] = {
    ID = 1072,
    CnID = "学弟",
    BaseSortID = 73,
    RoleName = "AvgRole_1072_RoleName|学生",
    Tittle = "AvgRole_1072_Tittle|弥萨格大学学生",
    AwakerResource = "SpChar_Male_NF"
  },
  [1073] = {
    ID = 1073,
    CnID = "警探1",
    BaseSortID = 74,
    RoleName = "AvgRole_1073_RoleName|年长警探",
    AwakerResource = "SpChar_Male_NF"
  },
  [1074] = {
    ID = 1074,
    CnID = "警探2",
    BaseSortID = 75,
    RoleName = "AvgRole_1074_RoleName|年轻警探",
    AwakerResource = "SpChar_Male_NF"
  },
  [1075] = {
    ID = 1075,
    CnID = "学生A",
    BaseSortID = 76,
    RoleName = "AvgRole_1075_RoleName|爽利的学生",
    AwakerResource = "SpChar_Female_NF"
  },
  [1076] = {
    ID = 1076,
    CnID = "学生B",
    BaseSortID = 77,
    RoleName = "AvgRole_1076_RoleName|胆怯的学生",
    AwakerResource = "SpChar_Female_NF"
  },
  [1077] = {
    ID = 1077,
    CnID = "雪地中的女子",
    BaseSortID = 78,
    RoleName = "AvgRole_1077_RoleName|雪地中的女子",
    AwakerResource = "SpChar_Female_NF"
  },
  [1078] = {
    ID = 1078,
    CnID = "雷娅？",
    BaseSortID = 79,
    RoleName = "AvgRole_1078_RoleName|神秘少女",
    AwakerResource = "B08_AF"
  },
  [1079] = {
    ID = 1079,
    CnID = "冷淡的女声",
    BaseSortID = 80,
    RoleName = "AvgRole_1079_RoleName|冷淡的女声",
    AwakerResource = "SpChar_Female_NF"
  },
  [1080] = {
    ID = 1080,
    CnID = "蜡像女孩",
    BaseSortID = 81,
    RoleName = "AvgRole_1080_RoleName|蜡像女孩",
    AwakerResource = "SpChar_Girl_NF"
  },
  [1081] = {
    ID = 1081,
    CnID = "蜡像男孩",
    BaseSortID = 82,
    RoleName = "AvgRole_1081_RoleName|蜡像男孩",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1082] = {
    ID = 1082,
    CnID = "声音A",
    BaseSortID = 83,
    RoleName = "AvgRole_1082_RoleName|声音A",
    AwakerResource = "SpChar_Female_NF"
  },
  [1083] = {
    ID = 1083,
    CnID = "声音B",
    BaseSortID = 84,
    RoleName = "AvgRole_1083_RoleName|声音B",
    AwakerResource = "SpChar_Female_NF"
  },
  [1084] = {
    ID = 1084,
    CnID = "詹金？",
    BaseSortID = 85,
    RoleName = "AvgRole_1084_RoleName|？？",
    AwakerResource = "D07_HF"
  },
  [1085] = {
    ID = 1085,
    CnID = "图鲁？",
    BaseSortID = 86,
    RoleName = "AvgRole_1085_RoleName|？？？",
    AwakerResource = "O01_NF"
  },
  [1086] = {
    ID = 1086,
    CnID = "旅店店主",
    BaseSortID = 87,
    RoleName = "AvgRole_1086_RoleName|旅店店主",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1087] = {
    ID = 1087,
    CnID = "女孩的声音",
    BaseSortID = 88,
    RoleName = "AvgRole_1087_RoleName|女孩的声音"
  },
  [1088] = {
    ID = 1088,
    CnID = "拉伊孩子1",
    BaseSortID = 89,
    RoleName = "AvgRole_1088_RoleName|金发孩子",
    Tittle = "AvgRole_1088_Tittle|拉伊小镇居民",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1089] = {
    ID = 1089,
    CnID = "拉伊孩子2",
    BaseSortID = 90,
    RoleName = "AvgRole_1089_RoleName|缺牙孩子",
    Tittle = "AvgRole_1089_Tittle|拉伊小镇居民",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1090] = {
    ID = 1090,
    CnID = "狱卒",
    BaseSortID = 91,
    RoleName = "AvgRole_1090_RoleName|狱卒",
    Tittle = "AvgRole_1090_Tittle|希洛的回忆",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1091] = {
    ID = 1091,
    CnID = "嘶叫的怪物",
    BaseSortID = 92,
    RoleName = "AvgRole_1091_RoleName|嘶叫的怪物"
  },
  [1092] = {
    ID = 1092,
    CnID = "瑟缩的怪物",
    BaseSortID = 93,
    RoleName = "AvgRole_1092_RoleName|瑟缩的怪物"
  },
  [1093] = {
    ID = 1093,
    CnID = "蜡像A",
    BaseSortID = 94,
    RoleName = "AvgRole_1093_RoleName|蜡像A",
    AwakerResource = "SpChar_Female_NF"
  },
  [1094] = {
    ID = 1094,
    CnID = "蜡像B",
    BaseSortID = 95,
    RoleName = "AvgRole_1094_RoleName|蜡像B",
    AwakerResource = "SpChar_DisMale_NF"
  },
  [1095] = {
    ID = 1095,
    CnID = "蜡像C",
    BaseSortID = 96,
    RoleName = "AvgRole_1095_RoleName|蜡像C",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1096] = {
    ID = 1096,
    CnID = "中年病患",
    BaseSortID = 97,
    RoleName = "AvgRole_1096_RoleName|中年病患",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1097] = {
    ID = 1097,
    CnID = "年轻病患",
    BaseSortID = 98,
    RoleName = "AvgRole_1097_RoleName|年轻病患",
    AwakerResource = "SpChar_Female_NF"
  },
  [1098] = {
    ID = 1098,
    CnID = "米娅",
    BaseSortID = 99,
    RoleName = "AvgRole_1098_RoleName|米娅"
  },
  [1099] = {
    ID = 1099,
    CnID = "病人",
    BaseSortID = 100,
    RoleName = "AvgRole_1099_RoleName|病人"
  },
  [1100] = {
    ID = 1100,
    CnID = "水手",
    BaseSortID = 101,
    RoleName = "AvgRole_1100_RoleName|水手"
  },
  [1101] = {
    ID = 1101,
    CnID = "怪物",
    BaseSortID = 102,
    RoleName = "AvgRole_1101_RoleName|怪物"
  },
  [1102] = {
    ID = 1102,
    CnID = "“小麦克”",
    BaseSortID = 103,
    RoleName = "AvgRole_1102_RoleName|「小麦克」",
    AwakerResource = "SpChar_LittleMike_NF"
  },
  [1103] = {
    ID = 1103,
    CnID = "弥利亚姆？",
    BaseSortID = 104,
    RoleName = "AvgRole_1103_RoleName|？？？",
    AwakerResource = "O07_NF"
  },
  [1104] = {
    ID = 1104,
    CnID = "戈利亚？",
    BaseSortID = 105,
    RoleName = "AvgRole_1104_RoleName|？？？",
    AwakerResource = "O06_NF"
  },
  [1105] = {
    ID = 1105,
    CnID = "司机",
    BaseSortID = 106,
    RoleName = "AvgRole_1105_RoleName|司机",
    Tittle = "AvgRole_1105_Tittle|哈罗德公爵的司机",
    AwakerResource = "SpChar_Male_NF"
  },
  [1106] = {
    ID = 1106,
    CnID = "蹈海者？",
    BaseSortID = 107,
    RoleName = "AvgRole_1106_RoleName|？？？",
    HeadIcon = "Portrait_Small_Monster_C0502",
    Sign = "AvgRole_1106_Sign|Portrait_Small_Monster_C0502"
  },
  [1107] = {
    ID = 1107,
    CnID = "蹈海者",
    BaseSortID = 108,
    RoleName = "AvgRole_1107_RoleName|蹈海者",
    HeadIcon = "Portrait_Small_Monster_C0502",
    Sign = "AvgRole_1107_Sign|Portrait_Small_Monster_C0502"
  },
  [1108] = {
    ID = 1108,
    CnID = "弗朗西斯吗",
    BaseSortID = 109,
    RoleName = "AvgRole_1108_RoleName|虚弱的女人",
    AwakerResource = "SpChar_FrancisNormal_NF"
  },
  [1109] = {
    ID = 1109,
    CnID = "男性教徒",
    BaseSortID = 110,
    RoleName = "AvgRole_1109_RoleName|男性教徒",
    AwakerResource = "SpChar_Male_NF"
  },
  [1110] = {
    ID = 1110,
    CnID = "女性教徒",
    BaseSortID = 111,
    RoleName = "AvgRole_1110_RoleName|女性教徒",
    AwakerResource = "SpChar_Female_NF"
  },
  [1111] = {
    ID = 1111,
    CnID = "小墨菲",
    BaseSortID = 112,
    RoleName = "AvgRole_1111_RoleName|墨菲？",
    AwakerResource = "SpChar_Girl_NF"
  },
  [1112] = {
    ID = 1112,
    CnID = "船长模样的人",
    BaseSortID = 113,
    RoleName = "AvgRole_1112_RoleName|船长模样的人",
    AwakerResource = "SpChar_Captain_NF"
  },
  [1113] = {
    ID = 1113,
    CnID = "学长？",
    BaseSortID = 114,
    RoleName = "AvgRole_1113_RoleName|@4"
  },
  [1114] = {
    ID = 1114,
    CnID = "艾继丝1",
    BaseSortID = 115,
    RoleName = "AvgRole_1114_RoleName|艾继@1",
    Tittle = "AvgRole_1114_Tittle|济贫院@2",
    AwakerResource = "B03_HF"
  },
  [1115] = {
    ID = 1115,
    CnID = "艾继丝2",
    BaseSortID = 116,
    RoleName = "AvgRole_1115_RoleName|艾@2",
    Tittle = "AvgRole_1115_Tittle|济@4",
    AwakerResource = "B03_HF"
  },
  [1116] = {
    ID = 1116,
    CnID = "艾继丝3",
    BaseSortID = 117,
    RoleName = "AvgRole_1116_RoleName|@3",
    Tittle = "AvgRole_1116_Tittle|@2@4@2",
    AwakerResource = "B03_HF"
  },
  [1117] = {
    ID = 1117,
    CnID = "希莱斯特？",
    BaseSortID = 118,
    RoleName = "AvgRole_1117_RoleName|圣洁的少女",
    AwakerResource = "O09_NF"
  },
  [1118] = {
    ID = 1118,
    CnID = "拉蒙娜",
    BaseSortID = 119,
    RoleName = "AvgRole_1118_RoleName|拉蒙娜",
    AwakerResource = "C01_AF",
    Sign = "AvgRole_1118_Sign|如暂时联系不上，可先联系守密人。"
  },
  [1119] = {
    ID = 1119,
    CnID = "拉蒙娜（黑化）",
    BaseSortID = 120,
    RoleName = "AvgRole_1119_RoleName|本源拉蒙娜"
  },
  [1120] = {
    ID = 1120,
    CnID = "朵尔",
    BaseSortID = 121,
    RoleName = "AvgRole_1120_RoleName|朵尔",
    AwakerResource = "C02_NF",
    Sign = "AvgRole_1120_Sign|办公时间：周一至周日8:00-23:30"
  },
  [1121] = {
    ID = 1121,
    CnID = "朵尔唤醒体",
    BaseSortID = 122,
    RoleName = "AvgRole_1121_RoleName|朵尔",
    AwakerResource = "C02_AF"
  },
  [1122] = {
    ID = 1122,
    CnID = "朵尔（黑化）",
    BaseSortID = 123,
    RoleName = "AvgRole_1122_RoleName|「朵尔」",
    AwakerResource = "C02EX_AF"
  },
  [1123] = {
    ID = 1123,
    CnID = "奥吉尔",
    BaseSortID = 124,
    RoleName = "AvgRole_1123_RoleName|奥吉尔",
    AwakerResource = "C03_NF",
    Sign = "AvgRole_1123_Sign|恪守骑士之责！"
  },
  [1124] = {
    ID = 1124,
    CnID = "萝坦",
    BaseSortID = 125,
    RoleName = "AvgRole_1124_RoleName|萝坦",
    AwakerResource = "C04_NF",
    Sign = "AvgRole_1124_Sign|来点能打的家伙。"
  },
  [1125] = {
    ID = 1125,
    CnID = "莱克",
    BaseSortID = 126,
    RoleName = "AvgRole_1125_RoleName|莱克",
    AwakerResource = "C05_NF",
    Sign = "AvgRole_1125_Sign|幸运女神眷顾于我。"
  },
  [1126] = {
    ID = 1126,
    CnID = "二十四",
    BaseSortID = 127,
    RoleName = "AvgRole_1126_RoleName|「24」",
    AwakerResource = "C06_NF",
    Sign = "AvgRole_1126_Sign|如果看到詹金请联系。"
  },
  [1127] = {
    ID = 1127,
    CnID = "诺缔拉",
    BaseSortID = 128,
    RoleName = "AvgRole_1127_RoleName|诺缔拉",
    AwakerResource = "C07_AF",
    Sign = "AvgRole_1127_Sign|这是啥？"
  },
  [1128] = {
    ID = 1128,
    CnID = "宁菲亚",
    BaseSortID = 129,
    RoleName = "AvgRole_1128_RoleName|宁菲亚",
    AwakerResource = "C08_HF",
    Sign = "AvgRole_1128_Sign|拉伊疗养院代理院长"
  },
  [1129] = {
    ID = 1129,
    CnID = "月兽",
    BaseSortID = 130,
    RoleName = "AvgRole_1129_RoleName|潘狄娅",
    Tittle = "AvgRole_1129_Tittle|蜡像馆管理员",
    AwakerResource = "C09_NF",
    Sign = "AvgRole_1129_Sign|享受疼痛的宠爱吧~"
  },
  [1130] = {
    ID = 1130,
    CnID = "莉莉",
    BaseSortID = 131,
    RoleName = "AvgRole_1130_RoleName|莉莉",
    AwakerResource = "SpChar_Lily_NF",
    Sign = "AvgRole_1130_Sign|喜欢主人，喜欢大家。"
  },
  [1131] = {
    ID = 1131,
    CnID = "艾尔瓦",
    BaseSortID = 132,
    RoleName = "AvgRole_1131_RoleName|艾尔瓦",
    AwakerResource = "C11_AF",
    Sign = "AvgRole_1131_Sign|我应坚毅。"
  },
  [1132] = {
    ID = 1132,
    CnID = "珈伦",
    BaseSortID = 133,
    RoleName = "AvgRole_1132_RoleName|珈伦",
    AwakerResource = "C12_AF",
    Sign = "AvgRole_1132_Sign|万能女仆静候你的差遣！"
  },
  [1133] = {
    ID = 1133,
    CnID = "莉迪亚",
    BaseSortID = 134,
    RoleName = "AvgRole_1133_RoleName|莉迪亚",
    AwakerResource = "SpChar_Female_NF"
  },
  [1134] = {
    ID = 1134,
    CnID = "泰旖丝",
    BaseSortID = 135,
    RoleName = "AvgRole_1134_RoleName|泰旖丝",
    AwakerResource = "B01_AF",
    Sign = "AvgRole_1134_Sign|生命如长河延续。"
  },
  [1135] = {
    ID = 1135,
    CnID = "萨尔瓦多",
    BaseSortID = 136,
    RoleName = "AvgRole_1135_RoleName|萨尔瓦多",
    AwakerResource = "B02_NF",
    Sign = "AvgRole_1135_Sign|愿父神的光照耀我们。"
  },
  [1136] = {
    ID = 1136,
    CnID = "艾继丝",
    BaseSortID = 137,
    RoleName = "AvgRole_1136_RoleName|艾继丝",
    Tittle = "AvgRole_1136_Tittle|济贫院孤儿",
    AwakerResource = "B03_HF",
    Sign = "AvgRole_1136_Sign|那个，艾继丝有帮到大家吗？"
  },
  [1137] = {
    ID = 1137,
    CnID = "索蕾尔",
    BaseSortID = 138,
    RoleName = "AvgRole_1137_RoleName|索蕾尔",
    AwakerResource = "B04_NF",
    Sign = "AvgRole_1137_Sign|欢迎参加我的沙龙。"
  },
  [1138] = {
    ID = 1138,
    CnID = "希洛",
    BaseSortID = 139,
    RoleName = "AvgRole_1138_RoleName|希洛",
    AwakerResource = "B05_NF",
    Sign = "AvgRole_1138_Sign|。"
  },
  [1139] = {
    ID = 1139,
    CnID = "希洛（黑化）",
    BaseSortID = 140,
    RoleName = "AvgRole_1139_RoleName|希洛（黑化）",
    AwakerResource = "B05_NF"
  },
  [1140] = {
    ID = 1140,
    CnID = "阿格里帕",
    BaseSortID = 141,
    RoleName = "AvgRole_1140_RoleName|阿格里帕",
    AwakerResource = "B06_AF",
    Sign = "AvgRole_1140_Sign|最后说一次：我的迷宫不是主题乐园！"
  },
  [1141] = {
    ID = 1141,
    CnID = "尤乌哈希",
    BaseSortID = 142,
    RoleName = "AvgRole_1141_RoleName|尤乌哈希",
    AwakerResource = "B07_NF",
    Sign = "AvgRole_1141_Sign|有本事就来。"
  },
  [1142] = {
    ID = 1142,
    CnID = "雷娅",
    BaseSortID = 143,
    RoleName = "AvgRole_1142_RoleName|雷娅",
    Tittle = "AvgRole_1142_Tittle|渴血患者",
    AwakerResource = "B08_AF",
    Sign = "AvgRole_1142_Sign|来吧，不要怜惜，好好惩罚我~"
  },
  [1143] = {
    ID = 1143,
    CnID = "菲茵特",
    BaseSortID = 144,
    RoleName = "AvgRole_1143_RoleName|菲茵特",
    AwakerResource = "B09_NF",
    Sign = "AvgRole_1143_Sign|花朵总会绽放。"
  },
  [1144] = {
    ID = 1144,
    CnID = "杜勒赛因",
    BaseSortID = 145,
    RoleName = "AvgRole_1144_RoleName|杜勒赛因",
    Tittle = "AvgRole_1144_Tittle|食尸鬼之王",
    AwakerResource = "B10_AF",
    Sign = "AvgRole_1144_Sign|教你做人，包教包会。"
  },
  [1145] = {
    ID = 1145,
    CnID = "卡拉布",
    BaseSortID = 146,
    RoleName = "AvgRole_1145_RoleName|卡拉布",
    AwakerResource = "B11_AF",
    Sign = "AvgRole_1145_Sign|仙女赐福，不要圆子，详情私聊"
  },
  [1146] = {
    ID = 1146,
    CnID = "莉兹",
    BaseSortID = 147,
    RoleName = "AvgRole_1146_RoleName|莉兹",
    AwakerResource = "D01_NF",
    Sign = "AvgRole_1146_Sign|旋转的足尖鞋。"
  },
  [1147] = {
    ID = 1147,
    CnID = "达芙黛尔",
    BaseSortID = 148,
    RoleName = "AvgRole_1147_RoleName|达芙黛尔",
    AwakerResource = "D02_HF",
    Sign = "AvgRole_1147_Sign|价格公道，童叟无欺。"
  },
  [1148] = {
    ID = 1148,
    CnID = "达芙黛尔唤醒体",
    BaseSortID = 149,
    RoleName = "AvgRole_1148_RoleName|达芙黛尔",
    AwakerResource = "D02_NF"
  },
  [1149] = {
    ID = 1149,
    CnID = "汀克特",
    BaseSortID = 150,
    RoleName = "AvgRole_1149_RoleName|汀克特",
    AwakerResource = "D03_NF",
    Sign = "AvgRole_1149_Sign|请聆听我的歌声。"
  },
  [1150] = {
    ID = 1150,
    CnID = "汀克特（黑化）",
    BaseSortID = 151,
    RoleName = "AvgRole_1150_RoleName|暮星·汀克特"
  },
  [1151] = {
    ID = 1151,
    CnID = "旺达",
    BaseSortID = 152,
    RoleName = "AvgRole_1151_RoleName|旺达",
    AwakerResource = "D04_NF",
    Sign = "AvgRole_1151_Sign|大家都是我可爱的仆人。"
  },
  [1152] = {
    ID = 1152,
    CnID = "温柯尔",
    BaseSortID = 153,
    RoleName = "AvgRole_1152_RoleName|温柯尔",
    AwakerResource = "D05_AF",
    Sign = "AvgRole_1152_Sign|有偿征集咖啡补给。"
  },
  [1153] = {
    ID = 1153,
    CnID = "奥尔拉",
    BaseSortID = 154,
    RoleName = "AvgRole_1153_RoleName|奥尔拉",
    AwakerResource = "D06_NF",
    Sign = "AvgRole_1153_Sign|愿我们心中有诗。"
  },
  [1154] = {
    ID = 1154,
    CnID = "詹金",
    BaseSortID = 155,
    RoleName = "AvgRole_1154_RoleName|詹金",
    Tittle = "AvgRole_1154_Tittle|伦蒂尼恩第一神偷（自封）",
    AwakerResource = "D07_HF",
    Sign = "AvgRole_1154_Sign|伦蒂尼恩第一神偷在此！"
  },
  [1155] = {
    ID = 1155,
    CnID = "艾瑞卡",
    BaseSortID = 156,
    RoleName = "AvgRole_1155_RoleName|艾瑞卡",
    AwakerResource = "D08_NF",
    Sign = "AvgRole_1155_Sign|如有问题，请在通讯器发送“查询”。"
  },
  [1156] = {
    ID = 1156,
    CnID = "卡茜亚",
    BaseSortID = 157,
    RoleName = "AvgRole_1156_RoleName|卡茜亚",
    AwakerResource = "D09_NF",
    Sign = "AvgRole_1156_Sign|魔法嘉年华每日开演！"
  },
  [1157] = {
    ID = 1157,
    CnID = "阿拉克涅",
    BaseSortID = 158,
    RoleName = "AvgRole_1157_RoleName|阿拉克涅",
    AwakerResource = "D10_AF",
    Sign = "AvgRole_1157_Sign|命运不掷骰子。"
  },
  [1158] = {
    ID = 1158,
    CnID = "纳各&耶伯",
    BaseSortID = 159,
    RoleName = "AvgRole_1158_RoleName|纳各&耶伯",
    AwakerResource = "D11_AF"
  },
  [1159] = {
    ID = 1159,
    CnID = "图鲁",
    BaseSortID = 160,
    RoleName = "AvgRole_1159_RoleName|图鲁",
    AwakerResource = "O01_NF",
    Sign = "AvgRole_1159_Sign|无事勿扰。"
  },
  [1160] = {
    ID = 1160,
    CnID = "墨菲（唤醒体）",
    BaseSortID = 161,
    RoleName = "AvgRole_1160_RoleName|墨菲",
    AwakerResource = "O02_AF",
    Sign = "AvgRole_1160_Sign|接受各种下午茶邀约，无小蛋糕免谈。"
  },
  [1161] = {
    ID = 1161,
    CnID = "墨菲（黑化）",
    BaseSortID = 162,
    RoleName = "AvgRole_1161_RoleName|本源墨菲"
  },
  [1162] = {
    ID = 1162,
    CnID = "法洛思",
    BaseSortID = 163,
    RoleName = "AvgRole_1162_RoleName|法洛思",
    AwakerResource = "O03_NF",
    Sign = "AvgRole_1162_Sign|愿故乡指引我。"
  },
  [1163] = {
    ID = 1163,
    CnID = "凯刻斯",
    BaseSortID = 164,
    RoleName = "AvgRole_1163_RoleName|凯刻斯",
    AwakerResource = "O04_AF",
    Sign = "AvgRole_1163_Sign|一切都是血脉的考验。"
  },
  [1164] = {
    ID = 1164,
    CnID = "凯刻斯NPC",
    BaseSortID = 165,
    RoleName = "AvgRole_1164_RoleName|凯刻斯",
    AwakerResource = "O04_HF"
  },
  [1165] = {
    ID = 1165,
    CnID = "奥瑞塔",
    BaseSortID = 166,
    RoleName = "AvgRole_1165_RoleName|奥瑞塔",
    AwakerResource = "O05_NF",
    Sign = "AvgRole_1165_Sign|伙伴们快来找我玩！"
  },
  [1166] = {
    ID = 1166,
    CnID = "戈利亚",
    BaseSortID = 167,
    RoleName = "AvgRole_1166_RoleName|戈利亚",
    AwakerResource = "O06_NF",
    Sign = "AvgRole_1166_Sign|想来挑战我的腕力吗？"
  },
  [1167] = {
    ID = 1167,
    CnID = "海德拉",
    BaseSortID = 168,
    RoleName = "AvgRole_1167_RoleName|弥利亚姆",
    AwakerResource = "O07_NF"
  },
  [1168] = {
    ID = 1168,
    CnID = "弥利亚姆",
    BaseSortID = 169,
    RoleName = "AvgRole_1168_RoleName|弥利亚姆",
    AwakerResource = "O07_NF",
    Sign = "AvgRole_1168_Sign|神国会庇佑它的子民。"
  },
  [1169] = {
    ID = 1169,
    CnID = "珊",
    BaseSortID = 170,
    RoleName = "AvgRole_1169_RoleName|珊",
    AwakerResource = "O08_NF",
    Sign = "AvgRole_1169_Sign|我们都是待成的雕塑。"
  },
  [1170] = {
    ID = 1170,
    CnID = "希莱斯特",
    BaseSortID = 171,
    RoleName = "AvgRole_1170_RoleName|希莱斯特",
    AwakerResource = "O09_NF",
    Sign = "AvgRole_1170_Sign|请向我许愿吧。"
  },
  [1171] = {
    ID = 1171,
    CnID = "克珀珊特",
    BaseSortID = 172,
    RoleName = "AvgRole_1171_RoleName|克珀珊特",
    AwakerResource = "O10_AF",
    Sign = "AvgRole_1171_Sign|领航员克珀珊特，时刻待命。"
  },
  [1172] = {
    ID = 1172,
    CnID = "路人NPC-儿童-男",
    BaseSortID = 173,
    AwakerResource = "SpChar_Boy_NF"
  },
  [1173] = {
    ID = 1173,
    CnID = "路人NPC-儿童-女",
    BaseSortID = 174,
    AwakerResource = "SpChar_Girl_NF"
  },
  [1174] = {
    ID = 1174,
    CnID = "路人NPC-青年-男",
    BaseSortID = 175,
    AwakerResource = "SpChar_Male_NF"
  },
  [1175] = {
    ID = 1175,
    CnID = "路人NPC-成人-女",
    BaseSortID = 176,
    AwakerResource = "SpChar_Female_NF"
  },
  [1176] = {
    ID = 1176,
    CnID = "路人NPC-中老年-男",
    BaseSortID = 177,
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1177] = {
    ID = 1177,
    CnID = "路人NPC-融蚀-男",
    BaseSortID = 178,
    AwakerResource = "SpChar_DisMale_NF"
  },
  [1178] = {
    ID = 1178,
    CnID = "阿利斯泰尔？",
    BaseSortID = 179,
    RoleName = "AvgRole_1178_RoleName|？？？",
    AwakerResource = "SpChar_AlistairDark_NF"
  },
  [1179] = {
    ID = 1179,
    CnID = "汉娜",
    BaseSortID = 180,
    RoleName = "AvgRole_1179_RoleName|汉娜",
    Tittle = "AvgRole_1179_Tittle|弥萨格大学日报主编",
    AwakerResource = "SpChar_Hannah_NF"
  },
  [1180] = {
    ID = 1180,
    CnID = "赫伯特",
    BaseSortID = 181,
    RoleName = "AvgRole_1180_RoleName|赫伯特",
    Tittle = "AvgRole_1180_Tittle|雕塑家协会会长",
    AwakerResource = "SpChar_Herbert_NF"
  },
  [1181] = {
    ID = 1181,
    CnID = "诃勒特",
    BaseSortID = 182,
    RoleName = "AvgRole_1181_RoleName|诃勒特",
    Tittle = "AvgRole_1181_Tittle|代理院长",
    AwakerResource = "SpChar_Czort_NF"
  },
  [1182] = {
    ID = 1182,
    CnID = "德克斯特",
    BaseSortID = 183,
    RoleName = "AvgRole_1182_RoleName|德克斯特",
    Tittle = "AvgRole_1182_Tittle|勋爵",
    AwakerResource = "SpChar_Dexter_NF"
  },
  [1183] = {
    ID = 1183,
    CnID = "威廉",
    BaseSortID = 184,
    RoleName = "AvgRole_1183_RoleName|威廉",
    Tittle = "AvgRole_1183_Tittle|资深调查员",
    AwakerResource = "SpChar_William_NF"
  },
  [1184] = {
    ID = 1184,
    CnID = "融蚀女学生",
    BaseSortID = 185,
    RoleName = "AvgRole_1184_RoleName|融蚀女学生",
    AwakerResource = "SpChar_StudentDis_NF"
  },
  [1185] = {
    ID = 1185,
    CnID = "拉蒙娜战损版",
    BaseSortID = 186,
    RoleName = "AvgRole_1185_RoleName|拉蒙娜",
    AwakerResource = "SpChar_InjuredRamona_NF"
  },
  [1186] = {
    ID = 1186,
    CnID = "莎拉",
    BaseSortID = 187,
    RoleName = "AvgRole_1186_RoleName|莎拉",
    Tittle = "AvgRole_1186_Tittle|济贫院管理员",
    AwakerResource = "SpChar_Sarah_NF"
  },
  [1187] = {
    ID = 1187,
    CnID = "罗杰斯",
    BaseSortID = 188,
    RoleName = "AvgRole_1187_RoleName|罗杰斯",
    Tittle = "AvgRole_1187_Tittle|蜡像师",
    AwakerResource = "SpChar_Rogers_NF"
  },
  [1188] = {
    ID = 1188,
    CnID = "护工戴安娜",
    BaseSortID = 189,
    RoleName = "AvgRole_1188_RoleName|戴安娜",
    Tittle = "AvgRole_1188_Tittle|济贫院护工",
    AwakerResource = "SpChar_FemaleNurse_NF"
  },
  [1189] = {
    ID = 1189,
    CnID = "克莱门汀",
    BaseSortID = 190,
    RoleName = "AvgRole_1189_RoleName|克莱门汀",
    Tittle = "AvgRole_1189_Tittle|心理医生",
    AwakerResource = "SpChar_Clementine_HF",
    Sign = "AvgRole_1189_Sign|我愿与你，共同开启一段心灵之旅。"
  },
  [1190] = {
    ID = 1190,
    CnID = "克莱门汀（唤醒体）",
    BaseSortID = 191,
    RoleName = "AvgRole_1190_RoleName|克莱门汀",
    AwakerResource = "SpChar_Clementine_AF"
  },
  [1191] = {
    ID = 1191,
    CnID = "乔治",
    BaseSortID = 192,
    RoleName = "AvgRole_1191_RoleName|乔治",
    Tittle = "AvgRole_1191_Tittle|小蜡像",
    AwakerResource = "SpChar_RogersDoll_NF"
  },
  [1192] = {
    ID = 1192,
    CnID = "罗杰斯断手",
    BaseSortID = 193,
    RoleName = "AvgRole_1192_RoleName|罗杰斯",
    Tittle = "AvgRole_1192_Tittle|蜡像师",
    AwakerResource = "SpChar_RogersDisabled_NF"
  },
  [1193] = {
    ID = 1193,
    CnID = "罗杰斯空",
    BaseSortID = 194,
    RoleName = "AvgRole_1193_RoleName|罗杰斯",
    Tittle = "AvgRole_1193_Tittle|蜡像师",
    AwakerResource = "SpChar_RogersEmpty_NF"
  },
  [1194] = {
    ID = 1194,
    CnID = "蜡像",
    BaseSortID = 195,
    RoleName = "AvgRole_1194_RoleName|「蜡像」",
    AwakerResource = "SpChar_TheWax_NF"
  },
  [1195] = {
    ID = 1195,
    CnID = "蛇人",
    BaseSortID = 196,
    RoleName = "AvgRole_1195_RoleName|阿尔比诺",
    AwakerResource = "SpChar_Albino_NF"
  },
  [1196] = {
    ID = 1196,
    CnID = "布朗",
    BaseSortID = 197,
    RoleName = "AvgRole_1196_RoleName|布朗",
    Tittle = "AvgRole_1196_Tittle|小老鼠",
    AwakerResource = "SpChar_Brown_NF"
  },
  [1197] = {
    ID = 1197,
    CnID = "弗朗西斯疯狂版",
    BaseSortID = 198,
    RoleName = "AvgRole_1197_RoleName|弗朗西斯",
    AwakerResource = "SpChar_FrancisCrazy_NF"
  },
  [1198] = {
    ID = 1198,
    CnID = "弗朗西斯",
    BaseSortID = 199,
    RoleName = "AvgRole_1198_RoleName|弗朗西斯",
    AwakerResource = "SpChar_FrancisNormal_NF"
  },
  [1199] = {
    ID = 1199,
    CnID = "墨菲",
    BaseSortID = 200,
    RoleName = "AvgRole_1199_RoleName|墨菲",
    AwakerResource = "SpChar_Murphy_NF",
    Sign = "AvgRole_1199_Sign|接受各种下午茶邀约，无小蛋糕免谈。"
  },
  [1200] = {
    ID = 1200,
    CnID = "伯特兰",
    BaseSortID = 201,
    RoleName = "AvgRole_1200_RoleName|伯特兰",
    Tittle = "AvgRole_1200_Tittle|上校",
    AwakerResource = "SpChar_Bertrand_NF"
  },
  [1201] = {
    ID = 1201,
    CnID = "埃尔顿",
    BaseSortID = 202,
    RoleName = "AvgRole_1201_RoleName|埃尔顿",
    Tittle = "AvgRole_1201_Tittle|船长",
    AwakerResource = "SpChar_Captain_NF"
  },
  [1202] = {
    ID = 1202,
    CnID = "童年罗杰斯",
    BaseSortID = 203,
    RoleName = "AvgRole_1202_RoleName|童年罗杰斯",
    AwakerResource = "SpChar_LittleRogers_NF"
  },
  [1203] = {
    ID = 1203,
    CnID = "小麦克",
    BaseSortID = 204,
    RoleName = "AvgRole_1203_RoleName|小麦克",
    Tittle = "AvgRole_1203_Tittle|济贫院孤儿",
    AwakerResource = "SpChar_LittleMike_NF"
  },
  [1204] = {
    ID = 1204,
    CnID = "雕塑家协会NPC",
    BaseSortID = 205,
    RoleName = "AvgRole_1204_RoleName|雕塑家协会NPC",
    AwakerResource = "SpChar_Sculptor_NF"
  },
  [1205] = {
    ID = 1205,
    CnID = "审查会NPC",
    BaseSortID = 206,
    RoleName = "AvgRole_1205_RoleName|审查会成员",
    AwakerResource = "SpChar_MTCAgent_NF"
  },
  [1206] = {
    ID = 1206,
    CnID = "库姆",
    BaseSortID = 207,
    RoleName = "AvgRole_1206_RoleName|库姆",
    AwakerResource = "SpChar_Kum_NF"
  },
  [1207] = {
    ID = 1207,
    CnID = "丽莎",
    BaseSortID = 208,
    RoleName = "AvgRole_1207_RoleName|丽莎",
    Tittle = "AvgRole_1207_Tittle|拉伊小镇居民",
    AwakerResource = "SpChar_Lisa_NF"
  },
  [1208] = {
    ID = 1208,
    CnID = "丽莎母亲",
    BaseSortID = 209,
    RoleName = "AvgRole_1208_RoleName|丽莎母亲",
    Tittle = "AvgRole_1208_Tittle|拉伊小镇居民",
    AwakerResource = "SpChar_LisaMon_NF"
  },
  [1209] = {
    ID = 1209,
    CnID = "融蚀老鼠",
    BaseSortID = 210,
    RoleName = "AvgRole_1209_RoleName|？？？",
    HeadIcon = "Portrait_Small_Monster_S0201",
    Sign = "AvgRole_1209_Sign|Portrait_Small_Monster_S0201"
  },
  [1210] = {
    ID = 1210,
    CnID = "神秘墨菲",
    BaseSortID = 211,
    RoleName = "AvgRole_1210_RoleName|少女",
    AwakerResource = "SpChar_Murphy_NF"
  },
  [1211] = {
    ID = 1211,
    CnID = "神秘拉蒙娜",
    BaseSortID = 212,
    RoleName = "AvgRole_1211_RoleName|？？？",
    AwakerResource = "C01_AF"
  },
  [1212] = {
    ID = 1212,
    CnID = "路人居民-女",
    BaseSortID = 213,
    RoleName = "AvgRole_1212_RoleName|居民",
    AwakerResource = "SpChar_Female_NF"
  },
  [1213] = {
    ID = 1213,
    CnID = "神秘戈利亚",
    BaseSortID = 214,
    RoleName = "AvgRole_1213_RoleName|？？？（男）",
    AwakerResource = "O06_NF"
  },
  [1214] = {
    ID = 1214,
    CnID = "神秘弥利亚姆",
    BaseSortID = 215,
    RoleName = "AvgRole_1214_RoleName|？？？（女）",
    AwakerResource = "O07_NF"
  },
  [1215] = {
    ID = 1215,
    CnID = "神秘凯刻斯",
    BaseSortID = 216,
    RoleName = "AvgRole_1215_RoleName|少年",
    AwakerResource = "O04_AF"
  },
  [1216] = {
    ID = 1216,
    CnID = "蹈海者凯刻斯",
    BaseSortID = 217,
    RoleName = "AvgRole_1216_RoleName|蹈海者少年",
    AwakerResource = "O04_AF"
  },
  [1217] = {
    ID = 1217,
    CnID = "古老弥利亚姆",
    BaseSortID = 218,
    RoleName = "AvgRole_1217_RoleName|女人",
    AwakerResource = "O07_NF"
  },
  [1218] = {
    ID = 1218,
    CnID = "古老图鲁",
    BaseSortID = 219,
    RoleName = "AvgRole_1218_RoleName|少年",
    AwakerResource = "O01_NF"
  },
  [1219] = {
    ID = 1219,
    CnID = "路人NPC-友人",
    BaseSortID = 220,
    RoleName = "AvgRole_1219_RoleName|友人",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1220] = {
    ID = 1220,
    CnID = "路人NPC-男性教众",
    BaseSortID = 221,
    RoleName = "AvgRole_1220_RoleName|男性教众",
    AwakerResource = "SpChar_Male_NF"
  },
  [1221] = {
    ID = 1221,
    CnID = "墨菲？？",
    BaseSortID = 222,
    RoleName = "AvgRole_1221_RoleName|？？？",
    AwakerResource = "SpChar_Murphy_NF"
  },
  [1222] = {
    ID = 1222,
    CnID = "温柯尔？",
    BaseSortID = 223,
    RoleName = "AvgRole_1222_RoleName|？？？",
    AwakerResource = "D05_AF"
  },
  [1223] = {
    ID = 1223,
    CnID = "路人NPC-大副",
    BaseSortID = 224,
    RoleName = "AvgRole_1223_RoleName|大副",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1224] = {
    ID = 1224,
    CnID = "路人NPC-轮机长",
    BaseSortID = 225,
    RoleName = "AvgRole_1224_RoleName|轮机长",
    AwakerResource = "SpChar_Male_NF"
  },
  [1225] = {
    ID = 1225,
    CnID = "达芙黛尔-伪装",
    BaseSortID = 226,
    RoleName = "AvgRole_1225_RoleName|朵尔？",
    AwakerResource = "D02_NF"
  },
  [1226] = {
    ID = 1226,
    CnID = "梅森人格",
    BaseSortID = 227,
    RoleName = "AvgRole_1226_RoleName|「梅森」",
    AwakerResource = "C06_AF"
  },
  [1227] = {
    ID = 1227,
    CnID = "雷娅哥哥",
    BaseSortID = 228,
    RoleName = "AvgRole_1227_RoleName|？？？",
    AwakerResource = "SpChar_Male_NF"
  },
  [1228] = {
    ID = 1228,
    CnID = "希洛？",
    BaseSortID = 229,
    RoleName = "AvgRole_1228_RoleName|？？？",
    Tittle = "AvgRole_1228_Tittle|凛然的女人",
    AwakerResource = "B05_NF"
  },
  [1229] = {
    ID = 1229,
    CnID = "独眼男人",
    BaseSortID = 230,
    RoleName = "AvgRole_1229_RoleName|？？？",
    Tittle = "AvgRole_1229_Tittle|独眼男人",
    AwakerResource = "SpChar_Herbert_NF"
  },
  [1230] = {
    ID = 1230,
    CnID = "身形巨大的怪物",
    BaseSortID = 231,
    RoleName = "AvgRole_1230_RoleName|？？？",
    Tittle = "AvgRole_1230_Tittle|身型巨大的怪物",
    AwakerResource = "SpChar_Kum_NF"
  },
  [1231] = {
    ID = 1231,
    CnID = "提灯教众未知版",
    BaseSortID = 232,
    RoleName = "AvgRole_1231_RoleName|？？？",
    Tittle = "AvgRole_1231_Tittle|黑纱女人",
    AwakerResource = "SpChar_LightLady_NF"
  },
  [1232] = {
    ID = 1232,
    CnID = "士兵1",
    BaseSortID = 233,
    RoleName = "AvgRole_1232_RoleName|士兵",
    Tittle = "AvgRole_1232_Tittle|斯巴达士兵",
    AwakerResource = "SpChar_Male_NF"
  },
  [1233] = {
    ID = 1233,
    CnID = "士兵2",
    BaseSortID = 234,
    RoleName = "AvgRole_1233_RoleName|士兵",
    Tittle = "AvgRole_1233_Tittle|斯巴达士兵",
    AwakerResource = "SpChar_Male_NF"
  },
  [1234] = {
    ID = 1234,
    CnID = "奴隶1",
    BaseSortID = 235,
    RoleName = "AvgRole_1234_RoleName|奴隶",
    Tittle = "AvgRole_1234_Tittle|提洛人",
    AwakerResource = "SpChar_Male_NF"
  },
  [1235] = {
    ID = 1235,
    CnID = "奴隶2",
    BaseSortID = 236,
    RoleName = "AvgRole_1235_RoleName|奴隶",
    Tittle = "AvgRole_1235_Tittle|提洛人",
    AwakerResource = "SpChar_Male_NF"
  },
  [1236] = {
    ID = 1236,
    CnID = "奴隶3",
    BaseSortID = 237,
    RoleName = "AvgRole_1236_RoleName|奴隶",
    Tittle = "AvgRole_1236_Tittle|提洛人",
    AwakerResource = "SpChar_Male_NF"
  },
  [1237] = {
    ID = 1237,
    CnID = "奴隶4",
    BaseSortID = 238,
    RoleName = "AvgRole_1237_RoleName|奴隶",
    Tittle = "AvgRole_1237_Tittle|提洛人",
    AwakerResource = "SpChar_Male_NF"
  },
  [1238] = {
    ID = 1238,
    CnID = "奴隶们",
    BaseSortID = 239,
    RoleName = "AvgRole_1238_RoleName|奴隶们",
    AwakerResource = "SpChar_Male_NF"
  },
  [1239] = {
    ID = 1239,
    CnID = "夫人",
    BaseSortID = 240,
    RoleName = "AvgRole_1239_RoleName|掌政官夫人",
    Tittle = "AvgRole_1239_Tittle|斯巴达贵族",
    AwakerResource = "SpChar_FrancisNormal_NF"
  },
  [1240] = {
    ID = 1240,
    CnID = "女奴隶",
    BaseSortID = 241,
    RoleName = "AvgRole_1240_RoleName|奴隶",
    Tittle = "AvgRole_1240_Tittle|提洛人",
    AwakerResource = "SpChar_FrancisNormal_NF"
  },
  [1241] = {
    ID = 1241,
    CnID = "女奴隶2",
    BaseSortID = 242,
    RoleName = "AvgRole_1241_RoleName|奴隶",
    Tittle = "AvgRole_1241_Tittle|提洛人",
    AwakerResource = "SpChar_FrancisNormal_NF"
  },
  [1242] = {
    ID = 1242,
    CnID = "贵族",
    BaseSortID = 243,
    RoleName = "AvgRole_1242_RoleName|斯巴达贵族",
    AwakerResource = "SpChar_Male_NF"
  },
  [1243] = {
    ID = 1243,
    CnID = "士兵们",
    BaseSortID = 244,
    RoleName = "AvgRole_1243_RoleName|士兵们",
    AwakerResource = "SpChar_Male_NF"
  },
  [1244] = {
    ID = 1244,
    CnID = "本源希洛",
    BaseSortID = 245,
    RoleName = "AvgRole_1244_RoleName|血链·希洛",
    AwakerResource = "B05EX_NF",
    Sign = "AvgRole_1244_Sign|别烦我"
  },
  [1245] = {
    ID = 1245,
    CnID = "本源拉蒙娜",
    BaseSortID = 246,
    RoleName = "AvgRole_1245_RoleName|拉蒙娜",
    AwakerResource = "C01EX_NF",
    Sign = "AvgRole_1245_Sign|等待与你相见。"
  },
  [1246] = {
    ID = 1246,
    CnID = "本源朵尔",
    BaseSortID = 247,
    RoleName = "AvgRole_1246_RoleName|「朵尔」",
    AwakerResource = "C02EX_AF",
    Sign = "AvgRole_1246_Sign|睁大眼看看吧，这世界的虚妄。"
  },
  [1247] = {
    ID = 1247,
    CnID = "以格伦",
    BaseSortID = 248,
    RoleName = "AvgRole_1247_RoleName|以格伦",
    Tittle = "AvgRole_1247_Tittle|非利士新任领袖",
    AwakerResource = "SpChar_Iglen_NF"
  },
  [1248] = {
    ID = 1248,
    CnID = "？？？（詹金）",
    BaseSortID = 249,
    RoleName = "AvgRole_1248_RoleName|？？？",
    AwakerResource = "D07_HF"
  },
  [1249] = {
    ID = 1249,
    CnID = "？？？（克莱门汀）",
    BaseSortID = 250,
    RoleName = "AvgRole_1249_RoleName|？？？",
    AwakerResource = "SpChar_Clementine_HF"
  },
  [1250] = {
    ID = 1250,
    CnID = "姐姐？",
    BaseSortID = 251,
    RoleName = "AvgRole_1250_RoleName|姐姐？",
    AwakerResource = "SpChar_Female_NF"
  },
  [1251] = {
    ID = 1251,
    CnID = "？？？（梅森）",
    BaseSortID = 252,
    RoleName = "AvgRole_1251_RoleName|？？？",
    AwakerResource = "C06_AF"
  },
  [1252] = {
    ID = 1252,
    CnID = "维克",
    BaseSortID = 253,
    RoleName = "AvgRole_1252_RoleName|维克",
    AwakerResource = "SpChar_Sculptor_NF"
  },
  [1253] = {
    ID = 1253,
    CnID = "审查会队长",
    BaseSortID = 254,
    RoleName = "AvgRole_1253_RoleName|审查会队长",
    AwakerResource = "SpChar_MTCAgent_NF"
  },
  [1254] = {
    ID = 1254,
    CnID = "“塔薇”之声",
    BaseSortID = 255,
    RoleName = "AvgRole_1254_RoleName|「塔薇」之声"
  },
  [1255] = {
    ID = 1255,
    CnID = "审判所士兵",
    BaseSortID = 256,
    RoleName = "AvgRole_1255_RoleName|审判所士兵",
    AwakerResource = "SpChar_Male_NF"
  },
  [1256] = {
    ID = 1256,
    CnID = "审判所士兵2",
    BaseSortID = 257,
    RoleName = "AvgRole_1256_RoleName|审判所士兵",
    AwakerResource = "SpChar_Male_NF"
  },
  [1257] = {
    ID = 1257,
    CnID = "洛佩兹太太",
    BaseSortID = 258,
    RoleName = "AvgRole_1257_RoleName|洛佩兹太太",
    AwakerResource = "SpChar_LisaMon_NF"
  },
  [1258] = {
    ID = 1258,
    CnID = "躯体主人",
    BaseSortID = 259,
    RoleName = "AvgRole_1258_RoleName|躯体主人",
    AwakerResource = "SpChar_Male_NF"
  },
  [1259] = {
    ID = 1259,
    CnID = "萨尔瓦多？",
    BaseSortID = 260,
    RoleName = "AvgRole_1259_RoleName|？？？？",
    AwakerResource = "B02_AF"
  },
  [1260] = {
    ID = 1260,
    CnID = "洛佩兹太太？",
    BaseSortID = 261,
    RoleName = "AvgRole_1260_RoleName|女人",
    AwakerResource = "SpChar_LisaMon_NF"
  },
  [1261] = {
    ID = 1261,
    CnID = "达芙黛尔？",
    BaseSortID = 262,
    RoleName = "AvgRole_1261_RoleName|？？？",
    AwakerResource = "D02_NF"
  },
  [1262] = {
    ID = 1262,
    CnID = "老弗里曼",
    BaseSortID = 263,
    RoleName = "AvgRole_1262_RoleName|老弗里曼",
    AwakerResource = "SpChar_Drunkard_NF"
  },
  [1263] = {
    ID = 1263,
    CnID = "猎颅者",
    BaseSortID = 264,
    RoleName = "AvgRole_1263_RoleName|猎颅者",
    AwakerResource = "SpChar_SkullHunter1_NF"
  },
  [1264] = {
    ID = 1264,
    CnID = "哈莉特",
    BaseSortID = 265,
    RoleName = "AvgRole_1264_RoleName|哈莉特",
    AwakerResource = "SpChar_LisaMon_NF"
  },
  [1265] = {
    ID = 1265,
    CnID = "哈莉特？",
    BaseSortID = 266,
    RoleName = "AvgRole_1265_RoleName|忧郁的妇人",
    AwakerResource = "SpChar_LisaMon_NF"
  },
  [1266] = {
    ID = 1266,
    CnID = "无头猎颅者",
    BaseSortID = 267,
    RoleName = "AvgRole_1266_RoleName|无头猎颅者",
    AwakerResource = "SpChar_SkullHunter2_NF"
  },
  [1267] = {
    ID = 1267,
    CnID = "暴走猎颅者",
    BaseSortID = 268,
    RoleName = "AvgRole_1267_RoleName|肿胀的哈莉特",
    HeadIcon = "Portrait_Small_Monster_DCD02_02_BOSSSIZE",
    Sign = "AvgRole_1267_Sign|Portrait_Small_Monster_DCD02_02_BOSSSIZE"
  },
  [1268] = {
    ID = 1268,
    CnID = "头颅A",
    BaseSortID = 269,
    RoleName = "AvgRole_1268_RoleName|亮晶晶的头颅"
  },
  [1269] = {
    ID = 1269,
    CnID = "头颅B",
    BaseSortID = 270,
    RoleName = "AvgRole_1269_RoleName|尖尖的头颅"
  },
  [1270] = {
    ID = 1270,
    CnID = "头颅C",
    BaseSortID = 271,
    RoleName = "AvgRole_1270_RoleName|咆哮的头颅"
  },
  [1271] = {
    ID = 1271,
    CnID = "“我”",
    BaseSortID = 272,
    RoleName = "AvgRole_1271_RoleName|「我」",
    AwakerResource = "SpChar_Male_NF"
  },
  [1272] = {
    ID = 1272,
    CnID = "英格丽德",
    BaseSortID = 273,
    RoleName = "AvgRole_1272_RoleName|英格丽德",
    AwakerResource = "SpChar_Female_NF"
  },
  [1273] = {
    ID = 1273,
    CnID = "“老火枪”",
    BaseSortID = 274,
    RoleName = "AvgRole_1273_RoleName|「老火枪」",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1274] = {
    ID = 1274,
    CnID = "船员1",
    BaseSortID = 275,
    RoleName = "AvgRole_1274_RoleName|船员",
    AwakerResource = "SpChar_Male_NF"
  },
  [1275] = {
    ID = 1275,
    CnID = "船员2",
    BaseSortID = 276,
    RoleName = "AvgRole_1275_RoleName|船员",
    AwakerResource = "SpChar_Male_NF"
  },
  [1276] = {
    ID = 1276,
    CnID = "欧文",
    BaseSortID = 277,
    RoleName = "AvgRole_1276_RoleName|欧文",
    AwakerResource = "SpChar_Male_NF"
  },
  [1277] = {
    ID = 1277,
    CnID = "比尔",
    BaseSortID = 278,
    RoleName = "AvgRole_1277_RoleName|比尔",
    AwakerResource = "SpChar_Male_NF"
  },
  [1278] = {
    ID = 1278,
    CnID = "欧文&比尔",
    BaseSortID = 279,
    RoleName = "AvgRole_1278_RoleName|欧文&比尔",
    AwakerResource = "SpChar_Male_NF"
  },
  [1279] = {
    ID = 1279,
    CnID = "伊萨克",
    BaseSortID = 280,
    RoleName = "AvgRole_1279_RoleName|伊萨克",
    AwakerResource = "SpChar_Male_NF"
  },
  [1280] = {
    ID = 1280,
    CnID = "安德斯",
    BaseSortID = 281,
    RoleName = "AvgRole_1280_RoleName|安德斯",
    AwakerResource = "SpChar_Male_NF"
  },
  [1281] = {
    ID = 1281,
    CnID = "@1@2",
    BaseSortID = 282,
    RoleName = "AvgRole_1281_RoleName|@1@2",
    AwakerResource = "SpChar_Male_NF"
  },
  [1282] = {
    ID = 1282,
    CnID = "@1@3",
    BaseSortID = 283,
    RoleName = "AvgRole_1282_RoleName|@1@3",
    AwakerResource = "SpChar_Male_NF"
  },
  [1283] = {
    ID = 1283,
    CnID = "@1@4",
    BaseSortID = 284,
    RoleName = "AvgRole_1283_RoleName|@1@4",
    AwakerResource = "SpChar_Male_NF"
  },
  [1284] = {
    ID = 1284,
    CnID = "镇民",
    BaseSortID = 285,
    RoleName = "AvgRole_1284_RoleName|镇民",
    AwakerResource = "SpChar_Male_NF"
  },
  [1285] = {
    ID = 1285,
    CnID = "镇民1",
    BaseSortID = 286,
    RoleName = "AvgRole_1285_RoleName|镇民",
    AwakerResource = "SpChar_Male_NF"
  },
  [1286] = {
    ID = 1286,
    CnID = "镇民2",
    BaseSortID = 287,
    RoleName = "AvgRole_1286_RoleName|镇民",
    AwakerResource = "SpChar_Male_NF"
  },
  [1287] = {
    ID = 1287,
    CnID = "镇民3",
    BaseSortID = 288,
    RoleName = "AvgRole_1287_RoleName|镇民",
    AwakerResource = "SpChar_Female_NF"
  },
  [1288] = {
    ID = 1288,
    CnID = "镇民们",
    BaseSortID = 289,
    RoleName = "AvgRole_1288_RoleName|镇民们",
    AwakerResource = "SpChar_Male_NF"
  },
  [1289] = {
    ID = 1289,
    CnID = "艾米丽",
    BaseSortID = 290,
    RoleName = "AvgRole_1289_RoleName|艾米丽",
    AwakerResource = "SpChar_Female_NF"
  },
  [1290] = {
    ID = 1290,
    CnID = "护士",
    BaseSortID = 291,
    RoleName = "AvgRole_1290_RoleName|护士",
    AwakerResource = "SpChar_Female_NF"
  },
  [1291] = {
    ID = 1291,
    CnID = "弥利亚姆与法洛思",
    BaseSortID = 292,
    RoleName = "AvgRole_1291_RoleName|弥利亚姆与法洛思",
    AwakerResource = "SpChar_Female_NF"
  },
  [1292] = {
    ID = 1292,
    CnID = "船员们",
    BaseSortID = 293,
    RoleName = "AvgRole_1292_RoleName|船员们",
    AwakerResource = "SpChar_Male_NF"
  },
  [1293] = {
    ID = 1293,
    CnID = "船员",
    BaseSortID = 294,
    RoleName = "AvgRole_1293_RoleName|船员",
    AwakerResource = "SpChar_Male_NF"
  },
  [1294] = {
    ID = 1294,
    CnID = "落单的孩子",
    BaseSortID = 295,
    RoleName = "AvgRole_1294_RoleName|落单的孩子",
    AwakerResource = "SpChar_Male_NF"
  },
  [1295] = {
    ID = 1295,
    CnID = "诺缔拉？",
    BaseSortID = 296,
    RoleName = "AvgRole_1295_RoleName|？？？",
    AwakerResource = "C07_AF"
  },
  [1296] = {
    ID = 1296,
    CnID = "向导",
    BaseSortID = 297,
    RoleName = "AvgRole_1296_RoleName|巴奈特",
    AwakerResource = "SpChar_Guide_NF"
  },
  [1297] = {
    ID = 1297,
    CnID = "艾维斯",
    BaseSortID = 298,
    RoleName = "AvgRole_1297_RoleName|艾维斯",
    AwakerResource = "SpChar_Detective_NF"
  },
  [1298] = {
    ID = 1298,
    CnID = "登山家",
    BaseSortID = 299,
    RoleName = "AvgRole_1298_RoleName|登山家",
    AwakerResource = "SpChar_Male_NF"
  },
  [1299] = {
    ID = 1299,
    CnID = "愤怒的考察队员",
    BaseSortID = 300,
    RoleName = "AvgRole_1299_RoleName|愤怒的考察队员",
    AwakerResource = "SpChar_Male_NF"
  },
  [1300] = {
    ID = 1300,
    CnID = "恐惧的考察队员",
    BaseSortID = 301,
    RoleName = "AvgRole_1300_RoleName|恐惧的考察队员",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1301] = {
    ID = 1301,
    CnID = "考察队员",
    BaseSortID = 302,
    RoleName = "AvgRole_1301_RoleName|考察队员",
    AwakerResource = "SpChar_Male_NF"
  },
  [1302] = {
    ID = 1302,
    CnID = "医护人员",
    BaseSortID = 303,
    RoleName = "AvgRole_1302_RoleName|医护人员",
    AwakerResource = "SpChar_Female_NF"
  },
  [1303] = {
    ID = 1303,
    CnID = "本地人",
    BaseSortID = 304,
    RoleName = "AvgRole_1303_RoleName|本地人",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1304] = {
    ID = 1304,
    CnID = "“希洛”",
    BaseSortID = 305,
    RoleName = "AvgRole_1304_RoleName|「希洛」",
    AwakerResource = "B05EX_NF"
  },
  [1305] = {
    ID = 1305,
    CnID = "本源·希洛",
    BaseSortID = 306,
    RoleName = "AvgRole_1305_RoleName|希洛",
    AwakerResource = "B05EX_NF"
  },
  [1306] = {
    ID = 1306,
    CnID = "山脉",
    BaseSortID = 307,
    RoleName = "AvgRole_1306_RoleName|山脉"
  },
  [1307] = {
    ID = 1307,
    CnID = "阿尔比诺",
    BaseSortID = 308,
    RoleName = "AvgRole_1307_RoleName|阿尔比诺",
    AwakerResource = "SpChar_Albino_NF"
  },
  [1308] = {
    ID = 1308,
    CnID = "贵族妇人",
    BaseSortID = 309,
    RoleName = "AvgRole_1308_RoleName|贵族妇人"
  },
  [1309] = {
    ID = 1309,
    CnID = "公主",
    BaseSortID = 310,
    RoleName = "AvgRole_1309_RoleName|公主",
    AwakerResource = "SpChar_Female_NF"
  },
  [1310] = {
    ID = 1310,
    CnID = "侍女",
    BaseSortID = 311,
    RoleName = "AvgRole_1310_RoleName|侍女",
    AwakerResource = "SpChar_Female_NF"
  },
  [1311] = {
    ID = 1311,
    CnID = "对练骑士",
    BaseSortID = 312,
    RoleName = "AvgRole_1311_RoleName|对练骑士",
    AwakerResource = "SpChar_Knight_NF"
  },
  [1312] = {
    ID = 1312,
    CnID = "围观骑士",
    BaseSortID = 313,
    RoleName = "AvgRole_1312_RoleName|围观骑士",
    AwakerResource = "SpChar_Knight_NF"
  },
  [1313] = {
    ID = 1313,
    CnID = "骑士团长",
    BaseSortID = 314,
    RoleName = "AvgRole_1313_RoleName|骑士团长",
    AwakerResource = "SpChar_Knight_NF"
  },
  [1314] = {
    ID = 1314,
    CnID = "护卫骑士",
    BaseSortID = 315,
    RoleName = "AvgRole_1314_RoleName|护卫骑士",
    AwakerResource = "SpChar_Knight_NF"
  },
  [1315] = {
    ID = 1315,
    CnID = "斥候",
    BaseSortID = 316,
    RoleName = "AvgRole_1315_RoleName|斥候",
    AwakerResource = "SpChar_Male_NF"
  },
  [1316] = {
    ID = 1316,
    CnID = "士官",
    BaseSortID = 317,
    RoleName = "AvgRole_1316_RoleName|士官",
    AwakerResource = "SpChar_Knight_NF"
  },
  [1317] = {
    ID = 1317,
    CnID = "少女",
    BaseSortID = 318,
    RoleName = "AvgRole_1317_RoleName|少女",
    AwakerResource = "SpChar_Female_NF"
  },
  [1318] = {
    ID = 1318,
    CnID = "怪物们",
    BaseSortID = 319,
    RoleName = "AvgRole_1318_RoleName|怪物们",
    AwakerResource = "SpChar_Male_NF"
  },
  [1319] = {
    ID = 1319,
    CnID = "于丽埃特",
    BaseSortID = 320,
    RoleName = "AvgRole_1319_RoleName|于丽埃特",
    AwakerResource = "SpChar_Female_NF"
  },
  [1320] = {
    ID = 1320,
    CnID = "于丽埃特？",
    BaseSortID = 321,
    RoleName = "AvgRole_1320_RoleName|陌生的女声",
    AwakerResource = "SpChar_Female_NF"
  },
  [1321] = {
    ID = 1321,
    CnID = "NPC1",
    BaseSortID = 322,
    RoleName = "AvgRole_1321_RoleName|中年市民",
    AwakerResource = "SpChar_Male_NF"
  },
  [1322] = {
    ID = 1322,
    CnID = "NPC2",
    BaseSortID = 323,
    RoleName = "AvgRole_1322_RoleName|年轻市民",
    AwakerResource = "SpChar_Female_NF"
  },
  [1323] = {
    ID = 1323,
    CnID = "NPC3",
    BaseSortID = 324,
    RoleName = "AvgRole_1323_RoleName|年长市民",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1324] = {
    ID = 1324,
    CnID = "NPC4",
    BaseSortID = 325,
    RoleName = "AvgRole_1324_RoleName|中年市民",
    AwakerResource = "SpChar_Female_NF"
  },
  [1325] = {
    ID = 1325,
    CnID = "老人",
    BaseSortID = 326,
    RoleName = "AvgRole_1325_RoleName|老人",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1326] = {
    ID = 1326,
    CnID = "士兵",
    BaseSortID = 327,
    RoleName = "AvgRole_1326_RoleName|士兵",
    AwakerResource = "SpChar_Knight_NF"
  },
  [1327] = {
    ID = 1327,
    CnID = "凯勒布",
    BaseSortID = 328,
    RoleName = "AvgRole_1327_RoleName|凯勒布",
    AwakerResource = "SpChar_Male_NF"
  },
  [1328] = {
    ID = 1328,
    CnID = "男人",
    BaseSortID = 329,
    RoleName = "AvgRole_1328_RoleName|男人",
    AwakerResource = "SpChar_Male_NF"
  },
  [1329] = {
    ID = 1329,
    CnID = "中年男人",
    BaseSortID = 330,
    RoleName = "AvgRole_1329_RoleName|中年男人",
    AwakerResource = "SpChar_Male_NF"
  },
  [1330] = {
    ID = 1330,
    CnID = "老妇人",
    BaseSortID = 331,
    RoleName = "AvgRole_1330_RoleName|老妇人",
    AwakerResource = "SpChar_Female_NF"
  },
  [1331] = {
    ID = 1331,
    CnID = "所有人",
    BaseSortID = 332,
    RoleName = "AvgRole_1331_RoleName|所有人"
  },
  [1332] = {
    ID = 1332,
    CnID = "人群",
    BaseSortID = 333,
    RoleName = "AvgRole_1332_RoleName|人群"
  },
  [1333] = {
    ID = 1333,
    CnID = "群众",
    BaseSortID = 334,
    RoleName = "AvgRole_1333_RoleName|群众"
  },
  [1334] = {
    ID = 1334,
    CnID = "审查会成员",
    BaseSortID = 335,
    RoleName = "AvgRole_1334_RoleName|审查会成员",
    AwakerResource = "SpChar_MTCAgent_NF"
  },
  [1335] = {
    ID = 1335,
    CnID = "陌生的声音",
    BaseSortID = 336,
    RoleName = "AvgRole_1335_RoleName|陌生的声音"
  },
  [1336] = {
    ID = 1336,
    CnID = "巨犬",
    BaseSortID = 337,
    RoleName = "AvgRole_1336_RoleName|巨犬"
  },
  [1337] = {
    ID = 1337,
    CnID = "焦虑的声音",
    BaseSortID = 338,
    RoleName = "AvgRole_1337_RoleName|焦虑的声音"
  },
  [1338] = {
    ID = 1338,
    CnID = "温和的声音",
    BaseSortID = 339,
    RoleName = "AvgRole_1338_RoleName|温和的声音"
  },
  [1339] = {
    ID = 1339,
    CnID = "奥古斯特",
    BaseSortID = 340,
    RoleName = "AvgRole_1339_RoleName|奥古斯特",
    AwakerResource = "SpChar_Detective_NF"
  },
  [1340] = {
    ID = 1340,
    CnID = "宾客A",
    BaseSortID = 341,
    RoleName = "AvgRole_1340_RoleName|男士宾客",
    AwakerResource = "SpChar_Male_NF"
  },
  [1341] = {
    ID = 1341,
    CnID = "宾客B",
    BaseSortID = 342,
    RoleName = "AvgRole_1341_RoleName|女士宾客",
    AwakerResource = "SpChar_Female_NF"
  },
  [1342] = {
    ID = 1342,
    CnID = "宾客C",
    BaseSortID = 343,
    RoleName = "AvgRole_1342_RoleName|老年宾客",
    AwakerResource = "SpChar_Male_NF"
  },
  [1343] = {
    ID = 1343,
    CnID = "珊瑚女",
    BaseSortID = 344,
    RoleName = "AvgRole_1343_RoleName|「石化的珊」",
    AwakerResource = "SpChar_StoneSanga_NF"
  },
  [1344] = {
    ID = 1344,
    CnID = "幼年保罗",
    BaseSortID = 345,
    RoleName = "AvgRole_1344_RoleName|幼年保罗",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1345] = {
    ID = 1345,
    CnID = "保罗少爷",
    BaseSortID = 346,
    RoleName = "AvgRole_1345_RoleName|保罗少爷",
    AwakerResource = "SpChar_Male_NF"
  },
  [1346] = {
    ID = 1346,
    CnID = "西岱报童",
    BaseSortID = 347,
    RoleName = "AvgRole_1346_RoleName|西岱报童",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1347] = {
    ID = 1347,
    CnID = "幼年的珊",
    BaseSortID = 348,
    RoleName = "AvgRole_1347_RoleName|少女的珊",
    AwakerResource = "SpChar_Female_NF"
  },
  [1348] = {
    ID = 1348,
    CnID = "奥古斯特？",
    BaseSortID = 349,
    RoleName = "AvgRole_1348_RoleName|？？？",
    AwakerResource = "SpChar_Detective_NF"
  },
  [1349] = {
    ID = 1349,
    CnID = "珊？",
    BaseSortID = 350,
    RoleName = "AvgRole_1349_RoleName|？？？",
    AwakerResource = "O08_NF"
  },
  [1350] = {
    ID = 1350,
    CnID = "爽朗的女性",
    BaseSortID = 351,
    RoleName = "AvgRole_1350_RoleName|爽朗的女性",
    AwakerResource = "D08_HF"
  },
  [1351] = {
    ID = 1351,
    CnID = "沉稳的女性",
    BaseSortID = 352,
    RoleName = "AvgRole_1351_RoleName|沉稳的女性",
    AwakerResource = "SpChar_May_NF"
  },
  [1352] = {
    ID = 1352,
    CnID = "梅伊",
    BaseSortID = 353,
    RoleName = "AvgRole_1352_RoleName|梅伊",
    AwakerResource = "SpChar_May_NF"
  },
  [1353] = {
    ID = 1353,
    CnID = "神秘店主",
    BaseSortID = 354,
    RoleName = "AvgRole_1353_RoleName|神秘店主",
    AwakerResource = "D02_HF"
  },
  [1354] = {
    ID = 1354,
    CnID = "普林？",
    BaseSortID = 355,
    RoleName = "AvgRole_1354_RoleName|？？？",
    AwakerResource = "SpChar_Witch_NF"
  },
  [1355] = {
    ID = 1355,
    CnID = "普林",
    BaseSortID = 356,
    RoleName = "AvgRole_1355_RoleName|普林",
    AwakerResource = "SpChar_Witch_NF"
  },
  [1356] = {
    ID = 1356,
    CnID = "融蚀浆怪物",
    BaseSortID = 357,
    RoleName = "AvgRole_1356_RoleName|融蚀浆怪物",
    HeadIcon = "Portrait_Small_Monster_S0103",
    Sign = "AvgRole_1356_Sign|Portrait_Small_Monster_S0103"
  },
  [1357] = {
    ID = 1357,
    CnID = "士兵A",
    BaseSortID = 358,
    RoleName = "AvgRole_1357_RoleName|年轻士兵",
    AwakerResource = "SpChar_Knight_NF"
  },
  [1358] = {
    ID = 1358,
    CnID = "士兵B",
    BaseSortID = 359,
    RoleName = "AvgRole_1358_RoleName|年长士兵",
    AwakerResource = "SpChar_Knight_NF"
  },
  [1359] = {
    ID = 1359,
    CnID = "女学生A",
    BaseSortID = 360,
    RoleName = "AvgRole_1359_RoleName|胆小的女学生",
    AwakerResource = "SpChar_Female_NF"
  },
  [1360] = {
    ID = 1360,
    CnID = "女学生B",
    BaseSortID = 361,
    RoleName = "AvgRole_1360_RoleName|沉稳的女学生",
    AwakerResource = "SpChar_Female_NF"
  },
  [1361] = {
    ID = 1361,
    CnID = "夏洛特",
    BaseSortID = 362,
    RoleName = "AvgRole_1361_RoleName|夏洛特",
    AwakerResource = "SpChar_StudentDis_NF"
  },
  [1362] = {
    ID = 1362,
    CnID = "「夏洛特」",
    BaseSortID = 363,
    RoleName = "AvgRole_1362_RoleName|「夏洛特」",
    AwakerResource = "SpChar_StudentDis_NF"
  },
  [1363] = {
    ID = 1363,
    CnID = "快乐的夏洛特",
    BaseSortID = 364,
    RoleName = "AvgRole_1363_RoleName|快乐的夏洛特",
    AwakerResource = "SpChar_StudentDis_NF"
  },
  [1364] = {
    ID = 1364,
    CnID = "悲伤的夏洛特",
    BaseSortID = 365,
    RoleName = "AvgRole_1364_RoleName|悲伤的夏洛特",
    AwakerResource = "SpChar_StudentDis_NF"
  },
  [1365] = {
    ID = 1365,
    CnID = "贪玩的夏洛特",
    BaseSortID = 366,
    RoleName = "AvgRole_1365_RoleName|贪玩的夏洛特",
    AwakerResource = "SpChar_StudentDis_NF"
  },
  [1366] = {
    ID = 1366,
    CnID = "恐惧的夏洛特",
    BaseSortID = 367,
    RoleName = "AvgRole_1366_RoleName|恐惧的夏洛特",
    AwakerResource = "SpChar_StudentDis_NF"
  },
  [1367] = {
    ID = 1367,
    CnID = "平静的夏洛特",
    BaseSortID = 368,
    RoleName = "AvgRole_1367_RoleName|平静的夏洛特",
    AwakerResource = "SpChar_StudentDis_NF"
  },
  [1368] = {
    ID = 1368,
    CnID = "「拉蒙娜」",
    BaseSortID = 369,
    RoleName = "AvgRole_1368_RoleName|「拉蒙娜」",
    AwakerResource = "C01_AF"
  },
  [1369] = {
    ID = 1369,
    CnID = "「朵尔」",
    BaseSortID = 370,
    RoleName = "AvgRole_1369_RoleName|「朵尔」",
    AwakerResource = "C02_AF"
  },
  [1370] = {
    ID = 1370,
    CnID = "「威廉」",
    BaseSortID = 371,
    RoleName = "AvgRole_1370_RoleName|「威廉」",
    Tittle = "AvgRole_1370_Tittle|资深调查员",
    AwakerResource = "SpChar_William_NF"
  },
  [1371] = {
    ID = 1371,
    CnID = "奴隶A",
    BaseSortID = 372,
    RoleName = "AvgRole_1371_RoleName|暴躁奴隶",
    AwakerResource = "SpChar_Gladiator_NF"
  },
  [1372] = {
    ID = 1372,
    CnID = "奴隶B",
    BaseSortID = 373,
    RoleName = "AvgRole_1372_RoleName|阴沉奴隶",
    AwakerResource = "SpChar_Gladiator_NF"
  },
  [1373] = {
    ID = 1373,
    CnID = "奴隶C",
    BaseSortID = 374,
    RoleName = "AvgRole_1373_RoleName|多疑奴隶",
    AwakerResource = "SpChar_Gladiator_NF"
  },
  [1374] = {
    ID = 1374,
    CnID = "贵族夫人",
    BaseSortID = 375,
    RoleName = "AvgRole_1374_RoleName|贵族妇人",
    AwakerResource = "SpChar_Female_NF"
  },
  [1375] = {
    ID = 1375,
    CnID = "老弗里曼？",
    BaseSortID = 376,
    RoleName = "AvgRole_1375_RoleName|？？？",
    AwakerResource = "SpChar_Drunkard_NF"
  },
  [1376] = {
    ID = 1376,
    CnID = "店长？",
    BaseSortID = 377,
    RoleName = "AvgRole_1376_RoleName|？？？",
    AwakerResource = "D02_AF"
  },
  [1377] = {
    ID = 1377,
    CnID = "店长",
    BaseSortID = 378,
    RoleName = "AvgRole_1377_RoleName|「达芙黛尔」",
    Tittle = "AvgRole_1377_Tittle|交换商店前任店主",
    AwakerResource = "D02_HF"
  },
  [1378] = {
    ID = 1378,
    CnID = "故事旁白（卡茜亚）",
    BaseSortID = 379,
    RoleName = "AvgRole_1378_RoleName|旁白",
    Tittle = "AvgRole_1378_Tittle|卡茜亚",
    AwakerResource = "D09_NF"
  },
  [1379] = {
    ID = 1379,
    CnID = "旁白（卡茜亚）",
    BaseSortID = 380,
    RoleName = "AvgRole_1379_RoleName|旁白",
    Tittle = "AvgRole_1379_Tittle|卡茜亚",
    AwakerResource = "D09_NF"
  },
  [1380] = {
    ID = 1380,
    CnID = "旁白（玩家）",
    BaseSortID = 381,
    RoleName = "AvgRole_1380_RoleName|旁白",
    Tittle = "AvgRole_1380_Tittle|守密人",
    ShowAsPlayer = 1,
    AwakerResource = "SpChar_PlayerM_NF"
  },
  [1381] = {
    ID = 1381,
    CnID = "？？？（宁菲亚）",
    BaseSortID = 382,
    RoleName = "AvgRole_1381_RoleName|？？？",
    AwakerResource = "C08_HF"
  },
  [1382] = {
    ID = 1382,
    CnID = "母亲（守密人）",
    BaseSortID = 383,
    RoleName = "AvgRole_1382_RoleName|母亲",
    Tittle = "AvgRole_1382_Tittle|守密人",
    ShowAsPlayer = 1,
    AwakerResource = "SpChar_PlayerM_NF"
  },
  [1383] = {
    ID = 1383,
    CnID = "害怕的女孩（莉莉）",
    BaseSortID = 384,
    RoleName = "AvgRole_1383_RoleName|害怕的女孩",
    Tittle = "AvgRole_1383_Tittle|莉莉",
    AwakerResource = "SpChar_Lily_NF"
  },
  [1384] = {
    ID = 1384,
    CnID = "勇敢的女孩（莉莉）",
    BaseSortID = 385,
    RoleName = "AvgRole_1384_RoleName|勇敢的女孩",
    Tittle = "AvgRole_1384_Tittle|莉莉",
    AwakerResource = "SpChar_Lily_NF"
  },
  [1385] = {
    ID = 1385,
    CnID = "霍迪妮大师",
    BaseSortID = 386,
    RoleName = "AvgRole_1385_RoleName|霍迪妮大师",
    Tittle = "AvgRole_1385_Tittle|卡茜亚",
    AwakerResource = "D09_NF"
  },
  [1386] = {
    ID = 1386,
    CnID = "探长G",
    BaseSortID = 387,
    RoleName = "AvgRole_1386_RoleName|探长G",
    Tittle = "AvgRole_1386_Tittle|奥吉尔",
    AwakerResource = "C03_NF"
  },
  [1387] = {
    ID = 1387,
    CnID = "被俘的女孩（莉莉）",
    BaseSortID = 388,
    RoleName = "AvgRole_1387_RoleName|被俘的女孩",
    Tittle = "AvgRole_1387_Tittle|莉莉",
    AwakerResource = "SpChar_Lily_NF"
  },
  [1388] = {
    ID = 1388,
    CnID = "终夜助手（詹金）",
    BaseSortID = 389,
    RoleName = "AvgRole_1388_RoleName|终夜助手",
    Tittle = "AvgRole_1388_Tittle|詹金",
    AwakerResource = "D07_NF"
  },
  [1389] = {
    ID = 1389,
    CnID = "旁白（萝坦）",
    BaseSortID = 390,
    RoleName = "AvgRole_1389_RoleName|旁白",
    Tittle = "AvgRole_1389_Tittle|萝坦",
    AwakerResource = "C04_NF"
  },
  [1390] = {
    ID = 1390,
    CnID = "海洋精灵（奥瑞塔）",
    BaseSortID = 391,
    RoleName = "AvgRole_1390_RoleName|海洋精灵",
    Tittle = "AvgRole_1390_Tittle|奥瑞塔",
    AwakerResource = "O05_NF"
  },
  [1391] = {
    ID = 1391,
    CnID = "不耐烦的巨兽（萝坦）",
    BaseSortID = 392,
    RoleName = "AvgRole_1391_RoleName|不耐烦的巨兽",
    Tittle = "AvgRole_1391_Tittle|萝坦",
    AwakerResource = "C04_NF"
  },
  [1392] = {
    ID = 1392,
    CnID = "地狱犬（莉莉）",
    BaseSortID = 393,
    RoleName = "AvgRole_1392_RoleName|地狱犬",
    Tittle = "AvgRole_1392_Tittle|莉莉",
    AwakerResource = "SpChar_Lily_NF"
  },
  [1393] = {
    ID = 1393,
    CnID = "融蚀异变体",
    BaseSortID = 394,
    RoleName = "AvgRole_1393_RoleName|融蚀异变体",
    AwakerResource = "SpChar_Male_NF"
  },
  [1394] = {
    ID = 1394,
    CnID = "终夜游侠（布朗）",
    BaseSortID = 395,
    RoleName = "AvgRole_1394_RoleName|终夜游侠",
    Tittle = "AvgRole_1394_Tittle|布朗",
    AwakerResource = "SpChar_Brown_NF"
  },
  [1395] = {
    ID = 1395,
    CnID = "？？？（萝坦）",
    BaseSortID = 396,
    RoleName = "AvgRole_1395_RoleName|？？？",
    AwakerResource = "C04_NF"
  },
  [1396] = {
    ID = 1396,
    CnID = "悠远的声音",
    BaseSortID = 397,
    RoleName = "AvgRole_1396_RoleName|悠远的声音",
    AwakerResource = "SpChar_Male_NF"
  },
  [1397] = {
    ID = 1397,
    CnID = "年轻女性",
    BaseSortID = 398,
    RoleName = "AvgRole_1397_RoleName|年轻女性",
    AwakerResource = "SpChar_Female_NF"
  },
  [1398] = {
    ID = 1398,
    CnID = "融蚀女人",
    BaseSortID = 399,
    RoleName = "AvgRole_1398_RoleName|女人",
    AwakerResource = "SpChar_Female_NF"
  },
  [1399] = {
    ID = 1399,
    CnID = "融蚀男人",
    BaseSortID = 400,
    RoleName = "AvgRole_1399_RoleName|中年男人",
    AwakerResource = "SpChar_DisMale_NF"
  },
  [1400] = {
    ID = 1400,
    CnID = "中年人",
    BaseSortID = 401,
    RoleName = "AvgRole_1400_RoleName|中年人",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1401] = {
    ID = 1401,
    CnID = "粗野的声音",
    BaseSortID = 402,
    RoleName = "AvgRole_1401_RoleName|粗野的声音",
    AwakerResource = "SpChar_Male_NF"
  },
  [1402] = {
    ID = 1402,
    CnID = "唯唯诺诺的声音",
    BaseSortID = 403,
    RoleName = "AvgRole_1402_RoleName|唯唯诺诺的声音",
    AwakerResource = "SpChar_Male_NF"
  },
  [1403] = {
    ID = 1403,
    CnID = "圣子",
    BaseSortID = 404,
    RoleName = "AvgRole_1403_RoleName|@3",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1404] = {
    ID = 1404,
    CnID = "拉蒙娜AF",
    BaseSortID = 405,
    RoleName = "AvgRole_1404_RoleName|拉蒙娜AF",
    AwakerResource = "C01_AF"
  },
  [1406] = {
    ID = 1406,
    CnID = "朵尔AF",
    BaseSortID = 406,
    RoleName = "AvgRole_1406_RoleName|朵尔AF",
    AwakerResource = "C02_AF"
  },
  [1407] = {
    ID = 1407,
    CnID = "朵尔NF",
    BaseSortID = 407,
    RoleName = "AvgRole_1407_RoleName|朵尔NF",
    AwakerResource = "C02_NF"
  },
  [1409] = {
    ID = 1409,
    CnID = "奥吉尔AF",
    BaseSortID = 408,
    RoleName = "AvgRole_1409_RoleName|奥吉尔AF",
    AwakerResource = "C03_AF"
  },
  [1410] = {
    ID = 1410,
    CnID = "奥吉尔NF",
    BaseSortID = 409,
    RoleName = "AvgRole_1410_RoleName|奥吉尔NF",
    AwakerResource = "C03_NF"
  },
  [1411] = {
    ID = 1411,
    CnID = "萝坦AF",
    BaseSortID = 410,
    RoleName = "AvgRole_1411_RoleName|萝坦AF",
    AwakerResource = "C04_AF"
  },
  [1412] = {
    ID = 1412,
    CnID = "萝坦NF",
    BaseSortID = 411,
    RoleName = "AvgRole_1412_RoleName|萝坦NF",
    AwakerResource = "C04_NF"
  },
  [1413] = {
    ID = 1413,
    CnID = "莱克AF",
    BaseSortID = 412,
    RoleName = "AvgRole_1413_RoleName|莱克AF",
    AwakerResource = "C05_AF"
  },
  [1414] = {
    ID = 1414,
    CnID = "莱克NF",
    BaseSortID = 413,
    RoleName = "AvgRole_1414_RoleName|莱克NF",
    AwakerResource = "C05_NF"
  },
  [1415] = {
    ID = 1415,
    CnID = "24AF",
    BaseSortID = 414,
    RoleName = "AvgRole_1415_RoleName|24AF",
    AwakerResource = "C06_AF"
  },
  [1416] = {
    ID = 1416,
    CnID = "24NF",
    BaseSortID = 415,
    RoleName = "AvgRole_1416_RoleName|24NF",
    AwakerResource = "C06_NF"
  },
  [1417] = {
    ID = 1417,
    CnID = "诺缔拉AF",
    BaseSortID = 416,
    RoleName = "AvgRole_1417_RoleName|诺缔拉AF",
    AwakerResource = "C07_AF"
  },
  [1419] = {
    ID = 1419,
    CnID = "宁菲亚AF",
    BaseSortID = 417,
    RoleName = "AvgRole_1419_RoleName|宁菲亚",
    AwakerResource = "C08_AF",
    Sign = "AvgRole_1419_Sign|拉伊疗养院代理院长"
  },
  [1420] = {
    ID = 1420,
    CnID = "宁菲亚NF",
    BaseSortID = 418,
    RoleName = "AvgRole_1420_RoleName|宁菲亚NF",
    AwakerResource = "C08_NF"
  },
  [1421] = {
    ID = 1421,
    CnID = "宁菲亚HF",
    BaseSortID = 419,
    RoleName = "AvgRole_1421_RoleName|宁菲亚HF",
    AwakerResource = "C08_HF"
  },
  [1422] = {
    ID = 1422,
    CnID = "潘狄娅AF",
    BaseSortID = 420,
    RoleName = "AvgRole_1422_RoleName|潘狄娅AF",
    AwakerResource = "C09_AF"
  },
  [1423] = {
    ID = 1423,
    CnID = "潘狄娅NF",
    BaseSortID = 421,
    RoleName = "AvgRole_1423_RoleName|潘狄娅NF",
    AwakerResource = "C09_NF"
  },
  [1424] = {
    ID = 1424,
    CnID = "莉莉AF",
    BaseSortID = 422,
    RoleName = "AvgRole_1424_RoleName|莉莉",
    AwakerResource = "C10_AF",
    Sign = "AvgRole_1424_Sign|喜欢主人，喜欢大家。"
  },
  [1425] = {
    ID = 1425,
    CnID = "艾尔瓦AF",
    BaseSortID = 423,
    RoleName = "AvgRole_1425_RoleName|艾尔瓦AF",
    AwakerResource = "C11_AF"
  },
  [1426] = {
    ID = 1426,
    CnID = "珈伦AF",
    BaseSortID = 424,
    RoleName = "AvgRole_1426_RoleName|珈伦AF",
    AwakerResource = "C12_AF"
  },
  [1427] = {
    ID = 1427,
    CnID = "图鲁AF",
    BaseSortID = 425,
    RoleName = "AvgRole_1427_RoleName|图鲁AF",
    AwakerResource = "O01_AF"
  },
  [1428] = {
    ID = 1428,
    CnID = "图鲁NF",
    BaseSortID = 426,
    RoleName = "AvgRole_1428_RoleName|图鲁NF",
    AwakerResource = "O01_NF"
  },
  [1429] = {
    ID = 1429,
    CnID = "墨菲AF",
    BaseSortID = 427,
    RoleName = "AvgRole_1429_RoleName|墨菲AF",
    AwakerResource = "O02_AF"
  },
  [1430] = {
    ID = 1430,
    CnID = "法洛思AF",
    BaseSortID = 428,
    RoleName = "AvgRole_1430_RoleName|法洛思AF",
    AwakerResource = "O03_AF"
  },
  [1431] = {
    ID = 1431,
    CnID = "法洛思NF",
    BaseSortID = 429,
    RoleName = "AvgRole_1431_RoleName|法洛思NF",
    AwakerResource = "O03_NF"
  },
  [1432] = {
    ID = 1432,
    CnID = "凯刻斯AF",
    BaseSortID = 430,
    RoleName = "AvgRole_1432_RoleName|凯刻斯AF",
    AwakerResource = "O04_AF"
  },
  [1433] = {
    ID = 1433,
    CnID = "凯刻斯HF",
    BaseSortID = 431,
    RoleName = "AvgRole_1433_RoleName|凯刻斯HF",
    AwakerResource = "O04_HF"
  },
  [1434] = {
    ID = 1434,
    CnID = "奥瑞塔AF",
    BaseSortID = 432,
    RoleName = "AvgRole_1434_RoleName|奥瑞塔AF",
    AwakerResource = "O05_AF"
  },
  [1435] = {
    ID = 1435,
    CnID = "奥瑞塔NF",
    BaseSortID = 433,
    RoleName = "AvgRole_1435_RoleName|奥瑞塔NF",
    AwakerResource = "O05_NF"
  },
  [1436] = {
    ID = 1436,
    CnID = "戈利亚AF",
    BaseSortID = 434,
    RoleName = "AvgRole_1436_RoleName|戈利亚AF",
    AwakerResource = "O06_AF"
  },
  [1437] = {
    ID = 1437,
    CnID = "戈利亚NF",
    BaseSortID = 435,
    RoleName = "AvgRole_1437_RoleName|戈利亚NF",
    AwakerResource = "O06_NF"
  },
  [1438] = {
    ID = 1438,
    CnID = "弥利亚姆AF",
    BaseSortID = 436,
    RoleName = "AvgRole_1438_RoleName|弥利亚姆AF",
    AwakerResource = "O07_AF"
  },
  [1439] = {
    ID = 1439,
    CnID = "弥利亚姆NF",
    BaseSortID = 437,
    RoleName = "AvgRole_1439_RoleName|弥利亚姆NF",
    AwakerResource = "O07_NF"
  },
  [1440] = {
    ID = 1440,
    CnID = "弥利亚姆HF",
    BaseSortID = 438,
    RoleName = "AvgRole_1440_RoleName|弥利亚姆HF",
    AwakerResource = "O07_HF"
  },
  [1441] = {
    ID = 1441,
    CnID = "珊AF",
    BaseSortID = 439,
    RoleName = "AvgRole_1441_RoleName|珊AF",
    AwakerResource = "O08_AF"
  },
  [1442] = {
    ID = 1442,
    CnID = "珊NF",
    BaseSortID = 440,
    RoleName = "AvgRole_1442_RoleName|珊NF",
    AwakerResource = "O08_NF"
  },
  [1443] = {
    ID = 1443,
    CnID = "希莱斯特AF",
    BaseSortID = 441,
    RoleName = "AvgRole_1443_RoleName|希莱斯特AF",
    AwakerResource = "O09_AF"
  },
  [1444] = {
    ID = 1444,
    CnID = "希莱斯特NF",
    BaseSortID = 442,
    RoleName = "AvgRole_1444_RoleName|希莱斯特NF",
    AwakerResource = "O09_NF"
  },
  [1445] = {
    ID = 1445,
    CnID = "泰旖丝AF",
    BaseSortID = 443,
    RoleName = "AvgRole_1445_RoleName|泰旖丝AF",
    AwakerResource = "B01_AF"
  },
  [1446] = {
    ID = 1446,
    CnID = "萨尔瓦多AF",
    BaseSortID = 444,
    RoleName = "AvgRole_1446_RoleName|萨尔瓦多AF",
    AwakerResource = "B02_AF"
  },
  [1447] = {
    ID = 1447,
    CnID = "萨尔瓦多NF",
    BaseSortID = 445,
    RoleName = "AvgRole_1447_RoleName|萨尔瓦多NF",
    AwakerResource = "B02_NF"
  },
  [1448] = {
    ID = 1448,
    CnID = "艾继丝AF",
    BaseSortID = 446,
    RoleName = "AvgRole_1448_RoleName|艾继丝",
    Tittle = "AvgRole_1448_Tittle|济贫院孤儿",
    AwakerResource = "B03_AF"
  },
  [1449] = {
    ID = 1449,
    CnID = "艾继丝HF",
    BaseSortID = 447,
    RoleName = "AvgRole_1449_RoleName|艾继丝HF",
    AwakerResource = "B03_HF"
  },
  [1450] = {
    ID = 1450,
    CnID = "索蕾尔AF",
    BaseSortID = 448,
    RoleName = "AvgRole_1450_RoleName|索蕾尔AF",
    AwakerResource = "B04_AF"
  },
  [1451] = {
    ID = 1451,
    CnID = "索蕾尔NF",
    BaseSortID = 449,
    RoleName = "AvgRole_1451_RoleName|索蕾尔NF",
    AwakerResource = "B04_NF"
  },
  [1452] = {
    ID = 1452,
    CnID = "希洛AF",
    BaseSortID = 450,
    RoleName = "AvgRole_1452_RoleName|希洛AF",
    AwakerResource = "B05_AF"
  },
  [1453] = {
    ID = 1453,
    CnID = "希洛NF",
    BaseSortID = 451,
    RoleName = "AvgRole_1453_RoleName|希洛NF",
    AwakerResource = "B05_NF"
  },
  [1454] = {
    ID = 1454,
    CnID = "阿格里帕AF",
    BaseSortID = 452,
    RoleName = "AvgRole_1454_RoleName|阿格里帕AF",
    AwakerResource = "B06_AF"
  },
  [1455] = {
    ID = 1455,
    CnID = "阿格里帕HF",
    BaseSortID = 453,
    RoleName = "AvgRole_1455_RoleName|阿格里帕HF",
    AwakerResource = "B06_HF"
  },
  [1456] = {
    ID = 1456,
    CnID = "尤乌哈希AF",
    BaseSortID = 454,
    RoleName = "AvgRole_1456_RoleName|尤乌哈希AF",
    AwakerResource = "B07_AF"
  },
  [1457] = {
    ID = 1457,
    CnID = "尤乌哈希NF",
    BaseSortID = 455,
    RoleName = "AvgRole_1457_RoleName|尤乌哈希NF",
    AwakerResource = "B07_NF"
  },
  [1458] = {
    ID = 1458,
    CnID = "雷娅AF",
    BaseSortID = 456,
    RoleName = "AvgRole_1458_RoleName|雷娅AF",
    AwakerResource = "B08_AF"
  },
  [1459] = {
    ID = 1459,
    CnID = "菲茵特AF",
    BaseSortID = 457,
    RoleName = "AvgRole_1459_RoleName|菲茵特AF",
    AwakerResource = "B09_AF"
  },
  [1460] = {
    ID = 1460,
    CnID = "莉兹AF",
    BaseSortID = 458,
    RoleName = "AvgRole_1460_RoleName|莉兹AF",
    AwakerResource = "D01_AF"
  },
  [1461] = {
    ID = 1461,
    CnID = "莉兹NF",
    BaseSortID = 459,
    RoleName = "AvgRole_1461_RoleName|莉兹NF",
    AwakerResource = "D01_NF"
  },
  [1462] = {
    ID = 1462,
    CnID = "达芙黛尔AF",
    BaseSortID = 460,
    RoleName = "AvgRole_1462_RoleName|达芙黛尔AF",
    AwakerResource = "D02_AF"
  },
  [1463] = {
    ID = 1463,
    CnID = "达芙黛尔NF",
    BaseSortID = 461,
    RoleName = "AvgRole_1463_RoleName|达芙黛尔NF",
    AwakerResource = "D02_NF"
  },
  [1464] = {
    ID = 1464,
    CnID = "达芙黛尔HF",
    BaseSortID = 462,
    RoleName = "AvgRole_1464_RoleName|达芙黛尔HF",
    AwakerResource = "D02_HF"
  },
  [1465] = {
    ID = 1465,
    CnID = "汀克特AF",
    BaseSortID = 463,
    RoleName = "AvgRole_1465_RoleName|汀克特AF",
    AwakerResource = "D03_AF"
  },
  [1466] = {
    ID = 1466,
    CnID = "汀克特NF",
    BaseSortID = 464,
    RoleName = "AvgRole_1466_RoleName|汀克特",
    AwakerResource = "D03_NF"
  },
  [1467] = {
    ID = 1467,
    CnID = "旺达AF",
    BaseSortID = 465,
    RoleName = "AvgRole_1467_RoleName|旺达AF",
    AwakerResource = "D04_AF"
  },
  [1468] = {
    ID = 1468,
    CnID = "旺达NF",
    BaseSortID = 466,
    RoleName = "AvgRole_1468_RoleName|旺达NF",
    AwakerResource = "D04_NF"
  },
  [1469] = {
    ID = 1469,
    CnID = "温柯尔AF",
    BaseSortID = 467,
    RoleName = "AvgRole_1469_RoleName|温柯尔AF",
    AwakerResource = "D05_AF"
  },
  [1470] = {
    ID = 1470,
    CnID = "奥尔拉AF",
    BaseSortID = 468,
    RoleName = "AvgRole_1470_RoleName|奥尔拉AF",
    AwakerResource = "D06_AF"
  },
  [1471] = {
    ID = 1471,
    CnID = "奥尔拉NF",
    BaseSortID = 469,
    RoleName = "AvgRole_1471_RoleName|奥尔拉NF",
    AwakerResource = "D06_NF"
  },
  [1472] = {
    ID = 1472,
    CnID = "奥尔拉HF",
    BaseSortID = 470,
    RoleName = "AvgRole_1472_RoleName|奥尔拉HF",
    AwakerResource = "D06_HF"
  },
  [1473] = {
    ID = 1473,
    CnID = "詹金AF",
    BaseSortID = 471,
    RoleName = "AvgRole_1473_RoleName|詹金AF",
    AwakerResource = "D07_AF"
  },
  [1474] = {
    ID = 1474,
    CnID = "詹金NF",
    BaseSortID = 472,
    RoleName = "AvgRole_1474_RoleName|詹金NF",
    AwakerResource = "D07_NF"
  },
  [1475] = {
    ID = 1475,
    CnID = "詹金HF",
    BaseSortID = 473,
    RoleName = "AvgRole_1475_RoleName|詹金HF",
    AwakerResource = "D07_HF"
  },
  [1476] = {
    ID = 1476,
    CnID = "艾瑞卡AF",
    BaseSortID = 474,
    RoleName = "AvgRole_1476_RoleName|艾瑞卡AF",
    AwakerResource = "D08_AF"
  },
  [1477] = {
    ID = 1477,
    CnID = "艾瑞卡NF",
    BaseSortID = 475,
    RoleName = "AvgRole_1477_RoleName|艾瑞卡NF",
    AwakerResource = "D08_NF"
  },
  [1478] = {
    ID = 1478,
    CnID = "艾瑞卡HF",
    BaseSortID = 476,
    RoleName = "AvgRole_1478_RoleName|艾瑞卡HF",
    AwakerResource = "D08_HF"
  },
  [1479] = {
    ID = 1479,
    CnID = "卡茜亚AF",
    BaseSortID = 477,
    RoleName = "AvgRole_1479_RoleName|卡茜亚AF",
    AwakerResource = "D09_AF"
  },
  [1480] = {
    ID = 1480,
    CnID = "卡茜亚NF",
    BaseSortID = 478,
    RoleName = "AvgRole_1480_RoleName|卡茜亚NF",
    AwakerResource = "D09_NF"
  },
  [1481] = {
    ID = 1481,
    CnID = "阿格里帕？",
    BaseSortID = 479,
    RoleName = "AvgRole_1481_RoleName|？？？",
    AwakerResource = "B06_AF"
  },
  [1482] = {
    ID = 1482,
    CnID = "老弗里曼1",
    BaseSortID = 480,
    RoleName = "AvgRole_1482_RoleName|老弗里曼",
    AwakerResource = "SpChar_Drunkard_NF"
  },
  [1483] = {
    ID = 1483,
    CnID = "老弗里曼2",
    BaseSortID = 481,
    RoleName = "AvgRole_1483_RoleName|老弗里曼",
    AwakerResource = "SpChar_Drunkard_NF"
  },
  [1484] = {
    ID = 1484,
    CnID = "老弗里曼3",
    BaseSortID = 482,
    RoleName = "AvgRole_1484_RoleName|老弗里曼",
    AwakerResource = "SpChar_Drunkard_NF"
  },
  [1485] = {
    ID = 1485,
    CnID = "测试拉蒙娜",
    BaseSortID = 483,
    RoleName = "AvgRole_1485_RoleName|拉蒙娜",
    Tittle = "AvgRole_1485_Tittle|测试员",
    AwakerResource = "C01_AF"
  },
  [1486] = {
    ID = 1486,
    CnID = "SpChar_PlayerM_NF",
    BaseSortID = 484,
    RoleName = "AvgRole_1486_RoleName|SpChar_PlayerM_NF",
    AwakerResource = "SpChar_PlayerM_NF"
  },
  [1487] = {
    ID = 1487,
    CnID = "SpChar_PlayerF_NF",
    BaseSortID = 485,
    RoleName = "AvgRole_1487_RoleName|SpChar_PlayerF_NF",
    AwakerResource = "SpChar_PlayerF_NF"
  },
  [1488] = {
    ID = 1488,
    CnID = "SpChar_Boy_NF",
    BaseSortID = 486,
    RoleName = "AvgRole_1488_RoleName|SpChar_Boy_NF",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1489] = {
    ID = 1489,
    CnID = "SpChar_Girl_NF",
    BaseSortID = 487,
    RoleName = "AvgRole_1489_RoleName|SpChar_Girl_NF",
    AwakerResource = "SpChar_Girl_NF"
  },
  [1490] = {
    ID = 1490,
    CnID = "SpChar_Male_NF",
    BaseSortID = 488,
    RoleName = "AvgRole_1490_RoleName|SpChar_Male_NF",
    AwakerResource = "SpChar_Male_NF"
  },
  [1491] = {
    ID = 1491,
    CnID = "SpChar_Female_NF",
    BaseSortID = 489,
    RoleName = "AvgRole_1491_RoleName|SpChar_Female_NF",
    AwakerResource = "SpChar_Female_NF"
  },
  [1492] = {
    ID = 1492,
    CnID = "SpChar_OldMale_NF",
    BaseSortID = 490,
    RoleName = "AvgRole_1492_RoleName|SpChar_OldMale_NF",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1493] = {
    ID = 1493,
    CnID = "SpChar_DisMale_NF",
    BaseSortID = 491,
    RoleName = "AvgRole_1493_RoleName|SpChar_DisMale_NF",
    AwakerResource = "SpChar_DisMale_NF"
  },
  [1494] = {
    ID = 1494,
    CnID = "SpChar_Alistair_NF",
    BaseSortID = 492,
    RoleName = "AvgRole_1494_RoleName|SpChar_Alistair_NF",
    AwakerResource = "SpChar_Alistair_NF"
  },
  [1495] = {
    ID = 1495,
    CnID = "SpChar_Herbert_NF",
    BaseSortID = 493,
    RoleName = "AvgRole_1495_RoleName|SpChar_Herbert_NF",
    AwakerResource = "SpChar_Herbert_NF"
  },
  [1496] = {
    ID = 1496,
    CnID = "SpChar_Czort_NF",
    BaseSortID = 494,
    RoleName = "AvgRole_1496_RoleName|SpChar_Czort_NF",
    AwakerResource = "SpChar_Czort_NF"
  },
  [1497] = {
    ID = 1497,
    CnID = "SpChar_Dexter_NF",
    BaseSortID = 495,
    RoleName = "AvgRole_1497_RoleName|SpChar_Dexter_NF",
    AwakerResource = "SpChar_Dexter_NF"
  },
  [1498] = {
    ID = 1498,
    CnID = "SpChar_William_NF",
    BaseSortID = 496,
    RoleName = "AvgRole_1498_RoleName|SpChar_William_NF",
    AwakerResource = "SpChar_William_NF"
  },
  [1499] = {
    ID = 1499,
    CnID = "SpChar_StudentDis_NF",
    BaseSortID = 497,
    RoleName = "AvgRole_1499_RoleName|SpChar_StudentDis_NF",
    AwakerResource = "SpChar_StudentDis_NF"
  },
  [1500] = {
    ID = 1500,
    CnID = "SpChar_InjuredRamona_NF",
    BaseSortID = 498,
    RoleName = "AvgRole_1500_RoleName|SpChar_InjuredRamona_NF",
    AwakerResource = "SpChar_InjuredRamona_NF"
  },
  [1501] = {
    ID = 1501,
    CnID = "SpChar_Hannah_NF",
    BaseSortID = 499,
    RoleName = "AvgRole_1501_RoleName|SpChar_Hannah_NF",
    AwakerResource = "SpChar_Hannah_NF"
  },
  [1502] = {
    ID = 1502,
    CnID = "SpChar_Sarah_NF",
    BaseSortID = 500,
    RoleName = "AvgRole_1502_RoleName|SpChar_Sarah_NF",
    AwakerResource = "SpChar_Sarah_NF"
  },
  [1503] = {
    ID = 1503,
    CnID = "SpChar_FemaleNurse_NF",
    BaseSortID = 501,
    RoleName = "AvgRole_1503_RoleName|SpChar_FemaleNurse_NF",
    AwakerResource = "SpChar_FemaleNurse_NF"
  },
  [1504] = {
    ID = 1504,
    CnID = "SpChar_Clementine_HF",
    BaseSortID = 502,
    RoleName = "AvgRole_1504_RoleName|SpChar_Clementine_HF",
    AwakerResource = "SpChar_Clementine_HF"
  },
  [1505] = {
    ID = 1505,
    CnID = "SpChar_Clementine_AF",
    BaseSortID = 503,
    RoleName = "AvgRole_1505_RoleName|SpChar_Clementine_AF",
    AwakerResource = "SpChar_Clementine_AF"
  },
  [1506] = {
    ID = 1506,
    CnID = "SpChar_RogersDoll_NF",
    BaseSortID = 504,
    RoleName = "AvgRole_1506_RoleName|SpChar_RogersDoll_NF",
    AwakerResource = "SpChar_RogersDoll_NF"
  },
  [1507] = {
    ID = 1507,
    CnID = "SpChar_Rogers_NF",
    BaseSortID = 505,
    RoleName = "AvgRole_1507_RoleName|SpChar_Rogers_NF",
    AwakerResource = "SpChar_Rogers_NF"
  },
  [1508] = {
    ID = 1508,
    CnID = "SpChar_RogersDisabled_NF",
    BaseSortID = 506,
    RoleName = "AvgRole_1508_RoleName|SpChar_RogersDisabled_NF",
    AwakerResource = "SpChar_RogersDisabled_NF"
  },
  [1509] = {
    ID = 1509,
    CnID = "SpChar_RogersEmpty_NF",
    BaseSortID = 507,
    RoleName = "AvgRole_1509_RoleName|SpChar_RogersEmpty_NF",
    AwakerResource = "SpChar_RogersEmpty_NF"
  },
  [1510] = {
    ID = 1510,
    CnID = "SpChar_LittleRogers_NF",
    BaseSortID = 508,
    RoleName = "AvgRole_1510_RoleName|SpChar_LittleRogers_NF",
    AwakerResource = "SpChar_LittleRogers_NF"
  },
  [1511] = {
    ID = 1511,
    CnID = "SpChar_TheWax_NF",
    BaseSortID = 509,
    RoleName = "AvgRole_1511_RoleName|SpChar_TheWax_NF",
    AwakerResource = "SpChar_TheWax_NF"
  },
  [1512] = {
    ID = 1512,
    CnID = "SpChar_Albino_NF",
    BaseSortID = 510,
    RoleName = "AvgRole_1512_RoleName|SpChar_Albino_NF",
    AwakerResource = "SpChar_Albino_NF"
  },
  [1513] = {
    ID = 1513,
    CnID = "SpChar_Brown_NF",
    BaseSortID = 511,
    RoleName = "AvgRole_1513_RoleName|SpChar_Brown_NF",
    AwakerResource = "SpChar_Brown_NF"
  },
  [1514] = {
    ID = 1514,
    CnID = "SpChar_FrancisCrazy_NF",
    BaseSortID = 512,
    RoleName = "AvgRole_1514_RoleName|SpChar_FrancisCrazy_NF",
    AwakerResource = "SpChar_FrancisCrazy_NF"
  },
  [1515] = {
    ID = 1515,
    CnID = "SpChar_FrancisNormal_NF",
    BaseSortID = 513,
    RoleName = "AvgRole_1515_RoleName|SpChar_FrancisNormal_NF",
    AwakerResource = "SpChar_FrancisNormal_NF"
  },
  [1516] = {
    ID = 1516,
    CnID = "SpChar_LittleMike_NF",
    BaseSortID = 514,
    RoleName = "AvgRole_1516_RoleName|SpChar_LittleMike_NF",
    AwakerResource = "SpChar_LittleMike_NF"
  },
  [1517] = {
    ID = 1517,
    CnID = "SpChar_Sculptor_NF",
    BaseSortID = 515,
    RoleName = "AvgRole_1517_RoleName|SpChar_Sculptor_NF",
    AwakerResource = "SpChar_Sculptor_NF"
  },
  [1518] = {
    ID = 1518,
    CnID = "SpChar_SculptorNorm_NF",
    BaseSortID = 516,
    RoleName = "AvgRole_1518_RoleName|SpChar_SculptorNorm_NF",
    AwakerResource = "SpChar_SculptorNorm_NF"
  },
  [1519] = {
    ID = 1519,
    CnID = "SpChar_MTCAgent_NF",
    BaseSortID = 517,
    RoleName = "AvgRole_1519_RoleName|SpChar_MTCAgent_NF",
    AwakerResource = "SpChar_MTCAgent_NF"
  },
  [1520] = {
    ID = 1520,
    CnID = "SpChar_Kum_NF",
    BaseSortID = 518,
    RoleName = "AvgRole_1520_RoleName|SpChar_Kum_NF",
    AwakerResource = "SpChar_Kum_NF"
  },
  [1521] = {
    ID = 1521,
    CnID = "SpChar_Lisa_NF",
    BaseSortID = 519,
    RoleName = "AvgRole_1521_RoleName|SpChar_Lisa_NF",
    AwakerResource = "SpChar_Lisa_NF"
  },
  [1522] = {
    ID = 1522,
    CnID = "SpChar_LisaMon_NF",
    BaseSortID = 520,
    RoleName = "AvgRole_1522_RoleName|SpChar_LisaMon_NF",
    AwakerResource = "SpChar_LisaMon_NF"
  },
  [1523] = {
    ID = 1523,
    CnID = "SpChar_LightLady_NF",
    BaseSortID = 521,
    RoleName = "AvgRole_1523_RoleName|SpChar_LightLady_NF",
    AwakerResource = "SpChar_LightLady_NF"
  },
  [1524] = {
    ID = 1524,
    CnID = "SpChar_Detective_NF",
    BaseSortID = 522,
    RoleName = "AvgRole_1524_RoleName|SpChar_Detective_NF",
    AwakerResource = "SpChar_Detective_NF"
  },
  [1525] = {
    ID = 1525,
    CnID = "SpChar_Murphy_NF",
    BaseSortID = 523,
    RoleName = "AvgRole_1525_RoleName|SpChar_Murphy_NF",
    AwakerResource = "SpChar_Murphy_NF"
  },
  [1526] = {
    ID = 1526,
    CnID = "SpChar_Bertrand_NF",
    BaseSortID = 524,
    RoleName = "AvgRole_1526_RoleName|SpChar_Bertrand_NF",
    AwakerResource = "SpChar_Bertrand_NF"
  },
  [1527] = {
    ID = 1527,
    CnID = "SpChar_Captain_NF",
    BaseSortID = 525,
    RoleName = "AvgRole_1527_RoleName|SpChar_Captain_NF",
    AwakerResource = "SpChar_Captain_NF"
  },
  [1528] = {
    ID = 1528,
    CnID = "SpChar_Lily_NF",
    BaseSortID = 526,
    RoleName = "AvgRole_1528_RoleName|SpChar_Lily_NF",
    AwakerResource = "SpChar_Lily_NF"
  },
  [1529] = {
    ID = 1529,
    CnID = "SpChar_Knight_NF",
    BaseSortID = 527,
    RoleName = "AvgRole_1529_RoleName|SpChar_Knight_NF",
    AwakerResource = "SpChar_Knight_NF"
  },
  [1530] = {
    ID = 1530,
    CnID = "SpChar_StoneSanga_NF",
    BaseSortID = 528,
    RoleName = "AvgRole_1530_RoleName|SpChar_StoneSanga_NF",
    AwakerResource = "SpChar_StoneSanga_NF"
  },
  [1531] = {
    ID = 1531,
    CnID = "SpChar_SkullHunter1_NF",
    BaseSortID = 529,
    RoleName = "AvgRole_1531_RoleName|SpChar_SkullHunter1_NF",
    AwakerResource = "SpChar_SkullHunter1_NF"
  },
  [1532] = {
    ID = 1532,
    CnID = "SpChar_SkullHunter2_NF",
    BaseSortID = 530,
    RoleName = "AvgRole_1532_RoleName|SpChar_SkullHunter2_NF",
    AwakerResource = "SpChar_SkullHunter2_NF"
  },
  [1533] = {
    ID = 1533,
    CnID = "SpChar_May_NF",
    BaseSortID = 531,
    RoleName = "AvgRole_1533_RoleName|SpChar_May_NF",
    AwakerResource = "SpChar_May_NF"
  },
  [1534] = {
    ID = 1534,
    CnID = "SpChar_Researcher_NF",
    BaseSortID = 532,
    RoleName = "AvgRole_1534_RoleName|SpChar_Researcher_NF",
    AwakerResource = "SpChar_Researcher_NF"
  },
  [1535] = {
    ID = 1535,
    CnID = "SpChar_Gladiator_NF",
    BaseSortID = 533,
    RoleName = "AvgRole_1535_RoleName|SpChar_Gladiator_NF",
    AwakerResource = "SpChar_Gladiator_NF"
  },
  [1536] = {
    ID = 1536,
    CnID = "SpChar_Drunkard_NF",
    BaseSortID = 534,
    RoleName = "AvgRole_1536_RoleName|SpChar_Drunkard_NF",
    AwakerResource = "SpChar_Drunkard_NF"
  },
  [1537] = {
    ID = 1537,
    CnID = "SpChar_Witch_NF",
    BaseSortID = 535,
    RoleName = "AvgRole_1537_RoleName|SpChar_Witch_NF",
    AwakerResource = "SpChar_Witch_NF"
  },
  [1538] = {
    ID = 1538,
    CnID = "SpChar_Maid_NF",
    BaseSortID = 536,
    RoleName = "AvgRole_1538_RoleName|SpChar_Maid_NF",
    AwakerResource = "SpChar_Maid_NF"
  },
  [1539] = {
    ID = 1539,
    CnID = "SpChar_Grandma_NF",
    BaseSortID = 537,
    RoleName = "AvgRole_1539_RoleName|SpChar_Grandma_NF",
    AwakerResource = "SpChar_Grandma_NF"
  },
  [1540] = {
    ID = 1540,
    CnID = "SpChar_Sylvia_NF",
    BaseSortID = 538,
    RoleName = "AvgRole_1540_RoleName|SpChar_Sylvia_NF",
    AwakerResource = "SpChar_Sylvia_NF"
  },
  [1541] = {
    ID = 1541,
    CnID = "SpChar_MaskMan_NF",
    BaseSortID = 539,
    RoleName = "AvgRole_1541_RoleName|SpChar_MaskMan_NF",
    AwakerResource = "SpChar_MaskMan_NF"
  },
  [1542] = {
    ID = 1542,
    CnID = "SpChar_N_NF",
    BaseSortID = 540,
    RoleName = "AvgRole_1542_RoleName|SpChar_N_NF",
    AwakerResource = "SpChar_N_NF"
  },
  [1543] = {
    ID = 1543,
    CnID = "无头哈莉特",
    BaseSortID = 541,
    RoleName = "AvgRole_1543_RoleName|「哈莉特」",
    AwakerResource = "SpChar_SkullHunter2_NF"
  },
  [1544] = {
    ID = 1544,
    CnID = "艾瑞卡人形",
    BaseSortID = 542,
    RoleName = "AvgRole_1544_RoleName|艾瑞卡",
    AwakerResource = "D08_HF"
  },
  [1545] = {
    ID = 1545,
    CnID = "高级蹈海者",
    BaseSortID = 543,
    RoleName = "AvgRole_1545_RoleName|蹈海者",
    Tittle = "AvgRole_1545_Tittle|亲卫",
    HeadIcon = "Portrait_Small_Monster_C0502_BOSSSIZE",
    Sign = "AvgRole_1545_Sign|Portrait_Small_Monster_C0502_BOSSSIZE"
  },
  [1546] = {
    ID = 1546,
    CnID = "少年维特",
    BaseSortID = 544,
    RoleName = "AvgRole_1546_RoleName|少年维特",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1547] = {
    ID = 1547,
    CnID = "「泼尼」",
    BaseSortID = 545,
    RoleName = "AvgRole_1547_RoleName|「泼尼」",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1548] = {
    ID = 1548,
    CnID = "？？？（婆婆）",
    BaseSortID = 546,
    RoleName = "AvgRole_1548_RoleName|老妇人",
    AwakerResource = "SpChar_Grandma_NF"
  },
  [1549] = {
    ID = 1549,
    CnID = "贝蒂婆婆",
    BaseSortID = 547,
    RoleName = "AvgRole_1549_RoleName|贝蒂婆婆",
    AwakerResource = "SpChar_Grandma_NF"
  },
  [1550] = {
    ID = 1550,
    CnID = "阿格里帕人形",
    BaseSortID = 548,
    RoleName = "AvgRole_1550_RoleName|阿格里帕",
    AwakerResource = "B06_HF"
  },
  [1551] = {
    ID = 1551,
    CnID = "幽灵珊",
    BaseSortID = 549,
    RoleName = "AvgRole_1551_RoleName|济贫院幽灵",
    AwakerResource = "O08_NF"
  },
  [1552] = {
    ID = 1552,
    CnID = "疗养院护工",
    BaseSortID = 550,
    RoleName = "AvgRole_1552_RoleName|护工",
    Tittle = "AvgRole_1552_Tittle|疗养院护工",
    AwakerResource = "SpChar_Male_NF"
  },
  [1553] = {
    ID = 1553,
    CnID = "詹金唤醒体",
    BaseSortID = 551,
    RoleName = "AvgRole_1553_RoleName|詹金",
    Tittle = "AvgRole_1553_Tittle|伦蒂尼恩第一神偷（自封）",
    AwakerResource = "D07_NF",
    Sign = "AvgRole_1553_Sign|伦蒂尼恩第一神偷在此！"
  },
  [1554] = {
    ID = 1554,
    CnID = "蝴蝶",
    BaseSortID = 552,
    RoleName = "AvgRole_1554_RoleName|蝴蝶",
    AwakerResource = "SpChar_ButterflyFemale_NF"
  },
  [1555] = {
    ID = 1555,
    CnID = "西岱市民",
    BaseSortID = 553,
    RoleName = "AvgRole_1555_RoleName|西岱市民",
    AwakerResource = "SpChar_BeeMale_NF"
  },
  [1556] = {
    ID = 1556,
    CnID = "毛毛虫",
    BaseSortID = 554,
    RoleName = "AvgRole_1556_RoleName|毛毛虫",
    AwakerResource = "SpChar_BeeMale_NF"
  },
  [1557] = {
    ID = 1557,
    CnID = "画家",
    BaseSortID = 555,
    RoleName = "AvgRole_1557_RoleName|画家",
    AwakerResource = "SpChar_BeeMale_NF"
  },
  [1558] = {
    ID = 1558,
    CnID = "柯蕾特",
    BaseSortID = 556,
    RoleName = "AvgRole_1558_RoleName|柯蕾特",
    AwakerResource = "SpChar_ChildColette1_NF"
  },
  [1559] = {
    ID = 1559,
    CnID = "怪物A",
    BaseSortID = 557,
    RoleName = "AvgRole_1559_RoleName|愚蠢的怪物",
    AwakerResource = "SpChar_ButterflyFemale_NF"
  },
  [1560] = {
    ID = 1560,
    CnID = "怪物B",
    BaseSortID = 558,
    RoleName = "AvgRole_1560_RoleName|暴躁的怪物",
    AwakerResource = "SpChar_BeeMale_NF"
  },
  [1561] = {
    ID = 1561,
    CnID = "邻居A",
    BaseSortID = 559,
    RoleName = "AvgRole_1561_RoleName|邻居A",
    AwakerResource = "SpChar_Male_NF"
  },
  [1562] = {
    ID = 1562,
    CnID = "邻居B",
    BaseSortID = 560,
    RoleName = "AvgRole_1562_RoleName|邻居B",
    AwakerResource = "SpChar_Female_NF"
  },
  [1563] = {
    ID = 1563,
    CnID = "侍卫",
    BaseSortID = 561,
    RoleName = "AvgRole_1563_RoleName|侍卫",
    AwakerResource = "SpChar_Knight_NF"
  },
  [1564] = {
    ID = 1564,
    CnID = "敲钟人",
    BaseSortID = 562,
    RoleName = "AvgRole_1564_RoleName|敲钟人",
    AwakerResource = "SpChar_Drunkard_NF"
  },
  [1565] = {
    ID = 1565,
    CnID = "市民",
    BaseSortID = 563,
    RoleName = "AvgRole_1565_RoleName|市民",
    AwakerResource = "SpChar_Male_NF"
  },
  [1566] = {
    ID = 1566,
    CnID = "雕塑家协会成员",
    BaseSortID = 564,
    RoleName = "AvgRole_1566_RoleName|雕塑家协会成员",
    AwakerResource = "SpChar_Sculptor_NF"
  },
  [1567] = {
    ID = 1567,
    CnID = "市民A",
    BaseSortID = 565,
    RoleName = "AvgRole_1567_RoleName|市民A",
    AwakerResource = "SpChar_Female_NF"
  },
  [1568] = {
    ID = 1568,
    CnID = "市民B",
    BaseSortID = 566,
    RoleName = "AvgRole_1568_RoleName|市民B",
    AwakerResource = "SpChar_Male_NF"
  },
  [1569] = {
    ID = 1569,
    CnID = "守密人",
    BaseSortID = 567,
    RoleName = "AvgRole_1569_RoleName|<Yellow:%player%>",
    Tittle = "AvgRole_1569_Tittle|守密人",
    ShowAsPlayer = 1,
    AwakerResource = "SpChar_PlayerM_NF"
  },
  [1570] = {
    ID = 1570,
    CnID = "无纸奥尔拉",
    BaseSortID = 568,
    RoleName = "AvgRole_1570_RoleName|奥尔拉",
    AwakerResource = "D06_HF"
  },
  [1571] = {
    ID = 1571,
    CnID = "蹈海者2",
    BaseSortID = 569,
    RoleName = "AvgRole_1571_RoleName|蹈海者",
    HeadIcon = "Portrait_Small_Monster_C0503_BOSSSIZE",
    Sign = "AvgRole_1571_Sign|Portrait_Small_Monster_C0503_BOSSSIZE"
  },
  [1572] = {
    ID = 1572,
    CnID = "达芙黛尔店主",
    BaseSortID = 570,
    RoleName = "AvgRole_1572_RoleName|？？？",
    AwakerResource = "D02_HF"
  },
  [1573] = {
    ID = 1573,
    CnID = "奈亚？",
    BaseSortID = 571,
    RoleName = "AvgRole_1573_RoleName|？？？",
    AwakerResource = "SpChar_N_NF"
  },
  [1574] = {
    ID = 1574,
    CnID = "奈亚",
    BaseSortID = 572,
    RoleName = "AvgRole_1574_RoleName|「N」",
    AwakerResource = "SpChar_N_NF"
  },
  [1575] = {
    ID = 1575,
    CnID = "黑影",
    BaseSortID = 573,
    RoleName = "AvgRole_1575_RoleName|神秘阴影",
    AwakerResource = "SpChar_MaskMan_NF"
  },
  [1576] = {
    ID = 1576,
    CnID = "活泼的女声",
    BaseSortID = 574,
    RoleName = "AvgRole_1576_RoleName|活泼的女声",
    AwakerResource = "SpChar_Hannah_NF"
  },
  [1577] = {
    ID = 1577,
    CnID = "神父",
    BaseSortID = 575,
    RoleName = "AvgRole_1577_RoleName|葬礼司仪",
    AwakerResource = "SpChar_Male_NF"
  },
  [1578] = {
    ID = 1578,
    CnID = "哈罗德公爵",
    BaseSortID = 576,
    RoleName = "AvgRole_1578_RoleName|哈罗德公爵",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1579] = {
    ID = 1579,
    CnID = "名流A",
    BaseSortID = 577,
    RoleName = "AvgRole_1579_RoleName|名流A",
    AwakerResource = "SpChar_Male_NF"
  },
  [1580] = {
    ID = 1580,
    CnID = "名流B",
    BaseSortID = 578,
    RoleName = "AvgRole_1580_RoleName|名流B",
    AwakerResource = "SpChar_Female_NF"
  },
  [1581] = {
    ID = 1581,
    CnID = "名流C",
    BaseSortID = 579,
    RoleName = "AvgRole_1581_RoleName|名流C",
    AwakerResource = "SpChar_Male_NF"
  },
  [1582] = {
    ID = 1582,
    CnID = "管家",
    BaseSortID = 580,
    RoleName = "AvgRole_1582_RoleName|管家",
    Tittle = "AvgRole_1582_Tittle|哈罗德的管家",
    AwakerResource = "SpChar_Male_NF"
  },
  [1583] = {
    ID = 1583,
    CnID = "警探A",
    BaseSortID = 581,
    RoleName = "AvgRole_1583_RoleName|年长警探",
    AwakerResource = "SpChar_Detective_NF"
  },
  [1584] = {
    ID = 1584,
    CnID = "警探B",
    BaseSortID = 582,
    RoleName = "AvgRole_1584_RoleName|年轻女警探",
    AwakerResource = "SpChar_Female_NF"
  },
  [1585] = {
    ID = 1585,
    CnID = "警探C",
    BaseSortID = 583,
    RoleName = "AvgRole_1585_RoleName|年轻男警探",
    AwakerResource = "SpChar_Male_NF"
  },
  [1586] = {
    ID = 1586,
    CnID = "路人A",
    BaseSortID = 584,
    RoleName = "AvgRole_1586_RoleName|楼下的宾客",
    AwakerResource = "SpChar_Female_NF"
  },
  [1587] = {
    ID = 1587,
    CnID = "路人B",
    BaseSortID = 585,
    RoleName = "AvgRole_1587_RoleName|包厢的宾客",
    AwakerResource = "SpChar_Male_NF"
  },
  [1588] = {
    ID = 1588,
    CnID = "路人C",
    BaseSortID = 586,
    RoleName = "AvgRole_1588_RoleName|剧院工作人员",
    AwakerResource = "SpChar_Male_NF"
  },
  [1589] = {
    ID = 1589,
    CnID = "尼古拉斯",
    BaseSortID = 587,
    RoleName = "AvgRole_1589_RoleName|尼古拉斯",
    Tittle = "AvgRole_1589_Tittle|哈罗德之子",
    AwakerResource = "SpChar_Male_NF"
  },
  [1590] = {
    ID = 1590,
    CnID = "聒噪的少女",
    BaseSortID = 588,
    RoleName = "AvgRole_1590_RoleName|聒噪的少女",
    AwakerResource = "SpChar_Female_NF"
  },
  [1591] = {
    ID = 1591,
    CnID = "保镖",
    BaseSortID = 589,
    RoleName = "AvgRole_1591_RoleName|保镖",
    AwakerResource = "SpChar_Male_NF"
  },
  [1592] = {
    ID = 1592,
    CnID = "神秘男子",
    BaseSortID = 590,
    RoleName = "AvgRole_1592_RoleName|神秘男子",
    AwakerResource = "SpChar_Male_NF"
  },
  [1593] = {
    ID = 1593,
    CnID = "茜尔维娅",
    BaseSortID = 591,
    RoleName = "AvgRole_1593_RoleName|茜尔维娅",
    Tittle = "AvgRole_1593_Tittle|弥萨格心理咨询师",
    AwakerResource = "SpChar_Sylvia_NF"
  },
  [1594] = {
    ID = 1594,
    CnID = "和蔼的乡绅",
    BaseSortID = 592,
    RoleName = "AvgRole_1594_RoleName|和蔼的乡绅",
    AwakerResource = "SpChar_Male_NF"
  },
  [1595] = {
    ID = 1595,
    CnID = "少女索蕾尔",
    BaseSortID = 593,
    RoleName = "AvgRole_1595_RoleName|少女索蕾尔",
    AwakerResource = "B04_NF"
  },
  [1596] = {
    ID = 1596,
    CnID = "哭泣的妇人",
    BaseSortID = 594,
    RoleName = "AvgRole_1596_RoleName|哭泣的妇人",
    AwakerResource = "SpChar_Female_NF"
  },
  [1597] = {
    ID = 1597,
    CnID = "朗贝尔",
    BaseSortID = 595,
    RoleName = "AvgRole_1597_RoleName|朗贝尔",
    Tittle = "AvgRole_1597_Tittle|索蕾尔之父",
    AwakerResource = "SpChar_Lambert_NF"
  },
  [1598] = {
    ID = 1598,
    CnID = "异变索蕾尔",
    BaseSortID = 596,
    RoleName = "AvgRole_1598_RoleName|异变索蕾尔",
    AwakerResource = "B04_NF"
  },
  [1599] = {
    ID = 1599,
    CnID = "民众A",
    BaseSortID = 597,
    RoleName = "AvgRole_1599_RoleName|年轻市民",
    AwakerResource = "SpChar_Male_NF"
  },
  [1600] = {
    ID = 1600,
    CnID = "民众B",
    BaseSortID = 598,
    RoleName = "AvgRole_1600_RoleName|年长市民",
    AwakerResource = "SpChar_Female_NF"
  },
  [1601] = {
    ID = 1601,
    CnID = "屁民A",
    BaseSortID = 599,
    RoleName = "AvgRole_1601_RoleName|狂热市民",
    AwakerResource = "SpChar_Male_NF"
  },
  [1602] = {
    ID = 1602,
    CnID = "屁民B",
    BaseSortID = 600,
    RoleName = "AvgRole_1602_RoleName|聒噪市民",
    AwakerResource = "SpChar_Female_NF"
  },
  [1603] = {
    ID = 1603,
    CnID = "屁民C",
    BaseSortID = 601,
    RoleName = "AvgRole_1603_RoleName|爽朗市民",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1604] = {
    ID = 1604,
    CnID = "奥瑞塔？",
    BaseSortID = 602,
    RoleName = "AvgRole_1604_RoleName|？？？",
    AwakerResource = "O05_NF"
  },
  [1605] = {
    ID = 1605,
    CnID = "蹈海者少年",
    BaseSortID = 603,
    RoleName = "AvgRole_1605_RoleName|蹈海者少年",
    AwakerResource = "O04_AF"
  },
  [1606] = {
    ID = 1606,
    CnID = "少年",
    BaseSortID = 604,
    RoleName = "AvgRole_1606_RoleName|少年",
    AwakerResource = "SpChar_Male_NF"
  },
  [1607] = {
    ID = 1607,
    CnID = "鱼头怪物",
    BaseSortID = 605,
    RoleName = "AvgRole_1607_RoleName|怪物"
  },
  [1608] = {
    ID = 1608,
    CnID = "提灯女性1",
    BaseSortID = 606,
    RoleName = "AvgRole_1608_RoleName|女性教徒",
    AwakerResource = "SpChar_LightLady_NF"
  },
  [1609] = {
    ID = 1609,
    CnID = "朗贝尔？",
    BaseSortID = 607,
    RoleName = "AvgRole_1609_RoleName|神秘老者",
    AwakerResource = "SpChar_Lambert_NF"
  },
  [1610] = {
    ID = 1610,
    CnID = "丽贝卡",
    BaseSortID = 608,
    RoleName = "AvgRole_1610_RoleName|丽贝卡",
    Tittle = "AvgRole_1610_Tittle|索蕾尔之母",
    AwakerResource = "SpChar_Female_NF"
  },
  [1611] = {
    ID = 1611,
    CnID = "战士A",
    BaseSortID = 609,
    RoleName = "AvgRole_1611_RoleName|年轻战士",
    Tittle = "AvgRole_1611_Tittle|非利士战士",
    AwakerResource = "SpChar_Gladiator_NF"
  },
  [1612] = {
    ID = 1612,
    CnID = "战士B",
    BaseSortID = 610,
    RoleName = "AvgRole_1612_RoleName|年长战士",
    Tittle = "AvgRole_1612_Tittle|非利士战士",
    AwakerResource = "SpChar_Gladiator_NF"
  },
  [1613] = {
    ID = 1613,
    CnID = "以格伦？",
    BaseSortID = 611,
    RoleName = "AvgRole_1613_RoleName|？？？",
    AwakerResource = "SpChar_Iglen_NF"
  },
  [1614] = {
    ID = 1614,
    CnID = "神秘的女声",
    BaseSortID = 612,
    RoleName = "AvgRole_1614_RoleName|神秘的女声",
    AwakerResource = "D04_AF"
  },
  [1615] = {
    ID = 1615,
    CnID = "低沉的男声",
    BaseSortID = 613,
    RoleName = "AvgRole_1615_RoleName|低沉的男声",
    AwakerResource = "SpChar_Male_NF"
  },
  [1616] = {
    ID = 1616,
    CnID = "侍从",
    BaseSortID = 614,
    RoleName = "AvgRole_1616_RoleName|侍从",
    AwakerResource = "SpChar_Female_NF"
  },
  [1617] = {
    ID = 1617,
    CnID = "不死者仆从A",
    BaseSortID = 615,
    RoleName = "AvgRole_1617_RoleName|盲眼侍从",
    AwakerResource = "SpChar_UndeadServant1_NF"
  },
  [1618] = {
    ID = 1618,
    CnID = "不死者仆从B",
    BaseSortID = 616,
    RoleName = "AvgRole_1618_RoleName|无头侍从",
    AwakerResource = "SpChar_UndeadServant2_NF"
  },
  [1619] = {
    ID = 1619,
    CnID = "苏珊娜的父亲",
    BaseSortID = 617,
    RoleName = "AvgRole_1619_RoleName|老者",
    Tittle = "AvgRole_1619_Tittle|苏珊娜的父亲",
    AwakerResource = "SpChar_Drunkard_NF"
  },
  [1620] = {
    ID = 1620,
    CnID = "男村民",
    BaseSortID = 618,
    RoleName = "AvgRole_1620_RoleName|男村民",
    AwakerResource = "SpChar_Male_NF"
  },
  [1621] = {
    ID = 1621,
    CnID = "女村民",
    BaseSortID = 619,
    RoleName = "AvgRole_1621_RoleName|女村民",
    AwakerResource = "SpChar_Female_NF"
  },
  [1622] = {
    ID = 1622,
    CnID = "古德里安伯爵",
    BaseSortID = 620,
    RoleName = "AvgRole_1622_RoleName|古德里安伯爵",
    AwakerResource = "SpChar_Male_NF"
  },
  [1623] = {
    ID = 1623,
    CnID = "骑士",
    BaseSortID = 621,
    RoleName = "AvgRole_1623_RoleName|骑士",
    Tittle = "AvgRole_1623_Tittle|古德里安的骑士",
    AwakerResource = "SpChar_Knight_NF"
  },
  [1624] = {
    ID = 1624,
    CnID = "小贝克曼？",
    BaseSortID = 622,
    RoleName = "AvgRole_1624_RoleName|脏兮兮的男孩",
    AwakerResource = "SpChar_LittleMike_NF"
  },
  [1625] = {
    ID = 1625,
    CnID = "异变村民A",
    BaseSortID = 623,
    RoleName = "AvgRole_1625_RoleName|异变农夫",
    AwakerResource = "SpChar_Male_NF"
  },
  [1626] = {
    ID = 1626,
    CnID = "异变村民B",
    BaseSortID = 624,
    RoleName = "AvgRole_1626_RoleName|异变农妇",
    AwakerResource = "SpChar_Female_NF"
  },
  [1627] = {
    ID = 1627,
    CnID = "旺达的侍女",
    BaseSortID = 625,
    RoleName = "AvgRole_1627_RoleName|苏珊娜",
    Tittle = "AvgRole_1627_Tittle|旺达的贴身侍女",
    AwakerResource = "SpChar_Maid_NF"
  },
  [1628] = {
    ID = 1628,
    CnID = "小贝克曼",
    BaseSortID = 626,
    RoleName = "AvgRole_1628_RoleName|小贝克曼",
    Tittle = "AvgRole_1628_Tittle|苏珊娜的弟弟",
    AwakerResource = "SpChar_LittleMike_NF"
  },
  [1629] = {
    ID = 1629,
    CnID = "苏珊娜的父亲？",
    BaseSortID = 627,
    RoleName = "AvgRole_1629_RoleName|角落里的老者",
    AwakerResource = "SpChar_Drunkard_NF"
  },
  [1630] = {
    ID = 1630,
    CnID = "黑暗中的眼睛1",
    BaseSortID = 628,
    AwakerResource = "SpChar_SkullHunter1_NF"
  },
  [1631] = {
    ID = 1631,
    CnID = "黑暗中的眼睛2",
    BaseSortID = 629,
    AwakerResource = "SpChar_SkullHunter1_NF"
  },
  [1632] = {
    ID = 1632,
    CnID = "黑暗中的眼睛3",
    BaseSortID = 630,
    AwakerResource = "SpChar_SkullHunter1_NF"
  },
  [1633] = {
    ID = 1633,
    CnID = "熟悉的声音",
    BaseSortID = 631,
    RoleName = "AvgRole_1633_RoleName|熟悉的声音",
    ShowAsPlayer = 1,
    AwakerResource = "SpChar_PlayerM_NF"
  },
  [1634] = {
    ID = 1634,
    CnID = "不耐烦的少女",
    BaseSortID = 632,
    RoleName = "AvgRole_1634_RoleName|不耐烦的少女",
    AwakerResource = "SpChar_Murphy_NF"
  },
  [1635] = {
    ID = 1635,
    CnID = "友人",
    BaseSortID = 633,
    RoleName = "AvgRole_1635_RoleName|友人",
    AwakerResource = "SpChar_Male_NF"
  },
  [1636] = {
    ID = 1636,
    CnID = "大副",
    BaseSortID = 634,
    RoleName = "AvgRole_1636_RoleName|大副",
    AwakerResource = "SpChar_Male_NF"
  },
  [1637] = {
    ID = 1637,
    CnID = "轮机长",
    BaseSortID = 635,
    RoleName = "AvgRole_1637_RoleName|轮机长",
    AwakerResource = "SpChar_Male_NF"
  },
  [1638] = {
    ID = 1638,
    CnID = "？？？（墨菲）",
    BaseSortID = 636,
    RoleName = "AvgRole_1638_RoleName|？？？",
    AwakerResource = "SpChar_Murphy_NF"
  },
  [1639] = {
    ID = 1639,
    CnID = "？？？（弥利亚姆）",
    BaseSortID = 637,
    RoleName = "AvgRole_1639_RoleName|？？？",
    AwakerResource = "O07_NF"
  },
  [1640] = {
    ID = 1640,
    CnID = "@4的声音",
    BaseSortID = 638,
    RoleName = "AvgRole_1640_RoleName|@4的声音"
  },
  [1641] = {
    ID = 1641,
    CnID = "不死者仆从C",
    BaseSortID = 639,
    RoleName = "AvgRole_1641_RoleName|盲眼侍从",
    AwakerResource = "SpChar_UndeadServant3_NF"
  },
  [1642] = {
    ID = 1642,
    CnID = "影子24",
    BaseSortID = 640,
    RoleName = "AvgRole_1642_RoleName|影子「24」",
    AwakerResource = "SpChar_ShadowMason_NF"
  },
  [1643] = {
    ID = 1643,
    CnID = "学者24",
    BaseSortID = 641,
    RoleName = "AvgRole_1643_RoleName|学者「24」",
    AwakerResource = "SpChar_ScholarMason_NF"
  },
  [1644] = {
    ID = 1644,
    CnID = "阿尔比诺？",
    BaseSortID = 642,
    RoleName = "AvgRole_1644_RoleName|？？？",
    AwakerResource = "SpChar_Albino_NF"
  },
  [1645] = {
    ID = 1645,
    CnID = "小丑24",
    BaseSortID = 643,
    RoleName = "AvgRole_1645_RoleName|小丑「24」",
    AwakerResource = "SpChar_JokerMason_NF"
  },
  [1646] = {
    ID = 1646,
    CnID = "怪物詹金",
    BaseSortID = 644,
    RoleName = "AvgRole_1646_RoleName|怪物詹金",
    AwakerResource = "D07_NF"
  },
  [1647] = {
    ID = 1647,
    CnID = "缺牙汤姆",
    BaseSortID = 645,
    RoleName = "AvgRole_1647_RoleName|缺牙汤姆",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1648] = {
    ID = 1648,
    CnID = "猫咪24",
    BaseSortID = 646,
    RoleName = "AvgRole_1648_RoleName|猫咪「24」",
    AwakerResource = "SpChar_CatMason_NF"
  },
  [1649] = {
    ID = 1649,
    CnID = "模糊的声音",
    BaseSortID = 647,
    RoleName = "AvgRole_1649_RoleName|模糊的声音"
  },
  [1650] = {
    ID = 1650,
    CnID = "潘狄娅",
    BaseSortID = 648,
    RoleName = "AvgRole_1650_RoleName|潘狄娅",
    AwakerResource = "C09_NF",
    Sign = "AvgRole_1650_Sign|享受疼痛的宠爱吧~"
  },
  [1651] = {
    ID = 1651,
    CnID = "索菲亚",
    BaseSortID = 649,
    RoleName = "AvgRole_1651_RoleName|索菲亚",
    AwakerResource = "SpChar_Sophia_NF"
  },
  [1652] = {
    ID = 1652,
    CnID = "持镜索菲亚",
    BaseSortID = 650,
    RoleName = "AvgRole_1652_RoleName|索菲亚",
    AwakerResource = "SpChar_SophiaMirror_NF"
  },
  [1653] = {
    ID = 1653,
    CnID = "年轻男人",
    BaseSortID = 651,
    RoleName = "AvgRole_1653_RoleName|年轻男人",
    AwakerResource = "SpChar_Male_NF"
  },
  [1654] = {
    ID = 1654,
    CnID = "好奇的市民",
    BaseSortID = 652,
    RoleName = "AvgRole_1654_RoleName|好奇的市民",
    AwakerResource = "SpChar_Male_NF"
  },
  [1655] = {
    ID = 1655,
    CnID = "凑热闹的市民",
    BaseSortID = 653,
    RoleName = "AvgRole_1655_RoleName|凑热闹的市民",
    AwakerResource = "SpChar_Female_NF"
  },
  [1656] = {
    ID = 1656,
    CnID = "围观的市民",
    BaseSortID = 654,
    RoleName = "AvgRole_1656_RoleName|围观的市民",
    AwakerResource = "SpChar_Female_NF"
  },
  [1657] = {
    ID = 1657,
    CnID = "爱德华",
    BaseSortID = 655,
    RoleName = "AvgRole_1657_RoleName|爱德华",
    AwakerResource = "SpChar_Male_NF"
  },
  [1658] = {
    ID = 1658,
    CnID = "愤怒的市民",
    BaseSortID = 656,
    RoleName = "AvgRole_1658_RoleName|愤怒的市民",
    AwakerResource = "SpChar_Male_NF"
  },
  [1659] = {
    ID = 1659,
    CnID = "粗鲁的市民",
    BaseSortID = 657,
    RoleName = "AvgRole_1659_RoleName|粗鲁的市民",
    AwakerResource = "SpChar_Female_NF"
  },
  [1660] = {
    ID = 1660,
    CnID = "市民们",
    BaseSortID = 658,
    RoleName = "AvgRole_1660_RoleName|市民们",
    AwakerResource = "SpChar_Female_NF"
  },
  [1661] = {
    ID = 1661,
    CnID = "敲门的市民",
    BaseSortID = 659,
    RoleName = "AvgRole_1661_RoleName|敲门的市民",
    AwakerResource = "SpChar_Male_NF"
  },
  [1662] = {
    ID = 1662,
    CnID = "门外的市民们",
    BaseSortID = 660,
    RoleName = "AvgRole_1662_RoleName|门外的市民们",
    AwakerResource = "SpChar_Female_NF"
  },
  [1663] = {
    ID = 1663,
    CnID = "衣衫褴褛的市民",
    BaseSortID = 661,
    RoleName = "AvgRole_1663_RoleName|衣衫褴褛的市民",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1664] = {
    ID = 1664,
    CnID = "台阶上的市民",
    BaseSortID = 662,
    RoleName = "AvgRole_1664_RoleName|台阶上的市民",
    AwakerResource = "SpChar_Male_NF"
  },
  [1665] = {
    ID = 1665,
    CnID = "暴怒的市民",
    BaseSortID = 663,
    RoleName = "AvgRole_1665_RoleName|暴怒的市民",
    AwakerResource = "SpChar_Male_NF"
  },
  [1666] = {
    ID = 1666,
    CnID = "惊讶的市民",
    BaseSortID = 664,
    RoleName = "AvgRole_1666_RoleName|惊讶的市民",
    AwakerResource = "SpChar_Male_NF"
  },
  [1667] = {
    ID = 1667,
    CnID = "审查会探员A",
    BaseSortID = 665,
    RoleName = "AvgRole_1667_RoleName|干练的审查会探员",
    AwakerResource = "SpChar_MTCAgent_NF"
  },
  [1668] = {
    ID = 1668,
    CnID = "审查会探员B",
    BaseSortID = 666,
    RoleName = "AvgRole_1668_RoleName|麻利的审查会探员",
    AwakerResource = "SpChar_MTCAgent_NF"
  },
  [1669] = {
    ID = 1669,
    CnID = "警官A",
    BaseSortID = 667,
    RoleName = "AvgRole_1669_RoleName|中年警官",
    AwakerResource = "SpChar_Detective_NF"
  },
  [1670] = {
    ID = 1670,
    CnID = "警官B",
    BaseSortID = 668,
    RoleName = "AvgRole_1670_RoleName|青年警官",
    AwakerResource = "SpChar_Detective_NF"
  },
  [1671] = {
    ID = 1671,
    CnID = "律师",
    BaseSortID = 669,
    RoleName = "AvgRole_1671_RoleName|律师",
    AwakerResource = "SpChar_Male_NF"
  },
  [1672] = {
    ID = 1672,
    CnID = "奥利维亚",
    BaseSortID = 670,
    RoleName = "AvgRole_1672_RoleName|奥利维亚",
    Tittle = "AvgRole_1672_Tittle|索菲亚的姐姐",
    AwakerResource = "SpChar_FemaleNurse_NF"
  },
  [1673] = {
    ID = 1673,
    CnID = "索菲亚怪",
    BaseSortID = 671,
    RoleName = "AvgRole_1673_RoleName|索@1亚",
    AwakerResource = "SpChar_Female_NF"
  },
  [1674] = {
    ID = 1674,
    CnID = "市民C",
    BaseSortID = 672,
    RoleName = "AvgRole_1674_RoleName|市民C",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1675] = {
    ID = 1675,
    CnID = "索菲亚&爱德华",
    BaseSortID = 673,
    RoleName = "AvgRole_1675_RoleName|索菲亚&爱德华",
    AwakerResource = "SpChar_Male_NF"
  },
  [1676] = {
    ID = 1676,
    CnID = "审查会探员",
    BaseSortID = 674,
    RoleName = "AvgRole_1676_RoleName|审查会探员",
    AwakerResource = "SpChar_MTCAgent_NF"
  },
  [1677] = {
    ID = 1677,
    CnID = "拿着木棍的市民",
    BaseSortID = 675,
    RoleName = "AvgRole_1677_RoleName|拿着木棍的市民",
    AwakerResource = "SpChar_Male_NF"
  },
  [1678] = {
    ID = 1678,
    CnID = "汤普森",
    BaseSortID = 676,
    RoleName = "AvgRole_1678_RoleName|汤普森",
    AwakerResource = "SpChar_Drunkard_NF"
  },
  [1679] = {
    ID = 1679,
    CnID = "后排的市民",
    BaseSortID = 677,
    RoleName = "AvgRole_1679_RoleName|后排的市民",
    AwakerResource = "SpChar_Male_NF"
  },
  [1680] = {
    ID = 1680,
    CnID = "急切的市民",
    BaseSortID = 678,
    RoleName = "AvgRole_1680_RoleName|急切的市民",
    AwakerResource = "SpChar_Female_NF"
  },
  [1681] = {
    ID = 1681,
    CnID = "高大的市民",
    BaseSortID = 679,
    RoleName = "AvgRole_1681_RoleName|高大的市民",
    AwakerResource = "SpChar_Male_NF"
  },
  [1682] = {
    ID = 1682,
    CnID = "索菲亚母亲",
    BaseSortID = 680,
    RoleName = "AvgRole_1682_RoleName|查兹坦夫人",
    Tittle = "AvgRole_1682_Tittle|索菲亚的母亲",
    AwakerResource = "SpChar_LisaMon_NF"
  },
  [1683] = {
    ID = 1683,
    CnID = "汤普森？",
    BaseSortID = 681,
    RoleName = "AvgRole_1683_RoleName|？？？",
    AwakerResource = "SpChar_Drunkard_NF"
  },
  [1684] = {
    ID = 1684,
    CnID = "密境梅森",
    BaseSortID = 682,
    RoleName = "AvgRole_1684_RoleName|梅森",
    Tittle = "AvgRole_1684_Tittle|密境中的「24」",
    AwakerResource = "C06_NF"
  },
  [1685] = {
    ID = 1685,
    CnID = "于丽埃特？？",
    BaseSortID = 683,
    RoleName = "AvgRole_1685_RoleName|？？？",
    AwakerResource = "SpChar_Julliette_NF"
  },
  [1686] = {
    ID = 1686,
    CnID = "于丽埃特使者版",
    BaseSortID = 684,
    RoleName = "AvgRole_1686_RoleName|于丽埃特",
    Tittle = "AvgRole_1686_Tittle|亚兰使者",
    AwakerResource = "SpChar_Julliette_NF"
  },
  [1687] = {
    ID = 1687,
    CnID = "泰旖丝？",
    BaseSortID = 685,
    RoleName = "AvgRole_1687_RoleName|？？？",
    AwakerResource = "B01_AF"
  },
  [1688] = {
    ID = 1688,
    CnID = "亚兰人1",
    BaseSortID = 686,
    RoleName = "AvgRole_1688_RoleName|殷勤的亚兰人",
    AwakerResource = "SpChar_AramWoman_NF"
  },
  [1689] = {
    ID = 1689,
    CnID = "亚兰人2",
    BaseSortID = 687,
    RoleName = "AvgRole_1689_RoleName|欢快的亚兰人",
    AwakerResource = "SpChar_AramWoman_NF"
  },
  [1690] = {
    ID = 1690,
    CnID = "亚兰人3",
    BaseSortID = 688,
    RoleName = "AvgRole_1690_RoleName|紧张的亚兰人",
    AwakerResource = "SpChar_AramMan_NF"
  },
  [1691] = {
    ID = 1691,
    CnID = "艾尔瓦？",
    BaseSortID = 689,
    RoleName = "AvgRole_1691_RoleName|？？？",
    AwakerResource = "C11_AF"
  },
  [1692] = {
    ID = 1692,
    CnID = "倒酒的亚兰女性",
    BaseSortID = 690,
    RoleName = "AvgRole_1692_RoleName|倒酒的亚兰女性",
    AwakerResource = "SpChar_AramWoman_NF"
  },
  [1693] = {
    ID = 1693,
    CnID = "叹息的亚兰战士",
    BaseSortID = 691,
    RoleName = "AvgRole_1693_RoleName|叹息的亚兰战士",
    AwakerResource = "SpChar_AramMan_NF"
  },
  [1694] = {
    ID = 1694,
    CnID = "畅饮的亚兰战士",
    BaseSortID = 692,
    RoleName = "AvgRole_1694_RoleName|畅饮的亚兰战士",
    AwakerResource = "SpChar_AramMan_NF"
  },
  [1695] = {
    ID = 1695,
    CnID = "慌乱的亚兰人",
    BaseSortID = 693,
    RoleName = "AvgRole_1695_RoleName|慌乱的亚兰人",
    AwakerResource = "SpChar_AramWoman_NF"
  },
  [1696] = {
    ID = 1696,
    CnID = "亚兰族少年",
    BaseSortID = 694,
    RoleName = "AvgRole_1696_RoleName|亚兰族少年",
    AwakerResource = "SpChar_AramBoy_NF"
  },
  [1697] = {
    ID = 1697,
    CnID = "涅弗鲁瑞",
    BaseSortID = 695,
    RoleName = "AvgRole_1697_RoleName|涅弗鲁瑞",
    AwakerResource = "SpChar_AramBoy_NF"
  },
  [1698] = {
    ID = 1698,
    CnID = "油滑的男声",
    BaseSortID = 696,
    RoleName = "AvgRole_1698_RoleName|油滑的男声",
    AwakerResource = "SpChar_Male_NF"
  },
  [1699] = {
    ID = 1699,
    CnID = "衣着华丽的男人",
    BaseSortID = 697,
    RoleName = "AvgRole_1699_RoleName|衣着华丽的男人",
    AwakerResource = "SpChar_Male_NF"
  },
  [1700] = {
    ID = 1700,
    CnID = "妆容精致的女人",
    BaseSortID = 698,
    RoleName = "AvgRole_1700_RoleName|妆容精致的女人",
    AwakerResource = "SpChar_Female_NF"
  },
  [1701] = {
    ID = 1701,
    CnID = "穿金戴银的男人",
    BaseSortID = 699,
    RoleName = "AvgRole_1701_RoleName|穿金戴银的男人",
    AwakerResource = "SpChar_Male_NF"
  },
  [1702] = {
    ID = 1702,
    CnID = "舞者",
    BaseSortID = 700,
    RoleName = "AvgRole_1702_RoleName|舞者",
    AwakerResource = "SpChar_Female_NF"
  },
  [1703] = {
    ID = 1703,
    CnID = "？？？莉兹",
    BaseSortID = 701,
    RoleName = "AvgRole_1703_RoleName|？？？",
    AwakerResource = "D01_NF"
  },
  [1704] = {
    ID = 1704,
    CnID = "舞者A",
    BaseSortID = 702,
    RoleName = "AvgRole_1704_RoleName|艾利尔",
    Tittle = "AvgRole_1704_Tittle|舞者",
    AwakerResource = "SpChar_Female_NF"
  },
  [1705] = {
    ID = 1705,
    CnID = "舞者B",
    BaseSortID = 703,
    RoleName = "AvgRole_1705_RoleName|卡罗琳",
    Tittle = "AvgRole_1705_Tittle|舞者",
    AwakerResource = "SpChar_Female_NF"
  },
  [1706] = {
    ID = 1706,
    CnID = "舞者C",
    BaseSortID = 704,
    RoleName = "AvgRole_1706_RoleName|莱莎",
    Tittle = "AvgRole_1706_Tittle|舞者",
    AwakerResource = "SpChar_Female_NF"
  },
  [1707] = {
    ID = 1707,
    CnID = "舞团经理",
    BaseSortID = 705,
    RoleName = "AvgRole_1707_RoleName|杰拉德",
    Tittle = "AvgRole_1707_Tittle|舞团经理",
    AwakerResource = "SpChar_Male_NF"
  },
  [1708] = {
    ID = 1708,
    CnID = "SpChar_AramMan_NF",
    BaseSortID = 706,
    RoleName = "AvgRole_1708_RoleName|SpChar_AramMan_NF",
    AwakerResource = "SpChar_AramMan_NF"
  },
  [1709] = {
    ID = 1709,
    CnID = "SpChar_AramWoman_NF",
    BaseSortID = 707,
    RoleName = "AvgRole_1709_RoleName|SpChar_AramWoman_NF",
    AwakerResource = "SpChar_AramWoman_NF"
  },
  [1710] = {
    ID = 1710,
    CnID = "SpChar_CatMason_NF",
    BaseSortID = 708,
    RoleName = "AvgRole_1710_RoleName|SpChar_CatMason_NF",
    AwakerResource = "SpChar_CatMason_NF"
  },
  [1711] = {
    ID = 1711,
    CnID = "SpChar_ScholarMason_NF",
    BaseSortID = 709,
    RoleName = "AvgRole_1711_RoleName|SpChar_ScholarMason_NF",
    AwakerResource = "SpChar_ScholarMason_NF"
  },
  [1712] = {
    ID = 1712,
    CnID = "SpChar_JokerMason_NF",
    BaseSortID = 710,
    RoleName = "AvgRole_1712_RoleName|SpChar_JokerMason_NF",
    AwakerResource = "SpChar_JokerMason_NF"
  },
  [1713] = {
    ID = 1713,
    CnID = "SpChar_ShadowMason_NF",
    BaseSortID = 711,
    RoleName = "AvgRole_1713_RoleName|SpChar_ShadowMason_NF",
    AwakerResource = "SpChar_ShadowMason_NF"
  },
  [1714] = {
    ID = 1714,
    CnID = "SpChar_Iglen_NF",
    BaseSortID = 712,
    RoleName = "AvgRole_1714_RoleName|SpChar_Iglen_NF",
    AwakerResource = "SpChar_Iglen_NF"
  },
  [1715] = {
    ID = 1715,
    CnID = "幼年弥利亚姆",
    BaseSortID = 713,
    RoleName = "AvgRole_1715_RoleName|幼年弥利亚姆",
    AwakerResource = "SpChar_ChildMiliyam1_NF"
  },
  [1716] = {
    ID = 1716,
    CnID = "幼年弥利亚姆（脏）",
    BaseSortID = 714,
    RoleName = "AvgRole_1716_RoleName|幼年弥利亚姆",
    AwakerResource = "SpChar_ChildMiliyam2_NF"
  },
  [1717] = {
    ID = 1717,
    CnID = "少女弥利亚姆",
    BaseSortID = 715,
    RoleName = "AvgRole_1717_RoleName|弥利亚姆",
    AwakerResource = "Awaker_O07_NF"
  },
  [1718] = {
    ID = 1718,
    CnID = "伊诺斯？",
    BaseSortID = 716,
    RoleName = "AvgRole_1718_RoleName|？？？",
    AwakerResource = "SpChar_LemuriaEnos_NF"
  },
  [1719] = {
    ID = 1719,
    CnID = "伊诺斯",
    BaseSortID = 717,
    RoleName = "AvgRole_1719_RoleName|伊诺斯",
    AwakerResource = "SpChar_LemuriaEnos_NF"
  },
  [1720] = {
    ID = 1720,
    CnID = "萨拉",
    BaseSortID = 718,
    RoleName = "AvgRole_1720_RoleName|萨拉",
    AwakerResource = "SpChar_Girl_NF"
  },
  [1721] = {
    ID = 1721,
    CnID = "黛博拉",
    BaseSortID = 719,
    RoleName = "AvgRole_1721_RoleName|黛博拉",
    AwakerResource = "SpChar_Deborah_NF"
  },
  [1722] = {
    ID = 1722,
    CnID = "主祭",
    BaseSortID = 720,
    RoleName = "AvgRole_1722_RoleName|主祭",
    AwakerResource = "SpChar_LemuriaPriest_NF"
  },
  [1723] = {
    ID = 1723,
    CnID = "老主祭",
    BaseSortID = 721,
    RoleName = "AvgRole_1723_RoleName|老主祭",
    AwakerResource = "SpChar_LemuriaPriest_NF"
  },
  [1724] = {
    ID = 1724,
    CnID = "祭司",
    BaseSortID = 722,
    RoleName = "AvgRole_1724_RoleName|祭司",
    AwakerResource = "SpChar_LightLady_NF"
  },
  [1725] = {
    ID = 1725,
    CnID = "中年学徒",
    BaseSortID = 723,
    RoleName = "AvgRole_1725_RoleName|中年学徒",
    AwakerResource = "SpChar_LemuriaOldMan_NF"
  },
  [1726] = {
    ID = 1726,
    CnID = "青年学徒",
    BaseSortID = 724,
    RoleName = "AvgRole_1726_RoleName|青年学徒",
    AwakerResource = "SpChar_LemuriaMan_NF"
  },
  [1727] = {
    ID = 1727,
    CnID = "罪犯的女儿",
    BaseSortID = 725,
    RoleName = "AvgRole_1727_RoleName|罪犯的女儿",
    AwakerResource = "SpChar_LemuriaWoman_NF"
  },
  [1728] = {
    ID = 1728,
    CnID = "塔利斯·奥恩",
    BaseSortID = 726,
    RoleName = "AvgRole_1728_RoleName|塔利斯·奥恩",
    AwakerResource = "SpChar_Bertrand_NF"
  },
  [1729] = {
    ID = 1729,
    CnID = "塔利斯",
    BaseSortID = 727,
    RoleName = "AvgRole_1729_RoleName|塔利斯",
    AwakerResource = "SpChar_Bertrand_NF"
  },
  [1730] = {
    ID = 1730,
    CnID = "阿比夏",
    BaseSortID = 728,
    RoleName = "AvgRole_1730_RoleName|阿比夏",
    AwakerResource = "SpChar_Gladiator_NF"
  },
  [1731] = {
    ID = 1731,
    CnID = "奥恩家族族长",
    BaseSortID = 729,
    RoleName = "AvgRole_1731_RoleName|奥恩家族族长",
    AwakerResource = "SpChar_LemuriaOldMan_NF"
  },
  [1732] = {
    ID = 1732,
    CnID = "奥恩家族次子",
    BaseSortID = 730,
    RoleName = "AvgRole_1732_RoleName|奥恩家族次子",
    AwakerResource = "SpChar_LemuriaMan_NF"
  },
  [1733] = {
    ID = 1733,
    CnID = "艾德蒙家族族长",
    BaseSortID = 731,
    RoleName = "AvgRole_1733_RoleName|艾德蒙家族族长",
    AwakerResource = "SpChar_LemuriaOldMan_NF"
  },
  [1734] = {
    ID = 1734,
    CnID = "信徒",
    BaseSortID = 732,
    RoleName = "AvgRole_1734_RoleName|信徒",
    AwakerResource = "SpChar_LemuriaWoman_NF"
  },
  [1735] = {
    ID = 1735,
    CnID = "兴奋的信徒",
    BaseSortID = 733,
    RoleName = "AvgRole_1735_RoleName|兴奋的信徒",
    AwakerResource = "SpChar_LemuriaEnos_NF"
  },
  [1736] = {
    ID = 1736,
    CnID = "忠诚的信徒",
    BaseSortID = 734,
    RoleName = "AvgRole_1736_RoleName|忠诚的信徒",
    AwakerResource = "SpChar_LemuriaMan_NF"
  },
  [1737] = {
    ID = 1737,
    CnID = "狂热的信徒",
    BaseSortID = 735,
    RoleName = "AvgRole_1737_RoleName|狂热的信徒",
    AwakerResource = "SpChar_LemuriaOldMan_NF"
  },
  [1738] = {
    ID = 1738,
    CnID = "迟钝的侍卫",
    BaseSortID = 736,
    RoleName = "AvgRole_1738_RoleName|迟钝的侍卫",
    AwakerResource = "SpChar_Knight_NF"
  },
  [1739] = {
    ID = 1739,
    CnID = "勇敢的侍卫",
    BaseSortID = 737,
    RoleName = "AvgRole_1739_RoleName|勇敢的侍卫",
    AwakerResource = "SpChar_Knight_NF"
  },
  [1740] = {
    ID = 1740,
    CnID = "宾客",
    BaseSortID = 738,
    RoleName = "AvgRole_1740_RoleName|宾客",
    AwakerResource = "SpChar_Sculptor_NF"
  },
  [1741] = {
    ID = 1741,
    CnID = "残忍的贵族",
    BaseSortID = 739,
    RoleName = "AvgRole_1741_RoleName|残忍的贵族",
    AwakerResource = "SpChar_Detective_NF"
  },
  [1742] = {
    ID = 1742,
    CnID = "胆怯的贵族",
    BaseSortID = 740,
    RoleName = "AvgRole_1742_RoleName|胆怯的贵族",
    AwakerResource = "SpChar_Sculptor_NF"
  },
  [1743] = {
    ID = 1743,
    CnID = "勇敢的贵族",
    BaseSortID = 741,
    RoleName = "AvgRole_1743_RoleName|勇敢的贵族",
    AwakerResource = "SpChar_Bertrand_NF"
  },
  [1744] = {
    ID = 1744,
    CnID = "鱼人",
    BaseSortID = 742,
    RoleName = "AvgRole_1744_RoleName|鱼人",
    HeadIcon = "Portrait_Small_Monster_C0502",
    Sign = "AvgRole_1744_Sign|Portrait_Small_Monster_C0502"
  },
  [1745] = {
    ID = 1745,
    CnID = "鱼人们",
    BaseSortID = 743,
    RoleName = "AvgRole_1745_RoleName|鱼人们",
    HeadIcon = "Portrait_Small_Monster_C0502",
    Sign = "AvgRole_1745_Sign|Portrait_Small_Monster_C0502"
  },
  [1746] = {
    ID = 1746,
    CnID = "非利士队长",
    BaseSortID = 744,
    RoleName = "AvgRole_1746_RoleName|非利士队长",
    AwakerResource = "SpChar_Gladiator_NF"
  },
  [1747] = {
    ID = 1747,
    CnID = "非利士战士",
    BaseSortID = 745,
    RoleName = "AvgRole_1747_RoleName|非利士战士",
    AwakerResource = "SpChar_Gladiator_NF"
  },
  [1748] = {
    ID = 1748,
    CnID = "婴儿",
    BaseSortID = 746,
    RoleName = "AvgRole_1748_RoleName|婴儿",
    AwakerResource = "SpChar_Girl_NF"
  },
  [1749] = {
    ID = 1749,
    CnID = "警卫",
    BaseSortID = 747,
    RoleName = "AvgRole_1749_RoleName|警卫",
    Tittle = "AvgRole_1749_Tittle|融灾禁区警卫",
    AwakerResource = "SpChar_Detective_NF"
  },
  [1750] = {
    ID = 1750,
    CnID = "黛博拉？",
    BaseSortID = 748,
    RoleName = "AvgRole_1750_RoleName|侍女",
    AwakerResource = "SpChar_Deborah_NF"
  },
  [1751] = {
    ID = 1751,
    CnID = "涅弗鲁瑞成年版",
    BaseSortID = 749,
    RoleName = "AvgRole_1751_RoleName|涅弗鲁瑞",
    AwakerResource = "SpChar_AramMan_NF"
  },
  [1752] = {
    ID = 1752,
    CnID = "摊主",
    BaseSortID = 750,
    RoleName = "AvgRole_1752_RoleName|摊主",
    AwakerResource = "SpChar_AramWoman_NF"
  },
  [1753] = {
    ID = 1753,
    CnID = "恐惧的亚兰士兵",
    BaseSortID = 751,
    RoleName = "AvgRole_1753_RoleName|恐惧的亚兰士兵",
    AwakerResource = "SpChar_AramMan_NF"
  },
  [1754] = {
    ID = 1754,
    CnID = "坚毅的亚兰士兵",
    BaseSortID = 752,
    RoleName = "AvgRole_1754_RoleName|坚毅的亚兰士兵",
    AwakerResource = "SpChar_AramMan_NF"
  },
  [1755] = {
    ID = 1755,
    CnID = "喜极而泣的亚兰士兵",
    BaseSortID = 753,
    RoleName = "AvgRole_1755_RoleName|喜极而泣的亚兰士兵",
    AwakerResource = "SpChar_AramMan_NF"
  },
  [1756] = {
    ID = 1756,
    CnID = "跪伏在地的亚兰士兵",
    BaseSortID = 754,
    RoleName = "AvgRole_1756_RoleName|跪伏在地的亚兰士兵",
    AwakerResource = "SpChar_AramMan_NF"
  },
  [1757] = {
    ID = 1757,
    CnID = "亚兰士兵",
    BaseSortID = 755,
    RoleName = "AvgRole_1757_RoleName|亚兰士兵",
    AwakerResource = "SpChar_AramMan_NF"
  },
  [1758] = {
    ID = 1758,
    CnID = "亚兰女性",
    BaseSortID = 756,
    RoleName = "AvgRole_1758_RoleName|亚兰女性",
    AwakerResource = "SpChar_AramWoman_NF"
  },
  [1759] = {
    ID = 1759,
    CnID = "旅馆老板娘",
    BaseSortID = 757,
    RoleName = "AvgRole_1759_RoleName|旅馆老板娘",
    AwakerResource = "SpChar_AramWoman_NF"
  },
  [1760] = {
    ID = 1760,
    CnID = "低沉的歌声",
    BaseSortID = 758,
    RoleName = "AvgRole_1760_RoleName|低沉的歌声",
    AwakerResource = "SpChar_AramWoman_NF"
  },
  [1761] = {
    ID = 1761,
    CnID = "人面犬",
    BaseSortID = 759,
    RoleName = "AvgRole_1761_RoleName|巨犬"
  },
  [1762] = {
    ID = 1762,
    CnID = "SpChar_Researcher2_NF",
    BaseSortID = 760,
    RoleName = "AvgRole_1762_RoleName|SpChar_Researcher2_NF",
    AwakerResource = "SpChar_Researcher2_NF"
  },
  [1763] = {
    ID = 1763,
    CnID = "莱克德克斯特勋爵版",
    BaseSortID = 761,
    RoleName = "AvgRole_1763_RoleName|莱克",
    AwakerResource = "SpChar_Dexter_NF"
  },
  [1764] = {
    ID = 1764,
    CnID = "艾维斯？",
    BaseSortID = 762,
    RoleName = "AvgRole_1764_RoleName|？？？",
    AwakerResource = "SpChar_Detective_NF"
  },
  [1765] = {
    ID = 1765,
    CnID = "幼年泰旖丝",
    BaseSortID = 763,
    RoleName = "AvgRole_1765_RoleName|幼年泰旖丝",
    AwakerResource = "SpChar_Girl_NF"
  },
  [1766] = {
    ID = 1766,
    CnID = "君王",
    BaseSortID = 764,
    RoleName = "AvgRole_1766_RoleName|君王"
  },
  [1767] = {
    ID = 1767,
    CnID = "大臣",
    BaseSortID = 765,
    RoleName = "AvgRole_1767_RoleName|大臣"
  },
  [1768] = {
    ID = 1768,
    CnID = "传令使",
    BaseSortID = 766,
    RoleName = "AvgRole_1768_RoleName|传令使"
  },
  [1769] = {
    ID = 1769,
    CnID = "陌生的女人",
    BaseSortID = 767,
    RoleName = "AvgRole_1769_RoleName|陌生的女人",
    AwakerResource = "SpChar_AramWoman_NF"
  },
  [1770] = {
    ID = 1770,
    CnID = "本源希洛？",
    BaseSortID = 768,
    RoleName = "AvgRole_1770_RoleName|？？？",
    AwakerResource = "B05EX_NF"
  },
  [1771] = {
    ID = 1771,
    CnID = "值班医疗助理",
    BaseSortID = 769,
    RoleName = "AvgRole_1771_RoleName|值班医疗助理",
    AwakerResource = "SpChar_Researcher_NF"
  },
  [1772] = {
    ID = 1772,
    CnID = "泰旖丝无项链版",
    BaseSortID = 770,
    RoleName = "AvgRole_1772_RoleName|泰旖丝",
    AwakerResource = "SpChar_Thais_NF"
  },
  [1773] = {
    ID = 1773,
    CnID = "泰旖丝无项链版？",
    BaseSortID = 771,
    RoleName = "AvgRole_1773_RoleName|？？？",
    AwakerResource = "SpChar_Thais_NF"
  },
  [1774] = {
    ID = 1774,
    CnID = "利莫里亚老人",
    BaseSortID = 772,
    RoleName = "AvgRole_1774_RoleName|利莫里亚老人",
    AwakerResource = "SpChar_LemuriaOldMan_NF"
  },
  [1775] = {
    ID = 1775,
    CnID = "利莫里亚男性",
    BaseSortID = 773,
    RoleName = "AvgRole_1775_RoleName|利莫里亚男性",
    AwakerResource = "SpChar_LemuriaMan_NF"
  },
  [1776] = {
    ID = 1776,
    CnID = "利莫里亚女性",
    BaseSortID = 774,
    RoleName = "AvgRole_1776_RoleName|利莫里亚女性",
    AwakerResource = "SpChar_LemuriaWoman_NF"
  },
  [1777] = {
    ID = 1777,
    CnID = "头像剪影-女1",
    BaseSortID = 775,
    RoleName = "AvgRole_1777_RoleName|头像剪影-女1",
    AwakerResource = "SpChar_FemaleHead1_NF"
  },
  [1778] = {
    ID = 1778,
    CnID = "头像剪影-男1",
    BaseSortID = 776,
    RoleName = "AvgRole_1778_RoleName|头像剪影-男1",
    AwakerResource = "SpChar_MaleHead1_NF"
  },
  [1779] = {
    ID = 1779,
    CnID = "头像剪影-男2",
    BaseSortID = 777,
    RoleName = "AvgRole_1779_RoleName|头像剪影-男2",
    AwakerResource = "SpChar_MaleHead2_NF"
  },
  [1780] = {
    ID = 1780,
    CnID = "沉稳的侍卫",
    BaseSortID = 778,
    RoleName = "AvgRole_1780_RoleName|沉稳的侍卫",
    AwakerResource = "SpChar_Gladiator_NF"
  },
  [1781] = {
    ID = 1781,
    CnID = "焦急的侍卫",
    BaseSortID = 779,
    RoleName = "AvgRole_1781_RoleName|焦急的侍卫",
    AwakerResource = "SpChar_Gladiator_NF"
  },
  [1782] = {
    ID = 1782,
    CnID = "帕娅",
    BaseSortID = 780,
    RoleName = "AvgRole_1782_RoleName|帕娅",
    AwakerResource = "SpChar_LemuriaWoman_NF"
  },
  [1783] = {
    ID = 1783,
    CnID = "老年柯蕾特？",
    BaseSortID = 781,
    RoleName = "AvgRole_1783_RoleName|？？？",
    AwakerResource = "SpChar_OldColette_NF"
  },
  [1784] = {
    ID = 1784,
    CnID = "老年柯蕾特",
    BaseSortID = 782,
    RoleName = "AvgRole_1784_RoleName|柯蕾特",
    AwakerResource = "SpChar_OldColette_NF"
  },
  [1785] = {
    ID = 1785,
    CnID = "贵妇？",
    BaseSortID = 783,
    RoleName = "AvgRole_1785_RoleName|？？？",
    AwakerResource = "SpChar_OldColette_NF"
  },
  [1786] = {
    ID = 1786,
    CnID = "贵妇",
    BaseSortID = 784,
    RoleName = "AvgRole_1786_RoleName|贵妇人",
    AwakerResource = "SpChar_OldColette_NF"
  },
  [1787] = {
    ID = 1787,
    CnID = "柯蕾特正位",
    BaseSortID = 785,
    RoleName = "AvgRole_1787_RoleName|柯蕾特",
    AwakerResource = "SpChar_ChildColette2_NF"
  },
  [1788] = {
    ID = 1788,
    CnID = "生前奥尔拉",
    BaseSortID = 786,
    RoleName = "AvgRole_1788_RoleName|奥尔拉",
    AwakerResource = "SpChar_ExHorla_NF"
  },
  [1789] = {
    ID = 1789,
    CnID = "好心的邻居",
    BaseSortID = 787,
    RoleName = "AvgRole_1789_RoleName|好心的邻居",
    AwakerResource = "SpChar_Male_NF"
  },
  [1790] = {
    ID = 1790,
    CnID = "悲伤的邻居",
    BaseSortID = 788,
    RoleName = "AvgRole_1790_RoleName|悲伤的邻居",
    AwakerResource = "SpChar_Female_NF"
  },
  [1791] = {
    ID = 1791,
    CnID = "兴奋的市民",
    BaseSortID = 789,
    RoleName = "AvgRole_1791_RoleName|兴奋的市民",
    AwakerResource = "SpChar_BeeMale_NF"
  },
  [1792] = {
    ID = 1792,
    CnID = "冷静的市民",
    BaseSortID = 790,
    RoleName = "AvgRole_1792_RoleName|冷静的市民",
    AwakerResource = "SpChar_ButterflyFemale_NF"
  },
  [1793] = {
    ID = 1793,
    CnID = "诗中怪物",
    BaseSortID = 791,
    RoleName = "AvgRole_1793_RoleName|怪物",
    AwakerResource = "SpChar_BeeMale_NF"
  },
  [1794] = {
    ID = 1794,
    CnID = "本源朵尔？",
    BaseSortID = 792,
    RoleName = "AvgRole_1794_RoleName|？？",
    AwakerResource = "C02EX_AF",
    Sign = "AvgRole_1794_Sign|睁大眼看看吧，这世界的虚妄"
  },
  [1795] = {
    ID = 1795,
    CnID = "暮星·汀克特",
    BaseSortID = 793,
    RoleName = "AvgRole_1795_RoleName|汀克特",
    AwakerResource = "D03EX_AF",
    Sign = "AvgRole_1795_Sign|失声的百灵鸟，是否也会歌唱。"
  },
  [1796] = {
    ID = 1796,
    CnID = "哈姆林",
    BaseSortID = 794,
    RoleName = "AvgRole_1796_RoleName|哈姆林",
    AwakerResource = "D12_NF",
    Sign = "AvgRole_1796_Sign|排练中，有事请稍候。"
  },
  [1797] = {
    ID = 1797,
    CnID = "小奈亚",
    BaseSortID = 795,
    RoleName = "AvgRole_1797_RoleName|「N」",
    AwakerResource = "SpChar_LittleN_NF"
  },
  [1798] = {
    ID = 1798,
    CnID = "小奈亚？",
    BaseSortID = 796,
    RoleName = "AvgRole_1798_RoleName|？？",
    AwakerResource = "SpChar_LittleN_NF"
  },
  [1799] = {
    ID = 1799,
    CnID = "艾尔莎？",
    BaseSortID = 797,
    RoleName = "AvgRole_1799_RoleName|？？？",
    AwakerResource = "SpChar_Elsa_NF"
  },
  [1800] = {
    ID = 1800,
    CnID = "艾尔莎",
    BaseSortID = 798,
    RoleName = "AvgRole_1800_RoleName|艾尔莎",
    AwakerResource = "SpChar_Elsa_NF"
  },
  [1801] = {
    ID = 1801,
    CnID = "奇怪的邮筒",
    BaseSortID = 799,
    RoleName = "AvgRole_1801_RoleName|奇怪的邮筒",
    AwakerResource = "SpChar_Male_NF"
  },
  [1802] = {
    ID = 1802,
    CnID = "黑胶唱片",
    BaseSortID = 800,
    RoleName = "AvgRole_1802_RoleName|黑胶唱片",
    AwakerResource = "SpChar_Male_NF"
  },
  [1803] = {
    ID = 1803,
    CnID = "蒙宠者们",
    BaseSortID = 801,
    RoleName = "AvgRole_1803_RoleName|蒙宠者们",
    AwakerResource = "SpChar_Male_NF"
  },
  [1804] = {
    ID = 1804,
    CnID = "卡纳克",
    BaseSortID = 802,
    RoleName = "AvgRole_1804_RoleName|卡纳克",
    HeadIcon = "Portrait_Minihead_SpChar_Karnak_NF"
  },
  [1805] = {
    ID = 1805,
    CnID = "阿波菲斯",
    BaseSortID = 803,
    RoleName = "AvgRole_1805_RoleName|阿波菲斯",
    HeadIcon = "Portrait_Minihead_SpChar_Apophis_NF"
  },
  [1806] = {
    ID = 1806,
    CnID = "阿波菲斯？",
    BaseSortID = 804,
    RoleName = "AvgRole_1806_RoleName|？？？",
    HeadIcon = "Portrait_Minihead_SpChar_Apophis_NF"
  },
  [1807] = {
    ID = 1807,
    CnID = "埃及祭司",
    BaseSortID = 805,
    RoleName = "AvgRole_1807_RoleName|祭司",
    AwakerResource = "SpChar_LemuriaPriest_NF"
  },
  [1808] = {
    ID = 1808,
    CnID = "调查员",
    BaseSortID = 806,
    RoleName = "AvgRole_1808_RoleName|调查员",
    AwakerResource = "SpChar_Male_NF"
  },
  [1809] = {
    ID = 1809,
    CnID = "本源朵尔？？？",
    BaseSortID = 807,
    RoleName = "AvgRole_1809_RoleName|？？？",
    AwakerResource = "C02EX_AF"
  },
  [1810] = {
    ID = 1810,
    CnID = "异变艾尔莎",
    BaseSortID = 808,
    RoleName = "AvgRole_1810_RoleName|？？？",
    AwakerResource = "SpChar_StudentDis_NF"
  },
  [1811] = {
    ID = 1811,
    CnID = "哈姆林？",
    BaseSortID = 809,
    RoleName = "AvgRole_1811_RoleName|？？？",
    AwakerResource = "D12_NF"
  },
  [1812] = {
    ID = 1812,
    CnID = "审查会领队",
    BaseSortID = 810,
    RoleName = "AvgRole_1812_RoleName|审查会领队",
    AwakerResource = "SpChar_MTCAgent_NF"
  },
  [1813] = {
    ID = 1813,
    CnID = "审查会探员NPC",
    BaseSortID = 811,
    RoleName = "AvgRole_1813_RoleName|审查会探员",
    AwakerResource = "SpChar_Male_NF"
  },
  [1814] = {
    ID = 1814,
    CnID = "塔薇？",
    BaseSortID = 812,
    RoleName = "AvgRole_1814_RoleName|？？？",
    AwakerResource = "C15_NF"
  },
  [1815] = {
    ID = 1815,
    CnID = "提灯教众",
    BaseSortID = 813,
    RoleName = "AvgRole_1815_RoleName|提灯教众",
    AwakerResource = "SpChar_LightLady_NF"
  },
  [1816] = {
    ID = 1816,
    CnID = "提灯双子",
    BaseSortID = 814,
    RoleName = "AvgRole_1816_RoleName|提灯双子"
  },
  [1817] = {
    ID = 1817,
    CnID = "德克斯特？",
    BaseSortID = 815,
    RoleName = "AvgRole_1817_RoleName|？？？",
    AwakerResource = "SpChar_Dexter_NF"
  },
  [1818] = {
    ID = 1818,
    CnID = "克莱门汀？",
    BaseSortID = 816,
    RoleName = "AvgRole_1818_RoleName|？？？",
    AwakerResource = "SpChar_Clementine_HF"
  },
  [1819] = {
    ID = 1819,
    CnID = "痛苦的探员",
    BaseSortID = 817,
    RoleName = "AvgRole_1819_RoleName|痛苦的探员",
    AwakerResource = "SpChar_Male_NF"
  },
  [1820] = {
    ID = 1820,
    CnID = "慌乱的探员",
    BaseSortID = 818,
    RoleName = "AvgRole_1820_RoleName|慌乱的探员",
    AwakerResource = "SpChar_Male_NF"
  },
  [1821] = {
    ID = 1821,
    CnID = "于丽埃特八章",
    BaseSortID = 819,
    RoleName = "AvgRole_1821_RoleName|于丽埃特",
    AwakerResource = "SpChar_Julliette_NF"
  },
  [1822] = {
    ID = 1822,
    CnID = "克莱门汀八章",
    BaseSortID = 820,
    RoleName = "AvgRole_1822_RoleName|克莱门汀",
    AwakerResource = "SpChar_Clementine_HF"
  },
  [1823] = {
    ID = 1823,
    CnID = "阿利斯泰尔彩色",
    BaseSortID = 821,
    RoleName = "AvgRole_1823_RoleName|阿利斯泰尔",
    AwakerResource = "SpChar_Alistair_NF"
  },
  [1824] = {
    ID = 1824,
    CnID = "塔薇AF",
    BaseSortID = 822,
    RoleName = "AvgRole_1824_RoleName|塔薇AF",
    AwakerResource = "C15_AF"
  },
  [1825] = {
    ID = 1825,
    CnID = "哈姆林AF",
    BaseSortID = 823,
    RoleName = "AvgRole_1825_RoleName|哈姆林AF",
    AwakerResource = "D12_AF"
  },
  [1826] = {
    ID = 1826,
    CnID = "本源拉蒙娜通讯器",
    BaseSortID = 824,
    RoleName = "AvgRole_1826_RoleName|环行·拉蒙娜",
    AwakerResource = "C01EX_NF",
    Sign = "AvgRole_1826_Sign|等待与你相见。"
  },
  [1827] = {
    ID = 1827,
    CnID = "本源朵尔AF",
    BaseSortID = 825,
    RoleName = "AvgRole_1827_RoleName|本源朵尔AF",
    AwakerResource = "C02EX_AF"
  },
  [1828] = {
    ID = 1828,
    CnID = "本源朵尔NF",
    BaseSortID = 826,
    RoleName = "AvgRole_1828_RoleName|本源朵尔NF",
    AwakerResource = "C02EX_NF"
  },
  [1829] = {
    ID = 1829,
    CnID = "体内塔薇",
    BaseSortID = 827,
    RoleName = "AvgRole_1829_RoleName|塔薇？",
    AwakerResource = "C15_NF"
  },
  [1830] = {
    ID = 1830,
    CnID = "体内N",
    BaseSortID = 828,
    RoleName = "AvgRole_1830_RoleName|N？",
    AwakerResource = "SpChar_N_NF"
  },
  [1831] = {
    ID = 1831,
    CnID = "体内泰旖丝",
    BaseSortID = 829,
    RoleName = "AvgRole_1831_RoleName|泰旖丝？",
    AwakerResource = "B01_AF"
  },
  [1832] = {
    ID = 1832,
    CnID = "契诃玛-达阿特",
    BaseSortID = 830,
    RoleName = "AvgRole_1832_RoleName|契诃玛-达阿特"
  },
  [1833] = {
    ID = 1833,
    CnID = "托乎瓦波",
    BaseSortID = 831,
    RoleName = "AvgRole_1833_RoleName|托乎瓦波"
  },
  [1834] = {
    ID = 1834,
    CnID = "拉蒙娜的幻影",
    BaseSortID = 832,
    RoleName = "AvgRole_1834_RoleName|拉蒙娜的幻影",
    AwakerResource = "C01_AF"
  },
  [1835] = {
    ID = 1835,
    CnID = "朵尔的幻影",
    BaseSortID = 833,
    RoleName = "AvgRole_1835_RoleName|朵尔的幻影",
    AwakerResource = "C02_NF"
  },
  [1836] = {
    ID = 1836,
    CnID = "萝坦的幻影",
    BaseSortID = 834,
    RoleName = "AvgRole_1836_RoleName|萝坦的幻影",
    AwakerResource = "C04_NF"
  },
  [1837] = {
    ID = 1837,
    CnID = "奥吉尔的幻影",
    BaseSortID = 835,
    RoleName = "AvgRole_1837_RoleName|奥吉尔的幻影",
    AwakerResource = "C03_NF"
  },
  [1838] = {
    ID = 1838,
    CnID = "玩家碎片男",
    BaseSortID = 836,
    RoleName = "AvgRole_1838_RoleName|？？？",
    AwakerResource = "SpChar_PlayerM_NF"
  },
  [1839] = {
    ID = 1839,
    CnID = "玩家碎片女",
    BaseSortID = 837,
    RoleName = "AvgRole_1839_RoleName|？？？",
    AwakerResource = "SpChar_PlayerF_NF"
  },
  [1840] = {
    ID = 1840,
    CnID = "原初悲泣之视",
    BaseSortID = 838,
    RoleName = "AvgRole_1840_RoleName|原初悲泣之视"
  },
  [1841] = {
    ID = 1841,
    CnID = "原初恐惧之视",
    BaseSortID = 839,
    RoleName = "AvgRole_1841_RoleName|原初恐惧之视"
  },
  [1842] = {
    ID = 1842,
    CnID = "原初刺骨之视",
    BaseSortID = 840,
    RoleName = "AvgRole_1842_RoleName|原初刺骨之视"
  },
  [1843] = {
    ID = 1843,
    CnID = "原初诡谲之视",
    BaseSortID = 841,
    RoleName = "AvgRole_1843_RoleName|原初诡谲之视"
  },
  [1844] = {
    ID = 1844,
    CnID = "原初邪信之视",
    BaseSortID = 842,
    RoleName = "AvgRole_1844_RoleName|原初邪信之视"
  },
  [1845] = {
    ID = 1845,
    CnID = "原初疯狂之视",
    BaseSortID = 843,
    RoleName = "AvgRole_1845_RoleName|原初疯狂之视"
  },
  [1846] = {
    ID = 1846,
    CnID = "原初诞临之视",
    BaseSortID = 844,
    RoleName = "AvgRole_1846_RoleName|原初诞临之视"
  },
  [1847] = {
    ID = 1847,
    CnID = "艾继丝的幻影",
    BaseSortID = 845,
    RoleName = "AvgRole_1847_RoleName|艾继丝的幻影",
    AwakerResource = "B03_HF"
  },
  [1848] = {
    ID = 1848,
    CnID = "詹金的幻影",
    BaseSortID = 846,
    RoleName = "AvgRole_1848_RoleName|詹金的幻影",
    AwakerResource = "D07_NF"
  },
  [1849] = {
    ID = 1849,
    CnID = "莉莉的幻影",
    BaseSortID = 847,
    RoleName = "AvgRole_1849_RoleName|莉莉的幻影",
    AwakerResource = "SpChar_Lily_NF"
  },
  [1850] = {
    ID = 1850,
    CnID = "达芙黛尔的幻影",
    BaseSortID = 848,
    RoleName = "AvgRole_1850_RoleName|达芙黛尔的幻影",
    AwakerResource = "D02_HF"
  },
  [1851] = {
    ID = 1851,
    CnID = "图鲁的幻影",
    BaseSortID = 849,
    RoleName = "AvgRole_1851_RoleName|图鲁的幻影",
    AwakerResource = "O01_NF"
  },
  [1852] = {
    ID = 1852,
    CnID = "墨菲的幻影",
    BaseSortID = 850,
    RoleName = "AvgRole_1852_RoleName|墨菲的幻影",
    AwakerResource = "O02_AF"
  },
  [1853] = {
    ID = 1853,
    CnID = "威廉？？？",
    BaseSortID = 851,
    RoleName = "AvgRole_1853_RoleName|？？？",
    AwakerResource = "SpChar_William_NF"
  },
  [1854] = {
    ID = 1854,
    CnID = "诺亚",
    BaseSortID = 852,
    RoleName = "AvgRole_1854_RoleName|诺亚",
    AwakerResource = "SpChar_Noah_NF"
  },
  [1855] = {
    ID = 1855,
    CnID = "孩童们",
    BaseSortID = 853,
    RoleName = "AvgRole_1855_RoleName|孩童们"
  },
  [1856] = {
    ID = 1856,
    CnID = "温柔的男孩",
    BaseSortID = 854,
    RoleName = "AvgRole_1856_RoleName|温柔的男孩"
  },
  [1857] = {
    ID = 1857,
    CnID = "冷静的男孩",
    BaseSortID = 855,
    RoleName = "AvgRole_1857_RoleName|冷静的男孩"
  },
  [1858] = {
    ID = 1858,
    CnID = "强壮的女孩",
    BaseSortID = 856,
    RoleName = "AvgRole_1858_RoleName|强壮的女孩"
  },
  [1859] = {
    ID = 1859,
    CnID = "绝望的男孩",
    BaseSortID = 857,
    RoleName = "AvgRole_1859_RoleName|绝望的男孩"
  },
  [1860] = {
    ID = 1860,
    CnID = "倔强的女孩",
    BaseSortID = 858,
    RoleName = "AvgRole_1860_RoleName|倔强的女孩"
  },
  [1861] = {
    ID = 1861,
    CnID = "玩家王冠",
    BaseSortID = 859,
    RoleName = "AvgRole_1861_RoleName|王冠",
    ShowAsPlayer = 1,
    AwakerResource = "SpChar_PlayerM_NF"
  },
  [1862] = {
    ID = 1862,
    CnID = "民众",
    BaseSortID = 860,
    RoleName = "AvgRole_1862_RoleName|民众"
  },
  [1863] = {
    ID = 1863,
    CnID = "惊恐的女孩",
    BaseSortID = 861,
    RoleName = "AvgRole_1863_RoleName|惊恐的女孩"
  },
  [1864] = {
    ID = 1864,
    CnID = "勇敢的女孩",
    BaseSortID = 862,
    RoleName = "AvgRole_1864_RoleName|勇敢的女孩"
  },
  [1865] = {
    ID = 1865,
    CnID = "少年图鲁",
    BaseSortID = 863,
    RoleName = "AvgRole_1865_RoleName|图鲁",
    AwakerResource = "SpChar_Tulu_NF"
  },
  [1866] = {
    ID = 1866,
    CnID = "狂喜的民众",
    BaseSortID = 864,
    RoleName = "AvgRole_1866_RoleName|狂喜的民众"
  },
  [1867] = {
    ID = 1867,
    CnID = "激动的民众",
    BaseSortID = 865,
    RoleName = "AvgRole_1867_RoleName|激动的民众"
  },
  [1868] = {
    ID = 1868,
    CnID = "悲伤的女人",
    BaseSortID = 866,
    RoleName = "AvgRole_1868_RoleName|悲伤的女人",
    AwakerResource = "SpChar_Female_NF"
  },
  [1869] = {
    ID = 1869,
    CnID = "幼小的男孩",
    BaseSortID = 867,
    RoleName = "AvgRole_1869_RoleName|幼小的男孩"
  },
  [1870] = {
    ID = 1870,
    CnID = "年长的男孩",
    BaseSortID = 868,
    RoleName = "AvgRole_1870_RoleName|年长的男孩",
    AwakerResource = "SpChar_Noah_NF"
  },
  [1871] = {
    ID = 1871,
    CnID = "成年诺亚",
    BaseSortID = 869,
    RoleName = "AvgRole_1871_RoleName|诺亚",
    AwakerResource = "SpChar_LemuriaEnos_NF"
  },
  [1872] = {
    ID = 1872,
    CnID = "围在门前的人",
    BaseSortID = 870,
    RoleName = "AvgRole_1872_RoleName|围在门前的人"
  },
  [1873] = {
    ID = 1873,
    CnID = "玩家王冠？",
    BaseSortID = 871,
    RoleName = "AvgRole_1873_RoleName|？？？",
    ShowAsPlayer = 1,
    AwakerResource = "SpChar_PlayerM_NF"
  },
  [1874] = {
    ID = 1874,
    CnID = "熔毁·朵尔",
    BaseSortID = 872,
    RoleName = "AvgRole_1874_RoleName|熔毁·朵尔",
    AwakerResource = "C02EX_AF"
  },
  [1875] = {
    ID = 1875,
    CnID = "？？？（珊）",
    BaseSortID = 873,
    RoleName = "AvgRole_1875_RoleName|？？？",
    AwakerResource = "O08_NF"
  },
  [1876] = {
    ID = 1876,
    CnID = "B-68",
    BaseSortID = 874,
    RoleName = "AvgRole_1876_RoleName|B-68",
    AwakerResource = "C02EX_AF"
  },
  [1877] = {
    ID = 1877,
    CnID = "融蚀异变体1",
    BaseSortID = 875,
    RoleName = "AvgRole_1877_RoleName|融蚀异变体",
    AwakerResource = "SpChar_SkullHunter2_NF"
  },
  [1878] = {
    ID = 1878,
    CnID = "熔毁·朵尔NF",
    BaseSortID = 876,
    RoleName = "AvgRole_1878_RoleName|熔毁·朵尔",
    AwakerResource = "C02EX_NF"
  },
  [1879] = {
    ID = 1879,
    CnID = "玩家&伊格娜蒂丝",
    BaseSortID = 877,
    RoleName = "AvgRole_1879_RoleName|<Yellow:%player%>&伊格娜蒂丝",
    ShowAsPlayer = 1,
    AwakerResource = "SpChar_PlayerM_NF"
  },
  [1880] = {
    ID = 1880,
    CnID = "虫人医生",
    BaseSortID = 878,
    RoleName = "AvgRole_1880_RoleName|医生",
    AwakerResource = "SpChar_DoctorMask_NF"
  },
  [1881] = {
    ID = 1881,
    CnID = "虫人医生1",
    BaseSortID = 879,
    RoleName = "AvgRole_1881_RoleName|医生",
    AwakerResource = "SpChar_DoctorMask_NF"
  },
  [1882] = {
    ID = 1882,
    CnID = "虫脸医生",
    BaseSortID = 880,
    RoleName = "AvgRole_1882_RoleName|@2",
    AwakerResource = "SpChar_DoctorMonster_NF"
  },
  [1883] = {
    ID = 1883,
    CnID = "虫脸医生1",
    BaseSortID = 881,
    RoleName = "AvgRole_1883_RoleName|@2",
    AwakerResource = "SpChar_DoctorMonster_NF"
  },
  [1884] = {
    ID = 1884,
    CnID = "患者",
    BaseSortID = 882,
    RoleName = "AvgRole_1884_RoleName|患者",
    AwakerResource = "SpChar_DisMale_NF"
  },
  [1885] = {
    ID = 1885,
    CnID = "？？？（克劳德）",
    BaseSortID = 883,
    RoleName = "AvgRole_1885_RoleName|？？？",
    Tittle = "AvgRole_1885_Tittle|融蚀患者",
    AwakerResource = "SpChar_Sculptor_NF"
  },
  [1886] = {
    ID = 1886,
    CnID = "克劳德",
    BaseSortID = 884,
    RoleName = "AvgRole_1886_RoleName|克劳德",
    Tittle = "AvgRole_1886_Tittle|融蚀患者",
    AwakerResource = "SpChar_Sculptor_NF"
  },
  [1887] = {
    ID = 1887,
    CnID = "提灯男性教徒",
    BaseSortID = 885,
    RoleName = "AvgRole_1887_RoleName|男性教徒",
    AwakerResource = "SpChar_LemuriaOldMan_NF"
  },
  [1888] = {
    ID = 1888,
    CnID = "小威廉？",
    BaseSortID = 886,
    RoleName = "AvgRole_1888_RoleName|？？？",
    AwakerResource = "SpChar_LittleWilliam_NF"
  },
  [1889] = {
    ID = 1889,
    CnID = "小威廉",
    BaseSortID = 887,
    RoleName = "AvgRole_1889_RoleName|失忆少年",
    AwakerResource = "SpChar_LittleWilliam_NF"
  },
  [1890] = {
    ID = 1890,
    CnID = "少年威廉",
    BaseSortID = 888,
    RoleName = "AvgRole_1890_RoleName|少年威廉",
    AwakerResource = "SpChar_LittleWilliam_NF"
  },
  [1891] = {
    ID = 1891,
    CnID = "男童",
    BaseSortID = 889,
    RoleName = "AvgRole_1891_RoleName|男童",
    AwakerResource = "SpChar_Boy_NF"
  },
  [1892] = {
    ID = 1892,
    CnID = "女童",
    BaseSortID = 890,
    RoleName = "AvgRole_1892_RoleName|女童",
    AwakerResource = "SpChar_Girl_NF"
  },
  [1893] = {
    ID = 1893,
    CnID = "威廉父亲",
    BaseSortID = 891,
    RoleName = "AvgRole_1893_RoleName|威廉的父亲",
    AwakerResource = "SpChar_Bertrand_NF"
  },
  [1894] = {
    ID = 1894,
    CnID = "伯克利",
    BaseSortID = 892,
    RoleName = "AvgRole_1894_RoleName|伯克利",
    AwakerResource = "SpChar_Berkeley_NF"
  },
  [1895] = {
    ID = 1895,
    CnID = "虫人男性",
    BaseSortID = 893,
    RoleName = "AvgRole_1895_RoleName|詹@1士",
    AwakerResource = "SpChar_Drunkard_NF"
  },
  [1896] = {
    ID = 1896,
    CnID = "虫人小孩",
    BaseSortID = 894,
    RoleName = "AvgRole_1896_RoleName|艾玛",
    AwakerResource = "SpChar_ChildMiliyam1_NF"
  },
  [1897] = {
    ID = 1897,
    CnID = "虫人女性",
    BaseSortID = 895,
    RoleName = "AvgRole_1897_RoleName|@1尔黛娜",
    AwakerResource = "SpChar_Maid_NF"
  },
  [1898] = {
    ID = 1898,
    CnID = "巡逻队长",
    BaseSortID = 896,
    RoleName = "AvgRole_1898_RoleName|巡逻队长",
    AwakerResource = "SpChar_Olive_NF"
  },
  [1899] = {
    ID = 1899,
    CnID = "奥利弗",
    BaseSortID = 897,
    RoleName = "AvgRole_1899_RoleName|奥利弗",
    AwakerResource = "SpChar_Olive_NF"
  },
  [1900] = {
    ID = 1900,
    CnID = "奥利弗头像",
    BaseSortID = 898,
    RoleName = "AvgRole_1900_RoleName|奥利弗",
    HeadIcon = "Portrait_Minihead_SpChar_Male_NF"
  },
  [1901] = {
    ID = 1901,
    CnID = "艾伦",
    BaseSortID = 899,
    RoleName = "AvgRole_1901_RoleName|艾伦",
    Tittle = "AvgRole_1901_Tittle|克莱门汀的父亲",
    AwakerResource = "SpChar_AllenNormal_NF"
  },
  [1902] = {
    ID = 1902,
    CnID = "艾伦？",
    BaseSortID = 900,
    RoleName = "AvgRole_1902_RoleName|？？？",
    AwakerResource = "SpChar_AllenNormal_NF"
  },
  [1903] = {
    ID = 1903,
    CnID = "怪物先生",
    BaseSortID = 901,
    RoleName = "AvgRole_1903_RoleName|怪物先生",
    AwakerResource = "SpChar_AllenMonster_NF"
  },
  [1904] = {
    ID = 1904,
    CnID = "血肉艾伦",
    BaseSortID = 902,
    RoleName = "AvgRole_1904_RoleName|@2",
    AwakerResource = "SpChar_AllenMonster_NF"
  },
  [1905] = {
    ID = 1905,
    CnID = "夏盖虫族",
    BaseSortID = 903,
    RoleName = "AvgRole_1905_RoleName|@2虫族",
    Tittle = "AvgRole_1905_Tittle|消逝@2的残留意志"
  },
  [1906] = {
    ID = 1906,
    CnID = "疗养院广播",
    BaseSortID = 904,
    RoleName = "AvgRole_1906_RoleName|疗养院广播",
    AwakerResource = "SpChar_Broadcast_NF"
  },
  [1907] = {
    ID = 1907,
    CnID = "老约翰",
    BaseSortID = 905,
    RoleName = "AvgRole_1907_RoleName|老约翰",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1908] = {
    ID = 1908,
    CnID = "伽拉忒亚",
    BaseSortID = 906,
    RoleName = "AvgRole_1908_RoleName|伽拉忒亚",
    Tittle = "AvgRole_1908_Tittle|赫伯特的爱宠"
  },
  [1909] = {
    ID = 1909,
    CnID = "@2门汀",
    BaseSortID = 907,
    RoleName = "AvgRole_1909_RoleName|@2门汀",
    AwakerResource = "SpChar_Clementine_HF"
  },
  [1910] = {
    ID = 1910,
    CnID = "克莱门汀战损版",
    BaseSortID = 908,
    RoleName = "AvgRole_1910_RoleName|克莱门汀",
    AwakerResource = "SpChar_ClementineInjured_NF"
  },
  [1911] = {
    ID = 1911,
    CnID = "克莱门汀唤醒体？",
    BaseSortID = 909,
    RoleName = "AvgRole_1911_RoleName|？？？",
    AwakerResource = "SpChar_Clementine_AF"
  },
  [1912] = {
    ID = 1912,
    CnID = "克莱门汀@版",
    BaseSortID = 910,
    RoleName = "AvgRole_1912_RoleName|@2门汀"
  },
  [1913] = {
    ID = 1913,
    CnID = "克莱门汀AF",
    BaseSortID = 911,
    RoleName = "AvgRole_1913_RoleName|克莱门汀",
    AwakerResource = "SpChar_Clementine_AF",
    Sign = "AvgRole_1913_Sign|我愿与你，共同开启一段心灵之旅。"
  },
  [8001] = {
    ID = 8001,
    CnID = "伊格娜蒂丝（未知）",
    BaseSortID = 912,
    RoleName = "AvgRole_8001_RoleName|？？？",
    AwakerResource = "SpChar_Ignativs_NF"
  },
  [8002] = {
    ID = 8002,
    CnID = "伊格娜蒂丝",
    BaseSortID = 913,
    RoleName = "AvgRole_8002_RoleName|伊格娜蒂丝",
    AwakerResource = "SpChar_Ignativs_NF"
  },
  [1914] = {
    ID = 1914,
    CnID = "詹金新",
    BaseSortID = 914,
    RoleName = "AvgRole_1914_RoleName|詹金",
    AwakerResource = "D07_HF"
  },
  [1915] = {
    ID = 1915,
    CnID = "融蚀异变体2",
    BaseSortID = 915,
    RoleName = "AvgRole_1915_RoleName|融蚀异变体",
    AwakerResource = "SpChar_SkullHunter2_NF"
  },
  [1916] = {
    ID = 1916,
    CnID = "融蚀异变体3",
    BaseSortID = 916,
    RoleName = "AvgRole_1916_RoleName|融蚀异变体",
    AwakerResource = "SpChar_SkullHunter2_NF"
  },
  [1917] = {
    ID = 1917,
    CnID = "伯克鲁格？？",
    BaseSortID = 917,
    RoleName = "AvgRole_1917_RoleName|？？？",
    AwakerResource = "SpChar_Bokrug_NF"
  },
  [1918] = {
    ID = 1918,
    CnID = "环行拉蒙娜？",
    BaseSortID = 918,
    RoleName = "AvgRole_1918_RoleName|？？？",
    AwakerResource = "C01EX_NF"
  },
  [1919] = {
    ID = 1919,
    CnID = "赫伯特无猫版",
    BaseSortID = 919,
    RoleName = "AvgRole_1919_RoleName|赫伯特",
    Tittle = "AvgRole_1919_Tittle|雕塑家协会会长",
    AwakerResource = "SpChar_HerbertNoCat_NF"
  },
  [1920] = {
    ID = 1920,
    CnID = "卡斯托尔",
    BaseSortID = 920,
    RoleName = "AvgRole_1920_RoleName|卡斯托尔",
    AwakerResource = "D11_NF",
    Sign = "AvgRole_1920_Sign|多有愚问，烦请勿怪。"
  },
  [1921] = {
    ID = 1921,
    CnID = "少年父亲",
    BaseSortID = 921,
    RoleName = "AvgRole_1921_RoleName|少年的父亲",
    AwakerResource = "SpChar_Bertrand_NF"
  },
  [1922] = {
    ID = 1922,
    CnID = "波吕克斯",
    BaseSortID = 922,
    RoleName = "AvgRole_1922_RoleName|波吕克斯",
    AwakerResource = "D14_NF",
    Sign = "AvgRole_1922_Sign|跟随明灯的指引。"
  },
  [1923] = {
    ID = 1923,
    CnID = "提灯侍从",
    BaseSortID = 923,
    RoleName = "AvgRole_1923_RoleName|提灯侍从",
    AwakerResource = "SpChar_LightLady_NF"
  },
  [1924] = {
    ID = 1924,
    CnID = "提灯灯卫",
    BaseSortID = 924,
    RoleName = "AvgRole_1924_RoleName|提灯灯卫",
    AwakerResource = "SpChar_Knight_NF"
  },
  [1925] = {
    ID = 1925,
    CnID = "灯芯",
    BaseSortID = 925,
    RoleName = "AvgRole_1925_RoleName|灯芯",
    AwakerResource = "SpChar_LightLady_NF"
  },
  [1926] = {
    ID = 1926,
    CnID = "货商",
    BaseSortID = 926,
    RoleName = "AvgRole_1926_RoleName|货商"
  },
  [1927] = {
    ID = 1927,
    CnID = "小贩",
    BaseSortID = 927,
    RoleName = "AvgRole_1927_RoleName|小贩"
  },
  [1928] = {
    ID = 1928,
    CnID = "旅馆店主",
    BaseSortID = 928,
    RoleName = "AvgRole_1928_RoleName|旅馆店主",
    AwakerResource = "SpChar_DesertDweller_NF"
  },
  [1929] = {
    ID = 1929,
    CnID = "烤饼摊主",
    BaseSortID = 929,
    RoleName = "AvgRole_1929_RoleName|烤饼摊主"
  },
  [1930] = {
    ID = 1930,
    CnID = "商队领队",
    BaseSortID = 930,
    RoleName = "AvgRole_1930_RoleName|商队领队",
    AwakerResource = "SpChar_Iglen_NF"
  },
  [1931] = {
    ID = 1931,
    CnID = "商队成员",
    BaseSortID = 931,
    RoleName = "AvgRole_1931_RoleName|商队成员",
    AwakerResource = "SpChar_Gladiator_NF"
  },
  [1932] = {
    ID = 1932,
    CnID = "商人",
    BaseSortID = 932,
    RoleName = "AvgRole_1932_RoleName|商人"
  },
  [1933] = {
    ID = 1933,
    CnID = "船长奥恩",
    BaseSortID = 933,
    RoleName = "AvgRole_1933_RoleName|船长奥恩",
    AwakerResource = "SpChar_CaptainAuen_NF"
  },
  [1934] = {
    ID = 1934,
    CnID = "水手约翰",
    BaseSortID = 934,
    RoleName = "AvgRole_1934_RoleName|水手约翰"
  },
  [1935] = {
    ID = 1935,
    CnID = "水手诺曼",
    BaseSortID = 935,
    RoleName = "AvgRole_1935_RoleName|水手诺曼",
    AwakerResource = "SpChar_SailorNorman_NF"
  },
  [1936] = {
    ID = 1936,
    CnID = "水手杰克",
    BaseSortID = 936,
    RoleName = "AvgRole_1936_RoleName|水手杰克"
  },
  [1937] = {
    ID = 1937,
    CnID = "水手理查德",
    BaseSortID = 937,
    RoleName = "AvgRole_1937_RoleName|水手理查德",
    HeadIcon = "Portrait_Minihead_SpChar_SailorRichard_NF"
  },
  [1938] = {
    ID = 1938,
    CnID = "男性融蚀乘客",
    BaseSortID = 938,
    RoleName = "AvgRole_1938_RoleName|男性融蚀乘客",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [1939] = {
    ID = 1939,
    CnID = "年轻融蚀乘客",
    BaseSortID = 939,
    RoleName = "AvgRole_1939_RoleName|年轻融蚀乘客",
    AwakerResource = "SpChar_DisMale_NF"
  },
  [1940] = {
    ID = 1940,
    CnID = "女性融蚀乘客",
    BaseSortID = 940,
    RoleName = "AvgRole_1940_RoleName|女性融蚀乘客",
    AwakerResource = "SpChar_Female_NF"
  },
  [1941] = {
    ID = 1941,
    CnID = "一等舱乘客",
    BaseSortID = 941,
    RoleName = "AvgRole_1941_RoleName|一等舱乘客",
    HeadIcon = "Portrait_Minihead_SpChar_Passenger1_NF"
  },
  [1942] = {
    ID = 1942,
    CnID = "三等舱乘客",
    BaseSortID = 942,
    RoleName = "AvgRole_1942_RoleName|三等舱乘客",
    HeadIcon = "Portrait_Minihead_SpChar_Passenger2_NF"
  },
  [1943] = {
    ID = 1943,
    CnID = "健康乘客",
    BaseSortID = 943,
    RoleName = "AvgRole_1943_RoleName|健康乘客"
  },
  [1944] = {
    ID = 1944,
    CnID = "融蚀乘客",
    BaseSortID = 944,
    RoleName = "AvgRole_1944_RoleName|融蚀乘客",
    AwakerResource = "SpChar_DisMale_NF"
  },
  [1945] = {
    ID = 1945,
    CnID = "克珀珊特HF",
    BaseSortID = 945,
    RoleName = "AvgRole_1945_RoleName|克珀珊特",
    AwakerResource = "O10_HF"
  },
  [1946] = {
    ID = 1946,
    CnID = "克莱门汀战损版1",
    BaseSortID = 946,
    RoleName = "AvgRole_1946_RoleName|「克莱门汀」",
    AwakerResource = "SpChar_ClementineInjured_NF"
  },
  [1947] = {
    ID = 1947,
    CnID = "怪物先生?",
    BaseSortID = 947,
    RoleName = "AvgRole_1947_RoleName|？？？",
    AwakerResource = "SpChar_AllenMonster_NF"
  },
  [1948] = {
    ID = 1948,
    CnID = "活泼的食尸鬼",
    BaseSortID = 948,
    RoleName = "AvgRole_1948_RoleName|活泼的食尸鬼",
    AwakerResource = "SpChar_Ghoul_NF"
  },
  [1949] = {
    ID = 1949,
    CnID = "稳重的食尸鬼",
    BaseSortID = 949,
    RoleName = "AvgRole_1949_RoleName|稳重的食尸鬼",
    AwakerResource = "SpChar_Ghoul_NF"
  },
  [1950] = {
    ID = 1950,
    CnID = "严格的食尸鬼",
    BaseSortID = 950,
    RoleName = "AvgRole_1950_RoleName|严格的食尸鬼",
    AwakerResource = "SpChar_Ghoul_NF"
  },
  [1951] = {
    ID = 1951,
    CnID = "随性的食尸鬼",
    BaseSortID = 951,
    RoleName = "AvgRole_1951_RoleName|随性的食尸鬼",
    AwakerResource = "SpChar_Ghoul_NF"
  },
  [1952] = {
    ID = 1952,
    CnID = "食尸鬼小女孩",
    BaseSortID = 952,
    RoleName = "AvgRole_1952_RoleName|食尸鬼小女孩",
    AwakerResource = "SpChar_Girl_NF"
  },
  [1953] = {
    ID = 1953,
    CnID = "食尸鬼士兵",
    BaseSortID = 953,
    RoleName = "AvgRole_1953_RoleName|食尸鬼士兵",
    HeadIcon = "Portrait_Small_Monster_S2C0304"
  },
  [1954] = {
    ID = 1954,
    CnID = "食尸鬼侍从",
    BaseSortID = 954,
    RoleName = "AvgRole_1954_RoleName|食尸鬼侍从",
    AwakerResource = "SpChar_Ghoul_NF"
  },
  [1955] = {
    ID = 1955,
    CnID = "食尸鬼融蚀体",
    BaseSortID = 955,
    RoleName = "AvgRole_1955_RoleName|食尸鬼融蚀体",
    HeadIcon = "Portrait_Small_Monster_S2C0302"
  },
  [1956] = {
    ID = 1956,
    CnID = "食尸鬼融蚀体？",
    BaseSortID = 956,
    RoleName = "AvgRole_1956_RoleName|？？？",
    HeadIcon = "Portrait_Small_Monster_S2C0302"
  },
  [1957] = {
    ID = 1957,
    CnID = "糖果店老板",
    BaseSortID = 957,
    RoleName = "AvgRole_1957_RoleName|糖果店老板",
    AwakerResource = "SpChar_Ghoul_NF"
  },
  [1958] = {
    ID = 1958,
    CnID = "交易所老板",
    BaseSortID = 958,
    RoleName = "AvgRole_1958_RoleName|交易所老板",
    AwakerResource = "SpChar_Ghoul_NF"
  },
  [1959] = {
    ID = 1959,
    CnID = "占卜店老板",
    BaseSortID = 959,
    RoleName = "AvgRole_1959_RoleName|占卜店老板",
    AwakerResource = "SpChar_Ghoul_NF"
  },
  [1960] = {
    ID = 1960,
    CnID = "化妆店老板",
    BaseSortID = 960,
    RoleName = "AvgRole_1960_RoleName|化妆店老板",
    AwakerResource = "SpChar_Ghoul_NF"
  },
  [1961] = {
    ID = 1961,
    CnID = "杜勒赛因？",
    BaseSortID = 961,
    RoleName = "AvgRole_1961_RoleName|？？？",
    AwakerResource = "B10_AF"
  },
  [1962] = {
    ID = 1962,
    CnID = "皮克曼",
    BaseSortID = 962,
    RoleName = "AvgRole_1962_RoleName|皮克曼",
    AwakerResource = "B12_AF",
    Sign = "AvgRole_1962_Sign|诚招模特！欢迎来到皮克曼的艺术殿堂！"
  },
  [1963] = {
    ID = 1963,
    CnID = "皮克曼？",
    BaseSortID = 963,
    RoleName = "AvgRole_1963_RoleName|？？？",
    AwakerResource = "B12_AF"
  },
  [1964] = {
    ID = 1964,
    CnID = "弗兰",
    BaseSortID = 964,
    RoleName = "AvgRole_1964_RoleName|弗兰",
    Tittle = "AvgRole_1964_Tittle|王邸管家",
    AwakerResource = "SpChar_Fran_NF"
  },
  [1965] = {
    ID = 1965,
    CnID = "弗兰？",
    BaseSortID = 965,
    RoleName = "AvgRole_1965_RoleName|？？？",
    AwakerResource = "SpChar_Fran_NF"
  },
  [1966] = {
    ID = 1966,
    CnID = "伊莱娜",
    BaseSortID = 966,
    RoleName = "AvgRole_1966_RoleName|伊莱娜",
    AwakerResource = "SpChar_Female_NF"
  },
  [1967] = {
    ID = 1967,
    CnID = "伊莱娜？",
    BaseSortID = 967,
    RoleName = "AvgRole_1967_RoleName|？？？",
    AwakerResource = "SpChar_Female_NF"
  },
  [1968] = {
    ID = 1968,
    CnID = "腐潮之傀",
    BaseSortID = 968,
    RoleName = "AvgRole_1968_RoleName|腐潮之傀",
    HeadIcon = "Portrait_Small_Monster_S2B0003"
  },
  [1969] = {
    ID = 1969,
    CnID = "腐潮之傀？",
    BaseSortID = 969,
    RoleName = "AvgRole_1969_RoleName|？？？",
    HeadIcon = "Portrait_Small_Monster_S2B0003"
  },
  [1970] = {
    ID = 1970,
    CnID = "本源墨菲？",
    BaseSortID = 970,
    RoleName = "AvgRole_1970_RoleName|？？？",
    AwakerResource = "SpChar_MurphyIllusory_NF"
  },
  [1971] = {
    ID = 1971,
    CnID = "本源图鲁？",
    BaseSortID = 971,
    RoleName = "AvgRole_1971_RoleName|？？？"
  },
  [1972] = {
    ID = 1972,
    CnID = "蹈海者祭司",
    BaseSortID = 972,
    RoleName = "AvgRole_1972_RoleName|蹈海者祭司",
    HeadIcon = "Portrait_Small_Monster_C0502_BOSSSIZE"
  },
  [1973] = {
    ID = 1973,
    CnID = "食尸鬼合唱",
    BaseSortID = 973,
    RoleName = "AvgRole_1973_RoleName|食尸鬼合唱"
  },
  [1974] = {
    ID = 1974,
    CnID = "神母墨菲？",
    BaseSortID = 974,
    RoleName = "AvgRole_1974_RoleName|？？？",
    AwakerResource = "SpChar_MurphyIllusory_NF"
  },
  [1975] = {
    ID = 1975,
    CnID = "舞蹈莉兹",
    BaseSortID = 975,
    RoleName = "AvgRole_1975_RoleName|莉兹",
    AwakerResource = "SpChar_Liz_NF"
  },
  [1976] = {
    ID = 1976,
    CnID = "沙漠居民怪物版",
    BaseSortID = 976,
    RoleName = "AvgRole_1976_RoleName|怪物居民",
    AwakerResource = "SpChar_DesertDwellerMonster_NF"
  },
  [1977] = {
    ID = 1977,
    CnID = "沙漠居民怪物版2",
    BaseSortID = 977,
    RoleName = "AvgRole_1977_RoleName|怪物居民",
    AwakerResource = "SpChar_DesertDwellerMonster_NF"
  },
  [1978] = {
    ID = 1978,
    CnID = "卡斯托尔AF",
    BaseSortID = 978,
    RoleName = "AvgRole_1978_RoleName|卡斯托尔",
    AwakerResource = "D11_AF"
  },
  [1979] = {
    ID = 1979,
    CnID = "波吕克斯AF",
    BaseSortID = 979,
    RoleName = "AvgRole_1979_RoleName|波吕克斯AF",
    AwakerResource = "D14_AF"
  },
  [1980] = {
    ID = 1980,
    CnID = "波吕克斯NF",
    BaseSortID = 980,
    RoleName = "AvgRole_1980_RoleName|波吕克斯NF",
    AwakerResource = "D14_NF"
  },
  [1981] = {
    ID = 1981,
    CnID = "卡斯托尔NF",
    BaseSortID = 981,
    RoleName = "AvgRole_1981_RoleName|卡斯托尔NF",
    AwakerResource = "D11_NF"
  },
  [1982] = {
    ID = 1982,
    CnID = "少年卡斯托尔",
    BaseSortID = 982,
    RoleName = "AvgRole_1982_RoleName|少年卡斯托尔",
    AwakerResource = "D11_NF"
  },
  [1983] = {
    ID = 1983,
    CnID = "少年波吕克斯",
    BaseSortID = 983,
    RoleName = "AvgRole_1983_RoleName|少年波吕克斯",
    AwakerResource = "SpChar_D14Wings_NF"
  },
  [1984] = {
    ID = 1984,
    CnID = "被寄生的居民",
    BaseSortID = 984,
    RoleName = "AvgRole_1984_RoleName|被寄生的居民"
  },
  [1985] = {
    ID = 1985,
    CnID = "「痛苦的影子」",
    BaseSortID = 985,
    RoleName = "AvgRole_1985_RoleName|「痛苦的影子」",
    AwakerResource = "D14_NF"
  },
  [1986] = {
    ID = 1986,
    CnID = "「少年波吕克斯」",
    BaseSortID = 986,
    RoleName = "AvgRole_1986_RoleName|「少年波吕克斯」",
    AwakerResource = "D14_NF"
  },
  [1987] = {
    ID = 1987,
    CnID = "赛琳涅",
    BaseSortID = 987,
    RoleName = "AvgRole_1987_RoleName|赛琳涅",
    AwakerResource = "SpChar_Female_NF"
  },
  [1988] = {
    ID = 1988,
    CnID = "赛琳涅？",
    BaseSortID = 988,
    RoleName = "AvgRole_1988_RoleName|？？？",
    AwakerResource = "SpChar_Female_NF"
  },
  [1989] = {
    ID = 1989,
    CnID = "蹈海者士兵",
    BaseSortID = 989,
    RoleName = "AvgRole_1989_RoleName|蹈海者士兵",
    HeadIcon = "Portrait_Small_Monster_C0502"
  },
  [1990] = {
    ID = 1990,
    CnID = "蹈海者们",
    BaseSortID = 990,
    RoleName = "AvgRole_1990_RoleName|蹈海者们",
    HeadIcon = "Portrait_Small_Monster_C0502"
  },
  [1991] = {
    ID = 1991,
    CnID = "食尸鬼祭司",
    BaseSortID = 991,
    RoleName = "AvgRole_1991_RoleName|食尸鬼祭司",
    HeadIcon = "Portrait_Small_Monster_S2C0303"
  },
  [1992] = {
    ID = 1992,
    CnID = "凯蒂古拉",
    BaseSortID = 992,
    RoleName = "AvgRole_1992_RoleName|凯蒂古拉",
    AwakerResource = "C16_AF",
    Sign = "AvgRole_1992_Sign|「N」的信徒可凭自身地址免单。"
  },
  [1993] = {
    ID = 1993,
    CnID = "尤乌哈希精二",
    BaseSortID = 993,
    RoleName = "AvgRole_1993_RoleName|尤乌哈希",
    AwakerResource = "SpChar_Uvhash_NF"
  },
  [1994] = {
    ID = 1994,
    CnID = "？？？_卢修斯",
    BaseSortID = 994,
    RoleName = "AvgRole_1994_RoleName|？？？"
  },
  [1995] = {
    ID = 1995,
    CnID = "？？？_凯蒂古拉",
    BaseSortID = 995,
    RoleName = "AvgRole_1995_RoleName|？？？"
  },
  [1996] = {
    ID = 1996,
    CnID = "？？？_蒂卡",
    BaseSortID = 996,
    RoleName = "AvgRole_1996_RoleName|？？？",
    AwakerResource = "SpChar_Lisa_Shadow_NF"
  },
  [1997] = {
    ID = 1997,
    CnID = "阿黛拉",
    BaseSortID = 997,
    RoleName = "AvgRole_1997_RoleName|阿黛拉",
    AwakerResource = "SpChar_Girl_NF"
  },
  [1998] = {
    ID = 1998,
    CnID = "路易斯",
    BaseSortID = 998,
    RoleName = "AvgRole_1998_RoleName|路易斯",
    AwakerResource = "SpChar_LemuriaEnos_NF"
  },
  [1999] = {
    ID = 1999,
    CnID = "伊斯梅尔",
    BaseSortID = 999,
    RoleName = "AvgRole_1999_RoleName|伊斯梅尔",
    AwakerResource = "SpChar_Boy_NF"
  },
  [2000] = {
    ID = 2000,
    CnID = "N",
    BaseSortID = 1000,
    RoleName = "AvgRole_2000_RoleName|「N」",
    AwakerResource = "SpChar_N_NF"
  },
  [2001] = {
    ID = 2001,
    CnID = "？？？_N",
    BaseSortID = 1001,
    RoleName = "AvgRole_2001_RoleName|？？？",
    AwakerResource = "SpChar_MaskMan_Shadow_NF"
  },
  [2002] = {
    ID = 2002,
    CnID = "？？？_凯蒂古拉燃烧",
    BaseSortID = 1002,
    RoleName = "AvgRole_2002_RoleName|？？？",
    AwakerResource = "C16_AF"
  },
  [2003] = {
    ID = 2003,
    CnID = "凯蒂古拉_燃烧",
    BaseSortID = 1003,
    RoleName = "AvgRole_2003_RoleName|凯蒂古拉",
    AwakerResource = "C16_AF"
  },
  [2004] = {
    ID = 2004,
    CnID = "不知名的调查员",
    BaseSortID = 1004,
    RoleName = "AvgRole_2004_RoleName|不知名的调查员"
  },
  [2005] = {
    ID = 2005,
    CnID = "镰刀怪物",
    BaseSortID = 1005,
    RoleName = "AvgRole_2005_RoleName|怪物",
    AwakerResource = "SpChar_SkullHunter1_NF"
  },
  [2006] = {
    ID = 2006,
    CnID = "无头怪物",
    BaseSortID = 1006,
    RoleName = "AvgRole_2006_RoleName|怪物",
    AwakerResource = "SpChar_SkullHunter2_NF"
  },
  [2007] = {
    ID = 2007,
    CnID = "N_战损",
    BaseSortID = 1007,
    RoleName = "AvgRole_2007_RoleName|「N」",
    AwakerResource = "SpChar_N_Break_NF"
  },
  [2008] = {
    ID = 2008,
    CnID = "蒂卡",
    BaseSortID = 1008,
    RoleName = "AvgRole_2008_RoleName|蒂卡",
    AwakerResource = "SpChar_Lisa_Shadow_NF"
  },
  [2009] = {
    ID = 2009,
    CnID = "卢修斯",
    BaseSortID = 1009,
    RoleName = "AvgRole_2009_RoleName|卢修斯",
    AwakerResource = "SpChar_Iglen_Shadow_NF"
  },
  [2010] = {
    ID = 2010,
    CnID = "邪教徒",
    BaseSortID = 1010,
    RoleName = "AvgRole_2010_RoleName|邪教徒",
    AwakerResource = "SpChar_LemuriaOldMan_NF"
  },
  [2011] = {
    ID = 2011,
    CnID = "西奥多",
    BaseSortID = 1011,
    RoleName = "AvgRole_2011_RoleName|西奥多"
  },
  [2012] = {
    ID = 2012,
    CnID = "？？？_N2",
    BaseSortID = 1012,
    RoleName = "AvgRole_2012_RoleName|？？？",
    AwakerResource = "SpChar_MaskMan_NF"
  },
  [2013] = {
    ID = 2013,
    CnID = "面具男阴影",
    BaseSortID = 1013,
    RoleName = "AvgRole_2013_RoleName|面具男阴影",
    AwakerResource = "SpChar_MaskMan_Shadow_NF"
  },
  [2014] = {
    ID = 2014,
    CnID = "以格伦阴影",
    BaseSortID = 1014,
    RoleName = "AvgRole_2014_RoleName|以格伦阴影",
    AwakerResource = "SpChar_Iglen_Shadow_NF"
  },
  [2015] = {
    ID = 2015,
    CnID = "丽莎阴影",
    BaseSortID = 1015,
    RoleName = "AvgRole_2015_RoleName|丽莎阴影",
    AwakerResource = "SpChar_Lisa_Shadow_NF"
  },
  [2016] = {
    ID = 2016,
    CnID = "猪人剪影",
    BaseSortID = 1016,
    RoleName = "AvgRole_2016_RoleName|猪人剪影",
    AwakerResource = "SpChar_PigMale_NF"
  },
  [2017] = {
    ID = 2017,
    CnID = "皮克曼剪影",
    BaseSortID = 1017,
    RoleName = "AvgRole_2017_RoleName|皮克曼剪影",
    AwakerResource = "SpChar_PigMan_NF"
  },
  [2018] = {
    ID = 2018,
    CnID = "胆小的市民",
    BaseSortID = 1018,
    RoleName = "AvgRole_2018_RoleName|胆小的市民",
    AwakerResource = "SpChar_Ghoul_NF"
  },
  [2019] = {
    ID = 2019,
    CnID = "随性的市民",
    BaseSortID = 1019,
    RoleName = "AvgRole_2019_RoleName|随性的市民",
    AwakerResource = "SpChar_Ghoul_NF"
  },
  [2020] = {
    ID = 2020,
    CnID = "N_面具",
    BaseSortID = 1020,
    RoleName = "AvgRole_2020_RoleName|「N」",
    AwakerResource = "SpChar_MaskMan_NF"
  },
  [2021] = {
    ID = 2021,
    CnID = "凯蒂古拉？",
    BaseSortID = 1021,
    RoleName = "AvgRole_2021_RoleName|？？？",
    AwakerResource = "C16_HF"
  },
  [2022] = {
    ID = 2022,
    CnID = "酒馆老板",
    BaseSortID = 1022,
    RoleName = "AvgRole_2022_RoleName|酒馆老板",
    AwakerResource = "SpChar_ButterflyFemale_NF"
  },
  [2023] = {
    ID = 2023,
    CnID = "酒馆老板（人形）",
    BaseSortID = 1023,
    RoleName = "AvgRole_2023_RoleName|酒馆老板",
    AwakerResource = "SpChar_Female_NF"
  },
  [2024] = {
    ID = 2024,
    CnID = "蛇头人",
    BaseSortID = 1024,
    RoleName = "AvgRole_2024_RoleName|盆栽店老板",
    AwakerResource = "SpChar_Apophis_NF"
  },
  [2025] = {
    ID = 2025,
    CnID = "无头人",
    BaseSortID = 1025,
    RoleName = "AvgRole_2025_RoleName|工艺品店老板",
    AwakerResource = "SpChar_SkullHunter2_NF"
  },
  [2026] = {
    ID = 2026,
    CnID = "蜜蜂人",
    BaseSortID = 1026,
    RoleName = "AvgRole_2026_RoleName|花粉店老板",
    AwakerResource = "SpChar_BeeMale_NF"
  },
  [2027] = {
    ID = 2027,
    CnID = "花头人",
    BaseSortID = 1027,
    RoleName = "AvgRole_2027_RoleName|颜料店老板",
    AwakerResource = "SpChar_FlowerMale_NF"
  },
  [2028] = {
    ID = 2028,
    CnID = "达达主义画家",
    BaseSortID = 1028,
    RoleName = "AvgRole_2028_RoleName|达达主义画家",
    AwakerResource = "SpChar_PigMale_NF"
  },
  [2029] = {
    ID = 2029,
    CnID = "古典主义画家",
    BaseSortID = 1029,
    RoleName = "AvgRole_2029_RoleName|古典主义画家",
    AwakerResource = "SpChar_PigMale_NF"
  },
  [2030] = {
    ID = 2030,
    CnID = "印象主义画家",
    BaseSortID = 1030,
    RoleName = "AvgRole_2030_RoleName|印象主义画家",
    AwakerResource = "SpChar_PigMale_NF"
  },
  [2031] = {
    ID = 2031,
    CnID = "象征主义画家",
    BaseSortID = 1031,
    RoleName = "AvgRole_2031_RoleName|象征主义画家",
    AwakerResource = "SpChar_PigMale_NF"
  },
  [2032] = {
    ID = 2032,
    CnID = "达达主义画家（人形）",
    BaseSortID = 1032,
    RoleName = "AvgRole_2032_RoleName|达达主义画家",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [2033] = {
    ID = 2033,
    CnID = "古典主义画家（人形）",
    BaseSortID = 1033,
    RoleName = "AvgRole_2033_RoleName|古典主义画家",
    AwakerResource = "SpChar_Male_NF"
  },
  [2034] = {
    ID = 2034,
    CnID = "印象主义画家（人形）",
    BaseSortID = 1034,
    RoleName = "AvgRole_2034_RoleName|印象主义画家",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [2035] = {
    ID = 2035,
    CnID = "象征主义画家（人形）",
    BaseSortID = 1035,
    RoleName = "AvgRole_2035_RoleName|象征主义画家",
    AwakerResource = "SpChar_Male_NF"
  },
  [2036] = {
    ID = 2036,
    CnID = "王邸管家？",
    BaseSortID = 1036,
    RoleName = "AvgRole_2036_RoleName|威严的老人",
    AwakerResource = "SpChar_Fran_NF"
  },
  [2037] = {
    ID = 2037,
    CnID = "王邸管家",
    BaseSortID = 1037,
    RoleName = "AvgRole_2037_RoleName|王邸管家",
    AwakerResource = "SpChar_Fran_NF"
  },
  [2038] = {
    ID = 2038,
    CnID = "粗鲁的贵族",
    BaseSortID = 1038,
    RoleName = "AvgRole_2038_RoleName|粗鲁的贵族",
    AwakerResource = "SpChar_BearMan_NF"
  },
  [2039] = {
    ID = 2039,
    CnID = "矜持的贵族",
    BaseSortID = 1039,
    RoleName = "AvgRole_2039_RoleName|矜持的贵族",
    AwakerResource = "SpChar_FoxMan_NF"
  },
  [2040] = {
    ID = 2040,
    CnID = "兴奋的贵族",
    BaseSortID = 1040,
    RoleName = "AvgRole_2040_RoleName|兴奋的贵族",
    AwakerResource = "SpChar_PigMale_NF"
  },
  [2041] = {
    ID = 2041,
    CnID = "温柔的舞女",
    BaseSortID = 1041,
    RoleName = "AvgRole_2041_RoleName|温柔的舞女",
    AwakerResource = "SpChar_ButterflyFemale_NF"
  },
  [2042] = {
    ID = 2042,
    CnID = "妖娆的舞女",
    BaseSortID = 1042,
    RoleName = "AvgRole_2042_RoleName|妖娆的舞女",
    AwakerResource = "SpChar_AllenMonster_NF"
  },
  [2043] = {
    ID = 2043,
    CnID = "城邦君主",
    BaseSortID = 1043,
    RoleName = "AvgRole_2043_RoleName|城邦君主",
    AwakerResource = "SpChar_Iglen_Shadow_NF"
  },
  [2044] = {
    ID = 2044,
    CnID = "城邦士兵",
    BaseSortID = 1044,
    RoleName = "AvgRole_2044_RoleName|城邦士兵",
    AwakerResource = "SpChar_Knight_NF"
  },
  [2045] = {
    ID = 2045,
    CnID = "皮克曼的阴影",
    BaseSortID = 1045,
    RoleName = "AvgRole_2045_RoleName|皮克曼？",
    AwakerResource = "B12_AF"
  },
  [2046] = {
    ID = 2046,
    CnID = "凯蒂古拉_人类",
    BaseSortID = 1046,
    RoleName = "AvgRole_2046_RoleName|凯蒂古拉",
    AwakerResource = "C16_HF"
  },
  [2047] = {
    ID = 2047,
    CnID = "泳装环拉",
    BaseSortID = 1047,
    RoleName = "AvgRole_2047_RoleName|环行·拉蒙娜",
    AwakerResource = "SpChar_C01EXSwimsuit_NF"
  },
  [2048] = {
    ID = 2048,
    CnID = "太阳帽奥尔拉",
    BaseSortID = 1048,
    RoleName = "AvgRole_2048_RoleName|奥尔拉",
    AwakerResource = "SpChar_D06Hat_NF"
  },
  [2049] = {
    ID = 2049,
    CnID = "墨镜墨菲",
    BaseSortID = 1049,
    RoleName = "AvgRole_2049_RoleName|墨菲",
    AwakerResource = "SpChar_O02Glasses_NF"
  },
  [2050] = {
    ID = 2050,
    CnID = "冰淇淋潘狄娅",
    BaseSortID = 1050,
    RoleName = "AvgRole_2050_RoleName|潘狄娅",
    AwakerResource = "SpChar_C09lce_NF"
  },
  [2051] = {
    ID = 2051,
    CnID = "游泳圈菲茵特",
    BaseSortID = 1051,
    RoleName = "AvgRole_2051_RoleName|菲茵特",
    AwakerResource = "SpChar_B09SwimRing_NF"
  },
  [2052] = {
    ID = 2052,
    CnID = "凯蒂古拉？？？",
    BaseSortID = 1052,
    RoleName = "AvgRole_2052_RoleName|？？？",
    AwakerResource = "C16_AF"
  },
  [2053] = {
    ID = 2053,
    CnID = "诃勒特？",
    BaseSortID = 1053,
    RoleName = "AvgRole_2053_RoleName|？？？",
    AwakerResource = "SpChar_Czort_NF"
  },
  [2054] = {
    ID = 2054,
    CnID = "男学生",
    BaseSortID = 1054,
    RoleName = "AvgRole_2054_RoleName|男学生",
    AwakerResource = "SpChar_Boy_NF"
  },
  [2055] = {
    ID = 2055,
    CnID = "女学生",
    BaseSortID = 1055,
    RoleName = "AvgRole_2055_RoleName|女学生",
    AwakerResource = "SpChar_Girl_NF"
  },
  [2056] = {
    ID = 2056,
    CnID = "艾拉？？？",
    BaseSortID = 1056,
    RoleName = "AvgRole_2056_RoleName|女孩",
    AwakerResource = "SpChar_Lisa_NF"
  },
  [2057] = {
    ID = 2057,
    CnID = "艾拉",
    BaseSortID = 1057,
    RoleName = "AvgRole_2057_RoleName|艾拉",
    AwakerResource = "SpChar_Lisa_NF"
  },
  [2058] = {
    ID = 2058,
    CnID = "托伦",
    BaseSortID = 1058,
    RoleName = "AvgRole_2058_RoleName|托伦",
    AwakerResource = "SpChar_Guide_NF"
  },
  [2059] = {
    ID = 2059,
    CnID = "盖尔？？？",
    BaseSortID = 1059,
    RoleName = "AvgRole_2059_RoleName|？？？",
    AwakerResource = "SpChar_MaleHead1_NF"
  },
  [2060] = {
    ID = 2060,
    CnID = "盖尔",
    BaseSortID = 1060,
    RoleName = "AvgRole_2060_RoleName|盖尔",
    AwakerResource = "SpChar_MaleHead1_NF"
  },
  [2061] = {
    ID = 2061,
    CnID = "巴索",
    BaseSortID = 1061,
    RoleName = "AvgRole_2061_RoleName|巴索",
    AwakerResource = "SpChar_LemuriaMan_NF"
  },
  [2062] = {
    ID = 2062,
    CnID = "马尔科",
    BaseSortID = 1062,
    RoleName = "AvgRole_2062_RoleName|马尔科",
    AwakerResource = "SpChar_Iglen_Shadow_NF"
  },
  [2063] = {
    ID = 2063,
    CnID = "卡利安",
    BaseSortID = 1063,
    RoleName = "AvgRole_2063_RoleName|卡利安",
    AwakerResource = "SpChar_LemuriaEnos_NF"
  },
  [2064] = {
    ID = 2064,
    CnID = "叛军士兵",
    BaseSortID = 1064,
    RoleName = "AvgRole_2064_RoleName|叛军士兵",
    AwakerResource = "SpChar_LemuriaMan_NF"
  },
  [2065] = {
    ID = 2065,
    CnID = "叛军头目",
    BaseSortID = 1065,
    RoleName = "AvgRole_2065_RoleName|叛军头目",
    AwakerResource = "SpChar_Male_NF"
  },
  [2066] = {
    ID = 2066,
    CnID = "礼官",
    BaseSortID = 1066,
    RoleName = "AvgRole_2066_RoleName|礼官",
    AwakerResource = "SpChar_FemaleHead1_NF"
  },
  [2067] = {
    ID = 2067,
    CnID = "新兵",
    BaseSortID = 1067,
    RoleName = "AvgRole_2067_RoleName|新兵",
    AwakerResource = "SpChar_MaleHead2_NF"
  },
  [2068] = {
    ID = 2068,
    CnID = "波吕克斯_翅膀",
    BaseSortID = 1068,
    RoleName = "AvgRole_2068_RoleName|波吕克斯",
    AwakerResource = "SpChar_D14Wings_NF"
  },
  [2069] = {
    ID = 2069,
    CnID = "波吕克斯_融合",
    BaseSortID = 1069,
    RoleName = "AvgRole_2069_RoleName|波吕克斯",
    AwakerResource = "SpChar_D14Fuse_NF"
  },
  [2070] = {
    ID = 2070,
    CnID = "波吕克斯纸板",
    BaseSortID = 1070,
    AwakerResource = "SpChar_D14doll_NF"
  },
  [2080] = {
    ID = 2080,
    CnID = "卡斯托尔纸板",
    BaseSortID = 1071,
    AwakerResource = "SpChar_D11doll_NF"
  },
  [7777001] = {
    ID = 7777001,
    CnID = "墨菲_万圣皮肤",
    BaseSortID = 1072,
    RoleName = "AvgRole_7777001_RoleName|墨菲",
    AwakerResource = "O02S02_AF"
  },
  [2071] = {
    ID = 2071,
    CnID = "波吕克斯纸板_笑脸",
    BaseSortID = 1073,
    AwakerResource = "SpChar_D14doll2_NF"
  },
  [2081] = {
    ID = 2081,
    CnID = "卡斯托尔纸板_笑脸",
    BaseSortID = 1074,
    AwakerResource = "SpChar_D11doll2_NF"
  },
  [2100] = {
    ID = 2100,
    CnID = "诞妄·墨菲",
    BaseSortID = 1075,
    RoleName = "AvgRole_2100_RoleName|墨菲",
    AwakerResource = "O02EX_AF",
    Sign = "AvgRole_2100_Sign|如何买完所有限定款？"
  },
  [2101] = {
    ID = 2101,
    CnID = "？？？（诞妄·墨菲）",
    BaseSortID = 1076,
    RoleName = "AvgRole_2101_RoleName|？？？",
    AwakerResource = "O02EX_AF"
  },
  [2102] = {
    ID = 2102,
    CnID = "？？？（阿拉克涅）",
    BaseSortID = 1077,
    RoleName = "AvgRole_2102_RoleName|？？？",
    AwakerResource = "D10_AF"
  },
  [2103] = {
    ID = 2103,
    CnID = "？？？（法洛思）",
    BaseSortID = 1078,
    RoleName = "AvgRole_2103_RoleName|？？？",
    AwakerResource = "O03_NF"
  },
  [2104] = {
    ID = 2104,
    CnID = "手持纺轮的女人",
    BaseSortID = 1079,
    RoleName = "AvgRole_2104_RoleName|手持纺轮的女人",
    AwakerResource = "D10_AF"
  },
  [2105] = {
    ID = 2105,
    CnID = "？？？_墨菲BOSS",
    BaseSortID = 1080,
    RoleName = "AvgRole_2105_RoleName|？？？"
  },
  [2106] = {
    ID = 2106,
    CnID = "？？？（神王图鲁）",
    BaseSortID = 1081,
    RoleName = "AvgRole_2106_RoleName|？？？",
    AwakerResource = "SpChar_AdultTulu_NF"
  },
  [2107] = {
    ID = 2107,
    CnID = "疯狂的蹈海祭司",
    BaseSortID = 1082,
    RoleName = "AvgRole_2107_RoleName|疯狂的蹈海祭司",
    HeadIcon = "Portrait_Small_Monster_C0502_BOSSSIZE"
  },
  [2120] = {
    ID = 2120,
    CnID = "拉蒙娜？",
    BaseSortID = 1083,
    RoleName = "AvgRole_2120_RoleName|？？？",
    AwakerResource = "C01_AF"
  },
  [2130] = {
    ID = 2130,
    CnID = "尖细的声音",
    BaseSortID = 1084,
    RoleName = "AvgRole_2130_RoleName|尖细的声音",
    AwakerResource = "SpChar_Lisa_Shadow_NF"
  },
  [2131] = {
    ID = 2131,
    CnID = "幸灾乐祸的声音",
    BaseSortID = 1085,
    RoleName = "AvgRole_2131_RoleName|幸灾乐祸的声音",
    AwakerResource = "SpChar_Female_NF"
  },
  [2132] = {
    ID = 2132,
    CnID = "妈妈？",
    BaseSortID = 1086,
    RoleName = "AvgRole_2132_RoleName|妈妈？",
    AwakerResource = "B14_HF"
  },
  [2133] = {
    ID = 2133,
    CnID = "徐",
    BaseSortID = 1087,
    RoleName = "AvgRole_2133_RoleName|徐",
    AwakerResource = "B14_HF"
  },
  [2134] = {
    ID = 2134,
    CnID = "穿洋装的男人",
    BaseSortID = 1088,
    RoleName = "AvgRole_2134_RoleName|穿洋装的男人",
    AwakerResource = "SpChar_EastMaleDu_NF"
  },
  [2135] = {
    ID = 2135,
    CnID = "做苦力的男人",
    BaseSortID = 1089,
    RoleName = "AvgRole_2135_RoleName|做苦力的男人",
    AwakerResource = "SpChar_Iglen_Shadow_NF"
  },
  [2136] = {
    ID = 2136,
    CnID = "打扮考究的男人",
    BaseSortID = 1090,
    RoleName = "AvgRole_2136_RoleName|打扮考究的男人",
    AwakerResource = "SpChar_SailorNorman_NF"
  },
  [2137] = {
    ID = 2137,
    CnID = "疯狂的人们",
    BaseSortID = 1091,
    RoleName = "AvgRole_2137_RoleName|疯狂的人们",
    AwakerResource = "SpChar_Iglen_Shadow_NF"
  },
  [2138] = {
    ID = 2138,
    CnID = "何方",
    BaseSortID = 1092,
    RoleName = "AvgRole_2138_RoleName|何方",
    AwakerResource = "SpChar_EastMaleHe_NF"
  },
  [2139] = {
    ID = 2139,
    CnID = "杜姓权贵",
    BaseSortID = 1093,
    RoleName = "AvgRole_2139_RoleName|杜姓权贵",
    AwakerResource = "SpChar_EastMaleDu_NF"
  },
  [2140] = {
    ID = 2140,
    CnID = "浓妆的姨娘",
    BaseSortID = 1094,
    RoleName = "AvgRole_2140_RoleName|浓妆的姨娘",
    AwakerResource = "SpChar_EastFemale_NF"
  },
  [2141] = {
    ID = 2141,
    CnID = "素雅的姨娘",
    BaseSortID = 1095,
    RoleName = "AvgRole_2141_RoleName|素雅的姨娘",
    AwakerResource = "SpChar_EastFemale_NF"
  },
  [2142] = {
    ID = 2142,
    CnID = "怯懦的姨娘",
    BaseSortID = 1096,
    RoleName = "AvgRole_2142_RoleName|怯懦的姨娘",
    AwakerResource = "SpChar_EastFemale_NF"
  },
  [2143] = {
    ID = 2143,
    CnID = "落泪的姨娘",
    BaseSortID = 1097,
    RoleName = "AvgRole_2143_RoleName|落泪的姨娘",
    AwakerResource = "SpChar_EastFemale_NF"
  },
  [2144] = {
    ID = 2144,
    CnID = "姨娘们",
    BaseSortID = 1098,
    RoleName = "AvgRole_2144_RoleName|姨娘们",
    AwakerResource = "SpChar_EastFemale_NF"
  },
  [2145] = {
    ID = 2145,
    CnID = "威严的男人",
    BaseSortID = 1099,
    RoleName = "AvgRole_2145_RoleName|威严的男人",
    AwakerResource = "SpChar_SailorNorman_NF"
  },
  [2146] = {
    ID = 2146,
    CnID = "男人们",
    BaseSortID = 1100,
    RoleName = "AvgRole_2146_RoleName|男人们",
    AwakerResource = "SpChar_Sculptor_NF"
  },
  [2147] = {
    ID = 2147,
    CnID = "徐？",
    BaseSortID = 1101,
    RoleName = "AvgRole_2147_RoleName|徐？",
    AwakerResource = "B14_AF"
  },
  [2148] = {
    ID = 2148,
    CnID = "门童",
    BaseSortID = 1102,
    RoleName = "AvgRole_2148_RoleName|门童",
    AwakerResource = "SpChar_Boy_NF"
  },
  [2149] = {
    ID = 2149,
    CnID = "提灯蹈海者",
    BaseSortID = 1103,
    RoleName = "AvgRole_2149_RoleName|蹈海者祭司",
    HeadIcon = "Portrait_Small_Monster_S2C0404"
  },
  [2150] = {
    ID = 2150,
    CnID = "天之帷幕",
    BaseSortID = 1104,
    RoleName = "AvgRole_2150_RoleName|永恒帷幕",
    HeadIcon = "Portrait_Small_Monster_S2B0004_BT"
  },
  [2151] = {
    ID = 2151,
    CnID = "墨菲撑伞皮",
    BaseSortID = 1105,
    RoleName = "AvgRole_2151_RoleName|墨菲",
    AwakerResource = "O02S01_AF"
  },
  [2200] = {
    ID = 2200,
    CnID = "癫狂的男人",
    BaseSortID = 1106,
    RoleName = "AvgRole_2200_RoleName|癫狂的男人",
    Tittle = "AvgRole_2200_Tittle|被囚禁的受害者",
    AwakerResource = "SpChar_DisMale_NF"
  },
  [2201] = {
    ID = 2201,
    CnID = "崩溃的女人",
    BaseSortID = 1107,
    RoleName = "AvgRole_2201_RoleName|崩溃的女人",
    Tittle = "AvgRole_2201_Tittle|被囚禁的受害者",
    AwakerResource = "SpChar_Female_NF"
  },
  [2202] = {
    ID = 2202,
    CnID = "茉夏",
    BaseSortID = 1108,
    RoleName = "AvgRole_2202_RoleName|茉夏",
    AwakerResource = "C17_AF",
    Sign = "AvgRole_2202_Sign|为「茉夏的异世界冒险记」搜集有趣素材中，欢迎投稿！"
  },
  [2203] = {
    ID = 2203,
    CnID = "茉夏？",
    BaseSortID = 1109,
    RoleName = "AvgRole_2203_RoleName|？？？",
    AwakerResource = "C17_AF"
  },
  [2204] = {
    ID = 2204,
    CnID = "繁星黎明教徒甲",
    BaseSortID = 1110,
    RoleName = "AvgRole_2204_RoleName|教徒甲",
    AwakerResource = "SpChar_SailorNorman_NF"
  },
  [2205] = {
    ID = 2205,
    CnID = "繁星黎明教徒乙",
    BaseSortID = 1111,
    RoleName = "AvgRole_2205_RoleName|教徒乙",
    AwakerResource = "SpChar_Male_NF"
  },
  [2206] = {
    ID = 2206,
    CnID = "通讯器",
    BaseSortID = 1112,
    RoleName = "AvgRole_2206_RoleName|通讯器",
    AwakerResource = "SpChar_Broadcast_NF"
  },
  [2207] = {
    ID = 2207,
    CnID = "怀特",
    BaseSortID = 1113,
    RoleName = "AvgRole_2207_RoleName|怀特",
    AwakerResource = "SpChar_White_NF"
  },
  [2208] = {
    ID = 2208,
    CnID = "怀特？",
    BaseSortID = 1114,
    RoleName = "AvgRole_2208_RoleName|？？？",
    AwakerResource = "SpChar_White_NF"
  },
  [2209] = {
    ID = 2209,
    CnID = "繁星黎明信徒1",
    BaseSortID = 1115,
    RoleName = "AvgRole_2209_RoleName|繁星黎明会女信徒",
    AwakerResource = "SpChar_Female_NF"
  },
  [2210] = {
    ID = 2210,
    CnID = "繁星黎明信徒2",
    BaseSortID = 1116,
    RoleName = "AvgRole_2210_RoleName|繁星黎明会男信徒",
    AwakerResource = "SpChar_Male_NF"
  },
  [2211] = {
    ID = 2211,
    CnID = "吹笛仆从",
    BaseSortID = 1117,
    RoleName = "AvgRole_2211_RoleName|混沌笛音",
    AwakerResource = "SpChar_DisMale_NF"
  },
  [2212] = {
    ID = 2212,
    CnID = "玩家？",
    BaseSortID = 1118,
    RoleName = "AvgRole_2212_RoleName|<Yellow:？？？>",
    ShowAsPlayer = 1,
    AwakerResource = "SpChar_PlayerM_NF"
  },
  [2213] = {
    ID = 2213,
    CnID = "玩家镜像",
    BaseSortID = 1119,
    RoleName = "AvgRole_2213_RoleName|<Yellow:「%player%」>",
    ShowAsPlayer = 1,
    AwakerResource = "SpChar_PlayerM_NF"
  },
  [2214] = {
    ID = 2214,
    CnID = "繁星黎明教徒甲？",
    BaseSortID = 1120,
    RoleName = "AvgRole_2214_RoleName|？？？",
    AwakerResource = "SpChar_SailorNorman_NF"
  },
  [2215] = {
    ID = 2215,
    CnID = "繁星黎明教徒甲_展示用",
    BaseSortID = 1121,
    RoleName = "AvgRole_2215_RoleName|教徒甲",
    AwakerResource = "SpChar_SailorNorman_NF"
  },
  [2216] = {
    ID = 2216,
    CnID = "繁星黎明教徒乙_展示用",
    BaseSortID = 1122,
    RoleName = "AvgRole_2216_RoleName|教徒乙",
    AwakerResource = "SpChar_Male_NF"
  },
  [2217] = {
    ID = 2217,
    CnID = "繁星黎明教徒甲_展示用2",
    BaseSortID = 1123,
    RoleName = "AvgRole_2217_RoleName|教徒甲",
    AwakerResource = "SpChar_SailorNorman_NF"
  },
  [2218] = {
    ID = 2218,
    CnID = "繁星黎明教徒乙_展示用2",
    BaseSortID = 1124,
    RoleName = "AvgRole_2218_RoleName|教徒乙",
    AwakerResource = "SpChar_Male_NF"
  },
  [2219] = {
    ID = 2219,
    CnID = "无头猎颅者_展示用",
    BaseSortID = 1125,
    RoleName = "AvgRole_2219_RoleName|无头猎颅者",
    AwakerResource = "SpChar_SkullHunter2_NF"
  },
  [2220] = {
    ID = 2220,
    CnID = "茉夏_无斧头",
    BaseSortID = 1126,
    RoleName = "AvgRole_2220_RoleName|茉夏",
    AwakerResource = "C17_NF"
  },
  [2221] = {
    ID = 2221,
    CnID = "茉夏_无斧头？",
    BaseSortID = 1127,
    RoleName = "AvgRole_2221_RoleName|？？？",
    AwakerResource = "C17_NF"
  },
  [2222] = {
    ID = 2222,
    CnID = "茉夏人形",
    BaseSortID = 1128,
    RoleName = "AvgRole_2222_RoleName|茉夏",
    AwakerResource = "C17_AF2"
  },
  [2223] = {
    ID = 2223,
    CnID = "通讯器？",
    BaseSortID = 1129,
    RoleName = "AvgRole_2223_RoleName|迷雾中的声音",
    AwakerResource = "SpChar_Broadcast_NF"
  },
  [2224] = {
    ID = 2224,
    CnID = "小N",
    BaseSortID = 1130,
    RoleName = "AvgRole_2224_RoleName|小N",
    AwakerResource = "SpChar_LittleN_NF"
  },
  [2225] = {
    ID = 2225,
    CnID = "千扇玄女",
    BaseSortID = 1131,
    RoleName = "AvgRole_2225_RoleName|徐",
    AwakerResource = "B14_AF",
    Sign = "AvgRole_2225_Sign|人生得意须尽欢。"
  },
  [2226] = {
    ID = 2226,
    CnID = "表演姨娘",
    BaseSortID = 1132,
    RoleName = "AvgRole_2226_RoleName|？？？",
    AwakerResource = "SpChar_EastFemale_NF"
  },
  [2227] = {
    ID = 2227,
    CnID = "表演徐",
    BaseSortID = 1133,
    RoleName = "AvgRole_2227_RoleName|@1",
    AwakerResource = "B14_HF"
  },
  [2228] = {
    ID = 2228,
    CnID = "表演千扇玄女",
    BaseSortID = 1134,
    RoleName = "AvgRole_2228_RoleName|@1",
    AwakerResource = "B14_AF"
  },
  [2229] = {
    ID = 2229,
    CnID = "真正的妈妈",
    BaseSortID = 1135,
    RoleName = "AvgRole_2229_RoleName|妈妈？",
    AwakerResource = "SpChar_EastFemaleXu_NF"
  },
  [2230] = {
    ID = 2230,
    CnID = "玩家（德克斯特脸）",
    BaseSortID = 1136,
    RoleName = "AvgRole_2230_RoleName|<Yellow:%player%>",
    Tittle = "AvgRole_2230_Tittle|守密人",
    ShowAsPlayer = 1,
    AwakerResource = "SpChar_Dexter_NF"
  },
  [2231] = {
    ID = 2231,
    CnID = "表演徐二号",
    BaseSortID = 1137,
    RoleName = "AvgRole_2231_RoleName|@1",
    AwakerResource = "B14_HF"
  },
  [2232] = {
    ID = 2232,
    CnID = "表演徐三号",
    BaseSortID = 1138,
    RoleName = "AvgRole_2232_RoleName|徐？",
    AwakerResource = "B14_HF"
  },
  [2233] = {
    ID = 2233,
    CnID = "千扇玄女？",
    BaseSortID = 1139,
    RoleName = "AvgRole_2233_RoleName|？？？",
    AwakerResource = "B14_AF"
  },
  [2240] = {
    ID = 2240,
    CnID = "小煤球",
    BaseSortID = 1140,
    RoleName = "AvgRole_2240_RoleName|小煤球",
    Tittle = "AvgRole_2240_Tittle|<Yellow:%player%>",
    AwakerResource = "SpChar_Seaotters_NF"
  },
  [2241] = {
    ID = 2241,
    CnID = "小煤球？？？",
    BaseSortID = 1141,
    RoleName = "AvgRole_2241_RoleName|<Yellow:%player%>",
    AwakerResource = "SpChar_Seaotters_NF"
  },
  [2242] = {
    ID = 2242,
    CnID = "？？？（诺缔拉）",
    BaseSortID = 1142,
    RoleName = "AvgRole_2242_RoleName|？？？",
    AwakerResource = "C07_AF"
  },
  [2243] = {
    ID = 2243,
    CnID = "不知名海獭",
    BaseSortID = 1143,
    RoleName = "AvgRole_2243_RoleName|不知名海獭",
    AwakerResource = "SpChar_Seaotters2_NF"
  },
  [2244] = {
    ID = 2244,
    CnID = "莫丝_人类",
    BaseSortID = 1144,
    RoleName = "AvgRole_2244_RoleName|莫丝",
    AwakerResource = "O11_HF"
  },
  [2245] = {
    ID = 2245,
    CnID = "莫丝",
    BaseSortID = 1145,
    RoleName = "AvgRole_2245_RoleName|莫丝",
    AwakerResource = "O11_AF",
    Sign = "AvgRole_2245_Sign|朋友，联系，开心！"
  },
  [2246] = {
    ID = 2246,
    CnID = "小煤球二世",
    BaseSortID = 1146,
    RoleName = "AvgRole_2246_RoleName|小煤球二世",
    AwakerResource = "SpChar_Seaotters2_NF"
  },
  [2247] = {
    ID = 2247,
    CnID = "莫丝_NF",
    BaseSortID = 1147,
    RoleName = "AvgRole_2247_RoleName|莫丝",
    AwakerResource = "O11_NF"
  },
  [2248] = {
    ID = 2248,
    CnID = "诺缔拉_人类",
    BaseSortID = 1148,
    RoleName = "AvgRole_2248_RoleName|诺缔拉",
    AwakerResource = "C07_HF"
  },
  [2249] = {
    ID = 2249,
    CnID = "？？？（诺缔拉_人类）",
    BaseSortID = 1149,
    RoleName = "AvgRole_2249_RoleName|？？？",
    AwakerResource = "C07_HF"
  },
  [2250] = {
    ID = 2250,
    CnID = "木偶·黑衣勇者",
    BaseSortID = 1150,
    RoleName = "AvgRole_2250_RoleName|木偶·黑衣勇者",
    AwakerResource = "SpChar_PlayerMMarionette_NF"
  },
  [2251] = {
    ID = 2251,
    CnID = "木偶·银钥匙",
    BaseSortID = 1151,
    RoleName = "AvgRole_2251_RoleName|木偶·银钥匙",
    AwakerResource = "SpChar_PlayerFMarionette_NF"
  },
  [2252] = {
    ID = 2252,
    CnID = "冷蛛侍女（阴影）",
    BaseSortID = 1152,
    RoleName = "AvgRole_2252_RoleName|？？？",
    AwakerResource = "SpChar_LengSpiderMaidens_NF"
  },
  [2253] = {
    ID = 2253,
    CnID = "阿拉克涅（阴影）",
    BaseSortID = 1153,
    RoleName = "AvgRole_2253_RoleName|？？？",
    AwakerResource = "D10_NF"
  },
  [2254] = {
    ID = 2254,
    CnID = "胆小的孩子",
    BaseSortID = 1154,
    RoleName = "AvgRole_2254_RoleName|胆小的孩子",
    AwakerResource = "SpChar_Boy_NF"
  },
  [2255] = {
    ID = 2255,
    CnID = "渊博的学者",
    BaseSortID = 1155,
    RoleName = "AvgRole_2255_RoleName|渊博的学者",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [2256] = {
    ID = 2256,
    CnID = "刻薄的青年",
    BaseSortID = 1156,
    RoleName = "AvgRole_2256_RoleName|刻薄的青年",
    AwakerResource = "SpChar_Male_NF"
  },
  [2257] = {
    ID = 2257,
    CnID = "善良的老人",
    BaseSortID = 1157,
    RoleName = "AvgRole_2257_RoleName|善良的老人",
    AwakerResource = "SpChar_LemuriaOldMan_NF"
  },
  [2258] = {
    ID = 2258,
    CnID = "严肃的警员",
    BaseSortID = 1158,
    RoleName = "AvgRole_2258_RoleName|严肃的警员",
    AwakerResource = "SpChar_MTCAgent_NF"
  },
  [2259] = {
    ID = 2259,
    CnID = "温柔的警员",
    BaseSortID = 1159,
    RoleName = "AvgRole_2259_RoleName|温柔的警员",
    AwakerResource = "SpChar_MTCAgent_NF"
  },
  [2260] = {
    ID = 2260,
    CnID = "渊狱侍从？",
    BaseSortID = 1160,
    RoleName = "AvgRole_2260_RoleName|？？？",
    AwakerResource = "SpChar_AbyssalprisonMaidens_NF"
  },
  [2261] = {
    ID = 2261,
    CnID = "醉酒的中年",
    BaseSortID = 1161,
    RoleName = "AvgRole_2261_RoleName|落魄的中年",
    AwakerResource = "SpChar_Bertrand_NF"
  },
  [2262] = {
    ID = 2262,
    CnID = "爽朗的女性_阿拉克涅剧情",
    BaseSortID = 1162,
    RoleName = "AvgRole_2262_RoleName|爽朗的女性",
    AwakerResource = "SpChar_LengSpiderMaidens_NF"
  },
  [2263] = {
    ID = 2263,
    CnID = "浪漫的调酒师",
    BaseSortID = 1163,
    RoleName = "AvgRole_2263_RoleName|调酒师",
    AwakerResource = "SpChar_Romantic_NF"
  },
  [2264] = {
    ID = 2264,
    CnID = "冷漠的侍者",
    BaseSortID = 1164,
    RoleName = "AvgRole_2264_RoleName|冷漠的侍者",
    AwakerResource = "SpChar_TheWax_NF"
  },
  [2265] = {
    ID = 2265,
    CnID = "酒吧众人",
    BaseSortID = 1165,
    RoleName = "AvgRole_2265_RoleName|酒吧众人"
  },
  [2266] = {
    ID = 2266,
    CnID = "冷蛛侍女？",
    BaseSortID = 1166,
    RoleName = "AvgRole_2266_RoleName|？？？",
    AwakerResource = "SpChar_LengSpiderMaidens_NF"
  },
  [2267] = {
    ID = 2267,
    CnID = "木偶·浪漫",
    BaseSortID = 1167,
    RoleName = "AvgRole_2267_RoleName|木偶·浪漫",
    AwakerResource = "SpChar_RomanticMarionette_NF"
  },
  [2268] = {
    ID = 2268,
    CnID = "木偶·善良",
    BaseSortID = 1168,
    RoleName = "AvgRole_2268_RoleName|木偶·善良",
    AwakerResource = "SpChar_LemuriaOldManMarionette_NF"
  },
  [2269] = {
    ID = 2269,
    CnID = "木偶·蛇女巫",
    BaseSortID = 1169,
    RoleName = "AvgRole_2269_RoleName|木偶·蝴蝶女巫",
    AwakerResource = "SpChar_ButterflyFemaleMarionette_NF"
  },
  [2270] = {
    ID = 2270,
    CnID = "木偶·狐狸女巫",
    BaseSortID = 1170,
    RoleName = "AvgRole_2270_RoleName|木偶·狐狸女巫",
    AwakerResource = "SpChar_FoxManMarionette_NF"
  },
  [2271] = {
    ID = 2271,
    CnID = "木偶·异形女巫",
    BaseSortID = 1171,
    RoleName = "AvgRole_2271_RoleName|木偶·异形女巫",
    AwakerResource = "SpChar_AllenMonsterMarionette_NF"
  },
  [2272] = {
    ID = 2272,
    CnID = "阿拉克涅？",
    BaseSortID = 1172,
    RoleName = "AvgRole_2272_RoleName|？？？",
    AwakerResource = "D10_NF"
  },
  [2274] = {
    ID = 2274,
    CnID = "舞台旁白",
    BaseSortID = 1173,
    RoleName = "AvgRole_2274_RoleName|舞台旁白"
  },
  [2275] = {
    ID = 2275,
    CnID = "木偶·涅芙蕾亚？",
    BaseSortID = 1174,
    RoleName = "AvgRole_2275_RoleName|？？？",
    AwakerResource = "SpChar_D10S01_Marionette_NF"
  },
  [2276] = {
    ID = 2276,
    CnID = "木偶·渊狱侍从",
    BaseSortID = 1175,
    RoleName = "AvgRole_2276_RoleName|木偶·渊狱侍从",
    AwakerResource = "SpChar_AbyssalprisonMaidensMarionette_NF"
  },
  [2277] = {
    ID = 2277,
    CnID = "木偶·涅芙蕾亚",
    BaseSortID = 1176,
    RoleName = "AvgRole_2277_RoleName|木偶·涅芙蕾亚",
    AwakerResource = "SpChar_D10S01_Marionette_NF"
  },
  [2278] = {
    ID = 2278,
    CnID = "咖啡馆侍者",
    BaseSortID = 1177,
    RoleName = "AvgRole_2278_RoleName|咖啡馆侍者",
    AwakerResource = "SpChar_Researcher_NF"
  },
  [2279] = {
    ID = 2279,
    CnID = "卡萨利姆警长",
    BaseSortID = 1178,
    RoleName = "AvgRole_2279_RoleName|卡萨利姆警长",
    AwakerResource = "SpChar_Detective_NF"
  },
  [2280] = {
    ID = 2280,
    CnID = "卡萨利姆市民",
    BaseSortID = 1179,
    RoleName = "AvgRole_2280_RoleName|卡萨利姆市民",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [2281] = {
    ID = 2281,
    CnID = "卡萨利姆警员",
    BaseSortID = 1180,
    RoleName = "AvgRole_2281_RoleName|卡萨利姆警员",
    AwakerResource = "SpChar_MTCAgent_NF"
  },
  [2282] = {
    ID = 2282,
    CnID = "贪婪的卡萨利姆市民",
    BaseSortID = 1181,
    RoleName = "AvgRole_2282_RoleName|贪婪的卡萨利姆市民",
    AwakerResource = "SpChar_Male_NF"
  },
  [2283] = {
    ID = 2283,
    CnID = "愤怒的卡萨利姆市民",
    BaseSortID = 1182,
    RoleName = "AvgRole_2283_RoleName|愤怒的卡萨利姆市民",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [2284] = {
    ID = 2284,
    CnID = "胆小的卡萨利姆市民",
    BaseSortID = 1183,
    RoleName = "AvgRole_2284_RoleName|胆小的卡萨利姆市民",
    AwakerResource = "SpChar_Sculptor_NF"
  },
  [2285] = {
    ID = 2285,
    CnID = "皇储的警卫",
    BaseSortID = 1184,
    RoleName = "AvgRole_2285_RoleName|皇储的警卫",
    AwakerResource = "SpChar_MTCAgent_NF"
  },
  [2286] = {
    ID = 2286,
    CnID = "「浪漫」",
    BaseSortID = 1185,
    RoleName = "AvgRole_2286_RoleName|「浪漫」",
    AwakerResource = "SpChar_Romantic_NF"
  },
  [2287] = {
    ID = 2287,
    CnID = "涅芙蕾亚",
    BaseSortID = 1186,
    RoleName = "AvgRole_2287_RoleName|涅芙蕾亚",
    AwakerResource = "D10S01_NF"
  },
  [2288] = {
    ID = 2288,
    CnID = "礼貌的商人",
    BaseSortID = 1187,
    RoleName = "AvgRole_2288_RoleName|礼貌的商人",
    AwakerResource = "SpChar_AllenNormal_NF"
  },
  [2289] = {
    ID = 2289,
    CnID = "傲慢的贵族",
    BaseSortID = 1188,
    RoleName = "AvgRole_2289_RoleName|傲慢的贵族",
    AwakerResource = "SpChar_Male_NF"
  },
  [2290] = {
    ID = 2290,
    CnID = "温和的贵族",
    BaseSortID = 1189,
    RoleName = "AvgRole_2290_RoleName|温和的贵族",
    AwakerResource = "SpChar_Lambert_NF"
  },
  [2291] = {
    ID = 2291,
    CnID = "兴奋的记者",
    BaseSortID = 1190,
    RoleName = "AvgRole_2291_RoleName|兴奋的记者",
    AwakerResource = "SpChar_Researcher2_NF"
  },
  [2292] = {
    ID = 2292,
    CnID = "热情的青年",
    BaseSortID = 1191,
    RoleName = "AvgRole_2292_RoleName|热情的青年",
    AwakerResource = "SpChar_Sculptor_NF"
  },
  [2293] = {
    ID = 2293,
    CnID = "期待的市民",
    BaseSortID = 1192,
    RoleName = "AvgRole_2293_RoleName|期待的市民",
    AwakerResource = "SpChar_Detective_NF"
  },
  [2294] = {
    ID = 2294,
    CnID = "贪便宜的市民",
    BaseSortID = 1193,
    RoleName = "AvgRole_2294_RoleName|贪便宜的市民",
    AwakerResource = "SpChar_Maid_NF"
  },
  [2295] = {
    ID = 2295,
    CnID = "落魄的市民",
    BaseSortID = 1194,
    RoleName = "AvgRole_2295_RoleName|落魄的市民",
    AwakerResource = "SpChar_Drunkard_NF"
  },
  [2296] = {
    ID = 2296,
    CnID = "报幕人",
    BaseSortID = 1195,
    RoleName = "AvgRole_2296_RoleName|报幕人"
  },
  [2297] = {
    ID = 2297,
    CnID = "报幕人（涅芙蕾亚）",
    BaseSortID = 1196,
    RoleName = "AvgRole_2297_RoleName|报幕人",
    AwakerResource = "D10S01_NF"
  },
  [2298] = {
    ID = 2298,
    CnID = "「善良」",
    BaseSortID = 1197,
    RoleName = "AvgRole_2298_RoleName|「善良」",
    AwakerResource = "SpChar_LemuriaOldMan_NF"
  },
  [2299] = {
    ID = 2299,
    CnID = "「回忆」",
    BaseSortID = 1198,
    RoleName = "AvgRole_2299_RoleName|「回忆」",
    AwakerResource = "SpChar_Girl_NF"
  },
  [2300] = {
    ID = 2300,
    CnID = "检票员",
    BaseSortID = 1199,
    RoleName = "AvgRole_2300_RoleName|检票员",
    AwakerResource = "SpChar_Researcher_NF"
  },
  [2301] = {
    ID = 2301,
    CnID = "不悦的乘客",
    BaseSortID = 1200,
    RoleName = "AvgRole_2301_RoleName|不悦的乘客",
    AwakerResource = "SpChar_Iglen_Shadow_NF"
  },
  [2302] = {
    ID = 2302,
    CnID = "紧张的乘客",
    BaseSortID = 1201,
    RoleName = "AvgRole_2302_RoleName|紧张的乘客",
    AwakerResource = "SpChar_FemaleNurse_NF"
  },
  [2303] = {
    ID = 2303,
    CnID = "疑惑的乘客",
    BaseSortID = 1202,
    RoleName = "AvgRole_2303_RoleName|疑惑的乘客",
    AwakerResource = "SpChar_Sculptor_NF"
  },
  [2304] = {
    ID = 2304,
    CnID = "礼貌的乘客",
    BaseSortID = 1203,
    RoleName = "AvgRole_2304_RoleName|礼貌的乘客",
    AwakerResource = "SpChar_AllenNormal_NF"
  },
  [2305] = {
    ID = 2305,
    CnID = "兴奋的乘客",
    BaseSortID = 1204,
    RoleName = "AvgRole_2305_RoleName|兴奋的乘客",
    AwakerResource = "SpChar_Drunkard_NF"
  },
  [2306] = {
    ID = 2306,
    CnID = "渊狱侍从",
    BaseSortID = 1205,
    RoleName = "AvgRole_2306_RoleName|渊狱侍从",
    AwakerResource = "SpChar_AbyssalprisonMaidens_NF"
  },
  [2307] = {
    ID = 2307,
    CnID = "木偶·阿拉克涅",
    BaseSortID = 1206,
    RoleName = "AvgRole_2307_RoleName|木偶·阿拉克涅",
    AwakerResource = "SpChar_D10_Marionette_NF"
  },
  [2308] = {
    ID = 2308,
    CnID = "木偶·冷蛛侍女",
    BaseSortID = 1207,
    RoleName = "AvgRole_2308_RoleName|木偶·冷蛛侍女",
    AwakerResource = "SpChar_LengSpiderMaidensMarionette_NF"
  },
  [2310] = {
    ID = 2310,
    CnID = "木偶·愤怒的艺术家",
    BaseSortID = 1208,
    RoleName = "AvgRole_2310_RoleName|木偶·愤怒的艺术家",
    AwakerResource = "SpChar_TheWaxMarionette_NF"
  },
  [2311] = {
    ID = 2311,
    CnID = "木偶·悲伤的将军",
    BaseSortID = 1209,
    RoleName = "AvgRole_2311_RoleName|木偶·悲伤的将军",
    AwakerResource = "SpChar_BertrandMarionette_NF"
  },
  [2312] = {
    ID = 2312,
    CnID = "塔薇的幻影",
    BaseSortID = 1210,
    RoleName = "AvgRole_2312_RoleName|塔薇的幻影",
    AwakerResource = "C15_NF"
  },
  [2313] = {
    ID = 2313,
    CnID = "泰旖丝的幻影",
    BaseSortID = 1211,
    RoleName = "AvgRole_2313_RoleName|泰旖丝的幻影",
    AwakerResource = "B01_NF"
  },
  [2314] = {
    ID = 2314,
    CnID = "N的幻影",
    BaseSortID = 1212,
    RoleName = "AvgRole_2314_RoleName|「N」的幻影",
    AwakerResource = "SpChar_N_NF"
  },
  [2315] = {
    ID = 2315,
    CnID = "「使徒」",
    BaseSortID = 1213,
    RoleName = "AvgRole_2315_RoleName|「使徒」",
    AwakerResource = "SpChar_StudentDis_NF"
  },
  [2316] = {
    ID = 2316,
    CnID = "歌剧家",
    BaseSortID = 1214,
    RoleName = "AvgRole_2316_RoleName|歌剧家"
  },
  [2317] = {
    ID = 2317,
    CnID = "被抛弃的命运",
    BaseSortID = 1215,
    RoleName = "AvgRole_2317_RoleName|被抛弃的命运"
  },
  [2318] = {
    ID = 2318,
    CnID = "冷蛛侍女",
    BaseSortID = 1216,
    RoleName = "AvgRole_2318_RoleName|冷蛛侍女",
    AwakerResource = "SpChar_LengSpiderMaidens_NF"
  },
  [2319] = {
    ID = 2319,
    CnID = "阿拉克涅NF",
    BaseSortID = 1217,
    RoleName = "AvgRole_2319_RoleName|阿拉克涅",
    AwakerResource = "D10_NF"
  },
  [2320] = {
    ID = 2320,
    CnID = "刻薄的青年2",
    BaseSortID = 1218,
    RoleName = "AvgRole_2320_RoleName|刻薄的青年",
    AwakerResource = "SpChar_Male_NF"
  },
  [2321] = {
    ID = 2321,
    CnID = "刻薄的青年3",
    BaseSortID = 1219,
    RoleName = "AvgRole_2321_RoleName|刻薄的青年",
    AwakerResource = "SpChar_Male_NF"
  },
  [2322] = {
    ID = 2322,
    CnID = "爽朗的女性_阿拉克涅剧情2",
    BaseSortID = 1220,
    RoleName = "AvgRole_2322_RoleName|爽朗的女性",
    AwakerResource = "SpChar_Female_NF"
  },
  [2323] = {
    ID = 2323,
    CnID = "「浪漫」分身",
    BaseSortID = 1221,
    RoleName = "AvgRole_2323_RoleName|「浪漫」",
    AwakerResource = "SpChar_Romantic_NF"
  },
  [2324] = {
    ID = 2324,
    CnID = "渊狱侍从分身",
    BaseSortID = 1222,
    RoleName = "AvgRole_2324_RoleName|渊狱侍从",
    AwakerResource = "SpChar_AbyssalprisonMaidens_NF"
  },
  [2325] = {
    ID = 2325,
    CnID = "冷蛛侍女分身",
    BaseSortID = 1223,
    RoleName = "AvgRole_2325_RoleName|冷蛛侍女",
    AwakerResource = "SpChar_LengSpiderMaidens_NF"
  },
  [2326] = {
    ID = 2326,
    CnID = "「使徒」分身",
    BaseSortID = 1224,
    RoleName = "AvgRole_2326_RoleName|「使徒」",
    AwakerResource = "SpChar_StudentDis_NF"
  },
  [2327] = {
    ID = 2327,
    CnID = "「使徒」分身2",
    BaseSortID = 1225,
    RoleName = "AvgRole_2327_RoleName|「使徒」",
    AwakerResource = "SpChar_StudentDis_NF"
  },
  [2328] = {
    ID = 2328,
    CnID = "提词人",
    BaseSortID = 1226,
    RoleName = "AvgRole_2328_RoleName|提词人"
  },
  [2329] = {
    ID = 2329,
    CnID = "涅芙蕾亚？",
    BaseSortID = 1227,
    RoleName = "AvgRole_2329_RoleName|？？？",
    AwakerResource = "D10S01_NF"
  },
  [2340] = {
    ID = 2340,
    CnID = "警卫阿拉克涅剧情",
    BaseSortID = 1228,
    RoleName = "AvgRole_2340_RoleName|警卫",
    AwakerResource = "SpChar_Detective_NF"
  },
  [2341] = {
    ID = 2341,
    CnID = "木偶·醉酒的中年",
    BaseSortID = 1229,
    RoleName = "AvgRole_2341_RoleName|落魄的中年",
    AwakerResource = "SpChar_BertrandMarionette_NF"
  },
  [2342] = {
    ID = 2342,
    CnID = "木偶·爽朗的女性_阿拉克涅剧情",
    BaseSortID = 1230,
    RoleName = "AvgRole_2342_RoleName|爽朗的女性",
    AwakerResource = "SpChar_LengSpiderMaidensMarionette_NF"
  },
  [2343] = {
    ID = 2343,
    CnID = "木偶·浪漫的调酒师",
    BaseSortID = 1231,
    RoleName = "AvgRole_2343_RoleName|调酒师",
    AwakerResource = "SpChar_RomanticMarionette_NF"
  },
  [2344] = {
    ID = 2344,
    CnID = "木偶·冷漠的侍者",
    BaseSortID = 1232,
    RoleName = "AvgRole_2344_RoleName|冷漠的侍者",
    AwakerResource = "SpChar_TheWaxMarionette_NF"
  },
  [2345] = {
    ID = 2345,
    CnID = "阿拉克涅特制NF",
    BaseSortID = 1233,
    RoleName = "AvgRole_2345_RoleName|？？？",
    AwakerResource = "SpChar_Arachne_NF"
  },
  [2346] = {
    ID = 2346,
    CnID = "沙耶",
    BaseSortID = 1234,
    RoleName = "AvgRole_2346_RoleName|沙耶",
    AwakerResource = "B15_NF"
  },
  [2347] = {
    ID = 2347,
    CnID = "沙耶之声",
    BaseSortID = 1235,
    RoleName = "AvgRole_2347_RoleName|沙耶之声",
    AwakerResource = "B15_NF",
    HeadIcon = "Portrait_Minihead_SpChar_B15Head_AF"
  },
  [2348] = {
    ID = 2348,
    CnID = "不知名沙耶",
    BaseSortID = 1236,
    RoleName = "AvgRole_2348_RoleName|？？？",
    AwakerResource = "B15_NF"
  },
  [2349] = {
    ID = 2349,
    CnID = "脑内的声音",
    BaseSortID = 1237,
    RoleName = "AvgRole_2349_RoleName|脑内的声音",
    AwakerResource = "SpChar_Lily_NF"
  },
  [2350] = {
    ID = 2350,
    CnID = "年轻的庞托斯",
    BaseSortID = 1238,
    RoleName = "AvgRole_2350_RoleName|庞托斯",
    AwakerResource = "SpChar_Pontos_NF"
  },
  [2351] = {
    ID = 2351,
    CnID = "庞托斯",
    BaseSortID = 1239,
    RoleName = "AvgRole_2351_RoleName|庞托斯",
    AwakerResource = "O13_AF",
    Sign = "AvgRole_2351_Sign|除%player%绿色通道外，暂不受理厄波扬斯移民申请。"
  },
  [2352] = {
    ID = 2352,
    CnID = "蕾莎",
    BaseSortID = 1240,
    RoleName = "AvgRole_2352_RoleName|蕾莎",
    AwakerResource = "SpChar_Lessa_NF"
  },
  [2353] = {
    ID = 2353,
    CnID = "？？？（夜魇）",
    BaseSortID = 1241,
    RoleName = "AvgRole_2353_RoleName|？？？",
    AwakerResource = "SpChar_AllenMonster_NF"
  },
  [2354] = {
    ID = 2354,
    CnID = "狂信者维恩",
    BaseSortID = 1242,
    RoleName = "AvgRole_2354_RoleName|狂信者维恩",
    AwakerResource = "SpChar_AllenMonster_NF"
  },
  [2355] = {
    ID = 2355,
    CnID = "狂信者以托玛",
    BaseSortID = 1243,
    RoleName = "AvgRole_2355_RoleName|狂信者以托玛",
    AwakerResource = "SpChar_AllenMonster_NF"
  },
  [2356] = {
    ID = 2356,
    CnID = "狂信者莱伊",
    BaseSortID = 1244,
    RoleName = "AvgRole_2356_RoleName|狂信者莱伊",
    AwakerResource = "SpChar_AllenMonster_NF"
  },
  [2357] = {
    ID = 2357,
    CnID = "狂信者本",
    BaseSortID = 1245,
    RoleName = "AvgRole_2357_RoleName|狂信者本",
    AwakerResource = "SpChar_Iglen_NF"
  },
  [2358] = {
    ID = 2358,
    CnID = "薇拉",
    BaseSortID = 1246,
    RoleName = "AvgRole_2358_RoleName|薇拉",
    AwakerResource = "SpChar_Girl_NF"
  },
  [2359] = {
    ID = 2359,
    CnID = "奥尔尼",
    BaseSortID = 1247,
    RoleName = "AvgRole_2359_RoleName|奥尔尼",
    AwakerResource = "SpChar_Boy_NF"
  },
  [2360] = {
    ID = 2360,
    CnID = "老年奥尔尼",
    BaseSortID = 1248,
    RoleName = "AvgRole_2360_RoleName|奥尔尼",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [2361] = {
    ID = 2361,
    CnID = "？？？（年轻的庞托斯）",
    BaseSortID = 1249,
    RoleName = "AvgRole_2361_RoleName|？？？",
    AwakerResource = "SpChar_Pontos_NF"
  },
  [2362] = {
    ID = 2362,
    CnID = "？？？（蕾莎）",
    BaseSortID = 1250,
    RoleName = "AvgRole_2362_RoleName|？？？",
    AwakerResource = "SpChar_Lessa_NF"
  },
  [2363] = {
    ID = 2363,
    CnID = "怀特叔叔",
    BaseSortID = 1251,
    RoleName = "AvgRole_2363_RoleName|怀特叔叔",
    AwakerResource = "SpChar_Male_NF"
  },
  [2364] = {
    ID = 2364,
    CnID = "狂信者@1",
    BaseSortID = 1252,
    RoleName = "AvgRole_2364_RoleName|狂信者@1",
    AwakerResource = "SpChar_Iglen_NF"
  },
  [2365] = {
    ID = 2365,
    CnID = "？？？（老年奥尔尼）",
    BaseSortID = 1253,
    RoleName = "AvgRole_2365_RoleName|？？？",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [2366] = {
    ID = 2366,
    CnID = "诺@2",
    BaseSortID = 1254,
    RoleName = "AvgRole_2366_RoleName|诺@2",
    AwakerResource = "O13_AF"
  },
  [2367] = {
    ID = 2367,
    CnID = "古老的@3",
    BaseSortID = 1255,
    RoleName = "AvgRole_2367_RoleName|古老的@3",
    AwakerResource = "SpChar_Pontos_NF"
  },
  [2368] = {
    ID = 2368,
    CnID = "艾继丝-无称号",
    BaseSortID = 1256,
    RoleName = "AvgRole_2368_RoleName|艾继丝",
    AwakerResource = "B03_HF",
    Sign = "AvgRole_2368_Sign|那个，艾继丝有帮到大家吗？"
  },
  [2369] = {
    ID = 2369,
    CnID = "沙耶NF",
    BaseSortID = 1257,
    RoleName = "AvgRole_2369_RoleName|沙耶",
    AwakerResource = "B15_NF"
  },
  [2370] = {
    ID = 2370,
    CnID = "急切的男人",
    BaseSortID = 1258,
    RoleName = "AvgRole_2370_RoleName|急切的男人",
    AwakerResource = "SpChar_Male_NF"
  },
  [2371] = {
    ID = 2371,
    CnID = "急切的女人",
    BaseSortID = 1259,
    RoleName = "AvgRole_2371_RoleName|急切的女人",
    AwakerResource = "SpChar_Female_NF"
  },
  [2372] = {
    ID = 2372,
    CnID = "狂信者们",
    BaseSortID = 1260,
    RoleName = "AvgRole_2372_RoleName|狂信者们",
    AwakerResource = "SpChar_Iglen_NF"
  },
  [2373] = {
    ID = 2373,
    CnID = "不知名狂信者",
    BaseSortID = 1261,
    RoleName = "AvgRole_2373_RoleName|不知名狂信者",
    AwakerResource = "SpChar_AllenMonster_NF"
  },
  [2374] = {
    ID = 2374,
    CnID = "厄波扬斯的人们",
    BaseSortID = 1262,
    RoleName = "AvgRole_2374_RoleName|厄波扬斯的人们",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [2375] = {
    ID = 2375,
    CnID = "沙耶AF",
    BaseSortID = 1263,
    RoleName = "AvgRole_2375_RoleName|沙耶",
    AwakerResource = "B15_AF",
    Sign = "AvgRole_2375_Sign|可以喜欢蒲公英吗？"
  },
  [2376] = {
    ID = 2376,
    CnID = "沙耶之声头像",
    BaseSortID = 1264,
    RoleName = "AvgRole_2376_RoleName|沙耶之声",
    HeadIcon = "Portrait_Minihead_SpChar_B15Head_AF"
  },
  [2377] = {
    ID = 2377,
    CnID = "乔",
    BaseSortID = 1265,
    RoleName = "AvgRole_2377_RoleName|乔",
    AwakerResource = "SpChar_Researcher2_NF"
  },
  [2378] = {
    ID = 2378,
    CnID = "瓦罗",
    BaseSortID = 1266,
    RoleName = "AvgRole_2378_RoleName|瓦罗",
    AwakerResource = "SpChar_Gladiator_NF"
  },
  [2379] = {
    ID = 2379,
    CnID = "强装镇定的战士",
    BaseSortID = 1267,
    RoleName = "AvgRole_2379_RoleName|强装镇定的战士",
    AwakerResource = "SpChar_Knight_NF"
  },
  [2380] = {
    ID = 2380,
    CnID = "狡猾的战士",
    BaseSortID = 1268,
    RoleName = "AvgRole_2380_RoleName|狡猾的战士",
    AwakerResource = "SpChar_Knight_NF"
  },
  [2381] = {
    ID = 2381,
    CnID = "愤怒的战士",
    BaseSortID = 1269,
    RoleName = "AvgRole_2381_RoleName|愤怒的战士",
    AwakerResource = "SpChar_Knight_NF"
  },
  [2382] = {
    ID = 2382,
    CnID = "坚定的战士",
    BaseSortID = 1270,
    RoleName = "AvgRole_2382_RoleName|坚定的战士",
    AwakerResource = "SpChar_Knight_NF"
  },
  [2383] = {
    ID = 2383,
    CnID = "星天之鲸的幻影？",
    BaseSortID = 1271,
    RoleName = "AvgRole_2383_RoleName|幻影",
    AwakerResource = "SpChar_LemuriaOldMan_NF"
  },
  [2384] = {
    ID = 2384,
    CnID = "埃利安？",
    BaseSortID = 1272,
    RoleName = "AvgRole_2384_RoleName|？？？",
    AwakerResource = "SpChar_Aelius_NF"
  },
  [2385] = {
    ID = 2385,
    CnID = "埃利安",
    BaseSortID = 1273,
    RoleName = "AvgRole_2385_RoleName|埃利安",
    Tittle = "AvgRole_2385_Tittle|宰相",
    AwakerResource = "SpChar_Aelius_NF"
  },
  [2386] = {
    ID = 2386,
    CnID = "参赛者",
    BaseSortID = 1274,
    RoleName = "AvgRole_2386_RoleName|参赛者",
    AwakerResource = "SpChar_LemuriaMan_NF"
  },
  [2387] = {
    ID = 2387,
    CnID = "阿利什？",
    BaseSortID = 1275,
    RoleName = "AvgRole_2387_RoleName|？？？",
    AwakerResource = "SpChar_LemuriaEnos_NF"
  },
  [2388] = {
    ID = 2388,
    CnID = "阿利什",
    BaseSortID = 1276,
    RoleName = "AvgRole_2388_RoleName|阿利什",
    Tittle = "AvgRole_2388_Tittle|将军",
    AwakerResource = "SpChar_LemuriaEnos_NF"
  },
  [2389] = {
    ID = 2389,
    CnID = "桑吉",
    BaseSortID = 1277,
    RoleName = "AvgRole_2389_RoleName|桑吉",
    Tittle = "AvgRole_2389_Tittle|毒士",
    AwakerResource = "SpChar_LemuriaWoman_NF"
  },
  [2390] = {
    ID = 2390,
    CnID = "星天之鲸的幻影",
    BaseSortID = 1278,
    RoleName = "AvgRole_2390_RoleName|星天之鲸的幻影",
    AwakerResource = "SpChar_Whale_NF"
  },
  [2391] = {
    ID = 2391,
    CnID = "蚀灭·萝坦",
    BaseSortID = 1279,
    RoleName = "AvgRole_2391_RoleName|萝坦",
    AwakerResource = "C04EX_NF",
    Sign = "AvgRole_2391_Sign|你知道自己很弱吗？"
  },
  [2392] = {
    ID = 2392,
    CnID = "星天之鲸的幻影A",
    BaseSortID = 1280,
    RoleName = "AvgRole_2392_RoleName|幻影",
    AwakerResource = "SpChar_LemuriaOldMan_NF"
  },
  [2393] = {
    ID = 2393,
    CnID = "星天之鲸的幻影B",
    BaseSortID = 1281,
    RoleName = "AvgRole_2393_RoleName|幻影",
    AwakerResource = "SpChar_LemuriaOldMan_NF"
  },
  [2394] = {
    ID = 2394,
    CnID = "星天之鲸的幻影C",
    BaseSortID = 1282,
    RoleName = "AvgRole_2394_RoleName|幻影",
    AwakerResource = "SpChar_LemuriaOldMan_NF"
  },
  [2395] = {
    ID = 2395,
    CnID = "星天之鲸的幻影D",
    BaseSortID = 1283,
    RoleName = "AvgRole_2395_RoleName|幻影",
    AwakerResource = "SpChar_LemuriaOldMan_NF"
  },
  [2396] = {
    ID = 2396,
    CnID = "表演用庞托斯",
    BaseSortID = 1284,
    RoleName = "AvgRole_2396_RoleName|庞托斯",
    AwakerResource = "O13_NF"
  },
  [2397] = {
    ID = 2397,
    CnID = "蚀灭·萝坦（人类）",
    BaseSortID = 1285,
    RoleName = "AvgRole_2397_RoleName|萝坦",
    AwakerResource = "C04EX_HF"
  },
  [2398] = {
    ID = 2398,
    CnID = "穿着邋遢西装的男人",
    BaseSortID = 1286,
    RoleName = "AvgRole_2398_RoleName|穿着邋遢西装的男人",
    AwakerResource = "SpChar_Male_NF"
  },
  [2399] = {
    ID = 2399,
    CnID = "尖酸的牧民",
    BaseSortID = 1287,
    RoleName = "AvgRole_2399_RoleName|尖酸的牧民",
    AwakerResource = "SpChar_SailorNorman_NF"
  },
  [2400] = {
    ID = 2400,
    CnID = "远方而来的歌声",
    BaseSortID = 1288,
    RoleName = "AvgRole_2400_RoleName|远方而来的歌声"
  },
  [2401] = {
    ID = 2401,
    CnID = "逐渐清晰的歌声",
    BaseSortID = 1289,
    RoleName = "AvgRole_2401_RoleName|逐渐清晰的歌声"
  },
  [2402] = {
    ID = 2402,
    CnID = "纳拉卡",
    BaseSortID = 1290,
    RoleName = "AvgRole_2402_RoleName|纳拉卡",
    AwakerResource = "SpChar_SnowGuide_NF"
  },
  [2403] = {
    ID = 2403,
    CnID = "遥远的呼唤",
    BaseSortID = 1291,
    RoleName = "AvgRole_2403_RoleName|遥远的呼唤"
  },
  [2404] = {
    ID = 2404,
    CnID = "风中的呼唤",
    BaseSortID = 1292,
    RoleName = "AvgRole_2404_RoleName|风中的呼唤"
  },
  [2405] = {
    ID = 2405,
    CnID = "于丽埃特的声音",
    BaseSortID = 1293,
    RoleName = "AvgRole_2405_RoleName|于丽埃特的声音",
    AwakerResource = "SpChar_Julliette_NF"
  },
  [2406] = {
    ID = 2406,
    CnID = "山之蠕虫",
    BaseSortID = 1294,
    RoleName = "AvgRole_2406_RoleName|山之蠕虫"
  },
  [2407] = {
    ID = 2407,
    CnID = "苹果蠕虫",
    BaseSortID = 1295,
    RoleName = "AvgRole_2407_RoleName|苹果上的蠕虫",
    HeadIcon = "Icon_StoryBig_053"
  },
  [2408] = {
    ID = 2408,
    CnID = "罗莎姨妈",
    BaseSortID = 1296,
    RoleName = "AvgRole_2408_RoleName|罗莎姨妈",
    AwakerResource = "SpChar_Lessa_NF"
  },
  [2409] = {
    ID = 2409,
    CnID = "卡拉布幼年版",
    BaseSortID = 1297,
    RoleName = "AvgRole_2409_RoleName|卡拉布",
    AwakerResource = "B11_AF"
  },
  [2410] = {
    ID = 2410,
    CnID = "亨利",
    BaseSortID = 1298,
    RoleName = "AvgRole_2410_RoleName|亨利",
    AwakerResource = "SpChar_Boy_NF"
  },
  [2411] = {
    ID = 2411,
    CnID = "芬戈尔",
    BaseSortID = 1299,
    RoleName = "AvgRole_2411_RoleName|芬戈尔"
  },
  [2412] = {
    ID = 2412,
    CnID = "影子",
    BaseSortID = 1300,
    RoleName = "AvgRole_2412_RoleName|影子",
    AwakerResource = "B11_AF"
  },
  [2413] = {
    ID = 2413,
    CnID = "「影子」",
    BaseSortID = 1301,
    RoleName = "AvgRole_2413_RoleName|「影子」",
    AwakerResource = "B11_AF"
  },
  [2414] = {
    ID = 2414,
    CnID = "伊芙琳",
    BaseSortID = 1302,
    RoleName = "AvgRole_2414_RoleName|伊芙琳",
    AwakerResource = "SpChar_SnowWoman_NF"
  },
  [2415] = {
    ID = 2415,
    CnID = "阿拉克涅之影",
    BaseSortID = 1303,
    RoleName = "AvgRole_2415_RoleName|阿拉克涅之影",
    AwakerResource = "D10_NF"
  },
  [2416] = {
    ID = 2416,
    CnID = "吆喝声",
    BaseSortID = 1304,
    RoleName = "AvgRole_2416_RoleName|吆喝声"
  },
  [2417] = {
    ID = 2417,
    CnID = "向导模样的男人",
    BaseSortID = 1305,
    RoleName = "AvgRole_2417_RoleName|向导模样的男人",
    AwakerResource = "SpChar_SnowGuide_NF"
  },
  [2418] = {
    ID = 2418,
    CnID = "湖底的声音",
    BaseSortID = 1306,
    RoleName = "AvgRole_2418_RoleName|湖底的声音"
  },
  [2419] = {
    ID = 2419,
    CnID = "卡斯托尔斗篷版",
    BaseSortID = 1307,
    RoleName = "AvgRole_2419_RoleName|卡斯托尔",
    AwakerResource = "D11_HF"
  },
  [2420] = {
    ID = 2420,
    CnID = "负誓奥吉尔（人类）",
    BaseSortID = 1308,
    RoleName = "AvgRole_2420_RoleName|奥吉尔",
    AwakerResource = "O04_AF"
  },
  [2421] = {
    ID = 2421,
    CnID = "负誓奥吉尔？",
    BaseSortID = 1309,
    RoleName = "AvgRole_2421_RoleName|？？？",
    AwakerResource = "O04_HF"
  },
  [2422] = {
    ID = 2422,
    CnID = "伪善的牧师",
    BaseSortID = 1310,
    RoleName = "AvgRole_2422_RoleName|伪善的牧师",
    AwakerResource = "SpChar_White_NF"
  },
  [2423] = {
    ID = 2423,
    CnID = "愚昧的村民1",
    BaseSortID = 1311,
    RoleName = "AvgRole_2423_RoleName|愚昧的村民",
    AwakerResource = "SpChar_Drunkard_NF"
  },
  [2424] = {
    ID = 2424,
    CnID = "愚昧的村民2",
    BaseSortID = 1312,
    RoleName = "AvgRole_2424_RoleName|愚昧的村民",
    AwakerResource = "SpChar_LisaMon_NF"
  },
  [2425] = {
    ID = 2425,
    CnID = "善良的修女",
    BaseSortID = 1313,
    RoleName = "AvgRole_2425_RoleName|善良的修女",
    AwakerResource = "SpChar_FemaleNurse_NF"
  },
  [2426] = {
    ID = 2426,
    CnID = "疯癫的庄园主",
    BaseSortID = 1314,
    RoleName = "AvgRole_2426_RoleName|疯癫的庄园主",
    AwakerResource = "SpChar_UndeadServant1_NF"
  },
  [2427] = {
    ID = 2427,
    CnID = "巡逻的卫兵",
    BaseSortID = 1315,
    RoleName = "AvgRole_2427_RoleName|巡逻的卫兵",
    AwakerResource = "SpChar_Knight_NF"
  },
  [2428] = {
    ID = 2428,
    CnID = "墓园的司事",
    BaseSortID = 1316,
    RoleName = "AvgRole_2428_RoleName|墓园的司事",
    AwakerResource = "SpChar_LemuriaOldMan_NF"
  },
  [2429] = {
    ID = 2429,
    CnID = "濒死的卫兵",
    BaseSortID = 1317,
    RoleName = "AvgRole_2429_RoleName|濒死的卫兵",
    AwakerResource = "SpChar_Knight_NF"
  },
  [2430] = {
    ID = 2430,
    CnID = "重病的领主",
    BaseSortID = 1318,
    RoleName = "AvgRole_2430_RoleName|重病的领主",
    AwakerResource = "SpChar_AlistairDark_NF"
  },
  [2431] = {
    ID = 2431,
    CnID = "淳朴的少女",
    BaseSortID = 1319,
    RoleName = "AvgRole_2431_RoleName|淳朴的少女",
    AwakerResource = "SpChar_Lisa_Shadow_NF"
  },
  [2432] = {
    ID = 2432,
    CnID = "寡言的外科理发师",
    BaseSortID = 1320,
    RoleName = "AvgRole_2432_RoleName|寡言的外科理发师",
    AwakerResource = "SpChar_SculptorNorm_NF"
  },
  [2433] = {
    ID = 2433,
    CnID = "慌张的村民",
    BaseSortID = 1321,
    RoleName = "AvgRole_2433_RoleName|慌张的村民",
    AwakerResource = "SpChar_SnowGuide_NF"
  },
  [2434] = {
    ID = 2434,
    CnID = "惊恐的村民",
    BaseSortID = 1322,
    RoleName = "AvgRole_2434_RoleName|惊恐的村民",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [2435] = {
    ID = 2435,
    CnID = "负誓·奥吉尔",
    BaseSortID = 1323,
    RoleName = "AvgRole_2435_RoleName|负誓·奥吉尔",
    AwakerResource = "C03EX_NF",
    HeadIcon = "如有任务安排，请直接联络。"
  },
  [2436] = {
    ID = 2436,
    CnID = "愚昧的村民3",
    BaseSortID = 1324,
    RoleName = "AvgRole_2436_RoleName|愚昧的村民",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [2437] = {
    ID = 2437,
    CnID = "惊恐的铁匠",
    BaseSortID = 1325,
    RoleName = "AvgRole_2437_RoleName|惊恐的铁匠",
    AwakerResource = "SpChar_OldMale_NF"
  },
  [2438] = {
    ID = 2438,
    CnID = "怪物1",
    BaseSortID = 1326,
    RoleName = "AvgRole_2438_RoleName|怪物",
    AwakerResource = "SpChar_BearMan_NF"
  },
  [2439] = {
    ID = 2439,
    CnID = "怪物2",
    BaseSortID = 1327,
    RoleName = "AvgRole_2439_RoleName|怪物",
    AwakerResource = "SpChar_FoxMan_NF"
  },
  [2440] = {
    ID = 2440,
    CnID = "怪物3",
    BaseSortID = 1328,
    RoleName = "AvgRole_2440_RoleName|怪物",
    AwakerResource = "SpChar_PigMale_NF"
  }
})
return AvgRole
