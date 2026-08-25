__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local EnergyPrice = readonly({
  [1] = {
    Buy_Time = 1,
    Buy_Price = 50,
    Spend_Id = 1
  },
  [2] = {
    Buy_Time = 2,
    Buy_Price = 100,
    Spend_Id = 1
  },
  [3] = {
    Buy_Time = 3,
    Buy_Price = 100,
    Spend_Id = 1
  },
  [4] = {
    Buy_Time = 4,
    Buy_Price = 150,
    Spend_Id = 1
  },
  [5] = {
    Buy_Time = 5,
    Buy_Price = 200,
    Spend_Id = 1
  },
  [6] = {
    Buy_Time = 6,
    Buy_Price = 200,
    Spend_Id = 1
  }
})
return EnergyPrice
