local key = {
  ID = 1,
  OrderFormInterval = 2,
  TimeScore = 3,
  Bonus = 4,
  BonusDelta = 5,
  IceSoulPoint = 6,
  IceSoulTime = 7,
  WaitingMood = 8,
  ClickInterval = 9,
  GuideOrderform = 10
}
local config = {
  {
    1,
    2,
    {
      {
        0,
        20,
        1
      },
      {
        20,
        50,
        1.2
      },
      {
        50,
        100,
        1.5
      }
    },
    1,
    0.02,
    12,
    8,
    {
      {
        0,
        50,
        1
      },
      {
        50,
        80,
        2
      },
      {
        80,
        100,
        3
      }
    },
    0.1,
    9999
  }
}
return config, "ID", key
