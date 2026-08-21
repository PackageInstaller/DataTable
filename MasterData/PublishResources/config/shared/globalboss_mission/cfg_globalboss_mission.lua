local key = {
  ID = 1,
  CampaignId = 2,
  LevelID = 3,
  BeginTime = 4,
  EndTime = 5,
  MissionName = 6,
  BaseWordBuff = 7
}
local config = {
  [10001] = {
    10001,
    11,
    5259001,
    "2023-04-04 04:00:00",
    "2023-08-04 04:00:00",
    "str_n25_battlefield_mission_name1",
    {5250010, 40804}
  }
}
return config, "ID", key
