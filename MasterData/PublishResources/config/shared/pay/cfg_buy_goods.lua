local key = {
  ID = 1,
  Name = 2,
  Des = 3,
  Type = 4,
  Price = 5,
  ItemList = 6
}
local common = {
  "str_pay_recharge_name_60",
  "str_pay_recharge_desc_60",
  "str_pay_recharge_name_600",
  "str_pay_recharge_desc_600",
  "str_pay_direct_purchase_name_1",
  "str_pay_direct_purchase_desc_1",
  "str_pay_direct_purchase_name_2",
  "str_pay_direct_purchase_desc_2"
}
local config = {
  ["com.tencent.baiye60"] = {
    "com.tencent.baiye60",
    common[1],
    common[2],
    1,
    6,
    {
      {3000002, 8000}
    }
  },
  ["com.tencent.baiye600"] = {
    "com.tencent.baiye600",
    common[3],
    common[4],
    1,
    60,
    {
      {3000002, 9000}
    }
  },
  ["com.tencent.baiyeint.testdust60"] = {
    "com.tencent.baiyeint.testdust60",
    common[1],
    common[2],
    1,
    6,
    {
      {3210101, 60}
    }
  },
  ["com.tencent.baiyeint.testdust600"] = {
    "com.tencent.baiyeint.testdust600",
    common[3],
    common[4],
    1,
    60,
    {
      {3000002, 7000}
    }
  },
  ["com.tencent.baiyeint.testdust1000"] = {
    "com.tencent.baiyeint.testdust1000",
    "str_pay_recharge_name_1000",
    "str_pay_recharge_desc_1000",
    1,
    100,
    {
      {3210101, 80}
    }
  },
  ["com.tencent.baiye.item1"] = {
    "com.tencent.baiye.item1",
    common[5],
    common[6],
    2,
    60,
    {
      {3000002, 6000}
    }
  },
  ["com.tencent.baiye.item2"] = {
    "com.tencent.baiye.item2",
    common[7],
    common[8],
    2,
    160,
    {
      {3210101, 70}
    }
  },
  ["com.tencent.baiyeint.testitem1"] = {
    "com.tencent.baiyeint.testitem1",
    common[5],
    common[6],
    2,
    60,
    {
      {3000002, 9000},
      {3210101, 90}
    }
  },
  ["com.tencent.baiyeint.testitem2"] = {
    "com.tencent.baiyeint.testitem2",
    common[7],
    common[8],
    2,
    160,
    {
      {3210201, 90},
      {3210301, 90}
    }
  },
  ["com.tencent.baiyeint.testitem3"] = {
    "com.tencent.baiyeint.testitem3",
    "str_pay_direct_purchase_name_3",
    "str_pay_direct_purchase_desc_3",
    2,
    200,
    {
      {3210101, 90}
    }
  }
}
return config, "ID", key
