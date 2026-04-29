local key = {
  CampaignID = 1,
  Atlas = 2,
  MainTitle = 3,
  PlayIntro = 4,
  PlayIntroBG = 5,
  MainBG = 6,
  Pet = 7,
  PetTransform = 8,
  RightBG = 9,
  TaskBg = 10,
  TaskComplete = 11,
  GetBtn = 12,
  DoingBtn = 13,
  GotBtn = 14,
  AwardBG = 15,
  AwardCountBG = 16,
  DailyBG = 17,
  NotDailyBG = 18
}
local common = {
  "str_sakura_specialtask_talk",
  "S2_zbhd_di04",
  "S3_zbhd_di04",
  {
    520,
    0,
    1
  }
}
local config = {
  [5019] = {
    5019,
    "S2SpecialTask",
    "S2_zbhd_title01",
    common[1],
    "S2_zbhd_di02",
    "S2_zbhd_bg01",
    "S2_zbhd_lh01",
    common[4],
    "S2_zbhd_di01",
    "S2_zbhd_di03",
    "S2_zbhd_mask01",
    common[2],
    "S2_zbhd_di05",
    common[2],
    "S2_zbhd_di06",
    "S2_zbhd_di07",
    "S2_zbhd_di08",
    "S2_zbhd_di09"
  },
  [5031] = {
    5031,
    "S3SpecialTask",
    "S3_zbhd_title01",
    common[1],
    "S3_zbhd_di02",
    "S3_zbhd_bg01",
    "S3_zbhd_lh01",
    common[4],
    "S3_zbhd_di01",
    "S3_zbhd_di03",
    "S3_zbhd_mask01",
    common[3],
    "S3_zbhd_di05",
    common[3],
    "S3_zbhd_di06",
    "S3_zbhd_di07",
    "S3_zbhd_di08",
    "S3_zbhd_di09"
  }
}
return config, "CampaignID", key
