local hero_talent = {
  [1001] = {mould_id = 6},
  [1002] = {hero_id = 1002, talent_id = 1002},
  [1003] = {
    hero_id = 1003,
    mould_id = 9,
    talent_id = 1003
  },
  [1004] = {
    hero_id = 1004,
    mould_id = 8,
    talent_id = 1004
  },
  [1005] = {
    hero_id = 1005,
    mould_id = 4,
    talent_id = 1005
  },
  [1006] = {
    hero_id = 1006,
    mould_id = 8,
    talent_id = 1006
  },
  [1007] = {
    hero_id = 1007,
    mould_id = 9,
    talent_id = 1007
  },
  [1008] = {
    hero_id = 1008,
    mould_id = 6,
    talent_id = 1008
  },
  [1009] = {hero_id = 1009, talent_id = 1009},
  [1010] = {
    hero_id = 1010,
    mould_id = 4,
    talent_id = 1010
  },
  [1011] = {
    hero_id = 1011,
    mould_id = 4,
    talent_id = 1011
  },
  [1012] = {
    hero_id = 1012,
    mould_id = 8,
    talent_id = 1012
  },
  [1013] = {
    hero_id = 1013,
    mould_id = 9,
    talent_id = 1013
  },
  [1014] = {
    hero_id = 1014,
    mould_id = 6,
    talent_id = 1014
  },
  [1015] = {
    hero_id = 1015,
    mould_id = 6,
    talent_id = 1015
  },
  [1016] = {hero_id = 1016, talent_id = 1016},
  [1017] = {hero_id = 1017, talent_id = 1017},
  [1018] = {
    hero_id = 1018,
    mould_id = 6,
    talent_id = 1018
  },
  [1019] = {
    hero_id = 1019,
    mould_id = 9,
    talent_id = 1019
  },
  [1020] = {
    hero_id = 1020,
    mould_id = 4,
    talent_id = 1020
  },
  [1021] = {hero_id = 1021, talent_id = 1021},
  [1022] = {
    hero_id = 1022,
    mould_id = 9,
    talent_id = 1022
  },
  [1023] = {
    hero_id = 1023,
    mould_id = 4,
    talent_id = 1023
  },
  [1024] = {
    hero_id = 1024,
    mould_id = 8,
    talent_id = 1024
  },
  [1025] = {
    hero_id = 1025,
    mould_id = 8,
    talent_id = 1025
  },
  [1026] = {
    hero_id = 1026,
    mould_id = 6,
    talent_id = 1026
  },
  [1027] = {
    hero_id = 1027,
    mould_id = 4,
    talent_id = 1027
  },
  [1028] = {
    hero_id = 1028,
    mould_id = 9,
    talent_id = 1028
  },
  [1029] = {hero_id = 1029, talent_id = 1029},
  [1030] = {hero_id = 1030, talent_id = 1030},
  [1031] = {
    hero_id = 1031,
    mould_id = 6,
    talent_id = 1031
  },
  [1032] = {
    hero_id = 1032,
    mould_id = 8,
    talent_id = 1032
  },
  [1033] = {hero_id = 1033, talent_id = 1033},
  [1034] = {hero_id = 1034, talent_id = 1034},
  [1035] = {
    hero_id = 1035,
    mould_id = 6,
    talent_id = 1035
  },
  [1036] = {
    hero_id = 1036,
    mould_id = 8,
    talent_id = 1036
  },
  [1037] = {
    hero_id = 1037,
    mould_id = 8,
    talent_id = 1037
  },
  [1038] = {hero_id = 1038, talent_id = 1038},
  [1039] = {
    hero_id = 1039,
    mould_id = 9,
    talent_id = 1039
  },
  [1040] = {hero_id = 1040, talent_id = 1040},
  [1041] = {
    hero_id = 1041,
    mould_id = 6,
    talent_id = 1041
  },
  [1042] = {
    hero_id = 1042,
    mould_id = 9,
    talent_id = 1042
  },
  [1043] = {
    hero_id = 1043,
    mould_id = 4,
    talent_id = 1043
  },
  [1044] = {
    hero_id = 1044,
    mould_id = 8,
    talent_id = 1044
  },
  [1045] = {hero_id = 1045, talent_id = 1045},
  [1046] = {
    hero_id = 1046,
    mould_id = 8,
    talent_id = 1046
  },
  [1047] = {
    hero_id = 1047,
    mould_id = 8,
    talent_id = 1047
  }
}
local __default_values = {
  hero_id = 1001,
  mould_id = 7,
  talent_id = 1001
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(hero_talent) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  maxAlgSpaceDic = {}
}
setmetatable(hero_talent, {__index = __rawdata})
return hero_talent
