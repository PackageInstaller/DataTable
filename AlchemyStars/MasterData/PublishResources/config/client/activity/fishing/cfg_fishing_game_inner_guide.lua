local key = {
  ID = 1,
  FishInfo = 2,
  OrderFishInfo = 3,
  TotalFish = 4,
  SkillSpine = 5,
  SupplyInterval = 6,
  RoleSpine = 7,
  RoleNormalAnimName = 8,
  SuccessAnim = 9,
  FailAnim = 10,
  OrderFailAnim = 11,
  OctopusAnim = 12,
  SuccessToNormalTime = 13,
  FailToNormalTime = 14,
  OrderFailToNormalTime = 15,
  SkillImage = 16
}
local config = {
  {
    1,
    {
      {
        5,
        1,
        1
      }
    },
    {
      {1, 99999999}
    },
    1,
    nil,
    2,
    "n14_g_3_spine_idle",
    "yao_norm",
    "yao_happy",
    "yao_helpless",
    "yao_pain",
    "yao_mozhi",
    2000,
    2000,
    2000,
    "n14_fish_niang"
  }
}
return config, "ID", key
