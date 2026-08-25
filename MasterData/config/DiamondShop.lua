local System = require("System.System")
local readonly = System.readonly
local DiamondShop = readonly({
  [100001] = {
    GoodsID = 100001,
    SortID = 1,
    ItemID = 1,
    Num = 120,
    Price = 6,
    BuyLimit = 1
  },
  [100002] = {
    GoodsID = 100002,
    SortID = 2,
    ItemID = 1,
    Num = 600,
    Price = 30,
    BuyLimit = 1
  },
  [100003] = {
    GoodsID = 100003,
    SortID = 3,
    ItemID = 1,
    Num = 1960,
    Price = 98,
    BuyLimit = 1
  },
  [100004] = {
    GoodsID = 100004,
    SortID = 4,
    ItemID = 1,
    Num = 6560,
    Price = 328,
    BuyLimit = 1
  },
  [100005] = {
    GoodsID = 100005,
    SortID = 5,
    ItemID = 1,
    Num = 12960,
    Price = 648,
    BuyLimit = 1
  }
})
return DiamondShop
