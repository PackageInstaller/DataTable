local key = {
  ID = 1,
  Species = 2,
  Rarity = 3,
  MutationTime = 4,
  DirectionalTime = 5,
  DyeTime = 6,
  AdvancedParam = 7,
  MainSeedPro = 8,
  Phases = 9,
  AdvancedPro = 10,
  SeedNumPro = 11,
  ExtraDrop = 12,
  LimiteDrop = 13
}
local common = {
  {
    30,
    100,
    100
  }
}
local config = {
  {
    1,
    1,
    1,
    32400,
    32400,
    9000,
    {
      4,
      4,
      10
    },
    85,
    common[1],
    {
      {1, 50},
      {2, 50},
      {3, 0},
      {4, 0}
    },
    {
      {0, 0},
      {1, 70},
      {2, 30}
    },
    100000,
    220000
  },
  {
    2,
    1,
    2,
    43200,
    43200,
    9000,
    {
      4,
      3,
      15
    },
    85,
    common[1],
    {
      {2, 60},
      {3, 40},
      {4, 0}
    },
    {
      {0, 0},
      {1, 80},
      {2, 20}
    },
    100000,
    220001
  },
  {
    3,
    1,
    3,
    54000,
    54000,
    9000,
    {
      4,
      3,
      20
    },
    85,
    common[1],
    {
      {3, 75},
      {4, 25}
    },
    {
      {0, 0},
      {1, 90},
      {2, 10}
    },
    100000,
    220002
  },
  {
    4,
    1,
    4,
    108000,
    108000,
    9000,
    {
      4,
      5,
      10
    },
    85,
    common[1],
    nil,
    {
      {0, 10}
    },
    100000,
    220003
  }
}
return config, "ID", key
