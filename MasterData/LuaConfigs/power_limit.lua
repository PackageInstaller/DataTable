local __rt_1 = {0, 60}
local __rt_2 = {0, 5}
local __rt_3 = {0, 10}
local __rt_4 = {}
local __rt_5 = {0, 6}
local __rt_6 = {0, 0}
local __rt_7 = {0, 1}
local __rt_8 = {0, 7}
local __rt_9 = {0, 8}
local __rt_10 = {0, 70}
local power_limit = {
  {},
  {id = 2},
  [1106] = {
    id = 1106,
    level_range = __rt_5,
    potential_range = __rt_6,
    rank_range = __rt_5,
    skill_level_range = __rt_7
  },
  [1109] = {
    id = 1109,
    level_range = __rt_8,
    potential_range = __rt_6,
    rank_range = __rt_5,
    skill_level_range = __rt_7
  },
  [1111] = {
    id = 1111,
    level_range = __rt_9,
    potential_range = __rt_6,
    rank_range = __rt_5,
    skill_level_range = __rt_7
  },
  [1112] = {
    id = 1112,
    level_range = __rt_9,
    potential_range = __rt_6,
    rank_range = __rt_5,
    skill_level_range = __rt_7
  },
  [2102] = {
    id = 2102,
    level_range = __rt_3,
    potential_range = __rt_6,
    rank_range = __rt_5,
    skill_level_range = __rt_7
  },
  [2104] = {
    id = 2104,
    level_range = {0, 11},
    potential_range = __rt_7,
    rank_range = __rt_5,
    skill_level_range = __rt_7
  },
  [2106] = {
    id = 2106,
    level_range = {0, 12},
    potential_range = __rt_7,
    rank_range = __rt_5,
    skill_level_range = __rt_7
  },
  [2109] = {
    id = 2109,
    level_range = {0, 13},
    potential_range = __rt_7,
    rank_range = __rt_5,
    skill_level_range = __rt_7
  },
  [2111] = {
    id = 2111,
    level_range = {0, 16},
    potential_range = __rt_7,
    rank_range = __rt_5,
    skill_level_range = __rt_7
  },
  [2115] = {
    id = 2115,
    level_range = {0, 19},
    potential_range = __rt_7,
    rank_range = __rt_5,
    skill_level_range = __rt_7
  },
  [2116] = {
    id = 2116,
    level_range = {0, 50},
    potential_range = {0, 4},
    rank_range = __rt_9,
    skill_level_range = __rt_8
  },
  [2117] = {id = 2117, skill_level_range = __rt_8},
  [2118] = {id = 2118},
  [2119] = {
    id = 2119,
    level_range = __rt_10,
    potential_range = __rt_5
  },
  [110011101] = {id = 110011101},
  [110011104] = {id = 110011104},
  [110011105] = {id = 110011105},
  [110011107] = {id = 110011107},
  [110011108] = {id = 110011108},
  [110011109] = {id = 110011109},
  [110011110] = {id = 110011110},
  [110011111] = {id = 110011111},
  [110011112] = {id = 110011112},
  [110011115] = {id = 110011115},
  [110011116] = {id = 110011116},
  [110011117] = {
    id = 110011117,
    level_range = __rt_10,
    potential_range = __rt_5
  },
  [110012101] = {id = 110012101},
  [110012104] = {id = 110012104},
  [110012105] = {id = 110012105},
  [110012107] = {id = 110012107},
  [110012108] = {id = 110012108},
  [110012109] = {id = 110012109},
  [110012110] = {id = 110012110},
  [110012111] = {id = 110012111},
  [110012112] = {id = 110012112},
  [110012115] = {id = 110012115},
  [110012116] = {id = 110012116},
  [110012117] = {
    id = 110012117,
    level_range = __rt_10,
    potential_range = __rt_5
  }
}
local __default_values = {
  id = 1,
  level_range = __rt_1,
  potential_range = __rt_2,
  rank_range = __rt_3,
  shield_module_dic = __rt_4,
  skill_level_range = __rt_3
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(power_limit) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(power_limit, {__index = __rawdata})
return power_limit
