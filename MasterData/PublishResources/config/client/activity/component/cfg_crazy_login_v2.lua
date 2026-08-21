local key = {
  Bg = 1,
  Spine = 2,
  BgBottom = 3,
  LockImage = 4,
  Time = 5,
  StateLock = 6,
  StateCanRecv = 7,
  StateRecved = 8,
  SelectedBg = 9,
  AwardParticecleF = 10,
  AwardParticecleB = 11,
  SpecialBg = 12,
  LastFixed = 13
}
local config = {
  [1123] = {
    "gh_jqqd_di01",
    {
      name = "1600291_spine_idle",
      pos = {-412, 25},
      scale = {
        0.45,
        0.45,
        1
      }
    },
    "gh_jqqd_di12",
    "gh_jqqd_icon02",
    {
      bg = "gh_jqqd_di11",
      text = "#E03F00"
    },
    {
      bg = "gh_jqqd_di08",
      day = "#F9A30F",
      desc = "#FFFFFF"
    },
    {
      bg = "gh_jqqd_di07",
      day = "#FFFFFF",
      desc = "#FF8A00"
    },
    {
      bg = "gh_jqqd_di06",
      day = "#DFDFDF",
      desc = "#FFFFFF"
    },
    "gh_jqqd_di09",
    "eff_activity_signin_blue_front.prefab",
    "eff_activity_signin_blue_back.prefab",
    "gh_jqqd_di05",
    true
  }
}
return config, "CampaignID", key
