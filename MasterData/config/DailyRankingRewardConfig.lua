local System = require("System.System")
local readonly = System.readonly
local DailyRankingRewardConfig = readonly({
  [1] = {
    ID = 1,
    UpperLimit = 1,
    LowerLimit = 10,
    ItemID = 9567,
    ItemNum = 100
  },
  [2] = {
    ID = 2,
    UpperLimit = 11,
    LowerLimit = 100,
    ItemID = 9567,
    ItemNum = 50
  },
  [3] = {
    ID = 3,
    UpperLimit = 101,
    LowerLimit = 1000,
    ItemID = 9567,
    ItemNum = 40
  },
  [4] = {
    ID = 4,
    UpperLimit = 1001,
    LowerLimit = 5000,
    ItemID = 9567,
    ItemNum = 30
  },
  [5] = {
    ID = 5,
    UpperLimit = 5001,
    LowerLimit = 10000,
    ItemID = 9567,
    ItemNum = 20
  }
})
return DailyRankingRewardConfig
