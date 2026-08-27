local __rt_1 = {}
local __rt_2 = {
  [2] = 1256
}
local warchess_grid_res = {
  [1001] = {id = 1001},
  [1002] = {icon = 3, id = 1002},
  [1003] = {id = 1003},
  [1004] = {icon = 5, id = 1004},
  [1005] = {id = 1005},
  [1006] = {icon = 1, id = 1006},
  [1007] = {id = 1007},
  [1008] = {icon = 1, id = 1008},
  [1009] = {icon = 4, id = 1009},
  [1010] = {icon = 4, id = 1010},
  [1011] = {icon = 4, id = 1011},
  [1012] = {icon = 4, id = 1012},
  [1013] = {icon = 4, id = 1013},
  [1014] = {icon = 4, id = 1014},
  [1015] = {icon = 4, id = 1015},
  [1016] = {icon = 4, id = 1016},
  [1017] = {icon = 4, id = 1017},
  [1018] = {id = 1018},
  [1019] = {id = 1019},
  [1020] = {id = 1020},
  [1021] = {icon = 4, id = 1021},
  [1022] = {id = 1022},
  [1023] = {id = 1023},
  [10000] = {},
  [10001] = {id = 10001},
  [10002] = {id = 10002},
  [10003] = {aniAudioDic = __rt_2, id = 10003},
  [10004] = {icon = 4, id = 10004},
  [10005] = {id = 10005},
  [10006] = {icon = 5, id = 10006},
  [10007] = {
    icon = 4,
    id = 10007,
    successAudio = 1229
  },
  [10008] = {
    icon = 4,
    id = 10008,
    successAudio = 1230
  },
  [10009] = {
    icon = 4,
    id = 10009,
    successAudio = 1229
  },
  [10010] = {
    icon = 4,
    id = 10010,
    successAudio = 1230
  },
  [10011] = {
    icon = 4,
    id = 10011,
    successAudio = 1229
  },
  [10012] = {
    icon = 4,
    id = 10012,
    successAudio = 1230
  },
  [10013] = {
    icon = 4,
    id = 10013,
    successAudio = 1229
  },
  [10014] = {
    icon = 4,
    id = 10014,
    successAudio = 1230
  },
  [10015] = {icon = 4, id = 10015},
  [10016] = {icon = 4, id = 10016},
  [10017] = {icon = 4, id = 10017},
  [10018] = {id = 10018},
  [10019] = {id = 10019},
  [10020] = {id = 10020},
  [10021] = {id = 10021},
  [10022] = {id = 10022},
  [10023] = {id = 10023},
  [10024] = {id = 10024},
  [10025] = {id = 10025},
  [10026] = {id = 10026},
  [10027] = {id = 10027},
  [10028] = {id = 10028},
  [10029] = {id = 10029},
  [10030] = {id = 10030},
  [10031] = {id = 10031},
  [10032] = {id = 10032},
  [10033] = {id = 10033},
  [10034] = {id = 10034},
  [10035] = {id = 10035},
  [10036] = {icon = 4, id = 10036},
  [10037] = {icon = 4, id = 10037},
  [10038] = {
    icon = 4,
    id = 10038,
    successAudio = 1258
  },
  [10039] = {
    icon = 4,
    id = 10039,
    successAudio = 1259
  },
  [10040] = {id = 10040},
  [10041] = {id = 10041},
  [10042] = {id = 10042},
  [10043] = {icon = 3, id = 10043},
  [10044] = {id = 10044},
  [10045] = {id = 10045},
  [10046] = {
    icon = 6,
    id = 10046,
    successAudio = 1261
  },
  [10047] = {
    icon = 6,
    id = 10047,
    successAudio = 1261
  },
  [10048] = {id = 10048, successAudio = 1257},
  [10049] = {aniAudioDic = __rt_2, id = 10049},
  [10050] = {id = 10050},
  [10051] = {id = 10051},
  [10052] = {id = 10052},
  [10053] = {id = 10053}
}
local __default_values = {
  aniAudioDic = __rt_1,
  default_anima = "1",
  height = 0,
  icon = 0,
  id = 10000,
  successAudio = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_grid_res) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warchess_grid_res, {__index = __rawdata})
return warchess_grid_res
