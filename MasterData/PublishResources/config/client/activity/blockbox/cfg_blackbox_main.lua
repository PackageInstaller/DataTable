local key = {
  ID = 1,
  ComponentID = 2,
  BG = 3,
  Title = 4,
  Intro = 5,
  IntroPage = 6,
  CommonNormal = 7,
  CommonSelect = 8,
  CommonLock = 9,
  BossNormal = 10,
  BossSelect = 11
}
local common = {
  "bb_hxzt_di08",
  "bb_hxzt_logo01",
  "UIActivityBlackBoxIntro",
  "bb_hxzt_di03",
  "bb_hxzt_di04",
  "bb_hxzt_di05",
  "bb_hxzt_di14",
  "bb_hxzt_di15",
  "str_cn7_n36_blackbox_intro"
}
local config = {
  {
    1,
    110602801,
    common[1],
    common[2],
    "str_n31_blackbox_intro",
    common[3],
    common[4],
    common[5],
    common[6],
    common[7],
    common[8]
  },
  {
    2,
    502902801,
    common[1],
    common[2],
    common[9],
    common[3],
    common[4],
    common[5],
    common[6],
    common[7],
    common[8]
  },
  {
    3,
    507002801,
    common[1],
    common[2],
    common[9],
    common[3],
    common[4],
    common[5],
    common[6],
    common[7],
    common[8]
  },
  {
    4,
    600102801,
    common[1],
    common[2],
    common[9],
    common[3],
    common[4],
    common[5],
    common[6],
    common[7],
    common[8]
  },
  {
    5,
    509202801,
    common[1],
    common[2],
    common[9],
    common[3],
    common[4],
    common[5],
    common[6],
    common[7],
    common[8]
  }
}
return config, "ID", key
