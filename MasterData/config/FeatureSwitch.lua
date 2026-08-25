local System = require("System.System")
local readonly = System.readonly
local FeatureSwitch = readonly({
  [81445] = {
    ID = 81445,
    CnID = "开关@主线",
    BaseSortID = 1,
    Feature = "MainCopy"
  },
  [81447] = {
    ID = 81447,
    CnID = "开关@主线困难",
    BaseSortID = 2,
    Feature = "MainCopyHard"
  },
  [81440] = {
    ID = 81440,
    CnID = "开关@抽卡",
    BaseSortID = 3,
    Feature = "DrawCard"
  },
  [81448] = {
    ID = 81448,
    CnID = "开关@商店",
    BaseSortID = 4,
    Feature = "Shop"
  },
  [81436] = {
    ID = 81436,
    CnID = "开关@炼金",
    BaseSortID = 5,
    Feature = "ItemConversion"
  },
  [81446] = {
    ID = 81446,
    CnID = "开关@邮件",
    BaseSortID = 6,
    Feature = "Mail"
  },
  [81437] = {
    ID = 81437,
    CnID = "开关@任务",
    BaseSortID = 7,
    Feature = "Task"
  },
  [81449] = {
    ID = 81449,
    CnID = "开关@风控检查",
    BaseSortID = 8,
    Feature = "RiskCheck"
  },
  [81444] = {
    ID = 81444,
    CnID = "开关@饰品洗练",
    BaseSortID = 9,
    Feature = "TrinketTrain"
  },
  [81439] = {
    ID = 81439,
    CnID = "开关@饰品强化",
    BaseSortID = 10,
    Feature = "TrinketUpgrade"
  },
  [81441] = {
    ID = 81441,
    CnID = "开关@命轮正位",
    BaseSortID = 11,
    Feature = "WeaponAdvance"
  },
  [81435] = {
    ID = 81435,
    CnID = "开关@分解",
    BaseSortID = 12,
    Feature = "Decompose"
  },
  [81442] = {
    ID = 81442,
    CnID = "开关@材料合成",
    BaseSortID = 13,
    Feature = "Compose"
  },
  [81438] = {
    ID = 81438,
    CnID = "开关@材料置换",
    BaseSortID = 14,
    Feature = "MaterialExchange"
  },
  [22364] = {
    ID = 22364,
    CnID = "运维@服务器创角",
    BaseSortID = 15,
    Feature = "CreateRole"
  },
  [81443] = {
    ID = 81443,
    CnID = "开关@回溯",
    BaseSortID = 16,
    Feature = "Backtrack"
  },
  [81450] = {
    ID = 81450,
    CnID = "开关@溶蚀深渊",
    BaseSortID = 17,
    Feature = "AbyssChallenge"
  },
  [84314] = {
    ID = 84314,
    CnID = "开关@首次五连重抽",
    BaseSortID = 18,
    Feature = "Resummon"
  },
  [84315] = {
    ID = 84315,
    CnID = "开关@时装",
    BaseSortID = 19,
    Feature = "AwakerSkin"
  },
  [95388] = {
    ID = 95388,
    CnID = "开关@命轮自动叠位分解",
    BaseSortID = 20,
    Feature = "WeaponAutoRefine",
    OnlyOpenZone = {1}
  },
  [91434] = {
    ID = 91434,
    CnID = "开关@好友邀请码",
    BaseSortID = 21,
    Feature = "SocialInviteCode"
  },
  [148486] = {
    ID = 148486,
    CnID = "开关@密契自动转录",
    BaseSortID = 22,
    Feature = "TrinketAutoRefine"
  },
  [148485] = {
    ID = 148485,
    CnID = "开关@密契绑定",
    BaseSortID = 23,
    Feature = "TrinketBind"
  }
})
return FeatureSwitch
