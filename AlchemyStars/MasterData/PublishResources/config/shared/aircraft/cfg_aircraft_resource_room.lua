local key = {
  ID = 1,
  ResCardLimit = 2,
  ResCardCD = 3,
  CoinDungeonLevel = 4,
  ExpDungeonLevel = 5,
  AirDungeonLevel = 6,
  EquipDungeonLevel = 7
}
local config = {
  [7104001] = {
    7104001,
    300,
    900,
    1,
    1,
    1,
    1
  },
  [7104002] = {
    7104002,
    300,
    900,
    2,
    2,
    2,
    2
  },
  [7104003] = {
    7104003,
    300,
    900,
    3,
    3,
    3,
    3
  },
  [7104004] = {
    7104004,
    300,
    900,
    4,
    4,
    4,
    4
  },
  [7104005] = {
    7104005,
    300,
    900,
    5,
    5,
    5,
    5
  }
}
return config, "ID", key
