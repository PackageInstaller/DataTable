local key = {
  ID = 1,
  IsActive = 2,
  Type = 3,
  ClassName = 4,
  Bg = 5,
  Head = 6,
  Left = 7,
  Icon = 8,
  Title = 9,
  CampaignType = 10,
  ComponentID = 11,
  BeginTime = 12,
  EndTime = 13
}
local common = {
  "homeland_mainbtns_campaign_bg_default",
  "N17_hdrk_di05",
  "homeland_mainbtns_campaign_left_default",
  "N17_hdrk_icon02",
  "str_n17_minigame_title"
}
local config = {
  {
    1,
    true,
    2,
    "UIN17HomelandEntryDailyPlan",
    common[1],
    common[2],
    common[3],
    "N17_hdrk_icon01",
    "str_n17_daily_plan_tab_btn_home",
    10023,
    1
  },
  {
    2,
    true,
    2,
    "UIN17HomelandEntryMiniGame",
    common[1],
    common[2],
    common[3],
    common[4],
    common[5],
    10023,
    5
  },
  {
    3,
    true,
    2,
    "UIN18HomelandEntryMiniGame",
    common[1],
    common[2],
    common[3],
    common[4],
    common[5],
    10024,
    8
  },
  {
    4,
    true,
    2,
    "UIN19HomelandCampainEnterMiniGame",
    common[1],
    "N19_hdrk_di01",
    common[3],
    "n19_chuanshanjia_icon02",
    "str_homeland_storytask_grouptitle_1",
    10025,
    3
  },
  {
    5,
    true,
    2,
    "UIN21HomelandEntryQuest",
    common[1],
    "N19_yyqy_di01",
    common[3],
    "n19_yyqy_icon01",
    "str_homeland_storytask_grouptitle_2",
    10029,
    5
  },
  {
    6,
    true,
    2,
    "UIN21HomelandEntryMiniGame",
    common[1],
    common[2],
    common[3],
    common[4],
    common[5],
    10029,
    4
  },
  {
    7,
    true,
    2,
    "UIN23HomelandEntryQuest",
    common[1],
    "qy_dyqy_di01",
    common[3],
    "qy_dyqy_icon01",
    "str_homeland_storytask_grouptitle_3",
    10031,
    6
  },
  {
    8,
    true,
    2,
    "UIN23HomelandEnterMiniGame",
    common[1],
    "dy_hdrk_di01",
    common[3],
    "dy_hdrk_icon01",
    "str_movie_homeland_enter",
    10031,
    6
  },
  {
    9,
    true,
    2,
    "UIHomelandEntryStoryTaskSimple",
    common[1],
    "N24_dyds_di03",
    common[3],
    "N24_dyds_icon02",
    "str_homeland_dyds",
    10032,
    5
  },
  {
    10,
    true,
    2,
    "UIN26HomelandEntryMiniGame",
    common[1],
    "dy_hdrk_di02",
    common[3],
    "dy_hdrk_icon01_second",
    "str_movie_homeland_enter_2",
    10036
  }
}
return config, "ID", key
