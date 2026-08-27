local audio_voice_point = {
  [0] = {
    vo_afk = {8},
    vo_battle = {106},
    vo_dormgreet = {
      140,
      141,
      142,
      143,
      144,
      145,
      146
    },
    vo_duty = {110},
    vo_formation = {105},
    vo_main = {5, 6},
    vo_mvp = {108, 109},
    vo_title = {118},
    vo_ultSkill = {107}
  },
  [1059] = {
    id = 1059,
    vo_interact = {
      1059010,
      1059011,
      1059012
    },
    vo_levelup = {1059102},
    vo_rankup = {1059103}
  }
}
local __default_values = {
  id = 0,
  vo_afk = {1059008},
  vo_battle = {1059106},
  vo_dormgreet = {
    1059140,
    1059141,
    1059142,
    1059143,
    1059144,
    1059145,
    1059146
  },
  vo_duty = {1059110},
  vo_formation = {1059105},
  vo_interact = {
    10,
    11,
    12
  },
  vo_levelup = {102},
  vo_main = {1059005, 1059006},
  vo_mvp = {1059108, 1059109},
  vo_rankup = {103},
  vo_title = {1059118},
  vo_ultSkill = {1059107}
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(audio_voice_point) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(audio_voice_point, {__index = __rawdata})
return audio_voice_point
