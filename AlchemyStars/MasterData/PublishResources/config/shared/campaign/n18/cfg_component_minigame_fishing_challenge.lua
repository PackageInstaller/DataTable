local key = {
  ID = 1,
  ComponentID = 2,
  RelateQuestID = 3,
  FishingPostionID = 4,
  StageList = 5,
  StageRewardList = 6
}
local config = {
  {
    1,
    105610505,
    4000001,
    8,
    {
      10,
      20,
      30,
      40,
      50
    },
    {
      {3000003, 10},
      {3000003, 20},
      {3000003, 30},
      {3000003, 40},
      {3000003, 50}
    }
  }
}
return config, "ID", key
