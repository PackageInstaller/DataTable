local brotato_role_amend = {
  [1001] = {},
  [1002] = {
    attack_range_factor = 220,
    attack_speed_factor = 250,
    id = 1002,
    skill_range_factor = 300
  },
  [1003] = {id = 1003},
  [1004] = {id = 1004},
  [1005] = {id = 1005},
  [1006] = {id = 1006, skill_range_factor = 300},
  [1007] = {id = 1007},
  [1008] = {id = 1008},
  [1009] = {id = 1009},
  [1010] = {id = 1010},
  [1011] = {id = 1011},
  [1014] = {id = 1014},
  [1015] = {id = 1015},
  [1016] = {id = 1016},
  [1017] = {id = 1017},
  [1018] = {id = 1018},
  [1019] = {id = 1019},
  [1021] = {id = 1021},
  [1022] = {id = 1022},
  [1024] = {id = 1024},
  [1025] = {
    attack_speed_factor = 90,
    id = 1025,
    skill_range_factor = 400
  },
  [1026] = {id = 1026},
  [1028] = {
    attack_speed_factor = 200,
    id = 1028,
    skill_range_factor = 300
  },
  [1029] = {id = 1029},
  [1030] = {id = 1030},
  [1032] = {id = 1032},
  [1033] = {id = 1033},
  [1035] = {id = 1035},
  [1036] = {id = 1036},
  [1037] = {id = 1037},
  [1040] = {id = 1040},
  [1041] = {id = 1041},
  [1042] = {id = 1042},
  [1043] = {id = 1043},
  [1044] = {id = 1044},
  [1045] = {id = 1045},
  [1046] = {id = 1046},
  [1047] = {id = 1047},
  [1048] = {id = 1048},
  [1049] = {id = 1049},
  [1050] = {
    attack_speed_factor = 250,
    id = 1050,
    skill_range_factor = 300
  },
  [1051] = {id = 1051},
  [1052] = {id = 1052},
  [1053] = {attack_range_factor = 100, id = 1053},
  [1054] = {id = 1054},
  [1055] = {id = 1055},
  [1056] = {id = 1056},
  [1057] = {
    attack_speed_factor = 200,
    id = 1057,
    skill_range_factor = 300
  },
  [1058] = {
    attack_range_factor = 150,
    attack_speed_factor = 200,
    id = 1058,
    skill_range_factor = 300
  },
  [1059] = {id = 1059},
  [1060] = {id = 1060},
  [1061] = {
    attack_speed_factor = 200,
    id = 1061,
    move_speed_factor = 600,
    skill_range_factor = 300
  },
  [1062] = {id = 1062, move_speed_factor = 450},
  [1063] = {id = 1063},
  [1064] = {id = 1064},
  [1065] = {id = 1065},
  [1066] = {
    attack_range_factor = 240,
    id = 1066,
    skill_range_factor = 340
  },
  [1067] = {id = 1067},
  [1068] = {
    attack_range_factor = 220,
    attack_speed_factor = 200,
    id = 1068,
    skill_range_factor = 300
  },
  [1069] = {id = 1069},
  [1071] = {id = 1071},
  [1072] = {
    attack_range_factor = 300,
    id = 1072,
    move_speed_factor = 600,
    skill_range_factor = 300
  },
  [1073] = {id = 1073},
  [1074] = {id = 1074},
  [1075] = {id = 1075},
  [1076] = {id = 1076},
  [1077] = {id = 1077},
  [1078] = {
    attack_range_factor = 240,
    id = 1078,
    move_speed_factor = 400,
    skill_range_factor = 300
  },
  [1079] = {id = 1079},
  [1080] = {
    attack_range_factor = 240,
    id = 1080,
    move_speed_factor = 400,
    skill_range_factor = 300
  },
  [1081] = {id = 1081},
  [1082] = {id = 1082},
  [1083] = {id = 1083, move_speed_factor = 450},
  [1972] = {
    attack_range_factor = 300,
    id = 1972,
    move_speed_factor = 450,
    skill_range_factor = 300
  }
}
local __default_values = {
  attack_range_factor = 200,
  attack_speed_factor = 100,
  id = 1001,
  move_speed_factor = 800,
  skill_range_factor = 100
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(brotato_role_amend) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(brotato_role_amend, {__index = __rawdata})
return brotato_role_amend
