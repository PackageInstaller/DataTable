local System = require("System.System")
local readonly = System.readonly
local LevelSuppression = readonly({
  [1] = {
    LevelDifference = 1,
    BattleSuppressType1 = 10,
    BattleSuppressType2 = 20,
    BattleSuppressType3 = 10
  },
  [2] = {
    LevelDifference = 2,
    BattleSuppressType1 = 10,
    BattleSuppressType2 = 21,
    BattleSuppressType3 = 10
  },
  [3] = {
    LevelDifference = 3,
    BattleSuppressType1 = 25,
    BattleSuppressType2 = 22,
    BattleSuppressType3 = 10
  },
  [4] = {
    LevelDifference = 4,
    BattleSuppressType1 = 25,
    BattleSuppressType2 = 23,
    BattleSuppressType3 = 10
  },
  [5] = {
    LevelDifference = 5,
    BattleSuppressType1 = 25,
    BattleSuppressType2 = 24,
    BattleSuppressType3 = 10
  },
  [6] = {
    LevelDifference = 6,
    BattleSuppressType1 = 30,
    BattleSuppressType2 = 25,
    BattleSuppressType3 = 25
  },
  [7] = {
    LevelDifference = 7,
    BattleSuppressType1 = 35,
    BattleSuppressType2 = 26,
    BattleSuppressType3 = 25
  },
  [8] = {
    LevelDifference = 8,
    BattleSuppressType1 = 40,
    BattleSuppressType2 = 27,
    BattleSuppressType3 = 25
  },
  [9] = {
    LevelDifference = 9,
    BattleSuppressType1 = 45,
    BattleSuppressType2 = 28,
    BattleSuppressType3 = 25
  },
  [10] = {
    LevelDifference = 10,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 29,
    BattleSuppressType3 = 25
  },
  [11] = {
    LevelDifference = 11,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 30,
    BattleSuppressType3 = 50
  },
  [12] = {
    LevelDifference = 12,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 31,
    BattleSuppressType3 = 50
  },
  [13] = {
    LevelDifference = 13,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 32,
    BattleSuppressType3 = 50
  },
  [14] = {
    LevelDifference = 14,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 33,
    BattleSuppressType3 = 50
  },
  [15] = {
    LevelDifference = 15,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 34,
    BattleSuppressType3 = 50
  },
  [16] = {
    LevelDifference = 16,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 35,
    BattleSuppressType3 = 50
  },
  [17] = {
    LevelDifference = 17,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 36,
    BattleSuppressType3 = 50
  },
  [18] = {
    LevelDifference = 18,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 37,
    BattleSuppressType3 = 50
  },
  [19] = {
    LevelDifference = 19,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 38,
    BattleSuppressType3 = 50
  },
  [20] = {
    LevelDifference = 20,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 39,
    BattleSuppressType3 = 50
  },
  [21] = {
    LevelDifference = 21,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 40,
    BattleSuppressType3 = 50
  },
  [22] = {
    LevelDifference = 22,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 41,
    BattleSuppressType3 = 50
  },
  [23] = {
    LevelDifference = 23,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 42,
    BattleSuppressType3 = 50
  },
  [24] = {
    LevelDifference = 24,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 43,
    BattleSuppressType3 = 50
  },
  [25] = {
    LevelDifference = 25,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 44,
    BattleSuppressType3 = 50
  },
  [26] = {
    LevelDifference = 26,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 45,
    BattleSuppressType3 = 50
  },
  [27] = {
    LevelDifference = 27,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 46,
    BattleSuppressType3 = 50
  },
  [28] = {
    LevelDifference = 28,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 47,
    BattleSuppressType3 = 50
  },
  [29] = {
    LevelDifference = 29,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 48,
    BattleSuppressType3 = 50
  },
  [30] = {
    LevelDifference = 30,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 49,
    BattleSuppressType3 = 50
  },
  [31] = {
    LevelDifference = 31,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 50,
    BattleSuppressType3 = 50
  },
  [32] = {
    LevelDifference = 32,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 51,
    BattleSuppressType3 = 50
  },
  [33] = {
    LevelDifference = 33,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 52,
    BattleSuppressType3 = 50
  },
  [34] = {
    LevelDifference = 34,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 53,
    BattleSuppressType3 = 50
  },
  [35] = {
    LevelDifference = 35,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 54,
    BattleSuppressType3 = 50
  },
  [36] = {
    LevelDifference = 36,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 55,
    BattleSuppressType3 = 50
  },
  [37] = {
    LevelDifference = 37,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 56,
    BattleSuppressType3 = 50
  },
  [38] = {
    LevelDifference = 38,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 57,
    BattleSuppressType3 = 50
  },
  [39] = {
    LevelDifference = 39,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 58,
    BattleSuppressType3 = 50
  },
  [40] = {
    LevelDifference = 40,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 59,
    BattleSuppressType3 = 50
  },
  [41] = {
    LevelDifference = 41,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 60,
    BattleSuppressType3 = 50
  },
  [42] = {
    LevelDifference = 42,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 61,
    BattleSuppressType3 = 50
  },
  [43] = {
    LevelDifference = 43,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 62,
    BattleSuppressType3 = 50
  },
  [44] = {
    LevelDifference = 44,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 63,
    BattleSuppressType3 = 50
  },
  [45] = {
    LevelDifference = 45,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 64,
    BattleSuppressType3 = 50
  },
  [46] = {
    LevelDifference = 46,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 65,
    BattleSuppressType3 = 50
  },
  [47] = {
    LevelDifference = 47,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 66,
    BattleSuppressType3 = 50
  },
  [48] = {
    LevelDifference = 48,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 67,
    BattleSuppressType3 = 50
  },
  [49] = {
    LevelDifference = 49,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 68,
    BattleSuppressType3 = 50
  },
  [50] = {
    LevelDifference = 50,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 69,
    BattleSuppressType3 = 50
  },
  [51] = {
    LevelDifference = 51,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 70,
    BattleSuppressType3 = 50
  },
  [52] = {
    LevelDifference = 52,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 71,
    BattleSuppressType3 = 50
  },
  [53] = {
    LevelDifference = 53,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 72,
    BattleSuppressType3 = 50
  },
  [54] = {
    LevelDifference = 54,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 73,
    BattleSuppressType3 = 50
  },
  [55] = {
    LevelDifference = 55,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 74,
    BattleSuppressType3 = 50
  },
  [56] = {
    LevelDifference = 56,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 75,
    BattleSuppressType3 = 50
  },
  [57] = {
    LevelDifference = 57,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 76,
    BattleSuppressType3 = 50
  },
  [58] = {
    LevelDifference = 58,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 77,
    BattleSuppressType3 = 50
  },
  [59] = {
    LevelDifference = 59,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 78,
    BattleSuppressType3 = 50
  },
  [60] = {
    LevelDifference = 60,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 79,
    BattleSuppressType3 = 50
  },
  [61] = {
    LevelDifference = 61,
    BattleSuppressType1 = 50,
    BattleSuppressType2 = 79,
    BattleSuppressType3 = 50
  }
})
return LevelSuppression
