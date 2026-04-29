local key = {
  ID = 1,
  StartTime = 2,
  EndTime = 3,
  TimeTransform = 4,
  QuestTitleStr = 5,
  MainSideIcon = 6,
  MainSideStr = 7,
  InfoCg = 8,
  InfoTitle = 9,
  InfoContent = 10,
  InfoPicTitle = 11,
  CgOffset = 12
}
local common = {
  "str_cn15_n44_lesson_1",
  "N44_rkbj_ent",
  "N44_rkbj_di01",
  "str_cn15_n44_lesson_2",
  "str_n11_rose_2",
  "str_n22_pumpkin_2"
}
local config = {
  {
    1,
    "2024-07-04 05:00:00",
    "2024-07-11 05:00:00",
    1,
    common[1],
    common[2],
    common[1],
    common[3],
    common[1],
    common[4]
  },
  {
    2,
    "2024-05-01 05:00:00",
    "2024-05-08 05:00:00",
    1,
    common[1],
    common[2],
    common[1],
    common[3],
    common[1],
    common[4]
  },
  {
    3,
    "2022-02-11 05:00:00",
    "2022-02-17 05:00:00",
    1,
    common[5],
    "qrj_zjm_ent",
    common[5],
    "qrj_zjm_icon3",
    common[5],
    "str_n11_rose_4",
    nil,
    {-486, 28}
  },
  {
    4,
    "2023-10-13 05:00:00",
    "2023-10-20 05:00:00",
    1,
    common[6],
    "wnsf_zjm_ent",
    common[6],
    "wnsf_zjm_di3",
    common[6],
    "str_n22_pumpkin_4",
    nil,
    {-466, -82}
  },
  {
    5,
    "2022-12-22 05:00:00",
    "2022-12-28 05:00:00",
    1,
    common[6],
    "N25_sdzjm_ent",
    "str_n25_christmas_1",
    "N25_sdjl_character",
    common[6],
    "str_n25_christmas_4",
    "N25_sdjl_tittle",
    {-584, -69}
  }
}
return config, "ID", key
