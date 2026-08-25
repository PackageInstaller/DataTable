local System = require("System.System")
local readonly = System.readonly
local HistoryRankingRewardConfig = readonly({
  [1] = {
    ID = 1,
    UpperLimit = 1,
    LowerLimit = 10,
    ItemID = 9567,
    ItemNum = 50
  },
  [2] = {
    ID = 2,
    UpperLimit = 11,
    LowerLimit = 30,
    ItemID = 9567,
    ItemNum = 20
  },
  [3] = {
    ID = 3,
    UpperLimit = 31,
    LowerLimit = 50,
    ItemID = 9567,
    ItemNum = 10
  },
  [4] = {
    ID = 4,
    UpperLimit = 51,
    LowerLimit = 100,
    ItemID = 9567,
    ItemNum = 4
  },
  [5] = {
    ID = 5,
    UpperLimit = 101,
    LowerLimit = 1000,
    ItemID = 9567,
    ItemNum = 2
  },
  [6] = {
    ID = 6,
    UpperLimit = 1001,
    LowerLimit = 10000,
    ItemID = 9567,
    ItemNum = 1
  }
})
return HistoryRankingRewardConfig
