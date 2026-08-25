__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local WaveConfig = readonly({
  [2] = {
    ID = 2,
    CnID = "怪物波次@2",
    BaseSortID = 1,
    School = 1,
    MonsterPoint1 = 1
  },
  [3] = {
    ID = 3,
    CnID = "怪物波次@3",
    BaseSortID = 2,
    School = 1,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [905] = {
    ID = 905,
    CnID = "怪物波次@测试普通",
    BaseSortID = 3,
    School = 1,
    MonsterPoint1 = 1
  },
  [1910] = {
    ID = 1910,
    CnID = "怪物波次@测试普通二阶",
    BaseSortID = 4,
    School = 1,
    MonsterPoint1 = 1
  },
  [959] = {
    ID = 959,
    CnID = "怪物波次@测试精英",
    BaseSortID = 5,
    School = 1,
    MonsterPoint1 = 1
  },
  [1642] = {
    ID = 1642,
    CnID = "怪物波次@测试首领",
    BaseSortID = 6,
    School = 1,
    MonsterPoint1 = 1
  },
  [850973] = {
    ID = 850973,
    CnID = "怪物波次@主线0_1_1",
    BaseSortID = 7,
    School = 1,
    Monster1 = 4378572,
    MonsterPoint1 = 5
  },
  [851772] = {
    ID = 851772,
    CnID = "怪物波次@主线0_1_2",
    BaseSortID = 8,
    School = 1,
    Monster1 = 4245333,
    MonsterPoint1 = 5
  },
  [863472] = {
    ID = 863472,
    CnID = "怪物波次@主线0_1_3",
    BaseSortID = 9,
    School = 1,
    Monster1 = 4378970,
    Monster2 = 4245601,
    Monster3 = 4245601,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 8
  },
  [863909] = {
    ID = 863909,
    CnID = "怪物波次@主线0_1_4",
    BaseSortID = 10,
    School = 1,
    Monster1 = 4246952,
    MonsterPoint1 = 5
  },
  [864227] = {
    ID = 864227,
    CnID = "怪物波次@主线0_1_5",
    BaseSortID = 11,
    School = 1,
    Monster1 = 4332021,
    MonsterPoint1 = 5
  },
  [54828] = {
    ID = 54828,
    CnID = "怪物波次@主线1_1_1",
    BaseSortID = 12,
    Monster1 = 4248236,
    Monster2 = 4249121,
    Monster3 = 4249842,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7
  },
  [55682] = {
    ID = 55682,
    CnID = "怪物波次@主线1_1_2",
    BaseSortID = 13,
    Monster1 = 4249121,
    Monster2 = 4249121,
    Monster3 = 4248236,
    Monster4 = 4248236,
    MonsterPoint1 = 2,
    MonsterPoint2 = -4,
    MonsterPoint3 = -6,
    MonsterPoint4 = 10
  },
  [55852] = {
    ID = 55852,
    CnID = "怪物波次@主线1_1_3",
    BaseSortID = 14,
    Monster1 = 4795827,
    MonsterPoint1 = 5
  },
  [856495] = {
    ID = 856495,
    CnID = "怪物波次@主线1_2_1",
    BaseSortID = 15,
    Monster1 = 4951728,
    Monster2 = 4380539,
    Monster3 = 4951039,
    MonsterPoint1 = 2,
    MonsterPoint2 = 7,
    MonsterPoint3 = 11
  },
  [857228] = {
    ID = 857228,
    CnID = "怪物波次@主线1_2_2",
    BaseSortID = 16,
    Monster1 = 4951728,
    Monster2 = 4253383,
    Monster3 = 4380539,
    MonsterPoint1 = 2,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [857520] = {
    ID = 857520,
    CnID = "怪物波次@主线1_2_3",
    BaseSortID = 17,
    Monster1 = 4795888,
    MonsterPoint1 = 8
  },
  [55947] = {
    ID = 55947,
    CnID = "怪物波次@主线1_3_1",
    BaseSortID = 18,
    Monster1 = 4381413,
    Monster2 = 4256646,
    Monster3 = 4255958,
    Monster4 = 4256646,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [56143] = {
    ID = 56143,
    CnID = "怪物波次@主线1_3_2",
    BaseSortID = 19,
    Monster1 = 4381413,
    Monster2 = 4255958,
    Monster3 = 4256646,
    Monster4 = 4382060,
    MonsterPoint1 = 2,
    MonsterPoint2 = 4,
    MonsterPoint3 = -6,
    MonsterPoint4 = 10
  },
  [56422] = {
    ID = 56422,
    CnID = "怪物波次@主线1_3_3",
    BaseSortID = 20,
    Monster1 = 4338707,
    MonsterPoint1 = 8
  },
  [56855] = {
    ID = 56855,
    CnID = "怪物波次@主线1_3_4",
    BaseSortID = 21,
    Monster1 = 4796658,
    Monster2 = 4338707,
    MonsterPoint1 = 4,
    MonsterPoint2 = 9
  },
  [865093] = {
    ID = 865093,
    CnID = "怪物波次@主线1_3_5",
    BaseSortID = 22,
    Monster1 = 4796731,
    MonsterPoint1 = 8
  },
  [858509] = {
    ID = 858509,
    CnID = "怪物波次@主线1_4_1",
    BaseSortID = 23,
    Monster1 = 4258188,
    Monster2 = 4339465,
    Monster3 = 4339551,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 8
  },
  [859492] = {
    ID = 859492,
    CnID = "怪物波次@主线1_4_2",
    BaseSortID = 24,
    Monster1 = 4339465,
    Monster2 = 4379593,
    Monster3 = 4258188,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 8
  },
  [865272] = {
    ID = 865272,
    CnID = "怪物波次@主线1_4_3",
    BaseSortID = 25,
    Monster1 = 4339551,
    Monster2 = 4824354,
    Monster3 = 4835466,
    MonsterPoint1 = 1,
    MonsterPoint2 = 4,
    MonsterPoint3 = 9
  },
  [865287] = {
    ID = 865287,
    CnID = "怪物波次@主线1_4_4",
    BaseSortID = 26,
    Monster1 = 4797132,
    MonsterPoint1 = 5
  },
  [57530] = {
    ID = 57530,
    CnID = "怪物波次@主线1_5_1",
    BaseSortID = 27,
    Monster1 = 4260172,
    Monster2 = 4341006,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [57796] = {
    ID = 57796,
    CnID = "怪物波次@主线1_5_2",
    BaseSortID = 28,
    Monster1 = 4260172,
    Monster2 = 4341006,
    Monster3 = 4835982,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 8
  },
  [57925] = {
    ID = 57925,
    CnID = "怪物波次@主线1_5_3",
    BaseSortID = 29,
    Monster1 = 4797177,
    MonsterPoint1 = 8
  },
  [58382] = {
    ID = 58382,
    CnID = "怪物波次@主线1_5_4",
    BaseSortID = 30,
    Monster1 = 4262003,
    Monster2 = 4261559,
    MonsterPoint1 = 4,
    MonsterPoint2 = 9
  },
  [58467] = {
    ID = 58467,
    CnID = "怪物波次@主线1_5_5",
    BaseSortID = 31,
    Monster1 = 4262003,
    Monster2 = 4262003,
    Monster3 = 4259866,
    MonsterPoint1 = 1,
    MonsterPoint2 = 5,
    MonsterPoint3 = 9
  },
  [59260] = {
    ID = 59260,
    CnID = "怪物波次@主线1_5_6",
    BaseSortID = 32,
    Monster1 = 4797991,
    Monster2 = 4825212,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6
  },
  [860308] = {
    ID = 860308,
    CnID = "怪物波次@主线1_6_1",
    BaseSortID = 33,
    Monster1 = 4265084,
    Monster2 = 4263531,
    Monster3 = 4262973,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7
  },
  [861068] = {
    ID = 861068,
    CnID = "怪物波次@主线1_6_2",
    BaseSortID = 34,
    Monster1 = 4798014,
    Monster2 = 4798014,
    Monster3 = 4262973,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7
  },
  [861721] = {
    ID = 861721,
    CnID = "怪物波次@主线1_6_3",
    BaseSortID = 35,
    Monster1 = 4798782,
    MonsterPoint1 = 8
  },
  [862293] = {
    ID = 862293,
    CnID = "怪物波次@主线1_6_4",
    BaseSortID = 36,
    Monster1 = 4337087,
    Monster2 = 4342506,
    Monster3 = 4342408,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7,
    MonsterPoint3 = 11
  },
  [865718] = {
    ID = 865718,
    CnID = "怪物波次@主线1_6_5",
    BaseSortID = 37,
    Monster1 = 4342506,
    Monster2 = 4342506,
    Monster3 = 4262973,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [866273] = {
    ID = 866273,
    CnID = "怪物波次@主线1_6_6",
    BaseSortID = 38,
    Monster1 = 4799157,
    MonsterPoint1 = -2
  },
  [59945] = {
    ID = 59945,
    CnID = "怪物波次@主线1_7_1",
    BaseSortID = 39,
    Monster1 = 4382191,
    Monster2 = 4268531,
    Monster3 = 4265592,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 8
  },
  [60476] = {
    ID = 60476,
    CnID = "怪物波次@主线1_7_2",
    BaseSortID = 40,
    Monster1 = 4267327,
    Monster2 = 4265592,
    Monster3 = 4267692,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7
  },
  [60692] = {
    ID = 60692,
    CnID = "怪物波次@主线1_7_3",
    BaseSortID = 41,
    Monster1 = 4799754,
    MonsterPoint1 = 5
  },
  [60745] = {
    ID = 60745,
    CnID = "怪物波次@主线1_7_4",
    BaseSortID = 42,
    Monster1 = 4337437,
    Monster2 = 4266522,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [866577] = {
    ID = 866577,
    CnID = "怪物波次@主线1_7_5",
    BaseSortID = 43,
    Monster1 = 4338042,
    Monster2 = 4342631,
    MonsterPoint1 = 4,
    MonsterPoint2 = 9
  },
  [867439] = {
    ID = 867439,
    CnID = "怪物波次@主线1_7_6",
    BaseSortID = 44,
    Monster1 = 4800573,
    MonsterPoint1 = 8
  },
  [60959] = {
    ID = 60959,
    CnID = "怪物波次@主线1_8_1",
    BaseSortID = 45,
    Monster1 = 4272350,
    Monster2 = 4272555,
    Monster3 = 4273277,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7
  },
  [61425] = {
    ID = 61425,
    CnID = "怪物波次@主线1_8_2",
    BaseSortID = 46,
    Monster1 = 4272555,
    Monster2 = 4382675,
    Monster3 = 4273277,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7
  },
  [62048] = {
    ID = 62048,
    CnID = "怪物波次@主线1_8_3",
    BaseSortID = 47,
    Monster1 = 4270950,
    Monster2 = 4271439,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [62136] = {
    ID = 62136,
    CnID = "怪物波次@主线1_8_4",
    BaseSortID = 48,
    Monster1 = 4801151,
    MonsterPoint1 = 5
  },
  [62319] = {
    ID = 62319,
    CnID = "怪物波次@主线1_8_5",
    BaseSortID = 49,
    Monster1 = 4272555,
    Monster2 = 4271506,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [62521] = {
    ID = 62521,
    CnID = "怪物波次@主线1_8_6",
    BaseSortID = 50,
    Monster1 = 4274487,
    Monster2 = 4272555,
    Monster3 = 4382675,
    Monster4 = 4382675,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [862722] = {
    ID = 862722,
    CnID = "怪物波次@主线1_8_7",
    BaseSortID = 51,
    Monster1 = 4802106,
    MonsterPoint1 = 5
  },
  [103787] = {
    ID = 103787,
    CnID = "怪物波次@主线2_1_1",
    BaseSortID = 52,
    Monster1 = 4343950,
    Monster2 = 4383497,
    Monster3 = 4383497,
    Monster4 = 4344929,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 9
  },
  [103909] = {
    ID = 103909,
    CnID = "怪物波次@主线2_1_2",
    BaseSortID = 53,
    Monster1 = 4343950,
    Monster2 = 4344929,
    Monster3 = 4346001,
    MonsterPoint1 = 3,
    MonsterPoint2 = -4,
    MonsterPoint3 = -8
  },
  [104018] = {
    ID = 104018,
    CnID = "怪物波次@主线2_1_3",
    BaseSortID = 54,
    Monster1 = 4802198,
    MonsterPoint1 = 8
  },
  [105964] = {
    ID = 105964,
    CnID = "怪物波次@主线2_2_1",
    BaseSortID = 55,
    Monster1 = 4348859,
    Monster2 = 4348859,
    Monster3 = 4384714,
    MonsterPoint1 = 2,
    MonsterPoint2 = -4,
    MonsterPoint3 = -6
  },
  [106655] = {
    ID = 106655,
    CnID = "怪物波次@主线2_2_2",
    BaseSortID = 56,
    Monster1 = 4802330,
    Monster2 = 4825492,
    Monster3 = 4384714,
    MonsterPoint1 = 2,
    MonsterPoint2 = -4,
    MonsterPoint3 = -6
  },
  [106888] = {
    ID = 106888,
    CnID = "怪物波次@主线2_2_3",
    BaseSortID = 57,
    Monster1 = 4802563,
    MonsterPoint1 = 8
  },
  [108272] = {
    ID = 108272,
    CnID = "怪物波次@主线2_3_1",
    BaseSortID = 58,
    Monster1 = 4802903,
    MonsterPoint1 = 8
  },
  [111660] = {
    ID = 111660,
    CnID = "怪物波次@主线2_4_1",
    BaseSortID = 59,
    Monster1 = 4352209,
    Monster2 = 4353731,
    Monster3 = 4826165,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7
  },
  [111723] = {
    ID = 111723,
    CnID = "怪物波次@主线2_4_2",
    BaseSortID = 60,
    Monster1 = 4385504,
    Monster2 = 4826165,
    Monster3 = 4355111,
    Monster4 = 4826165,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [112517] = {
    ID = 112517,
    CnID = "怪物波次@主线2_4_3",
    BaseSortID = 61,
    Monster1 = 4803629,
    Monster2 = 4826300,
    Monster3 = 4826165,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7
  },
  [113132] = {
    ID = 113132,
    CnID = "怪物波次@主线2_4_4",
    BaseSortID = 62,
    Monster1 = 4804213,
    Monster2 = 4826300,
    Monster3 = 4826165,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7
  },
  [113229] = {
    ID = 113229,
    CnID = "怪物波次@主线2_4_5",
    BaseSortID = 63,
    Monster1 = 4953139,
    Monster2 = 4954736,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [114715] = {
    ID = 114715,
    CnID = "怪物波次@主线2_5_1",
    BaseSortID = 64,
    Monster1 = 4355786,
    Monster2 = 4356775,
    Monster3 = 4836500,
    Monster4 = 4841498,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 9
  },
  [115173] = {
    ID = 115173,
    CnID = "怪物波次@主线2_5_2",
    BaseSortID = 65,
    Monster1 = 4804932,
    Monster2 = 4826458,
    Monster3 = 4826458,
    Monster4 = 4826458,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 9
  },
  [115245] = {
    ID = 115245,
    CnID = "怪物波次@主线2_5_3",
    BaseSortID = 66,
    Monster1 = 4804934,
    MonsterPoint1 = 8
  },
  [115600] = {
    ID = 115600,
    CnID = "怪物波次@主线2_5_4",
    BaseSortID = 67,
    Monster1 = 4805929,
    Monster2 = 4826938,
    Monster3 = 4826458,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7
  },
  [116338] = {
    ID = 116338,
    CnID = "怪物波次@主线2_5_5",
    BaseSortID = 68,
    Monster1 = 4806421,
    Monster2 = 4827201,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [117109] = {
    ID = 117109,
    CnID = "怪物波次@主线2_5_6",
    BaseSortID = 69,
    Monster1 = 4806764,
    MonsterPoint1 = 8
  },
  [117542] = {
    ID = 117542,
    CnID = "怪物波次@主线2_6_1",
    BaseSortID = 70,
    Monster1 = 4807445,
    Monster2 = 4827276,
    Monster3 = 4361921,
    Monster4 = 4361921,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [118465] = {
    ID = 118465,
    CnID = "怪物波次@主线2_6_2",
    BaseSortID = 71,
    Monster1 = 4807486,
    Monster2 = 4827568,
    Monster3 = 4837260,
    Monster4 = 4827568,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 8,
    MonsterPoint4 = 12
  },
  [119148] = {
    ID = 119148,
    CnID = "怪物波次@主线2_6_3",
    BaseSortID = 72,
    Monster1 = 4954104,
    MonsterPoint1 = 7
  },
  [121600] = {
    ID = 121600,
    CnID = "怪物波次@主线2_7_1",
    BaseSortID = 73,
    Monster1 = 4363849,
    Monster2 = 4362345,
    Monster3 = 4363982,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7
  },
  [122228] = {
    ID = 122228,
    CnID = "怪物波次@主线2_7_2",
    BaseSortID = 74,
    Monster1 = 4362212,
    Monster2 = 4364084,
    Monster3 = 4362212,
    MonsterPoint1 = 2,
    MonsterPoint2 = 6,
    MonsterPoint3 = 7
  },
  [123167] = {
    ID = 123167,
    CnID = "怪物波次@主线2_7_3",
    BaseSortID = 75,
    Monster1 = 4809537,
    Monster2 = 4362212,
    Monster3 = 4837769,
    MonsterPoint1 = 4,
    MonsterPoint2 = 9
  },
  [123559] = {
    ID = 123559,
    CnID = "怪物波次@主线2_7_4",
    BaseSortID = 76,
    Monster1 = 4809928,
    Monster2 = 4828859,
    MonsterPoint1 = 4,
    MonsterPoint2 = 9
  },
  [123756] = {
    ID = 123756,
    CnID = "怪物波次@主线2_7_5",
    BaseSortID = 77,
    Monster1 = 4810430,
    Monster2 = 4829523,
    MonsterPoint1 = 1,
    MonsterPoint2 = 10
  },
  [124897] = {
    ID = 124897,
    CnID = "怪物波次@主线2_8_1",
    BaseSortID = 78,
    Monster1 = 4811237,
    Monster2 = 4829603,
    Monster3 = 4838462,
    Monster4 = 4829603,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [125187] = {
    ID = 125187,
    CnID = "怪物波次@主线2_8_2",
    BaseSortID = 79,
    Monster1 = 4812158,
    Monster2 = 4830148,
    Monster3 = 4838462,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7
  },
  [126036] = {
    ID = 126036,
    CnID = "怪物波次@主线2_8_3",
    BaseSortID = 80,
    Monster1 = 4812437,
    MonsterPoint1 = 8
  },
  [126853] = {
    ID = 126853,
    CnID = "怪物波次@主线2_8_4",
    BaseSortID = 81,
    Monster1 = 4364534,
    Monster2 = 4364534,
    Monster3 = 4366411,
    Monster4 = 4811237,
    MonsterPoint1 = 2,
    MonsterPoint2 = 6,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [127696] = {
    ID = 127696,
    CnID = "怪物波次@主线2_8_5",
    BaseSortID = 82,
    Monster1 = 4812640,
    Monster2 = 4830354,
    MonsterPoint1 = 4,
    MonsterPoint2 = 9
  },
  [128139] = {
    ID = 128139,
    CnID = "怪物波次@主线2_8_6",
    BaseSortID = 83,
    Monster1 = 4813595,
    MonsterPoint1 = 8
  },
  [867574] = {
    ID = 867574,
    CnID = "怪物波次@主线2_9_1",
    BaseSortID = 84,
    Monster1 = 4954228,
    MonsterPoint1 = 8
  },
  [692019] = {
    ID = 692019,
    CnID = "怪物波次@主线2_10_1",
    BaseSortID = 85,
    Monster1 = 4816196,
    Monster2 = 4831253,
    Monster3 = 4839642,
    Monster4 = 4831253,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [692207] = {
    ID = 692207,
    CnID = "怪物波次@主线2_10_2",
    BaseSortID = 86,
    Monster1 = 4817164,
    Monster2 = 4389339,
    Monster3 = 4377241,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [692490] = {
    ID = 692490,
    CnID = "怪物波次@主线2_10_3",
    BaseSortID = 87,
    Monster1 = 4377241,
    Monster2 = 4389339,
    Monster3 = 4839642,
    Monster4 = 4831253,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [693096] = {
    ID = 693096,
    CnID = "怪物波次@主线2_10_4",
    BaseSortID = 88,
    Monster1 = 4817839,
    Monster2 = 4376712,
    MonsterPoint1 = 1,
    MonsterPoint2 = 10
  },
  [694065] = {
    ID = 694065,
    CnID = "怪物波次@主线2_10_5",
    BaseSortID = 89,
    Monster1 = 4818684,
    Monster2 = 4832928,
    MonsterPoint1 = 4,
    MonsterPoint2 = 9
  },
  [694300] = {
    ID = 694300,
    CnID = "怪物波次@主线2_10_6",
    BaseSortID = 90,
    Monster1 = 4819661,
    Monster2 = 4818684,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [868134] = {
    ID = 868134,
    CnID = "怪物波次@主线2_10_7",
    BaseSortID = 91,
    Monster1 = 4819952,
    MonsterPoint1 = 8
  },
  [694587] = {
    ID = 694587,
    CnID = "怪物波次@主线2_11_1",
    BaseSortID = 92,
    Monster1 = 4820034,
    Monster2 = 4833780,
    Monster3 = 4840032,
    Monster4 = 4842294,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [695423] = {
    ID = 695423,
    CnID = "怪物波次@主线2_11_2",
    BaseSortID = 93,
    Monster1 = 4820592,
    Monster2 = 4834057,
    Monster3 = 4833780,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7
  },
  [695650] = {
    ID = 695650,
    CnID = "怪物波次@主线2_11_3",
    BaseSortID = 94,
    Monster1 = 4820034,
    Monster2 = 4834576,
    Monster3 = 4840762,
    MonsterPoint1 = 1,
    MonsterPoint2 = -3,
    MonsterPoint3 = 7
  },
  [696302] = {
    ID = 696302,
    CnID = "怪物波次@主线2_11_4",
    BaseSortID = 95,
    Monster1 = 4821444,
    MonsterPoint1 = 8
  },
  [697231] = {
    ID = 697231,
    CnID = "怪物波次@主线2_11_5",
    BaseSortID = 96,
    Monster1 = 4822208,
    Monster2 = 4834698,
    MonsterPoint1 = 1,
    MonsterPoint2 = 10
  },
  [698043] = {
    ID = 698043,
    CnID = "怪物波次@主线2_11_6",
    BaseSortID = 97,
    Monster1 = 4822279,
    MonsterPoint1 = 8
  },
  [698371] = {
    ID = 698371,
    CnID = "怪物波次@主线2_11_7",
    BaseSortID = 98,
    Monster1 = 4822574,
    Monster2 = 4835125,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [959837] = {
    ID = 959837,
    CnID = "怪物波次@主线2_11_8",
    BaseSortID = 99,
    Monster1 = 4823536,
    MonsterPoint1 = 5
  },
  [698743] = {
    ID = 698743,
    CnID = "怪物波次@主线2_12_1",
    BaseSortID = 100,
    Monster1 = 4824248,
    MonsterPoint1 = 8
  },
  [699160] = {
    ID = 699160,
    CnID = "怪物波次@主线2_12_2",
    BaseSortID = 101,
    Monster1 = 4824248,
    MonsterPoint1 = 8
  },
  [699835] = {
    ID = 699835,
    CnID = "怪物波次@主线2_12_3",
    BaseSortID = 102,
    Monster1 = 4824248,
    MonsterPoint1 = 8
  },
  [700489] = {
    ID = 700489,
    CnID = "怪物波次@主线2_12_4",
    BaseSortID = 103,
    Monster1 = 4824248,
    MonsterPoint1 = 8
  },
  [128282] = {
    ID = 128282,
    CnID = "怪物波次@主线3_1_1",
    BaseSortID = 104,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [128875] = {
    ID = 128875,
    CnID = "怪物波次@主线3_1_2",
    BaseSortID = 105,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [129603] = {
    ID = 129603,
    CnID = "怪物波次@主线3_1_3",
    BaseSortID = 106,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [130456] = {
    ID = 130456,
    CnID = "怪物波次@主线3_2_1",
    BaseSortID = 107,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [131206] = {
    ID = 131206,
    CnID = "怪物波次@主线3_2_2",
    BaseSortID = 108,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [131651] = {
    ID = 131651,
    CnID = "怪物波次@主线3_2_3",
    BaseSortID = 109,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [131871] = {
    ID = 131871,
    CnID = "怪物波次@主线3_2_4",
    BaseSortID = 110,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [133658] = {
    ID = 133658,
    CnID = "怪物波次@主线3_3_1",
    BaseSortID = 111,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [134222] = {
    ID = 134222,
    CnID = "怪物波次@主线3_3_2",
    BaseSortID = 112,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [135029] = {
    ID = 135029,
    CnID = "怪物波次@主线3_3_3",
    BaseSortID = 113,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [135971] = {
    ID = 135971,
    CnID = "怪物波次@主线3_3_4",
    BaseSortID = 114,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [136740] = {
    ID = 136740,
    CnID = "怪物波次@主线3_3_5",
    BaseSortID = 115,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [137130] = {
    ID = 137130,
    CnID = "怪物波次@主线3_4_1",
    BaseSortID = 116,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [137747] = {
    ID = 137747,
    CnID = "怪物波次@主线3_4_2",
    BaseSortID = 117,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [138044] = {
    ID = 138044,
    CnID = "怪物波次@主线3_4_3",
    BaseSortID = 118,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [138150] = {
    ID = 138150,
    CnID = "怪物波次@主线3_4_4",
    BaseSortID = 119,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [138482] = {
    ID = 138482,
    CnID = "怪物波次@主线3_4_5",
    BaseSortID = 120,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [138579] = {
    ID = 138579,
    CnID = "怪物波次@主线3_4_6",
    BaseSortID = 121,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [138808] = {
    ID = 138808,
    CnID = "怪物波次@主线3_5_1",
    BaseSortID = 122,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [139365] = {
    ID = 139365,
    CnID = "怪物波次@主线3_5_2",
    BaseSortID = 123,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [140044] = {
    ID = 140044,
    CnID = "怪物波次@主线3_5_3",
    BaseSortID = 124,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [141024] = {
    ID = 141024,
    CnID = "怪物波次@主线3_5_4",
    BaseSortID = 125,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [141106] = {
    ID = 141106,
    CnID = "怪物波次@主线3_5_5",
    BaseSortID = 126,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [141266] = {
    ID = 141266,
    CnID = "怪物波次@主线3_5_6",
    BaseSortID = 127,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [871686] = {
    ID = 871686,
    CnID = "怪物波次@主线3_5_7",
    BaseSortID = 128,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [141445] = {
    ID = 141445,
    CnID = "怪物波次@主线3_6_1",
    BaseSortID = 129,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [142168] = {
    ID = 142168,
    CnID = "怪物波次@主线3_6_2",
    BaseSortID = 130,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [142373] = {
    ID = 142373,
    CnID = "怪物波次@主线3_6_3",
    BaseSortID = 131,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [143309] = {
    ID = 143309,
    CnID = "怪物波次@主线3_6_4",
    BaseSortID = 132,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [145000] = {
    ID = 145000,
    CnID = "怪物波次@主线3_7_1",
    BaseSortID = 133,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [145384] = {
    ID = 145384,
    CnID = "怪物波次@主线3_7_2",
    BaseSortID = 134,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [146047] = {
    ID = 146047,
    CnID = "怪物波次@主线3_7_3",
    BaseSortID = 135,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [149062] = {
    ID = 149062,
    CnID = "怪物波次@主线3_8_1",
    BaseSortID = 136,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [149654] = {
    ID = 149654,
    CnID = "怪物波次@主线3_8_2",
    BaseSortID = 137,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [149956] = {
    ID = 149956,
    CnID = "怪物波次@主线3_8_3",
    BaseSortID = 138,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [886563] = {
    ID = 886563,
    CnID = "怪物波次@主线3_9_1",
    BaseSortID = 139,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [886903] = {
    ID = 886903,
    CnID = "怪物波次@主线3_9_2",
    BaseSortID = 140,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [887513] = {
    ID = 887513,
    CnID = "怪物波次@主线3_9_3",
    BaseSortID = 141,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [887869] = {
    ID = 887869,
    CnID = "怪物波次@主线3_9_4",
    BaseSortID = 142,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [887974] = {
    ID = 887974,
    CnID = "怪物波次@主线3_9_5",
    BaseSortID = 143,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [888934] = {
    ID = 888934,
    CnID = "怪物波次@主线3_9_6",
    BaseSortID = 144,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [702676] = {
    ID = 702676,
    CnID = "怪物波次@主线3_10_1",
    BaseSortID = 145,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [702767] = {
    ID = 702767,
    CnID = "怪物波次@主线3_10_2",
    BaseSortID = 146,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [702965] = {
    ID = 702965,
    CnID = "怪物波次@主线3_10_3",
    BaseSortID = 147,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [703010] = {
    ID = 703010,
    CnID = "怪物波次@主线3_10_4",
    BaseSortID = 148,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [703493] = {
    ID = 703493,
    CnID = "怪物波次@主线3_10_5",
    BaseSortID = 149,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [703884] = {
    ID = 703884,
    CnID = "怪物波次@主线3_10_6",
    BaseSortID = 150,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [704520] = {
    ID = 704520,
    CnID = "怪物波次@主线3_11_1",
    BaseSortID = 151,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [704757] = {
    ID = 704757,
    CnID = "怪物波次@主线3_11_2",
    BaseSortID = 152,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [705536] = {
    ID = 705536,
    CnID = "怪物波次@主线3_11_3",
    BaseSortID = 153,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [705729] = {
    ID = 705729,
    CnID = "怪物波次@主线3_11_4",
    BaseSortID = 154,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [706119] = {
    ID = 706119,
    CnID = "怪物波次@主线3_11_5",
    BaseSortID = 155,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [706956] = {
    ID = 706956,
    CnID = "怪物波次@主线3_11_6",
    BaseSortID = 156,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [707781] = {
    ID = 707781,
    CnID = "怪物波次@主线3_11_7",
    BaseSortID = 157,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [708461] = {
    ID = 708461,
    CnID = "怪物波次@主线3_12_1",
    BaseSortID = 158,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [708994] = {
    ID = 708994,
    CnID = "怪物波次@主线3_12_2",
    BaseSortID = 159,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [709472] = {
    ID = 709472,
    CnID = "怪物波次@主线3_12_3",
    BaseSortID = 160,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [709904] = {
    ID = 709904,
    CnID = "怪物波次@主线3_12_4",
    BaseSortID = 161,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [710803] = {
    ID = 710803,
    CnID = "怪物波次@主线3_12_5",
    BaseSortID = 162,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [711444] = {
    ID = 711444,
    CnID = "怪物波次@主线3_12_6",
    BaseSortID = 163,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [711790] = {
    ID = 711790,
    CnID = "怪物波次@主线3_12_7",
    BaseSortID = 164,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = -7
  },
  [712225] = {
    ID = 712225,
    CnID = "怪物波次@主线3_12_8",
    BaseSortID = 165,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [151927] = {
    ID = 151927,
    CnID = "怪物波次@主线4_1_1",
    BaseSortID = 166,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [152259] = {
    ID = 152259,
    CnID = "怪物波次@主线4_1_2",
    BaseSortID = 167,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [153031] = {
    ID = 153031,
    CnID = "怪物波次@主线4_1_3",
    BaseSortID = 168,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [153131] = {
    ID = 153131,
    CnID = "怪物波次@主线4_1_4",
    BaseSortID = 169,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [229191] = {
    ID = 229191,
    CnID = "怪物波次@主线困难1_1_1",
    BaseSortID = 170,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [229648] = {
    ID = 229648,
    CnID = "怪物波次@主线困难1_1_2",
    BaseSortID = 171,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [230441] = {
    ID = 230441,
    CnID = "怪物波次@主线困难1_1_3",
    BaseSortID = 172,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 5
  },
  [872160] = {
    ID = 872160,
    CnID = "怪物波次@主线困难1_2_1",
    BaseSortID = 173,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [872286] = {
    ID = 872286,
    CnID = "怪物波次@主线困难1_2_2",
    BaseSortID = 174,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [872902] = {
    ID = 872902,
    CnID = "怪物波次@主线困难1_2_3",
    BaseSortID = 175,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [873021] = {
    ID = 873021,
    CnID = "怪物波次@主线困难1_2_4",
    BaseSortID = 176,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 5
  },
  [230971] = {
    ID = 230971,
    CnID = "怪物波次@主线困难1_3_1",
    BaseSortID = 177,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [231457] = {
    ID = 231457,
    CnID = "怪物波次@主线困难1_3_2",
    BaseSortID = 178,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [232391] = {
    ID = 232391,
    CnID = "怪物波次@主线困难1_3_3",
    BaseSortID = 179,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 5
  },
  [232951] = {
    ID = 232951,
    CnID = "怪物波次@主线困难1_3_4",
    BaseSortID = 180,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [873316] = {
    ID = 873316,
    CnID = "怪物波次@主线困难1_3_5",
    BaseSortID = 181,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 5
  },
  [874153] = {
    ID = 874153,
    CnID = "怪物波次@主线困难1_4_1",
    BaseSortID = 182,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [874711] = {
    ID = 874711,
    CnID = "怪物波次@主线困难1_4_2",
    BaseSortID = 183,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [874905] = {
    ID = 874905,
    CnID = "怪物波次@主线困难1_4_3",
    BaseSortID = 184,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [875010] = {
    ID = 875010,
    CnID = "怪物波次@主线困难1_4_4",
    BaseSortID = 185,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 5
  },
  [233221] = {
    ID = 233221,
    CnID = "怪物波次@主线困难1_5_1",
    BaseSortID = 186,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [233279] = {
    ID = 233279,
    CnID = "怪物波次@主线困难1_5_2",
    BaseSortID = 187,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [233371] = {
    ID = 233371,
    CnID = "怪物波次@主线困难1_5_3",
    BaseSortID = 188,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 5
  },
  [233565] = {
    ID = 233565,
    CnID = "怪物波次@主线困难1_5_4",
    BaseSortID = 189,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [234044] = {
    ID = 234044,
    CnID = "怪物波次@主线困难1_5_5",
    BaseSortID = 190,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7
  },
  [234387] = {
    ID = 234387,
    CnID = "怪物波次@主线困难1_5_6",
    BaseSortID = 191,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 5
  },
  [875671] = {
    ID = 875671,
    CnID = "怪物波次@主线困难1_6_1",
    BaseSortID = 192,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7
  },
  [876232] = {
    ID = 876232,
    CnID = "怪物波次@主线困难1_6_2",
    BaseSortID = 193,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7
  },
  [876978] = {
    ID = 876978,
    CnID = "怪物波次@主线困难1_6_3",
    BaseSortID = 194,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 5
  },
  [877432] = {
    ID = 877432,
    CnID = "怪物波次@主线困难1_6_4",
    BaseSortID = 195,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [878124] = {
    ID = 878124,
    CnID = "怪物波次@主线困难1_6_5",
    BaseSortID = 196,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [878491] = {
    ID = 878491,
    CnID = "怪物波次@主线困难1_6_6",
    BaseSortID = 197,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [235085] = {
    ID = 235085,
    CnID = "怪物波次@主线困难1_7_1",
    BaseSortID = 198,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7
  },
  [235732] = {
    ID = 235732,
    CnID = "怪物波次@主线困难1_7_2",
    BaseSortID = 199,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7
  },
  [236095] = {
    ID = 236095,
    CnID = "怪物波次@主线困难1_7_3",
    BaseSortID = 200,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [236964] = {
    ID = 236964,
    CnID = "怪物波次@主线困难1_7_4",
    BaseSortID = 201,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7
  },
  [878876] = {
    ID = 878876,
    CnID = "怪物波次@主线困难1_7_5",
    BaseSortID = 202,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7
  },
  [879198] = {
    ID = 879198,
    CnID = "怪物波次@主线困难1_7_6",
    BaseSortID = 203,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 5
  },
  [237431] = {
    ID = 237431,
    CnID = "怪物波次@主线困难1_8_1",
    BaseSortID = 204,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7
  },
  [238233] = {
    ID = 238233,
    CnID = "怪物波次@主线困难1_8_2",
    BaseSortID = 205,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7
  },
  [238527] = {
    ID = 238527,
    CnID = "怪物波次@主线困难1_8_3",
    BaseSortID = 206,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 5
  },
  [238562] = {
    ID = 238562,
    CnID = "怪物波次@主线困难1_8_4",
    BaseSortID = 207,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [239306] = {
    ID = 239306,
    CnID = "怪物波次@主线困难1_8_5",
    BaseSortID = 208,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [239574] = {
    ID = 239574,
    CnID = "怪物波次@主线困难1_8_6",
    BaseSortID = 209,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [879595] = {
    ID = 879595,
    CnID = "怪物波次@主线困难1_8_7",
    BaseSortID = 210,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [879602] = {
    ID = 879602,
    CnID = "怪物波次@主线困难1_8_8",
    BaseSortID = 211,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [251874] = {
    ID = 251874,
    CnID = "怪物波次@主线困难2_1_1",
    BaseSortID = 212,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [252629] = {
    ID = 252629,
    CnID = "怪物波次@主线困难2_1_2",
    BaseSortID = 213,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [253011] = {
    ID = 253011,
    CnID = "怪物波次@主线困难2_1_3",
    BaseSortID = 214,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [256152] = {
    ID = 256152,
    CnID = "怪物波次@主线困难2_2_1",
    BaseSortID = 215,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [256363] = {
    ID = 256363,
    CnID = "怪物波次@主线困难2_2_2",
    BaseSortID = 216,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [256728] = {
    ID = 256728,
    CnID = "怪物波次@主线困难2_2_3",
    BaseSortID = 217,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [259465] = {
    ID = 259465,
    CnID = "怪物波次@主线困难2_3_1",
    BaseSortID = 218,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [260295] = {
    ID = 260295,
    CnID = "怪物波次@主线困难2_3_2",
    BaseSortID = 219,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [260842] = {
    ID = 260842,
    CnID = "怪物波次@主线困难2_3_3",
    BaseSortID = 220,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [261735] = {
    ID = 261735,
    CnID = "怪物波次@主线困难2_3_4",
    BaseSortID = 221,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [263077] = {
    ID = 263077,
    CnID = "怪物波次@主线困难2_4_1",
    BaseSortID = 222,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [263214] = {
    ID = 263214,
    CnID = "怪物波次@主线困难2_4_2",
    BaseSortID = 223,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [263755] = {
    ID = 263755,
    CnID = "怪物波次@主线困难2_4_3",
    BaseSortID = 224,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 10
  },
  [264204] = {
    ID = 264204,
    CnID = "怪物波次@主线困难2_5_1",
    BaseSortID = 225,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [265128] = {
    ID = 265128,
    CnID = "怪物波次@主线困难2_5_2",
    BaseSortID = 226,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [265312] = {
    ID = 265312,
    CnID = "怪物波次@主线困难2_5_3",
    BaseSortID = 227,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [265888] = {
    ID = 265888,
    CnID = "怪物波次@主线困难2_5_4",
    BaseSortID = 228,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [266837] = {
    ID = 266837,
    CnID = "怪物波次@主线困难2_6_1",
    BaseSortID = 229,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [267721] = {
    ID = 267721,
    CnID = "怪物波次@主线困难2_6_2",
    BaseSortID = 230,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [268298] = {
    ID = 268298,
    CnID = "怪物波次@主线困难2_6_3",
    BaseSortID = 231,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [268934] = {
    ID = 268934,
    CnID = "怪物波次@主线困难2_6_4",
    BaseSortID = 232,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [269206] = {
    ID = 269206,
    CnID = "怪物波次@主线困难2_6_5",
    BaseSortID = 233,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [269906] = {
    ID = 269906,
    CnID = "怪物波次@主线困难2_6_6",
    BaseSortID = 234,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 10
  },
  [270611] = {
    ID = 270611,
    CnID = "怪物波次@主线困难2_7_1",
    BaseSortID = 235,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [271578] = {
    ID = 271578,
    CnID = "怪物波次@主线困难2_7_2",
    BaseSortID = 236,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [272069] = {
    ID = 272069,
    CnID = "怪物波次@主线困难2_7_3",
    BaseSortID = 237,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [272164] = {
    ID = 272164,
    CnID = "怪物波次@主线困难2_7_4",
    BaseSortID = 238,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [273745] = {
    ID = 273745,
    CnID = "怪物波次@主线困难2_8_1",
    BaseSortID = 239,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [273851] = {
    ID = 273851,
    CnID = "怪物波次@主线困难2_8_2",
    BaseSortID = 240,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [274307] = {
    ID = 274307,
    CnID = "怪物波次@主线困难2_8_3",
    BaseSortID = 241,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [275117] = {
    ID = 275117,
    CnID = "怪物波次@主线困难2_8_4",
    BaseSortID = 242,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [275547] = {
    ID = 275547,
    CnID = "怪物波次@主线困难2_8_5",
    BaseSortID = 243,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [276135] = {
    ID = 276135,
    CnID = "怪物波次@主线困难2_8_6",
    BaseSortID = 244,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [880540] = {
    ID = 880540,
    CnID = "怪物波次@主线困难2_9_1",
    BaseSortID = 245,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [881390] = {
    ID = 881390,
    CnID = "怪物波次@主线困难2_9_2",
    BaseSortID = 246,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [882014] = {
    ID = 882014,
    CnID = "怪物波次@主线困难2_9_3",
    BaseSortID = 247,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [882536] = {
    ID = 882536,
    CnID = "怪物波次@主线困难2_9_4",
    BaseSortID = 248,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [883304] = {
    ID = 883304,
    CnID = "怪物波次@主线困难2_9_5",
    BaseSortID = 249,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [883471] = {
    ID = 883471,
    CnID = "怪物波次@主线困难2_9_6",
    BaseSortID = 250,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [743886] = {
    ID = 743886,
    CnID = "怪物波次@主线困难2_10_1",
    BaseSortID = 251,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [744542] = {
    ID = 744542,
    CnID = "怪物波次@主线困难2_10_2",
    BaseSortID = 252,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [745178] = {
    ID = 745178,
    CnID = "怪物波次@主线困难2_10_3",
    BaseSortID = 253,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [745606] = {
    ID = 745606,
    CnID = "怪物波次@主线困难2_10_4",
    BaseSortID = 254,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [746386] = {
    ID = 746386,
    CnID = "怪物波次@主线困难2_10_5",
    BaseSortID = 255,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [746893] = {
    ID = 746893,
    CnID = "怪物波次@主线困难2_10_6",
    BaseSortID = 256,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [884110] = {
    ID = 884110,
    CnID = "怪物波次@主线困难2_10_7",
    BaseSortID = 257,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 5
  },
  [884879] = {
    ID = 884879,
    CnID = "怪物波次@主线困难2_10_8",
    BaseSortID = 258,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [885004] = {
    ID = 885004,
    CnID = "怪物波次@主线困难2_10_9",
    BaseSortID = 259,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [885579] = {
    ID = 885579,
    CnID = "怪物波次@主线困难2_10_10",
    BaseSortID = 260,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [886348] = {
    ID = 886348,
    CnID = "怪物波次@主线困难2_10_11",
    BaseSortID = 261,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [276538] = {
    ID = 276538,
    CnID = "怪物波次@主线困难3_1_1",
    BaseSortID = 262,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [276647] = {
    ID = 276647,
    CnID = "怪物波次@主线困难3_1_2",
    BaseSortID = 263,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [276955] = {
    ID = 276955,
    CnID = "怪物波次@主线困难3_1_3",
    BaseSortID = 264,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [278279] = {
    ID = 278279,
    CnID = "怪物波次@主线困难3_2_1",
    BaseSortID = 265,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [279165] = {
    ID = 279165,
    CnID = "怪物波次@主线困难3_2_2",
    BaseSortID = 266,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [279423] = {
    ID = 279423,
    CnID = "怪物波次@主线困难3_2_3",
    BaseSortID = 267,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [279526] = {
    ID = 279526,
    CnID = "怪物波次@主线困难3_2_4",
    BaseSortID = 268,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [281385] = {
    ID = 281385,
    CnID = "怪物波次@主线困难3_3_1",
    BaseSortID = 269,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [281548] = {
    ID = 281548,
    CnID = "怪物波次@主线困难3_3_2",
    BaseSortID = 270,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [282371] = {
    ID = 282371,
    CnID = "怪物波次@主线困难3_3_3",
    BaseSortID = 271,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [282799] = {
    ID = 282799,
    CnID = "怪物波次@主线困难3_3_4",
    BaseSortID = 272,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [282869] = {
    ID = 282869,
    CnID = "怪物波次@主线困难3_3_5",
    BaseSortID = 273,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [283985] = {
    ID = 283985,
    CnID = "怪物波次@主线困难3_4_1",
    BaseSortID = 274,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [284462] = {
    ID = 284462,
    CnID = "怪物波次@主线困难3_4_2",
    BaseSortID = 275,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [284742] = {
    ID = 284742,
    CnID = "怪物波次@主线困难3_4_3",
    BaseSortID = 276,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [284883] = {
    ID = 284883,
    CnID = "怪物波次@主线困难3_4_4",
    BaseSortID = 277,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [285739] = {
    ID = 285739,
    CnID = "怪物波次@主线困难3_4_5",
    BaseSortID = 278,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [286224] = {
    ID = 286224,
    CnID = "怪物波次@主线困难3_4_6",
    BaseSortID = 279,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [287027] = {
    ID = 287027,
    CnID = "怪物波次@主线困难3_5_1",
    BaseSortID = 280,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [287041] = {
    ID = 287041,
    CnID = "怪物波次@主线困难3_5_2",
    BaseSortID = 281,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [287552] = {
    ID = 287552,
    CnID = "怪物波次@主线困难3_5_3",
    BaseSortID = 282,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [287668] = {
    ID = 287668,
    CnID = "怪物波次@主线困难3_5_4",
    BaseSortID = 283,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [288064] = {
    ID = 288064,
    CnID = "怪物波次@主线困难3_5_5",
    BaseSortID = 284,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [288112] = {
    ID = 288112,
    CnID = "怪物波次@主线困难3_5_6",
    BaseSortID = 285,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [953957] = {
    ID = 953957,
    CnID = "怪物波次@主线困难3_5_7",
    BaseSortID = 286,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [288595] = {
    ID = 288595,
    CnID = "怪物波次@主线困难3_6_1",
    BaseSortID = 287,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [288972] = {
    ID = 288972,
    CnID = "怪物波次@主线困难3_6_2",
    BaseSortID = 288,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [289497] = {
    ID = 289497,
    CnID = "怪物波次@主线困难3_6_3",
    BaseSortID = 289,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [289686] = {
    ID = 289686,
    CnID = "怪物波次@主线困难3_6_4",
    BaseSortID = 290,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [291452] = {
    ID = 291452,
    CnID = "怪物波次@主线困难3_7_1",
    BaseSortID = 291,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [292373] = {
    ID = 292373,
    CnID = "怪物波次@主线困难3_7_2",
    BaseSortID = 292,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [292664] = {
    ID = 292664,
    CnID = "怪物波次@主线困难3_7_3",
    BaseSortID = 293,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [293239] = {
    ID = 293239,
    CnID = "怪物波次@主线困难3_8_1",
    BaseSortID = 294,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [294233] = {
    ID = 294233,
    CnID = "怪物波次@主线困难3_8_2",
    BaseSortID = 295,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [295134] = {
    ID = 295134,
    CnID = "怪物波次@主线困难3_8_3",
    BaseSortID = 296,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [955447] = {
    ID = 955447,
    CnID = "怪物波次@主线困难3_9_1",
    BaseSortID = 297,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [956380] = {
    ID = 956380,
    CnID = "怪物波次@主线困难3_9_2",
    BaseSortID = 298,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [957008] = {
    ID = 957008,
    CnID = "怪物波次@主线困难3_9_3",
    BaseSortID = 299,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [957619] = {
    ID = 957619,
    CnID = "怪物波次@主线困难3_9_4",
    BaseSortID = 300,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [957856] = {
    ID = 957856,
    CnID = "怪物波次@主线困难3_9_5",
    BaseSortID = 301,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [958062] = {
    ID = 958062,
    CnID = "怪物波次@主线困难3_9_6",
    BaseSortID = 302,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [756464] = {
    ID = 756464,
    CnID = "怪物波次@主线困难3_10_1",
    BaseSortID = 303,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [756686] = {
    ID = 756686,
    CnID = "怪物波次@主线困难3_10_2",
    BaseSortID = 304,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [757135] = {
    ID = 757135,
    CnID = "怪物波次@主线困难3_10_3",
    BaseSortID = 305,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [757464] = {
    ID = 757464,
    CnID = "怪物波次@主线困难3_10_4",
    BaseSortID = 306,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [757800] = {
    ID = 757800,
    CnID = "怪物波次@主线困难3_10_5",
    BaseSortID = 307,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [758686] = {
    ID = 758686,
    CnID = "怪物波次@主线困难3_10_6",
    BaseSortID = 308,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [758740] = {
    ID = 758740,
    CnID = "怪物波次@主线困难3_11_1",
    BaseSortID = 309,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [759415] = {
    ID = 759415,
    CnID = "怪物波次@主线困难3_11_2",
    BaseSortID = 310,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [759580] = {
    ID = 759580,
    CnID = "怪物波次@主线困难3_11_3",
    BaseSortID = 311,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [760061] = {
    ID = 760061,
    CnID = "怪物波次@主线困难3_11_4",
    BaseSortID = 312,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [760949] = {
    ID = 760949,
    CnID = "怪物波次@主线困难3_11_5",
    BaseSortID = 313,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [761339] = {
    ID = 761339,
    CnID = "怪物波次@主线困难3_11_6",
    BaseSortID = 314,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [762246] = {
    ID = 762246,
    CnID = "怪物波次@主线困难3_11_7",
    BaseSortID = 315,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [762672] = {
    ID = 762672,
    CnID = "怪物波次@主线困难3_12_1",
    BaseSortID = 316,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [762710] = {
    ID = 762710,
    CnID = "怪物波次@主线困难3_12_2",
    BaseSortID = 317,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [762877] = {
    ID = 762877,
    CnID = "怪物波次@主线困难3_12_3",
    BaseSortID = 318,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [763838] = {
    ID = 763838,
    CnID = "怪物波次@主线困难3_12_4",
    BaseSortID = 319,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [764391] = {
    ID = 764391,
    CnID = "怪物波次@主线困难3_12_5",
    BaseSortID = 320,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [764903] = {
    ID = 764903,
    CnID = "怪物波次@主线困难3_12_6",
    BaseSortID = 321,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [765684] = {
    ID = 765684,
    CnID = "怪物波次@主线困难3_12_7",
    BaseSortID = 322,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = -7
  },
  [765849] = {
    ID = 765849,
    CnID = "怪物波次@主线困难3_12_8",
    BaseSortID = 323,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [369614] = {
    ID = 369614,
    CnID = "怪物波次@日常金币1_1",
    BaseSortID = 324,
    School = 1,
    Monster1 = 4942795,
    MonsterPoint1 = 8
  },
  [371448] = {
    ID = 371448,
    CnID = "怪物波次@日常金币2_1",
    BaseSortID = 325,
    School = 1,
    Monster1 = 4943306,
    MonsterPoint1 = 8
  },
  [373866] = {
    ID = 373866,
    CnID = "怪物波次@日常金币3_1",
    BaseSortID = 326,
    School = 1,
    Monster1 = 4943492,
    MonsterPoint1 = 8
  },
  [377301] = {
    ID = 377301,
    CnID = "怪物波次@日常金币4_1",
    BaseSortID = 327,
    School = 1,
    Monster1 = 4943757,
    MonsterPoint1 = 8
  },
  [380972] = {
    ID = 380972,
    CnID = "怪物波次@日常金币5_1",
    BaseSortID = 328,
    School = 1,
    Monster1 = 4944204,
    MonsterPoint1 = 8
  },
  [394565] = {
    ID = 394565,
    CnID = "怪物波次@日常经验1_1",
    BaseSortID = 329,
    School = 1,
    Monster1 = 4848396,
    MonsterPoint1 = 1
  },
  [398215] = {
    ID = 398215,
    CnID = "怪物波次@日常经验2_1",
    BaseSortID = 330,
    School = 1,
    Monster1 = 4849212,
    MonsterPoint1 = 1
  },
  [400074] = {
    ID = 400074,
    CnID = "怪物波次@日常经验3_1",
    BaseSortID = 331,
    School = 1,
    Monster1 = 4850018,
    MonsterPoint1 = 1
  },
  [402353] = {
    ID = 402353,
    CnID = "怪物波次@日常经验4_1",
    BaseSortID = 332,
    School = 1,
    Monster1 = 4850224,
    MonsterPoint1 = 1
  },
  [406048] = {
    ID = 406048,
    CnID = "怪物波次@日常经验5_1",
    BaseSortID = 333,
    School = 1,
    Monster1 = 4850744,
    MonsterPoint1 = 1
  },
  [420027] = {
    ID = 420027,
    CnID = "怪物波次@日常深海1_1",
    BaseSortID = 334,
    School = 1,
    Monster1 = 4944685,
    MonsterPoint1 = 8
  },
  [422912] = {
    ID = 422912,
    CnID = "怪物波次@日常深海2_1",
    BaseSortID = 335,
    School = 1,
    Monster1 = 4945612,
    MonsterPoint1 = 8
  },
  [425901] = {
    ID = 425901,
    CnID = "怪物波次@日常深海3_1",
    BaseSortID = 336,
    School = 1,
    Monster1 = 4945887,
    MonsterPoint1 = 8
  },
  [428447] = {
    ID = 428447,
    CnID = "怪物波次@日常深海4_1",
    BaseSortID = 337,
    School = 1,
    Monster1 = 4945900,
    MonsterPoint1 = 8
  },
  [431174] = {
    ID = 431174,
    CnID = "怪物波次@日常深海5_1",
    BaseSortID = 338,
    School = 1,
    Monster1 = 4946114,
    MonsterPoint1 = 8
  },
  [443410] = {
    ID = 443410,
    CnID = "怪物波次@日常血肉1_1",
    BaseSortID = 339,
    Monster1 = 4946182,
    MonsterPoint1 = 8
  },
  [446487] = {
    ID = 446487,
    CnID = "怪物波次@日常血肉2_1",
    BaseSortID = 340,
    School = 1,
    Monster1 = 4946484,
    MonsterPoint1 = 8
  },
  [448685] = {
    ID = 448685,
    CnID = "怪物波次@日常血肉3_1",
    BaseSortID = 341,
    School = 1,
    Monster1 = 4947384,
    MonsterPoint1 = 8
  },
  [451070] = {
    ID = 451070,
    CnID = "怪物波次@日常血肉4_1",
    BaseSortID = 342,
    School = 1,
    Monster1 = 4948200,
    MonsterPoint1 = 8
  },
  [454684] = {
    ID = 454684,
    CnID = "怪物波次@日常血肉5_1",
    BaseSortID = 343,
    School = 1,
    Monster1 = 4948502,
    MonsterPoint1 = 8
  },
  [472040] = {
    ID = 472040,
    CnID = "怪物波次@日常超维1_1",
    BaseSortID = 344,
    School = 1,
    Monster1 = 4948759,
    MonsterPoint1 = 8
  },
  [474516] = {
    ID = 474516,
    CnID = "怪物波次@日常超维2_1",
    BaseSortID = 345,
    School = 1,
    Monster1 = 4949004,
    MonsterPoint1 = 8
  },
  [477972] = {
    ID = 477972,
    CnID = "怪物波次@日常超维3_1",
    BaseSortID = 346,
    School = 1,
    Monster1 = 4949062,
    MonsterPoint1 = 8
  },
  [480878] = {
    ID = 480878,
    CnID = "怪物波次@日常超维4_1",
    BaseSortID = 347,
    School = 1,
    Monster1 = 4949433,
    MonsterPoint1 = 8
  },
  [483002] = {
    ID = 483002,
    CnID = "怪物波次@日常超维5_1",
    BaseSortID = 348,
    School = 1,
    Monster1 = 4950187,
    MonsterPoint1 = 8
  },
  [960298] = {
    ID = 960298,
    CnID = "怪物波次@日常混沌1_1",
    BaseSortID = 349,
    Monster1 = 4955230,
    MonsterPoint1 = 8
  },
  [960623] = {
    ID = 960623,
    CnID = "怪物波次@日常混沌2_1",
    BaseSortID = 350,
    Monster1 = 4956224,
    MonsterPoint1 = 8
  },
  [960846] = {
    ID = 960846,
    CnID = "怪物波次@日常混沌3_1",
    BaseSortID = 351,
    Monster1 = 4956606,
    MonsterPoint1 = 8
  },
  [961483] = {
    ID = 961483,
    CnID = "怪物波次@日常混沌4_1",
    BaseSortID = 352,
    Monster1 = 4957104,
    MonsterPoint1 = 8
  },
  [962205] = {
    ID = 962205,
    CnID = "怪物波次@日常混沌5_1",
    BaseSortID = 353,
    Monster1 = 4957887,
    MonsterPoint1 = 8
  },
  [962647] = {
    ID = 962647,
    CnID = "怪物波次@日常攻击1_1",
    BaseSortID = 354,
    Monster1 = 4957979,
    MonsterPoint1 = 8
  },
  [962896] = {
    ID = 962896,
    CnID = "怪物波次@日常攻击2_1",
    BaseSortID = 355,
    Monster1 = 4958694,
    MonsterPoint1 = 8
  },
  [963682] = {
    ID = 963682,
    CnID = "怪物波次@日常攻击3_1",
    BaseSortID = 356,
    Monster1 = 4959504,
    MonsterPoint1 = 8
  },
  [964462] = {
    ID = 964462,
    CnID = "怪物波次@日常攻击4_1",
    BaseSortID = 357,
    Monster1 = 4960049,
    MonsterPoint1 = 8
  },
  [965193] = {
    ID = 965193,
    CnID = "怪物波次@日常攻击5_1",
    BaseSortID = 358,
    Monster1 = 4960756,
    MonsterPoint1 = 8
  },
  [965286] = {
    ID = 965286,
    CnID = "怪物波次@日常防御1_1",
    BaseSortID = 359,
    Monster1 = 4960941,
    MonsterPoint1 = 8
  },
  [965599] = {
    ID = 965599,
    CnID = "怪物波次@日常防御2_1",
    BaseSortID = 360,
    Monster1 = 4961664,
    MonsterPoint1 = 8
  },
  [966190] = {
    ID = 966190,
    CnID = "怪物波次@日常防御3_1",
    BaseSortID = 361,
    Monster1 = 4961676,
    MonsterPoint1 = 8
  },
  [966655] = {
    ID = 966655,
    CnID = "怪物波次@日常防御4_1",
    BaseSortID = 362,
    Monster1 = 4961999,
    MonsterPoint1 = 8
  },
  [966993] = {
    ID = 966993,
    CnID = "怪物波次@日常防御5_1",
    BaseSortID = 363,
    Monster1 = 4962118,
    MonsterPoint1 = 8
  },
  [967853] = {
    ID = 967853,
    CnID = "怪物波次@日常辅助1_1",
    BaseSortID = 364,
    Monster1 = 4962234,
    MonsterPoint1 = 8
  },
  [968384] = {
    ID = 968384,
    CnID = "怪物波次@日常辅助2_1",
    BaseSortID = 365,
    Monster1 = 4962265,
    MonsterPoint1 = 8
  },
  [968713] = {
    ID = 968713,
    CnID = "怪物波次@日常辅助3_1",
    BaseSortID = 366,
    Monster1 = 4962653,
    MonsterPoint1 = 8
  },
  [969250] = {
    ID = 969250,
    CnID = "怪物波次@日常辅助4_1",
    BaseSortID = 367,
    Monster1 = 4963350,
    MonsterPoint1 = 8
  },
  [969993] = {
    ID = 969993,
    CnID = "怪物波次@日常辅助5_1",
    BaseSortID = 368,
    Monster1 = 4963719,
    MonsterPoint1 = 8
  },
  [970836] = {
    ID = 970836,
    CnID = "怪物波次@武器突破一1_1",
    BaseSortID = 369,
    Monster1 = 4964381,
    MonsterPoint1 = 8
  },
  [971196] = {
    ID = 971196,
    CnID = "怪物波次@武器突破一2_1",
    BaseSortID = 370,
    Monster1 = 4964939,
    MonsterPoint1 = 8
  },
  [971575] = {
    ID = 971575,
    CnID = "怪物波次@武器突破一3_1",
    BaseSortID = 371,
    Monster1 = 4965616,
    MonsterPoint1 = 8
  },
  [971902] = {
    ID = 971902,
    CnID = "怪物波次@武器突破一4_1",
    BaseSortID = 372,
    Monster1 = 4965799,
    MonsterPoint1 = 8
  },
  [972101] = {
    ID = 972101,
    CnID = "怪物波次@武器突破一5_1",
    BaseSortID = 373,
    Monster1 = 4966306,
    MonsterPoint1 = 8
  },
  [972528] = {
    ID = 972528,
    CnID = "怪物波次@武器突破二1_1",
    BaseSortID = 374,
    Monster1 = 4967230,
    Monster2 = 4968358,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [972563] = {
    ID = 972563,
    CnID = "怪物波次@武器突破二2_1",
    BaseSortID = 375,
    Monster1 = 4967366,
    Monster2 = 4968731,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [972593] = {
    ID = 972593,
    CnID = "怪物波次@武器突破二3_1",
    BaseSortID = 376,
    Monster1 = 4967548,
    Monster2 = 4969185,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [973291] = {
    ID = 973291,
    CnID = "怪物波次@武器突破二4_1",
    BaseSortID = 377,
    Monster1 = 4967788,
    Monster2 = 4969738,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [974139] = {
    ID = 974139,
    CnID = "怪物波次@武器突破二5_1",
    BaseSortID = 378,
    Monster1 = 4967928,
    Monster2 = 4970283,
    MonsterPoint1 = 3,
    MonsterPoint2 = 7
  },
  [975017] = {
    ID = 975017,
    CnID = "怪物波次@武器突破三1_1",
    BaseSortID = 379,
    Monster1 = 4971211,
    MonsterPoint1 = 8
  },
  [975714] = {
    ID = 975714,
    CnID = "怪物波次@武器突破三2_1",
    BaseSortID = 380,
    Monster1 = 4971642,
    MonsterPoint1 = 8
  },
  [976214] = {
    ID = 976214,
    CnID = "怪物波次@武器突破三3_1",
    BaseSortID = 381,
    Monster1 = 4971780,
    MonsterPoint1 = 8
  },
  [977128] = {
    ID = 977128,
    CnID = "怪物波次@武器突破三4_1",
    BaseSortID = 382,
    Monster1 = 4972642,
    MonsterPoint1 = 8
  },
  [977153] = {
    ID = 977153,
    CnID = "怪物波次@武器突破三5_1",
    BaseSortID = 383,
    Monster1 = 4973563,
    MonsterPoint1 = 8
  },
  [498921] = {
    ID = 498921,
    CnID = "怪物波次@饰品A1_1",
    BaseSortID = 384,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [501492] = {
    ID = 501492,
    CnID = "怪物波次@饰品A2_1",
    BaseSortID = 385,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [504160] = {
    ID = 504160,
    CnID = "怪物波次@饰品A3_1",
    BaseSortID = 386,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [507367] = {
    ID = 507367,
    CnID = "怪物波次@饰品A4_1",
    BaseSortID = 387,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [510592] = {
    ID = 510592,
    CnID = "怪物波次@饰品A5_1",
    BaseSortID = 388,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [514052] = {
    ID = 514052,
    CnID = "怪物波次@饰品A6_1",
    BaseSortID = 389,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [515875] = {
    ID = 515875,
    CnID = "怪物波次@饰品A7_1",
    BaseSortID = 390,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [518515] = {
    ID = 518515,
    CnID = "怪物波次@饰品A8_1",
    BaseSortID = 391,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [524001] = {
    ID = 524001,
    CnID = "怪物波次@饰品B1_1",
    BaseSortID = 392,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [527533] = {
    ID = 527533,
    CnID = "怪物波次@饰品B2_1",
    BaseSortID = 393,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [530100] = {
    ID = 530100,
    CnID = "怪物波次@饰品B3_1",
    BaseSortID = 394,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [534097] = {
    ID = 534097,
    CnID = "怪物波次@饰品B4_1",
    BaseSortID = 395,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [537992] = {
    ID = 537992,
    CnID = "怪物波次@饰品B5_1",
    BaseSortID = 396,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [540530] = {
    ID = 540530,
    CnID = "怪物波次@饰品B6_1",
    BaseSortID = 397,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [544572] = {
    ID = 544572,
    CnID = "怪物波次@饰品B7_1",
    BaseSortID = 398,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [549138] = {
    ID = 549138,
    CnID = "怪物波次@饰品B8_1",
    BaseSortID = 399,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [556202] = {
    ID = 556202,
    CnID = "怪物波次@饰品C1_1",
    BaseSortID = 400,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [557909] = {
    ID = 557909,
    CnID = "怪物波次@饰品C2_1",
    BaseSortID = 401,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [560685] = {
    ID = 560685,
    CnID = "怪物波次@饰品C3_1",
    BaseSortID = 402,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [564023] = {
    ID = 564023,
    CnID = "怪物波次@饰品C4_1",
    BaseSortID = 403,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [568379] = {
    ID = 568379,
    CnID = "怪物波次@饰品C5_1",
    BaseSortID = 404,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [571560] = {
    ID = 571560,
    CnID = "怪物波次@饰品C6_1",
    BaseSortID = 405,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [574429] = {
    ID = 574429,
    CnID = "怪物波次@饰品C7_1",
    BaseSortID = 406,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [577844] = {
    ID = 577844,
    CnID = "怪物波次@饰品C8_1",
    BaseSortID = 407,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 1
  },
  [585155] = {
    ID = 585155,
    CnID = "怪物波次@饰品D1_1",
    BaseSortID = 408,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [588726] = {
    ID = 588726,
    CnID = "怪物波次@饰品D2_1",
    BaseSortID = 409,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [591273] = {
    ID = 591273,
    CnID = "怪物波次@饰品D3_1",
    BaseSortID = 410,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [593529] = {
    ID = 593529,
    CnID = "怪物波次@饰品D4_1",
    BaseSortID = 411,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [596884] = {
    ID = 596884,
    CnID = "怪物波次@饰品D5_1",
    BaseSortID = 412,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [598627] = {
    ID = 598627,
    CnID = "怪物波次@饰品D6_1",
    BaseSortID = 413,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [601189] = {
    ID = 601189,
    CnID = "怪物波次@饰品D7_1",
    BaseSortID = 414,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [604224] = {
    ID = 604224,
    CnID = "怪物波次@饰品D8_1",
    BaseSortID = 415,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [609998] = {
    ID = 609998,
    CnID = "怪物波次@饰品E1_1",
    BaseSortID = 416,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [612726] = {
    ID = 612726,
    CnID = "怪物波次@饰品E2_1",
    BaseSortID = 417,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [615642] = {
    ID = 615642,
    CnID = "怪物波次@饰品E3_1",
    BaseSortID = 418,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [618243] = {
    ID = 618243,
    CnID = "怪物波次@饰品E4_1",
    BaseSortID = 419,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [620852] = {
    ID = 620852,
    CnID = "怪物波次@饰品E5_1",
    BaseSortID = 420,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [624134] = {
    ID = 624134,
    CnID = "怪物波次@饰品E6_1",
    BaseSortID = 421,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [625727] = {
    ID = 625727,
    CnID = "怪物波次@饰品E7_1",
    BaseSortID = 422,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [629170] = {
    ID = 629170,
    CnID = "怪物波次@饰品E8_1",
    BaseSortID = 423,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [635923] = {
    ID = 635923,
    CnID = "怪物波次@饰品F1_1",
    BaseSortID = 424,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [639143] = {
    ID = 639143,
    CnID = "怪物波次@饰品F2_1",
    BaseSortID = 425,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [642250] = {
    ID = 642250,
    CnID = "怪物波次@饰品F3_1",
    BaseSortID = 426,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [644176] = {
    ID = 644176,
    CnID = "怪物波次@饰品F4_1",
    BaseSortID = 427,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [646505] = {
    ID = 646505,
    CnID = "怪物波次@饰品F5_1",
    BaseSortID = 428,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [649968] = {
    ID = 649968,
    CnID = "怪物波次@饰品F6_1",
    BaseSortID = 429,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [653051] = {
    ID = 653051,
    CnID = "怪物波次@饰品F7_1",
    BaseSortID = 430,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [655020] = {
    ID = 655020,
    CnID = "怪物波次@饰品F8_1",
    BaseSortID = 431,
    School = 1,
    Monster1 = 4824248,
    MonsterPoint1 = 2
  },
  [800748] = {
    ID = 800748,
    CnID = "怪物波次@周常挑战1_1_1",
    BaseSortID = 432,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [801039] = {
    ID = 801039,
    CnID = "怪物波次@周常挑战1_1_2",
    BaseSortID = 433,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [801442] = {
    ID = 801442,
    CnID = "怪物波次@周常挑战1_1_3",
    BaseSortID = 434,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [801752] = {
    ID = 801752,
    CnID = "怪物波次@周常挑战1_2_1",
    BaseSortID = 435,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [801855] = {
    ID = 801855,
    CnID = "怪物波次@周常挑战1_2_2",
    BaseSortID = 436,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [802565] = {
    ID = 802565,
    CnID = "怪物波次@周常挑战1_2_3",
    BaseSortID = 437,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [805435] = {
    ID = 805435,
    CnID = "怪物波次@周常挑战2_1_1",
    BaseSortID = 438,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [805794] = {
    ID = 805794,
    CnID = "怪物波次@周常挑战2_1_2",
    BaseSortID = 439,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [806146] = {
    ID = 806146,
    CnID = "怪物波次@周常挑战2_1_3",
    BaseSortID = 440,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [889326] = {
    ID = 889326,
    CnID = "怪物波次@周常挑战2_1_4",
    BaseSortID = 441,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [806425] = {
    ID = 806425,
    CnID = "怪物波次@周常挑战2_2_1",
    BaseSortID = 442,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [806741] = {
    ID = 806741,
    CnID = "怪物波次@周常挑战2_2_2",
    BaseSortID = 443,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [807431] = {
    ID = 807431,
    CnID = "怪物波次@周常挑战2_2_3",
    BaseSortID = 444,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [864373] = {
    ID = 864373,
    CnID = "怪物波次@周常挑战2_2_4",
    BaseSortID = 445,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [809117] = {
    ID = 809117,
    CnID = "怪物波次@周常挑战3_1_1",
    BaseSortID = 446,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [809599] = {
    ID = 809599,
    CnID = "怪物波次@周常挑战3_1_2",
    BaseSortID = 447,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [810396] = {
    ID = 810396,
    CnID = "怪物波次@周常挑战3_1_3",
    BaseSortID = 448,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [810866] = {
    ID = 810866,
    CnID = "怪物波次@周常挑战3_1_4",
    BaseSortID = 449,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [811035] = {
    ID = 811035,
    CnID = "怪物波次@周常挑战3_1_5",
    BaseSortID = 450,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [811134] = {
    ID = 811134,
    CnID = "怪物波次@周常挑战3_1_6",
    BaseSortID = 451,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [889698] = {
    ID = 889698,
    CnID = "怪物波次@周常挑战3_1_7",
    BaseSortID = 452,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [811811] = {
    ID = 811811,
    CnID = "怪物波次@周常挑战3_2_1",
    BaseSortID = 453,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [812355] = {
    ID = 812355,
    CnID = "怪物波次@周常挑战3_2_2",
    BaseSortID = 454,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [813116] = {
    ID = 813116,
    CnID = "怪物波次@周常挑战3_2_3",
    BaseSortID = 455,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [814167] = {
    ID = 814167,
    CnID = "怪物波次@周常挑战3_3_1",
    BaseSortID = 456,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [814719] = {
    ID = 814719,
    CnID = "怪物波次@周常挑战3_3_2",
    BaseSortID = 457,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [815306] = {
    ID = 815306,
    CnID = "怪物波次@周常挑战3_3_3",
    BaseSortID = 458,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [815409] = {
    ID = 815409,
    CnID = "怪物波次@周常挑战3_3_4",
    BaseSortID = 459,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 9
  },
  [815807] = {
    ID = 815807,
    CnID = "怪物波次@周常挑战3_3_5",
    BaseSortID = 460,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [816035] = {
    ID = 816035,
    CnID = "怪物波次@周常挑战3_3_6",
    BaseSortID = 461,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [816739] = {
    ID = 816739,
    CnID = "怪物波次@周常挑战4_1_1",
    BaseSortID = 462,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [817485] = {
    ID = 817485,
    CnID = "怪物波次@周常挑战4_1_2",
    BaseSortID = 463,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [818229] = {
    ID = 818229,
    CnID = "怪物波次@周常挑战4_1_3",
    BaseSortID = 464,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [890241] = {
    ID = 890241,
    CnID = "怪物波次@周常挑战4_1_4",
    BaseSortID = 465,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 6,
    MonsterPoint3 = 9
  },
  [890828] = {
    ID = 890828,
    CnID = "怪物波次@周常挑战4_1_5",
    BaseSortID = 466,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 6,
    MonsterPoint3 = 9
  },
  [891234] = {
    ID = 891234,
    CnID = "怪物波次@周常挑战4_1_6",
    BaseSortID = 467,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9
  },
  [891920] = {
    ID = 891920,
    CnID = "怪物波次@周常挑战4_1_7",
    BaseSortID = 468,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [818394] = {
    ID = 818394,
    CnID = "怪物波次@周常挑战4_2_1",
    BaseSortID = 469,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [819023] = {
    ID = 819023,
    CnID = "怪物波次@周常挑战4_2_2",
    BaseSortID = 470,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [819557] = {
    ID = 819557,
    CnID = "怪物波次@周常挑战4_2_3",
    BaseSortID = 471,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [819764] = {
    ID = 819764,
    CnID = "怪物波次@周常挑战4_3_1",
    BaseSortID = 472,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [820459] = {
    ID = 820459,
    CnID = "怪物波次@周常挑战4_3_2",
    BaseSortID = 473,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [820650] = {
    ID = 820650,
    CnID = "怪物波次@周常挑战4_3_3",
    BaseSortID = 474,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9
  },
  [892607] = {
    ID = 892607,
    CnID = "怪物波次@周常挑战4_3_4",
    BaseSortID = 475,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [893136] = {
    ID = 893136,
    CnID = "怪物波次@周常挑战4_3_5",
    BaseSortID = 476,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9,
    MonsterPoint3 = 6
  },
  [893857] = {
    ID = 893857,
    CnID = "怪物波次@周常挑战4_3_6",
    BaseSortID = 477,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [821584] = {
    ID = 821584,
    CnID = "怪物波次@周常挑战5_1_1",
    BaseSortID = 478,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [821656] = {
    ID = 821656,
    CnID = "怪物波次@周常挑战5_1_2",
    BaseSortID = 479,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [822141] = {
    ID = 822141,
    CnID = "怪物波次@周常挑战5_1_3",
    BaseSortID = 480,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [894811] = {
    ID = 894811,
    CnID = "怪物波次@周常挑战5_1_4",
    BaseSortID = 481,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [895404] = {
    ID = 895404,
    CnID = "怪物波次@周常挑战5_1_5",
    BaseSortID = 482,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [895848] = {
    ID = 895848,
    CnID = "怪物波次@周常挑战5_1_6",
    BaseSortID = 483,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [895878] = {
    ID = 895878,
    CnID = "怪物波次@周常挑战5_1_7",
    BaseSortID = 484,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [822182] = {
    ID = 822182,
    CnID = "怪物波次@周常挑战5_2_1",
    BaseSortID = 485,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [822628] = {
    ID = 822628,
    CnID = "怪物波次@周常挑战5_2_2",
    BaseSortID = 486,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [823411] = {
    ID = 823411,
    CnID = "怪物波次@周常挑战5_2_3",
    BaseSortID = 487,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [824029] = {
    ID = 824029,
    CnID = "怪物波次@周常挑战5_3_1",
    BaseSortID = 488,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [824675] = {
    ID = 824675,
    CnID = "怪物波次@周常挑战5_3_2",
    BaseSortID = 489,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [825235] = {
    ID = 825235,
    CnID = "怪物波次@周常挑战5_3_3",
    BaseSortID = 490,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [896661] = {
    ID = 896661,
    CnID = "怪物波次@周常挑战5_3_4",
    BaseSortID = 491,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 9
  },
  [896829] = {
    ID = 896829,
    CnID = "怪物波次@周常挑战5_3_5",
    BaseSortID = 492,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [897186] = {
    ID = 897186,
    CnID = "怪物波次@周常挑战5_3_6",
    BaseSortID = 493,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [825536] = {
    ID = 825536,
    CnID = "怪物波次@周常挑战6_1_1",
    BaseSortID = 494,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [826309] = {
    ID = 826309,
    CnID = "怪物波次@周常挑战6_1_2",
    BaseSortID = 495,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [826778] = {
    ID = 826778,
    CnID = "怪物波次@周常挑战6_1_3",
    BaseSortID = 496,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [827413] = {
    ID = 827413,
    CnID = "怪物波次@周常挑战6_1_4",
    BaseSortID = 497,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 6,
    MonsterPoint3 = 9
  },
  [827452] = {
    ID = 827452,
    CnID = "怪物波次@周常挑战6_1_5",
    BaseSortID = 498,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 6,
    MonsterPoint3 = 9
  },
  [828352] = {
    ID = 828352,
    CnID = "怪物波次@周常挑战6_1_6",
    BaseSortID = 499,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9
  },
  [897899] = {
    ID = 897899,
    CnID = "怪物波次@周常挑战6_1_7",
    BaseSortID = 500,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [829055] = {
    ID = 829055,
    CnID = "怪物波次@周常挑战6_2_1",
    BaseSortID = 501,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [829786] = {
    ID = 829786,
    CnID = "怪物波次@周常挑战6_2_2",
    BaseSortID = 502,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [830579] = {
    ID = 830579,
    CnID = "怪物波次@周常挑战6_2_3",
    BaseSortID = 503,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [831662] = {
    ID = 831662,
    CnID = "怪物波次@周常挑战6_3_1",
    BaseSortID = 504,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [832099] = {
    ID = 832099,
    CnID = "怪物波次@周常挑战6_3_2",
    BaseSortID = 505,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [832788] = {
    ID = 832788,
    CnID = "怪物波次@周常挑战6_3_3",
    BaseSortID = 506,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9
  },
  [833697] = {
    ID = 833697,
    CnID = "怪物波次@周常挑战6_3_4",
    BaseSortID = 507,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [834385] = {
    ID = 834385,
    CnID = "怪物波次@周常挑战6_3_5",
    BaseSortID = 508,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9,
    MonsterPoint3 = 6
  },
  [834769] = {
    ID = 834769,
    CnID = "怪物波次@周常挑战6_3_6",
    BaseSortID = 509,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [836332] = {
    ID = 836332,
    CnID = "怪物波次@周常挑战7_1_1",
    BaseSortID = 510,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [837171] = {
    ID = 837171,
    CnID = "怪物波次@周常挑战7_1_2",
    BaseSortID = 511,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [837386] = {
    ID = 837386,
    CnID = "怪物波次@周常挑战7_1_3",
    BaseSortID = 512,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [898840] = {
    ID = 898840,
    CnID = "怪物波次@周常挑战7_1_4",
    BaseSortID = 513,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [898992] = {
    ID = 898992,
    CnID = "怪物波次@周常挑战7_1_5",
    BaseSortID = 514,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [899940] = {
    ID = 899940,
    CnID = "怪物波次@周常挑战7_1_6",
    BaseSortID = 515,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [900857] = {
    ID = 900857,
    CnID = "怪物波次@周常挑战7_1_7",
    BaseSortID = 516,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [838130] = {
    ID = 838130,
    CnID = "怪物波次@周常挑战7_2_1",
    BaseSortID = 517,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [838431] = {
    ID = 838431,
    CnID = "怪物波次@周常挑战7_2_2",
    BaseSortID = 518,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [839178] = {
    ID = 839178,
    CnID = "怪物波次@周常挑战7_2_3",
    BaseSortID = 519,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [840061] = {
    ID = 840061,
    CnID = "怪物波次@周常挑战7_3_1",
    BaseSortID = 520,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [840571] = {
    ID = 840571,
    CnID = "怪物波次@周常挑战7_3_2",
    BaseSortID = 521,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [840624] = {
    ID = 840624,
    CnID = "怪物波次@周常挑战7_3_3",
    BaseSortID = 522,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [901084] = {
    ID = 901084,
    CnID = "怪物波次@周常挑战7_3_4",
    BaseSortID = 523,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 9
  },
  [901602] = {
    ID = 901602,
    CnID = "怪物波次@周常挑战7_3_5",
    BaseSortID = 524,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [902365] = {
    ID = 902365,
    CnID = "怪物波次@周常挑战7_3_6",
    BaseSortID = 525,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [841022] = {
    ID = 841022,
    CnID = "怪物波次@周常挑战8_1_1",
    BaseSortID = 526,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [841636] = {
    ID = 841636,
    CnID = "怪物波次@周常挑战8_1_2",
    BaseSortID = 527,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [841704] = {
    ID = 841704,
    CnID = "怪物波次@周常挑战8_1_3",
    BaseSortID = 528,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [902877] = {
    ID = 902877,
    CnID = "怪物波次@周常挑战8_1_4",
    BaseSortID = 529,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 6,
    MonsterPoint3 = 9
  },
  [903063] = {
    ID = 903063,
    CnID = "怪物波次@周常挑战8_1_5",
    BaseSortID = 530,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 6,
    MonsterPoint3 = 9
  },
  [903638] = {
    ID = 903638,
    CnID = "怪物波次@周常挑战8_1_6",
    BaseSortID = 531,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9
  },
  [903703] = {
    ID = 903703,
    CnID = "怪物波次@周常挑战8_1_7",
    BaseSortID = 532,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [841809] = {
    ID = 841809,
    CnID = "怪物波次@周常挑战8_2_1",
    BaseSortID = 533,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [841886] = {
    ID = 841886,
    CnID = "怪物波次@周常挑战8_2_2",
    BaseSortID = 534,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [842096] = {
    ID = 842096,
    CnID = "怪物波次@周常挑战8_2_3",
    BaseSortID = 535,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [842395] = {
    ID = 842395,
    CnID = "怪物波次@周常挑战8_3_1",
    BaseSortID = 536,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [842702] = {
    ID = 842702,
    CnID = "怪物波次@周常挑战8_3_2",
    BaseSortID = 537,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [843599] = {
    ID = 843599,
    CnID = "怪物波次@周常挑战8_3_3",
    BaseSortID = 538,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9
  },
  [904283] = {
    ID = 904283,
    CnID = "怪物波次@周常挑战8_3_4",
    BaseSortID = 539,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [904531] = {
    ID = 904531,
    CnID = "怪物波次@周常挑战8_3_5",
    BaseSortID = 540,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9,
    MonsterPoint3 = 6
  },
  [905491] = {
    ID = 905491,
    CnID = "怪物波次@周常挑战8_3_6",
    BaseSortID = 541,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [843899] = {
    ID = 843899,
    CnID = "怪物波次@周常挑战9_1_1",
    BaseSortID = 542,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [844189] = {
    ID = 844189,
    CnID = "怪物波次@周常挑战9_1_2",
    BaseSortID = 543,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [844246] = {
    ID = 844246,
    CnID = "怪物波次@周常挑战9_1_3",
    BaseSortID = 544,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [845077] = {
    ID = 845077,
    CnID = "怪物波次@周常挑战9_1_4",
    BaseSortID = 545,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [845224] = {
    ID = 845224,
    CnID = "怪物波次@周常挑战9_1_5",
    BaseSortID = 546,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [845418] = {
    ID = 845418,
    CnID = "怪物波次@周常挑战9_1_6",
    BaseSortID = 547,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [905586] = {
    ID = 905586,
    CnID = "怪物波次@周常挑战9_1_7",
    BaseSortID = 548,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [846048] = {
    ID = 846048,
    CnID = "怪物波次@周常挑战9_2_1",
    BaseSortID = 549,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [846505] = {
    ID = 846505,
    CnID = "怪物波次@周常挑战9_2_2",
    BaseSortID = 550,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [847397] = {
    ID = 847397,
    CnID = "怪物波次@周常挑战9_2_3",
    BaseSortID = 551,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [847970] = {
    ID = 847970,
    CnID = "怪物波次@周常挑战9_3_1",
    BaseSortID = 552,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [848013] = {
    ID = 848013,
    CnID = "怪物波次@周常挑战9_3_2",
    BaseSortID = 553,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [848104] = {
    ID = 848104,
    CnID = "怪物波次@周常挑战9_3_3",
    BaseSortID = 554,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [848655] = {
    ID = 848655,
    CnID = "怪物波次@周常挑战9_3_4",
    BaseSortID = 555,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 9
  },
  [849281] = {
    ID = 849281,
    CnID = "怪物波次@周常挑战9_3_5",
    BaseSortID = 556,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [850026] = {
    ID = 850026,
    CnID = "怪物波次@周常挑战9_3_6",
    BaseSortID = 557,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [905659] = {
    ID = 905659,
    CnID = "怪物波次@周常挑战10_1_1",
    BaseSortID = 558,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [906321] = {
    ID = 906321,
    CnID = "怪物波次@周常挑战10_1_2",
    BaseSortID = 559,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [906640] = {
    ID = 906640,
    CnID = "怪物波次@周常挑战10_1_3",
    BaseSortID = 560,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [907360] = {
    ID = 907360,
    CnID = "怪物波次@周常挑战10_1_4",
    BaseSortID = 561,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 6,
    MonsterPoint3 = 9
  },
  [907634] = {
    ID = 907634,
    CnID = "怪物波次@周常挑战10_1_5",
    BaseSortID = 562,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 6,
    MonsterPoint3 = 9
  },
  [907739] = {
    ID = 907739,
    CnID = "怪物波次@周常挑战10_1_6",
    BaseSortID = 563,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9
  },
  [908017] = {
    ID = 908017,
    CnID = "怪物波次@周常挑战10_1_7",
    BaseSortID = 564,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [908062] = {
    ID = 908062,
    CnID = "怪物波次@周常挑战10_2_1",
    BaseSortID = 565,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [908869] = {
    ID = 908869,
    CnID = "怪物波次@周常挑战10_2_2",
    BaseSortID = 566,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [909011] = {
    ID = 909011,
    CnID = "怪物波次@周常挑战10_2_3",
    BaseSortID = 567,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [909939] = {
    ID = 909939,
    CnID = "怪物波次@周常挑战10_3_1",
    BaseSortID = 568,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [910842] = {
    ID = 910842,
    CnID = "怪物波次@周常挑战10_3_2",
    BaseSortID = 569,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [911555] = {
    ID = 911555,
    CnID = "怪物波次@周常挑战10_3_3",
    BaseSortID = 570,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9
  },
  [912356] = {
    ID = 912356,
    CnID = "怪物波次@周常挑战10_3_4",
    BaseSortID = 571,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [913119] = {
    ID = 913119,
    CnID = "怪物波次@周常挑战10_3_5",
    BaseSortID = 572,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9,
    MonsterPoint3 = 6
  },
  [913439] = {
    ID = 913439,
    CnID = "怪物波次@周常挑战10_3_6",
    BaseSortID = 573,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [913508] = {
    ID = 913508,
    CnID = "怪物波次@周常挑战11_1_1",
    BaseSortID = 574,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [914397] = {
    ID = 914397,
    CnID = "怪物波次@周常挑战11_1_2",
    BaseSortID = 575,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [914949] = {
    ID = 914949,
    CnID = "怪物波次@周常挑战11_1_3",
    BaseSortID = 576,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [915517] = {
    ID = 915517,
    CnID = "怪物波次@周常挑战11_1_4",
    BaseSortID = 577,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [915944] = {
    ID = 915944,
    CnID = "怪物波次@周常挑战11_1_5",
    BaseSortID = 578,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [916586] = {
    ID = 916586,
    CnID = "怪物波次@周常挑战11_1_6",
    BaseSortID = 579,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [917387] = {
    ID = 917387,
    CnID = "怪物波次@周常挑战11_1_7",
    BaseSortID = 580,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [917902] = {
    ID = 917902,
    CnID = "怪物波次@周常挑战11_2_1",
    BaseSortID = 581,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [918718] = {
    ID = 918718,
    CnID = "怪物波次@周常挑战11_2_2",
    BaseSortID = 582,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [918837] = {
    ID = 918837,
    CnID = "怪物波次@周常挑战11_2_3",
    BaseSortID = 583,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [919173] = {
    ID = 919173,
    CnID = "怪物波次@周常挑战11_3_1",
    BaseSortID = 584,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [919880] = {
    ID = 919880,
    CnID = "怪物波次@周常挑战11_3_2",
    BaseSortID = 585,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [920846] = {
    ID = 920846,
    CnID = "怪物波次@周常挑战11_3_3",
    BaseSortID = 586,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [921005] = {
    ID = 921005,
    CnID = "怪物波次@周常挑战11_3_4",
    BaseSortID = 587,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 9
  },
  [921279] = {
    ID = 921279,
    CnID = "怪物波次@周常挑战11_3_5",
    BaseSortID = 588,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [921895] = {
    ID = 921895,
    CnID = "怪物波次@周常挑战11_3_6",
    BaseSortID = 589,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [922383] = {
    ID = 922383,
    CnID = "怪物波次@周常挑战12_1_1",
    BaseSortID = 590,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [922893] = {
    ID = 922893,
    CnID = "怪物波次@周常挑战12_1_2",
    BaseSortID = 591,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [923607] = {
    ID = 923607,
    CnID = "怪物波次@周常挑战12_1_3",
    BaseSortID = 592,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [924108] = {
    ID = 924108,
    CnID = "怪物波次@周常挑战12_1_4",
    BaseSortID = 593,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 6,
    MonsterPoint3 = 9
  },
  [924294] = {
    ID = 924294,
    CnID = "怪物波次@周常挑战12_1_5",
    BaseSortID = 594,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 6,
    MonsterPoint3 = 9
  },
  [924650] = {
    ID = 924650,
    CnID = "怪物波次@周常挑战12_1_6",
    BaseSortID = 595,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9
  },
  [925044] = {
    ID = 925044,
    CnID = "怪物波次@周常挑战12_1_7",
    BaseSortID = 596,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [925419] = {
    ID = 925419,
    CnID = "怪物波次@周常挑战12_2_1",
    BaseSortID = 597,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [925559] = {
    ID = 925559,
    CnID = "怪物波次@周常挑战12_2_2",
    BaseSortID = 598,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [925857] = {
    ID = 925857,
    CnID = "怪物波次@周常挑战12_2_3",
    BaseSortID = 599,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [926113] = {
    ID = 926113,
    CnID = "怪物波次@周常挑战12_3_1",
    BaseSortID = 600,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [926966] = {
    ID = 926966,
    CnID = "怪物波次@周常挑战12_3_2",
    BaseSortID = 601,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [927922] = {
    ID = 927922,
    CnID = "怪物波次@周常挑战12_3_3",
    BaseSortID = 602,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9
  },
  [928260] = {
    ID = 928260,
    CnID = "怪物波次@周常挑战12_3_4",
    BaseSortID = 603,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [928386] = {
    ID = 928386,
    CnID = "怪物波次@周常挑战12_3_5",
    BaseSortID = 604,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9,
    MonsterPoint3 = 6
  },
  [928522] = {
    ID = 928522,
    CnID = "怪物波次@周常挑战12_3_6",
    BaseSortID = 605,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [928947] = {
    ID = 928947,
    CnID = "怪物波次@周常挑战13_1_1",
    BaseSortID = 606,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [929709] = {
    ID = 929709,
    CnID = "怪物波次@周常挑战13_1_2",
    BaseSortID = 607,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [930380] = {
    ID = 930380,
    CnID = "怪物波次@周常挑战13_1_3",
    BaseSortID = 608,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [931205] = {
    ID = 931205,
    CnID = "怪物波次@周常挑战13_1_4",
    BaseSortID = 609,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [931678] = {
    ID = 931678,
    CnID = "怪物波次@周常挑战13_1_5",
    BaseSortID = 610,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [932152] = {
    ID = 932152,
    CnID = "怪物波次@周常挑战13_1_6",
    BaseSortID = 611,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [932676] = {
    ID = 932676,
    CnID = "怪物波次@周常挑战13_1_7",
    BaseSortID = 612,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [933623] = {
    ID = 933623,
    CnID = "怪物波次@周常挑战13_2_1",
    BaseSortID = 613,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [933732] = {
    ID = 933732,
    CnID = "怪物波次@周常挑战13_2_2",
    BaseSortID = 614,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [934457] = {
    ID = 934457,
    CnID = "怪物波次@周常挑战13_2_3",
    BaseSortID = 615,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [934556] = {
    ID = 934556,
    CnID = "怪物波次@周常挑战13_3_1",
    BaseSortID = 616,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [934793] = {
    ID = 934793,
    CnID = "怪物波次@周常挑战13_3_2",
    BaseSortID = 617,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [935452] = {
    ID = 935452,
    CnID = "怪物波次@周常挑战13_3_3",
    BaseSortID = 618,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [936293] = {
    ID = 936293,
    CnID = "怪物波次@周常挑战13_3_4",
    BaseSortID = 619,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 9
  },
  [936648] = {
    ID = 936648,
    CnID = "怪物波次@周常挑战13_3_5",
    BaseSortID = 620,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [937070] = {
    ID = 937070,
    CnID = "怪物波次@周常挑战13_3_6",
    BaseSortID = 621,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [937714] = {
    ID = 937714,
    CnID = "怪物波次@周常挑战14_1_1",
    BaseSortID = 622,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [937862] = {
    ID = 937862,
    CnID = "怪物波次@周常挑战14_1_2",
    BaseSortID = 623,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [938796] = {
    ID = 938796,
    CnID = "怪物波次@周常挑战14_1_3",
    BaseSortID = 624,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [939447] = {
    ID = 939447,
    CnID = "怪物波次@周常挑战14_1_4",
    BaseSortID = 625,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 6,
    MonsterPoint3 = 9
  },
  [939692] = {
    ID = 939692,
    CnID = "怪物波次@周常挑战14_1_5",
    BaseSortID = 626,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 6,
    MonsterPoint3 = 9
  },
  [940029] = {
    ID = 940029,
    CnID = "怪物波次@周常挑战14_1_6",
    BaseSortID = 627,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9
  },
  [940724] = {
    ID = 940724,
    CnID = "怪物波次@周常挑战14_1_7",
    BaseSortID = 628,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [941014] = {
    ID = 941014,
    CnID = "怪物波次@周常挑战14_2_1",
    BaseSortID = 629,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [942005] = {
    ID = 942005,
    CnID = "怪物波次@周常挑战14_2_2",
    BaseSortID = 630,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [942300] = {
    ID = 942300,
    CnID = "怪物波次@周常挑战14_2_3",
    BaseSortID = 631,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [943275] = {
    ID = 943275,
    CnID = "怪物波次@周常挑战14_3_1",
    BaseSortID = 632,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [943467] = {
    ID = 943467,
    CnID = "怪物波次@周常挑战14_3_2",
    BaseSortID = 633,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [944103] = {
    ID = 944103,
    CnID = "怪物波次@周常挑战14_3_3",
    BaseSortID = 634,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9
  },
  [944941] = {
    ID = 944941,
    CnID = "怪物波次@周常挑战14_3_4",
    BaseSortID = 635,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [945450] = {
    ID = 945450,
    CnID = "怪物波次@周常挑战14_3_5",
    BaseSortID = 636,
    Monster1 = 4795827,
    MonsterPoint1 = 2,
    MonsterPoint2 = 9,
    MonsterPoint3 = 6
  },
  [945895] = {
    ID = 945895,
    CnID = "怪物波次@周常挑战14_3_6",
    BaseSortID = 637,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [946184] = {
    ID = 946184,
    CnID = "怪物波次@周常挑战15_1_1",
    BaseSortID = 638,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [946189] = {
    ID = 946189,
    CnID = "怪物波次@周常挑战15_1_2",
    BaseSortID = 639,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [947080] = {
    ID = 947080,
    CnID = "怪物波次@周常挑战15_1_3",
    BaseSortID = 640,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [947997] = {
    ID = 947997,
    CnID = "怪物波次@周常挑战15_1_4",
    BaseSortID = 641,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [948675] = {
    ID = 948675,
    CnID = "怪物波次@周常挑战15_1_5",
    BaseSortID = 642,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [949158] = {
    ID = 949158,
    CnID = "怪物波次@周常挑战15_1_6",
    BaseSortID = 643,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [950130] = {
    ID = 950130,
    CnID = "怪物波次@周常挑战15_1_7",
    BaseSortID = 644,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [950325] = {
    ID = 950325,
    CnID = "怪物波次@周常挑战15_2_1",
    BaseSortID = 645,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [950415] = {
    ID = 950415,
    CnID = "怪物波次@周常挑战15_2_2",
    BaseSortID = 646,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [951070] = {
    ID = 951070,
    CnID = "怪物波次@周常挑战15_2_3",
    BaseSortID = 647,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [951489] = {
    ID = 951489,
    CnID = "怪物波次@周常挑战15_3_1",
    BaseSortID = 648,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [951917] = {
    ID = 951917,
    CnID = "怪物波次@周常挑战15_3_2",
    BaseSortID = 649,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [952735] = {
    ID = 952735,
    CnID = "怪物波次@周常挑战15_3_3",
    BaseSortID = 650,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [953328] = {
    ID = 953328,
    CnID = "怪物波次@周常挑战15_3_4",
    BaseSortID = 651,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 9
  },
  [953430] = {
    ID = 953430,
    CnID = "怪物波次@周常挑战15_3_5",
    BaseSortID = 652,
    Monster1 = 4795827,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [953759] = {
    ID = 953759,
    CnID = "怪物波次@周常挑战15_3_6",
    BaseSortID = 653,
    Monster1 = 4795827,
    MonsterPoint1 = 1
  },
  [958135] = {
    ID = 958135,
    CnID = "怪物波次@主线1_1_1测试",
    BaseSortID = 654,
    School = 1,
    Monster1 = 4248236,
    Monster2 = 4249121,
    Monster3 = 4249842,
    MonsterPoint1 = 1,
    MonsterPoint2 = 6,
    MonsterPoint3 = 10
  },
  [959055] = {
    ID = 959055,
    CnID = "怪物波次@主线1_1_2测试",
    BaseSortID = 655,
    School = 1,
    Monster1 = 4249121,
    Monster2 = 4249121,
    Monster3 = 4248236,
    Monster4 = 4248236,
    MonsterPoint1 = 1,
    MonsterPoint2 = 3,
    MonsterPoint3 = 7,
    MonsterPoint4 = 11
  },
  [959388] = {
    ID = 959388,
    CnID = "怪物波次@主线1_1_3测试",
    BaseSortID = 656,
    School = 1,
    Monster1 = 4795827,
    MonsterPoint1 = 5
  }
})
return WaveConfig
