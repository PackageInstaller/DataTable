local System = require("System.System")
local readonly = System.readonly
local Turntable = readonly({
  [89900] = {
    ID = 89900,
    CnID = "转盘@时装抽取",
    BaseSortID = 1,
    Cost = {
      84249,
      0,
      1,
      1,
      2,
      4,
      4,
      6,
      6,
      6,
      6
    },
    CostChange = {9536, 200},
    DropIds = {89901},
    ItemRare1 = {1},
    ItemRare2 = {
      2,
      3,
      4
    },
    ItemRare3 = {
      5,
      6,
      7,
      8,
      9
    }
  },
  [97996] = {
    ID = 97996,
    CnID = "转盘@墨菲万圣节时装抽取",
    BaseSortID = 2,
    Cost = {
      97992,
      0,
      1,
      2,
      2,
      3,
      5,
      5,
      5,
      5,
      5
    },
    CostChange = {9536, 60},
    DropIds = {97990},
    ItemRare1 = {1},
    ItemRare2 = {
      2,
      3,
      4
    },
    ItemRare3 = {
      5,
      6,
      7,
      8,
      9,
      10
    }
  }
})
return Turntable
