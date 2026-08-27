local activity_refresh_dungeon_dun = {
  [530101] = {},
  [530102] = {dungeon = 530102, hero_id = 1003},
  [530103] = {dungeon = 530103, hero_id = 1005},
  [530104] = {dungeon = 530104, hero_id = 1002},
  [530105] = {dungeon = 530105, hero_id = 1044},
  [530106] = {dungeon = 530106, hero_id = 1004},
  [530107] = {dungeon = 530107, hero_id = 1037},
  [530108] = {dungeon = 530108, hero_id = 1042},
  [530109] = {dungeon = 530109, hero_id = 1045},
  [530110] = {dungeon = 530110, hero_id = 1022},
  [530111] = {dungeon = 530111, hero_id = 1043},
  [530112] = {dungeon = 530112, hero_id = 1041},
  [530113] = {dungeon = 530113, hero_id = 1039},
  [530114] = {dungeon = 530114, hero_id = 1018},
  [530115] = {dungeon = 530115, hero_id = 1008},
  [530116] = {dungeon = 530116, hero_id = 1048},
  [530117] = {dungeon = 530117, hero_id = 1046},
  [530201] = {
    difficulty = 2,
    dungeon = 530201,
    overkill = 2
  },
  [530202] = {
    difficulty = 2,
    dungeon = 530202,
    hero_id = 1003,
    overkill = 2
  },
  [530203] = {
    difficulty = 2,
    dungeon = 530203,
    hero_id = 1005,
    overkill = 2
  },
  [530204] = {
    difficulty = 2,
    dungeon = 530204,
    hero_id = 1002,
    overkill = 2
  },
  [530205] = {
    difficulty = 2,
    dungeon = 530205,
    hero_id = 1044,
    overkill = 2
  },
  [530206] = {
    difficulty = 2,
    dungeon = 530206,
    hero_id = 1004,
    overkill = 2
  },
  [530207] = {
    difficulty = 2,
    dungeon = 530207,
    hero_id = 1037,
    overkill = 2
  },
  [530208] = {
    difficulty = 2,
    dungeon = 530208,
    hero_id = 1042,
    overkill = 2
  },
  [530209] = {
    difficulty = 2,
    dungeon = 530209,
    hero_id = 1045,
    overkill = 2
  },
  [530210] = {
    difficulty = 2,
    dungeon = 530210,
    hero_id = 1022,
    overkill = 2
  },
  [530211] = {
    difficulty = 2,
    dungeon = 530211,
    hero_id = 1043,
    overkill = 2
  },
  [530212] = {
    difficulty = 2,
    dungeon = 530212,
    hero_id = 1041,
    overkill = 2
  },
  [530213] = {
    difficulty = 2,
    dungeon = 530213,
    hero_id = 1039,
    overkill = 2
  },
  [530214] = {
    difficulty = 2,
    dungeon = 530214,
    hero_id = 1018,
    overkill = 2
  },
  [530215] = {
    difficulty = 2,
    dungeon = 530215,
    hero_id = 1008,
    overkill = 2
  },
  [530216] = {
    difficulty = 2,
    dungeon = 530216,
    hero_id = 1048,
    overkill = 2
  },
  [530217] = {
    difficulty = 2,
    dungeon = 530217,
    hero_id = 1046,
    overkill = 2
  },
  [530301] = {
    difficulty = 3,
    dungeon = 530301,
    overkill = 3
  },
  [530302] = {
    difficulty = 3,
    dungeon = 530302,
    hero_id = 1003,
    overkill = 3
  },
  [530303] = {
    difficulty = 3,
    dungeon = 530303,
    hero_id = 1005,
    overkill = 3
  },
  [530304] = {
    difficulty = 3,
    dungeon = 530304,
    hero_id = 1002,
    overkill = 3
  },
  [530305] = {
    difficulty = 3,
    dungeon = 530305,
    hero_id = 1044,
    overkill = 3
  },
  [530306] = {
    difficulty = 3,
    dungeon = 530306,
    hero_id = 1004,
    overkill = 3
  },
  [530307] = {
    difficulty = 3,
    dungeon = 530307,
    hero_id = 1037,
    overkill = 3
  },
  [530308] = {
    difficulty = 3,
    dungeon = 530308,
    hero_id = 1042,
    overkill = 3
  },
  [530309] = {
    difficulty = 3,
    dungeon = 530309,
    hero_id = 1045,
    overkill = 3
  },
  [530310] = {
    difficulty = 3,
    dungeon = 530310,
    hero_id = 1022,
    overkill = 3
  },
  [530311] = {
    difficulty = 3,
    dungeon = 530311,
    hero_id = 1043,
    overkill = 3
  },
  [530312] = {
    difficulty = 3,
    dungeon = 530312,
    hero_id = 1041,
    overkill = 3
  },
  [530313] = {
    difficulty = 3,
    dungeon = 530313,
    hero_id = 1039,
    overkill = 3
  },
  [530314] = {
    difficulty = 3,
    dungeon = 530314,
    hero_id = 1018,
    overkill = 3
  },
  [530315] = {
    difficulty = 3,
    dungeon = 530315,
    hero_id = 1008,
    overkill = 3
  },
  [530316] = {
    difficulty = 3,
    dungeon = 530316,
    hero_id = 1048,
    overkill = 3
  },
  [530317] = {
    difficulty = 3,
    dungeon = 530317,
    hero_id = 1046,
    overkill = 3
  }
}
local __default_values = {
  activity_id = 1,
  difficulty = 1,
  dungeon = 530101,
  hero_id = 1001,
  overkill = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_refresh_dungeon_dun) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_refresh_dungeon_dun, {__index = __rawdata})
return activity_refresh_dungeon_dun
