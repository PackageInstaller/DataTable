local brotato_role_skill_change = {
  [1001] = {},
  [1002] = {
    id = 1002,
    normal_skill = "AnnaSkillChange",
    ult_skill = "AnnaInvasionChange"
  },
  [1003] = {id = 1003},
  [1004] = {id = 1004},
  [1005] = {id = 1005},
  [1006] = {
    id = 1006,
    ult_skill = "FresnelUltChange"
  },
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
    attack_skill = "TwigsAttackChange",
    id = 1025,
    normal_skill = "TwigsNormalSkillChange"
  },
  [1026] = {id = 1026},
  [1028] = {
    id = 1028,
    ult_skill = "VeeUltChange"
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
  [1050] = {id = 1050},
  [1051] = {id = 1051},
  [1052] = {id = 1052},
  [1053] = {id = 1053},
  [1054] = {id = 1054},
  [1055] = {id = 1055},
  [1056] = {id = 1056},
  [1057] = {id = 1057},
  [1058] = {
    attack_skill = "ClukayAttackChange",
    id = 1058,
    normal_skill = "ClukaySkillChange",
    passive_skill = "ClukayPassiveChange"
  },
  [1059] = {id = 1059},
  [1060] = {id = 1060},
  [1061] = {id = 1061},
  [1062] = {
    attack_skill = "JiangyuAttackChange",
    id = 1062
  },
  [1063] = {id = 1063},
  [1064] = {id = 1064},
  [1065] = {id = 1065},
  [1066] = {id = 1066},
  [1067] = {id = 1067},
  [1068] = {id = 1068},
  [1069] = {id = 1069},
  [1071] = {id = 1071},
  [1072] = {
    id = 1072,
    normal_skill = "XinghuanSkillChange",
    ult_skill = "XinghuanUltChange"
  },
  [1073] = {id = 1073},
  [1074] = {id = 1074},
  [1075] = {id = 1075},
  [1076] = {id = 1076},
  [1077] = {id = 1077},
  [1078] = {
    attack_skill = "KurisuAttackChange",
    id = 1078,
    normal_skill = "KurisuSkillChange",
    passive_skill = "KurisuPassiveChange"
  },
  [1079] = {id = 1079},
  [1080] = {id = 1080},
  [1081] = {id = 1081},
  [1082] = {id = 1082},
  [1083] = {
    attack_skill = "ShaleAttackChange",
    id = 1083,
    normal_skill = "ShaleSkillChange"
  },
  [1972] = {
    id = 1972,
    normal_skill = "XinghuanSkillChange",
    ult_skill = "XinghuanUltChange"
  }
}
local __default_values = {
  attack_skill = "",
  id = 1001,
  normal_skill = "",
  passive_skill = "",
  ult_skill = ""
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(brotato_role_skill_change) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(brotato_role_skill_change, {__index = __rawdata})
return brotato_role_skill_change
