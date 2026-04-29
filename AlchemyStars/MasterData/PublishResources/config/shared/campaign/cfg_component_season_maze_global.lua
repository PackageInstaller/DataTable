local key = {
  ComponentID = 1,
  RerollPetRoom = 2,
  RelicSkip = 3,
  RelicRandomNum = 4,
  CurePercent = 5,
  RandomHard = 6,
  PetNum = 7,
  BeadMaxCnt = 8,
  BossMS = 9,
  NormalFailMS = 10,
  BeadGaleCnt = 11,
  BeadFriendCnt = 12,
  ConvertScoreItem = 13,
  GoldMaxLimit = 14,
  WorldBossMSRange = 15,
  WorldBossRound = 16,
  WorldBossMissionID = 17,
  ManualBanNum = 18,
  SlotParam = 19,
  PetParam = 20,
  RelicParam = 21,
  ReviveCount = 22,
  CureCount = 23,
  HandDeletCount = 24,
  HandResetCount = 25,
  BeadIDs = 26
}
local common = {
  {
    1,
    1,
    10
  }
}
local config = {
  [900308001] = {
    900308001,
    common[1],
    20,
    3,
    30,
    3,
    4,
    8,
    5,
    1,
    4,
    2,
    3201005,
    255,
    {
      {0, 4},
      {5, 9},
      {10, 19},
      {20, 99}
    },
    {
      7,
      8,
      9,
      10
    },
    20003,
    -1,
    common[1],
    common[1],
    {
      0,
      5,
      0
    },
    {
      30,
      40,
      50,
      60,
      75
    },
    {
      15,
      20,
      25,
      30,
      40
    },
    {
      0,
      20,
      40,
      60,
      80
    },
    {
      0,
      10,
      20,
      30,
      40,
      50
    },
    {
      10011,
      10012,
      10013,
      10014,
      10021,
      10022
    }
  }
}
return config, "ComponentID", key
