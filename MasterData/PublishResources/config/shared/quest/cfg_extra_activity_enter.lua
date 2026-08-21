local key = {
  ID = 1,
  StartTime = 2,
  EndTime = 3,
  MainSideIcon = 4,
  MainSideStr = 5,
  InfoCg = 6,
  InfoTitle = 7,
  InfoContent = 8
}
local common = {
  "n16_jzkfqd_zjm_ent",
  "str_between_chapters_title_construed",
  "str_between_chapters_title_illustrate"
}
local config = {
  [1058] = {
    1058,
    "2022-05-23 09:00:00",
    "2022-06-02 04:00:00",
    common[1],
    common[2],
    nil,
    common[3],
    common[2]
  },
  [1074] = {
    1074,
    "2022-11-17 05:00:00",
    "2022-12-15 04:00:00",
    common[1],
    common[2],
    nil,
    common[3],
    common[2]
  },
  [1092] = {
    1092,
    "2023-05-11 05:00:00",
    "2023-06-08 04:00:00",
    common[1],
    common[2],
    nil,
    common[3],
    common[2]
  }
}
return config, "ID", key
