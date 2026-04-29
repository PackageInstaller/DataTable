local key = {
  ProductID = 1,
  Name = 2,
  TimeUnit = 3,
  Length = 4,
  Price = 5,
  ServiceCode = 6,
  RenewRemind = 7,
  RewardList = 8
}
local common = {
  "测试月卡1",
  "day",
  "testcard1",
  "测试月卡2",
  {
    {3000002, 9000},
    {3210101, 90}
  }
}
local config = {
  ["com.tencent.baiye.testcard1.7"] = {
    "com.tencent.baiye.testcard1.7",
    common[1],
    common[2],
    7,
    100,
    common[3],
    1,
    {
      {3000002, 6000},
      {3210101, 60}
    }
  },
  ["com.tencent.baiye.testcard1.30"] = {
    "com.tencent.baiye.testcard1.30",
    common[4],
    common[2],
    30,
    200,
    common[3],
    1,
    {
      {3000002, 7000},
      {3210101, 70}
    }
  },
  ["com.tencent.baiye.testcard2.30"] = {
    "com.tencent.baiye.testcard2.30",
    "测试月卡3",
    common[2],
    30,
    100,
    "testcard2",
    1,
    {
      {3000002, 8000},
      {3210101, 80}
    }
  },
  ["com.tencent.baiyeint.testcard1.7"] = {
    "com.tencent.baiyeint.testcard1.7",
    common[1],
    common[2],
    7,
    100,
    common[3],
    1,
    common[5]
  },
  ["com.tencent.baiyeint.testcard1.15"] = {
    "com.tencent.baiyeint.testcard1.15",
    "测试月卡一15D",
    common[2],
    15,
    150,
    common[3],
    1,
    common[5]
  },
  ["com.tencent.baiyeint.testcard1.30"] = {
    "com.tencent.baiyeint.testcard1.30",
    common[4],
    common[2],
    30,
    200,
    common[3],
    1,
    {
      {3210201, 90},
      {3210301, 90}
    }
  }
}
return config, "ProductID", key
