local System = require("System.System")
local readonly = System.readonly
local FeatureUnlock = readonly({
  [16968] = {
    ID = 16968,
    CnID = "功能@主线",
    BaseSortID = 1,
    Feature = "MainCopy",
    FeatureName = "FeatureUnlock_16968_FeatureName|主线",
    FeatureEntranceType = 1
  },
  [16967] = {
    ID = 16967,
    CnID = "功能@主线序章",
    BaseSortID = 2,
    Feature = "MainCopy",
    Key = 15935,
    FeatureName = "FeatureUnlock_16967_FeatureName|主线序章"
  },
  [17064] = {
    ID = 17064,
    CnID = "功能@主线第一章",
    BaseSortID = 3,
    Feature = "MainCopy",
    Key = 15927,
    FeatureName = "FeatureUnlock_17064_FeatureName|「调查行动」第1章",
    UnlockCondition = {1, 7998}
  },
  [16958] = {
    ID = 16958,
    CnID = "功能@主线第二章",
    BaseSortID = 4,
    Feature = "MainCopy",
    Key = 15901,
    FeatureName = "FeatureUnlock_16958_FeatureName|「调查行动」第2章",
    UnlockCondition = {1, 8030},
    UnlockDesc = "FeatureUnlock_16958_UnlockDesc|<FeatureUnlockTitle:调查行动「以蜡像之名」已开启>\n\n<FeatureUnlockDesc:循着詹金提供的线索，你们决定前往南华克街44号，寻找蜡像背后的真相……>",
    LockTip = "FeatureUnlock_16958_LockTip|完成 「调查行动」第1章·普通 后解锁"
  },
  [16959] = {
    ID = 16959,
    CnID = "功能@主线第三章",
    BaseSortID = 5,
    Feature = "MainCopy",
    Key = 15922,
    FeatureName = "FeatureUnlock_16959_FeatureName|「调查行动」第3章",
    UnlockCondition = {1, 7755},
    UnlockDesc = "FeatureUnlock_16959_UnlockDesc|<FeatureUnlockTitle:调查行动「谨防恶犬」已开启>\n\n<FeatureUnlockDesc:追溯地狱犬「刻耳柏洛斯」的流言，弥萨格的调查员们来到伦蒂尼恩远郊的小镇拉伊，探寻失踪案背后的隐秘……>",
    LockTip = "FeatureUnlock_16959_LockTip|完成 「调查行动」第2章·普通 后解锁"
  },
  [16977] = {
    ID = 16977,
    CnID = "功能@主线第四章",
    BaseSortID = 6,
    Feature = "MainCopy",
    Key = 15882,
    FeatureName = "FeatureUnlock_16977_FeatureName|「调查行动」第4章",
    UnlockCondition = {1, 8045},
    UnlockDesc = "FeatureUnlock_16977_UnlockDesc|<FeatureUnlockTitle:调查行动「于无声处」已开启>\n\n<FeatureUnlockDesc:拉伊精神疗养院不会是幸福的家。为了揭开伪装的面纱，调查员不得不深入其中……>",
    LockTip = "FeatureUnlock_16977_LockTip|完成 「调查行动」第3章·普通 后解锁"
  },
  [16979] = {
    ID = 16979,
    CnID = "功能@主线第五章",
    BaseSortID = 7,
    Feature = "MainCopy",
    Key = 15907,
    FeatureName = "FeatureUnlock_16979_FeatureName|「调查行动」第5章",
    UnlockCondition = {1, 7869},
    UnlockDesc = "FeatureUnlock_16979_UnlockDesc|<FeatureUnlockTitle:调查行动「风暴之眼」已开启>\n\n<FeatureUnlockDesc:陌生的船只，陌生的少女，陌生的敌人。飘摇于大海之中，等待着调查员们的，是一场与命运的抗争……>",
    LockTip = "FeatureUnlock_16979_LockTip|完成 「调查行动」第4章·普通 后解锁"
  },
  [16984] = {
    ID = 16984,
    CnID = "功能@主线第六章",
    BaseSortID = 8,
    Feature = "MainCopy",
    Key = 15890,
    FeatureName = "FeatureUnlock_16984_FeatureName|「调查行动」第6章",
    UnlockCondition = {1, 22313},
    UnlockDesc = "FeatureUnlock_16984_UnlockDesc|<FeatureUnlockTitle:调查行动「倒错的群星」已开启>\n\n<FeatureUnlockDesc:索纳尼尔号是移动的克里特岛，它承载着所有人飞向彼岸与自由的希望……>",
    LockTip = "FeatureUnlock_16984_LockTip|完成 「调查行动」第5章·普通 后解锁"
  },
  [48920] = {
    ID = 48920,
    CnID = "功能@主线第七章",
    BaseSortID = 9,
    Feature = "MainCopy",
    Key = 48870,
    FeatureName = "FeatureUnlock_48920_FeatureName|「调查行动」第7章",
    UnlockCondition = {1, 35857},
    UnlockDesc = "FeatureUnlock_48920_UnlockDesc|<FeatureUnlockTitle:调查行动「欲河」已开启>\n\n<FeatureUnlockDesc:勒姆瓦希北部的卡拉盖圣河，哺育着游牧民族亚兰的过往与未来……>",
    LockTip = "FeatureUnlock_48920_LockTip|完成 「调查行动」第6章·普通 后解锁"
  },
  [58907] = {
    ID = 58907,
    CnID = "功能@主线第八章",
    BaseSortID = 10,
    Feature = "MainCopy",
    Key = 58900,
    FeatureName = "FeatureUnlock_58907_FeatureName|「调查行动」第8章",
    UnlockCondition = {1, 48069},
    UnlockDesc = "FeatureUnlock_58907_UnlockDesc|<FeatureUnlockTitle:调查行动「终末交响曲」已开启>\n\n<FeatureUnlockDesc:入场。静坐。等待。渴求。\n指挥棒轻轻扬起。准备好，聆听这宇宙最深邃的隐秘了吗？>",
    LockTip = "FeatureUnlock_58907_LockTip|完成 「调查行动」第7章·普通 后解锁"
  },
  [58908] = {
    ID = 58908,
    CnID = "功能@主线第九章",
    BaseSortID = 11,
    Feature = "MainCopy",
    Key = 67786,
    FeatureName = "FeatureUnlock_58908_FeatureName|「调查行动」终章",
    UnlockCondition = {1, 62348},
    UnlockDesc = "FeatureUnlock_58908_UnlockDesc|<FeatureUnlockTitle:调查行动「长梦尽时」已开启>\n\n<FeatureUnlockDesc:祂做了一场漫长的梦。\n祂梦见神与星辰，梦见尘埃衍化文明，文明化为尘埃。\n祂梦见恨与爱，梦见欢愉与恐惧。 \n祂从睡梦中惊醒。梦境中的一切，从未存在。>",
    LockTip = "FeatureUnlock_58908_LockTip|完成 「调查行动」第8章·普通 后解锁"
  },
  [72031] = {
    ID = 72031,
    CnID = "功能@主线第2部第1章",
    BaseSortID = 12,
    Feature = "MainCopy",
    Key = 70939,
    FeatureName = "FeatureUnlock_72031_FeatureName|「调查行动」星辰篇第1章",
    UnlockCondition = {1, 67914},
    UnlockDesc = "FeatureUnlock_72031_UnlockDesc|<FeatureUnlockTitle:调查行动「星辰正位之刻·重临雾都」已开启>\n\n<FeatureUnlockDesc:呼吸之间尘埃涌动，枯朽的太阳难以洞穿>",
    LockTip = "FeatureUnlock_72031_LockTip|完成 「调查行动」第9章·普通 后解锁"
  },
  [80318] = {
    ID = 80318,
    CnID = "功能@主线第2部第2章",
    BaseSortID = 13,
    Feature = "MainCopy",
    Key = 70938,
    FeatureName = "FeatureUnlock_80318_FeatureName|「调查行动」星辰篇第2章",
    UnlockCondition = {1, 70928},
    UnlockDesc = "FeatureUnlock_80318_UnlockDesc|<FeatureUnlockTitle:调查行动「星辰正位之刻·蜕变」已开启>\n\n<FeatureUnlockDesc:追随熟悉的金发身影，守密人来到未知的疗养院。这里，潜藏着无数破碎的秘密与灵魂。>",
    LockTip = "FeatureUnlock_80318_LockTip|完成 「调查行动」星辰篇第1章·普通 后解锁"
  },
  [91202] = {
    ID = 91202,
    CnID = "功能@主线第2部第3章",
    BaseSortID = 14,
    Feature = "MainCopy",
    Key = 70940,
    FeatureName = "FeatureUnlock_91202_FeatureName|「调查行动」星辰篇第3章",
    UnlockCondition = {1, 80242},
    UnlockDesc = "FeatureUnlock_91202_UnlockDesc|<FeatureUnlockTitle:调查行动「星辰正位之刻·餍飨」已开启>\n\n<FeatureUnlockDesc:穿越墓园的迷雾，宏伟的王城降临你身前。\n食尸鬼之王正耐心地等待，等待你加入他的盛宴。>",
    LockTip = "FeatureUnlock_91202_LockTip|完成 「调查行动」星辰篇第2章·普通 后解锁"
  },
  [120493] = {
    ID = 120493,
    CnID = "功能@主线第2部第4章",
    BaseSortID = 15,
    Feature = "MainCopy",
    Key = 118158,
    FeatureName = "FeatureUnlock_120493_FeatureName|「调查行动」星辰篇第4章",
    UnlockCondition = {1, 90680},
    UnlockDesc = "FeatureUnlock_120493_UnlockDesc|<FeatureUnlockTitle:调查行动「星辰正位之刻·乐园」已开启>\n\n<FeatureUnlockDesc:追踪着威廉的消息在海上漂泊数月后，你闯入了一场不可捉摸的离奇风暴……>",
    LockTip = "FeatureUnlock_120493_LockTip|完成 「调查行动」星辰篇第3章·普通 后解锁"
  },
  [126363] = {
    ID = 126363,
    CnID = "功能@主线第2部第5章",
    BaseSortID = 16,
    Feature = "MainCopy",
    Key = 125684,
    FeatureName = "FeatureUnlock_126363_FeatureName|「调查行动」星辰篇第5章",
    UnlockCondition = {1, 118146},
    UnlockDesc = "FeatureUnlock_126363_UnlockDesc|<FeatureUnlockTitle:调查行动「星辰正位之刻·织命剧场」已开启>\n\n<FeatureUnlockDesc:跨越黑日的门扉，你回到了那座熟悉的城市，而这一切，只是一座量身定制的舞台……>",
    LockTip = "FeatureUnlock_126363_LockTip|完成 「调查行动」星辰篇第4章·普通 后解锁"
  },
  [146356] = {
    ID = 146356,
    CnID = "功能@主线第2部第6章",
    BaseSortID = 17,
    Feature = "MainCopy",
    Key = 146257,
    FeatureName = "FeatureUnlock_146356_FeatureName|「调查行动」星辰篇第6章",
    UnlockCondition = {1, 125646},
    UnlockDesc = "FeatureUnlock_146356_UnlockDesc|<FeatureUnlockTitle:调查行动「星辰正位之刻·山宴」已开启>\n\n<FeatureUnlockDesc:乘着颠簸的汽车，守密人抵达了海拔四千米的终北大陆。云雾缭绕的雪山之巅，某个神秘的仪式正在等候攀登者的到来……>",
    LockTip = "FeatureUnlock_146356_LockTip|完成 「调查行动」星辰篇第5章·普通 后解锁"
  },
  [17069] = {
    ID = 17069,
    CnID = "功能@主线困难",
    BaseSortID = 18,
    Feature = "MainCopyHard",
    FeatureName = "FeatureUnlock_17069_FeatureName|「调查行动」·困难",
    UnlockCondition = {1, 8114},
    UnlockDesc = "FeatureUnlock_17069_UnlockDesc|<FeatureUnlockTitle: 「调查行动」·困难难度已开启>",
    LockTip = "FeatureUnlock_17069_LockTip|完成 「调查行动」3-5·普通 后解锁",
    Parameter = "20174"
  },
  [17068] = {
    ID = 17068,
    CnID = "功能@主线困难第一章",
    BaseSortID = 19,
    Feature = "MainCopyHard",
    Key = 15917,
    FeatureName = "FeatureUnlock_17068_FeatureName|「调查行动」第1章 ·困难",
    UnlockCondition = {1, 8114},
    LockTip = "FeatureUnlock_17068_LockTip|完成 「调查行动」3-5·普通 后解锁"
  },
  [17025] = {
    ID = 17025,
    CnID = "功能@主线困难第二章",
    BaseSortID = 20,
    Feature = "MainCopyHard",
    Key = 15895,
    FeatureName = "FeatureUnlock_17025_FeatureName|「调查行动」第2章 ·困难",
    UnlockCondition = {1, 7842},
    UnlockDesc = "FeatureUnlock_17025_UnlockDesc|<FeatureUnlockTitle:调查行动「以蜡像之名」·困难难度已开启>",
    LockTip = "FeatureUnlock_17025_LockTip|完成 「调查行动」1-8·困难 后解锁"
  },
  [17044] = {
    ID = 17044,
    CnID = "功能@主线困难第三章",
    BaseSortID = 21,
    Feature = "MainCopyHard",
    Key = 15906,
    FeatureName = "FeatureUnlock_17044_FeatureName|「调查行动」第3章 ·困难",
    UnlockCondition = {
      1,
      7933,
      1,
      8045
    },
    UnlockDesc = "FeatureUnlock_17044_UnlockDesc|<FeatureUnlockTitle:调查行动「谨防恶犬」·困难难度已开启>",
    LockTip = "FeatureUnlock_17044_LockTip|完成 「调查行动」3-5·普通 及 第2章·困难 后解锁"
  },
  [17003] = {
    ID = 17003,
    CnID = "功能@主线困难第四章",
    BaseSortID = 22,
    Feature = "MainCopyHard",
    Key = 15921,
    FeatureName = "FeatureUnlock_17003_FeatureName|「调查行动」第4章 ·困难",
    UnlockCondition = {
      1,
      7760,
      1,
      7869
    },
    UnlockDesc = "FeatureUnlock_17003_UnlockDesc|<FeatureUnlockTitle:调查行动「于无声处」·困难难度已开启>",
    LockTip = "FeatureUnlock_17003_LockTip|完成 「调查行动」第3章·困难 及第4章·普通 后解锁"
  },
  [17038] = {
    ID = 17038,
    CnID = "功能@主线困难第五章",
    BaseSortID = 23,
    Feature = "MainCopyHard",
    Key = 15905,
    FeatureName = "FeatureUnlock_17038_FeatureName|「调查行动」第5章 ·困难",
    UnlockCondition = {
      1,
      8105,
      1,
      22313
    },
    UnlockDesc = "FeatureUnlock_17038_UnlockDesc|<FeatureUnlockTitle:调查行动「风暴之眼」·困难难度已开启>",
    LockTip = "FeatureUnlock_17038_LockTip|完成 「调查行动」第4章·困难 及第5章·普通 后解锁"
  },
  [17070] = {
    ID = 17070,
    CnID = "功能@主线困难第六章",
    BaseSortID = 24,
    Feature = "MainCopyHard",
    Key = 15946,
    FeatureName = "FeatureUnlock_17070_FeatureName|「调查行动」第6章 ·困难",
    UnlockCondition = {
      1,
      7827,
      1,
      35857
    },
    UnlockDesc = "FeatureUnlock_17070_UnlockDesc|<FeatureUnlockTitle:调查行动「倒错的群星」·困难难度已开启>",
    LockTip = "FeatureUnlock_17070_LockTip|完成 「调查行动」第5章·困难 及第6章·普通 后解锁"
  },
  [48921] = {
    ID = 48921,
    CnID = "功能@主线困难第七章",
    BaseSortID = 25,
    Feature = "MainCopyHard",
    Key = 48869,
    FeatureName = "FeatureUnlock_48921_FeatureName|「调查行动」第7章 ·困难",
    UnlockCondition = {
      1,
      7945,
      1,
      48069
    },
    UnlockDesc = "FeatureUnlock_48921_UnlockDesc|<FeatureUnlockTitle:调查行动「欲河」·困难难度已开启>",
    LockTip = "FeatureUnlock_48921_LockTip|完成 「调查行动」第6章·困难 及第7章·普通 后解锁"
  },
  [58911] = {
    ID = 58911,
    CnID = "功能@主线困难第八章",
    BaseSortID = 26,
    Feature = "MainCopyHard",
    Key = 58906,
    FeatureName = "FeatureUnlock_58911_FeatureName|「调查行动」第8章 ·困难",
    UnlockCondition = {
      1,
      48065,
      1,
      62348
    },
    UnlockDesc = "FeatureUnlock_58911_UnlockDesc|<FeatureUnlockTitle:调查行动「终末交响曲」·困难难度已开启>",
    LockTip = "FeatureUnlock_58911_LockTip|完成 「调查行动」第7章·困难 及第8章·普通 后解锁"
  },
  [58909] = {
    ID = 58909,
    CnID = "功能@主线困难第九章",
    BaseSortID = 27,
    Feature = "MainCopyHard",
    Key = 67785,
    FeatureName = "FeatureUnlock_58909_FeatureName|「调查行动」终章 ·困难",
    UnlockCondition = {
      1,
      59071,
      1,
      67914
    },
    UnlockDesc = "FeatureUnlock_58909_UnlockDesc|<FeatureUnlockTitle:调查行动「长梦尽时」·困难难度已开启>",
    LockTip = "FeatureUnlock_58909_LockTip|完成 「调查行动」第8章·困难 及第9章·普通 后解锁"
  },
  [72076] = {
    ID = 72076,
    CnID = "功能@主线困难第2部第1章",
    BaseSortID = 28,
    Feature = "MainCopyHard",
    Key = 72075,
    FeatureName = "FeatureUnlock_72076_FeatureName|「调查行动」星辰篇第1章 ·困难",
    UnlockCondition = {1, 70928},
    UnlockDesc = "FeatureUnlock_72076_UnlockDesc|<FeatureUnlockTitle:调查行动「重临雾都」·困难难度已开启>",
    LockTip = "FeatureUnlock_72076_LockTip|完成 「调查行动」星辰篇第1章·普通 后解锁"
  },
  [80317] = {
    ID = 80317,
    CnID = "功能@主线困难第2部第2章",
    BaseSortID = 29,
    Feature = "MainCopyHard",
    Key = 72074,
    FeatureName = "FeatureUnlock_80317_FeatureName|「调查行动」星辰篇第2章 ·困难",
    UnlockCondition = {
      1,
      72070,
      1,
      80242
    },
    UnlockDesc = "FeatureUnlock_80317_UnlockDesc|<FeatureUnlockTitle:调查行动「蜕变」·困难难度已开启>",
    LockTip = "FeatureUnlock_80317_LockTip|完成 「调查行动」星辰篇第1章 · 困难 及第2章·普通 后解锁"
  },
  [91203] = {
    ID = 91203,
    CnID = "功能@主线困难第2部第3章",
    BaseSortID = 30,
    Feature = "MainCopyHard",
    Key = 72073,
    FeatureName = "FeatureUnlock_91203_FeatureName|「调查行动」星辰篇第3章 ·困难",
    UnlockCondition = {
      1,
      80269,
      1,
      90680
    },
    UnlockDesc = "FeatureUnlock_91203_UnlockDesc|<FeatureUnlockTitle:调查行动「餍飨」·困难难度已开启>",
    LockTip = "FeatureUnlock_91203_LockTip|完成 「调查行动」星辰篇第2章 · 困难 及第3章·普通 后解锁"
  },
  [120494] = {
    ID = 120494,
    CnID = "功能@主线困难第2部第4章",
    BaseSortID = 31,
    Feature = "MainCopyHard",
    Key = 118157,
    FeatureName = "FeatureUnlock_120494_FeatureName|「调查行动」星辰篇第4章 ·困难",
    UnlockCondition = {
      1,
      90674,
      1,
      118146
    },
    UnlockDesc = "FeatureUnlock_120494_UnlockDesc|<FeatureUnlockTitle:调查行动「乐园」·困难难度已开启>",
    LockTip = "FeatureUnlock_120494_LockTip|完成 「调查行动」星辰篇第3章 · 困难 及第4章·普通 后解锁"
  },
  [126364] = {
    ID = 126364,
    CnID = "功能@主线困难第2部第5章",
    BaseSortID = 32,
    Feature = "MainCopyHard",
    Key = 125685,
    FeatureName = "FeatureUnlock_126364_FeatureName|「调查行动」星辰篇第5章 ·困难",
    UnlockCondition = {
      1,
      118130,
      1,
      125646
    },
    UnlockDesc = "FeatureUnlock_126364_UnlockDesc|<FeatureUnlockTitle:调查行动「织命剧场」·困难难度已开启>",
    LockTip = "FeatureUnlock_126364_LockTip|完成 「调查行动」星辰篇第4章 · 困难 及第5章·普通 后解锁"
  },
  [146357] = {
    ID = 146357,
    CnID = "功能@主线困难第2部第6章",
    BaseSortID = 33,
    Feature = "MainCopyHard",
    Key = 146256,
    FeatureName = "FeatureUnlock_146357_FeatureName|「调查行动」星辰篇第6章 ·困难",
    UnlockCondition = {
      1,
      131105,
      1,
      146355
    },
    UnlockDesc = "FeatureUnlock_146357_UnlockDesc|<FeatureUnlockTitle:调查行动「山宴」·困难难度已开启>",
    LockTip = "FeatureUnlock_146357_LockTip|完成 「调查行动」星辰篇第5章 · 困难 及第6章·普通 后解锁"
  },
  [17056] = {
    ID = 17056,
    CnID = "功能@主线癫狂",
    BaseSortID = 34,
    Feature = "MainCopyCrazy",
    FeatureName = "FeatureUnlock_17056_FeatureName|「调查行动」·癫狂",
    UnlockCondition = {2, 120},
    UnlockDesc = "FeatureUnlock_17056_UnlockDesc|<FeatureUnlockTitle: 「调查行动」·癫狂难度已开启>",
    LockTip = "FeatureUnlock_17056_LockTip|敬请期待"
  },
  [17073] = {
    ID = 17073,
    CnID = "功能@主线癫狂第一章",
    BaseSortID = 35,
    Feature = "MainCopyCrazy",
    Key = 15896,
    FeatureName = "FeatureUnlock_17073_FeatureName|「调查行动」第1章 ·癫狂",
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_17073_LockTip|敬请期待"
  },
  [16989] = {
    ID = 16989,
    CnID = "功能@主线癫狂第二章",
    BaseSortID = 36,
    Feature = "MainCopyCrazy",
    Key = 15918,
    FeatureName = "FeatureUnlock_16989_FeatureName|「调查行动」第2章 ·癫狂",
    UnlockCondition = {2, 120},
    UnlockDesc = "FeatureUnlock_16989_UnlockDesc|<FeatureUnlockTitle:调查行动「以蜡像之名」·癫狂难度已开启>",
    LockTip = "FeatureUnlock_16989_LockTip|敬请期待"
  },
  [16973] = {
    ID = 16973,
    CnID = "功能@主线癫狂第三章",
    BaseSortID = 37,
    Feature = "MainCopyCrazy",
    Key = 15913,
    FeatureName = "FeatureUnlock_16973_FeatureName|「调查行动」第3章 ·癫狂",
    UnlockCondition = {2, 120},
    UnlockDesc = "FeatureUnlock_16973_UnlockDesc|<FeatureUnlockTitle:调查行动「谨防恶犬」·癫狂难度已开启>",
    LockTip = "FeatureUnlock_16973_LockTip|敬请期待"
  },
  [17066] = {
    ID = 17066,
    CnID = "功能@主线癫狂第四章",
    BaseSortID = 38,
    Feature = "MainCopyCrazy",
    Key = 15925,
    FeatureName = "FeatureUnlock_17066_FeatureName|「调查行动」第4章 ·癫狂",
    UnlockCondition = {2, 120},
    UnlockDesc = "FeatureUnlock_17066_UnlockDesc|<FeatureUnlockTitle:调查行动「于无声处」·癫狂难度已开启>",
    LockTip = "FeatureUnlock_17066_LockTip|敬请期待"
  },
  [16971] = {
    ID = 16971,
    CnID = "功能@主线癫狂第五章",
    BaseSortID = 39,
    Feature = "MainCopyCrazy",
    Key = 15919,
    FeatureName = "FeatureUnlock_16971_FeatureName|「调查行动」第5章 ·癫狂",
    UnlockCondition = {2, 120},
    UnlockDesc = "FeatureUnlock_16971_UnlockDesc|<FeatureUnlockTitle:调查行动「风暴之眼」·癫狂难度已开启>",
    LockTip = "FeatureUnlock_16971_LockTip|敬请期待"
  },
  [16986] = {
    ID = 16986,
    CnID = "功能@主线癫狂第六章",
    BaseSortID = 40,
    Feature = "MainCopyCrazy",
    Key = 15920,
    FeatureName = "FeatureUnlock_16986_FeatureName|「调查行动」第6章 ·癫狂",
    UnlockCondition = {2, 120},
    UnlockDesc = "FeatureUnlock_16986_UnlockDesc|<FeatureUnlockTitle:调查行动「倒错的群星」·癫狂难度已开启>",
    LockTip = "FeatureUnlock_16986_LockTip|敬请期待"
  },
  [48922] = {
    ID = 48922,
    CnID = "功能@主线癫狂第七章",
    BaseSortID = 41,
    Feature = "MainCopyCrazy",
    Key = 48868,
    FeatureName = "FeatureUnlock_48922_FeatureName|「调查行动」第7章 ·癫狂",
    UnlockCondition = {2, 120},
    UnlockDesc = "FeatureUnlock_48922_UnlockDesc|<FeatureUnlockTitle:调查行动「欲河」·癫狂难度已开启>",
    LockTip = "FeatureUnlock_48922_LockTip|敬请期待"
  },
  [58912] = {
    ID = 58912,
    CnID = "功能@主线癫狂第八章",
    BaseSortID = 42,
    Feature = "MainCopyCrazy",
    Key = 58904,
    FeatureName = "FeatureUnlock_58912_FeatureName|「调查行动」第8章 ·癫狂",
    UnlockCondition = {2, 120},
    UnlockDesc = "FeatureUnlock_58912_UnlockDesc|<FeatureUnlockTitle:调查行动「终末交响曲」·癫狂难度已开启>",
    LockTip = "FeatureUnlock_58912_LockTip|敬请期待"
  },
  [58915] = {
    ID = 58915,
    CnID = "功能@主线癫狂第九章",
    BaseSortID = 43,
    Feature = "MainCopyCrazy",
    Key = 67787,
    FeatureName = "FeatureUnlock_58915_FeatureName|「调查行动」终章 ·癫狂",
    UnlockCondition = {2, 120},
    UnlockDesc = "FeatureUnlock_58915_UnlockDesc|<FeatureUnlockTitle:调查行动「长梦尽时」·癫狂难度已开启>",
    LockTip = "FeatureUnlock_58915_LockTip|敬请期待"
  },
  [72035] = {
    ID = 72035,
    CnID = "功能@通关第1部剧情",
    BaseSortID = 44,
    Feature = "FirstChapterFinish",
    FeatureName = "FeatureUnlock_72035_FeatureName|通关忘却篇剧情",
    UnlockCondition = {1, 67914},
    LockTip = "FeatureUnlock_72035_LockTip|完成 「调查行动」第9章·普通 后回到主界面播放",
    StoryId = 71986
  },
  [17015] = {
    ID = 17015,
    CnID = "功能@抽卡",
    BaseSortID = 45,
    Feature = "DrawCard",
    FeatureName = "FeatureUnlock_17015_FeatureName|唤醒",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    UnlockDesc = "FeatureUnlock_17015_UnlockDesc|<FeatureUnlockTitle:唤醒仪式已开启>\n\n<FeatureUnlockDesc:可使用「无垢之芯」和「流明之芯」获取唤醒体和命轮。\n通过唤醒仪式还可获得「根源沉淀」，用以在弥萨格商店中兑换珍稀材料。>",
    LockTip = "FeatureUnlock_17015_LockTip|通关 序章 解锁"
  },
  [17032] = {
    ID = 17032,
    CnID = "功能@抽卡币商店",
    BaseSortID = 46,
    Feature = "Shop",
    FeatureEntranceType = 1,
    LockTip = "FeatureUnlock_17032_LockTip|通关 序章 解锁"
  },
  [17013] = {
    ID = 17013,
    CnID = "功能@高级抽卡币商店",
    BaseSortID = 47,
    Feature = "Shop",
    Key = 18654,
    FeatureName = "FeatureUnlock_17013_FeatureName|沉淀兑换",
    FeatureEntranceType = 1,
    LockTip = "FeatureUnlock_17013_LockTip|通关 序章 解锁"
  },
  [17024] = {
    ID = 17024,
    CnID = "功能@日常币商店",
    BaseSortID = 48,
    Feature = "Shop",
    Key = 18651,
    FeatureName = "FeatureUnlock_17024_FeatureName|融珠兑换",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7751},
    LockTip = "FeatureUnlock_17024_LockTip|完成 「调查行动」2-12·普通 后解锁"
  },
  [16991] = {
    ID = 16991,
    CnID = "功能@DBG玩法总入口",
    BaseSortID = 49,
    Feature = "DBGCopyGroup",
    FeatureName = "FeatureUnlock_16991_FeatureName|幕间演习",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8126},
    UnlockDesc = "FeatureUnlock_16991_UnlockDesc|<FeatureUnlockTitle:幕间演习已开启>\n\n<FeatureUnlockDesc:灾厄频发的年代，你们只能潜入旧时代的幻梦挖掘过往的奇迹。\n前往已覆灭的过往进行试炼，获得更多材料吧。>",
    LockTip = "FeatureUnlock_16991_LockTip|完成 「调查行动」1-2·普通 后解锁"
  },
  [17041] = {
    ID = 17041,
    CnID = "功能@日常材料本",
    BaseSortID = 50,
    Feature = "DailyMaterial",
    FeatureName = "FeatureUnlock_17041_FeatureName|融蚀之墟",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8126},
    UnlockDesc = "FeatureUnlock_17041_UnlockDesc|<FeatureUnlockTitle:融蚀之墟：金券搜查/制剂淬炼已开启>\n\n<FeatureUnlockDesc:在融蚀的残骸间搜寻遗留物，可以在弥萨格校务室兑换蔷薇金券或淬炼灵知制剂。>",
    LockTip = "FeatureUnlock_17041_LockTip|完成 「调查行动」1-2·普通 后解锁"
  },
  [17059] = {
    ID = 17059,
    CnID = "功能@日常金币本",
    BaseSortID = 51,
    Feature = "DailyMaterial",
    Key = 15951,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_17059_LockTip|完成 「调查行动」1-2·普通 后解锁"
  },
  [17057] = {
    ID = 17057,
    CnID = "功能@日常经验本",
    BaseSortID = 52,
    Feature = "DailyMaterial",
    Key = 15940,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_17057_LockTip|完成 「调查行动」1-2·普通 后解锁"
  },
  [17017] = {
    ID = 17017,
    CnID = "功能@日常深海本",
    BaseSortID = 53,
    Feature = "DailyMaterial",
    Key = 15915,
    FeatureName = "FeatureUnlock_17017_FeatureName|海渊残像",
    UnlockCondition = {1, 8028},
    UnlockDesc = "FeatureUnlock_17017_UnlockDesc|<FeatureUnlockTitle:融蚀之墟：升格素材已开启>\n\n<FeatureUnlockDesc:融蚀之墟中浮现出各界域残留的影像，在溃散前将它们记录于文书之上吧。>",
    LockTip = "FeatureUnlock_17017_LockTip|完成 「调查行动」1-13·普通 后解锁"
  },
  [17006] = {
    ID = 17006,
    CnID = "功能@日常血肉本",
    BaseSortID = 54,
    Feature = "DailyMaterial",
    Key = 15887,
    FeatureName = "FeatureUnlock_17006_FeatureName|器质残像",
    UnlockCondition = {1, 8028},
    LockTip = "FeatureUnlock_17006_LockTip|完成 「调查行动」1-13·普通 后解锁"
  },
  [17007] = {
    ID = 17007,
    CnID = "功能@日常超维本",
    BaseSortID = 55,
    Feature = "DailyMaterial",
    Key = 15872,
    FeatureName = "FeatureUnlock_17007_FeatureName|维度残像",
    UnlockCondition = {1, 8028},
    LockTip = "FeatureUnlock_17007_LockTip|完成 「调查行动」1-13·普通 后解锁"
  },
  [17047] = {
    ID = 17047,
    CnID = "功能@日常混沌本",
    BaseSortID = 56,
    Feature = "DailyMaterial",
    Key = 15936,
    FeatureName = "FeatureUnlock_17047_FeatureName|浑浊残像",
    UnlockCondition = {1, 8028},
    LockTip = "FeatureUnlock_17047_LockTip|完成 「调查行动」1-13·普通 后解锁"
  },
  [17035] = {
    ID = 17035,
    CnID = "功能@混沌技能本",
    BaseSortID = 57,
    Feature = "DailyMaterial",
    Key = 15904,
    FeatureName = "FeatureUnlock_17035_FeatureName|混沌集群",
    UnlockCondition = {2, 20},
    UnlockDesc = "FeatureUnlock_17035_UnlockDesc|<FeatureUnlockTitle:融蚀之墟·技能素材现已开启>\n\n<FeatureUnlockDesc:厌倦了庸常的试炼，这次你将潜往超越万古的意识深处……\n可利用界域特点，轻松获取唤醒体技能升级所需材料。>",
    LockTip = "FeatureUnlock_17035_LockTip|调查等级 20 级 解锁",
    Parameter = "20179"
  },
  [16998] = {
    ID = 16998,
    CnID = "功能@深海技能本",
    BaseSortID = 58,
    Feature = "DailyMaterial",
    Key = 15891,
    FeatureName = "FeatureUnlock_16998_FeatureName|波纳佩之墟",
    UnlockCondition = {2, 20},
    LockTip = "FeatureUnlock_16998_LockTip|调查等级 20 级 解锁"
  },
  [16988] = {
    ID = 16988,
    CnID = "功能@血肉技能本",
    BaseSortID = 59,
    Feature = "DailyMaterial",
    Key = 15893,
    FeatureName = "FeatureUnlock_16988_FeatureName|蠕虫之所",
    UnlockCondition = {2, 20},
    LockTip = "FeatureUnlock_16988_LockTip|调查等级 20 级 解锁"
  },
  [17004] = {
    ID = 17004,
    CnID = "功能@超维技能本",
    BaseSortID = 60,
    Feature = "DailyMaterial",
    Key = 15903,
    FeatureName = "FeatureUnlock_17004_FeatureName|史瓦西喉",
    UnlockCondition = {2, 20},
    LockTip = "FeatureUnlock_17004_LockTip|调查等级 20 级 解锁"
  },
  [16985] = {
    ID = 16985,
    CnID = "功能@饰品本",
    BaseSortID = 61,
    Feature = "TrinketCopy",
    FeatureName = "FeatureUnlock_16985_FeatureName|禁忌纂录",
    FeatureEntranceType = 1,
    UnlockCondition = {2, 25},
    UnlockDesc = "FeatureUnlock_16985_UnlockDesc|<FeatureUnlockTitle:禁忌纂录已开启>\n\n<FeatureUnlockDesc:在黑暗时代，这些符号被禁止抄写、转录。\n追溯禁忌的过往，获取更多密契套装。>",
    LockTip = "FeatureUnlock_16985_LockTip|调查等级 25 级 解锁",
    Parameter = "20180"
  },
  [16994] = {
    ID = 16994,
    CnID = "功能@饰品A本",
    BaseSortID = 62,
    Feature = "TrinketCopy",
    Key = 15873,
    FeatureName = "FeatureUnlock_16994_FeatureName|怪雾之都",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8030},
    LockTip = "FeatureUnlock_16994_LockTip|完成 「调查行动」第1章·普通 后解锁"
  },
  [16978] = {
    ID = 16978,
    CnID = "功能@饰品B本",
    BaseSortID = 63,
    Feature = "TrinketCopy",
    Key = 15958,
    FeatureName = "FeatureUnlock_16978_FeatureName|狂躁蜡馆",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7755},
    LockTip = "FeatureUnlock_16978_LockTip|完成 「调查行动」第2章·普通 后解锁"
  },
  [16960] = {
    ID = 16960,
    CnID = "功能@饰品C本",
    BaseSortID = 64,
    Feature = "TrinketCopy",
    Key = 15942,
    FeatureName = "FeatureUnlock_16960_FeatureName|错乱异镇",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8045},
    LockTip = "FeatureUnlock_16960_LockTip|完成 「调查行动」第3章·普通 后解锁"
  },
  [16969] = {
    ID = 16969,
    CnID = "功能@饰品D本",
    BaseSortID = 65,
    Feature = "TrinketCopy",
    Key = 15924,
    FeatureName = "FeatureUnlock_16969_FeatureName|失序山脉",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7869},
    LockTip = "FeatureUnlock_16969_LockTip|完成 「调查行动」第4章·普通 后解锁"
  },
  [17071] = {
    ID = 17071,
    CnID = "功能@饰品E本",
    BaseSortID = 66,
    Feature = "TrinketCopy",
    Key = 15908,
    FeatureName = "FeatureUnlock_17071_FeatureName|暗海之舟",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 22313},
    LockTip = "FeatureUnlock_17071_LockTip|完成 「调查行动」第5章·普通 后解锁"
  },
  [17033] = {
    ID = 17033,
    CnID = "功能@饰品F本",
    BaseSortID = 67,
    Feature = "TrinketCopy",
    Key = 15932,
    FeatureName = "FeatureUnlock_17033_FeatureName|风暴外海",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 35857},
    LockTip = "FeatureUnlock_17033_LockTip|完成 「调查行动」第6章·普通 后解锁"
  },
  [49171] = {
    ID = 49171,
    CnID = "功能@饰品G本",
    BaseSortID = 68,
    Feature = "TrinketCopy",
    Key = 49168,
    FeatureName = "FeatureUnlock_49171_FeatureName|荒沙之壁",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 48069},
    LockTip = "FeatureUnlock_49171_LockTip|完成 「调查行动」第7章·普通 后解锁"
  },
  [58913] = {
    ID = 58913,
    CnID = "功能@饰品H本",
    BaseSortID = 69,
    Feature = "TrinketCopy",
    Key = 58897,
    FeatureName = "FeatureUnlock_58913_FeatureName|原初裂隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 62348},
    LockTip = "FeatureUnlock_58913_LockTip|完成 「调查行动」第8章·普通 后解锁"
  },
  [16972] = {
    ID = 16972,
    CnID = "功能@日常挑战",
    BaseSortID = 70,
    Feature = "DailyChallenge",
    FeatureName = "FeatureUnlock_16972_FeatureName|幻梦深潜",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7751},
    UnlockDesc = "FeatureUnlock_16972_UnlockDesc|<FeatureUnlockTitle:幻梦深潜现已开启>\n\n<FeatureUnlockDesc:那是高位存在的古老幻梦。\n潜入过程中，守密人必须战胜负面共鸣的高压。每日都有不同的难关静候挑战。>",
    LockTip = "FeatureUnlock_16972_LockTip|完成 「调查行动」2-12·普通 后解锁",
    Parameter = "20171"
  },
  [16970] = {
    ID = 16970,
    CnID = "功能@无光之境",
    BaseSortID = 71,
    Feature = "AlternationSchoolTower",
    FeatureName = "FeatureUnlock_16970_FeatureName|无光之境",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7990},
    UnlockDesc = "FeatureUnlock_16970_UnlockDesc|<FeatureUnlockTitle:无光之境已开启>\n\n<FeatureUnlockDesc:在漆黑的视界里寻找真相。\n守密人可派出不同界域的队伍挑战，获取丰厚奖励。>",
    LockTip = "FeatureUnlock_16970_LockTip|完成 「调查行动」2-4·普通 后解锁",
    Parameter = "20196"
  },
  [17065] = {
    ID = 17065,
    CnID = "功能@无光之境深海之遗间隙",
    BaseSortID = 72,
    Feature = "AlternationSchoolTower",
    Key = 15916,
    FeatureName = "FeatureUnlock_17065_FeatureName|深海之遗·间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7990},
    LockTip = "FeatureUnlock_17065_LockTip|完成 「调查行动」2-4·普通 后解锁"
  },
  [17009] = {
    ID = 17009,
    CnID = "功能@无光之境血肉之沼间隙",
    BaseSortID = 73,
    Feature = "AlternationSchoolTower",
    Key = 15959,
    FeatureName = "FeatureUnlock_17009_FeatureName|血肉之沼·间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7990},
    LockTip = "FeatureUnlock_17009_LockTip|完成 「调查行动」2-4·普通 后解锁"
  },
  [17063] = {
    ID = 17063,
    CnID = "功能@无光之境超维之旅间隙",
    BaseSortID = 74,
    Feature = "AlternationSchoolTower",
    Key = 15884,
    FeatureName = "FeatureUnlock_17063_FeatureName|超维之旅·间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7990},
    LockTip = "FeatureUnlock_17063_LockTip|完成 「调查行动」2-4·普通 后解锁"
  },
  [17067] = {
    ID = 17067,
    CnID = "功能@无光之境混沌之域间隙",
    BaseSortID = 75,
    Feature = "AlternationSchoolTower",
    Key = 15874,
    FeatureName = "FeatureUnlock_17067_FeatureName|混沌之域·间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7990},
    LockTip = "FeatureUnlock_17067_LockTip|完成 「调查行动」2-4·普通 后解锁"
  },
  [17062] = {
    ID = 17062,
    CnID = "功能@无光之境深海之遗轮转间隙_1",
    BaseSortID = 76,
    Feature = "AlternationSchoolTower",
    Key = 15898,
    FeatureName = "FeatureUnlock_17062_FeatureName|深海之遗·轮转间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7935},
    LockTip = "FeatureUnlock_17062_LockTip|通关 深海之遗·间隙Ⅷ 解锁"
  },
  [17049] = {
    ID = 17049,
    CnID = "功能@无光之境血肉之沼轮转间隙_1",
    BaseSortID = 77,
    Feature = "AlternationSchoolTower",
    Key = 15931,
    FeatureName = "FeatureUnlock_17049_FeatureName|血肉之沼·轮转间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7879},
    LockTip = "FeatureUnlock_17049_LockTip|通关 血肉之沼·间隙Ⅷ 解锁"
  },
  [16963] = {
    ID = 16963,
    CnID = "功能@无光之境超维之旅轮转间隙_1",
    BaseSortID = 78,
    Feature = "AlternationSchoolTower",
    Key = 15869,
    FeatureName = "FeatureUnlock_16963_FeatureName|超维之旅·轮转间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7980},
    LockTip = "FeatureUnlock_16963_LockTip|通关 超维之旅·间隙Ⅷ 解锁"
  },
  [16992] = {
    ID = 16992,
    CnID = "功能@无光之境混沌之域轮转间隙_1",
    BaseSortID = 79,
    Feature = "AlternationSchoolTower",
    Key = 15910,
    FeatureName = "FeatureUnlock_16992_FeatureName|混沌之域·轮转间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8166},
    LockTip = "FeatureUnlock_16992_LockTip|通关 混沌之域·间隙Ⅷ 解锁"
  },
  [17060] = {
    ID = 17060,
    CnID = "功能@无光之境深海之遗轮转间隙_2",
    BaseSortID = 80,
    Feature = "AlternationSchoolTower",
    Key = 15900,
    FeatureName = "FeatureUnlock_17060_FeatureName|深海之遗·轮转间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7935},
    LockTip = "FeatureUnlock_17060_LockTip|通关 深海之遗·间隙Ⅷ 解锁"
  },
  [17050] = {
    ID = 17050,
    CnID = "功能@无光之境血肉之沼轮转间隙_2",
    BaseSortID = 81,
    Feature = "AlternationSchoolTower",
    Key = 15930,
    FeatureName = "FeatureUnlock_17050_FeatureName|血肉之沼·轮转间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7879},
    LockTip = "FeatureUnlock_17050_LockTip|通关 血肉之沼·间隙Ⅷ 解锁"
  },
  [16962] = {
    ID = 16962,
    CnID = "功能@无光之境超维之旅轮转间隙_2",
    BaseSortID = 82,
    Feature = "AlternationSchoolTower",
    Key = 15870,
    FeatureName = "FeatureUnlock_16962_FeatureName|超维之旅·轮转间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7980},
    LockTip = "FeatureUnlock_16962_LockTip|通关 超维之旅·间隙Ⅷ 解锁"
  },
  [17031] = {
    ID = 17031,
    CnID = "功能@无光之境混沌之域轮转间隙_2",
    BaseSortID = 83,
    Feature = "AlternationSchoolTower",
    Key = 15911,
    FeatureName = "FeatureUnlock_17031_FeatureName|混沌之域·轮转间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8166},
    LockTip = "FeatureUnlock_17031_LockTip|通关 混沌之域·间隙Ⅷ 解锁"
  },
  [17061] = {
    ID = 17061,
    CnID = "功能@无光之境深海之遗轮转间隙_3",
    BaseSortID = 84,
    Feature = "AlternationSchoolTower",
    Key = 15899,
    FeatureName = "FeatureUnlock_17061_FeatureName|深海之遗·轮转间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7935},
    LockTip = "FeatureUnlock_17061_LockTip|通关 深海之遗·间隙Ⅷ 解锁"
  },
  [17051] = {
    ID = 17051,
    CnID = "功能@无光之境血肉之沼轮转间隙_3",
    BaseSortID = 85,
    Feature = "AlternationSchoolTower",
    Key = 15929,
    FeatureName = "FeatureUnlock_17051_FeatureName|血肉之沼·轮转间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7879},
    LockTip = "FeatureUnlock_17051_LockTip|通关 血肉之沼·间隙Ⅷ 解锁"
  },
  [16961] = {
    ID = 16961,
    CnID = "功能@无光之境超维之旅轮转间隙_3",
    BaseSortID = 86,
    Feature = "AlternationSchoolTower",
    Key = 15871,
    FeatureName = "FeatureUnlock_16961_FeatureName|超维之旅·轮转间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7980},
    LockTip = "FeatureUnlock_16961_LockTip|通关 超维之旅·间隙Ⅷ 解锁"
  },
  [16990] = {
    ID = 16990,
    CnID = "功能@无光之境混沌之域轮转间隙_3",
    BaseSortID = 87,
    Feature = "AlternationSchoolTower",
    Key = 15912,
    FeatureName = "FeatureUnlock_16990_FeatureName|混沌之域·轮转间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8166},
    LockTip = "FeatureUnlock_16990_LockTip|通关 混沌之域·间隙Ⅷ 解锁"
  },
  [23670] = {
    ID = 23670,
    CnID = "功能@无光之境深海之遗轮转间隙_4",
    BaseSortID = 88,
    Feature = "AlternationSchoolTower",
    Key = 23663,
    FeatureName = "FeatureUnlock_23670_FeatureName|深海之遗·轮转间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7935},
    LockTip = "FeatureUnlock_23670_LockTip|通关 深海之遗·间隙Ⅷ 解锁"
  },
  [23669] = {
    ID = 23669,
    CnID = "功能@无光之境血肉之沼轮转间隙_4",
    BaseSortID = 89,
    Feature = "AlternationSchoolTower",
    Key = 23664,
    FeatureName = "FeatureUnlock_23669_FeatureName|血肉之沼·轮转间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7879},
    LockTip = "FeatureUnlock_23669_LockTip|通关 血肉之沼·间隙Ⅷ 解锁"
  },
  [23667] = {
    ID = 23667,
    CnID = "功能@无光之境超维之旅轮转间隙_4",
    BaseSortID = 90,
    Feature = "AlternationSchoolTower",
    Key = 23665,
    FeatureName = "FeatureUnlock_23667_FeatureName|超维之旅·轮转间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7980},
    LockTip = "FeatureUnlock_23667_LockTip|通关 超维之旅·间隙Ⅷ 解锁"
  },
  [23668] = {
    ID = 23668,
    CnID = "功能@无光之境混沌之域轮转间隙_4",
    BaseSortID = 91,
    Feature = "AlternationSchoolTower",
    Key = 23666,
    FeatureName = "FeatureUnlock_23668_FeatureName|混沌之域·轮转间隙",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8166},
    LockTip = "FeatureUnlock_23668_LockTip|通关 混沌之域·间隙Ⅷ 解锁"
  },
  [21452] = {
    ID = 21452,
    CnID = "功能@周常BOSS本",
    BaseSortID = 92,
    Feature = "WeekBossChallenge",
    FeatureName = "FeatureUnlock_21452_FeatureName|超验存在",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8043},
    UnlockDesc = "FeatureUnlock_21452_UnlockDesc|<FeatureUnlockTitle:超验存在已开启>\n\n<FeatureUnlockDesc:祂们是无视一切规则与因果的禁忌存在。\n消耗灵啡肽进行挑战，可以获得更珍稀的唤醒体技能升级材料。>",
    LockTip = "FeatureUnlock_21452_LockTip|完成 「调查行动」3-10·普通 后解锁",
    Parameter = "20175"
  },
  [17072] = {
    ID = 17072,
    CnID = "功能@周常BOSSA本",
    BaseSortID = 93,
    Feature = "WeekBossChallenge",
    Key = 15945,
    FeatureName = "FeatureUnlock_17072_FeatureName|玩偶之泪",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8043},
    LockTip = "FeatureUnlock_17072_LockTip|完成 「调查行动」3-10·普通 后解锁"
  },
  [16982] = {
    ID = 16982,
    CnID = "功能@周常BOSSB本",
    BaseSortID = 94,
    Feature = "WeekBossChallenge",
    Key = 15892,
    FeatureName = "FeatureUnlock_16982_FeatureName|蜡像之秘",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8043},
    LockTip = "FeatureUnlock_16982_LockTip|完成 「调查行动」3-10·普通 后解锁"
  },
  [16964] = {
    ID = 16964,
    CnID = "功能@周常BOSSC本",
    BaseSortID = 95,
    Feature = "WeekBossChallenge",
    Key = 15878,
    FeatureName = "FeatureUnlock_16964_FeatureName|漆黑之链",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8045},
    LockTip = "FeatureUnlock_16964_LockTip|完成 「调查行动」第3章·普通 后解锁"
  },
  [17011] = {
    ID = 17011,
    CnID = "功能@周常BOSSD本",
    BaseSortID = 96,
    Feature = "WeekBossChallenge",
    Key = 15909,
    FeatureName = "FeatureUnlock_17011_FeatureName|界外之影",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7869},
    LockTip = "FeatureUnlock_17011_LockTip|完成 「调查行动」第4章·普通 后解锁"
  },
  [16996] = {
    ID = 16996,
    CnID = "功能@周常BOSSE本",
    BaseSortID = 97,
    Feature = "WeekBossChallenge",
    Key = 15897,
    FeatureName = "FeatureUnlock_16996_FeatureName|虔诚之握",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 22313},
    LockTip = "FeatureUnlock_16996_LockTip|完成 「调查行动」第5章·普通 后解锁"
  },
  [17039] = {
    ID = 17039,
    CnID = "功能@周常BOSSF本",
    BaseSortID = 98,
    Feature = "WeekBossChallenge",
    Key = 15928,
    FeatureName = "FeatureUnlock_17039_FeatureName|圣胎之咏",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 35857},
    LockTip = "FeatureUnlock_17039_LockTip|完成 「调查行动」第6章·普通 后解锁"
  },
  [49170] = {
    ID = 49170,
    CnID = "功能@周常BOSSG本",
    BaseSortID = 99,
    Feature = "WeekBossChallenge",
    Key = 49169,
    FeatureName = "FeatureUnlock_49170_FeatureName|沙海遗存",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 48069},
    LockTip = "FeatureUnlock_49170_LockTip|完成 「调查行动」第7章·普通 后解锁"
  },
  [58914] = {
    ID = 58914,
    CnID = "功能@周常BOSSH本",
    BaseSortID = 100,
    Feature = "WeekBossChallenge",
    Key = 58901,
    FeatureName = "FeatureUnlock_58914_FeatureName|黑池之潮",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 62348},
    LockTip = "FeatureUnlock_58914_LockTip|完成 「调查行动」第8章·普通 后解锁"
  },
  [16975] = {
    ID = 16975,
    CnID = "功能@战斗二倍速",
    BaseSortID = 101,
    Feature = "QuickenBattle"
  },
  [80156] = {
    ID = 80156,
    CnID = "功能@自动战斗",
    BaseSortID = 102,
    Feature = "QuickClear",
    UnlockCondition = {1, 8121},
    LockTip = "FeatureUnlock_80156_LockTip|完成 「调查行动」1-9·普通 后解锁"
  },
  [17034] = {
    ID = 17034,
    CnID = "功能@邮件",
    BaseSortID = 103,
    Feature = "Mail",
    FeatureName = "FeatureUnlock_17034_FeatureName|信箱",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_17034_LockTip|通关 序章 解锁"
  },
  [17040] = {
    ID = 17040,
    CnID = "功能@任务",
    BaseSortID = 104,
    Feature = "Task",
    FeatureName = "FeatureUnlock_17040_FeatureName|学籍档案",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_17040_LockTip|通关 序章 解锁",
    Parameter = "20184"
  },
  [17046] = {
    ID = 17046,
    CnID = "功能@生涯任务",
    BaseSortID = 105,
    Feature = "Task",
    Key = 3,
    FeatureName = "FeatureUnlock_17046_FeatureName|行动报告",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8125},
    LockTip = "FeatureUnlock_17046_LockTip|完成 「调查行动」1-5·普通 后解锁"
  },
  [17000] = {
    ID = 17000,
    CnID = "功能@玩家等级任务",
    BaseSortID = 106,
    Feature = "Task",
    Key = 8,
    FeatureName = "FeatureUnlock_17000_FeatureName|成长记录",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8125},
    LockTip = "FeatureUnlock_17000_LockTip|完成 「调查行动」1-5·普通 后解锁"
  },
  [16981] = {
    ID = 16981,
    CnID = "功能@界域精通任务",
    BaseSortID = 107,
    Feature = "Task",
    Key = 7,
    FeatureName = "FeatureUnlock_16981_FeatureName|界域精通",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8125},
    LockTip = "FeatureUnlock_16981_LockTip|完成 「调查行动」1-5·普通 后解锁"
  },
  [16974] = {
    ID = 16974,
    CnID = "功能@角色升级",
    BaseSortID = 108,
    Feature = "AwakerLevelUp"
  },
  [16999] = {
    ID = 16999,
    CnID = "功能@角色突破",
    BaseSortID = 109,
    Feature = "AwakerBreakThrough"
  },
  [16976] = {
    ID = 16976,
    CnID = "功能@技能升级",
    BaseSortID = 110,
    Feature = "AwakerSkillLvUp"
  },
  [148488] = {
    ID = 148488,
    CnID = "功能@密契绑定",
    BaseSortID = 111,
    Feature = "TrinketBind",
    FeatureName = "FeatureUnlock_148488_FeatureName|密契结合",
    FeatureEntranceType = 1,
    UnlockCondition = {2, 60},
    UnlockDesc = "FeatureUnlock_148488_UnlockDesc|<FeatureUnlockTitle:密契结合已开启>\n\n<FeatureUnlockDesc:弥萨格在古典文籍中解读出了将密契刻画于灵核中的结合术式，能够大幅提升密契的增幅效果。请试试吧。\n将密契与唤醒体结合，获得主属性额外加成。>",
    LockTip = "FeatureUnlock_148488_LockTip|调查等级 60 级 解锁"
  },
  [16997] = {
    ID = 16997,
    CnID = "功能@武器强化",
    BaseSortID = 112,
    Feature = "WeaponLevelUp"
  },
  [16987] = {
    ID = 16987,
    CnID = "功能@武器突破",
    BaseSortID = 113,
    Feature = "WeaponBreakThrough"
  },
  [17008] = {
    ID = 17008,
    CnID = "功能@通行证",
    BaseSortID = 114,
    Feature = "BattlePass",
    FeatureName = "FeatureUnlock_17008_FeatureName|学期课题",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7685},
    UnlockDesc = "FeatureUnlock_17008_UnlockDesc|<FeatureUnlockTitle:学期课题现已开启>\n\n<FeatureUnlockDesc:没人能逃脱课业的压力，守密人也有期末考试。\n完成密境课室的日常试训和周常试训，提升课题等级并解锁更多课题奖励。>",
    LockTip = "FeatureUnlock_17008_LockTip|完成 「调查行动」1-11·普通 后解锁",
    Parameter = "20195"
  },
  [17075] = {
    ID = 17075,
    CnID = "功能@委派任务",
    BaseSortID = 115,
    Feature = "Task",
    Key = 1,
    FeatureName = "FeatureUnlock_17075_FeatureName|派遣",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8120},
    ResearchIcon = "Icon/Research/Research_Icon_Entrance02.png",
    ResearchLockIcon = "Icon/Research/Research_Icon_Entrance02_Lock.png",
    UnlockDesc = "FeatureUnlock_17075_UnlockDesc|<FeatureUnlockTitle:派遣任务已开启>\n\n<FeatureUnlockDesc:穿插在调查与课业之间的小小任务。\n派遣唤醒体执行任务，获得银芯和各种素材。>",
    LockTip = "FeatureUnlock_17075_LockTip|完成 「调查行动」1-8·普通 后解锁",
    Parameter = "20193"
  },
  [17016] = {
    ID = 17016,
    CnID = "功能@炼金",
    BaseSortID = 116,
    Feature = "ItemConversion",
    FeatureName = "FeatureUnlock_17016_FeatureName|冶炼室",
    FeatureEntranceType = 1,
    ResearchIcon = "Icon/Research/Research_Icon_Entrance03.png",
    ResearchLockIcon = "Icon/Research/Research_Icon_Entrance03_Lock.png",
    LockTip = "FeatureUnlock_17016_LockTip|通关 序章 解锁"
  },
  [16955] = {
    ID = 16955,
    CnID = "功能@炼金合成",
    BaseSortID = 117,
    Feature = "Compose",
    FeatureName = "FeatureUnlock_16955_FeatureName|材料合成",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7688},
    LockTip = "FeatureUnlock_16955_LockTip|完成 「调查行动」2-15·普通 后解锁"
  },
  [17058] = {
    ID = 17058,
    CnID = "功能@成就任务",
    BaseSortID = 118,
    Feature = "Task",
    Key = 4,
    FeatureName = "FeatureUnlock_17058_FeatureName|成就",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8125},
    ResearchIcon = "Icon/Research/Research_Icon_Entrance08.png",
    ResearchLockIcon = "Icon/Research/Research_Icon_Entrance08_Lock.png",
    LockTip = "FeatureUnlock_17058_LockTip|完成 「调查行动」1-5·普通 后解锁"
  },
  [17014] = {
    ID = 17014,
    CnID = "功能@炼金重印",
    BaseSortID = 119,
    Feature = "Recast",
    FeatureName = "FeatureUnlock_17014_FeatureName|密契重印",
    FeatureEntranceType = 1,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_17014_LockTip|敬请期待"
  },
  [17045] = {
    ID = 17045,
    CnID = "功能@炼金分解",
    BaseSortID = 120,
    Feature = "Decompose",
    FeatureName = "FeatureUnlock_17045_FeatureName|命轮分解",
    FeatureEntranceType = 1,
    LockTip = "FeatureUnlock_17045_LockTip|通关 序章 解锁"
  },
  [16965] = {
    ID = 16965,
    CnID = "功能@炼金密契分解",
    BaseSortID = 121,
    Feature = "TrinketDecompose",
    FeatureName = "FeatureUnlock_16965_FeatureName|密契分解",
    FeatureEntranceType = 1,
    UnlockCondition = {2, 25},
    LockTip = "FeatureUnlock_16965_LockTip|调查等级 25 级 解锁"
  },
  [147801] = {
    ID = 147801,
    CnID = "功能@炼金材料分解",
    BaseSortID = 122,
    Feature = "MaterialDecompose",
    FeatureName = "FeatureUnlock_147801_FeatureName|材料分解",
    FeatureEntranceType = 1,
    LockTip = "FeatureUnlock_147801_LockTip|通关 序章 解锁"
  },
  [17022] = {
    ID = 17022,
    CnID = "功能@好友",
    BaseSortID = 123,
    Feature = "Friends",
    FeatureName = "FeatureUnlock_17022_FeatureName|校友会",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_17022_LockTip|通关 序章 后解锁"
  },
  [17005] = {
    ID = 17005,
    CnID = "功能@竞技场",
    BaseSortID = 124,
    Feature = "Arena",
    FeatureName = "FeatureUnlock_17005_FeatureName|幕间演习(开发中)",
    FeatureEntranceType = 1,
    UnlockCondition = {2, 120},
    ResearchIcon = "Icon/Research/Research_Icon_Entrance06.png",
    ResearchLockIcon = "Icon/Research/Research_Icon_Entrance06_Lock.png",
    LockTip = "FeatureUnlock_17005_LockTip|敬请期待",
    FirstEnterTitle = "欢迎来到竞技场！",
    FirstEnterSubtitle = "你可以消耗「演习凭证」挑战其他守密人布置的防守队伍，挑战成功后将会提升排名。\n你也需要精心布置你的防守队伍，否则将可能被其他守密人挑战成功导致排名下降。\n排名越高每小时获得的「演习徽章」越多。\n「演习凭证」将跟随时间自动获得。\n「演习徽章」可以在兑换商店中兑换蔷薇金券、灵知制剂等道具。",
    FirstEnterDesc = "要记得来竞技场领取「演习徽章」喔~"
  },
  [17042] = {
    ID = 17042,
    CnID = "功能@公会",
    BaseSortID = 125,
    Feature = "Guild",
    FeatureName = "FeatureUnlock_17042_FeatureName|结社",
    FeatureEntranceType = 1,
    UnlockCondition = {2, 120},
    ResearchIcon = "Icon/Research/Research_Icon_Entrance07.png",
    ResearchLockIcon = "Icon/Research/Research_Icon_Entrance07_Lock.png",
    LockTip = "FeatureUnlock_17042_LockTip|敬请期待"
  },
  [17001] = {
    ID = 17001,
    CnID = "功能@上古战场",
    BaseSortID = 126,
    Feature = "BattleGround",
    FeatureName = "FeatureUnlock_17001_FeatureName|狂蚀集训(开发中)",
    FeatureEntranceType = 1,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_17001_LockTip|敬请期待"
  },
  [17055] = {
    ID = 17055,
    CnID = "功能@炼金置换",
    BaseSortID = 127,
    Feature = "Exchange",
    FeatureName = "FeatureUnlock_17055_FeatureName|材料置换",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8043},
    LockTip = "FeatureUnlock_17055_LockTip|完成 「调查行动」3-10·普通 后解锁"
  },
  [16957] = {
    ID = 16957,
    CnID = "功能@充值",
    BaseSortID = 128,
    Feature = "Shop",
    Key = 18655,
    FeatureName = "FeatureUnlock_16957_FeatureName|源液提取",
    FeatureEntranceType = 1,
    LockTip = "FeatureUnlock_16957_LockTip|通关 序章 解锁"
  },
  [17037] = {
    ID = 17037,
    CnID = "功能@大型支线",
    BaseSortID = 129,
    Feature = "LargeSubplotTab",
    FeatureName = "FeatureUnlock_17037_FeatureName|特遣纪录",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_17037_LockTip|通关 序章 后解锁"
  },
  [17020] = {
    ID = 17020,
    CnID = "功能@小型支线",
    BaseSortID = 130,
    Feature = "SmallSubplotTab",
    FeatureName = "FeatureUnlock_17020_FeatureName|意识潜游",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_17020_LockTip|通关 序章 后解锁"
  },
  [51757] = {
    ID = 51757,
    CnID = "功能@异梦视界",
    BaseSortID = 131,
    Feature = "SpecialSubplotTab",
    FeatureName = "FeatureUnlock_51757_FeatureName|异梦视界",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_51757_LockTip|通关 序章 后解锁"
  },
  [78734] = {
    ID = 78734,
    CnID = "功能@万象宇宙",
    BaseSortID = 132,
    Feature = "CollaborationSubplotTab",
    FeatureName = "FeatureUnlock_78734_FeatureName|多维连接",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_78734_LockTip|通关 序章 后解锁"
  },
  [17052] = {
    ID = 17052,
    CnID = "功能@达芙戴尔支线关卡普通",
    BaseSortID = 133,
    Feature = "LargeSubplot",
    Key = 15947,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_17052_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [17010] = {
    ID = 17010,
    CnID = "功能@达芙戴尔支线关卡困难",
    BaseSortID = 134,
    Feature = "LargeSubplotHard",
    Key = 15894,
    UnlockCondition = {1, 8010},
    LockTip = "FeatureUnlock_17010_LockTip|完成 「雨镇幽影」·普通 后解锁"
  },
  [16993] = {
    ID = 16993,
    CnID = "功能@达芙戴尔支线关卡癫狂",
    BaseSortID = 135,
    Feature = "LargeSubplotCrazy",
    Key = 15875,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_16993_LockTip|暂未开放"
  },
  [23701] = {
    ID = 23701,
    CnID = "功能@莉莉支线关卡普通",
    BaseSortID = 136,
    Feature = "LargeSubplot",
    Key = 23622,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_23701_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [23699] = {
    ID = 23699,
    CnID = "功能@莉莉支线关卡困难",
    BaseSortID = 137,
    Feature = "LargeSubplotHard",
    Key = 23621,
    UnlockCondition = {1, 23644},
    LockTip = "FeatureUnlock_23699_LockTip|完成 「故事的魔法」·普通 后解锁"
  },
  [23700] = {
    ID = 23700,
    CnID = "功能@莉莉支线关卡癫狂",
    BaseSortID = 138,
    Feature = "LargeSubplotCrazy",
    Key = 23623,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_23700_LockTip|暂未开放"
  },
  [24504] = {
    ID = 24504,
    CnID = "功能@索蕾尔支线关卡普通",
    BaseSortID = 139,
    Feature = "LargeSubplot",
    Key = 24436,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_24504_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [24502] = {
    ID = 24502,
    CnID = "功能@索蕾尔支线关卡困难",
    BaseSortID = 140,
    Feature = "LargeSubplotHard",
    Key = 24438,
    UnlockCondition = {1, 24425},
    LockTip = "FeatureUnlock_24502_LockTip|完成 「蔷薇礼赞」·普通 后解锁"
  },
  [24503] = {
    ID = 24503,
    CnID = "功能@索蕾尔支线关卡癫狂",
    BaseSortID = 141,
    Feature = "LargeSubplotCrazy",
    Key = 24437,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_24503_LockTip|暂未开放"
  },
  [20463] = {
    ID = 20463,
    CnID = "功能@奥吉尔支线关卡普通",
    BaseSortID = 142,
    Feature = "SmallSubplot",
    Key = 20452,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_20463_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [20455] = {
    ID = 20455,
    CnID = "功能@奥吉尔支线关卡困难",
    BaseSortID = 143,
    Feature = "SmallSubplotHard",
    Key = 20454,
    UnlockCondition = {1, 20435},
    LockTip = "FeatureUnlock_20455_LockTip|完成 「骑士的愿望」·普通 后解锁"
  },
  [20459] = {
    ID = 20459,
    CnID = "功能@奥吉尔支线关卡癫狂",
    BaseSortID = 144,
    Feature = "SmallSubplotCrazy",
    Key = 20449,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_20459_LockTip|暂未开放"
  },
  [16983] = {
    ID = 16983,
    CnID = "功能@尤乌哈希支线关卡普通",
    BaseSortID = 145,
    Feature = "SmallSubplot",
    Key = 15923,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_16983_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [17021] = {
    ID = 17021,
    CnID = "功能@尤乌哈希支线关卡困难",
    BaseSortID = 146,
    Feature = "SmallSubplotHard",
    Key = 15888,
    UnlockCondition = {1, 7663},
    LockTip = "FeatureUnlock_17021_LockTip|完成 「血与沙」·普通 后解锁"
  },
  [17019] = {
    ID = 17019,
    CnID = "功能@尤乌哈希支线关卡癫狂",
    BaseSortID = 147,
    Feature = "SmallSubplotCrazy",
    Key = 15960,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_17019_LockTip|暂未开放"
  },
  [20227] = {
    ID = 20227,
    CnID = "功能@珊支线关卡普通",
    BaseSortID = 148,
    Feature = "SmallSubplot",
    Key = 20223,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_20227_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [20225] = {
    ID = 20225,
    CnID = "功能@珊支线关卡困难",
    BaseSortID = 149,
    Feature = "SmallSubplotHard",
    Key = 20224,
    UnlockCondition = {1, 20089},
    LockTip = "FeatureUnlock_20225_LockTip|完成 「雕塑之死」·普通 后解锁"
  },
  [20226] = {
    ID = 20226,
    CnID = "功能@珊支线关卡癫狂",
    BaseSortID = 150,
    Feature = "SmallSubplotCrazy",
    Key = 20222,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_20226_LockTip|暂未开放"
  },
  [20460] = {
    ID = 20460,
    CnID = "功能@艾瑞卡支线关卡普通",
    BaseSortID = 151,
    Feature = "SmallSubplot",
    Key = 20448,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_20460_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [20458] = {
    ID = 20458,
    CnID = "功能@艾瑞卡支线关卡困难",
    BaseSortID = 152,
    Feature = "SmallSubplotHard",
    Key = 20451,
    UnlockCondition = {1, 20426},
    LockTip = "FeatureUnlock_20458_LockTip|完成 「扭曲核心」·普通 后解锁"
  },
  [20462] = {
    ID = 20462,
    CnID = "功能@艾瑞卡支线关卡癫狂",
    BaseSortID = 153,
    Feature = "SmallSubplotCrazy",
    Key = 20447,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_20462_LockTip|暂未开放"
  },
  [20456] = {
    ID = 20456,
    CnID = "功能@阿格里帕支线关卡普通",
    BaseSortID = 154,
    Feature = "SmallSubplot",
    Key = 20446,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_20456_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [20461] = {
    ID = 20461,
    CnID = "功能@阿格里帕支线关卡困难",
    BaseSortID = 155,
    Feature = "SmallSubplotHard",
    Key = 20453,
    UnlockCondition = {1, 20430},
    LockTip = "FeatureUnlock_20461_LockTip|完成 「苍白之主」·普通 后解锁"
  },
  [20457] = {
    ID = 20457,
    CnID = "功能@阿格里帕支线关卡癫狂",
    BaseSortID = 156,
    Feature = "SmallSubplotCrazy",
    Key = 20450,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_20457_LockTip|暂未开放"
  },
  [25072] = {
    ID = 25072,
    CnID = "功能@本源拉蒙娜支线关卡普通",
    BaseSortID = 157,
    Feature = "SmallSubplot",
    Key = 24553,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_25072_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [25070] = {
    ID = 25070,
    CnID = "功能@本源拉蒙娜支线关卡困难",
    BaseSortID = 158,
    Feature = "SmallSubplotHard",
    Key = 24554,
    UnlockCondition = {1, 24528},
    LockTip = "FeatureUnlock_25070_LockTip|完成 「一步之遥」·普通 后解锁"
  },
  [25071] = {
    ID = 25071,
    CnID = "功能@本源拉蒙娜支线关卡癫狂",
    BaseSortID = 159,
    Feature = "SmallSubplotCrazy",
    Key = 24552,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_25071_LockTip|暂未开放"
  },
  [36165] = {
    ID = 36165,
    CnID = "功能@奥瑞塔支线关卡普通",
    BaseSortID = 160,
    Feature = "SmallSubplot",
    Key = 35545,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_36165_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [36166] = {
    ID = 36166,
    CnID = "功能@奥瑞塔支线关卡困难",
    BaseSortID = 161,
    Feature = "SmallSubplotHard",
    Key = 35546,
    UnlockCondition = {1, 35575},
    LockTip = "FeatureUnlock_36166_LockTip|完成 「诸事如常」·普通 后解锁"
  },
  [36167] = {
    ID = 36167,
    CnID = "功能@奥瑞塔支线关卡癫狂",
    BaseSortID = 162,
    Feature = "SmallSubplotCrazy",
    Key = 35544,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_36167_LockTip|暂未开放"
  },
  [36630] = {
    ID = 36630,
    CnID = "功能@旺达支线关卡普通",
    BaseSortID = 163,
    Feature = "SmallSubplot",
    Key = 36627,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_36630_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [36629] = {
    ID = 36629,
    CnID = "功能@旺达支线关卡困难",
    BaseSortID = 164,
    Feature = "SmallSubplotHard",
    Key = 36625,
    UnlockCondition = {1, 36616},
    LockTip = "FeatureUnlock_36629_LockTip|完成 「燃烧的群宴」·普通 后解锁"
  },
  [36628] = {
    ID = 36628,
    CnID = "功能@旺达支线关卡癫狂",
    BaseSortID = 165,
    Feature = "SmallSubplotCrazy",
    Key = 36626,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_36628_LockTip|暂未开放"
  },
  [43520] = {
    ID = 43520,
    CnID = "功能@戈利亚支线关卡普通",
    BaseSortID = 166,
    Feature = "SmallSubplot",
    Key = 43517,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_43520_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [43519] = {
    ID = 43519,
    CnID = "功能@戈利亚支线关卡困难",
    BaseSortID = 167,
    Feature = "SmallSubplotHard",
    Key = 43515,
    UnlockCondition = {1, 43510},
    LockTip = "FeatureUnlock_43519_LockTip|完成 「巨人的陨落」·普通 后解锁"
  },
  [43518] = {
    ID = 43518,
    CnID = "功能@戈利亚支线关卡癫狂",
    BaseSortID = 168,
    Feature = "SmallSubplotCrazy",
    Key = 43516,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_43518_LockTip|暂未开放"
  },
  [44570] = {
    ID = 44570,
    CnID = "功能@萨尔瓦多支线关卡普通",
    BaseSortID = 169,
    Feature = "LargeSubplot",
    Key = 44564,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_44570_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [44569] = {
    ID = 44569,
    CnID = "功能@萨尔瓦多支线关卡困难",
    BaseSortID = 170,
    Feature = "LargeSubplotHard",
    Key = 44565,
    UnlockCondition = {1, 44552},
    LockTip = "FeatureUnlock_44569_LockTip|完成 「血的颜色」·普通 后解锁"
  },
  [44568] = {
    ID = 44568,
    CnID = "功能@萨尔瓦多支线关卡癫狂",
    BaseSortID = 171,
    Feature = "LargeSubplotCrazy",
    Key = 44566,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_44568_LockTip|暂未开放"
  },
  [46186] = {
    ID = 46186,
    CnID = "功能@「24」支线关卡普通",
    BaseSortID = 172,
    Feature = "LargeSubplot",
    Key = 46185,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_46186_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [46187] = {
    ID = 46187,
    CnID = "功能@「24」支线关卡困难",
    BaseSortID = 173,
    Feature = "LargeSubplotHard",
    Key = 46184,
    UnlockCondition = {1, 46173},
    LockTip = "FeatureUnlock_46187_LockTip|完成 「宁静的裂殖」·普通 后解锁"
  },
  [46188] = {
    ID = 46188,
    CnID = "功能@「24」支线关卡癫狂",
    BaseSortID = 174,
    Feature = "LargeSubplotCrazy",
    Key = 46183,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_46188_LockTip|暂未开放"
  },
  [55458] = {
    ID = 55458,
    CnID = "功能@奥尔拉支线关卡普通",
    BaseSortID = 175,
    Feature = "LargeSubplot",
    Key = 55455,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_55458_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [55459] = {
    ID = 55459,
    CnID = "功能@奥尔拉支线关卡困难",
    BaseSortID = 176,
    Feature = "LargeSubplotHard",
    Key = 55454,
    UnlockCondition = {1, 55392},
    LockTip = "FeatureUnlock_55459_LockTip|完成 「玫瑰的栖居」·普通 后解锁"
  },
  [55460] = {
    ID = 55460,
    CnID = "功能@奥尔拉支线关卡癫狂",
    BaseSortID = 177,
    Feature = "LargeSubplotCrazy",
    Key = 55453,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_55460_LockTip|暂未开放"
  },
  [57709] = {
    ID = 57709,
    CnID = "功能@莱克支线关卡普通",
    BaseSortID = 178,
    Feature = "LargeSubplot",
    Key = 56441,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_57709_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [57708] = {
    ID = 57708,
    CnID = "功能@莱克支线关卡困难",
    BaseSortID = 179,
    Feature = "LargeSubplotHard",
    Key = 56446,
    UnlockCondition = {1, 57685},
    LockTip = "FeatureUnlock_57708_LockTip|完成 「狩猎愉快！」·普通 后解锁"
  },
  [57707] = {
    ID = 57707,
    CnID = "功能@莱克支线关卡癫狂",
    BaseSortID = 180,
    Feature = "LargeSubplotCrazy",
    Key = 56440,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_57707_LockTip|暂未开放"
  },
  [57714] = {
    ID = 57714,
    CnID = "功能@本源希洛支线关卡普通",
    BaseSortID = 181,
    Feature = "LargeSubplot",
    Key = 56443,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_57714_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [57712] = {
    ID = 57712,
    CnID = "功能@本源希洛支线关卡困难",
    BaseSortID = 182,
    Feature = "LargeSubplotHard",
    Key = 56445,
    UnlockCondition = {1, 58691},
    LockTip = "FeatureUnlock_57712_LockTip|完成 「艾尔沃斯的归人」·普通 后解锁"
  },
  [57710] = {
    ID = 57710,
    CnID = "功能@本源希洛支线关卡癫狂",
    BaseSortID = 183,
    Feature = "LargeSubplotCrazy",
    Key = 56447,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_57710_LockTip|暂未开放"
  },
  [71851] = {
    ID = 71851,
    CnID = "功能@图鲁支线关卡普通",
    BaseSortID = 184,
    Feature = "SmallSubplot",
    Key = 71850,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_71851_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [51759] = {
    ID = 51759,
    CnID = "功能@弥利亚姆支线关卡普通",
    BaseSortID = 185,
    Feature = "SpecialSubplot",
    Key = 51755,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_51759_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [74241] = {
    ID = 74241,
    CnID = "功能@莉兹支线关卡普通",
    BaseSortID = 186,
    Feature = "SmallSubplot",
    Key = 74237,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_74241_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [74239] = {
    ID = 74239,
    CnID = "功能@莉兹支线关卡困难",
    BaseSortID = 187,
    Feature = "SmallSubplotHard",
    Key = 74236,
    UnlockCondition = {1, 74232},
    LockTip = "FeatureUnlock_74239_LockTip|完成 「热情归尘」·普通 后解锁"
  },
  [74240] = {
    ID = 74240,
    CnID = "功能@莉兹支线关卡癫狂",
    BaseSortID = 188,
    Feature = "SmallSubplotCrazy",
    Key = 74238,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_74240_LockTip|暂未开放"
  },
  [74341] = {
    ID = 74341,
    CnID = "功能@逆转回合活动支线",
    BaseSortID = 189,
    Feature = "SpecialSubplot",
    Key = 74338,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_74341_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [84356] = {
    ID = 84356,
    CnID = "功能@克珀珊特支线关卡普通",
    BaseSortID = 190,
    Feature = "SmallSubplot",
    Key = 81262,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_84356_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [88941] = {
    ID = 88941,
    CnID = "功能@卡斯托尔支线关卡普通",
    BaseSortID = 191,
    Feature = "SpecialSubplot",
    Key = 88934,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_88941_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [91238] = {
    ID = 91238,
    CnID = "功能@罗马支线关卡普通",
    BaseSortID = 192,
    Feature = "SpecialSubplot",
    Key = 91021,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_91238_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [94857] = {
    ID = 94857,
    CnID = "功能@夏日活动上支线关卡普通",
    BaseSortID = 193,
    Feature = "SpecialSubplot",
    Key = 94850,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_94857_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [97929] = {
    ID = 97929,
    CnID = "功能@夏日活动上支线关卡困难",
    BaseSortID = 194,
    Feature = "SpecialSubplot",
    Key = 97849,
    UnlockCondition = {1, 94837},
    LockTip = "FeatureUnlock_97929_LockTip|<Posse:完成 「再见永无乡」·普通 后解锁>"
  },
  [97144] = {
    ID = 97144,
    CnID = "功能@凯蒂古拉支线关卡普通",
    BaseSortID = 195,
    Feature = "SmallSubplot",
    Key = 95184,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_97144_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [97143] = {
    ID = 97143,
    CnID = "功能@皮克曼支线关卡普通",
    BaseSortID = 196,
    Feature = "SmallSubplot",
    Key = 96834,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_97143_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [116599] = {
    ID = 116599,
    CnID = "功能@波吕克斯支线关卡普通",
    BaseSortID = 197,
    Feature = "SpecialSubplot",
    Key = 99734,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_116599_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [125344] = {
    ID = 125344,
    CnID = "功能@徐支线关卡普通",
    BaseSortID = 198,
    Feature = "SmallSubplot",
    Key = 125338,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_125344_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [97894] = {
    ID = 97894,
    CnID = "功能@夏日活动下支线关卡普通",
    BaseSortID = 199,
    Feature = "SpecialSubplot",
    Key = 97852,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_97894_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [116229] = {
    ID = 116229,
    CnID = "功能@夏日活动下支线关卡困难",
    BaseSortID = 200,
    Feature = "SpecialSubplot",
    Key = 116228,
    UnlockCondition = {1, 97906},
    LockTip = "FeatureUnlock_116229_LockTip|<Posse:完成 「再见，永无乡」·普通 后解锁>"
  },
  [120990] = {
    ID = 120990,
    CnID = "功能@2周年支线关卡普通",
    BaseSortID = 201,
    Feature = "LargeSubplot",
    Key = 120952,
    UnlockCondition = {1, 118146},
    LockTip = "FeatureUnlock_120990_LockTip|<Posse:完成 「调查行动」星辰篇第4章·普通 后解锁>"
  },
  [120991] = {
    ID = 120991,
    CnID = "功能@2周年支线关卡困难",
    BaseSortID = 202,
    Feature = "LargeSubplotHard",
    Key = 120951,
    UnlockCondition = {1, 120976},
    LockTip = "FeatureUnlock_120991_LockTip|<Posse:完成 「群星咏叹调」·普通 后解锁>"
  },
  [120989] = {
    ID = 120989,
    CnID = "功能@2周年支线关卡癫狂",
    BaseSortID = 203,
    Feature = "LargeSubplotCrazy",
    Key = 120953,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_120989_LockTip|暂未开放"
  },
  [122564] = {
    ID = 122564,
    CnID = "功能@茉夏支线普通",
    BaseSortID = 204,
    Feature = "SpecialSubplot",
    Key = 122187,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_122564_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [123278] = {
    ID = 123278,
    CnID = "功能@茉夏支线困难",
    BaseSortID = 205,
    Feature = "SpecialSubplot",
    Key = 123115,
    UnlockCondition = {1, 122154},
    LockTip = "FeatureUnlock_123278_LockTip|完成 「银与血的洗礼」·普通 后解锁"
  },
  [123279] = {
    ID = 123279,
    CnID = "功能@茉夏支线癫狂",
    BaseSortID = 206,
    Feature = "SpecialSubplot",
    Key = 123114,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_123279_LockTip|暂未开放"
  },
  [129507] = {
    ID = 129507,
    CnID = "功能@26年春节支线关卡普通",
    BaseSortID = 207,
    Feature = "LargeSubplot",
    Key = 129506,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_129507_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [130899] = {
    ID = 130899,
    CnID = "功能@莫丝支线普通",
    BaseSortID = 208,
    Feature = "SmallSubplot",
    Key = 130895,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_130899_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [130172] = {
    ID = 130172,
    CnID = "功能@沙耶支线普通",
    BaseSortID = 209,
    Feature = "SpecialSubplot",
    Key = 130167,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_130172_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [140304] = {
    ID = 140304,
    CnID = "功能@沙耶支线困难",
    BaseSortID = 210,
    Feature = "SpecialSubplot",
    Key = 140302,
    UnlockCondition = {1, 140299},
    LockTip = "FeatureUnlock_140304_LockTip|完成 「被遗忘的爱之种」·普通 后解锁"
  },
  [140305] = {
    ID = 140305,
    CnID = "功能@沙耶支线癫狂",
    BaseSortID = 211,
    Feature = "SpecialSubplot",
    Key = 140303,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_140305_LockTip|暂未开放"
  },
  [141301] = {
    ID = 141301,
    CnID = "功能@庞托斯支线普通",
    BaseSortID = 212,
    Feature = "SmallSubplot",
    Key = 141292,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_141301_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [143319] = {
    ID = 143319,
    CnID = "功能@庞托斯支线困难",
    BaseSortID = 213,
    Feature = "SmallSubplotHard",
    Key = 143317,
    UnlockCondition = {1, 141251},
    LockTip = "FeatureUnlock_143319_LockTip|完成 「永远的厄波扬斯」·普通 后解锁"
  },
  [143318] = {
    ID = 143318,
    CnID = "功能@庞托斯支线癫狂",
    BaseSortID = 214,
    Feature = "SmallSubplotCrazy",
    Key = 143316,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_143318_LockTip|暂未开放"
  },
  [145362] = {
    ID = 145362,
    CnID = "功能@蚀灭·萝坦普通",
    BaseSortID = 215,
    Feature = "SmallSubplot",
    Key = 145356,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_145362_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [147085] = {
    ID = 147085,
    CnID = "功能@本源奥吉尔支线关卡普通",
    BaseSortID = 216,
    Feature = "SmallSubplot",
    Key = 146787,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_147085_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [147083] = {
    ID = 147083,
    CnID = "功能@本源奥吉尔支线关卡困难",
    BaseSortID = 217,
    Feature = "SmallSubplotHard",
    Key = 146795,
    UnlockCondition = {1, 146931},
    LockTip = "FeatureUnlock_147083_LockTip|完成 「五日谈」·普通 后解锁"
  },
  [147084] = {
    ID = 147084,
    CnID = "功能@本源奥吉尔支线关卡癫狂",
    BaseSortID = 218,
    Feature = "SmallSubplotCrazy",
    Key = 146792,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_147084_LockTip|暂未开放"
  },
  [147392] = {
    ID = 147392,
    CnID = "功能@暮星·汀克特支线普通",
    BaseSortID = 219,
    Feature = "SmallSubplot",
    Key = 147368,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_147392_LockTip|<Posse:完成 「调查行动」1-2·普通 后解锁>"
  },
  [147394] = {
    ID = 147394,
    CnID = "功能@暮星·汀克特支线困难",
    BaseSortID = 220,
    Feature = "SmallSubplotHard",
    Key = 147363,
    UnlockCondition = {1, 147311},
    LockTip = "FeatureUnlock_147394_LockTip|完成 「临时文本」·普通 后解锁"
  },
  [147393] = {
    ID = 147393,
    CnID = "功能@暮星·汀克特支线癫狂",
    BaseSortID = 221,
    Feature = "SmallSubplotCrazy",
    Key = 147371,
    UnlockCondition = {2, 120},
    LockTip = "FeatureUnlock_147393_LockTip|暂未开放"
  },
  [16966] = {
    ID = 16966,
    CnID = "功能@教程",
    BaseSortID = 222,
    Feature = "Tutorial",
    FeatureName = "FeatureUnlock_16966_FeatureName|教程",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_16966_LockTip|通关 序章 解锁"
  },
  [16995] = {
    ID = 16995,
    CnID = "功能@主角技能",
    BaseSortID = 223,
    Feature = "KeeperSkill",
    FeatureEntranceType = 1
  },
  [17048] = {
    ID = 17048,
    CnID = "功能@礼包商店",
    BaseSortID = 224,
    Feature = "Shop",
    Key = 18656,
    FeatureName = "FeatureUnlock_17048_FeatureName|礼包商店",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_17048_LockTip|通关 序章 后解锁"
  },
  [17002] = {
    ID = 17002,
    CnID = "功能@金币商店",
    BaseSortID = 225,
    Feature = "Shop",
    Key = 18659,
    FeatureName = "FeatureUnlock_17002_FeatureName|金券兑换",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_17002_LockTip|完成 「调查行动」1-2·普通 后解锁"
  },
  [17023] = {
    ID = 17023,
    CnID = "功能@银芯购买商店",
    BaseSortID = 226,
    Feature = "Shop",
    Key = 18652,
    FeatureName = "FeatureUnlock_17023_FeatureName|银芯购买",
    FeatureEntranceType = 1,
    LockTip = "FeatureUnlock_17023_LockTip|通关 序章 解锁"
  },
  [16980] = {
    ID = 16980,
    CnID = "功能@饰品强化",
    BaseSortID = 227,
    Feature = "TrinketLevelUp",
    FeatureName = "FeatureUnlock_16980_FeatureName|密契升级",
    UnlockCondition = {2, 35},
    UnlockDesc = "FeatureUnlock_16980_UnlockDesc|<FeatureUnlockTitle:密契升级功能已开启>\n\n<FeatureUnlockDesc:密契从不以真实面貌示人，你需要耐心等待它成型的那一天。\n守密人可在密契强化界面升级密契，从而提升密契主属性。>",
    LockTip = "FeatureUnlock_16980_LockTip|调查等级 35 级 解锁",
    Parameter = "20181"
  },
  [17043] = {
    ID = 17043,
    CnID = "功能@密契转录",
    BaseSortID = 228,
    Feature = "TrinketConversion",
    FeatureName = "FeatureUnlock_17043_FeatureName|密契转录",
    FeatureEntranceType = 1,
    UnlockCondition = {2, 45},
    UnlockDesc = "FeatureUnlock_17043_UnlockDesc|<FeatureUnlockTitle:密契转录功能已开启>\n\n<FeatureUnlockDesc:中世纪的抄写员曾因转录密契被处以极刑，所幸你现在身处一个文明时代。\n守密人可在密契强化时选择转录更改副属性的种类和数值。\n转录对密契主属性的种类和数值没有影响。>",
    LockTip = "FeatureUnlock_17043_LockTip|调查等级 45 级 解锁",
    Parameter = "20182"
  },
  [148487] = {
    ID = 148487,
    CnID = "功能@密契自动转录",
    BaseSortID = 229,
    Feature = "TrinketAutoRefine",
    FeatureName = "FeatureUnlock_148487_FeatureName|密契自动转录",
    FeatureEntranceType = 1,
    UnlockCondition = {2, 45},
    LockTip = "FeatureUnlock_148487_LockTip|调查等级 45 级 解锁"
  },
  [17036] = {
    ID = 17036,
    CnID = "功能@福利",
    BaseSortID = 230,
    Feature = "Activity",
    FeatureName = "FeatureUnlock_17036_FeatureName|活动",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8126},
    UnlockDesc = "FeatureUnlock_17036_UnlockDesc|<FeatureUnlockTitle:活动已开启>\n\n守密人可在此领取参与福利活动和玩法活动，完成任务领取丰厚奖励！",
    LockTip = "FeatureUnlock_17036_LockTip|完成 「调查行动」1-2·普通 后解锁",
    Parameter = "20191"
  },
  [17018] = {
    ID = 17018,
    CnID = "功能@PVP启灵",
    BaseSortID = 231,
    Feature = "PVPPotency",
    FeatureName = "FeatureUnlock_17018_FeatureName|启灵",
    FeatureEntranceType = 1
  },
  [17054] = {
    ID = 17054,
    CnID = "功能@PVP系统",
    BaseSortID = 232,
    Feature = "PVP",
    FeatureName = "FeatureUnlock_17054_FeatureName|相位对弈",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8111},
    UnlockDesc = "FeatureUnlock_17054_UnlockDesc|<FeatureUnlockTitle:相位对弈现已开启>\n\n<FeatureUnlockDesc:当不同的银芯相位之间开始交互、纠缠，它们将决出唯一的胜者。\n该模式为游戏附赠玩法，为了追求更有趣平衡的游戏环境，每个赛季卡牌和整体玩法都可能发生大幅变化。请谨慎为该模式投入资源。>",
    LockTip = "FeatureUnlock_17054_LockTip|完成 「调查行动」3-2·普通 后解锁",
    Parameter = "20173",
    StoryId = 46539
  },
  [17053] = {
    ID = 17053,
    CnID = "功能@PVP商店",
    BaseSortID = 233,
    Feature = "Shop",
    Key = 18653,
    FeatureName = "FeatureUnlock_17053_FeatureName|相位兑换",
    UnlockCondition = {1, 8111},
    LockTip = "FeatureUnlock_17053_LockTip|完成 「调查行动」3-2·普通 后解锁"
  },
  [17027] = {
    ID = 17027,
    CnID = "功能@唤醒体技能等级2",
    BaseSortID = 234,
    Feature = "AwakerSkillLevel",
    Key = 2,
    UnlockCondition = {2, 25},
    LockTip = "FeatureUnlock_17027_LockTip|调查等级 25 级 解锁"
  },
  [17026] = {
    ID = 17026,
    CnID = "功能@唤醒体技能等级3",
    BaseSortID = 235,
    Feature = "AwakerSkillLevel",
    Key = 3,
    UnlockCondition = {2, 35},
    LockTip = "FeatureUnlock_17026_LockTip|调查等级 35 级 解锁"
  },
  [17030] = {
    ID = 17030,
    CnID = "功能@唤醒体技能等级4",
    BaseSortID = 236,
    Feature = "AwakerSkillLevel",
    Key = 4,
    UnlockCondition = {2, 35},
    LockTip = "FeatureUnlock_17030_LockTip|调查等级 35 级 解锁"
  },
  [17029] = {
    ID = 17029,
    CnID = "功能@唤醒体技能等级5",
    BaseSortID = 237,
    Feature = "AwakerSkillLevel",
    Key = 5,
    UnlockCondition = {2, 45},
    LockTip = "FeatureUnlock_17029_LockTip|调查等级 45 级 解锁"
  },
  [17028] = {
    ID = 17028,
    CnID = "功能@唤醒体技能等级6",
    BaseSortID = 238,
    Feature = "AwakerSkillLevel",
    Key = 6,
    UnlockCondition = {2, 45},
    LockTip = "FeatureUnlock_17028_LockTip|调查等级 45 级 解锁"
  },
  [16956] = {
    ID = 16956,
    CnID = "功能@主命轮槽位",
    BaseSortID = 239,
    Feature = "MainWeapon",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_16956_LockTip|通关 序章 后解锁"
  },
  [17074] = {
    ID = 17074,
    CnID = "功能@副命轮槽位",
    BaseSortID = 240,
    Feature = "SecondaryWeapon",
    FeatureName = "FeatureUnlock_17074_FeatureName|第二命轮",
    FeatureEntranceType = 1,
    UnlockCondition = {2, 15},
    UnlockDesc = "FeatureUnlock_17074_UnlockDesc|<FeatureUnlockTitle:第二命轮已开启>\n\n<FeatureUnlockDesc:守密人可在命轮界面为唤醒体装备第二个命轮。一个唤醒体最多只可装备1个SSR级命轮。\n合理地搭配组合可以极大地提升唤醒体能力。>",
    LockTip = "FeatureUnlock_17074_LockTip|调查等级 15 级 后，可装备第二个命轮",
    Parameter = "20178"
  },
  [20785] = {
    ID = 20785,
    CnID = "功能@主线代币商店",
    BaseSortID = 241,
    Feature = "Shop",
    Key = 20592,
    FeatureName = "FeatureUnlock_20785_FeatureName|调查兑换",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_20785_LockTip|完成 「调查行动」1-2 ·普通 后解锁"
  },
  [20786] = {
    ID = 20786,
    CnID = "功能@界域塔代币商店",
    BaseSortID = 242,
    Feature = "Shop",
    Key = 20591,
    FeatureName = "FeatureUnlock_20786_FeatureName|无光兑换",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7990},
    LockTip = "FeatureUnlock_20786_LockTip|完成 「调查行动」2-4 ·普通 后解锁"
  },
  [21402] = {
    ID = 21402,
    CnID = "功能@每日任务",
    BaseSortID = 243,
    Feature = "DailyTask",
    FeatureName = "FeatureUnlock_21402_FeatureName|常训任务",
    FeatureEntranceType = 1
  },
  [25256] = {
    ID = 25256,
    CnID = "功能@融蚀深渊",
    BaseSortID = 244,
    Feature = "AbyssChallenge",
    FeatureName = "FeatureUnlock_25256_FeatureName|融灾禁区",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8025},
    UnlockDesc = "FeatureUnlock_25256_UnlockDesc|<FeatureUnlockTitle:融灾禁区已开启>\n\n<FeatureUnlockDesc:深入融灾爆发区域，解除黑潮危机警报。\n守密人可派出多个队伍进行挑战，获取原初灵核、银芯和黑色贡物等丰厚奖励。>",
    LockTip = "FeatureUnlock_25256_LockTip|完成 「调查行动」4-3 ·普通 后解锁",
    Parameter = "20176",
    StoryId = 47232
  },
  [49418] = {
    ID = 49418,
    CnID = "功能@通用任务类型",
    BaseSortID = 245,
    Feature = "Task",
    Key = 16,
    FeatureName = "FeatureUnlock_49418_FeatureName|通用任务类型",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_49418_LockTip|通关 序章 后解锁"
  },
  [49205] = {
    ID = 49205,
    CnID = "功能@常驻试玩",
    BaseSortID = 246,
    Feature = "ResidentTrial",
    FeatureName = "FeatureUnlock_49205_FeatureName|唤醒体试玩",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_49205_LockTip|通关 序章 后解锁"
  },
  [35576] = {
    ID = 35576,
    CnID = "功能@莉莉活动商店",
    BaseSortID = 247,
    Feature = "Shop",
    Key = 34757,
    FeatureName = "FeatureUnlock_35576_FeatureName|魔法剧情商店",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7684},
    LockTip = "FeatureUnlock_35576_LockTip|完成 「调查行动」1-10 ·普通 后解锁"
  },
  [38850] = {
    ID = 38850,
    CnID = "功能@旺达活动商店",
    BaseSortID = 248,
    Feature = "Shop",
    Key = 38813,
    FeatureName = "FeatureUnlock_38850_FeatureName|旺达的奇珍宝匣",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7684},
    LockTip = "FeatureUnlock_38850_LockTip|完成 「调查行动」1-10 ·普通 后解锁"
  },
  [38851] = {
    ID = 38851,
    CnID = "功能@旺达活动湖中之城",
    BaseSortID = 249,
    Feature = "WandaActivity",
    FeatureName = "FeatureUnlock_38851_FeatureName|湖中之城",
    FeatureEntranceType = 1
  },
  [44550] = {
    ID = 44550,
    CnID = "功能@萨尔瓦多活动",
    BaseSortID = 250,
    Feature = "SalvadorActivity",
    FeatureName = "FeatureUnlock_44550_FeatureName|萨尔瓦多",
    FeatureEntranceType = 1
  },
  [44702] = {
    ID = 44702,
    CnID = "功能@圣堂区域1",
    BaseSortID = 251,
    Feature = "SalvadorActivity",
    Key = 44278,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 44554},
    LockTip = "FeatureUnlock_44702_LockTip|在「特遣纪录：血的颜色」中完成「血腥的符号」后解锁"
  },
  [44700] = {
    ID = 44700,
    CnID = "功能@圣堂区域2",
    BaseSortID = 252,
    Feature = "SalvadorActivity",
    Key = 44277,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 44556},
    LockTip = "FeatureUnlock_44700_LockTip|在「特遣纪录：血的颜色」中完成「为嫉妒杀戮」后解锁"
  },
  [44701] = {
    ID = 44701,
    CnID = "功能@圣堂区域3",
    BaseSortID = 253,
    Feature = "SalvadorActivity",
    Key = 44276,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 44558},
    LockTip = "FeatureUnlock_44701_LockTip|在「特遣纪录：血的颜色」中完成「把饥肠填满」后解锁"
  },
  [44703] = {
    ID = 44703,
    CnID = "功能@圣堂区域4",
    BaseSortID = 254,
    Feature = "SalvadorActivity",
    Key = 44275,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 44559},
    LockTip = "FeatureUnlock_44703_LockTip|在「特遣纪录：血的颜色」中完成「将罪恶净化」后解锁"
  },
  [44704] = {
    ID = 44704,
    CnID = "功能@圣堂区域5",
    BaseSortID = 255,
    Feature = "SalvadorActivity",
    Key = 44274,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 44552},
    LockTip = "FeatureUnlock_44704_LockTip|在「特遣纪录：血的颜色」中完成「燃起白色的希望」后解锁"
  },
  [47456] = {
    ID = 47456,
    CnID = "功能@多重疗愈活动",
    BaseSortID = 256,
    Feature = "A24Activity",
    FeatureName = "FeatureUnlock_47456_FeatureName|多重疗愈",
    FeatureEntranceType = 1,
    StoryId = 47977
  },
  [47461] = {
    ID = 47461,
    CnID = "功能@记忆编码1",
    BaseSortID = 257,
    Feature = "A24Activity",
    Key = 46612,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 46178},
    LockTip = "FeatureUnlock_47461_LockTip|在「特遣纪录：宁静的裂殖」中完成「影子童话」后解锁"
  },
  [47460] = {
    ID = 47460,
    CnID = "功能@记忆编码2",
    BaseSortID = 258,
    Feature = "A24Activity",
    Key = 46610,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 46180},
    LockTip = "FeatureUnlock_47460_LockTip|在「特遣纪录：宁静的裂殖」中完成「失眠蛇」后解锁"
  },
  [47459] = {
    ID = 47459,
    CnID = "功能@记忆编码3",
    BaseSortID = 259,
    Feature = "A24Activity",
    Key = 46611,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 46182},
    LockTip = "FeatureUnlock_47459_LockTip|在「特遣纪录：宁静的裂殖」中完成「金色赋格」后解锁"
  },
  [47458] = {
    ID = 47458,
    CnID = "功能@记忆编码4",
    BaseSortID = 260,
    Feature = "A24Activity",
    Key = 46613,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 46174},
    LockTip = "FeatureUnlock_47458_LockTip|在「特遣纪录：宁静的裂殖」中完成「止于此」后解锁"
  },
  [47457] = {
    ID = 47457,
    CnID = "功能@记忆编码5",
    BaseSortID = 261,
    Feature = "A24Activity",
    Key = 46614,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 46172},
    LockTip = "FeatureUnlock_47457_LockTip|在「特遣纪录：宁静的裂殖」中完成「源」后解锁"
  },
  [50092] = {
    ID = 50092,
    CnID = "功能@欲海翻波活动",
    BaseSortID = 262,
    Feature = "ThaisActivity",
    FeatureName = "FeatureUnlock_50092_FeatureName|欲海翻波",
    FeatureEntranceType = 1
  },
  [17012] = {
    ID = 17012,
    CnID = "功能@图鉴",
    BaseSortID = 263,
    Feature = "CollectionHall",
    FeatureName = "FeatureUnlock_17012_FeatureName|秘典书库",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_17012_LockTip|通关 序章 后解锁"
  },
  [49303] = {
    ID = 49303,
    CnID = "功能@图鉴_世界观",
    BaseSortID = 264,
    Feature = "CollectionStory",
    FeatureName = "FeatureUnlock_49303_FeatureName|洪积世界",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_49303_LockTip|尚未有相关收藏"
  },
  [49309] = {
    ID = 49309,
    CnID = "功能@图鉴_世界观_编年史",
    BaseSortID = 265,
    Feature = "CollectionStory",
    Key = 1,
    FeatureName = "FeatureUnlock_49309_FeatureName|编年史",
    FeatureEntranceType = 1,
    UnlockCondition = {5, 49309},
    LockTip = "FeatureUnlock_49309_LockTip|尚未有相关收藏"
  },
  [49307] = {
    ID = 49307,
    CnID = "功能@图鉴_世界观_组织势力",
    BaseSortID = 266,
    Feature = "CollectionStory",
    Key = 2,
    FeatureName = "FeatureUnlock_49307_FeatureName|组织势力",
    FeatureEntranceType = 1,
    UnlockCondition = {5, 49307},
    LockTip = "FeatureUnlock_49307_LockTip|尚未有相关收藏"
  },
  [49306] = {
    ID = 49306,
    CnID = "功能@图鉴_世界观_综合名词",
    BaseSortID = 267,
    Feature = "CollectionStory",
    Key = 3,
    FeatureName = "FeatureUnlock_49306_FeatureName|洪积禁典",
    FeatureEntranceType = 1,
    UnlockCondition = {5, 49306},
    LockTip = "FeatureUnlock_49306_LockTip|尚未有相关收藏"
  },
  [49302] = {
    ID = 49302,
    CnID = "功能@图鉴_影像",
    BaseSortID = 268,
    Feature = "CollectionPicture",
    FeatureName = "FeatureUnlock_49302_FeatureName|影像",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_49302_LockTip|尚未有相关收藏"
  },
  [49300] = {
    ID = 49300,
    CnID = "功能@图鉴_影像_主线CG",
    BaseSortID = 269,
    Feature = "CollectionPicture",
    Key = 1,
    FeatureName = "FeatureUnlock_49300_FeatureName|剧情CG",
    FeatureEntranceType = 1,
    UnlockCondition = {5, 49300},
    LockTip = "FeatureUnlock_49300_LockTip|尚未有相关收藏"
  },
  [49308] = {
    ID = 49308,
    CnID = "功能@图鉴_影像_场景CG",
    BaseSortID = 270,
    Feature = "CollectionPicture",
    Key = 2,
    FeatureName = "FeatureUnlock_49308_FeatureName|场景CG",
    FeatureEntranceType = 1,
    UnlockCondition = {5, 49308},
    LockTip = "FeatureUnlock_49308_LockTip|尚未有相关收藏"
  },
  [49311] = {
    ID = 49311,
    CnID = "功能@图鉴_影像_PV",
    BaseSortID = 271,
    Feature = "CollectionPicture",
    Key = 3,
    FeatureName = "FeatureUnlock_49311_FeatureName|PV",
    FeatureEntranceType = 1,
    UnlockCondition = {5, 49311},
    LockTip = "FeatureUnlock_49311_LockTip|尚未有相关收藏"
  },
  [70556] = {
    ID = 70556,
    CnID = "功能@图鉴_影像_活动",
    BaseSortID = 272,
    Feature = "CollectionPicture",
    Key = 4,
    FeatureName = "FeatureUnlock_70556_FeatureName|活动",
    FeatureEntranceType = 1,
    UnlockCondition = {5, 70556},
    LockTip = "FeatureUnlock_70556_LockTip|尚未有相关收藏"
  },
  [75909] = {
    ID = 75909,
    CnID = "功能@图鉴_影像_广播剧",
    BaseSortID = 273,
    Feature = "CollectionPicture",
    Key = 5,
    FeatureName = "FeatureUnlock_75909_FeatureName|广播剧",
    FeatureEntranceType = 1,
    UnlockCondition = {5, 75909},
    LockTip = "FeatureUnlock_75909_LockTip|尚未有相关收藏"
  },
  [49301] = {
    ID = 49301,
    CnID = "功能@图鉴_音乐",
    BaseSortID = 274,
    Feature = "CollectionOST",
    FeatureName = "FeatureUnlock_49301_FeatureName|留声机",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_49301_LockTip|尚未有相关收藏"
  },
  [49304] = {
    ID = 49304,
    CnID = "功能@图鉴_角色",
    BaseSortID = 275,
    Feature = "CollectionCharacter",
    FeatureName = "FeatureUnlock_49304_FeatureName|角色",
    FeatureEntranceType = 1,
    LockTip = "FeatureUnlock_49304_LockTip|尚未有相关收藏"
  },
  [49298] = {
    ID = 49298,
    CnID = "功能@图鉴_事件",
    BaseSortID = 276,
    Feature = "CollectionEvent",
    FeatureName = "FeatureUnlock_49298_FeatureName|事件",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_49298_LockTip|尚未有相关收藏"
  },
  [49310] = {
    ID = 49310,
    CnID = "功能@图鉴_造物",
    BaseSortID = 277,
    Feature = "CollectionRelic",
    FeatureName = "FeatureUnlock_49310_FeatureName|造物",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_49310_LockTip|尚未有相关收藏"
  },
  [49296] = {
    ID = 49296,
    CnID = "功能@图鉴_命轮",
    BaseSortID = 278,
    Feature = "CollectionWeapon",
    FeatureName = "FeatureUnlock_49296_FeatureName|命轮",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_49296_LockTip|尚未有相关收藏"
  },
  [49305] = {
    ID = 49305,
    CnID = "功能@图鉴_密契",
    BaseSortID = 279,
    Feature = "CollectionTrinket",
    FeatureName = "FeatureUnlock_49305_FeatureName|密契",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_49305_LockTip|尚未有相关收藏"
  },
  [49567] = {
    ID = 49567,
    CnID = "功能@繁衍狂热",
    BaseSortID = 280,
    Feature = "ConfessionEvent",
    FeatureName = "FeatureUnlock_49567_FeatureName|繁衍狂热",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 48062},
    UnlockDesc = "FeatureUnlock_49567_UnlockDesc|<FeatureUnlockTitle:繁衍狂热已开启>\n\n<FeatureUnlockDesc:受神秘力量影响，唤醒体们陷入了「繁衍狂热」状态……请各位守密人小心！>",
    LockTip = "FeatureUnlock_49567_LockTip|完成 「调查行动」7-3·普通 后解锁",
    Parameter = "20177",
    StoryId = 49871
  },
  [60580] = {
    ID = 60580,
    CnID = "功能@新银芯通信",
    BaseSortID = 281,
    Feature = "Communicator",
    FeatureName = "FeatureUnlock_60580_FeatureName|银芯通信",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7986},
    UnlockDesc = "FeatureUnlock_60580_UnlockDesc|<FeatureUnlockTitle:银芯通信已开启>\n\n<FeatureUnlockDesc:盟友、战友、挚友，摇一摇神奇的盒子联系他们吧。>",
    LockTip = "FeatureUnlock_60580_LockTip|完成 「调查行动」2-1·普通 后解锁",
    Parameter = "20194"
  },
  [51255] = {
    ID = 51255,
    CnID = "功能@故事的魔法复刻活动",
    BaseSortID = 282,
    Feature = "MagicStoryActivityReproduce",
    FeatureName = "FeatureUnlock_51255_FeatureName|故事的魔法·轻量复刻",
    FeatureEntranceType = 1
  },
  [51256] = {
    ID = 51256,
    CnID = "功能@剧本迷思复刻1",
    BaseSortID = 283,
    Feature = "MagicStoryActivityReproduce",
    Key = 51132,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 23638},
    LockTip = "FeatureUnlock_51256_LockTip|在「特遣纪录：故事的魔法」中完成「安迪·约翰逊之力」后解锁"
  },
  [51258] = {
    ID = 51258,
    CnID = "功能@剧本迷思复刻2",
    BaseSortID = 284,
    Feature = "MagicStoryActivityReproduce",
    Key = 51133,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 23639},
    LockTip = "FeatureUnlock_51258_LockTip|在「特遣纪录：故事的魔法」中完成「商人的慷慨」后解锁"
  },
  [51257] = {
    ID = 51257,
    CnID = "功能@剧本迷思复刻3",
    BaseSortID = 285,
    Feature = "MagicStoryActivityReproduce",
    Key = 51134,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 23640},
    LockTip = "FeatureUnlock_51257_LockTip|在「特遣纪录：故事的魔法」中完成「寻找故事」后解锁"
  },
  [51260] = {
    ID = 51260,
    CnID = "功能@剧本迷思复刻4",
    BaseSortID = 286,
    Feature = "MagicStoryActivityReproduce",
    Key = 51128,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 23641},
    LockTip = "FeatureUnlock_51260_LockTip|在「特遣纪录：故事的魔法」中完成「最好的花」后解锁"
  },
  [51259] = {
    ID = 51259,
    CnID = "功能@剧本迷思复刻5",
    BaseSortID = 287,
    Feature = "MagicStoryActivityReproduce",
    Key = 51129,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 23642},
    LockTip = "FeatureUnlock_51259_LockTip|在「特遣纪录：故事的魔法」中完成「最怀念的人」后解锁"
  },
  [51262] = {
    ID = 51262,
    CnID = "功能@剧本迷思复刻6",
    BaseSortID = 288,
    Feature = "MagicStoryActivityReproduce",
    Key = 51130,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 23643},
    LockTip = "FeatureUnlock_51262_LockTip|在「特遣纪录：故事的魔法」中完成「最盛大的幻景」后解锁"
  },
  [51261] = {
    ID = 51261,
    CnID = "功能@剧本迷思复刻7",
    BaseSortID = 289,
    Feature = "MagicStoryActivityReproduce",
    Key = 51131,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 23644},
    LockTip = "FeatureUnlock_51261_LockTip|在「特遣纪录：故事的魔法」中完成「最圆满的结局」后解锁"
  },
  [51264] = {
    ID = 51264,
    CnID = "功能@剧本迷思复刻8",
    BaseSortID = 290,
    Feature = "MagicStoryActivityReproduce",
    Key = 51135,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 23644},
    LockTip = "FeatureUnlock_51264_LockTip|在「特遣纪录：故事的魔法」中完成「最圆满的结局」后解锁"
  },
  [51263] = {
    ID = 51263,
    CnID = "功能@剧本迷思复刻9",
    BaseSortID = 291,
    Feature = "MagicStoryActivityReproduce",
    Key = 51136,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 23644},
    LockTip = "FeatureUnlock_51263_LockTip|在「特遣纪录：故事的魔法」中完成「最圆满的结局」后解锁"
  },
  [129645] = {
    ID = 129645,
    CnID = "功能@疾驰的欢愉专列玩法关卡组",
    BaseSortID = 292,
    Feature = "PermanentActivitiesStageGroup",
    Key = 129175,
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_129645_LockTip|完成 「调查行动」1-2·普通 后解锁"
  },
  [54118] = {
    ID = 54118,
    CnID = "功能@索蕾尔活动",
    BaseSortID = 293,
    Feature = "SorelActivity",
    FeatureName = "FeatureUnlock_54118_FeatureName|与蔷薇书",
    FeatureEntranceType = 1
  },
  [55456] = {
    ID = 55456,
    CnID = "功能@奥尔拉活动",
    BaseSortID = 294,
    Feature = "HorlaActivity",
    FeatureName = "FeatureUnlock_55456_FeatureName|趁花园凋零以前",
    FeatureEntranceType = 1
  },
  [58025] = {
    ID = 58025,
    CnID = "功能@墨菲活动",
    BaseSortID = 295,
    Feature = "MurphyActivity",
    FeatureName = "FeatureUnlock_58025_FeatureName|墨菲活动",
    FeatureEntranceType = 1
  },
  [58032] = {
    ID = 58032,
    CnID = "功能@莱克活动",
    BaseSortID = 296,
    Feature = "RykerActivity",
    FeatureName = "FeatureUnlock_58032_FeatureName|莱克活动",
    FeatureEntranceType = 1
  },
  [58027] = {
    ID = 58027,
    CnID = "功能@萨尔瓦多复刻活动",
    BaseSortID = 297,
    Feature = "SalvadorActivityReproduce",
    FeatureName = "FeatureUnlock_58027_FeatureName|萨尔瓦多复刻活动",
    FeatureEntranceType = 1
  },
  [58031] = {
    ID = 58031,
    CnID = "功能@哈姆林活动",
    BaseSortID = 298,
    Feature = "HamelnActivity",
    FeatureName = "FeatureUnlock_58031_FeatureName|哈姆林活动",
    FeatureEntranceType = 1
  },
  [58034] = {
    ID = 58034,
    CnID = "功能@24复刻活动",
    BaseSortID = 299,
    Feature = "A24ActivityReproduce",
    FeatureName = "FeatureUnlock_58034_FeatureName|24复刻活动",
    FeatureEntranceType = 1
  },
  [58029] = {
    ID = 58029,
    CnID = "功能@本源希洛活动",
    BaseSortID = 300,
    Feature = "OriginHelotActivity",
    FeatureName = "FeatureUnlock_58029_FeatureName|本源希洛活动",
    FeatureEntranceType = 1
  },
  [58033] = {
    ID = 58033,
    CnID = "功能@旺达复刻活动",
    BaseSortID = 301,
    Feature = "WandaActivityReproduce",
    FeatureName = "FeatureUnlock_58033_FeatureName|旺达复刻活动",
    FeatureEntranceType = 1
  },
  [58030] = {
    ID = 58030,
    CnID = "功能@塔薇活动",
    BaseSortID = 302,
    Feature = "TawilActivity",
    FeatureName = "FeatureUnlock_58030_FeatureName|塔薇活动",
    FeatureEntranceType = 1
  },
  [58026] = {
    ID = 58026,
    CnID = "功能@弥利亚姆复刻活动",
    BaseSortID = 303,
    Feature = "MiryamActivityReproduce",
    FeatureName = "FeatureUnlock_58026_FeatureName|弥利亚姆复刻活动",
    FeatureEntranceType = 1
  },
  [58028] = {
    ID = 58028,
    CnID = "功能@本源朵尔活动",
    BaseSortID = 304,
    Feature = "OriginDollActivity",
    FeatureName = "FeatureUnlock_58028_FeatureName|本源朵尔活动",
    FeatureEntranceType = 1
  },
  [68889] = {
    ID = 68889,
    CnID = "功能@图鲁活动",
    BaseSortID = 305,
    Feature = "TuluActivity",
    FeatureName = "FeatureUnlock_68889_FeatureName|图鲁活动",
    FeatureEntranceType = 1
  },
  [68891] = {
    ID = 68891,
    CnID = "功能@达芙黛尔活动",
    BaseSortID = 306,
    Feature = "DaffodilActivity",
    FeatureName = "FeatureUnlock_68891_FeatureName|达芙黛尔活动",
    FeatureEntranceType = 1
  },
  [68887] = {
    ID = 68887,
    CnID = "功能@克莱门汀活动",
    BaseSortID = 307,
    Feature = "ClementineActivity",
    FeatureName = "FeatureUnlock_68887_FeatureName|克莱门汀活动",
    FeatureEntranceType = 1
  },
  [84307] = {
    ID = 84307,
    CnID = "功能@克珀珊特活动",
    BaseSortID = 308,
    Feature = "StElmosFireActivity",
    FeatureName = "FeatureUnlock_84307_FeatureName|克珀珊特活动",
    FeatureEntranceType = 1
  },
  [68892] = {
    ID = 68892,
    CnID = "功能@莫尔迪基安活动",
    BaseSortID = 309,
    Feature = "ModiglianActivity",
    FeatureName = "FeatureUnlock_68892_FeatureName|莫尔迪基安活动",
    FeatureEntranceType = 1
  },
  [68890] = {
    ID = 68890,
    CnID = "功能@本源墨菲活动",
    BaseSortID = 310,
    Feature = "OriginMurphyActivity",
    FeatureName = "FeatureUnlock_68890_FeatureName|本源墨菲活动",
    FeatureEntranceType = 1
  },
  [68894] = {
    ID = 68894,
    CnID = "功能@昂特拉克活动",
    BaseSortID = 311,
    Feature = "AntrakActivity",
    FeatureName = "FeatureUnlock_68894_FeatureName|昂特拉克活动",
    FeatureEntranceType = 1
  },
  [68893] = {
    ID = 68893,
    CnID = "功能@鲁利姆活动",
    BaseSortID = 312,
    Feature = "LulimActivity",
    FeatureName = "FeatureUnlock_68893_FeatureName|鲁利姆活动",
    FeatureEntranceType = 1
  },
  [68888] = {
    ID = 68888,
    CnID = "功能@本源图鲁活动",
    BaseSortID = 313,
    Feature = "OriginTuluActivity",
    FeatureName = "FeatureUnlock_68888_FeatureName|本源图鲁活动",
    FeatureEntranceType = 1
  },
  [73800] = {
    ID = 73800,
    CnID = "功能@墨菲复刻活动",
    BaseSortID = 314,
    Feature = "MurphyActivity",
    FeatureName = "FeatureUnlock_73800_FeatureName|墨菲复刻活动",
    FeatureEntranceType = 1
  },
  [74337] = {
    ID = 74337,
    CnID = "功能@逆转回合活动",
    BaseSortID = 315,
    Feature = "PVPReverseRoundActivity",
    FeatureName = "FeatureUnlock_74337_FeatureName|逆转回合活动",
    FeatureEntranceType = 1
  },
  [74348] = {
    ID = 74348,
    CnID = "功能@萨尔瓦多复刻2活动",
    BaseSortID = 316,
    Feature = "SalvadorActivityReproduce",
    FeatureName = "FeatureUnlock_74348_FeatureName|萨尔瓦多复刻活动",
    FeatureEntranceType = 1
  },
  [78650] = {
    ID = 78650,
    CnID = "功能@24复刻活动2",
    BaseSortID = 317,
    Feature = "A24ActivityReproduce",
    FeatureName = "FeatureUnlock_78650_FeatureName|24复刻活动",
    FeatureEntranceType = 1
  },
  [74362] = {
    ID = 74362,
    CnID = "功能@莱克复刻活动",
    BaseSortID = 318,
    Feature = "RykerActivity",
    FeatureName = "FeatureUnlock_74362_FeatureName|莱克复刻活动",
    FeatureEntranceType = 1
  },
  [78793] = {
    ID = 78793,
    CnID = "功能@本源希洛复刻活动",
    BaseSortID = 319,
    Feature = "OriginHelotActivity",
    FeatureName = "FeatureUnlock_78793_FeatureName|本源希洛活动",
    FeatureEntranceType = 1
  },
  [88942] = {
    ID = 88942,
    CnID = "功能@卡斯托尔活动",
    BaseSortID = 320,
    Feature = "CastorActivity",
    FeatureName = "FeatureUnlock_88942_FeatureName|卡斯托尔活动",
    FeatureEntranceType = 1
  },
  [91239] = {
    ID = 91239,
    CnID = "功能@罗马活动",
    BaseSortID = 321,
    Feature = "RomeActivity",
    FeatureName = "FeatureUnlock_91239_FeatureName|罗马活动",
    FeatureEntranceType = 1
  },
  [95783] = {
    ID = 95783,
    CnID = "功能@杜勒赛因活动",
    BaseSortID = 322,
    Feature = "DoresainActivity",
    FeatureName = "FeatureUnlock_95783_FeatureName|杜勒赛因活动",
    FeatureEntranceType = 1
  },
  [94856] = {
    ID = 94856,
    CnID = "功能@夏日活动上篇",
    BaseSortID = 323,
    Feature = "SummerChapter1Activity",
    FeatureName = "FeatureUnlock_94856_FeatureName|夏日特别活动上篇",
    FeatureEntranceType = 1
  },
  [97145] = {
    ID = 97145,
    CnID = "功能@凯蒂古拉活动",
    BaseSortID = 324,
    Feature = "KathiguRaActivity",
    FeatureName = "FeatureUnlock_97145_FeatureName|凯蒂古拉活动",
    FeatureEntranceType = 1
  },
  [97146] = {
    ID = 97146,
    CnID = "功能@皮克曼活动",
    BaseSortID = 325,
    Feature = "PickManActivity",
    FeatureName = "FeatureUnlock_97146_FeatureName|皮克曼活动",
    FeatureEntranceType = 1
  },
  [116600] = {
    ID = 116600,
    CnID = "功能@波吕克斯活动",
    BaseSortID = 326,
    Feature = "PolluxActivity",
    FeatureName = "FeatureUnlock_116600_FeatureName|波吕克斯活动",
    FeatureEntranceType = 1
  },
  [97895] = {
    ID = 97895,
    CnID = "功能@夏日活动下篇",
    BaseSortID = 327,
    Feature = "SummerChapter2Activity",
    FeatureName = "FeatureUnlock_97895_FeatureName|夏日特别活动下篇",
    FeatureEntranceType = 1
  },
  [97671] = {
    ID = 97671,
    CnID = "功能@本源深海淑女活动",
    BaseSortID = 328,
    Feature = "OriginMurphyActivity",
    FeatureName = "FeatureUnlock_97671_FeatureName|本源深海淑女活动",
    FeatureEntranceType = 1
  },
  [122563] = {
    ID = 122563,
    CnID = "功能@茉夏活动",
    BaseSortID = 329,
    Feature = "MouchetteActivity",
    FeatureName = "FeatureUnlock_122563_FeatureName|茉夏活动",
    FeatureEntranceType = 1
  },
  [125345] = {
    ID = 125345,
    CnID = "功能@徐活动",
    BaseSortID = 330,
    Feature = "XuActivity",
    FeatureName = "FeatureUnlock_125345_FeatureName|徐活动",
    FeatureEntranceType = 1
  },
  [130900] = {
    ID = 130900,
    CnID = "功能@莫丝活动",
    BaseSortID = 331,
    Feature = "MoskActivity",
    FeatureName = "FeatureUnlock_130900_FeatureName|莫丝活动",
    FeatureEntranceType = 1
  },
  [126274] = {
    ID = 126274,
    CnID = "功能@阿拉克涅活动",
    BaseSortID = 332,
    Feature = "ArachneActivity",
    FeatureName = "FeatureUnlock_126274_FeatureName|阿拉克涅活动",
    FeatureEntranceType = 1
  },
  [130173] = {
    ID = 130173,
    CnID = "功能@沙耶活动",
    BaseSortID = 333,
    Feature = "SayaActivity",
    FeatureName = "FeatureUnlock_130173_FeatureName|沙耶活动",
    FeatureEntranceType = 1
  },
  [141300] = {
    ID = 141300,
    CnID = "功能@庞托斯活动",
    BaseSortID = 334,
    Feature = "PontosActivity",
    FeatureName = "FeatureUnlock_141300_FeatureName|庞托斯活动",
    FeatureEntranceType = 1
  },
  [145361] = {
    ID = 145361,
    CnID = "功能@蚀灭·萝坦活动",
    BaseSortID = 335,
    Feature = "LotanCetarchon",
    FeatureName = "FeatureUnlock_145361_FeatureName|蚀灭·萝坦活动",
    FeatureEntranceType = 1
  },
  [147086] = {
    ID = 147086,
    CnID = "功能@本源奥吉尔活动",
    BaseSortID = 336,
    Feature = "GenesisOgierActivity",
    FeatureName = "FeatureUnlock_147086_FeatureName|本源奥吉尔活动",
    FeatureEntranceType = 1
  },
  [141798] = {
    ID = 141798,
    CnID = "功能@卡拉布活动",
    BaseSortID = 337,
    Feature = "CarabooActivity",
    FeatureName = "FeatureUnlock_141798_FeatureName|卡拉布活动",
    FeatureEntranceType = 1
  },
  [147395] = {
    ID = 147395,
    CnID = "功能@暮星·汀克特活动",
    BaseSortID = 338,
    Feature = "GenesisTinctActivity",
    FeatureName = "FeatureUnlock_147395_FeatureName|暮星·汀克特活动",
    FeatureEntranceType = 1
  },
  [129487] = {
    ID = 129487,
    CnID = "功能@疾驰的欢愉专列",
    BaseSortID = 339,
    Feature = "RailWayActivity",
    FeatureName = "FeatureUnlock_129487_FeatureName|疾驰的欢愉专列",
    FeatureEntranceType = 1
  },
  [79686] = {
    ID = 79686,
    CnID = "功能@换装",
    BaseSortID = 340,
    Feature = "AwakerSkin",
    FeatureName = "FeatureUnlock_79686_FeatureName|唤醒体时装",
    FeatureEntranceType = 1,
    LockTip = "FeatureUnlock_79686_LockTip|通关 序章 解锁"
  },
  [89531] = {
    ID = 89531,
    CnID = "功能@时装商店",
    BaseSortID = 341,
    Feature = "Shop",
    Key = 83564,
    FeatureName = "FeatureUnlock_89531_FeatureName|时装商店",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_89531_LockTip|通关 序章 后解锁"
  },
  [90492] = {
    ID = 90492,
    CnID = "功能@战斗教学",
    BaseSortID = 342,
    Feature = "BattleTeaching",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_90492_LockTip|完成 「调查行动」1-2·普通 后解锁"
  },
  [83813] = {
    ID = 83813,
    CnID = "功能@活动弹窗广告",
    BaseSortID = 343,
    Feature = "PopUp",
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_83813_LockTip|完成 「调查行动」1-2·普通 后解锁"
  },
  [91201] = {
    ID = 91201,
    CnID = "功能@好友邀请码",
    BaseSortID = 344,
    Feature = "FriendInvitation",
    FeatureName = "FeatureUnlock_91201_FeatureName|好友邀请码",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_91201_LockTip|通关 序章 解锁"
  },
  [100552] = {
    ID = 100552,
    CnID = "功能@自动合成",
    BaseSortID = 345,
    Feature = "AutoSynthesis",
    UnlockCondition = {1, 7688},
    LockTip = "FeatureUnlock_100552_LockTip|完成 「调查行动」2-15·普通 后解锁"
  },
  [100551] = {
    ID = 100551,
    CnID = "功能@自动转换",
    BaseSortID = 346,
    Feature = "AutoReplacement",
    UnlockCondition = {1, 8043},
    LockTip = "FeatureUnlock_100551_LockTip|完成 「调查行动」3-10·普通 后解锁"
  },
  [119961] = {
    ID = 119961,
    CnID = "功能@兑换商店",
    BaseSortID = 347,
    Feature = "Shop",
    Key = 119962,
    FeatureName = "FeatureUnlock_119961_FeatureName|兑换商店",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7998},
    LockTip = "FeatureUnlock_119961_LockTip|通关 序章 解锁"
  },
  [128099] = {
    ID = 128099,
    CnID = "功能@记忆回响",
    BaseSortID = 348,
    Feature = "OngoingActivities",
    FeatureName = "FeatureUnlock_128099_FeatureName|记忆回廊",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 8126},
    LockTip = "FeatureUnlock_128099_LockTip|完成 「调查行动」1-2·普通 后解锁"
  },
  [133714] = {
    ID = 133714,
    CnID = "功能@密境手记",
    BaseSortID = 349,
    Feature = "GuideNote",
    FeatureName = "FeatureUnlock_133714_FeatureName|密境课室",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7685},
    UnlockDesc = "FeatureUnlock_133714_UnlockDesc|<FeatureUnlockTitle:密境课室已开启>\n\n<FeatureUnlockDesc:为了使调查员时刻保持敏锐状态，这是弥萨格定下的日常基础训练内容。>",
    LockTip = "FeatureUnlock_133714_LockTip|完成 「调查行动」1-11·普通 后解锁",
    Parameter = "20301"
  },
  [140473] = {
    ID = 140473,
    CnID = "功能@禁忌试炼",
    BaseSortID = 350,
    Feature = "GuideNote_Season",
    FeatureName = "FeatureUnlock_140473_FeatureName|禁忌试炼",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7685},
    LockTip = "FeatureUnlock_140473_LockTip|完成 「调查行动」1-11·普通 后解锁"
  },
  [134020] = {
    ID = 134020,
    CnID = "功能@日常试训",
    BaseSortID = 351,
    Feature = "GuideNote_DailyTask",
    FeatureName = "FeatureUnlock_134020_FeatureName|日常试训",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7685},
    LockTip = "FeatureUnlock_134020_LockTip|完成 「调查行动」1-11·普通 后解锁"
  },
  [134019] = {
    ID = 134019,
    CnID = "功能@周常试训",
    BaseSortID = 352,
    Feature = "GuideNote_WeekTask",
    FeatureName = "FeatureUnlock_134019_FeatureName|周常试训",
    FeatureEntranceType = 1,
    UnlockCondition = {1, 7685},
    LockTip = "FeatureUnlock_134019_LockTip|完成 「调查行动」1-11·普通 后解锁"
  }
})
return FeatureUnlock
