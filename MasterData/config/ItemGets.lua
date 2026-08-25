local System = require("System.System")
local readonly = System.readonly
local ItemGets = readonly({
  [17899] = {
    ID = 17899,
    CnID = "跳转@高级抽卡币商店",
    BaseSortID = 1,
    Desc = "ItemGets_17899_Desc|沉淀兑换",
    Order = 1,
    JumpFunc = 17013
  },
  [17879] = {
    ID = 17879,
    CnID = "跳转@日常币商店",
    BaseSortID = 2,
    Desc = "ItemGets_17879_Desc|融珠兑换",
    Order = 2,
    JumpFunc = 17024
  },
  [17946] = {
    ID = 17946,
    CnID = "跳转@唤醒体详情升级",
    BaseSortID = 3,
    Desc = "ItemGets_17946_Desc|唤醒体升级",
    Order = 3,
    JumpFunc = "AwakerDetail",
    Param1 = "Level"
  },
  [17957] = {
    ID = 17957,
    CnID = "跳转@唤醒体详情技能",
    BaseSortID = 4,
    Desc = "ItemGets_17957_Desc|唤醒体技能升级",
    Order = 4,
    JumpFunc = "AwakerDetail",
    Param1 = "Skill"
  },
  [17860] = {
    ID = 17860,
    CnID = "跳转@唤醒体详情饰品",
    BaseSortID = 5,
    Desc = "ItemGets_17860_Desc|唤醒体密契",
    Order = 5,
    JumpFunc = "AwakerDetail",
    Param1 = "Trinket"
  },
  [17858] = {
    ID = 17858,
    CnID = "跳转@唤醒体详情武器",
    BaseSortID = 6,
    Desc = "ItemGets_17858_Desc|唤醒体命轮",
    Order = 6,
    JumpFunc = "AwakerDetail",
    Param1 = "Weapon"
  },
  [21698] = {
    ID = 21698,
    CnID = "跳转@任务总",
    BaseSortID = 7,
    Desc = "ItemGets_21698_Desc|学籍档案",
    Order = 7,
    JumpFunc = 17046
  },
  [17936] = {
    ID = 17936,
    CnID = "跳转@任务",
    BaseSortID = 8,
    Desc = "ItemGets_17936_Desc|学籍档案-行动报告",
    Order = 8,
    JumpFunc = 17046
  },
  [20795] = {
    ID = 20795,
    CnID = "跳转@玩家等级任务",
    BaseSortID = 9,
    Desc = "ItemGets_20795_Desc|学籍档案-成长记录",
    Order = 9,
    JumpFunc = 17000
  },
  [20793] = {
    ID = 20793,
    CnID = "跳转@界域精通任务",
    BaseSortID = 10,
    Desc = "ItemGets_20793_Desc|学籍档案-界域精通",
    Order = 10,
    JumpFunc = 16981
  },
  [20794] = {
    ID = 20794,
    CnID = "跳转@成就任务",
    BaseSortID = 11,
    Desc = "ItemGets_20794_Desc|学籍档案-生涯成就",
    Order = 11,
    JumpFunc = 17058
  },
  [17937] = {
    ID = 17937,
    CnID = "跳转@通行证",
    BaseSortID = 12,
    Desc = "ItemGets_17937_Desc|学期课题",
    Order = 12,
    JumpFunc = 17008
  },
  [17983] = {
    ID = 17983,
    CnID = "跳转@委派任务",
    BaseSortID = 13,
    Desc = "ItemGets_17983_Desc|派遣奖励",
    Order = 13,
    JumpFunc = 17075
  },
  [22695] = {
    ID = 22695,
    CnID = "跳转@幕间演习",
    BaseSortID = 14,
    Desc = "ItemGets_22695_Desc|幕间演习",
    Order = 14,
    JumpFunc = 16991
  },
  [22696] = {
    ID = 22696,
    CnID = "跳转@幕间演习饰品本",
    BaseSortID = 15,
    Desc = "ItemGets_22696_Desc|禁忌纂录",
    Order = 15,
    JumpFunc = 16985
  },
  [22697] = {
    ID = 22697,
    CnID = "跳转@幕间演习日常挑战",
    BaseSortID = 16,
    Desc = "ItemGets_22697_Desc|幻梦深潜",
    Order = 16,
    JumpFunc = 16972
  },
  [144539] = {
    ID = 144539,
    CnID = "跳转@幻梦深潜排行榜",
    BaseSortID = 17,
    Desc = "ItemGets_144539_Desc|幻梦深潜-排行奖励",
    Order = 17,
    JumpFunc = 16972
  },
  [22694] = {
    ID = 22694,
    CnID = "跳转@幕间演习周常挑战",
    BaseSortID = 18,
    Desc = "ItemGets_22694_Desc|无光之境",
    Order = 18,
    JumpFunc = 16970
  },
  [54068] = {
    ID = 54068,
    CnID = "跳转@幕间演习常驻试玩",
    BaseSortID = 19,
    Desc = "ItemGets_54068_Desc|唤醒体试玩",
    Order = 19,
    JumpFunc = 49205
  },
  [54374] = {
    ID = 54374,
    CnID = "跳转@校友会",
    BaseSortID = 20,
    Desc = "ItemGets_54374_Desc|校友会",
    Order = 20,
    JumpFunc = 17022
  },
  [17999] = {
    ID = 17999,
    CnID = "跳转@抽卡",
    BaseSortID = 21,
    Desc = "ItemGets_17999_Desc|唤醒",
    Order = 21,
    JumpFunc = 17015
  },
  [140474] = {
    ID = 140474,
    CnID = "跳转@禁忌试炼",
    BaseSortID = 22,
    Desc = "ItemGets_140474_Desc|禁忌试炼",
    Order = 22,
    JumpFunc = 140473
  },
  [21724] = {
    ID = 21724,
    CnID = "跳转@调查",
    BaseSortID = 23,
    Desc = "ItemGets_21724_Desc|调查",
    Order = 23,
    JumpFunc = "Stage"
  },
  [17855] = {
    ID = 17855,
    CnID = "跳转@主线",
    BaseSortID = 24,
    Desc = "ItemGets_17855_Desc|主线关卡首通",
    Order = 24,
    JumpFunc = "Stage"
  },
  [21708] = {
    ID = 21708,
    CnID = "跳转@主线三星",
    BaseSortID = 25,
    Desc = "ItemGets_21708_Desc|主线关卡三星",
    Order = 25,
    JumpFunc = "Stage"
  },
  [17866] = {
    ID = 17866,
    CnID = "跳转@关卡成就",
    BaseSortID = 26,
    Desc = "ItemGets_17866_Desc|主线关卡成就",
    Order = 26,
    JumpFunc = "Stage"
  },
  [17892] = {
    ID = 17892,
    CnID = "跳转@关卡评分",
    BaseSortID = 27,
    Desc = "ItemGets_17892_Desc|主线星级评分",
    Order = 27,
    JumpFunc = "Stage"
  },
  [17853] = {
    ID = 17853,
    CnID = "跳转@日常金币本",
    BaseSortID = 28,
    Desc = "ItemGets_17853_Desc|金券搜查",
    Order = 28,
    JumpFunc = 17059
  },
  [17927] = {
    ID = 17927,
    CnID = "跳转@日常经验本",
    BaseSortID = 29,
    Desc = "ItemGets_17927_Desc|制剂淬炼",
    Order = 29,
    JumpFunc = 17057
  },
  [18018] = {
    ID = 18018,
    CnID = "跳转@日常深海本",
    BaseSortID = 30,
    Desc = "ItemGets_18018_Desc|海渊残像",
    Order = 30,
    JumpFunc = 17017
  },
  [18017] = {
    ID = 18017,
    CnID = "跳转@日常血肉本",
    BaseSortID = 31,
    Desc = "ItemGets_18017_Desc|器质残像",
    Order = 31,
    JumpFunc = 17006
  },
  [17921] = {
    ID = 17921,
    CnID = "跳转@日常超维本",
    BaseSortID = 32,
    Desc = "ItemGets_17921_Desc|维度残像",
    Order = 32,
    JumpFunc = 17007
  },
  [17945] = {
    ID = 17945,
    CnID = "跳转@日常混沌本",
    BaseSortID = 33,
    Desc = "ItemGets_17945_Desc|浑浊残像",
    Order = 33,
    JumpFunc = 17047
  },
  [17856] = {
    ID = 17856,
    CnID = "跳转@日常混沌集群",
    BaseSortID = 34,
    Desc = "ItemGets_17856_Desc|混沌集群",
    Order = 34,
    JumpFunc = 17035
  },
  [17998] = {
    ID = 17998,
    CnID = "跳转@日常波纳佩之墟",
    BaseSortID = 35,
    Desc = "ItemGets_17998_Desc|波纳佩之墟",
    Order = 35,
    JumpFunc = 16998
  },
  [17896] = {
    ID = 17896,
    CnID = "跳转@日常蠕虫之所",
    BaseSortID = 36,
    Desc = "ItemGets_17896_Desc|蠕虫之所",
    Order = 36,
    JumpFunc = 16988
  },
  [17897] = {
    ID = 17897,
    CnID = "跳转@日常史瓦西喉",
    BaseSortID = 37,
    Desc = "ItemGets_17897_Desc|史瓦西喉",
    Order = 37,
    JumpFunc = 17004
  },
  [18003] = {
    ID = 18003,
    CnID = "跳转@炼金合成",
    BaseSortID = 38,
    Desc = "ItemGets_18003_Desc|材料合成",
    Order = 38,
    JumpFunc = 16955
  },
  [17889] = {
    ID = 17889,
    CnID = "跳转@炼金分解",
    BaseSortID = 39,
    Desc = "ItemGets_17889_Desc|命轮分解",
    Order = 39,
    JumpFunc = 17045
  },
  [17995] = {
    ID = 17995,
    CnID = "跳转@密契分解",
    BaseSortID = 40,
    Desc = "ItemGets_17995_Desc|密契分解",
    Order = 40,
    JumpFunc = 16965
  },
  [17942] = {
    ID = 17942,
    CnID = "跳转@炼金重印",
    BaseSortID = 41,
    Desc = "ItemGets_17942_Desc|密契重印",
    Order = 41,
    JumpFunc = 17014
  },
  [50022] = {
    ID = 50022,
    CnID = "跳转@炼金置换",
    BaseSortID = 42,
    Desc = "ItemGets_50022_Desc|材料置换",
    Order = 42,
    JumpFunc = 17055
  },
  [17894] = {
    ID = 17894,
    CnID = "跳转@周常BOSSA本",
    BaseSortID = 43,
    Desc = "ItemGets_17894_Desc|玩偶之泪",
    Order = 43,
    JumpFunc = 17072
  },
  [17916] = {
    ID = 17916,
    CnID = "跳转@周常BOSSB本",
    BaseSortID = 44,
    Desc = "ItemGets_17916_Desc|蜡像之秘",
    Order = 44,
    JumpFunc = 16982
  },
  [17941] = {
    ID = 17941,
    CnID = "跳转@周常BOSSC本",
    BaseSortID = 45,
    Desc = "ItemGets_17941_Desc|漆黑之链",
    Order = 45,
    JumpFunc = 16964
  },
  [18011] = {
    ID = 18011,
    CnID = "跳转@周常BOSSD本",
    BaseSortID = 46,
    Desc = "ItemGets_18011_Desc|界外之影",
    Order = 46,
    JumpFunc = 17011
  },
  [17977] = {
    ID = 17977,
    CnID = "跳转@周常BOSSE本",
    BaseSortID = 47,
    Desc = "ItemGets_17977_Desc|虔诚之握",
    Order = 47,
    JumpFunc = 16996
  },
  [18001] = {
    ID = 18001,
    CnID = "跳转@周常BOSSF本",
    BaseSortID = 48,
    Desc = "ItemGets_18001_Desc|圣胎之咏",
    Order = 48,
    JumpFunc = 17039
  },
  [49174] = {
    ID = 49174,
    CnID = "跳转@周常BOSSG本",
    BaseSortID = 49,
    Desc = "ItemGets_49174_Desc|沙海遗存",
    Order = 49,
    JumpFunc = 49170
  },
  [59100] = {
    ID = 59100,
    CnID = "跳转@周常BOSSH本",
    BaseSortID = 50,
    Desc = "ItemGets_59100_Desc|黑池之潮",
    Order = 50,
    JumpFunc = 58914
  },
  [20796] = {
    ID = 20796,
    CnID = "跳转@PVP对战",
    BaseSortID = 51,
    Desc = "ItemGets_20796_Desc|相位对弈",
    Order = 51,
    JumpFunc = 17054
  },
  [144540] = {
    ID = 144540,
    CnID = "跳转@PVP对战排行榜",
    BaseSortID = 52,
    Desc = "ItemGets_144540_Desc|相位对弈-排行奖励",
    Order = 52,
    JumpFunc = 17054
  },
  [128102] = {
    ID = 128102,
    CnID = "跳转@疾驰的欢愉专列",
    BaseSortID = 53,
    Desc = "ItemGets_128102_Desc|疾驰的欢愉专列",
    Order = 53,
    JumpFunc = 129487
  },
  [144538] = {
    ID = 144538,
    CnID = "跳转@疾驰的欢愉专列排行榜",
    BaseSortID = 54,
    Desc = "ItemGets_144538_Desc|疾驰的欢愉专列-排行奖励",
    Order = 54,
    JumpFunc = 129487
  },
  [17877] = {
    ID = 17877,
    CnID = "跳转@主线第1章",
    BaseSortID = 55,
    Desc = "ItemGets_17877_Desc|主线关卡首通-第1章",
    Order = 55,
    JumpFunc = "StageNoDetail",
    Param1 = 8128
  },
  [17979] = {
    ID = 17979,
    CnID = "跳转@主线第2章",
    BaseSortID = 56,
    Desc = "ItemGets_17979_Desc|主线关卡首通-第2章",
    Order = 56,
    JumpFunc = "StageNoDetail",
    Param1 = 7986
  },
  [17990] = {
    ID = 17990,
    CnID = "跳转@主线第3章",
    BaseSortID = 57,
    Desc = "ItemGets_17990_Desc|主线关卡首通-第3章",
    Order = 57,
    JumpFunc = "StageNoDetail",
    Param1 = 8110
  },
  [17890] = {
    ID = 17890,
    CnID = "跳转@主线第4章",
    BaseSortID = 58,
    Desc = "ItemGets_17890_Desc|主线关卡首通-第4章",
    Order = 58,
    JumpFunc = "StageNoDetail",
    Param1 = 8027
  },
  [17958] = {
    ID = 17958,
    CnID = "跳转@主线第5章",
    BaseSortID = 59,
    Desc = "ItemGets_17958_Desc|主线关卡首通-第5章",
    Order = 59,
    JumpFunc = "StageNoDetail",
    Param1 = 8153
  },
  [17893] = {
    ID = 17893,
    CnID = "跳转@主线第6章",
    BaseSortID = 60,
    Desc = "ItemGets_17893_Desc|主线关卡首通-第6章",
    Order = 60,
    JumpFunc = "StageNoDetail",
    Param1 = 7659
  },
  [48940] = {
    ID = 48940,
    CnID = "跳转@主线第7章",
    BaseSortID = 61,
    Desc = "ItemGets_48940_Desc|主线关卡首通-第7章",
    Order = 61,
    JumpFunc = "StageNoDetail",
    Param1 = 50345
  },
  [59085] = {
    ID = 59085,
    CnID = "跳转@主线第8章",
    BaseSortID = 62,
    Desc = "ItemGets_59085_Desc|主线关卡首通-第8章",
    Order = 62,
    JumpFunc = "StageNoDetail",
    Param1 = 58986
  },
  [67104] = {
    ID = 67104,
    CnID = "跳转@主线第9章",
    BaseSortID = 63,
    Desc = "ItemGets_67104_Desc|主线关卡首通-终章",
    Order = 63,
    JumpFunc = "StageNoDetail",
    Param1 = 59505
  },
  [74096] = {
    ID = 74096,
    CnID = "跳转@主线S1第1章",
    BaseSortID = 64,
    Desc = "ItemGets_74096_Desc|主线关卡首通-星辰篇第1章",
    Order = 64,
    JumpFunc = "StageNoDetail",
    Param1 = 70937
  },
  [80195] = {
    ID = 80195,
    CnID = "跳转@主线S1第2章",
    BaseSortID = 65,
    Desc = "ItemGets_80195_Desc|主线关卡首通-星辰篇第2章",
    Order = 65,
    JumpFunc = "StageNoDetail",
    Param1 = 80251
  },
  [95557] = {
    ID = 95557,
    CnID = "跳转@主线S1第3章",
    BaseSortID = 66,
    Desc = "ItemGets_95557_Desc|主线关卡首通-星辰篇第3章",
    Order = 66,
    JumpFunc = "StageNoDetail",
    Param1 = 90676
  },
  [118171] = {
    ID = 118171,
    CnID = "跳转@主线S1第4章",
    BaseSortID = 67,
    Desc = "ItemGets_118171_Desc|主线关卡首通-星辰篇第4章",
    Order = 67,
    JumpFunc = "StageNoDetail",
    Param1 = 118153
  },
  [125877] = {
    ID = 125877,
    CnID = "跳转@主线S1第5章",
    BaseSortID = 68,
    Desc = "ItemGets_125877_Desc|主线关卡首通-星辰篇第5章",
    Order = 68,
    JumpFunc = "StageNoDetail",
    Param1 = 125643
  },
  [146358] = {
    ID = 146358,
    CnID = "跳转@主线S1第6章",
    BaseSortID = 69,
    Desc = "ItemGets_146358_Desc|主线关卡首通-星辰篇第6章",
    Order = 69,
    JumpFunc = "StageNoDetail",
    Param1 = 146251
  },
  [17861] = {
    ID = 17861,
    CnID = "跳转@主线第1章关卡评分",
    BaseSortID = 70,
    Desc = "ItemGets_17861_Desc|主线星级评分-第1章",
    Order = 70,
    JumpFunc = "StageNoDetail",
    Param1 = 8128
  },
  [17895] = {
    ID = 17895,
    CnID = "跳转@主线第2章关卡评分",
    BaseSortID = 71,
    Desc = "ItemGets_17895_Desc|主线星级评分-第2章",
    Order = 71,
    JumpFunc = "StageNoDetail",
    Param1 = 7986
  },
  [17938] = {
    ID = 17938,
    CnID = "跳转@主线第3章关卡评分",
    BaseSortID = 72,
    Desc = "ItemGets_17938_Desc|主线星级评分-第3章",
    Order = 72,
    JumpFunc = "StageNoDetail",
    Param1 = 8110
  },
  [17988] = {
    ID = 17988,
    CnID = "跳转@主线第4章关卡评分",
    BaseSortID = 73,
    Desc = "ItemGets_17988_Desc|主线星级评分-第4章",
    Order = 73,
    JumpFunc = "StageNoDetail",
    Param1 = 8027
  },
  [17962] = {
    ID = 17962,
    CnID = "跳转@主线第5章关卡评分",
    BaseSortID = 74,
    Desc = "ItemGets_17962_Desc|主线星级评分-第5章",
    Order = 74,
    JumpFunc = "StageNoDetail",
    Param1 = 8153
  },
  [17857] = {
    ID = 17857,
    CnID = "跳转@主线第6章关卡评分",
    BaseSortID = 75,
    Desc = "ItemGets_17857_Desc|主线星级评分-第6章",
    Order = 75,
    JumpFunc = "StageNoDetail",
    Param1 = 7659
  },
  [24204] = {
    ID = 24204,
    CnID = "跳转@主线困难第1章",
    BaseSortID = 76,
    Desc = "ItemGets_24204_Desc|主线困难首通-第1章",
    Order = 76,
    JumpFunc = "StageNoDetail",
    Param1 = 7837
  },
  [24207] = {
    ID = 24207,
    CnID = "跳转@主线困难第2章",
    BaseSortID = 77,
    Desc = "ItemGets_24207_Desc|主线困难首通-第2章",
    Order = 77,
    JumpFunc = "StageNoDetail",
    Param1 = 7955
  },
  [24208] = {
    ID = 24208,
    CnID = "跳转@主线困难第3章",
    BaseSortID = 78,
    Desc = "ItemGets_24208_Desc|主线困难首通-第3章",
    Order = 78,
    JumpFunc = "StageNoDetail",
    Param1 = 7849
  },
  [24205] = {
    ID = 24205,
    CnID = "跳转@主线困难第4章",
    BaseSortID = 79,
    Desc = "ItemGets_24205_Desc|主线困难首通-第4章",
    Order = 79,
    JumpFunc = "StageNoDetail",
    Param1 = 7713
  },
  [24206] = {
    ID = 24206,
    CnID = "跳转@主线困难第5章",
    BaseSortID = 80,
    Desc = "ItemGets_24206_Desc|主线困难首通-第5章",
    Order = 80,
    JumpFunc = "StageNoDetail",
    Param1 = 7820
  },
  [36121] = {
    ID = 36121,
    CnID = "跳转@主线困难第6章",
    BaseSortID = 81,
    Desc = "ItemGets_36121_Desc|主线困难首通-第6章",
    Order = 81,
    JumpFunc = "StageNoDetail",
    Param1 = 7717
  },
  [49172] = {
    ID = 49172,
    CnID = "跳转@主线困难第7章",
    BaseSortID = 82,
    Desc = "ItemGets_49172_Desc|主线困难首通-第7章",
    Order = 82,
    JumpFunc = "StageNoDetail",
    Param1 = 48043
  },
  [59095] = {
    ID = 59095,
    CnID = "跳转@主线困难第8章",
    BaseSortID = 83,
    Desc = "ItemGets_59095_Desc|主线困难首通-第8章",
    Order = 83,
    JumpFunc = "StageNoDetail",
    Param1 = 59062
  },
  [67401] = {
    ID = 67401,
    CnID = "跳转@主线困难第9章",
    BaseSortID = 84,
    Desc = "ItemGets_67401_Desc|主线困难首通-终章",
    Order = 84,
    JumpFunc = "StageNoDetail",
    Param1 = 59509
  },
  [74097] = {
    ID = 74097,
    CnID = "跳转@主线困难S1第1章",
    BaseSortID = 85,
    Desc = "ItemGets_74097_Desc|主线困难首通-星辰篇第1章",
    Order = 85,
    JumpFunc = "StageNoDetail",
    Param1 = 72069
  },
  [80272] = {
    ID = 80272,
    CnID = "跳转@主线困难S1第2章",
    BaseSortID = 86,
    Desc = "ItemGets_80272_Desc|主线困难首通-星辰篇第2章",
    Order = 86,
    JumpFunc = "StageNoDetail",
    Param1 = 80260
  },
  [95551] = {
    ID = 95551,
    CnID = "跳转@主线困难S1第3章",
    BaseSortID = 87,
    Desc = "ItemGets_95551_Desc|主线困难首通-星辰篇第3章",
    Order = 87,
    JumpFunc = "StageNoDetail",
    Param1 = 90662
  },
  [118166] = {
    ID = 118166,
    CnID = "跳转@主线困难S1第4章",
    BaseSortID = 88,
    Desc = "ItemGets_118166_Desc|主线困难首通-星辰篇第4章",
    Order = 88,
    JumpFunc = "StageNoDetail",
    Param1 = 118149
  },
  [126382] = {
    ID = 126382,
    CnID = "跳转@主线困难S1第5章",
    BaseSortID = 89,
    Desc = "ItemGets_126382_Desc|主线困难首通-星辰篇第5章",
    Order = 89,
    JumpFunc = "StageNoDetail",
    Param1 = 125638
  },
  [17947] = {
    ID = 17947,
    CnID = "跳转@主线困难1-8",
    BaseSortID = 90,
    Desc = "ItemGets_17947_Desc|主线困难1-8",
    Order = 90,
    JumpFunc = "Stage",
    Param1 = 7842
  },
  [18016] = {
    ID = 18016,
    CnID = "跳转@主线困难2-11",
    BaseSortID = 91,
    Desc = "ItemGets_18016_Desc|主线困难2-11",
    Order = 91,
    JumpFunc = "Stage",
    Param1 = 7933
  },
  [17900] = {
    ID = 17900,
    CnID = "跳转@主线困难3-10",
    BaseSortID = 92,
    Desc = "ItemGets_17900_Desc|主线困难3-10",
    Order = 92,
    JumpFunc = "Stage",
    Param1 = 7760
  },
  [17924] = {
    ID = 17924,
    CnID = "跳转@主线困难4-12",
    BaseSortID = 93,
    Desc = "ItemGets_17924_Desc|主线困难4-12",
    Order = 93,
    JumpFunc = "Stage",
    Param1 = 8105
  },
  [17871] = {
    ID = 17871,
    CnID = "跳转@主线普通1-1",
    BaseSortID = 94,
    Desc = "ItemGets_17871_Desc|主线普通1-1",
    Order = 94,
    JumpFunc = "Stage",
    Param1 = 8128
  },
  [17996] = {
    ID = 17996,
    CnID = "跳转@主线普通1-2",
    BaseSortID = 95,
    Desc = "ItemGets_17996_Desc|主线普通1-2",
    Order = 95,
    JumpFunc = "Stage",
    Param1 = 8126
  },
  [17992] = {
    ID = 17992,
    CnID = "跳转@主线普通1-3",
    BaseSortID = 96,
    Desc = "ItemGets_17992_Desc|主线普通1-3",
    Order = 96,
    JumpFunc = "Stage",
    Param1 = 8127
  },
  [17875] = {
    ID = 17875,
    CnID = "跳转@主线普通1-4",
    BaseSortID = 97,
    Desc = "ItemGets_17875_Desc|主线普通1-4",
    Order = 97,
    JumpFunc = "Stage",
    Param1 = 8185
  },
  [17874] = {
    ID = 17874,
    CnID = "跳转@主线普通1-5",
    BaseSortID = 98,
    Desc = "ItemGets_17874_Desc|主线普通1-5",
    Order = 98,
    JumpFunc = "Stage",
    Param1 = 8125
  },
  [17873] = {
    ID = 17873,
    CnID = "跳转@主线普通1-6",
    BaseSortID = 99,
    Desc = "ItemGets_17873_Desc|主线普通1-6",
    Order = 99,
    JumpFunc = "Stage",
    Param1 = 8187
  },
  [17872] = {
    ID = 17872,
    CnID = "跳转@主线普通1-7",
    BaseSortID = 100,
    Desc = "ItemGets_17872_Desc|主线普通1-7",
    Order = 100,
    JumpFunc = "Stage",
    Param1 = 8188
  },
  [17980] = {
    ID = 17980,
    CnID = "跳转@主线普通1-8",
    BaseSortID = 101,
    Desc = "ItemGets_17980_Desc|主线普通1-8",
    Order = 101,
    JumpFunc = "Stage",
    Param1 = 8120
  },
  [17978] = {
    ID = 17978,
    CnID = "跳转@主线普通1-9",
    BaseSortID = 102,
    Desc = "ItemGets_17978_Desc|主线普通1-9",
    Order = 102,
    JumpFunc = "Stage",
    Param1 = 8121
  },
  [17931] = {
    ID = 17931,
    CnID = "跳转@主线普通1-10",
    BaseSortID = 103,
    Desc = "ItemGets_17931_Desc|主线普通1-10",
    Order = 103,
    JumpFunc = "Stage",
    Param1 = 7684
  },
  [17930] = {
    ID = 17930,
    CnID = "跳转@主线普通1-11",
    BaseSortID = 104,
    Desc = "ItemGets_17930_Desc|主线普通1-11",
    Order = 104,
    JumpFunc = "Stage",
    Param1 = 7685
  },
  [17929] = {
    ID = 17929,
    CnID = "跳转@主线普通1-12",
    BaseSortID = 105,
    Desc = "ItemGets_17929_Desc|主线普通1-12",
    Order = 105,
    JumpFunc = "Stage",
    Param1 = 7686
  },
  [17928] = {
    ID = 17928,
    CnID = "跳转@主线普通1-13",
    BaseSortID = 106,
    Desc = "ItemGets_17928_Desc|主线普通1-13",
    Order = 106,
    JumpFunc = "Stage",
    Param1 = 8028
  },
  [17933] = {
    ID = 17933,
    CnID = "跳转@主线普通1-14",
    BaseSortID = 107,
    Desc = "ItemGets_17933_Desc|主线普通1-14",
    Order = 107,
    JumpFunc = "Stage",
    Param1 = 7889
  },
  [116337] = {
    ID = 116337,
    CnID = "跳转@主线普通1-15",
    BaseSortID = 108,
    Desc = "ItemGets_116337_Desc|主线普通1-15",
    Order = 108,
    JumpFunc = "Stage",
    Param1 = 8030
  },
  [17862] = {
    ID = 17862,
    CnID = "跳转@主线普通2-1",
    BaseSortID = 109,
    Desc = "ItemGets_17862_Desc|主线普通2-1",
    Order = 109,
    JumpFunc = "Stage",
    Param1 = 7986
  },
  [17863] = {
    ID = 17863,
    CnID = "跳转@主线普通2-2",
    BaseSortID = 110,
    Desc = "ItemGets_17863_Desc|主线普通2-2",
    Order = 110,
    JumpFunc = "Stage",
    Param1 = 7988
  },
  [17864] = {
    ID = 17864,
    CnID = "跳转@主线普通2-3",
    BaseSortID = 111,
    Desc = "ItemGets_17864_Desc|主线普通2-3",
    Order = 111,
    JumpFunc = "Stage",
    Param1 = 7987
  },
  [17865] = {
    ID = 17865,
    CnID = "跳转@主线普通2-4",
    BaseSortID = 112,
    Desc = "ItemGets_17865_Desc|主线普通2-4",
    Order = 112,
    JumpFunc = "Stage",
    Param1 = 7990
  },
  [17960] = {
    ID = 17960,
    CnID = "跳转@主线普通2-5",
    BaseSortID = 113,
    Desc = "ItemGets_17960_Desc|主线普通2-5",
    Order = 113,
    JumpFunc = "Stage",
    Param1 = 7989
  },
  [17867] = {
    ID = 17867,
    CnID = "跳转@主线普通2-6",
    BaseSortID = 114,
    Desc = "ItemGets_17867_Desc|主线普通2-6",
    Order = 114,
    JumpFunc = "Stage",
    Param1 = 7992
  },
  [17868] = {
    ID = 17868,
    CnID = "跳转@主线普通2-7",
    BaseSortID = 115,
    Desc = "ItemGets_17868_Desc|主线普通2-7",
    Order = 115,
    JumpFunc = "Stage",
    Param1 = 7991
  },
  [17869] = {
    ID = 17869,
    CnID = "跳转@主线普通2-8",
    BaseSortID = 116,
    Desc = "ItemGets_17869_Desc|主线普通2-8",
    Order = 116,
    JumpFunc = "Stage",
    Param1 = 7983
  },
  [17870] = {
    ID = 17870,
    CnID = "跳转@主线普通2-9",
    BaseSortID = 117,
    Desc = "ItemGets_17870_Desc|主线普通2-9",
    Order = 117,
    JumpFunc = "Stage",
    Param1 = 7982
  },
  [17986] = {
    ID = 17986,
    CnID = "跳转@主线普通2-10",
    BaseSortID = 118,
    Desc = "ItemGets_17986_Desc|主线普通2-10",
    Order = 118,
    JumpFunc = "Stage",
    Param1 = 7749
  },
  [17984] = {
    ID = 17984,
    CnID = "跳转@主线普通2-11",
    BaseSortID = 119,
    Desc = "ItemGets_17984_Desc|主线普通2-11",
    Order = 119,
    JumpFunc = "Stage",
    Param1 = 7748
  },
  [17981] = {
    ID = 17981,
    CnID = "跳转@主线普通2-12",
    BaseSortID = 120,
    Desc = "ItemGets_17981_Desc|主线普通2-12",
    Order = 120,
    JumpFunc = "Stage",
    Param1 = 7751
  },
  [17982] = {
    ID = 17982,
    CnID = "跳转@主线普通2-13",
    BaseSortID = 121,
    Desc = "ItemGets_17982_Desc|主线普通2-13",
    Order = 121,
    JumpFunc = "Stage",
    Param1 = 7750
  },
  [17987] = {
    ID = 17987,
    CnID = "跳转@主线普通2-14",
    BaseSortID = 122,
    Desc = "ItemGets_17987_Desc|主线普通2-14",
    Order = 122,
    JumpFunc = "Stage",
    Param1 = 7753
  },
  [17997] = {
    ID = 17997,
    CnID = "跳转@主线普通2-15",
    BaseSortID = 123,
    Desc = "ItemGets_17997_Desc|主线普通2-15",
    Order = 123,
    JumpFunc = "Stage",
    Param1 = 7688
  },
  [17985] = {
    ID = 17985,
    CnID = "跳转@主线普通2-16",
    BaseSortID = 124,
    Desc = "ItemGets_17985_Desc|主线普通2-16",
    Order = 124,
    JumpFunc = "Stage",
    Param1 = 7755
  },
  [17954] = {
    ID = 17954,
    CnID = "跳转@主线普通3-1",
    BaseSortID = 125,
    Desc = "ItemGets_17954_Desc|主线普通3-1",
    Order = 125,
    JumpFunc = "Stage",
    Param1 = 8110
  },
  [17956] = {
    ID = 17956,
    CnID = "跳转@主线普通3-2",
    BaseSortID = 126,
    Desc = "ItemGets_17956_Desc|主线普通3-2",
    Order = 126,
    JumpFunc = "Stage",
    Param1 = 8111
  },
  [17955] = {
    ID = 17955,
    CnID = "跳转@主线普通3-3",
    BaseSortID = 127,
    Desc = "ItemGets_17955_Desc|主线普通3-3",
    Order = 127,
    JumpFunc = "Stage",
    Param1 = 8112
  },
  [17951] = {
    ID = 17951,
    CnID = "跳转@主线普通3-4",
    BaseSortID = 128,
    Desc = "ItemGets_17951_Desc|主线普通3-4",
    Order = 128,
    JumpFunc = "Stage",
    Param1 = 8113
  },
  [17950] = {
    ID = 17950,
    CnID = "跳转@主线普通3-5",
    BaseSortID = 129,
    Desc = "ItemGets_17950_Desc|主线普通3-5",
    Order = 129,
    JumpFunc = "Stage",
    Param1 = 8114
  },
  [17953] = {
    ID = 17953,
    CnID = "跳转@主线普通3-6",
    BaseSortID = 130,
    Desc = "ItemGets_17953_Desc|主线普通3-6",
    Order = 130,
    JumpFunc = "Stage",
    Param1 = 8115
  },
  [17952] = {
    ID = 17952,
    CnID = "跳转@主线普通3-7",
    BaseSortID = 131,
    Desc = "ItemGets_17952_Desc|主线普通3-7",
    Order = 131,
    JumpFunc = "Stage",
    Param1 = 8116
  },
  [17949] = {
    ID = 17949,
    CnID = "跳转@主线普通3-8",
    BaseSortID = 132,
    Desc = "ItemGets_17949_Desc|主线普通3-8",
    Order = 132,
    JumpFunc = "Stage",
    Param1 = 8117
  },
  [17948] = {
    ID = 17948,
    CnID = "跳转@主线普通3-9",
    BaseSortID = 133,
    Desc = "ItemGets_17948_Desc|主线普通3-9",
    Order = 133,
    JumpFunc = "Stage",
    Param1 = 8118
  },
  [17964] = {
    ID = 17964,
    CnID = "跳转@主线普通3-10",
    BaseSortID = 134,
    Desc = "ItemGets_17964_Desc|主线普通3-10",
    Order = 134,
    JumpFunc = "Stage",
    Param1 = 8043
  },
  [17963] = {
    ID = 17963,
    CnID = "跳转@主线普通3-11",
    BaseSortID = 135,
    Desc = "ItemGets_17963_Desc|主线普通3-11",
    Order = 135,
    JumpFunc = "Stage",
    Param1 = 8044
  },
  [17966] = {
    ID = 17966,
    CnID = "跳转@主线普通3-12",
    BaseSortID = 136,
    Desc = "ItemGets_17966_Desc|主线普通3-12",
    Order = 136,
    JumpFunc = "Stage",
    Param1 = 8041
  },
  [17965] = {
    ID = 17965,
    CnID = "跳转@主线普通3-13",
    BaseSortID = 137,
    Desc = "ItemGets_17965_Desc|主线普通3-13",
    Order = 137,
    JumpFunc = "Stage",
    Param1 = 8042
  },
  [17968] = {
    ID = 17968,
    CnID = "跳转@主线普通3-14",
    BaseSortID = 138,
    Desc = "ItemGets_17968_Desc|主线普通3-14",
    Order = 138,
    JumpFunc = "Stage",
    Param1 = 8045
  },
  [17919] = {
    ID = 17919,
    CnID = "跳转@主线普通4-1",
    BaseSortID = 139,
    Desc = "ItemGets_17919_Desc|主线普通4-1",
    Order = 139,
    JumpFunc = "Stage",
    Param1 = 8027
  },
  [17917] = {
    ID = 17917,
    CnID = "跳转@主线普通4-2",
    BaseSortID = 140,
    Desc = "ItemGets_17917_Desc|主线普通4-2",
    Order = 140,
    JumpFunc = "Stage",
    Param1 = 8026
  },
  [17918] = {
    ID = 17918,
    CnID = "跳转@主线普通4-3",
    BaseSortID = 141,
    Desc = "ItemGets_17918_Desc|主线普通4-3",
    Order = 141,
    JumpFunc = "Stage",
    Param1 = 8025
  },
  [17922] = {
    ID = 17922,
    CnID = "跳转@主线普通4-4",
    BaseSortID = 142,
    Desc = "ItemGets_17922_Desc|主线普通4-4",
    Order = 142,
    JumpFunc = "Stage",
    Param1 = 8032
  },
  [17923] = {
    ID = 17923,
    CnID = "跳转@主线普通4-5",
    BaseSortID = 143,
    Desc = "ItemGets_17923_Desc|主线普通4-5",
    Order = 143,
    JumpFunc = "Stage",
    Param1 = 8031
  },
  [17920] = {
    ID = 17920,
    CnID = "跳转@主线普通4-6",
    BaseSortID = 144,
    Desc = "ItemGets_17920_Desc|主线普通4-6",
    Order = 144,
    JumpFunc = "Stage",
    Param1 = 7689
  },
  [17961] = {
    ID = 17961,
    CnID = "跳转@主线普通4-7",
    BaseSortID = 145,
    Desc = "ItemGets_17961_Desc|主线普通4-7",
    Order = 145,
    JumpFunc = "Stage",
    Param1 = 8029
  },
  [17925] = {
    ID = 17925,
    CnID = "跳转@主线普通4-8",
    BaseSortID = 146,
    Desc = "ItemGets_17925_Desc|主线普通4-8",
    Order = 146,
    JumpFunc = "Stage",
    Param1 = 8024
  },
  [17926] = {
    ID = 17926,
    CnID = "跳转@主线普通4-9",
    BaseSortID = 147,
    Desc = "ItemGets_17926_Desc|主线普通4-9",
    Order = 147,
    JumpFunc = "Stage",
    Param1 = 8023
  },
  [17905] = {
    ID = 17905,
    CnID = "跳转@主线普通4-10",
    BaseSortID = 148,
    Desc = "ItemGets_17905_Desc|主线普通4-10",
    Order = 148,
    JumpFunc = "Stage",
    Param1 = 7868
  },
  [17906] = {
    ID = 17906,
    CnID = "跳转@主线普通4-11",
    BaseSortID = 149,
    Desc = "ItemGets_17906_Desc|主线普通4-11",
    Order = 149,
    JumpFunc = "Stage",
    Param1 = 7867
  },
  [17907] = {
    ID = 17907,
    CnID = "跳转@主线普通4-12",
    BaseSortID = 150,
    Desc = "ItemGets_17907_Desc|主线普通4-12",
    Order = 150,
    JumpFunc = "Stage",
    Param1 = 7866
  },
  [17908] = {
    ID = 17908,
    CnID = "跳转@主线普通4-13",
    BaseSortID = 151,
    Desc = "ItemGets_17908_Desc|主线普通4-13",
    Order = 151,
    JumpFunc = "Stage",
    Param1 = 7865
  },
  [17909] = {
    ID = 17909,
    CnID = "跳转@主线普通4-14",
    BaseSortID = 152,
    Desc = "ItemGets_17909_Desc|主线普通4-14",
    Order = 152,
    JumpFunc = "Stage",
    Param1 = 7871
  },
  [17910] = {
    ID = 17910,
    CnID = "跳转@主线普通4-15",
    BaseSortID = 153,
    Desc = "ItemGets_17910_Desc|主线普通4-15",
    Order = 153,
    JumpFunc = "Stage",
    Param1 = 7858
  },
  [17911] = {
    ID = 17911,
    CnID = "跳转@主线普通4-16",
    BaseSortID = 154,
    Desc = "ItemGets_17911_Desc|主线普通4-16",
    Order = 154,
    JumpFunc = "Stage",
    Param1 = 7869
  },
  [18010] = {
    ID = 18010,
    CnID = "跳转@主线普通5-1",
    BaseSortID = 155,
    Desc = "ItemGets_18010_Desc|主线普通5-1",
    Order = 155,
    JumpFunc = "Stage",
    Param1 = 8153
  },
  [18009] = {
    ID = 18009,
    CnID = "跳转@主线普通5-2",
    BaseSortID = 156,
    Desc = "ItemGets_18009_Desc|主线普通5-2",
    Order = 156,
    JumpFunc = "Stage",
    Param1 = 8151
  },
  [18008] = {
    ID = 18008,
    CnID = "跳转@主线普通5-3",
    BaseSortID = 157,
    Desc = "ItemGets_18008_Desc|主线普通5-3",
    Order = 157,
    JumpFunc = "Stage",
    Param1 = 8152
  },
  [18007] = {
    ID = 18007,
    CnID = "跳转@主线普通5-4",
    BaseSortID = 158,
    Desc = "ItemGets_18007_Desc|主线普通5-4",
    Order = 158,
    JumpFunc = "Stage",
    Param1 = 8156
  },
  [18006] = {
    ID = 18006,
    CnID = "跳转@主线普通5-5",
    BaseSortID = 159,
    Desc = "ItemGets_18006_Desc|主线普通5-5",
    Order = 159,
    JumpFunc = "Stage",
    Param1 = 8157
  },
  [18005] = {
    ID = 18005,
    CnID = "跳转@主线普通5-6",
    BaseSortID = 160,
    Desc = "ItemGets_18005_Desc|主线普通5-6",
    Order = 160,
    JumpFunc = "Stage",
    Param1 = 8154
  },
  [18004] = {
    ID = 18004,
    CnID = "跳转@主线普通5-7",
    BaseSortID = 161,
    Desc = "ItemGets_18004_Desc|主线普通5-7",
    Order = 161,
    JumpFunc = "Stage",
    Param1 = 8155
  },
  [18013] = {
    ID = 18013,
    CnID = "跳转@主线普通5-8",
    BaseSortID = 162,
    Desc = "ItemGets_18013_Desc|主线普通5-8",
    Order = 162,
    JumpFunc = "Stage",
    Param1 = 8158
  },
  [18012] = {
    ID = 18012,
    CnID = "跳转@主线普通5-9",
    BaseSortID = 163,
    Desc = "ItemGets_18012_Desc|主线普通5-9",
    Order = 163,
    JumpFunc = "Stage",
    Param1 = 8159
  },
  [17904] = {
    ID = 17904,
    CnID = "跳转@主线普通5-10",
    BaseSortID = 164,
    Desc = "ItemGets_17904_Desc|主线普通5-10",
    Order = 164,
    JumpFunc = "Stage",
    Param1 = 8175
  },
  [17903] = {
    ID = 17903,
    CnID = "跳转@主线普通5-11",
    BaseSortID = 165,
    Desc = "ItemGets_17903_Desc|主线普通5-11",
    Order = 165,
    JumpFunc = "Stage",
    Param1 = 8176
  },
  [17902] = {
    ID = 17902,
    CnID = "跳转@主线普通5-12",
    BaseSortID = 166,
    Desc = "ItemGets_17902_Desc|主线普通5-12",
    Order = 166,
    JumpFunc = "Stage",
    Param1 = 8177
  },
  [17901] = {
    ID = 17901,
    CnID = "跳转@主线普通5-13",
    BaseSortID = 167,
    Desc = "ItemGets_17901_Desc|主线普通5-13",
    Order = 167,
    JumpFunc = "Stage",
    Param1 = 8178
  },
  [17854] = {
    ID = 17854,
    CnID = "跳转@主线普通5-14",
    BaseSortID = 168,
    Desc = "ItemGets_17854_Desc|主线普通5-14",
    Order = 168,
    JumpFunc = "Stage",
    Param1 = 8174
  },
  [17886] = {
    ID = 17886,
    CnID = "跳转@主线普通6-1",
    BaseSortID = 169,
    Desc = "ItemGets_17886_Desc|主线普通6-1",
    Order = 169,
    JumpFunc = "Stage",
    Param1 = 7659
  },
  [17887] = {
    ID = 17887,
    CnID = "跳转@主线普通6-2",
    BaseSortID = 170,
    Desc = "ItemGets_17887_Desc|主线普通6-2",
    Order = 170,
    JumpFunc = "Stage",
    Param1 = 8022
  },
  [17888] = {
    ID = 17888,
    CnID = "跳转@主线普通6-3",
    BaseSortID = 171,
    Desc = "ItemGets_17888_Desc|主线普通6-3",
    Order = 171,
    JumpFunc = "Stage",
    Param1 = 7664
  },
  [17882] = {
    ID = 17882,
    CnID = "跳转@主线普通6-4",
    BaseSortID = 172,
    Desc = "ItemGets_17882_Desc|主线普通6-4",
    Order = 172,
    JumpFunc = "Stage",
    Param1 = 8016
  },
  [17883] = {
    ID = 17883,
    CnID = "跳转@主线普通6-5",
    BaseSortID = 173,
    Desc = "ItemGets_17883_Desc|主线普通6-5",
    Order = 173,
    JumpFunc = "Stage",
    Param1 = 8015
  },
  [17884] = {
    ID = 17884,
    CnID = "跳转@主线普通6-6",
    BaseSortID = 174,
    Desc = "ItemGets_17884_Desc|主线普通6-6",
    Order = 174,
    JumpFunc = "Stage",
    Param1 = 8018
  },
  [17885] = {
    ID = 17885,
    CnID = "跳转@主线普通6-7",
    BaseSortID = 175,
    Desc = "ItemGets_17885_Desc|主线普通6-7",
    Order = 175,
    JumpFunc = "Stage",
    Param1 = 8017
  },
  [17880] = {
    ID = 17880,
    CnID = "跳转@主线普通6-8",
    BaseSortID = 176,
    Desc = "ItemGets_17880_Desc|主线普通6-8",
    Order = 176,
    JumpFunc = "Stage",
    Param1 = 8014
  },
  [17881] = {
    ID = 17881,
    CnID = "跳转@主线普通6-9",
    BaseSortID = 177,
    Desc = "ItemGets_17881_Desc|主线普通6-9",
    Order = 177,
    JumpFunc = "Stage",
    Param1 = 8013
  },
  [17913] = {
    ID = 17913,
    CnID = "跳转@主线普通6-10",
    BaseSortID = 178,
    Desc = "ItemGets_17913_Desc|主线普通6-10",
    Order = 178,
    JumpFunc = "Stage",
    Param1 = 7885
  },
  [17914] = {
    ID = 17914,
    CnID = "跳转@主线普通6-11",
    BaseSortID = 179,
    Desc = "ItemGets_17914_Desc|主线普通6-11",
    Order = 179,
    JumpFunc = "Stage",
    Param1 = 7884
  },
  [17912] = {
    ID = 17912,
    CnID = "跳转@主线普通6-12",
    BaseSortID = 180,
    Desc = "ItemGets_17912_Desc|主线普通6-12",
    Order = 180,
    JumpFunc = "Stage",
    Param1 = 7886
  },
  [51662] = {
    ID = 51662,
    CnID = "跳转@主线普通6-13",
    BaseSortID = 181,
    Desc = "ItemGets_51662_Desc|主线普通6-13",
    Order = 181,
    JumpFunc = "Stage",
    Param1 = 35130
  },
  [51660] = {
    ID = 51660,
    CnID = "跳转@主线普通6-14",
    BaseSortID = 182,
    Desc = "ItemGets_51660_Desc|主线普通6-14",
    Order = 182,
    JumpFunc = "Stage",
    Param1 = 35129
  },
  [51661] = {
    ID = 51661,
    CnID = "跳转@主线普通6-15",
    BaseSortID = 183,
    Desc = "ItemGets_51661_Desc|主线普通6-15",
    Order = 183,
    JumpFunc = "Stage",
    Param1 = 35857
  },
  [51704] = {
    ID = 51704,
    CnID = "跳转@主线普通7-0",
    BaseSortID = 184,
    Desc = "ItemGets_51704_Desc|主线普通7-0",
    Order = 184,
    JumpFunc = "Stage",
    Param1 = 50345
  },
  [51665] = {
    ID = 51665,
    CnID = "跳转@主线普通7-1",
    BaseSortID = 185,
    Desc = "ItemGets_51665_Desc|主线普通7-1",
    Order = 185,
    JumpFunc = "Stage",
    Param1 = 48060
  },
  [51667] = {
    ID = 51667,
    CnID = "跳转@主线普通7-2",
    BaseSortID = 186,
    Desc = "ItemGets_51667_Desc|主线普通7-2",
    Order = 186,
    JumpFunc = "Stage",
    Param1 = 48061
  },
  [51666] = {
    ID = 51666,
    CnID = "跳转@主线普通7-3",
    BaseSortID = 187,
    Desc = "ItemGets_51666_Desc|主线普通7-3",
    Order = 187,
    JumpFunc = "Stage",
    Param1 = 48062
  },
  [51669] = {
    ID = 51669,
    CnID = "跳转@主线普通7-4",
    BaseSortID = 188,
    Desc = "ItemGets_51669_Desc|主线普通7-4",
    Order = 188,
    JumpFunc = "Stage",
    Param1 = 48056
  },
  [51668] = {
    ID = 51668,
    CnID = "跳转@主线普通7-5",
    BaseSortID = 189,
    Desc = "ItemGets_51668_Desc|主线普通7-5",
    Order = 189,
    JumpFunc = "Stage",
    Param1 = 48057
  },
  [51671] = {
    ID = 51671,
    CnID = "跳转@主线普通7-6",
    BaseSortID = 190,
    Desc = "ItemGets_51671_Desc|主线普通7-6",
    Order = 190,
    JumpFunc = "Stage",
    Param1 = 48058
  },
  [51670] = {
    ID = 51670,
    CnID = "跳转@主线普通7-7",
    BaseSortID = 191,
    Desc = "ItemGets_51670_Desc|主线普通7-7",
    Order = 191,
    JumpFunc = "Stage",
    Param1 = 48059
  },
  [51664] = {
    ID = 51664,
    CnID = "跳转@主线普通7-8",
    BaseSortID = 192,
    Desc = "ItemGets_51664_Desc|主线普通7-8",
    Order = 192,
    JumpFunc = "Stage",
    Param1 = 48063
  },
  [51663] = {
    ID = 51663,
    CnID = "跳转@主线普通7-9",
    BaseSortID = 193,
    Desc = "ItemGets_51663_Desc|主线普通7-9",
    Order = 193,
    JumpFunc = "Stage",
    Param1 = 48064
  },
  [51656] = {
    ID = 51656,
    CnID = "跳转@主线普通7-10",
    BaseSortID = 194,
    Desc = "ItemGets_51656_Desc|主线普通7-10",
    Order = 194,
    JumpFunc = "Stage",
    Param1 = 48075
  },
  [51655] = {
    ID = 51655,
    CnID = "跳转@主线普通7-11",
    BaseSortID = 195,
    Desc = "ItemGets_51655_Desc|主线普通7-11",
    Order = 195,
    JumpFunc = "Stage",
    Param1 = 48076
  },
  [51658] = {
    ID = 51658,
    CnID = "跳转@主线普通7-12",
    BaseSortID = 196,
    Desc = "ItemGets_51658_Desc|主线普通7-12",
    Order = 196,
    JumpFunc = "Stage",
    Param1 = 48073
  },
  [51657] = {
    ID = 51657,
    CnID = "跳转@主线普通7-13",
    BaseSortID = 197,
    Desc = "ItemGets_51657_Desc|主线普通7-13",
    Order = 197,
    JumpFunc = "Stage",
    Param1 = 48074
  },
  [51652] = {
    ID = 51652,
    CnID = "跳转@主线普通7-14",
    BaseSortID = 198,
    Desc = "ItemGets_51652_Desc|主线普通7-14",
    Order = 198,
    JumpFunc = "Stage",
    Param1 = 45411
  },
  [51651] = {
    ID = 51651,
    CnID = "跳转@主线普通7-15",
    BaseSortID = 199,
    Desc = "ItemGets_51651_Desc|主线普通7-15",
    Order = 199,
    JumpFunc = "Stage",
    Param1 = 48072
  },
  [51654] = {
    ID = 51654,
    CnID = "跳转@主线普通7-16",
    BaseSortID = 200,
    Desc = "ItemGets_51654_Desc|主线普通7-16",
    Order = 200,
    JumpFunc = "Stage",
    Param1 = 48070
  },
  [51653] = {
    ID = 51653,
    CnID = "跳转@主线普通7-17",
    BaseSortID = 201,
    Desc = "ItemGets_51653_Desc|主线普通7-17",
    Order = 201,
    JumpFunc = "Stage",
    Param1 = 48071
  },
  [51650] = {
    ID = 51650,
    CnID = "跳转@主线普通7-18",
    BaseSortID = 202,
    Desc = "ItemGets_51650_Desc|主线普通7-18",
    Order = 202,
    JumpFunc = "Stage",
    Param1 = 48068
  },
  [51649] = {
    ID = 51649,
    CnID = "跳转@主线普通7-19",
    BaseSortID = 203,
    Desc = "ItemGets_51649_Desc|主线普通7-19",
    Order = 203,
    JumpFunc = "Stage",
    Param1 = 48069
  },
  [59094] = {
    ID = 59094,
    CnID = "跳转@主线普通8-1",
    BaseSortID = 204,
    Desc = "ItemGets_59094_Desc|主线普通8-1",
    Order = 204,
    JumpFunc = "Stage",
    Param1 = 58986
  },
  [59092] = {
    ID = 59092,
    CnID = "跳转@主线普通8-2",
    BaseSortID = 205,
    Desc = "ItemGets_59092_Desc|主线普通8-2",
    Order = 205,
    JumpFunc = "Stage",
    Param1 = 58988
  },
  [59093] = {
    ID = 59093,
    CnID = "跳转@主线普通8-3",
    BaseSortID = 206,
    Desc = "ItemGets_59093_Desc|主线普通8-3",
    Order = 206,
    JumpFunc = "Stage",
    Param1 = 58979
  },
  [59090] = {
    ID = 59090,
    CnID = "跳转@主线普通8-4",
    BaseSortID = 207,
    Desc = "ItemGets_59090_Desc|主线普通8-4",
    Order = 207,
    JumpFunc = "Stage",
    Param1 = 58981
  },
  [59091] = {
    ID = 59091,
    CnID = "跳转@主线普通8-5",
    BaseSortID = 208,
    Desc = "ItemGets_59091_Desc|主线普通8-5",
    Order = 208,
    JumpFunc = "Stage",
    Param1 = 58980
  },
  [59088] = {
    ID = 59088,
    CnID = "跳转@主线普通8-6",
    BaseSortID = 209,
    Desc = "ItemGets_59088_Desc|主线普通8-6",
    Order = 209,
    JumpFunc = "Stage",
    Param1 = 58987
  },
  [59089] = {
    ID = 59089,
    CnID = "跳转@主线普通8-7",
    BaseSortID = 210,
    Desc = "ItemGets_59089_Desc|主线普通8-7",
    Order = 210,
    JumpFunc = "Stage",
    Param1 = 58977
  },
  [59086] = {
    ID = 59086,
    CnID = "跳转@主线普通8-8",
    BaseSortID = 211,
    Desc = "ItemGets_59086_Desc|主线普通8-8",
    Order = 211,
    JumpFunc = "Stage",
    Param1 = 58977
  },
  [59087] = {
    ID = 59087,
    CnID = "跳转@主线普通8-9",
    BaseSortID = 212,
    Desc = "ItemGets_59087_Desc|主线普通8-9",
    Order = 212,
    JumpFunc = "Stage",
    Param1 = 58976
  },
  [59096] = {
    ID = 59096,
    CnID = "跳转@主线普通8-10",
    BaseSortID = 213,
    Desc = "ItemGets_59096_Desc|主线普通8-10",
    Order = 213,
    JumpFunc = "Stage",
    Param1 = 58985
  },
  [59101] = {
    ID = 59101,
    CnID = "跳转@主线普通8-11",
    BaseSortID = 214,
    Desc = "ItemGets_59101_Desc|主线普通8-11",
    Order = 214,
    JumpFunc = "Stage",
    Param1 = 58984
  },
  [59098] = {
    ID = 59098,
    CnID = "跳转@主线普通8-12",
    BaseSortID = 215,
    Desc = "ItemGets_59098_Desc|主线普通8-12",
    Order = 215,
    JumpFunc = "Stage",
    Param1 = 58983
  },
  [59099] = {
    ID = 59099,
    CnID = "跳转@主线普通8-13",
    BaseSortID = 216,
    Desc = "ItemGets_59099_Desc|主线普通8-13",
    Order = 216,
    JumpFunc = "Stage",
    Param1 = 58982
  },
  [62349] = {
    ID = 62349,
    CnID = "跳转@主线普通8-14",
    BaseSortID = 217,
    Desc = "ItemGets_62349_Desc|主线普通8-14",
    Order = 217,
    JumpFunc = "Stage",
    Param1 = 62348
  },
  [66025] = {
    ID = 66025,
    CnID = "跳转@主线普通9-1",
    BaseSortID = 218,
    Desc = "ItemGets_66025_Desc|主线普通9-1",
    Order = 218,
    JumpFunc = "Stage",
    Param1 = 59505
  },
  [66024] = {
    ID = 66024,
    CnID = "跳转@主线普通9-2",
    BaseSortID = 219,
    Desc = "ItemGets_66024_Desc|主线普通9-2",
    Order = 219,
    JumpFunc = "Stage",
    Param1 = 59503
  },
  [66023] = {
    ID = 66023,
    CnID = "跳转@主线普通9-3",
    BaseSortID = 220,
    Desc = "ItemGets_66023_Desc|主线普通9-3",
    Order = 220,
    JumpFunc = "Stage",
    Param1 = 59504
  },
  [66027] = {
    ID = 66027,
    CnID = "跳转@主线普通9-4",
    BaseSortID = 221,
    Desc = "ItemGets_66027_Desc|主线普通9-4",
    Order = 221,
    JumpFunc = "Stage",
    Param1 = 59502
  },
  [66026] = {
    ID = 66026,
    CnID = "跳转@主线普通9-5",
    BaseSortID = 222,
    Desc = "ItemGets_66026_Desc|主线普通9-5",
    Order = 222,
    JumpFunc = "Stage",
    Param1 = 66016
  },
  [68289] = {
    ID = 68289,
    CnID = "跳转@主线普通9-6",
    BaseSortID = 223,
    Desc = "ItemGets_68289_Desc|主线普通9-6",
    Order = 223,
    JumpFunc = "Stage",
    Param1 = 67903
  },
  [68288] = {
    ID = 68288,
    CnID = "跳转@主线普通9-7",
    BaseSortID = 224,
    Desc = "ItemGets_68288_Desc|主线普通9-7",
    Order = 224,
    JumpFunc = "Stage",
    Param1 = 67904
  },
  [68291] = {
    ID = 68291,
    CnID = "跳转@主线普通9-8",
    BaseSortID = 225,
    Desc = "ItemGets_68291_Desc|主线普通9-8",
    Order = 225,
    JumpFunc = "Stage",
    Param1 = 67909
  },
  [68290] = {
    ID = 68290,
    CnID = "跳转@主线普通9-9",
    BaseSortID = 226,
    Desc = "ItemGets_68290_Desc|主线普通9-9",
    Order = 226,
    JumpFunc = "Stage",
    Param1 = 67902
  },
  [68287] = {
    ID = 68287,
    CnID = "跳转@主线普通9-10",
    BaseSortID = 227,
    Desc = "ItemGets_68287_Desc|主线普通9-10",
    Order = 227,
    JumpFunc = "Stage",
    Param1 = 67911
  },
  [68286] = {
    ID = 68286,
    CnID = "跳转@主线普通9-11",
    BaseSortID = 228,
    Desc = "ItemGets_68286_Desc|主线普通9-11",
    Order = 228,
    JumpFunc = "Stage",
    Param1 = 67912
  },
  [68285] = {
    ID = 68285,
    CnID = "跳转@主线普通9-12",
    BaseSortID = 229,
    Desc = "ItemGets_68285_Desc|主线普通9-12",
    Order = 229,
    JumpFunc = "Stage",
    Param1 = 67913
  },
  [68284] = {
    ID = 68284,
    CnID = "跳转@主线普通9-13",
    BaseSortID = 230,
    Desc = "ItemGets_68284_Desc|主线普通9-13",
    Order = 230,
    JumpFunc = "Stage",
    Param1 = 67914
  },
  [76302] = {
    ID = 76302,
    CnID = "跳转@星辰篇普通1_1",
    BaseSortID = 231,
    Desc = "ItemGets_76302_Desc|星辰篇普通1-1",
    Order = 231,
    JumpFunc = "Stage",
    Param1 = 70937
  },
  [76303] = {
    ID = 76303,
    CnID = "跳转@星辰篇普通1_2",
    BaseSortID = 232,
    Desc = "ItemGets_76303_Desc|星辰篇普通1-2",
    Order = 232,
    JumpFunc = "Stage",
    Param1 = 70936
  },
  [76304] = {
    ID = 76304,
    CnID = "跳转@星辰篇普通1_3",
    BaseSortID = 233,
    Desc = "ItemGets_76304_Desc|星辰篇普通1-3",
    Order = 233,
    JumpFunc = "Stage",
    Param1 = 70935
  },
  [76305] = {
    ID = 76305,
    CnID = "跳转@星辰篇普通1_4",
    BaseSortID = 234,
    Desc = "ItemGets_76305_Desc|星辰篇普通1-4",
    Order = 234,
    JumpFunc = "Stage",
    Param1 = 70934
  },
  [76306] = {
    ID = 76306,
    CnID = "跳转@星辰篇普通1_5",
    BaseSortID = 235,
    Desc = "ItemGets_76306_Desc|星辰篇普通1-5",
    Order = 235,
    JumpFunc = "Stage",
    Param1 = 70933
  },
  [76307] = {
    ID = 76307,
    CnID = "跳转@星辰篇普通1_6",
    BaseSortID = 236,
    Desc = "ItemGets_76307_Desc|星辰篇普通1-6",
    Order = 236,
    JumpFunc = "Stage",
    Param1 = 70932
  },
  [76308] = {
    ID = 76308,
    CnID = "跳转@星辰篇普通1_7",
    BaseSortID = 237,
    Desc = "ItemGets_76308_Desc|星辰篇普通1-7",
    Order = 237,
    JumpFunc = "Stage",
    Param1 = 70931
  },
  [76299] = {
    ID = 76299,
    CnID = "跳转@星辰篇普通1_8",
    BaseSortID = 238,
    Desc = "ItemGets_76299_Desc|星辰篇普通1-8",
    Order = 238,
    JumpFunc = "Stage",
    Param1 = 70930
  },
  [76300] = {
    ID = 76300,
    CnID = "跳转@星辰篇普通1_9",
    BaseSortID = 239,
    Desc = "ItemGets_76300_Desc|星辰篇普通1-9",
    Order = 239,
    JumpFunc = "Stage",
    Param1 = 70929
  },
  [76311] = {
    ID = 76311,
    CnID = "跳转@星辰篇普通1_10",
    BaseSortID = 240,
    Desc = "ItemGets_76311_Desc|星辰篇普通1-10",
    Order = 240,
    JumpFunc = "Stage",
    Param1 = 70927
  },
  [76312] = {
    ID = 76312,
    CnID = "跳转@星辰篇普通1_11",
    BaseSortID = 241,
    Desc = "ItemGets_76312_Desc|星辰篇普通1-11",
    Order = 241,
    JumpFunc = "Stage",
    Param1 = 70926
  },
  [76309] = {
    ID = 76309,
    CnID = "跳转@星辰篇普通1_12",
    BaseSortID = 242,
    Desc = "ItemGets_76309_Desc|星辰篇普通1-12",
    Order = 242,
    JumpFunc = "Stage",
    Param1 = 70925
  },
  [76310] = {
    ID = 76310,
    CnID = "跳转@星辰篇普通1_13",
    BaseSortID = 243,
    Desc = "ItemGets_76310_Desc|星辰篇普通1-13",
    Order = 243,
    JumpFunc = "Stage",
    Param1 = 70924
  },
  [76313] = {
    ID = 76313,
    CnID = "跳转@星辰篇普通1_14",
    BaseSortID = 244,
    Desc = "ItemGets_76313_Desc|星辰篇普通1-14",
    Order = 244,
    JumpFunc = "Stage",
    Param1 = 70928
  },
  [80406] = {
    ID = 80406,
    CnID = "跳转@星辰篇普通2_1",
    BaseSortID = 245,
    Desc = "ItemGets_80406_Desc|星辰篇普通2-1",
    Order = 245,
    JumpFunc = "Stage",
    Param1 = 80251
  },
  [80405] = {
    ID = 80405,
    CnID = "跳转@星辰篇普通2_2",
    BaseSortID = 246,
    Desc = "ItemGets_80405_Desc|星辰篇普通2-2",
    Order = 246,
    JumpFunc = "Stage",
    Param1 = 80252
  },
  [80404] = {
    ID = 80404,
    CnID = "跳转@星辰篇普通2_3",
    BaseSortID = 247,
    Desc = "ItemGets_80404_Desc|星辰篇普通2-3",
    Order = 247,
    JumpFunc = "Stage",
    Param1 = 80253
  },
  [80403] = {
    ID = 80403,
    CnID = "跳转@星辰篇普通2_4",
    BaseSortID = 248,
    Desc = "ItemGets_80403_Desc|星辰篇普通2-4",
    Order = 248,
    JumpFunc = "Stage",
    Param1 = 80254
  },
  [80402] = {
    ID = 80402,
    CnID = "跳转@星辰篇普通2_5",
    BaseSortID = 249,
    Desc = "ItemGets_80402_Desc|星辰篇普通2-5",
    Order = 249,
    JumpFunc = "Stage",
    Param1 = 80255
  },
  [80401] = {
    ID = 80401,
    CnID = "跳转@星辰篇普通2_6",
    BaseSortID = 250,
    Desc = "ItemGets_80401_Desc|星辰篇普通2-6",
    Order = 250,
    JumpFunc = "Stage",
    Param1 = 80256
  },
  [80400] = {
    ID = 80400,
    CnID = "跳转@星辰篇普通2_7",
    BaseSortID = 251,
    Desc = "ItemGets_80400_Desc|星辰篇普通2-7",
    Order = 251,
    JumpFunc = "Stage",
    Param1 = 80257
  },
  [80408] = {
    ID = 80408,
    CnID = "跳转@星辰篇普通2_8",
    BaseSortID = 252,
    Desc = "ItemGets_80408_Desc|星辰篇普通2-8",
    Order = 252,
    JumpFunc = "Stage",
    Param1 = 80258
  },
  [80407] = {
    ID = 80407,
    CnID = "跳转@星辰篇普通2_9",
    BaseSortID = 253,
    Desc = "ItemGets_80407_Desc|星辰篇普通2-9",
    Order = 253,
    JumpFunc = "Stage",
    Param1 = 80259
  },
  [80413] = {
    ID = 80413,
    CnID = "跳转@星辰篇普通2_10",
    BaseSortID = 254,
    Desc = "ItemGets_80413_Desc|星辰篇普通2-10",
    Order = 254,
    JumpFunc = "Stage",
    Param1 = 80245
  },
  [80412] = {
    ID = 80412,
    CnID = "跳转@星辰篇普通2_11",
    BaseSortID = 255,
    Desc = "ItemGets_80412_Desc|星辰篇普通2-11",
    Order = 255,
    JumpFunc = "Stage",
    Param1 = 80246
  },
  [80411] = {
    ID = 80411,
    CnID = "跳转@星辰篇普通2_12",
    BaseSortID = 256,
    Desc = "ItemGets_80411_Desc|星辰篇普通2-12",
    Order = 256,
    JumpFunc = "Stage",
    Param1 = 80243
  },
  [80410] = {
    ID = 80410,
    CnID = "跳转@星辰篇普通2_13",
    BaseSortID = 257,
    Desc = "ItemGets_80410_Desc|星辰篇普通2-13",
    Order = 257,
    JumpFunc = "Stage",
    Param1 = 80244
  },
  [80417] = {
    ID = 80417,
    CnID = "跳转@星辰篇普通2_14",
    BaseSortID = 258,
    Desc = "ItemGets_80417_Desc|星辰篇普通2-14",
    Order = 258,
    JumpFunc = "Stage",
    Param1 = 80249
  },
  [80416] = {
    ID = 80416,
    CnID = "跳转@星辰篇普通2_15",
    BaseSortID = 259,
    Desc = "ItemGets_80416_Desc|星辰篇普通2-15",
    Order = 259,
    JumpFunc = "Stage",
    Param1 = 80250
  },
  [80415] = {
    ID = 80415,
    CnID = "跳转@星辰篇普通2_16",
    BaseSortID = 260,
    Desc = "ItemGets_80415_Desc|星辰篇普通2-16",
    Order = 260,
    JumpFunc = "Stage",
    Param1 = 80247
  },
  [80414] = {
    ID = 80414,
    CnID = "跳转@星辰篇普通2_17",
    BaseSortID = 261,
    Desc = "ItemGets_80414_Desc|星辰篇普通2-17",
    Order = 261,
    JumpFunc = "Stage",
    Param1 = 80248
  },
  [80409] = {
    ID = 80409,
    CnID = "跳转@星辰篇普通2_18",
    BaseSortID = 262,
    Desc = "ItemGets_80409_Desc|星辰篇普通2-18",
    Order = 262,
    JumpFunc = "Stage",
    Param1 = 80242
  },
  [95560] = {
    ID = 95560,
    CnID = "跳转@星辰篇普通3_1",
    BaseSortID = 263,
    Desc = "ItemGets_95560_Desc|星辰篇普通3-1",
    Order = 263,
    JumpFunc = "Stage",
    Param1 = 90676
  },
  [95550] = {
    ID = 95550,
    CnID = "跳转@星辰篇普通3_2",
    BaseSortID = 264,
    Desc = "ItemGets_95550_Desc|星辰篇普通3-2",
    Order = 264,
    JumpFunc = "Stage",
    Param1 = 90679
  },
  [95559] = {
    ID = 95559,
    CnID = "跳转@星辰篇普通3_3",
    BaseSortID = 265,
    Desc = "ItemGets_95559_Desc|星辰篇普通3-3",
    Order = 265,
    JumpFunc = "Stage",
    Param1 = 90672
  },
  [95549] = {
    ID = 95549,
    CnID = "跳转@星辰篇普通3_4",
    BaseSortID = 266,
    Desc = "ItemGets_95549_Desc|星辰篇普通3-4",
    Order = 266,
    JumpFunc = "Stage",
    Param1 = 90671
  },
  [95552] = {
    ID = 95552,
    CnID = "跳转@星辰篇普通3_5",
    BaseSortID = 267,
    Desc = "ItemGets_95552_Desc|星辰篇普通3-5",
    Order = 267,
    JumpFunc = "Stage",
    Param1 = 90666
  },
  [95558] = {
    ID = 95558,
    CnID = "跳转@星辰篇普通3_6",
    BaseSortID = 268,
    Desc = "ItemGets_95558_Desc|星辰篇普通3-6",
    Order = 268,
    JumpFunc = "Stage",
    Param1 = 90667
  },
  [95556] = {
    ID = 95556,
    CnID = "跳转@星辰篇普通3_7",
    BaseSortID = 269,
    Desc = "ItemGets_95556_Desc|星辰篇普通3-7",
    Order = 269,
    JumpFunc = "Stage",
    Param1 = 90684
  },
  [95561] = {
    ID = 95561,
    CnID = "跳转@星辰篇普通3_8",
    BaseSortID = 270,
    Desc = "ItemGets_95561_Desc|星辰篇普通3-8",
    Order = 270,
    JumpFunc = "Stage",
    Param1 = 90664
  },
  [95553] = {
    ID = 95553,
    CnID = "跳转@星辰篇普通3_9",
    BaseSortID = 271,
    Desc = "ItemGets_95553_Desc|星辰篇普通3-9",
    Order = 271,
    JumpFunc = "Stage",
    Param1 = 90681
  },
  [95555] = {
    ID = 95555,
    CnID = "跳转@星辰篇普通3_10",
    BaseSortID = 272,
    Desc = "ItemGets_95555_Desc|星辰篇普通3-10",
    Order = 272,
    JumpFunc = "Stage",
    Param1 = 90687
  },
  [95554] = {
    ID = 95554,
    CnID = "跳转@星辰篇普通3_11",
    BaseSortID = 273,
    Desc = "ItemGets_95554_Desc|星辰篇普通3-11",
    Order = 273,
    JumpFunc = "Stage",
    Param1 = 90680
  },
  [118172] = {
    ID = 118172,
    CnID = "跳转@星辰篇普通4_0",
    BaseSortID = 274,
    Desc = "ItemGets_118172_Desc|星辰篇普通4-0",
    Order = 274,
    JumpFunc = "Stage",
    Param1 = 118156
  },
  [118170] = {
    ID = 118170,
    CnID = "跳转@星辰篇普通4_1",
    BaseSortID = 275,
    Desc = "ItemGets_118170_Desc|星辰篇普通4-1",
    Order = 275,
    JumpFunc = "Stage",
    Param1 = 118153
  },
  [118175] = {
    ID = 118175,
    CnID = "跳转@星辰篇普通4_2",
    BaseSortID = 276,
    Desc = "ItemGets_118175_Desc|星辰篇普通4-2",
    Order = 276,
    JumpFunc = "Stage",
    Param1 = 118139
  },
  [118169] = {
    ID = 118169,
    CnID = "跳转@星辰篇普通4_3",
    BaseSortID = 277,
    Desc = "ItemGets_118169_Desc|星辰篇普通4-3",
    Order = 277,
    JumpFunc = "Stage",
    Param1 = 118142
  },
  [118161] = {
    ID = 118161,
    CnID = "跳转@星辰篇普通4_4",
    BaseSortID = 278,
    Desc = "ItemGets_118161_Desc|星辰篇普通4-4",
    Order = 278,
    JumpFunc = "Stage",
    Param1 = 118148
  },
  [118165] = {
    ID = 118165,
    CnID = "跳转@星辰篇普通4_5",
    BaseSortID = 279,
    Desc = "ItemGets_118165_Desc|星辰篇普通4-5",
    Order = 279,
    JumpFunc = "Stage",
    Param1 = 118140
  },
  [118159] = {
    ID = 118159,
    CnID = "跳转@星辰篇普通4_6",
    BaseSortID = 280,
    Desc = "ItemGets_118159_Desc|星辰篇普通4-6",
    Order = 280,
    JumpFunc = "Stage",
    Param1 = 118147
  },
  [118168] = {
    ID = 118168,
    CnID = "跳转@星辰篇普通4_7",
    BaseSortID = 281,
    Desc = "ItemGets_118168_Desc|星辰篇普通4-7",
    Order = 281,
    JumpFunc = "Stage",
    Param1 = 118150
  },
  [118163] = {
    ID = 118163,
    CnID = "跳转@星辰篇普通4_8",
    BaseSortID = 282,
    Desc = "ItemGets_118163_Desc|星辰篇普通4-8",
    Order = 282,
    JumpFunc = "Stage",
    Param1 = 118143
  },
  [118173] = {
    ID = 118173,
    CnID = "跳转@星辰篇普通4_9",
    BaseSortID = 283,
    Desc = "ItemGets_118173_Desc|星辰篇普通4-9",
    Order = 283,
    JumpFunc = "Stage",
    Param1 = 118132
  },
  [118176] = {
    ID = 118176,
    CnID = "跳转@星辰篇普通4_10",
    BaseSortID = 284,
    Desc = "ItemGets_118176_Desc|星辰篇普通4-10",
    Order = 284,
    JumpFunc = "Stage",
    Param1 = 118134
  },
  [118162] = {
    ID = 118162,
    CnID = "跳转@星辰篇普通4_11",
    BaseSortID = 285,
    Desc = "ItemGets_118162_Desc|星辰篇普通4-11",
    Order = 285,
    JumpFunc = "Stage",
    Param1 = 118151
  },
  [118174] = {
    ID = 118174,
    CnID = "跳转@星辰篇普通4_12",
    BaseSortID = 286,
    Desc = "ItemGets_118174_Desc|星辰篇普通4-12",
    Order = 286,
    JumpFunc = "Stage",
    Param1 = 118141
  },
  [118164] = {
    ID = 118164,
    CnID = "跳转@星辰篇普通4_13",
    BaseSortID = 287,
    Desc = "ItemGets_118164_Desc|星辰篇普通4-13",
    Order = 287,
    JumpFunc = "Stage",
    Param1 = 118144
  },
  [118177] = {
    ID = 118177,
    CnID = "跳转@星辰篇普通4_14",
    BaseSortID = 288,
    Desc = "ItemGets_118177_Desc|星辰篇普通4-14",
    Order = 288,
    JumpFunc = "Stage",
    Param1 = 118138
  },
  [118160] = {
    ID = 118160,
    CnID = "跳转@星辰篇普通4_15",
    BaseSortID = 289,
    Desc = "ItemGets_118160_Desc|星辰篇普通4-15",
    Order = 289,
    JumpFunc = "Stage",
    Param1 = 118152
  },
  [118167] = {
    ID = 118167,
    CnID = "跳转@星辰篇普通4_16",
    BaseSortID = 290,
    Desc = "ItemGets_118167_Desc|星辰篇普通4-16",
    Order = 290,
    JumpFunc = "Stage",
    Param1 = 118146
  },
  [126368] = {
    ID = 126368,
    CnID = "跳转@星辰篇普通5_1",
    BaseSortID = 291,
    Desc = "ItemGets_126368_Desc|星辰篇普通5-1",
    Order = 291,
    JumpFunc = "Stage",
    Param1 = 125643
  },
  [126371] = {
    ID = 126371,
    CnID = "跳转@星辰篇普通5_2",
    BaseSortID = 292,
    Desc = "ItemGets_126371_Desc|星辰篇普通5-2",
    Order = 292,
    JumpFunc = "Stage",
    Param1 = 125653
  },
  [126377] = {
    ID = 126377,
    CnID = "跳转@星辰篇普通5_3",
    BaseSortID = 293,
    Desc = "ItemGets_126377_Desc|星辰篇普通5-3",
    Order = 293,
    JumpFunc = "Stage",
    Param1 = 125656
  },
  [126384] = {
    ID = 126384,
    CnID = "跳转@星辰篇普通5_4",
    BaseSortID = 294,
    Desc = "ItemGets_126384_Desc|星辰篇普通5-4",
    Order = 294,
    JumpFunc = "Stage",
    Param1 = 125662
  },
  [126378] = {
    ID = 126378,
    CnID = "跳转@星辰篇普通5_5",
    BaseSortID = 295,
    Desc = "ItemGets_126378_Desc|星辰篇普通5-5",
    Order = 295,
    JumpFunc = "Stage",
    Param1 = 125642
  },
  [126367] = {
    ID = 126367,
    CnID = "跳转@星辰篇普通5_6",
    BaseSortID = 296,
    Desc = "ItemGets_126367_Desc|星辰篇普通5-6",
    Order = 296,
    JumpFunc = "Stage",
    Param1 = 125660
  },
  [126383] = {
    ID = 126383,
    CnID = "跳转@星辰篇普通5_7",
    BaseSortID = 297,
    Desc = "ItemGets_126383_Desc|星辰篇普通5-7",
    Order = 297,
    JumpFunc = "Stage",
    Param1 = 125652
  },
  [126374] = {
    ID = 126374,
    CnID = "跳转@星辰篇普通5_8",
    BaseSortID = 298,
    Desc = "ItemGets_126374_Desc|星辰篇普通5-8",
    Order = 298,
    JumpFunc = "Stage",
    Param1 = 125640
  },
  [126369] = {
    ID = 126369,
    CnID = "跳转@星辰篇普通5_9",
    BaseSortID = 299,
    Desc = "ItemGets_126369_Desc|星辰篇普通5-9",
    Order = 299,
    JumpFunc = "Stage",
    Param1 = 125647
  },
  [126381] = {
    ID = 126381,
    CnID = "跳转@星辰篇普通5_10",
    BaseSortID = 300,
    Desc = "ItemGets_126381_Desc|星辰篇普通5-10",
    Order = 300,
    JumpFunc = "Stage",
    Param1 = 125651
  },
  [126379] = {
    ID = 126379,
    CnID = "跳转@星辰篇普通5_11",
    BaseSortID = 301,
    Desc = "ItemGets_126379_Desc|星辰篇普通5-11",
    Order = 301,
    JumpFunc = "Stage",
    Param1 = 125648
  },
  [126372] = {
    ID = 126372,
    CnID = "跳转@星辰篇普通5_12",
    BaseSortID = 302,
    Desc = "ItemGets_126372_Desc|星辰篇普通5-12",
    Order = 302,
    JumpFunc = "Stage",
    Param1 = 125654
  },
  [126380] = {
    ID = 126380,
    CnID = "跳转@星辰篇普通5_13",
    BaseSortID = 303,
    Desc = "ItemGets_126380_Desc|星辰篇普通5-13",
    Order = 303,
    JumpFunc = "Stage",
    Param1 = 125645
  },
  [126373] = {
    ID = 126373,
    CnID = "跳转@星辰篇普通5_14",
    BaseSortID = 304,
    Desc = "ItemGets_126373_Desc|星辰篇普通5-14",
    Order = 304,
    JumpFunc = "Stage",
    Param1 = 125655
  },
  [126375] = {
    ID = 126375,
    CnID = "跳转@星辰篇普通5_15",
    BaseSortID = 305,
    Desc = "ItemGets_126375_Desc|星辰篇普通5-15",
    Order = 305,
    JumpFunc = "Stage",
    Param1 = 125663
  },
  [126376] = {
    ID = 126376,
    CnID = "跳转@星辰篇普通5_16",
    BaseSortID = 306,
    Desc = "ItemGets_126376_Desc|星辰篇普通5-16",
    Order = 306,
    JumpFunc = "Stage",
    Param1 = 125646
  },
  [146366] = {
    ID = 146366,
    CnID = "跳转@星辰篇普通6_1",
    BaseSortID = 307,
    Desc = "ItemGets_146366_Desc|星辰篇普通6-1",
    Order = 307,
    JumpFunc = "Stage",
    Param1 = 146251
  },
  [146372] = {
    ID = 146372,
    CnID = "跳转@星辰篇普通6_2",
    BaseSortID = 308,
    Desc = "ItemGets_146372_Desc|星辰篇普通6-2",
    Order = 308,
    JumpFunc = "Stage",
    Param1 = 146239
  },
  [146375] = {
    ID = 146375,
    CnID = "跳转@星辰篇普通6_3",
    BaseSortID = 309,
    Desc = "ItemGets_146375_Desc|星辰篇普通6-3",
    Order = 309,
    JumpFunc = "Stage",
    Param1 = 146238
  },
  [146374] = {
    ID = 146374,
    CnID = "跳转@星辰篇普通6_4",
    BaseSortID = 310,
    Desc = "ItemGets_146374_Desc|星辰篇普通6-4",
    Order = 310,
    JumpFunc = "Stage",
    Param1 = 146233
  },
  [146368] = {
    ID = 146368,
    CnID = "跳转@星辰篇普通6_5",
    BaseSortID = 311,
    Desc = "ItemGets_146368_Desc|星辰篇普通6-5",
    Order = 311,
    JumpFunc = "Stage",
    Param1 = 146241
  },
  [146380] = {
    ID = 146380,
    CnID = "跳转@星辰篇普通6_6",
    BaseSortID = 312,
    Desc = "ItemGets_146380_Desc|星辰篇普通6-6",
    Order = 312,
    JumpFunc = "Stage",
    Param1 = 146250
  },
  [146376] = {
    ID = 146376,
    CnID = "跳转@星辰篇普通6_7",
    BaseSortID = 313,
    Desc = "ItemGets_146376_Desc|星辰篇普通6-7",
    Order = 313,
    JumpFunc = "Stage",
    Param1 = 146244
  },
  [146379] = {
    ID = 146379,
    CnID = "跳转@星辰篇普通6_8",
    BaseSortID = 314,
    Desc = "ItemGets_146379_Desc|星辰篇普通6-8",
    Order = 314,
    JumpFunc = "Stage",
    Param1 = 146240
  },
  [146367] = {
    ID = 146367,
    CnID = "跳转@星辰篇普通6_9",
    BaseSortID = 315,
    Desc = "ItemGets_146367_Desc|星辰篇普通6-9",
    Order = 315,
    JumpFunc = "Stage",
    Param1 = 146232
  },
  [146373] = {
    ID = 146373,
    CnID = "跳转@星辰篇普通6_10",
    BaseSortID = 316,
    Desc = "ItemGets_146373_Desc|星辰篇普通6-10",
    Order = 316,
    JumpFunc = "Stage",
    Param1 = 146236
  },
  [146370] = {
    ID = 146370,
    CnID = "跳转@星辰篇普通6_11",
    BaseSortID = 317,
    Desc = "ItemGets_146370_Desc|星辰篇普通6-11",
    Order = 317,
    JumpFunc = "Stage",
    Param1 = 146234
  },
  [146377] = {
    ID = 146377,
    CnID = "跳转@星辰篇普通6_12",
    BaseSortID = 318,
    Desc = "ItemGets_146377_Desc|星辰篇普通6-12",
    Order = 318,
    JumpFunc = "Stage",
    Param1 = 146254
  },
  [146371] = {
    ID = 146371,
    CnID = "跳转@星辰篇普通6_13",
    BaseSortID = 319,
    Desc = "ItemGets_146371_Desc|星辰篇普通6-13",
    Order = 319,
    JumpFunc = "Stage",
    Param1 = 146248
  },
  [146364] = {
    ID = 146364,
    CnID = "跳转@星辰篇普通6_14",
    BaseSortID = 320,
    Desc = "ItemGets_146364_Desc|星辰篇普通6-14",
    Order = 320,
    JumpFunc = "Stage",
    Param1 = 146245
  },
  [146365] = {
    ID = 146365,
    CnID = "跳转@星辰篇普通6_15",
    BaseSortID = 321,
    Desc = "ItemGets_146365_Desc|星辰篇普通6-15",
    Order = 321,
    JumpFunc = "Stage",
    Param1 = 146246
  },
  [146369] = {
    ID = 146369,
    CnID = "跳转@星辰篇普通6_16",
    BaseSortID = 322,
    Desc = "ItemGets_146369_Desc|星辰篇普通6-16",
    Order = 322,
    JumpFunc = "Stage",
    Param1 = 146255
  },
  [146378] = {
    ID = 146378,
    CnID = "跳转@星辰篇普通6_17",
    BaseSortID = 323,
    Desc = "ItemGets_146378_Desc|星辰篇普通6-17",
    Order = 323,
    JumpFunc = "Stage",
    Param1 = 146355
  },
  [17969] = {
    ID = 17969,
    CnID = "跳转@充值",
    BaseSortID = 324,
    Desc = "ItemGets_17969_Desc|源液提取",
    Order = 324,
    JumpFunc = 16957
  },
  [17976] = {
    ID = 17976,
    CnID = "跳转@金币商店",
    BaseSortID = 325,
    Desc = "ItemGets_17976_Desc|金券兑换",
    Order = 325,
    JumpFunc = 17002
  },
  [18000] = {
    ID = 18000,
    CnID = "跳转@银芯购买商店",
    BaseSortID = 326,
    Desc = "ItemGets_18000_Desc|银芯购买",
    Order = 326,
    JumpFunc = 17023
  },
  [20787] = {
    ID = 20787,
    CnID = "跳转@主线代币商店",
    BaseSortID = 327,
    Desc = "ItemGets_20787_Desc|调查兑换",
    Order = 327,
    JumpFunc = 20785
  },
  [20788] = {
    ID = 20788,
    CnID = "跳转@界域塔代币商店",
    BaseSortID = 328,
    Desc = "ItemGets_20788_Desc|无光兑换",
    Order = 328,
    JumpFunc = 20786
  },
  [17891] = {
    ID = 17891,
    CnID = "跳转@炼金-混沌高级材料",
    BaseSortID = 329,
    Desc = "ItemGets_17891_Desc|材料合成",
    Order = 329,
    JumpFunc = "ItemConversion",
    Param1 = 17111
  },
  [17940] = {
    ID = 17940,
    CnID = "跳转@炼金-混沌中级材料",
    BaseSortID = 330,
    Desc = "ItemGets_17940_Desc|材料合成",
    Order = 330,
    JumpFunc = "ItemConversion",
    Param1 = 17112
  },
  [17994] = {
    ID = 17994,
    CnID = "跳转@炼金-深海高级材料",
    BaseSortID = 331,
    Desc = "ItemGets_17994_Desc|材料合成",
    Order = 331,
    JumpFunc = "ItemConversion",
    Param1 = 17113
  },
  [17876] = {
    ID = 17876,
    CnID = "跳转@炼金-深海中级材料",
    BaseSortID = 332,
    Desc = "ItemGets_17876_Desc|材料合成",
    Order = 332,
    JumpFunc = "ItemConversion",
    Param1 = 17107
  },
  [17944] = {
    ID = 17944,
    CnID = "跳转@炼金-血肉高级材料",
    BaseSortID = 333,
    Desc = "ItemGets_17944_Desc|材料合成",
    Order = 333,
    JumpFunc = "ItemConversion",
    Param1 = 17108
  },
  [18014] = {
    ID = 18014,
    CnID = "跳转@炼金-血肉中级材料",
    BaseSortID = 334,
    Desc = "ItemGets_18014_Desc|材料合成",
    Order = 334,
    JumpFunc = "ItemConversion",
    Param1 = 17109
  },
  [18002] = {
    ID = 18002,
    CnID = "跳转@炼金-超维高级材料",
    BaseSortID = 335,
    Desc = "ItemGets_18002_Desc|材料合成",
    Order = 335,
    JumpFunc = "ItemConversion",
    Param1 = 17110
  },
  [17959] = {
    ID = 17959,
    CnID = "跳转@炼金-超维中级材料",
    BaseSortID = 336,
    Desc = "ItemGets_17959_Desc|材料合成",
    Order = 336,
    JumpFunc = "ItemConversion",
    Param1 = 17103
  },
  [17898] = {
    ID = 17898,
    CnID = "跳转@炼金-混沌技能高级材料",
    BaseSortID = 337,
    Desc = "ItemGets_17898_Desc|材料合成",
    Order = 337,
    JumpFunc = "ItemConversion",
    Param1 = 17104
  },
  [17993] = {
    ID = 17993,
    CnID = "跳转@炼金-混沌技能中级材料",
    BaseSortID = 338,
    Desc = "ItemGets_17993_Desc|材料合成",
    Order = 338,
    JumpFunc = "ItemConversion",
    Param1 = 17094
  },
  [17939] = {
    ID = 17939,
    CnID = "跳转@炼金-深海技能高级材料",
    BaseSortID = 339,
    Desc = "ItemGets_17939_Desc|材料合成",
    Order = 339,
    JumpFunc = "ItemConversion",
    Param1 = 17095
  },
  [17935] = {
    ID = 17935,
    CnID = "跳转@炼金-深海技能中级材料",
    BaseSortID = 340,
    Desc = "ItemGets_17935_Desc|材料合成",
    Order = 340,
    JumpFunc = "ItemConversion",
    Param1 = 17092
  },
  [17915] = {
    ID = 17915,
    CnID = "跳转@炼金-血肉技能高级材料",
    BaseSortID = 341,
    Desc = "ItemGets_17915_Desc|材料合成",
    Order = 341,
    JumpFunc = "ItemConversion",
    Param1 = 17093
  },
  [17991] = {
    ID = 17991,
    CnID = "跳转@炼金-血肉技能中级材料",
    BaseSortID = 342,
    Desc = "ItemGets_17991_Desc|材料合成",
    Order = 342,
    JumpFunc = "ItemConversion",
    Param1 = 17090
  },
  [17989] = {
    ID = 17989,
    CnID = "跳转@炼金-超维技能高级材料",
    BaseSortID = 343,
    Desc = "ItemGets_17989_Desc|材料合成",
    Order = 343,
    JumpFunc = "ItemConversion",
    Param1 = 17091
  },
  [17932] = {
    ID = 17932,
    CnID = "跳转@炼金-超维技能中级材料",
    BaseSortID = 344,
    Desc = "ItemGets_17932_Desc|材料合成",
    Order = 344,
    JumpFunc = "ItemConversion",
    Param1 = 17088
  },
  [17859] = {
    ID = 17859,
    CnID = "跳转@炼金-顶级技能升级材料",
    BaseSortID = 345,
    Desc = "ItemGets_17859_Desc|材料合成",
    Order = 345,
    JumpFunc = "ItemConversion",
    Param1 = 17089
  },
  [17973] = {
    ID = 17973,
    CnID = "跳转@炼金-周常材料1",
    BaseSortID = 346,
    Desc = "ItemGets_17973_Desc|材料合成",
    Order = 346,
    JumpFunc = "ItemConversion",
    Param1 = 17097
  },
  [17975] = {
    ID = 17975,
    CnID = "跳转@炼金-周常材料2",
    BaseSortID = 347,
    Desc = "ItemGets_17975_Desc|材料合成",
    Order = 347,
    JumpFunc = "ItemConversion",
    Param1 = 17098
  },
  [17974] = {
    ID = 17974,
    CnID = "跳转@炼金-周常材料3",
    BaseSortID = 348,
    Desc = "ItemGets_17974_Desc|材料合成",
    Order = 348,
    JumpFunc = "ItemConversion",
    Param1 = 17122
  },
  [17971] = {
    ID = 17971,
    CnID = "跳转@炼金-周常材料4",
    BaseSortID = 349,
    Desc = "ItemGets_17971_Desc|材料合成",
    Order = 349,
    JumpFunc = "ItemConversion",
    Param1 = 17121
  },
  [17970] = {
    ID = 17970,
    CnID = "跳转@炼金-周常材料5",
    BaseSortID = 350,
    Desc = "ItemGets_17970_Desc|材料合成",
    Order = 350,
    JumpFunc = "ItemConversion",
    Param1 = 17120
  },
  [17972] = {
    ID = 17972,
    CnID = "跳转@炼金-周常材料6",
    BaseSortID = 351,
    Desc = "ItemGets_17972_Desc|材料合成",
    Order = 351,
    JumpFunc = "ItemConversion",
    Param1 = 17119
  },
  [49173] = {
    ID = 49173,
    CnID = "跳转@炼金-周常材料7",
    BaseSortID = 352,
    Desc = "ItemGets_49173_Desc|材料合成",
    Order = 352,
    JumpFunc = "ItemConversion",
    Param1 = 48249
  },
  [59097] = {
    ID = 59097,
    CnID = "跳转@炼金-周常材料8",
    BaseSortID = 353,
    Desc = "ItemGets_59097_Desc|材料合成",
    Order = 353,
    JumpFunc = "ItemConversion",
    Param1 = 59102
  },
  [19959] = {
    ID = 19959,
    CnID = "跳转@混沌之域间隙2",
    BaseSortID = 354,
    Desc = "ItemGets_19959_Desc|混沌之域",
    Order = 354,
    JumpFunc = "Stage",
    Param1 = 8094
  },
  [19957] = {
    ID = 19957,
    CnID = "跳转@深海之遗间隙2",
    BaseSortID = 355,
    Desc = "ItemGets_19957_Desc|深海之遗",
    Order = 355,
    JumpFunc = "Stage",
    Param1 = 8146
  },
  [19958] = {
    ID = 19958,
    CnID = "跳转@血肉之沼间隙2",
    BaseSortID = 356,
    Desc = "ItemGets_19958_Desc|血肉之沼",
    Order = 356,
    JumpFunc = "Stage",
    Param1 = 7951
  },
  [19965] = {
    ID = 19965,
    CnID = "跳转@超维之旅间隙2",
    BaseSortID = 357,
    Desc = "ItemGets_19965_Desc|超维之旅",
    Order = 357,
    JumpFunc = "Stage",
    Param1 = 8173
  },
  [19954] = {
    ID = 19954,
    CnID = "跳转@混沌之域间隙4",
    BaseSortID = 358,
    Desc = "ItemGets_19954_Desc|混沌之域",
    Order = 358,
    JumpFunc = "Stage",
    Param1 = 7658
  },
  [19964] = {
    ID = 19964,
    CnID = "跳转@深海之遗间隙4",
    BaseSortID = 359,
    Desc = "ItemGets_19964_Desc|深海之遗",
    Order = 359,
    JumpFunc = "Stage",
    Param1 = 7746
  },
  [19960] = {
    ID = 19960,
    CnID = "跳转@血肉之沼间隙4",
    BaseSortID = 360,
    Desc = "ItemGets_19960_Desc|血肉之沼",
    Order = 360,
    JumpFunc = "Stage",
    Param1 = 7797
  },
  [19962] = {
    ID = 19962,
    CnID = "跳转@超维之旅间隙4",
    BaseSortID = 361,
    Desc = "ItemGets_19962_Desc|超维之旅",
    Order = 361,
    JumpFunc = "Stage",
    Param1 = 7775
  },
  [19956] = {
    ID = 19956,
    CnID = "跳转@混沌之域间隙6",
    BaseSortID = 362,
    Desc = "ItemGets_19956_Desc|混沌之域",
    Order = 362,
    JumpFunc = "Stage",
    Param1 = 8096
  },
  [19953] = {
    ID = 19953,
    CnID = "跳转@深海之遗间隙6",
    BaseSortID = 363,
    Desc = "ItemGets_19953_Desc|深海之遗",
    Order = 363,
    JumpFunc = "Stage",
    Param1 = 8070
  },
  [19955] = {
    ID = 19955,
    CnID = "跳转@血肉之沼间隙6",
    BaseSortID = 364,
    Desc = "ItemGets_19955_Desc|血肉之沼",
    Order = 364,
    JumpFunc = "Stage",
    Param1 = 8033
  },
  [19963] = {
    ID = 19963,
    CnID = "跳转@超维之旅间隙6",
    BaseSortID = 365,
    Desc = "ItemGets_19963_Desc|超维之旅",
    Order = 365,
    JumpFunc = "Stage",
    Param1 = 8101
  },
  [19951] = {
    ID = 19951,
    CnID = "跳转@混沌之域间隙8",
    BaseSortID = 366,
    Desc = "ItemGets_19951_Desc|混沌之域",
    Order = 366,
    JumpFunc = "Stage",
    Param1 = 8166
  },
  [19952] = {
    ID = 19952,
    CnID = "跳转@深海之遗间隙8",
    BaseSortID = 367,
    Desc = "ItemGets_19952_Desc|深海之遗",
    Order = 367,
    JumpFunc = "Stage",
    Param1 = 7935
  },
  [19950] = {
    ID = 19950,
    CnID = "跳转@血肉之沼间隙8",
    BaseSortID = 368,
    Desc = "ItemGets_19950_Desc|血肉之沼",
    Order = 368,
    JumpFunc = "Stage",
    Param1 = 7879
  },
  [19961] = {
    ID = 19961,
    CnID = "跳转@超维之旅间隙8",
    BaseSortID = 369,
    Desc = "ItemGets_19961_Desc|超维之旅",
    Order = 369,
    JumpFunc = "Stage",
    Param1 = 7980
  },
  [21700] = {
    ID = 21700,
    CnID = "跳转@每日任务",
    BaseSortID = 370,
    Desc = "ItemGets_21700_Desc|日常试训",
    Order = 370,
    JumpFunc = 134020
  },
  [25257] = {
    ID = 25257,
    CnID = "跳转@融蚀深渊",
    BaseSortID = 371,
    Desc = "ItemGets_25257_Desc|融灾禁区",
    Order = 371,
    JumpFunc = 25256
  },
  [35499] = {
    ID = 35499,
    CnID = "跳转@SSR命轮分解",
    BaseSortID = 372,
    Desc = "ItemGets_35499_Desc|分解SSR命轮",
    Order = 372,
    JumpFunc = 17045
  },
  [35498] = {
    ID = 35498,
    CnID = "跳转@SSR残片溢出",
    BaseSortID = 373,
    Desc = "ItemGets_35498_Desc|SSR唤醒体残片溢出",
    Order = 373,
    JumpFunc = 17015
  },
  [36171] = {
    ID = 36171,
    CnID = "跳转@超验存在",
    BaseSortID = 374,
    Desc = "ItemGets_36171_Desc|超验存在",
    Order = 374,
    JumpFunc = 21452
  },
  [38853] = {
    ID = 38853,
    CnID = "跳转@湖中之城",
    BaseSortID = 375,
    Desc = "ItemGets_38853_Desc|湖中之城",
    Order = 375,
    JumpFunc = 38851
  },
  [38852] = {
    ID = 38852,
    CnID = "跳转@旺达活动商店",
    BaseSortID = 376,
    Desc = "ItemGets_38852_Desc|旺达的奇珍宝匣",
    Order = 376,
    JumpFunc = 38850
  },
  [39550] = {
    ID = 39550,
    CnID = "跳转@背包密契页签",
    BaseSortID = 377,
    Desc = "ItemGets_39550_Desc|密契",
    Order = 377,
    JumpFunc = "Trinket"
  },
  [44810] = {
    ID = 44810,
    CnID = "跳转@每周试炼",
    BaseSortID = 378,
    Desc = "ItemGets_44810_Desc|周常试训",
    Order = 378,
    JumpFunc = 134019
  },
  [51672] = {
    ID = 51672,
    CnID = "跳转@意识潜游骑士的愿望",
    BaseSortID = 379,
    Desc = "ItemGets_51672_Desc|通关意识潜游-骑士的愿望",
    Order = 379,
    JumpFunc = 17020,
    Param1 = 20452
  },
  [51681] = {
    ID = 51681,
    CnID = "跳转@意识潜游诸事如常",
    BaseSortID = 380,
    Desc = "ItemGets_51681_Desc|通关意识潜游-诸事如常",
    Order = 380,
    JumpFunc = 17020,
    Param1 = 35545
  },
  [51674] = {
    ID = 51674,
    CnID = "跳转@意识潜游血与沙",
    BaseSortID = 381,
    Desc = "ItemGets_51674_Desc|通关意识潜游-血与沙",
    Order = 381,
    JumpFunc = 17020,
    Param1 = 15923
  },
  [51677] = {
    ID = 51677,
    CnID = "跳转@意识潜游扭曲核心",
    BaseSortID = 382,
    Desc = "ItemGets_51677_Desc|通关意识潜游-扭曲核心",
    Order = 382,
    JumpFunc = 17020,
    Param1 = 20448
  },
  [51685] = {
    ID = 51685,
    CnID = "跳转@意识潜游燃烧的群宴",
    BaseSortID = 383,
    Desc = "ItemGets_51685_Desc|通关意识潜游-燃烧的群宴",
    Order = 383,
    JumpFunc = 17020,
    Param1 = 36627
  },
  [51678] = {
    ID = 51678,
    CnID = "跳转@意识潜游如歌的雕琢",
    BaseSortID = 384,
    Desc = "ItemGets_51678_Desc|通关意识潜游-如歌的雕琢",
    Order = 384,
    JumpFunc = 17020,
    Param1 = 20223
  },
  [51683] = {
    ID = 51683,
    CnID = "跳转@意识潜游苍白后裔",
    BaseSortID = 385,
    Desc = "ItemGets_51683_Desc|通关意识潜游-苍白后裔",
    Order = 385,
    JumpFunc = 17020,
    Param1 = 20446
  },
  [51676] = {
    ID = 51676,
    CnID = "跳转@意识潜游一步之遥",
    BaseSortID = 386,
    Desc = "ItemGets_51676_Desc|通关意识潜游-一步之遥",
    Order = 386,
    JumpFunc = 17020,
    Param1 = 24553
  },
  [51682] = {
    ID = 51682,
    CnID = "跳转@特遣纪录雨镇幽影",
    BaseSortID = 387,
    Desc = "ItemGets_51682_Desc|通关特遣纪录-雨镇幽影",
    Order = 387,
    JumpFunc = 17037,
    Param1 = 15947
  },
  [51684] = {
    ID = 51684,
    CnID = "跳转@特遣纪录故事的魔法",
    BaseSortID = 388,
    Desc = "ItemGets_51684_Desc|通关特遣纪录-故事的魔法",
    Order = 388,
    JumpFunc = 17037,
    Param1 = 23622
  },
  [51673] = {
    ID = 51673,
    CnID = "跳转@特遣纪录蔷薇礼赞",
    BaseSortID = 389,
    Desc = "ItemGets_51673_Desc|通关特遣纪录-蔷薇礼赞",
    Order = 389,
    JumpFunc = 17037,
    Param1 = 24436
  },
  [51675] = {
    ID = 51675,
    CnID = "跳转@特遣纪录血的颜色",
    BaseSortID = 390,
    Desc = "ItemGets_51675_Desc|通关特遣纪录-血的颜色",
    Order = 390,
    JumpFunc = 17037,
    Param1 = 44564
  },
  [51680] = {
    ID = 51680,
    CnID = "跳转@意识潜游巨人的陨落",
    BaseSortID = 391,
    Desc = "ItemGets_51680_Desc|通关意识潜游-巨人的陨落",
    Order = 391,
    JumpFunc = 17020,
    Param1 = 43517
  },
  [51679] = {
    ID = 51679,
    CnID = "跳转@特遣纪录宁静的裂殖",
    BaseSortID = 392,
    Desc = "ItemGets_51679_Desc|通关特遣纪录-宁静的裂殖",
    Order = 392,
    JumpFunc = 17037,
    Param1 = 46185
  },
  [52064] = {
    ID = 52064,
    CnID = "跳转@异梦视界亵渎",
    BaseSortID = 393,
    Desc = "ItemGets_52064_Desc|通关异梦视界-亵渎",
    Order = 393,
    JumpFunc = 51757,
    Param1 = 51755
  },
  [56211] = {
    ID = 56211,
    CnID = "跳转@特遣纪录玫瑰的栖居",
    BaseSortID = 394,
    Desc = "ItemGets_56211_Desc|通关特遣纪录-玫瑰的栖居",
    Order = 394,
    JumpFunc = 17037,
    Param1 = 55455
  },
  [58023] = {
    ID = 58023,
    CnID = "跳转@特遣纪录莱克",
    BaseSortID = 395,
    Desc = "ItemGets_58023_Desc|通关特遣纪录-狩猎愉快！",
    Order = 395,
    JumpFunc = 17037,
    Param1 = 56441
  },
  [58024] = {
    ID = 58024,
    CnID = "跳转@特遣纪录本源希洛",
    BaseSortID = 396,
    Desc = "ItemGets_58024_Desc|通关特遣纪录-艾尔沃斯的归人",
    Order = 396,
    JumpFunc = 17037,
    Param1 = 56443
  },
  [71857] = {
    ID = 71857,
    CnID = "跳转@意识潜游图鲁",
    BaseSortID = 397,
    Desc = "ItemGets_71857_Desc|通关意识潜游-加冕之日",
    Order = 397,
    JumpFunc = 17020,
    Param1 = 71850
  },
  [76301] = {
    ID = 76301,
    CnID = "跳转@意识潜游莉兹",
    BaseSortID = 398,
    Desc = "ItemGets_76301_Desc|通关意识潜游-热情归尘",
    Order = 398,
    JumpFunc = 17020,
    Param1 = 74237
  },
  [78944] = {
    ID = 78944,
    CnID = "跳转@相位逆转",
    BaseSortID = 399,
    Desc = "ItemGets_78944_Desc|通关多维连接-逆转回合",
    Order = 399,
    JumpFunc = 78734,
    Param1 = 74338
  },
  [81755] = {
    ID = 81755,
    CnID = "跳转@意识潜游克珀珊特",
    BaseSortID = 400,
    Desc = "ItemGets_81755_Desc|通关意识潜游-最后的引航",
    Order = 400,
    JumpFunc = 17020,
    Param1 = 81262
  },
  [90259] = {
    ID = 90259,
    CnID = "跳转@异梦视界卡斯托尔",
    BaseSortID = 401,
    Desc = "ItemGets_90259_Desc|通关异梦视界-天边之外·上",
    Order = 401,
    JumpFunc = 51757,
    Param1 = 88934
  },
  [94569] = {
    ID = 94569,
    CnID = "跳转@异梦视界罗马活动",
    BaseSortID = 402,
    Desc = "ItemGets_94569_Desc|通关异梦视界-征厨房记",
    Order = 402,
    JumpFunc = 51757,
    Param1 = 91021
  },
  [98318] = {
    ID = 98318,
    CnID = "跳转@意识潜游凯蒂古拉",
    BaseSortID = 403,
    Desc = "ItemGets_98318_Desc|通关意识潜游-不朽极昼",
    Order = 403,
    JumpFunc = 17020,
    Param1 = 95184
  },
  [97738] = {
    ID = 97738,
    CnID = "跳转@异梦视界夏日活动上",
    BaseSortID = 404,
    Desc = "ItemGets_97738_Desc|通关异梦视界-再见永无乡",
    Order = 404,
    JumpFunc = 51757,
    Param1 = 94850
  },
  [99735] = {
    ID = 99735,
    CnID = "跳转@意识潜游皮克曼",
    BaseSortID = 405,
    Desc = "ItemGets_99735_Desc|通关意识潜游-畸世绘",
    Order = 405,
    JumpFunc = 17020,
    Param1 = 96834
  },
  [117490] = {
    ID = 117490,
    CnID = "跳转@异梦视界波吕克斯",
    BaseSortID = 406,
    Desc = "ItemGets_117490_Desc|通关异梦视界-天边之外·下",
    Order = 406,
    JumpFunc = 51757,
    Param1 = 99734
  },
  [120992] = {
    ID = 120992,
    CnID = "跳转@特遣纪录2周年",
    BaseSortID = 407,
    Desc = "ItemGets_120992_Desc|通关特遣纪录-群星咏叹调",
    Order = 407,
    JumpFunc = 17037,
    Param1 = 120952
  },
  [120499] = {
    ID = 120499,
    CnID = "跳转@多维连接茉夏",
    BaseSortID = 408,
    Desc = "ItemGets_120499_Desc|通关多维连接-银与血的洗礼",
    Order = 408,
    JumpFunc = 78734,
    Param1 = 122187
  },
  [127178] = {
    ID = 127178,
    CnID = "跳转@意识潜游徐",
    BaseSortID = 409,
    Desc = "ItemGets_127178_Desc|通关意识潜游-扇下夜谈",
    Order = 409,
    JumpFunc = 17020,
    Param1 = 125338
  },
  [129510] = {
    ID = 129510,
    CnID = "跳转@特遣纪录26年春节",
    BaseSortID = 410,
    Desc = "ItemGets_129510_Desc|通关特遣纪录-开往祈岁节的列车",
    Order = 410,
    JumpFunc = 17037,
    Param1 = 129506
  },
  [130926] = {
    ID = 130926,
    CnID = "跳转@意识潜游莫丝",
    BaseSortID = 411,
    Desc = "ItemGets_130926_Desc|通关意识潜游-沉溺",
    Order = 411,
    JumpFunc = 17020,
    Param1 = 130895
  },
  [132314] = {
    ID = 132314,
    CnID = "跳转@多维连接沙耶",
    BaseSortID = 412,
    Desc = "ItemGets_132314_Desc|通关多维连接-被遗忘的爱之种",
    Order = 412,
    JumpFunc = 78734,
    Param1 = 130167
  },
  [141309] = {
    ID = 141309,
    CnID = "跳转@意识潜游庞托斯",
    BaseSortID = 413,
    Desc = "ItemGets_141309_Desc|通关意识潜游-永远的厄波扬斯",
    Order = 413,
    JumpFunc = 17020,
    Param1 = 141292
  },
  [145385] = {
    ID = 145385,
    CnID = "跳转@意识潜游蚀灭·萝坦",
    BaseSortID = 414,
    Desc = "ItemGets_145385_Desc|通关意识潜游-直至鲸天陨落",
    Order = 414,
    JumpFunc = 17020,
    Param1 = 145356
  },
  [146982] = {
    ID = 146982,
    CnID = "跳转@意识潜游本源奥吉尔",
    BaseSortID = 415,
    Desc = "ItemGets_146982_Desc|通关意识潜游-临时文本",
    Order = 415,
    JumpFunc = 17020,
    Param1 = 146787
  },
  [147550] = {
    ID = 147550,
    CnID = "跳转@意识潜游暮星·汀克特",
    BaseSortID = 416,
    Desc = "ItemGets_147550_Desc|通关意识潜游-临时文本",
    Order = 416,
    JumpFunc = 17020,
    Param1 = 147368
  },
  [97191] = {
    ID = 97191,
    CnID = "跳转@杜勒赛因试玩",
    BaseSortID = 417,
    Desc = "ItemGets_97191_Desc|杜勒赛因试玩",
    Order = 417,
    JumpFunc = "Stage",
    Param1 = 95717
  },
  [97951] = {
    ID = 97951,
    CnID = "跳转@凯蒂古拉试玩",
    BaseSortID = 418,
    Desc = "ItemGets_97951_Desc|凯蒂古拉试玩",
    Order = 418,
    JumpFunc = "Stage",
    Param1 = 78001
  },
  [121068] = {
    ID = 121068,
    CnID = "跳转@泰旖丝试玩",
    BaseSortID = 419,
    Desc = "ItemGets_121068_Desc|泰旖丝试玩",
    Order = 419,
    JumpFunc = "Stage",
    Param1 = 48848
  },
  [123341] = {
    ID = 123341,
    CnID = "跳转@茉夏试玩",
    BaseSortID = 420,
    Desc = "ItemGets_123341_Desc|茉夏试玩",
    Order = 420,
    JumpFunc = "Stage",
    Param1 = 122601
  },
  [125369] = {
    ID = 125369,
    CnID = "跳转@徐试玩",
    BaseSortID = 421,
    Desc = "ItemGets_125369_Desc|徐试玩",
    Order = 421,
    JumpFunc = "Stage",
    Param1 = 125228
  },
  [125874] = {
    ID = 125874,
    CnID = "跳转@24混沌试玩",
    BaseSortID = 422,
    Desc = "ItemGets_125874_Desc|「24」混沌试玩",
    Order = 422,
    JumpFunc = "Stage",
    Param1 = 48133
  },
  [123347] = {
    ID = 123347,
    CnID = "跳转@莱克试玩",
    BaseSortID = 423,
    Desc = "ItemGets_123347_Desc|莱克试玩",
    Order = 423,
    JumpFunc = "Stage",
    Param1 = 48846
  },
  [100584] = {
    ID = 100584,
    CnID = "跳转@异梦视界夏日活动下",
    BaseSortID = 424,
    Desc = "ItemGets_100584_Desc|通关异梦视界-再见，永无乡",
    Order = 424,
    JumpFunc = 51757
  },
  [116329] = {
    ID = 116329,
    CnID = "跳转@活动",
    BaseSortID = 425,
    Desc = "ItemGets_116329_Desc|活动",
    Order = 425,
    JumpFunc = 17036
  },
  [116766] = {
    ID = 116766,
    CnID = "跳转@波吕克斯试玩",
    BaseSortID = 426,
    Desc = "ItemGets_116766_Desc|波吕克斯试玩",
    Order = 426,
    JumpFunc = "Stage",
    Param1 = 78002
  },
  [117091] = {
    ID = 117091,
    CnID = "跳转@最佳体验主线第1章",
    BaseSortID = 427,
    Desc = "ItemGets_117091_Desc|「调查行动」第一章",
    Order = 427,
    JumpFunc = "StageNoDetail",
    Param1 = 8128
  },
  [117124] = {
    ID = 117124,
    CnID = "跳转@最佳体验主线第2章",
    BaseSortID = 428,
    Desc = "ItemGets_117124_Desc|「调查行动」第二章",
    Order = 428,
    JumpFunc = "StageNoDetail",
    Param1 = 7986
  },
  [117097] = {
    ID = 117097,
    CnID = "跳转@最佳体验主线第3章",
    BaseSortID = 429,
    Desc = "ItemGets_117097_Desc|「调查行动」第三章",
    Order = 429,
    JumpFunc = "StageNoDetail",
    Param1 = 8110
  },
  [117118] = {
    ID = 117118,
    CnID = "跳转@最佳体验主线第4章",
    BaseSortID = 430,
    Desc = "ItemGets_117118_Desc|「调查行动」第四章",
    Order = 430,
    JumpFunc = "StageNoDetail",
    Param1 = 8027
  },
  [117100] = {
    ID = 117100,
    CnID = "跳转@最佳体验主线第5章",
    BaseSortID = 431,
    Desc = "ItemGets_117100_Desc|「调查行动」第五章",
    Order = 431,
    JumpFunc = "StageNoDetail",
    Param1 = 8153
  },
  [117096] = {
    ID = 117096,
    CnID = "跳转@最佳体验主线第6章",
    BaseSortID = 432,
    Desc = "ItemGets_117096_Desc|「调查行动」第六章",
    Order = 432,
    JumpFunc = "StageNoDetail",
    Param1 = 7659
  },
  [117089] = {
    ID = 117089,
    CnID = "跳转@最佳体验主线第7章",
    BaseSortID = 433,
    Desc = "ItemGets_117089_Desc|「调查行动」第七章",
    Order = 433,
    JumpFunc = "StageNoDetail",
    Param1 = 50345
  },
  [117109] = {
    ID = 117109,
    CnID = "跳转@最佳体验主线第8章",
    BaseSortID = 434,
    Desc = "ItemGets_117109_Desc|「调查行动」第八章",
    Order = 434,
    JumpFunc = "StageNoDetail",
    Param1 = 58986
  },
  [117093] = {
    ID = 117093,
    CnID = "跳转@最佳体验主线第9章",
    BaseSortID = 435,
    Desc = "ItemGets_117093_Desc|「调查行动」第九章",
    Order = 435,
    JumpFunc = "StageNoDetail",
    Param1 = 59505
  },
  [117113] = {
    ID = 117113,
    CnID = "跳转@最佳体验主线S1第1章",
    BaseSortID = 436,
    Desc = "ItemGets_117113_Desc|「调查行动」星辰篇第一章",
    Order = 436,
    JumpFunc = "StageNoDetail",
    Param1 = 70937
  },
  [117106] = {
    ID = 117106,
    CnID = "跳转@最佳体验主线S1第2章",
    BaseSortID = 437,
    Desc = "ItemGets_117106_Desc|「调查行动」星辰篇第二章",
    Order = 437,
    JumpFunc = "StageNoDetail",
    Param1 = 80251
  },
  [117127] = {
    ID = 117127,
    CnID = "跳转@最佳体验主线S1第3章",
    BaseSortID = 438,
    Desc = "ItemGets_117127_Desc|「调查行动」星辰篇第三章",
    Order = 438,
    JumpFunc = "StageNoDetail",
    Param1 = 90676
  },
  [120497] = {
    ID = 120497,
    CnID = "跳转@最佳体验主线S1第4章",
    BaseSortID = 439,
    Desc = "ItemGets_120497_Desc|「调查行动」星辰篇第四章",
    Order = 439,
    JumpFunc = "StageNoDetail",
    Param1 = 118156
  },
  [126370] = {
    ID = 126370,
    CnID = "跳转@最佳体验主线S1第5章",
    BaseSortID = 440,
    Desc = "ItemGets_126370_Desc|「调查行动」星辰篇第五章",
    Order = 440,
    JumpFunc = "StageNoDetail",
    Param1 = 125643
  },
  [117120] = {
    ID = 117120,
    CnID = "跳转@最佳体验意识潜游骑士的愿望",
    BaseSortID = 441,
    Desc = "ItemGets_117120_Desc|「意识潜游」骑士的愿望",
    Order = 441,
    JumpFunc = 17020,
    Param1 = 20452
  },
  [117095] = {
    ID = 117095,
    CnID = "跳转@最佳体验意识潜游诸事如常",
    BaseSortID = 442,
    Desc = "ItemGets_117095_Desc|「意识潜游」诸事如常",
    Order = 442,
    JumpFunc = 17020,
    Param1 = 35545
  },
  [117110] = {
    ID = 117110,
    CnID = "跳转@最佳体验意识潜游血与沙",
    BaseSortID = 443,
    Desc = "ItemGets_117110_Desc|「意识潜游」血与沙",
    Order = 443,
    JumpFunc = 17020,
    Param1 = 15923
  },
  [117128] = {
    ID = 117128,
    CnID = "跳转@最佳体验意识潜游扭曲核心",
    BaseSortID = 444,
    Desc = "ItemGets_117128_Desc|「意识潜游」扭曲核心",
    Order = 444,
    JumpFunc = 17020,
    Param1 = 20448
  },
  [117116] = {
    ID = 117116,
    CnID = "跳转@最佳体验意识潜游燃烧的群宴",
    BaseSortID = 445,
    Desc = "ItemGets_117116_Desc|「意识潜游」燃烧的群宴",
    Order = 445,
    JumpFunc = 17020,
    Param1 = 36627
  },
  [117103] = {
    ID = 117103,
    CnID = "跳转@最佳体验意识潜游如歌的雕琢",
    BaseSortID = 446,
    Desc = "ItemGets_117103_Desc|「意识潜游」如歌的雕琢",
    Order = 446,
    JumpFunc = 17020,
    Param1 = 20223
  },
  [117105] = {
    ID = 117105,
    CnID = "跳转@最佳体验意识潜游苍白后裔",
    BaseSortID = 447,
    Desc = "ItemGets_117105_Desc|「意识潜游」苍白后裔",
    Order = 447,
    JumpFunc = 17020,
    Param1 = 20446
  },
  [117115] = {
    ID = 117115,
    CnID = "跳转@最佳体验意识潜游一步之遥",
    BaseSortID = 448,
    Desc = "ItemGets_117115_Desc|「意识潜游」一步之遥",
    Order = 448,
    JumpFunc = 17020,
    Param1 = 24553
  },
  [117117] = {
    ID = 117117,
    CnID = "跳转@最佳体验特遣纪录雨镇幽影",
    BaseSortID = 449,
    Desc = "ItemGets_117117_Desc|「特遣纪录」雨镇幽影",
    Order = 449,
    JumpFunc = 17037,
    Param1 = 15947
  },
  [117111] = {
    ID = 117111,
    CnID = "跳转@最佳体验特遣纪录故事的魔法",
    BaseSortID = 450,
    Desc = "ItemGets_117111_Desc|「特遣纪录」故事的魔法",
    Order = 450,
    JumpFunc = 17037,
    Param1 = 23622
  },
  [117125] = {
    ID = 117125,
    CnID = "跳转@最佳体验特遣纪录蔷薇礼赞",
    BaseSortID = 451,
    Desc = "ItemGets_117125_Desc|「特遣纪录」蔷薇礼赞",
    Order = 451,
    JumpFunc = 17037,
    Param1 = 24436
  },
  [117126] = {
    ID = 117126,
    CnID = "跳转@最佳体验特遣纪录血的颜色",
    BaseSortID = 452,
    Desc = "ItemGets_117126_Desc|「特遣纪录」血的颜色",
    Order = 452,
    JumpFunc = 17037,
    Param1 = 44564
  },
  [117101] = {
    ID = 117101,
    CnID = "跳转@最佳体验意识潜游巨人的陨落",
    BaseSortID = 453,
    Desc = "ItemGets_117101_Desc|「意识潜游」巨人的陨落",
    Order = 453,
    JumpFunc = 17020,
    Param1 = 43517
  },
  [117099] = {
    ID = 117099,
    CnID = "跳转@最佳体验特遣纪录宁静的裂殖",
    BaseSortID = 454,
    Desc = "ItemGets_117099_Desc|「特遣纪录」宁静的裂殖",
    Order = 454,
    JumpFunc = 17037,
    Param1 = 46185
  },
  [117123] = {
    ID = 117123,
    CnID = "跳转@最佳体验异梦视界亵渎",
    BaseSortID = 455,
    Desc = "ItemGets_117123_Desc|「异梦视界」亵渎",
    Order = 455,
    JumpFunc = 51757,
    Param1 = 51755
  },
  [117090] = {
    ID = 117090,
    CnID = "跳转@最佳体验特遣纪录玫瑰的栖居",
    BaseSortID = 456,
    Desc = "ItemGets_117090_Desc|「特遣纪录」玫瑰的栖居",
    Order = 456,
    JumpFunc = 17037,
    Param1 = 55455
  },
  [117119] = {
    ID = 117119,
    CnID = "跳转@最佳体验特遣纪录莱克",
    BaseSortID = 457,
    Desc = "ItemGets_117119_Desc|「特遣纪录」狩猎愉快！",
    Order = 457,
    JumpFunc = 17037,
    Param1 = 56441
  },
  [117112] = {
    ID = 117112,
    CnID = "跳转@最佳体验特遣纪录本源希洛",
    BaseSortID = 458,
    Desc = "ItemGets_117112_Desc|「特遣纪录」艾尔沃斯的归人",
    Order = 458,
    JumpFunc = 17037,
    Param1 = 56443
  },
  [117092] = {
    ID = 117092,
    CnID = "跳转@最佳体验意识潜游图鲁",
    BaseSortID = 459,
    Desc = "ItemGets_117092_Desc|「意识潜游」加冕之日",
    Order = 459,
    JumpFunc = 17020,
    Param1 = 71850
  },
  [117098] = {
    ID = 117098,
    CnID = "跳转@最佳体验意识潜游莉兹",
    BaseSortID = 460,
    Desc = "ItemGets_117098_Desc|「意识潜游」热情归尘",
    Order = 460,
    JumpFunc = 17020,
    Param1 = 74237
  },
  [117122] = {
    ID = 117122,
    CnID = "跳转@最佳体验相位逆转",
    BaseSortID = 461,
    Desc = "ItemGets_117122_Desc|「多维连接」逆转回合",
    Order = 461,
    JumpFunc = 78734,
    Param1 = 74338
  },
  [117121] = {
    ID = 117121,
    CnID = "跳转@最佳体验意识潜游克珀珊特",
    BaseSortID = 462,
    Desc = "ItemGets_117121_Desc|「意识潜游」最后的引航",
    Order = 462,
    JumpFunc = 17020,
    Param1 = 81262
  },
  [117102] = {
    ID = 117102,
    CnID = "跳转@最佳体验异梦视界卡斯托尔",
    BaseSortID = 463,
    Desc = "ItemGets_117102_Desc|「异梦视界」天边之外·上",
    Order = 463,
    JumpFunc = 51757,
    Param1 = 88934
  },
  [117094] = {
    ID = 117094,
    CnID = "跳转@最佳体验异梦视界罗马活动",
    BaseSortID = 464,
    Desc = "ItemGets_117094_Desc|「异梦视界」征厨房记",
    Order = 464,
    JumpFunc = 51757,
    Param1 = 91021
  },
  [117104] = {
    ID = 117104,
    CnID = "跳转@最佳体验意识潜游凯蒂古拉",
    BaseSortID = 465,
    Desc = "ItemGets_117104_Desc|「意识潜游」不朽极昼",
    Order = 465,
    JumpFunc = 17020,
    Param1 = 95184
  },
  [117108] = {
    ID = 117108,
    CnID = "跳转@最佳体验异梦视界夏日活动上",
    BaseSortID = 466,
    Desc = "ItemGets_117108_Desc|「异梦视界」再见永无乡",
    Order = 466,
    JumpFunc = 51757,
    Param1 = 94850
  },
  [117107] = {
    ID = 117107,
    CnID = "跳转@最佳体验意识潜游皮克曼",
    BaseSortID = 467,
    Desc = "ItemGets_117107_Desc|「意识潜游」畸世绘",
    Order = 467,
    JumpFunc = 17020,
    Param1 = 96834
  },
  [117114] = {
    ID = 117114,
    CnID = "跳转@最佳体验异梦视界夏日活动下",
    BaseSortID = 468,
    Desc = "ItemGets_117114_Desc|「异梦视界」再见，永无乡",
    Order = 468,
    JumpFunc = 51757,
    Param1 = 97852
  },
  [118122] = {
    ID = 118122,
    CnID = "跳转@最佳体验异梦视界波吕克斯",
    BaseSortID = 469,
    Desc = "ItemGets_118122_Desc|「异梦视界」天边之外·下",
    Order = 469,
    JumpFunc = 51757,
    Param1 = 99734
  },
  [120498] = {
    ID = 120498,
    CnID = "跳转@最佳体验多维连接茉夏",
    BaseSortID = 470,
    Desc = "ItemGets_120498_Desc|「多维连接」银与血的洗礼",
    Order = 470,
    JumpFunc = 78734,
    Param1 = 122187
  },
  [120993] = {
    ID = 120993,
    CnID = "跳转@最佳体验特遣纪录2周年",
    BaseSortID = 471,
    Desc = "ItemGets_120993_Desc|「特遣纪录」群星咏叹调",
    Order = 471,
    JumpFunc = 17037,
    Param1 = 120952
  },
  [127177] = {
    ID = 127177,
    CnID = "跳转@最佳体验意识潜游徐",
    BaseSortID = 472,
    Desc = "ItemGets_127177_Desc|「意识潜游」扇下夜谈",
    Order = 472,
    JumpFunc = 17020,
    Param1 = 125338
  },
  [130927] = {
    ID = 130927,
    CnID = "跳转@最佳体验意识潜游莫丝",
    BaseSortID = 473,
    Desc = "ItemGets_130927_Desc|「意识潜游」沉溺",
    Order = 473,
    JumpFunc = 17020,
    Param1 = 130895
  },
  [90494] = {
    ID = 90494,
    CnID = "跳转@战斗教学",
    BaseSortID = 474,
    Desc = "ItemGets_90494_Desc|战斗训练",
    Order = 474,
    JumpFunc = 90492
  },
  [141955] = {
    ID = 141955,
    CnID = "跳转@用户中心",
    BaseSortID = 475,
    Desc = "ItemGets_141955_Desc|用户中心",
    Order = 475,
    JumpFunc = "Settings",
    Param1 = "BindPhoneOrEmail"
  },
  [147803] = {
    ID = 147803,
    CnID = "跳转@灵魂回溯碎片分解",
    BaseSortID = 476,
    Desc = "ItemGets_147803_Desc|分解「灵魂回溯碎片」",
    Order = 476,
    JumpFunc = "MaterialDecompose",
    Param1 = 145470
  },
  [147802] = {
    ID = 147802,
    CnID = "跳转@命途回溯碎片分解",
    BaseSortID = 477,
    Desc = "ItemGets_147802_Desc|分解「命途回溯碎片」",
    Order = 477,
    JumpFunc = "MaterialDecompose",
    Param1 = 145469
  }
})
return ItemGets
