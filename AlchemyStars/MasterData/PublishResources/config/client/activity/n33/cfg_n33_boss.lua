local key = {
  ID = 1,
  BossName = 2,
  Spine = 3,
  IdleAnim = 4,
  UnLockAnim = 5,
  DisappearAnim = 6,
  UnLockAnimLength = 7,
  DisappearAnimLength = 8
}
local common = {
  "str_n33_activity_boss_name",
  "n33_g_boss_spine_idle",
  "idle",
  "born",
  "dead"
}
local config = {
  [5331015] = {
    5331015,
    common[1],
    common[2],
    common[3],
    common[4],
    common[5],
    6500,
    3000
  },
  [5332006] = {
    5332006,
    common[1],
    common[2],
    common[3],
    common[4],
    common[5],
    6500,
    3000
  },
  [5332012] = {
    5332012,
    common[1],
    common[2],
    common[3],
    common[4],
    common[5],
    6500,
    3000
  }
}
return config, "ID", key
