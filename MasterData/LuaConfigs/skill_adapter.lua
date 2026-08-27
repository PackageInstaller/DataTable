local skill_adapter = {
  {
    [100101] = {describe = 471836, hero_id = 1001},
    [100401] = {
      describe = 357537,
      hero_id = 1004,
      skill_id = 100401,
      skill_id_new = 1004011
    },
    [100502] = {
      describe = 214655,
      hero_id = 1005,
      skill_id = 100502,
      skill_id_new = 1005021
    },
    [100601] = {
      describe = 501976,
      hero_id = 1006,
      skill_id = 100601,
      skill_id_new = 1006011
    },
    [100702] = {
      describe = 271376,
      hero_id = 1007,
      skill_id = 100702,
      skill_id_new = 1007021
    },
    [100901] = {
      describe = 504012,
      hero_id = 1009,
      skill_id = 100901,
      skill_id_new = 1009011
    },
    [101001] = {
      describe = 471362,
      hero_id = 1010,
      skill_id = 101001,
      skill_id_new = 1010011
    },
    [101003] = {
      describe = 471362,
      hero_id = 1010,
      skill_id = 101003,
      skill_id_new = 1010031
    },
    [101103] = {
      describe = 439984,
      hero_id = 1011,
      skill_id = 101103,
      skill_id_new = 1011031
    },
    [101602] = {
      describe = 519486,
      hero_id = 1016,
      skill_id = 101602,
      skill_id_new = 1016021
    },
    [101703] = {
      describe = 451815,
      hero_id = 1017,
      skill_id = 101703,
      skill_id_new = 1017031
    },
    [101801] = {
      describe = 123269,
      hero_id = 1018,
      lock_type = 1,
      skill_id = 101801,
      skill_id_new = 1018011
    },
    [101901] = {
      hero_id = 1019,
      lock_type = 1,
      skill_id = 101901,
      skill_id_new = 1019011
    },
    [101902] = {
      hero_id = 1019,
      skill_id = 101902,
      skill_id_new = 1019021
    },
    [102002] = {
      describe = 61862,
      hero_id = 1020,
      lock_type = 1,
      skill_id = 102002,
      skill_id_new = 1020021
    },
    [102301] = {
      describe = 336517,
      hero_id = 1023,
      skill_id = 102301,
      skill_id_new = 1023011
    },
    [102903] = {
      describe = 81570,
      hero_id = 1029,
      lock_type = 1,
      skill_id = 102903,
      skill_id_new = 1029031
    },
    [103001] = {
      describe = 21136,
      hero_id = 1030,
      skill_id = 103001,
      skill_id_new = 1030011
    },
    [103303] = {
      describe = 425494,
      hero_id = 1033,
      lock_type = 1,
      skill_id = 103303,
      skill_id_new = 1033031
    },
    [103703] = {
      describe = 28316,
      hero_id = 1037,
      skill_id = 103703,
      skill_id_new = 1037031
    },
    [103902] = {
      describe = 464963,
      hero_id = 1039,
      skill_id = 103902,
      skill_id_new = 1039021
    },
    [104101] = {
      describe = 225656,
      hero_id = 1041,
      skill_id = 104101,
      skill_id_new = 1041011
    },
    [104201] = {
      describe = 26030,
      skill_id = 104201,
      skill_id_new = 1042011
    },
    [104202] = {
      describe = 435965,
      skill_id = 104202,
      skill_id_new = 1042021
    },
    [104203] = {
      describe = 435965,
      skill_id = 104203,
      skill_id_new = 1042031
    }
  }
}
local __default_values = {
  describe = 21348,
  game_type = 1,
  hero_id = 1042,
  lock_type = 2,
  skill_id = 100101,
  skill_id_new = 1001011
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(skill_adapter) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  td_adapter = {
    [1001] = {adapter_desc = 471836},
    [1004] = {adapter_desc = 357537},
    [1005] = {adapter_desc = 214655},
    [1006] = {adapter_desc = 501976},
    [1007] = {adapter_desc = 271376},
    [1009] = {adapter_desc = 504012},
    [1010] = {adapter_desc = 471362},
    [1011] = {adapter_desc = 439984},
    [1016] = {adapter_desc = 519486},
    [1017] = {adapter_desc = 451815},
    [1018] = {adapter_desc = 123269},
    [1019] = {adapter_desc = 21348},
    [1020] = {adapter_desc = 61862},
    [1023] = {adapter_desc = 336517},
    [1029] = {adapter_desc = 81570},
    [1030] = {adapter_desc = 21136},
    [1033] = {adapter_desc = 425494},
    [1037] = {adapter_desc = 28316},
    [1039] = {adapter_desc = 464963},
    [1041] = {adapter_desc = 225656},
    [1042] = {adapter_desc = 26030}
  }
}
setmetatable(skill_adapter, {__index = __rawdata})
return skill_adapter
