local key = {
  ID = 1,
  BuffLock = 2,
  BuffAwakening = 3,
  PracticeLevelId = 4,
  StoryId = 5,
  PetIcon = 6,
  PetRawImg1 = 7,
  PetRawImg2 = 8,
  PetRawImg3 = 9,
  TurnIcon = 10,
  Sort = 11,
  HasPetNum = 12
}
local common = {
  "legend_sixiang_ren4",
  "legend_zhu_ren1"
}
local config = {
  [1701071] = {
    1701071,
    30,
    10,
    1,
    4014,
    common[1],
    "legend_di12",
    "legend_di11",
    "legend_di10",
    common[2],
    1
  },
  [1701081] = {
    1701081,
    30,
    10,
    6,
    4000,
    "legend_sixiang_ren1",
    "legend_di06",
    "legend_di05",
    "legend_di04",
    "legend_zhu_ren2",
    2
  },
  [1701091] = {
    1701091,
    30,
    10,
    11,
    4008,
    "legend_sixiang_ren2",
    "legend_di09",
    "legend_di08",
    "legend_di07",
    "legend_zhu_ren3",
    3
  },
  [1701101] = {
    1701101,
    30,
    10,
    16,
    4019,
    "legend_sixiang_ren3",
    "legend_di03",
    "legend_di02",
    "legend_di01",
    "legend_zhu_ren4",
    4
  },
  [1702361] = {
    1702361,
    0,
    0,
    22,
    4014,
    common[1],
    "legend_di16",
    "legend_di15",
    "legend_di14",
    common[2],
    5,
    4
  }
}
return config, "ID", key
