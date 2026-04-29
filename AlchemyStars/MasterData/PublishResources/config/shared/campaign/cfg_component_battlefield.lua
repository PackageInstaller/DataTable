local key = {
  ID = 1,
  CampaignMissionID = 2,
  ComponentID = 3,
  MilitaryExploitItemID = 4,
  DailyChallengeLimit = 5,
  Index = 6,
  MissionIcon = 7,
  MissionName = 8,
  MissionBKImg = 9,
  MissionDec = 10
}
local common = {
  "mission_2900271_Hccard",
  "mission_2900272_Hccard",
  "mission_2900273_Hccard",
  "mission_2900274_Hccard"
}
local config = {
  {
    1,
    5053001,
    100601501,
    3000217,
    0,
    1,
    common[1],
    "str_n5_battlefield_mission_name1",
    common[1],
    "str_n5_battlefield_mission_desc1"
  },
  {
    2,
    5053002,
    100601501,
    3000217,
    0,
    2,
    common[2],
    "str_n5_battlefield_mission_name2",
    common[2],
    "str_n5_battlefield_mission_desc2"
  },
  {
    3,
    5053003,
    100601501,
    3000217,
    0,
    3,
    common[3],
    "str_n5_battlefield_mission_name3",
    common[3],
    "str_n5_battlefield_mission_desc3"
  },
  {
    4,
    5053004,
    100601501,
    3000217,
    0,
    4,
    common[4],
    "str_n5_battlefield_mission_name4",
    common[4],
    "str_n5_battlefield_mission_desc4"
  }
}
return config, "ID", key
