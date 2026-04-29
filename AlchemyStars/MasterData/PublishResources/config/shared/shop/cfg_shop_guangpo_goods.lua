local key = {
  ID = 1,
  SequenceId = 2,
  ItemId = 3,
  BeginTime = 4,
  EndTime = 5,
  ItemCount = 6,
  SaleType = 7,
  RawPrice = 8,
  NewPrice = 9,
  Discount = 10,
  SaleNum = 11,
  SaleTag = 12
}
local common = {
  "2021-05-01 00:00:00",
  "2100-12-31 24:00:00"
}
local config = {
  [700001] = {
    700001,
    1,
    3000101,
    common[1],
    common[2],
    1,
    3000003,
    300,
    300,
    0,
    888888888,
    0
  },
  [700002] = {
    700002,
    2,
    3000100,
    common[1],
    common[2],
    1,
    3000003,
    300,
    300,
    0,
    888888888,
    0
  }
}
return config, "ID", key
