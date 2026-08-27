local activity_refresh_dungeon_hero = {
  [1001] = {
    pic = "AprilFoolPic_Persicaria"
  },
  [1002] = {
    avg_id = 1300105,
    hero_id = 1002,
    pic = "AprilFoolPic_Antonina"
  },
  [1003] = {
    avg_id = 1300103,
    hero_id = 1003,
    pic = "AprilFoolPic_Sol"
  },
  [1004] = {
    avg_id = 1300107,
    hero_id = 1004,
    pic = "AprilFoolPic_Simo"
  },
  [1005] = {
    avg_id = 1300104,
    hero_id = 1005,
    pic = "AprilFoolPic_Croque"
  },
  [1008] = {
    avg_id = 1300116,
    hero_id = 1008,
    pic = "AprilFoolPic_Gin"
  },
  [1018] = {
    avg_id = 1300115,
    hero_id = 1018,
    pic = "AprilFoolPic_Florence"
  },
  [1022] = {
    avg_id = 1300111,
    hero_id = 1022,
    voice_id = 144
  },
  [1037] = {
    avg_id = 1300108,
    hero_id = 1037,
    pic = "AprilFoolPic_Hubble"
  },
  [1039] = {
    avg_id = 1300114,
    hero_id = 1039,
    pic = "AprilFoolPic_Centaureissi",
    voice_id = 144
  },
  [1041] = {
    avg_id = 1300113,
    hero_id = 1041,
    pic = "AprilFoolPic_DeLacey"
  },
  [1042] = {
    avg_id = 1300109,
    hero_id = 1042,
    pic = "AprilFoolPic_Hatsuchiri"
  },
  [1043] = {
    avg_id = 1300112,
    hero_id = 1043,
    pic = "AprilFoolPic_Python",
    voice_id = 144
  },
  [1044] = {
    avg_id = 1300106,
    hero_id = 1044,
    pic = "AprilFoolPic_Kuro",
    voice_id = 144
  },
  [1045] = {
    avg_id = 1300110,
    hero_id = 1045,
    pic = "AprilFoolPic_Sueyoi"
  },
  [1046] = {
    avg_id = 1300118,
    hero_id = 1046,
    pic = "AprilFoolPic_Haze"
  },
  [1048] = {
    avg_id = 1300117,
    hero_id = 1048,
    pic = "AprilFoolPic_Nora",
    voice_id = 144
  }
}
local __default_values = {
  avg_id = 1300102,
  hero_id = 1001,
  pic = "AprilFoolPic_Aki",
  voice_id = 146
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_refresh_dungeon_hero) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_refresh_dungeon_hero, {__index = __rawdata})
return activity_refresh_dungeon_hero
