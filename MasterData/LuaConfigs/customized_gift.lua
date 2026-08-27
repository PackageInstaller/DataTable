local __rt_1 = {}
local __rt_2 = {40}
local __rt_3 = {60}
local __rt_4 = {
  1501,
  8205,
  1003,
  5007
}
local __rt_5 = {
  800,
  5,
  10000,
  3
}
local __rt_6 = {
  10,
  15,
  3000,
  12,
  1200,
  55
}
local __rt_7 = {
  5,
  5,
  12,
  25,
  12000,
  150
}
local __rt_8 = {
  8223,
  8205,
  1502,
  1501,
  5007,
  1003
}
local __rt_9 = {
  2,
  8,
  3,
  1500,
  6,
  20000
}
local __rt_10 = {
  1010,
  1041,
  1019,
  1039,
  1031,
  1011,
  1025,
  1021,
  1016,
  1057,
  1018,
  1034,
  1022,
  1046,
  1002,
  1007,
  1008,
  1040,
  1028,
  1014,
  1054,
  1005,
  1006,
  1037,
  1060,
  1009,
  1029,
  1042,
  1044,
  1059,
  1070,
  1051,
  1036,
  1050,
  1048,
  1055,
  1062,
  1072,
  1061
}
local customized_gift = {
  {
    param1 = {120},
    type = 1
  },
  {
    id = 2,
    param1 = {
      1037,
      1025,
      1010,
      1026,
      1039,
      1008,
      1018,
      1016,
      1028,
      1022,
      1041,
      1042,
      1043,
      1044,
      1045,
      1046,
      1048,
      1049,
      1050,
      1051,
      1052,
      1053,
      1054,
      1055,
      1057,
      1059,
      1060,
      1061,
      1062,
      1063,
      1066,
      1067,
      1069,
      1070,
      1072,
      1075,
      1079,
      1080,
      1082,
      1083,
      1085
    },
    type = 2
  },
  {
    id = 3,
    param1 = __rt_2,
    type = 3
  },
  {
    id = 4,
    param1 = __rt_3,
    type = 3
  },
  {
    id = 5,
    param1 = {15},
    param2 = {
      1004,
      1007,
      1009,
      1012,
      1014,
      1020,
      1021,
      1023,
      1027,
      1034,
      1035,
      1036
    },
    type = 4
  },
  {id = 6, param2 = __rt_5},
  {
    id = 7,
    param1 = {
      1020,
      1504,
      1503,
      8231,
      1018,
      1502
    },
    param2 = __rt_6
  },
  {
    id = 8,
    param1 = {
      6003,
      8231,
      8223,
      1502,
      1501,
      6002
    },
    param2 = __rt_7
  },
  {
    id = 9,
    param1 = __rt_8,
    param2 = __rt_9
  },
  {
    id = 10,
    param1 = __rt_2,
    param2 = __rt_10,
    type = 6
  },
  {
    id = 11,
    param1 = __rt_3,
    param2 = __rt_10,
    type = 6
  },
  {id = 12, param2 = __rt_5},
  {
    id = 13,
    param1 = {
      1504,
      3002,
      1502,
      1018,
      6002
    },
    param2 = {
      10,
      12,
      25,
      1000,
      100
    }
  },
  {
    id = 14,
    param1 = {
      1504,
      3002,
      6003,
      1503
    },
    param2 = {
      15,
      10,
      12,
      600
    }
  },
  {
    id = 15,
    param1 = {
      1505,
      1503,
      3002,
      1920,
      6003
    },
    param2 = {
      1,
      1200,
      20,
      2500,
      25
    }
  },
  {
    id = 16,
    param1 = {
      1057,
      1055,
      1018
    },
    type = 2
  },
  {
    id = 17,
    param1 = {
      1079,
      1069,
      1082,
      1063,
      1062
    },
    type = 2
  },
  [101] = {
    id = 101,
    param1 = {20},
    type = 1
  },
  [102] = {
    id = 102,
    param1 = {100},
    type = 1
  },
  [106] = {id = 106, param2 = __rt_5},
  [107] = {
    id = 107,
    param1 = {
      1020,
      1504,
      1503,
      8128,
      1018,
      1502
    },
    param2 = __rt_6
  },
  [108] = {
    id = 108,
    param1 = {
      6003,
      8128,
      8223,
      1502,
      1501,
      6002
    },
    param2 = __rt_7
  },
  [109] = {
    id = 109,
    param1 = __rt_8,
    param2 = __rt_9
  }
}
local __default_values = {
  id = 1,
  param1 = __rt_4,
  param2 = __rt_1,
  type = 5
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(customized_gift) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(customized_gift, {__index = __rawdata})
return customized_gift
