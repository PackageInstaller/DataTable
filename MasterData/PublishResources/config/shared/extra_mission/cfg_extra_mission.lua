local key = {
  ExtMissionID = 1,
  ExtMissionName = 2,
  ExtMissionNameEn = 3,
  ExtMissionDes = 4,
  ExtTaskList = 5,
  DependMissionID = 6,
  DependTaskID = 7,
  DependLevel = 8,
  AwardStar = 9,
  AwardListItemID = 10,
  AwardListItemCount = 11,
  ExtMissionIdx = 12,
  ExtMissionIdxEn = 13,
  StageTextureListColor = 14,
  StageTextureListCucoloris = 15,
  UnlockTime = 16,
  ExtMissionLoadingImg = 17,
  ExtMissionBigImg = 18,
  ExtMissionBigImgBlur = 19,
  ExtMissionSmallImg = 20,
  ImgThemeLow = 21,
  ExtHeaderGrayImg = 22,
  ExtHeaderImg = 23
}
local common = {
  {
    6,
    12,
    18
  },
  {
    "/loading/nufengshangu"
  },
  {
    {3000003},
    {3000003},
    {3000100}
  },
  {
    {50},
    {100},
    {1}
  }
}
local config = {
  [4501001] = {
    4501001,
    "str_extra_mission_name_0001",
    "str_extra_mission_name_en_0001",
    "str_extra_mission_dec_0001",
    {
      4500001,
      4500002,
      4500003,
      4500004,
      4500005,
      4500006
    },
    4003120,
    0,
    1,
    common[1],
    common[3],
    common[4],
    "str_extra_mission_chapter_idx_1",
    "str_extra_mission_chapter_en_idx_1",
    {
      "emap_chapter1_pass1_cai",
      "emap_chapter1_pass2_cai",
      "emap_chapter1_pass3_cai",
      "emap_chapter1_pass4_cai",
      "emap_chapter1_pass5_cai",
      "emap_chapter1_pass6_cai"
    },
    {
      "emap_chapter1_pass1_hui",
      "emap_chapter1_pass2_hui",
      "emap_chapter1_pass3_hui",
      "emap_chapter1_pass4_hui",
      "emap_chapter1_pass5_hui",
      "emap_chapter1_pass6_hui"
    },
    nil,
    common[2],
    "emap_chapter1_beijing",
    "emap_chapter1_beijing_blur",
    "emap_chapter1_cg",
    "emap_chapter1_di",
    "emap_chapter1_graycard",
    "emap_chapter1_card"
  },
  [4501002] = {
    4501002,
    "str_extra_mission_name_0002",
    "str_extra_mission_name_en_0002",
    "str_extra_mission_dec_0002",
    {
      4500007,
      4500008,
      4500009,
      4500010,
      4500011,
      4500012
    },
    4006120,
    0,
    1,
    common[1],
    common[3],
    common[4],
    "str_extra_mission_chapter_idx_2",
    "str_extra_mission_chapter_en_idx_2",
    {
      "emap_chapter2_pass1_cai",
      "emap_chapter2_pass2_cai",
      "emap_chapter2_pass3_cai",
      "emap_chapter2_pass4_cai",
      "emap_chapter2_pass5_cai",
      "emap_chapter2_pass6_cai"
    },
    {
      "emap_chapter2_pass1_hui",
      "emap_chapter2_pass2_hui",
      "emap_chapter2_pass3_hui",
      "emap_chapter2_pass4_hui",
      "emap_chapter2_pass5_hui",
      "emap_chapter2_pass6_hui"
    },
    nil,
    common[2],
    "emap_chapter2_beijing",
    "emap_chapter2_beijing_blur",
    "emap_chapter2_cg",
    "emap_chapter2_di",
    "emap_chapter2_graycard",
    "emap_chapter2_card"
  },
  [4501003] = {
    4501003,
    "str_extra_mission_name_0003",
    "str_extra_mission_name_en_0003",
    "str_extra_mission_dec_0003",
    {
      4500013,
      4500014,
      4500015,
      4500016,
      4500017,
      4500018
    },
    4008140,
    0,
    1,
    common[1],
    common[3],
    common[4],
    "str_extra_mission_chapter_idx_3",
    "str_extra_mission_chapter_en_idx_3",
    {
      "emap_chapter3_pass1_cai",
      "emap_chapter3_pass2_cai",
      "emap_chapter3_pass3_cai",
      "emap_chapter3_pass4_cai",
      "emap_chapter3_pass5_cai",
      "emap_chapter3_pass6_cai"
    },
    {
      "emap_chapter3_pass1_hui",
      "emap_chapter3_pass2_hui",
      "emap_chapter3_pass3_hui",
      "emap_chapter3_pass4_hui",
      "emap_chapter3_pass5_hui",
      "emap_chapter3_pass6_hui"
    },
    nil,
    common[2],
    "emap_chapter3_beijing",
    "emap_chapter3_beijing_blur",
    "emap_chapter3_cg",
    "emap_chapter3_di",
    "emap_chapter3_graycard",
    "emap_chapter3_card"
  },
  [4501004] = {
    4501004,
    "str_extra_mission_name_0004",
    "str_extra_mission_name_en_0004",
    "str_extra_mission_dec_0004",
    {
      4500019,
      4500020,
      4500021,
      4500022,
      4500023,
      4500024
    },
    4010140,
    0,
    1,
    common[1],
    common[3],
    common[4],
    "str_extra_mission_chapter_idx_4",
    "str_extra_mission_chapter_en_idx_4",
    {
      "emap_chapter4_pass1_cai",
      "emap_chapter4_pass2_cai",
      "emap_chapter4_pass3_cai",
      "emap_chapter4_pass4_cai",
      "emap_chapter4_pass5_cai",
      "emap_chapter4_pass6_cai"
    },
    {
      "emap_chapter4_pass1_hui",
      "emap_chapter4_pass2_hui",
      "emap_chapter4_pass3_hui",
      "emap_chapter4_pass4_hui",
      "emap_chapter4_pass5_hui",
      "emap_chapter4_pass6_hui"
    },
    "2021-12-14 09:00:00",
    common[2],
    "emap_chapter4_beijing",
    "emap_chapter4_beijing_blur",
    "emap_chapter4_cg",
    "emap_chapter4_di",
    "emap_chapter4_graycard",
    "emap_chapter4_card"
  }
}
return config, "ExtMissionID", key
